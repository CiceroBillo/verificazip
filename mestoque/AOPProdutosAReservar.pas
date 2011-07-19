unit AOPProdutosAReservar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, ExtCtrls, PainelGradiente,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, StdCtrls, Buttons, DB, DBClient, CBancoDados;

type
  TFOPProdutosAReservar = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    Produtos: TRBSQL;
    ProdutosCODFILIAL: TFMTBCDField;
    ProdutosSEQORDEM: TFMTBCDField;
    ProdutosSEQFRACAO: TFMTBCDField;
    ProdutosSEQCONSUMO: TFMTBCDField;
    ProdutosQTDARESERVAR: TFMTBCDField;
    ProdutosC_NOM_CLI: TWideStringField;
    DataProdutos: TDataSource;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    VprSeqProduto,
    VprCodCor : Integer;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
    procedure MostraFracoesEstoqueAReservar(VpaSeqProduto,VpaCodCor : Integer);
  end;

var
  FOPProdutosAReservar: TFOPProdutosAReservar;

implementation

uses APrincipal, FunSql;

{$R *.DFM}


{ **************************************************************************** }
procedure TFOPProdutosAReservar.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{******************************************************************************}
procedure TFOPProdutosAReservar.MostraFracoesEstoqueAReservar(VpaSeqProduto, VpaCodCor: Integer);
begin
  VprSeqProduto := VpaSeqProduto;
  VprCodCor := VpaCodCor;
  AtualizaConsulta;
  showmodal;
end;

{ *************************************************************************** }
procedure TFOPProdutosAReservar.AdicionaFiltros(VpaSelect: TStrings);
begin
  VpaSelect.Add('and FRA.SEQPRODUTO = '+IntToStr(VprSeqProduto)+
                'and FRA.CODCOR = ' +IntToStr(VprCodCor)+
                ' AND FRA.INDBAIXADO = ''N''');
end;

{******************************************************************************}
procedure TFOPProdutosAReservar.AtualizaConsulta;
begin
  LimpaSQLTabela(Produtos);
  AdicionaSQLTabela(Produtos,'select FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO, FRA.SEQCONSUMO, FRA.QTDARESERVAR, ' +
                             ' CLI.C_NOM_CLI ' +
                             ' from FRACAOOPCONSUMO FRA, ORDEMPRODUCAOCORPO OP, CADCLIENTES CLI ' +
                             ' where FRA.CODFILIAL = OP.EMPFIL ' +
                             ' AND FRA.SEQORDEM = OP.SEQORD ' +
                             ' AND OP.CODCLI = CLI.I_COD_CLI');
  AdicionaFiltros(Produtos.SQL);
  Produtos.Open;
end;

{******************************************************************************}
procedure TFOPProdutosAReservar.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFOPProdutosAReservar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFOPProdutosAReservar]);
end.
