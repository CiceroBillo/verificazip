unit ANovaCampanhaVendas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, DBCtrls, Tabela, Localizacao, Mask, DBKeyViolation, Db,
  DBTables, CBancoDados, BotaoCadastro, Buttons, PainelGradiente, ExtCtrls,
  Componentes1, DBClient;

type
  TFNovaCampanhaVendas = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    CampanhaVendas: TRBSQL;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    ECodUsuario: TDBEditLocaliza;
    DBEditColor2: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    CampanhaVendasSEQCAMPANHA: TFMTBCDField;
    CampanhaVendasNOMCAMPANHA: TWideStringField;
    CampanhaVendasCODUSUARIO: TFMTBCDField;
    CampanhaVendasDATVALIDADE: TSQLTimeStampField;
    DataCampanhaVendas: TDataSource;
    Localiza: TConsultaPadrao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CampanhaVendasAfterInsert(DataSet: TDataSet);
    procedure CampanhaVendasAfterEdit(DataSet: TDataSet);
    procedure CampanhaVendasAfterScroll(DataSet: TDataSet);
    procedure CampanhaVendasBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNovaCampanhaVendas: TFNovaCampanhaVendas;

implementation

uses APrincipal, Constantes, ACampanhaVendas;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaCampanhaVendas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CampanhaVendas.open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaCampanhaVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CampanhaVendas.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaCampanhaVendas.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaCampanhaVendas.CampanhaVendasAfterInsert(
  DataSet: TDataSet);
begin
  CampanhaVendasCODUSUARIO.AsInteger := varia.CodigoUsuario;
  ECodUsuario.Atualiza;
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFNovaCampanhaVendas.CampanhaVendasAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFNovaCampanhaVendas.CampanhaVendasAfterScroll(
  DataSet: TDataSet);
begin
  ECodUsuario.Atualiza;
end;

{******************************************************************************}
procedure TFNovaCampanhaVendas.CampanhaVendasBeforePost(DataSet: TDataSet);
begin
  if CampanhaVendas.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaCampanhaVendas]);
end.
