unit ANovaNotaFiscalNota;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  DBTables, ConvUnidade, DBKeyViolation, Localizacao, Db,
  Tabela, BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls,
  PainelGradiente, Grids, DBCtrls, Mask, DBGrids, UnNotaFiscal, Spin, Constantes,
  numericos, UnImpressao, ShellApi, UnProdutos, UnCotacao,  UnContasAReceber,
  UnDados, UnClientes,UnComissoes, UnDadosCR, UnDadosProduto, CGrades, UnSistema,
  Parcela, ComCtrls, UnOrdemProducao, UnImpressaoBoleto, Menus,  UnClassesImprimir,
  FMTBcd, SqlExpr, DBClient, ACBrNFeDANFEClass, ACBrNFeDANFERave,UnDadosLocaliza,  UnNFE,
  UnArgox, Mapi;

Const
  CT_DATAMENORULTIMOFECHAMENTO='DATA NÃO PODE SER MENOR QUE A DO ÚLTIMO FECHAMENTO!!!A data de digitação do produto não ser menor que a data do ultimo fechamento...';


type
  TFNovaNotaFiscalNota = class(TFormularioPermissao)
    FundoNota: TScrollBox;
    Shape4: TShape;
    Shape5: TShape;
    Shape3: TShape;
    Shape20: TShape;
    Shape12: TShape;
    Label21: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Shape10: TShape;
    Label18: TLabel;
    Shape11: TShape;
    Label19: TLabel;
    Label20: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Label22: TLabel;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Label24: TLabel;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Label39: TLabel;
    Label40: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label25: TLabel;
    LIEFilial: TLabel;
    Label73: TLabel;
    Label78: TLabel;
    LNomFilial: TLabel;
    SpeedButton1: TSpeedButton;
    MObservacoes: TMemoColor;
    ECodCliente: TRBEditLocaliza;
    Panel1: TPanelColor;
    BtbImprimeBoleto: TBitBtn;
    BotaoCadastrar1: TBitBtn;
    BotaoGravar1: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    BotaoCancelar1: TBitBtn;
    BObservacao: TBitBtn;
    Localiza: TConsultaPadrao;
    Aux: TSQLQUERY;
    MovNatureza: TSQL;
    LCGCFilial: TLabel;
    Panel2: TPanel;
    GRADEPAR: TStringGrid;
    LTituloFaturas: TLabel;
    PTotais: TPanel;
    Shape6: TShape;
    Shape37: TShape;
    Label41: TLabel;
    Shape32: TShape;
    Label42: TLabel;
    Shape33: TShape;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Shape34: TShape;
    Shape35: TShape;
    Shape36: TShape;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Shape38: TShape;
    Shape39: TShape;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Shape40: TShape;
    Shape41: TShape;
    Shape42: TShape;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Shape43: TShape;
    Label62: TLabel;
    Shape44: TShape;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Shape45: TShape;
    Shape46: TShape;
    Shape47: TShape;
    Shape48: TShape;
    Shape49: TShape;
    Shape50: TShape;
    Shape51: TShape;
    Label4: TLabel;
    Shape52: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label23: TLabel;
    Label71: TLabel;
    SpeedButton2: TSpeedButton;
    Label72: TLabel;
    SpeedButton3: TSpeedButton;
    BCondicao: TSpeedButton;
    LNomCondicao: TLabel;
    Label36: TLabel;
    EPlacaVeiculo: TEditColor;
    ECodTipoFrete: Tnumerico;
    EBaseICMS: TNumerico;
    EValFrete: TNumerico;
    EValTotalProdutos: TNumerico;
    EValSubsICM: TNumerico;
    EBaseSubICMS: TNumerico;
    EValICMS: Tnumerico;
    EValSeguro: TNumerico;
    EValOutrasDespesas: TNumerico;
    EValTotalNota: TNumerico;
    EMarca: TEditColor;
    EEspecie: TEditColor;
    EUFVeiculo: TEditColor;
    ECoDVendedor: TEditLocaliza;
    ECodTransportadora: TRBEditLocaliza;
    ECondicoes: TEditColor;
    MAdicional: TMemoColorLimite;
    EClaFiscal: TEditColor;
    EQtd: Tnumerico;
    EPesoBruto: Tnumerico;
    EPesoLiquido: Tnumerico;
    EValDescontoAcrescimo: TNumerico;
    EValTotalIPI: TNumerico;
    CValorPercentual: TRadioGroup;
    EPerComissao: Tnumerico;
    Label31: TLabel;
    ENumeroEmbalagem: TEditColor;
    Tempo: TPainelTempo;
    CADBOLETO: TSQLQUERY;
    RomaneioItem: TSQLQUERY;
    BAlterarNumero: TBitBtn;
    Shape25: TShape;
    ValidaGravacao1: TValidaGravacao;
    Label33: TLabel;
    EOrdemCompra: TEditColor;
    ECor: TEditLocaliza;
    RTipoNota: TRadioGroup;
    ENumNota: Tnumerico;
    ESerieNota: TEditColor;
    ECodFilial: TEditColor;
    Label34: TLabel;
    LCGCCPF: TLabel;
    LInscricaoEstadual: TLabel;
    LEndereco: TLabel;
    LBairro: TLabel;
    LCep: TLabel;
    LCidade: TLabel;
    LUF: TLabel;
    LFone: TLabel;
    LFax: TLabel;
    EDatEmissao: TMaskEditColor;
    EDatSaida: TMaskEditColor;
    EHorSaida: TMaskEditColor;
    GProdutos: TRBStringGridColor;
    ValidaUnidade: TValidaUnidade;
    Label30: TLabel;
    LCGCTranposrtadora: TLabel;
    LEnderecoTransportadora: TLabel;
    LNumEnderecoTransportadora: TLabel;
    LMunicipioTransportadora: TLabel;
    CriaParcelas: TCriaParcelasReceber;
    StatusBar1: TStatusBar;
    BAlterarNota: TSpeedButton;
    PSERVICO: TPanel;
    GServicos: TRBStringGridColor;
    Shape1: TShape;
    Label32: TLabel;
    Shape24: TShape;
    Label35: TLabel;
    EValIss: Tnumerico;
    Shape8: TShape;
    EValTotalServicos: Tnumerico;
    Label37: TLabel;
    Shape27: TShape;
    Label38: TLabel;
    Label52: TLabel;
    SpeedButton4: TSpeedButton;
    ECodPreposto: TEditLocaliza;
    Label70: TLabel;
    Label74: TLabel;
    EComissaoPreposto: Tnumerico;
    MImprimir: TPopupMenu;
    EPerISSQN: Tnumerico;
    BFinanceiroOculto: TSpeedButton;
    Shape28: TShape;
    ETextoFiscal: TEditColor;
    Label76: TLabel;
    EValTroca: Tnumerico;
    EspelhodaNota1: TMenuItem;
    Label75: TLabel;
    EChaveNFE: TEditColor;
    BEnviar: TBitBtn;
    Label17: TLabel;
    LTelefoneTransportadora: TLabel;
    Label77: TLabel;
    Shape30: TShape;
    ECotacaoTransportadora: TEditColor;
    N1: TMenuItem;
    ControleDespacho1: TMenuItem;
    N2: TMenuItem;
    EtiquetaEndereo1: TMenuItem;
    BMenuFiscal: TBitBtn;
    PNaturezaOperacao: TPanel;
    Shape2: TShape;
    Label8: TLabel;
    Shape7: TShape;
    Shape9: TShape;
    cv: TLabel;
    LPlanoContas: TLabel;
    Label26: TLabel;
    SpeedButton5: TSpeedButton;
    Shape26: TShape;
    BPlanoContas: TSpeedButton;
    LTextoPlanoContas: TLabel;
    Shape29: TShape;
    ECodNatureza: TEditLocaliza;
    EPlano: TEditColor;
    LSubSerie: TLabel;
    ESubSerie: TEditColor;
    BNotaRemesa: TBitBtn;
    SpeedButton6: TSpeedButton;
    Label80: TLabel;
    ERedespacho: TRBEditLocaliza;
    ObservacaoCotacao: TSQLQuery;
    MEnviar: TPopupMenu;
    EnviarXMLNfepeloOutlook1: TMenuItem;
    MProduto: TPopupMenu;
    PeasMquinas1: TMenuItem;
    PExportacao: TPanelColor;
    Label79: TLabel;
    EUFEmbarque: TComboBoxColor;
    PRodape: TPanelColor;
    Shape31: TShape;
    PTotaiseExportacao: TPanelColor;
    Label81: TLabel;
    Label82: TLabel;
    ELocalEmbarque: TEditColor;
    procedure BFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ECodNaturezaRetorno(Retorno1, Retorno2: String);
    procedure ECodClienteCadastrar(Sender: TObject);
    procedure ECodNaturezaCadastrar(Sender: TObject);
    procedure EValFreteExit(Sender: TObject);
    procedure ECondicoesExit(Sender: TObject);
    procedure ECoDVendedorRetorno(Retorno1, Retorno2: String);
    procedure BCondicaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BotaoCancelar1Click(Sender: TObject);
    procedure BotaoGravar1Click(Sender: TObject);
    procedure ECondicoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure BObservacaoClick(Sender: TObject);
    procedure ECodTipoFreteKeyPress(Sender: TObject; var Key: Char);
    procedure BImprimirClick(Sender: TObject);
    procedure BtbImprimeBoletoClick(Sender: TObject);
    procedure BAlterarNumeroClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ECodNaturezaSelect(Sender: TObject);
    procedure ECondicoesChange(Sender: TObject);
    procedure ECodTransportadoraCadastrar(Sender: TObject);
    procedure ECoDVendedorCadastrar(Sender: TObject);
    procedure ECorCadastrar(Sender: TObject);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosDepoisExclusao(Sender: TObject);
    procedure GProdutosEnter(Sender: TObject);
    procedure GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorEnter(Sender: TObject);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosNovaLinha(Sender: TObject);
    procedure GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EValDescontoAcrescimoExit(Sender: TObject);
    procedure GProdutosExit(Sender: TObject);
    procedure EDatEmissaoExit(Sender: TObject);
    procedure EDatSaidaExit(Sender: TObject);
    procedure BAlterarNotaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GServicosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GServicosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GServicosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GServicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GServicosKeyPress(Sender: TObject; var Key: Char);
    procedure GServicosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GServicosNovaLinha(Sender: TObject);
    procedure GServicosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ECodPrepostoRetorno(Retorno1, Retorno2: String);
    procedure BFinanceiroOcultoClick(Sender: TObject);
    procedure ECoDVendedorSelect(Sender: TObject);
    procedure ECodPrepostoSelect(Sender: TObject);
    procedure EspelhodaNota1Click(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EPlanoExit(Sender: TObject);
    procedure BPlanoContasClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure ControleDespacho1Click(Sender: TObject);
    procedure ECodClienteAlterar(VpaColunas: TRBColunasLocaliza);
    procedure ECodClienteRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EtiquetaEndereo1Click(Sender: TObject);
    procedure BMenuFiscalClick(Sender: TObject);
    procedure FPrincipalExportaExecute(Sender: TObject);
    procedure BNotaRemesaClick(Sender: TObject);
    procedure ECodTransportadoraRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EnviarXMLNfepeloOutlook1Click(Sender: TObject);
    procedure PeasMquinas1Click(Sender: TObject);
  private
     VprOperacao : TRBDOperacaoCadastro;
     VprDNota : TRBDNotaFiscal;
     VprDProdutoNota : TRBDNotaFiscalProduto;
     VprDServicoNota : TRBDNotaFiscalServico;
     VprDRomaneioOrcamento : TRBDRomaneioOrcamento;
     VprDContasaReceber : TRBDContasCR;
     VprCodNaturezaAtual,
     VprServicoAnterior,
     VprProdutoAnterior : String;
     VprDCliente : TRBDCliente;
     VprDTransportadora : TRBDCliente;
     FunOrdemProducao : TRBFuncoesOrdemProducao;
     FunImprimeBoleto : TImpressaoBoleto;
     VprDNatureza : TRBDNaturezaOperacao;
     VprAcao,
     VprNotaFiscalConsumidor,
     VprNotaAutomatica,
     VprNotaDevolucao  : Boolean;
     VprCodClienteFaccionista,
     VprCodClienteObservacao : Integer;

     //antigos
     UnImp : TFuncoesImpressao;
     LancamentoReceber : Integer;
     VprOrcamento,
     VprNotaRemessa,
     VprRomaneioOrcamento : Boolean; // para quando consulta naum executar servicos;

     NroLinhaProdutos,
     NroLinhaFatura,
     NroConjuntoFatura,
     NroLinhaObs : Integer;

     VprTextoReducao : string;
     VprCotacoes : TList;
     VprTransacao : TTransactionDesc;
     VprBoletoImpresso : boolean;
     //funcoes novas;
     procedure ConfiguraTela;
     procedure CarTitulosGrade;
     function LimiteCreditoOK(VpaDCliente : TRBDCliente) : Boolean;
     function SituacaoFinanceiraOK(VpaDCliente : TRBDCliente) : Boolean;
     procedure CardClienteNota(VpaDCliente : TRBDCliente);
     procedure CarObservacaoCotacao(VpaDNota: TRBDNotaFiscal);
     procedure CarDTransportadoraTela;
     procedure CarDProdutoNota;
     procedure CarDServicoNota;
     procedure CarDTela;
     procedure CarDValorTotalTela;
     function CarDClasse : string;
     procedure CarDValorTotal;
     procedure CarDDesconto;
     procedure CalculaValorTotalProduto;
     function ExisteProduto : Boolean;
     function ExisteServico : Boolean;
     procedure CalculaValorTotal;
     procedure CalculaValorTotalServico;
     function LocalizaProduto : Boolean;
     function LocalizaServico : Boolean;
     function ExisteUM : Boolean;
     function ExisteCor : Boolean;
     function ExisteCondicaoPagamento : Boolean;
     function LocalizaCondicaoPagto : Boolean;
     procedure ReferenciaProduto;
     procedure InicializaNota;
     function VerificaVariaveis : string;
     procedure CarregaDadosFilial;
     procedure ValidaValorUnitarioProduto;
     function DadosNotaValidos : String;
     procedure AtualizaStatus(VpaStatus : String);
     procedure LimpaDadosClientes;
     procedure AdicionaItemProduto(VpaDProdutoNota : TRBDNotaFiscalProduto);
     function RNumerosPedido : String;
     function RCodClienteFaccionista : integer;
     function RObservacaoCotacao(VpaNumCotacao, VpaCodFilial: Integer): String;
     procedure TelaModoConsulta(VpaConsulta : Boolean);
     procedure CalculaValorUnitarioPeloAlturaProduto;
     procedure ZeraCamposNotaFiscalDuplicada;

     //funcoes antigas
     function SendMailMAPI(const Subject, Body, FileName, SenderName,SenderEMail,RecepientName, RecepientEMail: string): Integer;
     procedure ConfiguraItemNota( NroDoc : Integer);

     Procedure EstadoBotoes(Estado : Boolean);
     procedure LimpaStringGrid;

     procedure MontaObservacao;

     procedure MontaPArcelasCR(VpaParcelaOculta : Boolean);
     procedure ExcluiFinanceiroCotacao;
     function GeraFinanceiroNota : String;
     function GeraFinanceiroOculto : String;
     function BaixaEstoqueNota : string;
     function BaixaEstoqueFiscal : String;
     function BaixaFinanceiro : string;
     function BaixaNota : String;
     procedure ArrumaDuplicatasFinanceiro;
     function ROrdensCompra : String;

     procedure AlteraLocalizasOrcamento;

     procedure GeraMovNotasFiscaisOrcamentos(VpaCotacoes : TList;VpaSomenteServico : Boolean=false);
     procedure GeraMovNotasFiscaisRomaneio(VpaEmpFil, VpaNumRomaneio : String);
     procedure GeraMovNotasFiscaisRomaneioGenerico(VpaCodFilial,VpaSeqRomaneio : Integer);
     procedure GeraMovNotasFiscaisRomaneioOrcamento(VpaDRomaneio : TRBDRomaneioOrcamento);
     procedure ValidaDadosRomaneioComOrcamento(VpaDRomaneioItem : TRBDRomaneioOrcamentoItem);
     procedure AdicionaServicoContrato(VpaDContrato : TRBDContratoCorpo);
     procedure AdicionaProdutosContratoDadosAdicionais(VpaDContrato : TRBDContratoCorpo);
     procedure AdicionaProdutosNotaEntrada(VpaDNotaEntrada : TRBDNotaFiscalFor);
     procedure AdicionaServicosNotaEntrada(VpaDNOtaEntrada:  TRBDNotaFiscalFor);
     procedure OrdenaCotacoesPorDataEntrega(VpaCotacoes : TList);
     procedure CarProBaixadosOrcamento;
     procedure AssociaNotaCotacoes(VpaCotacoes : TList);
     function BaixaProdutoCotacaoRomaneio : string;
     procedure CarDOrcamentoNota(VpaDOrcamento : TRBDOrcamento;VpaDNota : TRBDNotaFiscal);
     procedure CarDNotaEntradaNotaSaida(VpaDNotaentrada: TRBDNotaFiscalFor; VpaDNota : TRBDNotaFiscal);
     procedure CarDClienteNovaNota(VpaDNota : TRBDNotaFiscal;VpaCodCliente : Integer);
     procedure AdicionaAcrescimosDescontoCotacoesNota(VpaCotacoes : TList;VpaDNota : TRBDNotaFiscal);
     procedure CarObservacoesRomaneio(VpaDRomaneio : TRBDRomaneioOrcamento; VpaDNota : TRBDNotaFiscal);
     procedure CarNaturezaOperacaoNota;
     function FinalizaNotaAutomatico : String;
     procedure GeraNotaFiscalFriaContrato;
     function DadoNfeValidos(VpaDCliente : TRBDCliente) : string;
     function MarcaCotacoesComoFaturadas(VpaLista : TList):String;
     procedure AssociaNaturezaItens;
     procedure AssociaCSTItens;
     function ValorParcelaValido(VpaDNota : TRBDNotaFiscal) : string;
     function EnviaEmailNfe : string;
  public
     function NovaNotaFiscal : Boolean;
     function GeraNotaCotacoes(VpaCotacoes : TList;VpaSomenteServico : Boolean = false):Boolean;
     function GeraNotaNotaEntrada(VpaDNotaFiscalEntrada: TRBDNotaFiscalFor):boolean;
     function GeraNotaCotacoesAutomatico(VpaCotacoes : TList;VpaDCliente : TRBDCliente;VpaBarraStatus : TStatusBar):string;
     function GeraNotaRomaneio(VpaEmpfil,VpaNumRomaneio : String) : boolean;
     function GeraNotaRomaneioGenerico(VpaCodFilial, VpaSeqRomaneio,VpaCodCliente : Integer):Boolean;
     function GeraRonameioOrcamento(VpaCodFilial, VpaSeqRomaneio : Integer):boolean;
     function GeraNotaContratoDireto(VpaDContrato : TRBDContratoCorpo):boolean;
     function NotaDevolucao(VpaCodFilial, VpaSeqNota: Integer): Boolean;
     procedure ConsultaNota(VpaDNota : TRBDNotaFiscal);
     procedure EmiteNotaFiscalVendaConsumidor;
  end;

var
  FNovaNotaFiscalNota: TFNovaNotaFiscalNota;

implementation

uses APrincipal, constmsg, ANovaNatureza, ANovoCliente, funsql,
     ALocalizaProdutos, AConsultaCondicaoPgto, funnumeros, FunObjeto,
     AObservacoesNota, ANovoServico, funstring, FunData,
     AItensNatureza, funprinter,
  ANovoVendedor, ACores, AMostraObservacaoCliente,
  ALocalizaServico, FunArquivos, dmRave, APlanoConta, AMenuFiscalECF,
  AMostraObservacaoPedido, AProdutosClientePeca;

{$R *.DFM}

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Rotinas Gerais do formulario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************* quando cria o formulario ************************************ }
procedure TFNovaNotaFiscalNota.FormCreate(Sender: TObject);
begin
  VprAcao := false;
  VprNotaAutomatica := false;
  VprBoletoImpresso := false;
  VprNotaRemessa := false;
  VprRomaneioOrcamento := false;
  VprNotaFiscalConsumidor := false;
  VprCodClienteFaccionista := 0;
  if Varia.FormaEmissaoNFE = feScan then
    varia.SerieNota := '900';
  CarTitulosGrade;
  ValidaUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ValidaUnidade.Ainfo.UnidadeUN := varia.unidadeUN;
  ValidaUnidade.Ainfo.UnidadeKit := varia.unidadeKit;
  ValidaUnidade.Ainfo.UnidadeBarra := varia.UnidadeBarra;
  ValidaUnidade.Ainfo.UnidadeQuilo := varia.UnidadeQuilo;
  ValidaUnidade.Ainfo.UnidadeMilheiro := varia.UnidadeMilheiro;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);

  FundoNota.VertScrollBar.Position := 0;
  FunImprimeBoleto := TImpressaoBoleto.cria(Fprincipal.BaseDados);
  VprDCliente := TRBDCliente.cria;
  VprDTransportadora := TRBDCliente.Cria;
  VprDNatureza := TRBDNaturezaOperacao.cria;
  VprDContasaReceber := TRBDContasCR.cria;
  UnImp := TFuncoesImpressao.criar(self, FPrincipal.BaseDados);
  // permite ou nao alterar o numero da nota fiscal
  ConfiguraTela;
  carregacombo(EUFEmbarque, CT_UF);
end;

