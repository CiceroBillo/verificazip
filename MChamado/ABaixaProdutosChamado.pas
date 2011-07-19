unit ABaixaProdutosChamado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, ExtCtrls, PainelGradiente, Grids, CGrades, UnDados,
  Buttons, Localizacao, unDadosProduto, UnProdutos, UnChamado,
  DBKeyViolation;

type
  TFBaixaProdutosChamado = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    GProdutosChamado: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    Label8: TLabel;
    SpeedButton3: TSpeedButton;
    LNomTecnico: TLabel;
    ETecnico: TEditLocaliza;
    Bevel1: TBevel;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    LNomProduto: TLabel;
    EProduto: TEditLocaliza;
    GProdutosExtras: TRBStringGridColor;
    ValidaGravacao1: TValidaGravacao;
    ECodProduto: TEditColor;
    Label20: TLabel;
    SpeedButton1: TSpeedButton;
    Label21: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure GProdutosChamadoCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosExtrasCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure BGravarClick(Sender: TObject);
    procedure ETecnicoChange(Sender: TObject);
    procedure GProdutosExtrasDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosChamadoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosChamadoDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosExtrasMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure ECodProdutoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    VprRetorno,
    VprAcao : Boolean;
    VprDChamado : TRBDChamado;
    VprDParcial : TRBDChamadoParcial;
    VprDProdutoChamado : TRBDChamadoProduto;
    VprDProdutoExtra : TRBDChamadoProdutoExtra;
    FunChamado : TRBFuncoesChamado;
    procedure ConfiguraTela;
    procedure CarTitulosGrade;
    procedure AdicionaProduto(VpaSeqProduto : Integer);
    procedure RetornaProduto(VpaSeqProduto : Integer);
    function AdicionaProdutoExtra(VpaSeqProduto : Integer;VpaInserirProduto : Boolean) : Boolean;
    procedure InicializaTela;
    procedure CarDClasse;
  public
    { Public declarations }
    function BaixaProdutoChamado(VpaDChamado : TRBDChamado):boolean;
    function RetornoProdutos(VpaDChamado : TRBDChamado) : Boolean;
  end;

var
  FBaixaProdutosChamado: TFBaixaProdutosChamado;

implementation

uses APrincipal, Constantes, ConstMsg, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaProdutosChamado.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprRetorno := false;
  CarTitulosGrade;
  VprDParcial := TRBDChamadoParcial.cria;
  FunChamado := TRBFuncoesChamado.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBaixaProdutosChamado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunChamado.free;
  VprDParcial.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFBaixaProdutosChamado.ConfiguraTela;
begin
  if VprRetorno then
  begin
    PainelGradiente1.Caption := '   Retorno Produtos   ';
    Caption := 'Retorno Produtos';
  end;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.CarTitulosGrade;
begin
  if VprRetorno then
    GProdutosChamado.Cells[1,0] := 'Qtd Retornado'
  else
    GProdutosChamado.Cells[1,0] := 'Qtd Baixar';
  GProdutosChamado.Cells[2,0] := 'Qtd Chamado';
  GProdutosChamado.Cells[3,0] := 'Qtd Baixado';
  GProdutosChamado.Cells[4,0] := 'UM';
  GProdutosChamado.Cells[5,0] := 'Seq Interno';
  GProdutosChamado.Cells[6,0] := 'Produto';
  if VprRetorno then
    GProdutosExtras.Cells[1,0] := 'Qtd Retornado'
  else
    GProdutosExtras.Cells[1,0] := 'Qtd Baixar';
  GProdutosExtras.Cells[2,0] := 'Qtd Baixado';
  GProdutosExtras.Cells[3,0] := 'UM';
  GProdutosExtras.Cells[4,0] := 'Seq Interno';
  GProdutosExtras.Cells[5,0] := 'Produto';
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.AdicionaProduto(VpaSeqProduto : Integer);
var
  VpfLaco, VpfLinha : Integer;
  VpfDProChamado : TRBDChamadoProduto;
  VpfLocalizouProduto : Boolean;
