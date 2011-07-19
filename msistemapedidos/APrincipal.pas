unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, Tabela, Localizacao, UnImpressaoRelatorio, UnECF, UnProspect,
  Mask, UnPrincipal, jpeg, LabelCorMove, numericos, unSistema, UnProdutos, UnContasAReceber, UnCotacao,
  WideStrings, SqlExpr, DBXOracle, Ribbon, ImgList, ActnList, RibbonLunaStyleActnCtrls, ActnMan,
  RibbonObsidianStyleActnCtrls, ActnCtrls, ActnMenus, RibbonActnMenus, ShellApi;

const
  CampoPermissaoModulo = 'c_mod_sip';
  CampoFormModulos = 'c_mod_sip';
  NomeModulo = 'SISTEMA PEDIDOS';

type
  TFPrincipal = class(TForm)
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
    MFEventos: TMenuItem;
    MFProfissoes: TMenuItem;
    MFSituacoesClientes: TMenuItem;
    MFClientes: TMenuItem;
    MFRegiaoVenda: TMenuItem;
    Ajuda1: TMenuItem;
    ndice1: TMenuItem;
    Bloquear1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    MClientes: TMenuItem;
    N13: TMenuItem;
    N27: TMenuItem;
    ProprietrioProduto1: TMenuItem;
    TipoAgendamento1: TMenuItem;
    N15: TMenuItem;
    CadastroRpido1: TMenuItem;
    BaseDados: TSQLConnection;
    BancodeDados1: TMenuItem;
    ImportaoDados1: TMenuItem;
    BaseDadosMatriz: TSQLConnection;
    ActionManager1: TActionManager;
    Clientes: TAction;
    Importacao: TAction;
    MExportacao: TAction;
    Pedido: TAction;
    ImageList1: TImageList;
    Ribbon: TRibbon;
    PDigitaca: TRibbonPage;
    RibbonGroup1: TRibbonGroup;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    RibbonQuickAccessToolbar1: TRibbonQuickAccessToolbar;
    RibbonGroup2: TRibbonGroup;
    MConsultaPedidos: TAction;
    ImageGrandes: TImageList;
    RibbonGroup3: TRibbonGroup;
    MFechar: TAction;
    RibbonGroup4: TRibbonGroup;
    Consultar: TMenuItem;
    MConsulltaCodigo: TMenuItem;
    ConsCodigo: TAction;
    TabelasImportacao: TAction;
    Exportacao: TAction;
    Action1: TAction;
    Exporta: TAction;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    Panel1: TPanel;
    Label1: TLabel;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Ajuda1Click(Sender: TObject);
    procedure ndice1Click(Sender: TObject);
    procedure MFecharExecute(Sender: TObject);
    procedure ExportaExecute(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    TipoSistema : string;
    UnPri : TFuncoesPrincipal;
    FunImpressaoRel: TImpressaoRelatorio;
    FunEcf : TRBFuncoesECF;
    procedure ConfiguraPermissaoUsuario;
    function VerificaDataUltimaImportacao : boolean;
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
     function ConfiguraBaseInicialRepresentante : Boolean;
  end;


var
  FPrincipal: TFPrincipal;
  Ini : TInifile;

implementation

uses Constantes, UnRegistro, funsql,FunSistema, UnClientes, UnCrystal,
     Abertura, AAlterarSenha, ASobre, FunIni, AAlterarFilialUso,
  AAlteraEstagioProposta, AConsultaPrecosProdutos, ALocalizaServico, AClientes,
  AProdutos, UnVersoes, UnContasApagar, UnNotafiscal, AImportacaoDados, AExportacaoDados, ANovaCotacao, ACotacao,
  AConsultaCodigoRepresentante, ANovaTabelaImportacaoRepresentante, Fundata, FunValida, AVersaoDesatualizada;


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
  Application.Title := 'Sistema Pedidos';  // nome a ser mostrado na barra de tarefa do Windows
  Application.OnException := Erro;
  Application.OnMessage := Abre;
  Application.OnShortCut := TeclaPressionada;
  varia.VersaoSistema := VersaoSistemaPedido;
  Sistema := TRBFuncoesSistema.cria(FPrincipal.BaseDados);
end;

{******************************************************************************}
procedure TFPrincipal.ConfiguraPermissaoUsuario;
begin
  Varia.EscondeMenus(Menu,false);

//   AlterarVisibleDet([MRelatorios],true);
//   FunImpressaoRel.CarregarMenuRel(mrCRM,MRelatorios);

  if (puAdministrador in varia.PermissoesUsuario) or (puCRCompleto in varia.PermissoesUsuario) then
  begin
    varia.EscondeMenus(Menu,true);
//    FunImpressaoRel.CarregarMenuRel(mrPontoLoja,MRelatorios);
  end
  else
  begin
    if (puConsultarCliente in varia.PermissoesUsuario) then
    if (puClienteCompleto in varia.PermissoesUsuario) then
      AlterarVisibleDet([N13,MFProfissoes,MFEventos,MFRegiaoVenda,MFSituacoesClientes],true);
  end;
end;

{************ abre base de dados ********************************************* }
function TFPrincipal.AbreBaseDados( Alias : string ) : Boolean;
begin
  Result := true;
  if UpperCase(Alias) <> 'SISCORP' then
  begin
    BaseDados.close;
    BaseDados.Params.clear;
    BaseDados.Params.add('drivername=Oracle');
    BaseDados.Params.add('Database=SisCorp');
    BaseDados.Params.add('decimal separator=,');
    BaseDados.Params.add('Password=1298');
    BaseDados.Params.add('User_Name='+Alias);
    BaseDados.Open;
  end;
end;

function TFPrincipal.AbreBaseDadosMatriz(Alias: string): Boolean;
begin
  Result := true;
  BaseDadosMatriz.close;
  BaseDadosMatriz.Params.clear;
  BaseDadosMatriz.Params.add('drivername=Oracle');
  BaseDadosMatriz.Params.add('Database=SisCorpMatriz');
  BaseDadosMatriz.Params.add('decimal separator=,');
  BaseDadosMatriz.Params.add('Password=1298');
  BaseDadosMatriz.Params.add('User_Name=SYSTEM');
//  BaseDadosMatriz.Params.add('User_Name=franz');
//  BaseDadosMatriz.Params.add('User_Name='+Alias);
  try
    BaseDadosMatriz.Open;
  except
    BaseDadosMatriz.close;
    BaseDadosMatriz.Params.clear;
    BaseDadosMatriz.Params.add('drivername=Oracle');
    BaseDadosMatriz.Params.add('Database=SisCorpMatrizLocal');
    BaseDadosMatriz.Params.add('decimal separator=,');
    BaseDadosMatriz.Params.add('Password=1298');
    BaseDadosMatriz.Params.add('User_Name=SYSTEM');
  end;
end;

procedure TFPrincipal.erro(Sender: TObject; E: Exception);
begin
  Aviso(E.Message);
end;

procedure TFPrincipal.ExportaExecute(Sender: TObject);
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
  VerificaDataUltimaImportacao;
end;

procedure TFPrincipal.Label1Click(Sender: TObject);
var
   URL : String;
begin
   URL := 'www.eficaciaconsultoria.com.br';
   ShellExecute(handle, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

// -------------------- Altera o Caption da Jabela Proncipal ------------------ }
procedure TFPrincipal.AlteraNomeEmpresa;
begin
  UnPri.AlteraNomeEmpresa(self, BarraStatus, NomeModulo,IntToStr(Varia.CodVendedorSistemaPedidos) );
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
function TFPrincipal.VerificaDataUltimaImportacao : Boolean;
begin
  result := true;
  if DiasPorPeriodo(varia.DatUltimaImportacao,date) > 5 then
  begin
    result := false;
    aviso('INFORMAÇÕES DESATUALIZADAS!!!'#13'A ultima importação dos dados foi realizada dia "'+FormatDateTime('DD/MM/YYYY',Varia.DatUltimaImportacao)+'".'+
          '. É permitido ficar no máximo 5 dias sem importar os dados. Faça uma nova importação total dos dados.');
  end;
end;

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
//  if Varia.GrupoUsuarioMaster <> Varia.GrupoUsuario then
//    AlterarEnabledDet(botoes,false);
end;

{************************  M E N U   D O   S I S T E M A  ********************* }
procedure TFPrincipal.MenuClick(Sender: TObject);
begin
  if Sender is TComponent  then
  begin
    if ((Sender as TComponent).Tag = 2750) or
       ((Sender as TComponent).Tag = 2800) or
       ((Sender as TComponent).Tag = 2900) then
    begin
      if not VerificaDataUltimaImportacao then
        exit;
    end;

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
      2750 : begin
               FClientes := TFClientes.criarSDI(application, '',VerificaPermisao('FClientes'));
               FClientes.ShowModal;
               FClientes.free;
             end;
      2800 : begin
               FNovaCotacao := TFNovaCotacao.CriarSDI(self,'',true);
               FNovaCotacao.NovaCotacao;
               FNovaCotacao.free;
             end;
      2900 : begin
               FCotacao := TFCotacao.CriarSDI(self,'',true);
               FCotacao.ShowModal;
               FCotacao.Free;
             end;
      3200 : FProdutos := TFProdutos.criarMDI(Application,Varia.CT_Areax,Varia.CT_AreaY,VerificaPermisao('FProdutos'));
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
      5100 : begin
              FConsultaCodigoRepresentante := TFConsultaCodigoRepresentante.criarSDI(Self, '', true);
              FConsultaCodigoRepresentante.ShowModal;
             end;
      5200 : begin
              FNovaTabelaImportacaoRepresentante := TFNovaTabelaImportacaoRepresentante.criarSDI(Self, '', true);
              FNovaTabelaImportacaoRepresentante.ShowModal;
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
end;

procedure TFPrincipal.MFecharExecute(Sender: TObject);
begin

end;

{******************* configura os modulos do sistema ************************* }
function TFPrincipal.ConfiguraBaseInicialRepresentante: Boolean;
var
  VpfArquivo : TIniFile;
  VpfVendedor : string;
  VpfIndTodos : Boolean;
begin
  result := true;
  if OpenDialog1.Execute then
  begin
    VpfArquivo := TIniFile.Create(OpenDialog1.FileName);
    VpfVendedor := Descriptografa(VpfArquivo.ReadString('860384848547fgfqt','847085548477kiq',''));
    if VpfVendedor <> '' then
      varia.CodVendedorSistemaPedidos := StrToInt(VpfVendedor)
    else
      result := false;
    Config.ImportarTodosVendedores := Descriptografa(VpfArquivo.ReadString('860384848547fgfqtgu','858985548477qu',''))= 'todos';
    if result then
      Sistema.ConfiguraVendedorSistemaPedido(Varia.CodVendedorSistemaPedidos,Config.ImportarTodosVendedores);
    VpfArquivo.Free;
  end
  else
    result := false;
end;

{******************* configura os modulos do sistema ************************* }
procedure TFPrincipal.ConfiguracaoModulos;
var
  Reg : TRegistro;
begin
  ConfiguraPermissaoUsuario;
  ConfiguraFilial;

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

end.
