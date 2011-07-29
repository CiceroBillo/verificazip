unit ANovoGrupo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Tabela,
  DBKeyViolation, StdCtrls, Mask, DBCtrls, BotaoCadastro, Buttons, ComCtrls,
  DBClient, Localizacao, Grids, CGrades, UnDadosCR, unDados, UnDAdosLocaliza, unContasAReceber,
  UnProposta;

type
  TFNovoGrupo = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEditColor2: TDBEditColor;
    ECodFilial: TDBEditColor;
    CadGrupos: TSQL;
    CadGruposI_EMP_FIL: TFMTBCDField;
    CadGruposI_COD_GRU: TFMTBCDField;
    CadGruposC_NOM_GRU: TWideStringField;
    CadGruposD_ULT_ALT: TSQLTimeStampField;
    DataCadGrupos: TDataSource;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    CadGruposC_ADM_SIS: TWideStringField;
    CadGruposC_FIN_COM: TWideStringField;
    CadGruposC_EST_COM: TWideStringField;
    CadGruposC_POL_COM: TWideStringField;
    CadGruposC_FAT_COM: TWideStringField;
    CadGruposC_FIN_CCR: TWideStringField;
    CadGruposC_FIN_BCR: TWideStringField;
    CadGruposC_FIN_CCP: TWideStringField;
    CadGruposC_FIN_BCP: TWideStringField;
    CadGruposC_POL_IPP: TWideStringField;
    CadGruposC_GER_COC: TWideStringField;
    CadGruposC_GER_MPR: TWideStringField;
    CadGruposC_POL_CCO: TWideStringField;
    CadGruposC_POL_ACO: TWideStringField;
    CadGruposC_POL_VCO: TWideStringField;
    CadGruposC_POL_ICO: TWideStringField;
    CadGruposC_POL_CGN: TWideStringField;
    CadGruposC_POL_CGC: TWideStringField;
    CadGruposC_GER_MCP: TWideStringField;
    CadGruposC_GER_MCC: TWideStringField;
    CadGruposC_GER_MCS: TWideStringField;
    CadGruposC_GER_IMP: TWideStringField;
    CadGruposC_GER_REL: TWideStringField;
    CadGruposC_POL_UTE: TWideStringField;
    CadGruposC_POL_STE: TWideStringField;
    CadGruposC_GER_SPA: TWideStringField;
    CadGruposC_GER_SMP: TWideStringField;
    CadGruposC_GER_PRV: TWideStringField;
    CadGruposC_GER_PRC: TWideStringField;
    CadGruposC_EST_COP: TWideStringField;
    CadGruposC_FAT_MNO: TWideStringField;
    CadGruposC_FAT_GNO: TWideStringField;
    CadGruposC_EST_AOP: TWideStringField;
    CadGruposC_EST_EOP: TWideStringField;
    CadGruposC_CHA_COM: TWideStringField;
    CadGruposC_CHA_CBA: TWideStringField;
    CadGruposC_CHA_CAC: TWideStringField;
    CadGruposC_CHA_COC: TWideStringField;
    CadGruposC_CHA_GEC: TWideStringField;
    CadGruposC_CHA_ATC: TWideStringField;
    CadGruposC_CHA_ACF: TWideStringField;
    CadGruposC_POL_ECO: TWideStringField;
    CadGruposC_POL_AEF: TWideStringField;
    CadGruposC_EST_ROM: TWideStringField;
    CadGruposC_EST_CFA: TWideStringField;
    CadGruposC_EST_AFF: TWideStringField;
    CadGruposC_EST_CFF: TWideStringField;
    CadGruposC_EST_EFF: TWideStringField;
    CadGruposC_EST_ARF: TWideStringField;
    CadGruposC_EST_CRF: TWideStringField;
    CadGruposC_EST_ERF: TWideStringField;
    CadGruposC_IND_PER: TWideStringField;
    CadGruposC_RES_LEL: TWideStringField;
    CadGruposC_FIN_CPO: TWideStringField;
    CadGruposC_CRM_COM: TWideStringField;
    CadGruposC_IND_SCV: TWideStringField;
    CadGruposC_POL_CAC: TWideStringField;
    CadGruposC_FIN_ECO: TWideStringField;
    CadGruposC_POL_ATC: TWideStringField;
    CadGruposC_EST_CNF: TWideStringField;
    CadGruposC_EST_MNF: TWideStringField;
    CadGruposC_EST_IEP: TWideStringField;
    CadGruposC_CRM_SPV: TWideStringField;
    CadGruposC_EST_PEC: TWideStringField;
    CadGruposC_FIN_BCL: TWideStringField;
    CadGruposC_GER_VAC: TWideStringField;
    CadGruposC_EST_SCO: TWideStringField;
    CadGruposC_POL_PIP: TWideStringField;
    CadGruposC_POL_IVP: TWideStringField;
    PanelColor4: TPanelColor;
    PageControl1: TPageControl;
    PGeral: TTabSheet;
    CAdministrador: TDBCheckBox;
    CConsultaCliente: TDBCheckBox;
    CManutencaoProdutos: TDBCheckBox;
    CProdutoCompleto: TDBCheckBox;
    CServicoCompleto: TDBCheckBox;
    CImpressao: TDBCheckBox;
    CClienteCompleto: TDBCheckBox;
    CRelatorios: TDBCheckBox;
    CSomenteProdutos: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox34: TDBCheckBox;
    DBCheckBox35: TDBCheckBox;
    DBCheckBox38: TDBCheckBox;
    DBCheckBox48: TDBCheckBox;
    PFinanceiro: TTabSheet;
    CCompletoFinanceiro: TDBCheckBox;
    CCadastrarCR: TDBCheckBox;
    CBaixarCR: TDBCheckBox;
    CCadastrarCP: TDBCheckBox;
    CBaixarCP: TDBCheckBox;
    DBCheckBox36: TDBCheckBox;
    DBCheckBox40: TDBCheckBox;
    DBCheckBox47: TDBCheckBox;
    PPontodeLoja: TTabSheet;
    CCompletoPontoLoja: TDBCheckBox;
    CImprimirPedPendentes: TDBCheckBox;
    CCadastraCotacao: TDBCheckBox;
    CConsultaCotacao: TDBCheckBox;
    CAlteraCotacao: TDBCheckBox;
    CImprimiCotacao: TDBCheckBox;
    CGerarNota: TDBCheckBox;
    CGerarCupom: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    CUsuarioTelemarketing: TDBCheckBox;
    CSupervisorTelemarketing: TDBCheckBox;
    DBCheckBox15: TDBCheckBox;
    DBCheckBox16: TDBCheckBox;
    DBCheckBox39: TDBCheckBox;
    DBCheckBox41: TDBCheckBox;
    DBCheckBox50: TDBCheckBox;
    DBCheckBox51: TDBCheckBox;
    PFaturamento: TTabSheet;
    CCompletoFaturamento: TDBCheckBox;
    CFatGerarNotaFiscal: TDBCheckBox;
    CFatManutencaoNotas: TDBCheckBox;
    PEstoque: TTabSheet;
    CCompletoEstoque: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox17: TDBCheckBox;
    DBCheckBox18: TDBCheckBox;
    DBCheckBox19: TDBCheckBox;
    DBCheckBox20: TDBCheckBox;
    DBCheckBox21: TDBCheckBox;
    ScrollBox1: TScrollBox;
    PanelColor3: TPanelColor;
    DBCheckBox22: TDBCheckBox;
    DBCheckBox23: TDBCheckBox;
    DBCheckBox24: TDBCheckBox;
    DBCheckBox25: TDBCheckBox;
    DBCheckBox26: TDBCheckBox;
    DBCheckBox27: TDBCheckBox;
    DBCheckBox28: TDBCheckBox;
    DBCheckBox29: TDBCheckBox;
    DBCheckBox30: TDBCheckBox;
    DBCheckBox31: TDBCheckBox;
    DBCheckBox32: TDBCheckBox;
    DBCheckBox33: TDBCheckBox;
    DBCheckBox42: TDBCheckBox;
    DBCheckBox43: TDBCheckBox;
    DBCheckBox44: TDBCheckBox;
    DBCheckBox46: TDBCheckBox;
    DBCheckBox49: TDBCheckBox;
    TabSheet1: TTabSheet;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBCheckBox14: TDBCheckBox;
    PCRM: TTabSheet;
    DBCheckBox37: TDBCheckBox;
    DBCheckBox52: TDBCheckBox;
    CadGruposC_EST_PCO: TWideStringField;
    DBCheckBox53: TDBCheckBox;
    CadGruposC_CRM_CSP: TWideStringField;
    DBCheckBox54: TDBCheckBox;
    DBCheckBox55: TDBCheckBox;
    CadGruposC_EST_CLP: TWideStringField;
    CadGruposC_EST_RPC: TWideStringField;
    DBCheckBox56: TDBCheckBox;
    CadGruposC_EST_ACE: TWideStringField;
    DBCheckBox57: TDBCheckBox;
    DBCheckBox58: TDBCheckBox;
    CadGruposC_EST_APC: TWideStringField;
    CadGruposC_EST_EPC: TWideStringField;
    DBCheckBox59: TDBCheckBox;
    CadGruposC_EST_MGE: TWideStringField;
    DBCheckBox60: TDBCheckBox;
    CadGruposC_EST_OCO: TWideStringField;
    DBCheckBox61: TDBCheckBox;
    CadGruposC_EST_RGP: TWideStringField;
    ECodigo: TDBKeyViolation;
    DBCheckBox62: TDBCheckBox;
    DBCheckBox63: TDBCheckBox;
    CadGruposC_POL_PSP: TWideStringField;
    CadGruposC_POL_PCP: TWideStringField;
    DBCheckBox64: TDBCheckBox;
    CadGruposC_POL_ECP: TWideStringField;
    CadGruposC_FAT_CNO: TWideStringField;
    DBCheckBox65: TDBCheckBox;
    CadGruposC_POL_IPE: TWideStringField;
    CadGruposC_COD_CLA: TWideStringField;
    CadGruposI_COD_FIL: TFMTBCDField;
    Label4: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditLocaliza1: TDBEditLocaliza;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    Label6: TLabel;
    ConsultaPadrao1: TConsultaPadrao;
    PCondicaoPagamento: TTabSheet;
    GCondicaoPagamento: TRBStringGridColor;
    ECondicaoPagamento: TRBEditLocaliza;
    DBCheckBox66: TDBCheckBox;
    CadGruposC_GER_COP: TWideStringField;
    DBCheckBox67: TDBCheckBox;
    CadGruposC_EST_CAC: TWideStringField;
    DBCheckBox68: TDBCheckBox;
    CadGruposC_EST_RES: TWideStringField;
    CadGruposC_EST_CPR: TWideStringField;
    DBCheckBox69: TDBCheckBox;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    PanelColor8: TPanelColor;
    PanelColor9: TPanelColor;
    PanelColor10: TPanelColor;
    DBCheckBox70: TDBCheckBox;
    CadGruposC_GER_ALC: TWideStringField;
    ScrollBox2: TScrollBox;
    DBCheckBox71: TDBCheckBox;
    CadGruposC_EST_INV: TWideStringField;
    DBCheckBox72: TDBCheckBox;
    CadGruposC_EST_FAP: TWideStringField;
    CadGruposC_EST_MAP: TWideStringField;
    CadGruposC_EST_MCP: TWideStringField;
    DBCheckBox73: TDBCheckBox;
    DBCheckBox74: TDBCheckBox;
    CadGruposC_CRM_CAM: TWideStringField;
    DBCheckBox75: TDBCheckBox;
    Label7: TLabel;
    DBEditColor3: TDBEditColor;
    Label8: TLabel;
    CadGruposI_QTD_PAR: TFMTBCDField;
    PEstagios: TTabSheet;
    GEstagios: TRBStringGridColor;
    DBCheckBox76: TDBCheckBox;
    ECodEstagio: TRBEditLocaliza;
    CadGruposC_EST_AUT: TWideStringField;
    DBCheckBox77: TDBCheckBox;
    CadGruposC_EST_CEC: TWideStringField;
    DBCheckBox78: TDBCheckBox;
    CadGruposC_EST_AVN: TWideStringField;
    CadGruposC_EST_SCC: TWideStringField;
    DBCheckBox79: TDBCheckBox;
    DBCheckBox80: TDBCheckBox;
    CadGruposC_EST_CSC: TWideStringField;
    CadGruposC_EST_CPC: TWideStringField;
    DBCheckBox81: TDBCheckBox;
    DBCheckBox82: TDBCheckBox;
    CadGruposC_EST_AOC: TWideStringField;
    DBCheckBox83: TDBCheckBox;
    CadGruposC_GER_APP: TWideStringField;
    CadGruposN_PAR_MIN: TFMTBCDField;
    CadGruposC_PAR_MIN: TWideStringField;
    DBCheckBox84: TDBCheckBox;
    DBEditColor4: TDBEditColor;
    DBCheckBox85: TDBCheckBox;
    CadGruposC_EST_ESR: TWideStringField;
    DBCheckBox86: TDBCheckBox;
    CadGruposC_POL_CTOT: TWideStringField;
    DBCheckBox87: TDBCheckBox;
    CadGruposC_CRM_PRP: TWideStringField;
    DBCheckBox88: TDBCheckBox;
    CadGruposC_EXC_TEL: TWideStringField;
    DBCheckBox45: TDBCheckBox;
    DBCheckBox89: TDBCheckBox;
    CadGruposC_IND_SPV: TWideStringField;
    DBCheckBox90: TDBCheckBox;
    CadGruposC_OCU_VEN: TWideStringField;
    DBCheckBox91: TDBCheckBox;
    DBCheckBox92: TDBCheckBox;
    CadGruposC_POL_CROM: TWideStringField;
    CadGruposC_POL_VROM: TWideStringField;
    ScrollBox3: TScrollBox;
    CadGruposC_CHA_ECH: TWideStringField;
    DBCheckBox93: TDBCheckBox;
    CadGruposC_CRM_APF: TWideStringField;
    DBCheckBox94: TDBCheckBox;
    DBCheckBox95: TDBCheckBox;
    DBCheckBox96: TDBCheckBox;
    CadGruposC_EST_MUP: TWideStringField;
    CadGruposC_EST_BOC: TWideStringField;
    CadGruposC_EST_EPD: TWideStringField;
    DBCheckBox97: TDBCheckBox;
    DBCheckBox98: TDBCheckBox;
    CadGruposC_CRM_EFC: TWideStringField;
    DBCheckBox99: TDBCheckBox;
    CadGruposC_CHA_EFC: TWideStringField;
    DBCheckBox100: TDBCheckBox;
    CadGruposC_CLI_INA: TWideStringField;
    BRelatorios: TBitBtn;
    DBCheckBox101: TDBCheckBox;
    CadGruposC_GER_SRA: TWideStringField;
    DBCheckBox102: TDBCheckBox;
    CadGruposC_POL_NIC: TWideStringField;
    DBCheckBox103: TDBCheckBox;
    CadGruposC_POL_ROT: TWideStringField;
    DBCheckBox104: TDBCheckBox;
    CadGruposC_FAT_SPF: TWideStringField;
    DBCheckBox105: TDBCheckBox;
    CadGruposC_CRM_VDR: TWideStringField;
    DBCheckBox106: TDBCheckBox;
    CadGruposC_EXC_AMO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadGruposAfterInsert(DataSet: TDataSet);
    procedure CadGruposBeforePost(DataSet: TDataSet);
    procedure CadGruposAfterEdit(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure ECodGrupoChange(Sender: TObject);
    procedure GCondicaoPagamentoCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GCondicaoPagamentoDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure ECondicaoPagamentoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GCondicaoPagamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GCondicaoPagamentoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GCondicaoPagamentoNovaLinha(Sender: TObject);
    procedure GCondicaoPagamentoSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CadGruposAfterPost(DataSet: TDataSet);
    procedure CadGruposAfterScroll(DataSet: TDataSet);
    procedure PanelColor5Click(Sender: TObject);
    procedure GEstagiosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GEstagiosNovaLinha(Sender: TObject);
    procedure ECodEstagioRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GEstagiosDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GEstagiosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GEstagiosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GEstagiosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GCondicaoPagamentoColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure BRelatoriosClick(Sender: TObject);
  private
    { Private declarations }
    VprCondicoesPagamento : TList;
    VprEstagio : Tlist;
    VprDCondicaoPagamento : TRBDCondicaoPagamentoGrupoUsuario;
    VprDEstagio : TRBDEEstagioProducaoGrupoUsuario;
    procedure CarTitulosGrade;
  public
    { Public declarations }
    FunProposta : TRBFuncoesProposta;
  end;

var
  FNovoGrupo: TFNovoGrupo;

implementation

uses APrincipal, AGrupos,Constantes, FunObjeto, Constmsg, UnSistema,
  APermissaoRelatorio;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoGrupo.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunProposta := TRBFuncoesProposta.cria(FPrincipal.BaseDados);
  VprCondicoesPagamento := TList.Create;
  VprEstagio := TList.Create;
  GCondicaoPagamento.ADados := VprCondicoesPagamento;
  GCondicaoPagamento.CarregaGrade;
  GEstagios.ADados := VprEstagio;
  GEstagios.CarregaGrade;
  PageControl1.ActivePageIndex := 0;
  CadGrupos.open;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor4,'T','F');
  CarTitulosGrade;
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCondicaoPagamento := TRBDCondicaoPagamentoGrupoUsuario(VprCondicoesPagamento.Items[VpaLinha-1]);
  if VprDCondicaoPagamento.CodCondicao <> 0 then
    GCondicaoPagamento.Cells[1,VpaLinha]:= InttoStr(VprDCondicaoPagamento.CodCondicao)
  else
    GCondicaoPagamento.Cells[1,VpaLinha]:= '';
  GCondicaoPagamento.Cells[2,VpaLinha]:= VprDCondicaoPagamento.NomCondicao;
