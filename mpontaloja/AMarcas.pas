unit AMarcas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, Db, StdCtrls, Mask, DBCtrls,
  Tabela, DBKeyViolation, DBTables, CBancoDados, Localizacao,
  BotaoCadastro, Buttons, Grids, DBGrids, DBClient;

type
  TFMarca = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Marca: TRBSQL;
    MarcaCODMARCA: TFMTBCDField;
    MarcaNOMMARCA: TWideStringField;
    ECodigo: TDBKeyViolation;
    Label1: TLabel;
    DataMarca: TDataSource;
    DBEditColor1: TDBEditColor;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    ELocaliza: TLocalizaEdit;
    Grade: TGridIndice;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    MarcaDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MarcaAfterEdit(DataSet: TDataSet);
    procedure MarcaAfterInsert(DataSet: TDataSet);
    procedure MarcaAfterPost(DataSet: TDataSet);
    procedure MarcaBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMarca: TFMarca;

implementation

uses APrincipal, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMarca.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ELocaliza.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMarca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Marca.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFMarca.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMarca.MarcaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFMarca.MarcaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFMarca.MarcaAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('MARCA');
  ELocaliza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMarca.MarcaBeforePost(DataSet: TDataSet);
begin
  if Marca.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  MarcaDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMarca]);
end.