{************ no close da nota fiscal *************************************** }
procedure TFNovaNotaFiscalNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (VprBoletoImpresso = false) and (Config.MensagemBoleto = true) then
    aviso('BOLETO NÃO FOI IMPRESSO!!!!'#13'O boleto bancario dessa nota não foi impresso.');
  if FPrincipal.BaseDados.InTransaction then
     FPrincipal.BaseDados.Rollback(VprTransacao);
  MovNatureza.close;
  CADBOLETO.close;
  FunImprimeBoleto.free;
  VprDContasaReceber.free;
  VprDNatureza.Free;
  Aux.Close;
  action := cafree;
end;

{****************** fechamento da nota fiscal ****************************** }
procedure TFNovaNotaFiscalNota.BFecharClick(Sender: TObject);
begin
  self.close;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.LimiteCreditoOK(VpaDCliente : TRBDCliente) : Boolean;
begin
  result := true;
  if config.LimiteCreditoCliente then
  begin
    if (VprDCliente.LimiteCredito < (VprDCliente.DuplicatasEmAberto + VprDNota.ValTotal)) then
    begin
     result := false;
     if confirmacao('CLIENTE COM LIMITE DE CRÉDITO ESTOURADO!!!'#13'Esse cliente possui um limite de crédito de "'+FormatFloat('#,###,###,##0.00',VprDCliente.LimiteCredito)+
            '", e o valor das duplicatas em aberto somam "'+FormatFloat('#,###,###,##0.00',VprDCliente.DuplicatasEmAberto + VprDNota.ValTotal)+ '".Deseja alterar o limite de crédito do cliente?') then
     begin
       FNovoCliente := TFNovoCliente.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovoCliente'));
       FNovoCliente.CadClientes.FindKey([VpaDCliente.CodCliente]);
       FNovoCliente.CadClientes.Edit;
       FNovoCliente.Showmodal;
       FNovoCliente.free;
       FunClientes.CarDCliente(VpaDCliente);
     end
     else
       ECodCliente.Clear;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarTitulosGrade;
begin
  GProdutos.Cells[1,0] := 'CÓDIGO';
  GProdutos.Cells[2,0] := 'DESCRIÇÃO DO PRODUTO';
  GProdutos.Cells[3,0] := 'COR';
  GProdutos.Cells[4,0] := 'DESCRIÇÃO COR';
  GProdutos.Cells[5,0] := 'ALTURA';
  GProdutos.Cells[6,0] := 'C.F.';
  GProdutos.Cells[7,0] := 'CST';
  GProdutos.Cells[8,0] := 'UNID.';
  GProdutos.Cells[9,0] := 'QTD';
  GProdutos.Cells[10,0] := 'VALOR UNITÁRIO';
  GProdutos.Cells[11,0] := 'VALOR TOTAL';
  if config.NumeroSerieProduto then
    GProdutos.Cells[12,0] := 'NÚMERO SÉRIE'
  else
    GProdutos.Cells[12,0] := 'REFERÊNCIA CLIENTE';
  GProdutos.Cells[13,0] := 'ORDEM COMPRA';
  GProdutos.Cells[14,0] := 'ICMS';
  GProdutos.Cells[15,0] := 'IPI';
  GProdutos.Cells[16,0] := 'VALOR IPI';
  GProdutos.Cells[17,0] := 'CFOP';
  GProdutos.Cells[18,0] := '% Red ICMS';

  GServicos.Cells[1,0] := 'CÓDIGO';
  GServicos.Cells[2,0] := 'DESCRIÇÃO';
  GServicos.Cells[3,0] := 'DESCRIÇÃO ADICIONAL';
  GServicos.Cells[4,0] := 'QTD';
  GServicos.Cells[5,0] := 'VAL UNITÁRIO';
  GServicos.Cells[6,0] := 'VALOR TOTAL';
  if not config.AlturadoProdutonaGradedaCotacao then
  begin
    GProdutos.ColWidths[5] := -1;
    GProdutos.TabStops[5] := false;
  end;


end;

{******************************************************************************}
function TFNovaNotaFiscalNota.SituacaoFinanceiraOK(VpaDCliente : TRBDCliente) : Boolean;
begin
  result := LimiteCreditoOK(VpaDCliente);
  if result then
  begin
    if config.BloquearClienteEmAtraso then
    begin
      if VprDCliente.DuplicatasEmAtraso > 0 then
      begin
        if not Confirmacao('CLIENTE COM DUPLICATAS VENCIDAS!!!'#13'Este cliente possui duplicatas vencidas no valor de "'+FormatFloat('#,###,###,###,##0.00',VprDCliente.DuplicatasEmAtraso)+'". Deseja faturar para esse cliente ?') then
          ECodCliente.Clear;
      end;
    end;
  end;
  if VprDCliente.IndBloqueado then
  begin
    aviso('CLIENTE BLOQUEADO!!!'#13'Este cliente encontra-se bloqueado, não é permitido fazer cotações para clientes bloqueados. Solicite o desbloqueio desse cliente.');
    ECodCliente.clear;
    VprDCliente.CodCliente := 0;
    Result := false;
  end;

end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CardClienteNota(VpaDCliente : TRBDCliente);
begin
  ConfiguraTela;
  LCGCCPF.Caption := VpaDCliente.CGC_CPF;
  if VpaDCliente.TipoPessoa = 'F' then
    LInscricaoEstadual.Caption := VpaDCliente.RG
  else
    LInscricaoEstadual.Caption := VpaDCliente.InscricaoEstadual;
  if (VprDCliente.DesEnderecoCobranca <> '')  and config.MostrarEnderecoCobrancanaNota then
  begin
    LEndereco.Caption := VpaDCliente.DesEnderecoCobranca+', '+VpaDCliente.NumEnderecoCobranca ;
    LBairro.Caption := VpaDCliente.DesBairroCobranca;
    LCep.Caption := VpaDCliente.CepClienteCobranca;
    LCidade.Caption := VpaDCliente.DesCidadeCobranca;
    LUF.Caption := vpaDCliente.DesUfCobranca;
    LFone.Caption := VpaDCliente.Fone_FAX;
  end
  else
  begin
    LEndereco.Caption := VpaDCliente.DesEndereco+', '+VpaDCliente.NumEndereco + ' - '+ VpaDCliente.DesComplementoEndereco ;
    LBairro.Caption := VpaDCliente.DesBairro;
    LCep.Caption := VpaDCliente.CepCliente;
    LCidade.Caption := VpaDCliente.DesCidade;
    LUF.Caption := vpaDCliente.DesUF;
    LFone.Caption := VpaDCliente.Fone_FAX;
  end;
  if (VpadCliente.CodCondicaoPagamento <> 0) and (VprDNota.IndGeraFinanceiro)and
     (VprDNota.CodCondicaoPagamento = 0 ) then
  begin
    ECondicoes.AInteiro := VpaDCliente.CodCondicaoPagamento;
    CalculaValorTotal;
  end;
  if (VpaDCliente.CodFormaPagamento <> 0) and (VprDNota.CodFormaPagamento = 0) then
    VprDNota.CodFormaPagamento := VpaDCliente.CodFormaPagamento;
  if (VpaDCliente.CodVendedor <> 0) and (VprDNota.CodVendedor = 0) then
  begin
    ECoDVendedor.AInteiro := VpaDCliente.CodVendedor;
    ECoDVendedor.Atualiza;
  end;
  if (VpaDCliente.PerComissao <> 0) and (VprDNota.PerComissao = 0) then
    EPerComissao.AValor := VpaDCliente.PerComissao;
  if VpaDCliente.CodRedespacho <> 0 then
  begin
    ERedespacho.AInteiro := VpaDCliente.CodRedespacho;
    ERedespacho.Atualiza;
  end;
  VprDNota.PerIssqn := varia.ISSQN;
  EPerISSQN.AValor := VprDNota.PerIssqn;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDTransportadoraTela;
begin
  with VprDTransportadora do
  begin
    LCGCTranposrtadora.Caption := CGC_CPF;
    LEnderecoTransportadora.Caption := DesEndereco;
    LNumEnderecoTransportadora.Caption := NumEndereco;
    LMunicipioTransportadora.Caption := desCidade;
    LTelefoneTransportadora.Caption := desfone1;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDProdutoNota;
begin
  VprDProdutoNota.CodProduto := GProdutos.Cells[1,GProdutos.Alinha];
  if config.PermiteAlteraNomeProdutonaCotacao then
    VprDProdutoNota.NomProduto := GProdutos.Cells[2,GProdutos.ALinha];

  if GProdutos.Cells[3,GProdutos.ALinha] <> '' then
    VprDProdutoNota.CodCor := StrToInt(GProdutos.Cells[3,GProdutos.Alinha])
  else
    VprDProdutoNota.CodCor := 0;
  VprDProdutoNota.DesCor := GProdutos.Cells[4,GProdutos.ALinha];
  VprDProdutoNota.CodClassificacaoFiscal := GProdutos.Cells[6,GProdutos.ALinha];
  VprDProdutoNota.CodCST := GProdutos.Cells[7,GProdutos.ALinha];
  VprDProdutoNota.UM := GProdutos.Cells[8,GProdutos.ALinha];
  CalculaValorUnitarioPeloAlturaProduto;
  VprDProdutoNota.QtdProduto := StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.'));
  if ArredondaDecimais(VprDProdutoNota.ValUnitario,varia.Decimais) <> StrToFloat(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.')) then
    VprDProdutoNota.ValUnitario := StrToFloat(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.'));
  if config.NumeroSerieProduto then
    VprDProdutoNota.DesRefCliente := GProdutos.Cells[12,GProdutos.ALinha];
  VprDProdutoNota.DesOrdemCompra := GProdutos.Cells[13,GProdutos.ALinha];
  if GProdutos.Cells[14,GProdutos.ALinha] <> '' then
    VprDProdutoNota.PerICMS := StrToFloat(DeletaChars(DeletaChars(GProdutos.Cells[14,GProdutos.ALinha],'.'),'%'))
  else
    VprDProdutoNota.PerICMS := 0;
  if GProdutos.Cells[15,GProdutos.ALinha] <> '' then
    VprDProdutoNota.PerIPI := StrToFloat(DeletaChars(DeletaChars(GProdutos.Cells[15,GProdutos.ALinha],'.'),'%'))
  else
    VprDProdutoNota.PerIPI := 0;
  if GProdutos.Cells[16,GProdutos.ALinha] <> '' then
    VprDProdutoNota.ValIPI := StrToFloat(DeletaChars(GProdutos.Cells[16,GProdutos.ALinha],'.'))
  else
    VprDProdutoNota.ValIPI := 0;
  if GProdutos.Cells[17,GProdutos.ALinha] <> '' then
    VprDProdutoNota.CodCFOP := StrToInt(GProdutos.Cells[17,GProdutos.ALinha])
  else
    VprDProdutoNota.CodCFOP := 0;

  if GProdutos.Cells[18,GProdutos.ALinha] <> '' then
    VprDProdutoNota.PerReducaoUFBaseICMS := StrToFloat(DeletaChars(DeletaChars(GProdutos.Cells[18,GProdutos.ALinha],'.'),'%'))
  else
    VprDProdutoNota.PerReducaoUFBaseICMS := 0;


  CalculaValorTotalProduto;
  if ((VprDProdutoNota.QtdEstoque - VprDProdutoNota.QtdProduto) < VprDProdutoNota.QtdMinima) then
  begin
    if config.AvisaQtdMinima then
      aviso(CT_EstoqueProdutoMinimo);
  end
  else
    if ((VprDProdutoNota.QtdEstoque -  VprDProdutoNota.QtdProduto) < VprDProdutoNota.QtdPedido) Then
    begin
      if Config.AvisaQtdPedido Then
        aviso(CT_EstoquePedido);
    end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDServicoNota;
begin
  VprDServicoNota.CodServico := StrToInt(GServicos.Cells[1,GServicos.Alinha]);
  if config.PermiteAlteraNomeProdutonaCotacao then
    VprDServicoNota.NomServico := GServicos.Cells[2,GServicos.ALinha];
  VprDServicoNota.DesAdicional := GServicos.Cells[3,GServicos.ALinha];
  VprDServicoNota.QtdServico := StrToFloat(DeletaChars(GServicos.Cells[4,GServicos.ALinha],'.'));
  VprDServicoNota.ValUnitario := StrToFloat(DeletaChars(GServicos.Cells[5,GServicos.ALinha],'.'));
  CalculaValorTotalServico;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDTela;
begin
  with VprDNota do
  begin
    ESerieNota.text := DesSerie;
    ECodFilial.AInteiro := CodFilial;
    ECodNatureza.Text := CodNatureza;
    ECodCliente.AInteiro := CodCliente;
    ENumNota.AsInteger := NumNota;
    if DesTipoNota = 'E' then
      RTipoNota.ItemIndex := 0
    else
      RTipoNota.ItemIndex := 1;
    EDatEmissao.Text := FormatDateTime('DD/MM/YY',DatEmissao);
    if DatSaida > MontaData(1,1,1900) then
      EDatSaida.Text := FormatDateTime('DD/MM/YY',DatSaida)
    else
      EDatSaida.Text := '00/00/00';
    EHorSaida.Text := FormatDateTime('HH:MM',HorSaida);
    ECodTransportadora.AInteiro := CodTransportadora;
    ERedespacho.AInteiro := CodRedespacho;
    EPlacaVeiculo.Text := DesPlacaVeiculo;
    EUFVeiculo.Text := DesUFPlacaVeiculo;
    EQtd.AValor := QtdEmbalagem;
    EEspecie.Text := DesEspecie;
    EMarca.Text := DesMarcaEmbalagem;
    ENumeroEmbalagem.Text := NumEmbalagem;
    ECotacaoTransportadora.Text := NumCotacaoTransportadora;
    EOrdemCompra.Text := DesOrdemCompra;
    ECondicoes.AInteiro := CodCondicaoPagamento;
    ECoDVendedor.AInteiro := CodVendedor;
    ECoDVendedor.Atualiza;
    ECodPreposto.AInteiro := CodVendedorPreposto;
    ECodPreposto.Atualiza;
    EComissaoPreposto.AValor := PerComissaoPreposto;
    EPerComissao.AValor := PerComissao;
    EPerISSQN.AValor := PerIssqn;
    EClaFiscal.Text := DesClassificacaoFiscal;
    MAdicional.Lines.Text := DesDadosAdicinais.text;
    EValTroca.AValor := ValDescontoTroca;
    EChaveNFE.Text := VprDNota.DesChaveNFE;
    ELocalEmbarque.Text := VprDNota.DesLocalEmbarque;
    EUFEmbarque.Text := VprDNota.DesUFEmbarque;
  end;
  AtualizaLocalizas([ECodCliente,ECodNatureza,ECodTransportadora,ECondicoes,ERedespacho]);
  CarDValorTotalTela;
  CarDTransportadoraTela;
  ExisteCondicaoPagamento;
  MontaObservacao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDValorTotalTela;
begin
  with VprDNota do
  begin
    EBaseICMS.AValor :=  ValBaseICMS;
    EValICMS.AValor := ValICMS;
    EValSubsICM.AValor := ValICMSSubtituicao;
    EBaseSubICMS.AValor := ValBaseICMSSubstituicao;
    EValTotalProdutos.AValor := ValTotalProdutosSemDesconto;
    EValFrete.AValor := ValFrete;
    EValSeguro.AValor := ValSeguro;
    EValOutrasDespesas.aValor := ValOutrasDepesesas;
    EValTotalIPI.AValor := ValTotalIPI;
    EValTotalNota.AValor := ValTotal;
    ECodTipoFrete.AsInteger := CodTipoFrete;
    EPesoBruto.AValor := PesBruto;
    EPesoLiquido.AValor := PesLiquido;
    EValTotalServicos.AValor := ValTotalServicos;
    EValIss.AValor := ValIssqn;
    EPerISSQN.AValor := PerIssqn;
    CValorPercentual.ItemIndex := 1;
    if ValDesconto <> 0 then
    begin
      CValorPercentual.ItemIndex := 0;
      if ValDesconto > 0 then
        EValDescontoAcrescimo.AValor := ValDesconto
      else
        MAdicional.Lines.Add('Valor de acrescimo : '+FloatToStr(ValDesconto * -1));
    end
    else
      if PerDesconto <> 0 then
      begin
        CValorPercentual.ItemIndex := 1;
        if PerDesconto > 0 then
           EValDescontoAcrescimo.AValor := PerDesconto
        else
          MAdicional.Lines.Add('Percentual de acrescimo : '+FloatToStr(PerDesconto *-1));
      end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.CarDClasse : string;
begin
  result := '';
  try
    StrToDate(EDatEmissao.text);
  except
    result := 'DATA EMISSÃO INVÁLIDA!!!'#13'A data de emissao da nota fiscal não é uma data válida ou não foi preenchida...';
  end;
  try
    if DeletaChars(DeletaChars(EDatSaida.Text,'/'),'0') = '' then
      VprDNota.DatSaida := MontaData(1,1,1900)
    else
      VprDNota.DatSaida := StrToDate(EDatSaida.text);
  except
    result := 'DATA DE SAÍDA INVÁLIDA!!!'#13'A data de saida da nota fiscal não é uma data válida ou não foi preenchida...';
  end;


  if result = '' then
  begin
    with VprDNota do
    begin
      if config.NotaFiscalConjugada then
        DesSerie := Varia.SerieNota
      else
      begin
        if VprDNota.Produtos.Count > 0  then
          DesSerie := Varia.SerieNota
        else
          DesSerie := Varia.SerieNotaServico;
      end;
      DesSubSerie := ESubSerie.Text;
      CodNatureza := ECodNatureza.Text;
      NumNota := ENumNota.AsInteger;
      CodCliente := ECodCliente.AInteiro;
      DatEmissao := StrToDate(EDatEmissao.text);
      CarDValorTotal;

      CodTransportadora := ECodTransportadora.AInteiro;
      CodRedespacho := ERedespacho.AInteiro;
      DesPlacaVeiculo := EPlacaVeiculo.Text;
      DesUFPlacaVeiculo := EUFVeiculo.Text;
      QtdEmbalagem := EQtd.AsInteger;
      DesEspecie := EEspecie.Text;
      DesMarcaEmbalagem := EMarca.Text;
      NumEmbalagem := ENumeroEmbalagem.Text;
      NumCotacaoTransportadora := ECotacaoTransportadora.Text;
      PesBruto := EPesoBruto.AValor;
      PesLiquido := EPesoLiquido.AValor;
      DesOrdemCompra := EOrdemCompra.Text;
      CodCondicaoPagamento := ECondicoes.AInteiro;
      PerComissao := EPerComissao.AValor;
      CodVendedor := ECoDVendedor.AInteiro;
      CodVendedorPreposto := ECodPreposto.AInteiro;
      PerComissaoPreposto := EComissaoPreposto.AValor;
      DesUFEmbarque := EUFEmbarque.Text;
      DesLocalEmbarque := ELocalEmbarque.Text;

      if VprOrcamento and (VprCotacoes <> nil) then
        VprDNota.NumPedidos := RNumerosPedido ;

      if config.LimiteCreditoCliente then
      begin
        if not LimiteCreditoOK(VprDCliente) then
        begin
          result := 'CLIENTE COM LIMITE DE CRÉDITO ESTOURADO!!!'#13'Esse cliente possui um limite de crédito de "'+FormatFloat('#,###,###,##0.00',VprDCliente.LimiteCredito)+
                '", e o valor das duplicatas em aberto mais essa nota somam "'+FormatFloat('#,###,###,##0.00',VprDCliente.DuplicatasEmAberto+VprDNota.ValTotal)+ '".';
        end;
      end;
      DesClassificacaoFiscal := FunNotaFiscal.RTextoClassificacaoFiscal(VprDNota) ;
      DesDadosAdicinais.Text := MAdicional.Lines.Text;
    end;
    if result = '' then
      result := ValorParcelaValido(VprDNota);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDValorTotal;
begin
  with VprDNota do
  begin
    ValBaseICMS := EBaseICMS.AValor;
    ValICMS := EValICMS.AValor;
    ValICMSSubtituicao := EValSubsICM.AValor;
    ValBaseICMSSubstituicao := EBaseSubICMS.AValor;
    ValFrete := EValFrete.AValor;
    ValSeguro := EValSeguro.AValor;
    ValOutrasDepesesas := EValOutrasDespesas.aValor;
    ValTotal := EValTotalNota.AValor;
    ValTotalIPI := EValTotalIPI.AValor;
    CodTipoFrete := ECodTipoFrete.AsInteger;
    CodCondicaoPagamento := ECondicoes.AInteiro;
    PesBruto := EPesoBruto.AValor;
    PesLiquido := EPesoLiquido.AValor;
    PerIssqn := EPerISSQN.AValor;
  end;
  CarDDesconto;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDDesconto;
begin
  with VprDNota do
  begin
    PerDesconto := 0;
    ValDesconto := 0;
    if CValorPercentual.ItemIndex = 0 then //valor
    begin
      ValDesconto := EValDescontoAcrescimo.AValor;
    end
    else
      if CValorPercentual.ItemIndex = 1 then //percentual
      begin
        PerDesconto := EValDescontoAcrescimo.AValor;
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDNotaEntradaNotaSaida(VpaDNotaentrada: TRBDNotaFiscalFor; VpaDNota: TRBDNotaFiscal);
begin
  //informaçoes do cliente;

  VpaDNota.CodVendedor := VpaDNotaentrada.CodVendedor;
  ECoDVendedor.Atualiza;

//  CardClienteNovaNota(VpaDNota,VpaDNotaentrada.CodFornecedor);
  VpaDNota.CodVendedor := VpaDNotaentrada.CodVendedor;
  VpaDNota.PerComissao := VpaDNotaentrada.PerComissao;
  VpaDNota.CodCondicaoPagamento := VpaDNotaentrada.CodCondicaoPagamento;
  VpaDNota.CodFormaPagamento := VpaDNotaentrada.CodFormaPagamento;
  VpaDNota.CodTransportadora := VpaDNotaentrada.CodTransportadora;
  if VpaDNotaentrada.PerDesconto > 0  then
    VpaDNota.PerDesconto := VpaDNotaentrada.PerDesconto;
  if VprDCliente.IndQuarto then
    VpaDNota.ValDesconto := VpaDNotaentrada.ValDesconto / 4
  else
    if VprDCliente.IndDecimo then
      VpaDNota.ValDesconto := VpaDNotaentrada.ValDesconto / 10
    else
      if VpaDNotaentrada.ValDesconto > 0 then
        VpaDNota.ValDesconto := VpaDNotaentrada.ValDesconto;
  if VpaDNotaentrada.ValFrete <> 0 then
    VpaDNota.ValFrete := VpaDNotaentrada.ValFrete;
  if not config.NaoCopiarObservacaoPedidoNotaFiscal then
  begin
      VpaDNota.DesObservacao.text := VpaDNotaentrada.DesObservacao;

    if Config.MostrarTelaObsCotacaoNaNotaFiscal then
    begin
      if VpaDNotaentrada.DesObservacao <> '' then
      begin
        FMostraObservacaoPedido := TFMostraObservacaoPedido.criarSDI(Application,'',FPrincipal.VerificaPermisao('FMostraObservacaoPedido'));
        FMostraObservacaoPedido.MostraObservacao(VpaDNotaentrada.DesObservacao);
        FMostraObservacaoPedido.free;
      end;
    end;
  end;
  CarDTela;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CalculaValorTotalProduto;
begin
  if (VprDProdutoNota.ValUnitario = 0) and (VprDProdutoNota.ValTotal <> 0) and
     (VprDProdutoNota.QtdProduto > 0) then
    VprDProdutoNota.ValUnitario := VprDProdutoNota.ValTotal / VprDProdutoNota.QtdProduto
  else
    VprDProdutoNota.ValTotal :=ArredondaDecimais(VprDProdutoNota.ValUnitario * VprDProdutoNota.QtdProduto,2);
  VprDProdutoNota.ValIPI := ArredondaDecimais((VprDProdutoNota.ValTotal * VprDProdutoNota.PerIPI)/100,2);
  GProdutos.Cells[9,GProdutos.ALinha] := FormatFloat(varia.MascaraQtd,VprDProdutoNota.QtdProduto);
  GProdutos.Cells[10,GProdutos.ALinha] := FormatFloat(Varia.MascaraValorUnitario,VprDProdutoNota.ValUnitario);
  GProdutos.Cells[11,GProdutos.ALinha] := FormatFloat('R$ #,###,###,###,##0.00',VprDProdutoNota.ValTotal);
  GProdutos.Cells[16,GProdutos.ALinha] := FormatFloat('#,###,###,###,##0.00',VprDProdutoNota.ValIPI);
  if VprDProdutoNota.PerReducaoUFBaseICMS <> 0 then
    GProdutos.Cells[18,GProdutos.ALinha] := FormatFloat('0.00%',VprDProdutoNota.PerReducaoUFBaseICMS)
  else
    GProdutos.Cells[18,GProdutos.ALinha] := '';
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ExisteProduto : Boolean;
Var
  VpfDProduto : TRBDProduto;
begin
  if (GProdutos.Cells[1,GProdutos.ALinha] <> '') then
  begin
    if GProdutos.Cells[1,GProdutos.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      VprDProdutoNota.SeqProduto := 0;
      result := FunNotaFiscal.ExisteProduto(GProdutos.Cells[1,GProdutos.ALinha],VprDNota,VprDProdutoNota);
      if result then
      begin
        VpfDProduto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,Varia.CodigoEmpFil,VprDProdutoNota.SeqProduto);
        VprDProdutoNota.IndSubstituicaoTributaria := VpfDProduto.IndSubstituicaoTributaria;
        VprDProdutoNota.PerSubstituicaoTributaria := VpfDProduto.PerSubstituicaoTributaria;
        VprDProdutoNota.NumDestinoProduto := VpfDProduto.NumDestinoProduto;
        VprDProdutoNota.UnidadeParentes.free;
        VprDProdutoNota.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDProdutoNota.UMOriginal);
        VprDProdutoNota.CodCST := FunNotaFiscal.RCSTICMSProduto(VprDCliente,VpfDProduto,VprDNatureza);
        VprDProdutoNota.CodCFOP := FunNotaFiscal.RCFOPProduto(VprDCliente, VprDNatureza,VpfDProduto);

        VprProdutoAnterior := VprDProdutoNota.CodProduto;
        if VprDProdutoNota.IndReducaoICMS then
          GProdutos.Cells[18,GProdutos.ALinha] := FormatFloat('0.00%',(VprDNota.ValICMSPadrao * VprDProdutoNota.PerReducaoICMSProduto)/100);
        if VpfDProduto.IndDescontoBaseICMSConfEstado then
          VprDProdutoNota.PerReducaoUFBaseICMS := VprDNota.PerReducaoUFICMS
        else
          VprDProdutoNota.PerReducaoUFBaseICMS := 0;

        GProdutos.Cells[1,GProdutos.ALinha] := VprDProdutoNota.CodProduto;
        GProdutos.Cells[2,GProdutos.ALinha] := VprDProdutoNota.NomProduto;
        GProdutos.Cells[8,GProdutos.ALinha] := VprDProdutoNota.UM;
        GProdutos.Cells[6,GProdutos.ALinha] := VprDProdutoNota.CodClassificacaoFiscal;
        GProdutos.Cells[7,GProdutos.ALinha] := VprDProdutoNota.CodCST;
        GProdutos.Cells[17,GProdutos.ALinha] :=IntToStr(VprDProdutoNota.CodCFOP);

        ReferenciaProduto;
        CalculaValorTotalProduto;
        if VprDNota.IndBaixarEstoque then
          if FUnProdutos.TextoPossuiEstoque(1, VprDProdutoNota.QtdEstoque,' kit ') then
            FUnProdutos.TextoQdadeMinimaPedido( VprDProdutoNota.QtdMinima,VprDProdutoNota.QtdPedido, 1);
        VpfDProduto.free;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ExisteServico : Boolean;
begin
  if (GServicos.Cells[1,GServicos.ALinha] <> '') then
  begin
    if (GServicos.Cells[1,GServicos.ALinha] = VprServicoAnterior)  then
      result := true
    else
    begin
      result := FunNotaFiscal.ExisteServico(GServicos.Cells[1,GServicos.ALinha],VprDNota,VprDServicoNota);
      if result then
      begin
        VprServicoAnterior := GServicos.Cells[1,GServicos.ALinha];
        GServicos.Cells[2,GServicos.Alinha] := VprDServicoNota.NomServico;
        GServicos.Cells[4,GServicos.ALinha] :=  FormatFloat(varia.MascaraQtd,VprDServicoNota.QtdServico);
        GServicos.Cells[5,GServicos.ALinha] :=  FormatFloat(varia.MascaraValorUnitario,VprDServicoNota.ValUnitario);
        if VprDNota.IndCalculaISS then
        begin
          EPerISSQN.AValor := VprDServicoNota.PerISSQN
        end;
        CalculaValorTotalServico;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CalculaValorTotal;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    CarDValorTotal;
    FunNotaFiscal.CalculaValorTotal(VprDNota,VprDCliente);
    CarDValorTotalTela;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CalculaValorTotalServico;
begin
  VprDServicoNota.ValTotal := VprDServicoNota.ValUnitario * VprDServicoNota.QtdServico;
  GServicos.Cells[6,GServicos.ALinha] := FormatFloat(varia.MascaraValor,VprDServicoNota.ValTotal);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CalculaValorUnitarioPeloAlturaProduto;
var
  VpfValorGrade : Double;
begin
  if config.AlturadoProdutonaGradedaCotacao then
  begin
    if GProdutos.Cells[5,GProdutos.ALinha] <> '' then
    begin
     VpfValorGrade := StrToFloat(DeletaChars(GProdutos.Cells[5,GProdutos.ALinha],'.'));
     if VprDProdutoNota.AltProdutonaGrade <> VpfValorGrade  then
     begin
       VprDProdutoNota.AltProdutonaGrade := StrToFloat(DeletaChars(GProdutos.Cells[5,GProdutos.ALinha],'.'));
       VprDProdutoNota.ValUnitario := (VprDProdutoNota.ValUnitarioOriginal * VprDProdutoNota.AltProdutonaGrade);
       CalculaValorTotalProduto;
     end;
    end;
  end;

end;

{******************************************************************************}
function  TFNovaNotaFiscalNota.LocalizaProduto : Boolean;
Var
  VpfDProduto : TRBDProduto;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDProdutoNota,ECodCliente.Ainteiro); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    with VprDProdutoNota do
    begin
      VprDProdutoNota.UnidadeParentes.free;
      VprDProdutoNota.UnidadeParentes := ValidaUnidade.UnidadesParentes(UMOriginal);
      VprProdutoAnterior := CodProduto;
      VpfDProduto := TRBDProduto.Cria;
      FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,Varia.CodigoEmpFil,VprDProdutoNota.SeqProduto);
      VprDProdutoNota.IndSubstituicaoTributaria := VpfDProduto.IndSubstituicaoTributaria;
      VprDProdutoNota.PerSubstituicaoTributaria := VpfDProduto.PerSubstituicaoTributaria;
      VprDProdutoNota.NumDestinoProduto := VpfDProduto.NumDestinoProduto;
      VprDProdutoNota.CodCST := FunNotaFiscal.RCSTICMSProduto(VprDCliente,VpfDProduto,VprDNatureza);
      VprDProdutoNota.CodCFOP := FunNotaFiscal.RCFOPProduto(VprDCliente,VprDNatureza,VpfDProduto);
      GProdutos.Cells[1,GProdutos.ALinha] := CodProduto;
      GProdutos.Cells[2,GProdutos.ALinha] := NomProduto;
      GProdutos.Cells[6,GProdutos.ALinha] := CodClassificacaoFiscal;
      GProdutos.Cells[7,GProdutos.ALinha] := CodCST;
      GProdutos.Cells[8,GProdutos.ALinha] := UM;
      if VprDProdutoNota.IndReducaoICMS then
        GProdutos.Cells[14,GProdutos.ALinha] := FormatFloat('0.00%',(VprDNota.ValICMSPadrao * VprDProdutoNota.PerReducaoICMSProduto)/100);
      if VpfDProduto.IndDescontoBaseICMSConfEstado then
        VprDProdutoNota.PerReducaoUFBaseICMS := VprDNota.PerReducaoUFICMS
      else
        VprDProdutoNota.PerReducaoUFBaseICMS := 0;
      GProdutos.Cells[17,GProdutos.ALinha] :=IntToStr(VprDProdutoNota.CodCFOP);
      CalculaValorTotalProduto;
      ReferenciaProduto;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.LocalizaServico : Boolean;
begin

  FlocalizaServico := TFlocalizaServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaServico'));
  result := FlocalizaServico.LocalizaServico(VprdServicoNota);
  FlocalizaServico.free; // destroi a classe;

  if result then  // se o usuario nao cancelou a consulta
  begin
    VprDServicoNota.QtdServico := 1;
    GServicos.Cells[1,GServicos.ALinha] := IntToStr(VprDServicoNota.CodServico);
    GServicos.Cells[2,GServicos.ALinha] := VprDServicoNota.NomServico;
    GServicos.Cells[4,GServicos.ALinha] :=  FormatFloat(varia.mascaraQtd,VprDServicoNota.QtdServico);
    GServicos.Cells[5,GServicos.ALinha] :=  FormatFloat(varia.MascaraValorUnitario,VprDServicoNota.ValUnitario);
    if VprDNota.IndCalculaISS then
      EPerISSQN.AValor := VprDServicoNota.PerISSQN;
    CalculaValorTotalServico;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ExisteUM : Boolean;
begin
  if (VprDProdutoNota.UMAnterior = GProdutos.cells[8,GProdutos.ALinha]) then
    result := true
  else
  begin
    result := (VprDProdutoNota.UnidadeParentes.IndexOf(GProdutos.Cells[8,GProdutos.Alinha]) >= 0);
    if result then
    begin
      VprDProdutoNota.UM := GProdutos.Cells[8,GProdutos.Alinha];
      VprDProdutoNota.UMAnterior := VprDProdutoNota.UM;
      VprDProdutoNota.ValUnitario := FunProdutos.ValorPelaUnidade(VprDProdutoNota.UMOriginal,VprDProdutoNota.UM,VprDProdutoNota.SeqProduto,
                                               VprDProdutoNota.ValUnitarioOriginal);
      CalculaValorTotalProduto;
    end;
  end;
end;

{***************** verifica se as variaveis necessarias esta iniciadas *******}
function TFNovaNotaFiscalNota.VerificaVariaveis : string;
begin
  result := '';
  if Varia.NotaFiscalPadrao = 0 then
    result := CT_NotaFaltante;

  if result = '' then
  begin
    if ConfigModulos.Caixa then
      if varia.OperacaoReceber = 0 then
        result := CT_FaltaCFGOpeCaixaRC;
  end;
  //verifica se não faltam dados do cfg
  if result = '' then
  begin
    if (varia.CodigoEmpresa = 0) or (varia.CodigoEmpFil = 0) or (varia.UFFilial = '')   then
      result := CT_FaltaCFGFiscalECF;
  end;
  if result = '' then
  begin
    if (config.EmiteNFe) or (Config.EmiteSped) then
    begin
      if varia.CodIBGEMunicipio = 0  then
        result := 'CODIGO IBGE MUNICIPIO EMITENTE NÃO PREENCHIDO!!!'#13'É necessário importar os municipios com o codigo o IBGE, em seguida altere a filial entre e saia do campo cidade.';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ZeraCamposNotaFiscalDuplicada;
begin
  VprDNota.SeqNota := 0;
  VprDNota.NumNota := 0;
  VprDNota.SeqItemNatureza := 0;
  VprDNota.CodUsuario := varia.CodigoUsuario;
  VprDNota.NumCotacaoTransportadora := '';
  VprDNota.DesChaveNFE := '';
  VprDNota.NumProtocoloNFE := '';
  VprDNota.NumProtocoloCancelamentoNFE := '';
  VprDNota.NumReciboNFE  := '';
  VprDNota.CodMotivoNFE := '';
  VprDNota.DesMotivoNFE := '';
  VprDNota.DesMotivoCancelamentoNFE := '';
  VprDNota.DatNSU := date;
  VprDNota.IndNotaCancelada := false;
  VprDNota.IndNotaImpressa := false;
  VprDNota.IndECF := false;
  VprDNota.IndNotaVendaConsumidor := false;
  VprDNota.IndNotaDevolvida := false;
  VprDNota.IndNFEEnviada := false;
  VprDNota.DatEmissao := date;
  VprDNota.DatSaida := date;
  VprDNota.HorSaida := now;
  VprDNota.NumNSU := 0;
  ECodNatureza.Clear;
  VprDNota.CodNatureza := '';
  VprDNota.SeqItemNatureza := 0;
  VprDNota.DesDadosAdicinais.Clear;
end;

{************ monta nova nota, chamada externa ******************************* }
function TFNovaNotaFiscalNota.NovaNotaFiscal : Boolean;
var
  VpfResultado : String;
begin
  result := false;
  VprDNota := TRBDNotaFiscal.cria;
  VprOperacao := ocInsercao;

   VpfResultado :=  VerificaVariaveis;
   if VpfResultado = '' then
   begin
     ConfiguraItemNota(Varia.NotaFiscalPadrao);
     InicializaNota;
     ShowModal;
     result := VprAcao;
   end
   else
     aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.InicializaNota;
begin
  varia.ProdutoFiltro := '';
  VprCodNaturezaAtual := '';
  LimpaDadosClientes;
  VprDCliente.free;
  VprDCliente := TRBDCliente.cria;
  VprDTransportadora.free;
  VprDTransportadora := TRBDCliente.cria;
  VprDNota.free;
  VprDNota := TRBDNotaFiscal.cria;
  with VprDNota do
  begin
    TipNota := tnNormal;
    IndNotaCancelada := false;
    IndECF := false;
    IndNotaVendaConsumidor := VprNotaFiscalConsumidor;
    IndNotaImpressa := false;
    IndNotaDevolvida := false;
    IndReducaoICMS := false;
    IndNFEEnviada := false;
    CodFilial := Varia.CodigoEmpFil;
    DesUFFilial := varia.UFFilial;
    CodNatureza := Varia.NaturezaNota;
    CodUsuario := Varia.CodigoUsuario;
    CodTipoFrete := varia.FretePadraoNF;
    if CodTipoFrete = 0 then
       CodTipoFrete := 2;
    DatEmissao := date;
    DatSaida := date;
    HorSaida := now;
    DesSerie := Varia.SerieNota;
    if varia.MarcaEmbalagem <> '' then
      DesMarcaEmbalagem := varia.MarcaEmbalagem;
    DesPlacaVeiculo := varia.PlacaVeiculoNota;
    CodTransportadora := varia.CodTransportadora;
    CodCondicaoPagamento := varia.CondPagtoVista;  // condicao de pagamento default
    DesTipoNota := 'S';
    ValDesconto:= 0;
    PerDesconto := 0;
    PerIssqn := varia.ISSQN;
    if config.EmiteNFe then
      CodModeloDocumento := 55
    else
      CodModeloDocumento := 1;
  end;

  GProdutos.ADados := VprDNota.Produtos;
  GServicos.ADados := VprDNota.Servicos;
  LimpaComponentes(FundoNota,0);
  EstadoBotoes(true);
  CarDTela;
  LimpaStringGrid;
  ActiveControl := ECodNatureza;
  CarregaDadosFilial;  // carrega o cgc e incricao da filial
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Funcoes dos componentes superiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{****************Carrega o cgc e o cpf da filial da nota fiscal****************}
procedure TFNovaNotaFiscalNota.CarregaDadosFilial;
begin
   FunNotaFiscal.LocalizaFilial(Aux,Varia.CodigoEmpFil);
   LCGCFilial.Caption := aux.fieldByName('C_CGC_FIL').AsString;
   LIEFilial.Caption := aux.fieldByName('C_INS_FIL').AsString;
   LNomFilial.Caption := aux.fieldByName('C_NOM_FAN').AsString;
   VprTextoReducao := aux.fieldByName('C_TEX_RED').AsString;
   VprDNota.DesDadosAdicinais.text := aux.fieldByName('C_DAD_ADI').AsString;
  MAdicional.Clear;
     // daddos adionais
  if VprDNota.DesDadosAdicinais.text <> '' then
    MAdicional.Lines.Text := VprDNota.DesDadosAdicinais.text;

   Aux.Close;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ValidaDadosRomaneioComOrcamento(VpaDRomaneioItem: TRBDRomaneioOrcamentoItem);
Var
  VpfOrdemCompra : string;
begin
    AdicionaSQLAbreTabela(Aux,'Select MOV.N_VLR_PRO, MOV.N_ALT_PRO, MOV.C_COD_UNI, MOV.C_PRO_REF, MOV.C_ORD_COM, ' +
                              ' CAD.C_ORD_COM ORDEMCOMPRAPEDIDO '+
                              ' FROM MOVORCAMENTOS MOV, CADORCAMENTOS CAD '+
                              ' Where MOV.I_EMP_FIL = ' +IntToStr(VpaDRomaneioItem.CodFilialOrcamento)+
                              ' AND MOV.I_LAN_ORC = ' +IntToStr(VpaDRomaneioItem.LanOrcamento)+
                              ' AND MOV.I_SEQ_PRO = ' +IntToStr(VpaDRomaneioItem.SeqProduto)+
                              ' AND MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                              ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC ' +
                              ' AND '+SQLTextoIsNull('MOV.I_COD_COR','0')+' = ' +IntToStr(VpaDRomaneioItem.CodCor)+
                              ' AND '+SQLTextoIsNull('MOV.I_COD_TAM','0')+' = ' +IntToStr(VpaDRomaneioItem.CodTamanho));
    //CARREGA AS ORDENS DE COMPRA DA NOTA FISCAL;
    if VpaDRomaneioItem.ValUnitario <> Aux.FieldByName('N_VLR_PRO').AsFloat then
      aviso('VALOR UNITARIO PRDUTO ALTERADO NO PEDIDO!!!'#13'O valor unitário do produto "'+VpaDRomaneioItem.CodProduto+'-'+VpaDRomaneioItem.NomProduto+'" no orçamento está preenchida com "' +
              FormatFloat(varia.MascaraValorUnitario, Aux.FieldByName('N_VLR_PRO').AsFloat)+ '" e no romaneio esta preenchido com "'+ FormatFloat(varia.MascaraValorUnitario,VpaDRomaneioItem.ValUnitario)+'"');
    if VpaDRomaneioItem.DesUM <> Aux.FieldByName('C_COD_UNI').AsString then
      aviso('UNIDADE DE MEDIDA ALTERADA NO PEDIDO!!!'#13'A unidade de medida do produto "'+VpaDRomaneioItem.CodProduto+'-'+VpaDRomaneioItem.NomProduto+'" no orçamento está preenchida com "' +
               Aux.FieldByName('C_COD_UNI').AsString+ '" e no romaneio esta preenchido com "'+ VpaDRomaneioItem.DesUM+'"');
    if VpaDRomaneioItem.DesReferenciaCliente <> Aux.FieldByName('C_PRO_REF').AsString  then
      aviso('REFERENCIA CLIENTE ALTERADA NO PEDIDO!!!'#13'A referencia do cliente do produto "'+VpaDRomaneioItem.CodProduto+'-'+VpaDRomaneioItem.NomProduto+'" no orçamento está preenchida com "' +
               Aux.FieldByName('C_PRO_REF').AsString+ '" e no romaneio esta preenchido com "'+ VpaDRomaneioItem.DesReferenciaCliente+'"');
    VpfOrdemCompra := Aux.FieldByName('ORDEMCOMPRAPEDIDO').AsString;
    if Aux.FieldByName('C_ORD_COM').AsString <> '' then
      VpfOrdemCompra := Aux.FieldByName('C_ORD_COM').AsString;
    if VpaDRomaneioItem.DesOrdemCompra <> VpfOrdemCompra then
      aviso('ORDEM DE COMPRA ALTERADA NO PEDIDO!!!'#13'A ordem de compra do produto "'+VpaDRomaneioItem.CodProduto+'-'+VpaDRomaneioItem.NomProduto+'" no orçamento está preenchida com "' +
               VpfOrdemCompra+ '" e no romaneio esta preenchido com "'+ VpaDRomaneioItem.DesOrdemCompra+'"');
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ValidaValorUnitarioProduto;
var
  VpfValUnitarioUMOriginal,VpfDiferencaValor,VpfPerDescontoReal : double;
  VpfSolicitarSenha : Boolean;
begin
  VpfSolicitarSenha := false;
  if GProdutos.Cells[10,GProdutos.ALinha] <> '' then
  begin
    if ArredondaDecimais(VprDProdutoNota.ValUnitario,varia.Decimais) <> StrToFloat(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.')) then
      VprDProdutoNota.ValUnitario := StrToFloat(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.'));

    if VprDProdutoNota.ValUnitarioOriginal > 0 then
    begin
      VpfValUnitarioUMOriginal := FunProdutos.CalculaValorPadrao(VprDProdutoNota.UM,VprDProdutoNota.UMOriginal,VprDProdutoNota.ValUnitarioOriginal,IntToStr(VprDProdutoNota.SeqProduto));
      if VpfValUnitarioUMOriginal > 0 then
      begin
        VpfDiferencaValor := VpfValUnitarioUMOriginal - VprDProdutoNota.ValUnitario;
        VpfPerDescontoReal := (VpfDiferencaValor * 100)/VpfValUnitarioUMOriginal;
        if VpfPerDescontoReal > varia.DescontoMaximoNota then
          VpfSolicitarSenha := true;
      end;
    end;
    if VpfSolicitarSenha then
    begin
     if not FunProdutos.ValidaAlterarValorUnitario( FPrincipal.CorForm.ACorPainel, FPrincipal.CorFoco.AFundoComponentes ) then
     begin
       VprDProdutoNota.ValUnitario := FunProdutos.ValorPelaUnidade(VprDProdutoNota.UMOriginal,VprDProdutoNota.UM,VprDProdutoNota.SeqProduto,
                                 VprDProdutoNota.ValUnitarioOriginal);
     end
     else
       VprDProdutoNota.ValUnitarioOriginal := FunProdutos.ValorPelaUnidade(VprDProdutoNota.UM,VprDProdutoNota.UMOriginal,VprDProdutoNota.SeqProduto,VprDProdutoNota.ValUnitario);
    end;
  end
  else
    VprDProdutoNota.ValUnitario := 0;
  CalculaValorTotalProduto;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ValorParcelaValido(VpaDNota: TRBDNotaFiscal): string;
var
  VpfQtdParcelas : Integer;
begin
  if puValorMinimoParcela in varia.PermissoesUsuario then
  begin
    VpfQtdParcelas := sistema.RQtdParcelasCondicaoPagamento(VpaDNota.CodCondicaoPagamento);
    if  (VpfQtdParcelas > 1) then
    begin
      if (VpaDNota.ValTotal / VpfQtdParcelas) < varia.ValMinimoParcela then
        result := 'VALOR PARCELA INVÁLIDO!!!'#13'O valor minimo da parcela é '+FormatFloat('R$ #,###,##0.00',Varia.ValMinimoParcela);
    end;
  end;

end;

{******************************************************************************}
function TFNovaNotaFiscalNota.DadoNfeValidos(VpaDCliente: TRBDCliente): string;
var
  VpfLaco : Integer;
  VpfDProNota : TRBDNotaFiscalProduto;
  VpfDSerNota : TRBDNotaFiscalServico;
begin
  result := '';
  if ((config.EmiteNFe) or (config.EmiteSped)) then
  begin
    if VprDCliente.TipoPessoa = 'E' then
    begin
      if VprDNota.DesUFEmbarque = '' then
        result := 'UF DE EMBARQUE NÃO PREENCHIDO!!!'#13'É necessário preencher a UF de embarque quando o cliente é exportação.';
        if VprDNota.DesLocalEmbarque = '' then
          result := 'LOCAL DE EMBARQUE NÃO PREENCHIDO!!!'#13'É necessário preencher o local de embarque quando o cliente é exportação.';
    end;
    if VprDCliente.TipoPessoa <> 'E' then
      result := FunClientes.DadosSpedClienteValido(VpaDCliente);
    if result = '' then
    begin
      if VprDNota.CodTransportadora <> 0 then
      begin
        if VprDTransportadora.DesEndereco = '' then
          result := 'ENDEREÇO DA TRANSPORTADORA NÃO PREENCHIDO!!!'#13+'É necessário preencher o endereço da transportadora'
        else
          if VprDTransportadora.CGC_CPF = '' then
            result := 'CNPJ DA TRANSPORTADORA NÃO PREENCHIDO!!!'+#13+'É necessário preencher o CNPJ da transportadora '
          else
            if VprDTransportadora.InscricaoEstadual = '' then
              result := 'INSCRIÇÃO ESTADUAL DA TRANSPORTADORA NÃO PREENCHIDA!!!'+#13+'É necessário preencher a INSCRIÇÃO ESTADUAL da transportadora.'
            else
              if VprDTransportadora.DesCidade = ''  then
                result := 'CIDADE DA TRANSPORTADORA NÃO PREENCHIDA!!!'+#13+'É necessário preencher a cidade da transportadora.'
              else
                if VprDTransportadora.DesUF = '' then
                  result := 'UF DA TRANSPORTADORA NÃO PREENCHIDA!!!'+#13+'É necessário preencher a UF da transportadora.';
      end;
      if result = '' then
      begin
        if ((EPlacaVeiculo.Text <> '') and (EUFVeiculo.Text = '')) or
           ((EPlacaVeiculo.Text = '') and (EUFVeiculo.Text <> ''))then
          result := 'PLACA DO VEICULO E UF DO VEICULOA NÃO FORAM PREENCHIDOS!!!'#13'É necessario preencher a UF e a placa do veiculo.';
      end;
      if result = '' then
      begin
        for vpflaco := 0 to VprDNota.Produtos.Count - 1 do
        begin
          VpfDProNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpfLaco]);
          if VpfDProNota.CodClassificacaoFiscal <> ''  then
          begin
            if length(DeletaChars(VpfDProNota.CodClassificacaoFiscal,' ')) < 8 then
            begin
              result := 'CODIGO NCM/CLASSIFICAÇÃO FISCAL INVÁLIDO!!!'#13'O produto "'+VpfDProNota.CodProduto+'" possui o código NCM cadastrado errado "'+VpfDProNota.CodClassificacaoFiscal+'"';
              break;
            end;
          end;
          if VpfDProNota.CodCFOP = 0 then
          begin
            result := 'CFOP NÃO PREENCHIDO!!!'#13'O produto "'+VpfDProNota.CodProduto+'" não possui a CFOP preenchida.';
            break;
          end;
        end;
        if result = '' then
        begin
          for VpfLaco := 0 to VprDNota.Servicos.Count - 1 do
          begin
            VpfDSerNota := TRBDNotaFiscalServico(VprDNota.Servicos.Items[VpfLaco]);
            if VpfDSerNota.CodFiscal = 0 then
            begin
              result := 'CODIGO FISCAL DO SERVICO NÃO PREENHCIDO!!!'#13'É necessário preencher o codigo fiscal para o serviço "'+IntToStr(VpfDSerNota.CodServico)+'"';
              break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.DadosNotaValidos : String;
begin
  AtualizaStatus('Validados os dados da nota.');
  result := '';
  if ((VprDNota.Produtos.Count = 0) and (VprDNota.Servicos.Count=0)) and
     (VprDNota.IndNaturezaProduto or VprDNota.IndNaturezaServico) then
    result := 'NÃO FOI ADICIONADO NENHUM PRODUTO OU SERVIÇO!!!'#13'Não é possivel gravar a nota fiscal porque não foram adicinados nenhum produto ou serviço.';
  if result = '' then
  begin
    if VprDNota.CodCliente = 0 then
      result := 'FALTA SELECIONAR CLIENTE!!!'#13'É necessário preencher o cliente.';

    if result = '' then
    begin
      if VprDNota.IndGeraFinanceiro then
      begin
        if (VprDNota.CodCondicaoPagamento = 0) then
          result := 'FALTA SELECIONAR A CONDIÇÃO DE PAGAMENTO!!!'#13'É necessário preencher a condição de pagamento.'
        else
          if VprDNota.CodFormaPagamento = 0 then
            result := 'FALTA SELECIONAR A FORMA DE PAGAMENTO!!!'#13'É necessário preencher a forma de pagamento.';
      end;

      if result = '' then
      begin
        if (VprDNota.CodVendedor = 0) and (VprDNota.IndGeraComissao) then
          result := 'FALTA SELECIONAR O VENDEDOR!!!'#13'É necessário preencher o vendedor.';
      end;
    end;
  end;
  if result = '' then
  begin
    if VprDNota.CodNatureza = '' then
      result :=  'FALTA SELECIONAR A NATUREZA DE OPERAÇÃO!!!'#13'É necessário preencher a natureza de operação.';
    if result = '' then
    begin
      if VprDNota.SeqItemNatureza = 0 then
        result := 'FALTA SELECIONAR O ITEM DA NATUREZA DE OPERACÃO!!!'#13'É necessário preencher o item da natureza de operação.';
    end;
  end;

  if (config.QtdVolumeObrigatorio) and not(GProdutos.Focused) and not(GServicos.Focused) then
  begin
    if EQtd.AsInteger = 0 then
      result := 'QUANTIDADE DE VOLUMES NÃO PREENCHIDA!!!'#13'É obrigatório digitar a quantidade de volumes na nota fiscal.';
  end;
  if not(config.NotaFiscalConjugada) and (VprDNota.Produtos.Count > 0) and
     (VprDNota.Servicos.Count > 0) then
    result := 'NÃO É PERMITIDO NOTA FISCAL CONJUGADA!!!'#13'Não é possivel adicionar produtos e serviços na mesma nota fiscal.';

end;

{******************************************************************************}
function TFNovaNotaFiscalNota.NotaDevolucao(VpaCodFilial,VpaSeqNota: Integer): Boolean;
var
  VpfTextoDevolucao : String;
begin
  VprOperacao:= ocConsulta;
  InicializaNota;
  FunNotaFiscal.CarDNotaFiscal(VprDNota,VpaCodFilial,VpaSeqNota);
  VprDNota.TipNota := tnDevolucao;
  VpfTextoDevolucao := 'REFERENTE DEVOLUCAO NOTA FISCAL "'+IntToStr(VprDNota.NumNota)+'" do dia "'+FormatDateTime('DD/MM/YYYY',VprDNota.DatEmissao)+'"';

  ZeraCamposNotaFiscalDuplicada;

  GProdutos.CarregaGrade;
  CarDTela;
  CarNaturezaOperacaoNota;
  AssociaNaturezaItens;
  MAdicional.Lines.Add(VpfTextoDevolucao);


  EstadoBotoes(true);
  VprOperacao:= ocInsercao;
  ValidaGravacao1.execute;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AtualizaStatus(VpaStatus : String);
begin
  StatusBar1.Panels[0].Text := VpaStatus;
  StatusBar1.Refresh;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.LimpaDadosClientes;
begin
  Label34.Caption := '';
  LCGCCPF.Caption := '';
  LEndereco.Caption := '';
  LBairro.Caption := '';
  LCep.Caption := '';
  LCidade.Caption := '';
  LUF.Caption := '';
  LFone.Caption := '';
  LCGCTranposrtadora.Caption := '';
  LEnderecoTransportadora.Caption := '';
  LNumEnderecoTransportadora.Caption := '';
  LMunicipioTransportadora.Caption := '';
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AdicionaItemProduto(VpaDProdutoNota : TRBDNotaFiscalProduto);
Var
  VpfDProduto : TRBDProduto;
begin
  FunNotaFiscal.ExisteProduto('',VprDNota,VpaDProdutoNota);
  VprDProdutoNota.UnidadeParentes.free;
  VprDProdutoNota.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDProdutoNota.UMOriginal);
  VpfDProduto := TRBDProduto.Cria;
  FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,Varia.CodigoEmpFil,VprDProdutoNota.SeqProduto);
  VprDProdutoNota.IndSubstituicaoTributaria := VpfDProduto.IndSubstituicaoTributaria;
  VprDProdutoNota.PerSubstituicaoTributaria := VpfDProduto.PerSubstituicaoTributaria;
  VprDProdutoNota.NumDestinoProduto := VpfDProduto.NumDestinoProduto;
  VprDProdutoNota.CodCST := FunNotaFiscal.RCSTICMSProduto(VprDCliente,VpfDProduto,VprDNatureza);
  VprDProdutoNota.CodCFOP := FunNotaFiscal.RCFOPProduto(VprDCliente,VprDNatureza,VpfDProduto);
  if VpfDProduto.IndDescontoBaseICMSConfEstado then
    VprDProdutoNota.PerReducaoUFBaseICMS := VprDNota.PerReducaoUFICMS
  else
    VprDProdutoNota.PerReducaoUFBaseICMS := 0;
  VpfDProduto.free;

  if VprDProdutoNota.IndReducaoICMS then
    VprDProdutoNota.PerICMS :=  (VprDNota.ValICMSPadrao * VprDProdutoNota.PerReducaoICMSProduto)/100
  else
    VprDProdutoNota.PerICMS :=  VprDNota.ValICMSPadrao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AdicionaProdutosContratoDadosAdicionais(VpaDContrato: TRBDContratoCorpo);
