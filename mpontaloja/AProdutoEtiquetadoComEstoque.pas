unit AProdutoEtiquetadoComEstoque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons;

type
  TFProdutoEtiquetadoComEstoque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    Produtos: TQuery;
    DataProdutos: TDataSource;
    ProdutosCODFILIAL: TIntegerField;
    ProdutosLANORCAMENTO: TIntegerField;
    ProdutosDATIMPRESSAO: TDateTimeField;
    ProdutosN_QTD_PRO: TFloatField;
    ProdutosN_QTD_BAI: TFloatField;
    ProdutosD_DAT_ORC: TDateField;
    ProdutosC_NOM_CLI: TStringField;
    ProdutosQtdPendente: TFloatField;
    ProdutosC_NOM_PRO: TStringField;
    ProdutosC_COD_PRO: TStringField;
    BSeparado: TBitBtn;
    BFechar: TBitBtn;
    Aux: TQuery;
    ProdutosSEQETIQUETA: TIntegerField;
    ProdutosQTDETIQUETADO: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ProdutosCalcFields(DataSet: TDataSet);
    procedure BSeparadoClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta;
  public
    { Public declarations }
  end;

var
  FProdutoEtiquetadoComEstoque: TFProdutoEtiquetadoComEstoque;

implementation

uses APrincipal,FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProdutoEtiquetadoComEstoque.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProdutoEtiquetadoComEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Produtos.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFProdutoEtiquetadoComEstoque.AtualizaConsulta;
var
  VpfPosicao : TBookMark;
begin
  VpfPosicao := Produtos.GetBookmark;
  Produtos.sql.clear;
  Produtos.Sql.add('select ETI.CODFILIAL, ETI.LANORCAMENTO, ETI.SEQETIQUETA, ETI.DATIMPRESSAO, MOV.N_QTD_PRO, MOV.N_QTD_BAI, CAD.D_DAT_ORC, '+
                   ' ETI.QTDETIQUETADO, '+
                   ' CLI.C_NOM_CLI, PRO.C_COD_PRO,  PRO.C_NOM_PRO '+
                   ' from PRODUTOETIQUETADOCOMPEDIDO ETI, CADPRODUTOS PRO, MOVORCAMENTOS MOV, CADORCAMENTOS CAD, '+
                   ' CADCLIENTES CLI '+
                   ' Where PRO.I_SEQ_PRO = MOV.I_SEQ_PRO '+
                   ' AND ETI.CODFILIAL = MOV.I_EMP_FIL '+
                   ' AND ETI.LANORCAMENTO = MOV.I_LAN_ORC '+
                   ' AND ETI.SEQMOVIMENTO = MOV.I_SEQ_MOV '+
                   ' AND ETI.CODFILIAL = CAD.I_EMP_FIL '+
                   ' AND ETI.LANORCAMENTO = CAD.I_LAN_ORC '+
                   ' AND CAD.I_COD_CLI = CLI.I_COD_CLI'+
                   ' order by ETI.DATIMPRESSAO');

  Produtos.Open;
  Try
    Produtos.GotoBookmark(VpfPosicao);
  except
  end;
  Produtos.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFProdutoEtiquetadoComEstoque.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFProdutoEtiquetadoComEstoque.ProdutosCalcFields(
  DataSet: TDataSet);
begin
  ProdutosQtdPendente.AsFloat := ProdutosN_QTD_PRO.AsFloat - ProdutosN_QTD_BAI.AsFloat;
end;

{******************************************************************************}
procedure TFProdutoEtiquetadoComEstoque.BSeparadoClick(Sender: TObject);
begin
  IF ProdutosCODFILIAL.AsInteger <> 0 THEN
  Begin
    ExecutaComandoSql(Aux,'DELETE FROM PRODUTOETIQUETADOCOMPEDIDO '+
                        ' Where CODFILIAL = '+ProdutosCODFILIAL.AsString +
                        ' and LANORCAMENTO = '+ProdutosLANORCAMENTO.AsString+
                        ' and SEQETIQUETA = '+ProdutosSEQETIQUETA.AsString);
    AtualizaConsulta;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFProdutoEtiquetadoComEstoque]);
end.
