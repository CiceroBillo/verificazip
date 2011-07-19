unit AMeioDivulgacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Db, DBTables, Tabela, CBancoDados,
  Componentes1, ExtCtrls, PainelGradiente, Mask, DBCtrls, DBKeyViolation,
  Localizacao, Grids, DBGrids, DBClient;

type
  TFMeioDivulgacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MeioDivulgacao: TRBSQL;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    MeioDivulgacaoCODMEIODIVULGACAO: TFMTBCDField;
    MeioDivulgacaoDESMEIODIVULGACAO: TWideStringField;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    Grade: TGridIndice;
    DataMeioDivulgacao: TDataSource;
    MeioDivulgacaoDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MeioDivulgacaoAfterInsert(DataSet: TDataSet);
    procedure MeioDivulgacaoAfterEdit(DataSet: TDataSet);
    procedure MeioDivulgacaoAfterPost(DataSet: TDataSet);
    procedure MeioDivulgacaoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMeioDivulgacao: TFMeioDivulgacao;

implementation

uses APrincipal, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMeioDivulgacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMeioDivulgacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  MeioDivulgacao.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFMeioDivulgacao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMeioDivulgacao.MeioDivulgacaoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFMeioDivulgacao.MeioDivulgacaoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFMeioDivulgacao.MeioDivulgacaoAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('MEIODIVULGACAO');
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMeioDivulgacao.MeioDivulgacaoBeforePost(DataSet: TDataSet);
begin
  if MeioDivulgacao.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  MeioDivulgacaoDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMeioDivulgacao]);
end.
