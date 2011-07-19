unit AMotivoAtraso;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, Localizacao, Mask, DBCtrls, ExtCtrls, PainelGradiente, DB,
  DBClient;

type
  TFMotivoAtraso = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label3: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label4: TLabel;
    EConsulta: TLocalizaEdit;
    GGrid: TGridIndice;
    DBEditColor1: TDBEditColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BAlterar: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    DATAMOTIVOATRASO: TDataSource;
    MOTIVOATRASO: TSQL;
    MOTIVOATRASOCODMOTIVOATRASO: TFMTBCDField;
    MOTIVOATRASODESMOTIVOATRASO: TWideStringField;
    ValidaGravacao: TValidaGravacao;
    ECodigoMotivo: TDBKeyViolation;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MOTIVOATRASOAfterCancel(DataSet: TDataSet);
    procedure MOTIVOATRASOAfterEdit(DataSet: TDataSet);
    procedure MOTIVOATRASOAfterInsert(DataSet: TDataSet);
    procedure MOTIVOATRASOAfterPost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure GGridOrdem(Ordem: string);
    procedure MOTIVOATRASOBeforePost(DataSet: TDataSet);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FMotivoAtraso: TFMotivoAtraso;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFMotivoAtraso.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  MOTIVOATRASO.Open;
end;

{******************************************************************************}
procedure TFMotivoAtraso.GGridOrdem(Ordem: string);
begin
  EConsulta.AOrdem := ordem;
end;

{******************************************************************************}
procedure TFMotivoAtraso.MOTIVOATRASOAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(True);
end;

{******************************************************************************}
procedure TFMotivoAtraso.MOTIVOATRASOAfterEdit(DataSet: TDataSet);
begin
   ECodigoMotivo.ReadOnly:= true;
   ConfiguraConsulta(False);
end;

{******************************************************************************}
procedure TFMotivoAtraso.MOTIVOATRASOAfterInsert(DataSet: TDataSet);
begin
   ECodigoMotivo.ReadOnly:= false;
   ECodigoMotivo.ProximoCodigo;
   ConfiguraConsulta(False);
end;

{******************************************************************************}
procedure TFMotivoAtraso.MOTIVOATRASOAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaTabela;
  ConfiguraConsulta(True);
end;

{******************************************************************************}
procedure TFMotivoAtraso.MOTIVOATRASOBeforePost(DataSet: TDataSet);
begin
  if MOTIVOATRASO.State = dsinsert then
    ECodigoMotivo.VerificaCodigoUtilizado;
end;

{ *************************************************************************** }
procedure TFMotivoAtraso.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMotivoAtraso.ConfiguraConsulta(acao: Boolean);
begin
   Label1.Enabled := acao;
   EConsulta.Enabled := acao;
   GGrid.Enabled := acao;
end;

{******************************************************************************}
procedure TFMotivoAtraso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  MOTIVOATRASO.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMotivoAtraso]);
end.
