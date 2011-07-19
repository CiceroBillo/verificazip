unit AProcessosProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons, DB,
  DBClient, Tabela, CBancoDados, Grids, DBGrids, DBKeyViolation, Localizacao;

type
  TFProcessosProducao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GConsulta: TGridIndice;
    DATAPROCESSOPRODUCAO: TDataSource;
    PROCESSOPRODUCAO: TRBSQL;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoConsultar1: TBotaoConsultar;
    BotaoExcluir1: TBotaoExcluir;
    BFechar: TBitBtn;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    ECodigo: TEditColor;
    Label2: TLabel;
    EDescricao: TEditColor;
    EEstagio: TRBEditLocaliza;
    Label3: TLabel;
    BLocalizaEstagio: TSpeedButton;
    PROCESSOPRODUCAOCODPROCESSOPRODUCAO: TFMTBCDField;
    PROCESSOPRODUCAODESPROCESSOPRODUCAO: TWideStringField;
    PROCESSOPRODUCAOCODESTAGIO: TFMTBCDField;
    PROCESSOPRODUCAOQTDPRODUCAOHORA: TFMTBCDField;
    PROCESSOPRODUCAOINDCONFIGURACAO: TWideStringField;
    PROCESSOPRODUCAODESTEMPOCONFIGURACAO: TWideStringField;
    PROCESSOPRODUCAONOMEST: TWideStringField;
    ConsultaPadrao: TConsultaPadrao;
    LEstagio: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure GConsultaOrdem(Ordem: string);
    procedure BotaoAlterar1AntesAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoAlterar1DepoisAtividade(Sender: TObject);
    procedure BotaoConsultar1AntesAtividade(Sender: TObject);
    procedure BotaoConsultar1Atividade(Sender: TObject);
    procedure BotaoConsultar1DepoisAtividade(Sender: TObject);
    procedure ECodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodigoExit(Sender: TObject);
    procedure EEstagioFimConsulta(Sender: TObject);
    procedure BotaoExcluir1Click(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    procedure AtualizaConsulta;
    procedure AdicionaFiltrosSql(VpaSelect: TStrings);
  public
    { Public declarations }
  end;

var
  FProcessosProducao: TFProcessosProducao;

implementation

uses APrincipal, ANovoProcessoProducao, FunSql;

{$R *.DFM}

{ **************************************************************************** }
procedure TFProcessosProducao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'ORDER BY CODPROCESSOPRODUCAO ';
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFProcessosProducao.GConsultaOrdem(Ordem: string);
begin
  VprOrdem:= Ordem;
end;

{ *************************************************************************** }
procedure TFProcessosProducao.AdicionaFiltrosSql(VpaSelect: TStrings);
begin
  if (ECodigo.Text <> '') then
  begin
    VpaSelect.Add(' AND CODPROCESSOPRODUCAO = ' + ECodigo.Text);
  end else
  begin
    if EEstagio.Text <> '' then
      VpaSelect.Add(' AND CODEST = ' + EEstagio.Text);
    if EDescricao.Text <> '' then
      VpaSelect.Add(' AND DESPROCESSOPRODUCAO LIKE ''' + EDescricao.Text + '%''');
  end;
end;

{ *************************************************************************** }
procedure TFProcessosProducao.AtualizaConsulta;
begin
  PROCESSOPRODUCAO.close;
  PROCESSOPRODUCAO.sql.clear;
  PROCESSOPRODUCAO.sql.add(' SELECT PRO.CODPROCESSOPRODUCAO, PRO.DESPROCESSOPRODUCAO, PRO.CODESTAGIO, ' +
                           '        PRO.QTDPRODUCAOHORA, PRO.INDCONFIGURACAO, PRO.DESTEMPOCONFIGURACAO, ' +
                           '        EST.NOMEST  ' +
                           '   FROM PROCESSOPRODUCAO PRO, ESTAGIOPRODUCAO EST ' +
                           '  WHERE PRO.CODESTAGIO = EST.CODEST ');
  AdicionaFiltrosSql(PROCESSOPRODUCAO.SQL);
  PROCESSOPRODUCAO.sql.add(VprOrdem);
  PROCESSOPRODUCAO.open;
  GConsulta.ALinhaSQLOrderBy := PROCESSOPRODUCAO.Sql.Count - 1;
end;

{ *************************************************************************** }
procedure TFProcessosProducao.BFecharClick(Sender: TObject);
begin
  Close;
end;

{ *************************************************************************** }
procedure TFProcessosProducao.BotaoAlterar1AntesAtividade(Sender: TObject);
begin
  FNovoProcessoProducao := TFNovoProcessoProducao.criarSDI(Self, '', True);
end;

{ *************************************************************************** }
procedure TFProcessosProducao.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovoProcessoProducao.PROCESSOPRODUCAO,
                                         ' SELECT * FROM PROCESSOPRODUCAO '+
                                         '  WHERE CODPROCESSOPRODUCAO = '+
                                         IntToStr(PROCESSOPRODUCAOCODPROCESSOPRODUCAO.AsInteger));
end;

{ *************************************************************************** }
procedure TFProcessosProducao.BotaoAlterar1DepoisAtividade(Sender: TObject);
begin
  FNovoProcessoProducao.ShowModal;
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFProcessosProducao.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovoProcessoProducao := TFNovoProcessoProducao.criarSDI(Self, '', True);
end;

{ *************************************************************************** }
procedure TFProcessosProducao.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovoProcessoProducao.ShowModal;
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFProcessosProducao.BotaoConsultar1AntesAtividade(Sender: TObject);
begin
  FNovoProcessoProducao := TFNovoProcessoProducao.criarSDI(Self, '', True);
end;

{ *************************************************************************** }
procedure TFProcessosProducao.BotaoConsultar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovoProcessoProducao.PROCESSOPRODUCAO,
                        ' SELECT * FROM PROCESSOPRODUCAO '+
                        '  WHERE CODPROCESSOPRODUCAO = '+
                        IntToStr(PROCESSOPRODUCAOCODPROCESSOPRODUCAO.AsInteger));
end;

{ *************************************************************************** }
procedure TFProcessosProducao.BotaoConsultar1DepoisAtividade(Sender: TObject);
begin
  FNovoProcessoProducao.BotaoGravar.Enabled := False;
  FNovoProcessoProducao.BotaoCancelar.Enabled := True;
  FNovoProcessoProducao.ShowModal;
  AtualizaConsulta;
end;

procedure TFProcessosProducao.BotaoExcluir1Click(Sender: TObject);
begin

end;

{ *************************************************************************** }
procedure TFProcessosProducao.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovoProcessoProducao.Show;
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFProcessosProducao.ECodigoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFProcessosProducao.ECodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    13 : ECodigoExit(Self);
  end;
end;

{ *************************************************************************** }
procedure TFProcessosProducao.EEstagioFimConsulta(Sender: TObject);
begin

end;

{ *************************************************************************** }
procedure TFProcessosProducao.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFProcessosProducao]);
end.
