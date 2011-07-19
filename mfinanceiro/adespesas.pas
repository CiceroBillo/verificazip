unit ADespesas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, ExtCtrls, StdCtrls, Mask, DBCtrls,
  DBKeyViolation, Db, DBTables, BotaoCadastro, Buttons, Componentes1,
  PainelGradiente, Localizacao, DBCidade, DBClient;

type
  TFDespesas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    DataCadDespesas: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    EDescricao: TDBEditColor;
    EAtividade: TDBEditColor;
    Aux: TQuery;
    Label5: TLabel;
    DBEditColor4: TDBEditColor;
    EKeyViolation: TDBKeyViolation2;
    ProximoCodigo: TProximoCodigoFilial;
    Label6: TLabel;
    EMesesPrevia: TDBEditColor;
    Label7: TLabel;
    EMesesGerar: TDBEditColor;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label10: TLabel;
    Label8: TLabel;
    CadDespesas: TSQL;
    CadDespesasI_COD_DES: TIntegerField;
    CadDespesasC_NOM_DES: TStringField;
    CadDespesasC_ATI_DES: TStringField;
    CadDespesasI_EMP_FIL: TIntegerField;
    CadDespesasI_MES_MED: TIntegerField;
    CadDespesasI_MES_GER: TIntegerField;
    Localiza: TConsultaPadrao;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    CadDespesasC_CLA_PLA: TStringField;
    CadDespesasI_COD_EMP: TIntegerField;
    Label4: TLabel;
    EPlano: TEditColor;
    LPlano: TLabel;
    CadDespesasD_ULT_ALT: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadDespesasAfterInsert(DataSet: TDataSet);
    procedure EAtividadeKeyPress(Sender: TObject; var Key: Char);
    procedure CadDespesasBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadDespesasAfterPost(DataSet: TDataSet);
  private
    VprCodDespesaFixa: Integer;
    VprCadastrou: Boolean;
  public
    { Public declarations }
    function InsereLocalizaConta(VpaCodPlano, VpaDesPlano: string; var VpaCodDespesaFixa: Integer): Boolean;
  end;

var
  FDespesas: TFDespesas;

implementation

uses APrincipal, constantes, FunSql;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFDespesas.FormCreate(Sender: TObject);
begin
  VprCadastrou := False;
  AdicionaSQLAbreTabela(CadDespesas, ' SELECT * FROM  CADDESPESAS ' +
                                     ' WHERE  I_EMP_FIL = ' +
                                     IntToStr(varia.CodigoEmpFil));
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDespesas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CadDespesas);
  Action := CaFree;
end;

{ ***** Cadastra a despesa fixa e retorna seu código por valor e true se cadastrou, senão retorna false ****** }
function TFDespesas.InsereLocalizaConta(VpaCodPlano, VpaDesPlano: string; var VpaCodDespesaFixa: Integer): Boolean;
begin
  EPlano.Text:= VpaCodPlano;
  LPlano.Caption := VpaDesPlano;
  CadDespesas.Insert;
  Self.ShowModal;
  VpaCodDespesaFixa:=VprCodDespesaFixa;
  Result:=VprCadastrou;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo disponível***********************}
procedure TFDespesas.CadDespesasAfterInsert(DataSet: TDataSet);
begin
  CadDespesasI_EMP_FIl.value := Varia.CodigoEmpFil;
  CadDespesasI_COD_EMP.AsInteger := Varia.CodigoEmpresa;
  ProximoCodigo.Execute( 'CadDespesas', 'I_EMP_FIL', Varia.CodigoEmpFil);
  EMesesPrevia.Field.Value := 1;
  EMesesGerar.Field.Value := 1;
  EAtividade.Field.Value := 'S';
end;

{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFDespesas.CadDespesasBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadDespesasD_ULT_ALT.AsDateTime := Date;

  if CadDespesas.State = dsinsert then
    ProximoCodigo.VerificaCodigo;
  VprCodDespesaFixa:=CadDespesasI_COD_DES.AsInteger;
  if (Trim(EPlano.Text) <> '') then
    CadDespesasC_CLA_PLA.AsString:=Trim(EPlano.Text);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************************Fechar o Formulario corrente***********************}
procedure TFDespesas.BFecharClick(Sender: TObject);
begin
  FechaTabela(CadDespesas);
  Close;
end;

{ ****** Força a digitação de S/N ou s/n ****** }
procedure TFDespesas.EAtividadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Integer(Key) in [115,110,83,78,8]) Then
  begin
     beep;
     Key := #0;
  end;
end;


procedure TFDespesas.CadDespesasAfterPost(DataSet: TDataSet);
begin
  VprCadastrou:=True;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFDespesas]);
end.
