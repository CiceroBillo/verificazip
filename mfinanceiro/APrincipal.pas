unit APrincipal;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,Messages,TypInfo,
  Menus, ExtCtrls, StdCtrls,  formulariosFundo, Formularios,
  PainelGradiente, Tabela, Localizacao, Componentes1, DBTables, ComCtrls,
  Db, Buttons, ToolWin, Spin, Mask, DBCtrls, Grids, DBGrids, UnImpressaoRelatorio, UnPrincipal,
  UnContasAReceber, UnNotaFiscal, UnSistema, UnProdutos, UnCotacao, UNDadosCR, UnClientes, UnContasapagar,
  UnProspect, WideStrings, DBXOracle, SqlExpr, UnOrdemProducao;

Const
  CampoPermissaoModulo = 'c_mod_fin';
  CampoFormModulos ='c_mod_fin';
  NomeModulo = 'Financeiro';

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
    MFSobre: TMenuItem;
    MNormal: TMenuItem;
    MFormularios: TMenuItem;
    MFAlterarFilialUso: TMenuItem;
    CorFoco: TCorFoco;
    CorForm: TCorForm;
    CorPainelGra: TCorPainelGra;
    MFAbertura: TMenuItem;
    MFClientes: TMenuItem;
    MFEventos: TMenuItem;
    MFProfissoes: TMenuItem;
    MContaPagar: TMenuItem;
    N6: TMenuItem;
    MFSituacoesClientes: TMenuItem;
    MFVendedores: TMenuItem;
    N12: TMenuItem;
    MFFormasPagamento: TMenuItem;
    MFBancos: TMenuItem;
    MFContas: TMenuItem;
    MFMovBancario: TMenuItem;
    MFContasaPagar: TMenuItem;
    MFNovoContasAPagar: TMenuItem;
    MFCondicoesPagamentos: TMenuItem;
    MFNovoContasAReceber: TMenuItem;
    MFContasaReceber: TMenuItem;
    MFMovComissoes: TMenuItem;
    MFManutencaoCP: TMenuItem;
    MFManutencaoCR: TMenuItem;
    MFNovaOperacaoFinanceira: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    BCascata: TSpeedButton;
    BLadoaLado: TSpeedButton;
    BNormal: TSpeedButton;
    ToolButton3: TToolButton;
    BMFContasaPagar: TSpeedButton;
    BMFContasaReceber: TSpeedButton;
    MContaReceber: TMenuItem;
    MMovimentoBancario: TMenuItem;
    MComissoes: TMenuItem;
    N2: TMenuItem;
    MFCadPaises: TMenuItem;
    MFCadEstados: TMenuItem;
    MFCidades: TMenuItem;
    N3: TMenuItem;
    MFPlanoConta: TMenuItem;
    N4: TMenuItem;
    N1: TMenuItem;
    MFluxo: TMenuItem;
    BMFFluxoPagarReceber: TSpeedButton;
    BSaida: TSpeedButton;
    BMFClientes: TSpeedButton;
    N5: TMenuItem;
    MFFluxoPagarReceber: TMenuItem;
    N8: TMenuItem;
    Contexto1: TMenuItem;
    ndice1: TMenuItem;
    MImpressaoDocumento: TMenuItem;
    BoletoManual1: TMenuItem;
    CarnManual1: TMenuItem;
    MFImprimeBoleto: TMenuItem;
    MFImprimeDuplicata: TMenuItem;
    Manual1: TMenuItem;
    Recibo1: TMenuItem;
    MRelatorios: TMenuItem;
    Envelope1: TMenuItem;
    tempo: TPainelTempo;
    BMFMovComissoes: TSpeedButton;
    ForarNovoUsurio1: TMenuItem;
    N10: TMenuItem;
    MClientes: TMenuItem;
    ClienteseFornecedores1: TMenuItem;
    N11: TMenuItem;
    N14: TMenuItem;
    ContasaReceber1: TMenuItem;
    N16: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    Ab1: TMenuItem;
    ContasEmAbertoMatricial1: TMenuItem;
    MRemessas: TMenuItem;
    Retorno1: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    HistricoLigao1: TMenuItem;
    MCobrancas: TMenuItem;
    MEfetuarCobranca: TMenuItem;
    MHistoricoCobranca: TMenuItem;
    Mensalistas1: TMenuItem;
    BaixaMensalista1: TMenuItem;
    MotivoInadimplncia1: TMenuItem;
    IndDesempenho1: TMenuItem;
    N17: TMenuItem;
    MECobranca: TMenuItem;
    PrazoMdio1: TMenuItem;
    CentrodeCusto1: TMenuItem;
    MBloquearClientes: TMenuItem;
    GrficoAnliseFinanceira1: TMenuItem;
    ConsultaCheques1: TMenuItem;
    Timer1: TTimer;
    MCheques: TMenuItem;
    Cadastrar1: TMenuItem;
    N7: TMenuItem;
    BMFFluxoDiaro: TSpeedButton;
    BaseDados: TSQLConnection;
    N23: TMenuItem;
    Projeto1: TMenuItem;
    ReorganizaPlanoContas1: TMenuItem;
    MetaFaturamento1: TMenuItem;
    Projeto2: TMenuItem;
    N24: TMenuItem;
    MRecalcularProjeto: TMenuItem;
    FluxoGeral1: TMenuItem;
    PlanodeContasOrcado1: TMenuItem;
    Button1: TButton;
    N9: TMenuItem;
    ExportaPagamentosSCI1: TMenuItem;
    N13: TMenuItem;
    AvaliaoFinanceira1: TMenuItem;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Contexto1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ReorganizaPlanoContas1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    TipoSistema : string;
    UnPri : TFuncoesPrincipal;
    FunImpressaoRel: TImpressaoRelatorio;
    procedure ConfiguraPermissaoUsuario;
  public
     function AbreBaseDados( VpaAlias : string ) : Boolean;
     procedure TeclaPressionada(var Msg: TWMKey; var Handled: Boolean);
     procedure AlteraNomeEmpresa;
     Function  VerificaPermisao( nome : string ) : Boolean;
     procedure Erro(Sender: TObject; E: Exception);
     procedure Abre(var Msg: TMsg; var Handled: Boolean);
     procedure VerificaMoeda;
     procedure ValidaBotoesGrupos( botoes : array of TComponent);
     procedure ConfiguracaoModulos;
     procedure OrganizaBotoes;
     function PropType(const Obj: TObject; const PropName: string): string;
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses

  FunIni, fundata, FunValida, ConstMsg, FunObjeto, Constantes, UnRegistro,
  AAlterarFilialUso, Abertura,  AFormasPagamento,
  AEventos, AProfissoes, ASituacoesClientes, AClientes,
  ABancos, AContas, FunString,
  ANovoContasaPagar, ADespesas, AContasAPagar, AManutencaoCP,
  ANovoContasaReceber, AContasAReceber,
  AManutencaoCR, AMovComissoes,
  AAlterarSenha, AVendedores, ASobre, ACadLogradouro,
  ACadPaises, ACadEstados, ACadCidades, FunSql, APlanoConta,
  AAvaliacaoReceber,
  AMostraBoleto,
  AImprimeDuplicata, AImprimeBoleto,
  AMostraDuplicata, AMostraRecibo,
  AMostraEnvelope,
  AConsultaReceitaDespesa,
  ARelClientesemAberto,  ARemessas, UnCrystal,
  ARetornos, AHistoricoLigacao, ANovaCobranca, ACobrancas,
  ABaixaCotacaoPaga, AMotivoInadimplencia,
  AEmailContasAReceber, APrazoMedio, ACentroCusto, AClientesBloqueados,
  AGraficoAnaliseFaturamento, AConsultacheques, UnVersoes, AChequesOO,
  AFluxoCaixa, unCaixa, AProjetos, AReorganizaPlanoContas, ACondicaoPagamento, ARecalculaCustoProjeto, UnVendedor,
  APlanoContaOrcado;

