unit AMotivoInadimplencia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela,
  DBKeyViolation, StdCtrls, Localizacao, Mask, DBCtrls, Db, DBTables,
  CBancoDados, BotaoCadastro, Buttons, DBClient,unSistema;

type
  TFMotivoInadimplencia = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MotivoInadimplecia: TRBSQL;
    MotivoInadimpleciaCODMOTIVO: TFMTBCDField;
    MotivoInadimpleciaNOMMOTIVO: TWideStringField;
    Label1: TLabel;
    DataMotivoInadimplecia: TDataSource;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
    ELocaliza: TLocalizaEdit;
    GridIndice1: TGridIndice;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    MoveBasico1: TMoveBasico;
    MotivoInadimpleciaDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridIndice1Ordem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure MotivoInadimpleciaAfterInsert(DataSet: TDataSet);
    procedure MotivoInadimpleciaAfterEdit(DataSet: TDataSet);
    procedure MotivoInadimpleciaBeforePost(DataSet: TDataSet);
    procedure MotivoInadimpleciaAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMotivoInadimplencia: TFMotivoInadimplencia;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMotivoInadimplencia.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ELocaliza.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMotivoInadimplencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMotivoInadimplencia.GridIndice1Ordem(Ordem: String);
begin
  ELocaliza.AOrdem := ordem;
end;

procedure TFMotivoInadimplencia.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMotivoInadimplencia.MotivoInadimpleciaAfterInsert(
  DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFMotivoInadimplencia.MotivoInadimpleciaAfterEdit(
  DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFMotivoInadimplencia.MotivoInadimpleciaBeforePost(
  DataSet: TDataSet);
begin
  if MotivoInadimplecia.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  MotivoInadimpleciaDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
  Sistema.MarcaTabelaParaImportar('MOTIVOINADIMPLENCIA');
end;

{******************************************************************************}
procedure TFMotivoInadimplencia.MotivoInadimpleciaAfterPost(
  DataSet: TDataSet);
begin
  ELocaliza.AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMotivoInadimplencia]);
end.
