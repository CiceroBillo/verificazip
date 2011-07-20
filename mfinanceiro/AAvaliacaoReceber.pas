unit AAvaliacaoReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Tabela, Constantes,
  DBCtrls, ComCtrls, Localizacao, Mask, DBKeyViolation, TeeProcs, TeEngine,
  Chart, Series, DBChart, LabelCorMove, EditorImagem, Geradores, ToolWin,
  ImgList, Graficos;

type
  TFAvaliacaoReceber = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Aux: TQuery;
    Localiza: TConsultaPadrao;
    DataMovParcelas: TDataSource;
    MovParcelas: TQuery;
    Tempo: TPainelTempo;
    PanelColor4: TPanelColor;
    BGraficos: TBitBtn;
    BitBtn1: TBitBtn;
    PanelColor3: TPanelColor;
    Label18: TLabel;
    Label20: TLabel;
    SpeedButton4: TSpeedButton;
    Tipo: TRadioGroup;
    ECliente: TEditLocaliza;
    GroupBox1: TGroupBox;
    EDataIni: TCalendario;
    Label10: TLabel;
    EDataFim: TCalendario;
    RVencimento: TRadioButton;
    REmissao: TRadioButton;
    RPagamento: TRadioButton;
    RNenhum: TRadioButton;
    PPage: TPageControl;
    TitulosTab: TTabSheet;
    ReceberGrid: TGridIndice;
    PagamentoTab: TTabSheet;
    GeraisTab: TTabSheet;
    AdicionaisTab: TTabSheet;
    Label11: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    LTVencidos: TLabel;
    LQtdVencido: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label15: TLabel;
    LTTotalTitulosCorrigidos: TLabel;
    LTNaoVencidos: TLabel;
    LTTotalPagos: TLabel;
    LTVencidosCorrigido: TLabel;
    LQtdPago: TLabel;
    LQAbertos: TLabel;
    LQtqTotal: TLabel;
    FORMAPAGAMENTO: TQuery;
    DATAFORMAPAGAMENTO: TDataSource;
    FORMAPAGAMENTOI_COD_FRM: TIntegerField;
    FORMAPAGAMENTOC_NOM_FRM: TStringField;
    FORMAPAGAMENTOTOTAL: TFloatField;
    FORMAPAGAMENTOQDADE: TIntegerField;
    FORMAPAGAMENTOMEDIA: TFloatField;
    GridIndice1: TGridIndice;
    CondicoesTab: TTabSheet;
    CONDICOES: TQuery;
    DATACONDICOES: TDataSource;
    CONDICOESI_COD_PAG: TIntegerField;
    CONDICOESC_NOM_PAG: TStringField;
    CONDICOESTOTAL: TFloatField;
    CONDICOESQDADE: TIntegerField;
    CONDICOESMEDIA: TFloatField;
    GridIndice2: TGridIndice;
    ADICIONAIS: TQuery;
    DATAADICIONAIS: TDataSource;
    GridIndice3: TGridIndice;
    Label12: TLabel;
    LTJurMorMulVencidos: TLabel;
    Label14: TLabel;
    LTAdicionaisNaoVencidos: TLabel;
    Label17: TLabel;
    Label13: TLabel;
    DataTab: TTabSheet;
    Label16: TLabel;
    LTPagosAtrazo: TLabel;
    LQPagosAtrazo: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label38: TLabel;
    Label25: TLabel;
    Label24: TLabel;
    Label23: TLabel;
    Label22: TLabel;
    Label1: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    L0: TLabel;
    LQ0: TLabel;
    LQ1: TLabel;
    LQ2: TLabel;
    LQ3: TLabel;
    LQ4: TLabel;
    LQ5: TLabel;
    LQ6: TLabel;
    LQ7: TLabel;
    L7: TLabel;
    L6: TLabel;
    L4: TLabel;
    L5: TLabel;
    L3: TLabel;
    L2: TLabel;
    L1: TLabel;
    Bevel1: TBevel;
    Label47: TLabel;
    Label6: TLabel;
    LTTotalNaoVencidas: TLabel;
    LTTotalAberto: TLabel;
    Label54: TLabel;
    LTAdicionaisAberto: TLabel;
    Label55: TLabel;
    LTJurosAberto: TLabel;
    Label5: TLabel;
    LTAbertos: TLabel;
    LTTotalTitulos: TLabel;
    LTAdicionaisVencidos: TLabel;
    LQtdNaoVencido: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label53: TLabel;
    LTAdicionaisPagos: TLabel;
    LTDescontosPagos: TLabel;
    LTAcrescimosPagos: TLabel;
    LQtdPagoVencimento: TLabel;
    LMaiorVenda: TLabel;
    LTPagoVencimento: TLabel;
    Label56: TLabel;
    LTPagos: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label61: TLabel;
    LTVencidosAtrazo: TLabel;
    LQVVencidosAtrazo: TLabel;
    LQv7: TLabel;
    Lv7: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Lv0: TLabel;
    Lv1: TLabel;
    Lv2: TLabel;
    Lv3: TLabel;
    Lv4: TLabel;
    Lv5: TLabel;
    Lv6: TLabel;
    LQv6: TLabel;
    LQv5: TLabel;
    LQv4: TLabel;
    LQv3: TLabel;
    LQv2: TLabel;
    LQv1: TLabel;
    LQv0: TLabel;
    Label90: TLabel;
    MovParcelasI_LAN_REC: TIntegerField;
    MovParcelasC_CLA_PLA: TStringField;
    MovParcelasI_COD_CLI: TIntegerField;
    MovParcelasI_NRO_NOT: TIntegerField;
    MovParcelasD_DAT_EMI: TDateField;
    MovParcelasI_NRO_PAR: TIntegerField;
    MovParcelasD_DAT_VEN: TDateField;
    MovParcelasN_VLR_PAR: TFloatField;
    MovParcelasD_DAT_PAG: TDateField;
    MovParcelasN_VLR_PAG: TFloatField;
    MovParcelasC_NRO_DUP: TStringField;
    MovParcelasN_PER_MUL: TFloatField;
    MovParcelasN_PER_JUR: TFloatField;
    MovParcelasN_VLR_DES: TFloatField;
    MovParcelasN_VLR_ACR: TFloatField;
    MovParcelasN_PER_MOR: TFloatField;
    MovParcelasC_NOM_MOE: TStringField;
    MovParcelasDIAS_PAGOS: TIntegerField;
    MovParcelasDIAS_VENCIDOS: TIntegerField;
    MovParcelasMULTA: TFloatField;
    MovParcelasMORA: TFloatField;
    MovParcelasJUROS: TFloatField;
    MovParcelasACRESCIMO_TITULO: TFloatField;
    MovParcelasVALOR_ATUAL: TFloatField;
    Label37: TLabel;
    LTcVencidosAtrazo: TLabel;
    Lvc0: TLabel;
    Lvc1: TLabel;
    Lvc2: TLabel;
    Lvc3: TLabel;
    Lvc4: TLabel;
    Lvc5: TLabel;
    Lvc6: TLabel;
    Lvc7: TLabel;
    ADICIONAISTOTAL: TFloatField;
    ADICIONAISQDADE: TIntegerField;
    ADICIONAISMEDIA: TFloatField;
    ADICIONAISMEDIARECEBER: TFloatField;
    ADICIONAISRECEBER: TFloatField;
    ADICIONAISC_NOM_PLA: TStringField;
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
    Label41: TLabel;
    DBText19: TDBText;
    Label42: TLabel;
    DBText20: TDBText;
    Label43: TLabel;
    DBText21: TDBText;
    Label44: TLabel;
    DBText22: TDBText;
    Label48: TLabel;
    DBText13: TDBText;
    DBText1: TDBText;
    Label59: TLabel;
    DBText5: TDBText;
    BitBtn2: TBitBtn;
    BCaixa: TSpeedButton;
    Label9: TLabel;
    L8: TLabel;
    LQ8: TLabel;
    Label45: TLabel;
    Lv8: TLabel;
    Lvc8: TLabel;
    LQv8: TLabel;
    GraficosTrio: TGraficosTrio;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EClienteChange(Sender: TObject);
    procedure TipoClick(Sender: TObject);
    procedure PeriodoClick(Sender: TObject);
    procedure MovParcelasVALOR_ATUALGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure BCaixaClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure PPageChange(Sender: TObject);
    procedure MovParcelasDIAS_PAGOSGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure MovParcelasDIAS_VENCIDOSGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure ReceberGridKeyPress(Sender: TObject; var Key: Char);
    procedure BGraficosClick(Sender: TObject);
  private
    TeclaPresionada : Boolean;
    procedure CarregaVariaveisGrafico;
    procedure MudaVisible( coluna : array of integer; acao : Boolean);
    procedure ExecutaParcelaPai;
    procedure AtualizaValores;
    procedure CarregaTextoImprimir(Texto: TStringList);
    procedure CarregaFormasPagamento;
    procedure CarregaCondPagamento;
    procedure CarregaAdicionais;
  public
    { Public declarations }
  end;

