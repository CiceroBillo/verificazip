unit AImprimeBoleto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnImpressao,
  ComCtrls, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Mask, numericos, UnContasApagar, Localizacao, UnClassesImprimir,
  UnImpressaoBoleto, UnClientes, UnDados, UnDadosCR, FMTBcd, SqlExpr, DBClient;

type

  TFImprimeBoleto = class(TForm)
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
    PAcumular: TPanelColor;
    MovParcelasC_NRO_DUP: TWideStringField;
    DBText1: TDBText;
    Label12: TLabel;
    Label13: TLabel;
    CBoleto: TDBLookupComboBoxColor;
    Query1: TSQL;
    IntegerField1: TFMTBCDField;
    IntegerField2: TFMTBCDField;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    StringField3: TWideStringField;
    DataSource1: TDataSource;
    CADBOLETO: TSQL;
    DATACADBOLETO: TDataSource;
    CADBOLETOI_SEQ_BOL: TFMTBCDField;
    CADBOLETOC_NOM_BOL: TWideStringField;
    CADBOLETOC_DES_LOC: TWideStringField;
    CADBOLETOC_DES_CED: TWideStringField;
    CADBOLETOC_DES_ESP: TWideStringField;
    CADBOLETOC_DES_ACE: TWideStringField;
    CADBOLETOC_DES_CAR: TWideStringField;
    CADBOLETOC_ESP_MOE: TWideStringField;
    CADBOLETOC_DES_LN1: TWideStringField;
    CADBOLETOC_DES_LN2: TWideStringField;
    CADBOLETOC_DES_LN3: TWideStringField;
    CADBOLETOC_DES_LN4: TWideStringField;
    CADBOLETOC_DES_LN5: TWideStringField;
    CADBOLETOC_DES_LN6: TWideStringField;
    CADBOLETOC_DES_LN7: TWideStringField;
    MovParcelasC_CEP_CLI: TWideStringField;
    MovParcelasC_EST_CLI: TWideStringField;
    MovParcelasI_NUM_END: TFMTBCDField;
    MovParcelasc_tip_pes: TWideStringField;
    MovParcelasc_cgc_cli: TWideStringField;
    MovParcelasc_cpf_cli: TWideStringField;
    BEmail: TBitBtn;
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
    procedure RTipoChange(Sender: TObject);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure GradeParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure BEmailClick(Sender: TObject);
  private
     FunImpFolhaBranca: TImpressaoBoleto;
     Dados : TDadosBoleto;
     TamanhoPrimeiroCampo : Integer;
     UnImpressao : TFuncoesImpressao;
     TeclaPresionada,
     ExecutaAfterScroll: Boolean; // Controla a execução.
     VprTransacao : TTransactionDesc;
     procedure PosicionaContas;
     procedure ImprimeFolhaBranca(VpaCodCliente: integer; Dados: TDadosBoleto;
       VpaPreview,VpaEnviarEmail: boolean);
     procedure DeletaLinhaBrancoInstrucoes(VpaInstrucoes : TStringList);
     procedure ImprimeTodos;
     procedure ImprimeAcumulado(Visualizar: Boolean);
     procedure ImprimeSelecionado(Visualizar: Boolean);
     procedure CarregaDados(ValorAcumulado: Double);
     procedure PosicionaDadosBoletoPadrao;
  public
    { Public declarations }
  end;

var
  FImprimeBoleto: TFImprimeBoleto;

implementation

uses APrincipal, AMostraBoleto, Funsistema, Constantes,
  FunSql, FunData, ConstMsg, FunString, FunNumeros;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeBoleto.FormCreate(Sender: TObject);
begin
  // Tabelas.
  AdicionaSQLAbreTabela(CAD_DOC,
    ' SELECT * FROM CAD_DOC DOC, CAD_DRIVER CAD ' +
    ' WHERE CAD.I_SEQ_IMP = DOC.I_SEQ_IMP ' +
    ' AND CAD.I_COD_DRV IS NULL ' +
    ' AND DOC.C_TIP_DOC = ''BOL'' ');
  AbreTabela(CADBOLETO);
  PosicionaDadosBoletoPadrao;
  // Outras Inicializações;
  TeclaPresionada := True;
  RTipo.ItemIndex := 0;
  RFiltro.ItemIndex := 0;
  NFiltro.PageIndex := 0;
  UnImpressao := TFuncoesImpressao.criar(self,FPrincipal.BaseDados);
  ExecutaAfterScroll := True;
  DataParcela1.Date := PrimeiroDiaMes(Date);
  DataParcela2.Date := UltimoDiaMes(Date);
  PosicionaContas;
  FunImpFolhaBranca := TImpressaoBoleto.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeBoleto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CADBOLETO);
  FechaTabela(CAD_DOC);
  UnImpressao.Free;
  if VerificaFormCriado('TFMostraBoleto') then
    FMostraBoleto.Close;
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);
  FunImpFolhaBranca.Free;
  Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFImprimeBoleto.BFecharClick(Sender: TObject);
