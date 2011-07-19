unit AConsultaCondicaoPgto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Componentes1, ExtCtrls, PainelGradiente, StdCtrls,
  Localizacao, UnDadosLOcaliza, Buttons, Mask, numericos, unDadosProduto, Parcela,
  DBKeyViolation;

type
  TFConsultaCondicaoPgto = class(TForm)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridCondicao: TStringGrid;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    ECondicaoPagamento: TRBEditLocaliza;
    Label2: TLabel;
    Label3: TLabel;
    ETotalCondicao: Tnumerico;
    Label4: TLabel;
    ECodFormaPagamento: TRBEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    EValorCalcularComissao: Tnumerico;
    Label7: TLabel;
    EVendedor: TRBEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label8: TLabel;
    PanelColor3: TPanelColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    CriaParcelas: TCriaParcelasReceber;
    EPercComissaoVen: Tnumerico;
    Label9: TLabel;
    ValidaGravacao1: TValidaGravacao;
    PanelColor4: TPanelColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOkClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure ECondicaoPagamentoFimConsulta(Sender: TObject);
    procedure ETotalCondicaoChange(Sender: TObject);
    procedure EVendedorRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ECondicaoPagamentoChange(Sender: TObject);
    procedure ECondicaoPagamentoCadastrar(Sender: TObject);
  private
    { Private declarations }
    ValorTotalParcelas : Double;
    VprUsarCartao,VprAcao : Boolean;
    VprDNota : TRBDNotaFiscal;
    procedure LimpaGridParcelas;
    procedure GeraParcelas;
    procedure CarregaParcelas(Datas,Valores : TStringList);
    procedure CarDTela;
    procedure CarDClasse;
  public
    { Public declarations }
    function VisualizaParcelas(Valor:double;var condicao : Integer; UsarCartao : Boolean) : Double;
    function VisualizaParcelasFrmVendedor(Valor:double; var condicao,FormaPgto,CodVendedor : Integer; var PercCom, PercServico, ValorCalcularComissao  : Double; var nome : string; UsarCartao : Boolean) : Double;
    function VisualizaParcelasNota(VpaDNota : TRBDNotaFiscal) : Boolean;

  end;

var
  FConsultaCondicaoPgto: TFConsultaCondicaoPgto;

implementation

uses APrincipal, funObjeto, ACondicaoPagamento;

{$R *.dfm}
{********************Carrega o titulo do grid das parcelas*********************}
procedure TFConsultaCondicaoPgto.LimpaGridParcelas;
begin
   GridCondicao.RowCount := 2;
   GridCondicao.Color := ETotalCondicao.Color;
   GridCondicao.Cells[0,0] := 'Parcela';
   GridCondicao.Cells[1,0] := 'Vencimento';
   GridCondicao.Cells[2,0] := 'Valor';

   GridCondicao.Cells[0,1] := '';
   GridCondicao.Cells[1,1] := '';
   GridCondicao.Cells[2,1] := '';
end;

{************************Gera as parcelas da condição**************************}
procedure TFConsultaCondicaoPgto.GeraParcelas;
begin
   if ECondicaoPagamento.Text = '' then
   begin
      LimpaGridParcelas;
      ETotalCondicao.AValor := ValorTotalParcelas;
   end
   else
   begin
     CriaParcelas.Parcelas(VprDNota.ValTotal,ECondicaoPagamento.AInteiro,true, date);
     CarregaParcelas(CriaParcelas.TextoVencimentos,CriaParcelas.TextoParcelas);
     VprDNota.PerDesconto := CriaParcelas.PerDesconto;
   end;
end;

{************************Carrega as parcelas no GridCondiçoes******************}
procedure TFConsultaCondicaoPgto.CarregaParcelas(Datas,Valores : TStringList);
var
  VpfLaco:integer;
begin

   GridCondicao.RowCount := Datas.Count + 1;
   for VpfLaco := 1 to GridCondicao.RowCount - 1 do
   begin
      GridCondicao.Cells[0,VpfLaco] := inttoStr(VpfLaco);
      GridCondicao.Cells[1,VpfLaco] := Datas.Strings[VpfLaco - 1];
      GridCondicao.Cells[2,VpfLaco] := Valores.Strings[VpfLaco-1];
   end;
   ETotalCondicao.AValor := CriaParcelas.ValorTotal;
end;

{*******************Visualiza as parcelas da condição**************************}
procedure TFConsultaCondicaoPgto.ECondicaoPagamentoCadastrar(Sender: TObject);
begin
  FCondicaoPagamento := tFCondicaoPagamento.CriarSDI(self,'',true);
  FCondicaoPagamento.ShowModal;
  FCondicaoPagamento.free;
end;

{*******************Visualiza as parcelas da condição**************************}
procedure TFConsultaCondicaoPgto.ECondicaoPagamentoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

procedure TFConsultaCondicaoPgto.ECondicaoPagamentoFimConsulta(Sender: TObject);
begin
   GeraParcelas;