var
  FAvaliacaoReceber: TFAvaliacaoReceber;

implementation

uses fundata, APrincipal, constmsg, FUNSQL,
   FunString;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFAvaliacaoReceber.FormCreate(Sender: TObject);
begin
   EDataIni.Date := PrimeiroDiaMes(Date);
   EDataFim.Date := Date;
{   TipoClick(Sender);
   TeclaPresionada := True;}
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAvaliacaoReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//   FechaTabela(MovParcelas);
   Action := CaFree;
end;

{********************Quando o formulario é mostrado****************************}
procedure TFAvaliacaoReceber.FormShow(Sender: TObject);
begin
{  ExecutaParcelaPai;
  PPage.ActivePage := TitulosTab;}
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Execucao da Consulta da parcela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFAvaliacaoReceber.ExecutaParcelaPai;
begin
  FechaTabela(MovParcelas);
  LimpaSQLTabela(MovParcelas);
  InseriLinhaSQL(MovParcelas, 0,
    ' SELECT CR.I_LAN_REC, CR.C_CLA_PLA, CR.I_COD_CLI, CR.I_NRO_NOT, ' +
    ' CR.D_DAT_EMI, MCR.I_NRO_PAR, MCR.D_DAT_VEN, ' +
    ' (MCR.N_VLR_PAR * MOE.N_VLR_DIA) N_VLR_PAR, MCR.D_DAT_PAG, MCR.N_VLR_PAG, MCR.C_NRO_DUP, ' +
    ' MCR.N_PER_MUL, MCR.N_PER_MOR, MCR.N_PER_JUR,  ' +
    ' ISNULL(MCR.N_VLR_ACR,0) N_VLR_ACR, ISNULL(MCR.N_VLR_DES,0) N_VLR_DES, MOE.C_NOM_MOE, ' +
    ' (MCR.D_DAT_PAG - MCR.D_DAT_VEN) DIAS_PAGOS, ' +
    ' (TODAY(*) - MCR.D_DAT_VEN) DIAS_VENCIDOS, ' +
    ' (N_VLR_PAR * isnull(N_PER_MUL,0)/100) MULTA, ' +
    ' (N_VLR_PAR * isnull(N_PER_MOR,0)/100 * DIAS_VENCIDOS) MORA, ' +
    ' (N_VLR_PAR * isnull(N_PER_JUR,0)/100 * DIAS_VENCIDOS / 30) JUROS, ' +
    ' (MULTA + MORA + JUROS)  ACRESCIMO_TITULO, ' +
    ' (N_VLR_PAR + ACRESCIMO_TITULO) VALOR_ATUAL');
  InseriLinhaSQL(MovParcelas, 1,
    ' FROM MovContasaReceber as MCR, ' +
    '      CadContasaReceber as CR, ' +
    '      CadMoedas as MOE ' +
    ' WHERE CR.I_LAN_REC = MCR.I_LAN_REC ' +
    '       AND CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
    '       AND CR.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    '       AND MCR.I_COD_MOE = MOE.I_COD_MOE ' );
  {((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                FILTRO
  ))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
  case Tipo.ItemIndex of
    0 : begin
          // VENCIDAS.
          InseriLinhaSQL(MovParcelas, 2, ' and MCR.D_DAT_PAG IS NULL and MCR.D_DAT_VEN < ''' + DataToStrFormato(AAAAMMDD, Date, '/') + '''');
        end;
    1 : begin // PAGAS
          InseriLinhaSQL(MovParcelas, 2, ' and NOT MCR.D_DAT_PAG IS NULL ');
        end;
    2 : begin // TODAS
          InseriLinhaSQL(MovParcelas, 2, '');
        end;
  end;
  if RVencimento.Checked then // VENCIMENTO;
    InseriLinhaSQL(MovParcelas, 3,' and MCR.D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD, EDataIni.Date,'/') + '''' + ' and ''' + DataToStrFormato(AAAAMMDD, EDataFim.Date, '/') + ''''  )
    else
    if REmissao.Checked then // EMISSÃO.
      InseriLinhaSQL(MovParcelas, 3,' and CR.D_DAT_EMI between ''' + DataToStrFormato(AAAAMMDD,EDataIni.Date,'/') + '''' + ' and ''' + DataToStrFormato(AAAAMMDD, EDataFim.Date, '/') + ''''  )
      else
      if RPagamento.Checked then  // PAGAMENTO.
        InseriLinhaSQL(MovParcelas, 3,' and MCR.D_DAT_PAG between ''' + DataToStrFormato(AAAAMMDD,EDataIni.Date,'/') + '''' +  ' and ''' + DataToStrFormato(AAAAMMDD, EDataFim.Date, '/') + ''''  )
        else
        InseriLinhaSQL(MovParcelas, 3,'');
   if ECliente.Text <> '' then
     InseriLinhaSQL(MovParcelas, 4,' and CR.I_COD_CLI = ' + ECliente.Text )
   else
     InseriLinhaSQL(MovParcelas, 4,'');
   InseriLinhaSQL(MovParcelas, 5,' Order by MCR.D_DAT_VEN');
   AbreTabela(MovParcelas);
   AtualizaValores;
   CarregaFormasPagamento;
   CarregaCondPagamento;
   CarregaAdicionais;
end;

{*********************Altera os desenho do botão do zoom***********************}
procedure TFAvaliacaoReceber.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFAvaliacaoReceber.EClienteChange(Sender: TObject);
begin
{  if PPage.ActivePage = PagamentoTab then
    CarregaFormasPagamento
  else
    if PPage.ActivePage = CondicoesTab then
      CarregaCondPagamento
    else
      if PPage.ActivePage = AdicionaisTab then
        CarregaAdicionais
      else
        ExecutaParcelaPai; }
 // ExecutaParcelaPai;
end;


procedure TFAvaliacaoReceber.MudaVisible( coluna : array of integer; acao : Boolean);
 var
  laco : integer;
begin
  for laco := low(coluna) to high(coluna) do
      ReceberGrid.Columns[coluna[laco]].Visible := acao;
end;

procedure TFAvaliacaoReceber.TipoClick(Sender: TObject);
begin
  case Tipo.ItemIndex of
    0 : begin
          mudavisible([5,6,9,10,12], false);
          mudavisible([7,8,13],true);
        end;
    1 : begin
          mudavisible([7,8,13],false);
          mudavisible([5,6,9,10,12], true);
        end;
    2 : begin
          mudavisible([5,6,12,7,13],false);
          mudavisible([8,9,10], true);
       end;
  end;
  ExecutaParcelaPai;
end;

procedure TFAvaliacaoReceber.PeriodoClick(Sender: TObject);
begin
  EDataIni.Enabled := not RNenhum.Checked;
  EDataFim.Enabled := not RNenhum.Checked;
{  if PPage.ActivePage = PagamentoTab then
    CarregaFormasPagamento
  else
    if PPage.ActivePage = CondicoesTab then
      CarregaCondPagamento
    else
      if PPage.ActivePage = AdicionaisTab then
        CarregaAdicionais
      else
        ExecutaParcelaPai; }
  ExecutaParcelaPai;
end;

procedure TFAvaliacaoReceber.AtualizaValores;
var
  TVencidos,
  TJurMorMulVencidos,
  TAdicionaisVencidos,
  TNaoVencidos,
  TAdicionaisNaoVencidos,
  TPagos,
  TTotalPagos,
  TPagoVencimento,
  TAcrescimosPagos,
  TDescontosPagos,
  TAdicionaisPagos,
  MaiorVenda: Double;
  QtdAbertos,
  QtqTotal,
  QtdVencido,
  QtdPago,
  QtdPagoVencimento,
  QtdNaoVencido,
  I : Integer;
  TPeriodo : array [0..8] of Double;
  QPeriodo : array [0..8] of Integer;
  TVPeriodo : array [0..8] of Double;
  TVCPeriodo : array [0..8] of Double;
  QVPeriodo : array [0..8] of Integer;
begin
  // Inicializa Variáveis.
  for I:=0 to 8 do
  begin
    TPeriodo[I] := 0;
    QPeriodo[I] := 0;
    TVPeriodo[I] := 0;
    TVCPeriodo[I] := 0;
    QVPeriodo[I] := 0;
  end;
  TVencidos:= 0;
  TJurMorMulVencidos:= 0;
  TAdicionaisVencidos:= 0;
  TNaoVencidos:= 0;
  TAdicionaisNaoVencidos:= 0;
  TPagos:= 0;
  TTotalPagos:= 0;
  TPagoVencimento:= 0;
  TAcrescimosPagos:= 0;
  TDescontosPagos:= 0;
  TAdicionaisPagos:= 0;
  MaiorVenda:= 0;
  QtdAbertos:= 0;
  QtqTotal:= 0;
  QtdVencido:= 0;
  QtdPago:= 0;
  QtdPagoVencimento:= 0;
  QtdNaoVencido:= 0;
  with MovParcelas do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      // Maior Venda;
      if (MovParcelasN_VLR_PAR.AsFloat > MaiorVenda) then
        MaiorVenda := MovParcelasN_VLR_PAR.AsFloat;
      Inc(QtqTotal);
      if MovParcelasD_DAT_PAG.IsNull then // ABERTOS;
      begin
         Inc(QtdAbertos);
         if (MovParcelasD_DAT_VEN.AsDateTime < DATE) then // VENCIDA E NÃO PAGA.
         begin
           // MovParcelasQTD_DIAS_VENCIDOS.AsInteger;
           TVencidos:=TVencidos + MovParcelasN_VLR_PAR.AsFloat;
           TJurMorMulVencidos := TJurMorMulVencidos + MovParcelasACRESCIMO_TITULO.AsFloat;
           Inc(QtdVencido);
           // DIAS DE ATRAZO PAGOS.
           case (DiasPorPeriodo(MovParcelasD_DAT_VEN.AsDateTime, DATE)) of
             00 .. 05 : begin
                          TVPeriodo[0] := TVPeriodo[0] + MovParcelasN_VLR_PAR.AsFloat;
                          TVCPeriodo[0] := TVCPeriodo[0] + MovParcelasN_VLR_PAR.AsFloat + MovParcelasACRESCIMO_TITULO.AsFloat;
                          QVPeriodo[0] := QVPeriodo[0] + 1;
                        end;
             06 .. 10 : begin
                          TVPeriodo[1] := TVPeriodo[1] + MovParcelasN_VLR_PAR.AsFloat;
                          TVCPeriodo[1] := TVCPeriodo[1] + MovParcelasN_VLR_PAR.AsFloat + MovParcelasACRESCIMO_TITULO.AsFloat;
                          QVPeriodo[1] := QVPeriodo[1] + 1;
                        end;
             11 .. 15 : begin
                          TVPeriodo[2] := TVPeriodo[2] + MovParcelasN_VLR_PAR.AsFloat;
                          TVCPeriodo[2] := TVCPeriodo[2] + MovParcelasN_VLR_PAR.AsFloat + MovParcelasACRESCIMO_TITULO.AsFloat ;
                          QVPeriodo[2] := QVPeriodo[2] + 1;
                        end;
             16 .. 20 : begin
                          TVPeriodo[3] := TVPeriodo[3] + MovParcelasN_VLR_PAR.AsFloat;
                          TVCPeriodo[3] := TVCPeriodo[3] + MovParcelasN_VLR_PAR.AsFloat + MovParcelasACRESCIMO_TITULO.AsFloat;
                          QVPeriodo[3] := QVPeriodo[3] + 1;
                        end;
             21 .. 25 : begin
                          TVPeriodo[4] := TVPeriodo[4] + MovParcelasN_VLR_PAR.AsFloat;
                          TVCPeriodo[4] := TVCPeriodo[4] + MovParcelasN_VLR_PAR.AsFloat + MovParcelasACRESCIMO_TITULO.AsFloat;
                          QVPeriodo[4] := QVPeriodo[4] + 1;
                        end;
             26 .. 30 : begin
                          TVPeriodo[5] := TVPeriodo[5] + MovParcelasN_VLR_PAR.AsFloat;
                          TVCPeriodo[5] := TVCPeriodo[5] + MovParcelasN_VLR_PAR.AsFloat + MovParcelasACRESCIMO_TITULO.AsFloat ;
                          QVPeriodo[5] := QVPeriodo[5] + 1;
                        end;
             31 .. 60 : begin
                          TVPeriodo[6] := TVPeriodo[6] + MovParcelasN_VLR_PAR.AsFloat;
                          TVCPeriodo[6] := TVCPeriodo[6] + MovParcelasN_VLR_PAR.AsFloat + MovParcelasACRESCIMO_TITULO.AsFloat ;
                          QVPeriodo[6] := QVPeriodo[6] + 1;
                        end;
             61 .. 180 : begin
                           TVPeriodo[7] := TVPeriodo[7] + MovParcelasN_VLR_PAR.AsFloat;
                           TVCPeriodo[7] := TVCPeriodo[7] + MovParcelasN_VLR_PAR.AsFloat + MovParcelasACRESCIMO_TITULO.AsFloat;
                           QVPeriodo[7] := QVPeriodo[7] + 1;
                         end;
             else
             begin
               TVPeriodo[8] := TVPeriodo[8] + MovParcelasN_VLR_PAR.AsFloat;
               TVCPeriodo[8] := TVCPeriodo[8] + MovParcelasN_VLR_PAR.AsFloat + MovParcelasACRESCIMO_TITULO.AsFloat ;
               QVPeriodo[8] := QVPeriodo[8] + 1;
             end;
           end;
         end
         else
         begin // Não Vencidas.
           TNaoVencidos:=TNaoVencidos + MovParcelasN_VLR_PAR.AsFloat;
           TAdicionaisNaoVencidos := TAdicionaisNaoVencidos;
           Inc(QtdNaoVencido);
         end;
      end
      else // PAGA.
      begin
        TAcrescimosPagos := TAcrescimosPagos + MovParcelasN_VLR_ACR.AsFloat;
        TDescontosPagos := TDescontosPagos + MovParcelasN_VLR_DES.AsFloat;
        TTotalPagos := TTotalPagos + MovParcelasN_VLR_PAG.AsFloat;
        TPagos := TPagos + MovParcelasN_VLR_PAG.AsFloat + MovParcelasN_VLR_DES.AsFloat - MovParcelasN_VLR_ACR.AsFloat ;
        Inc(QtdPago);
        // Pagas no Vencimento;
        if (MovParcelasD_DAT_VEN.AsDateTime =
            MovParcelasD_DAT_PAG.AsDateTime) then
        begin
          TPagoVencimento := TPagoVencimento + MovParcelasN_VLR_PAG.AsFloat;
          Inc(QtdPagoVencimento);
        end;
        // DIAS DE ATRAZO PAGOS.
        case (DiasPorPeriodo(MovParcelasD_DAT_VEN.AsDateTime,
                             MovParcelasD_DAT_PAG.AsDateTime)) of
          00 .. 05 : begin
                       TPeriodo[0] := TPeriodo[0] + MovParcelasN_VLR_PAG.AsFloat;
                       QPeriodo[0] := QPeriodo[0] + 1;
                     end;
          06 .. 10 : begin
                       TPeriodo[1] := TPeriodo[1] + MovParcelasN_VLR_PAG.AsFloat;
                       QPeriodo[1] := QPeriodo[1] + 1;
                     end;
          11 .. 15 : begin
                       TPeriodo[2] := TPeriodo[2] + MovParcelasN_VLR_PAG.AsFloat;
                       QPeriodo[2] := QPeriodo[2] + 1;
                     end;
          16 .. 20 : begin
                       TPeriodo[3] := TPeriodo[3] + MovParcelasN_VLR_PAG.AsFloat;
                       QPeriodo[3] := QPeriodo[3] + 1;
                     end;
          21 .. 25 : begin
                       TPeriodo[4] := TPeriodo[4] + MovParcelasN_VLR_PAG.AsFloat;
                       QPeriodo[4] := QPeriodo[4] + 1;
                     end;
          26 .. 30 : begin
                       TPeriodo[5] := TPeriodo[5] + MovParcelasN_VLR_PAG.AsFloat;
                       QPeriodo[5] := QPeriodo[5] + 1;
                     end;
          31 .. 60 : begin
                       TPeriodo[6] := TPeriodo[6] + MovParcelasN_VLR_PAG.AsFloat;
                       QPeriodo[6] := QPeriodo[6] + 1;
                     end;
          61 .. 180 : begin
                       TPeriodo[7] := TPeriodo[7] + MovParcelasN_VLR_PAG.AsFloat;
                       QPeriodo[7] := QPeriodo[7] + 1;
                     end;
          else
          begin
            TPeriodo[8] := TPeriodo[8] + MovParcelasN_VLR_PAG.AsFloat;
            QPeriodo[8] := QPeriodo[8] + 1;
          end;
        end;
      end;
      Next;
    end;
    MovParcelas.First;
    EnableControls;
  end;
  // Valores.
  LMaiorVenda.Caption :=FormatFloat('R$ ###,###,###,##0.00', MaiorVenda);
  // Vencidos.
  LTVencidos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TVencidos);
  LTJurMorMulVencidos.Caption:=FormatFloat('R$ ###,###,###,##0.00', TJurMorMulVencidos);
  LTAdicionaisVencidos.Caption:=FormatFloat('R$ ###,###,###,##0.00', TAdicionaisVencidos);
  LTVencidosCorrigido.Caption :=FormatFloat('R$ ###,###,###,##0.00', TVencidos + TJurMorMulVencidos + TAdicionaisVencidos);
  // Não Vencidos.
  LTNaoVencidos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TNaoVencidos);
  LTAdicionaisNaoVencidos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TAdicionaisNaoVencidos);
  LTTotalNaoVencidas.Caption :=FormatFloat('R$ ###,###,###,##0.00', TNaoVencidos + TAdicionaisNaoVencidos);
  // Abertos.
  LTAbertos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TVencidos + TNaoVencidos);
  LTAdicionaisAberto.Caption :=FormatFloat('R$ ###,###,###,##0.00', TAdicionaisVencidos + TAdicionaisNaoVencidos);
  LTJurosAberto.Caption :=FormatFloat('R$ ###,###,###,##0.00', TJurMorMulVencidos);
  LTTotalAberto.Caption :=FormatFloat('R$ ###,###,###,##0.00', TVencidos + TNaoVencidos + TJurMorMulVencidos + TAdicionaisVencidos + TAdicionaisNaoVencidos);
  // Pagos.
  LTPagos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TPagos);
  LTAcrescimosPagos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TAcrescimosPagos);
  LTDescontosPagos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TDescontosPagos);
  LTAdicionaisPagos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TAdicionaisPagos);
  LTTotalPagos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TTotalPagos);
  // Total Geral.
  LTTotalTitulos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TTotalPagos + TVencidos + TNaoVencidos + TAdicionaisVencidos + TAdicionaisNaoVencidos);
  LTTotalTitulosCorrigidos.Caption :=FormatFloat('R$ ###,###,###,##0.00', TTotalPagos + TVencidos + TNaoVencidos +  TAdicionaisVencidos + TAdicionaisNaoVencidos + TJurMorMulVencidos);
  // DATAS..........
  LTPagoVencimento.Caption :=FormatFloat('R$ ###,###,###,##0.00', TPagoVencimento);
  // Quantidades.
  LQtqTotal.Caption :=IntToStr(QtqTotal);
  LQtdVencido.Caption :=IntToStr(QtdVencido);
  LQtdPago.Caption := IntToStr(QtdPago);
  LQtdPagoVencimento.Caption :=IntToStr(QtdPagoVencimento);
  LQAbertos.Caption := IntToStr(QtdAbertos);
  LQtdNaoVencido.Caption := IntToStr(QtdNaoVencido);
  // VALORES.
  L0.Caption := (FormatFloat('R$ ###,###,###,##0.00',TPeriodo[0]));
  L1.Caption := (FormatFloat('R$ ###,###,###,##0.00',TPeriodo[1]));
  L2.Caption := (FormatFloat('R$ ###,###,###,##0.00',TPeriodo[2]));
  L3.Caption := (FormatFloat('R$ ###,###,###,##0.00',TPeriodo[3]));
  L4.Caption := (FormatFloat('R$ ###,###,###,##0.00',TPeriodo[4]));
  L5.Caption := (FormatFloat('R$ ###,###,###,##0.00',TPeriodo[5]));
  L6.Caption := (FormatFloat('R$ ###,###,###,##0.00',TPeriodo[6]));
  L7.Caption := (FormatFloat('R$ ###,###,###,##0.00',TPeriodo[7]));
  L8.Caption := (FormatFloat('R$ ###,###,###,##0.00',TPeriodo[8]));
  LTPagosAtrazo.Caption :=FormatFloat('R$ ###,###,###,##0.00',
    (TPeriodo[0] + TPeriodo[1] +
     TPeriodo[2] + TPeriodo[3] +
     TPeriodo[4] + TPeriodo[5] +
     TPeriodo[6] + TPeriodo[7] + TPeriodo[8]));
  LV0.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVPeriodo[0]));
  LV1.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVPeriodo[1]));
  LV2.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVPeriodo[2]));
  LV3.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVPeriodo[3]));
  LV4.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVPeriodo[4]));
  LV5.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVPeriodo[5]));
  LV6.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVPeriodo[6]));
  LV7.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVPeriodo[7]));
  LV8.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVPeriodo[8]));
  LTVencidosAtrazo.Caption :=FormatFloat('R$ ###,###,###,##0.00',
    (TVPeriodo[0] + TVPeriodo[1] +
     TVPeriodo[2] + TVPeriodo[3] +
     TVPeriodo[4] + TVPeriodo[5] +
     TVPeriodo[6] + TVPeriodo[7] + TVPeriodo[8]));
  LVc0.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVcPeriodo[0]));
  LVc1.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVcPeriodo[1]));
  LVc2.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVcPeriodo[2]));
  LVc3.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVcPeriodo[3]));
  LVc4.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVcPeriodo[4]));
  LVc5.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVcPeriodo[5]));
  LVc6.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVcPeriodo[6]));
  LVc7.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVcPeriodo[7]));
  LVc8.Caption := (FormatFloat('R$ ###,###,###,##0.00',TVcPeriodo[8]));
  LTcVencidosAtrazo.Caption :=FormatFloat('R$ ###,###,###,##0.00',
    (TVcPeriodo[0] + TVcPeriodo[1] +
     TVcPeriodo[2] + TVcPeriodo[3] +
     TVcPeriodo[4] + TVcPeriodo[5] +
     TVcPeriodo[6] + TVcPeriodo[7] + TVcPeriodo[8]));
  // QUANTIDADES.
  LQ0.Caption := IntToStr(QPeriodo[0]);
  LQ1.Caption := IntToStr(QPeriodo[1]);
  LQ2.Caption := IntToStr(QPeriodo[2]);
  LQ3.Caption := IntToStr(QPeriodo[3]);
  LQ4.Caption := IntToStr(QPeriodo[4]);
  LQ5.Caption := IntToStr(QPeriodo[5]);
  LQ6.Caption := IntToStr(QPeriodo[6]);
  LQ7.Caption := IntToStr(QPeriodo[7]);
  LQ8.Caption := IntToStr(QPeriodo[8]);
  LQPagosAtrazo.Caption := IntToStr(QPeriodo[0] + QPeriodo[1] +
    QPeriodo[2] + QPeriodo[3] + QPeriodo[4] +
    QPeriodo[5] + QPeriodo[6] + QPeriodo[7] + QPeriodo[8]);
  LQV0.Caption := IntToStr(QVPeriodo[0]);
  LQV1.Caption := IntToStr(QVPeriodo[1]);
  LQV2.Caption := IntToStr(QVPeriodo[2]);
  LQV3.Caption := IntToStr(QVPeriodo[3]);
  LQV4.Caption := IntToStr(QVPeriodo[4]);
  LQV5.Caption := IntToStr(QVPeriodo[5]);
  LQV6.Caption := IntToStr(QVPeriodo[6]);
  LQV7.Caption := IntToStr(QVPeriodo[7]);
  LQV8.Caption := IntToStr(QVPeriodo[8]);
  LQVVencidosAtrazo.Caption := IntToStr(QVPeriodo[0] + QVPeriodo[1] +
    QVPeriodo[2] + QVPeriodo[3] + QVPeriodo[4] +
    QVPeriodo[5] + QVPeriodo[6] + QVPeriodo[7] + QVPeriodo[8]);
end;

procedure TFAvaliacaoReceber.MovParcelasVALOR_ATUALGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  // Vencida, mostra o valor atual.
  if (MovParcelasD_DAT_PAG.IsNull) and (MovParcelasD_DAT_VEN.AsDateTime < Date) then
    Text := FormatFloat('###,###,###,###,##0.00', MovParcelasVALOR_ATUAL.AsFloat)
  else
    Text := '';
end;

procedure TFAvaliacaoReceber.BCaixaClick(Sender: TObject);
begin
  Detalhes.Visible := BCaixa.Down;
end;

procedure TFAvaliacaoReceber.BitBtn2Click(Sender: TObject);
begin
  BCaixa.Down := False;
  Detalhes.Visible := False;
end;

procedure TFAvaliacaoReceber.PPageChange(Sender: TObject);
begin
  BGraficos.Enabled := (PPage.ActivePage = PagamentoTab) or (PPage.ActivePage = CondicoesTab) or (PPage.ActivePage = AdicionaisTab);
end;

procedure TFAvaliacaoReceber.CarregaFormasPagamento;
begin
  LimpaSQLTabela(FORMAPAGAMENTO);
  FORMAPAGAMENTO.SQL.Add(
    ' SELECT MOV.I_COD_FRM, ' +
    ' C_NOM_FRM, SUM(MOV.N_VLR_PAR * MOE.N_VLR_DIA) TOTAL, ' +
    ' COUNT(N_VLR_PAR) QDADE , AVG(MOV.N_VLR_PAR * MOE.N_VLR_DIA) MEDIA ' +
    ' FROM MOVCONTASARECEBER AS MOV, CADFORMASPAGAMENTO PAG, ' +
    ' CADCONTASARECEBER CAD, CadMoedas as MOE  ' +
    ' WHERE MOV.I_COD_FRM = PAG.I_COD_FRM ' +
    ' AND MOV.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND MOV.I_EMP_FIL =  CAD.I_EMP_FIL ' +
    ' AND MOV.I_COD_MOE = MOE.I_COD_MOE ' +
    ' AND MOV.I_LAN_REC = CAD.I_LAN_REC ');
  case Tipo.ItemIndex of
    0 : FORMAPAGAMENTO.SQL.Add(' and MOV.D_DAT_PAG IS NULL ' +
                                   ' and MOV.D_DAT_VEN < ''' + DataToStrFormato(AAAAMMDD, Date, '/') + '''');
    1 : FORMAPAGAMENTO.SQL.Add(' and NOT MOV.D_DAT_PAG IS NULL ');
  end;
  if RVencimento.Checked then // VENCIMENTO;
    FORMAPAGAMENTO.SQL.Add(' and MOV.D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD, EDataIni.Date,'/') + '''' + ' and ''' + DataToStrFormato(AAAAMMDD, EDataFim.Date, '/') + ''''  )
    else
    if REmissao.Checked then // EMISSÃO.
      FORMAPAGAMENTO.SQL.Add(' and CAD.D_DAT_EMI between ''' + DataToStrFormato(AAAAMMDD,EDataIni.Date,'/') + '''' + ' and ''' + DataToStrFormato(AAAAMMDD, EDataFim.Date, '/') + ''''  )
      else
      if RPagamento.Checked then  // PAGAMENTO.
        FORMAPAGAMENTO.SQL.Add(' and MOV.D_DAT_PAG between ''' + DataToStrFormato(AAAAMMDD,EDataIni.Date,'/') + '''' +  ' and ''' + DataToStrFormato(AAAAMMDD, EDataFim.Date, '/') + ''''  );
   if (ECliente.Text <> '') then
     FORMAPAGAMENTO.SQL.Add(' and CAD.I_COD_CLI = ' + ECliente.Text );
  FORMAPAGAMENTO.SQL.Add(' GROUP BY MOV.I_COD_FRM, C_NOM_FRM ' +
                         ' ORDER BY MOV.I_COD_FRM ');
  AbreTabela(FORMAPAGAMENTO);
end;

procedure TFAvaliacaoReceber.CarregaCondPagamento;
begin
  LimpaSQLTabela(CONDICOES);
  CONDICOES.SQL.Add(
    ' SELECT CAD.I_COD_PAG, C_NOM_PAG, SUM(MOV.N_VLR_PAR * MOE.N_VLR_DIA) TOTAL, ' +
    ' COUNT(MOV.N_VLR_PAR) QDADE, AVG(MOV.N_VLR_PAR * MOE.N_VLR_DIA) MEDIA ' +
    ' FROM  MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, ' +
    ' CADCONDICOESPAGTO PAG, CadMoedas as MOE ' +
    ' WHERE CAD.I_LAN_REC = MOV.I_LAN_REC ' +
    ' AND CAD.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
    ' AND MOV.I_COD_MOE = MOE.I_COD_MOE ' +
    ' AND CAD.I_COD_PAG = PAG.I_COD_PAG ');
  case Tipo.ItemIndex of
    0 : CONDICOES.SQL.Add(' and MOV.D_DAT_PAG IS NULL ' +
                                   ' and MOV.D_DAT_VEN < ''' + DataToStrFormato(AAAAMMDD, Date, '/') + '''');
    1 : CONDICOES.SQL.Add(' and NOT MOV.D_DAT_PAG IS NULL ');
  end;
  if RVencimento.Checked then // VENCIMENTO;
    CONDICOES.SQL.Add(' and MOV.D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD, EDataIni.Date,'/') + '''' + ' and ''' + DataToStrFormato(AAAAMMDD, EDataFim.Date, '/') + ''''  )
    else
    if REmissao.Checked then // EMISSÃO.
      CONDICOES.SQL.Add(' and CAD.D_DAT_EMI between ''' + DataToStrFormato(AAAAMMDD,EDataIni.Date,'/') + '''' + ' and ''' + DataToStrFormato(AAAAMMDD, EDataFim.Date, '/') + ''''  )
      else
      if RPagamento.Checked then  // PAGAMENTO.
        CONDICOES.SQL.Add(' and MOV.D_DAT_PAG between ''' + DataToStrFormato(AAAAMMDD,EDataIni.Date,'/') + '''' +  ' and ''' + DataToStrFormato(AAAAMMDD, EDataFim.Date, '/') + ''''  );
   if (ECliente.Text <> '') then
     CONDICOES.SQL.Add(' and CAD.I_COD_CLI = ' + ECliente.Text );
  CONDICOES.SQL.Add(' GROUP BY CAD.I_COD_PAG, C_NOM_PAG ' +
                         ' ORDER BY CAD.I_COD_PAG ');
  AbreTabela(CONDICOES);
end;

procedure TFAvaliacaoReceber.CarregaAdicionais;
begin
end;

procedure TFAvaliacaoReceber.MovParcelasDIAS_PAGOSGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if MovParcelasDIAS_PAGOS.AsInteger > 0 then
    Text := IntToStr(MovParcelasDIAS_PAGOS.AsInteger)
  else
    Text := '';
end;

procedure TFAvaliacaoReceber.MovParcelasDIAS_VENCIDOSGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if (MovParcelasDIAS_VENCIDOS.AsInteger > 0) then
    Text := IntToStr(MovParcelasDIAS_VENCIDOS.AsInteger)
  else
    Text := '';
end;

procedure TFAvaliacaoReceber.ReceberGridKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Key = #13 then
     Detalhes.Visible := True;
end;

procedure TFAvaliacaoReceber.CarregaTextoImprimir(Texto: TStringList);
var
   VpfLaco : Integer;
begin
  InicializaTString(Texto, 120, '');
  for VpfLaco :=0 to (ComponentCount -1) do
    if ((Components[VpfLaco] is TLabel) and (Components[VpfLaco].Tag > 0)) then
      InsereTString(Texto, (Components[VpfLaco].Tag), ((Components[VpfLaco] as TLabel).Caption));
end;

procedure TFAvaliacaoReceber.BGraficosClick(Sender: TObject);
begin
  CarregaVariaveisGrafico;
end;

procedure TFAvaliacaoReceber.CarregaVariaveisGrafico;
begin
  if (PPage.ActivePage = PagamentoTab) then
  begin
    Graficostrio.info.ComandoSQL := FORMAPAGAMENTO.SQL.Text ;
    Graficostrio.info.CampoRotulo := 'C_NOM_FRM';
    Graficostrio.info.CampoValor := 'TOTAL';
    Graficostrio.info.TituloGrafico := ' Avaliação por Forma de Pagamento  ';
    Graficostrio.info.TituloY := 'valor';
    Graficostrio.info.TituloX := 'Forma de Pagamento';
  end
  else
    if (PPage.ActivePage = CondicoesTab) then
    begin
      Graficostrio.info.ComandoSQL := CONDICOES.SQL.Text ;
      Graficostrio.info.CampoRotulo := 'C_NOM_PAG';
      Graficostrio.info.CampoValor := 'TOTAL';
      Graficostrio.info.TituloGrafico := ' Avaliação por Condições de Pagamento  ';
      Graficostrio.info.TituloY := 'Condição de Pagamento';
      Graficostrio.info.TituloX := 'Data';
    end
    else
    begin
      Graficostrio.info.ComandoSQL := ADICIONAIS.SQL.Text ;
      Graficostrio.info.CampoRotulo := 'C_NOM_PLA';
      Graficostrio.info.CampoValor := 'RECEBER';
      Graficostrio.info.TituloGrafico := '  Avaliação por Adicionais Recebidos  ';
      Graficostrio.info.TituloY := 'valor';
      Graficostrio.info.TituloX := 'Plano de Contas';
    end;
  Graficostrio.info.RodapeGrafico := 'Empresa : ' + Varia.NomeEmpresa +
    ' - Filial : ' + Varia.NomeFilial + '    - Período de ' +
    DateToStr(EDataIni.Date) + ' à ' + DateToStr(EDataFim.Date);
  Graficostrio.info.TituloFormulario := 'Gráfico de Avaliação';
//  Self.Visible := false;
  Graficostrio.Execute;
//  Self.Visible := true;
end;

Initialization
  RegisterClasses([TFAvaliacaoReceber]);
end.


