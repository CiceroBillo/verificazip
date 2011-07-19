unit ANovoTecnico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Db, Tabela, Mask, DBCtrls, DBKeyViolation, DBTables,
  CBancoDados, BotaoCadastro, Buttons, Componentes1, ExtCtrls,
  PainelGradiente, DBClient;

type
  TFNovoTecnico = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Tecnico: TRBSQL;
    TecnicoCODTECNICO: TFMTBCDField;
    TecnicoNOMTECNICO: TWideStringField;
    TecnicoDESTELEFONE: TWideStringField;
    TecnicoDESCELULAR: TWideStringField;
    TecnicoDESCPF: TWideStringField;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    DBEditPos21: TDBEditPos2;
    DBEditPos22: TDBEditPos2;
    DBEditCPF1: TDBEditCPF;
    DataTecnico: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BFechar: TBitBtn;
    TecnicoINDATIVO: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    TecnicoDESEMAIL: TWideStringField;
    DBEditColor2: TDBEditColor;
    Label6: TLabel;
    TecnicoDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TecnicoAfterInsert(DataSet: TDataSet);
    procedure TecnicoBeforePost(DataSet: TDataSet);
    procedure TecnicoAfterEdit(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure TecnicoAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNovoTecnico: TFNovoTecnico;

implementation

uses APrincipal, ATecnicos, FunObjeto, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoTecnico.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Tecnico.open;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoTecnico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Tecnico.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoTecnico.TecnicoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  Ecodigo.REadOnly := false;
  TecnicoINDATIVO.AsString := 'S';
end;

{******************************************************************************}
procedure TFNovoTecnico.TecnicoAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('TECNICO');
end;

{******************************************************************************}
procedure TFNovoTecnico.TecnicoBeforePost(DataSet: TDataSet);
begin
  if Tecnico.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  TecnicoDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFNovoTecnico.TecnicoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.Readonly := true;
end;

{******************************************************************************}
procedure TFNovoTecnico.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoTecnico]);
end.
