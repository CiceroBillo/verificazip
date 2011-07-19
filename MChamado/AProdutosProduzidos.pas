unit AProdutosProduzidos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, StdCtrls, Buttons, Grids, CGrades,
  DBGrids, Tabela, DB, DBClient, CBancoDados, ConstMsg, Menus;

type
  TRBDColunaGrade =(clIndProduzido,clCodFilial,clCodProduto,clNomProduto,clNumChamado,clSeqItemProdutoChamado,clSeqItemProduzir);

  TFProdutosProduzidos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    GProdutos: TDBGridColor;
    CHAMADOPRODUTOAPRODUZIR: TRBSQL;
    DataCHAMADOPRODUTOAPRODUZIR: TDataSource;
    CHAMADOPRODUTOAPRODUZIRCODFILIAL: TFMTBCDField;
    CHAMADOPRODUTOAPRODUZIRNUMCHAMADO: TFMTBCDField;
    CHAMADOPRODUTOAPRODUZIRC_COD_PRO: TWideStringField;
    CHAMADOPRODUTOAPRODUZIRC_NOM_PRO: TWideStringField;
    CHAMADOPRODUTOAPRODUZIRQTDPRODUTO: TFMTBCDField;
    CHAMADOPRODUTOAPRODUZIRSEQITEM: TFMTBCDField;
    CHAMADOPRODUTOAPRODUZIRSEQITEMORCADO: TFMTBCDField;
    Aux: TSQL;
    Cadastro: TSQL;
    CHAMADOPRODUTOAPRODUZIRSEQPRODUTO: TFMTBCDField;
    CHAMADOPRODUTOAPRODUZIRVALUNITARIO: TFMTBCDField;
    CHAMADOPRODUTOAPRODUZIRVALTOTAL: TFMTBCDField;
    CHAMADOPRODUTOAPRODUZIRDESUM: TWideStringField;
    MenuItem: TPopupMenu;
    MProdutoProduzido: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MProdutoProduzidoClick(Sender: TObject);
  private
    function RColunaGrade(VpaColuna : TRBDColunaGrade):Integer;
    procedure ExcluiItemGrade;
    function GravaItemProdutoOrcado:String;
    function RSeqItemOrcadoDisponivel: integer;
  public
    { Public declarations }
  end;

var
  FProdutosProduzidos: TFProdutosProduzidos;

implementation

uses APrincipal, FunSQL;

{$R *.DFM}


{ **************************************************************************** }
procedure TFProdutosProduzidos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CHAMADOPRODUTOAPRODUZIR.Open;
end;

{******************************************************************************}
procedure TFProdutosProduzidos.GProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
end;

{******************************************************************************}
Function TFProdutosProduzidos.GravaItemProdutoOrcado: string;
begin
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM CHAMADOPRODUTOORCADO ' +
                                 ' Where CODFILIAL = 0 AND NUMCHAMADO = 0 AND SEQITEM = 0 AND SEQITEMORCADO = 0 ');
  Cadastro.insert;

  Cadastro.FieldByName('CODFILIAL').AsInteger:= CHAMADOPRODUTOAPRODUZIRCODFILIAL.AsInteger;
  Cadastro.FieldByName('NUMCHAMADO').AsInteger:= CHAMADOPRODUTOAPRODUZIRNUMCHAMADO.AsInteger;
  Cadastro.FieldByName('SEQITEM').AsInteger:= CHAMADOPRODUTOAPRODUZIRSEQITEM.AsInteger;
  Cadastro.FieldByName('SEQITEMORCADO').AsInteger:= RSeqItemOrcadoDisponivel;
  Cadastro.FieldByName('SEQPRODUTO').AsInteger:= CHAMADOPRODUTOAPRODUZIRSEQPRODUTO.AsInteger;
  Cadastro.FieldByName('QTDPRODUTO').AsFloat:= CHAMADOPRODUTOAPRODUZIRQTDPRODUTO.AsFloat;
  Cadastro.FieldByName('VALUNITARIO').AsFloat:= CHAMADOPRODUTOAPRODUZIRVALUNITARIO.AsFloat;
  Cadastro.FieldByName('VALTOTAL').AsFloat:= CHAMADOPRODUTOAPRODUZIRVALTOTAL.AsFloat;
  Cadastro.FieldByName('DESUM').AsString:= CHAMADOPRODUTOAPRODUZIRDESUM.AsString;
  Cadastro.FieldByName('DATPRODUCAO').AsDateTime:= now;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TFProdutosProduzidos.MProdutoProduzidoClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado := GravaItemProdutoOrcado;
  if VpfResultado = '' then
  begin
    ExcluiItemGrade;
    CHAMADOPRODUTOAPRODUZIR.Close;
    CHAMADOPRODUTOAPRODUZIR.Open;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFProdutosProduzidos.RColunaGrade(VpaColuna: TRBDColunaGrade): Integer;
begin
  case VpaColuna of
    clIndProduzido: result:=1;
    clCodFilial: result:=2;
    clCodProduto: result:=3;
    clNomProduto: result:=4;
    clNumChamado: result:=5;
    clSeqItemProdutoChamado: result:=6;
    clSeqItemProduzir: result:=7;
  end;
end;

{******************************************************************************}
function TFProdutosProduzidos.RSeqItemOrcadoDisponivel: integer;
begin
  AdicionaSQLAbreTabela(Aux, 'select MAX(SEQITEMORCADO) as ultimo from CHAMADOPRODUTOAPRODUZIR ' +
                             ' where CODFILIAL = ' + IntToStr(CHAMADOPRODUTOAPRODUZIRCODFILIAL.AsInteger) +
                             ' AND NUMCHAMADO = ' + IntToStr(CHAMADOPRODUTOAPRODUZIRNUMCHAMADO.AsInteger) +
                             ' AND SEQITEM=' + IntToStr(CHAMADOPRODUTOAPRODUZIRSEQITEM.AsInteger));
  result:= aux.FieldByName('ultimo').AsInteger + 1;
end;

{ *************************************************************************** }
procedure TFProdutosProduzidos.BFecharClick(Sender: TObject);
begin
  close;
end;


{******************************************************************************}
procedure TFProdutosProduzidos.ExcluiItemGrade;
begin
  ExecutaComandoSql(aux, 'DELETE FROM CHAMADOPRODUTOAPRODUZIR ' +
                         ' WHERE CODFILIAL = ' + IntToStr(CHAMADOPRODUTOAPRODUZIRCODFILIAL.AsInteger) +
                         ' AND NUMCHAMADO = ' + IntToStr(CHAMADOPRODUTOAPRODUZIRNUMCHAMADO.AsInteger) +
                         ' AND SEQITEM = ' + IntToStr(CHAMADOPRODUTOAPRODUZIRSEQITEM.AsInteger) +
                         ' AND SEQITEMORCADO = ' + IntToStr(CHAMADOPRODUTOAPRODUZIRSEQITEMORCADO.AsInteger));
end;

{******************************************************************************}
procedure TFProdutosProduzidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CHAMADOPRODUTOAPRODUZIR.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}



Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFProdutosProduzidos]);
end.
