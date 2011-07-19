unit ARepresentada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, DB, DBClient, Tabela, Grids, DBGrids, DBKeyViolation,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons;

type
  TFRepresentada = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    PanelColor2: TPanelColor;
    Representada: TSQL;
    RepresentadaCODREPRESENTADA: TFMTBCDField;
    RepresentadaNOMREPRESENTADA: TWideStringField;
    RepresentadaNOMFANTASIA: TWideStringField;
    RepresentadaDESFONE: TWideStringField;
    DataRepresentada: TDataSource;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoConsultar1: TBotaoConsultar;
    BFechar: TBitBtn;
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
  FRepresentada: TFRepresentada;

implementation

uses APrincipal, ANovaRepresentada, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRepresentada.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AtualizaConsulta;
end;

{ **************************************************************************** }
procedure TFRepresentada.AtualizaConsulta;
begin
  Representada.Close;
  Representada.sql.clear;
  Representada.SQL.add('Select * from REPRESENTADA');
  Representada.open;
end;

{ **************************************************************************** }
procedure TFRepresentada.BFecharClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFRepresentada.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovaRepresentada.Representada,'Select * from REPRESENTADA '+
                                                       ' Where CODREPRESENTADA = '+IntToStr(RepresentadaCODREPRESENTADA.AsInteger));
end;

procedure TFRepresentada.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovaRepresentada := TFNovaRepresentada.CriarSDI(self,'',true);
end;

{ **************************************************************************** }
procedure TFRepresentada.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovaRepresentada.ShowModal;
  AtualizaConsulta;
end;

{ **************************************************************************** }
procedure TFRepresentada.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovaRepresentada.Show;
end;

{ **************************************************************************** }
procedure TFRepresentada.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovaRepresentada.free;
  AtualizaConsulta;
end;

{ **************************************************************************** }
procedure TFRepresentada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Representada.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRepresentada]);
end.
