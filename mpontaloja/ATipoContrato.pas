unit ATipoContrato;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Mask, DBCtrls, Tabela,
  DBKeyViolation, BotaoCadastro, Buttons, Db, DBTables, CBancoDados,
  Localizacao, Grids, DBGrids, DBClient;

type
  TFTipoContrato = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    TipoContrato: TRBSQL;
    TipoContratoCODTIPOCONTRATO: TFMTBCDField;
    TipoContratoNOMTIPOCONTRATO: TWideStringField;
    Label1: TLabel;
    DataTipoContrato: TDataSource;
    Label2: TLabel;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
    ELocaliza: TLocalizaEdit;
    GridIndice1: TGridIndice;
    TipoContratoCODPLANOCONTAS: TWideStringField;
    Label17: TLabel;
    BPlano: TSpeedButton;
    LPlano: TLabel;
    ConsultaPadrao1: TConsultaPadrao;
    DBEditColor2: TDBEditColor;
    ValidaGravacao1: TValidaGravacao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure TipoContratoAfterInsert(DataSet: TDataSet);
    procedure TipoContratoAfterEdit(DataSet: TDataSet);
    procedure TipoContratoBeforePost(DataSet: TDataSet);
    procedure TipoContratoAfterPost(DataSet: TDataSet);
    procedure BPlanoClick(Sender: TObject);
    procedure DBEditColor2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodigoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoContrato: TFTipoContrato;

implementation

uses APrincipal, APlanoConta;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoContrato.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ELocaliza.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTipoContrato.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFTipoContrato.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTipoContrato.TipoContratoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFTipoContrato.TipoContratoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFTipoContrato.TipoContratoBeforePost(DataSet: TDataSet);
begin
  if TipoContrato.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFTipoContrato.TipoContratoAfterPost(DataSet: TDataSet);
begin
  ELocaliza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTipoContrato.BPlanoClick(Sender: TObject);
var
  VpfCodigo : String;
begin
  if TipoContrato.State in [dsinsert,dsedit] then
  begin
    FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
    VpfCodigo := TipoContratoCODPLANOCONTAS.Asstring;
    if not FPlanoConta.VerificaCodigo(VpfCodigo,'C', LPlano, False, (Sender is TSpeedButton)) then
      DBEditColor2.SetFocus;
    TipoContratoCODPLANOCONTAS.AsString := VpfCodigo;
  end;
end;

procedure TFTipoContrato.DBEditColor2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 114) then
    BPlano.Click;
end;

{******************************************************************************}
procedure TFTipoContrato.ECodigoChange(Sender: TObject);
begin
  if TipoContrato.State in [dsedit,dsinsert] then
    ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoContrato]);
end.
