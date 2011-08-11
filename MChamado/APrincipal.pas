
unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, Tabela, Localizacao, UnImpressaoRelatorio, UnECF,
  Mask, UnPrincipal, jpeg, LabelCorMove, numericos, unSistema, UnProdutos, UnContasAReceber, UnCotacao,
  WideStrings, SqlExpr, DBXOracle, UnProspect;

const
  CampoPermissaoModulo = 'c_mod_cha';
  CampoFormModulos = 'c_mod_cha';
  NomeModulo = 'Chamado Técnico';

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
    MCadastros: TMenuItem;
    MFCadPaises: TMenuItem;
    MFCadEstados: TMenuItem;
    MFCidades: TMenuItem;
    MFEventos: TMenuItem;
    MFProfissoes: TMenuItem;
    MFSituacoesClientes: TMenuItem;
    MFClientes: TMenuItem;
    MProdutos: TMenuItem;
    MFProdutos: TMenuItem;
    MFAdicionaProdFilial: TMenuItem;
    MServico: TMenuItem;
    MFServicos: TMenuItem;
    MFFormacaoPrecoServico: TMenuItem;
    BMFProdutos: TSpeedButton;
    BMFClientes: TSpeedButton;
    BSaida: TSpeedButton;
    BMFConsultaPrecosProdutos: TSpeedButton;
    MFRegiaoVenda: TMenuItem;
    Ajuda1: TMenuItem;
    ndice1: TMenuItem;
    Bloquear1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    MClientes: TMenuItem;
    N13: TMenuItem;
    MRelatorios: TMenuItem;
    RamoAtividade1: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    AlterarClassificao1: TMenuItem;
    BitBtn1: TBitBtn;
    N23: TMenuItem;
    Tcnico1: TMenuItem;
    N27: TMenuItem;
    ProprietrioProduto1: TMenuItem;
    TipoAgendamento1: TMenuItem;
    MChamadoTecnico: TMenuItem;
    MNovoChamadoTecnico: TMenuItem;
    N2: TMenuItem;
    MConsultaChamado: TMenuItem;
    N3: TMenuItem;
    Estgios1: TMenuItem;
    MTipoChamado: TMenuItem;
    N4: TMenuItem;
    MPesquisaSatisfacao: TMenuItem;
    N5: TMenuItem;
    MConsultaPesquisaSatisfacao: TMenuItem;
    MAgenda: TMenuItem;
    MConsultaAgendamentos: TMenuItem;
    Telemarketing1: TMenuItem;
    EfetuarTelemarketing1: TMenuItem;
    HistricosLigaes1: TMenuItem;
    N7: TMenuItem;
    GerarTarefa1: TMenuItem;
    BMFNovoChamado: TSpeedButton;
    BaseDados: TSQLConnection;
    N6: TMenuItem;
    ProdutosaProduzir1: TMenuItem;
    ExportaProdutoServico1: TMenuItem;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Ajuda1Click(Sender: TObject);
    procedure ndice1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure MServicoClick(Sender: TObject);
    procedure ExportaProdutoServico1Click(Sender: TObject);
  private
    TipoSistema : string;
    UnPri : TFuncoesPrincipal;
    FunImpressaoRel: TImpressaoRelatorio;
    FunEcf : TRBFuncoesECF;
    procedure ConfiguraPermissaoUsuario;
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

uses Constantes, UnRegistro, funsql,FunSistema, UnClientes, UnCrystal,
     Abertura, AAlterarSenha, ASobre, FunIni, AAlterarFilialUso,
      AProfissoes, ASituacoesClientes, FunString,
     AClientes, ACadPaises, ACadEstados, ACadCidades,
     AEventos,   Registry,
        AConsultaPrecosProdutos,
  ALocalizaProdutos,
  AProdutos, AAdicionaProdFilial, AServicos,
  AFormacaoPrecoServico, ALocalizaServico,
  AUnidade,
  ACores,
  ARamoAtividade,
  UnNotaFiscal,
  UnContasAPagar, AAlteraClassificacaoProduto,
  ATecnicos,
  APrincipioAtivo, ACampanhaVendas,
  ADonoProduto,
  ATipoAgendamento,  AAgendamentos,
  AEstagioAgendamento, ANovoChamadoTecnico, ARegiaoVenda,
  AAlteraEstagioCotacao, AMostraPlanenamentoOP, AChamadosTecnicos,
  AAlteraEstagioChamado, AEstagioProducao, ATipoChamado,
  APerguntaPesquisaSatisfacao, APesquisaSatisfacaoChamado, UnVersoes,
  ANovoTeleMarketing, ATeleMarketings, ATarefas, UnCaixa,
  AProdutosProduzidos;



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

