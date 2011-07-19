unit ATextoBoletos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, ComCtrls, StdCtrls, Buttons, Componentes1,
  Mask, numericos, Grids, DBGrids, Tabela, Db, DBTables, DBKeyViolation,
  DBCtrls, BotaoCadastro, Localizacao, DBClient;

type
  TFTextoBoletos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    ValidaGravacaoBoleto: TValidaGravacao;
    CAD_BOL: TSQL;
    DataBoletos: TDataSource;
    CAD_BOLI_SEQ_BOL: TFMTBCDField;
    CAD_BOLC_DES_LOC: TWideStringField;
    CAD_BOLC_DES_CED: TWideStringField;
    CAD_BOLC_DES_ESP: TWideStringField;
    CAD_BOLC_DES_ACE: TWideStringField;
    CAD_BOLC_DES_CAR: TWideStringField;
    CAD_BOLC_ESP_MOE: TWideStringField;
    CAD_BOLC_DES_LN1: TWideStringField;
    CAD_BOLC_DES_LN2: TWideStringField;
    CAD_BOLC_DES_LN3: TWideStringField;
    CAD_BOLC_DES_LN4: TWideStringField;
    CAD_BOLC_DES_LN5: TWideStringField;
    CAD_BOLC_DES_LN6: TWideStringField;
    CAD_BOLC_DES_LN7: TWideStringField;
    CAD_BOLC_NOM_BOL: TWideStringField;
    Label35: TLabel;
    PanelColor7: TPanelColor;
    BitBtn8: TBitBtn;
    NovoBoleto: TBotaoCadastrar;
    ExcluirBoleto: TBotaoExcluir;
    AlterarBoleto: TBotaoAlterar;
    GravarBoleto: TBotaoGravar;
    CancelarBoleto: TBotaoCancelar;
    MoveBasicoBoleto: TMoveBasico;
    Label16: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label14: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label33: TLabel;
    ECodigo: TDBKeyViolation;
    A: TDBEditColor;
    E: TDBEditColor;
    F: TDBEditColor;
    G: TDBEditColor;
    H: TDBEditColor;
    D: TDBEditColor;
    J: TDBEditColor;
    I: TDBEditColor;
    K: TDBEditColor;
    B: TDBEditColor;
    C: TDBEditColor;
    L: TDBEditColor;
    M: TDBEditColor;
    N: TDBEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CAD_BOLAfterEdit(DataSet: TDataSet);
    procedure CAD_BOLAfterInsert(DataSet: TDataSet);
    procedure CAD_BOLBeforePost(DataSet: TDataSet);
    procedure ECodigoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTextoBoletos: TFTextoBoletos;

implementation

uses APrincipal, Constantes, FunSql, ConstMsg, FunString, UnClassesImprimir,
  AConfiguracaoImpressao;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFTextoBoletos.FormCreate(Sender: TObject);
begin
  AbreTabela(CAD_BOL);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTextoBoletos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

{ ********** fecha o formulario ******************************************** }
procedure TFTextoBoletos.BFecharClick(Sender: TObject);
begin
  Close;
end;

{***************** depois da edicao ***************************************** }
procedure TFTextoBoletos.CAD_BOLAfterEdit(DataSet: TDataSet);
begin
   ECodigo.ReadOnly := true;
end;

{************************ Depois da insercao ******************************** }
procedure TFTextoBoletos.CAD_BOLAfterInsert(DataSet: TDataSet);
begin
   ECodigo.ReadOnly := False;
   ECodigo.ProximoCodigo;
end;

{************************* antes do post ************************************ }
procedure TFTextoBoletos.CAD_BOLBeforePost(DataSet: TDataSet);
begin
  if CAD_BOL.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{************** valida a gravacao ********************************************}
procedure TFTextoBoletos.ECodigoChange(Sender: TObject);
begin
  if (CAD_BOL.State in [dsInsert, dsEdit]) then
  ValidaGravacaoBoleto.Execute;
end;

Initialization
  RegisterClasses([TFTextoBoletos]);
end.


