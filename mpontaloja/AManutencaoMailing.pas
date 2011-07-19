unit AManutencaoMailing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, Localizacao, ComCtrls, Db, DBTables, FMTBcd,
  SqlExpr, DBClient;

type
  TFManutencaoMailing = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    BExcluirLigacao: TBitBtn;
    BExcluirTarefa: TBitBtn;
    BLimparUsuario: TBitBtn;
    BFechar: TBitBtn;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    Localiza: TConsultaPadrao;
    EUsuario: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    ETarefa: TEditLocaliza;
    Mailing: TSQL;
    DataMailing: TDataSource;
    MailingC_NOM_USU: TWideStringField;
    MailingSEQTAREFA: TFMTBCDField;
    MailingDATLIGACAO: TSQLTimeStampField;
    MailingC_NOM_CLI: TWideStringField;
    MailingNOMCAMPANHA: TWideStringField;
    MailingDATTAREFA: TSQLTimeStampField;
    MailingINDREAGENDADO: TWideStringField;
    Aux: TSQLQuery;
    MailingCODUSUARIO: TFMTBCDField;
    MailingCODCLIENTE: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EUsuarioFimConsulta(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BExcluirLigacaoClick(Sender: TObject);
    procedure BExcluirTarefaClick(Sender: TObject);
    procedure BLimparUsuarioClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta(VpaPosicionar : boolean);
    procedure AdicionaFiltros(VpaComandoSQl : TStrings);
  public
    { Public declarations }
  end;

var
  FManutencaoMailing: TFManutencaoMailing;

implementation

uses APrincipal, Fundata, FunSql, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFManutencaoMailing.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CPeriodo.Checked := true;
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
  AtualizaConsulta(false);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFManutencaoMailing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFManutencaoMailing.AtualizaConsulta(VpaPosicionar : boolean);
Var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := Mailing.GetBookmark;
  Mailing.close;
  Mailing.sql.clear;
  Mailing.sql.add('SELECT USU.C_NOM_USU, TAR.SEQTAREFA, TAR.DATLIGACAO, TAR.CODUSUARIO, TAR.CODCLIENTE, ' +
                  ' CLI.C_NOM_CLI , CAM.NOMCAMPANHA, TEL.DATTAREFA, TAR.INDREAGENDADO '+
                  ' FROM TAREFATELEMARKETINGITEM TAR,  CADUSUARIOS USU, '+
                  ' CADCLIENTES CLI, CAMPANHAVENDA CAM, '+
                  ' TAREFATELEMARKETING TEL '+
                  ' Where TAR.CODUSUARIO = USU.I_COD_USU '+
                  ' and TAR.CODCLIENTE = CLI.I_COD_CLI '+
                  ' AND '+SQLTextoRightJoin('TAR.SEQCAMPANHA','CAM.SEQCAMPANHA')+
                  ' AND TAR.SEQTAREFA = TEL.SEQTAREFA ');
  AdicionaFiltros(Mailing.SQL);
  Mailing.sql.add('order by DATLIGACAO, TAR.INDREAGENDADO DESC,CLI.C_NOM_CLI');
  Mailing.open;
  if VpaPosicionar then
    Mailing.GotoBookmark(VpfPosicao);
  Mailing.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFManutencaoMailing.AdicionaFiltros(VpaComandoSQl : TStrings);
begin
  if CPeriodo.Checked then
    VpaComandoSQl.Add(SQLTextoDataEntreAAAAMMDD('TAR.DATLIGACAO',EDatInicio.DateTime,EDatFim.DateTime,CPeriodo.Checked));
  if EUsuario.AInteiro <> 0 then
    VpaComandoSQl.Add('and TAR.CODUSUARIO = '+EUsuario.Text);
  if ETarefa.AInteiro <> 0 then
    VpaComandoSQl.Add('and TAR.SEQTAREFA = '+ETarefa.Text);
end;

{******************************************************************************}
procedure TFManutencaoMailing.EUsuarioFimConsulta(Sender: TObject);
begin
   AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFManutencaoMailing.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFManutencaoMailing.BExcluirLigacaoClick(Sender: TObject);
begin
  if MailingSEQTAREFA.AsInteger <> 0 then
  begin
    if Confirmacao('Tem certeza que deseja excluir esta ligação do mailing?') then
    begin
      ExecutaComandoSql(Aux,'DELETE FROM TAREFATELEMARKETINGITEM '+
                            ' Where SEQTAREFA = '+MailingSEQTAREFA.AsString+
                            ' AND CODUSUARIO = '+ MailingCODUSUARIO.AsString+
                            ' and CODCLIENTE = '+MailingCODCLIENTE.AsString);
      AtualizaConsulta(true);
    end;
  end;
end;

{******************************************************************************}
procedure TFManutencaoMailing.BExcluirTarefaClick(Sender: TObject);
begin
  if MailingSEQTAREFA.AsInteger <> 0 then
  begin
    if Confirmacao('Tem certeza que deseja excluir todas as ligação geradas por essa tarefa do mailing?') then
    begin
      ExecutaComandoSql(Aux,'DELETE FROM TAREFATELEMARKETINGITEM '+
                            ' Where SEQTAREFA = '+MailingSEQTAREFA.AsString+
                            ' AND INDREAGENDADO = ''N''');
      AtualizaConsulta(true);
    end;
  end;
end;

procedure TFManutencaoMailing.BLimparUsuarioClick(Sender: TObject);
begin
  if MailingSEQTAREFA.AsInteger <> 0 then
  begin
    if Confirmacao('Tem certeza que deseja excluir todas as ligação do usuário?') then
    begin
      ExecutaComandoSql(Aux,'DELETE FROM TAREFATELEMARKETINGITEM '+
                            ' Where CODUSUARIO = '+MailingCODUSUARIO.AsString+
                            ' AND INDREAGENDADO = ''N''');
      AtualizaConsulta(true);
    end;
  end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFManutencaoMailing]);
end.