begin
  self.close;
end;


{******************************************************************************}
procedure TFImprimeBoleto.PosicionaDadosBoletoPadrao;
begin
  if varia.DadoBoletoPadraoNota <> 0 then
  begin
    CADBOLETO.First;
    While not CadBoleto.Eof do
    begin
      if CADBOLETOI_SEQ_BOL.AsInteger = Varia.DadoBoletoPadraoNota then
        exit;
      CADBOLETO.next;
    end;
  end;
end;

procedure TFImprimeBoleto.PosicionaContas;
begin
  LimpaSQLTabela(MovParcelas);
  InseriLinhaSQL(MovParcelas, 0,
    ' SELECT CPM.I_LAN_REC, CPM.I_NRO_PAR, CPM.D_DAT_VEN, CPM.N_VLR_PAR, CPM.D_DAT_PAG, ' +
    ' CPM.N_VLR_PAG, CPM.C_NRO_CON, CPM.C_NRO_DOC, CPM.L_OBS_REC, CPM.I_COD_FRM, ' +
    ' CPM.N_VLR_DES, CPM.N_VLR_ACR, CP.I_NRO_NOT, CPM.C_NRO_DUP, C.I_NUM_END, ' +
    ' CP.N_VLR_TOT, CP.D_DAT_EMI, C.C_NOM_CLI, C.C_END_CLI, C.C_BAI_CLI, C.C_CID_CLI, C.C_CEP_CLI, C.C_EST_CLI,' +
    ' C.C_FO1_CLI, CP.C_CLA_PLA, C.I_COD_CLI, PAG.I_COD_FRM, PAG.C_NOM_FRM, c.c_tip_pes, c.c_cgc_cli, c.c_cpf_cli ');
  InseriLinhaSQL(MovParcelas, 1,
    ' from MovContasAReceber CPM, CadContasAReceber CP, CadClientes C, CADFORMASPAGAMENTO PAG ' +
    ' where CPM.I_COD_FRM = PAG.I_COD_FRM ' +
    ' AND   CPM.I_EMP_FIL = CP.I_EMP_FIL ' +
    ' AND   CPM.I_LAN_REC = CP.I_LAN_REC ' +
    ' AND   CP.I_COD_CLI  = C.I_COD_CLI ' +
    ' and   CP.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil));
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

{  case CVisualizar.ItemIndex of
    0 : InseriLinhaSQL(MovParcelas, 3, ' AND CPM.C_FLA_BOL = ''N'' '); // Não Impressos.
    1 : InseriLinhaSQL(MovParcelas, 3, ' AND CPM.C_FLA_BOL <> ''N'' '); // Não Impressos.
    2 : InseriLinhaSQL(MovParcelas, 3, ' '); // todos
  end;}
  InseriLinhaSQL(MovParcelas, 3, ' '); // todos

  InseriLinhaSQL(MovParcelas, 4, SQLTextoDataEntreAAAAMMDD('CP.D_DAT_EMI', DataParcela1.Date, DataParcela2.Date, True));
  InseriLinhaSQL(MovParcelas, 5,' order by CP.D_DAT_EMI');
  AbreTabela(MovParcelas);
  BVizualizar.Enabled := not MovParcelas.Eof;
  BImprimir.Enabled := not MovParcelas.Eof;
end;

procedure TFImprimeBoleto.RPeriodoClick(Sender: TObject);
begin
  PosicionaContas;
end;

procedure TFImprimeBoleto.MovParcelasAfterScroll(DataSet: TDataSet);
begin
  if TeclaPresionada then
    if ExecutaAfterScroll then
    begin
       if (RTipo.ItemIndex <> 1) then
       begin
         if VerificaFormCriado('TFMostraBoleto') then
         begin
           // Carregar os dados do cheque com os do contas a pagar.
           CarregaDados(0);
           FMostraBoleto.MostraDocumento(Dados);
           FImprimeBoleto.SetFocus;
           FImprimeBoleto.GradeParcelas.SetFocus;
         end;
       end;
    end;
end;

procedure TFImprimeBoleto.MovParcelasBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TFImprimeBoleto.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
  CBoleto.KeyValue:=CADBOLETOI_SEQ_BOL.AsInteger; // Posiciona no Primeiro;
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 2);
end;

