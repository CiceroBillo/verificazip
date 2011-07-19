unit ATipoCotacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, BotaoCadastro, Componentes1, ExtCtrls, PainelGradiente,
  Localizacao, Mask, DBCtrls, Tabela, DBKeyViolation, Db, DBTables,
  CBancoDados, Grids, DBGrids, DBClient;

type
  TFTipoCotacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    CadTipoOrcamento: TRBSQL;
    CadTipoOrcamentoI_COD_TIP: TFMTBCDField;
    CadTipoOrcamentoC_NOM_TIP: TWideStringField;
    CadTipoOrcamentoC_CLA_PLA: TWideStringField;
    CadTipoOrcamentoI_COD_OPE: TFMTBCDField;
    Label1: TLabel;
    DataCadTipoOrcamento: TDataSource;
    Label2: TLabel;
    Label4: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    EPlanoContas: TDBEditLocaliza;
    Localiza: TConsultaPadrao;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    Label17: TLabel;
    EOperacaoEstoque: TDBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    EConsulta: TLocalizaEdit;
    Grade: TGridIndice;
    CadTipoOrcamentoI_COD_VEN: TFMTBCDField;
    CadTipoOrcamentoC_IND_CHA: TWideStringField;
    ECodVendedor: TDBEditLocaliza;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    Label7: TLabel;
    CadTipoOrcamentoC_IND_DAP: TWideStringField;
    CChamadoTecnico: TDBCheckBox;
    CDataEntrega: TDBCheckBox;
    CRevenda: TDBCheckBox;
    CadTipoOrcamentoC_IND_REV: TWideStringField;
    CadTipoOrcamentoD_ULT_ALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CadTipoOrcamentoAfterPost(DataSet: TDataSet);
    procedure CadTipoOrcamentoAfterEdit(DataSet: TDataSet);
    procedure CadTipoOrcamentoBeforePost(DataSet: TDataSet);
    procedure CadTipoOrcamentoAfterInsert(DataSet: TDataSet);
    procedure GradeOrdem(Ordem: String);
    procedure EOperacaoEstoqueCadastrar(Sender: TObject);
    procedure EPlanoContasCadastrar(Sender: TObject);
    procedure CadTipoOrcamentoAfterScroll(DataSet: TDataSet);
    procedure ECodVendedorCadastrar(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoCotacao: TFTipoCotacao;

implementation

uses APrincipal, AOperacoesEstoques, APlanoConta, ANovoVendedor, constantes, FunObjeto,
  UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoCotacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
  IniciallizaCheckBox([CChamadoTecnico,CDataEntrega,CRevenda],'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTipoCotacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CadTipoOrcamento.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTipoCotacao.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFTipoCotacao.CadTipoOrcamentoAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADTIPOORCAMENTO');
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTipoCotacao.CadTipoOrcamentoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
end;

{******************************************************************************}
procedure TFTipoCotacao.CadTipoOrcamentoBeforePost(DataSet: TDataSet);
begin
  if CadTipoOrcamento.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  CadTipoOrcamentoD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFTipoCotacao.CadTipoOrcamentoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
  CadTipoOrcamentoC_IND_CHA.AsString := 'N';
  CadTipoOrcamentoC_IND_REV.AsString := 'N';
  if config.ExigirDataEntregaPrevista then
    CadTipoOrcamentoC_IND_DAP.AsString := 'S'
  else
    CadTipoOrcamentoC_IND_DAP.AsString := 'N';
end;

{******************************************************************************}
procedure TFTipoCotacao.GradeOrdem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFTipoCotacao.EOperacaoEstoqueCadastrar(Sender: TObject);
begin
  FOperacoesEstoques := TFOperacoesEstoques.criarSDI(Application,'',FPrincipal.VerificaPermisao('FOperacoesEstoques'));
  FOperacoesEstoques.ShowModal;
  FOperacoesEstoques.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTipoCotacao.EPlanoContasCadastrar(Sender: TObject);
begin
  FPlanoConta := TFPlanoConta.criarSDI(Application,'',FPrincipal.VerificaPermisao('FPlanoConta'));
  FPlanoConta.CarregaCadastraPlanoContas;
  FPlanoConta.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTipoCotacao.CadTipoOrcamentoAfterScroll(DataSet: TDataSet);
begin
  EPlanoContas.Atualiza;
  EOperacaoEstoque.atualiza;
  ECodVendedor.Atualiza;
end;

procedure TFTipoCotacao.ECodVendedorCadastrar(Sender: TObject);
begin
  FNovoVendedor := tFNovoVendedoR.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoVendedor'));
  FNovoVendedor.CadVendedores.Insert;
  FNovoVendedor.ShowModal;
  FNovoVendedor.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoCotacao]);
end.
