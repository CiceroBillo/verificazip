unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Menus, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls,
  Componentes1, PainelGradiente,UnImpressaoRelatorio, UnContasAPagar, UnNotaFiscal,
  DBTables, unVersoes,
  UnPrincipal, Mask, Tabela, Dialogs, WideStrings, SqlExpr, DBXOracle, DBClient;

const
  CampoPermissaoModulo = 'C_MOD_EST';
  CampoFormModulos ='C_MOD_EST';
  NomeModulo = 'Estoque/Custo';

type
  TFPrincipal = class(TFormularioFundo)
    Menu: TMainMenu;
    MFAlteraSenha: TMenuItem;
    MAjuda: TMenuItem;
    BarraStatus: TStatusBar;
    Mjanela: TMenuItem;
    MCascata: TMenuItem;
    MLadoaLado: TMenuItem;
    MArquivo: TMenuItem;
    MSair: TMenuItem;
    N1: TMenuItem;
    MSobre: TMenuItem;
    MNormal: TMenuItem;
    MFAlterarFilialUso: TMenuItem;
    CorFoco: TCorFoco;
    CorForm: TCorForm;
    CorPainelGra: TCorPainelGra;
    MFAbertura: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    BCascata: TSpeedButton;
    BLadoaLado: TSpeedButton;
    BNormal: TSpeedButton;
    MCadastro: TMenuItem;
    MFFormacaoPreco: TMenuItem;
    MFAcertoEstoque: TMenuItem;
    MFExtornoEntrada: TMenuItem;
    MFCadNotaFiscaisFor: TMenuItem;
    MProdutos: TMenuItem;
    MFUnidades: TMenuItem;
    MFOperacoesEstoques: TMenuItem;
    MFprodutos: TMenuItem;
    MFCadPaises: TMenuItem;
    MFCadEstados: TMenuItem;
    MFCidades: TMenuItem;
    N3: TMenuItem;
    MFEventos: TMenuItem;
    MFProfissoes: TMenuItem;
    MFSituacoesClientes: TMenuItem;
    MFClientes: TMenuItem;
    N4: TMenuItem;
    MFNaturezas: TMenuItem;
    MFAdicionaProdFilial: TMenuItem;
    MFEstornoAcertoEstoque: TMenuItem;
    MFTabelaPreco: TMenuItem;
    MFCadIcmsEstado: TMenuItem;
    MFEstoqueProdutos: TMenuItem;
    MFPontoPedido: TMenuItem;
    MEstoque: TMenuItem;
    MServicos: TMenuItem;
    Servios1: TMenuItem;
    BSaida: TSpeedButton;
    MFFormacaoPrecoServico: TMenuItem;
    MAvaliaodeEstoque: TMenuItem;
    MFEstoqueProdutosAtual: TMenuItem;
    MFEstoqueClassificacaoAtual: TMenuItem;
    MFDetalhesEstoque: TMenuItem;
    MFAtividadeProduto: TMenuItem;
    BMFProdutos: TSpeedButton;
    BMFClientes: TSpeedButton;
    BMFConsultaProduto: TSpeedButton;
    ToolButton1: TToolButton;
    MFLocalizaProduto: TMenuItem;
    BMFAcertoEstoque: TSpeedButton;
    BMFEntradaMercadoria: TSpeedButton;
    BMFEstornoEntrada: TSpeedButton;
    BMFEstoqueAtual: TSpeedButton;
    BMFMovimentosEstoque: TSpeedButton;
    BMFEstoqueProdutos: TSpeedButton;
    MFEstoqueProdutosPreco: TMenuItem;
    MFFechamentoEstoque: TMenuItem;
    MForcaNovoUsuario: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    Constexto1: TMenuItem;
    ndice1: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    GeraMovimento1: TMenuItem;
    N18: TMenuItem;
    MInventario: TMenuItem;
    MRelatorios: TMenuItem;
    Mquinas1: TMenuItem;
    N19: TMenuItem;
    MProducao: TMenuItem;
    NovaOrdemProduo1: TMenuItem;
    TipoEstgioProduo1: TMenuItem;
    EstgiosProduo1: TMenuItem;
    N20: TMenuItem;
    MConsultarOrdemProducao: TMenuItem;
    N21: TMenuItem;
    TipoEmenda1: TMenuItem;
    N22: TMenuItem;
    MColetaQtdOrdemProducao: TMenuItem;
    AdicionarAoRomaneio1: TMenuItem;
    MRomaneio: TMenuItem;
    N23: TMenuItem;
    MotivoReprogramao1: TMenuItem;
    RevisoExterna1: TMenuItem;
    N24: TMenuItem;
    TipoCorte1: TMenuItem;
    N25: TMenuItem;
    ReabrirMs1: TMenuItem;
    CalendrioBase1: TMenuItem;
    HorrioTrabalho1: TMenuItem;
    N26: TMenuItem;
    MCelulaTrabalho: TMenuItem;
    MFerramentas: TMenuItem;
    AtualizaoPreo1: TMenuItem;
    Cor1: TMenuItem;
    Facas1: TMenuItem;
    MReprocessarProdutividade: TMenuItem;
    MColetaFracaoRomaneio: TMenuItem;
    N28: TMenuItem;
    MFaccionistas: TMenuItem;
    N27: TMenuItem;
    MFracaoFaccionista: TMenuItem;
    MAdicionarFracaoFaccionista: TMenuItem;
    MAdicinoarRetornoFracaoFaccionista: TMenuItem;
    MFaccionista: TMenuItem;
    MRetornoFracaoFaccionista: TMenuItem;
    N29: TMenuItem;
    MAdicionarDevolucaoFaccionista: TMenuItem;
    MDevolucaoFaccionista: TMenuItem;
    MEfetuarTelemarketingFaccionista: TMenuItem;
    MTelemarketingFAccionista: TMenuItem;
    N31: TMenuItem;
    MCartuchos: TMenuItem;
    PesarCartucho1: TMenuItem;
    N30: TMenuItem;
    MImprimirEtiquetaProduto: TMenuItem;
    MCompras: TMenuItem;
    MNovoPedidoCompras: TMenuItem;
    MPedidosCompras: TMenuItem;
    N33: TMenuItem;
    AlterarEstgio1: TMenuItem;
    MSolicitacaoCompras: TMenuItem;
    MNovaSolicitacaoCompras: TMenuItem;
    MSolicitacoesCompras: TMenuItem;
    MAlteraEstagioOrcamentoCompra: TMenuItem;
    N32: TMenuItem;
    Timer1: TTimer;
    N34: TMenuItem;
    Compradores1: TMenuItem;
    N35: TMenuItem;
    ConsultaCartuchos1: TMenuItem;
    N36: TMenuItem;
    ecobrana1: TMenuItem;
    N37: TMenuItem;
    ImportaoSolidWorks1: TMenuItem;
    N38: TMenuItem;
    Acessrios1: TMenuItem;
    MBastidor: TMenuItem;
    MPlanoCorte: TMenuItem;
    MNovoPlanoCorte: TMenuItem;
    N39: TMenuItem;
    MConsultaPlanoCorte: TMenuItem;
    MFichasTecnicasPendentes: TMenuItem;
    MDesenhosPendentes: TMenuItem;
    MOrcamentoCompra: TMenuItem;
    MNovoOrcamentoCompras: TMenuItem;
    MConsultaOrcamentoCompras: TMenuItem;
    N40: TMenuItem;
    ConsultLogSeparao1: TMenuItem;
    MGerencial: TMenuItem;
    MCustoPendente: TMenuItem;
    MAmostrasPendentes: TMenuItem;
    N41: TMenuItem;
    MExcluiProdutoDuplicado: TMenuItem;
    MPendenciasdeCompras: TMenuItem;
    BMOrdemProducao: TSpeedButton;
    Agenda1: TMenuItem;
    Agenda2: TMenuItem;
    FiguraGRF1: TMenuItem;
    Composio1: TMenuItem;
    N42: TMenuItem;
    GeraCdigosBarras1: TMenuItem;
    N43: TMenuItem;
    RetiraAcentuoNomeProdutos1: TMenuItem;
    Embalagem1: TMenuItem;
    BMFReservaEstoque: TSpeedButton;
    MReservaEstoque: TMenuItem;
    MotivoParada1: TMenuItem;
    N44: TMenuItem;
    MBaixarOrdemCorte: TMenuItem;
    MCortePendente: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    ImprimeEtiquetaPrateleira1: TMenuItem;
    Tabela: TSQL;
    MFichaAmostraPendente: TMenuItem;
    N47: TMenuItem;
    MEstoqueChapas: TMenuItem;
    ProcessosProduo1: TMenuItem;
    BaseDados: TSQLConnection;
    N6: TMenuItem;
    AtualizarModulos1: TMenuItem;
    ConsultaProdutosporNmerodeSrie1: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BaseMVA: TSQLConnection;
    TabelaMVA: TSQL;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure ndice1Click(Sender: TObject);
    procedure GeraEstoque1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToolBar1Click(Sender: TObject);
    procedure CortePendente1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    UnPri : TFuncoesPrincipal;
    FunImpressaoRel : TImpressaoRelatorio;
    TipoSistema : string;
    procedure ConfiguraPermissaoUsuario;
    function RPos1Barras(VpaNomProduto : string) : Integer;
  public
     function AbreBaseDados( VpaAlias : string ) : Boolean;
     procedure AlteraNomeEmpresa;
     Function  VerificaPermisao( nome : string ) : Boolean;
     procedure erro(Sender: TObject; E: Exception);
     procedure abre(var Msg: TMsg; var Handled: Boolean);
     procedure VerificaMoeda;
     procedure ValidaBotoesGrupos( botoes : array of TComponent);
     procedure TeclaPressionada(var Msg: TWMKey; var Handled: Boolean);
     procedure ConfiguracaoModulos;
     procedure OrganizaBotoes;
  end;



