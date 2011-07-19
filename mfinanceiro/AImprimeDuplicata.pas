unit AImprimeDuplicata;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnImpressao,
  ComCtrls, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Mask, numericos, UnContasApagar, Localizacao, UnClassesImprimir, FMTBcd,
  SqlExpr, DBClient, Clipbrd;

type
  TFImprimeDuplicata = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BVizualizar: TBitBtn;
    PanelFiltro: TPanelColor;
    GradeParcelas: TGridIndice;
    DataMovParcelas: TDataSource;
    MovParcelas: TSQL;
    Label8: TLabel;
    DataParcela1: TCalendario;
    Label10: TLabel;
    dataParcela2: TCalendario;
    PTempo: TPainelTempo;
    CAD_DOC: TSQL;
    CAD_DOCI_NRO_DOC: TFMTBCDField;
    CAD_DOCI_SEQ_IMP: TFMTBCDField;
    CAD_DOCC_NOM_DOC: TWideStringField;
    CAD_DOCC_TIP_DOC: TWideStringField;
    DATACAD_DOC: TDataSource;
    Label11: TLabel;
    CModelo: TDBLookupComboBoxColor;
    DBMemoColor1: TDBMemoColor;
    PanelColor4: TPanelColor;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    DBText3: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    BImprimir: TBitBtn;
    AUX: TSQLQuery;
    MovParcelasI_LAN_REC: TFMTBCDField;
    MovParcelasI_NRO_PAR: TFMTBCDField;
    MovParcelasD_DAT_VEN: TSQLTimeStampField;
    MovParcelasN_VLR_PAR: TFMTBCDField;
    MovParcelasD_DAT_PAG: TSQLTimeStampField;
    MovParcelasN_VLR_PAG: TFMTBCDField;
    MovParcelasC_NRO_CON: TWideStringField;
    MovParcelasC_NRO_DOC: TWideStringField;
    MovParcelasL_OBS_REC: TWideStringField;
    MovParcelasI_COD_FRM: TFMTBCDField;
    MovParcelasN_VLR_DES: TFMTBCDField;
    MovParcelasN_VLR_ACR: TFMTBCDField;
    MovParcelasI_NRO_NOT: TFMTBCDField;
    MovParcelasN_VLR_TOT: TFMTBCDField;
    MovParcelasD_DAT_EMI: TSQLTimeStampField;
    MovParcelasC_NOM_CLI: TWideStringField;
    MovParcelasC_END_CLI: TWideStringField;
    MovParcelasC_BAI_CLI: TWideStringField;
    MovParcelasC_CID_CLI: TWideStringField;
    MovParcelasC_FO1_CLI: TWideStringField;
    MovParcelasC_CLA_PLA: TWideStringField;
    MovParcelasI_COD_CLI: TFMTBCDField;
    MovParcelasI_COD_FRM_1: TFMTBCDField;
    MovParcelasC_NOM_FRM: TWideStringField;
    CAD_DOCC_NOM_IMP: TWideStringField;
    NFiltro: TNotebook;
    Localiza: TConsultaPadrao;
    LCliente: TLabel;
    SpeedButton4: TSpeedButton;
    ECliente: TEditLocaliza;
    Label18: TLabel;
    SpeedButton3: TSpeedButton;
    ENroNota: TEditLocaliza;
    Label1: TLabel;
    LNroNota: TLabel;
    Label15: TLabel;
    RTipo: TComboBoxColor;
    Label2: TLabel;
    RFiltro: TComboBoxColor;
    MovParcelasC_EST_CLI: TWideStringField;
    MovParcelasC_CGC_CLI: TWideStringField;
    MovParcelasC_INS_CLI: TWideStringField;
    MovParcelasC_NRO_DUP: TWideStringField;
    MovParcelasN_DES_VEN: TFMTBCDField;
    MovParcelasC_PRA_CLI: TWideStringField;
    Label12: TLabel;
    DBText1: TDBText;
    PAcumular: TPanelColor;
    MovParcelasC_CEP_CLI: TWideStringField;
    MovParcelasI_EMP_FIL: TFMTBCDField;
    MovParcelasC_END_COB: TWideStringField;
    MovParcelasC_BAI_COB: TWideStringField;
    MovParcelasC_CEP_COB: TWideStringField;
    MovParcelasI_NUM_COB: TFMTBCDField;
    MovParcelasC_CID_COB: TWideStringField;
    MovParcelasC_EST_COB: TWideStringField;
    MovParcelasI_NUM_END: TFMTBCDField;
    MovParcelasC_COM_END: TWideStringField;
    Button1: TButton;
    ESituacao: TComboBoxColor;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure RPeriodoClick(Sender: TObject);
    procedure MovParcelasAfterScroll(DataSet: TDataSet);
    procedure MovParcelasBeforeInsert(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure CModeloExit(Sender: TObject);
    procedure BVizualizarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure GradeParcelasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeParcelasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RFiltroClick(Sender: TObject);
    procedure ENroNotaSelect(Sender: TObject);
    procedure GradeParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure BBAjudaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
     TamanhoPrimeiroCampo : Integer;
     Dados : TDadosDuplicata;
     UnImpressao : TFuncoesImpressao;
     TeclaPresionada,
     ExecutaAfterScroll: Boolean; // Controla a execução.
     VprTransacao : TTransactionDesc;
     procedure PosicionaContas;
     procedure ImprimeTodos;
     procedure ImprimeFolhaemBranco(VpaVisualizar : Boolean);
     procedure ImprimeSelecionado(Visualizar: Boolean);
     procedure CarregaDados;
  public
    { Public declarations }
  end;

var
  FImprimeDuplicata: TFImprimeDuplicata;

implementation

uses APrincipal, AMostraDuplicata, Funsistema, Constantes, UnCrystal,
  FunSql, FunData, ConstMsg, FunString, FunNumeros, dmRave, UnContasAReceber;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeDuplicata.FormCreate(Sender: TObject);
begin
  // Tabelas.
  AdicionaSQLAbreTabela(CAD_DOC,
    ' SELECT * FROM CAD_DOC DOC, CAD_DRIVER CAD ' +
    ' WHERE CAD.I_SEQ_IMP = DOC.I_SEQ_IMP ' +
    ' AND CAD.I_COD_DRV IS NULL ' +
    ' AND DOC.C_TIP_DOC = ''DUP'' ');
  // Outras Inicializações;
  TeclaPresionada := True;
  RTipo.ItemIndex := 0;
  RFiltro.ItemIndex := 0;
  NFiltro.PageIndex := 0;
  UnImpressao := TFuncoesImpressao.criar(self,FPrincipal.BaseDados);
  ExecutaAfterScroll := True;
  DataParcela1.Date := PrimeiroDiaMes(Date);
  DataParcela2.Date := UltimoDiaMes(Date);
  ESituacao.ItemIndex := 0;
  PosicionaContas;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeDuplicata.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CAD_DOC);
  UnImpressao.Free;
  if VerificaFormCriado('TFMostraDuplicata') then
    FMostraDuplicata.Close;
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);
  Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFImprimeDuplicata.BFecharClick(Sender: TObject);
