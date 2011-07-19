unit ACampanhaVendas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, BotaoCadastro, StdCtrls, Buttons, Db, DBTables, DBClient;

type
  TFCampanhaVendas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    CampanhaVenda: TSQL;
    CampanhaVendaSEQCAMPANHA: TFMTBCDField;
    CampanhaVendaNOMCAMPANHA: TWideStringField;
    CampanhaVendaCODUSUARIO: TFMTBCDField;
    CampanhaVendaDATVALIDADE: TSQLTimeStampField;
    Label1: TLabel;
    DataCampanhaVenda: TDataSource;
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
  FCampanhaVendas: TFCampanhaVendas;

implementation

uses APrincipal, ANovaCampanhaVendas, funSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCampanhaVendas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCampanhaVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CampanhaVenda.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCampanhaVendas.AtualizaConsulta;
begin
  CampanhaVenda.close;
  CampanhaVenda.Open;
end;

{******************************************************************************}
procedure TFCampanhaVendas.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCampanhaVendas.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovaCampanhaVendas := TFNovaCampanhaVendas.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaCampanhaVendas'));
end;

{******************************************************************************}
procedure TFCampanhaVendas.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovaCampanhaVendas.Showmodal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFCampanhaVendas.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovaCampanhaVendas.CampanhaVendas,'Select * from CAMPANHAVENDA '+
                        ' Where SEQCAMPANHA = '+CampanhaVendaSEQCAMPANHA.AsString);
end;

{******************************************************************************}
procedure TFCampanhaVendas.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovaCampanhaVendas.show;
end;

{******************************************************************************}
procedure TFCampanhaVendas.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovaCampanhaVendas.close;
  AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCampanhaVendas]);
end.
