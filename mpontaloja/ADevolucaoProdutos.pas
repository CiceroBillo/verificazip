unit ADevolucaoProdutos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, CGrades, StdCtrls, UnDadosProduto,
  Buttons, Localizacao, UnCotacao;

type
  TFDevolucaoProdutos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor3: TPanelColor;
    GProdutos: TRBStringGridColor;
    ConsultaPadrao1: TConsultaPadrao;
    ECotacao: TEditLocaliza;
    Label2: TLabel;
    SpeedButton3: TSpeedButton;
    Label5: TLabel;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Label1: TLabel;
    CAlterarEstagio: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure ECotacaoSelect(Sender: TObject);
    procedure ECotacaoFimConsulta(Sender: TObject);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure ECotacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprDCotacao : TRBDOrcamento;
    VprDItem : TRBDOrcProduto;
    procedure CarTitulosGrade;
    procedure CarregaOrcamento;
    procedure CarQtdDevolvida;
    procedure ZeraQtdDevolvidas;
  public
    { Public declarations }
  end;

var
  FDevolucaoProdutos: TFDevolucaoProdutos;

implementation

uses APrincipal, Constantes, ConstMsg, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDevolucaoProdutos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDevolucaoProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFDevolucaoProdutos.CarregaOrcamento;
begin
  if VprDCotacao <> nil then
    VprDCotacao.free;
  VprDCotacao := TRBDOrcamento.cria;
  if ECotacao.AInteiro <> 0 then
  begin
    VprDCotacao.CodEmpFil := varia.CodigoEmpFil;
    VprDCotacao.LanOrcamento := ECotacao.AInteiro;
    FunCotacao.CarDOrcamento(VprDCotacao);
    ZeraQtdDevolvidas;
    ActiveControl :=  GProdutos;
    GProdutos.Col := 1;
  end;
  GProdutos.ADados := VprDCotacao.Produtos;
  GProdutos.CarregaGrade;
end;

{******************************************************************************}
procedure TFDevolucaoProdutos.CarTitulosGrade;
begin
  GProdutos.Cells[1,0] := 'Qtd a Baixar';
  GProdutos.Cells[2,0] := 'Qtd Devolvida';
  GProdutos.Cells[3,0] := 'UM';
  GProdutos.Cells[4,0] := 'Qtd Cotação';
  GProdutos.Cells[5,0] := 'Código';
  GProdutos.Cells[6,0] := 'Produto';
end;

{******************************************************************************}
procedure TFDevolucaoProdutos.ZeraQtdDevolvidas;
var
  VpfLaco : Integer;
begin
  for VpfLaco := VprDCotacao.Produtos.Count - 1 downto 0 do
  begin
    if TRBDOrcProduto(VprDCotacao.Produtos.Items[VpfLaco]).IndRetornavel then
      TRBDOrcProduto(VprDCotacao.Produtos.Items[VpfLaco]).QtdPedido := 0
  end;
end;

{******************************************************************************}
procedure TFDevolucaoProdutos.CarQtdDevolvida;
var
  VpfLaco : Integer;
  VpfDItem : TRBDOrcProduto;
begin
  for VpfLaco := 0 to VprDCotacao.Produtos.Count - 1 do
  begin
    VpfDItem :=  TRBDOrcProduto(VprDCotacao.Produtos.Items[VpfLaco]);
    VpfDItem.QtdDevolvido := VpfDItem.QtdDevolvido + VpfDItem.QtdPedido; 
  end;
end;

{******************************************************************************}
procedure TFDevolucaoProdutos.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if ECotacao.AInteiro <> 0 then
  begin
    CarQtdDevolvida;
    VpfResultado :=  FunCotacao.GravaDCotacao(VprDCotacao,nil);
    if VpfResultado = '' then
      if CAlterarEstagio.Checked then
        FunCotacao.AlteraEstagioCotacao(VprDCotacao.CodEmpFil,varia.CodigoUsuario,VprDCotacao.LanOrcamento,varia.EstagioFinalOrdemProducao,'');
    if VpfResultado <> '' then
      aviso(VpfREsultado)
    else
    begin
      ECotacao.Clear;
      ECotacao.Atualiza;
      CarregaOrcamento;
      ECotacao.SetFocus;
    end;
  end;
