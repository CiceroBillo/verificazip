unit ACotacao;
{          Autor: Rafael Budag
    Data Criação: 05/05/1999;
          Função: Consultar Orçamentos

Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Localizacao, Buttons, StdCtrls, Componentes1,
  ComCtrls, Grids, DBGrids, Tabela, Db, DBTables, DBKeyViolation, DBCtrls,UnImpressao,
  Graficos, UnDados, UnContasAReceber, UnCotacao, UnProdutos, UnDadosProduto, UnNotaFiscal,
  Menus, Mask, UnDadosCR, UnChamado, UnClassificacao, FMTBcd, SqlExpr, DBClient,
  RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave, unRave, UnSistema,RpDevice,UnContrato,
  numericos, UnECF;

Const
  CT_EXTORNAR = 'Tem certeza que deseja extornar o orçamento ?';
  CT_CANCELAR = 'Tem certeza que deseja cancelar o orçamento ?';
  CT_ORCAMENTOESGOTADO = 'ORÇAMENTO ESGOTADO!!! Não é possível gerar uma nota fiscal a partir do orçamento selecionado, pois não existe mais produtos a serem entregues ou o orçamento foi cancelado...';
  CT_CLIENTEDIFERENTE = 'ORÇAMENTO PARA CLIENTES DIFERENTES!!!'#13'Não é permitido gerar uma nota fiscal quando os orçamentos selecionados são para clientes diferentes...';
  CT_VENDEDORDIFERENTE = 'ORÇAMENTO DE VENDEDORES DIFERENTES!!!'#13'Não é permitido gerar uma nota fiscal quando os orçamentos selecionados são de vendedores diferentes...';

type
  TFCotacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    ECliente: TEditLocaliza;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    LCliente: TLabel;
    Localiza: TConsultaPadrao;
    Label3: TLabel;
    Label4: TLabel;
    DataInicial: TCalendario;
    Flag: TRadioGroup;
    CadOrcamento: TSQL;
    DataCadOrcamentos: TDataSource;
    BFechar: TBitBtn;
    MovOrcamentos: TSQL;
    DataMovOrcamentos: TDataSource;
    MovOrcamentosI_EMP_FIL: TFMTBCDField;
    MovOrcamentosI_LAN_ORC: TFMTBCDField;
    MovOrcamentosC_COD_PRO: TWideStringField;
    MovOrcamentosN_VLR_PRO: TFMTBCDField;
    MovOrcamentosN_QTD_PRO: TFMTBCDField;
    MovOrcamentosN_VLR_TOT: TFMTBCDField;
    MovOrcamentosC_COD_UNI: TWideStringField;
    MovOrcamentosC_IMP_FOT: TWideStringField;
    CadOrcamentoI_Lan_Orc: TFMTBCDField;
    CadOrcamentoD_Dat_Orc: TSQLTimeStampField;
    CadOrcamentoC_Nom_Cli: TWideStringField;
    CadOrcamentoC_Nom_Pag: TWideStringField;
    BAgrupar: TBitBtn;
    BtExcluir: TBitBtn;
    BAlterar: TBitBtn;
    Aux: TSQL;
    Label7: TLabel;
    ChDatEnt: TRadioButton;
    ChDatOrc: TRadioButton;
    CadOrcamentoT_Hor_Orc: TSQLTimeStampField;
    CadOrcamentoD_Dat_Ent: TSQLTimeStampField;
    BtExtornar: TBitBtn;
    CadOrcamentoC_Fla_Sit: TWideStringField;
    CadOrcamentoD_Dat_Pre: TSQLTimeStampField;
    BRomaneio: TBitBtn;
    GOrcamento: TGridIndice;
    CadOrcamentoL_Obs_Orc: TWideStringField;
    Label8: TLabel;
    SpeedButton3: TSpeedButton;
    LProduto: TLabel;
    EProduto: TEditColor;
    MovOrcamentosC_Fla_Res: TWideStringField;
    MovOrcamentosC_Nom_Pro: TWideStringField;
    MovOrcamentosI_Seq_Pro: TFMTBCDField;
    BCadastrar: TBitBtn;
    Splitter1: TSplitter;
    BGraficos: TBitBtn;
    EVendedor: TEditLocaliza;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    LNomVendedor: TLabel;
    BConsulta: TBitBtn;
    CadOrcamentoC_Nom_Ven: TWideStringField;
    PGraficos: TCorPainelGra;
    BitBtn4: TBitBtn;
    PanelColor5: TPanelColor;
    Label17: TLabel;
    Label18: TLabel;
    BClientes: TBitBtn;
    BData: TBitBtn;
    BFechaGrafico: TBitBtn;
    GraficosTrio: TGraficosTrio;
    CTipoGrafico: TRadioGroup;
    BVendedor: TBitBtn;
    BFlag: TBitBtn;
    BProduto: TBitBtn;
    BCondicao: TBitBtn;
    BGeraNota: TBitBtn;
    BCancelar: TBitBtn;
    MovOrcamentosN_Qtd_Bai: TFMTBCDField;
    ProdutosNota: TSQLQuery;
    CadOrcamentoC_Nro_Not: TWideStringField;
    BGeraCupom: TBitBtn;
    MovOrcamentosC_PRO_REF: TWideStringField;
    MovOrcamentosC_DES_COR: TWideStringField;
    BImprimeOP: TBitBtn;
    CadOrcamentoI_COD_CLI: TFMTBCDField;
    CadOrcamentoI_COD_VEN: TFMTBCDField;
    CadOrcamentoI_EMP_FIL: TFMTBCDField;
    BGerarOP: TBitBtn;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    LTipoCotacao: TLabel;
    ETipoCotacao: TEditLocaliza;
    BEstado: TBitBtn;
    CNaoFaturados: TCheckBox;
    PTotal: TPanelColor;
    Label9: TLabel;
    Label10: TLabel;
    BMais: TSpeedButton;
    EQtdTotal: TEditColor;
    CTotal: TCheckBox;
    COPNaoImpressas: TCheckBox;
    BEtiqueta: TBitBtn;
    BFiltros: TBitBtn;
    ECotacao: TEditColor;
    Label6: TLabel;
    CadOrcamentoN_Vlr_TOT: TFMTBCDField;
    PainelTempo1: TPainelTempo;
    MenuGrade: TPopupMenu;
    MGeraRomaneioParcial: TMenuItem;
    MConsultaRomaneiosParciais: TMenuItem;
    N1: TMenuItem;
    MEnviarEmail: TMenuItem;
    N2: TMenuItem;
    MImprimirPedidosPedentes: TMenuItem;
    N3: TMenuItem;
    MConsultaOP: TMenuItem;
    N4: TMenuItem;
    MAlterarCliente: TMenuItem;
    CadOrcamentoI_COD_USU: TFMTBCDField;
    CadOrcamentoC_NOM_USU: TWideStringField;
    EEstagio: TEditLocaliza;
    Label13: TLabel;
    SpeedButton5: TSpeedButton;
    Label14: TLabel;
    N5: TMenuItem;
    MDuplicarOrcamento: TMenuItem;
    N6: TMenuItem;
    MRecibo: TMenuItem;
    N7: TMenuItem;
    MBaixarNumero: TMenuItem;
    CadOrcamentoC_IND_IMP: TWideStringField;
    CadOrcamentoI_COD_EST: TFMTBCDField;
    CadOrcamentoNOMEST: TWideStringField;
    CadOrcamentoI_COD_TRA: TFMTBCDField;
    CadOrcamentoC_NOM_TRA: TWideStringField;
    EFilial: TEditLocaliza;
    Label15: TLabel;
    SpeedButton6: TSpeedButton;
    MAlterarVendedor: TMenuItem;
    CadOrcamentoI_TIP_ORC: TFMTBCDField;
    MovOrcamentosPRODUTOCOTACAO: TWideStringField;
    BGraficoRegiaVendas: TBitBtn;
    BGraficoHora: TBitBtn;
    ECodUsuario: TEditLocaliza;
    Label19: TLabel;
    SpeedButton7: TSpeedButton;
    LNomUsuario: TLabel;
    CadOrcamentoC_NOM_TIP: TWideStringField;
    CadOrcamentoC_ORD_COM: TWideStringField;
    MAlteraTaxaEntrega: TMenuItem;
    CadOrcamentoN_VAL_TAX: TFMTBCDField;
    ETransportadora: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    LTransportadora: TLabel;
    Label20: TLabel;
    CadOrcamentoC_NOT_GER: TWideStringField;
    CadOrcamentoC_GER_FIN: TWideStringField;
    MAlterarPreposto: TMenuItem;
    DataFinal: TCalendario;
    MGerarFichaImplantacao: TMenuItem;
    N8: TMenuItem;
    PanelColor3: TPanelColor;
    GridMov: TDBGridColor;
    DBMemoColor1: TDBMemoColor;
    MVisualizarNota: TMenuItem;
    Label21: TLabel;
    ESituacao: TComboBoxColor;
    CadOrcamentoC_IND_CAN: TWideStringField;
    Shape1: TShape;
    Label22: TLabel;
    MIniciarSeparacao: TMenuItem;
    MEnvioParcial: TMenuItem;
    N10: TMenuItem;
    BMes: TBitBtn;
    CadOrcamentoC_ORP_IMP: TWideStringField;
    CadOrcamentoC_NUM_BAI: TWideStringField;
    Label2: TLabel;
    SpeedButton9: TSpeedButton;
    LNomClassificacao: TLabel;
    EClassificacao: TEditColor;
    N12: TMenuItem;
    MExportaProdutosPendentes: TMenuItem;
    MovOrcamentosNOMEPRODUTO: TWideStringField;
    MenuItem: TPopupMenu;
    MCancelarSaldo: TMenuItem;
    MovOrcamentosI_SEQ_MOV: TFMTBCDField;
    N13: TMenuItem;
    MMarcarOPGerada: TMenuItem;
    Label12: TLabel;
    SpeedButton10: TSpeedButton;
    Label23: TLabel;
    EClienteMaster: TEditLocaliza;
    MConferenciaSeparacao: TMenuItem;
    MovOrcamentosN_QTD_CON: TFMTBCDField;
    EOrdemCompra: TEditColor;
    Label24: TLabel;
    CadOrcamentoI_TIP_FRE: TFMTBCDField;
    CadOrcamentoC_END_CLI: TWideStringField;
    CadOrcamentoC_BAI_CLI: TWideStringField;
    CadOrcamentoC_CEP_CLI: TWideStringField;
    CadOrcamentoC_CID_CLI: TWideStringField;
    CadOrcamentoC_EST_CLI: TWideStringField;
    CadOrcamentoC_CGC_CLI: TWideStringField;
    CadOrcamentoC_INS_CLI: TWideStringField;
    CadOrcamentoC_FO1_CLI: TWideStringField;
    CadOrcamentoC_FON_FAX: TWideStringField;
    CadOrcamentoC_END_ELE: TWideStringField;
    CadOrcamentoC_CON_ORC: TWideStringField;
    EValorTotal: Tnumerico;
    MPedidosPendentesSemClienteMaster: TMenuItem;
    N14: TMenuItem;
    SpeedButton11: TSpeedButton;
    Label25: TLabel;
    Label26: TLabel;
    Label16: TLabel;
    ECondicaoPagamento: TRBEditLocaliza;
    MAdicionarRomaneioSeparacao: TMenuItem;
    N9: TMenuItem;
    ImprimirRomaneioSeparao1: TMenuItem;
    ERepresentada: TRBEditLocaliza;
    Label27: TLabel;
    SpeedButton12: TSpeedButton;
    LRepresentada: TLabel;
    MovOrcamentosNOM_EMBALAGEM: TWideStringField;
    MovOrcamentosNOMECOR: TWideStringField;
    MovOrcamentosD_APR_AMO: TSQLTimeStampField;
    N15: TMenuItem;
    MAprovaAmostra: TMenuItem;
    MEstornaAprovaoAmostra: TMenuItem;
    Label29: TLabel;
    EReferenciaCliente: TEditColor;
    MovOrcamentosN_QTD_CAN: TFMTBCDField;
    MovOrcamentosQTDPRO: TFMTBCDField;
    ImprimirPedidosaixa1: TMenuItem;
    Label30: TLabel;
    EPreposto: TRBEditLocaliza;
    SpeedButton13: TSpeedButton;
    LPreposto: TLabel;
    CadOrcamentoC_FLA_EXP: TWideStringField;
    CPedidosNaoImpressos: TCheckBox;
    AgruparTodasCotaescomProdutosConferidos1: TMenuItem;
    N11: TMenuItem;
    ECor: TRBEditLocaliza;
    SpeedButton14: TSpeedButton;
    Label31: TLabel;
    Label32: TLabel;
    MovOrcamentosD_DAT_GOP: TSQLTimeStampField;
    ImprimirEnvelope1: TMenuItem;
    N16: TMenuItem;
    BMenuFiscal: TBitBtn;
    N17: TMenuItem;
    ConsultaPropostas1: TMenuItem;
    EstornarCancelarSaldo1: TMenuItem;
    N18: TMenuItem;
    GerarSinalPagamento1: TMenuItem;
    MovOrcamentosN_BAI_EST: TFMTBCDField;
    GerarReciboLocao1: TMenuItem;
    N19: TMenuItem;
    Alterar1: TMenuItem;
    BRepresentada: TBitBtn;
    N20: TMenuItem;
    ConsultaFraccaoFaccionista1: TMenuItem;
    PEmbalagem: TPanelColor;
    Label34: TLabel;
    EFacas: TRBEditLocaliza;
    SpeedButton15: TSpeedButton;
    CProdutoSolda: TCheckBox;
    Label33: TLabel;
    EImpressaoEmbalagem: TCheckBox;
    MImprimir: TPopupMenu;
    GeraPDF1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlagClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure GOrcamentoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GOrcamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CadOrcamentoAfterScroll(DataSet: TDataSet);
    procedure BAgruparClick(Sender: TObject);
    procedure BtExcluirClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BtExtornarClick(Sender: TObject);
    procedure BRomaneioClick(Sender: TObject);
    procedure EProdutoExit(Sender: TObject);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure BCadastrarClick(Sender: TObject);
    procedure BMaisClick(Sender: TObject);
    procedure BConsultaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BGraficosClick(Sender: TObject);
    procedure BFechaGraficoClick(Sender: TObject);
    procedure BClientesClick(Sender: TObject);
    procedure BVendedorClick(Sender: TObject);
    procedure BDataClick(Sender: TObject);
    procedure Flagitem(Sender: TObject);
    procedure BCondicaoClick(Sender: TObject);
    procedure BProdutoClick(Sender: TObject);
    procedure CTotalClick(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BGeraNotaClick(Sender: TObject);
    procedure BPendentesClick(Sender: TObject);
    procedure BImprimeOPClick(Sender: TObject);
    procedure BGerarOPClick(Sender: TObject);
    procedure GOrcamentoDblClick(Sender: TObject);
    procedure BEstadoClick(Sender: TObject);
    procedure CNaoFaturadosClick(Sender: TObject);
    procedure BEtiquetaClick(Sender: TObject);
    procedure BFiltrosClick(Sender: TObject);
    procedure PTotalClick(Sender: TObject);
    procedure MGeraRomaneioParcialClick(Sender: TObject);
    procedure MConsultaRomaneiosParciaisClick(Sender: TObject);
    procedure MEnviarEmailClick(Sender: TObject);
    procedure OrdemCarregamento1Click(Sender: TObject);
    procedure BGeraCupomClick(Sender: TObject);
    procedure ETelefoneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MConsultaOPClick(Sender: TObject);
    procedure ECotacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MAlterarClienteClick(Sender: TObject);
    procedure MDuplicarOrcamentoClick(Sender: TObject);
    procedure MReciboClick(Sender: TObject);
    procedure MBaixarNumeroClick(Sender: TObject);
    procedure MAlterarVendedorClick(Sender: TObject);
    procedure BGraficoRegiaVendasClick(Sender: TObject);
    procedure BGraficoHoraClick(Sender: TObject);
    procedure MAlteraTaxaEntregaClick(Sender: TObject);
    procedure MAlterarPrepostoClick(Sender: TObject);
    procedure MGerarFichaImplantacaoClick(Sender: TObject);
    procedure MVisualizarNotaClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure GOrcamentoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure MIniciarSeparacaoClick(Sender: TObject);
    procedure MEnvioParcialClick(Sender: TObject);
    procedure BMesClick(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure EClassificacaoExit(Sender: TObject);
    procedure EClassificacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MExportaProdutosPendentesClick(Sender: TObject);
    procedure MovOrcamentosCalcFields(DataSet: TDataSet);
    procedure MCancelarSaldoClick(Sender: TObject);
    procedure MMarcarOPGeradaClick(Sender: TObject);
    procedure MConferenciaSeparacaoClick(Sender: TObject);
    procedure MPedidosPendentesSemClienteMasterClick(Sender: TObject);
    procedure MAdicionarRomaneioSeparacaoClick(Sender: TObject);
    procedure ImprimirRomaneioSeparao1Click(Sender: TObject);
    procedure MAprovaAmostraClick(Sender: TObject);
    procedure MEstornaAprovaoAmostraClick(Sender: TObject);
    procedure rvMovOrcamentoValidateRow(Connection: TRvCustomConnection;
      var ValidRow: Boolean);
    procedure ImprimirPedidosaixa1Click(Sender: TObject);
    procedure GOrcamentoOrdem(Ordem: string);
    procedure AgruparTodasCotaescomProdutosConferidos1Click(Sender: TObject);
    procedure ImprimirEnvelope1Click(Sender: TObject);
    procedure BMenuFiscalClick(Sender: TObject);
    procedure ConsultaPropostas1Click(Sender: TObject);
    procedure EstornarCancelarSaldo1Click(Sender: TObject);
    procedure GerarSinalPagamento1Click(Sender: TObject);
    procedure EImpressaoEmbalagemClick(Sender: TObject);
    procedure GerarReciboLocao1Click(Sender: TObject);
    procedure BRepresentadaClick(Sender: TObject);
    procedure ConsultaFraccaoFaccionista1Click(Sender: TObject);
    procedure CProdutoSoldaClick(Sender: TObject);
    procedure GeraPDF1Click(Sender: TObject);
  private
    TeclaPressionada,
    VprPressionadoR,
    VprGerandoNota : boolean;
    VprCodProduto,
    VprNomProduto,
    VprOrdem : String;
    VprCodFilialProposta,
    VprSeqProposta,
    VprCodFilialRecibo,
    VprSeqRecibo : Integer;
    VprSeqProduto,
    VprQtdBaixas : Integer;
    VprValBaixas : Double;
    VprCotacoesRomaneioSeparacao,
    VprCotacoesGerarNota : TList;
    VprDOrcamento : TRBDOrcamento;
    FunClassificacao : TFuncoesClassificacao;
    FunCotacao : TFuncoesCotacao;
    FunImpressao :  TFuncoesImpressao;
    FunChamado : TRBFuncoesChamado;
    FunPro : TFuncoesProduto;
    FunRave : TRBFunRave;
    FunContrato : TRBFuncoesContrato;
    procedure ConfiguraPermissaoUsuario;
    procedure ConfiguraFilial;
    procedure AtualizaConsulta(VpaPosicionar :Boolean=false);
    procedure AdicionaFiltros(VpaSelect : TStrings);
    procedure AtualizaTotal;
    procedure PosMovOrcamento(VpaCodfilial, VpaOrcamento : String);
    procedure CancelaOrcamento;
    procedure ExcluiOrcamento;
    procedure ExtornaOrcamento;
    procedure ConsisteProduto;
    procedure LocalizaProduto;
    function CarCotacoesSelecionadas(VpaLista : TList;VpaValidarCliente : Boolean):String;
    function CarDCotacaoSelecionada(VpaLista : TList;VpaValidarCliente : Boolean):string;
    function VerificaTipoCotacaoAntesFaturar(VpaLista : TList):String;
    procedure GeraNotaFiscal;
    procedure GeraOrdemProducao;
    procedure AgrupaCotacoes;
    procedure LimpaFiltros;
    function RNomFiltros :String;
    procedure GraficoCliente;
    procedure GraficoVendedores;
    procedure GraficoData;
    procedure GraficoFlag;
    procedure GraficoCondicaoPagamento;
    procedure GraficoProduto;
    procedure GraficoUF;
    procedure GraficoRegiaoVenda;
    procedure GraficoHora;
    procedure GraficoMes;
    procedure GraficoRepresentada;
    procedure VisualizaNotas(VpaCodFilial,VpaLanOrcamento : Integer);
    procedure VisualizaFracaoFaccionista(VpaCodFilial, VpaLanOrcamento: Integer);
    procedure GeraFinanceiro;
    procedure GeraSinalPagamento;
    procedure MostraPedidosPendentesAFaturar;
    procedure ConfiguraTela;
    procedure AlteraEstagio;
    procedure SelecionaTodasLinhas;
    function LocalizaClassificacao: Boolean;
  public
    { Public declarations }
    procedure ConsultaCotacoesCliente(VpaCodCliente : Integer);
    procedure ConsultaCotacoesProposta(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ConsultaCotacaoRecibo(VpaCodFilial, VpaSeqRecibo : Integer);
    procedure ImprimePedidosPendentesCliente(VpaCodCliente : Integer);
  end;

var
  FCotacao: TFCotacao;

implementation

uses APrincipal,Fundata,Constantes, constMsg, ALocalizaProdutos,
     FunSql, ANovaCotacao,  FunObjeto, UnClassesImprimir,
  ANovaNotaFiscalNota, UnClientes, AImprimeEtiqueta, AGeraOP,
  ABaixaParcialCotacao, AConsultaBaixaParcial, ANovoECF, FunString,
  AOrdensProducaoCadarco, ANovoCliente, AAlteraVendedorCotacao,
  AOrdemProducaoGenerica, AAlteraEstagioCotacao, APedidosPendentesFaturar,
  ALocalizaClassificacao, dmRave, funNumeros, AMenuFiscalECF, APropostasCliente,
  AReciboLocacao, AFracaoFaccionista;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCotacao.FormCreate(Sender: TObject);
begin
  MovOrcamentosN_VLR_PRO.DisplayFormat := varia.MAscaraValorUnitario;
  MovOrcamentosN_QTD_PRO.DisplayFormat := varia.MAscaraQtd;
  VprGerandoNota := false;
  VprCotacoesGerarNota := TList.Create;
  VprCotacoesRomaneioSeparacao := TList.Create;
  VprDOrcamento := TRBDOrcamento.cria;
  FunClassificacao:= TFuncoesClassificacao.criar(Self,FPrincipal.BaseDados);
  FunCotacao := TFuncoesCotacao.Cria(FPrincipal.BaseDados);
  FunChamado := TRBFuncoesChamado.cria(FPrincipal.BaseDados);
  FunPro := TFuncoesProduto.criar(self,FPrincipal.BaseDados);
  FunImpressao :=  TFuncoesImpressao.Criar(Self,FPrincipal.BaseDados);
  FunRave := TRBFunRave.cria(FPrincipal.BaseDados);
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  VprCodFilialProposta := 0;
  VprSeqProposta := 0;
  VprCodFilialRecibo := 0;
  VprSeqRecibo := 0;
  VprOrdem := 'order by D_DAT_ORC, Orc.I_Lan_Orc';
  DataInicial.Date := PrimeiroDiaMes(date); // DecDia(Date,7);
  DataFinal.Date := UltimoDiaMes(Date);
  ESituacao.ItemIndex := 0;
  if config.MostrarCotacoesSomenteFilialAtiva then
  begin
    EFilial.AInteiro := varia.CodigoEmpFil;
    EFilial.Atualiza;
  end;
  if config.GerarFinanceiroCotacao then
  begin
    BtExtornar.Visible := false;
  end;

  AtualizaConsulta;
  TeclaPressionada := False;
  VprPressionadoR := false;
  ConfiguraPermissaoUsuario;
  ConfiguraFilial;
  ConfiguraTela;
  VprValBaixas := 0;
  VprQtdBaixas := 0;

end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCotacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if VprCotacoesGerarNota.Count > 0 then
    FreeTObjectsList(VprCotacoesGerarNota);
  VprCotacoesGerarNota.free;
  FreeTObjectsList(VprCotacoesRomaneioSeparacao);
  VprCotacoesRomaneioSeparacao.Free;
  CadOrcamento.close;
  MovOrcamentos.close;
  Aux.close;
  VprDOrcamento.free;
  FunCotacao.free;
  FunClassificacao.Free;
  FunPro.free;
  FunImpressao.free;
  FunChamado.free;
  FunRave.free;
  FunContrato.Free;

  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           eventos dos filtros superiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCotacao.ConsultaCotacaoRecibo(VpaCodFilial, VpaSeqRecibo: Integer);
begin
  VprCodFilialRecibo := VpaCodFilial;
  VprSeqRecibo :=  VpaSeqRecibo;
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFCotacao.ConsultaCotacoesCliente(VpaCodCliente : Integer);
begin
  DataInicial.DateTime := PrimeiroDiaMes(DecMes(date,3));
  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFCotacao.ConsultaCotacoesProposta(VpaCodFilial, VpaSeqProposta: Integer);
begin
  VprCodFilialProposta  := VpaCodFilial;
  VprSeqProposta := VpaSeqProposta;
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFCotacao.ConsultaFraccaoFaccionista1Click(Sender: TObject);
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
    VisualizaFracaoFaccionista(CadOrcamentoI_EMP_FIL.AsInteger, CadOrcamentoI_Lan_Orc.AsInteger);
end;

{******************************************************************************}
procedure TFCotacao.ConsultaPropostas1Click(Sender: TObject);
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    FPropostasCliente := TFPropostasCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FPropostasCliente'));
    FPropostasCliente.ConsultaPropostasCotacao(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
    FPropostasCliente.free;
  end;
end;

{******************************************************************************}
procedure TFCotacao.CProdutoSoldaClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{**************** cosiste se o produto digitado existe ************************}
procedure TFCotacao.ConsisteProduto;
var
  Produtos : TFuncoesProduto;
begin
  if EProduto.text <> '' then
  begin
    VprCodProduto := EProduto.text;
    Produtos := TFuncoesProduto.criar(Application,FPrincipal.BaseDados);
    if not Produtos.ExisteCodigoProduto(VprSeqProduto,VprCodProduto,VprNomProduto) then
    begin
      LocalizaProduto
    end;
  end
  else
    LProduto.Caption := '';
end;

{************************** localiza o produto ********************************}
procedure TFCotacao.LocalizaProduto;
var
  VpfCadastrouProduto : Boolean;
begin
  VpfCadastrouProduto := false;
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  if FlocalizaProduto.LocalizaProduto(VpfCadastrouProduto,VprSeqProduto,VprCodProduto,vprNomProduto) then
  begin
    LProduto.caption := VprNomProduto;
    EProduto.text := VprCodProduto;
  end
  else
    EProduto.SetFocus;
  FlocalizaProduto.free;
end;

{******************************************************************************}
function TFCotacao.CarCotacoesSelecionadas(VpaLista : TList;VpaValidarCliente : Boolean):String;
var
  VpfLaco : Integer;
  VpfBookMark : TBookmark;
begin
  result := '';
  FreeTObjectsList(VpaLista);
  if GOrcamento.SelectedRows.Count = 0  then
  begin
    result := CarDCotacaoSelecionada(VpaLista,False);
  end
  else
  begin
    for VpfLaco:= 0 to GOrcamento.SelectedRows.Count-1 do
    begin
      VpfBookmark:= TBookmark(GOrcamento.SelectedRows.Items[VpfLaco]);
      CadOrcamento.GotoBookmark(VpfBookMark);
      result := CarDCotacaoSelecionada(VpaLista,VpaValidarCliente);
      if result <> '' then
        break;
    end;
  end;
  if result <> '' then
    FreeTObjectsList(VpaLista);
end;

{******************************************************************************}
function TFCotacao.CarDCotacaoSelecionada(VpaLista: TList;VpaValidarCliente: Boolean): string;
var
  VpfDCotacao, VpfDPrimeiraCotacao : TRBDOrcamento;
begin
  result := '';

  VpfDCotacao := TRBDOrcamento.cria;
  FunCotacao.CarDOrcamento(VpfDCotacao,CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
  VpaLista.add(VpfDCotacao);

  VpfDPrimeiraCotacao := TRBDOrcamento(VpaLista.Items[0]);
  if VpaValidarCliente then
  begin
    if (VpfDPrimeiraCotacao.CodCliente <> VpfDCotacao.CodCliente) then
    begin
      result := CT_CLIENTEDIFERENTE;
      exit(result);
    end;
  end;

end;


{******************************************************************************}
function TFCotacao.VerificaTipoCotacaoAntesFaturar(VpaLista : TList):String;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDTipoCotacao : TRBDTipoCotacao;
  VpfDContasAReceber : TRBDContasCR;
begin
  result := '';
  VpfDTipoCotacao := TRBDTipoCotacao.cria;
  FunCotacao.CarDtipoCotacao(VpfDTipoCotacao,varia.TipoCotacao);
  for VpfLaco := 0 to VpaLista.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaLista.Items[VpfLaco]);
    if (VpfDCotacao.CodTipoOrcamento = varia.TipoCotacaoFaturamentoPosterior)and
       (varia.TipoCotacao <> 0) then
    begin
      VpfDCotacao.CodTipoOrcamento := Varia.TipoCotacao;
      if config.GerarFinanceiroCotacao then
      begin
        if VpfDTipoCotacao.CodPlanoContas <> '' then
        begin
          VpfDCotacao.CodPlanoContas := VpfDTipoCotacao.CodPlanoContas;
          VpfDCotacao.CodOperacaoEstoque := VpfDTipoCotacao.CodOperacaoEstoque;
          VpfDContasAReceber := TRBDContasCR.cria;
          FunCotacao.GeraFinanceiro(VpfDCotacao,nil, VpfDContasAReceber, FunContasAReceber,result,true,true);
          if result <> '' then
           break;
          VpfDContasAReceber.free;
        end;
      end;
    end;
  end;
  VpfDTipoCotacao.free;
end;


{******************************************************************************}
procedure TFCotacao.GeraNotaFiscal;
var
  VpfResultado : String;
begin
  VpfResultado := CarCotacoesSelecionadas(VprCotacoesGerarNota,true);
  if VpfResultado = '' then
  begin
    VpfResultado := VerificaTipoCotacaoAntesFaturar(VprCotacoesGerarNota);
    if VpfResultado = '' then
    begin
      PainelTempo1.execute('Gerando Nota Fiscal...');
      FNovaNotaFiscalNota := TFNovaNotaFiscalNota.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
      if FNovaNotaFiscalNota.GeraNotaCotacoes(VprCotacoesGerarNota) then
      begin
        AtualizaConsulta(true);
      end;
      FNovaNotaFiscalNota.free;
    end;
    FreeTObjectsList(VprCotacoesGerarNota);
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
  PainelTempo1.fecha;
end;

{******************************************************************************}
procedure TFCotacao.GeraOrdemProducao;
var
  VpfDCotacao : TRBDOrcamento;
  VpfResultado : String;
begin
  VpfResultado := CarCotacoesSelecionadas(VprCotacoesGerarNota,false);
  //chama a rotina de gerar a ordem de produção
  if VpfResultado = '' then
  begin
    if VprCotacoesGerarNota.Count > 0 then
    begin
      FGerarOP := TFGerarOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGerarOP'));
      if FGerarOP.GerarOrdemProducao(VprCotacoesGerarNota) then
      begin
        if varia.CNPJFilial <> CNPJ_Telitex THEN
          begin
            FunCotacao.SetaOPImpressa(VprCotacoesGerarNota);
            AtualizaConsulta(true);
          end;
      end;
      FGerarOP.free;
      AtualizaConsulta(true);
    end;
  end;
  FreeTObjectsList(VprCotacoesGerarNota);
  if VpfResultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFCotacao.GeraPDF1Click(Sender: TObject);
begin
  try
    dtRave := TdtRave.create(self);
    dtRave.VplArquivoPDF := varia.DiretorioSistema+'\ANEXOS\COTACAO\'+CadOrcamentoC_Nom_Cli.AsString+'.PDF';
    dtRave.ImprimePedido(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger,false);
  finally
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFCotacao.GerarReciboLocao1Click(Sender: TObject);
var
  VpfResultado : String;
  VpfDCliente : TRBDCliente;
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    VprDOrcamento.Free;
    VprDOrcamento :=TRBDOrcamento.cria;
    VpfDCliente :=  TRBDCliente.cria;
    VpfDCliente.CodCliente := CadOrcamentoI_COD_CLI.AsInteger;
    FunClientes.CarDCliente(VpfDCliente);
    FunCotacao.CarDOrcamento(VprDOrcamento,CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
    VpfResultado := FunContrato.GeraReciboLocacao(VprDOrcamento,VpfDCliente ,nil);
    if VpfResultado = '' then
    begin
      FReciboLocacao := TFReciboLocacao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FReciboLocacao'));
      FReciboLocacao.consultaReciboCotacao(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
      FReciboLocacao.free;

    end;
  end;
end;

{******************************************************************************}
procedure TFCotacao.GerarSinalPagamento1Click(Sender: TObject);
begin
  GeraSinalPagamento;
end;

{******************************************************************************}
procedure TFCotacao.GeraSinalPagamento;
var
  VpfResultado : String;
  VpfDContasAReceber : TRBDContasCR;
  VpfTransacao : TTransactionDesc;
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    VprDOrcamento.Free;
    VprDOrcamento := TRBDOrcamento.cria;
    FunCotacao.CarDOrcamento(VprDOrcamento,CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger );
    if (VprDOrcamento.IndSinalPagamentoGerado) then
      if FunContasAReceber.ExisteSinalPagamentoCotacao(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger) then
        if not Confirmacao('SINAL PAGAMENTO DUPLICADO!!!'#13'O sinal de pagamento desse orçamento já foi gerado, tem certeza que deseja gerar novamente?') then
          exit; //sai fora e não gera o financeiro}
    VpfTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VpfTransacao);
    VpfDContasAReceber := TRBDContasCR.cria;
    if FunCotacao.GeraFinanceiro(VprDOrcamento,nil,VpfDContasAReceber, FunContasAReceber,VpfResultado,true,true) then
    begin
      if VpfResultado ='' then
      begin
        FunCotacao.SetaSinalPagamentoGerado(VprDOrcamento);
        VprDOrcamento.IndSinalPagamentoGerado := true;
        if VpfResultado = '' then
          FPrincipal.BaseDados.Commit(VpfTransacao);
        PainelTempo1.fecha;
        AtualizaConsulta(true);
      end;
    end;
    if VpfResultado <> '' then
    begin
      FPrincipal.BaseDados.Rollback(VpfTransacao);
      aviso(VpfResultado);
    end;

    VpfDContasAReceber.free;
  end;
end;

{******************************************************************************}
procedure TFCotacao.MAdicionarRomaneioSeparacaoClick(Sender: TObject);
var
  VpfDCotacao : TRBDOrcamento;
begin
  if FunClientes.VerificaseClienteEstaBloqueado(CadOrcamentoI_COD_CLI.AsInteger) then
  begin
     aviso('CLIENTE BLOQUEADO!! Consulte o financeiro.');
  end
  else
  begin
    if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
    begin
      if FunCotacao.ExisteRomaneioAdicionado(VprCotacoesRomaneioSeparacao,CadOrcamentoI_EMP_FIL.AsInteger, CadOrcamentoI_Lan_Orc.AsInteger) then
        aviso('COTAÇÃO JÁ ADICIONADA NO ROMANEIO!!!'#13'Não é possível adicionar a cotação mais de uma vez no mesmo romaneio')
      else
      begin
        VpfDCotacao := TRBDOrcamento.cria;
        FunCotacao.CarDOrcamento(VpfDCotacao,CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
        VprCotacoesRomaneioSeparacao.Add(VpfDCotacao);
        MAdicionarRomaneioSeparacao.Caption := 'Adicionar Romaneio Separação ('+IntToSTr(VprCotacoesRomaneioSeparacao.count)+')';
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFCotacao.AgrupaCotacoes;
var
  VpfDCotacao : TRBDOrcamento;
  VpfResultado : String;
begin
  PainelTempo1.execute('Carregando as cotações...');
  //valida se as cotações selecionadas são válidas
  VpfResultado := CarCotacoesSelecionadas(VprCotacoesGerarNota,true);
    //chama a rotina de gerar a nota fiscal;
  if VpfResultado = '' then
  begin
    PainelTempo1.execute('Agrupando Cotação...');
    if VprCotacoesGerarNota.Count > 0 then
    begin
       if Config.NaCotacaoQuandoMesclarVerificarQtadeBaixada then
       begin
         if not FunCotacao.ExisteProdutoSemBaixar(VprCotacoesGerarNota) then
         begin
           FNovaCotacao := TFNovaCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
           if FNovaCotacao.AgrupaCotacao(VprCotacoesGerarNota) then
           begin
             AtualizaConsulta(false);
           end;
           FNovaCotacao.free;
           VprCotacoesGerarNota.Delete(0);
         end;
       end
       else
       begin
          FNovaCotacao := TFNovaCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
          if FNovaCotacao.AgrupaCotacao(VprCotacoesGerarNota) then
          begin
            AtualizaConsulta(false);
          end;
          FNovaCotacao.free;
          VprCotacoesGerarNota.Delete(0);
       end;
    end;
    FreeTObjectsList(VprCotacoesGerarNota);
  end;
  PainelTempo1.fecha;
  if VpfResultado <> '' then
    aviso(VpfREsultado);
end;

procedure TFCotacao.AgruparTodasCotaescomProdutosConferidos1Click(Sender: TObject);
begin
  if confirmacao('Tem certeza que deseja agrupar todos as cotações que possuem produtos conferidos ?') then
  begin

  end;
end;

{*************** chama a procedure para consistir o produto *******************}
procedure TFCotacao.EProdutoExit(Sender: TObject);
begin
  ConsisteProduto;
  AtualizaConsulta;
end;

{**************** quando é pressionado alguma tecla ***************************}
procedure TFCotacao.EProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f3 : LocalizaProduto;
  end;
end;

procedure TFCotacao.EstornarCancelarSaldo1Click(Sender: TObject);
var
  VpfResultado : String;
begin
  if MovOrcamentosI_EMP_FIL.AsInteger <> 0 then
  begin
    VpfREsultado := FunCotacao.EstornaCancelaSaldoItemOrcamento(MovOrcamentosI_EMP_FIL.AsInteger,MovOrcamentosI_LAN_ORC.AsInteger,MovOrcamentosI_SEQ_MOV.AsInteger);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsulta(true);
  end;

end;

{**************** quando é pressionado alguma tecla ***************************}
procedure TFCotacao.MEstornaAprovaoAmostraClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if MovOrcamentosI_EMP_FIL.AsInteger <> 0 then
  begin
    VpfREsultado := FunCotacao.ExtornaAprovacaoAmostra(MovOrcamentosI_EMP_FIL.AsInteger,MovOrcamentosI_LAN_ORC.AsInteger,MovOrcamentosI_SEQ_MOV.AsInteger);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      PosMovOrcamento(MovOrcamentosI_EMP_FIL.AsString,MovOrcamentosI_LAN_ORC.AsString);
  end;
end;

{*********************** Localiza o produto ***********************************}
procedure TFCotacao.SpeedButton3Click(Sender: TObject);
begin
  LocalizaProduto;
  AtualizaConsulta;
end;

{***************** chama a rotina para atualizar a consulta *******************}
procedure TFCotacao.EClienteRetorno(Retorno1, Retorno2: String);
begin
  AtualizaConsulta;
end;

{**************************Atualiza a Tabela Cad*******************************}
procedure TFCotacao.FlagClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************* limpa os filtros da consulta *****************************}
procedure TFCotacao.LimpaFiltros;
begin
  LimpaEdits(PanelColor1);
  AtualizaLocalizas([Ecliente,EVendedor]);
  Flag.ItemIndex := 0;
  DataInicial.Date := PrimeiroDiaMes(Date);
  DataFinal.Date := UltimoDiaMes(Date);
  ChDatOrc.Checked := true;
  LProduto.caption := '';
  if config.MostrarCotacoesSomenteFilialAtiva then
  begin
    EFilial.AInteiro := varia.CodigoEmpFil;
    EFilial.Atualiza;
  end;

  AtualizaConsulta;
end;

{******************************************************************************}
function TFCotacao.RNomFiltros :String;
begin
  if EVendedor.AInteiro <> 0 then
    result := ' - Vendedor : '+LNomVendedor.Caption;
  if ChDatOrc.Checked then
    result := result + '- Por Data Emissão : '+DataToStrFormato(AAAAMMDD,DataInicial.Date,'/')+ ' até '+ DataToStrFormato(AAAAMMDD,DataFinal.Date,'/')
    else
    result := result + '- Por Data Enrega Prevista : '+DataToStrFormato(AAAAMMDD,DataInicial.Date,'/')+ ' até '+ DataToStrFormato(AAAAMMDD,DataFinal.Date,'/');
  if ECliente.AInteiro <> 0 then
    Result := result +' - Cliente : '+ECliente.Text+'-'+LCliente.Caption;
end;

procedure TFCotacao.rvMovOrcamentoValidateRow(Connection: TRvCustomConnection; var ValidRow: Boolean);
begin
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos dos graficos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCotacao.GraficoCliente;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico de Cotações ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select Count(*) Qtd, Orc.I_Cod_Cli ||''-'' ||Cli.C_Nom_Cli Cliente '+
                                   ' from CadOrcamentos Orc, CadClientes Cli ') ;
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Orc.N_Vlr_LIQ) Valor, Orc.I_Cod_Cli ||''-'' ||Cli.C_Nom_Cli Cliente '+
                           ' from CadOrcamentos Orc, '+
                           ' CadClientes Cli ');
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;
  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' and Orc.I_cod_Cli = Cli.I_Cod_Cli '+
                    ' GROUP BY Orc.I_Cod_Cli ||''-'' ||Cli.C_Nom_Cli');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'Cliente';
  graficostrio.info.TituloGrafico := 'Gráficos por Clientes - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'Cliente';
  graficostrio.execute;
end;

{*********************** grafico por vendedores *******************************}
procedure TFCotacao.GraficoVendedores;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select Count(*) Qtd, Orc.I_Cod_Ven ||''-'' ||Ven.C_Nom_Ven Vendedor '+
                                   ' from CadOrcamentos Orc, CadVendedores Ven ') ;
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Orc.N_Vlr_LIQ) Valor, Orc.I_Cod_Ven ||''-'' ||Ven.C_Nom_Ven Vendedor '+
                           ' from CadOrcamentos Orc, CadVendedores Ven ');
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;
  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' and Orc.I_cod_Ven = Ven.I_Cod_Ven '+
                     ' GROUP BY Orc.I_Cod_Ven ||''-'' ||Ven.C_Nom_Ven');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'Vendedor';
  graficostrio.info.TituloGrafico := 'Gráficos por Vendedores - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico :=RNomFiltros ;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'Vendedor';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFCotacao.ImprimePedidosPendentesCliente(VpaCodCliente: Integer);
