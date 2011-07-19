unit ABastidor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons,
  DBCtrls, Mask, Tabela, DBKeyViolation, Db, DBTables, CBancoDados, Grids,
  DBGrids, Localizacao, DBClient;

type
  TFBastidor = class(TFormularioPermissao)
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
    Bastidor: TRBSQL;
    Label1: TLabel;
    DataEnfesto: TDataSource;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label2: TLabel;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    Label3: TLabel;
    Label4: TLabel;
    CInterno: TDBCheckBox;
    Bevel1: TBevel;
    Label5: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    BastidorCODBASTIDOR: TFMTBCDField;
    BastidorNOMBASTIDOR: TWideStringField;
    BastidorLARBASTIDOR: TFMTBCDField;
    BastidorALTBASTIDOR: TFMTBCDField;
    BastidorINDINTERNO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BastidorAfterInsert(DataSet: TDataSet);
    procedure BastidorAfterEdit(DataSet: TDataSet);
    procedure BastidorAfterPost(DataSet: TDataSet);
    procedure BastidorBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBastidor: TFBastidor;

implementation

uses APrincipal, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBastidor.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBastidor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Bastidor.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFBastidor.BastidorAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
  BastidorINDINTERNO.AsString := 'S';
end;

procedure TFBastidor.BastidorAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFBastidor.BastidorAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFBastidor.BastidorBeforePost(DataSet: TDataSet);
begin
  if Bastidor.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFBastidor.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFBastidor]);
end.