var
  VpfLaco : Integer;
  VpfDProdutContrato : TRBDContratoItem;
begin
  MAdicional.Lines.Text := 'ASSINATURA ';
  for VpfLaco := 0 to VpaDContrato.ItensContrato.Count -1  do
  begin
    VpfDProdutContrato := TRBDContratoItem(VpaDContrato.ItensContrato.Items[Vpflaco]);
    MAdicional.Lines.Text := MAdicional.Lines.Text + VpfDProdutContrato.NomProduto+', ';
  end;
  MAdicional.Lines.Text := copy(MAdicional.Lines.Text,1,length(MAdicional.Lines.Text)-1);
  MAdicional.Lines.text := MAdicional.Lines.text+ ' VIGENCIA '+FormatDateTime('DD/MM/YYYY',VpaDContrato.DatInicioVigencia)+ ' A ' +
                           FormatDateTime('DD/MM/YYYY',VpaDContrato.DatFimVigencia);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AdicionaProdutosNotaEntrada(VpaDNotaEntrada: TRBDNotaFiscalFor);
var
  VpfLaco : Integer;
  VpfDProdutNotaEntrada : TRBDNotaFiscalForItem;
begin
  for VpfLaco := 0 to VpaDNotaEntrada.ItensNota.Count -1  do
  begin
    VpfDProdutNotaEntrada := TRBDNotaFiscalForItem(VpaDNotaEntrada.ItensNota.Items[Vpflaco]);
    VprDProdutoNota := VprDNota.AddProduto;
    VprDProdutoNota.CodCST :=  '000';
    VprDProdutoNota.SeqProduto := VpfDProdutNotaEntrada.SeqProduto;
    AdicionaItemProduto(VprDProdutoNota);
    if VprDProdutoNota.IndReducaoICMS then
      VprDProdutoNota.PerICMS :=  (VprDNota.ValICMSPadrao * VprDProdutoNota.PerReducaoICMSProduto)/100
    else
      VprDProdutoNota.PerICMS :=  VprDNota.ValICMSPadrao;
    if VpfDProdutNotaEntrada.CodCor <> 0 then
      VprDProdutoNota.CodCor := VpfDProdutNotaEntrada.CodCor;
    VprDProdutoNota.CodProduto := VpfDProdutNotaEntrada.CodProduto;
    VprDProdutoNota.DesCor := VpfDProdutNotaEntrada.DesCor;
    if config.GerarFinanceiroCotacao or config.GerarNotaPelaQuantidadeProdutos then
      VprDProdutoNota.QtdProduto := VpfDProdutNotaEntrada.QtdProduto;
    if VprDCliente.IndQuarto then
      VprDProdutoNota.ValUnitario := VpfDProdutNotaEntrada.ValUnitario / 4
    else
      if VprDCliente.IndMeia then
        VprDProdutoNota.ValUnitario := VpfDProdutNotaEntrada.ValUnitario / 2
      else
        if VprDCliente.IndVintePorcento then
           VprDProdutoNota.ValUnitario := VpfDProdutNotaEntrada.ValUnitario / 5
         else
          if VprDCliente.IndDecimo then
             VprDProdutoNota.ValUnitario := VpfDProdutNotaEntrada.ValUnitario / 10
           else
             VprDProdutoNota.ValUnitario := VpfDProdutNotaEntrada.ValUnitario;
    VprDProdutoNota.UM := VpfDProdutNotaEntrada.UM;
    VprDProdutoNota.ValTotal := VprDProdutoNota.ValUnitario * VprDProdutoNota.QtdProduto;
    VprDProdutoNota.ValIPI := ArredondaDecimais((VprDProdutoNota.ValTotal * VprDProdutoNota.PerIPI)/100,2);
    FunNotaFiscal.VerificaItemNotaDuplicado(VprDNota);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AdicionaServicoContrato(VpaDContrato: TRBDContratoCorpo);