procedure TFImprimeBoleto.CModeloExit(Sender: TObject);
begin
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 2);
end;

procedure TFImprimeBoleto.BVizualizarClick(Sender: TObject);
begin
  ExecutaAfterScroll := False;
  case RTipo.ItemIndex of
    0 .. 1 : ImprimeSelecionado(True);
         2 : ImprimeAcumulado(True);
  end;
  ExecutaAfterScroll := True;
end;

{******************************************************************************}
procedure TFImprimeBoleto.BImprimirClick(Sender: TObject);
begin
  ExecutaAfterScroll := False;
  case RTipo.ItemIndex of
    0 : ImprimeSelecionado(False);
    1 : ImprimeTodos;
    2 : ImprimeAcumulado(False);
  end;
  ExecutaAfterScroll := True;
  AtualizaSQLTabela(MovParcelas);
end;

procedure TFImprimeBoleto.GradeParcelasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := False;
end;

procedure TFImprimeBoleto.GradeParcelasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := True;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  CARREGA OS DADOS DO CHEQUE
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFImprimeBoleto.CarregaDados(ValorAcumulado: Double);
var
  VpfInstrucoes,
  VpfSacado,
  VpfObsParcela: TStringList;
  vpfCGC_CPF : string;
  VpfLaco : Integer;
begin
  Dados := TDadosBoleto.Create;
  VpfInstrucoes := TStringList.Create;
  VpfSacado := TStringList.Create;
  with Dados do
  begin
    if ValorAcumulado = 0 then
    begin
      Valor := MovParcelasN_VLR_PAR.AsFloat;
      Desconto := MovParcelasN_VLR_DES.AsFloat;
      Acrescimos := MovParcelasN_VLR_ACR.AsFloat;
    end
    else
    begin
      Valor := ValorAcumulado;
      Desconto := 0;
      Acrescimos := 0;
    end;
    Vencimento := MovParcelasD_DAT_VEN.AsDateTime;
    Instrucoes := VpfInstrucoes;
    Instrucoes.Add(CADBOLETOC_DES_LN1.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN2.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN3.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN4.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN5.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN6.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN7.AsString);
    DeletaLinhaBrancoInstrucoes(Instrucoes);
    if MovParcelasL_OBS_REC.AsString <> '' then
    begin
      Instrucoes.Add('');
      VpfObsParcela := TStringList.create;
      SeparaFrases(MovParcelasL_OBS_REC.AsString,70,VpfObsParcela);
      for VpfLaco := 0 to VpfObsParcela.Count - 1 do
        Instrucoes.Add(VpfObsParcela.Strings[VpfLaco]);
      VpfObsParcela.free;
    end;
    Sacado := VpfSacado;

    if MovParcelasc_tip_pes.AsString = 'F' then
      vpfCGC_CPF := MovParcelasc_cpf_cli.AsString
    else
      vpfCGC_CPF := MovParcelasc_cgc_cli.AsString;

    Sacado.Add(MovParcelasC_NOM_CLI.AsString + '   CGC/CPF : ' + vpfCGC_CPF );
    if (MovParcelasC_BAI_CLI.AsString = '') then
      Sacado.Add(MovParcelasC_END_CLI.AsString + '' + MovParcelasI_NUM_END.AsString)
    else
      Sacado.Add(MovParcelasC_END_CLI.AsString  + '' + MovParcelasI_NUM_END.AsString + ',  ' + MovParcelasC_BAI_CLI.AsString);
    if (MovParcelasC_CEP_CLI.AsString = '') then
      Sacado.Add(AdicionaBrancoD(MovParcelasC_CID_CLI.AsString, 40) + MovParcelasC_EST_CLI.AsString)
    else
      Sacado.Add(AdicionaBrancoD(MovParcelasC_CID_CLI.AsString, 40) + MovParcelasC_EST_CLI.AsString + '   CEP: ' + MovParcelasC_CEP_CLI.AsString);
    DataDocumento := Date;
    DataProcessamento := Date;
    Desconto := MovParcelasN_VLR_DES.AsFloat;
    Acrescimos := MovParcelasN_VLR_ACR.AsFloat;
    ValorDocumento := valor;//MovParcelasN_VLR_PAR.AsFloat;
    LocalPagamento := CADBOLETOC_DES_LOC.AsString;
    Cedente := CADBOLETOC_DES_CED.AsString;
    NumeroDocumento := MovParcelasC_NRO_DOC.AsString;
    EspecieDocumento := CADBOLETOC_DES_ESP.AsString;
    Aceite := CADBOLETOC_DES_ACE.AsString;
    Carteira := CADBOLETOC_DES_CAR.AsString;
    Especie := CADBOLETOC_ESP_MOE.AsString;
    Quantidade := '';
    Agencia := '';
    NossoNumero := '';
    Outras := 0;
    MoraMulta := 0;
    ValoCobrado := valor;
