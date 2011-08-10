unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, Tabela, Localizacao, UnImpressaoRelatorio, UnECF,
  Mask, UnPrincipal, jpeg, LabelCorMove,numericos, unSistema, UnProdutos, UnContasAReceber, UnCotacao,Clipbrd,
  UnDadosCR, UnDadosProduto, unVersoes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP, WideStrings, DBXOracle, SqlExpr, DBClient, FMTBcd, unNfe, CBancoDados, UnDados;

const
  CampoPermissaoModulo = 'c_mod_pon';
  CampoFormModulos = 'c_mod_pon';
  NomeModulo = 'Ponto de Venda';

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
    N6: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    BCascata: TSpeedButton;
    BLadoaLado: TSpeedButton;
    BNormal: TSpeedButton;
    MCadastros: TMenuItem;
    N2: TMenuItem;
    MFCadPaises: TMenuItem;
    MFCadEstados: TMenuItem;
    MFCidades: TMenuItem;
    MFEventos: TMenuItem;
    MFProfissoes: TMenuItem;
    MFSituacoesClientes: TMenuItem;
    MFClientes: TMenuItem;
    N4: TMenuItem;
    MCotacao: TMenuItem;
    MFConsultaPrecosProdutos: TMenuItem;
    MFVendedores: TMenuItem;
    MFCondicoesPagamentos: TMenuItem;
    MFCotacao: TMenuItem;
    MFNovaCotacao: TMenuItem;
    N3: TMenuItem;
    MProdutos: TMenuItem;
    MFProdutos: TMenuItem;
    MFAdicionaProdFilial: TMenuItem;
    MFTabelaPreco: TMenuItem;
    MFFormacaoPreco: TMenuItem;
    MServico: TMenuItem;
    MFServicos: TMenuItem;
    MFFormacaoPrecoServico: TMenuItem;
    MFlocalizaServico: TMenuItem;
    MFaturamento: TMenuItem;
    MFNovaNotaFiscal: TMenuItem;
    MFVendaECF: TMenuItem;
    N5: TMenuItem;
    MImpDocumentos: TMenuItem;
    Manual1: TMenuItem;
    MFMostraEnvelope: TMenuItem;
    MFMostraRecibo: TMenuItem;
    MFMostraBoleto: TMenuItem;
    MFMostraduplicata: TMenuItem;
    MFImprimeBoleto: TMenuItem;
    MFNaturezas: TMenuItem;
    MFFormasPagamento: TMenuItem;
    BMFProdutos: TSpeedButton;
    BMFVendaECF: TSpeedButton;
    BMFClientes: TSpeedButton;
    BMFNovaNotaFiscal: TSpeedButton;
    BMFNovaCotacao: TSpeedButton;
    BSaida: TSpeedButton;
    BMFConsultaPrecosProdutos: TSpeedButton;
    MFBancos: TMenuItem;
    MVenda: TMenuItem;
    MFConsultaVendaPeriodo: TMenuItem;
    MFDocumentosRecebidos: TMenuItem;
    N8: TMenuItem;
    MFRegiaoVenda: TMenuItem;
    Ajuda1: TMenuItem;
    ndice1: TMenuItem;
    N9: TMenuItem;
    MFUnidades: TMenuItem;
    MFCadIcmsEstado: TMenuItem;
    Bloquear1: TMenuItem;
    N10: TMenuItem;
    MClientes: TMenuItem;
    N13: TMenuItem;
    ClienteseFornecedores1: TMenuItem;
    MFAniversariante: TMenuItem;
    N14: TMenuItem;
    MFEtiquetaClientes: TMenuItem;
    Cores1: TMenuItem;
    MRelatorios: TMenuItem;
    TipoCota1: TMenuItem;
    RamoAtividade1: TMenuItem;
    MFerramentas: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    Embalagem1: TMenuItem;
    ReferenciaCliente1: TMenuItem;
    GrficoProduo1: TMenuItem;
    IndicadoresdeDesempenho1: TMenuItem;
    Grficos1: TMenuItem;
    Relatrios1: TMenuItem;
    Cotaces1: TMenuItem;
    AnaliseCidade1: TMenuItem;
    AnaliseVendedor1: TMenuItem;
    Faturamento1: TMenuItem;
    FaturamentoXPedido1: TMenuItem;
    MetasVendedor1: TMenuItem;
    MetasVendedorXRealizado1: TMenuItem;
    N19: TMenuItem;
    AlterarClassificao1: TMenuItem;
    ExcluirClienteDuplicado1: TMenuItem;
    PedidosEmitidos1: TMenuItem;
    N20: TMenuItem;
    LeituraX1: TMenuItem;
    ReduoZ1: TMenuItem;
    N21: TMenuItem;
    MCancelarUltimoCupom: TMenuItem;
    N22: TMenuItem;
    MBaixaProdutosDevolvidos: TMenuItem;
    N23: TMenuItem;
    Tcnico1: TMenuItem;
    N24: TMenuItem;
    GerarNmeros1: TMenuItem;
    TipoContrato1: TMenuItem;
    FaturamentoMensal1: TMenuItem;
    PrincipioAtivo1: TMenuItem;
    N27: TMenuItem;
    MCampanhaVendas: TMenuItem;
    N28: TMenuItem;
    LeituraContratoLocao1: TMenuItem;
    MTeleMarketing: TMenuItem;
    EfetuarTeleMarketing1: TMenuItem;
    MHistoricoLigacoes: TMenuItem;
    N29: TMenuItem;
    AtualizaDiasTeleMarketing1: TMenuItem;
    N30: TMenuItem;
    MGerarTarefas: TMenuItem;
    MLocacaosemLeitura: TMenuItem;
    ProprietrioProduto1: TMenuItem;
    ReajusteContratos1: TMenuItem;
    TipoAgendamento1: TMenuItem;
    MManutencaoMailing: TMenuItem;
    MAgenda: TMenuItem;
    MAgendamentos: TMenuItem;
    N12: TMenuItem;
    SISTEMAOFFLINE: TMenuItem;
    Acondicionamento1: TMenuItem;
    N31: TMenuItem;
    MEstagioAgenda: TMenuItem;
    N26: TMenuItem;
    Facas1: TMenuItem;
    N32: TMenuItem;
    Valorestoque1: TMenuItem;
    MAssociarCartuchoCotacao: TMenuItem;
    MOrcamentoGrafica: TMenuItem;
    N25: TMenuItem;
    MMedico: TMenuItem;
    N33: TMenuItem;
    XMLSNGPC1: TMenuItem;
    Faturamento2: TMenuItem;
    BMFCotacoes: TSpeedButton;
    EMarketing1: TMenuItem;
    GerarTarefas1: TMenuItem;
    Tamanhos1: TMenuItem;
    N34: TMenuItem;
    MProdutoEtiquetadoComPedido: TMenuItem;
    Timer1: TTimer;
    N35: TMenuItem;
    GerarComissoesNotas1: TMenuItem;
    N37: TMenuItem;
    Manutenoemail1: TMenuItem;
    N36: TMenuItem;
    ClientesPerdidosVendedor1: TMenuItem;
    BitBtn2: TBitBtn;
    N38: TMenuItem;
    VerificaemailDuplicado1: TMenuItem;
    Duplicata1: TMenuItem;
    FaixaEtria1: TMenuItem;
    Marcas1: TMenuItem;
    EntradaMetros1: TMenuItem;
    N15: TMenuItem;
    ConsultaProdutosCliente1: TMenuItem;
    ComparativoAnoCliente1: TMenuItem;
    N39: TMenuItem;
    MRepresentada: TMenuItem;
    NmeroSrieCupom1: TMenuItem;
    DataSource1: TDataSource;
    N40: TMenuItem;
    ImportaProdutoMetalVidros1: TMenuItem;
    Aux: TRBSQL;
    PerfilCliente1: TMenuItem;
    N41: TMenuItem;
    MProjeto: TMenuItem;
    abelaComissao1: TMenuItem;
    N7: TMenuItem;
    ImportaCodigoEANVH1: TMenuItem;
    OpenDialog1: TOpenDialog;
    N11: TMenuItem;
    MNovoRomaneio: TMenuItem;
    MConsultaRomaneio: TMenuItem;
    ORACLECONNECTION: TSQLConnection;
    N42: TMenuItem;
    AlterarVendedorCadastroCliente1: TMenuItem;
    Cliente: TRBSQL;
    Cliente1: TRBSQL;
    BitBtn1: TBitBtn;
    MAtualizaModulos: TMenuItem;
    N43: TMenuItem;
    BRegeraComissao: TBitBtn;
    N44: TMenuItem;
    MRoteiroEntrega: TMenuItem;
    N45: TMenuItem;
    ConsultaProdutosNumerodeSerie1: TMenuItem;
    ReciboLocao1: TMenuItem;
    BitBtn3: TBitBtn;
    N46: TMenuItem;
    GeraArquivoURA1: TMenuItem;
    N47: TMenuItem;
    N48: TMenuItem;
    AlteraClientesVendedor1: TMenuItem;
    BitBtn4: TBitBtn;
    AuxEfi: TRBSQL;
    BitBtn5: TBitBtn;
    N49: TMenuItem;
    Nova1: TMenuItem;
    BaseDados: TSQLConnection;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Janete: TSQLConnection;
    BDJanete: TRBSQL;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Ajuda1Click(Sender: TObject);
    procedure ndice1Click(Sender: TObject);
    procedure Valorestoque1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure GerarComissoesNotas1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SISTEMAOFFLINEClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BRegeraComissaoClick(Sender: TObject);
    procedure MFaturamentoClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    TipoSistema : string;
    UnPri : TFuncoesPrincipal;
    FunImpressaoRel: TImpressaoRelatorio;
    FunEcf : TRBFuncoesECF;
    procedure MostraLeituraPendentes;
    procedure ConfiguraPermissaoUsuario;
    procedure ExcluiClientesDuplicados;
  public
     VersaoSistema : Integer;
     function AbreBaseDados( VpaAlias : string ) : Boolean;
     procedure AlteraNomeEmpresa;
     Function  VerificaPermisao( nome : string ) : Boolean;
     procedure erro(Sender: TObject; E: Exception);
     procedure abre(var Msg: TMsg; var Handled: Boolean);
     procedure VerificaMoeda;
     procedure ValidaBotoesGrupos( botoes : array of TComponent);
     procedure TeclaPressionada(var Msg: TWMKey; var Handled: Boolean);
     procedure ConfiguracaoModulos;
     procedure ConfiguraFilial;
     procedure OrganizaBotoes;
  end;


