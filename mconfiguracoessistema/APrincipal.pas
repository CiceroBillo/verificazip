unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Constantes, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, FunIni, Tabela, Localizacao, UnContasAReceber,
  Mask, UnPrincipal, UnVersoes, WideStrings, DBXOracle, SqlExpr, UnSistema;

const
  CampoPermissaoModulo = 'c_con_sis';
  campoFormModulos = 'c_mod_sis';
  NomeModulo = 'Configurações do Sistema';

type
  TFPrincipal = class(TFormularioFundo)
    Menu: TMainMenu;
    MUsuario: TMenuItem;
    MFUsuarios: TMenuItem;
    MAjuda: TMenuItem;
    BarraStatus: TStatusBar;
    Mjanela: TMenuItem;
    MCascata: TMenuItem;
    MLadoaLado: TMenuItem;
    MSistema: TMenuItem;
    MSair: TMenuItem;
    N1: TMenuItem;
    MFSobre: TMenuItem;
    MNormal: TMenuItem;
    MEmpresa: TMenuItem;
    MFFiliais: TMenuItem;
    MFEmpresas: TMenuItem;
    CorFoco: TCorFoco;
    CorForm: TCorForm;
    CorPainelGra: TCorPainelGra;
    MFAlteraSenha: TMenuItem;
    MFGrupos: TMenuItem;
    MFConfiguracoesGeral: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    BMFMovMoedas: TSpeedButton;
    MMoeda: TMenuItem;
    MFMoedas: TMenuItem;
    MFMovMoedas: TMenuItem;
    MFMoedaDia: TMenuItem;
    MFConfiguracoesProdutos: TMenuItem;
    MFConfiguracoesFinanceiro: TMenuItem;
    N2: TMenuItem;
    RegistrodoSistema1: TMenuItem;
    MFRegistroSistema: TMenuItem;
    MFImportaEnderecos: TMenuItem;
    N3: TMenuItem;
    Contexto1: TMenuItem;
    MFConfiguraImpressao: TMenuItem;
    BMFConfiguraImpressao: TSpeedButton;
    ndice1: TMenuItem;
    Configuraes1: TMenuItem;
    MFAbertura: TMenuItem;
    MFAlterarFilialUso: TMenuItem;
    MFConfiguracoesFiscal: TMenuItem;
    MFConfigImpNotaFiscal: TMenuItem;
    BMFDriveImpressora: TSpeedButton;
    Impresses1: TMenuItem;
    MFTextoBoletos: TMenuItem;
    MFDriveImpressora: TMenuItem;
    SpeedButton2: TSpeedButton;
    BMFConfiguracoesFiscal: TSpeedButton;
    BMFConfiguracoesProdutos: TSpeedButton;
    BMFConfiguracoesFinanceiro: TSpeedButton;
    BMFConfiguracoesGeral: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    ForarNovoUsurio1: TMenuItem;
    N5: TMenuItem;
    BMFConfiguraCupomFiscal: TSpeedButton;
    ConfiguraesEmpresa1: TMenuItem;
    Filiais1: TMenuItem;
    ConfiguraesECF1: TMenuItem;
    Quebrar: TDatabase;
    BaseDados: TSQLConnection;
    N6: TMenuItem;
    CoeficintesCusto1: TMenuItem;
    Ferramentas1: TMenuItem;
    LimpaBancoDados1: TMenuItem;
    Custo1: TMenuItem;
    N7: TMenuItem;
    LargurasTear1: TMenuItem;
    ConfiguraesModulos1: TMenuItem;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Contexto1Click(Sender: TObject);
    procedure ndice1Click(Sender: TObject);
    procedure BCImpDocClick(Sender: TObject);
  private
  public
     TipoSistema : string;
     UnPri : TFuncoesPrincipal;
     function AbreBaseDados( VpaAlias : string ) : Boolean;
     procedure AlteraNomeEmpresa;
     function  VerificaPermisao( nome : string ) : Boolean;
     procedure erro(Sender: TObject; E: Exception);
     procedure abre(var Msg: TMsg; var Handled: Boolean);
     procedure VerificaMoeda;
     procedure ValidaBotoesGrupos( botoes : array of TComponent);
     procedure ConfiguracaoModulos;
     procedure OrganizaBotoes;
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses Abertura, AEmpresas, AFiliais, AUsuarios, funsql,FunString,
  AGrupos, AConfiguracaoGeral, ASobre, AMoedas, AMoedaDia,
  AMovMoeda, AConfiguracaoProdutos, AConfiguracaoFiscal,
  AConfiguracaoFinanceiro, ARegistroSistema,
  UnRegistro, AImportaEnder,
  AConfiguracaoImpressao, AAlterarSenha,
  AAlterarFilialUso, AConfigImpNotaFiscal,
  ATextoBoletos, ADriveImpressora,
  AConfiguracaoEmpresa, AConfiguracaoFilial,
  AConfiguracaoECF, ACoeficientes, UnProposta, ALimpaBancoDados, APrecoLarguraTear,
  ALiberaModulo;


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
 ConfigModulos := TConfigModulo.create; //Classe que configura os modulos
 Sistema := TRBFuncoesSistema.cria(BaseDados);
 FunContasAReceber := TFuncoesContasAReceber.cria(BaseDados);

 Application.OnHint := MostraHint;
 Application.HintColor := $00EDEB9E;        // cor padrão dos hints
 Application.Title := 'Configurações Sistema';  // nome a ser mostrado na barra de tarefa do Windows
 Application.OnException := Erro;
 Application.OnMessage := Abre;
 varia.VersaoSistema := VersaoConfiguracaoSistema;
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

