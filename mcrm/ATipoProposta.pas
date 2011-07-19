unit ATipoProposta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, BotaoCadastro, StdCtrls, Buttons, Mask, DBCtrls, Tabela,
  DBKeyViolation, Db, DBTables, CBancoDados, Componentes1, PainelGradiente,
  Grids, DBGrids, Localizacao, DBClient;

type
  TFTipoProposta = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    TipoProposta: TRBSQL;
    TipoPropostaCODTIPOPROPOSTA: TFMTBCDField;
    TipoPropostaNOMTIPOPROPOSTA: TWideStringField;
    Label1: TLabel;
    DataTipoProposta: TDataSource;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TipoPropostaAfterInsert(DataSet: TDataSet);
    procedure TipoPropostaAfterEdit(DataSet: TDataSet);
    procedure TipoPropostaAfterPost(DataSet: TDataSet);
    procedure TipoPropostaBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoProposta: TFTipoProposta;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoProposta.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTipoProposta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  TipoProposta.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTipoProposta.TipoPropostaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFTipoProposta.TipoPropostaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFTipoProposta.TipoPropostaAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaTabela;
end;

{******************************************************************************}
procedure TFTipoProposta.TipoPropostaBeforePost(DataSet: TDataSet);
begin
  if TipoProposta.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado
end;

{******************************************************************************}
procedure TFTipoProposta.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTipoProposta.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoProposta]);
end.