var
  FPrincipal: TFPrincipal;
  Ini : TInifile;

implementation

uses Constantes, UnRegistro, funsql,FunSistema, UnClientes,
     Abertura, AAlterarSenha, ASobre, FunIni, AAlterarFilialUso,
      AProfissoes, ASituacoesClientes, FunData, FunString,
     AClientes, ACadPaises, ACadEstados, ACadCidades,
     AEventos,   Registry,
        AConsultaPrecosProdutos,
  AVendedores, ALocalizaProdutos, ACotacao,
  AProdutos, AAdicionaProdFilial, ATabelaPreco, AFormacaoPreco, AServicos,
  AFormacaoPrecoServico, ALocalizaServico,
  AImprimeBoleto, AMostraDuplicata,
  AMostraBoleto,
  AMostraRecibo, AMostraEnvelope,  ANaturezas,
  AFormasPagamento, AImprimeDuplicata,
   ABancos,
  AConsultaVendaPeriodo,
  ARegiaoVenda,
  AUnidade, ACadIcmsEstado,
  AEtiquetaCliente, ACores, ANovaCotacao,
  ATipoCotacao,  ARamoAtividade, AEmbalagem,
  AProdutoReferencia, AGraficoProducaoAnual, UnNotaFiscal,
  AGraficoAnaliseCidade, AGraficoAnaliseFaturamento, ANovaNotaFiscalNota,
  UnContasAPagar, AAlteraClassificacaoProduto, AExcluiClienteDuplicado,
  ANovoECF, AMostraPlanenamentoOP, AAlteraEstagioCotacao,
  ADevolucaoProdutos, ATecnicos, AFaturamentoDiario, AGeraNumerosModulo19,
  ATipoContrato, AFaturamentoMensal, APrincipioAtivo, ACampanhaVendas,
  ALeiturasLocacao, ANovoTeleMarketing, ATeleMarketings,
  AAtualizaDiasTeleMarketing, ATarefas, AContratosSemLeitura, ADonoProduto,
  AReajusteContrato, ATipoAgendamento, AManutencaoMailing, AAgendamentos,
  AAcondicionamento, AEstagioAgendamento, AFacas, AMostraLocacoesALer,
  ACartuchoCotacao, ANovaCotacaoGrafica, AMedico, AGeraXMLSNGCP,
  ATarefaEMarketing, ATamanhos, AProdutoEtiquetadoComEstoque,
  AAniversariantes, ANovoLembrete, AManutencaoEmail,
  AClientesPerdidosVendedor, UnZebra, ADesativaEmailDuplicado, AFaixaEtaria,
  AMarcas, AEntradaMetro, Unprospect, UnCaixa, AConsultaProdutoNumeroSerie,
  ACondicaoPagamento, UnOrdemProducao, AGraficoComprativoAno, ARepresentada, AImportaProdutosMetalVidros,
  APerfilCliente, AGeraCodigoOffline, AProjetos, ATabelaComissao, ANovoRomaneioOrcamento, ARomaneioOrcamento,
  AAlteraVendedorCadastroCliente, FunArquivos, ARoteiroEntrega,
  AReciboLocacao, AAlteraClienteVendedor;



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
  Varia := TVariaveis.Cria(BaseDados);   // classe das variaveis principais
  Config := TConfig.Create;     // Classe das variaveis Booleanas
  ConfigModulos := TConfigModulo.create; // classe das variaveis de configuracao do modulo.
  FunImpressaoRel := TImpressaoRelatorio.Cria(baseDados);
  Application.OnHint := MostraHint;
  Application.HintColor := $00EDEB9E;        // cor padrão dos hints
  Application.Title := 'Ponto de Venda';  // nome a ser mostrado na barra de tarefa do Windows
  Application.OnException := Erro;
  Application.OnMessage := Abre;
  Application.OnShortCut := TeclaPressionada;
  varia.VersaoSistema := VersaoPontoLoja;
  Sistema := TRBFuncoesSistema.cria(BaseDados);
end;

{******************************************************************************}
procedure TFPrincipal.MostraLeituraPendentes;
begin
  if config.ResponsavelLeituraLocacao then
  begin
    FMostraLocacoesALer := TFMostraLocacoesALer.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMostraLocacoesALer'));
    FMostraLocacoesALer.MostraLeiturasPendentes;
    FMostraLocacoesALer.free;
  end;
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraPermissaoUsuario;
begin
  Varia.EscondeMenus(Menu,false);
  AlterarVisibleDet([BMFClientes,BMFProdutos,BMFVendaECF,BMFConsultaPrecosProdutos,BMFNovaNotaFiscal,BMFNovaCotacao,BMFCotacoes],false);

   AlterarVisibleDet([MRelatorios,MFerramentas,MAtualizaModulos],true);
   FunImpressaoRel.CarregarMenuRel(mrPontoLoja,MRelatorios);

  if (puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario) then
  begin
    varia.EscondeMenus(Menu,true);