begin
  self.close;
end;


procedure TFImprimeDuplicata.PosicionaContas;
begin
  LimpaSQLTabela(MovParcelas);
  InseriLinhaSQL(MovParcelas, 0,
    ' SELECT CPM.I_LAN_REC, CPM.I_EMP_FIL, CPM.I_NRO_PAR, CPM.D_DAT_VEN, CPM.N_VLR_PAR, CPM.D_DAT_PAG, ' +
    ' CPM.N_VLR_PAG, CPM.C_NRO_CON, CPM.C_NRO_DOC, CPM.L_OBS_REC, CPM.I_COD_FRM, ' +
    ' CPM.N_DES_VEN, CPM.N_VLR_DES, CPM.N_VLR_ACR, CP.I_NRO_NOT, CPM.C_NRO_DUP, ' +
    ' CP.N_VLR_TOT, CP.D_DAT_EMI, C.C_NOM_CLI, C.C_END_CLI , C.C_BAI_CLI, C.C_CID_CLI, ' +
    '  C.C_END_COB, C.C_BAI_COB, C.C_CEP_COB, C.I_NUM_COB, C.C_CID_COB, C.C_EST_COB, '+
    ' C.I_NUM_END, C.C_COM_END, '+
    ' C.C_FO1_CLI, CP.C_CLA_PLA, C.I_COD_CLI, PAG.I_COD_FRM, PAG.C_NOM_FRM, C.C_EST_CLI, ' +
    ' C.C_CGC_CLI, C.C_INS_CLI, C.C_PRA_CLI, C.C_CEP_CLI ');
  InseriLinhaSQL(MovParcelas, 1,
    ' from MovContasAReceber CPM, CadContasAReceber CP, CadClientes C, CADFORMASPAGAMENTO PAG ' +
    ' where CPM.I_COD_FRM = PAG.I_COD_FRM ' +
    ' AND   CPM.I_EMP_FIL = CP.I_EMP_FIL ' +
    ' AND   CPM.I_LAN_REC = CP.I_LAN_REC ' +
    ' AND   CP.I_COD_CLI  = C.I_COD_CLI ' +
    ' and   CPM.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil));
  case RFiltro.ItemIndex of
    0 : InseriLinhaSQL(MovParcelas, 2, '');
    1 : begin
          if (ECliente.Text <> '') then
            InseriLinhaSQL(MovParcelas, 2, ' AND CP.I_COD_CLI = ' + ECliente.Text)
          else
            InseriLinhaSQL(MovParcelas, 2, '');
        end;
    2 : begin
          if (ENroNota.Text <> '') then
            InseriLinhaSQL(MovParcelas, 2, ' AND CP.I_NRO_NOT = ' + ENroNota.Text)
          else
            InseriLinhaSQL(MovParcelas, 2, '');
        end;
  end;
  case ESituacao.ItemIndex  of
    0 : InseriLinhaSQL(MovParcelas, 3, 'AND CPM.C_DUP_IMP = ''N'' ');
    1 : InseriLinhaSQL(MovParcelas, 3, 'AND CPM.C_DUP_IMP = ''S'' ');
    2 : InseriLinhaSQL(MovParcelas, 3, '');
  end;
  InseriLinhaSQL(MovParcelas, 4, SQLTextoDataEntreAAAAMMDD('CP.D_DAT_EMI', DataParcela1.Date, DataParcela2.Date, True));
  InseriLinhaSQL(MovParcelas, 5,' order by CPM.I_LAN_REC, CPM.I_NRO_PAR');
  AbreTabela(MovParcelas);
end;

procedure TFImprimeDuplicata.RPeriodoClick(Sender: TObject);
begin
  PosicionaContas;
end;

procedure TFImprimeDuplicata.MovParcelasAfterScroll(DataSet: TDataSet);
begin
  if TeclaPresionada then
    if ExecutaAfterScroll then
    begin
       if (RTipo.ItemIndex <> 1) then
       begin
         if VerificaFormCriado('TFMostraDuplicata') then
         begin
           // Carregar os dados do cheque com os do contas a pagar.
           CarregaDados;
           FMostraDuplicata.MostraDocumento(Dados);
           FImprimeDuplicata.SetFocus;
           FImprimeDuplicata.GradeParcelas.SetFocus;
         end;
       end;
    end;
end;

procedure TFImprimeDuplicata.MovParcelasBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TFImprimeDuplicata.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 16);
end;

