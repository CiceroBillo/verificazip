unit ATipoCorte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls,
  Buttons, Db, DBTables, Tabela, CBancoDados, Mask, DBCtrls, DBKeyViolation,
  Grids, DBGrids, Localizacao, DBClient;

type
  TFTipoCorte = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    TipoCorte: TRBSQL;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    TipoCorteCODCORTE: TFMTBCDField;
    TipoCorteNOMCORTE: TWideStringField;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    BaseTipoCorte: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    TipoCorteDATALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
    procedure TipoCorteAfterInsert(DataSet: TDataSet);
    procedure TipoCorteAfterEdit(DataSet: TDataSet);
    procedure TipoCorteAfterPost(DataSet: TDataSet);
    procedure TipoCorteBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoCorte: TFTipoCorte;

implementation

uses APrincipal, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoCorte.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTipoCorte.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTipoCorte.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTipoCorte.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFTipoCorte.TipoCorteAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFTipoCorte.TipoCorteAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFTipoCorte.TipoCorteAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('TIPOCORTE');
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTipoCorte.TipoCorteBeforePost(DataSet: TDataSet);
begin
  if TipoCorte.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  TipoCorteDATALT.AsDateTime := Sistema.RDataServidor;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoCorte]);
end.