//    FunImpressaoRel.CarregarMenuRel(mrPontoLoja,MRelatorios);
    AlterarVisibleDet([BMFClientes,BMFProdutos,BMFVendaECF,BMFConsultaPrecosProdutos,BMFNovaNotaFiscal,BMFNovaCotacao,BMFCotacoes],true);
  end
  else
  begin
    if (puPLImprimePedPendentes in varia.PermissoesUsuario) then
      AlterarVisibleDet([MCotacao,MFCotacao,MProdutoEtiquetadoComPedido],true);
    if (puConsultarCliente in varia.PermissoesUsuario) then
      AlterarVisibleDet([BMFClientes,MClientes,MFClientes,MBaixaProdutosDevolvidos,EfetuarTeleMarketing1,MAssociarCartuchoCotacao],true);
    if (puClienteCompleto in varia.PermissoesUsuario) then
      AlterarVisibleDet([N13,MFAniversariante,MFEtiquetaClientes,N14,MFProfissoes,MFEventos,MFRegiaoVenda,MFSituacoesClientes,MCadastros,MFNaturezas,n4,TipoCota1,MFerramentas,ExcluirClienteDuplicado1],true);
    if (puProdutoCompleto in varia.PermissoesUsuario) then
      AlterarVisibleDet([MFProdutos,n16,MFAdicionaProdFilial,N17,MFTabelaPreco,MFFormacaoPreco,n18,
                         ReferenciaCliente1,N19,AlterarClassificao1],true);
    if (puServicoCompleto in varia.PermissoesUsuario) then
      AlterarVisibleDet([MServico,MFServicos,MFFormacaoPrecoServico],true);
    if (puImpressao in varia.PermissoesUsuario) then
      AlterarVisibleDet([MImpDocumentos,MFImprimeBoleto,Manual1,MFMostraEnvelope,
                         MFMostraRecibo,MFMostraBoleto,MFMostraduplicata],true);
    if (puManutencaoProdutos in varia.PermissoesUsuario) then
      AlterarVisibleDet([BMFProdutos,MFProdutos,MProdutos],true);
    if (puPLCadastraCotacao in varia.PermissoesUsuario) then
      AlterarVisibleDet([MCotacao,MFCotacao,MFNovaCotacao,BMFNovaCotacao,BMFCotacoes,LeituraContratoLocao1,MOrcamentoGrafica],true);
    if (puPLConsultarCotacao in varia.PermissoesUsuario) or
       (puPLAlterarCotacao in varia.PermissoesUsuario) or
       (puImprimirPedido in varia.PermissoesUsuario) then
      AlterarVisibleDet([MCotacao,MFCotacao,BMFNovaCotacao],true);
    if (puPLGerarNota in varia.PermissoesUsuario) then
      AlterarVisibleDet([MFaturamento,BMFNovaNotaFiscal,MFNovaNotaFiscal,n24,MLocacaosemLeitura],true);
    if (puPLGerarCupom in varia.PermissoesUsuario) then
      AlterarVisibleDet([MFaturamento,MFVendaECF,BMFVendaECF,n8,n20,LeituraX1,ReduoZ1,MCancelarUltimoCupom,n21,FaturamentoMensal1,MFerramentas,
                         ExcluirClienteDuplicado1],true);
    if not(puRelatorios in varia.PermissoesUsuario) then
      AlterarVisibleDet([MRelatorios],false);
    if (puPLUsuarioTelemarketing in varia.PermissoesUsuario) then
      AlterarVisibleDet([MTeleMarketing,MHistoricoLigacoes,n30,MGerarTarefas,MManutencaoMailing,EfetuarTeleMarketing1, MAgenda,MEstagioAgenda,MAgendamentos],true);
    if (puPLSupervisorTelemarketing in varia.PermissoesUsuario) then
      AlterarVisibleDet([MTeleMarketing,MHistoricoLigacoes,MAgenda,MEstagioAgenda,MAgendamentos,MGerarTarefas,MManutencaoMailing],true);
    if (puPLCadastrarRomaneio in varia.PermissoesUsuario) then
      AlterarVisibleDet([MCotacao,MNovoRomaneio],true);
    if (puPLConsultarRomaneio in varia.PermissoesUsuario) then
      AlterarVisibleDet([MCotacao,MConsultaRomaneio],true);
    if (puPLRoteiroEntrega in varia.PermissoesUsuario) then
      AlterarVisibleDet([MRoteiroEntrega],true);

  end;
  if not config.Grafica then
    MOrcamentoGrafica.Visible := false;
  if MRepresentada.Visible then
     AlterarVisibleDet([MRepresentada,N39] ,config.RepresentanteComercial);


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

{******************************************************************************}
procedure TFPrincipal.erro(Sender: TObject; E: Exception);
begin
  Aviso(E.Message);
end;

{******************************************************************************}
procedure TFPrincipal.ExcluiClientesDuplicados;
var
  VpfClienteOriginal : Integer;
