unit ANovoVendedor;
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
  ExtCtrls, BotaoCadastro, StdCtrls, Buttons, Db,  DBTables,
  Tabela, Mask, DBCtrls, DBCidade, Componentes1, Grids, DBGrids,
  Localizacao, DBKeyViolation, LabelCorMove, PainelGradiente, constantes, constMsg,
  DBClient;

type
  TFNovoVendedor = class(TFormularioPermissao)
    CadVendedores: TSQL;
    DataCadVendedores: TDataSource;
    CadVendedoresI_COD_VEN: TFMTBCDField;
    CadVendedoresC_NOM_VEN: TWideStringField;
    CadVendedoresC_END_VEN: TWideStringField;
    CadVendedoresC_BAI_VEN: TWideStringField;
    CadVendedoresC_CID_VEN: TWideStringField;
    CadVendedoresI_NUM_VEN: TFMTBCDField;
    CadVendedoresC_EST_VEN: TWideStringField;
    CadVendedoresC_FON_VEN: TWideStringField;
    CadVendedoresC_FAX_VEN: TWideStringField;
    CadVendedoresC_CPF_VEN: TWideStringField;
    CadVendedoresC_IDE_VEN: TWideStringField;
    CadVendedoresD_DAT_CAD: TSQLTimeStampField;
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label12: TLabel;
    Label13: TLabel;
    DBEditColor2: TDBEditColor;
    Label1: TLabel;
    Label14: TLabel;
    Label7: TLabel;
    Label16: TLabel;
    DBEditColor8: TDBEditColor;
    Label8: TLabel;
    DBEditColor10: TDBEditColor;
    Label5: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    DBEditColor13: TDBEditColor;
    Label15: TLabel;
    DBEditColor4: TDBEditColor;
    Label3: TLabel;
    DBEditColor5: TDBEditColor;
    Label4: TLabel;
    DBEditColor6: TDBEditColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    DBEditCPF1: TDBEditCPF;
    CadVendedoresC_CEL_VEN: TWideStringField;
    Label2: TLabel;
    DBEditPos21: TDBEditPos2;
    DBEditPos22: TDBEditPos2;
    DBEditPos23: TDBEditPos2;
    CadVendedoresC_CON_VEN: TWideStringField;
    DBMemoColor1: TDBMemoColor;
    CadVendedoresC_OBS_VEN: TWideStringField;
    Label9: TLabel;
    DBEditColor1: TDBEditColor;
    Label10: TLabel;
    DBEditColor3: TDBEditColor;
    Label17: TLabel;
    CadVendedoresN_PER_COM: TFMTBCDField;
    CadVendedoresI_TIP_COM: TFMTBCDField;
    CadVendedoresC_COM_END: TWideStringField;
    ValidaGravacao1: TValidaGravacao;
    BFechar: TBitBtn;
    ECidade: TDBEditLocaliza;
    BCidade: TSpeedButton;
    BRua: TSpeedButton;
    DBEditColor28: TDBEditColor;
    CadVendedoresCOD_CIDADE: TFMTBCDField;
    CadVendedoresC_CEP_VEN: TWideStringField;
    DBEditNumerico1: TDBEditNumerico;
    Label18: TLabel;
    Label19: TLabel;
    CadVendedoresC_APE_VEN: TWideStringField;
    CadVendedoresN_PER_VIS: TFMTBCDField;
    CadVendedoresN_PER_PRA: TFMTBCDField;
    CadVendedoresD_ULT_ALT: TSQLTimeStampField;
    Localiza: TConsultaPadrao;
    CadVendedoresC_IND_ATI: TWideStringField;
    DBEditColor7: TDBEditColor;
    Label22: TLabel;
    CadVendedoresC_DES_EMA: TWideStringField;
    CAtivo: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    CadVendedoresC_IND_PRE: TWideStringField;
    ECodigo: TDBKeyViolation;
    CadVendedoresN_PER_PRE: TFMTBCDField;
    DBEditNumerico2: TDBEditNumerico;
    Label20: TLabel;
    Label21: TLabel;
    CadVendedoresC_PAS_FTP: TWideStringField;
    DBEditColor9: TDBEditColor;
    ETipoComissao: TComboBoxColor;
    ETipValorComissao: TComboBoxColor;
    Label23: TLabel;
    CadVendedoresI_TIP_VAL: TFMTBCDField;
    DBCheckBox2: TDBCheckBox;
    CadVendedoresN_PER_SER: TFMTBCDField;
    CadVendedoresC_IND_NFE: TWideStringField;
    Label24: TLabel;
    DBEditColor11: TDBEditColor;
    CadVendedoresC_DES_MSN: TWideStringField;
    Label25: TLabel;
    EProfissao: TDBEditLocaliza;
    BProfissao: TSpeedButton;
    CadVendedoresI_COD_PRF: TFMTBCDField;
    LProfissao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadVendedoresAfterInsert(DataSet: TDataSet);
    procedure CadVendedoresBeforePost(DataSet: TDataSet);
    procedure ChaveVendedorChange(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BRuaClick(Sender: TObject);
    procedure ECidadeCadastrar(Sender: TObject);
    procedure ECidadeRetorno(Retorno1, Retorno2: String);
    procedure DBEditColor28KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CadVendedoresAfterScroll(DataSet: TDataSet);
    procedure CadVendedoresAfterPost(DataSet: TDataSet);
    procedure EProfissaoCadastrar(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNovoVendedor: TFNovoVendedor;

implementation

uses APrincipal, AVendedores, AConsultaRuas, ACadCidades, Funstring, FunObjeto, UnSistema,
  AProfissoes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoVendedor.FormCreate(Sender: TObject);
begin
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
  CadVendedores.Open;
  if config.ComissaoDireta then
    ETipoComissao.Enabled := False;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoVendedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadVendedores.close;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**********************Carrega os dados default do cadastro********************}
procedure TFNovoVendedor.CadVendedoresAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
  DBEditColor13.Field.Value := date;
  CadVendedoresI_TIP_COM.AsInteger := 0;
  CadVendedoresC_IND_ATI.AsString := 'S';
  CadVendedoresC_IND_PRE.AsString := 'N';
  CadVendedoresC_IND_NFE.AsString := 'N';
  ETipoComissao.ItemIndex := 0;
  ETipValorComissao.ItemIndex := 0;
end;

{**********************Carrega os dados default do cadastro********************}
procedure TFNovoVendedor.CadVendedoresAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADVENDEDORES');
end;

{**********Verifica se o codigo já foi utilizado por outro usuario na rede*****}
procedure TFNovoVendedor.CadVendedoresBeforePost(DataSet: TDataSet);
begin
  CadVendedoresD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  CadVendedoresI_TIP_VAL.AsInteger := ETipValorComissao.ItemIndex;
  CadVendedoresI_TIP_COM.AsInteger := ETipoComissao.ItemIndex;
   if CadVendedores.State = dsinsert then
      ECodigo.VerificaCodigoUtilizado;
end;

{*******************************************************************************}
procedure TFNovoVendedor.CadVendedoresAfterScroll(DataSet: TDataSet);
begin
  ETipoComissao.ItemIndex := CadVendedoresI_TIP_COM.AsInteger;
  ETipValorComissao.ItemIndex := CadVendedoresI_TIP_VAL.AsInteger;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ******************** valida a gravacao do cadastro ************************ }