begin
  DataInicial.DateTime := PrimeiroDiaMes(DecMes(date,12));
  DataFinal.Date := UltimoDiaMes(incmes(date,12));
  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  AtualizaConsulta;
  BPendentesClick(MImprimirPedidosPedentes);

end;

{******************************************************************************}
procedure TFCotacao.ImprimirEnvelope1Click(Sender: TObject);
var
  VpfDCliente : TRBDCliente;
begin
  if CadOrcamentoI_COD_CLI.AsInteger <> 0 then
  begin
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := CadOrcamentoI_COD_CLI.AsInteger;
    FunClientes.CarDCliente(VpfDCliente);
    dtRave := TdtRave.create(self);
    dtRave.ImprimeEnvelope(VpfDCliente);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFCotacao.ImprimirPedidosaixa1Click(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimePedidoPendente(EFilial.AInteiro,ECliente.AInteiro,EClienteMaster.AInteiro, VprSeqProduto,ETipoCotacao.AInteiro,EPreposto.AInteiro, ECor.AInteiro, ERepresentada.AInteiro, EClassificacao.Text,lNomClassificacao.caption,LCliente.Caption,LTipoCotacao.Caption, LPreposto.Caption, LRepresentada.Caption, DataInicial.DateTime,DataFinal.DateTime,true,true);
  dtRave.free;
end;

{******************************************************************************}
procedure TFCotacao.ImprimirRomaneioSeparao1Click(Sender: TObject);
begin
  FunRave.ImprimeRomaneioSeparacaoCotacao(VprCotacoesRomaneioSeparacao);
  FunCotacao.AlteraEstagioCotacoes(VprCotacoesRomaneioSeparacao, Varia.CodigoUsuario,varia.EstagioOrdemProducaoAlmoxarifado);
  FreeTObjectsList(VprCotacoesRomaneioSeparacao);
  MAdicionarRomaneioSeparacao.Caption := 'Adicionar Romaneio Separação';
  AtualizaConsulta(false);
end;

{*********************** grafico pela data ************************************}
procedure TFCotacao.GraficoData;
var
  VpfTitulo, vpfCampo : String;
  VpfComandoSql : TStringList;
begin
  if ChDatOrc.Checked then
    VpfCampo := 'D_Dat_Orc'
  else
    VpfCampo := 'Orc.D_DAt_Pre ';

  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico de Cotações ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select Count(*) Qtd, '+ VpfCampo+ ' from CadOrcamentos Orc ');
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Orc.N_Vlr_LIQ) Valor,'+ VpfCampo+ ' from CadOrcamentos Orc ');
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY '+ VpfCAmpo+
                    ' order by '+VpfCAmpo);

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := VpfCampo;
  graficostrio.info.TituloGrafico := 'Gráficos por Periodo - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'Data';
  graficostrio.execute;
