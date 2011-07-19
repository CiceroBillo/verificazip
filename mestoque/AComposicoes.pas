unit AComposicoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, ExtCtrls, PainelGradiente, DB, DBClient, UnProdutos;

type
  TFComposicoes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoConsultar1: TBotaoConsultar;
    BFechar: TBitBtn;
    Composicao: TSQL;
    DataComposicao: TDataSource;
    ComposicaoCODCOMPOSICAO: TFMTBCDField;
    ComposicaoNOMCOMPOSICAO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta;
  public
    { Public declarations }
  end;

var
  FComposicoes: TFComposicoes;

implementation

uses APrincipal, FunSql, ANovaComposicao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFComposicoes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFComposicoes.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFComposicoes.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovaComposicao.Composicao,'Select * from COMPOSICAO '+
                                                   ' Where CODCOMPOSICAO = '+ComposicaoCODCOMPOSICAO.AsString);
end;

{******************************************************************************}
procedure TFComposicoes.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovaComposicao := TFNovaComposicao.CriarSDI(self,'',true);
end;

{******************************************************************************}
procedure TFComposicoes.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovaComposicao.ShowModal;
  FNovaComposicao.free;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFComposicoes.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovaComposicao.Show;
end;

procedure TFComposicoes.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovaComposicao.Close;
  FunProdutos.ExcluiComposicaoFiguraGRF(ComposicaoCODCOMPOSICAO.AsInteger);
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFComposicoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFComposicoes.AtualizaConsulta;
begin
  Composicao.close;
  Composicao.sql.clear;
  Composicao.sql.add('Select * from COMPOSICAO');
  Composicao.open;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFComposicoes]);
end.
