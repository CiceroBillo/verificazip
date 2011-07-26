unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, Tabela, Localizacao, UnImpressaoRelatorio, UnECF, UnProspect,
  Mask, UnPrincipal, jpeg, LabelCorMove, numericos, unSistema, UnProdutos, UnContasAReceber, UnCotacao,
  WideStrings, SqlExpr, DBXOracle, Ribbon, ImgList, ActnList, RibbonLunaStyleActnCtrls, ActnMan,
  RibbonObsidianStyleActnCtrls, ActnCtrls, ActnMenus, RibbonActnMenus;

const
  CampoPermissaoModulo = 'C_MOD_PDV';
  CampoFormModulos = 'C_MOD_PDV';
  NomeModulo = 'PDV';

type
  TFPrincipal = class(TFormularioFundo)
    BarraStatus: TStatusBar;
    CorFoco: TCorFoco;
    CorForm: TCorForm;
    BaseDados: TSQLConnection;
    Ribbon: TRibbon;
    PDigitaca: TRibbonPage;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    RibbonQuickAccessToolbar1: TRibbonQuickAccessToolbar;
    RibbonGroup2: TRibbonGroup;
    PainelTempo1: TPainelTempo;
    RibbonPage3: TRibbonPage;
    RibbonGroup1: TRibbonGroup;
    ImageGrandes: TImageList;
    ImageList1: TImageList;
    ActionManager1: TActionManager;
    MClientes: TAction;
    MNovoPedido: TAction;
    MConsultaPedidos: TAction;
    MFechar: TAction;
    MConsultaCodigo: TAction;
    MTabelasImportacao: TAction;
    RibbonPage1: TRibbonPage;
    RibbonGroup3: TRibbonGroup;
    MProdutos: TAction;
    PECF: TRibbonPage;
    RibbonPage2: TRibbonPage;
    BaseDadosMatriz: TSQLConnection;
    RibbonGroup4: TRibbonGroup;
    MImportacao: TAction;
    MMenuFiscal: TAction;
    RibbonGroup5: TRibbonGroup;
    MNovoECF: TAction;
    MCancelarUltimoCupom: TAction;
    MReducaoZ: TAction;
    RibbonGroup6: TRibbonGroup;
    RibbonGroup7: TRibbonGroup;
    RibbonGroup8: TRibbonGroup;
    MExportacaoDados: TAction;
    PainelTempo2: TPainelTempo;
    CorPainelGra: TCorPainelGra;
    MConsultaProdutos: TAction;
    RibbonGroup9: TRibbonGroup;
    MRetiradaCaixa: TAction;
    MSurpimentoCaixa: TAction;
    MNotaConsumidor: TAction;
    RibbonGroup10: TRibbonGroup;
    MFaturamentoDiario: TAction;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Ajuda1Click(Sender: TObject);
    procedure ndice1Click(Sender: TObject);
    procedure RibbonHelpButtonClick(Sender: TObject);
    procedure LeituraXExecute(Sender: TObject);
    procedure MFecharExecute(Sender: TObject);
  private
    TipoSistema : string;
    UnPri : TFuncoesPrincipal;
    FunImpressaoRel: TImpressaoRelatorio;
    FunEcf : TRBFuncoesECF;
    procedure ConfiguraPermissaoUsuario;
  public
     VersaoSistema : Integer;
     function AbreBaseDados( Alias : string ) : Boolean;
     function AbreBaseDadosMatriz( Alias : string ) : Boolean;
     procedure AlteraNomeEmpresa;
     Function  VerificaPermisao( nome : string ) : Boolean;
     procedure erro(Sender: TObject; E: Exception);
     procedure abre(var Msg: TMsg; var Handled: Boolean);
     procedure VerificaMoeda;
     procedure ValidaBotoesGrupos( botoes : array of TComponent);
     procedure TeclaPressionada(var Msg: TWMKey; var Handled: Boolean);
     procedure ConfiguracaoModulos;
     procedure ConfiguraFilial;
  end;


var
  FPrincipal: TFPrincipal;
  Ini : TInifile;

implementation

