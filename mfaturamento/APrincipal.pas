unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, Tabela, Localizacao,UnImpressaoRelatorio,
  Mask, Spin, UnPrincipal, UnSistema, UnClientes, WideStrings, DBXOracle,
  SqlExpr, UnNFE;

const
  CampoPermissaoModulo = 'c_mod_fat';
  CampoFormModulos = 'c_mod_fat';
  NomeModulo = 'Faturamento';

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
    MCadastro: TMenuItem;
    MFFormacaoPreco: TMenuItem;
    MProdutos: TMenuItem;
    MFUnidades: TMenuItem;
    MFOperacoesEstoques: TMenuItem;
    MFprodutos: TMenuItem;
    N2: TMenuItem;
    MFCadPaises: TMenuItem;
    MFCadEstados: TMenuItem;
    MFCidades: TMenuItem;
    N3: TMenuItem;
    MFEventos: TMenuItem;
    MFProfissoes: TMenuItem;
    MFSituacoesClientes: TMenuItem;
    MFClientes: TMenuItem;
    MFNaturezas: TMenuItem;
    MFAdicionaProdFilial: TMenuItem;
    MFTabelaPreco: TMenuItem;
    MFCadIcmsEstado: TMenuItem;
    MNotaFiscal: TMenuItem;
    MNovanota: TMenuItem;
    N5: TMenuItem;
    MManutencaoNota: TMenuItem;
    BSaida: TSpeedButton;
    BMFConsultaNotaFiscal: TSpeedButton;
    ToolButton1: TToolButton;
    DemonstrativodeFaturamento1: TMenuItem;
    MCondicaoPagamento: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    MImpDocumentos: TMenuItem;
    Manual1: TMenuItem;
    MFMostraRecibo: TMenuItem;
    MFMostraBoleto: TMenuItem;
    MFMostraDuplicata: TMenuItem;
    MImprimirBoleto: TMenuItem;
    MDuplicata: TMenuItem;
    MConsultaProduto: TMenuItem;
    MConsultaServico: TMenuItem;
    MFMostraEnvelope: TMenuItem;
    MVendedores: TMenuItem;
    BMFProdutos: TSpeedButton;
    BMFConsultaProdutos: TSpeedButton;
    BMFNotaFiscal: TSpeedButton;
    BMFClientes: TSpeedButton;
    BMFFaturamento: TSpeedButton;
    SpeedButton6: TSpeedButton;
    ForarNovoUsurio1: TMenuItem;
    N10: TMenuItem;
    Contexto1: TMenuItem;
    ndice1: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    GeraMovimento1: TMenuItem;
    MRelatorios: TMenuItem;
    MTipoFundo: TMenuItem;
    Ferramentas1: TMenuItem;
    Exporta1: TMenuItem;
    N13: TMenuItem;
    ImportaMunicpios1: TMenuItem;
    N14: TMenuItem;
    MAliquota: TMenuItem;
    N15: TMenuItem;
    VisualizaLogs1: TMenuItem;
    N16: TMenuItem;
    MVisualizaEstatisticaConsulta: TMenuItem;
    un: TTimer;
    BaseDados : TSQLConnection;
    N17: TMenuItem;
    Status1: TMenuItem;
    StatusServiosSefaz1: TMenuItem;
    N18: TMenuItem;
    HigienizarBancoDados1: TMenuItem;
    N19: TMenuItem;
    MSpedFiscal: TMenuItem;
    N20: TMenuItem;
    ExportarXMLNfe1: TMenuItem;
    N21: TMenuItem;
    ExportaXMLNfeContabilidade1: TMenuItem;
    N4: TMenuItem;
    ExportaRPS1: TMenuItem;
    N9: TMenuItem;
    ConhecimentoTransporte1: TMenuItem;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Contexto1Click(Sender: TObject);
    procedure ndice1Click(Sender: TObject);
    procedure GeraMovimento1Click(Sender: TObject);
    procedure ExportaXMLNfeContabilidade1Click(Sender: TObject);
  private
    TipoSistema : string;
    UnPri : TFuncoesPrincipal;
    FunImpressaoRel: TImpressaoRelatorio;
    procedure ConfiguraPermissaoUsuario;
    procedure VerificaStatusSefaz;
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
     procedure OrganizaBotoes;
  end;


