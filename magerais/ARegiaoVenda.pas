unit ARegiaoVenda;
{   Autor: Sergio Luiz Censi
    Data Criação: 29/03/1999;
          Função: Cadastrar um nova regiao
  Data Alteração: 29/03/1999;
    Alterado por: Rafael Budag
Motivo alteração: Adicionado os comementários e os blocos e testado - 29/03/1999 / Rafael Budag
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Localizacao,
  DBKeyViolation, Grids, DBGrids, DBClient;

type
  TFRegiaoVenda = class(TFormularioPermissao)
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
    DataBancos: TDataSource;
    Label2: TLabel;
    DBEditColor1: TDBEditColor;
    DBKeyViolation1: TDBKeyViolation;
    Bevel1: TBevel;
    DBGridColor1: TGridIndice;
    CadRegiao: TSQL;
    consulta: TLocalizaEdit;
    Label6: TLabel;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    CadRegiaoI_COD_REG: TFMTBCDField;
    CadRegiaoC_NOM_REG: TWideStringField;
    CadRegiaoD_ULT_ALT: TSQLTimeStampField;
    CadRegiaoI_CEP_INI: TFMTBCDField;
    CadRegiaoI_CEP_FIM: TFMTBCDField;
    Label3: TLabel;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    Label4: TLabel;
    Aux: TSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadRegiaoAfterInsert(DataSet: TDataSet);
    procedure CadRegiaoBeforePost(DataSet: TDataSet);
    procedure CadRegiaoAfterPost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadRegiaoAfterEdit(DataSet: TDataSet);
    procedure CadRegiaoAfterCancel(DataSet: TDataSet);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure DBKeyViolation1Change(Sender: TObject);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FRegiaoVenda: TFRegiaoVenda;

implementation

uses APrincipal, Constantes,funSql, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRegiaoVenda.FormCreate(Sender: TObject);
begin
   CadRegiao.open;  {  abre tabelas }
end;

{ ******************* Quando o formulario e fechado ************************** }
 procedure TFRegiaoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadRegiao.close; { fecha tabelas }
 Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo disponível***********************}
procedure TFRegiaoVenda.CadRegiaoAfterInsert(DataSet: TDataSet);
begin
   DBKeyViolation1.proximocodigo;
   DBKeyViolation1.ReadOnly := False;
   ConfiguraConsulta(false);
end;

{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFRegiaoVenda.CadRegiaoBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadRegiaoD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  If CadRegiao.State = dsInsert Then
    DBKeyViolation1.VerificaCodigoutilizado;
end;

{***************Caso o codigo tenha sido utilizado, efetua refresh*************}
procedure TFRegiaoVenda.CadRegiaoAfterPost(DataSet: TDataSet);
begin
   ExecutaComandoSql(Aux,'UPDATE CADCLIENTES '+
                         ' SET I_COD_REG = NULL'+
                         ' Where I_COD_REG = '+CadRegiaoI_COD_REG.AsString);
   ExecutaComandoSql(Aux,'UPDATE CADCLIENTES '+
                         ' SET I_COD_REG = '+CadRegiaoI_COD_REG.AsString+
                         ' Where NVL(C_CEP_CLI,0) >= '+IntToStr(CadRegiaoI_CEP_INI.AsInteger)+
                         ' and NVL(C_CEP_CLI,0) <= '+IntToStr(CadRegiaoI_CEP_FIM.AsInteger));
   consulta.AtualizaTabela;
   ConfiguraConsulta(true);
  Sistema.MarcaTabelaParaImportar('CADREGIAOVENDA');
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFRegiaoVenda.CadRegiaoAfterEdit(DataSet: TDataSet);
begin
   DBKeyViolation1.ReadOnly := true;
   ConfiguraConsulta(false);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFRegiaoVenda.CadRegiaoAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFRegiaoVenda.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   DBGridColor1.Enabled := acao;
   Label6.Enabled := acao;
end;

{***************************Fechar o Formulario corrente***********************}
procedure TFRegiaoVenda.BFecharClick(Sender: TObject);
begin
   self.close;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFRegiaoVenda.DBGridColor1Ordem(Ordem: String);
begin
consulta.AOrdem := ordem;
end;

procedure TFRegiaoVenda.DBKeyViolation1Change(Sender: TObject);
begin
if CadRegiao.State in [ dsEdit, dsInsert ] then
  ValidaGravacao1.execute;
end;

Initialization
 RegisterClasses([TFRegiaoVenda]);
end.
