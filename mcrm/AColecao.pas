unit AColecao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Db, Mask, DBCtrls, Tabela,
  DBKeyViolation, DBTables, CBancoDados, Componentes1, ExtCtrls,
  PainelGradiente, Grids, DBGrids, Localizacao, DBClient;

type
  TFColecao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Colecao: TRBSQL;
    ColecaoCODCOLECAO: TFMTBCDField;
    ColecaoNOMCOLECAO: TWideStringField;
    ColecaoDATINICIO: TSQLTimeStampField;
    ColecaoDATFIM: TSQLTimeStampField;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DataColecao: TDataSource;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    Bevel1: TBevel;
    Label5: TLabel;
    ELocaliza: TLocalizaEdit;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ColecaoAfterInsert(DataSet: TDataSet);
    procedure ColecaoAfterPost(DataSet: TDataSet);
    procedure ColecaoAfterEdit(DataSet: TDataSet);
    procedure ColecaoBeforePost(DataSet: TDataSet);
    procedure GridIndice1Ordem(Ordem: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FColecao: TFColecao;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFColecao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ELocaliza.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFColecao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Colecao.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFColecao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFColecao.ColecaoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFColecao.ColecaoAfterPost(DataSet: TDataSet);
begin
  ELocaliza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFColecao.ColecaoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFColecao.ColecaoBeforePost(DataSet: TDataSet);
begin
  if Colecao.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFColecao.GridIndice1Ordem(Ordem: String);
begin
  ELocaliza.AOrdem := ordem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFColecao]);
end.