end;

{************************ grafico pelo flag ***********************************}
procedure TFCotacao.GraficoFlag;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico de Cotações ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select Count(*) Qtd, C_Fla_Sit from CadOrcamentos Orc ');
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Orc.N_Vlr_LIQ) Valor, C_Fla_Sit from CadOrcamentos Orc ');
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY C_Fla_Sit');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'C_Fla_Sit';
  graficostrio.info.TituloGrafico := 'Gráficos por Flag - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'Flag';
  graficostrio.execute;
end;

{****************** grafico pela condicao de pagamento ************************}
procedure TFCotacao.GraficoCondicaoPagamento;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico de Cotações ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select Count(*) Qtd, Orc.I_Cod_Pag ||''-'' ||Pag.C_Nom_Pag PAgamento '+
                                   ' from CadOrcamentos Orc, CadCondicoesPagto Pag ') ;
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Orc.N_Vlr_LIQ) Valor,  Orc.I_Cod_Pag ||''-'' ||Pag.C_Nom_Pag PAgamento '+
                                   ' from CadOrcamentos Orc, CadCondicoesPagto Pag ') ;
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;
  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' and Orc.I_cod_Pag = PAg.I_Cod_Pag '+
                    ' GROUP BY Orc.I_Cod_Pag ||''-'' ||Pag.C_Nom_Pag');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'Pagamento';
  graficostrio.info.TituloGrafico := 'Gráficos por Condições de Pagamento - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'Condição de Pagamento';
  graficostrio.execute;
