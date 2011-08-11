unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, Tabela, Localizacao, UnImpressaoRelatorio, UnContasAPagar,
  Mask, UnPrincipal, jpeg, LabelCorMove, numericos, unSistema, UnProdutos, UnContasAReceber, UnCotacao,
  UnVersoes, WideStrings, SqlExpr, DBXOracle, UnCaixa;

const
  CampoPermissaoModulo = 'c_mod_cai';
  CampoFormModulos = 'c_mod_cai';
  NomeModulo = 'CAIXA';

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
    BMFProdutos: TSpeedButton;
    BSaida: TSpeedButton;
    Ajuda1: TMenuItem;
    ndice1: TMenuItem;
    Bloquear1: TMenuItem;
    N10: TMenuItem;
    MRelatorios: TMenuItem;
    BitBtn1: TBitBtn;
    Caixa1: TMenuItem;
    AberturaCaixa1: TMenuItem;
    Caixas1: TMenuItem;
    N2: TMenuItem;
    BaseDados: TSQLConnection;
    N3: TMenuItem;
    ConsultaTransferencias1: TMenuItem;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Ajuda1Click(Sender: TObject);
    procedure ndice1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    TipoSistema : string;
    UnPri : TFuncoesPrincipal;
    FunImpressaoRel: TImpressaoRelatorio;
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
     Abertura, AAlterarSenha, ASobre, FunIni, AAlterarFilialUso,   Registry,
     ANovoCaixa, ACaixas, Funstring, AConsultaTransferencias;



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
  FunContasAReceber := TFuncoesContasAReceber.cria(BaseDados);
  FunClientes := TRBFuncoesClientes.cria(FPrincipal.BaseDados);
  Application.OnHint := MostraHint;
  Application.HintColor := $00EDEB9E;        // cor padrão dos hints
  Application.Title := 'Caixa';  // nome a ser mostrado na barra de tarefa do Windows
  Application.OnException := Erro;
  Application.OnMessage := Abre;
  Application.OnShortCut := TeclaPressionada;
  varia.VersaoSistema := VersaoCaixa;
  Sistema := TRBFuncoesSistema.cria(FPrincipal.BaseDados);
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraPermissaoUsuario;
begin
//  Varia.EscondeMenus(Menu,false);
// AlterarVisibleDet([BMFProdutos],false);

   AlterarVisibleDet([Caixa1,MRelatorios],true);
   FunImpressaoRel.CarregarMenuRel(mrCaixa,MRelatorios);

  if (puAdministrador in varia.PermissoesUsuario) or (puCRCompleto in varia.PermissoesUsuario) then
  begin
    varia.EscondeMenus(Menu,true);
//    FunImpressaoRel.CarregarMenuRel(mrPontoLoja,MRelatorios);
    AlterarVisibleDet([BMFProdutos],true);
  end
  else
  begin
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
  FunCaixa.Free;
  Action := CaFree;
end;

// -------------------- Quando o Formulario é Iniciado ------------------------ }
procedure TFPrincipal.FormShow(Sender: TObject);
begin
  FunProdutos := TFuncoesProduto.criar(self,BaseDados);
  FunContasAPagar := TFuncoesContasAPagar.criar(self,BaseDados);
  FunCotacao := TFuncoesCotacao.Cria(BaseDados);
  FunCaixa := TRBFuncoesCaixa.cria(FPrincipal.BaseDados);
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
 UnPri.OrganizaBotoes(0, [ BCascata, BLadoaLado, BNormal, BMFProdutos, Bsaida]);
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
             FNovoCaixa := TFNovoCaixa.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoCaixa'));
             FNovoCaixa.NovoCaixa;
             FNovoCaixa.free;
           end;
    2200 : Begin
             FCaixas := TFCaixas.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCaixas'));
             FCaixas.ShowModal;
             FCaixas.free;
           end;
    2300 : Begin
             FConsultaTransferencias := TFConsultaTransferencias.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCaixas'));
             FConsultaTransferencias.ShowModal;
             FConsultaTransferencias.free;
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

{******************* configura os modulos do sistema ************************* }
procedure TFPrincipal.ConfiguracaoModulos;
var
  Reg : TRegistro;
begin
  ConfiguraPermissaoUsuario;
  ConfiguraFilial;

  Reg := TRegistro.create;
  reg.ValidaModulo( TipoSistema, [BMFProdutos] );
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


procedure TFPrincipal.BitBtn1Click(Sender: TObject);
begin
end;


{******************************************************************************}
end.
