unit APerguntaPesquisaSatisfacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Buttons, Db, DBTables;

type
  TFPerguntaPesquisaSatisfacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    Cadastrar: TBitBtn;
    PesquisaSatisfacao: TQuery;
    PesquisaSatisfacaoCODPESQUISA: TIntegerField;
    PesquisaSatisfacaoNOMPESQUISA: TStringField;
    PesquisaSatisfacaoINDATIVA: TStringField;
    PesquisaSatisfacaoQTDPESQUISAS: TIntegerField;
    DataPesquisaSatisfacao: TDataSource;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadastrarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta;
  public
    { Public declarations }
  end;

var
  FPerguntaPesquisaSatisfacao: TFPerguntaPesquisaSatisfacao;

implementation

uses APrincipal, ANovaPerguntaPesquisaSatisfacao, funSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPerguntaPesquisaSatisfacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPerguntaPesquisaSatisfacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  PesquisaSatisfacao.CLOSE;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPerguntaPesquisaSatisfacao.AtualizaConsulta;
begin
  AdicionaSQLAbreTabela(PesquisaSatisfacao,'Select * from PESQUISASATISFACAOCORPO');
end;

{******************************************************************************}
procedure TFPerguntaPesquisaSatisfacao.CadastrarClick(Sender: TObject);
begin
  FNovaPerguntaPesquisaSatisfacao := TFNovaPerguntaPesquisaSatisfacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaPerguntaPesquisaSatisfacao'));
  if FNovaPerguntaPesquisaSatisfacao.NovasPerguntas then
    AtualizaConsulta;
  FNovaPerguntaPesquisaSatisfacao.free;
end;

{******************************************************************************}
procedure TFPerguntaPesquisaSatisfacao.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPerguntaPesquisaSatisfacao]);
end.