end;

{************************ grafico por produto *********************************}
procedure TFCotacao.GraficoProduto;
var
  VpfTitulo,VpfCampo : String;
  VpfComandoSql : TStringList;
begin
  if UpperCase(varia.CodigoProduto) = 'C_COD_PRO' Then
    VpfCampo := 'PRO.C_COD_PRO'
  else
    VpfCampo := 'QTD.C_COD_BAR';
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico de Cotações ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select SUM(MOV.N_QTD_PRO) Qtd,'+ VpfCampo+' ||''-'' ||Pro.C_Nom_Pro Produto '+
                                   ' from CadOrcamentos Orc, MovOrcamentos Mov, '+
                                   ' CadProdutos Pro, MovQdadeProduto Qtd ') ;
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Mov.N_Vlr_TOT) Valor,  '+ VpfCampo+' ||''-'' ||Pro.C_Nom_Pro Produto '+
                                   ' from CadOrcamentos Orc, MovOrcamentos Mov, '+
                                   ' CadProdutos Pro, MovQdadeProduto Qtd ') ;
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;
  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' and Orc.I_Emp_Fil = Mov.I_Emp_Fil '+
                    ' and Orc.I_Lan_Orc = Mov.I_Lan_Orc '+
                    ' and Qtd.I_Emp_Fil = Mov.I_Emp_Fil '+
                    ' and Qtd.I_Seq_Pro = Mov.I_Seq_Pro '+
                    ' and Pro.I_SEq_Pro = Mov.I_Seq_Pro ' +
                    ' GROUP BY '+ VpfCampo+' ||''-'' ||Pro.C_Nom_Pro');
  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'Produto';
  graficostrio.info.TituloGrafico := 'Gráficos por Condições de Pagamento - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'Produtos';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFCotacao.GraficoUF;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico de Cotações ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select Count(*) Qtd, CLI.C_EST_CLI Estado '+
                                   ' from CadOrcamentos Orc, CadClientes Cli ') ;
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Orc.N_Vlr_LIQ) Valor, Cli.C_EST_CLI Estado '+
                           ' from CadOrcamentos Orc, '+
                           ' CadClientes Cli ');
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;
  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' and Orc.I_cod_Cli = Cli.I_Cod_Cli '+
                    ' GROUP BY CLI.C_EST_CLI');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'Estado';
  graficostrio.info.TituloGrafico := 'Gráficos por UF - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'UF';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFCotacao.GraficoRegiaoVenda;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico de Cotações ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select Count(*) Qtd, CLI.I_COD_REG ||''-'' ||REG.C_Nom_REG REGIAO '+
                                   ' from CadOrcamentos Orc, CADCLIENTES CLI, CADREGIAOVENDA REG ') ;
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Orc.N_Vlr_LIQ) Valor, CLI.I_COD_REG ||''-'' ||REG.C_Nom_REG REGIAO '+
                           ' from CadOrcamentos Orc, CADCLIENTES CLI, CADREGIAOVENDA REG ');
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;
  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' and Orc.I_COD_CLI = CLI.I_COD_CLI '+
                    ' and '+SQLTextoRightJoin('CLI.I_COD_REG','REG.I_COD_REG')+
                     ' GROUP BY CLI.I_COD_REG ||''-'' ||REG.C_Nom_REG');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'REGIAO';
  graficostrio.info.TituloGrafico := 'Gráficos por Região de Vendas - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'Região de Vendas';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFCotacao.GraficoRepresentada;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico de Cotações ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select Count(*) Qtd, REP.CODREPRESENTADA ||''-'' ||REP.NOMREPRESENTADA REPRESENTADA '+
                                   ' from CadOrcamentos Orc, REPRESENTADA REP ') ;
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Orc.N_Vlr_LIQ) Valor,  REP.CODREPRESENTADA ||''-'' ||REP.NOMREPRESENTADA REPRESENTADA '+
                                   ' from CadOrcamentos Orc, REPRESENTADA REP ') ;
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;
  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' and Orc.I_COD_REP = REP.CODREPRESENTADA '+
                     ' GROUP BY REP.CODREPRESENTADA ||''-'' ||REP.NOMREPRESENTADA '+
                     ' order by 1 desc ');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'REPRESENTADA';
  graficostrio.info.TituloGrafico := 'Gráficos por Representada - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'Representada';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFCotacao.GraficoHora;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico de Cotações - Horas ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select Count(*) Qtd, hour(orc.T_HOR_ORC) hora  from CadOrcamentos Orc ');
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Orc.N_Vlr_LIQ) Valor,hour(orc.T_HOR_ORC) hora from CadOrcamentos Orc ');
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY HOUR(ORC.T_HOR_ORC) '+
                    ' order by 2');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'HORA';
  graficostrio.info.TituloGrafico := 'Gráficos por Hora - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'Hora';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFCotacao.GraficoMes;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico de Cotações - Mes '+ RNomFiltros;
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('Select Count(*) Qtd, (YEAR(orc.d_dat_orc) *100)+month(orc.d_dat_orc) DATA1, month(Orc.D_DAT_ORC)||''/''|| year(ORC.D_DAT_ORC) DATA   from CadOrcamentos Orc ');
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('Select Sum(Orc.N_Vlr_LIQ) Valor,(YEAR(orc.d_dat_orc) *100)+month(orc.d_dat_orc) DATA1, month(Orc.D_DAT_ORC)||''/''|| year(ORC.D_DAT_ORC) DATA   from CadOrcamentos Orc ');
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY DATA1, DATA'+
                    ' order by 2');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'Data';
  graficostrio.info.TituloGrafico := 'Gráficos por Mes - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de Cotações';
  graficostrio.info.TituloX := 'Mês';
  graficostrio.execute;
end;

{************************* esconde os graficos ********************************}
procedure TFCotacao.BFechaGraficoClick(Sender: TObject);
begin
  PanelColor1.Enabled := true;
  PanelColor2.Enabled := true;
  GOrcamento.Enabled := true;
  GridMov.Enabled := true;
  PGraficos.Visible := false;
end;

{********************** chama o grafico por data ******************************}
procedure TFCotacao.BDataClick(Sender: TObject);
begin
  GraficoData;
end;

{******************** chama os graficos por flag ******************************}
procedure TFCotacao.Flagitem(Sender: TObject);
begin
  GraficoFlag;
end;

{***********************  condicao de pagamento *******************************}
procedure TFCotacao.BCondicaoClick(Sender: TObject);
begin
  GraficoCondicaoPagamento;
end;

{***************** chama a rotina de graficos por produto *********************}
procedure TFCotacao.BProdutoClick(Sender: TObject);
begin
  graficoProduto;
end;


{**************** chama a rotina dos graficos por Vendedores ******************}
procedure TFCotacao.BVendedorClick(Sender: TObject);
begin
  GraficoVendedores;
end;

{****************** chama a rotina dos graficos por clientes ******************}
procedure TFCotacao.BClientesClick(Sender: TObject);
begin
  GraficoCliente;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações da Consulta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCotacao.ConfiguraPermissaoUsuario;
