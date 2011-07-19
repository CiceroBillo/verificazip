unit ACores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Localizacao,
  DBKeyViolation, Mask, DBCtrls, Tabela, Db, BotaoCadastro, Buttons,
  DBTables, CBancoDados, Grids, DBGrids, DBClient, UnSistema;

type
  TFCores = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Cor: TRBSQL;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    CorCOD_COR: TFMTBCDField;
    CorNOM_COR: TWideStringField;
    Label1: TLabel;
    DataCor: TDataSource;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    ValidaGravacao1: TValidaGravacao;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    CorDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CorAfterInsert(DataSet: TDataSet);
    procedure CorAfterEdit(DataSet: TDataSet);
    procedure CorBeforePost(DataSet: TDataSet);
    procedure CorAfterPost(DataSet: TDataSet);
    procedure ECodigoChange(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure PainelGradiente1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCores: TFCores;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCores.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Cor.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCores.CorAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFCores.CorAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFCores.CorBeforePost(DataSet: TDataSet);
begin
  CorDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
  Sistema.MarcaTabelaParaImportar('COR');
  if Cor.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFCores.CorAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFCores.ECodigoChange(Sender: TObject);
begin
  if (Cor.State in [dsedit,dsinsert]) then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFCores.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

procedure TFCores.PainelGradiente1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFCores.BFecharClick(Sender: TObject);
begin
  Close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCores]);
end.