procedure TFPrincipal.MServicoClick(Sender: TObject);
begin

end;

// ------------------ Na criação do Formulário -------------------------------- }
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  UnPri := TFuncoesPrincipal.criar(self, BaseDados, NomeModulo);
  Varia := TVariaveis.Cria(BaseDados);   // classe das variaveis principais
  Config := TConfig.Create;     // Classe das variaveis Booleanas
  ConfigModulos := TConfigModulo.create; // classe das variaveis de configuracao do modulo.
  FunImpressaoRel := TImpressaoRelatorio.Cria(BaseDados);
  FunClientes := TRBFuncoesClientes.cria(BaseDados);
  Application.OnHint := MostraHint;
  Application.HintColor := $00EDEB9E;        // cor padrão dos hints
  Application.Title := 'Chamado Técnico';  // nome a ser mostrado na barra de tarefa do Windows
  Application.OnException := Erro;
  Application.OnMessage := Abre;
  Application.OnShortCut := TeclaPressionada;
  varia.VersaoSistema := VersaoChamadoTecnico;
  Sistema := TRBFuncoesSistema.cria(BaseDados);
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraPermissaoUsuario;
begin
  Varia.EscondeMenus(Menu,false);
  AlterarVisibleDet([BMFClientes,BMFProdutos,BMFConsultaPrecosProdutos, BMFNovoChamado],false);

   AlterarVisibleDet([MRelatorios],true);
   FunImpressaoRel.CarregarMenuRel(mrChamado,MRelatorios);

  if (puAdministrador in varia.PermissoesUsuario) or (puCHCompleto in varia.PermissoesUsuario) then
  begin
    varia.EscondeMenus(Menu,true);
//    FunImpressaoRel.CarregarMenuRel(mrPontoLoja,MRelatorios);
    AlterarVisibleDet([BMFClientes,BMFProdutos,BMFConsultaPrecosProdutos, BMFNovoChamado],true);
  end
  else
  begin
    if (puConsultarCliente in varia.PermissoesUsuario) then
      AlterarVisibleDet([BMFClientes,MClientes,MFClientes],true);
    if (puClienteCompleto in varia.PermissoesUsuario) then
      AlterarVisibleDet([N13,MFProfissoes,MFEventos,MFRegiaoVenda,MFSituacoesClientes],true);
    if (puProdutoCompleto in varia.PermissoesUsuario) then
      AlterarVisibleDet([MFProdutos,n16,MFAdicionaProdFilial,N17,
                         AlterarClassificao1],true);
    if (puServicoCompleto in varia.PermissoesUsuario) then
      AlterarVisibleDet([MServico,MFServicos,MFFormacaoPrecoServico],true);
    if (puManutencaoProdutos in varia.PermissoesUsuario) then
      AlterarVisibleDet([BMFProdutos,MFProdutos,MProdutos],true);
    if not(puRelatorios in varia.PermissoesUsuario) then
      AlterarVisibleDet([MRelatorios],false);
    if (puCHCadastrosBasicos in varia.PermissoesUsuario) then
      AlterarVisibleDet([MCadastros,MFCidades,MFCadEstados,MFCadPaises,RamoAtividade1,n23,n3,Estgios1,Tcnico1],true);
    if (puCHCadastrarChamado in varia.PermissoesUsuario) then
      AlterarVisibleDet([MChamadoTecnico,MNovoChamadoTecnico,BMFNovoChamado],true);
    if (puCHConsultarChamado in varia.PermissoesUsuario) then
      AlterarVisibleDet([MChamadoTecnico,MConsultaChamado,n2],true);
  end;
  if (Varia.CNPJFilial = CNPJ_Copyline) or
     (Varia.CNPJFilial = CNPJ_Impox) then
  begin
    MConsultaPesquisaSatisfacao.Visible := false;
    MAgenda.Visible := false;
    N5.visible := false;
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

