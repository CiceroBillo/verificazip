unit ARamoAtividade;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente,
  Db, DBTables, Tabela, CBancoDados, DBKeyViolation, Grids, DBGrids,
  Localizacao, Mask, DBCtrls, DBClient;

type
  TFRamoAtividade = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    RamoAtividade: TRBSQL;
    RamoAtividadeCOD_RAMO_ATIVIDADE: TFMTBCDField;
    RamoAtividadeNOM_RAMO_ATIVIDADE: TWideStringField;
    Label1: TLabel;
    DataRamoAtividade: TDataSource;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    ValidaGravacao1: TValidaGravacao;
    RamoAtividadeDAT_ULTIMA_ALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ECodigoChange(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
    procedure RamoAtividadeAfterInsert(DataSet: TDataSet);
    procedure RamoAtividadeAfterEdit(DataSet: TDataSet);
    procedure RamoAtividadeAfterPost(DataSet: TDataSet);
    procedure RamoAtividadeBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRamoAtividade: TFRamoAtividade;

implementation

uses APrincipal, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRamoAtividade.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRamoAtividade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  RamoAtividade.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRamoAtividade.ECodigoChange(Sender: TObject);
begin
  if RamoAtividade.state in [dsedit,dsinsert] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFRamoAtividade.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFRamoAtividade.RamoAtividadeAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFRamoAtividade.RamoAtividadeAfterEdit(DataSet: TDataSet);
begin
  Ecodigo.REadOnly := true;
end;

{******************************************************************************}
procedure TFRamoAtividade.RamoAtividadeAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('RAMO_ATIVIDADE');
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRamoAtividade.RamoAtividadeBeforePost(DataSet: TDataSet);
begin
  If RamoAtividade.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  RamoAtividadeDAT_ULTIMA_ALTERACAO.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFRamoAtividade.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRamoAtividade]);
end.