begin
  VprDServicoNota := VprDNota.AddServico;
  VprDServicoNota.CodServico := VpaDContrato.CodServico;
  FunNotaFiscal.ExisteServico(IntToStr(VprDServicoNota.CodServico),VprDNota,VprDServicoNota);
  VprDServicoNota.QtdServico := 1;

  VprDServicoNota.ValUnitario := VpaDContrato.ValContrato;
  VprDServicoNota.ValTotal := VpaDContrato.ValContrato;

  CalculaValorTotal;
  GServicos.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AdicionaServicosNotaEntrada(
  VpaDNOtaEntrada: TRBDNotaFiscalFor);
var
  VpfLaco : Integer;
  VpfDServicoNotaEntrada : TRBDNotaFiscalForServico;
begin
  for VpfLaco := 0 to VpaDNotaEntrada.ItensServicos.Count -1  do
  begin
    VpfDServicoNotaEntrada := TRBDNotaFiscalForServico(VpaDNotaEntrada.ItensServicos.Items[Vpflaco]);
    VprDServicoNota := VprDNota.AddServico;
    VprDServicoNota.CodServico := VpfDServicoNotaEntrada.CodServico;
    FunNotaFiscal.ExisteServico(IntToStr(VprDServicoNota.CodServico),VprDNota,VprDServicoNota);
    VprDServicoNota.NomServico := VpfDServicoNotaEntrada.NomServico;
    VprDServicoNota.DesAdicional := VpfDServicoNotaEntrada.DesAdicional;
    VprDServicoNota.QtdServico := VpfDServicoNotaEntrada.QtdServico;
    VprDServicoNota.CodClassificacao := VpfDServicoNotaEntrada.CodClassificacao;
    VprDServicoNota.CodFiscal := VpfDServicoNotaEntrada.CodFiscal;

    if VprDCliente.IndQuarto then
    begin
      VprDServicoNota.ValUnitario := VpfDServicoNotaEntrada.ValUnitario / 4;
      VprDServicoNota.ValTotal := VpfDServicoNotaEntrada.ValTotal / 4;
    end
    else
      if VprDCliente.IndMeia then
      begin
        VprDServicoNota.ValUnitario := VpfDServicoNotaEntrada.ValUnitario / 2;
        VprDServicoNota.ValTotal := VpfDServicoNotaEntrada.ValTotal / 2;
      end
      else
      if VprDCliente.IndVintePorcento then
        begin
          VprDServicoNota.ValUnitario := VpfDServicoNotaEntrada.ValUnitario / 5;
          VprDServicoNota.ValTotal := VpfDServicoNotaEntrada.ValTotal / 5;
        end
        else
        if VprDCliente.IndDecimo then
          begin
            VprDServicoNota.ValUnitario := VpfDServicoNotaEntrada.ValUnitario / 10;
            VprDServicoNota.ValTotal := VpfDServicoNotaEntrada.ValTotal / 10;
          end
          else
          begin
            VprDServicoNota.ValUnitario := VpfDServicoNotaEntrada.ValUnitario;
            VprDServicoNota.ValTotal := VpfDServicoNotaEntrada.ValTotal;
          end;
    if VprDServicoNota.PerISSQN <> 0 then
      EPerISSQN.AValor := VprDServicoNota.PerISSQN;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.RNumerosPedido : String;
var
  VpfLaco : Integer;
begin
  result := '';
  if VprCotacoes <> nil then
  begin
    for VpfLaco := 0 to VprCotacoes.Count - 1 do
    begin
      result := result + IntTostr(TRBDOrcamento(VprCotacoes.Items[Vpflaco]).LanOrcamento)+'; ';
    end;
    if result <> '' then
    begin
      result := copy(result,1,length(result)-2);
      result := 'Cotacoes : '+ result;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.TelaModoConsulta(VpaConsulta : Boolean);
begin
  AlteraReadOnlyDet(FundoNota,0,VpaConsulta);
  AlterarEnabledDet([CValorPercentual,RTipoNota],not VpaConsulta);
  if VpaConsulta then
    GProdutos.Options := [gofixedVertLine,gofixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSizing,goColSizing]
  else
    GProdutos.Options := [gofixedVertLine,gofixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSizing,goColSizing,goEditing,goTabs];
end;

{********************** select da natureza de operacao ********************* }
procedure TFNovaNotaFiscalNota.ECodNaturezaSelect(Sender: TObject);
begin
  ECodNatureza.ASelectLocaliza.Clear;
  ECodNatureza.ASelectLocaliza.add(' Select * from CadNatureza where c_nom_nat like ''@%'' ' +
                                  ' and c_cod_nat in ( select c_cod_nat from movNatureza ' +
                                  '                    where c_mos_not = ''S'' '+
                                  '                    and C_TIP_EMI = ''P''');
  ECodNatureza.ASelectValida.clear;
  ECodNatureza.ASelectValida.Add(' select * from CadNatureza where C_COD_NAT = ''@'' ' +
                                ' and c_cod_nat in ( select c_cod_nat from movNatureza ' +
                                '                    where c_mos_not = ''S'' '+
                                  '                    and C_TIP_EMI = ''P''');
  if ConfigModulos.Estoque then
  begin
    ECodNatureza.ASelectLocaliza.add(' and i_cod_ope is not null');
    ECodNatureza.ASelectValida.Add(' and i_cod_ope is not null');
  end;
  if ConfigModulos.ContasAReceber then
  begin
    ECodNatureza.ASelectLocaliza.add(' and C_CLA_PLA is not null');
    ECodNatureza.ASelectValida.Add(' and C_CLA_PLA is not null');
  end;
  ECodNatureza.ASelectLocaliza.add(' )');
  ECodNatureza.ASelectValida.Add(' ) ');
end;

{*************** retorno da localizacao da natureza ************************ }
procedure TFNovaNotaFiscalNota.ECodNaturezaRetorno(Retorno1, Retorno2: String);
begin
  if (retorno1 <> '')and (retorno1 <> VprCodNaturezaAtual) then
  begin
    FunNotaFiscal.LocalizaMovNatureza(MovNatureza, retorno1, true );

    if FunNotaFiscal.ContaLinhasTabela(MovNatureza) > 1 then
    begin
      FItensNatureza := TFItensNatureza.CriarSDI(application, '', true);
      FItensNatureza.PosicionaNatureza(MovNatureza);
      FItensNatureza.free;
    end;
    VprDNota.CodNatureza := MovNatureza.fieldbyName('C_COD_NAT').AsString;
    VprDNota.SeqItemNatureza := MovNatureza.fieldbyName('i_seq_mov').AsInteger;
    FunNotaFiscal.CarDNaturezaOperacao(VprDNota);
    FunNotaFiscal.CarDNaturezaOperacao(VprDNatureza,VprDNota.CodNatureza,VprDNota.SeqItemNatureza);

    EPlano.Text := VprDNota.CodPlanoContas;
    EPlanoExit(self);
    MontaObservacao;
    if VprOperacao in [ocInsercao,ocEdicao] then
    begin
      FunNotaFiscal.AlteraValorICMS(VprDNota);
      AssociaNaturezaItens;
    end;
    GProdutos.CarregaGrade;

    //verifica se o tipo de nota é de entrada ou saída
    if MovNatureza.fieldbyName('C_ENT_SAI').AsString = 'S' then
    begin
      VprDNota.DesTipoNota := 'S';
      RTipoNota.ItemIndex := 1;
    end
    else
    begin
      VprDNota.DesTipoNota := 'E';
      RTipoNota.ItemIndex := 0;
    end;

    // caso a natureza nao permita insercao de produtos.
    if VprOperacao in [ocInsercao,ocEdicao] then
      if MovNatureza.FieldByname('c_ins_pro').AsString  = 'N' then
        GProdutos.Options := GProdutos.Options - [goEditing,goTabs] // [gofixedVertLine,gofixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSizing,goColSizing]
      else
        GProdutos.Options := GProdutos.Options + [goEditing,goTabs];//[gofixedVertLine,gofixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSizing,goColSizing,goEditing,goTabs];

    // caso nao gere contas a receber
    if not VprDNota.IndGeraFinanceiro then
    begin
      if not((VprOrcamento) and (config.GerarFinanceiroCotacao) and not(config.ExcluirFinanceiroCotacaoQuandoGeraNota)) then
      begin
        AlterarEnabledDet([Econdicoes,BCondicao],false);
        ECondicoes.ACampoObrigatorio := false;
        Econdicoes.ACampoObrigatorio := false;
        ECondicoes.Clear;
        LNomCondicao.Caption := '';
      end;
    end
    else
    begin
      AlterarEnabledDet([Econdicoes,BCondicao],true);
      Econdicoes.ACampoObrigatorio := true;
    end;
    if VprOperacao in [ocInsercao,ocEdicao] then
        ValidaGravacao1.Execute;
    VprCodNaturezaAtual := retorno1;
    CalculaValorTotal;
  end;
end;

{*************** cadastro de nova natureza *********************************** }
procedure TFNovaNotaFiscalNota.ECodNaturezaCadastrar(Sender: TObject);
begin
   FNovaNatureza := TFNovaNatureza.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNatureza'));
   FNovaNatureza.CadNaturezas.Insert;
   FNovaNatureza.BotaoGravar1.AFecharAposOperacao := true;
   FNovaNatureza.ShowModal;
   Localiza.AtualizaConsulta;
   AtualizaSQLTabela(MovNatureza);
end;


{************* cadastro de novo cliente ************************************* }
procedure TFNovaNotaFiscalNota.ECodClienteAlterar(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas[0].AValorRetorno <> '' then
  begin
    FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
    AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+VpaColunas[0].AValorRetorno);
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    FNovoCliente.free;
    VprDNota.CodCliente := -1;
  end;
end;

procedure TFNovaNotaFiscalNota.ECodClienteCadastrar(Sender: TObject);
begin
   FNovoCliente := TFNovoCliente.CriarSDI(application,'', true);
   FNovoCliente.CadClientes.Insert;
   FNovoCliente.ShowModal;
   Localiza.AtualizaConsulta;
end;

procedure TFNovaNotaFiscalNota.ECodClienteRetorno(VpaColunas: TRBColunasLocaliza);
var
  VpfAcao : boolean;
  VpfResultado : String;
begin
  VpfAcao := true;
  VpfResultado := '';
  if VpaColunas[0].AValorRetorno <> '' then
  begin
    if StrToInt(VpaColunas[0].AValorRetorno) <> VprDCliente.CodCliente then
    begin
      VprDCliente.CodCliente := StrToInt(VpaColunas[0].AValorRetorno);
      VpfResultado := FunClientes.CarDCliente(VprDCliente,false,VprDNota.IndExigirCPFCNPJ);
      if VpfResultado = '' then
      begin
        if (config.EmiteNFe) or (config.EmiteSped)  then
        begin
          if VprDCliente.TipoPessoa <> 'E' then
            VpfResultado :=   FunClientes.DadosSpedClienteValido(VprDCliente);
        end;
        if VpfResultado = '' then
        begin
          if (VprOperacao in [ocInsercao,OcEdicao]) then
          begin
            VprDNota.IndClienteRevenda := VprDCliente.IndRevenda;
            VprDNota.IndDescontarISS := VprDCliente.IndDescontarISS;
            if not VprNotaAutomatica then
              VpfAcao := SituacaoFinanceiraOK(VprDCliente);

            If VpfAcao Then
            begin
              CardClienteNota(VprDCliente);
              FunNotaFiscal.CarValICMSPadrao(VprDNota.ValICMSPadrao,VprDNota.ValICMSAliquotaInternaUFDestino,VprDNota.PerReducaoUFICMS, VprDCliente.DesUF,VprDCliente.InscricaoEstadual,VprDCliente.TipoPessoa[1] = 'J',false,VprDCliente.IndUFConvenioSubstituicaoTributaria);
              if not((VprDNota.IndCalculaICMS) and (VprDCliente.IndDestacarICMSNota)and (VprDCliente.DesResolucaoProEmprego = '')) then
                VprDNota.ValICMSPadrao := 0;
              if (VprDCliente.DesObservacao <> '') and not VprNotaAutomatica and
                 (VprCodClienteObservacao <> ECodCliente.AInteiro) then
              begin
                FMostraObservacaoCliente := TFMostraObservacaoCliente.CriarSDI(application , '', FPrincipal.VerificaPermisao('FMostraObservacaoCliente'));
                FMostraObservacaoCliente.MostraObservacaoCliente(VprDCliente);
                FMostraObservacaoCliente.free;
                VprCodClienteObservacao := ECodCliente.AInteiro;
              end;

              if VprDCliente.TipoPessoa <> 'E' then
              begin
                if VprDNota.IndNaturezaEstadoLocal then
                begin
                  if Uppercase(VprDCliente.DesUF) <> UpperCase(Varia.UFFilial) then
                   VpfAcao := False;
                end
                else
                  if UpperCase(VprDCliente.DesUF) = UpperCase(Varia.UFFilial) then
                    VpfAcao := False;
              end;
            end;
          end;
        end;
      end;

      if not VpfAcao or (VpfResultado <> '') then
      begin
        if VprOrcamento and (VpfResultado = '') then
          ECodNatureza.Clear
        else
        begin
          if VpfResultado = '' then
            aviso(CT_NaturezaErrada)
          else
            aviso(VpfResultado);
          ECodCliente.Clear;
          if Visible then
            ECodCliente.SetFocus
          else
            ActiveControl := ECodCliente;
          VprDCliente.CodCliente:=0;
        end;
      end;
    end;
  end
  else
  begin
    VprDNota.CodCliente := 0;
    LimpaDadosClientes;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
 // CalculaValorTotal;

end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        Tratamentos dos produtos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{******************************************************************************}
function TFNovaNotaFiscalNota.ExisteCor : Boolean;
begin
  result := false;
  if (GProdutos.Cells[3,GProdutos.Alinha]<> '') then
  begin
    result := FunNotaFiscal.Existecor(GProdutos.Cells[3,GProdutos.ALinha],VprDProdutoNota);
    if result then
    begin
      GProdutos.Cells[4,GProdutos.ALinha] := VprDProdutoNota.DesCor;
      ReferenciaProduto;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ExisteCondicaoPagamento : Boolean;
begin
  result := true;
  if ECondicoes.AInteiro <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from CADCONDICOESPAGTO '+
                              ' Where I_COD_PAG = '+ECondicoes.Text);
    result := not Aux.Eof;
    if result then
    begin
      LNomCondicao.Caption := Aux.FieldByName('C_NOM_PAG').AsString;
      if VprDNota.PerDesconto = 0 then
        VprDNota.PerDesconto := Aux.FieldByName('N_PER_DES').AsFloat;
      CarDValorTotalTela;
      CalculaValorTotal;
    end;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.RCodClienteFaccionista: integer;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  result := 0;
  if VprCotacoes <> nil then
  begin
    for VpfLaco := 0 to VprCotacoes.Count - 1 do
    begin
      VpfDCotacao := TRBDOrcamento(VprCotacoes.Items[VpfLaco]);
      if VpfDCotacao.CodClienteFaccionista <> 0 then
      begin
        result := VpfDCotacao.CodClienteFaccionista;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ReferenciaProduto;
begin
  VprDProdutoNota.DesRefCliente := FunProdutos.RReferenciaProduto(VprDProdutoNota.SeqProduto,VprDNota.CodCliente,GProdutos.Cells[3,GProdutos.ALinha]);
  GProdutos.Cells[12,GProdutos.ALinha] := VprDProdutoNota.DesRefCliente;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Funcoes do Corpo da Nota - inferior
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************** chamada para calcular a nota fiscal ************************* }
procedure TFNovaNotaFiscalNota.EValFreteExit(Sender: TObject);
begin
 CalculaValorTotal;
end;

{************************ no exit da condicao de pagamento ****************** }
procedure TFNovaNotaFiscalNota.ECondicoesExit(Sender: TObject);
begin
  VprDNota.PesBruto:= EPesoBruto.AValor;
  VprDNota.PesLiquido:= EPesoLiquido.AValor;
  if (VprOperacao in [ocInsercao,ocEdicao]) then
    if not ExisteCondicaoPagamento then
    begin
      Econdicoes.Clear;
      LocalizaCondicaoPagto;
    end;
end;

{************** Localiza Condicao de pagto ********************************** }
function  TFNovaNotaFiscalNota.LocalizaCondicaoPagto : Boolean;
begin
  CarDClasse;
  FConsultaCondicaoPgto := TFConsultaCondicaoPgto.CREATE(SELF);
  result := FConsultaCondicaoPgto.VisualizaParcelasNota(VprDNota);
  if result then
  begin
    ECondicoes.AInteiro := VprDNota.CodCondicaoPagamento;
    CalculaValorTotal;
    CarDTela;
  end;
  try
    FConsultaCondicaoPgto.free;
  except
  end;
end;

{********************* No retorno da transportadora ************************* }

{************ no retorno do vendedor ***************************************** }
procedure TFNovaNotaFiscalNota.ECoDVendedorRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
     if VprDCliente.PerComissao = 0 then
       EPerComissao.AValor := StrToFloat(retorno1);
  end;
end;

