unit AAcessorio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, DBKeyViolation, BotaoCadastro,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, Localizacao, Mask, DBCtrls,
  Db, DBTables, CBancoDados, DBClient;

type
  TFAcessorio = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Acessorio: TRBSQL;
    Label1: TLabel;
    DataAcessorio: TDataSource;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    Grade: TGridIndice;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    DBEditColor2: TDBEditColor;
    Label4: TLabel;
    AcessorioCODACESSORIO: TFMTBCDField;
    AcessorioNOMACESSORIO: TWideStringField;
    AcessorioDESLETRA: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AcessorioAfterInsert(DataSet: TDataSet);
    procedure AcessorioAfterEdit(DataSet: TDataSet);
    procedure AcessorioAfterPost(DataSet: TDataSet);
    procedure AcessorioBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure GradeOrdem(Ordem: String);
    procedure ECodigoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAcessorio: TFAcessorio;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAcessorio.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
  
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAcessorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Acessorio.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAcessorio.AcessorioAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFAcessorio.AcessorioAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFAcessorio.AcessorioAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAcessorio.AcessorioBeforePost(DataSet: TDataSet);
begin
  if Acessorio.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFAcessorio.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAcessorio.GradeOrdem(Ordem: String);
begin
  EConsulta.AOrdem := ordem;
end;

{******************************************************************************}
procedure TFAcessorio.ECodigoChange(Sender: TObject);
begin
  if Acessorio.State in [dsedit,dsinsert] then
    ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAcessorio]);
end.
