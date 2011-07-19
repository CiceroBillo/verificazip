unit AFichaTecnicaPendente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, StdCtrls, Buttons,
  Componentes1, ExtCtrls, PainelGradiente, Menus,UnProdutos, Mask,
  numericos, DBClient;

type
  TFFichaTecnicaPendente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    Label1: TLabel;
    GridIndice1: TGridIndice;
    ProdutosComPedido: TSQL;
    DataProdutosComPedido: TDataSource;
    ProdutosComPedidoI_EMP_FIL: TFMTBCDField;
    ProdutosComPedidoI_LAN_ORC: TFMTBCDField;
    ProdutosComPedidoD_DAT_ORC: TSQLTimeStampField;
    ProdutosComPedidoC_COD_PRO: TWideStringField;
    ProdutosComPedidoC_NOM_PRO: TWideStringField;
    ProdutosComPedidoI_COD_COR: TFMTBCDField;
    ProdutosComPedidoT_HOR_ORC: TSQLTimeStampField;
    Label2: TLabel;
    GridIndice2: TGridIndice;
    Amostras: TSQL;
    AmostrasCODAMOSTRA: TFMTBCDField;
    AmostrasNOMAMOSTRA: TWideStringField;
    AmostrasDATAPROVACAO: TSQLTimeStampField;
    AmostrasC_NOM_CLI: TWideStringField;
    DataAmostras: TDataSource;
    PopupMenu1: TPopupMenu;
    MConcluirFichaTecnica: TMenuItem;
    ProdutosComPedidoI_SEQ_MOV: TFMTBCDField;
    ProdutosComPedidoC_NOM_CLI: TWideStringField;
    Label3: TLabel;
    EQtdFicha: Tnumerico;
    Aux: TSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MConcluirFichaTecnicaClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConfiguraPermissaoUsuario;
    procedure AtualizaConsulta;
    procedure AtualizaConsultaAmotra;
  public
    { Public declarations }
  end;

var
  FFichaTecnicaPendente: TFFichaTecnicaPendente;

implementation

uses APrincipal, ConstMsg, Constantes, FunObjeto, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFichaTecnicaPendente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ConfiguraPermissaoUsuario;
  AtualizaConsulta;
  AtualizaConsultaAmotra;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFichaTecnicaPendente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  ProdutosComPedido.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFFichaTecnicaPendente.AtualizaConsulta;
begin
  ProdutosCompedido.close;
  ProdutosComPedido.sql.clear;
  ProdutosComPedido.sql.add('select CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.D_DAT_ORC,   CAD.T_HOR_ORC, ' +
                            ' PRO.C_COD_PRO , PRO.C_NOM_PRO, '+
                            ' MOV.I_COD_COR, MOV.I_SEQ_MOV, '+
                            ' CLI.C_NOM_CLI '+
                            ' from CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADPRODUTOS PRO, CADCLIENTES CLI '+
                            ' where MOV.D_DAT_GOP is null '+
                            ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                            ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                            ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                            ' AND CAD.C_FLA_SIT = ''A'''+
                            ' AND CAD.C_IND_CAN = ''N'''+
                            ' and CAD.I_COD_CLI = CLI.I_COD_CLI');
  ProdutosComPedido.sql.add('order by CAD.D_DAT_ORC');
  ProdutosComPedido.open;
  AdicionaSQLAbreTabela(Aux,'select count(DISTINCT(MOV.I_SEQ_PRO)) QTD '+
                            ' from CADORCAMENTOS CAD, MOVORCAMENTOS MOV '+
                            ' where MOV.D_DAT_GOP is null '+
                            ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                            ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                            ' AND CAD.C_FLA_SIT = ''A'''+
                            ' AND CAD.C_IND_CAN = ''N''');
  EQtdFicha.AsInteger := Aux.FieldByName('QTD').AsInteger;

end;

{******************************************************************************}
procedure TFFichaTecnicaPendente.ConfiguraPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([MConcluirFichaTecnica],false);
  end;
end;

{******************************************************************************}
procedure TFFichaTecnicaPendente.AtualizaConsultaAmotra;
begin
  Amostras.Close;
  Amostras.sql.clear;
  Amostras.sql.add('select AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAPROVACAO, '+
                   ' CLI.C_NOM_CLI '+
                   ' from AMOSTRA AMO,  CADCLIENTES CLI '+
                   ' Where AMO.DATAPROVACAO IS NOT NULL '+
                   ' AND AMO.DATFICHA IS NULL '+
                   ' AND AMO.CODCLIENTE = CLI.I_COD_CLI ');
  Amostras.sql.add('order by AMO.DATAPROVACAO');
  Amostras.open;
end;

{******************************************************************************}
procedure TFFichaTecnicaPendente.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFFichaTecnicaPendente.MConcluirFichaTecnicaClick(
  Sender: TObject);
var
  VpfResultado : String;
begin
 if (config.GrupoAdminFichas = true) and (varia.GrupoUsuario = 1) then
 begin
  if confirmacao('Tem certeza que deseja concluir a ficha técnica?') then
  begin
    VpfResultado := FunProdutos.ConcluiFichaTecnica(ProdutosComPedidoI_EMP_FIL.AsInteger,ProdutosComPedidoI_LAN_ORC.AsInteger,ProdutosComPedidoI_SEQ_MOV.AsInteger);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsulta;
  end;
 end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFichaTecnicaPendente]);
end.
