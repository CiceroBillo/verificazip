unit ADonoProduto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, Localizacao, ExtCtrls, Mask, DBCtrls, Db, DBTables,
  CBancoDados, PainelGradiente, DBClient;

type
  TFDonoProduto = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DonoProduto: TRBSQL;
    DonoProdutoCODDONO: TFMTBCDField;
    DonoProdutoNOMDONO: TWideStringField;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    ELocaliza: TLocalizaEdit;
    Grade: TGridIndice;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    DataDonoProduto: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeOrdem(Ordem: String);
    procedure DonoProdutoAfterInsert(DataSet: TDataSet);
    procedure DonoProdutoAfterPost(DataSet: TDataSet);
    procedure DonoProdutoBeforePost(DataSet: TDataSet);
    procedure DonoProdutoAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDonoProduto: TFDonoProduto;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDonoProduto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ELocaliza.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDonoProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFDonoProduto.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFDonoProduto.GradeOrdem(Ordem: String);
begin
  ELocaliza.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFDonoProduto.DonoProdutoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFDonoProduto.DonoProdutoAfterPost(DataSet: TDataSet);
begin
  ELocaliza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFDonoProduto.DonoProdutoBeforePost(DataSet: TDataSet);
begin
  if DonoProduto.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFDonoProduto.DonoProdutoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFDonoProduto]);
end.
