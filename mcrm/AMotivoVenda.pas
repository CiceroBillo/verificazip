unit AMotivoVenda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, StdCtrls, Componentes1,
  Localizacao, ExtCtrls, Mask, DBCtrls, Db, DBTables, CBancoDados,
  PainelGradiente, BotaoCadastro, Buttons, DBClient;

type
  TFMotivoVenda = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MotivoVenda: TRBSQL;
    MotivoVendaCODMOTIVOVENDA: TFMTBCDField;
    MotivoVendaDESMOTIVOVENDA: TWideStringField;
    DataMotivoVenda: TDataSource;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    Label1: TLabel;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
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
    procedure GridIndice1Ordem(Ordem: String);
    procedure MotivoVendaAfterInsert(DataSet: TDataSet);
    procedure MotivoVendaAfterPost(DataSet: TDataSet);
    procedure MotivoVendaAfterEdit(DataSet: TDataSet);
    procedure MotivoVendaBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMotivoVenda: TFMotivoVenda;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMotivoVenda.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMotivoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  MotivoVenda.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMotivoVenda.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMotivoVenda.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := ordem;
end;

{******************************************************************************}
procedure TFMotivoVenda.MotivoVendaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFMotivoVenda.MotivoVendaAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMotivoVenda.MotivoVendaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFMotivoVenda.MotivoVendaBeforePost(DataSet: TDataSet);
begin
  if MotivoVenda.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMotivoVenda]);
end.
