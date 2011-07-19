unit ANovaFilial;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: Cadastrar um novo
  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 01/04/199 / Rafael Budag
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Tabela, StdCtrls, Mask, DBCtrls, Db, BotaoCadastro, Buttons, DBTables,
  ExtCtrls, ExtDlgs, Componentes1, DBCidade, constantes, DBKeyViolation,
  PainelGradiente, Localizacao, DBClient;

type
  TFNovaFilial = class(TFormularioPermissao)
    CadFiliais: TSQL;
    DataFiliais: TDataSource;
    PainelGradiente1: TPainelGradiente;
    ProximaFilial: TSQL;
    CadFiliaisI_EMP_FIL: TFMTBCDField;
    CadFiliaisI_COD_EMP: TFMTBCDField;
    CadFiliaisI_COD_FIL: TFMTBCDField;
    CadFiliaisC_END_FIL: TWideStringField;
    CadFiliaisI_NUM_FIL: TFMTBCDField;
    CadFiliaisC_BAI_FIL: TWideStringField;
    CadFiliaisC_CID_FIL: TWideStringField;
    CadFiliaisC_EST_FIL: TWideStringField;
    CadFiliaisC_CGC_FIL: TWideStringField;
    CadFiliaisC_INS_FIL: TWideStringField;
    CadFiliaisC_GER_FIL: TWideStringField;
    CadFiliaisC_DIR_FIL: TWideStringField;
    CadFiliaisC_FON_FIL: TWideStringField;
    CadFiliaisC_FAX_FIL: TWideStringField;
    CadFiliaisC_OBS_FIL: TWideStringField;
    CadFiliaisD_DAT_MOV: TSQLTimeStampField;
    CadFiliaisC_WWW_FIL: TWideStringField;
    CadFiliaisC_END_ELE: TWideStringField;
    CadFiliaisD_DAT_INI_ATI: TSQLTimeStampField;
    CadFiliaisD_DAT_FIM_ATI: TSQLTimeStampField;
    CadFiliaisC_NOM_FAN: TWideStringField;
    CadFiliaisCOD_CIDADE: TFMTBCDField;
    Localiza: TConsultaPadrao;
    CadFiliaisD_ULT_ALT: TSQLTimeStampField;
    CadFiliaisI_CEP_FIL: TFMTBCDField;
    ValidaGravacao1: TValidaGravacao;
    ScrollBox1: TScrollBox;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label24: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    BCidade: TSpeedButton;
    BRua: TSpeedButton;
    Label12: TLabel;
    DBEditColor2: TDBEditColor;
    DBEditColor9: TDBEditColor;
    DBEditColor4: TDBEditColor;
    DBEditColor5: TDBEditColor;
    DBEditColor3: TDBEditColor;
    DBEditColor8: TDBEditColor;
    DBEditCGC1: TDBEditCGC;
    DBEditColor13: TDBEditColor;
    DBEditColor20: TDBEditColor;
    DBEditColor17: TDBEditColor;
    DBEditColor7: TDBEditColor;
    DBEditColor12: TDBEditColor;
    DBEditColor11: TDBEditColor;
    DBEditColor18: TDBEditColor;
    DBEditColor19: TDBEditColor;
    DBMemoColor1: TDBMemoColor;
    codigo: TDBKeyViolation;
    DBEditPos21: TDBEditPos2;
    DBEditPos22: TDBEditPos2;
    DBEditColor1: TDBEditColor;
    ECidade: TDBEditLocaliza;
    DBEditColor6: TDBEditColor;
    Panel3: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    MoveBasico1: TMoveBasico;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    DBEditColor10: TDBEditColor;
    Label17: TLabel;
    CadFiliaisC_CPF_RES: TWideStringField;
    CadFiliaisC_JUN_COM: TWideStringField;
    CadFiliaisI_COD_FIS: TFMTBCDField;
    CadFiliaisC_COD_CNA: TWideStringField;
    DBEditColor14: TDBEditColor;
    Label19: TLabel;
    CadFiliaisC_INS_MUN: TWideStringField;
    Label25: TLabel;
    DBEditColor15: TDBEditColor;
    CadFiliaisC_IND_REV: TWideStringField;
    CBaixarEstoque: TDBCheckBox;
    CadFiliaisC_NOM_FIL: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FecharClick(Sender: TObject);
    procedure BotaoCancelar1AntesAtividade(Sender: TObject);
    procedure CadFiliaisAfterInsert(DataSet: TDataSet);
    procedure BRuaClick(Sender: TObject);
    procedure ECidadeCadastrar(Sender: TObject);
    procedure ECidadeRetorno(Retorno1, Retorno2: String);
    procedure CadFiliaisBeforePost(DataSet: TDataSet);
    procedure DBEditColor2Change(Sender: TObject);
    procedure CadFiliaisAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    EmpresaCadastro : integer;
  end;

