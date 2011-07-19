unit ANovaClassificacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, DBTables, Tabela, DBCtrls, ExtCtrls,
  Componentes1, BotaoCadastro, PainelGradiente, DBKeyViolation, formularios,
  AProdutos, UnClassificacao, numericos, DBClient;

type
  TFNovaClassificacao = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    Empresa: TDBEditColor;
    Label4: TLabel;
    CadClassificacao: TSQL;
    Desc: TDBEditColor;
    DataCadClassificacao: TDataSource;
    PainelGradiente: TPainelGradiente;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    CodCla: TMaskEditColor;
    CadClassificacaoI_COD_EMP: TFMTBCDField;
    CadClassificacaoC_COD_CLA: TWideStringField;
    CadClassificacaoC_NOM_CLA: TWideStringField;
    CadClassificacaoC_CON_CLA: TWideStringField;
    Label2: TLabel;
    ValidaGravacao1: TValidaGravacao;
    CadClassificacaoC_TIP_CLA: TWideStringField;
    CadClassificacaoD_ULT_ALT: TSQLTimeStampField;
    BFechar: TBitBtn;
    Label5: TLabel;
    CadClassificacaoN_PER_COM: TFMTBCDField;
    BComissaoVendedor: TBitBtn;
    DBEditNumerico1: TDBEditNumerico;
    CadClassificacaoC_ALT_QTD: TWideStringField;
    CAlterarQuantidade: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    CadClassificacaoC_IND_FER: TWideStringField;
    DBEditNumerico2: TDBEditNumerico;
    Label3: TLabel;
    Label6: TLabel;
    CadClassificacaoN_QTD_PER: TFMTBCDField;
    DBCheckBox3: TDBCheckBox;
    CadClassificacaoC_IMP_ETI: TWideStringField;
    Label7: TLabel;
    DBEditNumerico3: TDBEditNumerico;
    Label8: TLabel;
    CadClassificacaoN_PER_PER: TFMTBCDField;
    DBCheckBox4: TDBCheckBox;
    CadClassificacaoC_IND_INS: TWideStringField;
    BMenuFiscal: TBitBtn;
    DBEditNumerico4: TDBEditNumerico;
    Label9: TLabel;
    Label10: TLabel;
    CadClassificacaoN_PER_MAX: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoGravar1DepoisAtividade(Sender: TObject);
    procedure BotaoCancelar1DepoisAtividade(Sender: TObject);
    procedure CodClaExit(Sender: TObject);
    procedure BotaoGravar1Atividade(Sender: TObject);
    procedure EmpresaChange(Sender: TObject);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CadClassificacaoBeforePost(DataSet: TDataSet);
    procedure BComissaoVendedorClick(Sender: TObject);
    procedure CadClassificacaoAfterPost(DataSet: TDataSet);
    procedure BMenuFiscalClick(Sender: TObject);
  private
    { Private declarations }
    acao:Boolean;
    codigo : string;
    UnCla : TFuncoesClassificacao;
    TipoDeCla : string;
    procedure ConfiguraPermissaoUsuario;
  public
    { Public declarations }
    modo:byte;
    function Inseri(VpaDClassificacao : TClassificacao;  VpaTamanhoPicture : Integer; TipoCla : string ) : Boolean;
    function Alterar(VpaDClassificacao : TClassificacao; VpaTipo : string; VpaIndAlterar: Boolean) : Boolean;
  end;

var
  FNovaClassificacao: TFNovaClassificacao;

implementation

uses APrincipal, funstring, constantes, constMsg, FunObjeto,
  AComissaoClassificacaoVendedor, FunSql, UnSistema, AMenuFiscalECF;

{$R *.DFM}


{******************************************************************************
                        Inseri nova classificacao
****************************************************************************** }
function TFNovaClassificacao.Inseri(VpaDClassificacao : TClassificacao;  VpaTamanhoPicture : Integer; TipoCla : string  ) : Boolean;
begin
  self.codigo := VpaDClassificacao.CodClassificacao; // recebe o codigo pai
  self.TipoDeCla := TipoCla;

  CodCla.Clear;
  CodCla.EditMask  := UnCla.GeraMascara(VpaTamanhoPicture);

  CadClassificacao.Insert;
  empresa.Field.AsInteger := varia.CodigoEmpresa;
  CadClassificacaoC_CON_CLA.AsString := 'S';
  CadClassificacaoC_ALT_QTD.AsString := 'S';
  CadClassificacaoC_IND_FER.AsString := 'N';
  CadClassificacaoC_IND_INS.AsString := 'N';
  CadClassificacaoC_IMP_ETI.AsString := 'N';
  CadClassificacaoC_TIP_CLA.AsString := TipoCla;
  CodCla.ReadOnly := FALSE;
  CodCla.Text := UnCla.ProximoCodigoClassificacao( VpaTamanhoPicture, codigo, TipoCla );

  ShowModal;

  VpaDClassificacao.CodClassificacao := codigo + CodCla.Text;
  VpaDClassificacao.CodClassificacoReduzido := CodCla.Text;
  VpaDClassificacao.NomClassificacao := Desc.Text;
  result := Acao;
end;

