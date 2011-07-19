unit ASetores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, Componentes1, PainelGradiente, StdCtrls, Mask, DBCtrls, Tabela,
  DBKeyViolation, Db, DBTables, CBancoDados, Grids, DBGrids, Localizacao,
  BotaoCadastro, Buttons, DBClient;

type
  TFSetores = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    DataSETOR: TDataSource;
    ValidaGravacao: TValidaGravacao;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BFechar: TBitBtn;
    GConsulta: TGridIndice;
    Setor: TSQL;
    SetorCODSETOR: TFMTBCDField;
    SetorNOMSETOR: TWideStringField;
    BotaoConsultar1: TBotaoConsultar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GConsultaOrdem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure BotaoAlterar1DragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
    VprOrdem : String;
    procedure AtualizaConsulta;
  public
    { Public declarations }
  end;

var
  FSetores: TFSetores;

implementation
uses
  APrincipal, ANovoSetor, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFSetores.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by CODSETOR';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFSetores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Setor.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFSetores.AtualizaConsulta;
begin
  Setor.close;
  Setor.sql.clear;
  Setor.sql.add('Select CODSETOR, NOMSETOR FROM SETOR ');
  Setor.sql.add(VprOrdem);
  Setor.open;
  GConsulta.ALinhaSQLOrderBy := Setor.sql.Count - 1;
end;


{******************************************************************************}
procedure TFSetores.GConsultaOrdem(Ordem: String);
begin
  VprOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFSetores.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFSetores.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovoSetor := TFNovoSetor.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoSetor'));
end;

{******************************************************************************}
procedure TFSetores.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovoSetor.Showmodal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFSetores.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovoSetor.SETOR,'Select * from SETOR'+
                                         ' Where CODSETOR = '+IntToStr(SetorCODSETOR.AsInteger));
end;

procedure TFSetores.BotaoAlterar1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin

end;

{******************************************************************************}
procedure TFSetores.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FSetores.show;
end;

procedure TFSetores.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovoSetor.close;
  AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFSetores]);
end.
