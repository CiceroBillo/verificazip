unit AConcorrentes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Db, DBTables, StdCtrls, Componentes1,
  Localizacao, BotaoCadastro, Buttons, Grids, DBGrids, Tabela,
  DBKeyViolation, DBClient;

type
  TFConcorrentes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    Consulta: TLocalizaEdit;
    DataConcorrente: TDataSource;
    Concorrente: TSQL;
    PanelColor1: TPanelColor;
    PanelColor3: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BFechar: TBitBtn;
    BotaoExcluir1: TBotaoExcluir;
    BotaoConsultar1: TBotaoConsultar;
    DBGridColor1: TGridIndice;
    ConcorrenteCODCONCORRENTE: TFMTBCDField;
    ConcorrenteNOMCONCORRENTE: TWideStringField;
    ConcorrenteDESENDERECO: TWideStringField;
    ConcorrenteNUMENDERECO: TFMTBCDField;
    ConcorrenteDESBAIRRO: TWideStringField;
    ConcorrenteNUMCEP: TWideStringField;
    ConcorrenteDESCIDADE: TWideStringField;
    ConcorrenteDESUF: TWideStringField;
    ConcorrenteDESFONE1: TWideStringField;
    ConcorrenteNOMPROPRIETARIO: TWideStringField;
    ConcorrenteQTDFUNCIONARIO: TFMTBCDField;
    ConcorrenteQTDTECNICO: TFMTBCDField;
    ConcorrenteQTDVENDEDOR: TFMTBCDField;
    ConcorrenteVALFATURAMENTOMENSAL: TFMTBCDField;
    ConcorrenteDESOBSERVACAO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure DBGridColor1DblClick(Sender: TObject);
    procedure DBGridColor1Ordem(Ordem: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConcorrentes: TFConcorrentes;

implementation
uses
  APrincipal, ANovoConcorrente, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConcorrentes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Concorrente.Open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConcorrentes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Concorrente.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFConcorrentes.BFecharClick(Sender: TObject);
begin
  Self.Close;
end;

{******************************************************************************}
procedure TFConcorrentes.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovoConcorrente:= TFNovoConcorrente.CriarSDI(Application,'',True);
end;

{******************************************************************************}
procedure TFConcorrentes.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovoConcorrente.ShowModal;
  FNovoConcorrente.Free;
  Consulta.AtualizaTabela;
end;

{******************************************************************************}
procedure TFConcorrentes.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovoConcorrente.Concorrente,'SELECT * FROM CONCORRENTE WHERE CODCONCORRENTE = '+IntToStr(ConcorrenteCODCONCORRENTE.AsInteger));
end;

{******************************************************************************}
procedure TFConcorrentes.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovoConcorrente.Show;
end;

{******************************************************************************}
procedure TFConcorrentes.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovoConcorrente.Close;
  Consulta.AtualizaTabela;
end;

{******************************************************************************}
procedure TFConcorrentes.DBGridColor1DblClick(Sender: TObject);
begin
  BotaoAlterar1.Click;
end;

{******************************************************************************}
procedure TFConcorrentes.DBGridColor1Ordem(Ordem: String);
begin
  Consulta.AOrdem := Ordem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConcorrentes]);
end.
