unit ANovaOrdemProducaoCadarco;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, StdCtrls, Buttons, ComCtrls,
  Localizacao, Grids, CGrades, UnDadosProduto, UnOrdemProducao, UnProdutos, Constantes,
  DBKeyViolation;

type
  TFNovaOrdemProducaoCadarco = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BImprimir: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton3: TSpeedButton;
    Label8: TLabel;
    ETipoPedido: TComboBoxColor;
    ECliente: TEditLocaliza;
    Label1: TLabel;
    EDatEmissao: TCalendario;
    Label2: TLabel;
    EDatEntrega: TCalendario;
    EProgramador: TEditLocaliza;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    GProdutos: TRBStringGridColor;
    GMaquinas: TRBStringGridColor;
    Label5: TLabel;
    ECor: TEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    EDesObservacao: TMemoColor;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosDepoisExclusao(Sender: TObject);
    procedure GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosNovaLinha(Sender: TObject);
    procedure GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BFecharClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure ECorCadastrar(Sender: TObject);
    procedure ECorEnter(Sender: TObject);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure ETipoPedidoChange(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure ETipoPedidoExit(Sender: TObject);
    procedure GMaquinasCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GMaquinasDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GMaquinasGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GMaquinasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GMaquinasKeyPress(Sender: TObject; var Key: Char);
    procedure GMaquinasMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GMaquinasSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    VprProdutoAnterior :String;
    VprAcao : Boolean;
    VprOperacao : TRBDOperacaoCadastro;
    VprDOrdemProducao : TRBDOrdemProducaoEtiqueta;
    VprDItemOP : TRBDOPItemCadarco;
    VprDMaquina : TRBDOPItemMaquina;
    VprDConsumoMP : TRBDConsumoMP;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure CarTituloGrade;
    procedure CarDTela;
    procedure CarDOpItem;
    procedure CarDOpMaquina;
    procedure CarDClasse;
    procedure AtualizaDadosProduto(VpaSeqProduto : Integer);
    procedure AtualizaDadosProdutos;
    function  LocalizaProduto : Boolean;
    function ExisteProduto : Boolean;
    function Existecor : Boolean;
    function ExisteMaquina : Boolean;
    procedure AlteraEnabledBotoes(VpaEstado : Boolean);
    function DadosItensValidos : Boolean;
    procedure VerificaNumTabuas;
  public
    { Public declarations }
    function GeraNovaOP(VpaDOP : TRBDOrdemProducaoEtiqueta):Boolean;
    function AlteraOP(VpaDOP : TRBDOrdemProducaoEtiqueta) : Boolean;
  end;

var
  FNovaOrdemProducaoCadarco: TFNovaOrdemProducaoCadarco;

implementation

uses APrincipal, ALocalizaProdutos, ConstMsg, FunString,
  ACores, ANovoProdutoPro, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaOrdemProducaoCadarco.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);
  CarTituloGrade;
  VprAcao := false;
  VprDConsumoMP := TRBDConsumoMP.cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaOrdemProducaoCadarco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao.free;
  VprDConsumoMP.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.CarTituloGrade;
begin
  GProdutos.Cells[1,0] := 'Metragem';
  GProdutos.Cells[2,0] := 'Código';
  GProdutos.Cells[3,0] := 'Produto';
  GProdutos.Cells[4,0] := 'Algodão';
  GProdutos.Cells[5,0] := 'Poliés.';
  GProdutos.Cells[6,0] := 'Gross/Larg';
  GProdutos.Cells[7,0] := 'Cor';
  GProdutos.Cells[8,0] := 'Descrição';
  GProdutos.Cells[9,0] := 'Engrenagem';
  GProdutos.Cells[10,0] := 'Fusos';
  GProdutos.Cells[11,0] := 'Nro Fios';
  GProdutos.Cells[12,0] := 'Título';
  GProdutos.Cells[13,0] := 'Enchimento';
  GProdutos.Cells[14,0] := 'Tábuas';
  GProdutos.Cells[15,0] := 'Nro Máquinas';
  GMaquinas.Cells[1,0] := 'Qtd Metros';
  GMaquinas.Cells[2,0] := 'Máquina';
  GMaquinas.Cells[3,0] := 'Descrição';
  GMaquinas.Cells[4,0] := 'Qtd Horas';
  GMaquinas.Cells[5,0] := 'Data Final';
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.CarDTela;
begin
  ETipoPedido.ItemIndex := VprDOrdemProducao.TipPedido;
  EDatEmissao.DateTime := VprDOrdemProducao.DatEmissao;
  EDatEntrega.DateTime := VprDOrdemProducao.DatEntregaPrevista;
  ECliente.AInteiro := VprDOrdemProducao.CodCliente;
  ECliente.Atualiza;
  EProgramador.AInteiro := VprDOrdemProducao.CodProgramador;
  EProgramador.Atualiza;
  EDesObservacao.Lines.Text := VprDOrdemProducao.DesObservacoes;
  GProdutos.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.CarDOpItem;