var
  FPrincipal: TFPrincipal;
  Ini : TInifile;

implementation

uses Constantes, UnRegistro, funsql, FunNumeros,
     Abertura, AAlterarSenha, ASobre, FunIni, AAlterarFilialUso,
     AUnidade, AOperacoesEstoques, AProfissoes, ASituacoesClientes,
     AClientes, ACadPaises, ACadEstados, ACadCidades,
     AEventos, AProdutos, AExtornoEntrada,
     ANaturezas, AAcertoEstoque, AEstornoAcertoEstoque,
     AAdicionaProdFilial, AFormacaoPreco, ATabelaPreco, ACadIcmsEstado,
  AEstoqueProdutos, APontoPedido,
  AServicos, AFormacaoPrecoServico,
  UnAtualizacao, AEstoqueClassificacaoAtual, AEstoqueProdutosAtual,
  ADetalhesEstoque, AAtividadeProduto, ALocalizaProdutos,
  AEstoqueProdutosPreco, AFechamentoEstoque, UnProdutos,
  AInventario, UnSistema, AMaquinas, ANovaOrdemProducao,
  ATipoEstagioProducao, AEstagioProducao, AOrdemProducao, ATipoEmenda,
  AAlteraEstagioProducao, FunSistema,
  ANovaColetaOrdemProducao, AAdicionaColetaOPRomaneio,
  ARomaneios, ANovaNotaFiscaisFor, AMotivoReprogramacao, ARevisaoExterna, UnContasAReceber,
  ATipoCorte, AReprocessaEstoque, ACalendarioBase, AHorarioTrabalho,
  ACelulaTrabalho, AOrdensProducaoCadarco, AAtualizaPrecoFarmacia, ACores,
  AFacas, AOrdemProducaoGenerica, UnCrystal, AAlteraEstagioFracaoOP,
  ANovaOrdemProducaoGenerica, ANovaColetaFracaoOP, AColetaFracaoOP,
  AProcessaProdutividade, ANovaColetaRomaneio, ARomaneioGenerico, UnClientes,
  AFaccionistas, AFracaoFaccionista, ANovaFracaoFaccionista,
  ARetornoFracaoFaccionista, ADevolucaoFracaoFaccionista,
  ANovoTelemarketingFaccionista, ATelemarketingFaccionista, APesarCartucho,
  AImpEtiquetaTermicaProduto, ANovoPedidoCompra, APedidoCompra,
  AAlteraEstagioPedidoCompra, ASolicitacaoCompras, ANovaSolicitacaoCompra,
  AAlteraEstagioOrcamento,
  ACompradores, ACartuchos,
  AEmailCobrancaPedidoCompra, AImportaProdutosSolidWorks, AAcessorio,
  ABastidor, ANovoPlanoCorte, APlanoCorte, AFichaTecnicaPendente,
  ADesenhosPendentes, AOrcamentoCompras, ANovoOrcamentoCompra,
  AConsultaLogSeparacaoConsumo, APrecoPendente, AAmostrasPendentes,
  AExcluiProdutoDuplicado, APendenciasCompras, AAgendamentos, AFiguraGRF,
  AComposicoes, UnOrdemProducao, AEmbalagem, AMotivoParada, ABaixaOrdemCorte, AOrdemCortePendente, AImprimeEtiquetaPrateleira,
  AFichaAmostrasPendentes, UnCotacao, ACadastraEstoqueChapa, AProcessosProducao, FunArquivos,
  AConsultaProdutoNumeroSerie, AConsultaPrecosProdutos, FunString;

{$R *.DFM}


// ----- Verifica a permissão do formulários conforme tabela MovGrupoForm -------- //
Function TFPrincipal.VerificaPermisao( nome : string ) : Boolean;
begin
  result := UnPri.VerificaPermisao(nome);
  if not result then
    abort;
end;

// ------------------ Mostra os comentarios ma barra de Status ---------------- }
procedure TFPrincipal.MostraHint(Sender : TObject);
begin
  BarraStatus.Panels[3].Text := Application.Hint;
end;

