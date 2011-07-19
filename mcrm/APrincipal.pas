unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, Tabela, Localizacao, UnImpressaoRelatorio, UnECF, UnProspect,
  Mask, UnPrincipal, jpeg, LabelCorMove, numericos, unSistema, UnProdutos, UnContasAReceber, UnCotacao,
  WideStrings, SqlExpr, DBXOracle, xmldom, XMLIntf, msxmldom, XMLDoc;

const
  CampoPermissaoModulo = 'c_mod_crm';
  CampoFormModulos = 'c_mod_crm';
  NomeModulo = 'CRM';

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
    MClientes: TMenuItem;
    N13: TMenuItem;
    MRelatorios: TMenuItem;
    RamoAtividade1: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    AlterarClassificao1: TMenuItem;
    N27: TMenuItem;
    ProprietrioProduto1: TMenuItem;
    TipoAgendamento1: TMenuItem;
    N3: TMenuItem;
    Prospects1: TMenuItem;
    Prospects2: TMenuItem;
    MeioDivulgao1: TMenuItem;
    BMFProspects: TSpeedButton;
    MotivoVenda1: TMenuItem;
    MPropostas: TMenuItem;
    MNovaProposta: TMenuItem;
    MColecao: TMenuItem;
    Desenvolvedor1: TMenuItem;
    MAmostras: TMenuItem;
    MAmostra: TMenuItem;
    Concorrentes1: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    MVisitas: TMenuItem;
    TeleMarketing1: TMenuItem;
    EfetuarTelemarketing1: TMenuItem;
    emarketing1: TMenuItem;
    GerarTarefa1: TMenuItem;
    N8: TMenuItem;
    TarefasProspect1: TMenuItem;
    HistricoTelemarketing1: TMenuItem;
    N9: TMenuItem;
    Setores1: TMenuItem;
    N4: TMenuItem;
    Manutenoemail1: TMenuItem;
    MconsultaPropostas: TMenuItem;
    N2: TMenuItem;
    HistricoLigao1: TMenuItem;
    TipoProposta1: TMenuItem;
    Agendas1: TMenuItem;
    Agendamentos1: TMenuItem;
    BMFAmostra: TSpeedButton;
    N12: TMenuItem;
    FormatoFrasco1: TMenuItem;
    MaterialFrasco1: TMenuItem;
    MaterialRutlo1: TMenuItem;
    MaterialLiner1: TMenuItem;
    BMFNovaProposta: TSpeedButton;
    N14: TMenuItem;
    MCadastraEmail: TMenuItem;
    N15: TMenuItem;
    CadastroRpido1: TMenuItem;
    BMFCAdastroRapido: TSpeedButton;
    Gerencial1: TMenuItem;
    MInformacoesVendedor: TMenuItem;
    BaseDados: TSQLConnection;
    DepartamentoAmostra1: TMenuItem;
    ipoMateriaPrima1: TMenuItem;
    N11: TMenuItem;
    ObsInstalacao1: TMenuItem;
    N18: TMenuItem;
    MotivoAtraso1: TMenuItem;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Ajuda1Click(Sender: TObject);
    procedure ndice1Click(Sender: TObject);
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
      AProfissoes, ASituacoesClientes,FunString,
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
  AMostraPlanenamentoOP, AChamadosTecnicos,
  AMeioDivulgacao,
  AProspects, AMotivoVenda, ANovaProposta, AColecao,
  ADesenvolvedor, AAlteraEstagioProposta, AAmostras, AConcorrentes,
  AConsultaAgendaProspect, ANovoTelemarketingProspect,
  ATarefaEMarketingProspect, ATarefaTelemarketingProspect,
  AHistoricoTelemarketingProspect, ASetores, AManutencaoEmail, UnVersoes,
  APropostasCliente, AHistoricoLigacao, ATipoProposta, AFormatoFrasco,
  AMaterialFrasco, AMaterialRotulo, AMaterialLiner, ACadastraEmailSuspect,
  ADigitacaoProspect, ATeleMarketings, AInformacoesVendedor, ADepartamentoAmostra, ATipoMateriaPrima,
  AObsPropostaComercial, AMotivoAtraso;



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
  FunImpressaoRel := TImpressaoRelatorio.cria(Basedados);
  Application.OnHint := MostraHint;
  Application.HintColor := $00EDEB9E;        // cor padrão dos hints
  Application.Title := 'CRM';  // nome a ser mostrado na barra de tarefa do Windows
  Application.OnException := Erro;
  Application.OnMessage := Abre;
  Application.OnShortCut := TeclaPressionada;
  varia.VersaoSistema := VersaoCRM;
  Sistema := TRBFuncoesSistema.cria(FPrincipal.BaseDados);
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraPermissaoUsuario;
begin
  Varia.EscondeMenus(Menu,false);
  AlterarVisibleDet([BMFClientes,BMFProdutos, BMFConsultaPrecosProdutos,BMFProspects],false);

   AlterarVisibleDet([MRelatorios],true);
   FunImpressaoRel.CarregarMenuRel(mrCRM,MRelatorios);

  if (puAdministrador in varia.PermissoesUsuario) or (puCRCompleto in varia.PermissoesUsuario) then
  begin
    varia.EscondeMenus(Menu,true);