var
  FPrincipal : TFPrincipal;
  Ini : TInifile;

implementation

uses Constantes, UnRegistro, funsql,FunString,
     Abertura, AAlterarSenha, ASobre, FunIni, AAlterarFilialUso,
     AUnidade, AOperacoesEstoques, AProfissoes, ASituacoesClientes,
     AClientes, ACadPaises, ACadEstados, ACadCidades,
     AEventos, AProdutos,  ANaturezas,
     AAdicionaProdFilial, AFormacaoPreco, ATabelaPreco, ACadIcmsEstado,
     AManutencaoNotas, ADemosntrativoFaturamento,
     AImprimeDuplicata, AImprimeBoleto, AMostraDuplicata,
     AMostraBoleto,  AMostraRecibo,
     AConsultaPrecosProdutos, ALocalizaServico, funsistema,
  AMostraEnvelope, AVendedores, ANovaCotacao,
  UnProdutos,  ATipoFundo, UnContasaReceber,
  ANovaNotaFiscalNota, UnNotaFiscal, AGeraArquivosFiscais,
  AImportaMunicipios, AAliquotaFiscal, AVisualizaLogs,
  AVisualizaEstatisticaConsulta, UnVersoes, AHigienizarCadastros, ASpedFiscal, ACondicaoPagamento,
  AExportaNfeContabilidade, AExportaRPS, UnCotacao,
  AConhecimentoTransporteSaida;

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
  FunImpressaoRel := TImpressaoRelatorio.Cria(BaseDados);
  FunNotaFiscal := TFuncoesNotaFiscal.criar(self,BaseDados);
  FunContasAReceber := TFuncoesContasaReceber.Cria(baseDAdos);
  FunClientes := TRBFuncoesClientes.cria(BaseDAdos);
  Sistema := TRBFuncoesSistema.cria(BaseDados);
  Application.OnHint := MostraHint;
  Application.HintColor := $00EDEB9E;        // cor padrão dos hints
  Application.Title := 'Faturamento';  // nome a ser mostrado na barra de tarefa do Windows
  Application.OnException := Erro;
  Application.OnMessage := Abre;
  Varia.VersaoSistema := VersaoFaturamento;
  FunProdutos := TFuncoesProduto.criar(self,BaseDados);
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraPermissaoUsuario;
begin
  Varia.EscondeMenus(Menu,false);
  AlterarVisibleDet([BMFClientes,BMFProdutos,BMFNotaFiscal,BMFConsultaProdutos,BMFConsultaNotaFiscal,BMFFaturamento],false);
  FunImpressaoRel.CarregarMenuRel(mrFaturamento,MRelatorios);


  if (puAdministrador in varia.PermissoesUsuario) or (puFACompleto in varia.PermissoesUsuario) then
  begin
    varia.EscondeMenus(Menu,true);
    AlterarVisibleDet([BMFClientes,BMFProdutos,BMFNotaFiscal,BMFConsultaProdutos,BMFConsultaNotaFiscal,BMFFaturamento],true);
  end
  else
  begin
    AlterarVisibleDet([Ferramentas1,Exporta1],true);
    if (puConsultarCliente in varia.PermissoesUsuario) then
      AlterarVisibleDet([BMFClientes,MCadastro,MFClientes],true);
    if (puClienteCompleto in varia.PermissoesUsuario) then
      AlterarVisibleDet([N7,BMFClientes,MCadastro,MFClientes,MFEventos,MFProfissoes,MFSituacoesClientes,MFCadPaises,MFCadEstados,MFCidades,n2],true);
    if (puProdutoCompleto in varia.PermissoesUsuario) then
      AlterarVisibleDet([BMFProdutos,BMFConsultaProdutos, MCadastro,MTipoFundo,MProdutos,MFprodutos,MFAdicionaProdFilial,MFTabelaPreco,MFFormacaoPreco,n8,
                         MConsultaProduto,MConsultaServico],true);
    if (puImpressao in varia.PermissoesUsuario) then
      AlterarVisibleDet([MImpDocumentos,MImprimirBoleto,Manual1,MFMostraEnvelope,MDuplicata,
                         MFMostraRecibo,MFMostraBoleto,MFMostraduplicata],true);
    if (puManutencaoProdutos in varia.PermissoesUsuario) then
      AlterarVisibleDet([BMFProdutos,MFProdutos,MProdutos],true);
    if (puFAGerarNota in varia.PermissoesUsuario) then
      AlterarVisibleDet([BMFNotaFiscal,BMFConsultaNotaFiscal, MCadastro,MFCadIcmsEstado,MAliquota,MFOperacoesEstoques,MFUnidades,N11,MVendedores,
                         MNotaFiscal,MNovanota],true);
    if (puRelatorios in varia.PermissoesUsuario) then
      AlterarVisibleDet([MRelatorios],true);
    if (puFAManutencaoNota in varia.PermissoesUsuario) or
       (puFAConsultarNota in varia.PermissoesUsuario) then
      AlterarVisibleDet([MNotaFiscal,MManutencaoNota],true);
    if puFASpedFiscal in Varia.PermissoesUsuario then
     AlterarVisibleDet([MSpedFiscal],true);
  end;