begin
  with VprDItemOP do
  begin
    QtdMetrosProduto := StrToInt(GProdutos.Cells[1,GProdutos.ALinha]);
    CodProduto := GProdutos.Cells[2,GProdutos.Alinha];
    IndAlgodao := GProdutos.Cells[4,GProdutos.ALinha];
    IndPoliester := GProdutos.Cells[5,GProdutos.ALinha];
    if GProdutos.Cells[6,GProdutos.ALinha] <> '' then
      Grossura := StrToFloat(DeletaChars(GProdutos.Cells[6,GProdutos.ALinha],'.'))
    else
      Grossura := 0;
    if GProdutos.Cells[7,GProdutos.ALinha] <> '' then
      CodCor := StrToInt(GProdutos.Cells[7,GProdutos.Alinha])
    else
      CodCor := 0;
    NomCor := GProdutos.Cells[8,GProdutos.ALinha];
    DesEngrenagem := GProdutos.Cells[9,GProdutos.ALinha];
    if GProdutos.Cells[10,GProdutos.ALinha] <> '' then
      QtdFusos := StrToInt(GProdutos.Cells[10,GProdutos.Alinha])
    else
      QtdFusos := 0;
    if GProdutos.Cells[11,GProdutos.ALinha] <> '' then
      NroFios := StrToInt(GProdutos.Cells[11,GProdutos.Alinha])
    else
      NroFios := 0;
    TitFios := GProdutos.Cells[12,GProdutos.ALinha];
    DesEnchimento := GProdutos.Cells[13,GProdutos.ALinha];
    NumTabuas := StrToFloat(DeletaChars(GProdutos.Cells[14,GProdutos.ALinha],'.'));
    if GProdutos.Cells[15,GProdutos.ALinha] <> '' then
      NroMaquinas := StrToInt(GProdutos.Cells[15,GProdutos.Alinha])
    else
      NroMaquinas := 0;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.CarDOpMaquina;
begin
  with VprDMaquina do
  begin
    QtdMetros :=  StrToFloat(DeletaChars(GMaquinas.Cells[1,GMaquinas.ALinha],'.'));
    CodMaquina := StrToInt(GMaquinas.Cells[2,GMaquinas.ALinha]);
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.CarDClasse;
begin
  VprDOrdemProducao.TipPedido :=   ETipoPedido.ItemIndex;
  VprDOrdemProducao.DatEmissao := EDatEmissao.DateTime;
  VprDOrdemProducao.DatEntregaPrevista := EDatEntrega.DateTime;
  VprDOrdemProducao.CodCliente := ECliente.AInteiro;
  VprDOrdemProducao.CodProgramador := EProgramador.AInteiro;
  VprDOrdemProducao.DesObservacoes := EDesObservacao.Lines.Text;
  VprDOrdemProducao.CodEstagio := varia.EstagioOrdemProducao;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.AtualizaDadosProduto(VpaSeqProduto : Integer);
var
  VpfLaco : Integer;
  VpfDOpItem :  TRBDOPItemCadarco;
begin
  for VpfLaco := 0 to VprDOrdemProducao.ItemsCadarco.Count - 1 do
  begin
    VpfDOpItem := TRBDOPItemCadarco(VprDOrdemProducao.ItemsCadarco.Items[Vpflaco]);
    if VpfDOpItem.SeqProduto = VpaSeqProduto then
    begin
      FunOrdemProducao.CarDTecnicosCadarco(VprDOrdemProducao,VpfDOpItem);
      FunOrdemProducao.CarQtdMetrosMaquina(VpfDOpItem);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.AtualizaDadosProdutos;
