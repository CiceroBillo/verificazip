unit AAcondicionamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Mask, DBCtrls, Tabela, DBKeyViolation, Db, BotaoCadastro,
  Buttons, Componentes1, ExtCtrls, PainelGradiente, DBTables, CBancoDados,
  Grids, DBGrids, Localizacao, DBClient;

type
  TFAcondicionamento = class(TFormularioPermissao)
    Acondicionamento: TRBSQL;
    PainelGradiente1: TPainelGradiente;
    Painelcolor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    MoveBasico1: TMoveBasico;
    Label1: TLabel;
    DataAcondicionamento: TDataSource;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    Grade: TGridIndice;
    AcondicionamentoCODACONDICIONAMENTO: TFMTBCDField;
    AcondicionamentoNOMACONDICIONAMENTO: TWideStringField;
    AcondicionamentoDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure AcondicionamentoAfterEdit(DataSet: TDataSet);
    procedure AcondicionamentoAfterPost(DataSet: TDataSet);
    procedure AcondicionamentoAfterInsert(DataSet: TDataSet);
    procedure AcondicionamentoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAcondicionamento: TFAcondicionamento;

implementation

uses APrincipal, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAcondicionamento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAcondicionamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Acondicionamento.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFAcondicionamento.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAcondicionamento.AcondicionamentoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFAcondicionamento.AcondicionamentoAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('ACONDICIONAMENTO');
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAcondicionamento.AcondicionamentoAfterInsert(
  DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFAcondicionamento.AcondicionamentoBeforePost(DataSet: TDataSet);
begin
  if Acondicionamento.State = dsinsert then
  begin
    ECodigo.VerificaCodigoUtilizado;
  end;
  AcondicionamentoDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAcondicionamento]);
end.
