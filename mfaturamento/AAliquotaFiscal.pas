unit AAliquotaFiscal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Tabela,
  CBancoDados, Grids, DBGrids, DBKeyViolation, StdCtrls, Mask, DBCtrls,
  BotaoCadastro, Buttons, DBClient;

type
  TFAliquotaFiscal = class(TFormularioPermissao)
    AliquotaFiscal: TRBSQL;
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    AliquotaFiscalCODALIQUOTA: TIntegerField;
    AliquotaFiscalPERALIQUOTA: TFloatField;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BotaoAlterar1: TBotaoAlterar;
    BFechar: TBitBtn;
    ECodigo: TDBKeyViolation;
    Label1: TLabel;
    Label2: TLabel;
    DBEditColor1: TDBEditColor;
    DataAliquotaFiscal: TDataSource;
    Bevel1: TBevel;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure AliquotaFiscalAfterInsert(DataSet: TDataSet);
    procedure AliquotaFiscalAfterEdit(DataSet: TDataSet);
    procedure AliquotaFiscalAfterPost(DataSet: TDataSet);
    procedure AliquotaFiscalBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAliquotaFiscal: TFAliquotaFiscal;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAliquotaFiscal.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AliquotaFiscal.Open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAliquotaFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  AliquotaFiscal.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAliquotaFiscal.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAliquotaFiscal.AliquotaFiscalAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFAliquotaFiscal.AliquotaFiscalAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFAliquotaFiscal.AliquotaFiscalAfterPost(DataSet: TDataSet);
begin
  AliquotaFiscal.Close;
  AliquotaFiscal.open;
end;

{******************************************************************************}
procedure TFAliquotaFiscal.AliquotaFiscalBeforePost(DataSet: TDataSet);
begin
  if Aliquotafiscal.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAliquotaFiscal]);
end.
