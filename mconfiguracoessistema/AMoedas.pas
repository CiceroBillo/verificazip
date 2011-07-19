unit AMoedas;
{          Autor: Rafael Budag
    Data Criação: 09/04/1999;
          Função: Cadastrar uma nova moeda
  Data Alteração:
    Alterado por:
Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  DBKeyViolation, Grids, DBGrids, Tabela, StdCtrls, Componentes1,
  Localizacao, ExtCtrls, Mask, DBCtrls, Db, DBTables, BotaoCadastro,
  Buttons, PainelGradiente, DBClient;

type
  TFMoedas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    CadMoedas: TSQL;
    CadMoedasI_COD_MOE: TFMTBCDField;
    CadMoedasC_NOM_MOE: TWideStringField;
    Label1: TLabel;
    DataCadMoeda: TDataSource;
    Label2: TLabel;
    Z: TDBEditColor;
    Bevel1: TBevel;
    Consulta: TLocalizaEdit;
    Label3: TLabel;
    GridIndice1: TGridIndice;
    DBEditColor1: TDBEditColor;
    Label4: TLabel;
    CadMoedasC_CIF_MOE: TWideStringField;
    ValidaGravacao1: TValidaGravacao;
    CadMoedasC_DES_SIN: TWideStringField;
    CadMoedasC_DES_PLU: TWideStringField;
    Label5: TLabel;
    DBEditColor2: TDBEditColor;
    Label6: TLabel;
    DBEditColor3: TDBEditColor;
    CadMoedasD_ULT_ALT: TSQLTimeStampField;
    ECodigo: TDBKeyViolation;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CadMoedasBeforeEdit(DataSet: TDataSet);
    procedure CadMoedasBeforePost(DataSet: TDataSet);
    procedure CadMoedasAfterInsert(DataSet: TDataSet);
    procedure CadMoedasAfterEdit(DataSet: TDataSet);
    procedure CadMoedasAfterPost(DataSet: TDataSet);
    procedure GridIndice1Ordem(Ordem: String);
    procedure DBEditColor1Change(Sender: TObject);
    procedure CadMoedasAfterCancel(DataSet: TDataSet);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FMoedas: TFMoedas;

implementation

uses APrincipal, Constantes, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMoedas.FormCreate(Sender: TObject);
begin
   CadMoedas.open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMoedas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadMoedas.close;
   Action := CaFree;
end;

procedure TFMoedas.CadMoedasBeforeEdit(DataSet: TDataSet);
begin

end;
{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFMoedas.CadMoedasBeforePost(DataSet: TDataSet);
begin
  CadMoedasD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
   if CadMoedas.state = dsinsert Then
      ECodigo.VerificaCodigoUtilizado;
end;

{***********************Gera o proximo codigo disponível***********************}
procedure TFMoedas.CadMoedasAfterInsert(DataSet: TDataSet);
begin
   ECodigo.ProximoCodigo;
   ECodigo.ReadOnly := False;
   ConfiguraConsulta(false);
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFMoedas.CadMoedasAfterEdit(DataSet: TDataSet);
begin
   ECodigo.ReadOnly := true;
   ConfiguraConsulta(false);
end;

{******************************Atualiza a tabela*******************************}
procedure TFMoedas.CadMoedasAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADMOEDAS');
  Consulta.AtualizaTabela;
  ConfiguraConsulta(true);
end;

{************************ apos cancelar das operacoes da tabela ************** }
procedure TFMoedas.CadMoedasAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFMoedas.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   GridIndice1.Enabled := acao;
   Label3.Enabled := acao;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFMoedas.BFecharClick(Sender: TObject);
begin
   self.close;
end;

{*************No duplo click do grid altera o registro selecionado*************}
procedure TFMoedas.GridIndice1Ordem(Ordem: String);
begin
Consulta.AOrdem := Ordem;
end;

{*************** valida a gravacao do formulario **************************  }
procedure TFMoedas.DBEditColor1Change(Sender: TObject);
begin
if CadMoedas.State in [ dsEdit, dsInsert ] then
  ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMoedas]);
end.