uses Constantes, UnRegistro, funsql,FunSistema, UnClientes, UnCrystal,
     Abertura, AAlterarSenha, ASobre, FunIni, AAlterarFilialUso,
  AAlteraEstagioProposta, AConsultaPrecosProdutos, ALocalizaServico, AClientes,
  AProdutos, UnVersoes, UnContasApagar, UnNotafiscal, ANovaCotacao, ACotacao, ANovoECF, AMenuFiscalECF,
  AImportacaoDados, AExportacaoDados, ASangriaSuprimento, ANovaNotaFiscalNota, AFaturamentoDiario;


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
  FunImpressaoRel := TImpressaoRelatorio.Create;
  Application.OnHint := MostraHint;
  Application.HintColor := $00EDEB9E;        // cor padrão dos hints
  Application.Title := 'PDV';  // nome a ser mostrado na barra de tarefa do Windows
  Application.OnException := Erro;
  Application.OnMessage := Abre;
  Application.OnShortCut := TeclaPressionada;
  varia.VersaoSistema := VersaoPDV;
  varia.NomeModulo := NomeModulo;
  Sistema := TRBFuncoesSistema.cria(FPrincipal.BaseDados);
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraPermissaoUsuario;
begin

//   AlterarVisibleDet([MRelatorios],true);
//   FunImpressaoRel.CarregarMenuRel(mrCRM,MRelatorios);

  if (puAdministrador in varia.PermissoesUsuario) or (puCRCompleto in varia.PermissoesUsuario) then
  begin
//    FunImpressaoRel.CarregarMenuRel(mrPontoLoja,MRelatorios);
  end
end;

