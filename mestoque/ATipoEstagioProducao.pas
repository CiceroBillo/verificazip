unit ATipoEstagioProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, Localizacao, ExtCtrls, BotaoCadastro, Buttons,
  Mask, DBCtrls, Tabela, DBKeyViolation, Db, DBTables, CBancoDados,
  PainelGradiente, Grids, DBGrids, DBClient;

type
  TFTipoEstagioProducao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    TipoEstagio: TRBSQL;
    TipoEstagioCODTIP: TFMTBCDField;
    TipoEstagioNOMTIP: TWideStringField;
    Label1: TLabel;
    DataTipoEstagio: TDataSource;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    Bevel1: TBevel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridIndice1Ordem(Ordem: String);
    procedure TipoEstagioAfterInsert(DataSet: TDataSet);
    procedure TipoEstagioAfterEdit(DataSet: TDataSet);
    procedure TipoEstagioAfterPost(DataSet: TDataSet);
    procedure TipoEstagioBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoEstagioProducao: TFTipoEstagioProducao;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoEstagioProducao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTipoEstagioProducao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTipoEstagioProducao.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFTipoEstagioProducao.TipoEstagioAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFTipoEstagioProducao.TipoEstagioAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFTipoEstagioProducao.TipoEstagioAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTipoEstagioProducao.TipoEstagioBeforePost(DataSet: TDataSet);
begin
  if TipoEstagio.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFTipoEstagioProducao.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoEstagioProducao]);
end.