begin
  AdicionaSQLAbreTabela(Cliente,'select c_nom_cli, count(i_cod_cli), c_end_cli from cadclientes '+
                            ' group by c_nom_cli, c_end_cli '+
                            ' having count(i_cod_cli) > 1');
  while not Cliente.Eof do
  begin
    BarraStatus.Panels[0].Text := Cliente.FieldByName('C_NOM_CLI').AsString;
    AdicionaSQLAbreTabela(Cliente1,'Select * from CADCLIENTES ' +
                                   ' WHERE C_NOM_CLI = '''+Cliente.FieldByName('C_NOM_CLI').AsString+''''+
                                   ' AND C_END_CLI  is null');
    VpfClienteOriginal := Cliente1.FieldByName('I_COD_CLI').AsInteger;
    Cliente1.Next;
    while not Cliente1.Eof do
    begin
      try
        ExecutaComandoSql(Aux,'DELETE FROM cadclientes  ' +
                              ' Where I_COD_CLI = '+Cliente1.FieldByName('I_COD_CLI').AsString);
      except
        FunClientes.ExcluiCliente(Cliente1.FieldByName('I_COD_CLI').AsInteger,VpfClienteOriginal,BarraStatus);
      end;
      cliente1.Next;
    end;

    Cliente.Next;
  end;
end;

// ------------------- Quando o formulario e fechado -------------------------- }
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UnPri.free;
{  Varia.Free;
  Config.Free;
  FunImpressaoRel.Free;
  Sistema.free;
  FunProdutos.free;
  FunContasAPagar.Free;
//  FunCotacao.free;
  FunClientes.free;
  FunProspect.free;
//  FunECF.free;
//  BaseDados.close;}
  Action := CaFree;
end;

// -------------------- Quando o Formulario é Iniciado ------------------------ }
procedure TFPrincipal.FormShow(Sender: TObject);
begin
  FunProdutos := TFuncoesProduto.criar(self,BaseDados);
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(Basedados);
  FunNotaFiscal := TFuncoesNotaFiscal.criar(self,BaseDados);
  FunContasAPagar := TFuncoesContasAPagar.criar(self,BaseDados);
  FunContasAReceber := TFuncoesContasAreceber.Cria(BaseDados);
  FunCaixa := TRBFuncoesCaixa.Cria(BaseDados);
  FunCotacao := TFuncoesCotacao.Cria(BaseDados);
  FunClientes := TRBFuncoesClientes.cria(BaseDados);
  FunProspect := TRBFuncoesProspect.cria(baseDados);
  FunEcf := TRBFuncoesECF.cria(BarraStatus,BaseDados);
 // configuracoes do usuario
  UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
 // configura modulos
  ConfiguracaoModulos;
  AlteraNomeEmpresa;
  FPrincipal.WindowState := wsMaximized;  // coloca a janela maximizada;
 // conforme usuario, configura menu
  OrganizaBotoes;
  MostraLeituraPendentes;

end;

{****************** organiza os botoes do formulario ************************ }
procedure TFPrincipal.OrganizaBotoes;
begin
 UnPri.OrganizaBotoes(0, [ BCascata, BLadoaLado, BNormal, BMFClientes, BMFProdutos,
                           BMFConsultaPrecosProdutos, BMFNovaNotaFiscal, BMFVendaECF,
                           BMFNovaCotacao,BMFCotacoes,  Bsaida]);
end;

procedure TFPrincipal.SISTEMAOFFLINEClick(Sender: TObject);
begin

end;

// -------------------- Altera o Caption da Jabela Proncipal ------------------ }
procedure TFPrincipal.AlteraNomeEmpresa;
begin
  UnPri.AlteraNomeEmpresa(self, BarraStatus, NomeModulo, TipoSistema );
end;


{******************************************************************************}
procedure TFPrincipal.TeclaPressionada(var Msg: TWMKey; var Handled: Boolean);
begin
    case Msg.CharCode  of
      116 :
       begin
         FunEcf.AbreGaveta;
       end;
      117 :
       begin
         Sistema.SalvaTabelasAbertas;
       end;
      118 :
       if not VerificaFormCriado('TFDevolucaoProdutos') then
       begin
         FDevolucaoProdutos := TFDevolucaoProdutos.CriarSDI(application,'', FPrincipal.VerificaPermisao('TFDevolucaoProdutos'));
         FDevolucaoProdutos.Showmodal;
         FDevolucaoProdutos.free;
       end;
      119 :
       if not VerificaFormCriado('TFAlteraEstagioCotacao')and not VerificaFormCriado('TFCotacao') then
       begin
         FAlteraEstagioCotacao := TFAlteraEstagioCotacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FAlteraEstagioCotacao'));
         FAlteraEstagioCotacao.AlteraEstagio;
         FAlteraEstagioCotacao.free;
       end;
      120 :
       begin
         FCartuchoCotacao := TFCartuchoCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCartuchoCotacao'));
         FCartuchoCotacao.AssociaCartuchoCotacao;
         FCartuchoCotacao.free;
       end;
      121 :
          begin
            FConsultaProdutoNumeroSerie := TFConsultaProdutoNumeroSerie.CriarSDI(Application,'',true);
            FConsultaProdutoNumeroSerie.ShowModal;
            FConsultaProdutoNumeroSerie.Free;
          end;
      122 :
        if not VerificaFormCriado('TFlocalizaServico') then
        begin
          FlocalizaServico := TFlocalizaServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaServico'));
          FlocalizaServico.ConsultaServico;
          FlocalizaServico.free;
        end;
      123 :
       if not VerificaFormCriado('TFConsultaPrecosProdutos') then
       begin
         FConsultaPrecosProdutos := TFConsultaPrecosProdutos.criarSDI(Application,'',FPrincipal.VerificaPermisao('FConsultaPrecosProdutos'));
         FConsultaPrecosProdutos.ShowModal;
         FConsultaPrecosProdutos.free;
       end;
    end;
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

{************************  M E N U   D O   S I S T E M A  ********************* }
procedure TFPrincipal.MenuClick(Sender: TObject);
begin
  if Sender is TComponent  then
  case ((Sender as TComponent).Tag) of
    1050 : begin
           FAlteraSenha := TFAlteraSenha.CriarSDI(Application,'',VerificaPermisao('FAlteraSenha'));
           FAlteraSenha.ShowModal;
         end;
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
               ConfiguracaoModulos;
               UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
               OrganizaBotoes;
             end
             else
               if  ((Sender as TComponent).Tag) = 1210 then
                 FPrincipal.close;
             end;
           // ----- Sair do Sistema ----- //
    1300 : Close;
    2100 : begin
             FCores := TFCores.CriarSDI(application, '', VerificaPermisao('FCores'));
             FCores.ShowModal;
             FCores.free;
           end;
    2500 : begin
             FEventos := TFEventos.CriarSDI(application, '', VerificaPermisao('FEventos'));
             FEventos.ShowModal;
           end;
    2550 : begin
             FUnidades := TFUnidades.CriarSDI(application, '',VerificaPermisao('FUnidades'));
             FUnidades.ShowModal;
           end;
    2600 : begin
             // ------- As profissões do Cliente ------- //
             FProfissoes := TFProfissoes.CriarSDI(application,'',VerificaPermisao('FProfissoes'));
             FProfissoes.ShowModal;
           end;
    2610 : begin
             FTipoCotacao := TFTipoCotacao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FTipoCotacao'));
             FTipoCotacao.ShowModal;
             FTipoCotacao.free;
           end;
    2620 : begin
             FTipoContrato := TFTipoContrato.Create(self);
             FTipoContrato.ShowModal;
             FTipoContrato.free;
           end;
    2650 : begin
             FCadIcmsEstado := TFCadIcmsEstado.CriarSDI(application, '',VerificaPermisao('FCadIcmsEstado'));
             FCadIcmsEstado.ShowModal;
           end;
    2700 : begin
             // ------ As Situções do Cliente ------- //
             FSituacoesClientes := TFSituacoesClientes.CriarSDI(Application,'',VerificaPermisao('FSituacoesClientes'));
             FSituacoesClientes.ShowModal;
           end;
           // ------- Cadastro de Clientes ------- //
    2750 : begin
             FClientes := TFClientes.criarSDI(application, '',VerificaPermisao('FClientes'));
             FClientes.ShowModal;
             FClientes.free;
           end;
    2755 : begin
             FClientesPerdidosVenedor := TFClientesPerdidosVenedor.CriarSDI(self,'',FPrincipal.VerificaPermisao('FClientesPerdidosVenedor'));
             FClientesPerdidosVenedor.ShowModal;
             FClientesPerdidosVenedor.free;
           end;
    2757 : begin
             FReciboLocacao := TFReciboLocacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FClientesPerdidosVenedor'));
             FReciboLocacao.ShowModal;
             FReciboLocacao.free;
           end;

    2758 : begin
             FFaixaEtaria := TFFaixaEtaria.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFaixaEtaria'));
             FFaixaEtaria.ShowModal;
             FFaixaEtaria.free;
           end;
    2759 : begin
             FMarca := TFMarca.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMarca'));
             FMarca.ShowModal;
             FMarca.free;
           end;
    2760 : begin
             FBancos := TFBancos.CriarSDI(application , '', VerificaPermisao('FBancos'));
             FBancos.ShowModal;
           end;
    2770 : begin
             FCampanhaVendas := TFCampanhaVendas.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCampanhaVendas'));
             FCampanhaVendas.ShowModal;
             FCampanhaVendas.free;
           end;
    2773 : begin
             FDonoProduto := tFDonoProduto.CriarSDI(self,'',FPrincipal.VerificaPermisao('FDonoProduto'));
             FDonoProduto.ShowModal;
             FDonoProduto.free;
           end;
    2777 : begin
             FTipoAgendamento := TFTipoAgendamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTipoAgendamento'));
             FTipoAgendamento.ShowModal;
             FTipoAgendamento.free;
           end;
    2780 : begin
             FNaturezas := TFNaturezas.CriarSDI(application, '',VerificaPermisao('FNaturezas'));
             FNaturezas.Showmodal;
             FNaturezas.free;
           end;
    2783 : begin
             FFormasPagamento := TFFormasPagamento.CriarSDI(application , '', VerificaPermisao('FFormasPagamento'));
             FFormasPagamento.ShowModal;
           end;
    2793 : Begin
             FRegiaoVenda := TFRegiaoVenda.criarSDI(Application,'',VerificaPermisao('FRegiaoVenda'));
             FRegiaoVenda.ShowModal;
           end;
    2795 : FVendedores := TFVendedores.criarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FVendedores'));
    2790 : begin
             FCondicaoPagamento := TFCondicaoPagamento.CriarSDI(self,'',true);
             FCondicaoPagamento.showmodal;
             FCondicaoPagamento.free;
           end;
    2800 : begin
             FRepresentada := TFRepresentada.CriarSDI(self,'',true);
             FRepresentada.ShowModal;
             FRepresentada.free;
           end;
    2850 : begin
             FAlteraClienteVendedor := TFAlteraClienteVendedor.CriarSDI(self,'',true);
             FAlteraClienteVendedor.ShowModal;
             FAlteraClienteVendedor.free;
           end;
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
    2930 : begin
             FRamoAtividade := TFRamoAtividade.criarSDI(Application,'',FPrincipal.VerificaPermisao('FRamoAtividade'));
             FRamoAtividade.ShowModal;
             FRamoAtividade.free;
           end;
    2940 : begin
             FPrincipioAtivo := TFPrincipioAtivo.CriarSDI(application,'', FPrincipal.VerificaPermisao('FPrincipioAtivo'));
             FPrincipioAtivo.ShowModal;
             FPrincipioAtivo.free;
           end;
    2945 : begin
             FMedico := TFMedico.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMedico'));
             FMedico.showmodal;
             FMedico.free;
           end;
    2950 : begin
             FTecnicos := TFTecnicos.CriarSDI(application,'', FPrincipal.VerificaPermisao('FTecnicos'));
             FTecnicos.ShowModal;
             FTecnicos.free;
           end;
    2955 : begin
             FTamanhos := TFTamanhos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTamanhos'));
             FTamanhos.ShowModal;
             FTamanhos.free;
           end;
    2960 : begin
             FEmbalagem := TFEmbalagem.CriarSDI(application , '', VerificaPermisao('FEmbalagem'));
             FEmbalagem.showmodal;
             FEmbalagem.free;
           end;
    2970 : begin
             FAcondicionamento := TFAcondicionamento.Create(application);
             FAcondicionamento.showmodal;
             FAcondicionamento.free;
           end;
    2975: begin
            FNovoLembrete:= TFNovoLembrete.CriarSDI(Application,'',True);
            FNovoLembrete.NovoLembrete;
            FNovoLembrete.Free;
          end;
    2980: begin
            FPerfilCliente:= TFPerfilCliente.CriarSDI(Application,'',True);
            FPerfilCliente.ShowModal;
            FPerfilCliente.Free;
          end;
    2990: begin
            FProjetos := TFProjetos.criarSDI(Application,'',FPrincipal.VerificaPermisao('FProjetos'));
            FProjetos.showmodal;
            FProjetos.free;
          end;

    3000: begin
            FTabelaComissao := TFTabelaComissao.criarSDI(Application,'',true);
            FTabelaComissao.showmodal;
            FTabelaComissao.free;
          end;

    3200 : FProdutos := TFProdutos.criarMDI(Application,Varia.CT_Areax,Varia.CT_AreaY,VerificaPermisao('FProdutos'));

    3400 : FAdicionaProdFilial := TFAdicionaProdFilial.criarMDI(Application, Varia.CT_areaX, Varia.CT_areaY, VerificaPermisao('FAdicionaProdFilial'));
    3500 :
          begin
             FFacas := TFFacas.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFacas'));
             FFacas.showmodal;
             FFacas.free;
           end;
    3600 : begin
             FTabelaPreco := TFTabelaPreco.CriarSDI(application, '',VerificaPermisao('FTabelaPreco'));
             FTabelaPreco.ShowModal;
           end;
    3800 : begin
            FFormacaoPreco := TFFormacaoPreco.CriarSDI(application, '',VerificaPermisao('FFormacaoPreco'));
            FFormacaoPreco.ShowModal;
           end;
    3930 : begin
             FAlteraClassificacaoProduto := TFAlteraClassificacaoProduto.CriarSDI(application , '', FPrincipal.VerificaPermisao('FAlteraClassificacaoProduto'));
             FAlteraClassificacaoProduto.ShowModal;
             FAlteraClassificacaoProduto.free;
           end;
    3950 : begin
             FReferenciaProduto := TFReferenciaProduto.CriarSDI(application , '', FPrincipal.VerificaPermisao('FReferenciaProduto'));
             FReferenciaProduto.ShowModal;
             FReferenciaProduto.free;
           end;
    4000 : begin
             FConsultaProdutoNumeroSerie := TFConsultaProdutoNumeroSerie.CriarSDI(Application,'',true);
             FConsultaProdutoNumeroSerie.ShowModal;
             FConsultaProdutoNumeroSerie.Free;
           end;

    4100 : begin
             FConsultaPrecosProdutos := TFConsultaPrecosProdutos.criarSDI(Application,'',VerificaPermisao('FConsultaPrecosProdutos'));
             FConsultaPrecosProdutos.ShowModal
           end;
    4200 : Begin
             FCotacao := TFCotacao.criarSDI(Application,'',VerificaPermisao('FCotacao'));
             FCotacao.ShowModal;
           end;
    4300 : begin
             FNovaCotacao := TFNovaCotacao.criarSDI(Application,'',VerificaPermisao('FNovaCotacao'));
             FNovaCotacao.NovaCotacao;
           end;
    4400 : begin
            FlocalizaServico := TFlocalizaServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaServico'));
            FlocalizaServico.ConsultaServico;
           end;
    4500 : begin
              FDevolucaoProdutos := TFDevolucaoProdutos.CriarSDI(application,'', FPrincipal.VerificaPermisao('TFDevolucaoProdutos'));
              FDevolucaoProdutos.Showmodal;
              FDevolucaoProdutos.free;
           end;
    4600 : begin
              FCartuchoCotacao := TFCartuchoCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCartuchoCotacao'));
              FCartuchoCotacao.AssociaCartuchoCotacao;
              FCartuchoCotacao.free;
           end;
    4700 : begin
             FNovaCotacaoGrafica := TFNovaCotacaoGrafica.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCotacaoGrafica'));
             FNovaCotacaoGrafica.NovaCotacao;
             FNovaCotacaoGrafica.free;
           end;
    4800 : begin
             FProdutoEtiquetadoComEstoque := TFProdutoEtiquetadoComEstoque.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProdutoEtiquetadoComEstoque'));
             FProdutoEtiquetadoComEstoque.ShowModal;
             FProdutoEtiquetadoComEstoque.free;
           end;
    4900 : begin
             FConsultaProdutoNumeroSerie := TFConsultaProdutoNumeroSerie.CriarSDI(Application,'',true);
             FConsultaProdutoNumeroSerie.showmodal;
             FConsultaProdutoNumeroSerie.free;
           end;
    4950 : begin
             FNovoRomaneioOrcamento := TFNovoRomaneioOrcamento.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoRomaneioOrcamento'));
             FNovoRomaneioOrcamento.NovoRomaneio;
             FNovoRomaneioOrcamento.free;
           end;
    4960 : begin
             FRomaneioOrcamento := TFRomaneioOrcamento.criarSDI(Application,'',FPrincipal.VerificaPermisao('FRomaneioOrcamento'));
             FRomaneioOrcamento.showmodal;
             FRomaneioOrcamento.free;
           end;
    5000 : begin
             FRoteiroEntrega := TFRoteiroEntrega.criarSDI(Application,'',FPrincipal.VerificaPermisao('FRomaneioOrcamento'));
             FRoteiroEntrega.showmodal;
             FRoteiroEntrega.free;
           end;
    5200 : FServicos := TFServicos.criarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FServicos'));
    5400 : begin
             FFormacaoPrecoServico := TFFormacaoPrecoServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FFormacaoPrecoServico'));
             FFormacaoPrecoServico.Showmodal;
           end;
    6100 : Begin
             FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(application, '',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
             FNovaNotaFiscalNota.NovaNotaFiscal;
             FNovaNotaFiscalNota.free;
           end;
    6200 : begin
             FNovoECF := TFNovoECF.CriarSDI(application,'', VerificaPermisao('FNovoECF'));
             FNovoECF.NovoECF;
             FNovoECF.free;
           end;
    6300 : funecf.LeituraX;
    6400 : FunEcf.ReducaoZ;
    6450 : aviso(FunEcf.RNumSerieECF);
    6500 : FunEcf.CancelaUltimoCupom;
    6700 : begin
             FFaturamentoMensal := TFFaturamentoMensal.CriarSDI(application,'', FPrincipal.VerificaPermisao('FFaturamentoMensal'));
             FFaturamentoMensal.ShowModal;
             FFaturamentoMensal.free;
           end;
    6800 : begin
             FLeiturasLocacao := TFLeiturasLocacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FLeiturasLocacao'));
             FLeiturasLocacao.ShowModal;
             FLeiturasLocacao.free;
           end;
    6900 : begin
             FContratosSemLeitura := tFContratosSemLeitura.CriarSDI(self,'',FPrincipal.VerificaPermisao('FContratosSemLeitura'));
             FContratosSemLeitura.ShowModal;
             FContratosSemLeitura.free;
           end;
    6950 : begin
             FReajusteContrato := TFReajusteContrato.CriarSDI(self,'',FPrincipal.VerificaPermisao('FReajusteContrato'));
             FReajusteContrato.ShowModal;
             FReajusteContrato.free;
           end;
    7200 : FImprimeDuplicata := TFImprimeDuplicata.CriarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FImprimeDuplicata'));
    7300 : FImprimeBoleto := TFImprimeBoleto.Create(Application);
    7510 : begin
             FMostraduplicata := TFMostraduplicata.CriarSDI(Application,'',VerificaPermisao('FMostraduplicata'));
             FMostraduplicata.ShowModal;
           end;
    7530 : begin
             FMostraBoleto := TFMostraBoleto.CriarSDI(Application,'',VerificaPermisao('FMostraBoleto'));
             FMostraBoleto.ShowModal;
           end;
    7560 : begin
             FMostraRecibo := TFMostraRecibo.CriarSDI(Application,'',VerificaPermisao('FMostraRecibo'));
             FMostraRecibo.ShowModal;
           end;
    7570 : begin
           FMostraEnvelope := TFMostraEnvelope.CriarSDI(Application,'',VerificaPermisao('FMostraEnvelope'));
           FMostraEnvelope.ShowModal;
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
    10100 :begin
             FTarefaEMarketing := TFTarefaEMarketing.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTarefaEMarketing'));
             FTarefaEMarketing.showmodal;
             FTarefaEMarketing.free;
           end;
    10200 :begin
             FManutencaoEmail := TFManutencaoEmail.CriarSDI(self,'',FPrincipal.VerificaPermisao('FManutencaoEmail'));
             FManutencaoEmail.ShowModal;
             FManutencaoEmail.free;
           end;
    10300 :begin
             FDesativaEmailDuplicado := TFDesativaEmailDuplicado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FDesativaEmailDuplicado'));
             FDesativaEmailDuplicado.ShowModal;
             FDesativaEmailDuplicado.free;
           end;
    11100 : FConsultaVendaPeriodo := TFConsultaVendaPeriodo.CriarMDI(application, Varia.CT_AreaX,Varia.CT_AreaY,FPrincipal.VerificaPermisao('FConsultaVendaPeriodo'));
    13111 : begin
             FGraficoAnaliseCidade := TFGraficoAnaliseCidade.CriarSDI(application , '', FPrincipal.VerificaPermisao('FGraficoAnaliseCidade'));
             FGraficoAnaliseCidade.GraficoCidade;
             FGraficoAnaliseCidade.free;
           end;
    13112  : begin
             FGraficoAnaliseCidade := TFGraficoAnaliseCidade.CriarSDI(application , '', FPrincipal.VerificaPermisao('FGraficoAnaliseCidade'));
             FGraficoAnaliseCidade.GraficoVendedor;
             FGraficoAnaliseCidade.free;
           end;
    13113  : begin
             FGraficoAnaliseFaturamento := TFGraficoAnaliseFaturamento.CriarSDI(application , '', FPrincipal.VerificaPermisao('FGraficoAnaliseFaturamento'));
             FGraficoAnaliseFaturamento.GraficoMetaVendedor;
             FGraficoAnaliseFaturamento.free;
           end;
    13114  : begin
             FGraficoAnaliseFaturamento := TFGraficoAnaliseFaturamento.CriarSDI(application , '', FPrincipal.VerificaPermisao('FGraficoAnaliseFaturamento'));
             FGraficoAnaliseFaturamento.GraficoMetaVendedorRealizado;
             FGraficoAnaliseFaturamento.free;
           end;
    13115  : begin
             FGraficoAnaliseFaturamento := TFGraficoAnaliseFaturamento.CriarSDI(application , '', FPrincipal.VerificaPermisao('FGraficoAnaliseFaturamento'));
             FGraficoAnaliseFaturamento.GraficoPedidos;
             FGraficoAnaliseFaturamento.free;
           end;
    13120  : begin
             FGraficoAnaliseFaturamento := TFGraficoAnaliseFaturamento.CriarSDI(application , '', FPrincipal.VerificaPermisao('FGraficoAnaliseFaturamento'));
             FGraficoAnaliseFaturamento.GraficoReceberPorEmissao;
             FGraficoAnaliseFaturamento.free;
             end;
    13121  : begin
             FGraficoAnaliseFaturamento := TFGraficoAnaliseFaturamento.CriarSDI(application , '', FPrincipal.VerificaPermisao('FGraficoAnaliseFaturamento'));
             FGraficoAnaliseFaturamento.GraficoFaturamento;
             FGraficoAnaliseFaturamento.free;
           end;
    13123  : begin
               FGraficoComparativoAno := TFGraficoComparativoAno.CriarSDI(application , '', FPrincipal.VerificaPermisao('FGraficoComparativoAno'));
               FGraficoComparativoAno.GraficoComparativoAnoCliente;
               FGraficoComparativoAno.free;
             end;
    13300  : begin
               FEntradaMetro := TFEntradaMetro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FEntradaMetro'));
               FEntradaMetro.EntradaMetros;
               FEntradaMetro.free;
             end;
           // ------ Cadastro de Transportadora ------- //
    14200 :  begin
             FGraficoProducaoAnual := TFGraficoProducaoAnual.CriarSDI(application , '', FPrincipal.VerificaPermisao('FGraficoProducaoAnual'));
             FGraficoProducaoAnual.showmodal;
             FGraficoProducaoAnual.free;
           end;
    14300  : begin
             FExcluiClienteDuplicado := TFExcluiClienteDuplicado.CriarSDI(application , '', FPrincipal.VerificaPermisao('FExcluiClienteDuplicado'));
             FExcluiClienteDuplicado.ShowModal;
             FExcluiClienteDuplicado.free;
           end;
    14400  : begin
               FGeraNumerosModulo10 := TFGeraNumerosModulo10.CriarSDI(application,'', FPrincipal.VerificaPermisao('FGeraNumerosModulo10'));
               FGeraNumerosModulo10.ShowModal;
               FGeraNumerosModulo10.free;
             end;
    14500  : begin
                FGeraCodigoOffline := TFGeraCodigoOffline.CriarSDI(application,'', true);
                FGeraCodigoOffline.ShowModal;
                FGeraCodigoOffline.Free;
             end;
    14600  : begin
               FGeraXMLSNGPC := TFGeraXMLSNGPC.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGeraXMLSNGPC'));
               FGeraXMLSNGPC.ShowModal;
               FGeraXMLSNGPC.free;
             end;
    14700  : begin
               FImportaProdutosMetalVidros := TFImportaProdutosMetalVidros.criarSDI(Application,'',FPrincipal.VerificaPermisao('FImportaProdutosMetalVidros'));
               FImportaProdutosMetalVidros.showmodal;
               FImportaProdutosMetalVidros.free;
             end;
    14900  : begin
               FAlteraVendedorCadastroCliente := TFAlteraVendedorCadastroCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FAlteraVendedorCadastroCliente'));
               FAlteraVendedorCadastroCliente.showmodal;
               FAlteraVendedorCadastroCliente.free;
             end;
    14950 : begin
              ExecutaArquivoEXE('AtualizaModulos.exe',1);
            end;
    14960 : begin
              FunClientes.GeraArquivoURA('CLIENTES.TXT');
            end;
    15100  : begin
               FNovoTeleMarketing := TFNovoTeleMarketing.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoTeleMarketing'));
               FNovoTeleMarketing.EfetuaTeleMarketingAtivo;
               FNovoTeleMarketing.free;
             end;
    15200  : begin
               FTeleMarketings := TFTeleMarketings.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTeleMarketings'));
               FTeleMarketings.ConsultaHistoricos;
               FTeleMarketings.free;
             end;
    15300  : begin
               FAtualizaDiasTelemarketing := TFAtualizaDiasTelemarketing.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAtualizaDiasTelemarketing'));
               FAtualizaDiasTelemarketing.showmodal;
               FAtualizaDiasTelemarketing.free;
             end;
    15400  : begin
               FTarefas := TFTarefas.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTarefas'));
               FTarefas.ShowModal;
               FTarefas.free;
             end;
    15500  : begin
               FManutencaoMailing := tFManutencaoMailing.CriarSDI(self,'',FPrincipal.VerificaPermisao('FManutencaoMailing'));
               FManutencaoMailing.showmodal;
               FManutencaoMailing.free;
             end;
    16100  : begin
               FAgendamentos := TFAgendamentos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendamentos'));
               FAgendamentos.agenda;
               FAgendamentos.free;
             end;
    16200  : begin
               FEstagioAgendamento := TFEstagioAgendamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FEstagioAgendamento'));
               FEstagioAgendamento.ShowModal;
               FEstagioAgendamento.free;
             end;
    16300 : begin
               FAgendamentos := TFAgendamentos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendamentos'));
               FAgendamentos.AgendaNova;
               FAgendamentos.free;
            end;

    275050 : begin
               //rotina antiga
               //FAniversariante := TFAniversariante.CriarMDI(application, varia.CT_AreaX, varia.CT_AreaY,VerificaPermisao('FAniversariante'));

               FAniversariantes:= TFAniversariantes.CriarSDI(Application,'',True);
               FAniversariantes.ShowModal;
               FAniversariantes.Free;
             end;
    275060 : begin
               FEtiquetaClientes := TFEtiquetaClientes.CriarSDI(application , '', VerificaPermisao('FEtiquetaClientes'));
               FEtiquetaClientes.ShowModal;
             end;
  end;
end;

procedure TFPrincipal.MFaturamentoClick(Sender: TObject);
begin

end;

{******************* configura os modulos do sistema ************************* }
procedure TFPrincipal.ConfiguracaoModulos;
var
  Reg : TRegistro;
begin
  ConfiguraPermissaoUsuario;
  ConfiguraFilial;

  Reg := TRegistro.create;
  reg.ValidaModulo( TipoSistema, [MCadastros, Mcotacao, MProdutos, MFaturamento, {MCAixa,} MServico, BMFProdutos, BMFNovaCotacao, BMFNovaNotaFiscal, BMFVendaECF, BMFConsultaPrecosProdutos, BMFClientes] );
  VersaoSistema := reg.VersaoMaquina;
  reg.ConfiguraModulo(ct_servico, [ MServico ]  );
  reg.ConfiguraModulo(CT_NOTAFISCAL,[ MFNovaNotaFiscal, BMFNovaNotaFiscal ] );
  reg.ConfiguraModulo( CT_ORCAMENTOVENDA, [ MCotacao, BMFNovaCotacao]);
  reg.ConfiguraModulo( CT_IMPDOCUMENTOS, [ MImpDocumentos ] );
  if ( not MFNovaNotaFiscal.Visible) and ( not MFVendaECF.Visible ) then
    MFaturamento.Visible := false;
  reg.ConfiguraModulo(CT_PRODUTO, [MFClientes, MProdutos, BMFProdutos, BMFConsultaPrecosProdutos, BMFClientes]);
  reg.ConfiguraModulo(CT_AGENDACLIENTE,[MAgenda,MAgendamentos]);
  reg.ConfiguraModulo(CT_MALACLIENTE,[MFEtiquetaClientes]);
  reg.ConfiguraModulo(CT_TELEMARKETING,[MCampanhaVendas,N27,MTeleMarketing]);
  AlterarVisibleDet([MProjeto],Config.ControlarProjeto);
  reg.Free;
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraFilial;
begin
  if not config.EmitirECF then
    AlterarVisibleDet([MFVendaECF,N20,N21,MCancelarUltimoCupom, LeituraX1,ReduoZ1],false);
end;

{******************************************************************************}
procedure TFPrincipal.Ajuda1Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER,0);
end;

{******************************************************************************}
procedure TFPrincipal.ndice1Click(Sender: TObject);
begin
   Application.HelpCommand(HELP_KEY,0);
end;


procedure TFPrincipal.BitBtn1Click(Sender: TObject);
begin
  ExcluiClientesDuplicados;
end;

procedure TFPrincipal.BitBtn2Click(Sender: TObject);
var
  VpfFunNFe : TRBFuncoesNFe;
  VpfDNota : TRBDNotaFiscal;
  VpfDCliente : TRBDCliente;
begin
  VpfFunNFe := TRBFuncoesNFe.cria(BaseDados);
  AdicionaSQLAbreTabela(Aux,'Select * from CADNOTAFISCAIS '+
                            ' Where '+SQLTextoDataEntreAAAAMMDD('D_DAT_EMI',MontaData(1,6,2010),MontaData(30,6,2010),false )+
                            ' and C_SER_NOT = ''1''');
  while not aux.Eof do
  begin
    VpfDNota := TRBDNotaFiscal.cria;
    FunNotaFiscal.CarDNotaFiscal(VpfDNota,Aux.FieldByName('I_EMP_FIL').AsInteger,Aux.FieldByName('I_SEQ_NOT').AsInteger);
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := Aux.FieldByName('I_COD_CLI').AsInteger;
    FunClientes.CarDCliente(VpfDCliente);
    VpfFunNFe.EmiteNota(VpfDNota,VpfdCliente,nil);
    VpfDNota.Free;
    VpfDCliente.Free;
    VpfFunNFe.NFe.NotasFiscais.SaveToFile;
    Aux.next;
  end;
