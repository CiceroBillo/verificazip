unit ASelecionarUsuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, StdCtrls, Buttons, Db, DBCtrls,
  Tabela, DBTables, CheckLst, UnDados, UnLembrete, DBClient;

type
  TFSelecionarUsuarios = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BOK: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    DataCADGRUPOS: TDataSource;
    CADGRUPOS: TSQL;
    Label1: TLabel;
    CADUSUARIOS: TSql;
    EGrupos: TDBLookupComboBoxColor;
    CUsuarios: TCheckListBox;
    CMostrarTodos: TCheckBox;
    CSelecionarTodos: TCheckBox;
    CADUSUARIOSI_COD_USU: TFMTBCDField;
    CADUSUARIOSI_COD_GRU: TFMTBCDField;
    CADUSUARIOSC_NOM_USU: TWideStringField;
    CADGRUPOSI_COD_GRU: TFMTBCDField;
    CADGRUPOSC_NOM_GRU: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CadGruposAfterScroll(DataSet: TDataSet);
    procedure CSelecionarTodosClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure CMostrarTodosClick(Sender: TObject);
    procedure CUsuariosClickCheck(Sender: TObject);
  private
    VprAcao: Boolean;
    VprUsuarios: TList;
    VprDUsuario: TRBDLembreteItem;
    FunLembrete: TRBFuncoesLembrete;
    procedure CarregaUsuarios;
    procedure CarDTelaUsuarios;
    procedure CarDClasse(VpaDLembreteCorpo: TRBDLembreteCorpo);
    procedure SelecionaUsuariosMarcados(VpaDLembreteCorpo: TRBDLembreteCorpo);
  public
    function SelecionarUsuarios(VpaDLembreteCorpo: TRBDLembreteCorpo): Boolean;
  end;

var
  FSelecionarUsuarios: TFSelecionarUsuarios;

implementation
uses
  APrincipal, FunObjeto, FunSQL;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFSelecionarUsuarios.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  VprUsuarios:= TList.Create;
  FunLembrete:= TRBFuncoesLembrete.Cria(FPrincipal.BaseDados);
  CADGRUPOS.Open;
  EGrupos.KeyValue:= CADGRUPOSI_COD_GRU.AsVariant;
  CMostrarTodos.Checked:= True;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFSelecionarUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunLembrete.Free;
  CADGRUPOS.Close;
  Action:= caFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFSelecionarUsuarios.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFSelecionarUsuarios.CadGruposAfterScroll(DataSet: TDataSet);
begin
  CarregaUsuarios;
  CarDTelaUsuarios;
end;

{******************************************************************************}
procedure TFSelecionarUsuarios.CarregaUsuarios;
begin
  if not CMostrarTodos.Checked then
    FunLembrete.CarDUsuariosSistema(VprUsuarios,CADGRUPOSI_COD_GRU.AsInteger)
  else
    FunLembrete.CarDUsuariosSistema(VprUsuarios);
end;

{******************************************************************************}
procedure TFSelecionarUsuarios.CarDTelaUsuarios;
var
  VpfLaco: Integer;
begin
  CUsuarios.Clear;
  for VpfLaco:= 0 to VprUsuarios.Count -1 do
  begin
    VprDUsuario:= TRBDLembreteItem(VprUsuarios.Items[VpfLaco]);
    CUsuarios.Items.AddObject(FormatFloat('#000 - '+VprDUsuario.NomUsuario,VprDUsuario.CodUsuario),VprDUsuario);
    CUsuarios.Checked[VpfLaco]:= VprDUsuario.IndMarcado;
  end;
end;

{******************************************************************************}
procedure TFSelecionarUsuarios.CSelecionarTodosClick(Sender: TObject);
var
  VpfLaco: Integer;
begin
  for VpfLaco:= 0 to VprUsuarios.Count-1 do
  begin
    VprDUsuario:= TRBDLembreteItem(VprUsuarios.Items[VpfLaco]);
    VprDUsuario.IndMarcado:= CSelecionarTodos.Checked;
  end;
  CarDTelaUsuarios;
end;

{******************************************************************************}
function TFSelecionarUsuarios.SelecionarUsuarios(VpaDLembreteCorpo: TRBDLembreteCorpo): Boolean;
begin
  SelecionaUsuariosMarcados(VpaDLembreteCorpo);
  ShowModal;
  Result:= VprAcao;
  if Result then
    CarDClasse(VpaDLembreteCorpo);
  // Não limpar essas listas no FormClose para nao perder as informações
  CUsuarios.Clear;
  FreeTObjectsList(VprUsuarios);
  VprUsuarios.Free;
end;

{******************************************************************************}
procedure TFSelecionarUsuarios.SelecionaUsuariosMarcados(VpaDLembreteCorpo: TRBDLembreteCorpo);
var
  VpfLacoMarcados,
  VpfLaco: Integer;
begin
  for VpfLacoMarcados:= 0 to VpaDLembreteCorpo.Usuarios.Count-1 do
    for VpfLaco:= 0 to VprUsuarios.Count-1 do
    begin
      VprDUsuario:= TRBDLembreteItem(VprUsuarios.Items[VpfLaco]);
      if VprDUsuario.CodUsuario =
         TRBDLembreteItem(VpaDLembreteCorpo.Usuarios.Items[VpfLacoMarcados]).CodUsuario then
        VprDUsuario.IndMarcado:= True;
    end;
  CarDTelaUsuarios;
end;

{******************************************************************************}
procedure TFSelecionarUsuarios.CarDClasse(VpaDLembreteCorpo: TRBDLembreteCorpo);
var
  VpfLaco: Integer;
  VpfDUsuario: TRBDLembreteItem;
begin
  FreeTObjectsList(VpaDLembreteCorpo.Usuarios);
  for VpfLaco:= 0 to VprUsuarios.Count-1 do
  begin
    VprDUsuario:= TRBDLembreteItem(VprUsuarios.Items[VpfLaco]);
    if VprDUsuario.IndMarcado then
    begin
      VpfDUsuario:= VpaDLembreteCorpo.AddUsuario;
      VpfDUsuario.CodUsuario:= VprDUsuario.CodUsuario;
      VprDUsuario.QtdVisualizacao:= 0;
      VpfDUsuario.IndLido:= 'N';
    end;
  end;
end;

{******************************************************************************}
procedure TFSelecionarUsuarios.BOKClick(Sender: TObject);
begin
  VprAcao:= True;
  Close;
end;

{******************************************************************************}
procedure TFSelecionarUsuarios.CMostrarTodosClick(Sender: TObject);
begin
  EGrupos.Enabled:= not CMostrarTodos.Checked;
  CADGRUPOS.First;
  CSelecionarTodosClick(Self);
  if EGrupos.Enabled then
    ActiveControl:= EGrupos
  else
    ActiveControl:= CUsuarios;
end;

{******************************************************************************}
procedure TFSelecionarUsuarios.CUsuariosClickCheck(Sender: TObject);
begin
  VprDUsuario:= TRBDLembreteItem(VprUsuarios.Items[CUsuarios.ItemIndex]);
  VprDUsuario.IndMarcado:= CUsuarios.Checked[CUsuarios.ItemIndex];
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFSelecionarUsuarios]);
end.