end;

{******************************************************************************}
procedure TFPrincipal.VerificaStatusSefaz;
var
  VpfFunNFE : TRBFuncoesNFe;
begin
  VpfFunNFE := TRBFuncoesNFe.cria(BaseDados);
  VpfFunNFE.VerificaStatusServico(BarraStatus);
  VpfFunNFE.free;
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


procedure TFPrincipal.ExportaXMLNfeContabilidade1Click(Sender: TObject);
begin

end;

// ------------------- Quando o formulario e fechado -------------------------- }
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UnPri.free;
{  FunContasAReceber.free;
  BaseDados.Close;
  Varia.Free;
  Config.Free;
  Sistema.Free;
  FunImpressaoRel.Free;
  FunProdutos.free;
  FunNotaFiscal.free;
  FunClientes.free;
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
  OrganizaBotoes;
  Application.OnShortCut := TeclaPressionada;
  FunCotacao := TFuncoesCotacao.Cria(BaseDados);
  // conforme usuario, configura menu
end;

{****************** organiza os botoes do formulario ************************ }
procedure TFPrincipal.OrganizaBotoes;
begin
 UnPri.OrganizaBotoes(0, [ BCascata, BLadoaLado, BNormal, BMFClientes, BMFProdutos,
                           BMFConsultaProdutos, BMFNotaFiscal, BMFConsultaNotaFiscal,
                           BMFFaturamento, BSaida, SpeedButton6 ]);
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
      117 : Sistema.SalvaTabelasAbertas;
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
      0001 : Close;
      1050 : begin
               FAlteraSenha := TFAlteraSenha.CriarSDI(Application,'',VerificaPermisao('FAlteraSenha'));
               FAlteraSenha.ShowModal;
             end;
      1100 : begin
               FAlterarFilialUso := TFAlterarFilialUso.CriarSDI(application,'', VerificaPermisao('FAlterarFilialUso'));
               FAlterarFilialUso.ShowModal;
             end;
      1200,1210 : begin
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
      2050 : begin
               // ------ Cadastro de Condições de Pagamento ------ //
               FCondicaoPagamento := TFCondicaoPagamento.CriarSDI(Application,'',VerificaPermisao('FCondicaoPagamento'));
               FCondicaoPagamento.ShowModal;
               FCondicaoPagamento.free;
             end;
      2100 : begin
               // ------ Cadastra as Unidades ------ //
               FUnidades := TFUnidades.CriarSDI(application,'',VerificaPermisao('FUnidades'));
               FUnidades.ShowModal;
             end;
      2300 : begin
               // ----- Cadastra Operações de Estoque ----- //
               FOperacoesEstoques := TFOperacoesEstoques.criarSDI(application,'',VerificaPermisao('FOperacoesEstoques'));
               FOperacoesEstoques.ShowModal;
             end;
      2425 : begin
               FTipoFundo := TFTipoFundo.criarSDI(application,'',VerificaPermisao('FTipoFundo'));
               FTipoFundo.ShowModal;
               FTipoFundo.free;
             end;
      2450 : begin
               // ------ O Cadastro de Naturezas ------ //
               FNaturezas := TFNaturezas.CriarSDI(Application,'',VerificaPermisao('FNaturezas'));
               FNaturezas.showmodal;
               FNaturezas.free;
             end;
      2460 : begin
               FAliquotaFiscal := TFAliquotaFiscal.CriarSDI(application,'', VerificaPermisao('FAliquotaFiscal'));
               FAliquotaFiscal.ShowModal;
               FAliquotaFiscal.free;
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
               FClientes := TFClientes.criarSDI(application, '',VerificaPermisao('FClientes'));
               FClientes.ShowModal;
               FClientes.Free;
             end;
      2760 : FVendedores := TFVendedores.criarMDI(application, varia.CT_AreaX, varia.CT_AreaY,VerificaPermisao('FVendedores'));
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
      3600 : Begin
               FConsultaPrecosProdutos := TFConsultaPrecosProdutos.criarSDI(Application,'',FPrincipal.VerificaPermisao('FConsultaPrecosProdutos'));
               FConsultaPrecosProdutos.ShowModal;
             end;
      3700 : Begin
               FlocalizaServico := TFlocalizaServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaServico'));
               FlocalizaServico.ConsultaServico;
             end;
      4010 : begin
               FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
               FNovaNotaFiscalNota.NovaNotaFiscal;
               FNovaNotaFiscalNota.free;
             end;
      4012 : FManutencaoNotas := TFManutencaoNotas.CriarMDI(application,varia.CT_areaX, varia.CT_areaY, FPrincipal.VerificaPermisao('FManutencaoNotas'));
      4014 : FDemonstrativoFaturamento := TFDemonstrativoFaturamento.CriarMDI(application,varia.CT_areaX, varia.CT_areaY, FPrincipal.VerificaPermisao('FDemonstrativoFaturamento'));
      4020 : begin
               FConhecimentoTransporteSaida := TFConhecimentoTransporteSaida.CriarSDI(self,'',true);
               FConhecimentoTransporteSaida.NovoConhecimento;
               FConhecimentoTransporteSaida.Free;
             end;
      4510 : begin
               VerificaStatusSefaz;
             end;
      7100 : FImprimeDuplicata := TFImprimeDuplicata.CriarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FImprimeDuplicata'));
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
     13100 : begin
               FGeraArquivosFiscais := TFGeraArquivosFiscais.CriarSDI(application,'', VerificaPermisao('FGeraArquivosFiscais'));
               FGeraArquivosFiscais.ShowModal;
               FGeraArquivosFiscais.free;
             end;
     13200 : Begin
               FImportaMunicipios := TFImportaMunicipios.CriarSDI(application,'', VerificaPermisao('FImportaMunicipios'));
               FImportaMunicipios.Showmodal;
               FImportaMunicipios.free;
             end;
     13300 : begin
               FVisualizaLogs := tFVisualizaLogs.CriarSDI(application,'', FPrincipal.VerificaPermisao('FVisualizaLogs'));
               FVisualizaLogs.ShowModal;
               FVisualizaLogs.free;
             end;
     13400 : begin
               FVisualizaEstatisticaConsulta := TFVisualizaEstatisticaConsulta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FVisualizaEstatisticaConsulta'));
               FVisualizaEstatisticaConsulta.ShowModal;
               FVisualizaEstatisticaConsulta.free;
             end;
     13500 : begin
               FHigienizarCadastros := TFHigienizarCadastros.CriarSDI(application,'', FPrincipal.VerificaPermisao('FHigienizarCadastros'));
               FHigienizarCadastros.ShowModal;
               FHigienizarCadastros.free;
             end;
     13600 : begin
               FSpedFiscal := TFSpedFiscal.CriarSDI(self,'',true);
               FSpedFiscal.ShowModal;
               FSpedFiscal.free;
             end;
     13700 : begin
               FGeraArquivosFiscais := TFGeraArquivosFiscais.criarSDI(Application,'',FPrincipal.VerificaPermisao('FGeraArquivosFiscais'));
               FGeraArquivosFiscais.GeraArquivoNFeXML;
               FGeraArquivosFiscais.free;
             end;
     13800 : begin
               FExportanfeContabilidade := TFExportanfeContabilidade.criarSDI(Application,'',FPrincipal.VerificaPermisao('FExportanfeContabilidade'));
               FExportanfeContabilidade.showmodal;
               FExportanfeContabilidade.free;

             end;
     13900 : begin
               FExportaRPS := TFExportaRPS.criarSDI(Application,'',FPrincipal.VerificaPermisao('FExportaRPS'));
               FExportaRPS.showmodal;
               FExportaRPS.free;
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
  reg.ValidaModulo( TipoSistema, [MProdutos, MNotaFiscal,MImpDocumentos] );
  VersaoSistema := reg.VersaoMaquina;
  reg.ConfiguraModulo(CT_IMPDOCUMENTOS, [ MImpDocumentos] );
  reg.ConfiguraModulo(CT_NOTAFISCAL, [ MNotaFiscal, BMFNotaFiscal, BMFConsultaNotaFiscal, BMFFaturamento ] );
  reg.ConfiguraModulo(CT_PRODUTO, [ MProdutos, BMFProdutos, BMFConsultaProdutos ]);
  reg.Free;
 end;

procedure TFPrincipal.Contexto1Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER,0);
end;

