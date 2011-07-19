unit AGeraFracaoOPProdutos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente,
  UnDadosProduto, StdCtrls, Buttons, UnOrdemProducao;

type
  TFGeraFracaoOPProdutos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    PainelTempo1: TPainelTempo;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    Label3: TLabel;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure BGravarClick(Sender: TObject);
    procedure GradeGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
  private
    { Private declarations }
    VprDProdutoOP :TRBDOrdemProducaoProduto;
    VprDOrdemProducao : TRBDOrdemProducao;
    VprAcao : Boolean;
    procedure CarTitulosGrade;
  public
    { Public declarations }
    function GeraOP(VpaDOrdemProducao : TRBDOrdemProducao) : Boolean;
  end;

var
  FGeraFracaoOPProdutos: TFGeraFracaoOPProdutos;

implementation

uses APrincipal, Constantes, constmsg, AGeraFracaoOP, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGeraFracaoOPProdutos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTitulosGrade;
end;

{ **************************************************************************** }
function TFGeraFracaoOPProdutos.GeraOP(VpaDOrdemProducao: TRBDOrdemProducao): Boolean;
begin
  PainelTempo1.execute('Agrupando produtos. Aguarde.');
  FunOrdemProducao.AgrupaProdutosFracoesOPSubMontagem(VpaDOrdemProducao);
  VprDOrdemProducao := VpaDOrdemProducao;
  Grade.ADados := VpaDOrdemProducao.ProdutosSubmontagemAgrupados;
  Grade.CarregaGrade;
  PainelTempo1.fecha;
  showmodal;
end;

{ **************************************************************************** }
procedure TFGeraFracaoOPProdutos.GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDProdutoOP := TRBDOrdemProducaoProduto(VprDOrdemProducao.ProdutosSubmontagemAgrupados.Items[VpaLinha-1]);
  Grade.Cells[1,VpaLinha] := VprDProdutoOP.DProduto.CodProduto;
  Grade.Cells[2,VpaLinha] := VprDProdutoOP.DProduto.NomProduto;
  if (VprDProdutoOP.CodCor <> 0 ) then
    Grade.Cells[3,VpaLinha] := IntToStr(VprDProdutoOP.CodCor)
  else
    Grade.Cells[3,VpaLinha] := '';
  Grade.Cells[4,VpaLinha] := VprDProdutoOP.NomCor;
  if (VprDProdutoOP.CodTamanho <> 0 ) then
    Grade.Cells[5,VpaLinha] := IntToStr(VprDProdutoOP.CodTamanho)
  else
    Grade.Cells[5,VpaLinha] := '';
  Grade.Cells[6,VpaLinha] := VprDProdutoOP.NomTamanho;
  Grade.Cells[7,VpaLinha] := VprDProdutoOP.DesUM;
  Grade.Cells[8,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProdutoOP.QtdaProduzir);
  Grade.Cells[9,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProdutoOP.QtdOp);
  Grade.Cells[10,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProdutoOP.DProduto.QtdRealEstoque);
  Grade.Cells[11,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProdutoOP.DProduto.QtdEstoque);
  Grade.Cells[12,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProdutoOP.DProduto.QtdReservado);
  Grade.Cells[13,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProdutoOP.DProduto.QtdAReservar);
  Grade.Cells[14,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProdutoOP.DProduto.QtdMinima);
  Grade.Cells[15,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProdutoOP.DProduto.QtdPedido);
  Grade.Cells[16,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProdutoOP.QtdemProcesso);
  Grade.Cells[17,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDProdutoOP.QtdemProcessoSerie);
end;