{************ abre base de dados ********************************************* }
function TFPrincipal.AbreBaseDados( Alias : string ) : Boolean;
begin
  Result := true;
  BaseDados.close;
  BaseDados.Params.clear;
  BaseDados.Params.add('drivername=Oracle');
  BaseDados.Params.add('Database=SisCorp');
  BaseDados.Params.add('decimal separator=,');
  BaseDados.Params.add('Password=1298');
  if UpperCase(Alias) = 'SISCORP' then
    BaseDados.Params.add('User_Name=SYSTEM')
  else
    BaseDados.Params.add('User_Name='+Alias);
  try
    BaseDados.Open;
    config.SistemaEstaOnline := true;
  except
    aviso('BASE DE DADOS CENTRAL SEM COMUNICAÇÃO!!!'#13'Não foi possível estabelecer a conexão com a base de dados central, o sistema estará acessando a base de dados local');
    BaseDados.close;
    BaseDados.Params.clear;
    BaseDados.Params.add('drivername=Oracle');
    BaseDados.Params.add('Database=SisCorpLocal');
    BaseDados.Params.add('decimal separator=,');
    BaseDados.Params.add('Password=1298');
    BaseDados.Params.add('User_Name=PAF');
//          if UpperCase(Alias) = 'SISCORP' then
//            BaseDados.Params.add('User_Name=SYSTEM')
//          else
//            BaseDados.Params.add('User_Name='+Alias);
    BaseDados.Open;
    config.SistemaEstaOnline := false;
  end;
end;

{******************************************************************************}
function TFPrincipal.AbreBaseDadosMatriz(Alias: string): Boolean;
begin
  Result := true;
  BaseDadosMatriz.close;
  BaseDadosMatriz.Params.clear;
  BaseDadosMatriz.Params.add('drivername=Oracle');
  BaseDadosMatriz.Params.add('Database=SisCorpMatriz');
  BaseDadosMatriz.Params.add('decimal separator=,');
  BaseDadosMatriz.Params.add('Password=1298');
  BaseDadosMatriz.Params.add('User_Name=System');
  try
    BaseDadosMatriz.Open;
  except
    BaseDadosMatriz.close;
    BaseDadosMatriz.Params.clear;
    BaseDadosMatriz.Params.add('drivername=Oracle');
    BaseDadosMatriz.Params.add('Database=SisCorpMatrizLocal');
    BaseDadosMatriz.Params.add('decimal separator=,');
    BaseDadosMatriz.Params.add('Password=1298');
    BaseDadosMatriz.Params.add('User_Name=System');
    BaseDadosMatriz.Open;
  end;
end;

procedure TFPrincipal.erro(Sender: TObject; E: Exception);
begin
  Aviso(E.Message);
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
 //gera o md5
 varia.MD5 := Sistema.GeraMD5;
 FunEcf.GravaMD5(varia.MD5);
 // conforme usuario, configura menu
 PainelTempo1.execute('Verificando se existe cupom fiscal aberto.');
 if FunECF.ExisteCupomAberto then
 begin
   PainelTempo1.execute('Existe Cupom Aberto. Aguarde o sistema esta recuperando os dados.');
   FNovoECF := TFNovoECF.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoECF'));
   FNovoECF.showmodal;
   FNovoECF.free;
 end;
 PainelTempo1.fecha;
end;

procedure TFPrincipal.LeituraXExecute(Sender: TObject);
begin

end;

// -------------------- Altera o Caption da Jabela Proncipal ------------------ }
procedure TFPrincipal.AlteraNomeEmpresa;
begin
  UnPri.AlteraNomeEmpresa(self, BarraStatus, NomeModulo, TipoSistema );
  Ribbon.Caption := self.Caption;
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
               ConfiguracaoModulos;
               UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
             end
             else
               if  ((Sender as TComponent).Tag) = 1210 then
                 FPrincipal.close;
             end;
           // ----- Sair do Sistema ----- //
    1300 : Close;
    2700 : FProdutos := TFProdutos.criarMDI(application,varia.CT_areaX, varia.CT_areaY, FPrincipal.VerificaPermisao('FProdutos'));
    2750 : begin
             FClientes := TFClientes.criarSDI(application, '',VerificaPermisao('FClientes'));
             FClientes.ShowModal;
             FClientes.free;
           end;
    3100 : begin
             FNovaCotacao := tFNovaCotacao.criarSDI(self,'',true);
             FNovaCotacao.NovaCotacao;
             FNovaCotacao.Free;
           end;
    3200 : begin
             FCotacao := TFCotacao.CriarSDI(self,'',true);
             FCotacao.ShowModal;
             FCotacao.Free;
           end;
    3300 : begin
             FConsultaPrecosProdutos := TFConsultaPrecosProdutos.criarSDI(Application,'',FPrincipal.VerificaPermisao('FConsultaPrecosProdutos'));
             FConsultaPrecosProdutos.ShowModal;
             FConsultaPrecosProdutos.free;
           end;
    3400 : begin
             FNovaNotaFiscalNota := TFNovaNotaFiscalNota.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
             FNovaNotaFiscalNota.EmiteNotaFiscalVendaConsumidor;
             FNovaNotaFiscalNota.free;
           end;
    3500 : begin
             FFaturamentoDiario := TFFaturamentoDiario.CriarSDI(self,'',true);
             FFaturamentoDiario.RodaFaturamentoDiario;
           end;
    4100 : begin
               if AbreBaseDadosMatriz('') then
               begin
                 FImportacaoDados := TFImportacaoDados.CriarSDI(self,'',true);
                 FImportacaoDados.ShowModal;
                 FImportacaoDados.Free;
               end;
             end;
    4200 : begin
             if AbreBaseDadosMatriz('') then
             begin
               FExportacaoDados := TFExportacaoDados.CriarSDI(self,'',true);
               FExportacaoDados.ShowModal;
               FExportacaoDados.Free;
             end;
           end;
    4300 : begin
             PainelTempo1.execute('Inicializando Cupom Fiscal. Aguarde...');
             FNovoECF := TFNovoECF.CriarSDI(self,'',true);
             PainelTempo1.fecha;
             FNovoECF.NovoECF;
             FNovoECF.Free;
           end;
    4400 : begin
             FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
             FMenuFiscalECF.ShowModal;
             FMenuFiscalECF.Free;
           end;
    4500 : begin
             FunEcf.CancelaUltimoCupom;
           end;
    4600 : begin
             FunEcf.ReducaoZ;
           end;
    4700 : begin
             FSangriaSuprimento := TFSangriaSuprimento.criarSDI(Application,'',FPrincipal.VerificaPermisao('FSangriaSuprimento'));
             FSangriaSuprimento.RetiradaCaixa;
             FSangriaSuprimento.free;
           end;
    4800 : begin
             FSangriaSuprimento := TFSangriaSuprimento.criarSDI(Application,'',FPrincipal.VerificaPermisao('FSangriaSuprimento'));
             FSangriaSuprimento.SuprimentoCaixa;
             FSangriaSuprimento.free;
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
  end;
end;

procedure TFPrincipal.MFecharExecute(Sender: TObject);
begin

end;

{******************* configura os modulos do sistema ************************* }
procedure TFPrincipal.ConfiguracaoModulos;
var
  Reg : TRegistro;
begin
  ConfiguraPermissaoUsuario;
  ConfiguraFilial;
  if not config.SistemaEstaOnline then
    AlterarEnabledDet([MConsultaCodigo,MReducaoZ,MSurpimentoCaixa,MRetiradaCaixa],false);

  if not(FunEcf.ImpressoraAtiva) or not(FunEcf.NumeroSerieAutorizado) then
    AlterarEnabledDet([MNovoECF, MExportacaoDados,MImportacao,MNovoPedido,MConsultaPedidos,MConsultaCodigo,MTabelasImportacao,MReducaoZ,MCancelarUltimoCupom,MSurpimentoCaixa,MRetiradaCaixa],false);
  varia.ModoImpressaoDAV := FunEcf.ModoImpressaoDAVNaoFiscal;
  Reg := TRegistro.create;
  VersaoSistema := reg.VersaoMaquina;
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

procedure TFPrincipal.RibbonHelpButtonClick(Sender: TObject);
begin

end;

{******************************************************************************}
end.
