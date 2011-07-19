unit ADesenvolvedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Tabela, CBancoDados, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Mask, DBCtrls, DBKeyViolation, BotaoCadastro,
  Buttons, Grids, DBGrids, Localizacao, DBClient;

type
  TFDesenvolvedor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DESENVOLVEDOR: TRBSQL;
    DataDESENVOLVEDOR: TDataSource;
    DESENVOLVEDORCODDESENVOLVEDOR: TFMTBCDField;
    DESENVOLVEDORNOMDESENVOLVEDOR: TWideStringField;
    ECodigo: TDBKeyViolation;
    Label1: TLabel;
    Label2: TLabel;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
    ELocaliza: TLocalizaEdit;
    GridIndice1: TGridIndice;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    CCobrarFormaPagamento: TDBCheckBox;
    DESENVOLVEDORINDATIVO: TWideStringField;
    DESENVOLVEDORDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure DESENVOLVEDORAfterPost(DataSet: TDataSet);
    procedure DESENVOLVEDORAfterEdit(DataSet: TDataSet);
    procedure DESENVOLVEDORAfterInsert(DataSet: TDataSet);
    procedure DESENVOLVEDORBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDesenvolvedor: TFDesenvolvedor;

implementation

uses APrincipal, FunObjeto, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDesenvolvedor.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ELocaliza.AtualizaConsulta;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1, 'S', 'N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDesenvolvedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  DESENVOLVEDOR.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFDesenvolvedor.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFDesenvolvedor.DESENVOLVEDORAfterPost(DataSet: TDataSet);
begin
  ELocaliza.AtualizaConsulta;
  Sistema.MarcaTabelaParaImportar('DESENVOLVEDOR');
end;

{******************************************************************************}
procedure TFDesenvolvedor.DESENVOLVEDORAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFDesenvolvedor.DESENVOLVEDORAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
  DESENVOLVEDORINDATIVO.AsString := 'S';
end;

{******************************************************************************}
procedure TFDesenvolvedor.DESENVOLVEDORBeforePost(DataSet: TDataSet);
begin
  DESENVOLVEDORDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
  if DESENVOLVEDOR.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFDesenvolvedor]);
end.