begin
  MAlterarVendedor.Visible := Config.PermitirAlterarVendedornaCotacao;
  if CONFIG.ControlarASeparacaodaCotacao then
    MIniciarSeparacao.Visible := true;

  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([BCadastrar,BAlterar,BGraficos,PTotal,BGeraNota,BtExtornar,BRomaneio,BtExcluir,BCancelar,BConsulta,BGeraCupom,BEtiqueta,BGerarOP,BImprimeOP,MBaixarNumero,n7,BCancelar,
                       MImprimirPedidosPedentes,MGeraRomaneioParcial,MConferenciaSeparacao,MEnvioParcial,MAlterarCliente,MAlterarPreposto,MDuplicarOrcamento,
                       MConsultaOP,MMarcarOPGerada,MIniciarSeparacao],false);
    GOrcamento.Columns[RIndiceColuna(GOrcamento,'N_VLR_TOT')].Visible := false;
    GridMov.Columns[RIndiceColuna(GridMov,'N_VLR_PRO')].Visible := false;
    GridMov.Columns[RIndiceColuna(GridMov,'N_VLR_TOT')].Visible := false;
    GridMov.Columns[8].Visible := false;
    GOrcamento.OnDblClick := nil;
    if (puPLCadastraCotacao in Varia.PermissoesUsuario) then
      AlterarVisibleDet([BCadastrar,PTotal],true);
    if (puPLImprimePedPendentes in varia.PermissoesUsuario) then
      AlterarVisibleDet([MImprimirPedidosPedentes],true);

    if (puPLConsultarCotacao in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([BConsulta,PTotal,BGraficos],true);
      GOrcamento.Columns[RIndiceColuna(GOrcamento,'N_VLR_TOT')].Visible := true;
      GridMov.Columns[RIndiceColuna(GridMov,'N_VLR_PRO')].Visible := true;
      GridMov.Columns[RIndiceColuna(GridMov,'N_VLR_TOT')].Visible := true;
    end;
    if (puPLAlterarCotacao in varia.PermissoesUsuario) then
      BAlterar.Visible := true;
    if (puPLExcluirCotacao in varia.PermissoesUsuario) then
      BtExcluir.Visible := true;
    if (puPLCancelarCotacao in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([BCancelar,BtExtornar],true);
    end;
    if (puImprimirPedido in varia.PermissoesUsuario) then
      BRomaneio.Visible := true;
    if (puPLImprimirEtiqueta in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([MConsultaOP,BEtiqueta,BImprimeOP,BGerarOP,MMarcarOPGerada],true);
    end;
    if (puPLGerarNota in Varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([BGeraNota,MVisualizarNota],true);
      GOrcamento.Columns[7].Visible := true;
      GridMov.Columns[RIndiceColuna(GridMov,'N_VLR_PRO')].Visible := true;
      GridMov.Columns[6].Visible := true;
      GridMov.Columns[RIndiceColuna(GridMov,'N_VLR_TOT')].Visible := true;
    end;
    if (puPLGerarCupom in varia.PermissoesUsuario) then
      AlterarVisibledet([BGeraCupom],true);
    if (puPLSeparaProduto in varia.PermissoesUsuario) then
      AlterarVisibledet([MGeraRomaneioParcial],true);
    if (puPLConferirProduto in varia.PermissoesUsuario) then
      AlterarVisibledet([MConferenciaSeparacao],true);
    if (puPLEnvioParcialPedido in varia.PermissoesUsuario) then
      AlterarVisibledet([MEnvioParcial],true);
    if (puClienteCompleto in varia.PermissoesUsuario) then
      AlterarVisibledet([MAlterarCliente],true);
    if (puClienteCompleto in varia.PermissoesUsuario) then
      AlterarVisibledet([MAlterarCliente],true);
    if (puPLAlterarCotacao in varia.PermissoesUsuario) then
      AlterarVisibledet([MAlterarVendedor,MAlterarPreposto],true);
    if (puPLCadastraCotacao in varia.PermissoesUsuario) then
      AlterarVisibledet([MDuplicarOrcamento],true);
    if (puOcultarVendedor in varia.PermissoesUsuario) then
      AlterarVisibledet([MAlterarVendedor,BVendedor],false);
    if (puPLIniciarSeparacao in varia.PermissoesUsuario) then
      AlterarVisibledet([MIniciarSeparacao],true);
    if not (puPLVisualizarTotalCotacao in varia.PermissoesUsuario) then
    begin
      CTotal.Enabled:= false;
      Label10.Visible:= false;
      EValorTotal.Visible:= false;
    end;
  end
  else
  begin
    AlterarVisibleDet([BGeraCupom,BMenuFiscal],NomeModulo = 'PDV');
    AlterarVisibleDet([BtExcluir],not(NomeModulo = 'PDV'));
  end;

  if (puOcultarVendedor in varia.PermissoesUsuario) then
    GOrcamento.Columns[RIndiceColuna(GOrcamento,'C_NOM_VEN')].Visible := false;


  MBaixarNumero.Visible:= Config.PermitirBaixarNumeroPedido and ((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario));
  // habilitar apenas se a configuração estiver marcada e se for Administrador
  // ou tiver o Ponto de Loja completo

  n6.Visible := ConfigModulos.OrdemServico;
  MGerarFichaImplantacao.Visible := ConfigModulos.OrdemServico;

  if (varia.CNPJFilial = CNPJ_Kairos) or (Varia.CNPJFilial = CNPJ_AviamentosJaragua) or
     (varia.CNPJFilial = CNPJ_Zumm) or (varia.CNPJFilial = CNPJ_ZummH) or
     (varia.CNPJFilial = CNPJ_ZummSP) then
  begin
    AlterarVisibleDet([BImprimeOP],false);
    AlterarVisibleDet([MPedidosPendentesSemClienteMaster],true);
  end;
  if CONFIG.ControlarASeparacaodaCotacao then
  begin
    MGeraRomaneioParcial.Caption := 'Separação de Produtos';
    GridMov.Columns[RIndiceColuna(GridMov,'N_QTD_BAI')].Title.Caption := 'Separado';
  end
  else
  begin
    GridMov.Columns[RIndiceColuna(GridMov,'N_QTD_CON')].Visible := false;
  end;
  if not config.PermitirCancelareExtornarCotacao then
  begin
    BCancelar.Visible := false;
    BtExtornar.Visible := false;
  end;
  GridMov.Columns[RIndiceColuna(GridMov,'D_APR_AMO')].Visible := config.ControlarAmostraAprovadanaCotacao;
  if varia.TipoBancoDados = bdRepresentante then
  begin
    AlterarVisibleDet([MBaixarNumero,MIniciarSeparacao,MGeraRomaneioParcial,MConferenciaSeparacao,MEnvioParcial,MConsultaRomaneiosParciais,
                       MExportaProdutosPendentes,MConsultaOP,MAlterarCliente,MAlterarVendedor,MAlterarPreposto,MAlteraTaxaEntrega,
                       MGerarFichaImplantacao,MRecibo,MMarcarOPGerada,MCancelarSaldo,MEstornaAprovaoAmostra,MAprovaAmostra,
                       BGerarOP,BGeraNota,BGeraCupom,BEtiqueta,BCancelar,BtExtornar,BAgrupar,BImprimeOP],false);
    if NomeModulo = 'PDV' then
    begin
      AlterarVisibleDet([BGeraNota],true);
    end;
  end;
  PEmbalagem.Visible:= config.CadastroEmbalagemPvc;
end;

{******************************************************************************}
procedure TFCotacao.ConfiguraFilial;
begin
  if not config.EmitirECF then
    AlterarVisibleDet([BGeraCupom],false);
end;

{********************Atualiza a tabela de cadOrcamento*************************}
procedure TFCotacao.AtualizaConsulta(VpaPosicionar :Boolean=false);
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := CadOrcamento.GetBookmark;
  MovOrcamentos.Close;
   CadOrcamento.close;
   CadOrcamento.sql.clear;
   CadOrcamento.SQl.add(' Select Orc.I_Lan_Orc, Orc.D_Dat_Orc, Cli.C_Nom_Cli,'+
                             ' Pag.C_Nom_Pag,  Orc.T_Hor_Orc, Orc.D_Dat_Ent, ORC.C_IND_IMP, ORC.C_CON_ORC,' +
                             ' Orc.I_TIP_ORC, ORC.C_ORD_COM, Orc.N_VAL_TAX, ORC.C_GER_FIN, C_NOT_GER,'+
                             ' Orc.C_Fla_Sit, Orc.D_Dat_Pre, Orc.L_Obs_Orc, Orc.N_VLR_TOT,'+
                             ' Orc.C_Nro_Not, ORC.I_COD_CLI, ORC.I_COD_VEN, ORC.I_EMP_FIL, ORC.C_IND_CAN,'+
                             ' Orc.C_FLA_EXP, '+
                             ' Ven.C_Nom_Ven, USU.I_COD_USU, USU.C_NOM_USU, '+
                             ' ORC.I_COD_EST, EST.NOMEST, ORC.I_COD_TRA, TRA.C_NOM_CLI C_NOM_TRA, '+
                             ' TIP.C_NOM_TIP, ORC.C_ORP_IMP, ORC.C_NUM_BAI, ORC.I_TIP_FRE, '+
                             ' CLI.C_END_CLI, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, '+
                             ' CLI.C_EST_CLI, CLI.C_CGC_CLI, CLI.C_INS_CLI, CLI.C_FO1_CLI, '+
                             ' CLI.C_FON_FAX, CLI.C_END_ELE '+
                             ' from CadOrcamentos Orc, CadClientes Cli, '+
                             ' CadCondicoesPagto Pag, '+
                             ' CadVendedores Ven, CADUSUARIOS USU, ESTAGIOPRODUCAO EST, '+
                             ' CADCLIENTES TRA, CADTIPOORCAMENTO TIP' );
   AdicionaFiltros(CadOrcamento.Sql);
   CadOrcamento.Sql.Add(' and Cli.I_Cod_Cli = Orc.I_Cod_Cli '+
                        ' and Pag.I_Cod_Pag = Orc.i_Cod_Pag ' +
                        ' and Ven.I_Cod_Ven = Orc.I_Cod_Ven'+
//                        ' and ORC.I_COD_USU *= USU.I_COD_USU '+
//                        ' and ORC.I_COD_EST *= EST.CODEST '+
//                        ' and ORC.I_COD_TRA *= TRA.I_COD_TRA'+
                        ' and ORC.I_COD_USU = USU.I_COD_USU(+) '+
                        ' and ORC.I_COD_EST = EST.CODEST(+) '+
                        ' and ORC.I_COD_TRA = TRA.I_COD_CLI(+) '+
                        ' and ORC.I_TIP_ORC = TIP.I_COD_TIP');
   CadOrcamento.sql.add(VprOrdem);
   CadOrcamento.open;
   GOrcamento.ALinhaSQLOrderBy := CadOrcamento.SQL.Count - 1;
   if CTotal.Checked then
     AtualizaTotal
   else
   begin
     EValorTotal.text := '0';
     EQtdTotal.text := '0';
   end;
  if VpaPosicionar then
  begin
    try
      if not CadOrcamento.eof then
        CadOrcamento.GotoBookmark(vpfPosicao);

    except
      try
        CadOrcamento.Last;
        CadOrcamento.GotoBookmark(vpfPosicao);
      except
      end;
    end;
  end;
  Cadorcamento.FreeBookMark(VpfPosicao);
end;

{****************** adiciona os filtros da cotacao ****************************}
procedure TFCotacao.AdicionaFiltros(VpaSelect : TStrings);
begin

  if ECotacao.AInteiro <> 0 then
  begin
   VpaSelect.Add(' Where ORC.I_LAN_ORC = '+ ECotacao.Text);
   if EFilial.Text <> '' then
     VpaSelect.Add(' and ORC.I_EMP_FIL = '+ EFilial.Text);
  end
  else
    if VprCodFilialProposta <> 0 then
    begin
      VpaSelect.Add(' Where Exists( SELECT 1 FROM PROPOSTACOTACAO PTO ' +
                    ' Where PTO.CODFILIALORCAMENTO = ORC.I_EMP_FIL ' +
                    ' AND PTO.LANORCAMENTO = ORC.I_LAN_ORC ' +
                    ' AND PTO.CODFILIALPROPOSTA = ' +IntToStr(VprCodFilialProposta)+
                    ' AND PTO.SEQPROPOSTA = ' +IntToStr(VprSeqProposta)+
                    ' )');
    end
    else
    if  VprCodFilialRecibo <> 0 then
    begin
      VpaSelect.Add(' Where Exists( SELECT 1 FROM RECIBOLOCACAOCORPO REC ' +
                    ' Where REC.CODFILIAL = ORC.I_EMP_FIL ' +
                    ' AND REC.LANORCAMENTO = ORC.I_LAN_ORC ' +
                    ' AND REC.CODFILIAL = ' +IntToStr(VprCodFilialRecibo)+
                    ' AND REC.SEQRECIBO = ' +IntToStr(VprSeqRecibo)+
                    ' )');
    end
    else
    begin
      if ChDatOrc.Checked then
        VpaSelect.add(' Where  orc.D_DAT_Orc between ' + SQLTextoDataAAAAMMMDD(DataInicial.Date) +
                       ' and ' + SQLTextoDataAAAAMMMDD(DataFinal.Date)  )
      else
        VpaSelect.add( ' Where orc.D_DAT_Pre between ''' + DataToStrFormato(AAAAMMDD,DataInicial.Date,'/') + '''' +
                                 ' and ''' + DataToStrFormato(AAAAMMDD,DataFinal.Date,'/') + ''''  );
      case ESituacao.ItemIndex of
         1 : VpaSelect.add('and ORC.C_IND_CAN = ''S''');
         2 : VpaSelect.add('and ORC.C_IND_CAN = ''N''');
      end;

       if ETipoCotacao.Text <> '' then
         VpaSelect.Add(' and ORC.I_TIP_ORC = '+ETipoCotacao.Text);

       if EPreposto.Text <> '' then
         VpaSelect.Add(' and ORC.I_VEN_PRE = '+EPreposto.Text);

       if ETransportadora.Text <> '' then
         VpaSelect.Add(' and ORC.I_COD_TRA = '+ETransportadora.Text);

       if ECliente.Text <> '' Then
         VpaSelect.Add(' and Orc.I_Cod_Cli = '+ ECliente.text);

       if EVendedor.text <> '' then
         VpaSelect.add(' and Orc.I_Cod_Ven = ' + EVendedor.Text);

       if EFilial.Text <> '' then
         VpaSelect.Add(' and ORC.I_EMP_FIL = '+ EFilial.Text);

       if EClienteMaster.Text <> '' then
         VpaSelect.Add(' and CLI.I_CLI_MAS = '+ EClienteMaster.Text);
       if ECondicaoPagamento.AInteiro <> 0 then
         VpaSelect.Add(' and ORC.I_COD_PAG = '+ ECondicaoPagamento.Text );


       if Flag.ItemIndex = 0 then
          VpaSelect.add(' and orc.C_Fla_Sit = ''A''')
       else
          if flag.ItemIndex = 1 Then
            VpaSelect.add(' and orc.C_Fla_Sit = ''E''');
      if CNaoFaturados.checked then
        VpaSelect.Add('And ORC.C_GER_FIN IS NULL');
      if COPNaoImpressas.checked then
      begin
        if (VARIA.CNPJFilial = CNPJ_MetalVidros) or (varia.CNPJFilial =  CNPJ_VIDROMAX) then
          VpaSelect.add('and ORC.I_TIP_ORC = '+IntToSTr(Varia.TipoCotacaoPedido));
        VpaSelect.Add('And ORC.C_ORP_IMP = ''N''');
      end;
      if CPedidosNaoImpressos.checked then
        VpaSelect.Add('And '+SQLTextoIsNull('ORC.C_IND_IMP','''N''')+' = ''N''');

      if EEstagio.Text <> '' then
        VpaSelect.add('and ORC.I_COD_EST = '+EEstagio.Text);

      if ECodUsuario.Text <> '' then
        VpaSelect.add('and ORC.I_COD_USU = '+ECodUsuario.Text);

      if EClassificacao.Text <> '' then
        VpaSelect.Add(' AND EXISTS(SELECT * '+
                      '             FROM MOVORCAMENTOS MOV, CADPRODUTOS PRO'+
                      '             WHERE MOV.I_LAN_ORC = ORC.I_LAN_ORC'+
                      '             AND MOV.I_EMP_FIL = ORC.I_EMP_FIL'+
                      '             AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                      '             AND PRO.C_COD_CLA LIKE '''+EClassificacao.Text+'%'')');

      if EimpressaoEmbalagem.Checked then
        VpaSelect.Add(' AND EXISTS(SELECT * '+
                      '             FROM MOVORCAMENTOS MOV, CADPRODUTOS PRO'+
                      '             WHERE MOV.I_LAN_ORC = ORC.I_LAN_ORC'+
                      '             AND MOV.I_EMP_FIL = ORC.I_EMP_FIL'+
                      '             AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                      '             AND PRO.I_IMP_EMB >= 2 )');
      if EProduto.text <> '' then
        VpaSelect.add(' and exists ( Select I_Lan_Orc from MovOrcamentos mov '+
                                  'Where Mov.I_Seq_Pro = ' + IntToStr(VprSeqProduto)+
                                  ' and mov.I_EMP_FIL = ORC.I_EMP_FIL '+
                                  ' AND MOV.I_LAN_ORC = ORC.I_LAN_ORC) ');
      if EReferenciaCliente.text <> '' then
        VpaSelect.add(' and exists ( Select I_Lan_Orc from MovOrcamentos mov '+
                                  'Where Mov.C_PRO_REF = ''' +EReferenciaCliente.Text +''''+
                                  ' and mov.I_EMP_FIL = ORC.I_EMP_FIL '+
                                  ' AND MOV.I_LAN_ORC = ORC.I_LAN_ORC) ');
      if ECor.AInteiro <> 0 then
        VpaSelect.add(' and exists ( Select I_Lan_Orc from MOVORCAMENTOS MOV '+
                                  'Where MOV.I_COD_COR = '+ECor.Text+
                                  ' and mov.I_EMP_FIL = ORC.I_EMP_FIL '+
                                  ' AND MOV.I_LAN_ORC = ORC.I_LAN_ORC) ');

      if EFacas.AInteiro <> 0 then
        VpaSelect.add(' and exists ( Select PRO.I_SEQ_PRO from CADPRODUTOS PRO, MOVORCAMENTOS MOV '+
                                   ' Where PRO.I_FER_EMB = '+EFacas.Text+
                                   ' AND PRO.I_SEQ_PRO = MOV.I_SEQ_PRO ' +
                                   ' AND MOV.I_LAN_ORC = ORC.I_LAN_ORC) ');
      if CProdutoSolda.Checked then
        VpaSelect.add(' and exists ( Select PRO.I_SEQ_PRO from CADPRODUTOS PRO, MOVORCAMENTOS MOV '+
                                   ' Where (PRO.I_ALC_EMB IN (2,3,4,7) ' +
                                   ' OR PRO.C_IND_BOL = ''S'')'+
                                   ' AND PRO.I_SEQ_PRO = MOV.I_SEQ_PRO ' +
                                   ' AND MOV.I_LAN_ORC = ORC.I_LAN_ORC) ');

      if EOrdemCompra.Text <> '' then
        VpaSelect.add(' and ORC.C_ORD_COM like '''+EOrdemCompra.Text+'%''');
      if ERepresentada.AInteiro <> 0 then
        VpaSelect.Add(' and ORC.I_COD_REP = '+ERepresentada.Text)
    end;
  if (puSomenteClientesdoVendedor in varia.PermissoesUsuario) then
    VpaSelect.Add('and ORC.I_COD_VEN in '+Varia.CodigosVendedores) ;
end;

{************************* atualiza os totais *********************************}
procedure TFCotacao.AtualizaTotal;
begin
  Aux.Close;
  Aux.sql.Clear;
  AdicionaSQLTabela(Aux,'Select Sum(N_VLR_TOT) VALOR, Count(I_Lan_Orc) Qtd '+
                            ' from CadOrcamentos Orc ');
  AdicionaFiltros(Aux.Sql);
  Aux.open;
  EValorTotal.AValor := Aux.FieldByName('VALOR').AsFloat;
  EQtdTotal.Text := Aux.FieldByName('Qtd').Asstring;
end;

{*****************Posiciona o MovOrcamento de acordo com o Cad*****************}
procedure TFCotacao.PosMovOrcamento(VpaCodfilial, VpaOrcamento : String);
begin
  MovOrcamentos.close;
  if ((Vpaorcamento <> '') and not(TeclaPressionada)) then
  begin
    MovOrcamentos.sql.clear;
    MovOrcamentos.sql.add('Select Mov.I_Emp_Fil, Mov.I_Lan_Orc,Mov.N_Qtd_Pro, Mov.N_Vlr_Pro, Mov.N_Vlr_Tot, Mov.C_Cod_Uni, Mov.N_Qtd_Can, (Mov.N_Qtd_pro - nvl(Mov.N_Qtd_Bai,0) - nvl(Mov.N_Qtd_Can,0)) QTDPRO, '+
                          ' C_Imp_Fot, C_Fla_Res, Mov.N_Qtd_Bai, MOV.N_QTD_CON, MOV.I_COD_COR ||''-''||MOV.C_DES_COR C_DES_COR, MOV.C_DES_COR NOMECOR, '+
                          ' Pro.C_Nom_Pro, Pro.I_Seq_Pro, MOV.I_SEQ_MOV, MOV.C_NOM_PRO PRODUTOCOTACAO,' +
                          ' MOV.C_COD_PRO, MOV.N_BAI_EST, '+
                          ' EMB.NOM_EMBALAGEM, MOV.D_APR_AMO, MOV.D_DAT_GOP, C_PRO_REF ');

    MovOrcamentos.sql.add(' from MovOrcamentos Mov, CadProdutos Pro, MovQdadeProduto QTD, EMBALAGEM EMB' +
                          ' Where mov.I_Emp_Fil = ' + VpaCodfilial +
                          ' and Mov.I_Lan_Orc = ' + VpaOrcamento +
                          ' and Mov.I_Seq_Pro = Pro.I_Seq_Pro '+
                          ' and Mov.I_Seq_Pro = Qtd.I_Seq_Pro '+
                          ' and Mov.I_Emp_Fil = QTd.I_Emp_Fil '+
                          ' and ' + SQLTextoRightJoin('MOV.I_COD_EMB','EMB.COD_EMBALAGEM')+
                          ' union ' +
                          ' Select Orc.I_Emp_Fil, Orc.I_Lan_Orc,Orc.N_Qtd_Ser, '+
                          ' Orc.N_Vlr_Ser,Orc.N_Vlr_Tot, ''SE''  Unis,  0.00, 0.00,''-'' Foto, '+
                          ' ''-'' Res, N_QTD_BAI, 0,'' '', '' '' ,Ser.C_Nom_Ser, Ser.I_Cod_ser,ORC.I_COD_SER,SER.C_NOM_SER, Cast(Ser.I_Cod_Ser as VARChar2(20)) C_Cod_Pro , 0 N_BAI_EST, '' '','+
                          SQLTextoDataAAAAMMMDD(DATE)+' D_DAT_APR, '+
                          SQLTextoDataAAAAMMMDD(DATE)+' D_DAT_GOP, '' '' C_PRO_REF  '+
                          ' from movservicoorcamento orc, cadservico ser ' +
                          ' Where orc.I_Emp_Fil = ' + VpaCodfilial +
                          ' and Orc.I_Lan_Orc = ' + VpaOrcamento +
                          ' and Orc.I_Cod_Ser = Ser.I_Cod_Ser ');
    MovOrcamentos.sql.add(' order by 15 ');
    MovOrcamentos.open;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{*************************Atualiza o MovOrcamento******************************}
procedure TFCotacao.CadOrcamentoAfterScroll(DataSet: TDataSet);
begin
  if not VprGerandoNota then
  begin
    AlterarEnabledDet([BGeraNota,MVisualizarNota,BGeraCupom,BtExtornar,BAgrupar,BAlterar,BGerarOP,BtExcluir,MEnviarEmail,BCancelar,MGeraRomaneioParcial],true);
   PosMovOrcamento(CadOrcamentoI_EMP_FIL.AsString, CadOrcamentoI_Lan_Orc.AsString);
   GOrcamento.Hint := 'Cliente : '+ CadOrcamentoI_COD_CLI.AsString +'-'+CadOrcamentoC_Nom_Cli.Asstring;;
   if Config.NaoPermitirAlterarCotacaoAposImpressa then
     BAlterar.Enabled := CadOrcamentoC_IND_IMP.AsString = 'N';
   if (config.AlterarCotacaoSomentenoDiaEmissao) and (CadOrcamentoI_TIP_ORC.AsInteger <> Varia.TipoCotacaoFaturamentoPosterior) and
      (CadOrcamentoI_TIP_ORC.AsInteger <> Varia.TipoCotacaoFaturamentoPendente) then
     BAlterar.Enabled := CadOrcamentoD_Dat_Orc.AsDateTime = date;

   BImprimeOP.Enabled:= True;
   BRomaneio.Enabled:= True;
   if not(puAdministrador in Varia.PermissoesUsuario) and not(puPLCompleto in Varia.PermissoesUsuario) then
   begin
     if not (puPLImprimirPedidoDuasVezes in Varia.PermissoesUsuario) then
       if CadOrcamentoC_ORP_IMP.AsString = 'S' then
       begin
       // se a ordem de produção já estiver impressa
         BImprimeOP.Enabled:= False;
         BRomaneio.Enabled:= False;
       end;
   end;
   BRomaneio.Enabled:= BImprimeOP.Enabled;

   if varia.GrupoUsuario = varia.GrupoUsuarioMaster then
   begin
     AlterarEnabledDet([BAlterar,BtExcluir],true);
   end;
   if varia.CodigoEmpFil <> CadOrcamentoI_EMP_FIL.AsInteger then
     AlterarEnabledDet([BGeraCupom,BtExtornar,BtExcluir,BAlterar,MEnviarEmail,BCancelar,MGeraRomaneioParcial],false);
   if (CadOrcamentoC_GER_FIN.AsString = 'S') or (CadOrcamentoC_NOT_GER.AsString = 'S') then
     if not((puPLAlterarExcluirDepoisFaturado in varia.PermissoesUsuario)or (puAdministrador in varia.PermissoesUsuario)or
            ( puPLCompleto in varia.PermissoesUsuario)) then
       AlterarEnabledDet([BAlterar,BtExcluir],false);
   if (varia.TipoBancoDados = bdRepresentante) and BAlterar.Enabled then
     AlterarEnabledDet([BAlterar,BtExcluir],CadOrcamentoC_FLA_EXP.AsString = 'N');
  end;
//  BtExcluir.Visible := BtExcluir.Enabled;

end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Ações do Grid CadOrçamento e seus Filtros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************Quando soltado a tecla posicona o movorcamento****************}
procedure TFCotacao.GOrcamentoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   TeclaPressionada := False;
   if key in[37..40]  then
      PosMovOrcamento(CadOrcamentoI_EMP_FIL.AsString,CadOrcamentoI_Lan_Orc.AsString);
    if (puPLNaoImprimeCotacaoJaImpressa in varia.PermissoesUsuario) then
    begin
      if FunCotacao.RSePedidoFoiImpresso(CadOrcamentoI_EMP_FIL.AsInteger, CadOrcamentoI_Lan_Orc.AsInteger) then
        BRomaneio.Enabled:= false;
    end;
end;

procedure TFCotacao.GOrcamentoOrdem(Ordem: string);
begin
  VprOrdem := Ordem;
end;

{*******************Não deixa fazer mais os filtros****************************}
procedure TFCotacao.GOrcamentoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  
//  if key = 46 then
//    ExcluiOrcamento;
//foi colocado em comentario porque quando gerava o financeiro, a tecla pressionada ficava como true
//   TeclaPressionada := true;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações dos Botões Inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*******************Chama a rotina para cancelar o orcamento*******************}
procedure TFCotacao.BAgruparClick(Sender: TObject);
begin
  VprGerandoNota := true;
  AgrupaCotacoes;
  AtualizaConsulta(true);
  VprGerandoNota := false;
end;

{***************************Cancela um orcamento*******************************}
procedure TFCotacao.CancelaOrcamento;
begin
  if CadOrcamentoI_EMP_FIL.AsInteger <> Varia.CodigoEmpFil then
  begin
    aviso('FILIAL ATIVA DIFERENTE DA COTAÇÃO!!!!'#13'A filial da cotação não é a mesma que está logado no sistema.');
    exit;
  end;

  if confirmacao('Tem certeza que deseja cancelar a cotação?') then
  begin
    FunCotacao.CancelaOrcamento(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
    AtualizaConsulta(true);
  end;

end;

{******************Chama a rotina para Excluir o Orçamento*********************}
procedure TFCotacao.BtExcluirClick(Sender: TObject);
begin
   ExcluiOrcamento;
end;

{*******************************Exclui o Orçamento*****************************}
procedure TFCotacao.ExcluiOrcamento;
var
  VpfResultado : string;
begin
  VpfResultado := '';
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    if ((CadOrcamentoC_GER_FIN.AsString = 'S') or (CadOrcamentoC_NOT_GER.AsString = 'S'))and
       not(puPLAlterarExcluirDepoisFaturado in varia.PermissoesUsuario)   then
      VpfResultado := 'USUÁRIO SEM PERMISSÃO!!!'#13'Esse usuário não possui permissão para excluir pedidos depois de faturados';
  end;

  if VpfResultado = '' then
  begin
    if not CadOrcamento.IsEmpty then
      if not FunCotacao.ExisteOpGerada(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger,true) or
         (VARIA.CNPJFilial = CNPJ_Telitex) then
      begin
        if (Confirmacao(CT_DeletaRegistro)) and not(CadOrcamentoI_Lan_Orc.IsNull) then
        begin
          FunCotacao.ExcluiOrcamento(CadOrcamentoI_EMP_FIL.AsInteger, CadOrcamentoI_Lan_Orc.AsInteger);
          AtualizaConsulta(true);
        end;
      end;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{*****************Chama a rotina para alterar o MovOrçamento*******************}
procedure TFCotacao.BAlterarClick(Sender: TObject);
begin
   if not CadOrcamentoI_Lan_Orc.IsNull then
   begin
     if not FunCotacao.ExisteOpGerada(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger,true) then
     begin
       FNovaCotacao := TFNovaCotacao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
       if FNovaCotacao.AlteraCotacao(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger) then
       begin
         AtualizaConsulta(true);
       end;
       FNovaCotacao.free;
     end;
   end;
end;

{*****************Chama a rotina para extornar o orçamento*********************}
procedure TFCotacao.BtExtornarClick(Sender: TObject);
begin
  ExtornaOrcamento;
end;

{*************************Extorna o MovOrcamento*******************************}
procedure TFCotacao.ExtornaOrcamento;
var
  VpfResultado : string;
begin
  VpfResultado := '';
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    if ((CadOrcamentoC_GER_FIN.AsString = 'S') or (CadOrcamentoC_NOT_GER.AsString = 'S'))and
       not(puPLAlterarExcluirDepoisFaturado in varia.PermissoesUsuario)   then
      VpfResultado := 'USUÁRIO SEM PERMISSÃO!!!'#13'Esse usuário não possui permissão para estornar pedidos depois de faturados';
  end;
  if VpfResultado = '' then
  begin
    if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
    begin
      if Confirmacao(CT_EXTORNAR) then
      begin
        FunCotacao.ExtornaOrcamento(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
        AtualizaConsulta(true);
      end;
    end;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{************************* gera a nota fiscal *********************************}
procedure TFCotacao.BGeraNotaClick(Sender: TObject);
begin
  VprGerandoNota := true;
  GeraNotaFiscal;
  AtualizaConsulta(true);
  VprGerandoNota := false;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFCotacao.BFecharClick(Sender: TObject);
begin
  Close;
end;

{***************************Imprime o orcamento********************************}
procedure TFCotacao.BRepresentadaClick(Sender: TObject);
begin
  GraficoRepresentada;
end;

{******************************************************************************}
procedure TFCotacao.BRomaneioClick(Sender: TObject);
var
  VpfDFilial :TRBDFilial;
  VpfFunECF : TRBFuncoesECF;
begin
  if (varia.NomeModulo = 'PDV') and (varia.ModoImpressaoDAV = idFiscal) then
  begin
    VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
    VprDOrcamento.LanOrcamento := CadOrcamentoI_Lan_Orc.AsInteger;
    FunCotacao.CarDOrcamento(VprDOrcamento);
    VpfFunECF := TRBFuncoesECF.cria(nil,FPrincipal.BaseDados);
    VpfFunECF.ImprimeDAVFiscal(VprDOrcamento,nil);
    VpfFunECF.Free;
  end
  else
  begin
    if (puPLNaoImprimeCotacaoJaImpressa in varia.PermissoesUsuario) then
    begin
      FunCotacao.CarDOrcamento(VprDOrcamento);
      VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
      VprDOrcamento.LanOrcamento := CadOrcamentoI_Lan_Orc.AsInteger;
      if FunCotacao.RSePedidoFoiImpresso(varia.CodigoEmpFil, VprDOrcamento.LanOrcamento) then
      begin
        aviso('JA IMPRESSO!!!' + #13 + 'Impossivel reimpressão.');
        exit;
      end
    end;
    if not Config.ImprimirPedEmPreImp then
    begin
      try
        dtRave := TdtRave.create(self);
        dtRave.ImprimePedido(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger,true);
      finally
        dtRave.free;
      end;
    end
    else
    begin
      VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
      VprDOrcamento.LanOrcamento := CadOrcamentoI_Lan_Orc.AsInteger;
      FunCotacao.CarDOrcamento(VprDOrcamento);
      FunCotacao.CarDParcelaOrcamento(VprDOrcamento);
      FunImpressao.ImprimirPedido(VprDOrcamento);
    end;
  end;

  FunCotacao.SetaOrcamentoImpresso1(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_lan_orc.AsInteger);
  if Varia.EstagioImpressao <> 0 then
    FunCotacao.GravaLogEstagio(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_lan_orc.AsInteger,varia.EstagioImpressao,varia.CodigoUsuario,'');

  AtualizaConsulta(True);
end;

{************************ cadastra um novo orcamento **************************}
procedure TFCotacao.BCadastrarClick(Sender: TObject);
begin
  FNovaCotacao := TFNovaCotacao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
  FNovaCotacao.NovaCotacao;
  FNovaCotacao.free;
  AtualizaConsulta;
end;

{********************** mostra ou nao os filtros ******************************}
procedure TFCotacao.BMaisClick(Sender: TObject);
begin
  PanelColor1.Visible := not BMais.Down;
end;

{************************** consulta o orcamento ******************************}
procedure TFCotacao.BConsultaClick(Sender: TObject);
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    FNovaCotacao := TFNovaCotacao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
    FNovaCotacao.ConsultaCotacao(CadOrcamentoI_EMP_FIL.AsString, CadOrcamentoI_Lan_Orc.Asstring);
    FNovaCotacao.free;
  end;
end;

{****************** chama a rotina para limpar os filtros *********************}
procedure TFCotacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key  of
    Vk_f5 : LimpaFiltros;
    Vk_f8 : AlteraEstagio;
    vk_Up :
      if PossuiFoco(PanelColor1) Then
      begin
        GOrcamento.setfocus;
        Atualizaconsulta;
        IF not MovOrcamentos.bof then
          MovOrcamentos.prior;
      end;
    vk_Down :
      if PossuiFoco(PanelColor1) Then
      begin
        GOrcamento.setfocus;
        Atualizaconsulta;
        if not MovOrcamentos.Eof then
          MovOrcamentos.next;
      end;
  end;
  if (Shift = [ssCtrl]) and (key = 65) then
    SelecionaTodasLinhas;

  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
        if (key = 87) then
        begin
          GeraFinanceiro;
          VprPressionadoR := false;
        end
        else
          VprPressionadoR := false;
  end;

end;

{******************* Mostra os graficos ***************************************}
procedure TFCotacao.BGraficosClick(Sender: TObject);
begin
  PanelColor1.Enabled := false;
  PanelColor2.Enabled := false;
  GOrcamento.Enabled := false;
  GridMov.Enabled := false;
  PGraficos.Top := 16;
  PGraficos.Visible := true;
end;

{**************** atualiza a consulta com os totais ***************************}
procedure TFCotacao.CTotalClick(Sender: TObject);
var
  vpfPosicao : TBookmark;
begin
  VpfPosicao := Cadorcamento.GetBookmark;
  AtualizaConsulta;
  CadOrcamento.GotoBookmark(VpfPosicao);
  CadOrcamento.FreeBookmark(VpfPosicao);
end;


{******************************************************************************}
procedure TFCotacao.VisualizaFracaoFaccionista(VpaCodFilial,VpaLanOrcamento: Integer);
begin
   AdicionaSQLAbreTabela(Aux,'Select SEQORD FROM ORDEMPRODUCAOCORPO '+
                             ' Where LANORC = '+ IntToStr(VpaLanOrcamento)+
                             ' and EMPFIL = ' + IntToStr(VpaCodfilial));
   while not aux.Eof do
   begin
     FFracaoFaccionista := TFFracaoFaccionista.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCotacao'));
     FFracaoFaccionista.ConsultaFracaoPedido(CadOrcamentoI_EMP_FIL.AsInteger, Aux.FieldByName('SEQORD').AsInteger);
     FFracaoFaccionista.free;
     Aux.Next;
   end;
    Aux.close;
end;

{****************** vizualiza as notas do orcamento ***************************}
procedure TFCotacao.VisualizaNotas(VpaCodFilial, VpaLanOrcamento : Integer);
var
  VpfDNotaFiscal : TRBDNotaFiscal;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_EMP_FIL, I_Seq_Not from MOVNOTAORCAMENTO '+
                            ' Where I_Fil_ORC = '+ InttoStr(VPACodfilial) +
                            ' and I_Lan_Orc = '+ InttoStr(VpaLanOrcamento));
  While not Aux.Eof do
  begin
    VpfDNotaFiscal := TRBDNotaFiscal.cria;
    VpfDNotaFiscal.CodFilial := Aux.FieldByName('I_EMP_FIL').AsInteger;
    VpfDNotaFiscal.SeqNota := Aux.FieldByName('I_Seq_Not').AsInteger;
    FunNotaFiscal.CarDNotaFiscal(VpfDNotaFiscal);
    FNovaNotaFiscalNota := TFNovaNotaFiscalNota.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
    FNovaNotaFiscalNota.ConsultaNota(VpfDNotaFiscal);
    FNovaNotaFiscalNota.free;
    Aux.Next;
  end;
  Aux.close;
end;

{******************************************************************************}
procedure TFCotacao.GeraFinanceiro;
var
  VpfResultado : String;
  VpfDContasAReceber : TRBDContasCR;
  VpfTransacao : TTransactionDesc;
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    MostraPedidosPendentesAFaturar;
    VprDOrcamento.Free;
    VprDOrcamento := TRBDOrcamento.cria;
    FunCotacao.CarDOrcamento(VprDOrcamento,CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger );
    if (VprDOrcamento.FinanceiroGerado) or (VprDOrcamento.IndNotaGerada) then
      if not Confirmacao('FINANCEIRO DUPLICADO!!!'#13'O financeiro desse orçamento já foi gerado, tem certeza que deseja gerar novamente?') then
        exit; //sai fora e não gera o financeiro
    VpfTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VpfTransacao);
    VpfDContasAReceber := TRBDContasCR.cria;
    if FunCotacao.GeraFinanceiro(VprDOrcamento,nil,VpfDContasAReceber, FunContasAReceber,VpfResultado,true,false) then
    begin
      if VpfResultado ='' then
      begin
        FunCotacao.SetaFinanceiroGerado(VprDOrcamento);
        VprDOrcamento.FinanceiroGerado := true;
        if VprDOrcamento.CodOperacaoEstoque <> 0 then
        begin
          VpfResultado := FunCotacao.GeraEstoqueProdutos(VprDOrcamento,FunProdutos);
          if VpfResultado = '' then
            FunCotacao.BaixaEstoqueOrcamento(VprDOrcamento);
        end;
        if VpfResultado = '' then
          FPrincipal.BaseDados.Commit(VpfTransacao);
        PainelTempo1.fecha;
        AtualizaConsulta(true);
      end;
    end;
    if VpfResultado <> '' then
    begin
      FPrincipal.BaseDados.Rollback(VpfTransacao);
      aviso(VpfResultado);
    end;

    VpfDContasAReceber.free;
  end;
end;

{******************************************************************************}
procedure TFCotacao.MostraPedidosPendentesAFaturar;
begin
  if config.QuandoGerarFinanceiorMostrarCotacoesNaoFaturadas then
  begin
    FPedidosPendentesFaturar := TFPedidosPendentesFaturar.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPedidosPendentesFaturar'));
    FPedidosPendentesFaturar.MosraPedidosPendentes(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger,CadOrcamentoI_COD_CLI.AsInteger);
    FPedidosPendentesFaturar.free;
  end;
end;

{******************************************************************************}
procedure TFCotacao.ConfiguraTela;
begin
  GridMov.Columns[RIndiceColuna(GridMov,'NOMEPRODUTO')].Width := VARIA.LarguraColunaProdutoConsulta ;
  GridMov.Columns[RIndiceColuna(GridMov,'C_DES_COR')].Width := VARIA.LarguraColunaCorConsulta ;
end;

{******************************************************************************}
procedure TFCotacao.AlteraEstagio;
var
  VpfPosicao : TBookmark;
  VpfCotacoes : String;
begin
  VpfCotacoes := '';
  VpfPosicao := CadOrcamento.GetBookmark;
  CadOrcamento.First;
  While not CadOrcamento.Eof do
  begin
    if GOrcamento.SelectedRows.CurrentRowSelected then
    begin
      if CadOrcamentoI_EMP_FIL.AsInteger <> varia.CodigoEmpFil then
        aviso('FILIAL INVÁLIDA!!!'#13'Só é possivel alterar o estágio das cotações da filial ativa...')
      else
        VpfCotacoes := VpfCotacoes +CadOrcamentoI_Lan_Orc.AsString + ',';
    end;
    CadOrcamento.next;
  end;
  if VpfCotacoes <> '' then
  begin
    VpfCotacoes := copy(VpfCotacoes,1,Length(VpfCotacoes)-1);
    FAlteraEstagioCotacao := TFAlteraEstagioCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao(''));
    if FAlteraEstagioCotacao.AlteraEstagioCotacoes(VpfCotacoes) then
      AtualizaConsulta(false);
    FAlteraEstagioCotacao.free;
  end
  else
    Aviso('FALTA SELECIONAR COTAÇÃO!!!'#13'É necessário selecionar as cotações que se deseja alterar');

  try
    CadOrcamento.GotoBookmark(vpfPosicao);
  except
  end;
  CadOrcamento.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFCotacao.MAprovaAmostraClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if MovOrcamentosI_EMP_FIL.AsInteger <> 0 then
  begin
    VpfREsultado := FunCotacao.AprovaAmostra(MovOrcamentosI_EMP_FIL.AsInteger,MovOrcamentosI_LAN_ORC.AsInteger,MovOrcamentosI_SEQ_MOV.AsInteger);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      PosMovOrcamento(MovOrcamentosI_EMP_FIL.AsString,MovOrcamentosI_LAN_ORC.AsString);
  end;
end;

{******************************************************************************}
procedure TFCotacao.SelecionaTodasLinhas;
begin
  CadOrcamento.First;
  while not CadOrcamento.Eof do
  begin
    GOrcamento.SelectedRows.CurrentRowSelected := true;
    CadOrcamento.Next;
  end;
end;

{******************************************************************************}
procedure TFCotacao.BPendentesClick(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimePedidoPendente(EFilial.AInteiro,ECliente.AInteiro,EClienteMaster.AInteiro, VprSeqProduto,ETipoCotacao.AInteiro, EPreposto.AInteiro, ECor.AInteiro, ERepresentada.AInteiro, EClassificacao.Text,lNomClassificacao.caption,LCliente.Caption,LTipoCotacao.Caption,LPreposto.Caption,LRepresentada.Caption, DataInicial.DateTime,DataFinal.DateTime,true, false,EImpressaoEmbalagem.Checked, CProdutoSolda.Checked);
  dtRave.free;
end;

{******************************************************************************}
procedure TFCotacao.BImprimeOPClick(Sender: TObject);
var
  VpfQtdVias : String;
  VpfLaco : Integer;
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    VpfQtdVias := '1';
    if Varia.CNPJFilial = cNPJ_Veneto then
      if not EntradaNumero('Vias de Impressão','Qtd de vias',VpfQtdVias,false,ECotacao.Color,PanelColor1.Color,false) then
        exit;
    try
      dtRave := TdtRave.Create(self);
      dtRave.ImprimeCotacaocomoOrdemProducao(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger,StrToInt(VpfQtdVias));
    finally
      dtRave.Free;
    end;
  end;
end;

{******************************************************************************}
procedure TFCotacao.BGerarOPClick(Sender: TObject);
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    GeraOrdemProducao;
  end;
end;

{******************************************************************************}
procedure TFCotacao.GOrcamentoDblClick(Sender: TObject);
var
  VpfMouseinGrid : TPoint;
  VpfGridCoord :  TGridCoord;
begin
  if (BAlterar.Enabled) and (BAlterar.Visible) then
    BAlterar.Click;
end;

{******************************************************************************}
procedure TFCotacao.BEstadoClick(Sender: TObject);
begin
  GraficoUF;
end;

{******************************************************************************}
procedure TFCotacao.CNaoFaturadosClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFCotacao.BEtiquetaClick(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfResultado := CarCotacoesSelecionadas(VprCotacoesGerarNota,true);
  if VpfResultado = '' then
  begin
    FImprimiEtiqueta := TFImprimiEtiqueta.CriarSDI(application , '', FPrincipal.VerificaPermisao('FImprimiEtiqueta'));
    FImprimiEtiqueta.ImprimeEtiquetas(VprCotacoesGerarNota);
    FImprimiEtiqueta.free;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFCotacao.BFiltrosClick(Sender: TObject);
begin
  if BFiltros.Caption = '>>' then
  begin
    PanelColor1.Height := ERepresentada.Top + ERepresentada.Height + 5;
    BFiltros.Caption := '<<';
  end
  else
  begin
    PanelColor1.Height := ECotacao.Top + ECotacao.Height + 2;
    BFiltros.Caption := '>>';
  end;
end;

procedure TFCotacao.PTotalClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFCotacao.MGeraRomaneioParcialClick(Sender: TObject);
begin
  if FunClientes.VerificaseClienteEstaBloqueado(CadOrcamentoI_COD_CLI.AsInteger) then
  begin
    aviso('CLIENTE BLOQUEADO!! Consulte o financeiro.');
  end
  else
  begin
    if not CadOrcamentoI_Lan_Orc.IsNull then
    begin
      FBaixaParcialCotacao := TFBaixaParcialCotacao.CriarSDI(application , '', FPrincipal.VerificaPermisao('FBaixaParcialCotacao'));
      VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
      VprDOrcamento.LanOrcamento :=  CadOrcamentoI_Lan_Orc.AsInteger;
      FunCotacao.CarDOrcamento(VprDOrcamento);
      if FBaixaParcialCotacao.GeraBaixaParcial(VprDOrcamento,false) then
        AtualizaConsulta(true);
      FBaixaParcialCotacao.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFCotacao.MConsultaRomaneiosParciaisClick(Sender: TObject);
begin
  FConsultaBaixaParcial := TFConsultaBaixaParcial.CriarSDI(application , '', FPrincipal.VerificaPermisao('FConsultaBaixaParcial'));
  FConsultaBaixaParcial.ConsultaBaixasParciais(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
  FConsultaBaixaParcial.free;
end;

{******************************************************************************}
procedure TFCotacao.MEnviarEmailClick(Sender: TObject);
var
  VpfDCliente : TRBDCliente;
  VpfResultado : string;
begin
  if MovOrcamentosI_LAN_ORC.AsInteger <> 0 then
  begin
    VprDOrcamento.Free;
    VprDOrcamento := TRBDOrcamento.cria;
    FunCotacao.CarDOrcamento(VprDOrcamento,CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VprDOrcamento.CodCliente;
    FunClientes.CarDCliente(VpfDCliente);
    FunCotacao.CarDParcelaOrcamento(VprDOrcamento);

    VpfResultado :=  FunCotacao.EnviaEmailCliente(VprDOrcamento,VpfDCliente);
    VpfDCliente.free;
    if VpfResultado <> '' then
      aviso(vpfREsultado);
  end;
end;

{******************************************************************************}
procedure TFCotacao.OrdemCarregamento1Click(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFCotacao.BGeraCupomClick(Sender: TObject);
var
  VpfGerar : Boolean;
begin
  PainelTempo1.execute('Gerando cupom fiscal...');
  if not CadOrcamentoI_Lan_Orc.IsNull then
  begin
    VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
    VprDOrcamento.LanOrcamento := CadOrcamentoI_Lan_Orc.AsInteger;
    FunCotacao.CarDOrcamento(VprDOrcamento);
    if VprDOrcamento.IndNotaGerada then
      VpfGerar := Confirmacao('CUPOM FISCAL JÁ GERADO!!!'#13'Para este orçamento já foi gerado um cupom fiscal, tem certeza que deseja gerar novamente?')
    else
      VpfGerar := true;
    if VpfGerar then
    begin
      FNovoECF := TFNovoECF.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoECF'));
      if FNovoECF.GeraECFAPartirCotacao(VprDOrcamento) then
      begin
        VprDOrcamento.IndNotaGerada := true;
        FunCotacao.GravaDCotacao(VprDOrcamento,nil);
        AtualizaConsulta(true);
      end;
      FNovoECF.free;
    end;
  end;
  PainelTempo1.fecha;
end;

{******************************************************************************}
procedure TFCotacao.ETelefoneKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF KEY = 13 then
    AtualizaConsulta;
end;

procedure TFCotacao.MConsultaOPClick(Sender: TObject);
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    if config.CadastroCadarco then
    begin
      FOrdensProducaoCadarco := TFOrdensProducaoCadarco.CriarSDI(application,'', FPrincipal.VerificaPermisao('FOrdensProducaoCadarco'));
      FOrdensProducaoCadarco.ConsultaOPCotacao(CadOrcamentoI_Lan_Orc.AsInteger);
      FOrdensProducaoCadarco.free;
    end
    else
    begin
      FOrdemProducaoGenerica := TFOrdemProducaoGenerica.CriarSDI(self,'',FPrincipal.VerificaPermisao('FOrdemProducaoGenerica'));
      FOrdemProducaoGenerica.ConsultaOPsPedido(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
      FOrdemProducaoGenerica.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFCotacao.ECotacaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

procedure TFCotacao.EImpressaoEmbalagemClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFCotacao.MAlterarClienteClick(Sender: TObject);
begin
  if CadOrcamentoI_COD_CLI.AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoCliente'));
    AdicionaSqlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+CadOrcamentoI_COD_CLI.AsString);
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    FNovoCliente.Free;
  end;
end;

{******************************************************************************}
procedure TFCotacao.MDuplicarOrcamentoClick(Sender: TObject);
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    FNovaCotacao := TFNovaCotacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaCotacao'));
    if FNovaCotacao.DuplicarPedido(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger) then
      AtualizaConsulta;
    FNovaCotacao.free;
  end;
end;

{******************************************************************************}
procedure TFCotacao.MReciboClick(Sender: TObject);
var
  VpfDCliente : TRBDCliente;
begin
  if not CadOrcamentoI_Lan_Orc.IsNull then
  begin
    VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
    VprDOrcamento.LanOrcamento :=  CadOrcamentoI_Lan_Orc.AsInteger;
    FunCotacao.CarDOrcamento(VprDOrcamento);
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := CadOrcamentoI_COD_CLI.AsInteger;
    FunClientes.CarDCliente(VpfDCliente,false,false,false);
    try
      dtRave := TdtRave.create(self);
      dtRave.ImprimeRecibo(varia.CodigoEmpFil,VpfDCliente,IntToStr(VprDOrcamento.LanOrcamento),FormatFloat('#,###,##0.00',VprDOrcamento.ValTotal),Extenso(VprDOrcamento.ValTotal,'reais','real'),varia.CidadeFilial+' '+ IntTostr(dia(date))+', de ' + TextoMes(date,false)+ ' de '+Inttostr(ano(date)),varia.NomeFilial);
    finally
      dtRave.free;
    end;
    VpfDCliente.free;
  end;
end;

{******************************************************************************}
procedure TFCotacao.MBaixarNumeroClick(Sender: TObject);
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    if FunCotacao.BaixaNumero(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger) then
    begin
      VprValBaixas := VprValBaixas +CadOrcamentoN_Vlr_TOT.AsFloat;
      inc(VprQtdBaixas);
      EValorTotal.Text := FormatFloat(varia.MascaraValorUnitario,VprValBaixas);
      EQtdTotal.Text := IntToStr(VprQtdBaixas);
    end;
  end;
end;

{******************************************************************************}
procedure TFCotacao.MAlterarVendedorClick(Sender: TObject);
begin
  IF CadOrcamentoI_EMP_FIL.AsInteger = Varia.CodigoEmpFil then
  begin
    FAlteraVendedorCotacao := TFAlteraVendedorCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraVendedorCotacao'));
    VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
    VprDOrcamento.LanOrcamento := CadOrcamentoI_Lan_Orc.AsInteger;
    FunCotacao.CarDOrcamento(VprDOrcamento);
    if FAlteraVendedorCotacao.AlteraVendedor(VprDOrcamento) then
      AtualizaConsulta(true);
    FAlteraVendedorCotacao.free;
  end
  else
    aviso('FILIAL ATIVA INVALIDA!!!'#13'A filial da cotação é diferente da filial logada no sistema, para alterar o vendedor é necessário alterar a filial em uso.');
end;

{******************************************************************************}
procedure TFCotacao.BGraficoRegiaVendasClick(Sender: TObject);
begin
  GraficoRegiaoVenda;
end;

{******************************************************************************}
procedure TFCotacao.BGraficoHoraClick(Sender: TObject);
begin
  GraficoHora;
end;

{******************************************************************************}
procedure TFCotacao.MAlteraTaxaEntregaClick(Sender: TObject);
var
  VpfValor,VpfResultado : String;
  VpfDCliente : TRBDCliente;
begin
  VpfValor := CadOrcamentoN_VAL_TAX.AsString;
  if EntradaNumero('Alterar Taxa de Entrega','Taxa Entrega : ',VpfValor,false,ECliente.color,PanelColor1.color,true) then
  begin
    VprDOrcamento.Free;
    VprDOrcamento := TRBDOrcamento.cria;
    VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
    VprDOrcamento.LanOrcamento := CadOrcamentoI_LAN_ORC.AsInteger;
    FunCotacao.CarDOrcamento(VprDOrcamento);
    VprDOrcamento.ValTaxaEntrega := StrToFloat(VpfValor);
    FunCotacao.CalculaValorTotal(VprDOrcamento);
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VprDOrcamento.CodCliente;
    FunClientes.CarDCliente(VpfDCliente);
    VpfResultado := FunCotacao.GravaDCotacao(VprDOrcamento,VpfDCliente);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsulta(true);
    VpfDCliente.free;
  end;
//
end;

procedure TFCotacao.MAlterarPrepostoClick(Sender: TObject);
begin
  IF CadOrcamentoI_EMP_FIL.AsInteger = Varia.CodigoEmpFil then
  begin
    FAlteraVendedorCotacao := TFAlteraVendedorCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraVendedorCotacao'));
    VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
    VprDOrcamento.LanOrcamento := CadOrcamentoI_Lan_Orc.AsInteger;
    FunCotacao.CarDOrcamento(VprDOrcamento);
    if FAlteraVendedorCotacao.AlteraPreposto(VprDOrcamento) then
      AtualizaConsulta(true);
    FAlteraVendedorCotacao.free;
  end
  else
    aviso('FILIAL ATIVA INVALIDA!!!'#13'A filial da cotação é diferente da filial logada no sistema, para alterar o vendedor é necessário alterar a filial em uso.');
end;

{******************************************************************************}
procedure TFCotacao.MGerarFichaImplantacaoClick(Sender: TObject);
var
  VpfResultado : String ;
begin
  IF CadOrcamentoI_EMP_FIL.AsInteger = Varia.CodigoEmpFil then
  begin
    VprDOrcamento.free;
    VprDOrcamento := TRBDOrcamento.cria;
    VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
    VprDOrcamento.LanOrcamento := CadOrcamentoI_Lan_Orc.AsInteger;
    FunCotacao.CarDOrcamento(VprDOrcamento);
    VpfResultado := FunChamado.GeraFichaImplantacaoChamado(VprDOrcamento);
    if Vpfresultado = '' then
      aviso('Ficha Implantação gerada com sucesso!!!')
    else
      aviso(vpfresultado);
  end;
end;

{******************************************************************************}
procedure TFCotacao.MVisualizarNotaClick(Sender: TObject);
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
    VisualizaNotas(CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
end;

{******************************************************************************}
procedure TFCotacao.BCancelarClick(Sender: TObject);
begin
    CancelaOrcamento;
end;

{******************************************************************************}
procedure TFCotacao.GOrcamentoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (varia.CnpjFilial = CNPJ_ZUMM) or
     (varia.CNPJFilial = CNPJ_ZummH) or
     (varia.CNPJFilial = CNPJ_ZummSP) or
     (varia.CNPJFilial = CNPJ_ZummNeumarkt) then
  begin
      if (CadOrcamentoC_NUM_BAI.AsString = 'S') then
      begin
        GOrcamento.Canvas.Brush.Color:= clOlive;
        GOrcamento.DefaultDrawDataCell(Rect, GOrcamento.columns[datacol].field, State);
      end;
      if CadOrcamentoC_IND_CAN.AsString = 'S' then
      begin
        GOrcamento.Canvas.brush.Color:= clred; // coloque aqui a cor desejada
        GOrcamento.DefaultDrawDataCell(Rect, GOrcamento.columns[datacol].field, State);
      end;
  end
  else
  begin
    if (State = [gdSelected]) then
    begin
      GOrcamento.Canvas.Font.Color:= clWhite;
      GOrcamento.DefaultDrawDataCell(Rect, GOrcamento.columns[datacol].field, State);
    end
    else
      begin
        if (CadOrcamentoC_NUM_BAI.AsString = 'S') or (CadOrcamentoC_GER_FIN.AsString = 'S') or
           ((CadOrcamentoC_FLA_SIT.AsString = 'E')and not config.BaixarEstoqueCotacao and
             not config.ControlarASeparacaodaCotacao) then
        begin
          GOrcamento.Canvas.Font.Color:= clGreen;
          GOrcamento.DefaultDrawDataCell(Rect, GOrcamento.columns[datacol].field, State);
        end;
      end;
      if CadOrcamentoC_IND_CAN.AsString = 'S' then
      begin
        GOrcamento.Canvas.Font.Color:= clred;
        GOrcamento.DefaultDrawDataCell(Rect, GOrcamento.columns[datacol].field, State);
      end;
  end;
end;

{******************************************************************************}
procedure TFCotacao.MIniciarSeparacaoClick(Sender: TObject);
var
  VpfResultado : String;
  VpfDCotacao : TRBDOrcamento;
begin
 VpfResultado:= '';
 if FunClientes.VerificaseClienteEstaBloqueado(CadOrcamentoI_COD_CLI.AsInteger) then
 begin
   aviso('CLIENTE BLOQUEADO!! Consulte o financeiro.');
 end
 else
 begin
   if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
    begin
      VpfDCotacao := TRBDOrcamento.cria;
      FunCotacao.CarDOrcamento(VpfDCotacao,CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
      if not (CadOrcamentoI_TIP_ORC.AsInteger = varia.TipoCotacaoPedido) then
        VpfResultado := FunCotacao.AlteraCotacaoParaPedido(VpfDCotacao);

      if VpfResultado = '' then
      begin
        if config.ImprimirOPQuandoIniciarSeparacao then
        begin
          BImprimeOP.Click;
          FunCotacao.ImprimeEtiquetaSeparacaoPedido(VpfDCotacao);
        end;
      end;


      if VpfResultado <> '' then
        aviso(VpfResultado);

      VpfDCotacao.free;
    end;
 end;
end;

{******************************************************************************}
procedure TFCotacao.MEnvioParcialClick(Sender: TObject);
var
  VpfLanOrcamentoRetorno : Integer;
begin
  if not CadOrcamentoI_Lan_Orc.IsNull then
  begin
    if confirmacao('Tem certeza que deseja gerar um complemento do pedido?') then
    begin
      FunCotacao.CarDOrcamento(VprDOrcamento,CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
      FunCotacao.GeraComplementoCotacao(VprDOrcamento,VpfLanOrcamentoRetorno);

      FNovaCotacao := TFNovaCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
      if FNovaCotacao.AlteraCotacao(varia.CodigoEmpFil,VpfLanOrcamentoRetorno) then
        AtualizaConsulta(true);
      FNovaCotacao.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFCotacao.BMenuFiscalClick(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

{******************************************************************************}
procedure TFCotacao.BMesClick(Sender: TObject);
begin
  GraficoMes;
end;

{******************************************************************************}
procedure TFCotacao.EClassificacaoExit(Sender: TObject);
var
  VpfNomClassificacao : String;
begin
  if EClassificacao.Text <> '' then
  begin
    if not FunClassificacao.ValidaClassificacao(EClassificacao.Text,VpfNomClassificacao, 'P') then
    begin
      if not LocalizaClassificacao then
        EClassificacao.SetFocus;
    end
    else
    begin
      LNomClassificacao.Caption:= VpfNomClassificacao;
    end;
  end
  else
    LNomClassificacao.Caption:= '';
  AtualizaConsulta;    
end;

{******************************************************************************}
function TFCotacao.LocalizaClassificacao : Boolean;
var
  VpfCodClassificacao, VpfNomClassificacao : string;
begin
  Result:= True;
  FLocalizaClassificacao:= TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomClassificacao, 'P') then
  begin
    EClassificacao.Text:= VpfCodClassificacao;
    LNomClassificacao.Caption:= VpfNomClassificacao;
    AtualizaConsulta;
  end
  else
    Result:= False;
end;

{******************************************************************************}
procedure TFCotacao.EClassificacaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFCotacao.SpeedButton9Click(Sender: TObject);
begin
  LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFCotacao.MExportaProdutosPendentesClick(Sender: TObject);
begin
  FunCotacao.ExportaProdutosPendentes(DataInicial.Date,DataFinal.Date);
end;

{******************************************************************************}
procedure TFCotacao.MovOrcamentosCalcFields(DataSet: TDataSet);
begin
  if (config.PermiteAlteraNomeProdutonaCotacao) and (MovOrcamentos.FieldByName('PRODUTOCOTACAO').AsString <> '' )then
    MovOrcamentosNOMEPRODUTO.AsString := MovOrcamentos.FieldByName('PRODUTOCOTACAO').AsString
  else
    MovOrcamentosNOMEPRODUTO.AsString := MovOrcamentos.FieldByName('C_NOM_PRO').AsString;
end;

{******************************************************************************}
procedure TFCotacao.MPedidosPendentesSemClienteMasterClick(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimePedidoPendente(EFilial.AInteiro,ECliente.AInteiro,EClienteMaster.AInteiro, VprSeqProduto,ETipoCotacao.AInteiro, EPreposto.AInteiro, ECor.AInteiro, ERepresentada.AInteiro, EClassificacao.Text,lNomClassificacao.caption,LCliente.Caption, LTipoCotacao.Caption,LPreposto.Caption,LRepresentada.Caption, DataInicial.DateTime,DataFinal.DateTime,false);
  dtRave.free;
end;

{******************************************************************************}
procedure TFCotacao.MCancelarSaldoClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if FunClientes.VerificaseClienteEstaBloqueado(CadOrcamentoI_COD_CLI.AsInteger) then
  begin
    aviso('CLIENTE BLOQUEADO!! Consulte o financeiro.');
  end
  else
  begin
    if MovOrcamentosI_EMP_FIL.AsInteger <> 0 then
    begin
      VpfREsultado := FunCotacao.CancelaSaldoItemOrcamento(MovOrcamentosI_EMP_FIL.AsInteger,MovOrcamentosI_LAN_ORC.AsInteger,MovOrcamentosI_SEQ_MOV.AsInteger);
      if VpfResultado <> '' then
        aviso(VpfResultado)
      else
        AtualizaConsulta(true);
    end;
  end;
end;

{******************************************************************************}
procedure TFCotacao.MMarcarOPGeradaClick(Sender: TObject);
begin
  if CadOrcamentoI_Lan_Orc.AsInteger <> 0 then
  begin
    FreeTObjectsList(VprCotacoesGerarNota);
    VprDOrcamento := TRBDOrcamento.cria;
    FunCotacao.CarDOrcamento(VprDOrcamento,CadOrcamentoI_EMP_FIL.AsInteger,CadOrcamentoI_Lan_Orc.AsInteger);
    VprCotacoesGerarNota.add(VprDOrcamento);
    FunCotacao.SetaOPImpressa(VprCotacoesGerarNota);
    AtualizaConsulta;
    VprCotacoesGerarNota.Delete(0);
  end;
end;

{******************************************************************************}
procedure TFCotacao.MConferenciaSeparacaoClick(Sender: TObject);
begin
  if FunClientes.VerificaseClienteEstaBloqueado(CadOrcamentoI_COD_CLI.AsInteger) then
 begin
   aviso('CLIENTE BLOQUEADO!! Consulte o financeiro.');
 end
 else
 begin
   if not CadOrcamentoI_Lan_Orc.IsNull then
   begin
     FBaixaParcialCotacao := TFBaixaParcialCotacao.CriarSDI(application , '', FPrincipal.VerificaPermisao('FBaixaParcialCotacao'));
     VprDOrcamento.CodEmpFil := CadOrcamentoI_EMP_FIL.AsInteger;
     VprDOrcamento.LanOrcamento :=  CadOrcamentoI_Lan_Orc.AsInteger;
     FunCotacao.CarDOrcamento(VprDOrcamento);
     if FBaixaParcialCotacao.GeraBaixaParcial(VprDOrcamento,true) then
       AtualizaConsulta(true);
     FBaixaParcialCotacao.free;
   end;
 end;
end;

Initialization
{ *************** Registra a classe paraprocedure  evitar duplicidade ****************** }
 RegisterClasses([TFCotacao]);
end.