var
  FNovaFilial: TFNovaFilial;

implementation

uses AFiliais, APrincipal, AConsultaRuas, ACadCidades, FunString, UnSistema, FunObjeto;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaFilial.FormCreate(Sender: TObject);
begin
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'T','F');
  CadFiliais.open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaFilial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
CadFiliais.Close;
Action := cafree;
end;

{ ****************************** Fecha o formulário ************************** }
procedure TFNovaFilial.FecharClick(Sender: TObject);
begin
close;
end;

{ ****************************** cancela o formulário ************************ }
procedure TFNovaFilial.BotaoCancelar1AntesAtividade(Sender: TObject);
begin
Varia.AcaoCancela := true;
end;


{ ******* Apos a Inserção, adiciona empresa e filial no campos  ************** }
procedure TFNovaFilial.CadFiliaisAfterInsert(DataSet: TDataSet);
begin
  ProximaFilial.close;
  ProximaFilial.sql.Clear;
  ProximaFilial.sql.Add('select * from CadFiliais where I_COD_EMP = ' + IntToStr(EmpresaCadastro)+ ' ORDER BY I_COD_FIL');
  ProximaFilial.Open;
  ProximaFilial.Last;

  CadFiliais.FieldByName('I_COD_EMP').AsInteger :=   EmpresaCadastro;   // para nova empresa ou quando for criado nova filial
  CadFiliais.FieldByName('I_COD_FIL').AsInteger := (ProximaFilial.fieldByName('I_COD_FIL').AsInteger + 1);
  Codigo.Field.Value := StrToInt(IntToStr(EmpresaCadastro) + IntToStr(ProximaFilial.fieldByName('I_COD_FIL').AsInteger + 1));
  DBeditColor20.Field.Value := date;
end;

procedure TFNovaFilial.CadFiliaisAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADFILIAIS');
end;

procedure TFNovaFilial.BRuaClick(Sender: TObject);
var
  VpfCodCidade,
  VpfCEP,
  VpfLograd,
  VpfRua,
  VpfBairro,
  VpfDesCidade: string;
begin
 if CadFiliais.State in [ dsInsert, dsedit] then
 begin
    VpfCEP:=SubstituiStr(VpfCEP,'-','');
    FConsultaRuas := TFConsultaRuas.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FConsultaRuas'));
    if FConsultaRuas.BuscaEndereco( VpfCodCidade, VpfCEP,
                                    VpfRua, VpfBairro, VpfDesCidade)
    then
    begin
      // Preenche os campos;
      CadFiliaisCOD_CIDADE.AsInteger:=StrToInt(VpfCodCidade);
      CadFiliaisI_CEP_FIL.AsString:=VpfCEP;
      CadFiliaisC_CID_FIL.AsString:=VpfDesCidade;
      CadFiliaisC_END_FIL.AsString:=VpfRua;
      CadFiliaisC_BAI_FIL.AsString:=VpfBairro;
      ECidade.Atualiza;
    end;
  end;
end;

procedure TFNovaFilial.ECidadeCadastrar(Sender: TObject);
begin
  FCidades := TFCidades.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FCidades'));
  FCidades.ShowModal;
end;

procedure TFNovaFilial.ECidadeRetorno(Retorno1, Retorno2: String);
begin
  if (Retorno2 <> '') then
    if (CadFiliais.State in [dsInsert, dsEdit]) then
    begin
      if Retorno1 <> '' then
        CadFiliaisI_COD_FIS.AsInteger:=StrToInt(Retorno1)
      else
        CadFiliaisI_COD_FIS.clear;
      CadFiliaisC_EST_FIL.AsString:=Retorno2; // Grava o Estado;
    end;
end;

{******************* antes de gravar o registro *******************************}
procedure TFNovaFilial.CadFiliaisBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadFiliaisD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
end;

{******************** valida a gravação do botão ******************************}
procedure TFNovaFilial.DBEditColor2Change(Sender: TObject);
begin
  if CadFiliais.State in [dsedit,dsinsert] then
    ValidaGravacao1.execute;
end;

end.
