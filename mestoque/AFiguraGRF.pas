unit AFiguraGRF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  DB, DBClient, Tabela, Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Mask, DBCtrls, DBKeyViolation, Grids, DBGrids, Localizacao;

type
  TFFiguraGRF = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    FiguraGRF: TSQL;
    FiguraGRFCODFIGURAGRF: TFMTBCDField;
    FiguraGRFNOMFIGURAGRF: TWideStringField;
    FiguraGRFDESFIGURAGRF: TWideStringField;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BFechar: TBitBtn;
    BotaoCancelar1: TBotaoCancelar;
    DataFiguraGRF: TDataSource;
    ECodigo: TDBKeyViolation;
    Label1: TLabel;
    DBEditColor1: TDBEditColor;
    Label2: TLabel;
    DBMemoColor1: TDBMemoColor;
    Label3: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: string);
    procedure FiguraGRFAfterInsert(DataSet: TDataSet);
    procedure FiguraGRFAfterEdit(DataSet: TDataSet);
    procedure FiguraGRFBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFiguraGRF: TFFiguraGRF;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFiguraGRF.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFiguraGRF.GridIndice1Ordem(Ordem: string);
begin
  EConsulta.AOrdem := Ordem;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFiguraGRF.BFecharClick(Sender: TObject);
begin
  close;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFiguraGRF.FiguraGRFAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFiguraGRF.FiguraGRFAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

procedure TFFiguraGRF.FiguraGRFBeforePost(DataSet: TDataSet);
begin
  if FiguraGRF.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

procedure TFFiguraGRF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFiguraGRF]);
end.
