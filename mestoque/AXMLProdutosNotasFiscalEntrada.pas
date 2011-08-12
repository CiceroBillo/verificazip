unit AXMLProdutosNotasFiscalEntrada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Grids, CGrades, UnDadosProduto;

type
  TRBDColunaGrade =(clCodProduto,clNomProduto,clCodCor,clNomCor,clCodTamanho,clNomTamanho,clClassificacaoFiscal,clCST,clUm,clQtdPro,ClValUnitarioPro,clValTotalPro,clPerIcms,clPerIpi,clNumSerie,clRefFornecedor);
  TRBDColunaXGrade =(clxCodProduto,clxNomProduto,clxCodCor,clxNomCor,clxCodTamanho,clxNomTamanho,clxClassificacaoFiscal,clxUm,clxQtdPro,ClxValUnitarioPro,clxValTotalPro,clxPerIcms,clxPerIpi,clxNumSerie,clxRefFornecedor);

  TFXMLProdutosNotaFiscalEntrada = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    Label1: TLabel;
    PanelColor7: TPanelColor;
    Label2: TLabel;
    Grade: TRBStringGridColor;
    GXML: TRBStringGridColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure FormShow(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure GXMLCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
  private
    { Private declarations }
    VprDNotaFor : TRBDNotaFiscalFor;
    VprDItemNota : TRBDNotaFiscalForItem;
    VprDXMLProduto : TRBDProdutoXMLNotaFor;
    procedure ConfiguraPermissaoUsuario;
    procedure CarTitulosGrade;
    function RColunaGrade(VpaColuna : TRBDColunaGrade):Integer;
    function RColunaXMLGrade(VpaColuna : TRBDColunaXGrade):Integer;
  public
    { Public declarations }
    function CarProdutosXML(VpaDNota : TRBDNotaFiscalFor):Boolean;
  end;

var
  FXMLProdutosNotaFiscalEntrada: TFXMLProdutosNotaFiscalEntrada;

implementation

uses APrincipal, Constantes, FunNumeros;

{$R *.DFM}


{ **************************************************************************** }
procedure TFXMLProdutosNotaFiscalEntrada.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
  ConfiguraPermissaoUsuario;
end;

{******************************************************************************}
procedure TFXMLProdutosNotaFiscalEntrada.FormShow(Sender: TObject);
begin
  PanelColor3.Height := Self.Height div 2;
end;

{******************************************************************************}
procedure TFXMLProdutosNotaFiscalEntrada.GradeCarregaItemGrade(Sender: TObject;VpaLinha: Integer);
begin
  VprDItemNota := TRBDNotaFiscalForItem(VprDNotaFor.ItensNota.Items[VpaLinha-1]);
  Grade.Cells[RColunaGrade(clCodProduto),VpaLinha] := VprDItemNota.CodProduto;
  Grade.Cells[RColunaGrade(clNomProduto),VpaLinha] := VprDItemNota.NomProduto;
  if VprDItemNota.CodCor <> 0 then
    Grade.Cells[RColunaGrade(clCodCor),VpaLinha] := IntToStr(VprDItemNota.CodCor)
  else
    Grade.Cells[RColunaGrade(clCodCor),VpaLinha] := '';
  Grade.Cells[RColunaGrade(clNomCor),VpaLinha] := VprDItemNota.DesCor;

  if VprDItemNota.CodTamanho <> 0 then
    Grade.Cells[RColunaGrade(clCodTamanho),VpaLinha] := IntToStr(VprDItemNota.CodTamanho)
  else
    Grade.Cells[RColunaGrade(clCodTamanho),VpaLinha] := '';
  Grade.Cells[RColunaGrade(clNomTamanho),VpaLinha] := VprDItemNota.DesTamanho;
  Grade.Cells[RColunaGrade(clClassificacaoFiscal),VpaLinha] := VprDItemNota.CodClassificacaoFiscal;
  Grade.Cells[RColunaGrade(clCST),VpaLinha] := VprDItemNota.CodCST;
  Grade.Cells[RColunaGrade(clPerIcms),VpaLinha] := FormatFloat('0.00',VprDItemNota.PerICMS);
  Grade.Cells[RColunaGrade(clUm),VpaLinha] := VprDItemNota.UM;
  Grade.Cells[RColunaGrade(clPerIcms),VpaLinha] := FormatFloat('0.00',VprDItemNota.PerICMS);
  Grade.Cells[RColunaGrade(clPerIpi),VpaLinha] := FormatFloat('0.00',VprDItemNota.PerIPI);

  VprDItemNota.ValTotal := ArredondaDecimais((VprDItemNota.ValUnitario * VprDItemNota.QtdProduto),2);
  Grade.Cells[RColunaGrade(clQtdPro),Grade.ALinha] := FormatFloat(varia.MascaraQtd,VprDItemNota.QtdProduto);
  Grade.Cells[RColunaGrade(ClValUnitarioPro),Grade.ALinha] := FormatFloat('###,###,###,##0.0000',VprDItemNota.ValUnitario);
  Grade.Cells[RColunaGrade(clValTotalPro),Grade.ALinha] := FormatFloat(Varia.MascaraValor,VprDItemNota.ValTotal);

  Grade.Cells[RColunaGrade(clNumSerie),VpaLinha] := VprDItemNota.DesNumSerie;
  Grade.Cells[RColunaGrade(clRefFornecedor),VpaLinha] := VprDItemNota.DesReferenciaFornecedor;
end;

{******************************************************************************}
procedure TFXMLProdutosNotaFiscalEntrada.GXMLCarregaItemGrade(Sender: TObject;VpaLinha: Integer);
begin
  VprDXMLProduto := TRBDProdutoXMLNotaFor(VprDNotaFor.ItensXML.Items[VpaLinha-1]);
  GXML.Cells[RColunaXMLGrade(clxCodProduto),VpaLinha] := VprDXMLProduto.CodProduto;
  GXML.Cells[RColunaXMLGrade(clxNomProduto),VpaLinha] := VprDXMLProduto.NomProduto;
  if VprDItemNota.CodCor <> 0 then
    GXML.Cells[RColunaXMLGrade(clxCodCor),VpaLinha] := IntToStr(VprDXMLProduto.CodCor)
  else
    GXML.Cells[RColunaXMLGrade(clxCodCor),VpaLinha] := '';

  GXML.Cells[RColunaXMLGrade(clxNomCor),VpaLinha] := VprDXMLProduto.NomCor;

  if VprDXMLProduto.CodTamanho <> 0 then
    GXML.Cells[RColunaXMLGrade(clxCodTamanho),VpaLinha] := IntToStr(VprDXMLProduto.CodTamanho)
  else
    GXML.Cells[RColunaXMLGrade(clxCodTamanho),VpaLinha] := '';
  GXML.Cells[RColunaXMLGrade(clxNomTamanho),VpaLinha] := VprDXMLProduto.NomTamanho;
  GXML.Cells[RColunaXMLGrade(clxClassificacaoFiscal),VpaLinha] := VprDXMLProduto.CodClassificacaoFiscal;
  GXML.Cells[RColunaXMLGrade(clxPerIcms),VpaLinha] := FormatFloat('0.00',VprDXMLProduto.PerICMS);
  GXML.Cells[RColunaXMLGrade(clxUm),VpaLinha] := VprDXMLProduto.DesUM;
  GXML.Cells[RColunaXMLGrade(clxPerIcms),VpaLinha] := FormatFloat('0.00',VprDXMLProduto.PerICMS);
  GXML.Cells[RColunaXMLGrade(clxPerIpi),VpaLinha] := FormatFloat('0.00',VprDXMLProduto.PerIPI);

  VprDXMLProduto.ValTotal := ArredondaDecimais((VprDXMLProduto.ValUnitario * VprDXMLProduto.QtdProduto),2);
  GXML.Cells[RColunaXMLGrade(clxQtdPro),GXML.ALinha] := FormatFloat(varia.MascaraQtd,VprDXMLProduto.QtdProduto);
  GXML.Cells[RColunaXMLGrade(ClxValUnitarioPro),GXML.ALinha] := FormatFloat('###,###,###,##0.0000',VprDXMLProduto.ValUnitario);
  GXML.Cells[RColunaXMLGrade(clxValTotalPro),GXML.ALinha] := FormatFloat(Varia.MascaraValor,VprDXMLProduto.ValTotal);

//  GXML.Cells[RColunaXMLGrade(clxNumSerie),VpaLinha] := VprDXMLProduto.DesNumSerie;
  GXML.Cells[RColunaXMLGrade(clxRefFornecedor),VpaLinha] := VprDXMLProduto.CodReferencia;
end;

{******************************************************************************}
function TFXMLProdutosNotaFiscalEntrada.RColunaGrade(VpaColuna: TRBDColunaGrade): Integer;
begin
  case VpaColuna of
    clCodProduto: result:=1;
    clNomProduto: result:=2;
    clCodCor: result:=3;
    clNomCor: result:=4;
    clCodTamanho: result:=5;
    clNomTamanho: result:=6;
    clClassificacaoFiscal: result:=7;
    clCST: result:=8;
    clUm: result:=9;
    clQtdPro: result:=10;
    ClValUnitarioPro: result:=11;
    clValTotalPro: result:=12;
    clPerIcms: result:=13;
    clPerIpi: result:=14;
    clNumSerie: result:=15;
    clRefFornecedor: result:=16;
  end;
end;

{******************************************************************************}
function TFXMLProdutosNotaFiscalEntrada.RColunaXMLGrade(VpaColuna: TRBDColunaXGrade): Integer;
begin
  case VpaColuna of
    clxCodProduto: result:=1;
    clxNomProduto: result:=2;
    clxCodCor: result:=3;
    clxNomCor: result:=4;
    clxCodTamanho: result:=5;
    clxNomTamanho: result:=6;
    clxClassificacaoFiscal: result:=7;
    clxUm: result:=9;
    clxQtdPro: result:=10;
    ClxValUnitarioPro: result:=11;
    clxValTotalPro: result:=12;
    clxPerIcms: result:=13;
    clxPerIpi: result:=14;
    clxNumSerie: result:=15;
    clxRefFornecedor: result:=16;
  end;
end;

{ *************************************************************************** }
procedure TFXMLProdutosNotaFiscalEntrada.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
function TFXMLProdutosNotaFiscalEntrada.CarProdutosXML(VpaDNota: TRBDNotaFiscalFor): Boolean;
begin
  VprDNotaFor := VpaDNota;
  Grade.ADados := VprDNotaFor.ItensNota;
  grade.CarregaGrade;
  GXML.ADados := VprDNotaFor.ItensXML;
  GXML.CarregaGrade;
  showmodal;
end;

{******************************************************************************}
procedure TFXMLProdutosNotaFiscalEntrada.CarTitulosGrade;
begin
  grade.Cells[RColunaGrade(clCodProduto),0] := 'Código';
  grade.Cells[RColunaGrade(clNomProduto),0] := 'Produto';
  grade.Cells[RColunaGrade(clCodCor),0] := 'Cor';
  grade.Cells[RColunaGrade(clNomCor),0] := 'Descrição';
  grade.Cells[RColunaGrade(clCodTamanho),0] := 'Tamanho';
  grade.Cells[RColunaGrade(clNomTamanho),0] := 'Descrição';
  grade.Cells[RColunaGrade(clClassificacaoFiscal),0] := 'Cl Fisc.';
  grade.Cells[RColunaGrade(clCST),0] := 'CST';
  grade.Cells[RColunaGrade(clUm),0] := 'UM';
  grade.Cells[RColunaGrade(clQtdPro),0] := 'Qtd';
  grade.Cells[RColunaGrade(ClValUnitarioPro),0] := 'Valor Unitário';
  grade.Cells[RColunaGrade(clValTotalPro),0] := 'Valor Total';
  grade.Cells[RColunaGrade(clPerIcms),0] := '%ICMS';
  grade.Cells[RColunaGrade(clPerIpi),0] := '%IPI';
  grade.Cells[RColunaGrade(clNumSerie),0] := 'Número Série';
  grade.Cells[RColunaGrade(clRefFornecedor),0] := 'Ref Fornecedor';

  GXML.Cells[RColunaXMLGrade(clxCodProduto),0] := 'Código';
  GXML.Cells[RColunaXMLGrade(clxNomProduto),0] := 'Produto';
  GXML.Cells[RColunaXMLGrade(clxCodCor),0] := 'Cor';
  GXML.Cells[RColunaXMLGrade(clxNomCor),0] := 'Descrição';
  GXML.Cells[RColunaXMLGrade(clxCodTamanho),0] := 'Tamanho';
  GXML.Cells[RColunaXMLGrade(clxNomTamanho),0] := 'Descrição';
  GXML.Cells[RColunaXMLGrade(clxClassificacaoFiscal),0] := 'Cl Fisc.';
  GXML.Cells[RColunaXMLGrade(clxUm),0] := 'UM';
  GXML.Cells[RColunaXMLGrade(clxQtdPro),0] := 'Qtd';
  GXML.Cells[RColunaXMLGrade(ClxValUnitarioPro),0] := 'Valor Unitário';
  GXML.Cells[RColunaXMLGrade(clxValTotalPro),0] := 'Valor Total';
  GXML.Cells[RColunaXMLGrade(clxPerIcms),0] := '%ICMS';
  GXML.Cells[RColunaXMLGrade(clxPerIpi),0] := '%IPI';
  GXML.Cells[RColunaXMLGrade(clxNumSerie),0] := 'Número Série';
  GXML.Cells[RColunaXMLGrade(clxRefFornecedor),0] := 'Ref Fornecedor';

end;

{******************************************************************************}
procedure TFXMLProdutosNotaFiscalEntrada.ConfiguraPermissaoUsuario;
begin
  if not config.EstoquePorCor then
  begin
    Grade.ColWidths[rcolunagrade(clCodCor)] := -1;
    Grade.ColWidths[rcolunagrade(clNomCor)] := -1;
    Grade.TabStops[rcolunagrade(clCodCor)] := false;
    Grade.TabStops[rcolunagrade(clNomProduto)] := false;

    GXML.ColWidths[rcolunaXMLgrade(clxCodCor)] := -1;
    GXML.ColWidths[rcolunaXMLgrade(clxNomProduto)] := -1;
    GXML.TabStops[rcolunaXMLgrade(clxCodCor)] := false;
    GXML.TabStops[rcolunaXMLgrade(clxNomCor)] := false;
  end;
  if not config.EstoquePorTamanho then
  begin
    Grade.ColWidths[rcolunaGrade(clCodTamanho)] := -1;
    Grade.ColWidths[rcolunaGrade(clNomTamanho)] := -1;
    Grade.TabStops[rcolunaGrade(clCodTamanho)] := false;
    Grade.TabStops[rcolunaGrade(clNomTamanho)] := false;

    GXML.ColWidths[rcolunaXMLGrade(clxCodTamanho)] := -1;
    GXML.ColWidths[rcolunaXMLGrade(clxNomTamanho)] := -1;
    GXML.TabStops[rcolunaXMLGrade(clxCodTamanho)] := false;
    GXML.TabStops[rcolunaXMLGrade(clxNomTamanho)] := false;

  end;
  Grade.ColWidths[RColunaGrade(clNomProduto)] := varia.LarguraColunaProdutoConsulta;
  Grade.ColWidths[RColunaGrade(clNomCor)] := varia.LarguraColunaCorConsulta;

  GXML.ColWidths[RColunaXMLGrade(clxNomProduto)] := varia.LarguraColunaProdutoConsulta;
  GXML.ColWidths[RColunaXMLGrade(clxNomCor)] := varia.LarguraColunaCorConsulta;
end;

{******************************************************************************}
procedure TFXMLProdutosNotaFiscalEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFXMLProdutosNotaFiscalEntrada]);
end.