end;

{*******************Visualiza as parcelas da condição**************************}
procedure TFConsultaCondicaoPgto.ETotalCondicaoChange(Sender: TObject);
begin
  EValorCalcularComissao.AValor := ETotalCondicao.AValor;
end;

procedure TFConsultaCondicaoPgto.EVendedorRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if (VpaColunas.items[2].AValorRetorno <> '') and (VprDNota.PerComissao = 0) then
    EPercComissaoVen.AValor := StrToFloat(VpaColunas.items[2].AValorRetorno);
end;

{*******************Visualiza as parcelas da condição**************************}
procedure TFConsultaCondicaoPgto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action := CaFree;
end;

{*******************Visualiza as parcelas da condição**************************}
procedure TFConsultaCondicaoPgto.FormCreate(Sender: TObject);
begin
   VprUsarCartao := false;
   LimpaGridParcelas;
end;

{*******************Visualiza as parcelas da condição**************************}
function TFConsultaCondicaoPgto.VisualizaParcelas(Valor:double;var Condicao : Integer; UsarCartao : Boolean) : Double;
begin
  VprDNota := TRBDNotaFiscal.cria;
  VprDNota.ValTotal := Valor;
  VprDNota.CodCondicaoPagamento := condicao;
  VprUsarCartao := UsarCartao;
  ValorTotalParcelas := Valor;
  if condicao = 0 then
     ECondicaoPagamento.Text := ''
  else
     ECondicaoPagamento.text:=intToStr(condicao);

  GeraParcelas;
  ECondicaoPagamento.Atualiza;
  showModal;

  if (ECondicaoPagamento.text = '') or ( not VprAcao ) Then
  begin
     Condicao := 0;
     result := 0;
  end
  else
  begin
     result := ETotalCondicao.AValor;
     condicao := StrToInt(ECondicaoPagamento.text);
 end;
 VprDNota.free;
end;

{******************************************************************************}
procedure TFConsultaCondicaoPgto.CarDTela;
begin
  with VprDnota do
  begin
    ECondicaoPagamento.AInteiro := CodCondicaoPagamento;
    ECodFormaPagamento.ainteiro := CodFormaPagamento;
    EVendedor.Ainteiro := codvendedor;
    EPercComissaoVen.AValor := PerComissao;
  end;
  AtualizaLocalizas([ECodFormaPagamento,ECondicaoPagamento,EVendedor]);
  GeraParcelas;
end;

{******************************************************************************}
procedure TFConsultaCondicaoPgto.BCancelarClick(Sender: TObject);
begin
   VprAcao := false;
   Close;
end;

{******************************************************************************}
procedure TFConsultaCondicaoPgto.BOkClick(Sender: TObject);
begin
   VprAcao := true;
   if EPercComissaoVen.AValor = 0 then
     EVendedor.Atualiza;
   Close;
end;

{*************** visualiza parcelas mais condicoes ************************** }
procedure TFConsultaCondicaoPgto.CarDClasse;
begin
  with VprDnota do
  begin
    CodCondicaoPagamento := ECondicaoPagamento.AInteiro;
    CodFormaPagamento := ECodFormaPagamento.ainteiro;
    codvendedor := EVendedor.Ainteiro;
    PerComissao := EPercComissaoVen.AValor;
  end;
end;

{*************** visualiza parcelas mais condicoes ************************** }
function TFConsultaCondicaoPgto.VisualizaParcelasFrmVendedor(Valor:double; var condicao,FormaPgto,CodVendedor : Integer; var PercCom, PercServico, ValorCalcularComissao  : Double; var nome : string; UsarCartao : Boolean) : Double;
begin
  VprUsarCartao := UsarCartao;

  BOk.Enabled := false;

  if FormaPgto <> 0 then
  begin
    ECodFormaPagamento.Text := IntToStr(FormaPgto);
    ECodFormaPagamento.Atualiza;
  end;

  if CodVendedor <> 0 then
  begin
    EVendedor.text := IntTostr(CodVendedor);
    EVendedor.Atualiza;
    EPercComissaoVen.AValor := PercCom;
  end;

  result := VisualizaParcelas( Valor,condicao, UsarCartao);
  if ECodFormaPagamento.text <> '' then
  begin
    FormaPgto := StrToInt(ECodFormaPagamento.text);
    nome := Label1.caption;
  end
  else
  begin
    FormaPgto := 0;
  end;

  if EVendedor.text <> '' then
  begin
    CodVendedor := StrToInt(EVendedor.text);
    PercCom := EPercComissaoVen.AValor;
  end
  else
  begin
    CodVendedor := 0;
    PercCom := 0;
  end;
end;

{******************************************************************************}
function TFConsultaCondicaoPgto.VisualizaParcelasNota(VpaDNota : TRBDNotaFiscal) : Boolean;
begin
  VprDNota := VpaDNota;
  CarDTela;
  Showmodal;
  result := VprAcao;
  if VprAcao then
    CarDClasse;
end;


end.
