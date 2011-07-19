unit AFormasPagamento;
{          Autor: Rafael Budag
    Data Criação: 10/04/1999;
          Função: Cadastrar uma nova forma de Pagamento

Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Localizacao,
  DBKeyViolation, Grids, DBGrids, Constantes, DBClient;

type
  TFFormasPagamento = class(TFormularioPermissao)
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
    DataFormas: TDataSource;
    Label2: TLabel;
    Descricao: TDBEditColor;
    Bevel1: TBevel;
    DBGridColor1: TGridIndice;
    Consulta: TLocalizaEdit;
    Label3: TLabel;
    CadFormasPagamento: TSQL;
    CadFormasPagamentoI_COD_FRM: TFMTBCDField;
    CadFormasPagamentoC_NOM_FRM: TWideStringField;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    CadFormasPagamentoC_FLA_BCP: TWideStringField;
    CadFormasPagamentoC_FLA_BCR: TWideStringField;
    CadFormasPagamentoC_FLA_TIP: TWideStringField;
    RTipo: TDBRadioGroup;
    DBCheckBox1: TDBCheckBox;
    CadFormasPagamentoC_BAI_BAC: TWideStringField;
    CadFormasPagamentoC_BAI_CON: TWideStringField;
    CadFormasPagamentoD_ULT_ALT: TSQLTimeStampField;
    CGaveta: TDBCheckBox;
    CadFormasPagamentoC_ACI_GAV: TWideStringField;
    CadFormasPagamentoN_VLR_FRM: TFMTBCDField;
    Label4: TLabel;
    DBEditColor1: TDBEditColor;
    ECodigo: TDBKeyViolation;
    LPerBaixa: TLabel;
    EPerBaixa: TDBEditColor;
    CadFormasPagamentoN_PER_DES: TFMTBCDField;
    LDiasCartao: TLabel;
    EDiasCartao: TDBEditColor;
    CadFormasPagamentoI_DIA_CHE: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadFormasPagamentoAfterInsert(DataSet: TDataSet);
    procedure CadFormasPagamentoBeforePost(DataSet: TDataSet);
    procedure CadFormasPagamentoAfterPost(DataSet: TDataSet);
    procedure CadFormasPagamentoAfterEdit(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure CadFormasPagamentoAfterCancel(DataSet: TDataSet);
    procedure DBKeyViolation1Change(Sender: TObject);
    procedure RTipoChange(Sender: TObject);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FFormasPagamento: TFFormasPagamento;

implementation

uses APrincipal, FunObjeto, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFormasPagamento.FormCreate(Sender: TObject);
begin
   CadFormasPagamento.open;  {  abre tabelas }
   IniciallizaCheckBox([DBCheckBox1, CGaveta], 'S', 'N');
end;

procedure TFFormasPagamento.RTipoChange(Sender: TObject);
begin
  if CadFormasPagamentoC_FLA_TIP.AsString <> '' then
  begin
    AlterarVisibleDet([LPerBaixa,EPerBaixa,LDiasCartao,EDiasCartao],CadFormasPagamentoC_FLA_TIP.AsString[1] in ['T','E']);
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFormasPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadFormasPagamento.close; { fecha tabelas }
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo disponível***********************}
procedure TFFormasPagamento.CadFormasPagamentoAfterInsert(DataSet: TDataSet);
begin
   ECodigo.ProximoCodigo;
   ECodigo.ReadOnly := False;
   ConfiguraConsulta(False);
   CadFormasPagamentoC_BAI_CON.AsString := 'N';
   CadFormasPagamentoC_ACI_GAV.AsString := 'N';
   RTipo.ItemIndex := 0;
end;

{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFFormasPagamento.CadFormasPagamentoBeforePost(DataSet: TDataSet);
begin
  CadFormasPagamentoD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  If CadFormasPagamento.State = dsInsert Then
    ECodigo.VerificaCodigoUtilizado;
end;

{***************Caso o codigo tenha sido utilizado, efetua refresh*************}
procedure TFFormasPagamento.CadFormasPagamentoAfterPost(DataSet: TDataSet);
begin
   Sistema.MarcaTabelaParaImportar('CADFORMASPAGAMENTO');
   Consulta.AtualizaTabela;
   ConfiguraConsulta(true);
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFFormasPagamento.CadFormasPagamentoAfterEdit(DataSet: TDataSet);
begin
   ECodigo.ReadOnly := True;
   ConfiguraConsulta(false);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFFormasPagamento.CadFormasPagamentoAfterCancel(
  DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFFormasPagamento.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   DBGridColor1.Enabled := acao;
   Label3.Enabled := acao;
end;

{***************************Fechar o Formulario corrente***********************}
procedure TFFormasPagamento.BFecharClick(Sender: TObject);
begin
   close;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFFormasPagamento.DBGridColor1Ordem(Ordem: String);
begin
Consulta.AOrdem := ordem;
end;

{**************** valida os campos obrigatorios ****************************** }
procedure TFFormasPagamento.DBKeyViolation1Change(Sender: TObject);
begin
if CadFormasPagamento.State in [ dsInsert, dsEdit ] then
  ValidaGravacao1.execute;
end;



Initialization
 RegisterClasses([TFFormasPagamento]);
end.