procedure TFNovoVendedor.ChaveVendedorChange(Sender: TObject);
begin
  if CadVendedores.State in [ dsinsert, dsedit ] then
    ValidaGravacao1.execute;
end;

{***************************** fecha o formulario *************************** }
procedure TFNovoVendedor.BFecharClick(Sender: TObject);
begin
  self.close;
end;

procedure TFNovoVendedor.BRuaClick(Sender: TObject);
var
  VpfCodCidade,
  VpfCEP,
  VpfRua,
  VpfBairro,
  VpfDesCidade: string;
begin
  if CadVendedores.State in [ dsEdit, dsInsert] then
  begin
    VpfCEP := SubstituiStr( VpfCEP,'-','');
    FConsultaRuas := TFConsultaRuas.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FConsultaRuas'));
    if FConsultaRuas.BuscaEndereco(VpfCodCidade, VpfCEP,
         VpfRua, VpfBairro, VpfDesCidade)
    then
    begin
      // Preenche os campos;
      CadVendedoresCOD_CIDADE.AsInteger:=StrToInt(VpfCodCidade);
      CadVendedoresC_CEP_VEN.AsString:=VpfCEP;
      CadVendedoresC_CID_VEN.AsString:=VpfDesCidade;
      CadVendedoresC_END_VEN.AsString:=VpfRua;
      CadVendedoresC_BAI_VEN.AsString:=VpfBairro;
      ECidade.Atualiza;
    end;
  end;
end;

procedure TFNovoVendedor.ECidadeCadastrar(Sender: TObject);
begin
  FCidades := TFCidades.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FCidades'));
  FCidades.ShowModal;
end;

procedure TFNovoVendedor.ECidadeRetorno(Retorno1, Retorno2: String);
begin
  if (Retorno1 <> '') then
    if (CadVendedores.State in [dsInsert, dsEdit]) then
    begin
      CadVendedoresCOD_CIDADE.AsInteger:=StrToInt(Retorno1); // Grava a cidade;
      CadVendedoresC_EST_VEN.AsString:=Retorno2; // Grava o Estado;
    end;
end;

procedure TFNovoVendedor.EProfissaoCadastrar(Sender: TObject);
begin
  FProfissoes:= TFProfissoes.CriarSDI(Self, '', True);
  FProfissoes.BotaoCadastrar1.Click;
  FProfissoes.ShowModal;
  FProfissoes.Free;
end;

procedure TFNovoVendedor.DBEditColor28KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then // F3 abre a localizacao dos endereços.
    BRua.Click;
end;

Initialization
 RegisterClasses([TFNovoVendedor]);
end.


