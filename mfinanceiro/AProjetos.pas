unit AProjetos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, BotaoCadastro, StdCtrls, Buttons, DB, Mask, DBCtrls,
  Tabela, DBKeyViolation, DBClient, CBancoDados, Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids, Localizacao;

type
  TFProjetos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Projeto: TRBSQL;
    ECodigo: TDBKeyViolation;
    ProjetoCODPROJETO: TFMTBCDField;
    ProjetoNOMPROJETO: TWideStringField;
    DataProjeto: TDataSource;
    DBEditColor1: TDBEditColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ProjetoAfterInsert(DataSet: TDataSet);
    procedure ProjetoAfterEdit(DataSet: TDataSet);
    procedure ProjetoAfterPost(DataSet: TDataSet);
    procedure ProjetoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FProjetos: TFProjetos;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProjetos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProjetos.ProjetoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProjetos.ProjetoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProjetos.ProjetoAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProjetos.ProjetoBeforePost(DataSet: TDataSet);
begin
  if Projeto.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProjetos.BFecharClick(Sender: TObject);
begin
  close;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProjetos.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFProjetos]);
end.