procedure TFPrincipal.ndice1Click(Sender: TObject);
begin
   Application.HelpCommand(HELP_KEY,0);
end;

procedure TFPrincipal.GeraMovimento1Click(Sender: TObject);
begin
{  AdicionaSQLAbreTabela(MovNotas,'Select Mov.I_SEQ_PRO, NAT.I_COD_OPE, MOV.I_SEQ_NOT,'+
                                 ' CAD.I_NRO_NOT, CAD.D_DAT_EMI, MOV.N_QTD_PRO,'+
                                 ' MOV.N_TOT_PRO, MOV.C_COD_UNI '+
                                 ' from MOVNOTASFISCAIS MOV,  MOVNATUREZA NAT, CADNOTAFISCAIS CAD, '+
                                 ' Where MOV.I_EMP_FIL = 11 '+
                                 ' AND CAD.C_COD_NAT = NAT.C_COD_NAT '+
                                 ' AND CAD.I_ITE_NAT = NAT.I_SEQ_MOV '+
                                 ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                 ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT ');
  FunProdutos := TFuncoesProduto.criar(self,BaseDados);

  While not MovNotas.eof do
  begin
    FunProdutos.BaixaProdutoEstoque(MovNotas.FieldByname('I_SEQ_PRO').AsInteger,
                                            MovNotas.FieldByname('I_COD_OPE').AsInteger,
                                            MovNotas.FieldByname('I_SEQ_NOT').AsInteger,
                                            MovNotas.FieldByname('I_NRO_NOT').AsInteger,
                                            varia.MoedaBase,
                                            MovNotas.FieldByname('D_DAT_EMI').AsDateTime,
                                            MovNotas.FieldByname('N_QTD_PRO').AsFloat,
                                            MovNotas.FieldByname('N_TOT_PRO').AsFloat,
                                            MovNotas.FieldByname('C_COD_UNI').AsString,
                                            'PC',false,FALSE);
    MovNotas.next;
  end;

  FunProdutos.free;
  aviso('ok!!! Efetuado com sucesso...');}
end;


end.
