unit ANaturezas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, BotaoCadastro, StdCtrls, Buttons, DBTables, Tabela,
  Componentes1, ExtCtrls, PainelGradiente, DBKeyViolation, Grids, DBGrids,
  Mask, DBCtrls, Localizacao, DBClient;

type
  TFNaturezas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    DataNatureza: TDataSource;
    BFechar: TBitBtn;
    PanelColor2: TPanelColor;
    Consulta: TLocalizaEdit;
    Label3: TLabel;
    CadNatureza: TSQL;
    GridIndice1: TGridIndice;
    BotaoConsultar1: TBotaoConsultar;
    CadNaturezaC_COD_NAT: TWideStringField;
    CadNaturezaC_NOM_NAT: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridColor1TitleClick(Column: TColumn);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure BotaoCadastrar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNaturezas: TFNaturezas;

implementation

uses APrincipal, ANovaNatureza,Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNaturezas.FormCreate(Sender: TObject);
begin
   Consulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNaturezas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadNatureza.close; { fecha tabelas }
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**********Altera a ordem da tabela e atualiza o indice do grid****************}
procedure TFNaturezas.DBGridColor1TitleClick(Column: TColumn);
begin
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFNaturezas.BFecharClick(Sender: TObject);
begin
   close;
end;

{****************Cria o Formulario para inserir um novo registro***************}
procedure TFNaturezas.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
   FNovaNatureza := TFNovaNatureza.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNatureza'));
end;

procedure TFNaturezas.BotaoCadastrar1Click(Sender: TObject);
begin

end;

{**************Mostra o novo formulario e na volta atualiza a Tabela***********}
procedure TFNaturezas.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
   FNovaNatureza.ShowModal;
   Consulta.AtualizaTabela;
end;

{*****************************Posiciona o registro*****************************}
procedure TFNaturezas.BotaoAlterar1Atividade(Sender: TObject);
begin
   FNovaNatureza.PosicionaNatureza(FNovaNatureza.CadNaturezas,CadNaturezaC_COD_NAT.AsString);
   FNovaNatureza.BotaoGravar1.AFecharAposOperacao := true;
end;

{***********************Mostra o registro a ser excluído***********************}
procedure TFNaturezas.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
   FNovaNatureza.show;
end;

{********************Fecha o formulário do registro excluído*******************}
procedure TFNaturezas.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
   FNovaNatureza.close;
   Consulta.AtualizaTabela;
end;

{**************************Aciona o botão Alterar******************************}
Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNaturezas]);
end.
