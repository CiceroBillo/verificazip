unit AFaixaEtaria;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Tabela,
  CBancoDados, Grids, DBGrids, DBKeyViolation, StdCtrls, Localizacao,
  BotaoCadastro, Buttons, Mask, DBCtrls, DBClient;

type
  TFFaixaEtaria = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    FaixaEtaria: TRBSQL;
    FaixaEtariaCODFAIXAETARIA: TFMTBCDField;
    FaixaEtariaNOMFAIXAETARIA: TWideStringField;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    DataFaixaEtaria: TDataSource;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    Bevel1: TBevel;
    Label3: TLabel;
    ELocaliza: TLocalizaEdit;
    Grade: TGridIndice;
    FaixaEtariaDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeOrdem(Ordem: String);
    procedure FaixaEtariaAfterEdit(DataSet: TDataSet);
    procedure FaixaEtariaAfterInsert(DataSet: TDataSet);
    procedure FaixaEtariaAfterPost(DataSet: TDataSet);
    procedure FaixaEtariaBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFaixaEtaria: TFFaixaEtaria;

implementation

uses APrincipal, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFaixaEtaria.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ELocaliza.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFaixaEtaria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FaixaEtaria.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFFaixaEtaria.GradeOrdem(Ordem: String);
begin
  ELocaliza.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFFaixaEtaria.FaixaEtariaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFFaixaEtaria.FaixaEtariaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFFaixaEtaria.FaixaEtariaAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('FAIXAETARIA');
  ELocaliza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFaixaEtaria.FaixaEtariaBeforePost(DataSet: TDataSet);
begin
  if FaixaEtaria.State = dsInsert then
    ECodigo.VerificaCodigoUtilizado;
  FaixaEtariaDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFFaixaEtaria.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFaixaEtaria]);
end.
