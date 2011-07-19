unit AAdicionaProdutosTerceirizacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Localizacao, Buttons, Grids, CGrades, unDadosProduto, unOrdemProducao, UnDados, UnPedidoCompra;

type
  TFAdicionaProdutosTerceirizacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente2: TPainelGradiente;
    Localiza: TConsultaPadrao;
    EFilial: TRBEditLocaliza;
    Label2: TLabel;
    SFilial: TSpeedButton;
    Label3: TLabel;
    Label5: TLabel;
    SFracao: TSpeedButton;
    Label6: TLabel;
    EFracao: TEditLocaliza;
    Label1: TLabel;
    SOP: TSpeedButton;
    Label4: TLabel;
    EOrdemProducao: TEditLocaliza;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EFracaoSelect(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure EFracaoRetorno(Retorno1, Retorno2: string);
    procedure GradeCellClick(Button: TMouseButton; Shift: TShiftState; VpaColuna, VpaLinha: Integer);
  private
    { Private declarations }
    VprSeqOrdem,
    VprSeqFracao : Integer;
    VprAcao : Boolean;
    VprDBaixaConsumo : TRBDConsumoFracaoOP;
    VprDPedidoCompra : TRBDPedidoCompraCorpo;
    VprDProdutoPedido : TRBDProdutoPedidoCompra;
    VprBaixas : TList;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    FunPedidoCompra : TRBFunPedidoCompra;
    procedure CarTitulosGrade;
    procedure CarDConsumo;
    procedure AdicionaProdutoPedidoCompra;
  public
    { Public declarations }
    function AdicionaProdutos(VpaDPedidoCompra : TRBDPedidoCompraCorpo;VpaDProdutoPedido :  TRBDProdutoPedidoCompra; VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer) : boolean;
  end;

var
  FAdicionaProdutosTerceirizacao: TFAdicionaProdutosTerceirizacao;

implementation

uses APrincipal, Constantes, FunObjeto, unProdutos;

{$R *.DFM}


{ **************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTitulosGrade;
  VprBaixas:= TList.Create;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);
  FunPedidoCompra := TRBFunPedidoCompra.Cria(FPrincipal.BaseDados);
  Grade.ADados:= VprBaixas;
  Grade.CarregaGrade;
  CarTitulosGrade;
end;

{ **************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDBaixaConsumo:= TRBDConsumoFracaoOP(VprBaixas.Items[VpaLinha-1]);
  Grade.Cells[2,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDBaixaConsumo.QtdProduto);

  Grade.Cells[3,VpaLinha]:= VprDBaixaConsumo.DesUM;
  Grade.Cells[4,VpaLinha]:= VprDBaixaConsumo.CodProduto;
  Grade.Cells[5,VpaLinha]:= VprDBaixaConsumo.NomProduto;
  if VprDBaixaConsumo.CodCor <> 0 then
    Grade.Cells[6,VpaLinha]:= IntToStr(VprDBaixaConsumo.CodCor)
  else
    Grade.Cells[6,VpaLinha]:= '';
  Grade.Cells[7,VpaLinha]:= VprDBaixaConsumo.NomCor;
  if VprDBaixaConsumo.LarMolde <> 0 then
    if config.ConverterMTeCMparaMM then
      Grade.Cells[8,VpaLinha]:= FormatFloat('#,##0.00', VprDBaixaConsumo.LarMolde*10)
    else
      Grade.Cells[8,VpaLinha]:= FormatFloat('#,##0.00', VprDBaixaConsumo.LarMolde);
  if VprDBaixaConsumo.AltMolde <> 0 then
    if config.ConverterMTeCMparaMM then
      Grade.Cells[9,VpaLinha]:= FormatFloat('#,##0.00', VprDBaixaConsumo.AltMolde*10)
    else
      Grade.Cells[8,VpaLinha]:= FormatFloat('#,##0.00', VprDBaixaConsumo.LarMolde);
end;

{ **************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.GradeCellClick(Button: TMouseButton; Shift: TShiftState; VpaColuna,
  VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VpaColuna = 1) then
  begin
    if (Grade.Cells[1,VpaLinha] = '0')or (Grade.Cells[1,VpaLinha] = '') then
    begin
      Grade.Cells[1,VpaLinha] := '1';
    end
    else
    begin
      Grade.Cells[1,VpaLinha] := '0';
    end;
  end;
end;

{ *************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.AdicionaProdutoPedidoCompra;
var
  VpfLacoGrade : Integer;
  VpfDConsumo : TRBDConsumoFracaoOP;
  VpfDMateriaPrima : TRBDProdutoPedidoCompraMateriaPrima;
  VpfLarChapa, VpfComChapa : Double;
begin
  //tem que carregar corretamente os dados do produto, chamar a rotina de existe produto;
  for VpfLacoGrade:= 1 to Grade.RowCount-1 do
  begin
//    if Grade.Cells[VpflacoGrade,1] = '1' then
//adiciona todos as materia prima
    begin
      VpfDConsumo := TRBDConsumoFracaoOP(VprBaixas.Items[VpfLacoGrade-1]);
      if config.ConverterMTeCMparaMM then
      begin
        VpfLarChapa := VpfDConsumo.AltMolde*10;
        VpfComChapa := VpfDConsumo.LarMolde*10;
      end
      else
      begin
        VpfLarChapa := VpfDConsumo.AltMolde;
        VpfComChapa := VpfDConsumo.LarMolde;
      end;

      VpfDMateriaPrima := FunPedidoCompra.RMateriaPrimaProduto(VprDProdutoPedido,VpfDConsumo.SeqProduto,VpfDConsumo.CodCor,VpfDConsumo.AltMolde,VpfDConsumo.LarMolde);
      if VpfDMateriaPrima = nil then
      begin
        VpfDMateriaPrima := VprDProdutoPedido.AddMateriaPrima;
        VpfDMateriaPrima.SeqProduto := VpfDConsumo.SeqProduto;
        VpfDMateriaPrima.CodCor := VpfDConsumo.CodCor;
        VpfDMateriaPrima.CodProduto :=  VpfDConsumo.CodProduto;
        VpfDMateriaPrima.NomProduto := VpfDConsumo.NomProduto;
        VpfDMateriaPrima.NomCor := VpfDConsumo.NomCor;
        VpfDMateriaPrima.QtdProduto := 0;
        VpfDMateriaPrima.LarChapa := VpfLarChapa;
        VpfDMateriaPrima.ComChapa :=  VpfComChapa;
      end;
      if VpfDConsumo.AltMolde <> 0 then
      begin
        VpfDMateriaPrima.QtdProduto := VpfDMateriaPrima.QtdProduto + VpfDConsumo.PesProduto;
        VpfDMateriaPrima.QtdChapa := VpfDMateriaPrima.QtdChapa + 1;
      end;
    end;
  end;
end;

{ *************************************************************************** }
function TFAdicionaProdutosTerceirizacao.AdicionaProdutos(VpaDPedidoCompra: TRBDPedidoCompraCorpo;VpaDProdutoPedido :  TRBDProdutoPedidoCompra;VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer): boolean;
begin
  VprDPedidoCompra := VpaDPedidoCompra;
  VprDProdutoPedido := VpaDProdutoPedido;
  EFilial.AInteiro := VpaCodFilial;
  EOrdemProducao.AInteiro := VpaSeqOrdem;
  EFracao.AInteiro := VpaSeqFracao;
  EFracao.Atualiza;
  BGravar.Click;
  result := true;
end;

{ *************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{ *************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.BGravarClick(Sender: TObject);
begin
  AdicionaProdutoPedidoCompra;
  VprAcao := true;
  close;
end;

{ *************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.CarDConsumo;
begin
  if EFracao.AInteiro <> 0 then
  begin
    VprSeqOrdem := EOrdemProducao.AInteiro;
    VprSeqFracao := EFracao.AInteiro;
    FunProdutos.CarDBaixaConsumoProduto(EFilial.AInteiro, EOrdemProducao.AInteiro, EFracao.AInteiro,false, VprBaixas);
    Grade.CarregaGrade;
  end;
end;

{ *************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.CarTitulosGrade;
begin
  Grade.Cells[2,0]:= 'Quantidade';
  Grade.Cells[3,0]:= 'UM';
  Grade.Cells[4,0]:= 'Código';
  Grade.Cells[5,0]:= 'Produto';
  Grade.Cells[6,0]:= 'Código';
  Grade.Cells[7,0]:= 'Cor';
  Grade.Cells[8,0]:= 'Largura';
  Grade.Cells[9,0]:= 'Comprimento';
end;

{ *************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.EFracaoRetorno(Retorno1, Retorno2: string);
begin
    CarDConsumo;
end;

procedure TFAdicionaProdutosTerceirizacao.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO LIKE ''@%'''+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

{ *************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.EOrdemProducaoSelect(Sender: TObject);
begin
  EOrdemProducao.ASelectLocaliza.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND CLI.C_NOM_CLI like ''@%''';
  EOrdemProducao.ASelectValida.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI From ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND ORD.SEQORD = @';
end;

{ *************************************************************************** }
procedure TFAdicionaProdutosTerceirizacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprBaixas);
  VprBaixas.Free;
  FunOrdemProducao.free;
  FunPedidoCompra.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAdicionaProdutosTerceirizacao]);
end.