{***************** quando ocorrer um erro ************************************ }
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
  ConfigModulos.Free;
  UnPri.free;
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
  // oragniza os botoes
  OrganizaBotoes;
end;

{****************** organiza os botoes do formulario ************************ }
procedure TFPrincipal.OrganizaBotoes;
begin
  UnPri.OrganizaBotoes(0,[BMFConfiguracoesGeral, BMFConfiguracoesFinanceiro,BMFConfiguracoesProdutos,
                          BMFConfiguracoesFiscal,
                          BMFConfiguraImpressao,BMFConfiguraCupomFiscal,
                          BMFDriveImpressora, BMFMovMoedas, SpeedButton9, SpeedButton2]);
end;

// -------------------- Altera o Caption da Jabela Proncipal ------------------ }
procedure TFPrincipal.AlteraNomeEmpresa;
begin
  UnPri.AlteraNomeEmpresa(self, BarraStatus, NomeModulo, TipoSistema );
end;

// -------------Quando é enviada a menssagem de criação de um formulario------------- //
procedure TFPrincipal.abre(var Msg: TMsg; var Handled: Boolean);
begin
  if (Msg.message = CT_CRIAFORM) or (Msg.message = CT_DESTROIFORM) then
  begin
    UnPri.ConfiguraMenus(screen.FormCount,[],[MFAbertura,MSair], Mjanela);
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
             FAlteraSenha := TFAlteraSenha.CriarSDI(Application,'',VerificaPermisao('FAlteraSenha'));
             FAlteraSenha.ShowModal;
           end;

    1200 : begin
             FAlterarFilialUso := TFAlterarFilialUso.CriarSDI(application,'', VerificaPermisao('FAlterarFilialUso'));
             FAlterarFilialUso.ShowModal;
           end;
    1300,1350 : begin
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
                    if  ((Sender as TComponent).Tag) = 1350 then
                      FPrincipal.close;
                end;
           // ---- Sair do Sistema ----- //
    1900 : self.Close;
    2100 : FConfiguracoesGeral := TFConfiguracoesGeral.criarMDI(application,Varia.CT_AreaX,Varia.CT_AreaY, VerificaPermisao('FConfiguracoesGeral'));
    2200 : FConfiguracoesFinanceiro := TFConfiguracoesFinanceiro.criarMDI(application,Varia.CT_AreaX,Varia.CT_AreaY, VerificaPermisao('FConfiguracoesGeral'));
    2300 : FConfiguracoesProdutos := TFConfiguracoesProdutos.criarMDI(application,Varia.CT_AreaX,Varia.CT_AreaY, VerificaPermisao('FConfiguracoesGeral'));
    2400 : FConfiguracoesFiscal := TFConfiguracoesFiscal.criarMDI(application,Varia.CT_AreaX,Varia.CT_AreaY, VerificaPermisao('FConfiguracoesGeral'));
    2401 : begin
             FConfigImpNotaFiscal := TFConfigImpNotaFiscal.CriarSDI(application,'', VerificaPermisao('FConfigImpNotaFiscal'));
             FConfigImpNotaFiscal.ShowModal;
           end;
    2500 : FConfiguracaoEmpresa := TFConfiguracaoEmpresa.criarMDI(application,Varia.CT_AreaX,Varia.CT_AreaY, VerificaPermisao('FConfiguracaoEmpresa'));
    2550 : FConfiguracaoFilial := TFConfiguracaoFilial.criarMDI(application,Varia.CT_AreaX,Varia.CT_AreaY, VerificaPermisao('FConfiguracaoFilial'));
    2660 :
           begin
             FConfiguracaoECF := TFConfiguracaoECF.CriarSDI(application,'', FPrincipal.VerificaPermisao('FConfiguracaoECF'));
             FConfiguracaoECF.ShowModal;
             FConfiguracaoECF.free;
           end;
    2675 : begin
             FConfiguraImpressao := TFConfiguraImpressao.CriarSDI(application,'', VerificaPermisao('FConfiguraImpressao'));
             FConfiguraImpressao.ShowModal;
           end;
    2700 : begin
             FTextoBoletos := TFTextoBoletos.CriarSDI(application, '' , VerificaPermisao('FTextoBoletos'));
             FTextoBoletos.ShowModal;
           end;
    2720 : begin
             FDriveImpressora := TFDriveImpressora.CriarSDI(application, '' , VerificaPermisao('FDriveImpressora'));
             FDriveImpressora.ShowModal;
           end;
    2800 : begin
            FLiberaModulo:= TFLiberaModulo.CriarSDI(Application, '', true);
            FLiberaModulo.ShowModal;
           end;

    2990 : begin
             FImportaEnderecos := TFImportaEnderecos.CriarSDI(application,'', VerificaPermisao('FImportaEnderecos'));
             FImportaEnderecos.ShowModal;
           end;

             // ----- Formulario de Empresas ----- //
    3100 : FEmpresas := TFEmpresas.criarMDI(application,Varia.CT_AreaX,Varia.CT_AreaY, VerificaPermisao('FEmpresas'));
           // ------ Formulario de Filiais  ------ //
    3200 : FFiliais := TFFiliais.criarMDI(application,Varia.CT_areaX,Varia.CT_areaY, VerificaPermisao('FFiliais'));
    4100 : begin
             // ------ Cadastro de Moedas ------ //
             FMoedas := TFMoedas.CriarSDI(application, '',  VerificaPermisao('FMoedas'));
             FMoedas.ShowModal;
           end;
    4200 : begin
             // ------ Moedos da Dia ------ //
             FMoedaDia := TFMoedaDia.CriarSDI(application, '', VerificaPermisao('FMoedaDia'));
             FMoedaDia.ShowModal;
           end;
    4300 : begin
             // ------ Movimentação de Moedas ------ //
             FMovMoedas := TFMovMoedas.criarSDI(application, '', VerificaPermisao('FMovMoedas'));
             FMovMoedas.ShowModal;
           end;
    5200 : FUsuarios := TFUsuarios.criarMDI(application,Varia.CT_AreaX, Varia.CT_AreaY, VerificaPermisao('FUsuarios'));
    5400 : begin
             Fgrupos := TFGrupos.CriarSDI(application,'', VerificaPermisao('FGrupos'));
             Fgrupos.ShowModal;
           end;
    6100 : begin
             // ---- Coloca as janelas em cacatas ---- //
             Cascade;
           end;
    6200 : begin
             // ---- Coloca as janelas em lado a lado ---- //
             Tile;
           end;
    6300 : begin
             // ---- Coloca a janela em tamanho normal ---- //
             if FPrincipal.ActiveMDIChild is TFormulario then
             (FPrincipal.ActiveMDIChild as TFormulario).TamanhoPadrao;
           end;
    7100 : begin
             // ---- registro do sistema ---- //
              FRegistroSistema := TFRegistroSistema.CriarSDI(application,'', VerificaPermisao('FRegistroSistema'));
              FRegistroSistema.ShowModal;
            end;
    8100 : begin
             FSobre := TFSobre.CriarSDI(application,'', VerificaPermisao('FSobre'));
             FSobre.ShowModal;
           end;
    9100 : begin
             FLimpaBancoDados := TFLimpaBancoDados.criarSDI(Application,'',FPrincipal.VerificaPermisao('FLimpaBancoDados'));
             FLimpaBancoDados.showmodal;
             FLimpaBancoDados.free;
           end;
    10100 : begin
             FCoeficientes := TFCoeficientes.CriarSDI(self,'',true);
             FCoeficientes.ShowModal;
             FCoeficientes.free;
           end;
    10200 : begin
             FPrecoLarguraTear := TFPrecoLarguraTear.criarSDI(Application,'',FPrincipal.VerificaPermisao('FPrecoLarguraTear'));
             FPrecoLarguraTear.showmodal;
             FPrecoLarguraTear.free;
           end;

  end;
