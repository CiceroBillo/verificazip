unit ACentroCusto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela,
  DBKeyViolation, StdCtrls, Localizacao, Mask, DBCtrls, Db, DBTables,
  CBancoDados, BotaoCadastro, Buttons, DBClient;

type
  TFCentroCusto = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    CentroCusto: TRBSQL;
    CentroCustoCODCENTRO: TFMTBCDField;
    CentroCustoNOMCENTRO: TWideStringField;
    DataCentroCusto: TDataSource;
    ECodigo: TDBKeyViolation;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CentroCustoAfterInsert(DataSet: TDataSet);
    procedure CentroCustoAfterEdit(DataSet: TDataSet);
    procedure CentroCustoAfterPost(DataSet: TDataSet);
    procedure CentroCustoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCentroCusto: TFCentroCusto;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCentroCusto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCentroCusto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CentroCusto.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCentroCusto.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCentroCusto.CentroCustoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFCentroCusto.CentroCustoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFCentroCusto.CentroCustoAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFCentroCusto.CentroCustoBeforePost(DataSet: TDataSet);
begin
  if CentroCusto.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCentroCusto]);
end.
