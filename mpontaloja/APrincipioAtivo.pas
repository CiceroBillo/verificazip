unit APrincipioAtivo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente,
  DBCtrls, Db, Mask, Tabela, DBKeyViolation, DBTables, CBancoDados, Grids,
  DBGrids, Localizacao, DBClient;

type
  TFPrincipioAtivo = class(TFormularioPermissao)
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
    PrincipioAtivo: TRBSQL;
    ECodigo: TDBKeyViolation;
    DataPrincipioAtivo: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    DBEditColor1: TDBEditColor;
    CControlado: TDBCheckBox;
    Bevel1: TBevel;
    Consulta: TLocalizaEdit;
    Label3: TLabel;
    Grade: TGridIndice;
    PrincipioAtivoDATULTIMAALTERACAO: TSQLTimeStampField;
    PrincipioAtivoCODPRINCIPIO: TFMTBCDField;
    PrincipioAtivoNOMPRINCIPIO: TWideStringField;
    PrincipioAtivoINDCONTROLADO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeOrdem(Ordem: String);
    procedure PrincipioAtivoAfterInsert(DataSet: TDataSet);
    procedure PrincipioAtivoAfterEdit(DataSet: TDataSet);
    procedure PrincipioAtivoAfterPost(DataSet: TDataSet);
    procedure PrincipioAtivoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipioAtivo: TFPrincipioAtivo;

implementation

uses APrincipal, FunObjeto, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPrincipioAtivo.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  IniciallizaCheckBox([CControlado],'T','F');
  Consulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPrincipioAtivo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  PrincipioAtivo.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPrincipioAtivo.BFecharClick(Sender: TObject);
begin

  Close;
end;

{******************************************************************************}
procedure TFPrincipioAtivo.GradeOrdem(Ordem: String);
begin
  Consulta.AOrdem := Ordem;
end;

procedure TFPrincipioAtivo.PrincipioAtivoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
  PrincipioAtivoINDCONTROLADO.AsString := 'F';
end;

{******************************************************************************}
procedure TFPrincipioAtivo.PrincipioAtivoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFPrincipioAtivo.PrincipioAtivoAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('PRINCIPIOATIVO');
  Consulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPrincipioAtivo.PrincipioAtivoBeforePost(DataSet: TDataSet);
begin
  if PrincipioAtivo.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  PrincipioAtivoDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPrincipioAtivo]);
end.
