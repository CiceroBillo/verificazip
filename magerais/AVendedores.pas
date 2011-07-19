unit AVendedores;
{          Autor: Rafael Budag
    Data Criação: 05/04/1999;
          Função: Cadastrar um novo Vendedor
  Data Alteração:
    Alterado por:
Motivo alteração: 
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, BotaoCadastro, StdCtrls, Buttons, Db,  DBTables,
  Tabela, Mask, DBCtrls, DBCidade, Componentes1, Grids, DBGrids,
  Localizacao, DBKeyViolation, LabelCorMove, PainelGradiente, constantes, constMsg,
  DBClient, Menus, IniFiles;

type
  TFVendedores = class(TFormularioPermissao)
    DataCadVendedores: TDataSource;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    DBGridColor1: TGridIndice;
    BFechar: TBitBtn;
    PanelColor1: TPanelColor;
    CadVendedores: TSQL;
    CadVendedoresI_COD_VEN: TFMTBCDField;
    CadVendedoresC_NOM_VEN: TWideStringField;
    CadVendedoresC_CID_VEN: TWideStringField;
    CadVendedoresC_FON_VEN: TWideStringField;
    Label1: TLabel;
    BotaoConsultar: TBotaoConsultar;
    CadVendedoresC_CEL_VEN: TWideStringField;
    CAtivos: TCheckBox;
    BMetas: TBitBtn;
    PopupMenu1: TPopupMenu;
    GerarArquivoConfiguraoSistemaPedidos1: TMenuItem;
    SaveDialog: TSaveDialog;
    ENome: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridColor1TitleClick(Column: TColumn);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure BotaoConsultar1AntesAtividade(Sender: TObject);
    procedure BotaoConsultarAntesAtividade(Sender: TObject);
    procedure CAtivosClick(Sender: TObject);
    procedure ENomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BMetasClick(Sender: TObject);
    procedure GerarArquivoConfiguraoSistemaPedidos1Click(Sender: TObject);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure ENomeExit(Sender: TObject);
    procedure BotaoConsultarClick(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FVendedores: TFVendedores;

implementation

uses APrincipal, ANovoVendedor, AMetasVendedor, funsql, FunString, FunValida;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFVendedores.FormCreate(Sender: TObject);
begin
  VprOrdem := 'order by VEN.I_COD_VEN ';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFVendedores.GerarArquivoConfiguraoSistemaPedidos1Click(Sender: TObject);
var
  VpfArquivo : TIniFile;
begin
  SaveDialog.FileName := 'c:\'+CadVendedoresI_COD_VEN.AsString+CopiaAteChar(CadVendedoresC_NOM_VEN.AsString,' ')+'.rsp';
  if SaveDialog.Execute then
  begin
    VpfArquivo := TIniFile.Create(SaveDialog.FileName);
    VpfArquivo.WriteString('860384848547fgfqt','847085548477kiq',Criptografa(CadVendedoresI_COD_VEN.AsString));
    VpfArquivo.Free;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFVendedores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
CadVendedores.close;
Action := CaFree;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**********Altera a ordem da tabela e atualiza o indice do grid****************}
procedure TFVendedores.DBGridColor1TitleClick(Column: TColumn);
begin
end;

{******************************************************************************}
procedure TFVendedores.AtualizaConsulta;
begin
  CadVendedores.close;
  CadVendedores.sql.clear;
  CadVendedores.sql.add('Select VEN.I_COD_VEN, VEN.C_NOM_VEN, VEN.C_CID_VEN, VEN.C_FON_VEN, VEN.C_CEL_VEN '+
                        ' From CADVENDEDORES VEN '+
                        ' Where VEN.I_COD_VEN = VEN.I_COD_VEN');
  AdicionaFiltros(CadVendedores.sql);
  CadVendedores.sql.add(VprOrdem);
  CadVendedores.open;
  DBGridColor1.ALinhaSQLOrderBy := CadVendedores.SQL.count - 1;
end;

{******************************************************************************}
procedure TFVendedores.AdicionaFiltros(VpaSelect : TStrings);
begin
  if ENome.Text <> '' then
    VpaSelect.add('and VEN.C_NOM_VEN like  '''+ENome.Text +'%''');
  if CAtivos.Checked then
    VpaSelect.add('and VEN.C_IND_ATI = ''S''');
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFVendedores.BFecharClick(Sender: TObject);
begin
   Close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*****************Cria o formulario para cadastrar novo registro***************}
procedure TFVendedores.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovoVendedor := TFNovoVendedor.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoVendedor'));
end;

procedure TFVendedores.BotaoCadastrar1Click(Sender: TObject);
begin

end;

{************Vai para o Novo registro e na volta atualiza a tabela*************}
procedure TFVendedores.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovoVendedor.ShowModal;
  AtualizaConsulta;
end;

{**************Localiza o registro para que possa ser alterado*****************}
procedure TFVendedores.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQlAbreTabela( FNovoVendedor.CadVendedores,'Select * from CADVENDEDORES '+
                                                    ' Where I_COD_VEN = '+CadVendedoresI_cod_Ven.AsString);
end;

procedure TFVendedores.BotaoExcluir1Atividade(Sender: TObject);
begin

end;

{*******************Mostra o registro que será excluído************************}
procedure TFVendedores.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
   FNovoVendedor.show;
end;

{*************Apos excluir fecha o formulario que mostrava o registro**********}
procedure TFVendedores.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovoVendedor.close;
  AtualizaConsulta;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFVendedores.DBGridColor1Ordem(Ordem: String);
begin
  VprOrdem := ordem;
end;

{***************** consultar clientes *************************************** }
procedure TFVendedores.BotaoConsultar1AntesAtividade(Sender: TObject);
begin
  FNovoVendedor := TFNovoVendedor.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoVendedor'));
end;

{******************************************************************************}
procedure TFVendedores.BotaoConsultarAntesAtividade(Sender: TObject);
begin
  FNovoVendedor := TFNovoVendedor.CriarSDI(Application,'',true);
end;

procedure TFVendedores.BotaoConsultarClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFVendedores.CAtivosClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFVendedores.ENomeExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFVendedores.ENomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFVendedores.BMetasClick(Sender: TObject);
begin
  if CadVendedoresI_COD_VEN.AsInteger <> 0 then
  begin
    FMetasVendedor := TFMetasVendedor.criarSDI(Application,'',FPrincipal.VerificaPermisao('FMetasVendedor'));
    FMetasVendedor.CadastraMeta(CadVendedoresI_COD_VEN.AsInteger);
    FMetasVendedor.free;
  end;
end;

Initialization
 RegisterClasses([TFVendedores]);
end.