procedure TFPrincipal.erro(Sender: TObject; E: Exception);
begin
  Aviso(E.Message);
end;

{************ abre base de dados ********************************************* }
procedure TFPrincipal.ExportaProdutoServico1Click(Sender: TObject);
begin
end;

// ------------------- Quando o formulario e fechado -------------------------- }
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BaseDados.Close;
  Varia.Free;
  Config.Free;
  UnPri.free;
  FunImpressaoRel.Free;
  Sistema.free;
  FunProdutos.free;
  FunContasAPagar.Free;
  FunCotacao.free;
  FunClientes.free;
  FunECF.free;
  FunContasaReceber.free;
  FunCaixa.free;
  FunProspect.free;
  Action := CaFree;
end;

// -------------------- Quando o Formulario é Iniciado ------------------------ }
procedure TFPrincipal.FormShow(Sender: TObject);
begin
  FunProdutos := TFuncoesProduto.criar(self,BaseDados);
  FunNotaFiscal := TFuncoesNotaFiscal.criar(self,BaseDados);
  FunContasAPagar := TFuncoesContasAPagar.criar(self,BaseDados);
  FunCotacao := TFuncoesCotacao.Cria(BaseDados);
  FunEcf := TRBFuncoesECF.cria(BarraStatus,BaseDados);
  FunContasAReceber := TFuncoesContasAREceber.cria(BaseDAdos);
  FunCaixa := TRBFuncoesCaixa.Cria(BaseDados);
  FunProspect := TRBFuncoesProspect.cria(BaseDados);
 // configuracoes do usuario
 UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
 // configura modulos
 ConfiguracaoModulos;
 AlteraNomeEmpresa;
 FPrincipal.WindowState := wsMaximized;  // coloca a janela maximizada;
 // conforme usuario, configura menu
 OrganizaBotoes;
end;

