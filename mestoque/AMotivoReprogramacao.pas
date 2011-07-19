unit AMotivoReprogramacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons,
  Mask, DBCtrls, Tabela, DBKeyViolation, Db, DBTables, CBancoDados, Grids,
  DBGrids, Localizacao, DBClient;

type
  TFMotivoReprogramacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    MOTIVOREPROGRAMACAO: TRBSQL;
    DataMotivoReprogramacao: TDataSource;
    MOTIVOREPROGRAMACAOCOD_MOTIVO: TIntegerField;
    MOTIVOREPROGRAMACAONOM_MOTIVO: TStringField;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Localiza: TLocalizaEdit;
    Grade: TGridIndice;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MOTIVOREPROGRAMACAOAfterInsert(DataSet: TDataSet);
    procedure MOTIVOREPROGRAMACAOAfterEdit(DataSet: TDataSet);
    procedure MOTIVOREPROGRAMACAOAfterPost(DataSet: TDataSet);
    procedure MOTIVOREPROGRAMACAOBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMotivoReprogramacao: TFMotivoReprogramacao;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMotivoReprogramacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Localiza.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMotivoReprogramacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  MOTIVOREPROGRAMACAO.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFMotivoReprogramacao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMotivoReprogramacao.MOTIVOREPROGRAMACAOAfterInsert(
  DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFMotivoReprogramacao.MOTIVOREPROGRAMACAOAfterEdit(
  DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFMotivoReprogramacao.MOTIVOREPROGRAMACAOAfterPost(
  DataSet: TDataSet);
begin
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMotivoReprogramacao.MOTIVOREPROGRAMACAOBeforePost(
  DataSet: TDataSet);
begin
  if MOTIVOREPROGRAMACAO.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMotivoReprogramacao]);
end.
