unit AClientesBloqueados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Grids,
  DBGrids, Tabela, DBKeyViolation, Db, DBTables, FMTBcd, SqlExpr, DBClient,
  Menus;

type
  TFClientesBloqueados = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Splitter1: TSplitter;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    Label1: TLabel;
    BFechar: TBitBtn;
    GNaoBloqueados: TGridIndice;
    GBloqueados: TGridIndice;
    ClienteNaoBloqueado: TSQL;
    ClientesBloqueados: TSQL;
    DataClienteNaoBloqueado: TDataSource;
    DataClientesBloqueados: TDataSource;
    ClienteNaoBloqueadoI_COD_CLI: TFMTBCDField;
    ClienteNaoBloqueadoC_NOM_CLI: TWideStringField;
    Label3: TLabel;
    ENaoCodCliente: TEditColor;
    Label4: TLabel;
    ENaoNomCliente: TEditColor;
    Label5: TLabel;
    ENaoNomFantasia: TEditColor;
    PanelColor3: TPanelColor;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ECodCliente: TEditColor;
    ENomCliente: TEditColor;
    ENomFantasia: TEditColor;
    ClientesBloqueadosI_COD_CLI: TFMTBCDField;
    ClientesBloqueadosC_NOM_CLI: TWideStringField;
    BBloqueiaCliente: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    BDesbloquearCliente: TSpeedButton;
    Aux: TSQL;
    BGeraNota: TBitBtn;
    PopupMenu1: TPopupMenu;
    ConsultaContasaReceber1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ENaoCodClienteExit(Sender: TObject);
    procedure ENaoCodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GNaoBloqueadosOrdem(Ordem: String);
    procedure BBloqueiaClienteClick(Sender: TObject);
    procedure ECodClienteExit(Sender: TObject);
    procedure ECodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BDesbloquearClienteClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BGeraNotaClick(Sender: TObject);
    procedure ConsultaContasaReceber1Click(Sender: TObject);
  private
    { Private declarations }
    VprOrdemNaoBloqueado,
    VprOrdemBloqueado : String;
    procedure AtualizaConsultaNaoBloqueados;
    procedure AdicionaFiltrosNaoBloqueados(VpaSelect : TStrings);
    procedure AtualizaConsultaBloqueados;
    procedure AdicionaFiltrosBloqueados(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FClientesBloqueados: TFClientesBloqueados;

implementation

uses APrincipal, FunSql, ConstMsg, UnClientes, AContasAReceber;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFClientesBloqueados.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdemNaoBloqueado := 'order by I_COD_CLI';
  VprOrdemBloqueado := 'order by I_COD_CLI';
  AtualizaConsultaNaoBloqueados;
  AtualizaConsultaBloqueados;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFClientesBloqueados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFClientesBloqueados.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFClientesBloqueados.BGeraNotaClick(Sender: TObject);
begin
  FunClientes.BloqueiaClientesAtrasados;
  aviso('Clientes Bloqueados com sucesso');
  AtualizaConsultaBloqueados;
  AtualizaConsultaNaoBloqueados;
end;

{******************************************************************************}
procedure TFClientesBloqueados.ConsultaContasaReceber1Click(Sender: TObject);
begin
  FContasaReceber := TFContasaReceber.criarSDI(Application,'',FPrincipal.VerificaPermisao('FContasaReceber'));
  FContasaReceber.ConsultaContasReceberCliente(ClientesBloqueadosI_COD_CLI.AsInteger);
  FContasaReceber.free;
end;

{******************************************************************************}
procedure TFClientesBloqueados.AtualizaConsultaNaoBloqueados;
Var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := ClienteNaoBloqueado.GetBookmark;
  ClienteNaoBloqueado.close;
  ClienteNaoBloqueado.sql.clear;
  ClienteNaoBloqueado.sql.add('Select CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                              ' from CADCLIENTES CLI '+
                              ' Where C_IND_BLO = ''N'''+
                              ' AND C_IND_CLI = ''S''');
  AdicionaFiltrosNaoBloqueados(ClienteNaoBloqueado.Sql);
  ClienteNaoBloqueado.sql.add(VprOrdemNaoBloqueado);
  ClienteNaoBloqueado.open;
  GNaoBloqueados.ALinhaSQLOrderBy := ClienteNaoBloqueado.SQL.count -1;
  try
    ClienteNaoBloqueado.GotoBookmark(VpfPosicao);
  except
  end;
    ClienteNaoBloqueado.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFClientesBloqueados.AdicionaFiltrosNaoBloqueados(VpaSelect : TStrings);
begin
  if ENaoCodCliente.AInteiro <> 0 then
    VpaSelect.add('and CLI.I_COD_CLI = '+ENaoCodCliente.Text);
  if ENaoNomCliente.Text <> '' then
    VpaSelect.add('and CLI.C_NOM_CLI LIKE '''+ENaoNomCliente.Text+'%''');
  if ENaoNomFantasia.Text <> '' then
    VpaSelect.add('and CLI.C_NOM_FAN LIKE '''+ENaoNomFantasia.Text+'%''');
end;

{******************************************************************************}
procedure TFClientesBloqueados.AtualizaConsultaBloqueados;
Var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := ClientesBloqueados.GetBookmark;
  ClientesBloqueados.Close;
  ClientesBloqueados.sql.clear;
  ClientesBloqueados.sql.add('Select CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                              ' from CADCLIENTES CLI '+
                              ' Where C_IND_BLO = ''S'''+
                              ' AND C_IND_CLI = ''S''' );
  AdicionaFiltrosBloqueados(ClientesBloqueados.Sql);
  ClientesBloqueados.sql.add(VprOrdemBloqueado);
  ClientesBloqueados.open;
  GBloqueados.ALinhaSQLOrderBy := ClientesBloqueados.SQL.count -1;
  try
    ClientesBloqueados.GotoBookmark(VpfPosicao);
  except
  end;
  ClientesBloqueados.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFClientesBloqueados.AdicionaFiltrosBloqueados(VpaSelect : TStrings);
Begin
  if ECodCliente.AInteiro <> 0 then
    VpaSelect.add('and CLI.I_COD_CLI = '+ECodCliente.Text);
  if ENomCliente.Text <> '' then
    VpaSelect.add('and CLI.C_NOM_CLI LIKE '''+ENomCliente.Text+'%''');
  if ENomFantasia.Text <> '' then
    VpaSelect.add('and CLI.C_NOM_FAN LIKE '''+ENomFantasia.Text+'%''');
end;

{******************************************************************************}
procedure TFClientesBloqueados.ENaoCodClienteExit(Sender: TObject);
begin
  AtualizaConsultaNaoBloqueados;
end;

procedure TFClientesBloqueados.ENaoCodClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsultaNaoBloqueados;
end;

{******************************************************************************}
procedure TFClientesBloqueados.GNaoBloqueadosOrdem(Ordem: String);
begin
  VprOrdemNaoBloqueado := Ordem;
end;

procedure TFClientesBloqueados.BBloqueiaClienteClick(Sender: TObject);
begin
  if ClienteNaoBloqueadoI_COD_CLI.AsInteger <> 0 then
  begin
    ExecutaComandoSql(Aux,'Update CadClientes ' +
                          ' set C_IND_BLO = ''S'''+
                          ' , D_DAT_ALT = '+SQLTextoDataAAAAMMMDD(DATE)+
                          ' Where I_COD_CLI = ' +ClienteNaoBloqueadoI_COD_CLI.AsString);
    AtualizaConsultaNaoBloqueados;
    AtualizaConsultaBloqueados;
  end;
end;

{******************************************************************************}
procedure TFClientesBloqueados.ECodClienteExit(Sender: TObject);
begin
  AtualizaConsultaBloqueados;
end;

procedure TFClientesBloqueados.ECodClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsultaBloqueados;
end;

procedure TFClientesBloqueados.BDesbloquearClienteClick(Sender: TObject);
begin
  if ClientesBloqueadosI_COD_CLI.AsInteger <> 0 then
  begin
    ExecutaComandoSql(Aux,'Update CadClientes ' +
                          ' set C_IND_BLO = ''N'''+
                          ' , D_DAT_ALT = '+SQLTextoDataAAAAMMMDD(DATE)+
                          ' Where I_COD_CLI = ' +ClientesBloqueadosI_COD_CLI.AsString);
    AtualizaConsultaNaoBloqueados;
    AtualizaConsultaBloqueados;
  end;
end;

{******************************************************************************}
procedure TFClientesBloqueados.SpeedButton2Click(Sender: TObject);
begin
  if Confirmacao('Tem certeza que deseja bloquear todos os clientes da seleção?') then
  begin
    Aux.Sql.clear;
    Aux.sql.add('UpdCadClientes CLI ' +
                          ' set C_IND_BLO = ''S'''+
                          ' , D_DAT_ALT = '+SQLTextoDataAAAAMMMDD(DATE)+
                          ' Where C_IND_BLO = ''N''');
    AdicionaFiltrosNaoBloqueados(aux.sql);
    Aux.ExecSQL;
    AtualizaConsultaNaoBloqueados;
    AtualizaConsultaBloqueados;
  end;
end;

procedure TFClientesBloqueados.SpeedButton3Click(Sender: TObject);
begin
  if Confirmacao('Tem certeza que deseja desbloquear todos os clientes da seleção?') then
  begin
    Aux.Sql.clear;
    Aux.sql.add('Update CadClientes CLI ' +
                          ' set C_IND_BLO = ''N'''+
                          ' , D_DAT_ALT = '+SQLTextoDataAAAAMMMDD(DATE)+
                          ' Where C_IND_BLO = ''S''');
    AdicionaFiltrosBloqueados(aux.sql);
    Aux.ExecSQL;
    AtualizaConsultaNaoBloqueados;
    AtualizaConsultaBloqueados;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFClientesBloqueados]);
end.
