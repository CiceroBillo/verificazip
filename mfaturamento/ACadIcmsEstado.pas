unit ACadIcmsEstado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, ExtCtrls, StdCtrls, Mask, DBCtrls, Db,
  BotaoCadastro, Buttons, Componentes1, PainelGradiente, DBTables,
  Localizacao, DBKeyViolation, DBClient;

type
  TFCadIcmsEstado = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoCancelar1: TBotaoCancelar;
    BotaoGravar1: TBotaoGravar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoAlterar1: TBotaoAlterar;
    BotaoCadastrar1: TBotaoCadastrar;
    MoveBasico1: TMoveBasico;
    Label1: TLabel;
    DataCadIcmsEstado: TDataSource;
    Label2: TLabel;
    Label4: TLabel;
    DBComboBoxUF1: TDBComboBoxUF;
    DBEditColor1: TDBEditColor;
    DBEditColor3: TDBEditColor;
    Bevel1: TBevel;
    DBGridColor1: TDBGridColor;
    Consulta: TLocalizaEdit;
    Label3: TLabel;
    CadIcmsEstado: TSQL;
    CadIcmsEstadoC_COD_EST: TWideStringField;
    CadIcmsEstadoN_ICM_INT: TFMTBCDField;
    CadIcmsEstadoN_ICM_EXT: TFMTBCDField;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    CadIcmsEstadoD_ULT_ALT: TSQLTimeStampField;
    ECodEmpresa: TDBEditLocaliza;
    Label10: TLabel;
    SpeedButton9: TSpeedButton;
    Label12: TLabel;
    ConsultaPadrao1: TConsultaPadrao;
    CadIcmsEstadoI_COD_EMP: TFMTBCDField;
    CadIcmsEstadoN_RED_ICM: TFMTBCDField;
    DBEditColor2: TDBEditColor;
    Label5: TLabel;
    CadIcmsEstadoC_SUB_TRI: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure DBComboBoxUF1Change(Sender: TObject);
    procedure CadIcmsEstadoBeforePost(DataSet: TDataSet);
    procedure BBAjudaClick(Sender: TObject);
    procedure CadIcmsEstadoAfterScroll(DataSet: TDataSet);
    procedure CadIcmsEstadoAfterInsert(DataSet: TDataSet);
    procedure CadIcmsEstadoAfterOpen(DataSet: TDataSet);
    procedure CadIcmsEstadoAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCadIcmsEstado: TFCadIcmsEstado;

implementation

uses APrincipal,Constantes, funObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCadIcmsEstado.FormCreate(Sender: TObject);
begin
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
  Consulta.ASelect.Text := 'Select * from CadIcmsestados '+
                           ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                           ' and C_Cod_est like ''@%''';
  Consulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCadIcmsEstado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadIcmsEstado.close;
 Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFCadIcmsEstado.BFecharClick(Sender: TObject);
begin
   close;
end;

{*************** valida a gravação **************************************** }
procedure TFCadIcmsEstado.DBComboBoxUF1Change(Sender: TObject);
begin
if CadIcmsEstado.State in [ dsInsert, dsEdit ] then
  ValidaGravacao1.execute;
end;

{******************* antes de gravar o registro *******************************}
procedure TFCadIcmsEstado.CadIcmsEstadoBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadIcmsEstadoD_ULT_ALT.AsDateTime := Date;
end;

procedure TFCadIcmsEstado.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFCadIcmsEstado.CadIcmsEstadoAfterScroll(DataSet: TDataSet);
begin
  ECodEmpresa.Atualiza;
end;

{******************************************************************************}
procedure TFCadIcmsEstado.CadIcmsEstadoAfterInsert(DataSet: TDataSet);
begin
  CadIcmsEstadoI_COD_EMP.AsInteger := varia.CodigoEmpresa;
  CadIcmsEstadoC_SUB_TRI.AsString := 'N';
  ECodEmpresa.Atualiza;
end;

procedure TFCadIcmsEstado.CadIcmsEstadoAfterOpen(DataSet: TDataSet);
begin

end;

{******************************************************************************}
procedure TFCadIcmsEstado.CadIcmsEstadoAfterPost(DataSet: TDataSet);
begin
  Consulta.AtualizaConsulta;
end;

Initialization
 RegisterClasses([TFCadIcmsEstado]);
end.