// ------------------ Na criação do Formulário -------------------------------- }
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  UnPri := TFuncoesPrincipal.criar(self, BaseDados, NomeModulo);
  Varia := TVariaveis.Cria(FPrincipal.BaseDados);   // classe das variaveis principais
  Config := TConfig.Create;     // Classe das variaveis Booleanas
  ConfigModulos := TConfigModulo.create; // classe das variaveis de configuracao do modulo.
  FunImpressaoRel := TImpressaoRelatorio.Cria(BaseDados);
  FunContasAPagar := TFuncoesContasAPagar.criar(self,BaseDados);
  FunNotaFiscal := TFuncoesNotaFiscal.criar(self,BaseDados);
  FunClientes := TRBFuncoesClientes.cria(FPrincipal.BaseDados);
  FunContasAReceber := TFuncoesContasAReceber.cria(BaseDados);
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(BaseDAdos);
  FunCotacao := TFuncoesCotacao.Cria(BaseDados);
  Sistema := TRBFuncoesSistema.cria(FPrincipal.BaseDados);
  Application.OnHint := MostraHint;
  Application.HintColor := $00EDEB9E;        // cor padrão dos hints
  Application.Title := NomeModulo ;  // nome a ser mostrado na barra de tarefa do Windows
  Application.OnException := Erro;
  Application.OnMessage := Abre;
  Application.OnShortCut := TeclaPressionada;
  Varia.VersaoSistema := VersaoEstoque;
  if Self.Text = '' then
  begin


  end;
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraPermissaoUsuario;
begin
  Varia.EscondeMenus(Menu,false);
  AlterarVisibleDet([MRelatorios],true);
  AlterarVisibleDet([MFerramentas,ImprimeEtiquetaPrateleira1],true);
  FunImpressaoRel.CarregarMenuRel(mrEstoque,MRelatorios);

  AlterarVisibleDet([BMFClientes,BMFProdutos,BMFConsultaProduto,BMFEntradaMercadoria,BMFEstornoEntrada, BMFEstoqueAtual,BMFEstoqueProdutos,BMFMovimentosEstoque,BMFAcertoEstoque,BMFReservaEstoque],false);


  if (puAdministrador in varia.PermissoesUsuario) or (puESCompleto in varia.PermissoesUsuario) then
  begin
    varia.EscondeMenus(Menu,true);
    AlterarVisibleDet([BMFClientes,BMFProdutos,BMFConsultaProduto,BMFEntradaMercadoria,BMFEstornoEntrada, BMFEstoqueAtual,BMFEstoqueProdutos,BMFMovimentosEstoque],true);
    AlterarVisibleDet([MFichaAmostraPendente],config.MostrarMenuFichaAmostraPendente);
  end
  else
  begin
    AlterarVisibleDet([MFichaAmostraPendente],config.MostrarMenuFichaAmostraPendente);
    if (puProdutoCompleto in varia.PermissoesUsuario) then
      AlterarVisibleDet([BMFProdutos,MProdutos,MFProdutos,n16,MFAdicionaProdFilial,N17,MFTabelaPreco,MFFormacaoPreco,n18,
                         n7,N19],true);
    if (puManutencaoProdutos in varia.PermissoesUsuario) then
      AlterarVisibleDet([BMFProdutos,MFProdutos,MProdutos,Cor1,Facas1,MBastidor],true);
    if (puConsultarOP in varia.PermissoesUsuario) then
      AlterarVisibleDet([MProducao,MConsultarOrdemProducao],true);
    if (puESRomaneio in varia.PermissoesUsuario) then
      AlterarVisibleDet([MProducao,MRomaneio,MColetaFracaoRomaneio,N24,N28],true);
    if (puESCadastrarFaccionista in varia.PermissoesUsuario) then
      AlterarVisibleDet([MCadastro,MFaccionistas],true);
    if (puESAdicionarFracaoFaccionista in varia.PermissoesUsuario) then
      AlterarVisibleDet([MFaccionista,MAdicionarFracaoFaccionista,MEfetuarTelemarketingFaccionista,MTelemarketingFAccionista,n29,MAdicionarDevolucaoFaccionista,MDevolucaoFaccionista],true);
    if (puESConsultarFracaoFaccionista in varia.PermissoesUsuario) then
      AlterarVisibleDet([MFaccionista,MFracaoFaccionista],true);
    if (puESAdicionarRetornoFracaoFaccionista in varia.PermissoesUsuario) then
      AlterarVisibleDet([MFaccionista,MAdicinoarRetornoFracaoFaccionista],true);
    if (puESConsultarRetornoFracaoFaccionista in varia.PermissoesUsuario) then
      AlterarVisibleDet([MFaccionista,MRetornoFracaoFaccionista],true);
    if not(puRelatorios in varia.PermissoesUsuario) then
      AlterarVisibleDet([MRelatorios],false);
    if (puESCadastrarNotaFiscal in varia.PermissoesUsuario) then
      AlterarVisibleDet([MEstoque,MFCadNotaFiscaisFor,MFExtornoEntrada,n8],true);
    if (puESImprimirEtiquetaProduto in varia.PermissoesUsuario) then
      AlterarVisibleDet([MProducao,MImprimirEtiquetaProduto],true);
    if (puESPedidoCompra in varia.PermissoesUsuario) then
      AlterarVisibleDet([MPedidosCompras,MCompras],true);
    if (puESSolicitacaoCompra in varia.PermissoesUsuario) then
      AlterarVisibleDet([MSolicitacaoCompras,MSolicitacoesCompras,MAlteraEstagioOrcamentoCompra],true);
    if (puESOrcamentoCompra in varia.PermissoesUsuario) then
      AlterarVisibleDet([MOrcamentoCompra, MNovoOrcamentoCompras,MConsultaOrcamentoCompras],true);
    if (puESPlanoCorte in varia.PermissoesUsuario) then
      AlterarVisibleDet([N39,MPlanoCorte,MNovoPlanoCorte,MConsultaPlanoCorte],true);
    if (puESColetaQtdProduzidoOP in varia.PermissoesUsuario) then
      AlterarVisibleDet([MProducao,MColetaQtdOrdemProducao],true);
    if (puESReprocessarProdutividade in varia.PermissoesUsuario) then
      AlterarVisibleDet([MProducao,MReprocessarProdutividade],true);
    if (puESAcertoEstoque in varia.PermissoesUsuario) then
      AlterarVisibleDet([MEstoque,MFAcertoEstoque,BMFAcertoEstoque],true);
    if (puESReservaEstoque in varia.PermissoesUsuario) then
      AlterarVisibleDet([MEstoque,MReservaEstoque,BMFReservaEstoque],true);
    if (puESMenuGerencial in varia.PermissoesUsuario) then
      AlterarVisibleDet([MGerencial,MDesenhosPendentes,MFichasTecnicasPendentes,n38,MAmostrasPendentes,MCustoPendente,MPendenciasdeCompras],true);
    if (puESCadastrarCelulaTrabalho in varia.PermissoesUsuario) then
      AlterarVisibleDet([MCadastro,MCelulaTrabalho],true);
    if (puESConsultaProduto in varia.PermissoesUsuario) then
      AlterarVisibleDet([MProdutos,MFLocalizaProduto],true);
    if (puESInventario in varia.PermissoesUsuario) then
      AlterarVisibleDet([MEstoque,MInventario],true);
    if (puESMenuGerencialFichaAmostraPendente in varia.PermissoesUsuario) then
      AlterarVisibleDet([MGerencial,MFichaAmostraPendente],true);
    if (puESMenuGerencialAmostraPendente in varia.PermissoesUsuario) then
      AlterarVisibleDet([MGerencial,MAmostrasPendentes],true);
    if (puESCustoPendente in varia.PermissoesUsuario) then
      AlterarVisibleDet([MGerencial,MCustoPendente],true);
    if (puESCadastrarEstoqueChapas in varia.PermissoesUsuario) then
      AlterarVisibleDet([MEstoque,MEstoqueChapas],true);
    if (puESCadastrarSolicitacaoCompra in varia.PermissoesUsuario) then
      AlterarVisibleDet([MNovaSolicitacaoCompras,MSolicitacaoCompras],true);
    if (puESCadastrarPedidoCompra in varia.PermissoesUsuario) then
      AlterarVisibleDet([MNovoPedidoCompras,MPedidosCompras],true);
    if (puESMenuGerencialCortePendente in varia.PermissoesUsuario) then
      AlterarVisibleDet([MGerencial,MCortePendente],true);
    if (puESBaixarOrdemCorte in varia.PermissoesUsuario) then
      AlterarVisibleDet([MProducao,MBaixarOrdemCorte],true);
    if (puESExcluiProdutoDuplicado in varia.PermissoesUsuario) then
      AlterarVisibleDet([MFerramentas,MExcluiProdutoDuplicado],true);
  end;

  if not (config.ManutencaoImpressoras) then
    AlterarVisibleDet([MCartuchos],false);


  if not (config.CadastroEtiqueta or Config.CadastroCadarco) then
  begin
    AlterarVisibleDet([N22,N24,AdicionarAoRomaneio1,RevisoExterna1],false);
  end
  else
  begin
    AlterarVisibleDet([MColetaFracaoRomaneio],false);
  end
