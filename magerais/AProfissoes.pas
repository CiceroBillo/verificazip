unit AProfissoes;
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
  Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids,
  Tabela, Db, DBTables, StdCtrls, Mask, DBCtrls, BotaoCadastro, Buttons,
  Localizacao, DBKeyViolation, DBClient;

type
  TFProfissoes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoCancelar1: TBotaoCancelar;
    BotaoGravar1: TBotaoGravar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoAlterar1: TBotaoAlterar;
    BotaoCadastrar1: TBotaoCadastrar;
    MoveBasico1: TMoveBasico;
    Label1: TLabel;
    DataCadProfissao: TDataSource;
    Label2: TLabel;
    DBEditColor1: TDBEditColor;
    DBGridColor1: TGridIndice;
    Consulta: TLocalizaEdit;
    Label3: TLabel;
    CadProfissoes: TSQL;
    BFechar: TBitBtn;
    Bevel2: TBevel;
    CadProfissoesI_COD_PRF: TFMTBCDField;
    CadProfissoesC_NOM_PRF: TWideStringField;
    ValidaGravacao1: TValidaGravacao;
    CadProfissoesD_ULT_ALT: TSQLTimeStampField;
    ECodigo: TDBKeyViolation;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadProfissoesAfterInsert(DataSet: TDataSet);
    procedure CadProfissoesAfterPost(DataSet: TDataSet);
    procedure CadProfissoesBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadProfissoesAfterEdit(DataSet: TDataSet);
    procedure CadProfissoesAfterCancel(DataSet: TDataSet);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure DBKeyViolation1Change(Sender: TObject);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FProfissoes: TFProfissoes;

implementation

uses APrincipal, Constantes, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProfissoes.FormCreate(Sender: TObject);
begin
   CadProfissoes.open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProfissoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadProfissoes.close;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações da Tabela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*****************Gera o proximo codigo disponivel como default****************}
procedure TFProfissoes.CadProfissoesAfterInsert(DataSet: TDataSet);
begin
    ECodigo.ProximoCodigo;
    ECodigo.ReadOnly := False;
    ConfiguraConsulta(false);
end;

{**********Verifica se o codigo já foi utilizado por outro usuario na rede*****}
procedure TFProfissoes.CadProfissoesBeforePost(DataSet: TDataSet);
begin
  CadProfissoesD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
   if CadProfissoes.State = dsinsert then
      ECodigo.VerificaCodigoUtilizado;
end;


{Atualiza o cadastro caso o codigo tenha sido utilizado por outro usuario na rede}
procedure TFProfissoes.CadProfissoesAfterPost(DataSet: TDataSet);
begin
   Consulta.AtualizaTabela;
   ConfiguraConsulta(true);
  Sistema.MarcaTabelaParaImportar('CADPROFISSOES');
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFProfissoes.CadProfissoesAfterEdit(DataSet: TDataSet);
begin
   ECodigo.ReadOnly := True;
   ConfiguraConsulta(false);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFProfissoes.CadProfissoesAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFProfissoes.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   DBGridColor1.Enabled := acao;
   Label3.Enabled := acao;
end;

{************************Fecha o formulario corrente***************************}
procedure TFProfissoes.BFecharClick(Sender: TObject);
begin
   Close;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFProfissoes.DBGridColor1Ordem(Ordem: String);
begin
Consulta.AOrdem := ordem;
end;

procedure TFProfissoes.DBKeyViolation1Change(Sender: TObject);
begin
if CadProfissoes.State in [ dsInsert, dsEdit ] then
  ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFProfissoes]);
end.
