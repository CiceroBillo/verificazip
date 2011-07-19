unit AMovNatureza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, BotaoCadastro, StdCtrls, Buttons, DBTables, Tabela,
  Componentes1, ExtCtrls, PainelGradiente, DBKeyViolation, Grids, DBGrids,
  Mask, DBCtrls, Localizacao, UnImpressao, ComCtrls, DBClient, FMTBcd, SqlExpr, unSistema;

type
  TFMovNatureza = class(TFormularioPermissao)
    Localiza: TConsultaPadrao;
    MovNaturezas: TSQL;
    DataMovNatureza: TDataSource;
    PainelGradiente1: TPainelGradiente;
    PanelColor5: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar2: TBotaoGravar;
    BotaoCancelar2: TBotaoCancelar;
    BFechar: TBitBtn;
    Aux: TSQLQuery;
    MovNaturezasC_COD_NAT: TWideStringField;
    MovNaturezasI_SEQ_MOV: TFMTBCDField;
    MovNaturezasC_NOM_MOV: TWideStringField;
    MovNaturezasC_GER_FIN: TWideStringField;
    MovNaturezasC_ENT_SAI: TWideStringField;
    MovNaturezasC_BAI_EST: TWideStringField;
    MovNaturezasL_TEX_FIS: TWideStringField;
    MovNaturezasC_CAL_ICM: TWideStringField;
    MovNaturezasC_GER_COM: TWideStringField;
    MovNaturezasC_IMP_AUT: TWideStringField;
    MovNaturezasI_COD_OPE: TFMTBCDField;
    MovNaturezasI_COD_EMP: TFMTBCDField;
    MovNaturezasC_INS_SER: TWideStringField;
    MovNaturezasC_NAT_LOC: TWideStringField;
    MovNaturezasC_INS_PRO: TWideStringField;
    MovNaturezasC_MOS_NOT: TWideStringField;
    MovNaturezasD_ULT_ALT: TSQLTimeStampField;
    MovNaturezasC_CAL_ISS: TWideStringField;
    MovNaturezasC_EXI_CPF: TWideStringField;
    MovNaturezasC_CLA_PLA: TWideStringField;
    MovNaturezasC_CAL_PIS: TWideStringField;
    MovNaturezasC_CAL_COF: TWideStringField;
    ValidaGravacao1: TValidaGravacao;
    MovNaturezasI_CFO_PRO: TFMTBCDField;
    MovNaturezasI_CFO_SER: TFMTBCDField;
    MovNaturezasC_TIP_EMI: TWideStringField;
    MovNaturezasI_CFO_SUB: TFMTBCDField;
    PanelColor3: TPanelColor;
    Label12: TLabel;
    SpeedButton1: TSpeedButton;
    Label13: TLabel;
    Label15: TLabel;
    SpeedButton2: TSpeedButton;
    Label14: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    RTipoEmissao: TDBRadioGroup;
    DelOperacaoEstoque: TDBEditLocaliza;
    EPlano: TDBEditNumerico;
    MObs: TDBMemoColorLimite;
    EditColor1: TEditColor;
    PanelColor4: TPanelColor;
    DBGridColor1: TDBGridColor;
    EProximoCodigo: TDBKeyViolation;
    DBEditColor2: TDBEditColor;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBEditNumerico1: TDBEditNumerico;
    DBEditNumerico2: TDBEditNumerico;
    DBRadioGroup2: TDBRadioGroup;
    DBEditNumerico3: TDBEditNumerico;
    PanelColor1: TPanelColor;
    ScrollBox1: TScrollBox;
    DBEditNumerico4: TDBEditNumerico;
    Label5: TLabel;
    MovNaturezasI_CFO_STR: TFMTBCDField;
    DBEditNumerico5: TDBEditNumerico;
    Label7: TLabel;
    MovNaturezasI_CFO_PRR: TFMTBCDField;
    DBCheckBox13: TDBCheckBox;
    MovNaturezasC_MOV_FIS: TWideStringField;
    MovNaturezasC_NOT_DEV: TWideStringField;
    DBCheckBox14: TDBCheckBox;
    Label8: TLabel;
    LCST: TLabel;
    MovNaturezasC_COD_CST: TWideStringField;
    MovNaturezasC_PLA_CCO: TWideStringField;
    DBEditColor1: TDBEditColor;
    ECST: TDBEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure DelOperacaoEstoqueSelect(Sender: TObject);
    procedure DelOperacaoEstoqueCadastrar(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MovNaturezasAfterInsert(DataSet: TDataSet);
    procedure MovNaturezasBeforePost(DataSet: TDataSet);
    procedure DelOperacaoEstoqueRetorno(Retorno1, Retorno2: String);
    procedure MObsExit(Sender: TObject);
    procedure MovNaturezasAfterPost(DataSet: TDataSet);
    procedure MovNaturezasAfterScroll(DataSet: TDataSet);
    procedure DelOperacaoEstoqueExit(Sender: TObject);
    procedure MovNaturezasAfterEdit(DataSet: TDataSet);
    procedure DelOperacaoEstoqueChange(Sender: TObject);
    procedure RTipoEmissaoChange(Sender: TObject);
    procedure MovNaturezasC_CAL_ICMChange(Sender: TField);
  private
    unImp : TFuncoesImpressao;
    VprCodNatureza,
    VprNomNatureza : string;
    procedure PreConfiguraNatureza(VpaCodNatureza : string);
    procedure ConfiguraTipoEntradaouSaida;
  public
    procedure PosicionaNatureza( VpaCodigo, VpaNome : String);
  end;

var
  FMovNatureza: TFMovNatureza;

implementation

uses APrincipal, FunSql,AOperacoesEstoques, APlanoConta, constantes, FunObjeto, FunString;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           cad naturezas
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ****************** Na criação do Formulário ******************************** }
procedure TFMovNatureza.FormCreate(Sender: TObject);
begin
   unImp := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
   unImp.LocalizaUmItem(aux, varia.NotaFiscalPadrao, 74);
   MObs.AQdadeCaracter := aux.FieldByname('i_tam_cam').AsInteger;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor3,'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMovNatureza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   unImp.Free;
   Aux.close;
   MovNaturezas.close;
   Action := CaFree;