end;

{******************************************************************************}
procedure TFDevolucaoProdutos.BCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TFDevolucaoProdutos.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItem := TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaLinha-1]);
  GProdutos.Cells[1,VpaLinha] := FormatFloat(Varia.MascaraQtd,VprDItem.QtdPedido);
  GProdutos.Cells[2,VpaLinha] := FormatFloat(Varia.MascaraQtd,VprDItem.QtdDevolvido);
  GProdutos.Cells[3,VpaLinha] := VprDItem.UMOriginal;
  GProdutos.Cells[4,VpaLinha] := FormatFloat(Varia.MascaraQtd,VprDItem.QtdProduto);
  GProdutos.Cells[5,VpaLinha] := VprDItem.CodProduto;
  GProdutos.Cells[6,VpaLinha] := VprDItem.NomProduto;
end;


{******************************************************************************}
procedure TFDevolucaoProdutos.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if VprDItem.SeqProduto <> 0 then
  begin
    if GProdutos.Cells[1,GProdutos.ALinha] <> '' then
      VprDItem.QtdPedido := StrToFloat(GProdutos.Cells[1,GProdutos.ALinha]);
    if ((VprDItem.QtdPedido + VprDItem.QtdDevolvido) > VprDItem.QtdProduto) then
    begin
      aviso('QUANTIDADE DE PRODUTOS DEVOLVIDOS INVÁLIDA!!!!'#13'Está sendo devolvida mais produtos do que foram entregues nessa cotação.');
      VpaValidos := false;
    end;
  end;
end;

{******************************************************************************}
procedure TFDevolucaoProdutos.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDCotacao.Produtos.Count > 0 then
    VprDItem := TRBDOrcProduto(VprDCotacao.Produtos.items[VpaLinhaAtual -1]);
end;

{******************************************************************************}
procedure TFDevolucaoProdutos.GProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if GProdutos.AColuna <> 1 then
    key := #0;
end;

procedure TFDevolucaoProdutos.ECotacaoSelect(Sender: TObject);
begin
  ECotacao.ASelectLocaliza.Text := 'Select CLI.C_NOM_CLI, COT.I_LAN_ORC '+
                                   ' from CADCLIENTES CLI, CADORCAMENTOS COT '+
                                   ' Where CLI.I_COD_CLI = COT.I_COD_CLI '+
                                   ' and COT.I_EMP_FIL = '+inttoStr(Varia.CodigoEmpFil)+
                                   ' and CLI.C_NOM_CLI LIKE ''@%''';
  ECotacao.ASelectValida.Text := 'Select CLI.C_NOM_CLI, COT.I_LAN_ORC '+
                                   ' from CADCLIENTES CLI, CADORCAMENTOS COT '+
                                   ' Where CLI.I_COD_CLI = COT.I_COD_CLI '+
                                   ' and COT.I_EMP_FIL = '+inttoStr(Varia.CodigoEmpFil)+
                                   ' and COT.I_LAN_ORC = @';
end;

{******************************************************************************}
procedure TFDevolucaoProdutos.ECotacaoFimConsulta(Sender: TObject);
begin
  CarregaOrcamento;
end;

{******************************************************************************}
procedure TFDevolucaoProdutos.GProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 115 then
    ActiveControl := BGravar;
end;

{******************************************************************************}
procedure TFDevolucaoProdutos.GProdutosGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  VpfDItem : TRBDOrcProduto;
begin
  if (ARow > 0) and (Acol > 0) then
  begin
    if VprDCotacao <> nil then
      if VprDCotacao.Produtos.Count >0 then
      begin
        VpfDItem := TRBDOrcProduto(VprDCotacao.Produtos.Items[arow-1]);
        if not VpfDItem.IndRetornavel then
        begin
           ABrush.Color := clgray;
        end;
      end;
  end;
end;

procedure TFDevolucaoProdutos.ECotacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = 13 )then
  begin
    ECotacao.Text := DeletaChars(ECotacao.text,'.');
    ECotacao.Atualiza;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFDevolucaoProdutos]);
end.
