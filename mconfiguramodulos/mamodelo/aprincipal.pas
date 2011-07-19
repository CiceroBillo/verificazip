unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, Tabela, Localizacao,
  Mask;

const
  CampoPermissaoModulo = 'c_mod_cai';
  NomeModulo = 'Caixa';

type
  TFPrincipal = class(TFormularioFundo)
    Menu: TMainMenu;
    MAlterarSenhas: TMenuItem;
    MAjuda: TMenuItem;
    BaseDados: TDatabase;
    BarraStatus: TStatusBar;
    Mjanela: TMenuItem;
    MCascata: TMenuItem;
    MLadoaLado: TMenuItem;
    MArquivo: TMenuItem;
    MSair: TMenuItem;
    N1: TMenuItem;
    MSobre: TMenuItem;
    MNormal: TMenuItem;
    MAlterarFilial: TMenuItem;
    CorFoco: TCorFoco;
    CorForm: TCorForm;
    CorPainelGra: TCorPainelGra;
    MAlterarUsuario: TMenuItem;
    Permissao: TQuery;
    VerificaForm: TQuery;
    CadUsuarios: TTable;
    CadUsuariosC_NOM_LOG: TStringField;
    CadUsuariosC_SEN_USU: TStringField;
    CadUsuariosL_INI_USU: TMemoField;
    aux: TQuery;
    aux1: TQuery;
    N6: TMenuItem;
    N7: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    BCascata: TSpeedButton;
    BLadoaLado: TSpeedButton;
    BNormal: TSpeedButton;
    ToolButton1: TToolButton;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
  private
    TipoSistema : string;
    Procedure CarregaNomeForms;
  public
     ImagemPrincipal : integer;
     procedure AlteraNomeEmpresa;
     procedure ConfiguraMenus;
     procedure ConfigUsu( dados : TDataSet);
     procedure EliminaItemsMenu;
     procedure RetornaItemsMenu;
     Function  VerificaPermisao( nome : string ) : Boolean;
     procedure erro(Sender: TObject; E: Exception);
     procedure abre(var Msg: TMsg; var Handled: Boolean);
     procedure VerificaMoeda;
     procedure ValidaBotoesGrupos( botoes : array of TComponent);
     procedure MudaVisibilidadeMenu(Estado : Boolean);
  end;


var
  FPrincipal: TFPrincipal;
  Ini : TInifile;

implementation

uses Abertura, AAlterarSenha, ASobre, FunIni, AAlterarFilialUso,
     Constantes, UnRegistro;


{$R *.DFM}

// -------------------------------------------------------------------------------------- //
// Somente para uso em tempo de desenvolvimento para atualizacao dos Formulario Permissao //
// -------------------------------------------------------------------------------------- //