procedure TFImprimeDuplicata.CModeloExit(Sender: TObject);
begin
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 16);
end;

{**********************************************************************************}
procedure TFImprimeDuplicata.BVizualizarClick(Sender: TObject);
begin
  ExecutaAfterScroll := False;
  ImprimeSelecionado(True);
  ExecutaAfterScroll := True;
end;

procedure TFImprimeDuplicata.BImprimirClick(Sender: TObject);
begin
  ExecutaAfterScroll := False;
  case RTipo.ItemIndex of
    0 : ImprimeSelecionado(false);
    1 : ImprimeTodos;
  end;
  ExecutaAfterScroll := True;
  AtualizaSQLTabela(MovParcelas);
end;

procedure TFImprimeDuplicata.Button1Click(Sender: TObject);
begin
  GradeParcelas.CopiaParaClipBoard(True,false);
end;


procedure TFImprimeDuplicata.GradeParcelasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := False;
end;

procedure TFImprimeDuplicata.GradeParcelasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := True;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  CARREGA OS DADOS DO CHEQUE
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFImprimeDuplicata.CarregaDados;
var
  AUX: string;
begin
  Dados := TDadosDuplicata.Create;
  with Dados do
  begin
    Valor := MovParcelasN_VLR_PAR.AsFloat;
    ValorTotal := MovParcelasN_VLR_TOT.AsFloat;
    NomeSacado := MovParcelasC_NOM_CLI.AsString;
    Cod_Sacado := MovParcelasI_COD_CLI.AsString;
    if MovParcelasC_END_COB.AsString <> '' then
    BEGIN
      CEP := MovParcelasC_CEP_COB.AsString;
      EnderecoSacado := MovParcelasC_END_COB.AsString + ', '+MovParcelasI_NUM_COB.AsString;
      EstadoSacado := MovParcelasC_EST_COB.AsString;
      Bairro := MovParcelasC_BAI_COB.AsString;
      CidadeSacado := MovParcelasC_CID_COB.AsString;
    END
    else
    begin
      CEP := MovParcelasC_CEP_CLI.AsString;
      EnderecoSacado := MovParcelasC_END_CLI.AsString + ', '+MovParcelasI_NUM_END.AsString+' - '+MovParcelasC_COM_END.AsString;
      EstadoSacado := MovParcelasC_EST_CLI.AsString;
      Bairro := MovParcelasC_BAI_CLI.AsString;
      CidadeSacado := MovParcelasC_CID_CLI.AsString;
    end;

    InscricaoCGC  := MovParcelasC_CGC_CLI.AsString;
    InscricaoEstadual := MovParcelasC_INS_CLI.AsString;
    Numero  := MovParcelasI_NRO_NOT.AsString;
    DataEmissao := MovParcelasD_DAT_EMI.AsDateTime;
    DataVencimento := MovParcelasD_DAT_VEN.AsDateTime;
    NroOrdem  := MovParcelasC_NRO_DUP.AsString;
    DescontoDe := MovParcelasN_DES_VEN.AsFloat;
    DataPagtoAte := MovParcelasD_DAT_VEN.AsDateTime;
    PracaPagto := MovParcelasC_PRA_CLI.AsString;
    AUX  := Maiusculas(RetiraAcentuacao(Extenso(MovParcelasN_VLR_PAR.AsFloat, 'reais', 'real')));
    DivideTextoDois(DescValor1, DescValor2, AUX, TamanhoPrimeiroCampo);
    CondEspeciais := '';
    Representante := '';
    Cod_Representante := '';
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        IMPRESSÕES
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**** IMPRIME SÓ O TÍTULO SELECIONADO *****}
procedure TFImprimeDuplicata.ImprimeSelecionado(Visualizar: Boolean);
begin
  PTempo.Execute('Carregando ...');
  CarregaDados;
  PTempo.Fecha;
  if UnImpressao.ImprimirDocumentonaLaser(CAD_DOCI_NRO_DOC.AsInteger) then
    ImprimeFolhaemBranco(Visualizar)
  else
  begin
    if Visualizar then
    begin
      if not VerificaFormCriado('TFMostraDuplicata') then
        FMostraDuplicata := TFMostraDuplicata.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMostraDuplicata'));
      FMostraDuplicata.MostraDocumento(Dados);
    end
    else
    begin
      UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
      UnImpressao.ImprimeDuplicata(Dados);
      UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
    end;
  end;
  FunContasAReceber.SetaDuplicataImpressa(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger);
