unit ANovoSetor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente,
  Db, DBTables, Tabela, CBancoDados, Mask, DBCtrls, DBKeyViolation, DBClient;

type
  TFNovoSetor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    SETOR: TRBSQL;
    SETORCODSETOR: TFMTBCDField;
    SETORNOMSETOR: TWideStringField;
    SETORNUMMODELOEMAIL: TFMTBCDField;
    SETORDESRODAPEPROPOSTA: TWideStringField;
    ECodigo: TDBKeyViolation;
    ESetor: TDBEditColor;
    EModeloEmail: TComboBoxColor;
    Label4: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    DBMemoColor1: TDBMemoColor;
    Label3: TLabel;
    DataSETOR: TDataSource;
    SETORDESEMAIL: TWideStringField;
    DBEditColor1: TDBEditColor;
    Label5: TLabel;
    SETORDESMODELORELATORIO: TWideStringField;
    Label6: TLabel;
    DBEditColor2: TDBEditColor;
    DBCheckBox13: TDBCheckBox;
    SETORINDIMPRESSAOOPCAO: TWideStringField;
    Label7: TLabel;
    DBEditColor3: TDBEditColor;
    SETORDESDIRETORIOSALVARPDF: TWideStringField;
    Label8: TLabel;
    DBEditColor4: TDBEditColor;
    SETORDESGARANTIA: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure SETORBeforePost(DataSet: TDataSet);
    procedure SETORAfterScroll(DataSet: TDataSet);
    procedure SETORAfterInsert(DataSet: TDataSet);
    procedure SETORAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNovoSetor: TFNovoSetor;

implementation

uses APrincipal, ASetores, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoSetor.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  SETOR.open;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoSetor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  SETOR.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFNovoSetor.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFNovoSetor.SETORBeforePost(DataSet: TDataSet);
begin
  if SETOR.State = dsInsert then
    ECodigo.VerificaCodigoUtilizado;
  SETORNUMMODELOEMAIL.AsInteger := EModeloEmail.ItemIndex;
end;

procedure TFNovoSetor.SETORAfterScroll(DataSet: TDataSet);
begin
  EModeloEmail.ItemIndex := SETORNUMMODELOEMAIL.AsInteger;
end;

{******************************************************************************}
procedure TFNovoSetor.SETORAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly:= False;
  EModeloEmail.ItemIndex := 0;
  SETORINDIMPRESSAOOPCAO.AsString := 'N';
end;

procedure TFNovoSetor.SETORAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly:= True;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoSetor]);
end.