{************ no click do botao localiza condicao pagamento ***************** }
procedure TFNovaNotaFiscalNota.BCondicaoClick(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    LocalizaCondicaoPagto;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.BEnviarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := EnviaEmailNfe;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{************** localiza condicoes de pagamento F3 ************************** }
procedure TFNovaNotaFiscalNota.ECondicoesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
  begin
    LocalizaCondicaoPagto;
  end;
end;

{********** verifica se 0 usuario digita somente 1 ou 2 ********************** }
procedure TFNovaNotaFiscalNota.ECodTipoFreteKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in [ '1','2', #8, #46]) then
     Key := #0;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Funcoes dos Botoes inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{***************** quando cancela uma nota fiscal *************************** }
procedure TFNovaNotaFiscalNota.BotaoCancelar1Click(Sender: TObject);
begin
  LimpaComponentes(FundoNota,0);
  FreeTObjectsList(VprDNota.Produtos);
  GProdutos.CarregaGrade;
  EstadoBotoes(False);
  BotaoGravar1.Enabled := false;
  if VprOrcamento then
    close;
end;

{***************** grava uma nova nota fiscal ******************************** }
procedure TFNovaNotaFiscalNota.BotaoGravar1Click(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao :  TTransactionDesc;
begin
  VpfResultado := '';
  AtualizaStatus('Validando a condição de pagamento');
  if VprOrcamento then
    if not LocalizaCondicaoPagto then
      Econdicoes.Clear;

  if ((Econdicoes.text = '') or ( VprDNota.CodFormaPagamento = 0)) and VprDNota.IndGeraFinanceiro then
  begin
    if not LocalizaCondicaoPagto then
      vpfResultado := 'CONDIÇÃO DE PAGAMENTO NÃO PREENCHIDA!!!'#13'Para gravar a nota é obrigatório preencher a condição de pagamento.';
  end;

  if VpfResultado = '' then
  begin
    AtualizaStatus('Carregando os dados para a classe.');
    VpfResultado := CarDClasse;
    if VpfResultado = '' then
    begin
      AtualizaStatus('Validando os dados da nota');
      VpfResultado := DadosNotaValidos;
      if vpfresultado = '' then
        VpfResultado := DadoNfeValidos(VprDCliente);

      if VpfResultado = '' then
      begin
        VpfResultado := GeraFinanceiroNota;
        if VpfResultado = '' then
        begin
          if FPrincipal.BaseDados.intransaction then
            FPrincipal.BaseDados.Rollback(VpfTransacao);
          VpfTransacao.IsolationLevel :=xilREADCOMMITTED;
          FPrincipal.BaseDados.StartTransaction(vpfTransacao);
          AtualizaStatus('Gravando os dados da nota fiscal');
          FunNotaFiscal.AdicionaTextoProEmprego(VprDNota,VprDCliente);
          FunNotaFiscal.CarTextoDescricaoAdicionalProduto(VprDNota);
          vpfResultado := FunNotaFiscal.GravaDNotaFiscal(VprDNota);
          if VpfResultado = '' then
          begin
            VpfResultado := BaixaNota;
            if VpfResultado = '' then
            begin
              if VprOrcamento Then
              begin
                CarProBaixadosOrcamento;
                VpfResultado := FunNotaFiscal.ExcluiParcelasSinalPagamentoEmAberto(VprCotacoes);
                if VpfResultado = '' then
                begin
                  VpfResultado := FunNotaFiscal.BaixaSaldoSinalPagamento(VprDNota,VprDNota.ValSinalPagamento);
                  if VpfResultado = '' then
                    VpfResultado := FunNotaFiscal.GravaParcelasSinalPagamento(VprDNota);
                end;
              end;
              if VprRomaneioOrcamento then
              begin
                VpfResultado := BaixaProdutoCotacaoRomaneio;
                if VpfResultado = '' then
                begin
                  VpfResultado := FunNotaFiscal.AssociaNotaRomaneio(VprDRomaneioOrcamento.CodFilial,VprDRomaneioOrcamento.SeqRomaneio,VprDNota.CodFilial,VprDNota.SeqNota,VprDNota.NumNota);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  if VpfResultado = '' then
  begin
    FPrincipal.BaseDados.Commit(vpfTransacao);
    EstadoBotoes(false);
    BotaoGravar1.Enabled := false;
    VprAcao := true;
    ENumNota.AsInteger := VprDNota.NumNota;
    EClaFiscal.Text := VprDNota.DesClassificacaoFiscal;
    AtualizaStatus('Nota fiscal gravada com sucesso.');
    TelaModoConsulta(true);
  end
  else
  begin
    if FPrincipal.BaseDados.intransaction then
      FPrincipal.BaseDados.Rollback(VpfTransacao);
    aviso(VpfREsultado);
  end;
end;

procedure TFNovaNotaFiscalNota.BPlanoContasClick(Sender: TObject);
begin

end;

{*********** cadastra uma nova nota fiscal *********************************** }
procedure TFNovaNotaFiscalNota.BotaoCadastrar1Click(Sender: TObject);
begin
  VprOperacao := ocinsercao;
  VprOrcamento := false;
  VprNotaRemessa := false;
  TelaModoConsulta(false);
  InicializaNota;
end;

{************* gera a tela de digitacao de observacao ************************ }
procedure TFNovaNotaFiscalNota.BObservacaoClick(Sender: TObject);
begin
   MontaObservacao;
   FObservacoesNota := TFObservacoesNota.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FObservacoesNota'));
   FObservacoesNota.ObservacaodaNota(MObservacoes.lines.text,vprdNota, NroLinhaObs);
   MontaObservacao;
end;

{************ imprime a nota fiscal ***************************************** }
procedure TFNovaNotaFiscalNota.BImprimirClick(Sender: TObject);
var
  VpfFunNFE : TRBFuncoesNFe;
  VpfResultado : String;
begin
  if config.EmiteNFe then
  begin
    if not Config.NotaFiscalConjugada and
      (VprDNota.Servicos.Count > 0) then
      UnImp.ImprimirNotaFiscal(VprDNota)
    else
    begin
      VpfFunNFE := TRBFuncoesNFe.cria(FPrincipal.BaseDados);
      if (VprDNota.DesChaveNFE = '') then
      begin
        if VprDNota.IndNFEEnviada then
        begin
          VpfResultado := VpfFunNFE.ResolveproblemaComunicacao(VprDNota);
          EChaveNFE.Text := VprDNota.DesChaveNFE;
          if VpfResultado <> '' then
            aviso(VpfResultado)
        end
        else
        begin
          VpfResultado :=  VpfFunNFE.EmiteNota(VprDNota,VprDCliente,StatusBar1);
          EChaveNFE.Text := VprDNota.DesChaveNFE;
          if Vpfresultado <> ''  then
            aviso(Vpfresultado)
          else
          begin
            VpfResultado := FunNotaFiscal.GravaDNotaFiscal(VprDNota);
            if VpfResultado <> '' then
              aviso(VpfResultado);
          end;
        end;
      end;
      if (VprDNota.DesChaveNFE <> '') and not VprDNota.IndNotaCancelada then
        VpfResultado := VpfFunNFE.ImprimeDanfe(VprDNota);

      VpfFunNFE.free;
      if config.NFEHomologacao then
        UnImp.ImprimirNotaFiscal(VprDNota);
    end;
  end
  else
    UnImp.ImprimirNotaFiscal(VprDNota);

  EstadoBotoes(false);
  BAlterarNumero.visible := false;
  if (VprBoletoImpresso = false) and (Config.MensagemBoleto = true) then
    aviso('IMPRIMIR BOLETO!!!'#13+varia.NomeUsuario +' não esqueça de imprimir o boleto.');
end;
{******************************************************************************}
procedure TFNovaNotaFiscalNota.BMenuFiscalClick(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.BNotaRemesaClick(Sender: TObject);
var
  VpfCodFilial, VpfSeqNota,VpfNroNotaAnterior, VpfCodClienteAnterior : Integer;
  VpfDataAnterior : TDateTime;
begin
  VprNotaRemessa := true;
  VpfCodFilial := VprDNota.CodFilial;
  VpfSeqNota := VprDNota.SeqNota;
  VpfNroNotaAnterior := VprDNota.NumNota;
  VpfCodClienteAnterior := VprDNota.CodCliente;
  VpfDataAnterior := VprDNota.DatEmissao;
  VprOperacao := ocinsercao;
  TelaModoConsulta(false);
  InicializaNota;

  FunNotaFiscal.CarDNotaFiscal(VprDNota,VpfCodFilial,VpfSeqNota);

  ZeraCamposNotaFiscalDuplicada;
  ECodCliente.Clear;
  VprDNota.CodCliente := VprCodClienteFaccionista;
  VprDNota.DesDadosAdicinais.Add(FunNotaFiscal.RTextoNotaRemessaFaccionista(VpfCodClienteAnterior,VpfNroNotaAnterior,VprDNota.DesSerie,VpfDataAnterior));

  GProdutos.CarregaGrade;
  CarDTela;
  CarNaturezaOperacaoNota;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Diveros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }


function TFNovaNotaFiscalNota.SendMailMAPI(const Subject, Body, FileName, SenderName,SenderEMail,RecepientName, RecepientEMail: string): Integer;
var
message: TMapiMessage;
lpSender,
lpRecepient: TMapiRecipDesc;
FileAttach: TMapiFileDesc;
SM: TFNMapiSendMail;
MAPIModule: HModule;
SL: TStringList;
i: integer;
begin
FillChar(message, SizeOf(message), 0);
with message do
begin
if (Subject <> '') then
begin
lpszSubject := PAnsiChar( AnsiString(Subject))
end;
if (Body <> '') then
begin
lpszNoteText := PAnsiChar( AnsiString(Body))
end;
if (SenderEMail <> '') then
begin
lpSender.ulRecipClass := MAPI_ORIG;
if (SenderName = '') then
begin
lpSender.lpszName := PAnsiChar( AnsiString(SenderEMail))
end
else
begin
lpSender.lpszName := PAnsiChar( AnsiString(SenderName))
end;
lpSender.lpszAddress := PAnsiChar( AnsiString('SMTP:' + SenderEMail));
lpSender.ulReserved := 0;
lpSender.ulEIDSize := 0;
lpSender.lpEntryID := nil;
lpOriginator := @lpSender;
end;
if (RecepientEMail <> '') then
begin
lpRecepient.ulRecipClass := MAPI_TO;
if (RecepientName = '') then
begin
lpRecepient.lpszName := PAnsiChar( AnsiString(RecepientEMail))
end
else
begin
lpRecepient.lpszName := PAnsiChar( AnsiString(RecepientName))
end;
lpRecepient.lpszAddress := PAnsiChar( AnsiString('SMTP:' + RecepientEMail));
lpRecepient.ulReserved := 0;
lpRecepient.ulEIDSize := 0;
lpRecepient.lpEntryID := nil;
nRecipCount := 1;
lpRecips := @lpRecepient;
end
else
begin
lpRecips := nil
end;
if (FileName = '') then
begin
nFileCount := 0;
lpFiles := nil;
end
else
begin
SL := TStringList.Create;
try
SL.Text := Filename;
for i := 0 to SL.Count - 1 do
begin
FillChar(FileAttach, SizeOf(FileAttach), 0);
FileAttach.nPosition := Cardinal($FFFFFFFF);
FileAttach.lpszPathName :=
PAnsiChar( AnsiString(SL.Strings[i]));//PAnsiChar( AnsiString(FileName);
Inc(nFileCount);//nFileCount := 1;
lpFiles := @FileAttach;
end;
finally
SL.Free;
end;
end;
end;
MAPIModule := LoadLibrary(PWideChar( MAPIDLL));
if MAPIModule = 0 then
begin
Result := -1
end
else
begin
try
@SM := GetProcAddress(MAPIModule, 'MAPISendMail');
if @SM <> nil then
begin
Result := SM(0, Application.Handle, message, MAPI_DIALOG or
MAPI_LOGON_UI, 0);
end
else
begin
Result := 1
end;

finally
FreeLibrary(MAPIModule);
end;
end;
if Result <> 0 then
begin
MessageDlg('Error sending mail (' + IntToStr(Result) + ').', mtError,
[mbOk],
0)
end;
end;



{************ configura a fatura e campos tipo, ipi, valor ipi, servico ****** }
procedure TFNovaNotaFiscalNota.ConfiguraItemNota( NroDoc : Integer);
begin
  UnImp.LocalizaCab(aux, NroDoc);  // abre cabecalho do documento

  FunNotaFiscal.ConfiguraFatura(GRADEPAR, Aux.FieldByName('i_qtd_col').AsInteger, LTituloFaturas);
  NroLinhaProdutos := Aux.FieldByName('i_qtd_lin').AsInteger;
  NroLinhaFatura := Aux.FieldByName('i_qtd_fat').AsInteger;
  NroConjuntoFatura := Aux.FieldByName('i_qtd_col').AsInteger;
  MAdicional.AQdadeLinha := Aux.FieldByName('I_QTD_ADI').AsInteger;
  NroLinhaObs := Aux.FieldByName('I_QTD_OBS').AsInteger;

  GRADEPAR.RowCount := NroLinhaFatura;

  if NroLinhaFatura > 1 then   // configura a rolagem da grade de parcelas
    GRADEPAR.ScrollBars := ssVertical
  else
    GRADEPAR.ScrollBars := ssNone;
end;


{***************************************************************************** }
procedure TFNovaNotaFiscalNota.ConfiguraTela;
begin
  ENumNota.ReadOnly := not config.AlterarNroNF;

  PSERVICO.Visible := ConfigModulos.Servico;
  PExportacao.Visible := VprDCliente.TipoPessoa = 'E';

  PTotaiseExportacao.Height := PTotais.Height;
  if PExportacao.Visible  then
    PTotaiseExportacao.Height := PTotaiseExportacao.Height + PExportacao.Height;

  PRodape.Height := PTotaiseExportacao.Height;
  if PSERVICO.Visible then
    PRodape.Height := PRodape.Height + PSERVICO.Height+5;

  if not config.DescontoNota then
    EValDescontoAcrescimo.ReadOnly := true;

  AlterarVisibleDet([LPlanoContas,LTextoPlanoContas,EPlano,BPlanoContas],CONFIG.PermiteAlterarPlanoContasnaNotafiscal);
  BMenuFiscal.Visible := NomeModulo = 'PDV';
end;

{*********** muda o foco ***************************************************** }
procedure TFNovaNotaFiscalNota.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 115 then
  begin
    if GProdutos.Focused then
    begin
      if ConfigModulos.Servico then
        GServicos.SetFocus
      else
        ECodTransportadora.SetFocus;
    end
    else
      if PossuiFoco(PTotais) then
      begin
        ECodCliente.SetFocus;
        FundoNota.VertScrollBar.Position := 0;
      end
      else
        if GServicos.Focused then
        begin
          ECodTransportadora.SetFocus;
        end
        else
        begin
          GProdutos.SetFocus;
          FundoNota.VertScrollBar.Position := 0;
        end;
  end;
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
    begin
      BAlterarNota.Visible := true;
      BFinanceiroOculto.visible := true;
      TelaModoConsulta(false);
    end;
  end;
end;

{*************** modifica os botoes conforme acao da nota fiscal ************* }
Procedure TFNovaNotaFiscalNota.EstadoBotoes(Estado : Boolean);
begin
   BObservacao.Enabled := Estado;
   BImprimir.Enabled := not(Estado) and not(VprDNota.IndNotaInutilizada);
   BEnviar.Enabled := not estado;
   BtbImprimeBoleto.Enabled := Not Estado;
   BotaoCancelar1.Enabled := Estado;
   BFechar.Enabled := not Estado;
   BotaoCadastrar1.Enabled := not estado;
   BtbImprimeBoleto.Enabled := not Estado;
   BNotaRemesa.Visible := VprOrcamento;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EtiquetaEndereo1Click(Sender: TObject);
var
  VpfFunArgox : TRBFuncoesArgox;
begin
  VpfFunArgox := TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica);
  VpfFunArgox.ImprimeEtiquetaEnderecoClienteNota(VprDNota,VprDCliente);
  VpfFunArgox.Free;
end;

{***************************Limpa o StringGrig*********************************}
procedure TFNovaNotaFiscalNota.LimpaStringGrid;
var
   x,y : Integer;
begin
// zera o stringGrid
  for y := 0 to 1 do
    for x := 0 to 5 do
       gradepar.Cells[x,y] := '';
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.MarcaCotacoesComoFaturadas(
  VpaLista: TList): String;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  result := '';
  for VpfLaco := 0 to VpaLista.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaLista.Items[VpfLaco]);
    VpfDCotacao.IndNotaGerada := true;
    VpfDCotacao.IndCancelado := False;
    VpfDCotacao.IndImpresso := true;
    result :=  FunCotacao.GravaDCotacao(VpfDCotacao,nil);
    if result = '' then
    begin
      case Varia.TipoEstagioCotacaoQuandoGeraNota of
        ecAlmoxarifado :
        begin
          if varia.EstagioOrdemProducaoAlmoxarifado <> 0 then
            result := FunCotacao.AlteraEstagioCotacao(VpfDCotacao.CodEmpFil,varia.codigousuario,VpfDCotacao.LanOrcamento,varia.EstagioOrdemProducaoAlmoxarifado,'');
        end;
        ecAguardandoEntrega :
        begin
          if varia.EstagioAguardandoEntrega <> 0 then
            result := FunCotacao.AlteraEstagioCotacao(VpfDCotacao.CodEmpFil,varia.codigousuario,VpfDCotacao.LanOrcamento,varia.EstagioAguardandoEntrega,'');
        end;
      end;
    end;
    if result <> '' then
      break;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.MontaObservacao;
begin
  MObservacoes.clear;

   // caso tenha reducao
//  if VprTextoReducao <> '' then
//    MObservacoes.Lines.add(VprTextoReducao);
  if VprTextoReducao <> '' then
    ETextoFiscal.text := VprTextoReducao;

  // texto fiscal conforme naturesas
//  MObservacoes.Lines.Add(VprDNota.DesTextoFiscal);
  if VprDNota.DesTextoFiscal <> '' then
    ETextoFiscal.Text := VprDNota.DesTextoFiscal;


  // observacao digitada pelo usuario
  if VprDNota.DesObservacao.Text <> '' then
    MObservacoes.Lines.add(VprDNota.DesObservacao.Text);

  if MObservacoes.Lines.Strings[MObservacoes.Lines.Count - 1] = '' then
    MObservacoes.Lines.Delete(MObservacoes.Lines.Count - 1);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          baixas da nota
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{********************Carrega o Titulos do grid de Parcelas*********************}
procedure TFNovaNotaFiscalNota.MontaPArcelasCR(VpaParcelaOculta : Boolean);
var
   laco,x,y : Integer;
begin
  LimpaStringGrid;

  x := 0;
  y := 0;

  aux.close;
  aux.sql.Clear;
  aux.sql.Add('select CR.I_LAN_REC, MCR.C_NRO_DUP, MCR.N_VLR_PAR, MCR.D_DAT_VEN ' +
              ' from CadContasAReceber CR, MovContasaReceber MCR ' +
              ' where  ' +
              ' CR.I_SEQ_NOT = ' + IntToStr(VprDNota.SeqNota) +
              ' and CR.I_EMP_FIL = ' + IntToStr(VprDNota.CodFilial) +
              ' and CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
              ' and CR.I_LAN_REC =  MCR.I_LAN_REC');
  if VpaParcelaOculta then
    aux.sql.Add(' and CR.C_IND_CAD = ''S''')
  else
    aux.sql.Add(' and CR.C_IND_CAD = ''N''');

  aux.sql.Add(' order by MCR.D_DAT_VEN' );
//  Aux.sql.saveToFile(RetornaDiretorioCorrente+'consulta.sql');
  aux.open;

  LancamentoReceber := aux.fieldByName('I_LAN_REC').AsInteger;

  aux.First;
  while not Aux.Eof do
  begin
     gradepar.Cells[x,y] := aux.fieldByName('C_NRO_DUP').AsString;
     gradepar.Cells[x+1,y] := aux.fieldByName('D_DAT_VEN').AsString;
     gradepar.Cells[x+2,y] := FormatFloat(Varia.MascaraMoeda, aux.fieldByName('N_VLR_PAR').AsFloat);
     inc(y);
     aux.Next;
     if y >= NroLinhaFatura  then
     begin
       y := 0;
       inc(x,3);
       if (x  + 1) > (NroConjuntoFatura * 3) then
        Break;
     end;
  end;
  aux.close;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ExcluiFinanceiroCotacao;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  for VpfLaco := 0 to VprCotacoes.Count - 1 do
  begin
    VpfDCotacao :=TRBDorcamento(VprCotacoes.Items[vpfLaco]);
    FunCotacao.ExcluiFinanceiroOrcamento(VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento,0);
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraFinanceiroNota : String;
var
  VpfOcultar : Boolean;
begin
  VpfOcultar := false;
  if VprCotacoes <> nil then
    if VprCotacoes.Count > 0 then
      VpfOcultar := trbdorcamento(VprCotacoes.Items[0]).IndProcessamentoFrio;
  VprDNota.IndGerouFinanceiroOculto := VpfOcultar;
  VprDContasaReceber.free;
  VprDContasaReceber := TRBDContasCR.cria;
  result := FunNotaFiscal.GeraFinanceiroNota(VprDNota,VprCotacoes,VprDCliente,VprDContasaReceber, vpfOcultar,false);
  if result = '' then
  begin
    if VprDContasaReceber.ValTotalAcrescimoFormaPagamento <> 0 then
    begin
      VprDNota.ValOutrasDepesesas := VprDNota.ValOutrasDepesesas + VprDContasaReceber.ValTotalAcrescimoFormaPagamento;
      EValOutrasDespesas.AValor := VprDNota.ValOutrasDepesesas;
      CalculaValorTotal;
    end;
    if VprDContasaReceber.ValUtilizadoCredito > 0 then
    begin
      VprDNota.DesObservacao.add('Abatido do Crédito "'+FormatFloat('R$ #,###,###,###,##0.00',VprDContasaReceber.ValUtilizadoCredito)+'". Saldo Crédito "'+FormatFloat('R$ #,###,###,###,##0.00',VprDContasaReceber.ValSaldoCreditoCliente)+'" - '+FormatDateTime('DD/MM/YYYY - HH:MM',now));
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraFinanceiroOculto : String;
begin
  VprDContasaReceber.free;
  VprDContasaReceber := TRBDContasCR.cria;
  result := FunNotaFiscal.GeraFinanceiroNota(VprDNota,VprCotacoes,VprDCliente,VprDContasaReceber, true,true);
  VprDNota.IndGerouFinanceiroOculto := true;
  if result = '' then
    MontaPArcelasCR(true);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.BaixaEstoqueNota : string;
begin
  Tempo.execute('Atualizando Estoque Produto...');
  AtualizaStatus('Atualizando Estoque Produtos');
  Result := FunNotaFiscal.BaixaEstoqueNota(VprDNota,VprDNatureza,FunProdutos);
  if result = '' then
    result := BaixaEstoqueFiscal;

  Tempo.fecha;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.BaixaEstoqueFiscal : String;
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
begin
  if config.EstoqueFiscal and (VprCotacoes.Count > 0) then
  begin
    if VprOrcamento then
      if TRBDOrcamento(VprCotacoes.Items[0]).NumCupomfiscal <> '' then //o estoque fiscal já foi baixado no ECF
        exit;

    Tempo.execute('Atualizando Estoque Fiscal...');
    AtualizaStatus('Atualizando Estoque Fiscal');
    for VpfLaco := 0 to VprDNota.Produtos.count - 1 do
    begin
      VpfDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpfLaco]);
      FunProdutos.BaixaEstoqueFiscal(VprDNota.CodFilial,
                                     VpfDProdutoNota.SeqProduto,
                                      VpfDProdutoNota.CodCor,
                                      0,
                                      VpfDProdutoNota.QtdProduto,
                                      VpfDProdutoNota.UM,
                                      VpfDProdutoNota.UMOriginal,
                                      VprDNota.DesTipoNota);
    end;
    Tempo.fecha;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.BaixaFinanceiro : string;
var
  VpfDOrcamento : TRBDOrcamento;
begin
  ArrumaDuplicatasFinanceiro;
  if VprCotacoes <> nil then
  begin
    VpfDOrcamento := TRBDOrcamento(VprCotacoes.Items[0]);
    if Config.ExcluirFinanceiroCotacaoQuandoGeraNota then
      FunCotacao.ExcluiFinanceiroCotacoes(VprCotacoes);
    if not(VprDNota.IndGeraFinanceiro) and (config.GerarFinanceiroCotacao) and not(Config.ExcluirFinanceiroCotacaoQuandoGeraNota)
       and(VprDNota.ValTotal = VpfDOrcamento.ValTotal) then
      FunContasAReceber.AssociaFinanceiroCotacaoNaNota(VprDNota,VpfDOrcamento);
  end;
  If VprDNota.IndGeraFinanceiro then
    result :=  FunContasAReceber.GravaContasaReceber(VprDContasaReceber);

  MontaPArcelasCR(VprDNota.IndGerouFinanceiroOculto);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.BaixaNota : String;
begin
  result := BaixaFinanceiro;
  if result = '' then
  begin
    MontaPArcelasCR(VprDNota.IndGerouFinanceiroOculto);
    result := BaixaEstoqueNota;
  end;

  if result = '' then
  begin
    // imprime a nota fiscal automaticamente
    if MovNatureza.FieldByName('C_IMP_AUT').AsString = 'S' then
       BImprimir.Click;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.BaixaProdutoCotacaoRomaneio : string;
Var
  VpfCotacoes : TList;
begin
  result := '';
  if not VprNotaRemessa then
  begin
    VpfCotacoes := TList.Create;
    FunCotacao.CarCotacoesParaBaixarRomaneio(VprDRomaneioOrcamento,VpfCotacoes);
    AssociaNotaCotacoes(VpfCotacoes);
    MarcaCotacoesComoFaturadas(VpfCotacoes);
    VpfCotacoes.Free;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ArrumaDuplicatasFinanceiro;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDMovContasCR;
begin
  VprDContasaReceber.SeqNota := VprDNota.SeqNota;
  VprDContasaReceber.NroNota := VprDNota.NumNota;
  for VpfLaco := 0 to VprDContasaReceber.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDMovContasCR(VprDContasaReceber.Parcelas.Items[VpfLaco]);
    if (VpfDParcela.NroDuplicata = '') then
    begin
      VpfDParcela.NroDuplicata := IntToStr(VprDNota.NumNota)+'/'+IntToStr(VpfLaco + 1);
      VpfDParcela.NroDocumento := VpfDParcela.NroDuplicata;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AssociaCSTItens;
var
  VpfDProdutoNota : TRBDNotaFiscalProduto;
  VpfLaco : Integer;
  VpfDProduto : TRBDProduto;
begin
  for VpfLaco := 0 to VprDNota.Produtos.Count - 1 do
  begin
    VpfDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[Vpflaco]);
    VpfDProduto := TRBDProduto.Cria;
    FunProdutos.CarDProduto(VpfDProduto,Varia.CodigoEmpresa,VprDNota.CodFilial,VpfDProdutoNota.SeqProduto);
    VpfDProdutoNota.CodCST :=  FunNotaFiscal.RCSTICMSProduto(VprDCliente,VpfDProduto,VprDNatureza);
  end;
  GProdutos.CarregaGrade;
  CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AssociaNaturezaItens;
var
  VpfLaco : Integer;
  VpfCFOPProduto : Integer;
  VpfDProNota : TRBDNotaFiscalProduto;
begin
  if VprDNota.CFOPProdutoIndustrializacao <> 0 then
    VpfCFOPProduto := VprDNota.CFOPProdutoIndustrializacao
  else
    if length(VprDNota.CodNatureza) = 4 then
      VpfCFOPProduto := StrToInt(VprDNota.CodNatureza);
  if VpfCFOPProduto <> 0 then
  begin
    for VpfLaco := 0 to VprDNota.Produtos.Count - 1 do
    begin
      VprDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpfLaco]);
      if VprDCliente.IndUFConvenioSubstituicaoTributaria and
         ((VprDProdutoNota.PerSubstituicaoTributaria > 0) or VprDProdutoNota.IndSubstituicaoTributaria) then
      begin
        if VprDProdutoNota.NumDestinoProduto = dpRevenda then
          VprDProdutoNota.CodCFOP := VprDNota.CFOPSubstituicaoTributariaRevenda
        else
          VprDProdutoNota.CodCFOP := VprDNota.CFOPSubstituicaoTributariaIndustrializacao;
      end
      else
      begin
        if VprDProdutoNota.NumDestinoProduto = dpRevenda then
          VprDProdutoNota.CodCFOP := VprDNota.CFOPProdutoRevenda
        else
          VprDProdutoNota.CodCFOP := VpfCFOPProduto;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AssociaNotaCotacoes(VpaCotacoes: TList);
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  //carrega o numero das notas fiscais nas cotacoes
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
    VpfDCotacao.IndProcessada := true;
    FunNotaFiscal.AssociaNotaOrcamento(VprDNota.CodFilial,VprDNota.SeqNota,VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento);
    if VpfDCotacao.NumNotas = '' then
      VpfDCotacao.NumNotas := IntToStr(VprDNota.NumNota)
    else
      VpfDCotacao.NumNotas := IntToStr(VprDNota.NumNota)+'/'+ VpfDCotacao.NumNotas;
    if VpfDCotacao.DatEntrega = 0 then
    begin
      VpfDCotacao.DatEntrega := date;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.RObservacaoCotacao(VpaNumCotacao,
  VpaCodFilial: Integer): String;
begin
  AdicionaSQLAbreTabela(Aux,'Select L_OBS_ORC from CADORCAMENTOS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = '+IntToStr(VpaNumCotacao));
  result := Aux.FieldByname('L_OBS_ORC').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ROrdensCompra : String;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfOrdensCompra : TStringList;
begin
  result := '';
  if VprCotacoes <> nil then
  begin
    VpfOrdensCompra := TStringList.create;
    For VpfLaco := 0 to VprCotacoes.Count - 1 do
    begin
      VpfDCotacao := TRBDOrcamento(VprCotacoes.Items[VpfLaco]);
      if VpfDCotacao.OrdemCompra <> '' then
      begin
        if VpfOrdensCompra.IndexOf(VpfDCotacao.OrdemCompra) < 0 then
        begin
          result := result +' '+ VpfDCotacao.OrdemCompra+';';
          VpfOrdensCompra.Add(VpfDCotacao.OrdemCompra);
        end;
      end;
    end;
    VpfOrdensCompra.free;
    if result <> '' then
      result := copy(result,1,length(result)-1);
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Eventos da consulta da nota fiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarProBaixadosOrcamento;
var
  VpfQtdProduto : Double;
  VpfLacoNota,VpfLaco, VpfLacoProdutos : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDProCotacao, VpfDUltimoProCotacao : TRBDOrcProduto;
  VpfUnidadeAtual : String;
begin
  if VprCotacoes = nil then
    exit;
  if config.BaixaQTDCotacaonaNota then
  begin
    if not VprNotaRemessa then //se for nota de remessa nao pode baixar na cotacao pois a nota que foi gerado o financeiro ja baixou.
    begin
      for VpfLacoNota := 0 to VprDNota.Produtos.Count - 1 do
      begin
        OrdenaCotacoesPorDataEntrega(VprCotacoes);
        VprDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpfLacoNota]);
        VpfQtdProduto := VprDProdutoNota.QtdProduto;
        VpfUnidadeAtual := VprDProdutoNota.UM;
        VpfDUltimoProCotacao := nil;
        for VpfLaco := 0 to VprCotacoes.Count - 1 do
        begin
          VpfDCotacao := TRBDOrcamento(VprCotacoes.Items[Vpflaco]);
          for VpfLacoProdutos := 0 to VpfDCotacao.Produtos.Count - 1 do
          begin
            VpfDProCotacao := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProdutos]);
            if (VpfDProCotacao.SeqProduto = VprDProdutoNota.SeqProduto) then
            begin
              if (config.EstoquePorCor) and (VpfDProCotacao.CodCor <> VprDProdutoNota.CodCor) then
                continue;
              VpfDUltimoProCotacao := VpfDProCotacao;
              if (VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixadoNota - VpfDProCotacao.QtdCancelado) > 0 then
              begin
                VpfQtdProduto := FunProdutos.CalculaQdadePadrao(VpfUnidadeAtual,VpfDProCotacao.UM,VpfQtdProduto,IntToStr(VprDProdutoNota.SeqProduto));
                VpfUnidadeAtual := VpfDProCotacao.UM;
                if (VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixadoNota - VpfDProCotacao.QtdCancelado) >= VpfQtdProduto then
                begin
                  VpfDProCotacao.QtdBaixadoNota := VpfDProCotacao.QtdBaixadoNota + VpfQtdProduto;
                  VpfQtdProduto := 0;
                end
                else
                begin
                  VpfQtdProduto := VpfQtdProduto - (VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixadoNota - VpfDProCotacao.QtdCancelado);
                  VpfDProCotacao.QtdBaixadoNota := VpfDProCotacao.QtdProduto;
                end;
              end;
            end;
            if VpfQtdProduto = 0 then
              break;
          end;
          if VpfQtdProduto = 0 then
            break;
        end;
        if VpfQtdProduto > 0  then
        begin
          if VpfDUltimoProCotacao <> nil then
          begin
            VpfDUltimoProCotacao.QtdBaixadoNota := VpfDUltimoProCotacao.QtdBaixadoNota + VpfQtdProduto;
            VpfQtdProduto := 0;
          end;
        end;
      end;
    end;
  end;
  AssociaNotaCotacoes(VprCotacoes);
  MarcaCotacoesComoFaturadas(VprCotacoes);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDOrcamentoNota(VpaDOrcamento : TRBDOrcamento;VpaDNota : TRBDNotaFiscal);