{******************************************************************************
                        destroy o formulario
****************************************************************************** }
procedure TFNovaClassificacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  
  UnCla.Destroy;
  Action := CaFree;
end;

{******************************************************************************
                        Alterar classificacao
****************************************************************************** }
function TFNovaClassificacao.Alterar(VpaDClassificacao : TClassificacao; VpaTipo : string; VpaIndAlterar: Boolean) : Boolean;
begin
  TipoDeCla := VpaTipo;
  // Classificação é por empresa e não por filial.
  AdicionaSQlAbreTabela(CadClassificacao,'Select * from CADCLASSIFICACAO '+
                                         ' Where I_COD_EMP = '+ IntTosTr(Varia.CodigoEmpresa)+
                                         ' and C_COD_CLA = '''+VpaDClassificacao.CodClassificacao+''''+
                                         ' AND C_TIP_CLA = '''+VpaTipo+'''');
  if not CadClassificacao.Eof then
  begin
    if VpaIndAlterar then
    begin
      CadClassificacao.edit;
      CodCla.Text := VpaDClassificacao.CodClassificacoReduzido;
      CodCla.ReadOnly := true;
      ShowModal;
      VpaDClassificacao.NomClassificacao := Desc.Text;
      result := Acao;
    end
    else
    begin
      CodCla.Text := VpaDClassificacao.CodClassificacoReduzido;
      CodCla.ReadOnly := true;
      ShowModal;
      Result := False;
    end;
  end
  else
  begin
    Aviso('Classificação não encontrada.');
    Result := False;
    Close;
  end;
end;

{******************************************************************************}
procedure TFNovaClassificacao.ConfiguraPermissaoUsuario;
begin
  if config.ControlarASeparacaodaCotacao then
    CAlterarQuantidade.Visible := true
  else
    CAlterarQuantidade.Visible := false;
end;

{ *****************************************************************************
  FormShow :  serve para colocar o componente de edicao do
              código read only se for uma alteracao
****************************************************************************** }
procedure TFNovaClassificacao.FormCreate(Sender: TObject);
begin
  InicializaVerdadeiroeFalsoCheckBox(PanelColor3,'S','N');
  UnCla := TFuncoesClassificacao.criar(self,FPrincipal.BaseDados);
  CadClassificacao.open;
  ConfiguraPermissaoUsuario;
end;

{*****************************************************************************
                   serve para indicar que o usuario confirmou
****************************************************************************** }
procedure TFNovaClassificacao.BotaoGravar1DepoisAtividade(Sender: TObject);
begin
  Acao:=TRUE;
  Close;
end;

{******************************************************************************
             serve para indicar que o usuario cancelou
****************************************************************************** }
procedure TFNovaClassificacao.BotaoCancelar1DepoisAtividade(Sender: TObject);
begin
  acao:=FALSE;
  Close;
end;

{******************************************************************************
   na saida da caixa de codigo, faz verificações de duplicação de código
****************************************************************************** }
procedure TFNovaClassificacao.CodClaExit(Sender: TObject);
begin
  if CadClassificacao.state = dsinsert Then
    if CodCla.text <> '' then
    begin
       if not UnCla.ClassificacaoExistente(codigo + CodCla.Text, TipoDeCla) then
         CodCla.SetFocus;
    end;
end;

{************ configura o codigo ******************************************** }
procedure TFNovaClassificacao.BotaoGravar1Atividade(Sender: TObject);
begin
if CadClassificacao.State = dsInsert then
   CadClassificacaoC_COD_CLA.Value := codigo + CodCla.Text;
end;

{*************** valida a gravacao ******************************************* }
procedure TFNovaClassificacao.EmpresaChange(Sender: TObject);
begin
if CadClassificacao.State in [ dsInsert, dsEdit ] then
  ValidaGravacao1.execute;
end;

procedure TFNovaClassificacao.BotaoFechar1Click(Sender: TObject);
begin
  Close;
end;

procedure TFNovaClassificacao.FormShow(Sender: TObject);
begin
  if TipoDeCla = 'S' then
    PainelGradiente.Caption := '  Cadastro de Classificação de Serviços  '
  else
    PainelGradiente.Caption := '  Cadastro de Classificação de Produtos  ';
end;

{******************* antes de gravar o registro *******************************}
procedure TFNovaClassificacao.CadClassificacaoAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADCLASSIFICACAO');
end;

procedure TFNovaClassificacao.CadClassificacaoBeforePost(
  DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadClassificacaoD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFNovaClassificacao.BComissaoVendedorClick(Sender: TObject);
begin
  if CadClassificacao.State = dsEdit then
  begin
    FComissaoClassificacaoVendedor:= TFComissaoClassificacaoVendedor.CriarSDI(Application,'',True);
    FComissaoClassificacaoVendedor.CadastraComissaoClassificacaoVendedor(CadClassificacaoI_COD_EMP.AsInteger,
                                                                         CadClassificacaoC_COD_CLA.AsString,
                                                                         CadClassificacaoC_TIP_CLA.AsString);
    FComissaoClassificacaoVendedor.Free;
  end
  else
    aviso('É necessário estar alterando a classificação para cadastrar as comissões dos vendedores.');
end;

{******************************************************************************}
procedure TFNovaClassificacao.BMenuFiscalClick(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

end.