end;

{************ abre base de dados ********************************************* }
function TFPrincipal.AbreBaseDados( VpaAlias : string ) : Boolean;
Var
  VpfAliasOracle : string;
begin
  if VpaAlias = '' then
    VpaAlias := 'SisCorp';
  if ExisteLetraString('/',VpaAlias)  then
  begin
    VpfAliasOracle := DeleteAteChar(VpaAlias,'/');
    VpaAlias := CopiaAteChar(VpaAlias,'/');
  end
  else
    if UpperCase(VpaAlias) = 'EFICACIA' then
      VpfAliasOracle := 'Eficacia'
    else
      VpfAliasOracle := 'SisCorp';

  Result := true;
  BaseDados.close;
  BaseDados.Params.clear;
  BaseDados.Params.add('drivername=Oracle');
  BaseDados.Params.add('Database='+VpfAliasOracle);
  BaseDados.Params.add('decimal separator=,');
  BaseDados.Params.add('Password=1298');
  if UpperCase(VpaAlias) = 'SISCORP' then
    BaseDados.Params.add('User_Name=system')
  else
    BaseDados.Params.add('User_Name='+VpaAlias);
  BaseDados.Open;
end;

procedure TFPrincipal.erro(Sender: TObject; E: Exception);
begin
  Aviso(E.Message);
end;

// ------------------- Quando o formulario e fechado -------------------------- }
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UnPri.free;
{  BaseDados.Close;
  Varia.Free;
  Config.Free;
  Sistema.free;
  FunImpressaoRel.free;
  FunProdutos.free;
  FunContasAPagar.free;
  FunContasAReceber.free;
  FunNotaFiscal.free;
  FunClientes.free;
  FunOrdemProducao.free;
  FunCotacao.Free;
  Action := CaFree;}
end;

// -------------------- Quando o Formulario é Iniciado ------------------------ }
procedure TFPrincipal.FormShow(Sender: TObject);
begin
  // configuracoes do usuario
  UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
  // configura modulos
  ConfiguracaoModulos;
  AlteraNomeEmpresa;
  FPrincipal.WindowState := wsMaximized;  // coloca a janela maximizada;
  // conforme usuario, configura menu
  OrganizaBotoes;
  FunProdutos := TFuncoesProduto.criar(self,BaseDados);

end;

{****************** organiza os botoes do formulario ************************ }
procedure TFPrincipal.OrganizaBotoes;
begin
  UnPri.OrganizaBotoes(0, [ BCascata, BLadoaLado, BNormal, BMFClientes, BMFProdutos, BMFConsultaProduto,BMOrdemProducao,
                            BMFAcertoEstoque,BMFReservaEstoque,BMFEntradaMercadoria, BMFEstornoEntrada, BMFEstoqueAtual, BMFEstoqueProdutos,
                            BMFMovimentosEstoque, bsaida]);
end;

{******************************************************************************}
function TFPrincipal.RPos1Barras(VpaNomProduto: string): Integer;
var
  VpfLaco : Integer;
  VpfAchouIgual : Boolean;
begin
  result := 0;
  VpfAchouIgual := false;

  for VpfLaco := 0 to Length(VpaNomProduto) -3 do
  begin
    if (VpaNomProduto[Vpflaco] = '/') and VpfAchouIgual then
    begin
      result := VpfLaco;
      break;
    end;
    if (VpaNomProduto[Vpflaco] = '=') then
      VpfAchouIgual := true;

  end;
end;

// -------------------- Altera o Caption da Jabela Proncipal ------------------ }
procedure TFPrincipal.AlteraNomeEmpresa;
begin
  UnPri.AlteraNomeEmpresa(self, BarraStatus, NomeModulo, TipoSistema );
end;


procedure TFPrincipal.BitBtn1Click(Sender: TObject);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MOVQDADEPRODUTO');

  while not Tabela.Eof do
  begin
    Tabela.Edit;
    Tabela.FieldByName('N_QTD_PRO').AsFloat := ArredondaDecimais(Tabela.FieldByName('N_QTD_PRO').AsFloat,2);
    Tabela.Post;
    Tabela.Next;
  end;
  Tabela.Close;
end;

procedure TFPrincipal.BitBtn2Click(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunProdutos.AdicionarProdutosFilial;
  if VpfResultado <> '' then
    aviso(VpfResultado);
  exit;
end;

procedure TFPrincipal.BitBtn3Click(Sender: TObject);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADPRODUTOS ' +
                               'WHERE N_PER_SUT = 0 ');
  while not Tabela.Eof do
  begin
    AdicionaSQLAbreTabela(TabelaMVA,'Select N_PER_SUT from CADPRODUTOS ' +
                                    ' WHERE I_SEQ_PRO = ' +IntToStr(TABELA.FieldByName('I_SEQ_PRO').AsInteger));
    if TabelaMVA.FieldByName('N_PER_SUT').AsFloat > 0 then
    Begin
      Tabela.Edit;
      Tabela.FieldByName('N_PER_SUT').AsFloat := TabelaMVA.FieldByName('N_PER_SUT').AsFloat;
      tabela.Post;
    End;
    Tabela.Next;
  end;
  Tabela.Close;
end;

// -------------Quando é enviada a menssagem de criação de um formulario------------- //
procedure TFPrincipal.abre(var Msg: TMsg; var Handled: Boolean);
begin
  if (Msg.message = CT_CRIAFORM) or (Msg.message = CT_DESTROIFORM) then
  begin
    UnPri.ConfiguraMenus(screen.FormCount,[BCascata,BLadoaLado,BNormal],[MFAbertura,MSair], Mjanela);
  end;
end;

// --------- Verifica moeda --------------------------------------------------- }
procedure TFPrincipal.VerificaMoeda;
begin
  if (varia.DataDaMoeda <> date) and (Config.AvisaDataAtualInvalida)  then
    aviso(CT_DataMoedaDifAtual)
  else
    if (varia.MoedasVazias <> '') and (Config.AvisaIndMoeda) then
    avisoFormato(CT_MoedasVazias, [ varia.MoedasVazias]);
end;


// -------------  Valida ou naum Botoes para ususario master ou naum ------------- }
procedure TFPrincipal.ValidaBotoesGrupos( botoes : array of TComponent);
begin
  if Varia.GrupoUsuarioMaster <> Varia.GrupoUsuario then
    AlterarEnabledDet(botoes,false);
end;

{******************************************************************************}
procedure TFPrincipal.TeclaPressionada(var Msg: TWMKey; var Handled: Boolean);
begin
    case Msg.CharCode  of
      117 :
       begin
         Sistema.SalvaTabelasAbertas;
       end;
      119 :
       if not VerificaFormCriado('TFAlteraEstagioProducao') then
       begin
         if config.CadastroEtiqueta then
         begin
           FAlteraEstagioProducao := TFAlteraEstagioProducao.CriarSDI(application , '', FPrincipal.VerificaPermisao('FAlteraEstagioProducao'));
           FAlteraEstagioProducao.AlteraEstagio;
           FAlteraEstagioProducao.free;
         end
         else
         begin
           FAlteraEstagioFracaoOP := TFAlteraEstagioFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraEstagioFracaoOP'));
           FAlteraEstagioFracaoOP.alteraEstagioFracaoOP;
           FAlteraEstagioFracaoOP.free;
         end;
       end;
      116 :
        if not VerificaFormCriado('TFNovaColetaFracaoOP') then
        begin
          FNovaColetaFracaoOP := TFNovaColetaFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaColetaFracaoOP'));
          FNovaColetaFracaoOP.NovaColeta;
          FNovaColetaFracaoOP.free;
        end;
      VK_F12 :
       if not VerificaFormCriado('TFLocalizaProduto') then
       begin
          FConsultaPrecosProdutos := TFConsultaPrecosProdutos.criarSDI(Application,'',VerificaPermisao('FConsultaPrecosProdutos'));
          FConsultaPrecosProdutos.ShowModal;
          FConsultaPrecosProdutos.Free;
       end;
    end;
