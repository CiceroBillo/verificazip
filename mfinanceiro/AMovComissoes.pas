unit AMovComissoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, Componentes1, ExtCtrls,
  PainelGradiente, Buttons, StdCtrls, ComCtrls, Localizacao, BotaoCadastro,
  Mask, numericos, DBKeyViolation, UnComissoes, DBCtrls,UnAtualizacao, FMTBcd,
  SqlExpr, DBClient,RpDefine, RpBase, RpSystem,RPDevice, RpCon, RpConDS, RpRave,
  RpRender, RpRenderHTML, RpRenderPDF, UnSistema;

type
  TFMovComissoes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    MovComissoes: TSQL;
    DataMovComissoes: TDataSource;
    ECodVendedor: TEditLocaliza;
    Localiza: TConsultaPadrao;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    LNomVendedor: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    PanelColor4: TPanelColor;
    ETotalPeriodo: Tnumerico;
    ETotalPagarLiberadas: Tnumerico;
    ETotalPagas: Tnumerico;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Aux: TSQL;
    Tempo: TPainelTempo;
    BEstornaPagamento: TBitBtn;
    BPagamento: TBitBtn;
    BEstornaLibera: TBitBtn;
    BLiberaCom: TBitBtn;
    SelcaoInteira: TRadioButton;
    ApenasReg: TRadioButton;
    ETotal_Pagar: Tnumerico;
    Label9: TLabel;
    CVencimento: TComboBoxColor;
    CSituacaoComissao: TComboBoxColor;
    BImprimir: TBitBtn;
    GComissoes: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    Label1: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    BAlteraVendedor: TBitBtn;
    BAlteraPercentual: TBitBtn;
    BExportar: TBitBtn;
    Vendedores: TSQLQuery;
    BMostrarConta: TSpeedButton;
    ENovoVendedor: TEditLocaliza;
    Label3: TLabel;
    ENota: Tnumerico;
    RvSystem: TRvSystem;
    Rave: TRvProject;
    rvComissoes: TRvDataSetConnection;
    MovComissoesI_EMP_FIL: TFMTBCDField;
    MovComissoesI_LAN_CON: TFMTBCDField;
    MovComissoesI_COD_VEN: TFMTBCDField;
    MovComissoesD_DAT_VEN: TSQLTimeStampField;
    MovComissoesD_DAT_PAG: TSQLTimeStampField;
    MovComissoesD_DAT_VAL: TSQLTimeStampField;
    MovComissoesN_VLR_COM: TFMTBCDField;
    MovComissoesI_NRO_PAR: TFMTBCDField;
    MovComissoesI_LAN_REC: TFMTBCDField;
    MovComissoesN_PER_COM: TFMTBCDField;
    MovComissoesL_OBS_COM: TWideStringField;
    MovComissoesD_DAT_EMI: TSQLTimeStampField;
    MovComissoesC_NOM_VEN: TWideStringField;
    MovComissoesI_NRO_NOT: TFMTBCDField;
    MovComissoesN_VLR_TOT: TFMTBCDField;
    MovComissoesC_NRO_DUP: TWideStringField;
    MovComissoesI_COD_CLI: TFMTBCDField;
    MovComissoesC_NOM_CLI: TWideStringField;
    MovComissoesN_VLR_PAR: TFMTBCDField;
    PDF: TRvRenderPDF;
    ECliente: TRBEditLocaliza;
    Label11: TLabel;
    Label12: TLabel;
    SpeedButton2: TSpeedButton;
    EDuplicata: TEditColor;
    Label13: TLabel;
    MovComissoesD_PAG_REC: TSQLTimeStampField;
    MovComissoesN_BAS_PRO: TFMTBCDField;
    MovComissoesD_DAT_EMI_1: TSQLTimeStampField;
    MovComissoesC_NUM_PED: TWideStringField;
    MovComissoesI_LAN_ORC: TFMTBCDField;
    COcultarValorZerado: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure BEstornaPagamentoClick(Sender: TObject);
    procedure BLiberaComClick(Sender: TObject);
    procedure BEstornaLiberaClick(Sender: TObject);
    procedure MovComissoesAfterScroll(DataSet: TDataSet);
    procedure BImprimirClick(Sender: TObject);
    procedure BAlteraVendedorClick(Sender: TObject);
    procedure BAlteraPercentualClick(Sender: TObject);
    procedure BExportarClick(Sender: TObject);
    procedure BMostrarContaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GComissoesOrdem(Ordem: String);
    procedure ENotaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EClienteFimConsulta(Sender: TObject);
    procedure COcultarValorZeradoClick(Sender: TObject);
  private
    FunCom : TFuncoesComissao;
    VprPressionadoR : Boolean;
    VprOrdem : String;
    procedure AtualizaConsulta(VpaPosicionar : Boolean);
    procedure AdicionaFiltros(VpaSelect : TStrings);
    function RValTotalComissoes : Double;
    function RValComissoesPagas : Double;
    function RValComissoesLiberadas : Double;
    procedure InicializaTela;
    procedure CalculaValores;
    function PagaComissao(VpaOperacao : Integer) : boolean;
    procedure EnviaParametros;
    procedure InicializaRave;
    procedure EnviaEmail(VpaNomVendedor,VpaDesEmail, VpaNomArquivo : String);
  public
    procedure MostraComissoes(VpaDatInicio, VpaDatFim : TdateTime );
  end;

