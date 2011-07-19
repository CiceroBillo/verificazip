unit AAmostrasPendentes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Db, Grids,
  DBGrids, Tabela, DBKeyViolation, DBTables, Menus, UnAmostra, DBClient, Localizacao,
  Mask, numericos, FMTBcd, SqlExpr, CBancoDados;

type
  TFAmostrasPendentes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Amostras: TSQL;
    AmostrasCODAMOSTRA: TFMTBCDField;
    AmostrasNOMAMOSTRA: TWideStringField;
    AmostrasDATAMOSTRA: TSQLTimeStampField;
    AmostrasDATENTREGACLIENTE: TSQLTimeStampField;
    AmostrasC_NOM_VEN: TWideStringField;
    AmostrasC_NOM_CLI: TWideStringField;
    GridIndice1: TGridIndice;
    DataAmostras: TDataSource;
    AmostrasQTDAMOSTRA: TFMTBCDField;
    PopupMenu1: TPopupMenu;
    MConsultaAmostra: TMenuItem;
    N1: TMenuItem;
    MConcluiAmostra: TMenuItem;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    AmostrasDESDEPARTAMENTO: TWideStringField;
    EDepartamento: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    N2: TMenuItem;
    GerarAmostra1: TMenuItem;
    AmostrasCODDESENVOLVEDOR: TFMTBCDField;
    AmostrasNOMDESENVOLVEDOR: TWideStringField;
    AmostrasCODDEPARTAMENTOAMOSTRA: TFMTBCDField;
    AmostrasNOMDEPARTAMENTOAMOSTRA: TWideStringField;
    N3: TMenuItem;
    AlterarDesenvolvedor1: TMenuItem;
    EDesenvolvedor: TRBEditLocaliza;
    ESituacao: TComboBoxColor;
    Label9: TLabel;
    Label3: TLabel;
    ETotal: Tnumerico;
    Aux: TRBSQL;
    AmostrasINDAMOSTRAREALIZADA: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MConsultaAmostraClick(Sender: TObject);
    procedure MConcluiAmostraClick(Sender: TObject);
    procedure EDepartamentoClick(Sender: TObject);
    procedure EDepartamentoFimConsulta(Sender: TObject);
    procedure GerarAmostra1Click(Sender: TObject);
    procedure AlterarDesenvolvedor1Click(Sender: TObject);
    procedure GridIndice1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    FunAmostra : TRBFuncoesAmostra;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaConsulta : TStrings);
    procedure AtualizaTotais;
    procedure ConfiguraPermissaoUsuario;
  public
    { Public declarations }
  end;

var
  FAmostrasPendentes: TFAmostrasPendentes;

implementation

uses APrincipal, AAmostras, Constantes, FunObjeto, Constmsg, ANovaAmostra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAmostrasPendentes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;
  if varia.CNPJFilial = CNPJ_VENETO  then
    ESituacao.ItemIndex := 1;
  AtualizaConsulta;
end;


procedure TFAmostrasPendentes.GerarAmostra1Click(Sender: TObject);
begin
  if AmostrasCODAMOSTRA.AsInteger <> 0 then
  begin
    FNovaAmostra := tFNovaAmostra.CriarSDI(Self,'',true);
    FNovaAmostra.NovaAmostra(AmostrasCODAMOSTRA.AsInteger);
    FNovaAmostra.free;
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.GridIndice1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if AmostrasINDAMOSTRAREALIZADA.AsString = 'S' then
  begin
     if (State = [gdSelected]) then
       GridIndice1.Canvas.Font.Color := clWhite
     else
     begin
       GridIndice1.Canvas.Font.Color := clGreen;
       GridIndice1.Canvas.Font.Style := [fsbold];
     end;
  end;
  GridIndice1.DefaultDrawDataCell(Rect, GridIndice1.columns[datacol].field, State);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAmostrasPendentes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra.free;
  Amostras.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAmostrasPendentes.AlterarDesenvolvedor1Click(Sender: TObject);
var
  VpfResultado : string;
begin
  if EDesenvolvedor.AAbreLocalizacao then
    VpfResultado :=  FunAmostra.AlteraDesenvolvedor(AmostrasCODAMOSTRA.AsInteger,EDesenvolvedor.AInteiro);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.AtualizaConsulta;
begin
  Amostras.close;
  Amostras.sql.clear;
  Amostras.sql.add('SELECT CODAMOSTRA, NOMAMOSTRA, DATAMOSTRA, DATENTREGACLIENTE, AMO.QTDAMOSTRA, AMO.DESDEPARTAMENTO, '+
                   ' VEN.C_NOM_VEN, AMO.INDAMOSTRAREALIZADA, '+
                   ' CLI.C_NOM_CLI, '+
                   ' DES.CODDESENVOLVEDOR, DES.NOMDESENVOLVEDOR, '+
                   ' DEP.CODDEPARTAMENTOAMOSTRA, DEP.NOMDEPARTAMENTOAMOSTRA '+
                   ' FROM AMOSTRA AMO, CADVENDEDORES VEN, CADCLIENTES CLI, DESENVOLVEDOR DES, DEPARTAMENTOAMOSTRA DEP '+
                   ' WHERE AMO.CODVENDEDOR = VEN.I_COD_VEN '+
                   ' AND AMO.CODCLIENTE = CLI.I_COD_CLI '+
                   ' AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR ' +
                   ' AND AMO.CODDEPARTAMENTOAMOSTRA = DEP.CODDEPARTAMENTOAMOSTRA');
  AdicionaFiltros(Amostras.sql);
  Amostras.sql.add(' ORDER BY AMO.DATENTREGACLIENTE');
  Amostras.open;
  AtualizaTotais;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.AtualizaTotais;
begin
  Aux.close;
  Aux.sql.clear;
  Aux.sql.add('SELECT SUM(QTDAMOSTRA) QTD '+
                   ' FROM AMOSTRA AMO '+
                   ' WHERE AMO.CODAMOSTRA = AMO.CODAMOSTRA ');
  AdicionaFiltros(Aux.sql);
  Aux.open;
  ETotal.AsInteger := Aux.FieldByName('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.AdicionaFiltros(VpaConsulta : TStrings);
begin
  VpaConsulta.Add(' AND AMO.DATENTREGA IS NULL '+
                   ' AND AMO.TIPAMOSTRA = ''I''');
  if EDepartamento.AInteiro <> 0 then
    VpaConsulta.add('AND AMO.CODDEPARTAMENTOAMOSTRA = '+EDepartamento.Text);
  case ESituacao.ItemIndex of
    1 : VpaConsulta.Add('AND AMO.DATFICHAAMOSTRA IS NOT NULL');
  end;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.ConfiguraPermissaoUsuario;
begin
  MConcluiAmostra.Visible := true;
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([MConcluiAmostra],(puCRConcluirAmostra in varia.PermissoesUsuario));
  end;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.MConsultaAmostraClick(
  Sender: TObject);
begin
  FAmostras := TFAmostras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAmostras'));
  FAmostras.ConsultaAmostrasIndefinidas(AmostrasCODAMOSTRA.AsInteger);
  FAmostras.free;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.MConcluiAmostraClick(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfREsultado := FunAmostra.ConcluiAmostra(AmostrasCODAMOSTRA.AsInteger,date);
  if VpfREsultado <> '' then
    aviso(VpfREsultado)
  else
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.EDepartamentoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.EDepartamentoFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAmostrasPendentes]);
end.
