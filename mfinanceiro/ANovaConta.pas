unit ANovaConta;
{          Autor: Sergio Luiz Censi
    Data Criação: 29/03/1999;
          Função: Cadastrar um novo
  Data Alteração: 29/03/1999;
    Alterado por: Rafael Budag
Motivo alteração: - adicionado os comentarios e os blocos no codigo e feita toda
                    a revisão - 29/03/1999 / Rafael Budag.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Localizacao,
  DBKeyViolation, Grids, DBGrids, DBClient;

type
  TFNovaConta = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Label1: TLabel;
    DataContas: TDataSource;
    Label2: TLabel;
    CadContas: TSQL;
    Label4: TLabel;
    BFechar: TBitBtn;
    CadContasC_NRO_CON: TWideStringField;
    CadContasI_COD_BAN: TFMTBCDField;
    CadContasC_NOM_GER: TWideStringField;
    DBEditColor2: TDBEditColor;
    DBEditLocaliza1: TDBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Localiza: TConsultaPadrao;
    Label5: TLabel;
    DBKeyViolation1: TDBKeyViolation;
    Label3: TLabel;
    DBEditColor1: TDBEditColor;
    CadContasD_DAT_ABE: TSQLTimeStampField;
    DBEditColor3: TDBEditColor;
    Label7: TLabel;
    CadContasC_NOM_CRR: TWideStringField;
    ValidaGravacao1: TValidaGravacao;
    CadContasN_LIM_CRE: TFMTBCDField;
    Label8: TLabel;
    DBEditColor4: TDBEditColor;
    CadContasD_ULT_ALT: TSQLTimeStampField;
    CadContasC_NRO_AGE: TWideStringField;
    DBEditColor5: TDBEditColor;
    Label9: TLabel;
    EFilial: TDBEditLocaliza;
    Label10: TLabel;
    SpeedButton2: TSpeedButton;
    Label11: TLabel;
    CadContasI_EMP_FIL: TFMTBCDField;
    DBEditColor6: TDBEditColor;
    Label12: TLabel;
    CadContasI_NUM_CAR: TFMTBCDField;
    DBCheckBox1: TDBCheckBox;
    CadContasC_EMI_BOL: TWideStringField;
    CadContasC_NUM_CON: TWideStringField;
    Label13: TLabel;
    DBEditColor7: TDBEditColor;
    CadContasC_CON_BAN: TWideStringField;
    DBEditColor8: TDBEditColor;
    Label14: TLabel;
    CadContasC_PRO_BAN: TWideStringField;
    DBEditColor9: TDBEditColor;
    Label15: TLabel;
    CadContasI_COD_CLI: TFMTBCDField;
    ECliente: TDBEditLocaliza;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    Label16: TLabel;
    CadContasN_FAI_INI: TFMTBCDField;
    CadContasN_FAI_FIM: TFMTBCDField;
    Label17: TLabel;
    DBEditColor10: TDBEditColor;
    Label18: TLabel;
    DBEditColor11: TDBEditColor;
    CadContasC_IND_FAI: TWideStringField;
    DBCheckBox2: TDBCheckBox;
    DBEditColor12: TDBEditColor;
    Label19: TLabel;
    CadContasI_CLI_BAN: TFMTBCDField;
    CadContasC_TIP_CON: TWideStringField;
    DBRadioGroup1: TDBRadioGroup;
    DBCheckBox3: TDBCheckBox;
    CadContasC_IND_ATI: TWideStringField;
    CadContasN_SAL_ATU: TFMTBCDField;
    Label20: TLabel;
    DBEditColor13: TDBEditColor;
    CadContasI_DIA_COM: TFMTBCDField;
    DBEditColor14: TDBEditColor;
    Label21: TLabel;
    Label22: TLabel;
    SpeedButton4: TSpeedButton;
    Label23: TLabel;
    ELayoutCheque: TDBEditLocaliza;
    CadContasI_LAY_CHE: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CadContasAfterEdit(DataSet: TDataSet);
    procedure CadContasAfterInsert(DataSet: TDataSet);
    procedure CadContasAfterScroll(DataSet: TDataSet);
    procedure DBEditLocaliza1Cadastrar(Sender: TObject);
    procedure DBEditLocaliza1Change(Sender: TObject);
    procedure CadContasBeforePost(DataSet: TDataSet);
    procedure EClienteCadastrar(Sender: TObject);
    procedure CadContasAfterPost(DataSet: TDataSet);
  private
  public
    { Public declarations }
  end;

var
  FNovaConta: TFNovaConta;

implementation

uses APrincipal, Constantes, ABancos, AContas, ANovoCliente, funObjeto,
  UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaConta.FormCreate(Sender: TObject);
begin
  CadContas.open;
  IniciallizaCheckBox([DBCheckBox1,DBCheckBox1],'T','F');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaConta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CadContas.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********************Coloca o campo chave em read-only************************}
procedure TFNovaConta.CadContasAfterEdit(DataSet: TDataSet);
begin
  CadContasC_NRO_CON.ReadOnly := true;
end;

{**********************Tira o campo chave em read-only*************************}
procedure TFNovaConta.CadContasAfterInsert(DataSet: TDataSet);
begin
  CadContasC_NRO_CON.ReadOnly := false;
  DBEditLocaliza1.Atualiza;
  CadContasC_IND_FAI.AsString:= 'F';
  CadContasC_IND_ATI.AsString:= 'T';
  CadContasC_EMI_BOL.AsString:= 'F';
  CadContasC_TIP_CON.AsString:= 'CC';
end;

procedure TFNovaConta.CadContasAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADCONTAS');
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************************Fechar o Formulario corrente***********************}
procedure TFNovaConta.BFecharClick(Sender: TObject);
begin
  Close;
end;

{***************************Atualiza o localiza********************************}
procedure TFNovaConta.CadContasAfterScroll(DataSet: TDataSet);
begin
  DBEditLocaliza1.Atualiza;
  EFilial.Atualiza;
  ECliente.Atualiza;
  ELayoutCheque.Atualiza;
end;

{*************************Cadastra um novo banco*******************************}
procedure TFNovaConta.DBEditLocaliza1Cadastrar(Sender: TObject);
begin
  FBancos := TFBancos.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FBancos'));
  FBancos.BotaoCadastrar1.Click;
  FBancos.ShowModal;
  Localiza.AtualizaConsulta;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFNovaConta.DBEditLocaliza1Change(Sender: TObject);
begin
  if CadContas.State in [ dsInsert, dsEdit ] then
    ValidaGravacao1.execute;
end;

procedure TFNovaConta.CadContasBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadContasD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFNovaConta.EClienteCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoCliente'));
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.ccliente.Checked := true;
  FNovoCliente.ShowModal;
  FNovoCliente.free;
  Localiza.AtualizaConsulta;
end;

Initialization
{*******************Registra a classe para evitar duplicidade******************}
  RegisterClasses([TFNovaConta]);
end.