{ **************************************************************************** }
procedure TFGeraFracaoOPProdutos.GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if (Grade.Cells[8,Grade.ALinha] = '') then
  begin
    VpaValidos := false;
    aviso('QUANTIDADE A PRODUZIR INVALIDA!!!'#13'É necessário informar a quantidade a produzir.');
    Grade.Col := 8;
  end;
  if VpaValidos then
  begin
    VprDProdutoOP.QtdaProduzir := StrToFloat(DeletaChars(Grade.Cells[8,Grade.ALinha],'.'));
    if VprDProdutoOP.QtdaProduzir < 0 then
    begin
      VpaValidos := false;
      aviso('QUANTIDADE A PRODUZIR INVALIDA!!!'#13'A quantidade a produzir não pode ser menor que zero.');
      VprDProdutoOP.QtdaProduzir := VprDProdutoOP.QtdOp;
      Grade.Col := 8;
    end;
    if VpaValidos then
    begin
      if VprDProdutoOP.QtdaProduzir < VprDProdutoOP.QtdOp then
      begin
        if ((VprDProdutoOP.QtdOp - VprDProdutoOP.QtdaProduzir) > VprDProdutoOP.DProduto.QtdRealEstoque) then
        begin
          VpaValidos := false;
          aviso('QUANTIDADE A PRODUZIR INVALIDA!!!'#13'Não é possivel diminuir a quantidade a produzir pois não existe quantidade em estoque disponivel.');
          VprDProdutoOP.QtdaProduzir := VprDProdutoOP.QtdOp;
          Grade.Col := 8;
        end;
      end;
    end;
  end;
end;

{ **************************************************************************** }
procedure TFGeraFracaoOPProdutos.GradeGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  VpfDProdutoOP : TRBDOrdemProducaoProduto;
begin
  if (ARow > 0) and (Acol > 0) then
  begin
    if VprDOrdemProducao.ProdutosSubmontagemAgrupados.Count >0 then
    begin
      VpfDProdutoOP := TRBDOrdemProducaoProduto(VprDOrdemProducao.ProdutosSubmontagemAgrupados.Items[arow-1]);
      if (VpfDProdutoOP.QtdaProduzir > VpfDProdutoOP.QtdOp) then
        ABrush.Color := $008080FF
      else
        if (VpfDProdutoOP.QtdaProduzir  = 0) then
          ABrush.Color := $0080FF80
        else
          if (VpfDProdutoOP.QtdaProduzir < VpfDProdutoOP.QtdOp) then
            ABrush.Color := $0080FFFF;
    end;
  end;
end;

{ **************************************************************************** }
procedure TFGeraFracaoOPProdutos.GradeMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDOrdemProducao.ProdutosSubmontagemAgrupados.Count >0 then
  begin
    VprDProdutoOP := TRBDOrdemProducaoProduto(VprDOrdemProducao.ProdutosSubmontagemAgrupados.Items[VpaLinhaAtual-1]);  end;
end;

{ **************************************************************************** }
procedure TFGeraFracaoOPProdutos.BCancelarClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFGeraFracaoOPProdutos.BGravarClick(Sender: TObject);
begin
  FunOrdemProducao.MarcaFracoesQuePossuemEstoque(VprDOrdemProducao);
  FGeraFracaoOP := TFGeraFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGeraFracaoOP'));

  if  FGeraFracaoOP.GeraFracaoOP(VprDOrdemProducao) then
  begin
    VprAcao := true;
    close;
  end;
  FGeraFracaoOP.free;
end;

{ **************************************************************************** }
procedure TFGeraFracaoOPProdutos.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Produto';
  Grade.Cells[3,0] := 'Código';
  Grade.Cells[4,0] := 'Cor';
  Grade.Cells[5,0] := 'Código';
  Grade.Cells[6,0] := 'Tamanho';
  Grade.Cells[7,0] := 'UM';
  Grade.Cells[8,0] := 'Qtd Produzir';
  Grade.Cells[9,0] := 'Qtd OP';
  Grade.Cells[10,0] := 'Qtd Disponível';
  Grade.Cells[11,0] := 'Qtd Estoque';
  Grade.Cells[12,0] := 'Qtd Reservado';
  Grade.Cells[13,0] := 'Qtd A Reservar';
  Grade.Cells[14,0] := 'Qtd Mínimo';
  Grade.Cells[15,0] := 'Qtd Ideal';
  Grade.Cells[16,0] := 'Qtd em Processo';
  Grade.Cells[17,0] := 'Qtd Série';
  if not Config.EstoquePorCor then
  begin
    Grade.ColWidths[3] := -1;
    Grade.ColWidths[4] := -1;
  end;
  if not Config.EstoquePorTamanho then
  begin
    Grade.ColWidths[5] := -1;
    Grade.ColWidths[6] := -1;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGeraFracaoOPProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFGeraFracaoOPProdutos]);
end.
