unit ANovaTransportadora;
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
  StdCtrls, Mask, DBCtrls, Db, DBTables, Tabela, BotaoCadastro,
  Buttons, ExtCtrls, Componentes1, DBCidade, DBKeyViolation, DBGrids,
  Localizacao, PainelGradiente, constantes, Constmsg, Grids, DBClient;

type
  TFNovaTransportadora = class(TFormularioPermissao)
    CadTransportadoras: TSQL;
    DataTransportadora: TDataSource;
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    MoveBasico1: TMoveBasico;
    PanelColor2: TPanelColor;
    Label13: TLabel;
    Label14: TLabel;
    DBEditColor1: TDBEditColor;
    Label15: TLabel;
    Label1: TLabel;
    DBEditColor2: TDBEditColor;
    Label16: TLabel;
    DBEditColor3: TDBEditColor;
    Label2: TLabel;
    DBEditColor4: TDBEditColor;
    DBEditColor12: TDBEditColor;
    Label11: TLabel;
    DBEditColor8: TDBEditColor;
    Label9: TLabel;
    DBEditColor7: TDBEditColor;
    Label8: TLabel;
    DBEditColor6: TDBEditColor;
    Label4: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    DBEditColor9: TDBEditColor;
    Label10: TLabel;
    Label5: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    DBEditColor13: TDBEditColor;
    DBEditColor14: TDBEditColor;
    CadTransportadorasI_COD_TRA: TFMTBCDField;
    CadTransportadorasC_NOM_TRA: TWideStringField;
    CadTransportadorasC_END_TRA: TWideStringField;
    CadTransportadorasC_BAI_TRA: TWideStringField;
    CadTransportadorasI_NUM_TRA: TFMTBCDField;
    CadTransportadorasC_CID_TRA: TWideStringField;
    CadTransportadorasC_EST_TRA: TWideStringField;
    CadTransportadorasC_FON_TRA: TWideStringField;
    CadTransportadorasC_FAX_TRA: TWideStringField;
    CadTransportadorasC_NOM_GER: TWideStringField;
    CadTransportadorasC_CGC_TRA: TWideStringField;
    CadTransportadorasC_INS_TRA: TWideStringField;
    CadTransportadorasD_DAT_MOV: TSQLTimeStampField;
    CadTransportadorasC_WWW_TRA: TWideStringField;
    CadTransportadorasC_END_ELE: TWideStringField;
    DBEditPos21: TDBEditPos2;
    DBEditPos22: TDBEditPos2;
    DBEditColor10: TDBEditColor;
    CadTransportadorasC_COM_END: TWideStringField;
    Label17: TLabel;
    BFechar: TBitBtn;
    Label18: TLabel;
    DBEditColor11: TDBEditColor;
    CadTransportadorasCOD_CIDADE: TFMTBCDField;
    ECidade: TDBEditLocaliza;
    BCidade: TSpeedButton;
    BRua: TSpeedButton;
    Localiza: TConsultaPadrao;
    CadTransportadorasC_CEP_TRA: TWideStringField;
    ValidaGravacao1: TValidaGravacao;
    CadTransportadorasD_ULT_ALT: TSQLTimeStampField;
    DBCheckBox1: TDBCheckBox;
    CadTransportadorasC_IND_ATI: TWideStringField;
    ECodigo: TDBKeyViolation;
    CadTransportadorasI_COD_PAI: TFMTBCDField;
    CadTransportadorasI_COD_IBG: TFMTBCDField;
    CadTransportadorasC_IND_PRO: TWideStringField;
    DBCheckBox2: TDBCheckBox;
    CadTransportadorasL_OBS_TRA: TWideStringField;
    DBMemoColor1: TDBMemoColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadTransportadorasAfterInsert(DataSet: TDataSet);
    procedure CadTransportadorasBeforePost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadTransportadorasAfterEdit(DataSet: TDataSet);
    procedure ECidadeCadastrar(Sender: TObject);
    procedure ECidadeRetorno(Retorno1, Retorno2: String);
    procedure BRuaClick(Sender: TObject);
    procedure DBFilialColor1Change(Sender: TObject);
    procedure CadTransportadorasAfterPost(DataSet: TDataSet);
    procedure DBEditColor7Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNovaTransportadora: TFNovaTransportadora;