end;

{******************************************************************************}
procedure TFPrincipal.BitBtn3Click(Sender: TObject);
var
  VpfDCotacao : TRBDOrcamento;
begin
  AdicionaSQLAbreTabela(Cliente,'select * from CADORCAMENTOS '+
                                ' where D_DAT_ORC >= to_date(''02/05/2011'',''DD/MM/YYYY'') '+
                                ' ORDER BY I_LAN_ORC');
  while not Cliente.Eof do
  begin
    VpfDCotacao := TRBDOrcamento.cria;
    FunCotacao.CarDOrcamento(VpfDCotacao,Cliente.FieldByName('I_EMP_FIL').AsInteger,Cliente.FieldByName('I_LAN_ORC').AsInteger);
    FunCotacao.GeraEstoqueProdutos(VpfDCotacao,FunProdutos);
    Cliente.Next;
    VpfDCotacao.Free
  end;
  AVISO('Baixado com sucesso');
  Cliente.Close;
end;

procedure TFPrincipal.BitBtn4Click(Sender: TObject);
begin
  AdicionaSQLAbreTabela(Aux,'Select * from cadclientes where C_IND_PRC = ''S'''+
                            ' and D_DAT_CAD >= '+SQLTextoDataAAAAMMMDD(MontaData(1,3,2011)));
  while not AUX.EOF do
  begin
    AdicionaSQLAbreTabela(AuxEfi,'Select D_DAT_CAD FROM CADCLIENTES '+
                                ' Where I_COD_CLI = '+Aux.FieldByName('I_COD_CLI').AsString);
    if not AuxEfi.Eof then
    begin
      Aux.Edit;
      Aux.FieldByName('D_DAT_CAD').AsDateTime := AuxEfi.FieldByName('D_DAT_CAD').AsDateTime;
      aux.Post;
    end;

    Aux.Next;
  end;
  aux.Close;
