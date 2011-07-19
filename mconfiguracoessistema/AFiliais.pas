unit AFiliais;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: Cadastrar um novo
  Data Alteração: 01/04/1999;
    Alterado por: 
Motivo alteração: -
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, DBCtrls, Db, Menus, DBTables, BotaoCadastro, Buttons, Grids,
  DBGrids, ExtCtrls, constantes, Componentes1, Tabela, PainelGradiente,
  DBKeyViolation, DBClient;

type
  TFFiliais = class(TFormularioPermissao)
    DataFiliais: TDataSource;
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
    CadFiliais: TSQL;
    CadFiliaisI_COD_FIL: TFMTBCDField;
    CadFiliaisC_NOM_FAN: TWideStringField;
    CadFiliaisC_CID_FIL: TWideStringField;
    CadFiliaisC_FON_FIL: TWideStringField;
    GridIndice1: TGridIndice;
    PanelColor2: TPanelColor;
    ListaEmpresa: TListDBComboBox;
    PanelColor3: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar: TBotaoAlterar;
    BotaoExcluir: TBotaoExcluir;
    BotaoConsultar: TBotaoConsultar;
    BFechar: TBitBtn;
    PainelGradiente1: TPainelGradiente;
    Label1: TLabel;
    CadFiliaisI_EMP_FIL: TFMTBCDField;
    CadFiliaisI_COD_EMP: TFMTBCDField;
    CadEmpresas: TSQL;
    CadEmpresasI_COD_EMP: TFMTBCDField;
    CadEmpresasC_NOM_EMP: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoCadastrarAntesAtividade(Sender: TObject);
    procedure BotaoCadastrarDepoisAtividade(Sender: TObject);
    procedure BotaoExcluirDepoisAtividade(Sender: TObject);
    procedure BotaoExcluirDestroiFormulario(Sender: TObject);
    procedure BotaoAlterarAtividade(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure ListaEmpresaChange(Sender: TObject);
    procedure BotaoConsultarAntesAtividade(Sender: TObject);
  private
    procedure carregaFilial;
  public
    { Public declarations }
  end;

var
  FFiliais: TFFiliais;

implementation

uses ANovaFilial, APrincipal, funSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFiliais.FormCreate(Sender: TObject);
begin
  listaEmpresa.Text := Varia.NomeEmpresa;
  CadEmpresas.open;
  carregaFilial;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFiliais.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CadEmpresas.close;
 cadfiliais.close;
 Action := CaFree;
end;

{ *********** abre select que localiza filial ******************************* }
procedure TFFiliais.carregaFilial;
begin
CadFiliais.close;
CadFiliais.sql.clear;
CadFiliais.sql.add('Select I_COD_FIL,C_NOM_FAN,C_CID_FIL,C_FON_FIL, I_EMP_FIL, Fil.I_COD_EMP ' +
                   ' from CadFiliais Fil, CadEmpresas Emp '+
                   ' where EMP.C_NOM_EMP = ''' + ListaEmpresa.Text + '''' +
                   ' and FIL.I_COD_EMP = EMP.I_COD_EMP ');
CadFiliais.sql.add('   ');
Cadfiliais.open;
end;

{ ******************* Cria o formulario de alteraçao e cadastro ************** }
procedure TFFiliais.BotaoCadastrarAntesAtividade(Sender: TObject);
begin
  FNovaFilial := TFNovaFilial.CriarSDI(application,'',FPrincipal.VerificaPermisao('FNovaFilial'));
  FNovaFilial.EmpresaCadastro := CadFiliaisI_COD_EMP.AsInteger;
end;

{ ******************* inicializa o formulario de alteraçao e cadastro ******** }
procedure TFFiliais.BotaoCadastrarDepoisAtividade(Sender: TObject);
begin
  FNovaFilial.ShowModal;
  CadFiliais.close;
  CadFiliais.open;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFFiliais.BotaoExcluirDepoisAtividade(Sender: TObject);
begin
FNovaFilial.show;
end;

{********** apos destrui o formulario de exclusao *************************** }
procedure TFFiliais.BotaoExcluirDestroiFormulario(Sender: TObject);
begin
FNovafilial.Close;
CadFiliais.Close;
CadFiliais.open;
end;

{************* localiza o registro a ser alterado *************************** }
procedure TFFiliais.BotaoAlterarAtividade(Sender: TObject);
begin
  AdicionaSqlAbreTabela(FNovaFilial.CadFiliais,'Select * from CADFILIAIS '+
                                              ' Where I_EMP_FIL = '+IntToStr(CadFiliaisI_EMP_FIL.AsInteger));
end;

{ *************** fecha o formulario **************************************** }
procedure TFFiliais.BFecharClick(Sender: TObject);
begin
close;
end;

{********************* Quando muda a empresa ******************************** }
procedure TFFiliais.ListaEmpresaChange(Sender: TObject);
begin
carregaFilial;
if ListaEmpresa.Text <> Varia.NomeEmpresa then
  PanelColor3.Visible := false
else
  PanelColor3.Visible := true;
end;

{******************************************************************************}
procedure TFFiliais.BotaoConsultarAntesAtividade(Sender: TObject);
begin
  FNovaFilial := TFNovaFilial.CriarSDI(application,'',true);
  FNovaFilial.EmpresaCadastro := CadFiliaisI_COD_EMP.AsInteger;
end;

Initialization
 RegisterClasses([TFFiliais]);

end.
