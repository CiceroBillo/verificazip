unit APedidosPendentesFaturar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, Db, DBTables, StdCtrls, Buttons, Localizacao, DBClient;

type
  TFPedidosPendentesFaturar = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    PedidosPendentes: TSQL;
    PedidosPendentesI_EMP_FIL: TFMTBCDField;
    PedidosPendentesI_LAN_ORC: TFMTBCDField;
    PedidosPendentesD_DAT_ORC: TSQLTimeStampField;
    PedidosPendentesC_NOM_CLI: TWideStringField;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    ECliente: TEditLocaliza;
    DataPedidosPendentes: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta(VpaCodFilial,VpaLanOrcamento,VpaCodCliente : Integer);
  public
    { Public declarations }
    procedure MosraPedidosPendentes(VpaCodFilial,VpaLanOrcamento, VpaCodCliente : Integer);
  end;

var
  FPedidosPendentesFaturar: TFPedidosPendentesFaturar;

implementation

uses APrincipal, FunSql, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPedidosPendentesFaturar.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPedidosPendentesFaturar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPedidosPendentesFaturar.AtualizaConsulta(VpaCodFilial,VpaLanOrcamento,VpaCodCliente : Integer);
begin
  AdicionaSQLAbreTabela(PedidosPendentes,'select ORC.I_EMP_FIL , ORC.I_LAN_ORC, ORC.D_DAT_ORC, '+
                                         ' CLI.C_NOM_CLI '+
                                         ' from  CADCLIENTES CLI, CADORCAMENTOS ORC '+
                                         ' WHERE ORC.I_COD_CLI = CLI.I_COD_CLI '+
                                         ' AND ORC.I_TIP_ORC = '+ IntToStr(Varia.TipoCotacaoPedido)+
                                         ' and ORC.I_COD_CLI = '+ IntToStr(VpaCodCliente)+
                                         ' and NOT (ORC.I_EMP_FIL = '+ IntToStr(VpaCodFilial) +
                                         ' AND ORC.I_LAN_ORC = ' + IntToStr(VpaLanOrcamento)+' )'+
                                         ' AND ORC.C_GER_FIN IS NULL '+
                                         ' ORDER BY ORC.D_DAT_ORC ');
end;

{******************************************************************************}
procedure TFPedidosPendentesFaturar.MosraPedidosPendentes(VpaCodFilial,VpaLanOrcamento,VpaCodCliente: Integer);
begin
  AtualizaConsulta(VpaCodFilial,VpaLanOrcamento, VpaCodCliente);
  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  if not PedidosPendentes.Eof then
    ShowModal;
end;

{******************************************************************************}
procedure TFPedidosPendentesFaturar.BitBtn1Click(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPedidosPendentesFaturar]);
end.
