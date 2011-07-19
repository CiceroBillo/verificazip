unit ATipoChamado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons,
  Db, DBTables, Tabela, CBancoDados, Grids, DBGrids, DBKeyViolation,
  Localizacao, Mask, DBCtrls, DBClient;

type
  TFTipoChamado = class(TFormularioPermissao)
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
    TipoChamado: TRBSQL;
    DataTipoChamado: TDataSource;
    TipoChamadoCODTIPOCHAMADO: TFMTBCDField;
    TipoChamadoNOMTIPOCHAMADO: TWideStringField;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    EConsulta: TLocalizaEdit;
    Grade: TGridIndice;
    Label4: TLabel;
    EModeloEmail: TComboBoxColor;
    TipoChamadoNUMMODELOEMAIL: TFMTBCDField;
    TipoChamadoINDGARANTIA: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure TipoChamadoAfterEdit(DataSet: TDataSet);
    procedure TipoChamadoAfterInsert(DataSet: TDataSet);
    procedure TipoChamadoAfterPost(DataSet: TDataSet);
    procedure TipoChamadoBeforePost(DataSet: TDataSet);
    procedure TipoChamadoAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoChamado: TFTipoChamado;

implementation

uses APrincipal, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoChamado.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor2,'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTipoChamado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  TipoChamado.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTipoChamado.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTipoChamado.TipoChamadoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.readonly := true;
  EModeloEmail.Enabled := true;
end;

{******************************************************************************}
procedure TFTipoChamado.TipoChamadoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
  EModeloEmail.Enabled := true;
  TipoChamadoINDGARANTIA.AsString := 'N';
end;

{******************************************************************************}
procedure TFTipoChamado.TipoChamadoAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTipoChamado.TipoChamadoBeforePost(DataSet: TDataSet);
begin
  if TipoChamado.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  TIPOCHAMADONUMMODELOEMAIL.AsInteger := EModeloEmail.ItemIndex;
end;

{******************************************************************************}
procedure TFTipoChamado.TipoChamadoAfterScroll(DataSet: TDataSet);
begin
  EModeloEmail.Enabled := false;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoChamado]);
end.