end;

{***** IMPRIME OS CHEQUES A IMPRIMIR DIRETAMENTE - SEM VISUALIZAR *****}
procedure TFImprimeDuplicata.ImprimeTodos;
begin
  if ((not CAD_DOC.EOF) and (CModelo.Text <> '')) then
  begin
    with MovParcelas do
    begin
      DisableControls;
      First;
      PTempo.Execute('Imprimindo ... ');
      while not EOF do
      begin
        if UnImpressao.ImprimirDocumentonaLaser(CAD_DOCI_NRO_DOC.AsInteger) then
          ImprimeFolhaemBranco(false)
        else
        begin
          CarregaDados;
          UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
          UnImpressao.ImprimeDuplicata(Dados);
          UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
        end;
        FunContasAReceber.SetaDuplicataImpressa(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger);
        Next;
      end;
      EnableControls;
    end;
    PTempo.Fecha;
  end;
end;

{******************************************************************************}
procedure TFImprimeDuplicata.ImprimeFolhaemBranco(VpaVisualizar : Boolean);
begin
  dtRave := TdtRave.Create(self);
  dtRave.ImprimeDuplicata(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger,VpaVisualizar);
  dtRave.free;
  FunContasAReceber.SetaDuplicataImpressa(MovParcelasI_EMP_FIL.AsInteger,MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger);
end;

{******************************************************************************}
procedure TFImprimeDuplicata.RFiltroClick(Sender: TObject);
begin
  ENroNota.Clear;
  LNroNota.Caption := '';
  ECliente.Clear;
  LCliente.Caption := '';
  NFiltro.PageIndex := RFiltro.ItemIndex;
  PosicionaContas;
end;

procedure TFImprimeDuplicata.ENroNotaSelect(Sender: TObject);
begin
  ENroNota.ASelectValida.Clear;
  ENroNota.ASelectValida.Add(' select C.c_nom_CLI, CR.i_lan_rec from dba.CadContasaReceber  as CR, dba.CadClientes as C '+
                             ' where CR.I_COD_CLI = C.I_COD_CLI ' +
                             ' and I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                             ' and CR.I_NRO_NOT = @');
  ENroNota.ASelectLocaliza.Clear;
  ENroNota.ASelectLocaliza.Add(' select CR.i_lan_rec, CR.I_NRO_NOT, C.C_NOM_CLI, C.I_COD_CLI from '+
                               ' CadContasaReceber as CR, CadClientes as C '+
                               ' where CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                               ' and CR.I_COD_CLI = C.I_COD_CLI and I_NRO_NOT like ''@%''' +
                               ' and not CR.I_NRO_NOT is null ');
end;

procedure TFImprimeDuplicata.GradeParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    BVizualizar.Click
  else
    if key = '+' then
      PanelFiltro.Visible := False
    else
       if key = '-' then
         PanelFiltro.Visible := True;
end;

procedure TFImprimeDuplicata.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FImprimeDuplicata.HelpContext);
end;

Initialization
  RegisterClasses([TFImprimeDuplicata]);
end.