end;


{************************  M E N U   D O   S I S T E M A  ********************* }
procedure TFPrincipal.MenuClick(Sender: TObject);
var
  VpfData : TDateTime;
  VpfResultado : string;
begin
  if Sender is TComponent  then
  case ((Sender as TComponent).Tag) of
    0001 : Close;
    1100 : begin
             FAlterarFilialUso := TFAlterarFilialUso.CriarSDI(application,'', VerificaPermisao('FAlterarFilialUso'));
             FAlterarFilialUso.ShowModal;
           end;
    1200, 1210 : begin
             // ----- Formulario para alterar o usuario atual ----- //
             FAbertura := TFAbertura.Create(Application);
             FAbertura.ShowModal;
             if Varia.StatusAbertura = 'OK' then
             begin
               AlteraNomeEmpresa;
               ResetaMenu(Menu, ToolBar1);
               UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
               ConfiguracaoModulos;
               OrganizaBotoes;
             end
             else
               if  ((Sender as TComponent).Tag) = 1210 then
                 FPrincipal.close;
           end;
           // ----- Sair do Sistema ----- //
    1300 : Close;
    2100 : begin
             // ------ Cadastra as Unidades ------ //
             FUnidades := TFUnidades.CriarSDI(application,'',VerificaPermisao('FUnidades'));
             FUnidades.ShowModal;
           end;
    2200 : begin
             FCalendarioBase := TFCalendarioBase.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCalendarioBase'));
             FCalendarioBase.Showmodal;
             FCalendarioBase.free;
           end;
    2250 : begin
             FHorarioTrabalho := TFHorarioTrabalho.CriarSDI(application,'', FPrincipal.VerificaPermisao('FHorarioTrabalho'));
             FHorarioTrabalho.Showmodal;
             FHorarioTrabalho.free;
           end;
    2260 : begin
             FCelulaTrabalho := tFCelulaTrabalho.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCelulaTrabalho'));
             FCelulaTrabalho.Showmodal;
             FCelulaTrabalho.free;
           end;
    2270 : begin
             FFaccionistas := TFFaccionistas.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFaccionistas'));
             FFaccionistas.ShowModal;
             FFaccionistas.free;
           end;
    2300 : begin
             // ----- Cadastra Operações de Estoque ----- //
             FOperacoesEstoques := TFOperacoesEstoques.criarSDI(application,'',VerificaPermisao('FOperacoesEstoques'));
             FOperacoesEstoques.ShowModal;
           end;
    2310 : begin
             FCompradores:= TFCompradores.CriarSDI(Application,'',True);
             FCompradores.ShowModal;
             FCompradores.Free;
           end;
    2450 : begin
             // ------ O Cadastro de Naturezas ------ //
             FNaturezas := TFNaturezas.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNaturezas'));
             FNaturezas.ShowModal;
             FNaturezas.Free;
           end;
    2475 : begin
             FCadIcmsEstado := TFCadIcmsEstado.CriarSDI(application, '', VerificaPermisao('FCadIcmsEstado'));
             FCadIcmsEstado.ShowModal;
           end;
    2500 : begin
             FEventos := TFEventos.CriarSDI(application, '', VerificaPermisao('FEventos'));
             FEventos.ShowModal;
           end;
    2600 : begin
             // ------- As profissões do Cliente ------- //
             FProfissoes := TFProfissoes.CriarSDI(application,'',VerificaPermisao('FProfissoes'));
             FProfissoes.ShowModal;
           end;
    2700 : begin
             // ------ As Situções do Cliente ------- //
             FSituacoesClientes := TFSituacoesClientes.CriarSDI(Application,'',VerificaPermisao('FSituacoesClientes'));
             FSituacoesClientes.ShowModal;
           end;
           // ------- Cadastro de Clientes ------- //
    2750 : begin
             FClientes := TFClientes.CriarSDI(self,'',FPrincipal.VerificaPermisao('FClientes'));
             FClientes.Showmodal;
             FClientes.free;
           end;
           // ------ Cadastro de Transportadora ------- //
    2900 : begin
             // ------ Cadastro de Paises ------ //
             FCadPaises := TFCadPaises.CriarSDI(Application,'',VerificaPermisao('FCadPaises'));
             FCadPaises.ShowModal;
           end;
    2910 : begin
             // ------ Cadastro de Estados ------ //
             FCadEstados := TFCadEstados.CriarSDI(Application,'',VerificaPermisao('FCadEstados'));
             FCadEstados.ShowModal;
           end;
    2920 : begin
             // ------ Cadastro de Cidades ------ //
             FCidades := TFCidades.CriarSDI(Application,'',VerificaPermisao('FCidades'));
             FCidades.ShowModal;
           end;
    2950 : begin
             FMaquinas:= TFMaquinas.criarSDI(Application,'',True);
             FMaquinas.ShowModal;
             FMaquinas.free;
           end;
    2951 : begin
             FMotivoReprogramacao := tFMotivoReprogramacao.CriarSDI(application , '', FPrincipal.VerificaPermisao('FMotivoReprogramacao'));
             FMotivoReprogramacao.showmodal;
             FMotivoReprogramacao.free;
           end;
    2960 : begin
             FMotivoParada := TFMotivoParada.criarSDI(Application,'',verificaPermisao('FMotivoParada'));
             FMotivoParada.ShowModal;
             FMotivoParada.free;
           end;
    2970 : begin
             FProcessosProducao := TFProcessosProducao.criarSDI(Application,'',true);
             FProcessosProducao.ShowModal;
             FProcessosProducao.Free;
           end;
    2975 : begin
             FTipoEstagioProducao := TFTipoEstagioProducao.criarSDI(Application,'',verificaPermisao('FTipoEstagioProducao'));
             FTipoEstagioProducao.ShowModal;
             FTipoEstagioProducao.free;
           end;
    2980 : begin
             FEstagioProducao := TFEstagioProducao.criarSDI(Application,'',verificaPermisao('FEstagioProducao'));
             FEstagioProducao.ShowModal;
             FEstagioProducao.free;
           end;
           // ------- produtos
    3100 : FProdutos := TFProdutos.criarMDI(application,varia.CT_areaX, varia.CT_areaY, FPrincipal.VerificaPermisao('FProdutos'));
    3200 : begin
             FAdicionaProdFilial := TFAdicionaProdFilial.criarMDI(Application, Varia.CT_areaX, Varia.CT_areaY, VerificaPermisao('FAdicionaProdFilial'));
           end;
    3300 : begin
             FTabelaPreco := TFTabelaPreco.CriarSDI(application, '',VerificaPermisao('FTabelaPreco'));
             FTabelaPreco.ShowModal;
           end;
    3400 : begin
            FFormacaoPreco := TFFormacaoPreco.CriarSDI(application, '',VerificaPermisao('FFormacaoPreco'));
            FFormacaoPreco.ShowModal;
           end;
    3475 : Begin
             FAtividadeProduto := TFAtividadeProduto.criarSDI(Application,'',VerificaPermisao('FAtividadeProduto'));
             FAtividadeProduto.ShowModal;
           end;
    3480 : Begin
             FLocalizaProduto := TFLocalizaProduto.criarSDI(Application,'',VerificaPermisao('FLocalizaProduto'));
             FLocalizaProduto.LocalizaProduto;
           end;
    3490 : Begin
             FTipoEmenda := TFTipoEmenda.criarSDI(Application,'',FPrincipal.verificaPermisao('FTipoEmenda'));
             FTipoEmenda.ShowModal;
             FTipoEmenda.free;
           end;
    3491 : begin
             FComposicoes := TFComposicoes.CriarSDI(Application,'',true);
             FComposicoes.ShowModal;
             FComposicoes.free
           end;
    3492 : begin
             FFiguraGRF := TFFiguraGRF.CriarSDI(self,'',true);
             FFiguraGRF.ShowModal;
             FFiguraGRF.free;
           end;
    3493 : begin
             FCores := TFCores.CriarSDI(application , '', FPrincipal.VerificaPermisao('FCores'));
             FCores.showmodal;
             FCores.free;
           end;
    3494 : begin
             FBastidor := TFBastidor.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBastidor'));
             FBastidor.Showmodal;
             FBastidor.free;
           end;
    3495 : begin
             FTipoCorte := TFTipoCorte.CriarSDI(application , '', FPrincipal.VerificaPermisao('FTipoCorte'));
             FTipoCorte.showmodal;
             FTipoCorte.free;
           end;
    3498 : begin
             FAcessorio := TFAcessorio.CriarSDI(application , '', FPrincipal.VerificaPermisao('FAcessorio'));
             FAcessorio.showmodal;
             FAcessorio.free;
           end;
           // ------- serviços
    3500 : FServicos := TFServicos.criarMDI(application,varia.CT_areaX, varia.CT_areaY, FPrincipal.VerificaPermisao('FServicos'));
    3510 : begin
             FFacas := tFFacas.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFacas'));
             FFacas.ShowModal;
             FFacas.free;
           end;
    3520 : begin
             FEmbalagem := TFEmbalagem.CriarSDI(self,'',true);
             FEmbalagem.ShowModal;
             FEmbalagem.free;
           end;
    3600 : begin
            FFormacaoPrecoServico := TFFormacaoPrecoServico.CriarSDI(application, '',VerificaPermisao('FFormacaoPrecoServico'));
            FFormacaoPrecoServico.ShowModal;
           end;
    4000 : begin
             FConsultaProdutoNumeroSerie := TFConsultaProdutoNumeroSerie.CriarSDI(Application,'',true);
             FConsultaProdutoNumeroSerie.ShowModal;
             FConsultaProdutoNumeroSerie.Free;
           end;
    4200 : begin
             // ------ Movimento de entrada de produtos ------ //
             FNovaNotaFiscaisFor := TFNovaNotaFiscaisFor.CriarSDI(Application,'',VerificaPermisao('FNovaNotaFiscaisFor'));
             FNovaNotaFiscaisFor.Cadastrar;
             FNovaNotaFiscaisFor.free;
           end;
    4300 : begin
             // ------ extorno de entrada de produtos ------ //
             FExtornoEntrada := TFExtornoEntrada.CriarSDI(Application,'',VerificaPermisao('FExtornoEntrada'));
             FExtornoEntrada.ShowModal;
           end;
    4500 : begin
             FAcertoEstoque := TFAcertoEstoque.Create(self);//riarSDI(Application,'',VerificaPermisao('FAcertoEstoque'));
             FAcertoEstoque.ShowModal;
           end;
    4510 : begin
             FAcertoEstoque := TFAcertoEstoque.Create(self);//riarSDI(Application,'',VerificaPermisao('FAcertoEstoque'));
             FAcertoEstoque.ReservaEstoque;
           end;
    4750 : begin
             FEstornoAcertoEstoque := TFEstornoAcertoEstoque.CriarSDI(Application,'',VerificaPermisao('FEstornoAcertoEstoque'));
             FEstornoAcertoEstoque.ShowModal;
           end;
    4800 : begin
             FCadastraEstoqueChapa := TFCadastraEstoqueChapa.criarSDI(self,'',true);
             FCadastraEstoqueChapa.CadastraEstoqueChapa;
             FCadastraEstoqueChapa.Free;
           end;
    4910 : FPontoPedido := TFPontoPedido.CriarMDI( Application, varia.CT_AreaX, varia.CT_AreaY ,VerificaPermisao('FPontoPedido'));
    4920 : Begin
             FFechamentoEstoque := TFFechamentoEstoque.CriarSDI(Application,'',VerificaPermisao('FFechamentoEstoque'));
             FFechamentoEstoque.ShowModal;
           end;
    4930 :
           begin
             FInventario := TFInventario.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FInventario'));
             FInventario.ShowModal;
             FInventario.free;
           end;
    4940 :
           begin
             FReprocessaEstoque := TFReprocessaEstoque.CriarSDI(application , '', FPrincipal.VerificaPermisao('FReprocessaEstoque'));
             FReprocessaEstoque.Showmodal;
             FReprocessaEstoque.free;
           end;
    4950 :       
           begin
             VpfData := date;
             if EntraData('Reabrir Mês','Mes que deseja reabrir : ',VpfData) then
             begin
               FunProdutos.ReAbrirMes(VpfData);
               aviso('Mês reaberto com sucesso!!!');
             end;
           end;
    5100 : begin
             FEstoqueProdutos := TFEstoqueProdutos.CriarSDI(Application,'',VerificaPermisao('FEstoqueProdutos'));
             FEstoqueProdutos.ShowModal;
             FEstoqueProdutos.free;
           end;
    5200 : begin
             FEstoqueClassificacaoAtual := TFEstoqueClassificacaoAtual.CriarSDI(Application,'',VerificaPermisao('FEstoqueClassificacaoAtual'));
             FEstoqueClassificacaoAtual.ShowModal;
           end;
    5300 : begin
             FEstoqueProdutosAtual := TFEstoqueProdutosAtual.CriarSDI(Application,'',VerificaPermisao('FEstoqueProdutosAtual'));
             FEstoqueProdutosAtual.ShowModal;
           end;
    5400 : begin
             FDetalhesEstoque := TFDetalhesEstoque.CriarSDI(Application,'',VerificaPermisao('FDetalhesEstoque'));
             FDetalhesEstoque.MostraDetalhes('',IntToStr(varia. CodigoEmpFil),'PA', 'X');
           end;
    5500 : begin
             FEstoqueProdutosPreco := TFEstoqueProdutosPreco.CriarSDI(Application,'',VerificaPermisao('FEstoqueProdutosPreco'));
             FEstoqueProdutosPreco.ShowModal;
           end;

    6100 : begin
             FAlteraSenha := TFAlteraSenha.CriarSDI(Application,'',VerificaPermisao('FAlteraSenha'));
             FAlteraSenha.ShowModal;
           end;
    8100 : begin
             // ---- Coloca as janelas em cacatas ---- //
             Cascade;
           end;
    8200 : begin
             // ---- Coloca as janelas em lado a lado ---- //
             Tile;
           end;
    8300 : begin
             // ---- Coloca a janela em tamanho normal ---- //
             if FPrincipal.ActiveMDIChild is TFormulario then
             (FPrincipal.ActiveMDIChild as TFormulario).TamanhoPadrao;
           end;
    9100 : begin
             FSobre := TFSobre.CriarSDI(application,'', VerificaPermisao('FSobre'));
             FSobre.ShowModal;
           end;
    10100: begin
             if config.CadastroCadarco or config.CadastroEtiqueta then
             begin
               FNovaOrdemProducao := TFNovaOrdemProducao.CriarSDI(Application,'',VerificaPermisao('FNovaOrdemProducao'));
               FNovaOrdemProducao.NovaOrdem;
               FNovaOrdemProducao.free;
             end
             else
             begin
              FNovaOrdemProducaoGenerica := TFNovaOrdemProducaoGenerica.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaOrdemProducaoGenerica'));
              FNovaOrdemProducaoGenerica.NovaOrdemProducao;
              FNovaOrdemProducaoGenerica.free;
             end;
           end;
    10200: begin
             if config.CadastroCadarco then
             begin
               FOrdensProducaoCadarco := tFOrdensProducaoCadarco.CriarSDI(application,'', FPrincipal.VerificaPermisao('FOrdensProducaoCadarco'));
               FOrdensProducaoCadarco.ConsultaOrdensProducao;
               FOrdensProducaoCadarco.free;
             end
             else
               if config.CadastroEtiqueta then
               begin
                 FOrdemProducao := TFOrdemProducao.criarSDI(Application,'',verificaPermisao('FOrdemProducao'));
                 FOrdemProducao.ShowModal;
                 FOrdemProducao.free;
               end
               else
               begin
                 FOrdemProducaoGenerica := TFOrdemProducaoGenerica.CriarSDI(self,'',FPrincipal.VerificaPermisao('FOrdemProducaoGenerica'));
                 FOrdemProducaoGenerica.ShowModal;
                 FOrdemProducaoGenerica.free;
               end;
           end;
    10250: begin
             FConsultaLogSeparacaoConsumo := TFConsultaLogSeparacaoConsumo.CriarSDI(self,'',FPrincipal.VerificaPermisao('FConsultaLogSeparacaoConsumo'));
             FConsultaLogSeparacaoConsumo.ShowModal;
             FConsultaLogSeparacaoConsumo.free;
           end;
    10300: begin
             if config.CadastroEtiqueta then
             begin
               FNovaColetaOrdemProducao := TFNovaColetaOrdemProducao.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaColetaOrdemProducao'));
               FNovaColetaOrdemProducao.NovaColeta;
               FNovaColetaOrdemProducao.free;
             end
             else
             begin
               FColetaFracaoOP := TFColetaFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FColetaFracaoOP'));
               FColetaFracaoOP.ShowModal;
               FColetaFracaoOP.free;
             end;
           end;
    10400: begin
             FAdicionaColetaOPRomaneio := TFAdicionaColetaOPRomaneio.CriarSDI(application , '', FPrincipal.VerificaPermisao('FAdicionaColetaOPRomaneio'));
             FAdicionaColetaOPRomaneio.showmodal;
             FAdicionaColetaOPRomaneio.free;
           end;
    10500: begin
             if config.CadastroEtiqueta then
             begin
               FRomaneios := TFRomaneios.CriarSDI(application , '', FPrincipal.VerificaPermisao('FRomaneios'));
               FRomaneios.Showmodal;
               FRomaneios.free;
             end
             else
             begin
               FRomaneioGenerico := TFRomaneioGenerico.CriarSDI(self,'',FPrincipal.VerificaPermisao('FRomaneioGenerico'));
               FRomaneioGenerico.ShowModal;
               FRomaneioGenerico.free;
             end;
           end;
    10600: begin
             FRevisaoExterna := TFRevisaoExterna.CriarSDI(application , '', FPrincipal.VerificaPermisao('FRevisaoExterna'));
             FRevisaoExterna.ShowModal;
             FRevisaoExterna.free;
           end;
    10700: begin
             FProcessaProdutividade := TFProcessaProdutividade.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProcessaProdutividade'));
             FProcessaProdutividade.ShowModal;
             FProcessaProdutividade.free;
           end;
    10800: begin
             FNovaColetaRomaneio := TFNovaColetaRomaneio.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaColetaRomaneio'));
             FNovaColetaRomaneio.NovaColeta;
             FNovaColetaRomaneio.free;
           end;
    10850: begin
             FBaixaOrdemCorte := TFBaixaOrdemCorte.CriarSDI(self,'',true);
             FBaixaOrdemCorte.BaixaOrdemCorte;
             FBaixaOrdemCorte.free;
           end;
    10900: begin
             FImpEtiquetaTermicaProduto := TFImpEtiquetaTermicaProduto.CriarSDI(self,'',FPrincipal.VerificaPermisao('FImpEtiquetaTermicaProduto'));
             FImpEtiquetaTermicaProduto.ShowModal;
             FImpEtiquetaTermicaProduto.free;
           end;
    12100: begin
             FAtualizaPrecoFarmacia := TFAtualizaPrecoFarmacia.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAtualizaPrecoFarmacia'));
             FAtualizaPrecoFarmacia.ShowModal;
             FAtualizaPrecoFarmacia.free;
           end;
    12200: begin
             FImportaProdutosSolidWork := TFImportaProdutosSolidWork.CriarSDI(self,'',FPrincipal.VerificaPermisao('FImportaProdutosSolidWork'));
             FImportaProdutosSolidWork.ShowModal;
             FImportaProdutosSolidWork.free;
           end;
    12300: begin
             FExcluiProdutoDuplicado := TFExcluiProdutoDuplicado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FExcluiProdutoDuplicado'));
             FExcluiProdutoDuplicado.ShowModal;
             FExcluiProdutoDuplicado.free;
           end;
    12400: begin
             VpfResultado := FunProdutos.GeraCodigosBArras;
             if VpfResultado <> '' then
               aviso(VpfResultado);
           end;
    12500: begin
             FunProdutos.ConverteNomesProdutosSemAcento;
             aviso('Conversão do produto realizada com sucesso.');
           end;
    12600: begin
             FImprimeEtiquetaPrateleira := TFImprimeEtiquetaPrateleira.criarSDI(self,'',true);
             FImprimeEtiquetaPrateleira.ShowModal;
             FImprimeEtiquetaPrateleira.free;
           end;
    12700: begin
              ExecutaArquivoEXE('AtualizaModulos.exe',1);
           end;
    13100: begin
             FNovaFracaoFaccionista := TFNovaFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaFracaoFaccionista'));
             FNovaFracaoFaccionista.NovaFracaoFaccionista;
             FNovaFracaoFaccionista.free;
           end;
    13200: begin
             FFracaoFaccionista := TFFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFracaoFaccionista'));
             FFracaoFaccionista.ShowModal;
             FFracaoFaccionista.free;
           end;
    13300: begin
             FNovaFracaoFaccionista := TFNovaFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaFracaoFaccionista'));
             FNovaFracaoFaccionista.RetornoFracaoFaccionista;
             FNovaFracaoFaccionista.free;
           end;
    13400: begin
             FRetornoFracaoFaccionista := TFRetornoFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FRetornoFracaoFaccionista'));
             FRetornoFracaoFaccionista.ShowModal;
             FRetornoFracaoFaccionista.free;
           end;
    13500: begin
             FNovaFracaoFaccionista := TFNovaFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaFracaoFaccionista'));
             FNovaFracaoFaccionista.DevolucaoFracaoFaccionista;
             FNovaFracaoFaccionista.free;
           end;
    13600 :begin
             FDevolucaoFracaoFaccionista := TFDevolucaoFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FDevolucaoFracaoFaccionista'));
             FDevolucaoFracaoFaccionista.ShowModal;
             FDevolucaoFracaoFaccionista.free;
           end;
    13700: begin
             FNovoTelemarketingFaccionista := TFNovoTelemarketingFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoTelemarketingFaccionista'));
             FNovoTelemarketingFaccionista.NovoTelemarketing;
             FNovoTelemarketingFaccionista.free;
           end;
    13800: begin
             FTelemarketingFaccionista := TFTelemarketingFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTelemarketingFaccionista'));
             FTelemarketingFaccionista.ShowModal;
             FTelemarketingFaccionista.free;
           end;
    14050: begin
             FCartuchos:= TFCartuchos.CriarSDI(Application,'',True);
             FCartuchos.ShowModal;
             FCartuchos.Free;
           end;
    14100: begin
             FPesarCartucho := TFPesarCartucho.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPesarCartucho'));
             FPesarCartucho.ShowModal;
             FPesarCartucho.free;
           end;
    15100: begin
             FNovoPedidoCompra := TFNovoPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoPedidoCompra'));
             FNovoPedidoCompra.NovoPedido;
             FNovoPedidoCompra.free;
           end;
    15200: begin
             FPedidoCompra := TFPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPedidoCompra'));
             FPedidoCompra.ShowModal;
             FPedidoCompra.free;
           end;
    15300: begin
             FAlteraEstagioPedidoCompra := TFAlteraEstagioPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao(''));
             FAlteraEstagioPedidoCompra.AlteraEstagio;
             FAlteraEstagioPedidoCompra.free;
           end;
    15400: begin
             FEmailCobrancaPedidoCompra := TFEmailCobrancaPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FEmailCobrancaPedidoCompra'));
             FEmailCobrancaPedidoCompra.ShowModal;
             FEmailCobrancaPedidoCompra.free;
           end;
    16100: begin
             FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
             FNovaSolicitacaoCompras.NovoOrcamento;
             FNovaSolicitacaoCompras.free;
           end;
    16200: begin
             FSolicitacaoCompra := TFSolicitacaoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FOrcamentoCompra'));
             FSolicitacaoCompra.ShowModal;
             FSolicitacaoCompra.free;
           end;
    16300: begin
             FAlteraEstagioOrcamentoCompra := TFAlteraEstagioOrcamentoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraEstagioOrcamentoCompra'));
             FAlteraEstagioOrcamentoCompra.AlteraEstagio;
             FAlteraEstagioOrcamentoCompra.free;
           end;
    17100: begin
             FNovoPlanoCorte := TFNovoPlanoCorte.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoPlanoCorte'));
             FNovoPlanoCorte.NovoPlanoCorte;
             FNovoPlanoCorte.free;
           end;
    17200 :begin
             FPlanoCorte := TFPlanoCorte.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPlanoCorte'));
             FPlanoCorte.ShowModal;
             FPlanoCorte.free;
           end;
    18100 :begin
             FNovoOrcamentoCompra := TFNovoOrcamentoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompra'));
             FNovoOrcamentoCompra.NovoOrcamento;
             FNovoOrcamentoCompra.free;
           end;
    18200 :begin
             FOrcamentoCompras := TFOrcamentoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FOrcamentoCompras'));
             FOrcamentoCompras.ShowModal;
             FOrcamentoCompras.free;
           end;
    19100 : begin
             FDesenhosPendentes := TFDesenhosPendentes.CriarSDI(self,'',FPrincipal.VerificaPermisao('FDesenhosPendentes'));
             FDesenhosPendentes.ShowModal;
             FDesenhosPendentes.free;
           end;
    19200 : begin
             FFichaTecnicaPendente := TFFichaTecnicaPendente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFichaTecnicaPendente'));
             FFichaTecnicaPendente.ShowModal;
             FFichaTecnicaPendente.free;
            end;
    19300 : begin
              FAmostrasPendentes := TFAmostrasPendentes.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAmostrasPendentes'));
              FAmostrasPendentes.ShowModal;
              FAmostrasPendentes.free;
            end;
    19400 : begin
             FPrecoPendente := TFPrecoPendente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPrecoPendente'));
             FPrecoPendente.ShowModal;
             FPrecoPendente.free;
            end;
    19500 : begin
             FPendenciasCompras := TFPendenciasCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPendenciasCompras'));
             FPendenciasCompras.ShowModal;
             FPendenciasCompras.free;
            end;
    19600 : begin
              FOrdemCortePendente := TFOrdemCortePendente.CriarSDI(self,'',true);
              FOrdemCortePendente.showmodal;
              FOrdemCortePendente.free;
            end;
    19700 : begin
              FFichaAmostrasPendentes := TFFichaAmostrasPendentes.CriarSDI(self,'',true);
              FFichaAmostrasPendentes.ShowModal;
              FFichaAmostrasPendentes.Free;
            end;
    20100 : begin
             FAgendamentos := TFAgendamentos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendamentos'));
             FAgendamentos.agenda;
             FAgendamentos.free;
            end;
  end;