end;

procedure TFPrincipal.BitBtn5Click(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunProdutos.ExportaProdutosParaServicos;
  if VpfResultado <> '' then
    aviso(VpfResultado);
  exit;
end;

procedure TFPrincipal.BitBtn6Click(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunClientes.AdicionaEmailNfeCliente('klabunde.maili@terra.com.br');
  if VpfResultado <> '' then
    aviso(VpfResultado);
  exit;
end;

{******************************************************************************}
procedure TFPrincipal.BitBtn7Click(Sender: TObject);
begin
  AdicionaSQLAbreTabela(Cliente,'Select * from CADCLIENTES ' +
                                ' Where C_INS_CLI = ''ISENTO''');
  while not Cliente.Eof do
  begin
    AdicionaSQLAbreTabela(BDJanete,'Select * from CADCLIENTES ' +
                                   ' WHERE I_COD_CLI = ' +IntToStr(Cliente.FieldByName('I_COD_CLI').AsInteger));
    if BDJanete.FieldByName('C_INS_CLI').AsString <> 'ISENTO' then
    Begin
      Cliente.Edit;
      Cliente.FieldByName('C_INS_CLI').AsString := BDJanete.FieldByName('C_INS_CLI').AsString;
      Cliente.Post;
    End;

    Cliente.Next;
  end;
end;

procedure TFPrincipal.BRegeraComissaoClick(Sender: TObject);
var
  VpfdNovaCR : TRBDContasCR;
  VpfDParcela : TRBDMovContasCR;
begin
  AdicionaSQLAbreTabela(Cliente,'select * from cadcontasareceber rec '+
                                ' where rec.d_dat_emi >= to_date(''24/01/2011'',''DD/MM/YYYY'') '+
                                ' AND  rec.d_dat_emi <= to_date(''27/01/2011'',''DD/MM/YYYY'') '+
                                ' AND REC.I_EMP_FIL =21 '+
                                ' and not exists(Select * from movcomissoes com '+
                                ' where com.i_emp_fil = rec.i_emp_fil '+
                                ' and com.i_lan_rec = rec.i_lan_rec) '+
                                ' order by i_nro_not');
  while not Cliente.Eof do
  begin
    VpfdNovaCR := TRBDContasCR.cria;
    VpfdNovaCR.CodEmpFil := Cliente.FieldByName('I_EMP_FIL').AsInteger;
    VpfdNovaCR.LanReceber := Cliente.FieldByName('I_LAN_REC').AsInteger;
    VpfdNovaCR.TipComissao := 0;
    VpfdNovaCR.ValTotalProdutos := Cliente.FieldByName('N_VLR_TOT').AsFloat;
    VpfdNovaCR.ValTotal := Cliente.FieldByName('N_VLR_TOT').AsFloat;
    VpfdNovaCR.DatEmissao := Cliente.FieldByName('D_DAT_EMI').AsDateTime;

    if Cliente.FieldByName('I_SEQ_NOT').AsInteger <> 0 then
    begin
      AdicionaSQLAbreTabela(Aux,'Select * from cadnotafiscais  ' +
                            ' Where I_EMP_FIL = '+Cliente.FieldByName('I_EMP_FIL').AsString +
                            ' AND I_SEQ_NOT = ' +Cliente.FieldByName('I_SEQ_NOT').AsString);
      VpfdNovaCR.CodVendedor := Aux.FieldByName('I_COD_VEN').AsInteger;
      VpfdNovaCR.PerComissao := Aux.FieldByName('N_PER_COM').AsFloat;
    end
    else
      if Cliente.FieldByName('I_LAN_ORC').AsInteger <> 0 then
      begin
        AdicionaSQLAbreTabela(Aux,'Select * from cadorcamentos  ' +
                              ' Where I_EMP_FIL = '+Cliente.FieldByName('I_EMP_FIL').AsString +
                              ' AND I_LAN_ORC = ' +Cliente.FieldByName('I_LAN_ORC').AsString);
        VpfdNovaCR.CodVendedor := Aux.FieldByName('I_COD_VEN').AsInteger;
        VpfdNovaCR.PerComissao := Aux.FieldByName('N_PER_COM').AsFloat;
      end;
    VpfdNovaCR.ValComissao := (Cliente.FieldByName('N_VLR_TOT').AsFloat * VpfdNovaCR.PerComissao)/100;
    VpfDParcela := VpFDNovaCR.AddParcela;
    VpfDParcela.NumParcela := 1;
    VpfDParcela.DatVencimento := VpfdNovaCR.DatEmissao;
    VpfDParcela.Valor := VpfdNovaCR.ValTotal;

    FunContasAReceber.GeraComissaoCR(VpfdNovaCR);

    VpfdNovaCR.Free;
    Cliente.Next;
  end;
  Aviso('Gerado com sucesso');
  Cliente.Close;
end;

{******************************************************************************}
procedure TFPrincipal.Valorestoque1Click(Sender: TObject);
begin
{  AdicionaSQLAbreTabela(Tabela,'Select * from MOVESTOQUEPRODUTOS '+
                               ' Where D_DAT_MOV >= ''2007/05/01'''+
                               ' AND C_TIP_MOV = ''S'''+
                               ' AND I_LAN_ORC IS NOT NULL');
  While not Tabela.Eof do
  begin
    Tabela.Edit;
    AdicionaSQLAbreTabela(Aux,'Select CAD.I_COD_FRM, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_PER_DES from CADORCAMENTOS CAD, MOVORCAMENTOS MOV '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                              ' AND MOV.I_SEQ_PRO = '+Tabela.FieldByName('I_SEQ_PRO').AsString +
                              ' AND CAD.I_LAN_ORC = '+Tabela.FieldByName('I_LAN_ORC').AsString+
                              ' AND CAD.I_EMP_FIL = '+Tabela.FieldByName('I_EMP_FIL').AsString);
    IF Aux.FieldByName('I_COD_FRM').AsInteger = 1101 then
      Tabela.FieldByName('N_VLR_MOV').AsFloat := (Tabela.FieldByName('N_QTD_MOV').AsFloat * Aux.FieldByName('N_VLR_PRO').AsFloat) - (((Tabela.FieldByName('N_QTD_MOV').AsFloat * Aux.FieldByName('N_VLR_PRO').AsFloat) *Aux.FieldByName('N_PER_DES').AsFloat)/100)
    ELSE
      Tabela.FieldByName('N_VLR_MOV').AsFloat := Tabela.FieldByName('N_QTD_MOV').AsFloat * Aux.FieldByName('N_VLR_PRO').AsFloat;
    Tabela.post;
    Tabela.next;
  end;}
end;

{******************************************************************************}
procedure TFPrincipal.Timer1Timer(Sender: TObject);
begin
  Sistema.SalvaTabelasAbertas;
end;


{******************************************************************************}
procedure TFPrincipal.GerarComissoesNotas1Click(Sender: TObject);
var
  VpfDataInicio, VpfDataFim : TDateTime;
  VpfDNovaCR : TRBDContasCR;
  VpfDNotaFiscal : TRBDNotaFiscal;
  VpfDParcela : TRBDMovContasCR;
begin
{  VpfDataInicio := MontaData(1,4,2008);
  VpfDataFim := MontaData(1,4,2008);
  if EntraData('Data Inicial','Data Inicial : ',VpfDataInicio) and EntraData('Data Final','Data Final : ',VpfDataFim) then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select * from CADNOTAFISCAIS CAD, CADVENDEDORES VEN ' +
                                 ' Where '+SQLTextoDataEntreAAAAMMDD('D_DAT_EMI',VpfDataInicio,VpfDataFim,false)+
                                 ' and C_NOT_CAN = ''N'''+
                                 ' and C_FIN_GER = ''S'''+
                                 ' and CAD.I_COD_VEN = VEN.I_COD_VEN');
    while not Tabela.eof do
    begin
      VpfDNotaFiscal := TRBDNotaFiscal.cria;
      FunNotaFiscal.CarDNotaFiscal(VpfDNotaFiscal,Tabela.FieldByname('I_EMP_FIL').AsInteger,Tabela.FieldByname('I_SEQ_NOT').AsInteger);


      AdicionaSQLAbreTabela(Aux,'Select * from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                                ' Where CAD.I_EMP_FIL = '+Tabela.FieldByname('I_EMP_FIL').AsString+
                                ' and CAD.I_SEQ_NOT = '+Tabela.FieldByname('I_SEQ_NOT').AsString+
                                ' and CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                ' and CAD.I_LAN_REC = MOV.I_LAN_REC '+
                                ' ORDER BY MOV.D_DAT_VEN ');
      VpfDNovaCR := TRBDContasCR.cria;
      VpfDNovaCR.CodEmpFil := Aux.FieldByname('I_EMP_FIL').AsInteger;
      VpfDNovaCR.LanReceber := Aux.FieldByname('I_LAN_REC').AsInteger;
      VpfDNovaCR.NroNota := Tabela.FieldByname('I_NRO_NOT').AsInteger;
      VpfDNovaCR.SeqNota := Tabela.FieldByname('I_SEQ_NOT').AsInteger;
      VpfDNovaCR.CodVendedor := Tabela.FieldByname('I_COD_VEN').AsInteger;
      VpfDNovaCR.TipComissao := Tabela.FieldByname('I_TIP_COM').AsInteger;
      VpfDNovaCR.PerComissao := Tabela.FieldByname('N_PER_COM').AsFloat;
      VpfDNovaCR.ValComissao := FunNotaFiscal.RValorComissao(VpfDNotaFiscal,VpfDNovaCR.TipComissao,VpfDNovaCR.PerComissao,0);
      VpfDNovaCR.DatEmissao := Tabela.FieldByname('D_DAT_EMI').AsDateTime;
      VpfDNovaCR.ValTotal := Aux.FieldByname('N_VLR_TOT').AsFloat;
      while not Aux.eof do
      begin
        VpfDParcela := VpfDNovaCR.AddParcela;
        VpfDParcela.NumParcela := Aux.FieldByname('I_NRO_PAR').AsInteger;
        VpfDParcela.DatVencimento := Aux.FieldByname('D_DAT_VEN').AsDateTime;
        VpfDParcela.Valor := Aux.FieldByname('N_VLR_PAR').AsFloat;
        Aux.Next;
      end;
      FunContasAReceber.GeraComissaoCR(VpfDNovaCR);
      Tabela.next;
      VpfDNovaCR.free;
      VpfDNotaFiscal.free;
    end;
    Tabela.close;
  end;}
//
end;

end.

