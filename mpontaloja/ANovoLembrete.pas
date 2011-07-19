unit ANovoLembrete;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, StdCtrls, Buttons, Localizacao,
  ComCtrls, UnDados, UnLembrete, Constantes;

type
  TFNovoLembrete = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    EData: TEditColor;
    EUsuario: TEditLocaliza;
    Localiza: TConsultaPadrao;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    CAgendar: TCheckBox;
    EDatAgendamento: TCalendario;
    Label4: TLabel;
    PanelColor4: TPanelColor;
    RSelecionarTodos: TRadioButton;
    RSelecionar: TRadioButton;
    BSelecionarUsuarios: TBitBtn;
    Label5: TLabel;
    ETitulo: TEditColor;
    Label6: TLabel;
    EDescricao: TMemoColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure RSelecionarTodosClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BSelecionarUsuariosClick(Sender: TObject);
  private
    VprOperacao: TRBDOperacaoCadastro;
    VprAcao: Boolean;
    VprDLembreteCorpo: TRBDLembreteCorpo;
    FunLembrete: TRBFuncoesLembrete;
    procedure InicializaClasse;
    procedure CarDTela;
    function DadosValidos: String;
    procedure CarDClasse;
    procedure BloquearTela(VpaEstado: Boolean);
  public
    function AlterarLembrete(VpaSeqLembrete, VpaCodUsuario: Integer): Boolean;
    function NovoLembrete: Boolean;
    procedure LerLembrete(VpaSeqLembrete, VpaCodUsuario: Integer);
  end;

var
  FNovoLembrete: TFNovoLembrete;

implementation
uses
  APrincipal, ConstMsg, FunData, ASelecionarUsuarios, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoLembrete.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  FunLembrete:= TRBFuncoesLembrete.Cria(FPrincipal.BaseDados);
  VprDLembreteCorpo:= TRBDLembreteCorpo.Cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoLembrete.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunLembrete.Free;
  VprDLembreteCorpo.Free;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFNovoLembrete.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
function TFNovoLembrete.NovoLembrete: Boolean;
begin
  VprOperacao:= ocInsercao;
  InicializaClasse;
  CarDTela;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFNovoLembrete.InicializaClasse;
begin
  VprDLembreteCorpo.SeqLembrete:= 0;
  VprDLembreteCorpo.CodUsuario:= Varia.CodigoUsuario;
  VprDLembreteCorpo.DatLembrete:= Now;
  VprDLembreteCorpo.DatAgenda:= IncDia(VprDLembreteCorpo.DatLembrete,1);
  VprDLembreteCorpo.IndAgendar:= 'S';
  VprDLembreteCorpo.IndTodos:= 'S';
  VprDLembreteCorpo.DesTitulo:= '';
  VprDLembreteCorpo.DesLembrete:= '';
end;

{******************************************************************************}
procedure TFNovoLembrete.CarDTela;
begin
  EData.Text:= FormatDateTime('DD/MM/YYYY HH:MM',VprDLembreteCorpo.DatLembrete);
  EUsuario.AInteiro:= VprDLembreteCorpo.CodUsuario;
  EUsuario.Atualiza;
  CAgendar.Checked:= (VprDLembreteCorpo.IndAgendar = 'S');
  EDatAgendamento.DateTime:= VprDLembreteCorpo.DatAgenda;
  RSelecionarTodos.Checked:= False;
  RSelecionar.Checked:= False;
  if VprDLembreteCorpo.IndTodos = 'S' then
    RSelecionarTodos.Checked:= True
  else
    RSelecionar.Checked:= True;
  RSelecionarTodosClick(RSelecionarTodos);
  ETitulo.Text:= VprDLembreteCorpo.DesTitulo;
  EDescricao.Text:= VprDLembreteCorpo.DesLembrete;
end;

{******************************************************************************}
procedure TFNovoLembrete.RSelecionarTodosClick(Sender: TObject);
begin
  BSelecionarUsuarios.Enabled:= RSelecionar.Checked;
  if RSelecionarTodos.Checked and (VprOperacao in [ocInsercao,ocEdicao]) then
    FreeTObjectsList(VprDLembreteCorpo.Usuarios);
