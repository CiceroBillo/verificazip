unit ALiberaModulo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, DBCtrls, DB, DBClient, Tabela,
  CBancoDados, Buttons, Componentes1, BotaoCadastro, FunSql;

type
  TFLiberaModulo = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Fechar: TBitBtn;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    Cfg_Modulo: TRBSQL;
    DataCfg_Modulo: TDataSource;
    DBancario: TDBCheckBox;
    DFluxo: TDBCheckBox;
    DComissoes: TDBCheckBox;
    DNota: TDBCheckBox;
    DEcf: TDBCheckBox;
    DContasPagar: TDBCheckBox;
    DContasReceber: TDBCheckBox;
    DFaturamento: TDBCheckBox;
    DCaixa: TDBCheckBox;
    DProduto: TDBCheckBox;
    DCusto: TDBCheckBox;
    DEstoque: TDBCheckBox;
    DServico: TDBCheckBox;
    DTef: TDBCheckBox;
    DCodigoBarra: TDBCheckBox;
    DGaveta: TDBCheckBox;
    DImpDocumento: TDBCheckBox;
    DOrcamentoVenda: TDBCheckBox;
    DImpExp: TDBCheckBox;
    DSenhaGrupo: TDBCheckBox;
    DMala: TDBCheckBox;
    DAgenda: TDBCheckBox;
    DPedido: TDBCheckBox;
    DOrdem: TDBCheckBox;
    DTeleMarketing: TDBCheckBox;
    DFaccionista: TDBCheckBox;
    DAmostra: TDBCheckBox;
    DOrdemProducao: TDBCheckBox;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    Cfg_ModuloFLA_BANCARIO: TWideStringField;
    Cfg_ModuloFLA_FLUXO: TWideStringField;
    Cfg_ModuloFLA_COMISSAO: TWideStringField;
    Cfg_ModuloFLA_NOTA_FISCAL: TWideStringField;
    Cfg_ModuloFLA_ECF: TWideStringField;
    Cfg_ModuloFLA_CONTA_PAGAR: TWideStringField;
    Cfg_ModuloFLA_CONTA_RECEBER: TWideStringField;
    Cfg_ModuloFLA_FATURAMENTO: TWideStringField;
    Cfg_ModuloFLA_CAIXA: TWideStringField;
    Cfg_ModuloFLA_PRODUTO: TWideStringField;
    Cfg_ModuloFLA_CUSTO: TWideStringField;
    Cfg_ModuloFLA_ESTOQUE: TWideStringField;
    Cfg_ModuloFLA_SERVICO: TWideStringField;
    Cfg_ModuloFLA_TEF: TWideStringField;
    Cfg_ModuloFLA_CODIGOBARRA: TWideStringField;
    Cfg_ModuloFLA_GAVETA: TWideStringField;
    Cfg_ModuloFLA_IMPDOCUMENTOS: TWideStringField;
    Cfg_ModuloFLA_ORCAMENTOVENDA: TWideStringField;
    Cfg_ModuloFLA_IMP_EXP: TWideStringField;
    Cfg_ModuloFLA_SENHAGRUPO: TWideStringField;
    Cfg_ModuloFLA_MALACLIENTE: TWideStringField;
    Cfg_ModuloFLA_AGENDACLIENTE: TWideStringField;
    Cfg_ModuloFLA_PEDIDO: TWideStringField;
    Cfg_ModuloFLA_ORDEMSERVICO: TWideStringField;
    Cfg_ModuloFLA_TELEMARKETING: TWideStringField;
    Cfg_ModuloFLA_FACCIONISTA: TWideStringField;
    Cfg_ModuloFLA_AMOSTRA: TWideStringField;
    Cfg_ModuloFLA_ORDEMPRODUCAO: TWideStringField;
    Cfg_ModuloD_ULT_ALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure Cfg_ModuloAfterPost(DataSet: TDataSet);
    procedure Cfg_ModuloBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLiberaModulo: TFLiberaModulo;

implementation

uses APrincipal, UnSistema, FunObjeto;

{$R *.DFM}


{ **************************************************************************** }
procedure TFLiberaModulo.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AdicionaSQLAbreTabela(Cfg_Modulo,'Select * from CFG_MODULO ');
  InicializaVerdadeiroeFalsoCheckBox(Self, 'T', 'F');
end;

{ *************************************************************************** }
procedure TFLiberaModulo.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFLiberaModulo.Cfg_ModuloAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CFG_MODULO');
end;

{******************************************************************************}
procedure TFLiberaModulo.Cfg_ModuloBeforePost(DataSet: TDataSet);
begin
  Cfg_ModuloD_ULT_ALT.AsDateTime:= Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFLiberaModulo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Cfg_Modulo.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFLiberaModulo]);
end.
