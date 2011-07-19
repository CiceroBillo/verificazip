unit ATipoFundo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons,
  Db, Mask, DBCtrls, DBTables, Tabela, CBancoDados, Grids, DBGrids,
  DBKeyViolation, Localizacao, DBClient;

type
  TFTipoFundo = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    MoveBasico1: TMoveBasico;
    TipoFundo: TRBSQL;
    TipoFundoI_COD_FUN: TFMTBCDField;
    TipoFundoC_NOM_FUN: TWideStringField;
    Label1: TLabel;
    DataTipoFundo: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEditColor;
    Codigo: TDBKeyViolation;
    Bevel1: TBevel;
    Label3: TLabel;
    Consulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    TipoFundoD_ULT_ALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridIndice1Ordem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure TipoFundoAfterInsert(DataSet: TDataSet);
    procedure TipoFundoAfterEdit(DataSet: TDataSet);
    procedure TipoFundoBeforePost(DataSet: TDataSet);
    procedure TipoFundoAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoFundo: TFTipoFundo;

implementation

uses APrincipal, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoFundo.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Consulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTipoFundo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  TipoFundo.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTipoFundo.GridIndice1Ordem(Ordem: String);
begin
  Consulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFTipoFundo.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTipoFundo.TipoFundoAfterInsert(DataSet: TDataSet);
begin
  Codigo.ReadOnly := false;
  Codigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFTipoFundo.TipoFundoAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADTIPOFUNDO');
end;

{******************************************************************************}
procedure TFTipoFundo.TipoFundoAfterEdit(DataSet: TDataSet);
begin
  Codigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFTipoFundo.TipoFundoBeforePost(DataSet: TDataSet);
begin
  if TipoFundo.State = dsinsert then
    Codigo.VerificaCodigoUtilizado;
  TipoFundoD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoFundo]);
end.
