unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, LabelCorMove, PainelGradiente, ExtCtrls, Icones, Menus, Buttons, Shellapi,
  DBTables, Componentes1, IniFiles, Registry, Db, Uncotacao,UnContasAreceber, Unclientes,
  Unprodutos, UnNotaFiscal, UnSistema, WideStrings, SqlExpr, DBXOracle;

const
  NomeModulo = 'Siscorp';

type
  TFPrincipal = class(TForm)
    IconeBarraStatus1: TIconeBarraStatus;
    Panel1: TPanel;
    BFaturamento: TBitBtn;
    BSair: TBitBtn;
    BarraLateral: TPainelGradiente;
    LUsuario: TLabel;
    CorFoco: TCorFoco;
    CorPainelGra1: TCorPainelGra;
    CorPainelGra: TCorPainelGra;
    CorFoco1: TCorFoco;
    CorForm: TCorForm;
    BaseDados : TSQLConnection;
    procedure FormCreate(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure IconeBarraStatus1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    VprAtualizarSistema : Boolean;
    VprAlinhamento : integer; // 0 direita, 1 esquerda, 2 top, 3 base
    function UsuarioOk : boolean;
  public
    { Public declarations }
    VplParametroBaseDados: String;
    function AbreBaseDados( Alias : string ) : Boolean;
    function VerificaPermisao(VpaNome : String): boolean;
  end;

var
  VglParametroOficial : String;
  FPrincipal: TFPrincipal;
  CampoPermissaoModulo : String;
  CampoFormModulos : String;

implementation

Uses FunString, Constantes, FunObjeto, Abertura, FunValida,ConstMsg, FunArquivos, funSql,
  AMenssagemAtualizando, AFaturamentoDiario;
{$R *.DFM}

{****************** quando o formulario é criado ******************************}
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  IconeBarraStatus1.AAtiva := true;
  IconeBarraStatus1.AVisible := true;

  Varia := TVariaveis.Cria(BAseDAdos);   // classe das variaveis principais
  Config := TConfig.Create;     // Classe das variaveis Booleanas
  ConfigModulos := TConfigModulo.create; // classe das variaveis de configuracao do modulo.
  Sistema := TRBFuncoesSistema.cria(BAseDados);

end;

{******************** quando o formulario é mostrado **************************}
procedure TFPrincipal.FormShow(Sender: TObject);
var
  H : HWnd;
begin
  //esconte o botão da barra de tarefas quando o programa estiver executando
  H := FindWindow(Nil,'Faturamentodiario');
  if H <> 0 then
    ShowWindow(H,SW_HIDE);
end;

{****************** quando o formulario e fechado *****************************}
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BaseDados.Close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos do menu suspensos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************** abre base de dados **************************************}
function TFPrincipal.AbreBaseDados( Alias : string ) : Boolean;
begin
  result := true;
end;

{******************************************************************************}
function TFPrincipal.VerificaPermisao(VpaNome : String): boolean;
begin

end;

{***************** verifica se o usuario esta ok ******************************}
function TFPrincipal.UsuarioOk : boolean;
var
  VpfAcao : Boolean;
begin
  result := false;
  VpfAcao := true;
  if not BaseDados.Connected Then
    VpfAcao :=  AbreBaseDados(VplParametroBaseDados);
  if VpfAcao Then
  begin
    FAbertura := TFAbertura.Create(Application);
    FAbertura.ShowModal;
    FAbertura.free;
    if Varia.StatusAbertura = 'OK' then
    begin
      result := true;
    end
  end;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos dos botoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************** sai fora do formulario ********************************}
procedure TFPrincipal.Sair1Click(Sender: TObject);
begin
 close;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{************** quando é presssionada algum botao ou menu *********************}
procedure TFPrincipal.MenuClick(Sender: TObject);
var
  VpfHandleSistema : THandle;
  VpfModulo : string;
begin
  if (Sender is TComponent) then
  begin
    case TComponent(Sender).Tag of
      2 : begin
            CampoPermissaoModulo := 'c_mod_fat';
            VpfModulo := 'Faturamento.exe';
          end;
    end;
    CampoFormModulos := CampoPermissaoModulo;
    if UsuarioOk Then
    begin
      FunCotacao.free;
      FunCotacao := TFuncoesCotacao.Cria(BaseDados);
      FunClientes.free;
      FunClientes := TRBFuncoesClientes.cria(BaseDados);
      FunNotaFiscal.free;
      FunNotaFiscal := TFuncoesNotaFiscal.criar(self,BaseDados);
      FunProdutos.free;
      FunProdutos := TFuncoesProduto.criar(self,basedados);
      FunContasaREceber := TFuncoesContasAReceber.Cria(BaseDados);

      FFaturamentoDiario := TFFaturamentoDiario.Create(self);
      FFaturamentoDiario.RodaFaturamentoDiario;
    end;
  end;
end;


{********************* ativa a tela da aplicação ******************************}
procedure TFPrincipal.IconeBarraStatus1Click(Sender: TObject);
begin
  Application.BringToFront;
end;


end.
