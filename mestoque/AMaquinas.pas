Unit AMaquinas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, Localizacao, Db, DBTables, Tabela, CBancoDados,
  Grids, DBGrids, DBKeyViolation, ExtCtrls, PainelGradiente, Buttons,
  BotaoCadastro, CDiversos, DBClient;

type
  TFMaquinas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TGridIndice;
    DataMaquina: TDataSource;
    Label2: TLabel;
    BFechar: TBitBtn;
    ECodMaq: TEditColor;
    Label1: TLabel;
    EMaquina: TEditColor;
    Maquina: TSQL;
    MaquinaCODMAQ: TFMTBCDField;
    MaquinaNOMMAQ: TWideStringField;
    MaquinaQTDFIO: TFMTBCDField;
    MaquinaINDATI: TWideStringField;
    MaquinaCONKWH: TFMTBCDField;
    MaquinaQTDRPM: TFMTBCDField;
    MaquinaQTDBAR: TFMTBCDField;
    MaquinaQTDLAN: TFMTBCDField;
    MaquinaLARBOC: TFMTBCDField;
    MaquinaQTDCAR: TFMTBCDField;
    MaquinaALTBOC: TFMTBCDField;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoConsultar1: TBotaoConsultar;
    MaquinaDATALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ECodMaqExit(Sender: TObject);
    procedure ECodMaqKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BotaoConsultar1AntesAtividade(Sender: TObject);
    procedure BotaoConsultar1Atividade(Sender: TObject);
    procedure BotaoConsultar1DepoisAtividade(Sender: TObject);
    procedure BotaoCadastrar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure MaquinaAfterPost(DataSet: TDataSet);
    procedure MaquinaBeforePost(DataSet: TDataSet);
  private
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
  public
  end;

var
  FMaquinas: TFMaquinas;

implementation
uses
  APrincipal, FunSQL, ANovaMaquina, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMaquinas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ActiveControl:= ECodMaq;
  AtualizaConsulta;
end;

{ **************************************************************************** }
procedure TFMaquinas.MaquinaAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('MAQUINA');
end;

procedure TFMaquinas.MaquinaBeforePost(DataSet: TDataSet);
begin
  MaquinaDATALT.AsDateTime := Sistema.RDataServidor;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMaquinas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMaquinas.AtualizaConsulta;
begin
  Maquina.SQL.Clear;
  Maquina.SQL.Add('SELECT * FROM MAQUINA'+
                  ' WHERE CODMAQ = CODMAQ');
  AdicionaFiltros(Maquina.SQL);
  Maquina.Open;
end;

{******************************************************************************}
procedure TFMaquinas.AdicionaFiltros(VpaSelect: TStrings);
begin
  if ECodMaq.Text <> '' then
    VpaSelect.Add(' AND CODMAQ = '+ECodMaq.Text)
  else
    if EMaquina.Text <> '' then
      VpaSelect.Add(' AND NOMMAQ LIKE '''+EMaquina.Text+'%''');
end;

{******************************************************************************}
procedure TFMaquinas.ECodMaqExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMaquinas.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFMaquinas.ECodMaqKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMaquinas.BotaoConsultar1AntesAtividade(Sender: TObject);
begin
  FNovaMaquina:= TFNovaMaquina.CriarSDI(Application,'',True);
end;

{******************************************************************************}
procedure TFMaquinas.BotaoConsultar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovaMaquina.MAQUINA,'SELECT * FROM MAQUINA WHERE CODMAQ = '+MaquinaCODMAQ.AsString);
end;

{******************************************************************************}
procedure TFMaquinas.BotaoConsultar1DepoisAtividade(Sender: TObject);
begin
  FNovaMaquina.ShowModal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMaquinas.BotaoCadastrar1Atividade(Sender: TObject);
begin
  FNovaMaquina.MAQUINA.Open;
end;

{******************************************************************************}
procedure TFMaquinas.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovaMaquina.Show;
end;

{******************************************************************************}
procedure TFMaquinas.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovaMaquina.Close;
  AtualizaConsulta;
end;

initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMaquinas]);
end.