end;

{******************************************************************************}
procedure TFNovoLembrete.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= DadosValidos;
  if VpfResultado = '' then
  begin
    CarDClasse;
    VpfResultado:= FunLembrete.GravaDLembrete(VprDLembreteCorpo);
    if VpfResultado = '' then
    begin
      VprAcao:= True;
      Close;
    end;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFNovoLembrete.DadosValidos: String;
begin
  Result:= '';
  if ETitulo.Text = '' then
  begin
    Result:= 'TÍTULO NÃO PREENCHIDO!!!'#13'É necessário preencher o título do lembrete.';
    ActiveControl:= ETitulo;
  end
  else
    if EDescricao.Text = '' then
    begin
      Result:= 'DESCRIÇÃO NÃO PREENCHIDA!!!'#13'É necessário preencher a descrição do lembrete.';
      ActiveControl:= EDescricao;
    end
    else
      if VprDLembreteCorpo.Usuarios.Count < 0 then
      begin
        Result:= 'SEM USUÁRIOS SELECIONADOS!!!'#13'É necessário selecionar pelo menos um usuário.';
        ActiveControl:= PanelColor4;
      end
end;

{******************************************************************************}
procedure TFNovoLembrete.CarDClasse;
begin
  VprDLembreteCorpo.DatAgenda:= MontaData(1,1,1900);
  if CAgendar.Checked then
  begin
    VprDLembreteCorpo.IndAgendar:= 'S';
    VprDLembreteCorpo.DatAgenda:= EDatAgendamento.DateTime;
  end
  else
    VprDLembreteCorpo.IndAgendar:= 'N';
  if RSelecionarTodos.Checked then
    VprDLembreteCorpo.IndTodos:= 'S'
  else
    VprDLembreteCorpo.IndTodos:= 'N';
  VprDLembreteCorpo.DesTitulo:= ETitulo.Text;
  VprDLembreteCorpo.DesLembrete:= EDescricao.Text;
  VprDLembreteCorpo.CodUsuario := Varia.CodigoUsuario;
end;

{******************************************************************************}
procedure TFNovoLembrete.BSelecionarUsuariosClick(Sender: TObject);
begin
  FSelecionarUsuarios:= TFSelecionarUsuarios.CriarSDI(Application,'',True);
  FSelecionarUsuarios.SelecionarUsuarios(VprDLembreteCorpo);
  FSelecionarUsuarios.Free;
end;

{******************************************************************************}
procedure TFNovoLembrete.LerLembrete(VpaSeqLembrete, VpaCodUsuario: Integer);
begin
  VprOperacao:= ocConsulta;
  FunLembrete.CarDLembrete(VpaSeqLembrete,VprDLembreteCorpo);
  BloquearTela(True);
  CarDTela;
  FunLembrete.UsuarioLeuLembrete(VpaSeqLembrete,VpaCodUsuario);
  ShowModal;
end;

{******************************************************************************}
procedure TFNovoLembrete.BloquearTela(VpaEstado: Boolean);
begin
  CAgendar.Enabled:= not VpaEstado;
  EDatAgendamento.Enabled:= not VpaEstado;
  PanelColor4.Enabled:= not VpaEstado;
  ETitulo.ReadOnly:= not VpaEstado;
  EDescricao.ReadOnly:= not VpaEstado;
  BGravar.Enabled:= not VpaEstado;
end;

{******************************************************************************}
function TFNovoLembrete.AlterarLembrete(VpaSeqLembrete, VpaCodUsuario: Integer): Boolean;
begin
  VprOperacao:= ocInsercao;
  FunLembrete.CarDLembrete(VpaSeqLembrete,VprDLembreteCorpo);
  CarDTela;
  if (VprDLembreteCorpo.CodUsuario = VpaCodUsuario) or
     (puAdministrador in Varia.PermissoesUsuario) then
    ShowModal
  else
    aviso('PERMISSÃO INVÁLIDA!!!'#13'Somente o dono deste lembrete pode alterá-lo.');
  Result:= VprAcao;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoLembrete]);
end.