begin
  //informaçoes do cliente;

  VpaDNota.CodVendedor := VpaDOrcamento.CodVendedor;
  ECoDVendedor.Atualiza;

  CardClienteNovaNota(VpaDNota,VpaDOrcamento.CodCliente);
  VpaDNota.CodVendedor := VpaDOrcamento.CodVendedor;
  VpaDNota.PerComissao := VpaDOrcamento.PerComissao;
  VpaDNota.CodVendedorPreposto := VpaDOrcamento.CodPreposto;
  VpaDNota.PerComissaoPreposto := VpaDOrcamento.PerComissaoPreposto;
  VpaDNota.CodCondicaoPagamento := VpaDOrcamento.CodCondicaoPagamento;
  VpaDNota.CodFormaPagamento := VpaDOrcamento.CodFormaPaqamento;
  VpaDNota.NumContaCorrente := VpaDOrcamento.NumContaCorrente;
  if config.CopiarTransportadoraPedido then
    VpaDNota.CodTransportadora := VpaDOrcamento.CodTransportadora;
  VpaDNota.CodRedespacho := VpaDOrcamento.CodRedespacho;
  VpaDNota.DesMarcaEmbalagem := VpaDOrcamento.MarTransportadora;
  VpaDNota.DesEspecie := VpaDOrcamento.EspTransportadora;
  if VpaDOrcamento.TipFrete <> 0 then
    VpaDNota.CodTipoFrete := VpaDOrcamento.TipFrete;
  if VpaDOrcamento.NumTransportadora <> 0 then
  VpaDNota.NumEmbalagem := IntToStr(VpaDOrcamento.NumTransportadora);
  VpaDNota.DesUFPlacaVeiculo := VpaDOrcamento.UFVeiculo;
  VpaDNota.DesPlacaVeiculo := VpaDOrcamento.PlaVeiculo;
  if VpaDOrcamento.PesBruto <> 0 then
    VpaDNota.PesBruto := VpaDOrcamento.PesBruto;
  if VpaDOrcamento.PesLiquido <> 0 then
    VpaDNota.PesLiquido := VpaDOrcamento.PesLiquido;
  if VpaDOrcamento.QtdVolumesTransportadora <> 0 then
    VpaDNota.QtdEmbalagem := VpaDOrcamento.QtdVolumesTransportadora;
  if VpaDOrcamento.PerDesconto > 0  then
    VpaDNota.PerDesconto := VpaDOrcamento.PerDesconto;
  if VprDCliente.IndQuarto then
    VpaDNota.ValDesconto := VpaDOrcamento.ValDesconto / 4
  else
    if VprDCliente.IndDecimo then
      VpaDNota.ValDesconto := VpaDOrcamento.ValDesconto / 10
    else
      if VpaDOrcamento.ValDesconto > 0 then
        VpaDNota.ValDesconto := VpaDOrcamento.ValDesconto;
  if VpaDOrcamento.ValTroca > 0 then
    VpaDNota.ValDesconto := VpaDNota.ValDesconto+  VpaDOrcamento.ValTroca;

  if VpaDOrcamento.ValTaxaEntrega <> 0 then
    VpaDNota.ValFrete := VpaDOrcamento.ValTaxaEntrega;
  if not config.NaoCopiarObservacaoPedidoNotaFiscal then
  begin
    if config.ObservacaoFiscalNaCotacao then
      VpaDNota.DesObservacao.text := VpaDOrcamento.DesObservacaoFiscal
    else
      VpaDNota.DesObservacao.text := VpaDOrcamento.DesObservacao.Text;

    if Config.MostrarTelaObsCotacaoNaNotaFiscal then
    begin
      if VpaDOrcamento.DesObservacao.Text <> '' then
      begin
        FMostraObservacaoPedido := TFMostraObservacaoPedido.criarSDI(Application,'',FPrincipal.VerificaPermisao('FMostraObservacaoPedido'));
        FMostraObservacaoPedido.MostraObservacao(VpaDOrcamento.DesObservacao.Text);
        FMostraObservacaoPedido.free;
      end;
    end;
  end;
  VpaDNota.DesOrdemCompra := ROrdensCompra;
  if VpaDOrcamento.NumCupomfiscal <> '' then
  begin
    VpaDNota.DesDadosAdicinais.Add('Cupom : '+VpaDOrcamento.NumCupomfiscal);
  end;

  CarDTela;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDClienteNovaNota(VpaDNota : TRBDNotaFiscal;VpaCodCliente : Integer);
begin
  VpaDNota.CodCliente :=  VpaCodCliente;
  VprDCliente.CodCliente := 0;
end;
{******************************************************************************}
procedure TFNovaNotaFiscalNota.AdicionaAcrescimosDescontoCotacoesNota(VpaCotacoes : TList;VpaDNota : TRBDNotaFiscal);
var
  VpfDCotacao : TRBDOrcamento;
  VpfLaco : Integer;
begin
  VpaDNota.PerDesconto := 0;
  VpaDNota.ValFrete := 0;
  VpaDNota.ValDesconto := 0;
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
    if VprDCliente.IndQuarto then
      VpaDNota.ValDesconto :=  VpaDNota.ValDesconto + (VpfDCotacao.ValDesconto / 4)
    else
      if VprDCliente.IndDecimo then
        VpaDNota.ValDesconto :=  VpaDNota.ValDesconto + (VpfDCotacao.ValDesconto / 10)
      else
      begin
        if VpfDCotacao.ValDesconto < 0 then
          VpaDNota.ValOutrasDepesesas := VpaDNota.ValOutrasDepesesas + (VpfDCotacao.ValDesconto *-1)
        else
          VpaDNota.ValDesconto :=  VpaDNota.ValDesconto + VpfDCotacao.ValDesconto;
      end;
    if VpfDCotacao.ValTroca > 0  then
      VpaDNota.ValDesconto := VpaDNota.ValDesconto + VpfDCotacao.ValTroca;
    if config.ColocaroFreteemDespAcessoriasQuandoMesmaCidade and (VprDCliente.DesCidade = varia.CidadeFilial) then
      VpaDNota.ValOutrasDepesesas := VpaDNota.ValOutrasDepesesas + VpfDCotacao.ValTaxaEntrega
    else
      VpaDNota.ValFrete := VpaDNota.ValFrete + VpfDCotacao.ValTaxaEntrega;
    if VpfDCotacao.PerDesconto > 0 then
      VpaDNota.PerDesconto := VpfDCotacao.PerDesconto
    else
      VpaDNota.ValOutrasDepesesas := VpaDNota.ValOutrasDepesesas + (((VpfDCotacao.PerDesconto *-1)* VpfDCotacao.ValTotalProdutos)/100);

  end;
  CarDValorTotalTela;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarNaturezaOperacaoNota;
begin
  if VprDNota.Produtos.Count = 0 then
  begin
    if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
      VprDNota.CodNatureza := Varia.NaturezaServico
    else
      VprDNota.CodNatureza := Varia.NaturezaServicoForaEstado;
  end
  else
  begin
    if (FunNotaFiscal.PossuiProdutosIndustrializadosTributacaoICMSNormal(VprDCliente,VprDNota) )  and
       (VprDNota.TipNota = tnDevolucao) then
    begin
      if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
        VprDNota.CodNatureza := Varia.NaturezaDevolucaoIndustrializado
      else
        VprDNota.CodNatureza := Varia.NaturezaDevolucaoIndustrializadoFora;
    end
    else
    if (FunNotaFiscal.PossuiProdutosIndustrializadosTributacaoICMSNormal(VprDCliente,VprDNota) ) and
        FunNotaFiscal.PossuiProdutosIndustrializadoTributacaoICMSSubstituto(VprDCliente,VprDNota) and
       (VprDNota.Servicos.Count > 0) then
    begin
      if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
        VprDNota.CodNatureza := Varia.NaturezaProdutoIndustrializadoeSTIndustrializadoeServico
      else
        VprDNota.CodNatureza := Varia.NaturezaProdutoIndustrializadoeSTIndustrializadoeServicoForaEstado;
    end
    else
      if (FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSNormal(VprDCliente,VprDNota) ) and
         (FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSSubstituto(VprDCliente,VprDNota) ) and
         (VprDNota.Servicos.Count > 0) then
      begin
        if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
          VprDNota.CodNatureza := Varia.NaturezaServicoeRevendaeRevendaST
        else
          VprDNota.CodNatureza := varia.NaturezaServicoeRevendaeRevendaSTFora;
      end
    else
      if (FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSNormal(VprDCliente,VprDNota) ) and
         (FunNotaFiscal.PossuiProdutosIndustrializadosTributacaoICMSNormal(VprDCliente,VprDNota) ) and
         (VprDNota.Servicos.Count > 0) then
      begin
        if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
          VprDNota.CodNatureza := Varia.NaturezaServicoERevendaeIndustrializacao
        else
          VprDNota.CodNatureza := Varia.NaturezaServicoERevendaeIndustrializacaoForaEstado;
      end
      else
      if (FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSNormal(VprDCliente,VprDNota) ) and
         (VprDNota.Servicos.Count > 0) then
      begin
        if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
          VprDNota.CodNatureza := Varia.NaturezaServicoERevenda
        else
          VprDNota.CodNatureza := Varia.NaturezaServicoERevendaForaEstado;
      end
      else
        if (FunNotaFiscal.PossuiProdutosIndustrializadoTributacaoICMSSubstituto(VprDCliente,VprDNota) ) and
           (VprDNota.Servicos.Count > 0) then
        begin
          if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
            VprDNota.CodNatureza := Varia.NaturezaServicoeST
          else
            VprDNota.CodNatureza := Varia.NaturezaServicoeSTForaEstado;
        end
      else
        if (FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSSubstituto(VprDCliente,VprDNota) ) and
           (VprDNota.Servicos.Count > 0) then
        begin
          if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
            VprDNota.CodNatureza := Varia.NaturezaSTRevendaeServico
          else
            VprDNota.CodNatureza := Varia.NaturezaSTRevendaeServicoFora;
        end
        else
          if VprNotaRemessa and  //natureza 6924
             FunNotaFiscal.PossuiProdutosIndustrializadosTributacaoICMSNormal(VprDCliente,VprDNota) and
             (VprDNota.Servicos.Count = 0) then
          begin
            if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
              VprDNota.CodNatureza := Varia.NaturezaProdutoIndustrializadoRemessaPorContaseOrdem
            else
              VprDNota.CodNatureza := Varia.NaturezaProdutoIndustrializadoRemessaPorContaseOrdemFora;
          end
        else
          if (VprDNota.TipNota = tnVendaPorContaeOrdem) and  //natureza 6122
             FunNotaFiscal.PossuiProdutosIndustrializadosTributacaoICMSNormal(VprDCliente,VprDNota) and
             (VprDNota.Servicos.Count = 0) then
          begin
            if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
              VprDNota.CodNatureza := Varia.NaturezaProdutoIndustrializadoVendaPorContaseOrdem
            else
              VprDNota.CodNatureza := Varia.NaturezaProdutoIndustrializadoVendaPorContaseOrdemFora;
          end
        else
          if (FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSNormal(VprDCliente,VprDNota)) and
             FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSSubstituto(VprDCliente,VprDNota) and
             FunNotaFiscal.PossuiProdutosIndustrializadoTributacaoICMSSubstituto(VprDCliente,VprDNota) and
             (VprDNota.Servicos.Count = 0) then
          begin
            if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
              VprDNota.CodNatureza := Varia.NaturezaRevendaSTIndustrializadoSTRevenda
            else
              VprDNota.CodNatureza := Varia.NaturezaRevendaSTIndustrializadoSTRevendaFora;
          end
        else
          if (FunNotaFiscal.PossuiProdutosIndustrializadosTributacaoICMSNormal(VprDCliente,VprDNota)) and
             FunNotaFiscal.PossuiProdutosIndustrializadoTributacaoICMSSubstituto(VprDCliente,VprDNota) and
             (VprDNota.Servicos.Count = 0) then
          begin
            if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
              VprDNota.CodNatureza := Varia.NaturezaProdutoeST
            else
              VprDNota.CodNatureza := Varia.NaturezaProdutoeSTForaEstado;
          end
          else
            if (FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSSubstituto(VprDCliente,VprDNota)) and
                FunNotaFiscal.PossuiProdutosIndustrializadoTributacaoICMSSubstituto(VprDCliente,VprDNota) and
               (VprDNota.Servicos.Count = 0) then
            begin
              if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
                VprDNota.CodNatureza := Varia.NaturezaSTRevendaeSTIndustrializacao
              else
                VprDNota.CodNatureza := Varia.NaturezaSTRevendaeSTIndustrilizacaoFora;
            end
          else
            if (FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSNormal(VprDCliente,VprDNota)) and
                FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSSubstituto(VprDCliente,VprDNota) and
               (VprDNota.Servicos.Count = 0) then
            begin
              if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
                VprDNota.CodNatureza := Varia.NaturezaSTRevendaeRevenda
              else
                VprDNota.CodNatureza := Varia.NaturezaSTRevendaeRevendaFora;
            end
            else
              if (FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSNormal(VprDCliente,VprDNota)) and
                 (FunNotaFiscal.PossuiProdutosIndustrializadosTributacaoICMSNormal(VprDCliente,VprDNota)) and
                 (VprDNota.Servicos.Count = 0) then
              begin
                if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
                  VprDNota.CodNatureza := Varia.NaturezaRevendaeIndustrializacao
                else
                  VprDNota.CodNatureza := Varia.NaturezaRevendaeIndustrializacaoFora;
              end
              else
                if (FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSNormal(VprDCliente,VprDNota)) and
                   (VprDNota.Servicos.Count = 0) then
                begin
                  if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
                    VprDNota.CodNatureza := Varia.NaturezaRevenda
                  else
                    VprDNota.CodNatureza := Varia.NaturezaRevendaForaEstado;
                end
                else
                  if (FunNotaFiscal.PossuiProdutosIndustrializadosTributacaoICMSNormal(VprDCliente,VprDNota)) and
                     (VprDNota.Servicos.Count = 0) then
                  begin
                    if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
                      VprDNota.CodNatureza := Varia.NaturezaNota
                    else
                      VprDNota.CodNatureza := Varia.NaturezaForaEstado
                  end
                  else
                    if FunNotaFiscal.PossuiProdutosIndustrializadoTributacaoICMSSubstituto(VprDCliente,VprDNota) and
                       (VprDNota.Servicos.Count = 0) then
                    begin
                      if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
                        VprDNota.CodNatureza := Varia.NaturezaSTIndustrializacao
                      else
                        VprDNota.CodNatureza := Varia.NaturezaSTIndustrializacaoForaEstado;
                    end
                    else
                      if FunNotaFiscal.PossuiProdutosRevendaTributacaoICMSSubstituto(VprDCliente,VprDNota) and
                         (VprDNota.Servicos.Count = 0) then
                      begin
                        if UpperCase(VprDCliente.DesUF) = UpperCase(varia.UFFilial) then
                          VprDNota.CodNatureza := Varia.NaturezaSTRevenda
                        else
                          VprDNota.CodNatureza := Varia.NaturezaSTRevendaForaEstado;
                      end;
  end;
  if VprOrcamento then
  begin
    if VprCotacoes <> nil then
    begin
      if TRBDOrcamento(VprCotacoes.Items[0]).NumCupomfiscal <> '' then
        VprDNota.CodNatureza := Varia.NaturezaNotaFiscalCupom;
    end;
  end;

  ECodNatureza.Clear;
  VprCodNaturezaAtual := '';
  ECodNatureza.Text := VprDNota.CodNatureza;
  ECodNatureza.Atualiza;
  if not VprDNota.IndCalculaISS then
  begin
    EPerISSQN.Avalor := 0;
    EValIss.AValor := 0;
    VprDNota.PerIssqn := 0;
    VprDNota.ValIssqn :=0;
  end;
  //atualiza o cliente pois agora possui o codigo da natureza correta;
  VprDCliente.CodCliente := 0;
  ECodCliente.Atualiza;
  //atualiza a natureza de operacao para carregar o icms dos itens da nota pois foram carregados sem a Natureza de operacao correto;
  VprCodNaturezaAtual := '';
  ECodNatureza.Atualiza;
  AssociaCSTItens;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarObservacaoCotacao(VpaDNota: TRBDNotaFiscal);
var
  VpfObservacaoCotacao: String;
  VpfNumPedido: Integer;
begin

    AdicionaSQLAbreTabela(ObservacaoCotacao,'SELECT I_LAN_ORC FROM MOVNOTAORCAMENTO ' +
                              ' WHERE I_SEQ_NOT = '+ InttoStr(VpaDNota.SeqNota));
    while not ObservacaoCotacao.Eof do
    begin
      VpfNumPedido:= ObservacaoCotacao.FieldByName('I_LAN_ORC').AsInteger;
      VpfObservacaoCotacao:= RObservacaoCotacao(VpfNumPedido, VpaDNota.CodFilial);
      if VpfObservacaoCotacao <> '' then
      begin
        FMostraObservacaoPedido := TFMostraObservacaoPedido.criarSDI(Application,'',FPrincipal.VerificaPermisao('FMostraObservacaoPedido'));
        FMostraObservacaoPedido.MostraObservacao(VpfObservacaoCotacao);
        FMostraObservacaoPedido.free;
      end;
      ObservacaoCotacao.Next;
    end;
    ObservacaoCotacao.Close;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarObservacoesRomaneio(VpaDRomaneio: TRBDRomaneioOrcamento; VpaDNota : TRBDNotaFiscal);
var
  VpfObservacoesPedido : string;
begin
  VpfObservacoesPedido := '';
  if not config.NaoCopiarObservacaoPedidoNotaFiscal then
  begin
    AdicionaSQLAbreTabela(Aux,'select ORC.I_EMP_FIL, ORC.I_LAN_ORC, ORC.L_OBS_ORC, ORC.C_OBS_FIS '+
                              ' from ROMANEIOORCAMENTOITEM ROI, CADORCAMENTOS ORC '+
                              ' WHERE ROI.CODFILIAL = '+ IntToStr(VpaDRomaneio.CodFilial)+
                              ' AND ROI.SEQROMANEIO = ' +IntToStr(VpaDRomaneio.SeqRomaneio)+
                              ' AND ROI.CODFILIALORCAMENTO = ORC.I_EMP_FIL '+
                              ' AND ROI.LANORCAMENTO = ORC.I_LAN_ORC '+
                              ' GROUP BY ORC.I_EMP_FIL, ORC.I_LAN_ORC, ORC.L_OBS_ORC, ORC.C_OBS_FIS');
    while not Aux.Eof do
    begin
      if Config.ObservacaoFiscalNaCotacao then
      begin
        VpaDNota.DesObservacao.text := VpaDNota.DesObservacao.text + aux.FieldByName('C_OBS_FIS').AsString+#13;
        if aux.FieldByName('L_OBS_ORC').AsString <> '' then
        begin
          if VpfObservacoesPedido <> '' then
            VpfObservacoesPedido := VpfObservacoesPedido + #13#13;
        VpfObservacoesPedido := VpfObservacoesPedido+'Cotacao ' +Aux.FieldByName('I_LAN_ORC').AsString+#13+aux.FieldByName('L_OBS_ORC').AsString;
        end;
      end
      else
        VpaDNota.DesObservacao.text := VpaDNota.DesObservacao.text + aux.FieldByName('L_OBS_ORC').AsString+#13;
      Aux.Next;
    end;
    Aux.Close;
  end;
  if VpfObservacoesPedido <> '' then
  begin
    FMostraObservacaoPedido := TFMostraObservacaoPedido.criarSDI(Application,'',FPrincipal.VerificaPermisao('FMostraObservacaoPedido'));
    FMostraObservacaoPedido.MostraObservacao(VpfObservacoesPedido);
    FMostraObservacaoPedido.free;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.FinalizaNotaAutomatico : String;
begin
  result := '';
  AtualizaStatus('Carregando os dados para a classe.');
  Result := CarDClasse;
  VprDNota.IndMostrarParcelas := false;
  if Result = '' then
  begin
    AtualizaStatus('Validando os dados da nota');
    Result := DadosNotaValidos;
    if Result = '' then
    begin
      VprTransacao.IsolationLevel := xilREADCOMMITTED;
      FPrincipal.BaseDados.StartTransaction(VprTransacao);
      AtualizaStatus('Gravando os dados da nota fiscal');
      Result := FunNotaFiscal.GravaDNotaFiscal(VprDNota);
      if Result = '' then
      begin
        EstadoBotoes(false);
        BotaoGravar1.Enabled := false;
        GeraFinanceiroNota;
        BaixaNota;

        if VprOrcamento Then
          CarProBaixadosOrcamento;
      end;
    end;
  end;

  if Result = '' then
  begin
    FPrincipal.BaseDados.Commit(VprTransacao);
    VprAcao := true;
    ENumNota.AsInteger := VprDNota.NumNota;
    EClaFiscal.Text := VprDNota.DesClassificacaoFiscal;
    AtualizaStatus('Nota fiscal gravada com sucesso.');
    TelaModoConsulta(true);
  end
  else
  begin
    if FPrincipal.BaseDados.InTransaction then
      FPrincipal.BaseDados.Rollback(VprTransacao);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GeraNotaFiscalFriaContrato;
begin
  FreeTObjectsList(VprDNota.Servicos);
  VprDNota.CodNatureza := Varia.NaturezaNota;
  VprDNota.PerDesconto := 0;
  VprDNota.ValDesconto := 0;
  VprDProdutoNota := VprDNota.AddProduto;
  VprDProdutoNota.SeqProduto := Varia.SeqProdutoContrato;
  FunNotaFiscal.ExisteProduto(Varia.CodProdutoContrato,VprDNota,VprDProdutoNota);
  VprDProdutoNota.ValUnitario := VprDNota.ValTotal * 0.3;
  IF VprDProdutoNota.ValUnitario > 60 then
    VprDProdutoNota.ValUnitario := 50 + random(10);
  VprDProdutoNota.ValTotal := VprDProdutoNota.ValUnitario;
  CalculaValorTotalProduto;
  CalculaValorTotal;
  TRBDOrcamento(VprCotacoes.Items[0]).IndProcessamentoFrio := false;
  VprDNota.CodFormaPagamento := varia.FormaPagamentoContrato;
  VprDNota.CodCondicaoPagamento := varia.CondicaoPagamentoContrato;
  VprDNota.DesObservacao.clear;
  ECodNatureza.Text := Varia.NaturezaNota;
  ECodNatureza.Atualiza;

  GeraFinanceiroNota;
  BaixaFinanceiro;
  aviso('POSICIONE A NOTA!!!'#13'Posicione a nota fiscal para a impressão.');
  BImprimir.Click;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraNotaNotaEntrada(VpaDNotaFiscalEntrada: TRBDNotaFiscalFor): boolean;
var
  VpfResultado : String;
begin
  result := false;

  VprDNota := TRBDNotaFiscal.cria;
  VprOperacao := ocInsercao;
  VpfResultado :=  VerificaVariaveis;
  if VpfResultado = '' then
  begin
    VprDNota := TRBDNotaFiscal.cria;
    VprOperacao := ocInsercao;
    ConfiguraItemNota(Varia.NotaFiscalPadrao);
    InicializaNota;
    AlteraLocalizasOrcamento;
    CarDNotaEntradaNotaSaida(VpaDNotaFiscalEntrada,VprDNota);
    AdicionaServicosNotaEntrada(VpaDNotaFiscalEntrada);
    CarNaturezaOperacaoNota;
    AdicionaProdutosNotaEntrada(VpaDNotaFiscalEntrada);
    GProdutos.CarregaGrade;
    GServicos.CarregaGrade;
    ShowModal;
    result := VprAcao;
  end
  else
    aviso(VpfResultado);
end;

{******************* imprime boletos bancarios **************************** }
procedure TFNovaNotaFiscalNota.BtbImprimeBoletoClick(Sender: TObject);
var
  VpfDBoleto : TDadosBoleto;
begin
  begin
    VprBoletoImpresso := true;
    FunNotaFiscal.LocalizaParcelasBoleto(Aux,VprDNota.CodFilial, VprDNota.SeqNota);
    if not config.ImprimirBoletoFolhaBranco then
      UnIMP.InicializaImpressao(varia.BoletoPadraoNota,  UnIMP.RetornaImpressoraPadrao(Varia.BoletoPadraoNota));

    while not aux.Eof do
    begin
      if config.ImprimirBoletoFolhaBranco then
        FunImprimeBoleto.ImprimeBoleto(Aux.FieldByName('I_EMP_FIL').AsInteger,Aux.FieldByName('I_LAN_REC').AsInteger,
                                       Aux.FieldByName('I_NRO_PAR').AsInteger,VprDCliente,false,'',false)
      else
      begin
        VpfDBoleto := TDadosBoleto.Create;

        with VpfDBoleto do
        begin
          Valor := aux.fieldByName('n_vlr_par').AsCurrency;
          Desconto := 0;
          Acrescimos := 0;
          Vencimento := aux.fieldByName('d_dat_ven').AsDateTime;


          UnImp.LocalizaTipoBoleto(CadBoleto, varia.DadoBoletoPadraoNota);

          Instrucoes := TStringList.create;
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN1').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN2').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN3').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN4').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN5').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN6').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN7').AsString);

          sacado := TStringList. create;
          Sacado.Add(Aux.fieldByName('C_NOM_CLI').AsString);
          if (Aux.fieldByName('C_BAI_CLI').AsString = '') then
             Sacado.Add(Aux.fieldByName('C_END_CLI').AsString + '' +
             Aux.fieldByName('I_NUM_END').AsString)
          else
            Sacado.Add(Aux.fieldByName('C_END_CLI').AsString  + '' +
            Aux.fieldByName('I_NUM_END').AsString + ',  ' +
            Aux.fieldByName('C_BAI_CLI').AsString);

          if (Aux.fieldByName('C_CEP_CLI').AsString = '') then
            Sacado.Add(AdicionaBrancoD(Aux.fieldByName('C_CID_CLI').AsString, 40) +
            Aux.fieldByName('C_EST_CLI').AsString)
          else
            Sacado.Add(AdicionaBrancoD(Aux.fieldByName('C_CID_CLI').AsString, 40) +
            Aux.fieldByName('C_EST_CLI').AsString + '   CEP: ' +
            Aux.fieldByName('C_CEP_CLI').AsString);

          NumeroDocumento := Aux.fieldByName('I_NRO_NOT').AsString;
          LanReceber := Aux.fieldByName('I_LAN_REC').AsInteger;
          NumParcela := Aux.fieldByName('I_NRO_PAR').AsInteger;
          Carteira := Aux.FieldByName('I_NUM_CAR').AsString;


          DataDocumento := Date;
          DataProcessamento := Date;
          Desconto := 0;
          Acrescimos := 0;
          ValorDocumento := Aux.fieldByName('N_VLR_PAR').AsFloat;
          LocalPagamento := CADBOLETO.FieldByName('C_DES_LOC').AsString;
          Cedente := CADBOLETO.FieldByName('C_DES_CED').AsString;
          EspecieDocumento := CADBOLETO.FieldByName('C_DES_ESP').AsString;
          Aceite := CADBOLETO.FieldByName('C_DES_ACE').AsString;
          Especie := CADBOLETO.FieldByName('C_ESP_MOE').AsString;
          Quantidade := '';
          Agencia := '';
          NossoNumero := '';
          Outras := 0;
          MoraMulta := 0;
          ValoCobrado := Aux.fieldByName('N_VLR_PAR').AsFloat;
          UnIMP.ImprimeBoleto(VpfDBoleto); // Imprime 1 documento.
         end;
        end;
       aux.Next;
    end;
    if not config.ImprimirBoletoFolhaBranco then
      UnIMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       eventos do orcamento na nota fiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************** altera os localizas para o orcamento ******************}
