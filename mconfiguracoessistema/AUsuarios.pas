unit AUsuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, Grids, DBGrids, ExtCtrls, Buttons,
  Constantes, formularios, Menus, BotaoCadastro, constMsg,
  Componentes1, Tabela, PainelGradiente, funValida, Localizacao, DBClient,
  DBKeyViolation;

type
  TFUsuarios = class(TFormularioPermissao)
    DataUsuarios: TDataSource;
    menu: TPopupMenu;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Consultar1: TMenuItem;
    Atividade1: TMenuItem;
    N1: TMenuItem;
    Selecionar1: TMenuItem;
    Ativos1: TMenuItem;
    Todos1: TMenuItem;
    NoAtivos1: TMenuItem;
    N2: TMenuItem;
    Fechar1: TMenuItem;
    CadUsuarios: TSQL;
    CadUsuariosI_COD_USU: TFMTBCDField;
    CadUsuariosC_NOM_USU: TWideStringField;
    CadUsuariosC_NOM_LOG: TWideStringField;
    CadUsuariosD_DAT_MOV: TSQLTimeStampField;
    Grade: TGridIndice;
    PanelColor1: TPanelColor;
    EAtividade: TComboBoxColor;
    PanelColor2: TPanelColor;
    BotaoAlterar: TBotaoAlterar;
    BotaoConsultar: TBotaoConsultar;
    BFechar: TBitBtn;
    PainelGradiente1: TPainelGradiente;
    CadUsuariosC_SEN_USU: TWideStringField;
    Label2: TLabel;
    BotaoCadastrar1: TBotaoCadastrar;
    BitBtn2: TBitBtn;
    Localiza: TConsultaPadrao;
    ENome: TEditColor;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BotaoCadastrarAntesAtividade(Sender: TObject);
    procedure BotaoCadastrarDepoisAtividade(Sender: TObject);
    procedure BotaoAlterarAtividade(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoAlterarDepoisAtividade(Sender: TObject);
    procedure EliminarFraseSQL;
    procedure BotaoConsultarAntesAtividade(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EAtividadeChange(Sender: TObject);
    procedure BotaoAlterarClick(Sender: TObject);
    procedure GradeOrdem(Ordem: string);
    procedure ENomeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GradeDblClick(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    procedure AtualizaConsulta;
    procedure Adicionafiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FUsuarios: TFUsuarios;
  FraseDeleteSQL : integer;
  DeletarFrase : boolean;
implementation

uses ANovoUsuario, APrincipal,
  AAlteraPermissaoFilial, FunSql;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFUsuarios.FormCreate(Sender: TObject);
begin
  EAtividade.itemIndex := 0;
  VprOrdem := 'order by C_NOM_USU';
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFUsuarios.GradeDblClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFUsuarios.GradeOrdem(Ordem: string);
begin
  VprOrdem := Ordem;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
CadUsuarios.close;
Action := Cafree;
end;

{ **************** Cria novo filtro para o tipo de usuario, ativo, etc ******* }
procedure TFUsuarios.Adicionafiltros(VpaSelect : TStrings);
begin
  case EAtividade.ItemIndex of
    0 : VpaSelect.add(' and C_USU_ATI = ''S''');
    2 : VpaSelect.add(' and C_USU_ATI = ''N''');
  end;
  if ENome.Text <> '' then
    VpaSelect.Add(' AND C_NOM_USU LIKE '''+ENome.Text+'%''');
end;


{ *************** Aciona o formulario de mudança de Atividade *************** }
procedure TFUsuarios.AtualizaConsulta;
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := CadUsuarios.GetBookmark;
  CadUsuarios.close;
  CadUsuarios.sql.clear;
  CadUsuarios.sql.add('Select * from CADUSUARIOS '+
                      ' Where I_COD_USU = I_COD_USU');
  AdicionaFiltros(Cadusuarios.sql);
  CadUsuarios.Sql.add(VprOrdem);
  Grade.ALinhaSQLOrderBy := CadUsuarios.SQL.Count -1;
  CadUsuarios.open;
  CadUsuarios.GotoBookmark(VpfPosicao);
  CadUsuarios.FreeBookmark(VpfPosicao);
end;

{ *********** Cria o formulario de cadastro, alteracao ou consulta *********** }
procedure TFUsuarios.BotaoCadastrarAntesAtividade(Sender: TObject);
begin
   FNovoUsuario := TFNovoUsuario.CriarSDI(application,'',Fprincipal.VerificaPermisao('FNovoUsuario'))
end;

{ ******** Aciona o formulario de cadastro, alteracao ou consulta ************ }
procedure TFUsuarios.BotaoCadastrarDepoisAtividade(Sender: TObject);
begin
  FNovoUsuario.ShowModal;
  FUsuarios.CadUsuarios.close;
  FUsuarios.CadUsuarios.open;
end;

{ ********* Localiza usuarios para alteracao ou consulta ******************** }
procedure TFUsuarios.BotaoAlterarAtividade(Sender: TObject);
begin
  AdicionaSqlAbreTabela(FNovoUsuario.CadUsuarios,'Select * from CADUSUARIOS '+
                                                 ' Where I_COD_USU = ' +IntToStr(CadUsuariosI_COD_USU.AsInteger));
end;


procedure TFUsuarios.BotaoAlterarClick(Sender: TObject);
begin

end;

{ *************** Fecha o formulario **************************************** }
procedure TFUsuarios.BFecharClick(Sender: TObject);
begin
close;
end;

{ *************** Verifica a senha do usuario para alteracao ***************** }
procedure TFUsuarios.BotaoAlterarDepoisAtividade(Sender: TObject);
begin
  FNovoUsuario.Senhas.text := Descriptografa(FNovoUsuario.CadUsuarios.FieldByName('C_SEN_USU').AsString);
  FNovoUsuario.ConfSenha.Text := FNovoUsuario.Senhas.text;
  FNovoUsuario.ShowModal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFUsuarios.EAtividadeChange(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFUsuarios.EliminarFraseSQL;
begin
if  deletarfrase then
begin
  CadUsuarios.sql.Delete(FraseDeleteSQL);
  deletarfrase := false;
end;
end;

procedure TFUsuarios.ENomeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if KEY = 13 then
    AtualizaConsulta;
end;

procedure TFUsuarios.BotaoConsultarAntesAtividade(Sender: TObject);
begin
   FNovoUsuario := TFNovoUsuario.CriarSDI(application,'',true)
end;

{******************************************************************************}
procedure TFUsuarios.BitBtn2Click(Sender: TObject);
begin
  if CadUsuariosI_COD_USU.AsInteger <> 0 then
  begin
    FAlteraPermissaoFilial := TFAlteraPermissaoFilial.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraPermissaoFilial'));
    FAlteraPermissaoFilial.AlteraPermissaoUsuario(CadUsuariosI_COD_USU.AsInteger);
    FAlteraPermissaoFilial.free;
  end;
end;

Initialization
 RegisterClasses([TFUsuarios]);
end.