end;

{******************* configura os modulos do sistema ************************* }
procedure TFPrincipal.ConfiguracaoModulos;
var
  Reg : TRegistro;
begin
  ConfiguraPermissaoUsuario;
  Reg := TRegistro.create;
  reg.ValidaModulo( TipoSistema, [MProdutos, MEstoque, MServicos] );
  reg.ConfiguraModulo(CT_ESTOQUE, [ Mestoque, MAvaliaodeEstoque, BMFEntradaMercadoria,
                                   BMFEstornoEntrada, BMFEstoqueAtual, BMFEstoqueProdutos, BMFMovimentosEstoque ] );
//  reg.ConfiguraModulo(CT_CUSTO, [ MCusto ] );
  reg.ConfiguraModulo(CT_SERVICO, [ MServicos ] );
  reg.ConfiguraModulo(CT_PRODUTO, [ MProdutos, BMFProdutos, BMFConsultaProduto ]);
  reg.configuramodulo(CT_FACCIONISTA,[MFaccionista,MFaccionistas]);
  reg.Free;
end;

{******************************************************************************}
procedure TFPrincipal.CortePendente1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFPrincipal.ndice1Click(Sender: TObject);
begin
   Application.HelpCommand(HELP_KEY,0);
end;

{******************************************************************************}
procedure TFPrincipal.GeraEstoque1Click(Sender: TObject);
{var
  VpfSeqEstoqueBarra : Integer;}