{$R *.DFM}


// ------------------ Mostra os comentarios ma barra de Status ---------------- }
procedure TFPrincipal.MostraHint(Sender : TObject);
begin
  BarraStatus.Panels[3].Text := Application.Hint;
end;

// ------------------ Na criação do Formulário -------------------------------- }
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  UnPri := TFuncoesPrincipal.criar(self, BaseDados,NomeModulo);
  Varia := TVariaveis.Cria(BaseDados);   // classe das variaveis principais
  Config := TConfig.Create;     // Classe das variaveis Booleanas
  ConfigModulos := TConfigModulo.create; // classes de configuracoes dos modulos
  FunImpressaoRel := TImpressaoRelatorio.Cria(BaseDados);
  FunContasAReceber := TFuncoesContasAReceber.Cria(BaseDados);
  FunContasAPagar := TFuncoesContasAPagar.criar(self,BaseDados);
  FunNotaFiscal := TFuncoesNotaFiscal.criar(self,BaseDados);
  FunCotacao := TFuncoesCotacao.Cria(BaseDados);
  FunClientes := TRBFuncoesClientes.cria(BaseDados);
  FunCaixa := TRBFuncoesCaixa.Cria(BaseDados);
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(BaseDados);
  FunProspect := TRBFuncoesProspect.cria(BaseDados);
  FunVendedor := TRBFuncoesVendedor.cria(BaseDados);
  Sistema := TRBFuncoesSistema.cria(BaseDados);
  Application.OnHint := MostraHint;
  Application.HintColor := $00EDEB9E;        // cor padrão dos hints
  Application.Title := 'Financeiro';  // nome a ser mostrado na barra de tarefa do Windows
  Application.OnException := Erro;
  Application.OnMessage := Abre;
  Application.OnShortCut := TeclaPressionada;
  Varia.VersaoSistema  :=VersaoFinanceiro;
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraPermissaoUsuario;
begin
  Varia.EscondeMenus(Menu,false);
  AlterarVisibleDet([BMFClientes,BMFContasAPagar,BMFContasaReceber,BMFMovComissoes,BMFFluxoPagarReceber],false);


  if (puAdministrador in varia.PermissoesUsuario) or (puFICompleto in varia.PermissoesUsuario) then
  begin
    varia.EscondeMenus(Menu,true);
    FunImpressaoRel.CarregarMenuRel(mrFinanceiro,MRelatorios);
    AlterarVisibleDet([BMFClientes,BMFContasAPagar,BMFContasaReceber,BMFMovComissoes,BMFFluxoPagarReceber],true);
  end
  else
  begin
    if (puSomenteRelatoriosAutorizados in varia.PermissoesUsuario ) then
      AlterarVisibleDet([ContasaReceber1],false);

    if (puFIBloquearClientes in varia.PermissoesUsuario) then
      AlterarVisibleDet([MBloquearClientes],true);
    if (puFICadastraCR in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([MContaReceber,MFNovoContasAReceber],true);
    end;
    if (puFIBaixaCR in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([MContaReceber],true);
    end;
    if (puFICadastraCP in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([MContaPagar,MFNovoContasAPagar],true);
    end;
    if (puFIBaixaCP in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([MContaPagar,MFContasaPagar,N4],true);
    end;
    if (puFIEfetuarCobranca in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([MCobrancas,MEfetuarCobranca,MHistoricoCobranca,MECobranca,N17],true);
    end;
  end;
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
procedure TFPrincipal.TeclaPressionada(var Msg: TWMKey; var Handled: Boolean);
begin
    case Msg.CharCode  of
      117 :
       begin
         Sistema.SalvaTabelasAbertas;
       end;
    end;
end;


{************** erros do sistema ******************************************** }
procedure TFPrincipal.erro(Sender: TObject; E: Exception);
begin
  Aviso(E.Message);
end;

// ------------------- Quando o formulario e fechado -------------------------- }
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  BaseDados.Close;
  Varia.Free;
  Config.Free;
  ConfigModulos.Free;
  UnPri.free;
  FunImpressaoRel.free;
  FunNotaFiscal.free;
  FunProdutos.free;
  FunCotacao.free;
  FunOrdemProducao.Free;
  FunProspect.Free;
  Sistema.free;
  FunContasAPagar.free;
  FunCaixa.free;
  FunVendedor.Free;
  Action := CaFree;
end;

// -------------------- Quando o Formulario é Iniciado ------------------------ }
procedure TFPrincipal.FormShow(Sender: TObject);
begin
  // configuracoes do usuario
  UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
  // configura modulos
  ConfiguracaoModulos;
  // altera o nome e dados da barra de status
  AlteraNomeEmpresa;
  // coloca a janela maximizada;
  FPrincipal.WindowState := wsMaximized;
  // conforme usuario, configura menu
  OrganizaBotoes;
  FunProdutos := TFuncoesProduto.criar(self,BaseDados);
end;

{procedure TFPrincipal.IndDesempenho1Click(Sender: TObject);
begin

end;

****************** organiza os botoes do formulario ************************ }
procedure TFPrincipal.OrganizaBotoes;
begin
 UnPri.OrganizaBotoes(0, [ BCascata, BLadoaLado, BNormal, BMFClientes, BMFContasaPagar,
                           BMFContasaReceber, BMFMovComissoes,BMFFluxoDiaro,  BMFFluxoPagarReceber,
                           bsaida]);
end;

{******************************************************************************}
function TFPrincipal.PropType(const Obj: TObject;const PropName: string): string;
var
  Info: PPropInfo;
begin
  Info := GetPropInfo(Obj.ClassInfo, PropName);
  if Assigned(Info) then
    Result := Info^.PropType^.Name
  else
    Result := '';
end;

// -------------------- Altera o Caption da Jabela Proncipal ------------------ }
procedure TFPrincipal.AlteraNomeEmpresa;
begin
  UnPri.AlteraNomeEmpresa(self, BarraStatus, NomeModulo, TipoSistema );
end;

procedure TFPrincipal.Button1Click(Sender: TObject);
var
  VpfDCheque : TRBDCheque;
  VpfNome : string;
begin
  VpfDCheque := TRBDCheque.cria;
  VpfDCheque.CodBanco := 15;
  Aviso(GetPropInfo(VpfDCheque,'CodBanco',[tkInteger]).Name);


//  aviso(PropType(Button1,'name'));
end;

// ----- Verifica a permissão do formulários conforme tabela MovGrupoForm -------- //
Function TFPrincipal.VerificaPermisao( nome : string ) : Boolean;
begin
  result := UnPri.VerificaPermisao(nome);
  if not result then
    abort;
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
           // ------ Formulario de Filiais  ------ //
    2200 : begin
             FClientesBloqueados := TFClientesBloqueados.CriarSDI(self,'',FPrincipal.VerificaPermisao('FClientesBloqueados'));
             FClientesBloqueados.ShowModal;
             FClientesBloqueados.free;
           end;
    2300 : begin
             FEventos := TFEventos.CriarSDI(application, '', VerificaPermisao('FEventos'));
             FEventos.ShowModal;
           end;
    2400 : begin
             // ------- As profissões do Cliente ------- //
             FProfissoes := TFProfissoes.CriarSDI(application,'',VerificaPermisao('FProfissoes'));
             FProfissoes.ShowModal;
           end;
    2500 : begin
             // ------ As Situções do Cliente ------- //
             FSituacoesClientes := TFSituacoesClientes.CriarSDI(Application,'',VerificaPermisao('FSituacoesClientes'));
             FSituacoesClientes.ShowModal;
           end;
           // ------- Cadastro de Clientes ------- //
    2600 : begin
             FClientes := TFClientes.CriarSDI(application, '',VerificaPermisao('FClientes'));
             FClientes.ShowModal;
             FClientes.free;
           end;
    2650 : begin
             FAvaliacaoReceber := TFAvaliacaoReceber.criarSDI(Application,'',FPrincipal.VerificaPermisao('FAvaliacaoReceber'));
             FAvaliacaoReceber.showmodal;
             FAvaliacaoReceber.free;
           end;
    2700 : begin
             FHistoricoLigacao := TFHistoricoLigacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FHistoricoLigacao'));
             FHistoricoLigacao.ShowModal;
             FHistoricoLigacao.free;
           end;
    2750 : begin
             FMotivoInadimplencia := tFMotivoInadimplencia.CriarSDI(application,'', FPrincipal.VerificaPermisao('FMotivoInadimplencia'));
             FMotivoInadimplencia.ShowModal;
             FMotivoInadimplencia.free;
           end;
    2760 : begin
             FProjetos := TFProjetos.CriarSDI(self,'',true);
             FProjetos.ShowModal;
             FProjetos.free;
           end;
    2800 : FVendedores := TFVendedores.CriarMDI(application,varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FVendedores'));
    2920 : begin
             // ------ Cadastro de Paises ------ //
             FCadPaises := TFCadPaises.CriarSDI(Application,'',VerificaPermisao('FCadPaises'));
             FCadPaises.ShowModal;
           end;
    2930 : begin
             // ------ Cadastro de Estados ------ //
             FCadEstados := TFCadEstados.CriarSDI(Application,'',VerificaPermisao('FCadEstados'));
             FCadEstados.ShowModal;
           end;
    2940 : begin
             // ------ Cadastro de Cidades ------ //
             FCidades := TFCidades.CriarSDI(Application,'',VerificaPermisao('FCidades'));
             FCidades.ShowModal;
           end;
    3000 : begin
             FPlanoContaOrcado := TFPlanoContaOrcado.CriarSDI(Application,'',VerificaPermisao('FCidades'));
             FPlanoContaOrcado.ShowModal;
             FPlanoContaOrcado.Free;
           end;
    3100 : begin
             FConsultaCheques := TFConsultaCheques.CriarSDI(self,'',FPrincipal.VerificaPermisao('FConsultaCheques'));
             FConsultaCheques.ConsultaCheques;
           end;
    3200 : begin
             FChequesOO := TFChequesOO.CriarSDI(self,'',FPrincipal.VerificaPermisao('FChequesOO'));
             FChequesOO.CadastraChequesAvulso;
             FChequesOO.free;
           end;
    4110 : begin
             // ------ Cadastro de Condições de Pagamento ------ //
             FCondicaoPagamento := TFCondicaoPagamento.CriarSDI(Application,'',VerificaPermisao('FCondicaoPagamento'));
             FCondicaoPagamento.ShowModal;
             FCondicaoPagamento.free;
           end;
    4120 : begin
             // ------ Cadastra formas de pagamento ------ //
             FFormasPagamento := TFFormasPagamento.CriarSDI(Application,'',VerificaPermisao('FFormasPagamento'));
             FFormasPagamento.ShowModal;
           end;
    4130 : begin
             FCentroCusto := tFCentroCusto.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCentroCusto'));
             FCentroCusto.ShowModal;
             FCentroCusto.free;
           end;
    4140 : begin
             FPlanoConta := TFPlanoConta.criarSDI(Application, '', True);
             FPlanoConta.CarregaCadastraPlanoCOntas;
           end;
    4150 : begin
             // ------ Cadastro de Bancos ------ //
             FBancos := TFBancos.CriarSDI(Application,'',VerificaPermisao('FBancos'));
             FBancos.ShowModal;
           end;
    4160 : begin
             // ------ Cadastro de Contas Correntes ------ //
             FContas := TFContas.CriarSDI(Application,'',VerificaPermisao('FContas'));
             FContas.Showmodal;
           end;
    4182 : begin
             // ------ Cadastrar um contas a Pagar ------ //
             FNovoContasAPagar := TFNovoContasAPagar.CriarSDI(Application,'',VerificaPermisao('FNovoContasAPagar'));
             FNovoContasAPagar.NovoContasaPagar(0);
             FNovoContasAPagar.free;
           end;
    4185 : begin
             // ------ Contas a Pagar ------ //
             FContasaPagar := TFContasaPagar.CriarSDI(Application,'',VerificaPermisao('FContasaPagar'));
             FContasaPagar.ShowModal;
           end;
    // ------------ //
    4186 : begin
             // ------ Manutenção de titulos do conta a pagar ------ //
             FmanutencaoCP := TFmanutencaoCP.CriarSDI(self,'',VerificaPermisao('FmanutencaoCP'));
             FmanutencaoCP.ShowModal;
           end;
    4192 : begin
             // ------ Cadastra o contas a receber ------ //
             FNovoContasAReceber := TFNovoContasAReceber.CriarSDI(Application,'',VerificaPermisao('FNovoContasAReceber'));
             FNovoContasAReceber.BNovo.Click;
             FNovoContasAReceber.showmodal;
           end;
    4193 : begin
             // ------ Contas a Receber ------ //
             FContasaReceber := TFContasaReceber.CriarSDI(Application,'',VerificaPermisao('FContasaReceber'));
             FContasaReceber.ShowModal;
           end;
    4194 : begin
             // ------ Os titulos do contas a receber ------ //
             FmanutencaoCR := TFmanutencaoCR.CriarSDI(self,'',VerificaPermisao('FmanutencaoCR'));
             FmanutencaoCR.ShowModal;
           end;
    4199 : begin
             // ------ Contas a Receber ------ //
             FAvaliacaoReceber := TFAvaliacaoReceber.CriarSDI(Application,'',VerificaPermisao('FAvaliacaoReceber'));
             FAvaliacaoReceber.ShowModal;
           end;
    4242 : begin
             // ------ O Movimento de Comissões ------ //
             FMovComissoes := TFMovComissoes.CriarSDI(Application,'',VerificaPermisao('FMovComissoes'));
             FMovComissoes.ShowModal;
           end;
    4300 : begin
             FRemessas := TFRemessas.CriarSDI(application,'', FPrincipal.VerificaPermisao('FRemessas'));
             FRemessas.ShowModal;
             FRemessas.free;
           end;
    4400 : begin
             FRetornos := TFRetornos.CriarSDI(application,'', true);
             FRetornos.ShowModal;
             FRetornos.free;
           end;
    5101 : begin
             // ------ Fluxo Pagar Receber  diario ------ //
             FFluxoCaixa := TFFluxoCaixa.CriarSDI(Application,'',VerificaPermisao('FFluxoCaixa'));
             FFluxoCaixa.FluxoCaixaDiario(mes(date), ano(date));
//             FFluxoCaixa.free;
           end;
    5150 : begin
             // ------ Fluxo Pagar Receber  diario ------ //
             FFluxoCaixa := TFFluxoCaixa.CriarSDI(Application,'',VerificaPermisao('FFluxoCaixa'));
             FFluxoCaixa.FluxoCaixaGeralDiario(mes(date), ano(date));
//             FFluxoCaixa.free;
           end;
    5300 : begin
             // ------ Fluxo Pagar Receber  Mensal ------ //
             FConsultaReceitaDespesa := TFConsultaReceitaDespesa.CriarSDI(Application,'',VerificaPermisao('FConsultaReceitaDespesa'));
             FConsultaReceitaDespesa.CarregaPlanoContas;
           end;
    6100 : begin
             FAlteraSenha := TFAlteraSenha.CriarSDI(Application,'',VerificaPermisao('FAlteraSenha'));
             FAlteraSenha.ShowModal;
           end;
    6120 : begin
             FRelClienteEmAberto := TFRelClienteEmAberto.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FRelClienteEmAberto'));
             FRelClienteEmAberto.ContasEmAberto;
             FRelClienteEmAberto.free;
           end;
    7100 : begin
             FBaixaCotacaoPaga := TFBaixaCotacaoPaga.CriarSDI(application,'', FPrincipal.VerificaPermisao('FBaixaCotacaoPaga'));
             FBaixaCotacaoPaga.AdicionaOrcamento;
             FBaixaCotacaoPaga.free;
           end;
    7200 : begin
             FBaixaCotacaoPaga := TFBaixaCotacaoPaga.CriarSDI(application,'', FPrincipal.VerificaPermisao('FBaixaCotacaoPaga'));
             FBaixaCotacaoPaga.BaixaOrcamento;
             FBaixaCotacaoPaga.free;
           end;
    7300 : begin
             FReorganizaPlanoContas := TFReorganizaPlanoContas.CriarSDI(self,'',true);
             FReorganizaPlanoContas.ShowModal;
             FReorganizaPlanoContas.free;
           end;
    7400 : begin
             FunContasAReceber.ExportaPagamentosSCI(MontaData(24,06,2011),MontaData(25,06,2011));
           end;
           // ------- Cadastro de Vendedores ------- //
    8100 : FImprimeDuplicata := TFImprimeDuplicata.CriarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FImprimeDuplicata'));
    8300 : FImprimeBoleto := TFImprimeBoleto.Create(application);
    8510 : begin
             FMostraduplicata := TFMostraduplicata.CriarSDI(Application,'',VerificaPermisao('FMostraduplicata'));
             FMostraduplicata.ShowModal;
           end;
    8530 : begin
             FMostraBoleto := TFMostraBoleto.CriarSDI(Application,'',VerificaPermisao('FMostraBoleto'));
             FMostraBoleto.ShowModal;
           end;
    8560 : begin
             FMostraRecibo := TFMostraRecibo.CriarSDI(Application,'',VerificaPermisao('FMostraRecibo'));
             FMostraRecibo.ShowModal;
           end;
    8570 : begin
             FMostraEnvelope := TFMostraEnvelope.CriarSDI(Application,'',VerificaPermisao('FMostraEnvelope'));
             FMostraEnvelope.ShowModal;
           end;
    9100 : begin
             FNovaCobranca := TFNovaCobranca.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaCobranca'));
             FNovaCobranca.EfetuaCobrancas;
             FNovaCobranca.free;
           end;
    9200 : begin
             FCobrancas := TFCobrancas.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCobrancas'));
             FCobrancas.ConsultaCobrancas;
             FCobrancas.free;
           end;
    9300 : begin
             FEmailContasaReceber := TFEmailContasaReceber.CriarSDI(self,'',FPrincipal.VerificaPermisao('FEmailContasaReceber'));
             FEmailContasaReceber.ShowModal;
             FEmailContasaReceber.free;
           end;
    10100 : begin
               FRecalculaCustoProjeto := TFRecalculaCustoProjeto.CriarSDI(self,'',true);
               FRecalculaCustoProjeto.ShowModal;
               FRecalculaCustoProjeto.Free;
            end;
    20100 : begin
             // ---- Coloca as janelas em cacatas ---- //
             Cascade;
           end;
    20200 : begin
             // ---- Coloca as janelas em lado a lado ---- //
             Tile;
           end;
    20300 : begin
             // ---- Coloca a janela em tamanho normal ---- //
             if FPrincipal.ActiveMDIChild is TFormulario then
             (FPrincipal.ActiveMDIChild as TFormulario).TamanhoPadrao;
           end;
    21100 : begin
             FSobre := TFSobre.CriarSDI(application,'', VerificaPermisao('FSobre'));
             FSobre.ShowModal;
           end;

  30200 : begin
            FPrazoMedio := TFPrazoMedio.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPrazoMedio'));
            FPrazoMedio.ShowModal;
            FPrazoMedio.free;
          end;
  30300 : begin
            FGraficoAnaliseFaturamento := tFGraficoAnaliseFaturamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGraficoAnaliseFaturamento'));
            FGraficoAnaliseFaturamento.GraficoReceberXPagar;
            FGraficoAnaliseFaturamento.free;
          end;
  30400 : begin
            FGraficoAnaliseFaturamento := tFGraficoAnaliseFaturamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGraficoAnaliseFaturamento'));
            FGraficoAnaliseFaturamento.GraficoMetaFaturamento;
            FGraficoAnaliseFaturamento.free;
          end;
  end;
end;


procedure TFPrincipal.Contexto1Click(Sender: TObject);
begin
 Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TFPrincipal.ReorganizaPlanoContas1Click(Sender: TObject);
begin

end;

{******************* configura os modulos do sistema ************************* }
procedure TFPrincipal.ConfiguracaoModulos;
var
  Reg : TRegistro;
begin
  ConfiguraPermissaoUsuario;
  Reg := TRegistro.create;
  Reg.ValidaModulo( TipoSistema, [MContaPagar, MContaReceber, MMovimentoBancario, MFClientes,
                                  MImpressaoDocumento, MComissoes, MFluxo, BMFClientes, BMFContasaPagar,
                                  BMFContasaReceber, BMFMovComissoes, BMFFluxoPagarReceber] );
  AlterarVisibleDet([MFMovBancario,MFNovaOperacaoFinanceira],false);
  Reg.ConfiguraModulo(CT_ContaPagar, [MContaPagar, BMFContasaPagar]);
  Reg.ConfiguraModulo(CT_ContaReceber, [MContaReceber, BMFContasaReceber]);
  Reg.ConfiguraModulo(CT_Fluxo, [MFluxo,BMFFluxoPagarReceber]);
  Reg.ConfiguraModulo(CT_Comissao, [MComissoes,BMFMovComissoes]);
  Reg.ConfiguraModulo(CT_Bancario, [MRemessas,Retorno1]);
  Reg.ConfiguraModulo(CT_IMPDOCUMENTOS, [MImpressaoDocumento]);
  Reg.Free;
end;



procedure TFPrincipal.Timer1Timer(Sender: TObject);
begin
  Sistema.SalvaTabelasAbertas;
end;

end.

