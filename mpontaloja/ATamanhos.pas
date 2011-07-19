unit ATamanhos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, BotaoCadastro, StdCtrls, Buttons,
  DBKeyViolation, Mask, DBCtrls, Tabela, Localizacao, Db, DBTables,
  CBancoDados, Grids, DBGrids, DBClient;

type
  TFTamanhos = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BMover: TMoveBasico;
    BCadastrar: TBotaoCadastrar;
    BAlterar: TBotaoAlterar;
    BExcluir: TBotaoExcluir;
    BGravar: TBotaoGravar;
    BCancelar: TBotaoCancelar;
    BFechar: TBitBtn;
    ValidaGravacao: TValidaGravacao;
    Bevel1: TBevel;
    Label1: TLabel;
    EConsulta: TLocalizaEdit;
    Label2: TLabel;
    Label6: TLabel;
    ENome: TDBEditColor;
    ECodigo: TDBKeyViolation;
    TAMANHOS: TRBSQL;
    DataTAMANHOS: TDataSource;
    TAMANHOSCODTAMANHO: TFMTBCDField;
    TAMANHOSNOMTAMANHO: TWideStringField;
    GTamanhos: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ECodigoChange(Sender: TObject);
    procedure GTamanhosOrdem(Ordem: String);
    procedure TAMANHOSAfterInsert(DataSet: TDataSet);
    procedure TAMANHOSBeforePost(DataSet: TDataSet);
    procedure TAMANHOSAfterPost(DataSet: TDataSet);
    procedure TAMANHOSAfterEdit(DataSet: TDataSet);
  private
  public
  end;

var
  FTamanhos: TFTamanhos;

implementation
uses
  APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTamanhos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTamanhos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  TAMANHOS.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFTamanhos.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFTamanhos.ECodigoChange(Sender: TObject);
begin
  if TAMANHOS.State in [dsInsert,dsEdit] then
    ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFTamanhos.GTamanhosOrdem(Ordem: String);
begin
  EConsulta.AOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFTamanhos.TAMANHOSAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly:= False;
  ECodigo.ProximoCodigo;
  ActiveControl:= ENome;
end;

{******************************************************************************}
procedure TFTamanhos.TAMANHOSBeforePost(DataSet: TDataSet);
begin
  if TAMANHOS.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFTamanhos.TAMANHOSAfterPost(DataSet: TDataSet);
begin
  ECodigo.Text:= '';
  ENome.Text:= '';
  EConsulta.AtualizaTabela;
end;

{******************************************************************************}
procedure TFTamanhos.TAMANHOSAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly:= True;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTamanhos]);
end.
