unit AEventos;
{          Autor: Rafael Budag
    Data Criação: 25/03/1999;
          Função: 
  Data Alteração: 25/03/1999;
    Alterado por:
Motivo alteração:
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Mask, DBCtrls, Tabela, Db, DBTables, Grids, DBGrids,
  BotaoCadastro, Buttons, Componentes1, ExtCtrls, PainelGradiente,
  DBKeyViolation, Localizacao, DBClient;

type
  TFEventos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    MoveBasico1: TMoveBasico;
    PanelColor1: TPanelColor;
    DBGridColor1: TGridIndice;
    DataEventos: TDataSource;
    DBEditColor2: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    BFechar: TBitBtn;
    Bevel1: TBevel;
    Label3: TLabel;
    Consulta: TLocalizaEdit;
    CadEventos: TSQL;
    CadEventosI_COD_EVE: TFMTBCDField;
    CadEventosC_NOM_EVE: TWideStringField;
    ValidaGravacao1: TValidaGravacao;
    CadEventosD_ULT_ALT: TSQLTimeStampField;
    ECodigo: TDBKeyViolation;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadEventosAfterInsert(DataSet: TDataSet);
    procedure CadEventosBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadEventosAfterPost(DataSet: TDataSet);
    procedure CadEventosAfterEdit(DataSet: TDataSet);
    procedure CadEventosAfterCancel(DataSet: TDataSet);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure DBKeyViolation1Change(Sender: TObject);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FEventos: TFEventos;

implementation

uses APrincipal,constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }

procedure TFEventos.FormCreate(Sender: TObject);
begin
  cadEventos.open;
end;

{ ******************* Quando o formulario e fechado ************************** }

procedure TFEventos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 cadEventos.close;
 Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações da Tabela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{*********************Gera o próximo código livre******************************}

procedure TFEventos.CadEventosAfterInsert(DataSet: TDataSet);
begin
   ECodigo.ProximoCodigo;
   ECodigo.ReadOnly := false;
   ConfiguraConsulta(false);
end;

{**********Verifica se o codigo já foi utilizado por outro usuario na rede*****}

procedure TFEventos.CadEventosBeforePost(DataSet: TDataSet);
begin
  CadEventosD_ULT_ALT.AsDateTime := Date;
   if CadEventos.State = dsinsert then
      ECodigo.VerificaCodigoUtilizado;
end;

{***************************Atualiza a tabela**********************************}

procedure TFEventos.CadEventosAfterPost(DataSet: TDataSet);
begin
  Consulta.AtualizaTabela;
  ConfiguraConsulta(true);
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFEventos.CadEventosAfterEdit(DataSet: TDataSet);
begin
   ECodigo.ReadOnly := true;
   ConfiguraConsulta(false);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFEventos.CadEventosAfterCancel(DataSet: TDataSet);
begin
   ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFEventos.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   DBGridColor1.Enabled := acao;
   Label3.Enabled := acao;
end;

{**************************Fecha o formulario corrente*************************}
procedure TFEventos.BFecharClick(Sender: TObject);
begin
   close;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFEventos.DBGridColor1Ordem(Ordem: String);
begin
Consulta.AOrdem := Ordem;
end;

procedure TFEventos.DBKeyViolation1Change(Sender: TObject);
begin
if CadEventos.State in [ dsEdit, dsInsert ] then
 ValidaGravacao1.execute;
end;

Initialization
 RegisterClasses([TFEventos]);
end.