procedure TFNovaNotaFiscalNota.AlteraLocalizasOrcamento;
begin
  ECodNatureza.ASelectLocaliza.Text := 'Select * from CadNatureza '+
                                      ' where c_nom_nat like ''@%''' +
                                      ' and C_TIP_EMI = ''P''';
  ECodNatureza.ASelectValida.Text := 'Select * from CadNatureza '+
                                      ' where c_cod_nat = ''@'' ' +
                                      ' and C_TIP_EMI = ''P''';
  ECodNatureza.Atualiza;
  ECodCliente.Atualiza;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GeraMovNotasFiscaisOrcamentos(VpaCotacoes : TList;VpaSomenteServico : Boolean=false);
var
  VpfLaco, VpfLacoProdutos,VpfLacoServicos : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDProCotacao : TRBDOrcProduto;
  VpfDServicoCotacao : TRBDOrcServico;
  VpfFaturarTodos : Boolean;
begin
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[Vpflaco]);
    VpfFaturarTodos := FunCotacao.FaturarTodosProdutos(VpfDCotacao);
    VprDNota.DesOrdemCompra := VprDNota.DesOrdemCompra + VpfDCotacao.OrdemCompra +' ';
    if not VpaSomenteServico then
    begin
      for VpfLacoProdutos := 0 to VpfDCotacao.Produtos.Count - 1 do
      begin
        VpfDProCotacao := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpflacoProdutos]);
        if not VpfDProCotacao.IndBrinde then
        begin
          if VpfFaturarTodos or VpfDProCotacao.IndFaturar or not(config.EstoqueFiscal) then
          begin
            if ((VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixadoNota) > 0 ) or
                config.GerarFinanceiroCotacao or config.GerarNotaPelaQuantidadeProdutos then
            begin
              VprDProdutoNota := VprDNota.AddProduto;
              VprDProdutoNota.CodCST :=  '000';
              VprDProdutoNota.SeqProduto := VpfDProCotacao.SeqProduto;
              AdicionaItemProduto(VprDProdutoNota);
              if VprDProdutoNota.IndReducaoICMS then
                VprDProdutoNota.PerICMS :=  (VprDNota.ValICMSPadrao * VprDProdutoNota.PerReducaoICMSProduto)/100
              else
                VprDProdutoNota.PerICMS :=  VprDNota.ValICMSPadrao;
              if VpfDProCotacao.CodCor <> 0 then
                VprDProdutoNota.CodCor := VpfDProCotacao.CodCor;
              if config.PermiteAlteraNomeProdutonaCotacao then
                VprDProdutoNota.NomProduto := VpfDProCotacao.NomProduto;
              VprDProdutoNota.CodProduto := VpfDProCotacao.CodProduto;
              VprDProdutoNota.DesCor := VpfDProCotacao.DesCor;
              if config.GerarFinanceiroCotacao or config.GerarNotaPelaQuantidadeProdutos then
                VprDProdutoNota.QtdProduto := VpfDProCotacao.QtdProduto
              else
                VprDProdutoNota.QtdProduto := (VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixadoNota - VpfDProCotacao.QtdCancelado);
              if VprDCliente.IndQuarto then
                VprDProdutoNota.ValUnitario := VpfDProCotacao.ValUnitario / 4
              else
                if VprDCliente.IndMeia then
                  VprDProdutoNota.ValUnitario := VpfDProCotacao.ValUnitario / 2
                else
                  if VprDCliente.IndVintePorcento then
                     VprDProdutoNota.ValUnitario := VpfDProCotacao.ValUnitario / 5
                   else
                    if VprDCliente.IndDecimo then
                       VprDProdutoNota.ValUnitario := VpfDProCotacao.ValUnitario / 10
                     else
                       VprDProdutoNota.ValUnitario := VpfDProCotacao.ValUnitario;
              VprDProdutoNota.AltProdutonaGrade := VpfDProCotacao.AltProdutonaGrade;
              VprDProdutoNota.UM := VpfDProCotacao.UM;
              VprDProdutoNota.DesRefCliente := VpfDProCotacao.DesRefCliente;
              VprDProdutoNota.DesOrdemCompra := VpfDProCotacao.DesOrdemCompra;
              VprDProdutoNota.ValTotal := VprDProdutoNota.ValUnitario * VprDProdutoNota.QtdProduto;
              VprDProdutoNota.ValIPI := ArredondaDecimais((VprDProdutoNota.ValTotal * VprDProdutoNota.PerIPI)/100,2);
              FunNotaFiscal.VerificaItemNotaDuplicado(VprDNota);
            end;
          end;
        end;
      end;
    end;

    for VpfLacoServicos := 0 to VpfDCotacao.Servicos.Count - 1 do
    begin
      VpfDServicoCotacao := TRBDOrcServico(VpfDCotacao.Servicos.Items[VpflacoServicos]);
      VprDServicoNota := VprDNota.AddServico;
      VprDServicoNota.CodServico := VpfDServicoCotacao.CodServico;
      FunNotaFiscal.ExisteServico(IntToStr(VprDServicoNota.CodServico),VprDNota,VprDServicoNota);
      VprDServicoNota.NomServico := VpfDServicoCotacao.NomServico;
      VprDServicoNota.DesAdicional := VpfDServicoCotacao.DesAdicional;
      VprDServicoNota.QtdServico := VpfDServicoCotacao.QtdServico;
      VprDServicoNota.PerComissaoClassificacao := VpfDServicoCotacao.PerComissaoClassificacao;
      VprDServicoNota.CodClassificacao := VpfDServicoCotacao.CodClassificacao;
      VprDServicoNota.CodFiscal := VpfDServicoCotacao.CodFiscal;

      if VprDCliente.IndQuarto then
      begin
        VprDServicoNota.ValUnitario := VpfDServicoCotacao.ValUnitario / 4;
        VprDServicoNota.ValTotal := VpfDServicoCotacao.ValTotal / 4;
      end
      else
        if VprDCliente.IndMeia then
        begin
          VprDServicoNota.ValUnitario := VpfDServicoCotacao.ValUnitario / 2;
          VprDServicoNota.ValTotal := VpfDServicoCotacao.ValTotal / 2;
        end
        else
        if VprDCliente.IndVintePorcento then
          begin
            VprDServicoNota.ValUnitario := VpfDServicoCotacao.ValUnitario / 5;
            VprDServicoNota.ValTotal := VpfDServicoCotacao.ValTotal / 5;
          end
          else
          if VprDCliente.IndDecimo then
            begin
              VprDServicoNota.ValUnitario := VpfDServicoCotacao.ValUnitario / 10;
              VprDServicoNota.ValTotal := VpfDServicoCotacao.ValTotal / 10;
            end
            else
            begin
              VprDServicoNota.ValUnitario := VpfDServicoCotacao.ValUnitario;
              VprDServicoNota.ValTotal := VpfDServicoCotacao.ValTotal;
            end;
      if VprDServicoNota.PerISSQN <> 0 then
        EPerISSQN.AValor := VprDServicoNota.PerISSQN;

      if VpaCotacoes.Count > 1 then
        FunNotaFiscal.VerificaServicoNotaDuplicado(VprDNota);
    end;
  end;
  CalculaValorTotal;
  GServicos.CarregaGrade;
  GProdutos.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GeraMovNotasFiscaisRomaneio(VpaEmpFil,VpaNumRomaneio :String);
Var
  VpfPedidoAnterior : Integer;
  VpfTotalKM : Double;
begin
  AdicionaSQLAbreTabela(RomaneioItem,'select PRO.C_NOM_PRO, ' +
                                       ' OP.NUMPED, OP.CODPRO, OP.VALUNI, OP.SEQPRO, '+
                                       ' OPI.CODCOM, OPI.CODMAN, OPI.NROFIT, OPI.METCOL, (OPI.METCOL * OPI.NROFIT) / 1000 TOTALKM '+
                                       ' from ORDEMPRODUCAOCORPO OP, COLETAOPITEM opi, CADPRODUTOS PRO, ROMANEIOITEM RIT '+
                                       ' WHERE OPI.EMPFIL = OP.EMPFIL '+
                                       ' AND OPI.SEQORD = OP.SEQORD '+
                                       ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
                                       ' AND RIT.EMPFIL = OPI.EMPFIL '+
                                       ' AND RIT.SEQORD = OPI.SEQORD '+
                                       ' AND RIT.SEQCOL = OPI.SEQCOL '+
                                       ' AND RIT.EMPFIL = ' +VpaEmpFil +
                                       ' and rit.SEQROM = '+VpaNumRomaneio+
                                       ' order by OP.NUMPED' );
  VpfPedidoAnterior := -90838443;
  While not RomaneioItem.Eof do
  begin
    if VpfPedidoAnterior <> RomaneioItem.FieldByName('NUMPED').AsInteger then
    begin
      VprDProdutoNota := VprDNota.AddProduto;
      VprDProdutoNota.SeqProduto := RomaneioItem.FieldByName('SEQPRO').AsInteger;
      VprDProdutoNota.CodProduto := RomaneioItem.FieldByName('CODPRO').AsString;
      AdicionaItemProduto(VprDProdutoNota);
      VprDProdutoNota.PerICMS := VprDNota.ValICMSPadrao;
      VpfTotalKM := RomaneioItem.FieldByName('TOTALKM').AsFloat;
      VprDProdutoNota.QtdProduto := RomaneioItem.FieldByName('TOTALKM').AsFloat;
      VprDProdutoNota.ValUnitario := RomaneioItem.FieldByName('VALUNI').AsFloat;
      VprDProdutoNota.UM := 'KM';
      VpfPedidoAnterior := RomaneioItem.FieldByName('NUMPED').AsInteger;
    end
    else
    begin
      VpfTotalKM := VpfTotalKM + RomaneioItem.FieldByName('TOTALKM').AsFloat;
      VprDProdutoNota.QtdProduto :=VpfTotalKM ;
    end;
    RomaneioItem.next;
  end;

  GProdutos.CarregaGrade;
  CalculaValorTotal;
  ActiveControl := ECodNatureza;
  RomaneioItem.close;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GeraMovNotasFiscaisRomaneioGenerico(VpaCodFilial,VpaSeqRomaneio : Integer);
var
  VpfCotacoes, VpfOrdensCompra : TStringList;
begin
  VpfCotacoes := TStringList.Create;
  VpfOrdensCompra := TStringList.Create;
  AdicionaSQLAbreTabela(RomaneioItem,'select  CRO.QTDCOLETADO, CRO.DESUM, '+
                                     ' OP.CODPRO, OP.SEQPRO, OP.CODCOM, OP.NUMPED,OP.VALUNI, OP.ORDCLI, '+
                                     ' OP.PROREF, OP.UNMPED '+
                                     ' from  ROMANEIOPRODUTOITEM ROI, COLETAROMANEIOOP CRO, ORDEMPRODUCAOCORPO OP '+
                                     ' Where ROI.CODFILIAL = CRO.CODFILIAL '+
                                     ' AND ROI.SEQORDEM = CRO.SEQORDEM '+
                                     ' AND ROI.SEQFRACAO = CRO.SEQFRACAO '+
                                     ' AND ROI.SEQCOLETA = CRO.SEQCOLETA '+
                                     ' AND ROI.CODFILIAL = OP.EMPFIL '+
                                     ' AND ROI.SEQORDEM = OP.SEQORD '+
                                     ' AND ROI.CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                     ' AND ROI.SEQROMANEIO = '+IntToStr(VpaSeqRomaneio));
  while not RomaneioItem.eof do
  begin
    VprDProdutoNota := VprDNota.AddProduto;
    VprDProdutoNota.CodCST :=  '000';
    VprDProdutoNota.SeqProduto := RomaneioItem.FieldByName('SEQPRO').AsInteger;
    AdicionaItemProduto(VprDProdutoNota);
    if VprDProdutoNota.IndReducaoICMS then
      VprDProdutoNota.PerICMS :=  (VprDNota.ValICMSPadrao * VprDProdutoNota.PerReducaoICMSProduto)/100
    else
      VprDProdutoNota.PerICMS :=  VprDNota.ValICMSPadrao;

    if RomaneioItem.FieldByName('CODCOM').AsInteger <> 0 then
    begin
      VprDProdutoNota.CodCor := RomaneioItem.FieldByName('CODCOM').AsInteger;
      VprDProdutoNota.DesCor := FunProdutos.RNomeCor(inttoStr(VprDProdutoNota.CodCor));
    end;
    VprDProdutoNota.CodProduto := RomaneioItem.FieldByName('CODPRO').AsString;
    VprDProdutoNota.QtdProduto := FunProdutos.CalculaQdadePadrao(RomaneioItem.FieldByName('DESUM').AsString,RomaneioItem.FieldByName('UNMPED').AsString,
                                    RomaneioItem.FieldByName('QTDCOLETADO').AsFloat,IntToStr(VprDProdutoNota.SeqProduto));
    VprDProdutoNota.ValUnitario := RomaneioItem.FieldByName('VALUNI').AsFloat;
    VprDProdutoNota.UM := RomaneioItem.FieldByName('UNMPED').AsString;
    VprDProdutoNota.DesRefCliente := RomaneioItem.FieldByName('PROREF').AsString;
    VprDProdutoNota.ValTotal := VprDProdutoNota.ValUnitario * VprDProdutoNota.QtdProduto;
    VprDProdutoNota.ValIPI := ArredondaDecimais((VprDProdutoNota.ValTotal * VprDProdutoNota.PerIPI)/100,2);
    FunNotaFiscal.VerificaItemNotaDuplicado(VprDNota);
    if (VpfCotacoes.IndexOf(RomaneioItem.FieldByName('NUMPED').AsString)  < 0) Then
    begin
      VpfCotacoes.add(RomaneioItem.FieldByName('NUMPED').AsString);
      VprDNota.NumPedidos := VprDNota.NumPedidos+ RomaneioItem.FieldByName('NUMPED').AsString +',';
    end;
    if (VpfOrdensCompra.IndexOf(RomaneioItem.FieldByName('ORDCLI').AsString)  < 0) Then
    begin
      VpfOrdensCompra.add(RomaneioItem.FieldByName('ORDCLI').AsString);
      VprDNota.DesOrdemCompra := VprDNota.DesOrdemCompra + RomaneioItem.FieldByName('ORDCLI').AsString +',';
    end;

    RomaneioItem.next;
  end;
  RomaneioItem.close;
  if VprDNota.NumPedidos <> '' then
    VprDNota.NumPedidos := copy(VprDNota.NumPedidos,1,length(VprDNota.NumPedidos)-1);
  if VprDNota.DesOrdemCompra <> '' then
  begin
    VprDNota.DesOrdemCompra := copy(VprDNota.DesOrdemCompra,1,length(VprDNota.DesOrdemCompra)-1);
    EOrdemCompra.Text := VprDNota.DesOrdemCompra;
  end;
  GProdutos.CarregaGrade;
  CalculaValorTotal;
  ActiveControl := ECodNatureza;
  VpfCotacoes.free;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GeraMovNotasFiscaisRomaneioOrcamento(VpaDRomaneio: TRBDRomaneioOrcamento);
var
  VpfDItemRomaneio : TRBDRomaneioOrcamentoItem;
  VpfLaco :Integer;
  VpfOrdensCompra : TStringList;
begin
  VpfOrdensCompra := TStringList.Create;
  for VpfLaco := 0 to VpaDRomaneio.Produtos.Count - 1 do
  begin
    VpfDItemRomaneio := TRBDRomaneioOrcamentoItem(VpaDRomaneio.Produtos.Items[VpfLaco]);
    VprDProdutoNota := VprDNota.AddProduto;
    VprDProdutoNota.CodCST :=  '000';
    VprDProdutoNota.SeqProduto := VpfDItemRomaneio.SeqProduto;
    AdicionaItemProduto(VprDProdutoNota);
    VprDProdutoNota.CodCor := VpfDItemRomaneio.CodCor;
    VprDProdutoNota.CodProduto := VpfDItemRomaneio.CodProduto;
    VprDProdutoNota.DesCor := VpfDItemRomaneio.NomCor;
    VprDProdutoNota.QtdProduto := VpfDItemRomaneio.QtdProduto;
    //CARREGA AS ORDENS DE COMPRA DA NOTA FISCAL;
    ValidaDadosRomaneioComOrcamento(VpfDItemRomaneio);
    if (VpfDItemRomaneio.DesOrdemCompra <> '') AND
       (VpfOrdensCompra.IndexOf(VpfDItemRomaneio.DesOrdemCompra) = -1)  then
       VpfOrdensCompra.Add(VpfDItemRomaneio.DesOrdemCompra);

    if VprDCliente.IndQuarto then
      VprDProdutoNota.ValUnitario := VpfDItemRomaneio.ValUnitario / 4
    else
      if VprDCliente.IndMeia then
        VprDProdutoNota.ValUnitario := VpfDItemRomaneio.ValUnitario / 2
      else
        if VprDCliente.IndVintePorcento then
           VprDProdutoNota.ValUnitario := VpfDItemRomaneio.ValUnitario / 5
         else
          if VprDCliente.IndDecimo then
             VprDProdutoNota.ValUnitario := VpfDItemRomaneio.ValUnitario / 10
           else
             VprDProdutoNota.ValUnitario := VpfDItemRomaneio.ValUnitario;
//    VprDProdutoNota.AltProdutonaGrade := Aux.FieldByName('N_ALT_PRO').AsFloat;
    VprDProdutoNota.UM := VpfDItemRomaneio.DesUM;
    VprDProdutoNota.DesRefCliente := VpfDItemRomaneio.DesReferenciaCliente;
    VprDProdutoNota.DesOrdemCompra := VpfDItemRomaneio.DesOrdemCompra;
    VprDProdutoNota.ValTotal := VprDProdutoNota.ValUnitario * VprDProdutoNota.QtdProduto;
    VprDProdutoNota.ValIPI := ArredondaDecimais((VprDProdutoNota.ValTotal * VprDProdutoNota.PerIPI)/100,2);
    FunNotaFiscal.VerificaItemNotaDuplicado(VprDNota);
  end;
  EOrdemCompra.Text := SubstituiStr(VpfOrdensCompra.Text,#13,';');
  VpfOrdensCompra.Free;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.OrdenaCotacoesPorDataEntrega(VpaCotacoes : TList);
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfUltimaCotacao : TRBDOrcamento;
begin
  for VpflacoExterno := VpaCotacoes.Count - 1 downto 0 do
  begin
    VpfUltimaCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno - 1 downto 0 do
    begin
      if VpfUltimaCotacao.DatPrevista < TRBDOrcamento(VpaCotacoes.Items[VpfLacoInterno]).DatPrevista then
      begin
        VpaCotacoes.Items[VpfLacoExterno] := VpaCotacoes.Items[VpfLacoInterno];
        VpaCotacoes.Items[VpfLacoInterno] := VpfUltimaCotacao;
        VpfUltimaCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLacoExterno]);
      end;
    end;
  end;

end;

procedure TFNovaNotaFiscalNota.Panel1Click(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.PeasMquinas1Click(Sender: TObject);
var
  VpfRSeProdutoEDoCliente: Boolean;
  VpfResultado : String;
begin
   VpfResultado:= '';
   if GProdutos.Cells[12,GProdutos.ALinha] = ''  then
     VpfResultado:= 'PECAS DO PRODUTO INVALIDAS!!!' + #13 + 'Para digitar as peças é necessário preencher o número de série do produto. ';
   if VpfResultado = '' then
   begin
     FProdutosClientePeca := TFProdutosClientePeca.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCelulaTrabalho'));
     FProdutosClientePeca.AtualizaConsultaNota(VprDProdutoNota.ProdutoPeca);
     FProdutosClientePeca.Showmodal;
     FProdutosClientePeca.free;
   end;
   if VpfResultado <> '' then
     aviso(VpfResultado);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraNotaContratoDireto(VpaDContrato: TRBDContratoCorpo): boolean;
var
  VpfResultado : String;
begin
  result := false;

  VprDNota := TRBDNotaFiscal.cria;
  VprOperacao := ocInsercao;
  VpfResultado :=  VerificaVariaveis;
  if VpfResultado = '' then
  begin
    ConfiguraItemNota(Varia.NotaFiscalPadrao);
    InicializaNota;
    AlteraLocalizasOrcamento;
    ECodCliente.AInteiro := VpaDContrato.CodCliente;
    ECondicoes.AInteiro := VpaDContrato.CodCondicaoPagamento;
    ExisteCondicaoPagamento;
    VprDNota.CodFormaPagamento := VpaDContrato.CodFormaPagamento;

    AdicionaServicoContrato(VpaDContrato);
    CarNaturezaOperacaoNota;
    AdicionaProdutosContratoDadosAdicionais(VpaDContrato);
    ShowModal;
    result := VprAcao;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraNotaCotacoes(VpaCotacoes : TList;VpaSomenteServico : Boolean = false): Boolean;
var
  VpfDCotacao : TRBDOrcamento;
  VpfResultado : String;
begin
  result := false;
  if VpaCotacoes.Count > 0 then
  begin
    VprDNota := TRBDNotaFiscal.cria;
    VprOperacao := ocInsercao;
    VprCotacoes := VpaCotacoes;
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[0]);
    VprOrcamento := true;
    VpfResultado :=  VerificaVariaveis;
    if VpfResultado = '' then
    begin
      ConfiguraItemNota(Varia.NotaFiscalPadrao);
      InicializaNota;
      AlteraLocalizasOrcamento;

      CarDOrcamentoNota(VpfDCotacao,VprDNota);
      AdicionaAcrescimosDescontoCotacoesNota(VpaCotacoes,VprDNota);
      GeraMovNotasFiscaisOrcamentos(VpaCotacoes,VpaSomenteServico);
      VprCodClienteFaccionista := RCodClienteFaccionista;
      if VprCodClienteFaccionista <> 0 then
      begin
        VprDNota.TipNota := tnVendaPorContaeOrdem;
        MAdicional.Lines.Add(FunNotaFiscal.RTextoNotaContaeOrdem(VprCodClienteFaccionista,VARIA.SerieNota,Date));
      end;
      CarNaturezaOperacaoNota;
      ShowModal;
      result := VprAcao;
    end
    else
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraNotaCotacoesAutomatico(VpaCotacoes : TList;VpaDCliente : TRBDCliente; VpaBarraStatus : TStatusBar):string;
var
  VpfDCotacao : TRBDOrcamento;
begin
  result := '';