implementation

uses APrincipal,  ACadCidades, AConsultaRuas, funstring,
     UnClientes, UnSistema;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaTransportadora.FormCreate(Sender: TObject);
begin
  CadTransportadoras.open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaTransportadora.FormClose(Sender: TObject; var Action: TCloseAction);
begin
CadTransportadoras.close;
Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações da Tabela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**********Verifica se o codigo já foi utilizado por outro usuario na rede*****}
procedure TFNovaTransportadora.CadTransportadorasBeforePost(DataSet: TDataSet);
begin
  CadTransportadorasD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
   if CadTransportadoras.State = dsinsert then
      ECodigo.VerificaCodigoUtilizado;
end;

{**********************Carrega os dados default do cadastro********************}
procedure TFNovaTransportadora.CadTransportadorasAfterInsert(
  DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  DBEditColor12.Field.Value := date;
  ECodigo.ReadOnly := False;
  CadTransportadorasC_IND_ATI.AsString:= 'S';
  CadTransportadorasC_IND_PRO.AsString := 'N';
end;

{******************************************************************************}
procedure TFNovaTransportadora.CadTransportadorasAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADTRANSPORTADORAS');
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFNovaTransportadora.CadTransportadorasAfterEdit(
  DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************Fecha o formulario corrente***************************}
procedure TFNovaTransportadora.BFecharClick(Sender: TObject);
begin
   close;
end;


procedure TFNovaTransportadora.ECidadeCadastrar(Sender: TObject);
begin
  FCidades := TFCidades.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FCidades'));
  FCidades.ShowModal;
end;

procedure TFNovaTransportadora.ECidadeRetorno(Retorno1,
  Retorno2: String);
begin
  if (Retorno2 <> '') then
    if (CadTransportadoras.State in [dsInsert, dsEdit]) then
    begin
      if Retorno1 <> '' then
        CadTransportadorasI_COD_IBG.AsInteger:=StrToInt(Retorno1)
      else
        CadTransportadorasI_COD_IBG.clear;
      CadTransportadorasC_EST_TRA.AsString:=Retorno2; // Grava o Estado;
      CadTransportadorasI_COD_PAI.AsInteger := FunClientes.RCodPais(Retorno2);
    end;
end;

procedure TFNovaTransportadora.BRuaClick(Sender: TObject);
var
  VpfCodCidade,
  VpfCEP,
  VpfRua,
  VpfBairro,
  VpfDesCidade: string;
begin
  if CadTransportadoras.State in [dsedit, dsInsert] then
  begin
    VpfCEP := SubstituiStr(VpfCEP,'-','');
    FConsultaRuas := TFConsultaRuas.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FConsultaRuas'));
    if FConsultaRuas.BuscaEndereco(VpfCodCidade, VpfCEP,
        VpfRua, VpfBairro, VpfDesCidade)
    then
    begin
      // Preenche os campos;
      CadTransportadorasCOD_CIDADE.AsInteger := StrToInt(VpfCodCidade);
      CadTransportadorasC_CEP_TRA.AsString := VpfCEP;
      CadTransportadorasC_CID_TRA.AsString := VpfDesCidade;
      CadTransportadorasC_END_TRA.AsString := VpfRua;
      CadTransportadorasC_BAI_TRA.AsString := VpfBairro;
      ECidade.Atualiza;
    end;
  end;
end;

procedure TFNovaTransportadora.DBEditColor7Exit(Sender: TObject);
begin
  if CadTransportadoras.State in [dsedit,dsinsert] then
    if (CadTransportadorasC_CGC_TRA.AsString = varia.CNPJFilial)  then
      CadTransportadorasC_IND_PRO.AsString := 'S';
end;

procedure TFNovaTransportadora.DBFilialColor1Change(Sender: TObject);
begin
  if CadTransportadoras.State in [dsedit,dsinsert] then
    ValidaGravacao1.Execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaTransportadora]);
end.