begin
{  AdicionaSQLAbreTabela(MovNota,'Select MOV.I_SEQ_PRO, CAD.I_COD_OPE, MOV.I_SEQ_NOT, '+
                                ' CAD.I_NRO_NOT, CAD.D_DAT_EMI, MOV.N_QTD_PRO, MOV.I_COD_COR,'+
                                ' MOV.N_TOT_PRO, MOV.C_COD_UNI, MOV.I_COD_TAMA '+
                                ' FROM CADNOTAFISCAISFOR CAD, MOVNOTASFISCAISFOR MOV '+
                                ' WHERE CAD.I_EMP_FIL = 11 ' +
                                ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT ');
  FunProdutos := TFuncoesProduto.criar(SELF,BaseDados);
  While not MovNota.eof do
  begin
    FunProdutos.BaixaProdutoEstoque(varia.CodigoEmpfil,
                                    MovNota.FieldByname('I_SEQ_PRO').AsInteger,
                                    MovNota.FieldByname('I_COD_OPE').AsInteger,
                                    MovNota.FieldByname('I_SEQ_NOT').AsInteger,
                                    MovNota.FieldByname('I_NRO_NOT').AsInteger,
                                    0,
                                    varia.MoedaBase,
                                    MovNota.FieldByname('I_COD_COR').AsInteger,
                                    MovNota.FieldByname('I_COD_TAM').AsInteger,
                                    MovNota.FieldByname('D_DAT_EMI').AsDateTime,
                                    MovNota.FieldByname('N_QTD_PRO').AsFloat,
                                    MovNota.FieldByname('N_TOT_PRO').AsFloat,
                                    MovNota.FieldByname('C_COD_UNI').AsString,
                                    'pc','',true,VpfSeqEstoqueBarra);
    movnota.next;
  end;}
end;

{******************************************************************************}
procedure TFPrincipal.Timer1Timer(Sender: TObject);
begin
  Sistema.SalvaTabelasAbertas;
end;

procedure TFPrincipal.ToolBar1Click(Sender: TObject);
begin

end;

{******************************************************************************}
end.