end;

{************Posiciona a tabela passada conforme o codigo passado**************}
procedure TFMovNatureza.PosicionaNatureza( VpaCodigo, VpaNome : String );
begin
  AdicionaSQLAbreTabela(MovNaturezas,' Select * from MovNatureza ' +
                                     ' Where C_Cod_Nat = ''' + VpaCodigo + '''');
  VprCodNatureza := VpaCodigo;
  VprNomNatureza := VpaNome;
  self.ShowModal;
end;

{*******************************************************************************}
procedure TFMovNatureza.PreConfiguraNatureza(VpaCodNatureza: string);
begin
  VpaCodNatureza := DeletaChars(DeletaChars(VpaCodNatureza,'.'),' ');
  if length(VpaCodNatureza) > 0 then
  begin
    if (copy(VpaCodNatureza,1,1) = '1') or
       (copy(VpaCodNatureza,1,1) = '5') then
      MovNaturezasC_NAT_LOC.AsString := 'S';
    if (copy(VpaCodNatureza,1,1) = '2') or
       (copy(VpaCodNatureza,1,1) = '6') then
      MovNaturezasC_NAT_LOC.AsString := 'N';

    MovNaturezasC_BAI_EST.AsString := 'N';
    MovNaturezasC_GER_FIN.AsString := 'N';
    MovNaturezasC_CAL_ICM.AsString := 'N';
    MovNaturezasC_GER_COM.AsString := 'N';
    MovNaturezasC_CAL_ISS.AsString := 'N';
    MovNaturezasC_CAL_PIS.AsString := 'N';
    MovNaturezasC_CAL_COF.AsString := 'N';
    if (copy(VpaCodNatureza,1,4) = '5933') or
       (copy(VpaCodNatureza,1,4) = '5101') or
       (copy(VpaCodNatureza,1,4) = '5401') or
       (copy(VpaCodNatureza,1,4) = '5102') or
       (copy(VpaCodNatureza,1,4) = '6933') or
       (copy(VpaCodNatureza,1,4) = '6101') or
       (copy(VpaCodNatureza,1,4) = '6401') or
       (copy(VpaCodNatureza,1,4) = '6102') then
    begin
      MovNaturezasC_BAI_EST.AsString := 'S';
      MovNaturezasC_GER_FIN.AsString := 'S';
      MovNaturezasC_CAL_ICM.AsString := 'S';
      MovNaturezasC_GER_COM.AsString := 'S';
      MovNaturezasC_CAL_ISS.AsString := 'S';
      MovNaturezasC_CAL_PIS.AsString := 'S';
      MovNaturezasC_CAL_COF.AsString := 'S';
    end;
{    if Length(VpaCodNatureza) > 4 then
    begin
      MovNaturezasC_INS_PRO.AsString := 'S';
      MovNaturezasC_INS_SER.AsString := 'S';
      if ExisteLetraString('/',VpaCodNatureza) then
      begin
        MovNaturezasI_CFO_PRO.AsInteger := StrToInt(DeletaChars(CopiaAteChar(VpaCodNatureza,'/'),'/'));
        MovNaturezasI_CFO_SER.AsInteger := StrToInt(DeleteAteChar(VpaCodNatureza,'/'));
      end;
    end
    else
    begin
      if (VpaCodNatureza = '5933') or
         (VpaCodNatureza = '6933') then
      begin
        MovNaturezasC_INS_PRO.AsString := 'N';
        MovNaturezasC_INS_SER.AsString := 'S';
        MovNaturezasI_CFO_SER.AsInteger := StrToInt(VpaCodNatureza)
      end
      else
        MovNaturezasC_INS_PRO.AsString := 'S';
        MovNaturezasC_INS_SER.AsString := 'N';
        MovNaturezasI_CFO_PRO.AsInteger := StrToInt(VpaCodNatureza)
    end;}
    ConfiguraTipoEntradaouSaida;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFMovNatureza.BFecharClick(Sender: TObject);
begin
   close;
end;

{******************Carrega a Select da operacao de estoque*********************}
procedure TFMovNatureza.DelOperacaoEstoqueSelect(Sender: TObject);
begin
   DelOperacaoEstoque.ASelectValida.text := 'Select * from CadOperacaoEstoque '  +
                                            ' Where I_Cod_Ope = @ ';
   DelOperacaoEstoque.ASelectLocaliza.text := 'Select * from CadOperacaoEstoque '+
                                              ' Where C_Nom_Ope like ''@%''';
end;



{********************Cadastra uma nova operação de Estoque*********************}
procedure TFMovNatureza.ConfiguraTipoEntradaouSaida;
begin
  EPlano.Clear;
  if MovNaturezasC_COD_NAT.AsString <> '' then
  begin
    if MovNaturezasC_COD_NAT.AsString[1] in ['1','2','3']  then
      MovNaturezasC_ENT_SAI.AsString := 'E'
    else
      MovNaturezasC_ENT_SAI.AsString := 'S';
  end;
end;

{********************Cadastra uma nova operação de Estoque*********************}
procedure TFMovNatureza.RTipoEmissaoChange(Sender: TObject);
begin
  if MovNaturezas.State in [dsedit,dsinsert]  then
    ConfiguraTipoEntradaouSaida;
end;

procedure TFMovNatureza.DelOperacaoEstoqueCadastrar(Sender: TObject);
begin
   FOperacoesEstoques := TFOperacoesEstoques.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FOperacoesEstoques'));
   FOperacoesEstoques.BotaoCadastrar1.Click;
   FOperacoesEstoques.ShowModal;
   Localiza.AtualizaConsulta;
end;

{************ localiza plano de contas ************************************** }
procedure TFMovNatureza.DelOperacaoEstoqueChange(Sender: TObject);
begin
  if MovNaturezas.State in [dsedit,dsinsert] then
  begin
    ValidaGravacao1.execute;
  end;
end;

{************ localiza plano de contas ************************************** }
procedure TFMovNatureza.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
  VpfTipDebitoCredito : String;
begin
  if RTipoEmissao.ItemIndex = 0 then
    VpfTipDebitoCredito := 'D'
  else
    VpfTipDebitoCredito := 'C';

  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Field.AsString;
  if not FPlanoConta.verificaCodigo( VpfCodigo,VpfTipDebitoCredito, Label14, false,(Sender is TSpeedButton) ) then
    EPlano.SetFocus;
  if MovNaturezas.State in [ dsEdit, dsInsert] then
  begin
    EPlano.Field.AsString := VpfCodigo;
    if EPlano.Text = '' then
      MovNaturezasC_CLA_PLA.Clear;
  end;
end;

procedure TFMovNatureza.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = 114 then
  EPlanoExit(SpeedButton2);
end;


procedure TFMovNatureza.MovNaturezasAfterEdit(DataSet: TDataSet);
begin
  DBEditcolor2.readOnly := false;
end;

{******************************************************************************}
procedure TFMovNatureza.MovNaturezasAfterInsert(DataSet: TDataSet);
begin
   EProximocodigo.proximocodigo;
   DBEditcolor2.readOnly := false;
   MovNaturezasC_COD_NAT.AsString := VprCodNatureza;
   MovNaturezasC_NOM_MOV.AsString := VprNomNatureza;
   MovNaturezasC_ENT_SAI.AsString := 'S'; // SOMENTE PARA SAIDA DE PRODUTOS
   MovNaturezasC_IMP_AUT.AsString := 'N';
   MovNaturezasC_INS_PRO.AsString := 'S';
   MovNaturezasC_INS_SER.AsString := 'N';
   MovNaturezasC_MOS_NOT.AsString := 'S';
   MovNaturezasC_EXI_CPF.AsString := 'S';
   MovNaturezasC_TIP_EMI.AsString := 'P';
   MovNaturezasC_MOV_FIS.AsString := 'S';
   MovNaturezasC_NOT_DEV.AsString := 'N';
   PreConfiguraNatureza(VprCodNatureza);
end;

{******************* antes de gravar o registro *******************************}
procedure TFMovNatureza.MovNaturezasBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  MovNaturezasD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  Sistema.MarcaTabelaParaImportar('MOVNATUREZA');
  if MovNaturezas.State = dsinsert Then
      EProximoCodigo.VerificaCodigoutilizado;
end;

procedure TFMovNatureza.MovNaturezasC_CAL_ICMChange(Sender: TField);
begin
end;

{******************************************************************************}
procedure TFMovNatureza.DelOperacaoEstoqueRetorno(Retorno1,
  Retorno2: String);
begin
  EditColor1.Text := Retorno1;
end;

procedure TFMovNatureza.MObsExit(Sender: TObject);
begin
  if BotaoGravar2.Enabled then
    BotaoGravar2.SetFocus;
end;

procedure TFMovNatureza.MovNaturezasAfterPost(DataSet: TDataSet);
begin
  AtualizaSQLTabela(MovNaturezas);
  DBEditcolor2.readOnly := true;
end;

procedure TFMovNatureza.MovNaturezasAfterScroll(DataSet: TDataSet);
begin
  DelOperacaoEstoque.Atualiza;
  EPlanoExit(EPlano);
end;

procedure TFMovNatureza.DelOperacaoEstoqueExit(Sender: TObject);
begin
  if MovNaturezas.State in [ dsEdit, dsInsert ] then
    if DelOperacaoEstoque.text = '' then
      MovNaturezasI_COD_OPE.Clear;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMovNatureza]);
end.