end;

procedure TFPrincipal.Contexto1Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER,0);
end;

{******************* configura os modulos do sistema ************************* }
procedure TFPrincipal.ConfiguracaoModulos;
var
  Reg : TRegistro;
begin
  Reg := TRegistro.create;
  Reg.ValidaModulo( TipoSistema, [Configuraes1, MMoeda, Impresses1,MUsuario, BMFConfiguraCupomFiscal,
                                  BMFConfiguracoesFiscal, BMFConfiguracoesProdutos, BMFConfiguracoesFinanceiro, BMFConfiguracoesGeral, BMFMovMoedas, BMFConfiguraImpressao] );
  //cp, cr
  if ( not ConfigModulos.ContasAPagar) and ( not ConfigModulos.ContasAReceber ) then
  begin
    MFConfiguracoesFinanceiro.Visible := false;
    BMFConfiguracoesFinanceiro.Visible := false;
  end;
  // caixa
  // produtos
  reg.ConfiguraModulo(CT_PRODUTO, [ MFConfiguracoesProdutos, BMFConfiguracoesProdutos ] );
  // codigo barra
  //  nota fiscal
  if ( not ConfigModulos.NotaFiscal) and ( not ConfigModulos.ECF ) then
  begin
    MFConfigImpNotaFiscal.Visible := false;
    MFConfiguracoesFiscal.Visible := false;
    BMFConfiguracoesFiscal.Visible:= false;
  end;
  // somente nota fiscal
  MFConfigImpNotaFiscal.Visible := ConfigModulos.NotaFiscal;

  // permissao
  reg.ConfiguraModulo( CT_SENHAGRUPO, [ MFGrupos ] );
  // imp documentos
  reg.ConfiguraModulo( CT_IMPDOCUMENTOS, [ MFConfiguraImpressao, BMFConfiguraImpressao, MFTextoBoletos ] );
  // impressao de documentos
  reg.ConfiguraModulo( CT_IMPDOCUMENTOS, [ FConfigImpNotaFiscal, FTextoBoletos ]  );
  // ECF
  // mala direta
  reg.Free;
end;

procedure TFPrincipal.ndice1Click(Sender: TObject);
begin
   Application.HelpCommand(HELP_KEY,0);
end;

procedure TFPrincipal.BCImpDocClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER,0);
end;

end.