var
  FMovComissoes: TFMovComissoes;

implementation

uses
   APrincipal, funstring, fundata, constantes,
   Constmsg, funsql ;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMovComissoes.FormCreate(Sender: TObject);
begin
  VprPressionadoR := false;
  FunCom := TFuncoesComissao.cria(FPrincipal.BaseDados);
  InicializaTela;
  VprOrdem := 'order by CV.C_NOM_VEN ';
  AtualizaConsulta(false);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMovComissoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 MovComissoes.close;
 FunCom.free;
 Action := CaFree;
end;

{************* rotina para chamada da  externas **************************** }
procedure TFMovComissoes.MostraComissoes(VpaDatInicio, VpaDatFim : TdateTime );
begin
  InicializaTela;
  EDatInicio.DateTime := VpaDatInicio;
  EDatFim.DateTime := VpaDatFim;
  AtualizaConsulta(false);
  ShowModal;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Rotinas diveras
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMovComissoes.BitBtn1Click(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMovComissoes.EClienteFimConsulta(Sender: TObject);
begin
  AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFMovComissoes.EDatInicioCloseUp(Sender: TObject);
begin
  AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFMovComissoes.ENotaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if KEY = 13 then
    AtualizaConsulta(false);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Rotinas de filtro das comissoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMovComissoes.AtualizaConsulta(VpaPosicionar : Boolean);
var
  VpfPosicao : tbookmark;
begin
  VpfPosicao := MovComissoes.GetBookmark;
  MovComissoes.Close;
  MovComissoes.Sql.Clear;
  MovComissoes.Sql.add(' Select MOC.I_EMP_FIL, MOC.I_COD_VEN, MOC.D_DAT_VEN, MOC.D_DAT_PAG, MOC.D_DAT_VAL, MOC.N_VLR_COM, ' +
                                ' MOC.I_NRO_PAR, MOC.I_LAN_REC, CV.C_NOM_VEN, CAR.I_NRO_NOT, CAR.N_VLR_TOT, '+
                                ' MOC.I_LAN_CON, MOC.D_PAG_REC, MOC.N_BAS_PRO, ' +
                                ' MOC.N_PER_COM, MOC.L_OBS_COM, MOC.D_DAT_EMI, CAR.D_DAT_EMI,'+
                                ' MOV.C_NRO_DUP, MOV.N_VLR_PAR, ' +
                                ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  ' +
                                ' NOTA.C_NUM_PED, NOTA.I_LAN_ORC ' );
  MovComissoes.Sql.add(' from MovComissoes MOC, CadVendedores CV, CadContasaReceber CAR, CADCLIENTES CLI, MOVCONTASARECEBER MOV, CADNOTAFISCAIS NOTA' +
                                   ' where MOC.I_COD_VEN = CV.I_COD_VEN ' +
                                   ' and MOC.I_EMP_FIL = CAR.I_EMP_FIL ' +
                                   ' and MOC.I_LAN_REC = CAR.I_LAN_REC ' +
                                   ' and CAR.I_COD_CLI  = CLI.I_COD_CLI'+
                                   ' and MOC.I_EMP_FIL = MOV.I_EMP_FIL '+
                                   ' and MOC.I_LAN_REC = MOV.I_LAN_REC '+
                                   ' and MOC.I_NRO_PAR = MOV.I_NRO_PAR ' +
                                   ' AND ' + SQLTextoRightJoin('CAR.I_SEQ_NOT', 'NOTA.I_SEQ_NOT') +
                                   ' AND ' + SQLTextoRightJoin('CAR.I_EMP_FIL', 'NOTA.I_EMP_FIL'));
  AdicionaFiltros(MovComissoes.sql);
  MovComissoes.Sql.add(VprOrdem);
  Movcomissoes.open;
  if VpaPosicionar then
  begin
    try
      MovComissoes.GotoBookmark(VpfPosicao)
    except
    end;
  end;
  MovComissoes.FreeBookmark(VpfPosicao);
  GComissoes.ALinhaSQLOrderBy := MovComissoes.SQL.count - 1;
  CalculaValores;
end;

{******************************************************************************}
procedure TFMovComissoes.AdicionaFiltros(VpaSelect : TStrings);
begin
  VpaSelect.add('AND MOC.i_emp_fil = ' + IntToStr(varia.codigoEmpfil));
  case CVencimento.ItemIndex of    // tipo de data
    0 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('MOC.D_DAT_VEN', EDatInicio.DateTime, EDatFim.DateTime, true));
    1 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('MOC.D_DAT_VAL', EDatInicio.DateTime, EDatFim.DateTime, true));
    2 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('MOC.D_DAT_PAG', EDatInicio.DateTime, EDatFim.DateTime, true));
    3 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('MOC.D_DAT_EMI', EDatInicio.DateTime, EDatFim.DateTime, true));
    4 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('MOC.D_PAG_REC', EDatInicio.DateTime, EDatFim.DateTime, true));
  end;

  case CSituacaoComissao.ItemIndex of
    0 : VpaSelect.add(' and MOC.d_dat_pag is not null ');
    1 : VpaSelect.add(' and MOC.d_dat_pag is null ');
    2 : VpaSelect.add(' and MOC.d_dat_pag is null and MOC.D_DAT_VAL is not null');
    3 : VpaSelect.add(' and MOC.d_dat_pag is null and MOC.D_DAT_VAL is null');
  end;

  if ECodVendedor.AInteiro <> 0 then      // vendedor
    VpaSelect.Add(' and MOC.I_COD_VEN =' + ECodVendedor.Text);
  if ENota.AsINteger <> 0  then
    VpaSelect.Add(' and CAR.I_NRO_NOT = '+Enota.Text);
  if not BMostrarConta.Visible then
    VpaSelect.Add(' and MOV.C_IND_CAD = ''N''');
  if ECliente.AInteiro <> 0  then
    VpaSelect.Add(' and CAR.I_COD_CLI = '+ECliente.Text);
  if EDuplicata.Text <> '' then
    VpaSelect.Add(' and MOV.C_NRO_DUP = '''+EDuplicata.Text+'''');
  if COcultarValorZerado.Checked then
    VpaSelect.Add(' and MOC.N_VLR_COM <> 0 ');
end;

{******************************************************************************}
function TFMovComissoes.RValTotalComissoes : Double;
begin
  Aux.close;
  Aux.Sql.Clear;
  Aux.Sql.add('Select sum(N_VLR_COM) VALOR from MOVCOMISSOES MOC,CadContasaReceber CAR, MOVCONTASARECEBER MOV '+
              'Where MOC.I_EMP_FIL = CAR.I_EMP_FIL '+
              ' and MOC.I_LAN_REC = CAR.I_LAN_REC '+
              ' and MOC.I_EMP_FIL = MOV.I_EMP_FIL '+
              ' and MOC.I_LAN_REC = MOV.I_LAN_REC '+
              ' and MOC.I_NRO_PAR = MOV.I_NRO_PAR ');
  AdicionaFiltros(Aux.sql);
  Aux.open;
  result := Aux.FieldByname('VALOR').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFMovComissoes.RValComissoesPagas : Double;
begin
  Aux.Sql.Clear;
  Aux.Sql.add('Select sum(N_VLR_COM) VALOR from MOVCOMISSOES MOC,CadContasaReceber CAR, MOVCONTASARECEBER MOV '+
              'Where MOC.D_DAT_PAG IS NOT NULL '+
              ' and MOC.I_EMP_FIL = CAR.I_EMP_FIL ' +
              ' and MOC.I_LAN_REC = CAR.I_LAN_REC '+
              ' and MOC.I_EMP_FIL = MOV.I_EMP_FIL '+
              ' and MOC.I_LAN_REC = MOV.I_LAN_REC '+
              ' and MOC.I_NRO_PAR = MOV.I_NRO_PAR ');
  AdicionaFiltros(Aux.sql);
  Aux.open;
  result := Aux.FieldByname('VALOR').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFMovComissoes.RValComissoesLiberadas : Double;
begin
  Aux.Sql.Clear;
  Aux.Sql.add('Select sum(N_VLR_COM) VALOR from MOVCOMISSOES MOC,CadContasaReceber CAR, MOVCONTASARECEBER MOV '+
              ' Where MOC.D_DAT_PAG IS NULL ' +
              ' and MOC.D_DAT_VAL IS NOT NULL '+
              ' and MOC.I_EMP_FIL = CAR.I_EMP_FIL ' +
              ' and MOC.I_LAN_REC = CAR.I_LAN_REC '+
              ' and MOC.I_EMP_FIL = MOV.I_EMP_FIL '+
              ' and MOC.I_LAN_REC = MOV.I_LAN_REC '+
              ' and MOC.I_NRO_PAR = MOV.I_NRO_PAR ');
    AdicionaFiltros(Aux.sql);
  Aux.open;
  result := Aux.FieldByname('VALOR').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
procedure TFMovComissoes.InicializaTela;
begin
   EDatInicio.Date := PrimeiroDiaMes(date);
   EDatFim.Date := UltimoDiaMes(date);

   case Varia.TipComissao of
     0 :
       begin
         CVencimento.ItemIndex := 3;
         VprOrdem := 'order by MOC.D_DAT_EMI';
       end;
     1 :
       begin
         CVencimento.ItemIndex := 0;
         VprOrdem := 'order by MOC.D_DAT_VEN';
       end;
     2 :
       begin
         CVencimento.ItemIndex := 1;
         VprOrdem := 'order by MOC.D_DAT_VAL';
       end;
     3 :
       begin
         CVencimento.ItemIndex := 4;
         VprOrdem := 'order by MOC.D_REC_PAR';
       end;
   end;
   CSituacaoComissao.ItemIndex := 4;
{   FPrincipal.ValidaBotoesGrupos([ BPagamento, BEstornaPagamento,
                                   BLiberaCom, BEstornaLibera,
                                   BExcluir,   BotaoCadastrar1]);}
end;

{******************* calcula os valores **************************************** }
procedure TFMovComissoes.CalculaValores;
begin
  ETotalPeriodo.AValor := RValTotalComissoes;
  ETotalPagas.AValor := RValComissoesPagas;
  ETotal_Pagar.AValor := ETotalPeriodo.AValor - ETotalPagas.AValor;
  ETotalPagarLiberadas.AValor  := RValComissoesLiberadas;
end;

procedure TFMovComissoes.COcultarValorZeradoClick(Sender: TObject);
begin
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      chamadas dos botoes inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************  efetua o pagamento das comissoes ************************ }
procedure TFMovComissoes.BPagamentoClick(Sender: TObject);
begin
  if PagaComissao(1) then
    AtualizaConsulta(true);
end;

{ ********************* estorna os pagamentos das comissoes ***************** }
procedure TFMovComissoes.BEstornaPagamentoClick(Sender: TObject);
begin
  if PagaComissao(2) then
    AtualizaConsulta(true);
end;


{ ******************************  libera a comissao ************************ }
procedure TFMovComissoes.BLiberaComClick(Sender: TObject);
begin
  if PagaComissao(3) then
    AtualizaConsulta(true);
end;

{ ****************  estorna a liberacao de uma comisso ********************** }
procedure TFMovComissoes.BEstornaLiberaClick(Sender: TObject);
begin
  if PagaComissao(4) then
    AtualizaConsulta(true);
end;

{******************************************************************************}
procedure TFMovComissoes.MovComissoesAfterScroll(DataSet: TDataSet);
begin
  // Libera a comissão.
  BLiberaCom.Enabled :=
    not MovComissoes.EOF
    and (not MovComissoesD_DAT_VEN.IsNull)
    and MovComissoesD_DAT_VAL.IsNull
    and MovComissoesD_DAT_PAG.IsNull;
  // Estorna a liberação da comissão.
  BEstornaLibera.Enabled :=
    not MovComissoes.EOF
    and (not MovComissoesD_DAT_VEN.IsNull)
    and (not MovComissoesD_DAT_VAL.IsNull)
    and MovComissoesD_DAT_PAG.IsNull;
  // Efetua o pagamento da comissão.
  BPagamento.Enabled :=
    not MovComissoes.EOF
    and (not MovComissoesD_DAT_VEN.IsNull)
    and (not MovComissoesD_DAT_VAL.IsNull)
    and MovComissoesD_DAT_PAG.IsNull;
  // Estorna o pagamento da comissão.
  BEstornaPagamento.Enabled :=
    not MovComissoes.EOF
    and (not MovComissoesD_DAT_PAG.IsNull);
  // Excluir a comissão.
end;

{******************************************************************************}
function TFMovComissoes.PagaComissao(VpaOperacao : Integer) : boolean; //operacao 1 = Paga comissao;2 = extorna baixa
var                                                                    //         3 = Libera comissao;
   VpfResultado : String;
   VpfData : TDateTime;
   VpfPosicao : TBookmark;
begin
  VpfData := Date;
  VpfResultado := '';
  result := true;
  if VpaOperacao in [1,3] then
    result := EntraData('Data de Pagamento','Data Pagamento : ',VpfData);
  if result then
  begin
    if ApenasReg.Checked then
    begin
      case VpaOperacao of
        1 : VpfResultado := FunCom.EfetuaBaixaPagamento(MovComissoesI_EMP_FIL.AsInteger,MovComissoesI_LAN_CON.AsInteger,VpfData);
        2 : VpfResultado := FunCom.EstornaBaixaPagamento(MovComissoesI_EMP_FIL.AsInteger,MovComissoesI_LAN_CON.AsInteger);
        3 : VpfResultado := FunCom.EfetuaLiberacao(MovComissoesI_EMP_FIL.AsInteger,MovComissoesI_LAN_CON.AsInteger,VpfData);
        4 : VpfResultado := FunCom.EstornaLiberacao(MovComissoesI_EMP_FIL.AsInteger,MovComissoesI_LAN_CON.AsInteger);
      end;
    end
    else
    begin
      VpfPosicao := MovComissoes.GetBookmark;
      MovComissoes.first;
      while not MovComissoes.eof and (VpfResultado = '') do
      begin
        case VpaOperacao of
          1 :
            begin
              if not(MovComissoesD_DAT_VAL.IsNull) and (MovComissoesD_DAT_PAG.IsNull) then
                VpfResultado := FunCom.EfetuaBaixaPagamento(MovComissoesI_EMP_FIL.AsInteger,MovComissoesI_LAN_CON.AsInteger,VpfData);
            end;
          2 :
            begin
              if not(MovComissoesD_DAT_PAG.IsNull) then
                VpfResultado := FunCom.EstornaBaixaPagamento(MovComissoesI_EMP_FIL.AsInteger,MovComissoesI_LAN_CON.AsInteger);
            end;
          3 :
            begin
              if (MovComissoesD_DAT_VAL.IsNull) then
                VpfResultado := FunCom.EfetuaLiberacao(MovComissoesI_EMP_FIL.AsInteger,MovComissoesI_LAN_CON.AsInteger,VpfData);
            end;
          4 :
            begin
              if not(MovComissoesD_DAT_VAL.IsNull) and (MovComissoesD_DAT_PAG.IsNull) then
                VpfResultado := FunCom.EstornaLiberacao(MovComissoesI_EMP_FIL.AsInteger,MovComissoesI_LAN_CON.AsInteger);
            end;
        end;
        MovComissoes.next;
      end;
      MovComissoes.GotoBookmark(VpfPosicao);
    end;
  end;
  if VpfResultado <> '' then
  begin
    Aviso(VpfResultado);
    result := false;
  end;
end;

{******************************************************************************}
procedure TFMovComissoes.EnviaParametros;
begin
  Rave.clearParams;
  Rave.SetParam('VENDEDOR',LNomVendedor.Caption);
  Rave.SetParam('FILIAL',Varia.Nomefilial);
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',EDatInicio.Date)+' até '+FormatDateTime('DD/MM/YYYY',EDatFim.Date));
  Rave.SetParam('SITUACAO',CSituacaoComissao.Text);
  Rave.SetParam('TIPOPERIODO',CVencimento.Text);
end;

{******************************************************************************}
procedure TFMovComissoes.InicializaRave;
begin
  Rave.close;
  Rave.ProjectFile := varia.PathRelatorios+'\Financeiro\XX_COMISSAO.rav';
  EnviaParametros;
end;

{******************************************************************************}
procedure TFMovComissoes.EnviaEmail(VpaNomVendedor,VpaDesEmail, VpaNomArquivo : String);
begin


end;

{******************************************************************************}
procedure TFMovComissoes.BAlteraVendedorClick(Sender: TObject);
begin
  if Confirmacao(CT_AlteraVendedor) then
  begin
    IF ENovoVendedor.AAbreLocalizacao then
    begin
      FunCom.AlteraVendedor(ENovoVendedor.AInteiro,MovComissoesI_EMP_FIL.AsInteger,MovComissoesI_LAN_CON.AsInteger);
      AtualizaConsulta(true);
    end;
 end;
end;

{******************************************************************************}
procedure TFMovComissoes.BAlteraPercentualClick(Sender: TObject);
var
  VpfValor : String;
begin
  VpfValor := MovComissoesN_PER_COM.AsString;
  if EntradaNumero('Novo Percentual','Digite o Novo Percentual',VpfValor,false,FPrincipal.CorFoco.ACorFundoFoco,
                     FPrincipal.CorForm.ACorPainel, false) then
  begin
    FunCom.AlterarPerComissao(MovComissoesI_EMP_FIL.AsInteger,MovComissoesI_LAN_CON.AsInteger,MovComissoesI_LAN_REC.AsInteger,MovComissoesI_NRO_PAR.AsInteger,StrToFloat(VpfValor));
    AtualizaConsulta(true);
  end;
end;

{******************************************************************************}
procedure TFMovComissoes.BExportarClick(Sender: TObject);
Var
  VpfLaco : Integer;
  VpfOrdem,VpfNomArquivo,VpfCorpoEmail,VpfResultado : String;
begin
  Vendedores.Sql.Clear;
  Vendedores.Sql.add('Select * from CADVENDEDORES '+
                     ' Where C_DES_EMA IS NOT NULL');
  if ECodVendedor.Text <> '' then
    Vendedores.Sql.Add('and I_COD_VEN = '+ECodVendedor.TEXT)
  else
    Vendedores.Sql.Add(' and C_IND_ATI = ''S''');

  Vendedores.Open;
  VpfOrdem := VprOrdem;
  VprOrdem := 'order by MOV.C_NRO_DUP';
  While not Vendedores.Eof do
  begin
    ECodVendedor.text := Vendedores.FieldByName('I_COD_VEN').AsString;
    AtualizaConsulta(false);
    if MovComissoes.RecordCount > 0 then
    begin
      VpfNomArquivo := Vendedores.FieldByName('I_COD_VEN').AsString+'.pdf';
      InicializaRave;
      rvSystem.DefaultDest := rdFile;
      rvSystem.DoNativeOutput := false;
      rvSystem.RenderObject := Pdf;
      rvSystem.OutputFileName := VpfNomArquivo;
      Rave.execute;
      VpfCorpoEmail := '<html><body>Prezado(a) <b>'+ Vendedores.FieldByName('C_NOM_VEN').AsString+
                       '</b>,<br><br>Segue anexo relatório de comissões'+
                        '<br><br><hr> <center><address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>'+
                       '</center></body></html>';
      VpfResultado := Sistema.EnviaEmail(Vendedores.FieldByName('C_DES_EMA').AsString,'Relatório Comissões ('+FormatDatetime('DD/MM/YY',EDatInicio.Date)+'-'+ FormatDatetime('DD/MM/YY',EDatFim.Date)+')',
                      VpfCorpoEmail,VpfNomArquivo);
      if FileExists(VpfNomArquivo) then
        DeleteFile(VpfNomArquivo);
      if VpfResultado <> '' then
        aviso(VpfResultado);
    end;
    Vendedores.Next;
  end;
  Vendedores.close;
  VprOrdem := VpfOrdem;
  ECodVendedor.Clear;
  AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFMovComissoes.BMostrarContaClick(Sender: TObject);
begin
  BMostrarConta.visible := false;
end;

{******************************************************************************}
procedure TFMovComissoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
      begin
        if (key = 77) then
        begin
          BMostrarConta.Visible := true;
          AtualizaConsulta(false);
        end;
        VprPressionadoR := false;
      end;
  end;
end;

{******************************************************************************}
procedure TFMovComissoes.GComissoesOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFMovComissoes.BImprimirClick(Sender: TObject);
begin
  SubstituiLinhaSQL(MovComissoes, MovComissoes.sql.count-1,' order by CV.C_NOM_VEN,MOC.C_IND_DEV DESC, MOV.C_NRO_DUP');
  MovComissoes.close;
  MovComissoes.open;
  InicializaRave;
  rvSystem.DefaultDest := rdPreview;
  Rave.execute;
  Rave.close;
  SubstituiLinhaSQL(MovComissoes, MovComissoes.sql.count-1,VprOrdem);
  MovComissoes.close;
  MovComissoes.open;
end;


Initialization
 RegisterClasses([TFMovComissoes]);
end.
