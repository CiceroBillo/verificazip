unit ATipoEmenda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Mask, DBCtrls, Db,
  DBTables, Tabela, CBancoDados, DBKeyViolation, Grids, DBGrids,
  Localizacao, BotaoCadastro, Buttons, DBClient;

type
  TFTipoEmenda = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    TipoEmenda: TRBSQL;
    TipoEmendaCODEME: TFMTBCDField;
    TipoEmendaNOMEME: TWideStringField;
    Label1: TLabel;
    DataTipoEmenda: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEditColor;
    ECodigo: TDBKeyViolation;
    Bevel1: TBevel;
    EConsulta: TLocalizaEdit;
    Label3: TLabel;
    Grade: TGridIndice;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    TipoEmendaDATALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeOrdem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure TipoEmendaAfterEdit(DataSet: TDataSet);
    procedure TipoEmendaAfterInsert(DataSet: TDataSet);
    procedure TipoEmendaAfterPost(DataSet: TDataSet);
    procedure TipoEmendaBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoEmenda: TFTipoEmenda;

implementation

uses APrincipal, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoEmenda.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTipoEmenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  TipoEmenda.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTipoEmenda.GradeOrdem(Ordem: String);
begin
  EConsulta.AOrdem := 'Order by NOMEME';
end;

{******************************************************************************}
procedure TFTipoEmenda.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTipoEmenda.TipoEmendaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFTipoEmenda.TipoEmendaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFTipoEmenda.TipoEmendaAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('TIPOEMENDA');
  EConsulta.AtualizaConsulta;
end;

procedure TFTipoEmenda.TipoEmendaBeforePost(DataSet: TDataSet);
begin
  if TipoEmenda.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  TipoEmendaDATALT.AsDateTime := Sistema.RDataServidor;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoEmenda]);
end.