//    ValoCobrado := MovParcelasN_VLR_PAR.AsFloat + MovParcelasN_VLR_ACR.AsFloat - MovParcelasN_VLR_DES.AsFloat + MovParcelasN_VLR_ADI.AsFloat;
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        IMPRESSÕES
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**** IMPRIME SÓ O TÍTULO SELECIONADO *****}
procedure TFImprimeBoleto.ImprimeSelecionado(Visualizar: Boolean);
begin
  PTempo.Execute('Carregando ...');
  CarregaDados(0);
  PTempo.Fecha;
  if Visualizar then
  begin
    if not config.ImprimirBoletoFolhaBranco then
    begin
      if not VerificaFormCriado('TFMostraBoleto') then
        FMostraBoleto := TFMostraBoleto.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMostraBoleto'));
      FMostraBoleto.MostraDocumento(Dados);
    end
    else
      ImprimeFolhaBranca(MovParcelasI_COD_CLI.AsInteger, Dados, true,false);
  end
  else
    begin
      if not config.ImprimirBoletoFolhaBranco then
      begin
        UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
        UnImpressao.ImprimeBoleto(Dados);
        UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
      end
      else
        ImprimeFolhaBranca(MovParcelasI_COD_CLI.AsInteger, Dados, false,false);
      end;
end;

{***** SOMA OS VALORES DOS TITULOS A IMPRIMIR E COLOCA EM UM SÓ CHEQUE *****}
procedure TFImprimeBoleto.ImprimeAcumulado(Visualizar: Boolean);
var
  Soma: Double;
  ponto : Tbookmark;
begin
  case RFiltro.ItemIndex of
    1 : begin
          if (ECliente.Text = '') then
          begin
            Aviso('Informe o cliente a acumular.');
            ECliente.SetFocus;
            Abort;
          end;
        end;
    2 : begin
          if (ENroNota.Text = '') then
          begin
            Aviso('Informe a nota fiscal a acumular.');
            ENroNota.SetFocus;
            Abort;
          end;
        end;
  end;
  Soma := 0;
  with MovParcelas do
  begin
    PTempo.Execute('Somando ...');
    ponto := GetBookmark;
    DisableControls;
    First;
    while not EOF do
    begin
      if GradeParcelas.SelectedRows.CurrentRowSelected then
      begin
        Soma := Soma + (MovParcelasN_VLR_PAR.AsFloat + MovParcelasN_VLR_ACR.AsFloat - MovParcelasN_VLR_DES.AsFloat);
        PTempo.Caption :=('Somando ... : ' + FloatToStr(Soma));
        PTempo.Refresh;
      end;
      Next;
    end;
    GotoBookmark(ponto);
    FreeBookmark(ponto);
    CarregaDados(Soma);
    PTempo.Fecha;
    EnableControls;
    if Visualizar then
    begin
      if not config.ImprimirBoletoFolhaBranco then
      begin
        if not VerificaFormCriado('TFMostra') then
          FMostraBoleto := TFMostraBoleto.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FMostraBoleto'));
        FMostraBoleto.MostraDocumento(Dados);
      end
      else
        ImprimeFolhaBranca(MovParcelasI_COD_CLI.AsInteger, Dados, true,false);
    end
    else
      begin
        if not config.ImprimirBoletoFolhaBranco then
        begin
          UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
          UnImpressao.ImprimeBoleto(Dados);
          UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
        end
        else
          ImprimeFolhaBranca(MovParcelasI_COD_CLI.AsInteger, Dados, false,false);
      end;
  end;