var
  VpfLaco : Integer;
  VpfDOpItem :  TRBDOPItemCadarco;
begin
  for VpfLaco := 0 to VprDOrdemProducao.ItemsCadarco.Count - 1 do
  begin
    VpfDOpItem := TRBDOPItemCadarco(VprDOrdemProducao.ItemsCadarco.Items[VpfLaco]);
    FunOrdemProducao.CarDTecnicosCadarco(VprDOrdemProducao,VpfDOpItem);
    FunOrdemProducao.CarQtdMetrosMaquina(VpfDOpItem);
  end;
  GProdutos.CarregaGrade;
end;

{******************** localiza o produto digitado *****************************}
Function TFNovaOrdemProducaoCadarco.LocalizaProduto : Boolean;
var
  VpfCadastrou : Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VpfCadastrou,VprdItemOp.SeqProduto,VprdItemOp.CodProduto,VprdItemOp.NomProduto); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    FunOrdemProducao.CarDTecnicosCadarco(VprDOrdemProducao,VprDItemOP);
    GProdutosCarregaItemGrade(GProdutos,GProdutos.ALinha);
  end;
end;

{******************** verifica se o produto existe ****************************}
function TFNovaOrdemProducaoCadarco.ExisteProduto : Boolean;
begin
  if (GProdutos.Cells[2,GProdutos.ALinha] <> '') then
  begin
    if GProdutos.Cells[2,GProdutos.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      result := FunProdutos.ExisteProduto(GProdutos.Cells[2,GProdutos.ALinha],VprDConsumoMP);
      if result then
      begin
        VprDConsumoMP.CodProduto := GProdutos.Cells[2,GProdutos.ALinha];
        VprProdutoAnterior := VprDConsumoMP.CodProduto;
        VprDItemOP.SeqProduto := VprDConsumoMP.SeqProduto;
        VprDItemOP.CodProduto := VprDConsumoMP.CodProduto;
        VprDItemOP.NomProduto := VprDConsumoMP.NomProduto;
        VprDItemOP.UM := VprDConsumoMP.UMOriginal;
        FunOrdemProducao.CarDTecnicosCadarco(VprDOrdemProducao,VprDItemOP);
        GProdutosCarregaItemGrade(GProdutos,GProdutos.ALinha);
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaOrdemProducaoCadarco.Existecor : Boolean;
begin
  result := false;
  if (GProdutos.Cells[7,GProdutos.Alinha]<> '') then
  begin
    result := FunProdutos.Existecor(GProdutos.Cells[7,GProdutos.ALinha],VprDItemOP.NomCor);
    if result then
    begin
      GProdutos.Cells[8,GProdutos.ALinha] := VprDItemOP.NomCor;
    end;
  end;
end;

{******************************************************************************}
function TFNovaOrdemProducaoCadarco.ExisteMaquina : Boolean;
begin
  result := false;
  if (GMaquinas.cells[2,GMaquinas.ALinha] <> '') then
  begin
    result := FunOrdemProducao.ExisteMaquina(GMaquinas.Cells[2,GMaquinas.ALinha],VprDMaquina);
    if result then
      begin
        GMaquinasCarregaItemGrade(GMaquinas,GMaquinas.ALinha);
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.AlteraEnabledBotoes(VpaEstado : Boolean);
begin
  BImprimir.Enabled := VpaEstado;
  BFechar.Enabled := VpaEstado;
  BGravar.Enabled := not VpaEstado;
  BCancelar.Enabled := not VpaEstado;
end;

{******************************************************************************}
function TFNovaOrdemProducaoCadarco.DadosItensValidos : Boolean;
var
  VpfLaco : Integer;
  VpfDItem : TRBDOPItemCadarco;
begin
  result := true;
  for VpfLaco := 0 to VprDOrdemProducao.ItemsCadarco.Count - 1 do
  begin
    VpfDItem := TRBDOPItemCadarco(VprDOrdemProducao.itemsCadarco.Items[VpfLaco]);
    if  VpfDItem.NumTabuas = 0 then
    begin
      result := false;
      aviso('NÚMERO DE TÁBUAS INVÁLIDO!!!'#13'O número de tábuas não foi preenchido.');
      GProdutos.Col := 14;
    end;

    if not result then
    begin
      ActiveControl := GProdutos;
      GProdutos.row := VpfLaco + 1;
      exit;
    end;
  end;

end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.VerificaNumTabuas;
begin
  if (VprDItemOP.NumTabuas <> StrToFloat(DeletaChars(GProdutos.Cells[14,GProdutos.ALinha],'.'))) or
     (VprDItemOP.NroMaquinas <> StrToFloat(DeletaChars(GProdutos.Cells[15,GProdutos.ALinha],'.')))then
  begin
    VprDItemOP.NumTabuas := StrToFloat(DeletaChars(GProdutos.Cells[14,GProdutos.ALinha],'.'));
    VprDItemOP.NroMaquinas := StrtoInt(GProdutos.Cells[15,GProdutos.ALinha]);
    if VprDItemOP.NumTabuas <= (VprDItemOP.NroMaquinas - 1) then
    begin
      VprDItemOP.NumTabuas := VprDItemOP.NroMaquinas;
      GProdutosCarregaItemGrade(GProdutos,GProdutos.ALinha);
    end;
    FunOrdemProducao.CarQtdMetrosMaquina(VprDItemOP);
    GMaquinas.CarregaGrade;
  end;
end;

{******************************************************************************}
function TFNovaOrdemProducaoCadarco.GeraNovaOP(VpaDOP : TRBDOrdemProducaoEtiqueta):Boolean;
begin
  VprOperacao := ocInsercao;
  AlteraEnabledBotoes(false);
  VprDOrdemProducao := VpaDOP;
  GProdutos.ADados := VprDOrdemProducao.ItemsCadarco;
  CarDTela;
  ActiveControl := GProdutos;
  showmodal;
  Result := VprAcao;
end;

{******************************************************************************}
function TFNovaOrdemProducaoCadarco.AlteraOP(VpaDOP : TRBDOrdemProducaoEtiqueta) : Boolean;
begin
  VprOperacao := ocEdicao;
  AlteraEnabledBotoes(false);
  VprDOrdemProducao := VpaDOP;
  GProdutos.ADados := VprDOrdemProducao.ItemsCadarco;
  CarDTela;
  ActiveControl := GProdutos;
  showmodal;
  Result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GProdutosCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDItemOP := TRBDOPItemCadarco(VprDOrdemProducao.ItemsCadarco.Items[VpaLinha -1]);
  GProdutos.Cells[1,VpaLinha] := FormatFloat('0',VprDItemOP.QtdMetrosProduto);
  GProdutos.Cells[2,VpaLinha] := VprDItemOP.CodProduto;
  GProdutos.Cells[3,VpaLinha] := VprDItemOP.NomProduto;
  GProdutos.Cells[4,VpaLinha] := VprDItemOP.IndAlgodao;
  GProdutos.Cells[5,VpaLinha] := VprDItemOP.IndPoliester;
  GProdutos.Cells[6,VpaLinha] := Formatfloat('0.##',VprDItemOP.Grossura);
  if VprDItemOP.CodCor <> 0 then
    GProdutos.Cells[7,VpaLinha] := IntToStr(VprDItemOP.CodCor)
  else
    GProdutos.Cells[7,VpaLinha] := '';
  GProdutos.Cells[8,VpaLinha] := VprDItemOP.NomCor;
  GProdutos.Cells[9,VpaLinha] := VprDItemOP.DesEngrenagem;
  GProdutos.Cells[10,VpaLinha] := IntToStr(VprDItemOP.QtdFusos);
  if VprDItemOP.NroFios <> 0 then
    GProdutos.Cells[11,VpaLinha] := InttoStr(VprDItemOP.NroFios)
  else
    GProdutos.Cells[11,VpaLinha] := '';
  GProdutos.Cells[12,VpaLinha] := VprDItemOP.TitFios;
  GProdutos.Cells[13,VpaLinha] := VprDItemOP.DesEnchimento;
  GProdutos.Cells[14,VpaLinha] := FormatFloat('0.0',VprDItemOP.NumTabuas);
  GProdutos.Cells[15,VpaLinha] := IntToStr(VprDItemOP.NroMaquinas);
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if DeletaChars(DeletaChars(GProdutos.Cells[1,GProdutos.ALinha],'0'),' ') = '' then
  begin
    VpaValidos := false;
    aviso(CT_QTDPRODUTOINVALIDO);
  end
  else
    if GProdutos.Cells[2,GProdutos.ALinha] = '' then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTOINVALIDO);
    end
    else
      if not ExisteProduto then
      begin
        VpaValidos := false;
        aviso(CT_PRODUTONAOCADASTRADO);
        GProdutos.col := 2;
      end
      else
        if DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[14,GProdutos.ALinha],'0'),' '),',') = '' then
        begin
          VpaValidos := false;
          aviso('NÚMERO DE TÁBUAS INVÁLIDO!!!'#13'O número de tábuas não foi preenchido.');
          GProdutos.Col := 14;
        end;
  if  VpaValidos then
  begin
    if (GProdutos.Cells[7,GProdutos.ALinha] <> '') then
    begin
      if not Existecor then
      begin
        VpaValidos := false;
        Aviso(CT_CORINEXISTENTE);
        GProdutos.Col := 7;
      end;
    end
  end;

  if VpaValidos then
  begin
    VerificaNumTabuas;
    CarDOpItem;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GProdutosDepoisExclusao(
  Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GProdutosGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  case ACol of
    1,6,7,10,11,15 :  Value := '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Var
  VpfSeqProduto, vpfAux : String;
begin
  case key of
    114 :
      begin                           // F3
        case GProdutos.Col of
          2 :  LocalizaProduto;
          7 :  ECor.AAbreLocalizacao;
        end;
      end;
    117 :
      begin
        FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
        FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,VprdItemOp.SeqProduto);
        FNovoProdutoPro.free;
        AtualizaDadosProduto(VprDItemOP.SeqProduto);
        GProdutos.CarregaGrade;
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  case GProdutos.Col of
    3,8 : key := #0;
  end;

  if GProdutos.col in [4,5] then  //permite digitar somente S/N
    if not (key in ['s','S','n','N',#8]) then
      key := #0
    else
      if key = 's' Then
        key := 'S'
      else
        if key = 'n' Then
          key := 'N';

  if (key = '.') and (GProdutos.col = 14) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDOrdemProducao.ItemsCadarco.Count > 0 then
  begin
    VprDItemOP := TRBDOPItemCadarco(VprDOrdemProducao.ItemsCadarco.Items[VpaLinhaAtual - 1]);
    VprProdutoAnterior := VprDItemOP.CodProduto;
    GMaquinas.ADados := VprDItemOP.Maquinas;
    GMaquinas.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GProdutosNovaLinha(Sender: TObject);
begin
  VprProdutoAnterior := '';
  VprDItemOP := VprDOrdemProducao.AddItemsCadarco;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GProdutosSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProdutos.AColuna <> ACol then
    begin
      case GProdutos.AColuna of
        1 : if GProdutos.Cells[1,GProdutos.ALinha] <> '' then
            begin
              if VprDItemOP.QtdMetrosProduto <> StrToInt(GProdutos.Cells[1,GProdutos.ALinha]) then
              begin
                VprDItemOP.QtdMetrosProduto := StrToInt(GProdutos.Cells[1,GProdutos.ALinha]);
                FunOrdemProducao.CarDTecnicosCadarco(VprDOrdemProducao,VprDItemOP);

                GProdutos.Cells[14,GProdutos.ALinha] := FormatFloat('0.0',VprDItemOP.NumTabuas);
                VprDItemOP.NumTabuas := 0; //é zerado o numero de tabuas para que o sistema reconheca que foi alterado e recalcule o numero de metros por maquina.
                VerificaNumTabuas;
              end;
            end;
        2 :if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               GProdutos.Cells[2,GProdutos.ALinha] := '';
               GProdutos.Col := 2;
             end;
           end;
        7 : if GProdutos.Cells[7,GProdutos.Alinha] <> '' then
            begin
              if not Existecor then
              begin
                Aviso(CT_CORINEXISTENTE);
                GProdutos.Col := 7;
                abort;
              end;
            end;
    14,15 : VerificaNumTabuas;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.BGravarClick(Sender: TObject);
Var
  VpfResultado : String;
begin
  if DadosItensValidos then
  begin
    CarDClasse;
    VpfResultado := FunOrdemProducao.GravaOrdemProducao(VprDOrdemProducao);
    if VpfResultado = '' then
    begin
      VprAcao := true;
      AlteraEnabledBotoes(true);
      VprOperacao := ocConsulta;
    end
    else
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.BCancelarClick(Sender: TObject);
begin
//AlteraEnabledBotoes(true);
  close;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application, '', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.Showmodal;
  FCores.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.ECorEnter(Sender: TObject);
begin
  ECor.clear;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.ECorRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GProdutos.Cells[7,GProdutos.ALinha] := ECor.Text;
    GProdutos.Cells[8,GProdutos.ALinha] := Retorno1;
    GProdutos.AEstadoGrade := egEdicao;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.ETipoPedidoChange(Sender: TObject);
begin
  if VprOperacao in [ocinsercao,ocEdicao ] then
    ValidaGravacao1.execute;

end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.Create(self);
  dtRave.ImprimeOPCadarcoTrancado(VprDOrdemProducao.CodEmpresafilial,VprDOrdemProducao.SeqOrdem,false);
  dtRave.Free;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.ETipoPedidoExit(Sender: TObject);
begin
  if VprDOrdemProducao.TipPedido <> ETipoPedido.ItemIndex then
  begin
    VprDOrdemProducao.TipPedido := ETipoPedido.ItemIndex;
    AtualizaDadosProdutos;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GMaquinasCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDMaquina := TRBDOPItemMaquina(VprDItemOP.Maquinas.Items[VpaLinha-1]);
  GMaquinas.Cells[1,VpaLinha] := FormatFloat('#,###,##0.###',VprDMaquina.QtdMetros);
  if VprDMaquina.CodMaquina <> 0 then
    GMaquinas.Cells[2,VpaLinha] := IntToStr(VprDMaquina.CodMaquina)
  else
    GMaquinas.Cells[2,VpaLinha] := '';
  GMaquinas.Cells[3,VpaLinha] := VprDMaquina.NomMaquina;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GMaquinasDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if DeletaChars(DeletaChars(GMaquinas.Cells[1,GMaquinas.ALinha],'0'),' ') = '' then
  begin
    VpaValidos := false;
    aviso('QUANTIDADE METROS INVÁLIDA!!!'#13'É necessário preencher a quantidade de metros.');
  end
  else
    if GMaquinas.Cells[2,GMaquinas.ALinha] = '' then
    begin
      VpaValidos := false;
      aviso('MAQUINA INVÁLIDA!!!'#13'É necessário preencher em que máquina será produzido.');
    end
    else
      if not ExisteMaquina then
      begin
        VpaValidos := false;
        aviso('MÁQUINA NÃO CADASTRADA!!!'#13'A máquina selecionada não existe cadastrada.');
        GMaquinas.col := 2;
      end
      else
        if DeletaChars(DeletaChars(DeletaChars(GMaquinas.Cells[1,GMaquinas.ALinha],'0'),' '),',') = '' then
        begin
          VpaValidos := false;
          aviso('QUANTIDADE METROS INVÁLIDA!!!'#13'É necessário preencher a quantidade de metros.');
          GMaquinas.col := 1;
        end;

  if VpaValidos then
  begin
    CarDOpMaquina;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GMaquinasGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  case ACol of
    1,2 :  Value := '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GMaquinasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
      begin                           // F3
        case GMaquinas.Col of
          2 :  LocalizaProduto;
        end;
      end;
  end;
end;

procedure TFNovaOrdemProducaoCadarco.GMaquinasKeyPress(Sender: TObject;
  var Key: Char);
begin
  case GMaquinas.Col of
    3 : key := #0;
  end;
end;

procedure TFNovaOrdemProducaoCadarco.GMaquinasMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDItemOP.Maquinas.Count > 0 then
  begin
    VprDMaquina := TRBDOPItemMaquina(VprDItemOP.Maquinas.Items[VpaLinhaAtual - 1]);
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoCadarco.GMaquinasSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if GMaquinas.AEstadoGrade in [egInsercao,EgEdicao] then
    if GMaquinas.AColuna <> ACol then
    begin
      case GMaquinas.AColuna of
        2 :if not ExisteMaquina then
           begin
             if not LocalizaProduto then
             begin
               GMaquinas.Cells[2,GMaquinas.ALinha] := '';
               GMaquinas.Col := 2;
             end;
           end;
      end;
    end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaOrdemProducaoCadarco]);
end.
