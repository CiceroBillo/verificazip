unit ANovoProcessoProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, StdCtrls, BotaoCadastro, Buttons, DB,
  DBClient, Tabela, CBancoDados, Mask, DBCtrls, Localizacao, AProcessosProducao,
  DBKeyViolation;

type
  TFNovoProcessoProducao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PROCESSOPRODUCAO: TRBSQL;
    BotaoGravar: TBotaoGravar;
    BotaoCancelar: TBotaoCancelar;
    DATAPROCESSOPRODUCAO: TDataSource;
    PROCESSOPRODUCAOCODPROCESSOPRODUCAO: TFMTBCDField;
    PROCESSOPRODUCAODESPROCESSOPRODUCAO: TWideStringField;
    PROCESSOPRODUCAOCODESTAGIO: TFMTBCDField;
    PROCESSOPRODUCAOQTDPRODUCAOHORA: TFMTBCDField;
    PROCESSOPRODUCAOINDCONFIGURACAO: TWideStringField;
    PROCESSOPRODUCAODESTEMPOCONFIGURACAO: TWideStringField;
    DBEditColor2: TDBEditColor;
    EEstagio: TDBEditLocaliza;
    DBEditColor3: TDBEditColor;
    CConfiguracao: TDBCheckBox;
    ETempoConfiguracao: TMaskEditColor;
    ECodigo: TDBKeyViolation;
    BEstagio: TSpeedButton;
    LEstagio: TLabel;
    ConsultaPadrao: TConsultaPadrao;
    ValidaGravacao: TValidaGravacao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PROCESSOPRODUCAOAfterScroll(DataSet: TDataSet);
    procedure PROCESSOPRODUCAOBeforePost(DataSet: TDataSet);
    procedure PROCESSOPRODUCAOAfterEdit(DataSet: TDataSet);
    procedure PROCESSOPRODUCAOAfterInsert(DataSet: TDataSet);
    procedure CConfiguracaoClick(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
    procedure ECodigoChange(Sender: TObject);
    procedure BotaoGravarClick(Sender: TObject);
    procedure PROCESSOPRODUCAOAfterCancel(DataSet: TDataSet);
    procedure PROCESSOPRODUCAOAfterPost(DataSet: TDataSet);
    procedure PROCESSOPRODUCAOAfterDelete(DataSet: TDataSet);
    procedure BotaoGravarDepoisAtividade(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
  public
    { Public declarations }
    function CadastraProcesso(VpaCodEstagio : Integer): Boolean;
  end;

var
  FNovoProcessoProducao: TFNovoProcessoProducao;

implementation

uses APrincipal;

{$R *.DFM}

{ **************************************************************************** }
procedure TFNovoProcessoProducao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  PROCESSOPRODUCAO.Open;
  VprAcao := false;
end;

{ **************************************************************************** }
procedure TFNovoProcessoProducao.PROCESSOPRODUCAOAfterCancel(DataSet: TDataSet);
begin
  ModalResult := mrCancel;
end;

procedure TFNovoProcessoProducao.PROCESSOPRODUCAOAfterDelete(DataSet: TDataSet);
begin
  ModalResult := mrCancel;
end;

{ **************************************************************************** }
procedure TFNovoProcessoProducao.PROCESSOPRODUCAOAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly:= True;
end;

{ *************************************************************************** }
procedure TFNovoProcessoProducao.PROCESSOPRODUCAOAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly:= False;
  CConfiguracao.Checked := False;
end;

{ *************************************************************************** }
procedure TFNovoProcessoProducao.PROCESSOPRODUCAOAfterPost(DataSet: TDataSet);
begin
  ModalResult := mrOk;
end;

{ *************************************************************************** }
procedure TFNovoProcessoProducao.PROCESSOPRODUCAOAfterScroll(DataSet: TDataSet);
begin
  ETempoConfiguracao.Text := PROCESSOPRODUCAODESTEMPOCONFIGURACAO.AsString;
  CConfiguracaoClick(Self);
end;

{ **************************************************************************** }
procedure TFNovoProcessoProducao.PROCESSOPRODUCAOBeforePost(DataSet: TDataSet);
begin
  PROCESSOPRODUCAODESTEMPOCONFIGURACAO.AsString := ETempoConfiguracao.Text;
end;

{ *************************************************************************** }
procedure TFNovoProcessoProducao.BotaoCancelarClick(Sender: TObject);
begin
  close;
end;

{ *************************************************************************** }
procedure TFNovoProcessoProducao.BotaoGravarClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoProcessoProducao.BotaoGravarDepoisAtividade(Sender: TObject);
begin
  VprAcao := true;
end;

{ *************************************************************************** }
function TFNovoProcessoProducao.CadastraProcesso(VpaCodEstagio: Integer): Boolean;
begin
  PROCESSOPRODUCAO.Insert;
  PROCESSOPRODUCAOCODESTAGIO.AsInteger :=  VpaCodEstagio;
  EEstagio.Atualiza;
  showmodal;
  result :=  VprAcao;
end;

{******************************************************************************}
procedure TFNovoProcessoProducao.CConfiguracaoClick(Sender: TObject);
begin
  ETempoConfiguracao.ACampoObrigatorio := CConfiguracao.checked;
  ECodigoChange(Self);
  if (CConfiguracao.Checked) and Visible then
    ETempoConfiguracao.SetFocus;
end;

{ *************************************************************************** }
procedure TFNovoProcessoProducao.ECodigoChange(Sender: TObject);
begin
  ValidaGravacao.execute;
end;

{ *************************************************************************** }
procedure TFNovoProcessoProducao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  PROCESSOPRODUCAO.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoProcessoProducao]);
end.