//    FunImpressaoRel.CarregarMenuRel(mrPontoLoja,MRelatorios);
    AlterarVisibleDet([BMFProspects, BMFClientes,BMFProdutos,BMFConsultaPrecosProdutos],true);
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
      AlterarVisibleDet([MCadastros,MFCidades,MFCadEstados,MFCadPaises,RamoAtividade1,n3],true);
    if (puCRPropostas in varia.PermissoesUsuario)  then
      AlterarVisibleDet([MPropostas,MconsultaPropostas,MNovaProposta],true);
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

// ------------------- Quando o formulario e fechado -------------------------- }
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  BaseDados.Close;
  Varia.Free;
  Config.Free;
  UnPri.free;
  FunImpressaoRel.Free;
  Sistema.free;
  FunProdutos.free;
  FunContasAPagar.Free;
  FunContasAReceber.Free;
  FunCotacao.free;
  FunClientes.free;
  FunProspect.free;
  FunECF.free;
  Action := CaFree;
end;

// -------------------- Quando o Formulario é Iniciado ------------------------ }
procedure TFPrincipal.FormShow(Sender: TObject);
begin
  FunProdutos := TFuncoesProduto.criar(self,BaseDados);
  FunNotaFiscal := TFuncoesNotaFiscal.criar(self,BaseDados);
  FunContasAPagar := TFuncoesContasAPagar.criar(self,BaseDados);
  FunCotacao := TFuncoesCotacao.Cria(BaseDados);
  FunClientes := TRBFuncoesClientes.cria(FPrincipal.BaseDados);
  FunProspect := TRBFuncoesProspect.Cria(BaseDados);
  FunEcf := TRBFuncoesECF.cria(BarraStatus,basedados);
  FunContasAReceber := TFuncoesContasAReceber.Cria(BaseDados);
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
 UnPri.OrganizaBotoes(0, [ BCascata, BLadoaLado, BNormal, BMFProspects, BMFClientes,BMFCAdastroRapido, BMFProdutos, BMFAmostra, BMFNovaProposta,
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
      117 :
       begin
         Sistema.SalvaTabelasAbertas;
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
    2400 : begin
             FFormatoFrasco := TFFormatoFrasco.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFormatoFrasco'));
             FFormatoFrasco.ShowModal;
             FFormatoFrasco.free;
           end;
    2410 : begin
             FMaterialFrasco := TFMaterialFrasco.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMaterialFrasco'));
             FMaterialFrasco.ShowModal;
             FMaterialFrasco.free;
           end;
    2420 : begin
             FMaterialRotulo := TFMaterialRotulo.CriarSDI(self,'',FPrincipal.VerificaPermisao(''));
             FMaterialRotulo.ShowModal;
             FMaterialRotulo.free;
           end;
    2430 : begin
             FMaterialLiner := TFMaterialLiner.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMaterialLiner'));
             FMaterialLiner.ShowModal;
             FMaterialLiner.free;
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
             FProfissoes.free;
           end;
    2650 : begin
             FDigitacaoProspect := TFDigitacaoProspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FDigitacaoProspect'));
             FDigitacaoProspect.CadastraProspect;
             FDigitacaoProspect.free;
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
    2773 : begin
             FDonoProduto := tFDonoProduto.CriarSDI(self,'',FPrincipal.VerificaPermisao('FDonoProduto'));
             FDonoProduto.ShowModal;
             FDonoProduto.Free;
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
             FColecao := TFColecao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FColecao'));
             FColecao.ShowModal;
             FColecao.free;
           end;
    2830 : begin
             FHistoricoLigacao := TFHistoricoLigacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FHistoricoLigacao'));
             FHistoricoLigacao.ShowModal;
             FHistoricoLigacao.free;
           end;
    2840 : begin
             FDepartamentoAmostra := TFDepartamentoAmostra.CriarSDI(self,'',true);
             FDepartamentoAmostra.ShowModal;
             FDepartamentoAmostra.free;
           end;
    2850 : begin
             FDesenvolvedor := TFDesenvolvedor.CriarSDI(self,'',FPrincipal.VerificaPermisao('FDesenvolvedor'));
             FDesenvolvedor.ShowModal;
             FDesenvolvedor.free;
           end;
    2855 : begin
             FTipoMateriaPrima := TFTipoMateriaPrima.CriarSDI(self,'',true);
             FTipoMateriaPrima.showmodal;
             FTipoMateriaPrima.free;
           end;
    2860 : begin
             FConcorrentes := TFConcorrentes.CriarSDI(self,'',FPrincipal.VerificaPermisao('FConcorrentes'));
             FConcorrentes.ShowModal;
             FConcorrentes.free;
           end;
    2870: begin
            FSetores:= TFSetores.CriarSDI(Application,'',True);
            FSetores.ShowModal;
            FSetores.Free;
          end;
    2880 : begin
             FTipoProposta := TFTipoProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTipoProposta'));
             FTipoProposta.ShowModal;
             FTipoProposta.free;
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
    2960 : begin
             FMeioDivulgacao := TFMeioDivulgacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMeioDivulgacao'));
             FMeioDivulgacao.ShowModal;
             FMeioDivulgacao.free;
           end;
    2970 : begin
             FMotivoVenda := tFMotivoVenda.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMotivoVenda'));
             FMotivoVenda.showmodal;
             FMotivoVenda.free;
           end;
    3000 : begin
             FObsPropostaComercial:= tFObsPropostaComercial.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMotivoVenda'));
             FObsPropostaComercial.showmodal;
             FObsPropostaComercial.free;
           end;
    3100 : begin
             FMotivoAtraso:= TFMotivoAtraso.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMotivoAtraso'));
             FMotivoAtraso.showmodal;
             FMotivoAtraso.free;
           end;
    3200 : FProdutos := TFProdutos.criarMDI(Application,Varia.CT_Areax,Varia.CT_AreaY,VerificaPermisao('FProdutos'));

    3930 : begin
             FAlteraClassificacaoProduto := TFAlteraClassificacaoProduto.CriarSDI(application , '', FPrincipal.VerificaPermisao('FAlteraClassificacaoProduto'));
             FAlteraClassificacaoProduto.ShowModal;
             FAlteraClassificacaoProduto.free;
           end;
    4100 : begin
             FProspects := TFProspects.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProspects'));
             FProspects.ShowModal;
             FProspects.Free;
           end;
    4200 : begin
             FConsultaAgendaProspect:= TFConsultaAgendaProspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FConsultaAgendaProspect'));
             FConsultaAgendaProspect.ShowModal;
             FConsultaAgendaProspect.free;
           end;
    4300 : begin
             FCadastraEmailSuspect := TFCadastraEmailSuspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCadastraEmailSuspect'));
             FCadastraEmailSuspect.ShowModal;
             FCadastraEmailSuspect.free;
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
             FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
             FNovaProposta.NovaProposta;
             FNovaProposta.free;
           end;
    6300 : begin
             FPropostasCliente:= TFPropostasCliente.CriarSDI(Application,'',True);
             FPropostasCliente.ShowModal;
             FPropostasCliente.Free;
           end;
    7100 : begin
             FAmostras := TFAmostras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAmostras'));
             FAmostras.ShowModal;
             FAmostras.free;
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
    10100  : begin
               FTarefaEMarketingProspect := TFTarefaEMarketingProspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTarefaEMarketingProspect'));
               FTarefaEMarketingProspect.ShowModal;
               FTarefaEMarketingProspect.free;
             end;
    10200  : begin
               FManutencaoEmail := tFManutencaoEmail.CriarSDI(self,'',FPrincipal.VerificaPermisao('FManutencaoEmail'));
               FManutencaoEmail.ShowModal;
               FManutencaoEmail.free;
             end;
    11100  : begin
               FAgendamentos := TFAgendamentos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendamentos'));
               FAgendamentos.ShowModal;
               FAgendamentos.free;
             end;
    12100 : begin
              FInformacoesVendedor := TFInformacoesVendedor.CriarSDI(self,'',FPrincipal.VerificaPermisao(''));
              FInformacoesVendedor.showmodal;
              FInformacoesVendedor.free;
            end;
    13100 : begin
             FNovoTelemarketingProspect:= TFNovoTelemarketingProspect.CriarSDI(Application,'',True);
             FNovoTelemarketingProspect.EfetuaTeleMarketingAtivo;
             FNovoTelemarketingProspect.Free;
           end;
    13200: begin
             FTarefasTelemarketingProspect:= TFTarefasTelemarketingProspect.CriarSDI(Application,'',True);
             FTarefasTelemarketingProspect.ShowModal;
             FTarefasTelemarketingProspect.Free;
           end;
    13300: begin
             FHistoricoTelemarketingProspect := TFHistoricoTelemarketingProspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FHistoricoTelemarketingProspect'));
             FHistoricoTelemarketingProspect.ShowModal;
             FHistoricoTelemarketingProspect.free;
           end;
    13400  : begin
               FTeleMarketings := TFTeleMarketings.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTeleMarketings'));
               FTeleMarketings.showmodal;
               FTeleMarketings.free; 
             end;
    14100  : begin
               FAgendamentos := TFAgendamentos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendamentos '));
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
  reg.ConfiguraModulo(CT_AMOSTRA, [MAmostras,BMFAmostra]);

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

{******************************************************************************}
end.