begin
  VpfLocalizouProduto := false;
  VpfDProChamado := nil;
  for VpfLaco := 0 to VprDChamado.Produtos.Count - 1 do
  begin
    if TRBDChamadoProduto(VprDChamado.Produtos.Items[VpfLaco]).SeqProduto = VpaSeqProduto then
    begin
      VpfDProChamado := TRBDChamadoProduto(VprDChamado.Produtos.Items[VpfLaco]);
      VpfLinha := VpfLaco + 1;
      if VpfDProChamado.QtdABaixar < (VpfDProChamado.QtdProduto - VpfDProChamado.QtdBaixado) then
      begin
        VpfDProChamado.QtdABaixar := VpfDProChamado.QtdABaixar + 1;
        VpfLocalizouProduto := true;
        break;
      end;
    end;
  end;

  if VpfLocalizouProduto then
  begin
    GProdutosChamado.CarregaGrade;
    GProdutosChamado.Row := VpfLinha;
  end
  else
    AdicionaProdutoExtra(VpaSeqProduto,true);
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.RetornaProduto(VpaSeqProduto : Integer);
var
  VpfLaco, VpfLinha : Integer;
  VpfDProChamado : TRBDChamadoProduto;
  VpfLocalizouProduto : Boolean;
begin
  if not AdicionaProdutoExtra(VpaSeqProduto,false) then
  begin
    VpfLocalizouProduto := false;
    VpfDProChamado := nil;
    for VpfLaco := 0 to VprDChamado.Produtos.Count - 1 do
    begin
      if TRBDChamadoProduto(VprDChamado.Produtos.Items[VpfLaco]).SeqProduto = VpaSeqProduto then
      begin
        VpfDProChamado := TRBDChamadoProduto(VprDChamado.Produtos.Items[VpfLaco]);
        VpfLinha := VpfLaco + 1;
        if VpfDProChamado.QtdABaixar < VpfDProChamado.QtdBaixado then
        begin
          VpfDProChamado.QtdABaixar := VpfDProChamado.QtdABaixar + 1;
          VpfLocalizouProduto := true;
          break;
        end;
      end;
    end;
    if VpfLocalizouProduto then
    begin
      GProdutosChamado.CarregaGrade;
      GProdutosChamado.Row := VpfLinha;
    end
    else
      aviso('PRODUTO INVÁLIDO!!!'#13'Não é possível retornar esse produto porque ele não foi enviado para esse cliente');

  end;
end;


{******************************************************************************}
function TFBaixaProdutosChamado.AdicionaProdutoExtra(VpaSeqProduto : Integer;VpaInserirProduto : Boolean):Boolean;
var
  VpfLaco, VpfLinha : Integer;
  VpfDProdutoExtra : TRBDChamadoProdutoExtra;
  VpfDProduto : TRBDProduto;
begin
  result := false;
  VpfDProdutoExtra := nil;
  for VpfLaco := 0 to VprDChamado.ProdutosExtras.Count - 1 do
  begin
    if (TRBDChamadoProdutoExtra(VprDChamado.ProdutosExtras.Items[VpfLaco]).SeqProduto = VpaSeqProduto)and
       not(TRBDChamadoProdutoExtra(VprDChamado.ProdutosExtras.Items[VpfLaco]).IndFaturado) then
    begin
      VpfDProdutoExtra := TRBDChamadoProdutoExtra(VprDChamado.ProdutosExtras.Items[VpfLaco]);
      if VprRetorno then
      begin
        if VpfDProdutoExtra.QtdProduto >= VpfDProdutoExtra.QtdBaixado then
          break;
      end;
      VpfDProdutoExtra.QtdProduto := VpfDProdutoExtra.QtdProduto +1;
      VpfLinha := VpfLaco + 1;
      result := true;
    end;
  end;

  if result then
  begin
    GProdutosExtras.CarregaGrade;
    GProdutosExtras.Row := VpfLinha;
  end
  else
  begin
    if VpaInserirProduto then
    begin
      VpfDProdutoExtra := VprDChamado.AddProdutoExtra;
      VpfDProduto := TRBDProduto.Cria;
      FunProdutos.CarDProduto(VpfDProduto,Varia.CodigoEmpresa,Varia.CodigoEmpFil,VpaSeqProduto);
      VpfDProdutoExtra.SeqProduto :=VpfDProduto.SeqProduto;
      VpfDProdutoExtra.CodProduto :=VpfDProduto.CodProduto;
      VpfDProdutoExtra.NomProduto :=VpfDProduto.NomProduto;
      VpfDProdutoExtra.UM :=VpfDProduto.CodUnidade;
      VpfDProdutoExtra.UMOriginal :=VpfDProduto.CodUnidade;
      VpfDProdutoExtra.QtdProduto :=1;
      GProdutosExtras.CarregaGrade;
      GProdutosExtras.Row := VprDChamado.ProdutosExtras.Count;
    end;
  end;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.InicializaTela;
begin
  VprDParcial.free;
  VprDParcial := TRBDChamadoParcial.cria;
  VprDParcial.CodFilial := VprDChamado.CodFilial;
  VprDParcial.NumChamado := VprDChamado.NumChamado;
  VprDParcial.CodUsuario := varia.CodigoUsuario;
  VprDParcial.DatParcial := now;
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.CarDClasse;
begin
  VprDParcial.CodTecnico := ETecnico.AInteiro;
  VprDParcial.IndRetorno := VprRetorno;
end;

{******************************************************************************}
function TFBaixaProdutosChamado.BaixaProdutoChamado(VpaDChamado : TRBDChamado):boolean;
begin
  VprDChamado := VpaDChamado;
  InicializaTela;
  GProdutosChamado.ADados := VpaDChamado.Produtos;
  GProdutosChamado.CarregaGrade;
  GProdutosExtras.ADados := VpaDChamado.ProdutosExtras;
  GProdutosExtras.CarregaGrade;
  ShowModal;
end;

{******************************************************************************}
function TFBaixaProdutosChamado.RetornoProdutos(VpaDChamado : TRBDChamado) : Boolean;
begin
  VprRetorno := true;
  VprDChamado := VpaDChamado;
  ConfiguraTela;
  CarTitulosGrade;
  InicializaTela;
  GProdutosChamado.ADados := VpaDChamado.Produtos;
  GProdutosChamado.CarregaGrade;
  GProdutosExtras.ADados := VpaDChamado.ProdutosExtras;
  GProdutosExtras.CarregaGrade;
  ShowModal;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.GProdutosChamadoCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDProdutoChamado := TRBDChamadoProduto(VprDChamado.Produtos.Items[VpaLinha-1]);
  GProdutosChamado.Cells[1,VpaLinha] := FormatFloat(varia.MascaraValor,VprDProdutoChamado.QtdABaixar);
  GProdutosChamado.Cells[2,VpaLinha] := FormatFloat(varia.MascaraValor,VprDProdutoChamado.QtdProduto);
  GProdutosChamado.Cells[3,VpaLinha] := FormatFloat(varia.MascaraValor,VprDProdutoChamado.QtdBaixado);
  GProdutosChamado.Cells[4,VpaLinha] := VprDProdutoChamado.DesUM;
  GProdutosChamado.Cells[5,VpaLinha] := IntToStr(VprDProdutoChamado.SeqProduto);
  GProdutosChamado.Cells[6,VpaLinha] := VprDProdutoChamado.NomProduto;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.ECodProdutoKeyPress(Sender: TObject;
  var Key: Char);
var
  VpfSeqProduto : Integer;
  VpfNomProduto : String;
begin
  if ECodProduto.Text <> '' then
  begin
    if key = #13 then
    begin
      if FunProdutos.ExisteProduto(ECodProduto.Text,VpfSeqProduto,VpfNomProduto) then
      begin
        if VprRetorno then
          RetornaProduto(VpfSeqProduto)
        else
          AdicionaProduto(VpfSeqProduto);
        ECodProduto.Clear
      end
      else
        aviso('PRODUTO NÃO ENCONTRADO!!!'#13'O produto digitado não existe cadastrado.');
    end;
  end;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.EProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  VpfCodProduto, VpfNomProduto : String;
begin
  if EProduto.AInteiro <> 0 then
    if key = 13 then
    begin
      if not FunProdutos.ExisteProduto(EProduto.AInteiro,VpfCodProduto,VpfNomProduto) then
        if not EProduto.AAbreLocalizacao then
        begin
          EProduto.SelectAll;
          exit;
        end;
      EProduto.Atualiza;
      if VprRetorno then
        RetornaProduto(EProduto.AInteiro)
      else
        AdicionaProduto(EProduto.AInteiro);
      EProduto.clear;
    end;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.GProdutosExtrasCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDProdutoExtra := TRBDChamadoProdutoExtra(VprDChamado.ProdutosExtras.Items[VpaLinha-1]);
  GProdutosExtras.Cells[1,VpaLinha] := FormatFloat(varia.MascaraValor,VprDProdutoExtra.QtdProduto);
  GProdutosExtras.Cells[2,VpaLinha] := FormatFloat(varia.MascaraValor,VprDProdutoExtra.QtdBaixado);
  GProdutosExtras.Cells[3,VpaLinha] := VprDProdutoExtra.UM;
  GProdutosExtras.Cells[4,VpaLinha] := IntToStr(VprDProdutoExtra.SeqProduto);
  GProdutosExtras.Cells[5,VpaLinha] := VprDProdutoExtra.NomProduto;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CarDClasse;
  VpfResultado := FunChamado.GravaDChamadoParcial(VprDChamado,VprDParcial);
  if VpfResultado = '' then
  begin
    VprAcao := true;
    close;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.ETecnicoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.GProdutosExtrasDadosValidos(
  Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if VprDProdutoExtra <> nil then
  begin
    if GProdutosExtras.Cells[1,GProdutosExtras.ALinha] <> '' then
      VprDProdutoExtra.QtdProduto := StrToFloat(DeletaChars(GProdutosExtras.Cells[1,GProdutosExtras.ALinha],'.'))
    else
      VprDProdutoExtra.QtdProduto := 0;
  end;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.GProdutosChamadoMudouLinha(
  Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDChamado.Produtos.Count > 0 then
  begin
    VprDProdutoChamado := TRBDChamadoProduto(VprDChamado.Produtos.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.GProdutosChamadoDadosValidos(
  Sender: TObject; var VpaValidos: Boolean);
Var
  VpfQtdABaixar : Double;
begin
  VpaValidos := true;
  if GProdutosChamado.Cells[1,GProdutosChamado.ALinha] <> '' then
    VpfQtdABaixar := StrToFloat(DeletaChars(GProdutosChamado.Cells[1,GProdutosChamado.ALinha],'.'))
  else
    VpfQtdABaixar := 0;
  if VprRetorno then
  begin
    if VpfQtdABaixar > VprDProdutoChamado.QtdBaixado then
    begin
      aviso('QUANTIDADE DE PRODUTOS A BAIXAR INVÁLIDA!!!'#13'A quantidade de produtos a baixar não pode ser maior que a quantidade de produtos baixados.');
      VpaValidos := false;
    end;
  end
  else
    if VpfQtdABaixar > VprDProdutoChamado.QtdProduto then
    begin
      aviso('QUANTIDADE DE PRODUTOS A BAIXAR INVÁLIDA!!!'#13'A quantidade de produtos a baixar não pode ser maior que a quantidade de produtos.');
      VpaValidos := false;
    end;

  if VpaValidos  then
    VprDProdutoChamado.QtdABaixar := VpfQtdABaixar;
end;

{******************************************************************************}
procedure TFBaixaProdutosChamado.GProdutosExtrasMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDChamado.ProdutosExtras.Count > 0 then
  begin
    VprDProdutoExtra := TRBDChamadoProdutoExtra(VprDChamado.ProdutosExtras.Items[VpaLinhaAtual-1]);
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFBaixaProdutosChamado]);
end.
