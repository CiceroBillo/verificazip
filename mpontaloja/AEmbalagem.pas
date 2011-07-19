unit AEmbalagem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente,
  Mask, DBCtrls, Tabela, DBKeyViolation, Db, DBTables, CBancoDados, Grids,
  DBGrids, Localizacao, DBClient;

type
  TFEmbalagem = class(TFormularioPermissao)
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
    Embalagem: TRBSQL;
    EmbalagemCOD_EMBALAGEM: TFMTBCDField;
    EmbalagemNOM_EMBALAGEM: TWideStringField;
    Label1: TLabel;
    DataEmbalagem: TDataSource;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    EConsulta: TLocalizaEdit;
    Label3: TLabel;
    GridIndice1: TGridIndice;
    EmbalagemQTD_EMBALAGEM: TFMTBCDField;
    DBEditColor2: TDBEditColor;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EmbalagemBeforeInsert(DataSet: TDataSet);
    procedure EmbalagemBeforePost(DataSet: TDataSet);
    procedure EmbalagemAfterEdit(DataSet: TDataSet);
    procedure EmbalagemAfterPost(DataSet: TDataSet);
    procedure GridIndice1Ordem(Ordem: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEmbalagem: TFEmbalagem;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEmbalagem.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEmbalagem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Embalagem.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFEmbalagem.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFEmbalagem.EmbalagemBeforeInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFEmbalagem.EmbalagemBeforePost(DataSet: TDataSet);
begin
  if Embalagem.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFEmbalagem.EmbalagemAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFEmbalagem.EmbalagemAfterPost(DataSet: TDataSet);
begin
  Embalagem.close;
  Embalagem.Open;
end;

{******************************************************************************}
procedure TFEmbalagem.GridIndice1Ordem(Ordem: String);
begin
  econsulta.AOrdem := Ordem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEmbalagem]);
end.
