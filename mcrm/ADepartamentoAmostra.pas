unit ADepartamentoAmostra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, DB, DBClient, Tabela, Localizacao, Mask, DBCtrls, DBKeyViolation, CBancoDados, Grids, DBGrids;

type
  TFDepartamentoAmostra = class(TFormularioPermissao)
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
    DepartamentoAmosra: TRBSQL;
    DepartamentoAmosraCODDEPARTAMENTOAMOSTRA: TFMTBCDField;
    DepartamentoAmosraNOMDEPARTAMENTOAMOSTRA: TWideStringField;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    DataDepartamentoAmosra: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: string);
    procedure DepartamentoAmosraAfterInsert(DataSet: TDataSet);
    procedure DepartamentoAmosraAfterEdit(DataSet: TDataSet);
    procedure DepartamentoAmosraAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDepartamentoAmostra: TFDepartamentoAmostra;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDepartamentoAmostra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{*****************************************************************************}
procedure TFDepartamentoAmostra.GridIndice1Ordem(Ordem: string);
begin
  EConsulta.AOrdem := Ordem;
end;

{*****************************************************************************}
procedure TFDepartamentoAmostra.BFecharClick(Sender: TObject);
begin
  close;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDepartamentoAmostra.DepartamentoAmosraAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{*****************************************************************************}
procedure TFDepartamentoAmostra.DepartamentoAmosraAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{*****************************************************************************}
procedure TFDepartamentoAmostra.DepartamentoAmosraAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{*****************************************************************************}
procedure TFDepartamentoAmostra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  DepartamentoAmosra.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFDepartamentoAmostra]);
end.
