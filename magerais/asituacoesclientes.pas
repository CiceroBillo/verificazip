unit ASituacoesClientes;
{          Autor: Rafael Budag
    Data Criação: 25/03/1999;
          Função: Cadastrar uma nova transportadora
  Data Alteração: 25/03/1999;
    Alterado por:
Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Tabela, Grids,
  DBGrids, StdCtrls, DBCtrls, Mask, BotaoCadastro, Buttons,
  Localizacao, DBKeyViolation, DBClient;

type
  TFSituacoesClientes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Label1: TLabel;
    DataSituacao: TDataSource;
    Label2: TLabel;
    DBEditColor2: TDBEditColor;
    DBGridColor1: TGridIndice;
    Bevel1: TBevel;
    CadSituacoesClientes: TSQL;
    BFechar: TBitBtn;
    CadSituacoesClientesI_COD_SIT: TFMTBCDField;
    CadSituacoesClientesC_NOM_SIT: TWideStringField;
    Consulta: TLocalizaEdit;
    Label3: TLabel;
    ValidaGravacao1: TValidaGravacao;
    CadSituacoesClientesD_ULT_ALT: TSQLTimeStampField;
    ECodigo: TDBKeyViolation;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadSituacoesClientesAfterInsert(DataSet: TDataSet);
    procedure CadSituacoesClientesBeforePost(DataSet: TDataSet);
    procedure CadSituacoesClientesAfterPost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadSituacoesClientesAfterEdit(DataSet: TDataSet);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure CadSituacoesClientesAfterCancel(DataSet: TDataSet);
    procedure DBKeyViolation1Change(Sender: TObject);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FSituacoesClientes: TFSituacoesClientes;

implementation

uses APrincipal, Constantes, UnSistema;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFSituacoesClientes.FormCreate(Sender: TObject);
begin
   CadSituacoesClientes.open;  {  abre tabelas }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFSituacoesClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadSituacoesClientes.close;{ fecha tabelas }
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Açoes das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo disponível***********************}
procedure TFSituacoesClientes.CadSituacoesClientesAfterInsert(DataSet: TDataSet);
begin
   ECodigo.ProximoCodigo;
   ECodigo.ReadOnly := False;
   ConfiguraConsulta(false);
end;

{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFSituacoesClientes.CadSituacoesClientesBeforePost(DataSet: TDataSet);
begin
  CadSituacoesClientesD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
   if CadSituacoesClientes.State = dsinsert then
      ECodigo.VerificaCodigoUtilizado;
end;

{***************Caso o codigo tenha sido utilizado, efetua refresh*************}
procedure TFSituacoesClientes.CadSituacoesClientesAfterPost(DataSet: TDataSet);
begin
   Consulta.AtualizaTabela;
   ConfiguraConsulta(true);
   Sistema.MarcaTabelaParaImportar('CADSITUACOESCLIENTES');
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFSituacoesClientes.CadSituacoesClientesAfterEdit(
  DataSet: TDataSet);
begin
   ECodigo.ReadOnly := True;
   ConfiguraConsulta(false);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFSituacoesClientes.CadSituacoesClientesAfterCancel(
  DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFSituacoesClientes.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   DBGridColor1.Enabled := acao;
   Label3.Enabled := acao;
end;

{*************************Fecha o formulario corrente**************************}
procedure TFSituacoesClientes.BFecharClick(Sender: TObject);
begin
   close;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFSituacoesClientes.DBGridColor1Ordem(Ordem: String);
begin
Consulta.AOrdem := ordem;
end;


procedure TFSituacoesClientes.DBKeyViolation1Change(Sender: TObject);
begin
if CadSituacoesClientes.State in [ dsEdit, dsInsert ] then
 ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFSituacoesClientes]);
end.
