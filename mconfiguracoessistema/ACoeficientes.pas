unit ACoeficientes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, DB, DBClient, Tabela, Componentes1, Grids, DBGrids,
  DBKeyViolation, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons;

type
  TFCoeficientes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    GridIndice1: TGridIndice;
    PanelColor1: TPanelColor;
    CoeficienteCusto: TSQL;
    DataCoeficienteCusto: TDataSource;
    CoeficienteCustoCODCOEFICIENTE: TFMTBCDField;
    CoeficienteCustoNOMCOEFICIENTE: TWideStringField;
    CoeficienteCustoPERCOMISSAO: TFMTBCDField;
    CoeficienteCustoPERLUCRO: TFMTBCDField;
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
  FCoeficientes: TFCoeficientes;

implementation

uses APrincipal, FunSql, ANovoCoeficienteCusto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCoeficientes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCoeficientes.AtualizaConsulta;
begin
  AdicionaSQLAbreTabela(CoeficienteCusto,'select CODCOEFICIENTE, NOMCOEFICIENTE, PERCOMISSAO, PERLUCRO '+
                                         ' from COEFICIENTECUSTO '+
                                         ' order by CODCOEFICIENTE');
end;

{ *************************************************************************** }
procedure TFCoeficientes.BFecharClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFCoeficientes.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovoCoeficienteCusto.CoeficienteCusto,'Select * from COEFICIENTECUSTO '+
                                                              ' Where CODCOEFICIENTE = '+IntToStr(CoeficienteCustoCODCOEFICIENTE.AsInteger));
end;

{ **************************************************************************** }
procedure TFCoeficientes.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovoCoeficienteCusto := TFNovoCoeficienteCusto.CriarSDI(self,'',true);
end;

{ **************************************************************************** }
procedure TFCoeficientes.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovoCoeficienteCusto.ShowModal;
  AtualizaConsulta;
end;

{ **************************************************************************** }
procedure TFCoeficientes.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovoCoeficienteCusto.Show;
end;

{ **************************************************************************** }
procedure TFCoeficientes.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovoCoeficienteCusto.close;
  AtualizaConsulta;
end;

{ **************************************************************************** }
procedure TFCoeficientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CoeficienteCusto.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCoeficientes]);
end.
