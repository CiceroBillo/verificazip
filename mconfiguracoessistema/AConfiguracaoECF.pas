unit AConfiguracaoECF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Db, Localizacao, DBTables, Tabela, StdCtrls,
  Mask, DBCtrls, Buttons, ComCtrls, BotaoCadastro, Componentes1, numericos, UnECF,
  DBClient, unSistema;

type
  TFConfiguracaoECF = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    CFGECF: TSQL;
    DataCFGECF: TDataSource;
    localiza: TConsultaPadrao;
    CFGECFCODPLANOCONTAS: TWideStringField;
    CFGECFCODCLIENTEPADRAO: TFMTBCDField;
    CFGECFNUMTIPOECF: TFMTBCDField;
    PanelColor1: TPanelColor;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    PageControl: TPageControl;
    PGeral: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    EClientePadrao: TDBEditLocaliza;
    EPlanoContas: TDBEditLocaliza;
    ETipoECF: TComboBoxColor;
    Label5: TLabel;
    PAliquotas: TTabSheet;
    LAliquotas: TListBoxColor;
    BAdicionar: TBitBtn;
    Label6: TLabel;
    ENovoAliquota: Tnumerico;
    CFGECFCODOPERACAOESTOQUE: TFMTBCDField;
    DBEditLocaliza1: TDBEditLocaliza;
    Label7: TLabel;
    SpeedButton3: TSpeedButton;
    Label8: TLabel;
    CGeraFinanceiro: TDBCheckBox;
    CBaixarEstoque: TDBCheckBox;
    CFGECFINDGERAFINANCEIRO: TWideStringField;
    CFGECFINDBAIXAESTOQUE: TWideStringField;
    CMostrarFormaPagamento: TDBCheckBox;
    CFGECFINDFORMAPAGAMENTOCOTACAO: TWideStringField;
    CFGECFINDUTILIZAGAVETA: TWideStringField;
    CUtilizarGaveta: TDBCheckBox;
    CFGECFINDDESCONTOCOTACAO: TWideStringField;
    CDescontoCotacaoECF: TDBCheckBox;
    CFGECFCODCONDICAOPAGAMENTO: TFMTBCDField;
    DBEditLocaliza2: TDBEditLocaliza;
    Label9: TLabel;
    SpeedButton4: TSpeedButton;
    Label10: TLabel;
    CFGECFD_ULT_ALT: TSQLTimeStampField;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    Label11: TLabel;
    EPorta: TComboBoxColor;
    CFGECFNUMPORTA: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CFGECFAfterEdit(DataSet: TDataSet);
    procedure CFGECFAfterPost(DataSet: TDataSet);
    procedure ETipoECFChange(Sender: TObject);
    procedure FecharClick(Sender: TObject);
    procedure BAdicionarClick(Sender: TObject);
    procedure CFGECFBeforePost(DataSet: TDataSet);
    procedure EPortaChange(Sender: TObject);
  private
    { Private declarations }
    FunECF : TRBFuncoesECF;
    procedure CarregaAliquotas;
  public
    { Public declarations }
  end;

var
  FConfiguracaoECF: TFConfiguracaoECF;

implementation

uses APrincipal, FunSQl, FunObjeto, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConfiguracaoECF.FormCreate(Sender: TObject);
begin
  FunECF := TRBFuncoesECF.cria(nil,FPrincipal.BaseDados);
  AdicionaSQLAbreTabela(CFGECF,'Select * from CFG_ECF ');
  PageControl.ActivePageIndex := 0;
  IniciallizaCheckBox([CGeraFinanceiro,CBaixarEstoque,CUtilizarGaveta,CMostrarFormaPagamento,CDescontoCotacaoECF], 'T', 'F');
  AtualizaLocalizas([EClientePadrao,EPlanoContas]);
  ETipoECF.ItemIndex := CFGECFNUMTIPOECF.AsInteger;
  ETipoECF.Enabled := false;
  EPorta.ItemIndex := CFGECFNUMPORTA.AsInteger;
  CarregaAliquotas;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConfiguracaoECF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunEcf.free;
  CFGECF.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFConfiguracaoECF.CFGECFAfterEdit(DataSet: TDataSet);
begin
  ETipoECF.Enabled := TRUE;
end;

{******************************************************************************}
procedure TFConfiguracaoECF.CFGECFAfterPost(DataSet: TDataSet);
begin
  ETipoECF.Enabled := false;
  Sistema.MarcaTabelaParaImportar('CFG_ECF');
end;

{******************************************************************************}
procedure TFConfiguracaoECF.CFGECFBeforePost(DataSet: TDataSet);
begin
  CFGECFD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFConfiguracaoECF.EPortaChange(Sender: TObject);
begin
  if CFGECF.State = dsedit then
    CFGECFNUMPORTA.AsInteger := EPorta.ItemIndex;
end;

{******************************************************************************}
procedure TFConfiguracaoECF.ETipoECFChange(Sender: TObject);
begin
  if CFGECF.State = dsedit then
    CFGECFNUMTIPOECF.AsInteger := ETipoECF.ItemIndex;
end;

{******************************************************************************}
procedure TFConfiguracaoECF.CarregaAliquotas;
var
  VpfAliquotas : String;
begin
  VpfAliquotas :=  FunECF.RAliquotas;
  while VpfAliquotas <> ''do
  begin
    LAliquotas.Items.Add(DeletaChars(CopiaAteChar(VpfAliquotas,','),','));
    VpfAliquotas := DeleteAteChar(VpfAliquotas,',');
  end;
end;

{******************************************************************************}
procedure TFConfiguracaoECF.FecharClick(Sender: TObject);
begin
  close;
end;

procedure TFConfiguracaoECF.BAdicionarClick(Sender: TObject);
begin
  FunECF.AdicionaAliquotaICMS(ENovoAliquota.Avalor);
  LAliquotas.Items.add(ENovoAliquota.Text);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConfiguracaoECF]);
end.