procedure TFPrincipal.carregaNomeForms;

 function localiza( nome : string ) : boolean;
 begin
   aux1.close;
   aux1.sql.clear;
   aux1.sql.Add('select - from cadFormularios where c_cod_fom = ''' + nome + '''');
   aux1.open;
   result :=  aux1.eof;
 end;

var
  laco : integer;
begin

  aux.close;
  aux.sql.clear;
  aux.sql.Add('select - from cadFormularios ');
  aux.open;

  for laco := 0 to screen.FormCount - 1 do
  begin
     if localiza(screen.Forms[laco].Name) then
     begin
        aux.Insert;
        aux.FieldByName('c_cod_fom').Value := screen.Forms[laco].Name;
        aux.Post;
     end;
  end;
  aux.close;
end;

{ ##############################################################################
                      Configuracao do usuários
############################################################################## }

// --------- Carrega as configuracoes do usuario ------------------------------ //
procedure TFPrincipal.ConfigUsu( dados : TDataSet);
begin
try
  ImagemPrincipal := ConfiguraSituacaoImagem(dados.FieldByName('C_SIS_IMA').AsString);
  CorFoco.AFonteComponentes.Color := stringToColor(dados.FieldByName('C_EFO_COR').AsString);
  CorFoco.AFonteComponentes.Size := dados.FieldByName('I_EFO_TAM').AsInteger;
  CorFoco.AFonteComponentes.Name := dados.FieldByName('C_EFO_NOM').AsString;
  CorFoco.AFonteComponentes.Style := montaAtributosFonte(dados.FieldByName('C_EFO_ATR').AsString);
  CorFoco.AFundoComponentes := StringToColor(dados.FieldByName('C_EFU_COR').AsString);
  CorFoco.ACorFundoFoco := stringToColor(dados.FieldByName('C_EFF_COR').AsString);
  CorFoco.ACorObrigatorio := stringToColor(dados.FieldByName('C_EFF_FCO').AsString);
  CorFoco.ACorFonteFoco := stringToColor(dados.FieldByName('C_EFO_FCO').AsString);

  CorFoco.AFonteTituloGrid.Color := stringToColor(dados.FieldByName('C_GFO_COR').AsString);
  CorFoco.AFonteTituloGrid.Size := dados.FieldByName('I_GFO_TAM').AsInteger;
  CorFoco.AFonteTituloGrid.Name := dados.FieldByName('C_GFO_NOM').AsString;
  CorFoco.AFonteTituloGrid.Style := montaAtributosFonte(dados.FieldByName('C_GFO_ATR').AsString);
  CorFoco.ACorTituloGrid := StringToColor(dados.FieldByName('C_GTI_COR').AsString);

  CorForm.AFonteForm.Color := StringToColor(dados.FieldByName('C_SFO_COR').AsString);
  CorForm.AFonteForm.Size := dados.FieldByName('I_SFO_TAM').AsInteger;
  CorForm.AFonteForm.Name := dados.FieldByName('C_SFO_NOM').AsString;
  CorForm.AFonteForm.Style :=  MontaAtributosFonte(dados.FieldByName('C_SFO_ATR').AsString);
  CorForm.ACorPainel := StringToColor(dados.FieldByName('C_SPA_COR').AsString);

  CorPainelGra.Alignment := RetornaAlinhamentoTexto(dados.FieldByName('I_TIT_ALI').AsInteger);
  CorPainelGra.AColorSombra := StringToColor(dados.FieldByName('C_TCO_SOM').AsString);
  CorPainelGra.AColorInicio := StringToColor(dados.FieldByName('C_TCO_INI').AsString);
  CorPainelGra.AColorFim := StringToColor(dados.FieldByName('C_TCO_FIM').AsString);
  CorPainelGra.AEfeitosTexto := RetornaEfeitoTexto(dados.FieldByName('I_TIT_TEX').AsInteger);
  CorPainelGra.AEfeitosDeFundos := RetornaFundoTitulo(dados.FieldByName('I_TIT_FUN').AsInteger);
  CorPainelGra.Font.Color := StringToColor(dados.FieldByName('C_TFO_COR').AsString);
  CorPainelGra.Font.Size := dados.FieldByName('I_TFO_TAM').AsInteger;
  CorPainelGra.Font.Name := dados.FieldByName('C_TFO_NOM').AsString;
  CorPainelGra.Font.Style := MontaAtributosFonte(dados.FieldByName('C_TFO_ATR').AsString);

  FPrincipal.color := StringToColor(dados.FieldByName('C_SIS_COR').AsString);
  if (FileExists(dados.FieldByName('C_SIS_PAP').AsString)) and (dados.FieldByName('C_SIS_IMA').AsString <> 'NENHUM') then
  begin
     FPrincipal.Image1.Picture.LoadFromFile(dados.FieldByName('C_SIS_PAP').AsString);
     FPrincipal.Desenha(dados.FieldByName('C_SIS_IMA').AsString);
  end;
except
end;
end;

// ------------- Elimina itens de menu conforme tabela MovGrupoForm -------------- //
procedure TFPrincipal.EliminaItemsMenu;
begin
 Permissao.close;
 Permissao.sql.Clear;
 Permissao.SQL.Add('Select MG.C_COD_FOM, CF.C_NOM_MEN, CF.C_NOM_FOM, MG.I_COD_GRU, MG.I_EMP_FIL from dba.MovGrupoForm as MG, dba.CadFormularios  as CF  '+
                   'where MG.I_EMP_FIL = ' + IntToStr(Varia.codigoEmpFil) +
                   ' and MG.I_COD_GRU = ' + IntToStr(Varia.GrupoUsuario) +
                   ' and MG.C_COD_FOM = CF.C_COD_FOM');
 Permissao.open;

 Permissao.First;
 while not Permissao.EOF do
 begin
    if Permissao.fieldByname('C_NOM_MEN').AsString <> '' then

      if (FPrincipal.FindComponent(Permissao.fieldByname('C_NOM_MEN').value) is TMenuItem) then
        (FPrincipal.FindComponent(Permissao.fieldByname('C_NOM_MEN').value) as TMenuItem).Visible := false;
   Permissao.Next;
 end;
end;

// ------------- Retorna itens de menu conforme tabela MovGrupoForm -------------- //
procedure TFPrincipal.RetornaItemsMenu;
begin
 Permissao.First;
 while not Permissao.EOF do
 begin
    if Permissao.fieldByname('C_NOM_MEN').AsString <> '' then
      if (FPrincipal.FindComponent(Permissao.fieldByname('C_NOM_MEN').value) is TMenuItem) then
        (FPrincipal.FindComponent(Permissao.fieldByname('C_NOM_MEN').value) as TMenuItem).Visible := true;
   Permissao.Next;
 end;
end;

// ----- Verifica a permissão do formulários conforme tabela MovGrupoForm -------- //
Function TFPrincipal.VerificaPermisao( nome : string ) : Boolean;
begin
  result := true;
  VerificaForm.close;
  VerificaForm.sql.Clear;
  VerificaForm.sql.Add('Select C_COD_FOM, I_COD_GRU, I_EMP_FIL from dba.MovGrupoForm '+
                       'where I_EMP_FIL = ' + IntToStr(Varia.codigoEmpFil) +
                       ' and I_COD_GRU = ' + IntToStr(Varia.GrupoUsuario) +
                       ' and C_COD_FOM = ''' +  Nome + '''');

  VerificaForm.open;
  VerificaForm.First;
  if not VerificaForm.EOF then
  begin
    aviso(CT_PermissaoNegada);
    result := false;
    abort;
  end;
end;



// ------------------ Mostra os comentarios ma barra de Status ---------------- }
procedure TFPrincipal.MostraHint(Sender : TObject);
begin
  BarraStatus.Panels[3].Text := Application.Hint;
end;

// ------------------ Na criação do Formulário -------------------------------- }
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
 Varia := TVariaveis.Create;   // classe das variaveis principais
 Faixas := TFaixas.Create;     // classe das varias de faixas de cadastros
 Config := TConfig.Create;     // Classe das variaveis Booleanas
 ConfigModulos := TConfigModulo.create; // classe que configura os modulos.

 AbreBancoDados(BaseDados);
 Application.OnHint := MostraHint;
 Application.HintColor := $00EDEB9E;        // cor padrão dos hints
 Application.Title := 'Sistema Gerencial';  // nome a ser mostrado na barra de tarefa do Windows
 Application.OnException := Erro;
 Application.OnMessage := Abre;
end;

procedure TFPrincipal.erro(Sender: TObject; E: Exception);
begin
  Aviso(E.Message);
end;

// ------------------- Quando o formulario e fechado -------------------------- }
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  VerificaForm.close;
  Permissao.close;
  BaseDados.Close;
  Varia.Free;
  Faixas.Free;
  Config.Free;
  ConfigModulos.Free;
  Action := CaFree;
end;

// -------------------- Quando o Formulario é Iniciado ------------------------ }
procedure TFPrincipal.FormShow(Sender: TObject);
var
  reg : TRegistro;
begin
 reg := TRegistro.create;
 reg.ValidaModulo( TipoSistema, [] );
 reg.ConfiguraModuloCaixa(nil,nil);
 reg.Free;
 AlteraNomeEmpresa;
 FPrincipal.WindowState := wsMaximized;  // coloca a janela maximizada;
 EliminaItemsMenu;
end;

// -------------------- Altera o Caption da Jabela Proncipal ------------------ }
procedure TFPrincipal.AlteraNomeEmpresa;
begin
   self.caption := NomeSistema +  VersaoSistema + ' - ' + NomeModulo + '[ ' + TipoSistema + ' ]';
   BarraStatus.Panels[0].Text := ' Filial : ' + Varia.NomeFilial ;
   BarraStatus.Panels[1].Text := ' Usuário : ' + Varia.NomeUsuario;
   BarraStatus.Panels[2].Text := ' Moeda : ' + dateToStr(varia.DataDaMoeda)
end;

// -------------------- Configura os menus do Sistema ------------------------- }
procedure TFPrincipal.ConfiguraMenus;
begin
if screen.FormCount = 2 then
begin
  AlterarenabledDet([BCascata,BLadoaLado,BNormal], true);
  AlterarenabledDet([MAlterarFilial,MAlterarUsuario,MSair], false);
  AlterarVisibleDet([Mjanela], true);
end
else
    if screen.FormCount = 1 then
    begin
      AlterarenabledDet([BCascata,BLadoaLado,BNormal], false);
      AlterarenabledDet([MAlterarFilial,MAlterarUsuario,MSair], true);
      AlterarVisibleDet([Mjanela], false);
    end;
end;

// -----------------------Muda a Visibilidade dos menus------------------------------ //
procedure TFPrincipal.MudaVisibilidadeMenu(Estado : Boolean);
var
   Laco : Integer;
begin
   CoolBar1.Visible := Estado;
   for Laco := 0 to Menu.Items.Count - 1 do
   begin
      Menu.Items[Laco].Visible := Estado;
   end;
end;


// -------------Quando é enviada a menssagem de criação de um formulario------------- //
procedure TFPrincipal.abre(var Msg: TMsg; var Handled: Boolean);
begin
if (Msg.message = CT_CRIAFORM) or (Msg.message = CT_DESTROIFORM) then
begin
  ConfiguraMenus;
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
    1200 : begin
             // ----- Formulario para alterar o usuario atual ----- //
             FAbertura := TFAbertura.Create(Application);
             FAbertura.ShowModal;
             if Varia.StatusAbertura = 'OK' then
             begin
               AlteraNomeEmpresa;
               RetornaItemsMenu;
               EliminaItemsMenu;
             end;
           end;
           // ----- Sair do Sistema ----- //
    1300 : Close;
           // ----- Formulario de Empresas ----- //
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
  end;
end;


end.