end;

procedure TFImprimeBoleto.ImprimeFolhaBranca(VpaCodCliente: integer; Dados: TDadosBoleto;
  VpaPreview,VpaEnviarEmail: boolean);
var
  VpfDadosClinte: TRBDCliente;
begin
  VpfDadosClinte := TRBDCliente.cria;
  VpfDadosClinte.CodCliente := VpaCodCliente;

  FunClientes.CarDCliente(VpfDadosClinte);
  FunImpFolhaBranca.ImprimeBoleto(Varia.CodigoEmpFil, MovParcelasI_LAN_REC.AsInteger,MovParcelasI_NRO_PAR.AsInteger,
                                  VpfDadosClinte, VpaPreview,'',VpaEnviarEmail);

  VpfDadosClinte.Free;
end;

{******************************************************************************}
procedure TFImprimeBoleto.DeletaLinhaBrancoInstrucoes(VpaInstrucoes : TStringList);
var
  VpfLaco : Integer;
begin
  for VpfLaco := VpaInstrucoes.Count - 1 downto 0 do
  begin
    if VpaInstrucoes.Strings[VpfLaco] = '' then
      VpaInstrucoes.Delete(VpfLaco);
  end;
end;

{***** IMPRIME OS CHEQUES A IMPRIMIR DIRETAMENTE - SEM VISUALIZAR *****}
procedure TFImprimeBoleto.ImprimeTodos;
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
        CarregaDados(0);

        if not config.ImprimirBoletoFolhaBranco then
        begin
          UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
          UnImpressao.ImprimeBoleto(Dados);
          UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
        end
        else
          ImprimeFolhaBranca(MovParcelasI_COD_CLI.AsInteger, Dados, False,false);

        Next;
      end;
      EnableControls;
    end;
    PTempo.Fecha;
  end;
end;

procedure TFImprimeBoleto.RFiltroClick(Sender: TObject);
begin
  ENroNota.Clear;
  LNroNota.Caption := '';
  ECliente.Clear;
  LCliente.Caption := '';
  NFiltro.PageIndex := RFiltro.ItemIndex;
  // Não pode acumular por período. Só por nota ou cliente.
  if (RFiltro.ItemIndex = 0) and (RTipo.ItemIndex = 2) then
  begin
    Aviso('O documento só pode ser acumulado por nota ou cliente.');
    RTipo.ItemIndex := 0;
  end;
  PosicionaContas;
end;

procedure TFImprimeBoleto.ENroNotaSelect(Sender: TObject);
begin
  ENroNota.ASelectValida.Clear;
  ENroNota.ASelectValida.Add(' select C.c_nom_CLI, CR.i_lan_rec from CadContasaReceber  CR, CadClientes C '+
                             ' where CR.I_COD_CLI = C.I_COD_CLI ' +
                             ' and I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                             ' and CR.I_NRO_NOT = @');
  ENroNota.ASelectLocaliza.Clear;
  ENroNota.ASelectLocaliza.Add(' select CR.i_lan_rec, CR.I_NRO_NOT, C.C_NOM_CLI, C.I_COD_CLI from '+
                               ' CadContasaReceber  CR, CadClientes  C '+
                               ' where CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                               ' and CR.I_COD_CLI = C.I_COD_CLI and I_NRO_NOT like ''@%''' +
                               ' and not CR.I_NRO_NOT is null ');
end;

procedure TFImprimeBoleto.RTipoChange(Sender: TObject);
begin
  if (RFiltro.ItemIndex = 0) and (RTipo.ItemIndex = 2) then
  begin
    Aviso('O documento só pode ser acumulado por nota ou cliente.');
    RTipo.ItemIndex := 0;
  end;
end;

procedure TFImprimeBoleto.EClienteRetorno(Retorno1, Retorno2: String);
begin
  PosicionaContas;
end;

procedure TFImprimeBoleto.GradeParcelasKeyPress(Sender: TObject;
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

procedure TFImprimeBoleto.BEmailClick(Sender: TObject);
begin
  if MovParcelasI_COD_CLI.AsInteger <> 0 then
    ImprimeFolhaBranca(MovParcelasI_COD_CLI.AsInteger, Dados, true,true);
end;

Initialization
  RegisterClasses([TFImprimeBoleto]);
end.