end;

procedure TFNovoGrupo.GCondicaoPagamentoColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin

end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ECondicaoPagamento.AExisteCodigo(GCondicaoPagamento.Cells[1,GCondicaoPagamento.ALinha]) then
  begin
    VpaValidos := false;
    aviso('CONDIÇÃO DE PAGAMENTO NÃO CADASTRADA!!!'#13'A condição de pagamento digitada não existe cadastrada.');
    GCondicaoPagamento.Col := 1;
  end;
  if Vpavalidos then
  begin
    if FunContasAReceber.CondicaoPagamentoDuplicada(VprCondicoesPagamento) then
    begin
      VpaValidos := false;
      aviso('CONDIÇÃO PAGAMENTO DUPLICADA!!!'#13'Essa condição de pagamento já foi digitada.');
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case GCondicaoPagamento.AColuna of
        1: ECondicaoPagamento.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprCondicoesPagamento.Count >0 then
  begin
    VprDCondicaoPagamento := TRBDCondicaoPagamentoGrupoUsuario(VprCondicoesPagamento.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoNovaLinha(Sender: TObject);
begin
  VprDCondicaoPagamento := TRBDCondicaoPagamentoGrupoUsuario.cria;
  VprCondicoesPagamento.add(VprDCondicaoPagamento);
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GCondicaoPagamento.AEstadoGrade in [egInsercao,EgEdicao] then
    if GCondicaoPagamento.AColuna <> ACol then
    begin
      case GCondicaoPagamento.AColuna of
        1 :if not ECondicaoPagamento.AExisteCodigo(GCondicaoPagamento.Cells[1,GCondicaoPagamento.ALinha]) then
           begin
             if not ECondicaoPagamento.AAbreLocalizacao then
             begin
               GCondicaoPagamento.Cells[1,GCondicaoPagamento.ALinha] := '';
               abort;
             end;
           end;
      end;
    end;
end;

procedure TFNovoGrupo.GEstagiosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDEstagio := TRBDEEstagioProducaoGrupoUsuario(VprEstagio.Items[VpaLinha-1]);
  if VprDEstagio.CodEstagio <> 0 then
    GEstagios.Cells[1,VpaLinha]:= InttoStr(VprDEstagio.CodEstagio)
  else
    GEstagios.Cells[1,VpaLinha]:= '';
  GEstagios.Cells[2,VpaLinha]:= VprDEstagio.NomEstagio;
end;

procedure TFNovoGrupo.GEstagiosDadosValidos(Sender: TObject;var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ECodEstagio.AExisteCodigo(GEstagios.Cells[1,GEstagios.ALinha]) then
  begin
    VpaValidos := false;
    aviso('ESTAGIO NÃO CADASTRADO!!!'#13'O estagio digitado não existe no cadastro.');
    GEstagios.Col := 1;
  end;
  if VpaValidos then
  begin
    if FunProposta.EstagioDuplicado(VprEstagio) then
    begin
      VpaValidos := false;
      aviso('ESTÁGIO DUPLICADO!!!'#13'Esse estágiojá foi digitado.');
    end;
  end;
end;

procedure TFNovoGrupo.GEstagiosKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case GEstagios.AColuna of
        1: ECodEstagio.AAbreLocalizacao;
      end;
    end;
  end;
end;

procedure TFNovoGrupo.GEstagiosMudouLinha(Sender: TObject; VpaLinhaAtual,VpaLinhaAnterior: Integer);
begin
  if VprEstagio.Count > 0 then
  begin
    VprDEstagio := TRBDEEstagioProducaoGrupoUsuario(VprEstagio.Items[VpaLinhaAtual-1]);
  end;
end;

procedure TFNovoGrupo.GEstagiosNovaLinha(Sender: TObject);
begin
  VprDEstagio := TRBDEEstagioProducaoGrupoUsuario.cria;
  VprEstagio.Add(VprDEstagio);
end;

procedure TFNovoGrupo.GEstagiosSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if GEstagios.AEstadoGrade in [egInsercao,EgEdicao] then
    if GEstagios.AColuna <> ACol then
    begin
      case GEstagios.AColuna of
        1 :if not ECodEstagio.AExisteCodigo(GEstagios.Cells[1,GEstagios.ALinha]) then
           begin
             if not ECodEstagio.AAbreLocalizacao then
             begin
               GEstagios.Cells[1,GEstagios.ALinha] := '';
               abort;
             end;
           end;
      end;
    end;
end;

procedure TFNovoGrupo.PanelColor5Click(Sender: TObject);
begin

end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoGrupo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunProposta.Free;
  CadGrupos.Close;
  FreeTObjectsList(VprCondicoesPagamento);
  FreeTObjectsList(VprEstagio);
  VprCondicoesPagamento.free;
  VprEstagio.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoGrupo.CadGruposAfterInsert(DataSet: TDataSet);
begin
  CadGruposI_EMP_FIL.AsInteger := Varia.CodigoEmpFil;
  ECodigo.Proximocodigo;
  InicializaCheckBox(PanelColor4,'F');
  CadGruposC_GER_ALC.AsString := 'T';
  CadGruposC_EST_AVN.AsString := 'T';
  CadGruposC_CHA_ECH.AsString := 'T';
end;

procedure TFNovoGrupo.CadGruposAfterPost(DataSet: TDataSet);
var
  VpfResultado : String;
begin
  VpfResultado := FunContasAReceber.GravaDCondicaoPagamentoGrupoUsuario(CadGruposI_COD_GRU.AsInteger,VprCondicoesPagamento);
  if VpfResultado = '' then
    VpfResultado := FunProposta.GravaDEstagioGrupoUsuario(CadGruposI_COD_GRU.AsInteger,VprEstagio);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    Sistema.MarcaTabelaParaImportar('CADGRUPOS');
end;

{******************************************************************************}
procedure TFNovoGrupo.CadGruposAfterScroll(DataSet: TDataSet);
begin
  if VprCondicoesPagamento <> nil then
  begin
    FunContasAReceber.CarDCondicaoPagamentoGrupoUsuario(CadGruposI_COD_GRU.AsInteger,VprCondicoesPagamento);
    GCondicaoPagamento.CarregaGrade;
    FunProposta.CarDEstagioGrupoUsuario(CadGruposI_COD_GRU.AsInteger,VprEstagio);
    GEstagios.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFNovoGrupo.CadGruposBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadGruposD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  if CadGrupos.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFNovoGrupo.BRelatoriosClick(Sender: TObject);
begin
  FPermissaoRelatorio := TFPermissaoRelatorio.criarSDI(Application,'',FPrincipal.VerificaPermisao('FPermissaoRelatorio'));
  FPermissaoRelatorio.PermissaoRelatorio(CadGruposI_EMP_FIL.AsInteger,CadGruposI_COD_GRU.AsInteger);
  FPermissaoRelatorio.free;
end;

{******************************************************************************}
procedure TFNovoGrupo.CadGruposAfterEdit(DataSet: TDataSet);
begin
end;

{******************************************************************************}
procedure TFNovoGrupo.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoGrupo.ECodEstagioRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDEstagio.CodEstagio := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDEstagio.NomEstagio := VpaColunas.items[1].AValorRetorno;
    GEstagios.Cells[1,GEstagios.ALinha] := VpaColunas.items[0].AValorRetorno;
    GEstagios.Cells[2,GEstagios.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDEstagio.CodEstagio := 0;
    VprDEstagio.NomEstagio := '';
  end;
end;

procedure TFNovoGrupo.ECodGrupoChange(Sender: TObject);
begin
  if (CadGrupos.State in [dsinsert,dsedit]) then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoGrupo.ECondicaoPagamentoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDCondicaoPagamento.CodCondicao := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDCondicaoPagamento.NomCondicao := VpaColunas.items[1].AValorRetorno;
    GCondicaoPagamento.Cells[1,GCondicaoPagamento.ALinha] := VpaColunas.items[0].AValorRetorno;
    GCondicaoPagamento.Cells[2,GCondicaoPagamento.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDCondicaoPagamento.CodCondicao := 0;
    VprDCondicaoPagamento.NomCondicao := '';
  end;

end;

{******************************************************************************}
procedure TFNovoGrupo.CarTitulosGrade;
begin
  GCondicaoPagamento.Cells[1,0] := 'Código';
  GCondicaoPagamento.Cells[2,0] := 'Condição Pagamento';
  GEstagios.Cells[1,0] := 'Código';
  GEstagios.Cells[2,0] := 'Estágio';
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoGrupo]);
end.