{****************** organiza os botoes do formulario ************************ }
procedure TFPrincipal.OrganizaBotoes;
begin
 UnPri.OrganizaBotoes(0, [ BCascata, BLadoaLado, BNormal, BMFClientes, BMFProdutos,BMFNovoChamado,
                           BMFConsultaPrecosProdutos, Bsaida]);
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
      117 : Sistema.SalvaTabelasAbertas;
      119 :
       if not VerificaFormCriado('TFAlteraEstagioChamado') and not VerificaFormCriado('TFChamadoTecnico') then
       begin
         FAlteraEstagioChamado := TFAlteraEstagioChamado.CriarSDI(application,'', FPrincipal.VerificaPermisao('FAlteraEstagioChamado'));
         FAlteraEstagioChamado.AlteraEstagioChamado;
         FAlteraEstagioChamado.free;
       end;
      123 :
       if not VerificaFormCriado('TFConsultaPrecosProdutos') then
       begin
         FConsultaPrecosProdutos := TFConsultaPrecosProdutos.criarSDI(Application,'',FPrincipal.VerificaPermisao('FConsultaPrecosProdutos'));
         FConsultaPrecosProdutos.ShowModal;
         FConsultaPrecosProdutos.free;
       end;
      122 :
        if not VerificaFormCriado('TFlocalizaServico') then
        begin
          FlocalizaServico := TFlocalizaServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaServico'));
          FlocalizaServico.ConsultaServico;
          FlocalizaServico.free;
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
             FPerguntaPesquisaSatisfacao := TFPerguntaPesquisaSatisfacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPerguntaPesquisaSatisfacao'));
             FPerguntaPesquisaSatisfacao.ShowModal;
             FPerguntaPesquisaSatisfacao.free;
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
    2700 : begin
             // ------ As Situções do Cliente ------- //
             FSituacoesClientes := TFSituacoesClientes.CriarSDI(Application,'',VerificaPermisao('FSituacoesClientes'));
             FSituacoesClientes.ShowModal;
           end;
           // ------- Cadastro de Clientes ------- //
    2750 : BEGIN
             FClientes := TFClientes.criarSDI(application, '',VerificaPermisao('FClientes'));
             FClientes.showmodal;
             FClientes.free;
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
    2793 : Begin
             FRegiaoVenda := TFRegiaoVenda.criarSDI(Application,'',VerificaPermisao('FRegiaoVenda'));
             FRegiaoVenda.ShowModal;
           end;
    2800 : begin
             FEstagioProducao := TFEstagioProducao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FEstagioProducao'));
             FEstagioProducao.ShowModal;
             FEstagioProducao.free;
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
    2950 : begin
             FTecnicos := TFTecnicos.CriarSDI(application,'', FPrincipal.VerificaPermisao('FTecnicos'));
             FTecnicos.ShowModal;
             FTecnicos.free;
           end;
    2970 : begin
             FTipoChamado := TFTipoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTipoChamado'));
             FTipoChamado.ShowModal;
             FTipoChamado.free;
           end;
    3200 : FProdutos := TFProdutos.criarMDI(Application,Varia.CT_Areax,Varia.CT_AreaY,VerificaPermisao('FProdutos'));

    3930 : begin
             FAlteraClassificacaoProduto := TFAlteraClassificacaoProduto.CriarSDI(application , '', FPrincipal.VerificaPermisao('FAlteraClassificacaoProduto'));
             FAlteraClassificacaoProduto.ShowModal;
             FAlteraClassificacaoProduto.free;
           end;
    4100 : begin
             FConsultaPrecosProdutos := TFConsultaPrecosProdutos.criarSDI(Application,'',VerificaPermisao('FConsultaPrecosProdutos'));
             FConsultaPrecosProdutos.ShowModal
           end;
    4400 : begin
            FlocalizaServico := TFlocalizaServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaServico'));
            FlocalizaServico.ConsultaServico;
           end;
    5200 : FServicos := TFServicos.criarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FServicos'));
    5400 : begin
             FFormacaoPrecoServico := TFFormacaoPrecoServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FFormacaoPrecoServico'));
             FFormacaoPrecoServico.Showmodal;
           end;
    6100 : begin
             FNovoTeleMarketing := TFNovoTeleMarketing.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoTeleMarketing'));
             FNovoTeleMarketing.EfetuaTeleMarketingAtivo;
             FNovoTeleMarketing.free;
           end;
    6200 : begin
             FTeleMarketings := TFTeleMarketings.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTeleMarketings'));
             FTeleMarketings.ShowModal;
             FTeleMarketings.free;
           end;
    6300 : begin
             FTarefas := TFTarefas.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTarefas'));
             FTarefas.ShowModal;
             FTarefas.free;
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
    11100  : begin
               FAgendamentos := TFAgendamentos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendamentos'));
               FAgendamentos.ShowModal;
               FAgendamentos.free;
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
    17100 :  begin
               FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoChamado'));
               FNovoChamado.NovoChamado;
               FNovoChamado.free;
             end;
    17200 :  begin
               FChamadoTecnico := TFChamadoTecnico.CriarSDI(self,'',FPrincipal.VerificaPermisao('FChamadoTecnico'));
               FChamadoTecnico.ShowModal;
               FChamadoTecnico.free;
             end;
    17300 :  begin
               FPesquisaSatisfacaoChamado := TFPesquisaSatisfacaoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPesquisaSatisfacaoChamado'));
               FPesquisaSatisfacaoChamado.ShowModal;
               FPesquisaSatisfacaoChamado.free;
             end;
    17400 :  begin
               FProdutosProduzidos := TFProdutosProduzidos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProdutosProduzidos'));
               FProdutosProduzidos.ShowModal;
               FProdutosProduzidos.free;
             end;
  end;
end;

{******************* configura os modulos do sistema ************************* }
procedure TFPrincipal.ConfiguracaoModulos;
var
  Reg : TRegistro;
begin
  ConfiguraPermissaoUsuario;
  ConfiguraFilial;

  Reg := TRegistro.create;
  reg.ValidaModulo( TipoSistema, [MCadastros, MProdutos, MServico, BMFProdutos, BMFConsultaPrecosProdutos, BMFClientes] );
  VersaoSistema := reg.VersaoMaquina;
  reg.ConfiguraModulo(ct_servico, [ MServico ]  );
  reg.ConfiguraModulo(CT_PRODUTO, [MFClientes, MProdutos, BMFProdutos, BMFConsultaPrecosProdutos, BMFClientes]);
  reg.ConfiguraModulo(CT_AGENDACLIENTE, [MAgenda, MProdutos, BMFProdutos, BMFConsultaPrecosProdutos, BMFClientes]);

  reg.Free;
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraFilial;
begin
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

end;


{******************************************************************************}
end.
