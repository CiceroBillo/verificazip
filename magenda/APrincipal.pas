unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, LabelCorMove, PainelGradiente, ExtCtrls, Icones, Menus, Buttons, Shellapi,
  DBTables, Componentes1, IniFiles, Registry, Db, Psock, NMFtp;

const
  CampoPermissaoModulo = 'C_MOD_AGE';
  CampoFormModulos = 'C_MOD_AGE';
  NomeModulo = 'AgendaSiscorp';

type
  TFPrincipal = class(TForm)
    IconeBarraStatus1: TIconeBarraStatus;
    PopupMenu1: TPopupMenu;
    Sair1: TMenuItem;
    BaseDados: TDatabase;
    CorFoco: TCorFoco;
    CorPainelGra: TCorPainelGra;
    MVisualizarAgenda: TMenuItem;
    N3: TMenuItem;
    TempoAgenda: TTimer;
    Agenda: TQuery;
    CorForm: TCorForm;
    BaseEndereco: TDatabase;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sair1Click(Sender: TObject);
    procedure TempoAgendaTimer(Sender: TObject);
    procedure MVisualizarAgendaClick(Sender: TObject);
  private
    procedure VerificaAgendamento;
  public
    { Public declarations }
    VplParametroBaseDados: String;
    procedure VerificaMoeda;
    function VerificaPermisao(VpaNomFomrulario :String):Boolean;
    function AbreBaseDados( Alias : string ) : Boolean;
  end;

var
  VglParametroOficial : String;
  FPrincipal: TFPrincipal;

implementation

Uses FunString, Constantes, FunObjeto, Abertura, FunValida,ConstMsg, FunArquivos, funSql,
  AMenssagemAtualizando, AAgendamentos, UnClientes, UnCrystal, UnProdutos,
  UnSistema;
{$R *.DFM}

{****************** quando o formulario é criado ******************************}
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  FunClientes := TRBFuncoesClientes.cria;
  FunCrystal := TRBFuncoesCrystal.cria;
  Sistema := TRBFuncoesSistema.cria;
  IconeBarraStatus1.AAtiva := true;

  Varia := TVariaveis.Cria;   // classe das variaveis principais
  Config := TConfig.Create;     // Classe das variaveis Booleanas
  ConfigModulos := TConfigModulo.create; // classe das variaveis de configuracao do modulo.
  Brush.Style := bsclear;
  Top := -300;
end;

{******************** quando o formulario é mostrado **************************}
procedure TFPrincipal.FormShow(Sender: TObject);
var
  H : HWnd;
begin
  //esconte o botão da barra de tarefas quando o programa estiver executando
  H := FindWindow(Nil,'AgendaSisCorp');
  if H <> 0 then
    ShowWindow(H,SW_HIDE);
  TempoAgenda.Enabled := true;
  TempoAgendaTimer(tempoAgenda);
end;

{****************** quando o formulario e fechado *****************************}
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Sistema.free;
  BaseDados.Close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos do menu suspensos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************** abre base de dados **************************************}
function TFPrincipal.AbreBaseDados( Alias : string ) : Boolean;
var
  VpfErro : String;
begin
  BaseDados.AliasName :=  Alias;
  result := AbreDataBase(BaseDados,'DBA','9774',VpfErro);
  if not result then
    aviso(CT_AberturaBaseDados+#13#13+VpfErro);
  FunProdutos := TFuncoesProduto.criar(self,BaseDados);
end;

{******************************************************************************}
function TFPrincipal.VerificaPermisao(VpaNomFomrulario :String):Boolean;
begin
  result := true;
end;

{******************************************************************************}
procedure TFPrincipal.VerificaAgendamento;
begin
  AdicionaSQLAbreTabela(Agenda,'Select * from AGENDA '+
                               ' Where DATINICIO <= dateformat('''+FormatDateTime('YYYY/MM/DD HH:MM',now)+''',''YYYY/MM/DD HH:MM'')'+
                               ' and CODUSUARIO = '+IntToStr(Varia.CodigoUsuario)+
                               ' and INDREALIZADO = ''N'''+
                               ' and INDCANCELADO = ''N''');
  if not Agenda.Eof then
  begin
    TempoAgenda.Enabled := false;
    FAgendamentos := TFAgendamentos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendamentos'));
    FAgendamentos.VerificaAgendamentoUsuario;
    FAgendamentos.free;
    TempoAgenda.Enabled := true;
  end;
  Agenda.close;
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
{******************************************************************************}
procedure TFPrincipal.Sair1Click(Sender: TObject);
begin
  close;
end;

procedure TFPrincipal.TempoAgendaTimer(Sender: TObject);
begin
  VerificaAgendamento;
end;

procedure TFPrincipal.MVisualizarAgendaClick(Sender: TObject);
begin
  TempoAgenda.Enabled := false;
  FAgendamentos := TFAgendamentos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendamentos'));
  FAgendamentos.Agenda;
  FAgendamentos.free;
  TempoAgenda.Enabled := true;
end;

end.