//09/08/2009 - foi colocado em comentario para ver se para de dar o acces violation no faturamento diario;
//  VpaBarraStatus := StatusBar1;
  VprNotaAutomatica := true;
  if VpaCotacoes.Count > 0 then
  begin
    VprDNota := TRBDNotaFiscal.cria;
    VprOperacao := ocInsercao;
    VprCotacoes := VpaCotacoes;
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[0]);

    VprOrcamento := true;
    Result :=  VerificaVariaveis;
    if Result = '' then
    begin
      ConfiguraItemNota(Varia.NotaFiscalPadrao);
      InicializaNota;
      AlteraLocalizasOrcamento;
      CarDOrcamentoNota(VpfDCotacao,VprDNota);
      AdicionaAcrescimosDescontoCotacoesNota(VpaCotacoes,VprDNota);
      GeraMovNotasFiscaisOrcamentos(VpaCotacoes);
      CarNaturezaOperacaoNota;
      result := FinalizaNotaAutomatico;
      if config.ExibirMensagemAntesdeImprimirNotanoFaturamentoMensal then
        aviso('NOTA FISCAL PRONTA PARA IMPRESSÃO!!!'#13'A nota fiscal está pronta para ser impressa, pressione o botão OK para continuar.');
      if VpfDCotacao.IndProcessamentoFrio then
        aviso('Posicione a nota fiscal.');
      if result = '' then
      begin
        BImprimir.Click;
        if (config.EmiteNFe) then
        begin
          if ( Config.NotaFiscalConjugada and
            (VprDNota.Servicos.Count > 0)) or
             (VprDNota.Servicos.Count = 0)  then
            EnviaEmailNfe;
        end;
      end;
      if VpfDCotacao.IndProcessamentoFrio then
        GeraNotaFiscalFriaContrato;
    end
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraNotaRomaneio(VpaEmpfil,VpaNumRomaneio : String) : boolean;
var
  VpfResultado : String;
begin
  result := false;
  VprDNota := TRBDNotaFiscal.cria;
  VprOperacao := ocInsercao;
  VprOrcamento := true;
  VpfResultado :=  VerificaVariaveis;
  if VpfResultado = '' then
  begin
    ConfiguraItemNota(Varia.NotaFiscalPadrao);
    InicializaNota;
    AlteraLocalizasOrcamento;
    VprDNota.CodCliente := 11024;
    VprDNota.CodNatureza := Varia.NaturezaNota;
    CarDTela;
    GeraMovNotasFiscaisRomaneio(VpaEmpFil,VpaNumRomaneio);
    CarNaturezaOperacaoNota;
    ShowModal;
    result := VprAcao;
    if result then
      VpfResultado:= FunOrdemProducao.BaixaRomaneioComoFaturado(StrToInt(VpaEmpfil),StrToInt(VpaNumRomaneio),VprDNota.SeqNota,VprDNota.CodFilial);
  end;
  if Vpfresultado <> '' then
    aviso(vpfResultado);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraNotaRomaneioGenerico(VpaCodFilial, VpaSeqRomaneio,VpaCodCliente : Integer):Boolean;
var
  VpfResultado : String;
begin
  result := false;
  VprDNota := TRBDNotaFiscal.cria;
  VprOperacao := ocInsercao;
  VprOrcamento := true;
  VpfResultado :=  VerificaVariaveis;
  if VpfResultado = '' then
  begin
    ConfiguraItemNota(Varia.NotaFiscalPadrao);
    InicializaNota;
    AlteraLocalizasOrcamento;
    CarDClienteNovaNota(VprDNota,VpaCodCliente);
    CarDTela;
    GeraMovNotasFiscaisRomaneioGenerico(VpaCodFilial,VpaSeqRomaneio);
    CarNaturezaOperacaoNota;
    ShowModal;
    result := VprAcao;
    if result then
      VpfResultado:= FunOrdemProducao.BaixaRomaneioGenerico(VpaCodFilial,VpaSeqRomaneio,VprDNota.SeqNota,IntToStr(VprDNota.NumNota));
  end;
  if Vpfresultado <> '' then
    aviso(vpfResultado);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraRonameioOrcamento(VpaCodFilial, VpaSeqRomaneio: Integer): boolean;
var
  VpfResultado : String;
  VpfDRomaneioProduto : TRBDRomaneioOrcamentoItem;
  VpfDCotacao : TRBDOrcamento;
  VpfSeqRomaneioCancelado : Integer;
begin
  result := false;
  VprDRomaneioOrcamento := TRBDRomaneioOrcamento.cria;
  FunCotacao.CarDRomaneioOrcamento(VprDRomaneioOrcamento,VpaCodFilial,VpaSeqRomaneio);

  VpfSeqRomaneioCancelado := FunCotacao.RSeqRomaneioBloqueado(VpaCodFilial,VprDRomaneioOrcamento.CodCliente);
  if VpfSeqRomaneioCancelado <> 0 then
    aviso('EXISTE ROMANEIO BLOQUEADO!!!'#13'Existe um romaneio "'+IntToStr(VpfSeqRomaneioCancelado)+'" bloqueado para esse cliente.');

  VprDNota := TRBDNotaFiscal.cria;
  VprOperacao := ocInsercao;
  VprOrcamento := true;
  VprRomaneioOrcamento := true;
  VpfResultado :=  VerificaVariaveis;
  if VpfResultado = '' then
  begin
    ConfiguraItemNota(Varia.NotaFiscalPadrao);
    InicializaNota;
    AlteraLocalizasOrcamento;

    if VprDRomaneioOrcamento.Produtos.Count > 0 then
    begin
      VpfDRomaneioProduto := TRBDRomaneioOrcamentoItem(VprDRomaneioOrcamento.Produtos.Items[0]);
      VpfDCotacao := TRBDOrcamento.cria;
      FunCotacao.CarDOrcamento(VpfDCotacao,VpfDRomaneioProduto.CodFilialOrcamento,VpfDRomaneioProduto.LanOrcamento);
      CarDOrcamentoNota(VpfDCotacao,VprDNota);
      EQtd.AsInteger := VprDRomaneioOrcamento.QtdVolume;
      EPesoBruto.AValor := VprDRomaneioOrcamento.PesBruto;
      EPesoLiquido.AValor := VprDRomaneioOrcamento.PesBruto;

      GeraMovNotasFiscaisRomaneioOrcamento(VprDRomaneioOrcamento);
      CarObservacoesRomaneio(VprDRomaneioOrcamento,VprDNota);
      VprCodClienteFaccionista := VpfDCotacao.CodClienteFaccionista;
      if VprCodClienteFaccionista <> 0 then
      begin
        VprDNota.TipNota := tnVendaPorContaeOrdem;
        MAdicional.Lines.Add(FunNotaFiscal.RTextoNotaContaeOrdem(VpfDCotacao.CodClienteFaccionista,VARIA.SerieNota,Date));
      end;
      CarNaturezaOperacaoNota;
      ShowModal;
      result := VprAcao;
    end
    else
      aviso(VpfResultado);
  end;
end;


{******************************************************************************}
procedure TFNovaNotaFiscalNota.ConsultaNota(VpaDNota : TRBDNotaFiscal);
var
  VpfResultado : String;
begin
  VprOperacao := ocConsulta;

   VpfResultado :=  VerificaVariaveis;
   if VpfResultado = '' then
   begin
     ConfiguraItemNota(Varia.NotaFiscalPadrao);
     InicializaNota;
     VprDNota.free;
     VprDNota := VpaDNota;
     GProdutos.ADados := VpaDNota.Produtos;
     GProdutos.CarregaGrade;
     GServicos.ADados := VpaDNota.Servicos;
     GServicos.CarregaGrade;
     VprDCliente.CodCliente := VpaDNota.CodCliente;
     FunClientes.CarDCliente(VprDCliente);
     CarDTela;
     CardClienteNota(VprDCliente);
     if Config.MostrarTelaObsCotacaoNaNotaFiscal then
       CarObservacaoCotacao(VprDNota);
     FunNotaFiscal.CarValICMSPadrao(VprDNota.ValICMSPadrao,VprDNota.ValICMSAliquotaInternaUFDestino,VprDNota.PerReducaoUFICMS, VprDCliente.DesUF,VprDCliente.InscricaoEstadual,VprDCliente.TipoPessoa[1] = 'J',false,VprDCliente.IndUFConvenioSubstituicaoTributaria);
     MontaPArcelasCR(false);
     EstadoBotoes(false);
     BotaoGravar1.Enabled := false;
     TelaModoConsulta(true);
     if VpaDNota.IndNotaCancelada then
     begin
       if VpaDNota.IndECF then
         LNomFilial.Caption := 'CUPOM CANCELADO'
       else
         LNomFilial.Caption := 'NOTA CANCELADA';
       LNomFilial.Font.Color := clred;
     end
     else
       if VpaDNota.IndECF then
       begin
         LNomFilial.Caption := 'CUPOM FISCAL';
         LNomFilial.Font.Color := clgreen;
       end
       else
         if VpaDNota.CodFilial <> varia.CodigoEmpFil then
         begin
           LNomFilial.Caption :=Sistema.RNomFilial(VpaDNota.CodFilial);
         end;
     ShowModal;
   end
   else
     aviso(VpfResultado);
end;

procedure TFNovaNotaFiscalNota.ControleDespacho1Click(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimeControleDespachoNota(VprDNota,VprDCliente,VprDTransportadora);
  dtRave.free;
end;

{********************* Atlera o numero da nota ********************************}
procedure TFNovaNotaFiscalNota.BAlterarNumeroClick(Sender: TObject);
var
  VpfNovoNumero : String;
begin
  if EntradaNumero('Novo Número','Digite o Novo numero da Nota : ',VpfNovoNumero,False,EDatEmissao.color,color,false) then
  begin
    ExecutaComandoSql(Aux,'Update CadNotaFiscais ' +
                          'Set I_Nro_not = ' + VpfNovoNumero +
                          ' Where I_Emp_Fil = '+ IntToStr(VprDNota.CodFilial) +
                          ' and I_Seq_Not = ' + IntToStr(VprDNota.SeqNota));
    VprDNota.NumNota := StrToInt(VpfNovoNumero);
    ENumNota.AsInteger := VprDNota.NumNota;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.FormShow(Sender: TObject);
begin
  if PNaturezaOperacao.Visible then
    ECodNatureza.SetFocus;
end;

procedure TFNovaNotaFiscalNota.FPrincipalExportaExecute(Sender: TObject);
begin

end;

{********************* valida a gravacao do botao *****************************}
procedure TFNovaNotaFiscalNota.ECondicoesChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    ValidaGravacao1.execute;
end;

{********************* cadastra a transportadora ******************************}
procedure TFNovaNotaFiscalNota.ECodTransportadoraCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.CadClientesC_IND_TRA.AsString := 'S';
  FNovoCliente.CadClientesC_IND_CLI.AsString := 'N';
  FNovoCliente.showmodal;
  FNovoCliente.free;
end;

procedure TFNovaNotaFiscalNota.ECodTransportadoraRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if ECodTransportadora.Text <> '' then
  begin
    VprDTransportadora.CodCliente := ECodTransportadora.AInteiro;
    FunClientes.CarDCliente(VprDTransportadora);
    CarDTransportadoraTela;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECoDVendedorCadastrar(Sender: TObject);
begin
  FNovoVendedor := TFNovoVendedor.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoVendedor'));
  FNovoVendedor.CadVendedores.Insert;
  FNovoVendedor.showmodal;
  FNovoVendedor.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application, '', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.showmodal;
  FCores.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECorRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GProdutos.Cells[3,GProdutos.ALinha] := ECor.Text;
    GProdutos.Cells[4,GProdutos.ALinha] := Retorno1;
    ReferenciaProduto;
    GProdutos.AEstadoGrade := egEdicao;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  if ((VpaLinha-1) < VprDNota.Produtos.Count) then
  begin
    VprDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpaLinha-1]);
    GProdutos.Cells[1,VpaLinha] := VprDProdutoNota.CodProduto;
    GProdutos.Cells[2,VpaLinha] := VprDProdutoNota.NomProduto;
    if VprDProdutoNota.CodCor <> 0 then
      GProdutos.Cells[3,VpaLinha] := IntToStr(VprDProdutoNota.CodCor)
    else
      GProdutos.Cells[3,VpaLinha] := '';
    GProdutos.Cells[4,VpaLinha] := VprDProdutoNota.DesCor;
    if VprDProdutoNota.AltProdutonaGrade <> 0 then
      GProdutos.Cells[5,VpaLinha] := FormatFloat('#,##0.00',VprDProdutoNota.AltProdutonaGrade)
    else
      GProdutos.Cells[5,VpaLinha] := '';
    GProdutos.Cells[6,VpaLinha] := VprDProdutoNota.CodClassificacaoFiscal;
    GProdutos.Cells[7,VpaLinha] := VprDProdutoNota.CodCST;
    GProdutos.Cells[8,VpaLinha] := VprDProdutoNota.UM;
    GProdutos.Cells[12,VpaLinha] := VprDProdutoNota.DesRefCliente;
    GProdutos.Cells[13,VpaLinha] := VprDProdutoNota.DesOrdemCompra;
    if VprDProdutoNota.PerICMS <> 0 then
      GProdutos.Cells[14,VpaLinha] := FormatFloat('0.00%',VprDProdutoNota.PerICMS)
    else
      GProdutos.Cells[14,VpaLinha] := '';
    if VprDProdutoNota.PerIPI <> 0 then
      GProdutos.Cells[15,VpaLinha] := FormatFloat('0.00%',VprDProdutoNota.PerIPI)
    else
      GProdutos.Cells[15,VpaLinha] := '';
    if VprDProdutoNota.ValIPI <> 0 then
      GProdutos.Cells[16,VpaLinha] := FormatFloat('0.00',VprDProdutoNota.ValIPI)
    else
      GProdutos.Cells[16,VpaLinha] := '';
    GProdutos.Cells[17,VpaLinha] := IntToSTr(VprDProdutoNota.CodCFOP);


    CalculaValorTotalProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
Var
  VpfResultado : string;
begin
  VpaValidos := true;
  if GProdutos.Cells[1,GProdutos.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GProdutos.col := 1;
    end
    else
      if (GProdutos.Cells[3,GProdutos.ALinha] <> '') then
      begin
        if not Existecor then
        begin
          VpaValidos := false;
          Aviso(CT_CORINEXISTENTE);
          GProdutos.Col := 3;
        end;
      end
      else
        if (GProdutos.Cells[8,GProdutos.Alinha] <> VprDProdutoNota.UMAnterior) and (VprDProdutoNota.UnidadeParentes.IndexOf(GProdutos.Cells[8,GProdutos.Alinha]) < 0) then
        begin
          VpaValidos := false;
          aviso(CT_UNIDADEVAZIA);
          GProdutos.col := 8;
        end
        else
          if (GProdutos.Cells[9,GProdutos.ALinha] = '') then
          begin
            VpaValidos := false;
            aviso(CT_QTDPRODUTOINVALIDO);
            GProdutos.Col := 9;
          end
          else
            if (GProdutos.Cells[10,GProdutos.ALinha] = '') then
            begin
              VpaValidos := false;
              aviso(CT_VALORUNITARIOINVALIDO);
              GProdutos.Col := 10;
            end;

  if VpaValidos then
  begin
    CarDProdutoNota;
    CalculaValorTotal;
    if VprDProdutoNota.QtdProduto = 0 then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      GProdutos.col := 9;
    end
    else
      if VprDProdutoNota.ValUnitario = 0 then
      begin
        VpaValidos := false;
        aviso(CT_VALORUNITARIOINVALIDO);
        GProdutos.Col := 10;
      end
      else
        if not FunProdutos.VerificaEstoque( VprDProdutoNota.UM,VprDProdutoNota.UMOriginal,VprDProdutoNota.QtdProduto,VprDProdutoNota.SeqProduto,VprDProdutoNota.CodCor,0) then
          VpaValidos := false;
      ValidaValorUnitarioProduto;
  end;
  if VpaValidos then
  begin
    if (VprDProdutoNota.CodCFOP = 0)   then
    begin
      VpaValidos := false;
      aviso('CFOP DO PRODUTO NÃO PREENCHIDO!!!'#13'É necesário preencher o codigo CFOP do produto.');
      GProdutos.col := 17;
    end;

    if FunNotaFiscal.VerificaItemNotaDuplicado(VprDNota) then
    begin
      CalculaValorTotalProduto;
      GProdutos.CarregaGrade;
    end;
    if VpaValidos then
    begin
      VpfResultado := FunNotaFiscal.DadosCTSItemNotaValido(VprDProdutoNota);
      if VpfResultado <> '' then
      begin
        aviso(VpfResultado);
        VpaValidos := false;
      end
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosDepoisExclusao(Sender: TObject);
begin
  if GProdutos.ALinha > 1 then
    calculavalortotal
  else
  begin
    CarDValorTotalTela;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosEnter(Sender: TObject);
var
  VpfResultado : String;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    vpfResultado :=   CarDClasse;
    if vpfResultado <> '' then
    begin
      aviso(vpfResultado);
      ActiveControl := ECodNatureza;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3 :  Value := '00000;0; ';
    17 :  Value := '0000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GProdutos.Col of
        1 :  LocalizaProduto;
        3 :  ECor.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECorEnter(Sender: TObject);
begin
  ECor.clear;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  IF (GProdutos.Col = 12) and not(config.NumeroSerieProduto) then  //referencia do cliente
    key := #0;

  if (key = '.') and (GProdutos.col <> 1) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDNota.Produtos.Count >0 then
  begin
    VprDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDProdutoNota.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosNovaLinha(Sender: TObject);
begin
  VprDProdutoNota := VprDNota.AddProduto;
  VprDProdutoNota.PerICMS :=  VprDNota.ValICMSPadrao;
  VprDProdutoNota.CodCST :=  '000';
  VprProdutoAnterior := '-10';
  VprDProdutoNota.CodCFOP := VprDNota.CFOPProdutoIndustrializacao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProdutos.AColuna <> ACol then
    begin
      case GProdutos.AColuna of
        1 :if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               GProdutos.Cells[1,GProdutos.ALinha] := '';
               GProdutos.Col := 1;
             end;
           end;
        3 : if GProdutos.Cells[3,GProdutos.Alinha] <> '' then
            begin
              if not Existecor then
              begin
                Aviso(CT_CORINEXISTENTE);
                GProdutos.Col := 3;
                abort;
              end;
            end
            else
              ReferenciaProduto;
        5 : CalculaValorUnitarioPeloAlturaProduto;

        8 : if not ExisteUM then
            begin
              aviso(CT_UNIDADEVAZIA);
              GProdutos.col := 8;
              abort;
            end;
        9 :
             begin
               if GProdutos.Cells[9,GProdutos.ALinha] <> '' then
                 VprDProdutoNota.QtdProduto := StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.'))
               else
                 VprDProdutoNota.QtdProduto := 0;
               CalculaValorTotalProduto;
             end;
        10: begin
              VprDProdutoNota.ValTotal := 0;
              ValidaValorUnitarioProduto;
            end;
        11:  begin
               VprDProdutoNota.ValTotal := StrToFloat(DeletaChars(DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[11,GProdutos.ALinha],'.'),'R'),'$'),' '));
               CalculaValorTotalProduto;
             end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EValDescontoAcrescimoExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,OcEdicao] then
  begin
    CarDValorTotal;
    CalculaValorTotal;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    MontaObservacao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EDatEmissaoExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    try
      StrToDate(EDatEmissao.text);
      VprDNota.DatEmissao :=StrToDate(EDatEmissao.text);
      if VprDNota.DatEmissao <= Varia.DataUltimoFechamento then
      begin
        aviso(CT_DATAMENORULTIMOFECHAMENTO);
        EDatEmissao.SetFocus;
      end;

    except
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EDatSaidaExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    try
      StrToDate(EDatSaida.text);
      VprDNota.DatSaida := StrToDate(EDatSaida.text);
      if VprDNota.DatSaida < Varia.DataUltimoFechamento then
      begin
        aviso(CT_DATAMENORULTIMOFECHAMENTO);
        EDatSaida.SetFocus;
      end;
    except
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EmiteNotaFiscalVendaConsumidor;
var
  VpfResultado : String;
begin
  VprNotaFiscalConsumidor := true;
  VprDNota := TRBDNotaFiscal.cria;
  VprOperacao := ocInsercao;

   VpfResultado :=  VerificaVariaveis;
   if VpfResultado = '' then
   begin
     ConfiguraItemNota(Varia.NotaFiscalPadrao);
     InicializaNota;
     AlterarVisibleDet([RTipoNota,PNaturezaOperacao,BImprimir,BtbImprimeBoleto,BEnviar],false);
     ESerieNota.ReadOnly := False;
     ESerieNota.TabStop := true;
     ESerieNota.Color := clSilver;
     ESerieNota.BorderStyle := bsSingle;
     ENumNota.ReadOnly := false;
     ESubSerie.Visible := true;
     LSubSerie.Visible := true;

     ShowModal;
   end
   else
     aviso(VpfResultado);

end;

{******************************************************************************}
function TFNovaNotaFiscalNota.EnviaEmailNfe: string;
var
  VpfFunNFE : TRBFuncoesNFe;
begin
  result := '';
  VpfFunNFE := TRBFuncoesNFe.cria(FPrincipal.BaseDados);
  result := VpfFunNFE.EnviaEmailDanfe(VprDNota,VprDCliente);
  VpfFunNFE.free;
  if result = '' then
    StatusBar1.Panels[0].Text := 'E-mail enviado com sucesso...';
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EnviarXMLNfepeloOutlook1Click(Sender: TObject);
var
  VpfFunNFE : TRBFuncoesNFe;
begin
  VpfFunNFE := TRBFuncoesNFe.cria(FPrincipal.BaseDados);
  VpfFunNFE.EnviaemailDanfePeloOutlook(VprDNota,VprDCliente);
 // VpfFunNFE.Free;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EPlanoExit(Sender: TObject);
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VprDNota.CodPlanoContas :=  EPlano.text;
  if not FPlanoConta.verificaCodigo( VprDNota.CodPlanoContas, 'C', LTextoPlanoContas, false,(Sender is TSpeedButton) ) then
    EPlano.SetFocus;
  EPlano.text := VprDNota.CodPlanoContas;

end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EPlanoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    EPlanoExit(BPlanoContas);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.BAlterarNotaClick(Sender: TObject);
begin
  BAlterarNota.Visible := false;
  TelaModoConsulta(true);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.FormDestroy(Sender: TObject);
begin
  UnImp.Free;
  VprDCliente.free;
  VprDTransportadora.free;
  VprDNota.free;
  FunOrdemProducao.free;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDServicoNota := TRBDNotaFiscalServico(VprDNota.Servicos.Items[VpaLinha-1]);
  if VprDServicoNota.CodServico <> 0 then
    GServicos.Cells[1,VpaLinha] := IntToStr(VprDServicoNota.CodServico)
  else
    GServicos.Cells[1,VpaLinha] := '';
  GServicos.Cells[2,VpaLinha] := VprDServicoNota.NomServico;
  GServicos.Cells[3,VpaLinha] := VprDServicoNota.DesAdicional;
  GServicos.Cells[4,VpaLinha] := FormatFloat(Varia.MascaraQtd,VprDServicoNota.QtdServico);
  GServicos.cells[5,VpaLinha] := FormatFloat(Varia.MascaraValorUnitario,VprDServicoNota.ValUnitario);
  GServicos.Cells[6,VpaLinha] := FormatFloat(Varia.MascaraValor,VprDServicoNota.ValTotal);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := false;
  if not ExisteServico then
  begin
    GServicos.col := 1;
    aviso('SERVIÇO NÃO PREENCHIDO!!!'#13'É necessário preencher o código do serviço.');
  end
  else
    if GServicos.Cells[4,GServicos.ALinha] = '' then
    begin
      GServicos.col := 4;
      Aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do serviço.');
    end
    else
      if GServicos.Cells[5,GServicos.ALinha] = '' then
      begin
        GServicos.col := 5;
        aviso('VALOR UNITÁRIO INVÁLIDO!!!'#13'É necessário preencher o valor unitário do serviço.');
     end
      else
        VpaValidos := true;
  if VpaValidos then
  begin
    CarDServicoNota ;
    CalculaValorTotal;
    if VprDServicoNota.QtdServico = 0 then
    begin
      VpaValidos := false;
      GServicos.col := 4;
      Aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do serviço.');
    end
    else
      if VprDServicoNota.ValUnitario = 0 then
      begin
        VpaValidos := false;
        GServicos.col := 5;
        aviso('VALOR UNITÁRIO INVÁLIDO!!!'#13'É necessário preencher o valor unitário do serviço.');
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1 :  Value := '0000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GServicos.Col of
        1 :  LocalizaServico;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosKeyPress(Sender: TObject;
  var Key: Char);
begin
//  IF GServicos.Col = 2 then  //referencia do cliente
//    key := #;

  if (key = '.')  then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDNota.Servicos.Count >0 then
  begin
    VprDServicoNota := TRBDNotaFiscalServico(VprDNota.Servicos.Items[VpaLinhaAtual-1]);
    VprServicoAnterior := InttoStr(VprDServicoNota.CodServico);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosNovaLinha(Sender: TObject);
begin
  VprDServicoNota := VprDNota.AddServico;
  VprServicoAnterior := '-10';
end;

procedure TFNovaNotaFiscalNota.GServicosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GServicos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GServicos.AColuna <> ACol then
    begin
      case GServicos.AColuna of
        1 :if not ExisteServico then
           begin
             if not LocalizaServico then
             begin
               GServicos.Cells[1,GServicos.ALinha] := '';
               GServicos.Col := 1;
             end;
           end;
        4,5 :
             begin
               if GServicos.Cells[4,GServicos.ALinha] <> '' then
                 VprDServicoNota.QtdServico := StrToFloat(DeletaChars(GServicos.Cells[4,GServicos.ALinha],'.'))
               else
                 VprDServicoNota.QtdServico := 0;
               if GServicos.Cells[5,GServicos.ALinha] <> '' then
                 VprDServicoNota.ValUnitario := StrToFloat(DeletaChars(GServicos.Cells[5,GServicos.ALinha],'.'))
               else
                 VprDServicoNota.ValUnitario := 0;
               CalculaValorTotalServico;
             end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECodPrepostoRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    EComissaoPreposto.AValor := StrToFloat(retorno1);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.BFinanceiroOcultoClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := GeraFinanceiroOculto;
  if vpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECoDVendedorSelect(Sender: TObject);
begin
  if VprNotaAutomatica then
  begin
    ECoDVendedor.ASelectValida.Text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_COM, I_TIP_COM '+
                                       ' from CADVENDEDORES '+
                                       ' where I_COD_VEN  = @ ';
    ECoDVendedor.ASelectLocaliza.text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_COM, I_TIP_COM '+
                                         ' from CADVENDEDORES '+
                                         ' where C_NOM_VEN like ''@%'''+
                                         ' order by C_NOM_VEN ';
  end
  else
  begin
    ECoDVendedor.ASelectValida.Text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_COM, I_TIP_COM '+
                                       ' from CADVENDEDORES '+
                                       ' where I_COD_VEN  = @ '+
                                       ' and C_IND_ATI = ''S''';
    ECoDVendedor.ASelectLocaliza.text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_COM, I_TIP_COM '+
                                         ' from CADVENDEDORES '+
                                         ' where C_NOM_VEN like ''@%'''+
                                         ' and C_IND_ATI = ''S'''+
                                         ' order by C_NOM_VEN ';
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECodPrepostoSelect(Sender: TObject);
begin
  if VprNotaAutomatica then
  begin
    ECodPreposto.ASelectValida.Text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_PRE, I_TIP_COM '+
                                       ' from CADVENDEDORES '+
                                       ' where I_COD_VEN  = @ ';
    ECodPreposto.ASelectLocaliza.text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_PRE, I_TIP_COM '+
                                         ' from CADVENDEDORES '+
                                         ' where C_NOM_VEN like ''@%'''+
                                         ' AND C_IND_PRE = ''S'''+
                                         ' order by C_NOM_VEN ';
  end
  else
  begin
    ECodPreposto.ASelectValida.Text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_PRE, I_TIP_COM '+
                                       ' from CADVENDEDORES '+
                                       ' where I_COD_VEN  = @ '+
                                       ' and C_IND_ATI = ''S''';
    ECodPreposto.ASelectLocaliza.text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_PRE, I_TIP_COM '+
                                         ' from CADVENDEDORES '+
                                         ' where C_NOM_VEN like ''@%'''+
                                         ' and C_IND_ATI = ''S'''+
                                         ' AND C_IND_PRE = ''S'''+
                                         ' order by C_NOM_VEN ';
  end;
end;
{******************************************************************************}
procedure TFNovaNotaFiscalNota.EspelhodaNota1Click(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimeEspelhoNota(VprDNota.CodFilial,VprDNota.SeqNota);
  dtRave.free;
end;

Initialization
{3254}
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaNotaFiscalNota]);
end.












