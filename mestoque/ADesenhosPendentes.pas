unit ADesenhosPendentes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Db, DBTables,
  Grids, DBGrids, Tabela, DBKeyViolation, Menus, UnProdutos, UnAmostra, DBClient;

type
  TFDesenhosPendentes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    Label1: TLabel;
    GridIndice1: TGridIndice;
    DesenhosComPedido: TSQL;
    DataDesenhosComPedido: TDataSource;
    DesenhosComPedidoI_EMP_FIL: TFMTBCDField;
    DesenhosComPedidoI_LAN_ORC: TFMTBCDField;
    DesenhosComPedidoD_DAT_ORC: TSQLTimeStampField;
    DesenhosComPedidoT_HOR_ORC: TSQLTimeStampField;
    DesenhosComPedidoC_COD_PRO: TWideStringField;
    DesenhosComPedidoC_NOM_PRO: TWideStringField;
    DesenhosComPedidoI_SEQ_PRO: TFMTBCDField;
    DesenhosComPedidoI_COR_KIT: TFMTBCDField;
    DesenhosComPedidoNOMMAQ: TWideStringField;
    PanelColor6: TPanelColor;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    ConcluirDesenho1: TMenuItem;
    Amostra: TSQL;
    GridIndice2: TGridIndice;
    DataAmostra: TDataSource;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    DesenhosComPedidoI_SEQ_MOV: TFMTBCDField;
    AmostraCODAMOSTRA: TFMTBCDField;
    AmostraNOMAMOSTRA: TWideStringField;
    AmostraDATAMOSTRA: TSQLTimeStampField;
    AmostraNOMMAQ: TWideStringField;
    AmostraDATREQUISICAO: TSQLTimeStampField;
    AmostraDESREQUISICAO: TWideStringField;
    AmostraC_NOM_CLI: TWideStringField;
    AmostraSEQREQUISICAO: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ConcluirDesenho1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    { Private declarations }
    FunAmostra : TRBFuncoesAmostra;
    procedure AtualizaConsulta;
    procedure AtualizaConsultaAmostra;
  public
    { Public declarations }
  end;

var
  FDesenhosPendentes: TFDesenhosPendentes;

implementation

uses APrincipal, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDesenhosPendentes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  AtualizaConsulta;
  AtualizaConsultaAmostra;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDesenhosPendentes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFDesenhosPendentes.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFDesenhosPendentes.AtualizaConsulta;
begin
  DesenhosComPedido.CLOSE;
  DesenhosComPedido.sql.clear;
  DesenhosComPedido.sql.add('select  CAD.I_EMP_FIL ,CAD.I_LAN_ORC, CAD.D_DAT_ORC, CAD.T_HOR_ORC, ' +
                            ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.I_SEQ_PRO, ' +
                            ' KIT.I_COR_KIT, KIT.I_SEQ_MOV, '+
                            ' MAQ.NOMMAQ '+
                            ' from MOVKIT KIT, CADPRODUTOS PRO, MAQUINA MAQ, MOVORCAMENTOS MOV, CADORCAMENTOS CAD ' +
                            ' WHERE PRO.I_SEQ_PRO = KIT.I_PRO_KIT '+
                            ' AND KIT.I_COD_MAQ = MAQ.CODMAQ '+
                            ' AND KIT.I_PRO_KIT = MOV.I_SEQ_PRO '+
                            ' AND KIT.I_COR_KIT = MOV.I_COD_COR '+
                            ' AND MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                            ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC '+
                            ' AND KIT.D_DAT_DES IS NULL ');
  DesenhosComPedido.sql.add('order by CAD.D_DAT_ORC ');
  DesenhosComPedido.open;
end;

{******************************************************************************}
procedure TFDesenhosPendentes.AtualizaConsultaAmostra;
begin
  Amostra.Close;
  Amostra.sql.clear;
  Amostra.sql.add('SELECT AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAMOSTRA, '+
                  ' MAQ.NOMMAQ, '+
                  ' REQ.DATREQUISICAO, REQ.DESREQUISICAO, REQ.SEQREQUISICAO, '+
                  ' CLI.C_NOM_CLI '+
                  ' FROM AMOSTRA AMO, REQUISICAOMAQUINA REQ, MAQUINA MAQ, CADCLIENTES CLI '+
                  ' WHERE REQ.DATCONCLUSAO IS NULL '+
                  ' AND MAQ.CODMAQ = REQ.CODMAQUINA '+
                  ' AND MAQ.INDDES = ''S'''+
                  ' AND AMO.CODAMOSTRA = REQ.CODAMOSTRA '+
                  ' AND AMO.CODCLIENTE = CLI.I_COD_CLI  ');
  Amostra.sql.add('order by REQ.DATREQUISICAO');
  Amostra.open;
end;

{******************************************************************************}
procedure TFDesenhosPendentes.ConcluirDesenho1Click(Sender: TObject);
var
  VpfResultado : string;
begin
  if DesenhosComPedidoI_LAN_ORC.AsInteger <> 0 then
  begin
    if Confirmacao('TEM CERTEZA QUE DESEJA CONCLUIR O DESENHO? ') then
    begin
      VpfResultado := FunProdutos.ConcluiDesenho(DesenhosComPedidoI_SEQ_PRO.AsInteger,DesenhosComPedidoI_COR_KIT.AsInteger,DesenhosComPedidoI_SEQ_MOV.AsInteger);
      if VpfResultado <> '' then
        aviso(vpfresultado)
      else
        AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFDesenhosPendentes.MenuItem1Click(Sender: TObject);
var
  VpfResultado : string;
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    if Confirmacao('TEM CERTEZA QUE DESEJA CONCLUIR O DESENHO DA AMOSTRA? ') then
    begin
      VpfResultado := FunAmostra.ConcluiDesenhoAmostra(AmostraSEQREQUISICAO.AsInteger);
      if VpfResultado <> '' then
        aviso(vpfresultado)
      else
        AtualizaConsultaAmostra;
    end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFDesenhosPendentes]);
end.
