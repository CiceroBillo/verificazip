unit AMontaKit;
{          Autor: Sergio Luiz Censi
    Data Criação: 06/04/1999;
          Função: Montar um novo Kit
  Data Alteração: 06/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 06/04/199 / Rafael Budag
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, PainelGradiente, StdCtrls, Buttons,
  ExtCtrls, Componentes1, DBKeyViolation, CGrades, UnDados, UnProdutos,
  ConvUnidade, Localizacao, UnDadosProduto, Menus, UnAmostra, DBClient,
  CBancoDados, ComCtrls, FunSql;

type
  TFMontaKit = class(TFormularioPermissao)
    PCor: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Bok: TBitBtn;
    BCancelar: TBitBtn;
    ValidaUnidade: TValidaUnidade;
    Localiza: TConsultaPadrao;
    ECor: TEditLocaliza;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    ECorKit: TEditLocaliza;
    PopupMenu1: TPopupMenu;
    Copiar1: TMenuItem;
    Colar1: TMenuItem;
    EFaca: TEditLocaliza;
    EMaquina: TEditLocaliza;
    N1: TMenuItem;
    ImportaConsumoAmostra1: TMenuItem;
    Label3: TLabel;
    N2: TMenuItem;
    Bastidores1: TMenuItem;
    Paginas: TPageControl;
    PProdutos: TTabSheet;
    TabSheet2: TTabSheet;
    GProdutos: TRBStringGridColor;
    PanelColor1: TPanelColor;
    MovKit: TRBSQL;
    DataMovKit: TDataSource;
    GridIndice1: TGridIndice;
    MovKitC_COD_PRO: TWideStringField;
    MovKitSEQPRODUTO: TFMTBCDField;
    MovKitSEQLOG: TFMTBCDField;
    MovKitDATLOG: TSQLTimeStampField;
    MovKitCODUSUARIO: TFMTBCDField;
    MovKitC_NOM_USU: TWideStringField;
    MovKitDESCAMINHOLOG: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BokClick(Sender: TObject);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorCadastrar(Sender: TObject);
    procedure ECorEnter(Sender: TObject);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosNovaLinha(Sender: TObject);
    procedure GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GProdutosEnter(Sender: TObject);
    procedure ECorKitRetorno(Retorno1, Retorno2: String);
    procedure Copiar1Click(Sender: TObject);
    procedure Colar1Click(Sender: TObject);
    procedure EFacaRetorno(Retorno1, Retorno2: String);
    procedure EMaquinaRetorno(Retorno1, Retorno2: String);
    procedure ImportaConsumoAmostra1Click(Sender: TObject);
    procedure Bastidores1Click(Sender: TObject);
    procedure PaginasEnter(Sender: TObject);
  private
    VprCorKitAnterior, VprCorKitCopia : Integer;
    VprDProduto : TRBDProduto;
    VprDConsumo : TRBDConsumoMP;
    VprAcao : Boolean;
    VprProdutoAnterior : String;
    FunProdutos : TFuncoesProduto;
    FunAmostra : TRBFuncoesAmostra;
    procedure CarTituloGrade;
    procedure ConfiguraTela;
    function ExisteProduto : Boolean;
    function ExisteEntretela : Boolean;
    function ExisteTermoColante : Boolean;
    function ExisteCor : Boolean;
    function ExisteUM : Boolean;
    function ExisteFaca : Boolean;
    function ExisteMaquina: Boolean;
    procedure CarDConsumo;
    function LocalizaProduto : Boolean;
    function LocalizaEntretela : boolean;
    function LocalizaTermocolante : Boolean;
    procedure CalculaValorTotalItem;
    procedure CarGrade;
    procedure CopiaConsumo;
    procedure CarQtdPecaMetroGrade;
    procedure CalculaConsumos;
    procedure AtualizaConsulta(VpaSeqProduto : integer);
  public
    function  ConsumoMP(VpaDProduto : TRBDProduto) :Boolean;
  end;

var
  FMontaKit: TFMontaKit;

implementation

uses APrincipal, constantes, constmsg, ALocalizaClassificacao,
  ALocalizaProdutos, FunString, ACores, FunNumeros, AMontaKitBastidor;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMontaKit.FormCreate(Sender: TObject);
begin
  VprAcao := false;
  FunProdutos := TFuncoesProduto.criar(self,FPrincipal.BaseDados);
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  ValidaUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ValidaUnidade.Ainfo.UnidadeUN := varia.unidadeUN;
  ValidaUnidade.Ainfo.UnidadeKiT := varia.UnidadeKit;
  ValidaUnidade.Ainfo.UnidadeBarra := varia.UnidadeBarra;
  ConfiguraTela;
  Paginas.ActivePage := PProdutos;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMontaKit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FunAmostra.free;
  FunProdutos.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações de Inicalização
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**********************Carrega a  tela na inicialização************************}
function  TFMontaKit.ConsumoMP(VpaDProduto : TRBDProduto) :Boolean;
begin
  CarTituloGrade;
  VprDProduto := VpaDProduto;
  CarGrade;
  ShowModal;
  result := vprAcao;
end;

{******************************************************************************}
procedure TFMontaKit.CarTituloGrade;
begin
  GProdutos.Cells[1,0] := 'Código';
  GProdutos.Cells[2,0] := 'Produto';
  GProdutos.Cells[3,0] := 'Cor';
  GProdutos.Cells[4,0] := 'Descrição';
  GProdutos.Cells[5,0] := 'Cor Ref.';
  GProdutos.Cells[6,0] := 'UM';
  GProdutos.Cells[7,0] := 'Quantidade';
  GProdutos.Cells[8,0] := 'Valor Unitário';
  GProdutos.Cells[9,0] := 'Valor Total';
  GProdutos.Cells[10,0]:= 'Código';
  GProdutos.Cells[11,0]:= 'Faca';
  GProdutos.Cells[12,0]:= 'Altura Molde';
  GProdutos.Cells[13,0]:= 'Largura Molde';
  GProdutos.Cells[14,0]:= 'Código';
  GProdutos.Cells[15,0]:= 'Máquina';
  GProdutos.Cells[16,0]:= 'Código';
  GProdutos.Cells[17,0]:= 'Entretela';
  GProdutos.Cells[18,0]:= 'Qtd';
  GProdutos.Cells[19,0]:= 'Código';
  GProdutos.Cells[20,0]:= 'Termocolante';
  GProdutos.Cells[21,0]:= 'Qtd';
  GProdutos.Cells[22,0]:= 'Pcs em MT';
  GProdutos.Cells[23,0]:= 'Indice MT';
  GProdutos.Cells[24,0]:= 'Observacoes';
end;

{******************************************************************************}
procedure TFMontaKit.ConfiguraTela;
begin
  PCor.Visible := Config.ConsumodoProdutoporCombinacao;
  if not Config.EstoquePorCor then
  begin
    ECorKit.Clear;
    GProdutos.ColWidths[3] := -1;
    GProdutos.ColWidths[4] := -1;
    GProdutos.ColWidths[2] := RetornaInteiro(GProdutos.ColWidths[2] * 1.5);
    GProdutos.ColWidths[1] := RetornaInteiro(GProdutos.ColWidths[1] * 1.5);
  end;
end;

{******************** verifica se o produto existe ****************************}
function TFMontaKit.ExisteProduto : Boolean;
begin
  if (GProdutos.Cells[1,GProdutos.ALinha] <> '') then
  begin
    if GProdutos.Cells[1,GProdutos.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      result := FunProdutos.ExisteProduto(GProdutos.Cells[1,GProdutos.ALinha],VprDConsumo);
      if result then
      begin
        VprDConsumo.CodProduto := GProdutos.Cells[1,GProdutos.ALinha];
        VprDConsumo.UnidadeParentes.free;
        VprDConsumo.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDConsumo.UMOriginal);
        VprProdutoAnterior := VprDConsumo.CodProduto;
        GProdutos.Cells[2,GProdutos.ALinha] := VprDConsumo.NomProduto;
        GProdutos.Cells[6,GProdutos.ALinha] := VprDConsumo.UM;
        GProdutos.Cells[7,GProdutos.ALinha] := FormatFloat('0.000',VprDConsumo.QtdProduto);
        GProdutos.Cells[8,GProdutos.ALinha]:= FormatFloat(Varia.MascaraValor,VprDConsumo.ValorUnitario);
        CalculaValorTotalItem;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFMontaKit.Existecor : Boolean;
begin
  result := true;
  if (GProdutos.Cells[3,GProdutos.Alinha]<> '') then
  begin
    result := FunProdutos.ExisteCor(GProdutos.Cells[3,GProdutos.ALinha],VprDConsumo);
    if result then
    begin
      GProdutos.Cells[4,GProdutos.ALinha] := VprDConsumo.NomCor;
    end;
  end;
end;

{******************************************************************************}
function TFMontaKit.ExisteEntretela : Boolean;
begin
  result := true;
  if (GProdutos.Cells[16,GProdutos.ALinha] <> '') then
  begin
    result := FunProdutos.ExisteEntretela(GProdutos.Cells[16,GProdutos.ALinha],VprDConsumo);
    if result then
    begin
      VprDConsumo.CodProdutoEntretela := GProdutos.Cells[16,GProdutos.ALinha];
      GProdutos.Cells[17,GProdutos.ALinha] := VprDConsumo.NomProdutoEntretela;
    end;
  end
  else
  begin
    VprDConsumo.SeqProdutoEntretela := 0;
    VprDConsumo.CodProdutoEntretela := '';
    VprDConsumo.NomProdutoEntretela := '';
    VprDConsumo.QtdEntretela := 0;
  end;
end;

{******************************************************************************}
function TFMontaKit.ExisteTermoColante : Boolean;
begin
  result := true;
  if (GProdutos.Cells[19,GProdutos.ALinha] <> '') then
  begin
    result := FunProdutos.ExisteTermoColante(GProdutos.Cells[19,GProdutos.ALinha],VprDConsumo);
    if result then
    begin
      VprDConsumo.CodProdutoTermoColante := GProdutos.Cells[19,GProdutos.ALinha];
      GProdutos.Cells[20,GProdutos.ALinha] := VprDConsumo.NomProdutoTermoColante;
    end;
  end
  else
  begin
    VprDConsumo.SeqProdutoTermoColante := 0;
    VprDConsumo.CodProdutoTermoColante := '';
    VprDConsumo.NomProdutoTermoColante := '';
    VprDConsumo.QtdTermoColante := 0;
  end;
end;

{******************************************************************************}
function TFMontaKit.ExisteUM : Boolean;
begin
  result := (VprDConsumo.UnidadeParentes.IndexOf(GProdutos.Cells[6,GProdutos.Alinha]) >= 0);
end;

{******************************************************************************}
procedure TFMontaKit.CarDConsumo;
begin
  VprDConsumo.NomProduto := GProdutos.Cells[2,GProdutos.ALinha];
  if GProdutos.Cells[3,GProdutos.ALinha] <> '' then
    VprDConsumo.CodCor := StrToInt(GProdutos.Cells[3,GProdutos.Alinha])
  else
    VprDConsumo.CodCor := 0;
  if GProdutos.Cells[5,GProdutos.Alinha] <> '' then
    VprDConsumo.CorReferencia := StrToInt(GProdutos.Cells[5,GProdutos.Alinha])
  else
    VprDConsumo.CorReferencia:= 0;
  VprDConsumo.UM := GProdutos.Cells[6,GProdutos.ALinha];
  CalculaValorTotalItem;

  if GProdutos.Cells[10,GProdutos.Alinha] <> '' then
    VprDConsumo.CodFaca:= StrToInt(GProdutos.Cells[10,GProdutos.Alinha])
  else
    VprDConsumo.CodFaca:= 0;
  if GProdutos.Cells[12,GProdutos.ALinha] <> '' then
  begin
    if config.ConverterMTeCMparaMM then
      VprDConsumo.AlturaMolde:= StrToFloat(GProdutos.Cells[12,GProdutos.ALinha])/10
    else
      VprDConsumo.AlturaMolde:= StrToFloat(GProdutos.Cells[12,GProdutos.ALinha]);
  end
  else
    VprDConsumo.AlturaMolde:= 0;
  if GProdutos.Cells[13,GProdutos.ALinha] <> '' then
  begin
    if config.ConverterMTeCMparaMM then
      VprDConsumo.LarguraMolde:= StrToFloat(GProdutos.Cells[13,GProdutos.ALinha]) /10
    else
      VprDConsumo.LarguraMolde:= StrToFloat(GProdutos.Cells[13,GProdutos.ALinha]);
  end
  else
    VprDConsumo.LarguraMolde:= 0;
  if GProdutos.Cells[14,GProdutos.ALinha] <> '' then
    VprDConsumo.CodMaquina:= StrToInt(GProdutos.Cells[14,GProdutos.ALinha])
  else
    VprDConsumo.CodMaquina:= 0;
  if GProdutos.Cells[18,GProdutos.ALinha] <> '' then
    VprDConsumo.QtdEntretela:= StrToInt(GProdutos.Cells[18,GProdutos.ALinha])
  else
    if VprDConsumo.SeqProdutoEntretela <> 0 then
      VprDConsumo.QtdEntretela:= 1
    else
      VprDConsumo.QtdEntretela:= 0;
  if GProdutos.Cells[21,GProdutos.ALinha] <> '' then
    VprDConsumo.QtdTermoColante:= StrToInt(GProdutos.Cells[21,GProdutos.ALinha])
  else
    if VprDConsumo.SeqProdutoTermoColante <> 0 then
      VprDConsumo.QtdTermoColante:= 1
    else
      VprDConsumo.QtdTermoColante:= 0;
  if GProdutos.Cells[22,GProdutos.ALinha] <> '' then
    VprDConsumo.PecasMT:= StrToFloat(DeletaChars(GProdutos.Cells[22,GProdutos.ALinha],'.'))
  else
    VprDConsumo.PecasMT:= 0;
  if GProdutos.Cells[23,GProdutos.ALinha] <> '' then
    VprDConsumo.IndiceMT:= StrToFloat(DeletaChars(GProdutos.Cells[23,GProdutos.ALinha],'.'))
  else
    VprDConsumo.IndiceMT:= 0;
  VprDConsumo.DesObservacoes := GProdutos.Cells[24,GProdutos.ALinha];
end;

{******************** localiza o produto digitado *****************************}
function TFMontaKit.LocalizaProduto : Boolean;
begin
  FLocalizaProdutoConsumo  := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FLocalizaProdutoConsumo'));
  Result := FLocalizaProdutoConsumo.LocalizaProduto(VprDConsumo);

  FLocalizaProdutoConsumo.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
    begin
      with VprDConsumo do
      begin
        UM := UMOriginal;
        UnidadeParentes.free;
        UnidadeParentes := ValidaUnidade.UnidadesParentes(UMOriginal);
        VprProdutoAnterior := CodProduto;
        QtdProduto := 1;
        GProdutos.Cells[1,GProdutos.ALinha] := CodProduto;
        GProdutos.Cells[2,GProdutos.ALinha] := NomProduto;
        GProdutos.Cells[6,GProdutos.ALinha] := UM;
        GProdutos.Cells[7,GProdutos.ALinha] := FormatFloat('0.000',VprDConsumo.QtdProduto);
        GProdutos.Cells[8,GProdutos.ALinha]:= FormatFloat(Varia.MascaraValor,VprDConsumo.ValorUnitario);
        CalculaValorTotalItem;
      end;
    end;
end;

{******************************************************************************}
function TFMontaKit.LocalizaEntretela : boolean;
begin
  FLocalizaProdutoConsumo  := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FLocalizaProdutoConsumo'));
  Result := FLocalizaProdutoConsumo.LocalizaEntretela(VprDConsumo);

  FLocalizaProdutoConsumo.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
    begin
      with VprDConsumo do
      begin
        QtdEntretela := 1;
        GProdutos.Cells[16,GProdutos.ALinha] := CodProdutoEntretela;
        GProdutos.Cells[17,GProdutos.ALinha] := NomProdutoEntretela;
      end;
    end;
end;

{******************************************************************************}
function TFMontaKit.LocalizaTermocolante : Boolean;
begin
  FLocalizaProdutoConsumo  := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FLocalizaProdutoConsumo'));
  Result := FLocalizaProdutoConsumo.LocalizaTermoColante(VprDConsumo);

  FLocalizaProdutoConsumo.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
    begin
      with VprDConsumo do
      begin
        QtdTermoColante := 1;
        GProdutos.Cells[19,GProdutos.ALinha] := CodProdutoTermoColante;
        GProdutos.Cells[20,GProdutos.ALinha] := NomProdutoTermoColante;
      end;
    end;
end;

{******************************************************************************}
procedure TFMontaKit.PaginasEnter(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFMontaKit.CalculaValorTotalItem;
begin
  if GProdutos.Cells[7,GProdutos.ALinha] <> '' then
    VprDConsumo.QtdProduto := StrToFloat(DeletaChars(GProdutos.Cells[7,GProdutos.ALinha],'.'))
  else
    VprDConsumo.QtdProduto := 0;

  if GProdutos.Cells[8,GProdutos.ALinha] <> '' then
    VprDConsumo.ValorUnitario:= StrToFloat(DeletaChars(GProdutos.Cells[8,GProdutos.ALinha],'.'))
  else
    VprDConsumo.ValorUnitario:= 0;

  if VprDConsumo.PecasMT <> 0 then
    VprDConsumo.ValorTotal:= ((VprDConsumo.ValorUnitario*VprDConsumo.IndiceMT)/VprDConsumo.PecasMt)*VprDConsumo.Qtdproduto
  else
    VprDConsumo.ValorTotal := VprDConsumo.QtdProduto * VprDConsumo.ValorUnitario;

  GProdutos.Cells[9,gProdutos.ALinha] := FormatFloat(varia.MascaraValor,VprDConsumo.ValorTotal);
end;

{******************************************************************************}
procedure TFMontaKit.CarGrade;
begin
  FunProdutos.CarConsumoProduto(VprDProduto,ECorKit.AInteiro);
  GProdutos.ADados := VprDProduto.ConsumosMP;
  GProdutos.CarregaGrade;
  VprCorKitAnterior := ECorKit.AInteiro;
end;

{******************************************************************************}
procedure TFMontaKit.CopiaConsumo;
begin
  FunProdutos.CarConsumoProduto(VprDProduto,VprCorKitCopia);
  GProdutos.ADados := VprDProduto.ConsumosMP;
  GProdutos.CarregaGrade;
  VprCorKitAnterior := ECorKit.AInteiro;
end;

{******************************************************************************}
procedure TFMontaKit.CarQtdPecaMetroGrade;
begin
  if VprDConsumo.PecasMt <> 0 then
    GProdutos.Cells[22,GProdutos.ALinha]:= FormatFloat('###,###,##0.00',VprDConsumo.PecasMt)
  else
    GProdutos.Cells[22,GProdutos.ALinha]:= '';
  if VprDConsumo.IndiceMT <> 0 then
    GProdutos.Cells[23,GProdutos.ALinha]:= FormatFloat('###,###,##0.00',VprDConsumo.IndiceMT)
  else
    GProdutos.Cells[23,GProdutos.ALinha]:= '';
end;

{******************************************************************************}
procedure TFMontaKit.CalculaConsumos;
begin
  if varia.TipoOrdemProducao in [toAgrupada,toFracionada] then
  begin
    CarDConsumo;
    VprDConsumo.PecasMT := 0;
    if VprDConsumo.CodFaca <> 0 then
    begin
      VprDConsumo.PecasMT := FunProdutos.RQtdPecaemMetro(VprDConsumo.AltProduto,100,VprDConsumo.Faca.QtdProvas,VprDConsumo.Faca.AltFaca,VprDConsumo.Faca.LarFaca,false,VprDConsumo.IndiceMT);
      VprDConsumo.Qtdproduto := 1 / VprDConsumo.PecasMT;
    end
      else
      if (VprDConsumo.LarguraMolde <> 0 )and
         (VprDConsumo.AlturaMolde <> 0) then
      begin
        VprDConsumo.PecasMT := FunProdutos.RQtdPecaemMetro(VprDConsumo.AltProduto,100,1,VprDConsumo.AlturaMolde,VprDConsumo.LarguraMolde,false, VprDConsumo.IndiceMT);
      end;
    if (VprDConsumo.LarguraMolde <> 0 )or(VprDConsumo.AlturaMolde <> 0) or
       (VprDConsumo.CodFaca <> 0) or (VprDConsumo.CodMaquina <> 0) then
      if VprDConsumo.AltProduto = 0 then
      begin
        aviso('ALTURA DO PRODUTO NÃO PREENCHIDA!!!'#13'É necessário informar a altura do produto');
        VprDConsumo.PecasMt := 0;
      end;

    CarQtdPecaMetroGrade;
    CalculaValorTotalItem;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          eventos dos filtros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFMontaKit.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFMontaKit.BokClick(Sender: TObject);
Var
  VpfResultado :String;
begin
  VpfResultado := FunProdutos.GravaDConsumoMP(VprDProduto,ECorKit.Ainteiro);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao := true;
    close;
  end;
end;

{******************************************************************************}
procedure TFMontaKit.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  if VprDProduto.ConsumosMP.Count > 0 then
  begin
    VprDConsumo := TRBDConsumoMP(VprDProduto.ConsumosMP.Items[VpaLinha-1]);
    GProdutos.Cells[1,VpaLinha] := VprDConsumo.CodProduto;
    GProdutos.Cells[2,VpaLinha] := VprDConsumo.NomProduto;
    if VprDConsumo.CodCor <> 0 then
      GProdutos.cells[3,VpaLinha] := InTToStr(VprDConsumo.CodCor)
    else
      GProdutos.cells[3,VpaLinha] :='';
    GProdutos.Cells[4,VpaLinha] := VprDConsumo.NomCor;
    if VprDConsumo.CorReferencia <> 0 then
      GProdutos.Cells[5,VpaLinha]:= IntToStr(VprDConsumo.CorReferencia)
    else
      GProdutos.Cells[5,VpaLinha]:= '';
    GProdutos.Cells[6,VpaLinha] := VprDConsumo.UM;
    if VprDConsumo.QtdProduto <> 0 then
      GProdutos.Cells[7,VpaLinha] := FormatFloat('0.000',VprDConsumo.QtdProduto)
    else
      GProdutos.Cells[7,VpaLinha] := '';
    if VprDConsumo.ValorUnitario <> 0 then
      GProdutos.Cells[8,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDConsumo.ValorUnitario)
    else
      GProdutos.Cells[8,VpaLinha]:= '';
    if VprDConsumo.ValorTotal <> 0 then
      GProdutos.Cells[9,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDConsumo.ValorTotal)
    else
      GProdutos.Cells[9,VpaLinha]:= '';
    if VprDConsumo.Faca.CodFaca <> 0 then
      GProdutos.Cells[10,VpaLinha]:= IntToStr(VprDConsumo.Faca.CodFaca)
    else
      GProdutos.Cells[10,VpaLinha]:= '';
    GProdutos.Cells[11,VpaLinha]:= VprDConsumo.Faca.NomFaca;
    if VprDConsumo.AlturaMolde <> 0 then
    begin
      if config.ConverterMTeCMparaMM then
        GProdutos.Cells[12,VpaLinha]:= FormatFloat('#,##0.00',VprDConsumo.AlturaMolde*10)
      else
        GProdutos.Cells[12,VpaLinha]:= FormatFloat('#,##0.00',VprDConsumo.AlturaMolde);
    end
    else
      GProdutos.Cells[12,VpaLinha]:= '';
    if VprDConsumo.LarguraMolde <> 0 then
    begin
      if config.ConverterMTeCMparaMM then
        GProdutos.Cells[13,VpaLinha]:= FormatFloat('#,##0.00',VprDConsumo.LarguraMolde*10)
      else
        GProdutos.Cells[13,VpaLinha]:= FormatFloat('#,##0.00',VprDConsumo.LarguraMolde)
    end
    else
      GProdutos.Cells[13,VpaLinha]:= '';
    if VprDConsumo.Maquina.CodMaquina <> 0 then
      GProdutos.Cells[14,VpaLinha]:= IntToStr(VprDConsumo.Maquina.CodMaquina)
    else
      GProdutos.Cells[14,VpaLinha]:= '';
    GProdutos.Cells[15,VpaLinha]:= VprDConsumo.Maquina.NomMaquina;
    GProdutos.Cells[16,VpaLinha]:= VprDConsumo.CodProdutoEntretela;
    GProdutos.Cells[17,VpaLinha]:= VprDConsumo.NomProdutoEntretela;
    if VprDConsumo.QtdEntretela <> 0 then
      GProdutos.Cells[18,VpaLinha]:= IntToStr(VprDConsumo.QtdEntretela)
    else
      GProdutos.Cells[18,VpaLinha]:= '';
    GProdutos.Cells[19,VpaLinha]:= VprDConsumo.CodProdutoTermoColante;
    GProdutos.Cells[20,VpaLinha]:= VprDConsumo.NomProdutoTermoColante;
    if VprDConsumo.QtdTermocolante <> 0 then
      GProdutos.Cells[21,VpaLinha]:= IntToStr(VprDConsumo.QtdTermoColante)
    else
      GProdutos.Cells[21,VpaLinha]:= '';

    if VprDConsumo.PecasMT <> 0 then
      GProdutos.Cells[22,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDConsumo.PecasMT)
    else
      GProdutos.Cells[22,VpaLinha]:= '';
    if VprDConsumo.IndiceMT <> 0 then
      GProdutos.Cells[23,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDConsumo.IndiceMT)
    else
      GProdutos.Cells[23,VpaLinha]:= '';
    GProdutos.Cells[24,VpaLinha]:= VprDConsumo.DesObservacoes;
  end;
end;

{******************************************************************************}
procedure TFMontaKit.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GProdutos.Cells[1,GProdutos.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
    GProdutos.col := 1;
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GProdutos.col := 1;
    end
    else
      if not Existecor then
      begin
        VpaValidos := false;
        Aviso(CT_CORINEXISTENTE);
        GProdutos.Col := 3;
      end
      else
        if not ExisteFaca then
        begin
          VpaValidos := false;
          Aviso('FACA NÃO CADASTRADA!!!!'#13'A faca digitada não existe cadastrada.');
          GProdutos.Col := 10;
        end
        else
          if not ExisteMaquina then
          begin
            VpaValidos := false;
            Aviso('MAQUINA NÃO CADASTRADA!!!!'#13'A maquina digitada não existe cadastrada.');
            GProdutos.Col := 14;
          end
          else
            if not ExisteEntretela then
            begin
              VpaValidos := false;
              Aviso('ENTRETELA NÃO CADASTRADA!!!!'#13'A entretela digitada não existe cadastrada.');
              GProdutos.Col := 16;
            end
            else
              if not ExisteTermoColante then
              begin
                VpaValidos := false;
                Aviso('TERMOCOLANTE NÃO CADASTRADO!!!!'#13'O termocolante digitada não existe cadastrado.');
                GProdutos.Col := 19;
              end;

  if VpaValidos then
  begin
    VprDConsumo.UnidadeParentes.free;
    VprDConsumo.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDConsumo.UMOriginal);
    if (VprDConsumo.UnidadeParentes.IndexOf(GProdutos.Cells[6,GProdutos.Alinha]) < 0) then
    begin
      VpaValidos := false;
      aviso(CT_UNIDADEVAZIA);
      GProdutos.col := 6;
    end
    else
      if GProdutos.Cells[7,GProdutos.ALinha] = '' then
      begin
        VpaValidos := false;
        aviso('QUANTIDADE DO PRODUTO INVÁLIDA!!!'#13'É necessário preencher a quantidade do produto.');
        GProdutos.col := 7;
      end
      else
        if GProdutos.Cells[8,GProdutos.ALinha] = '' then
        begin
          VpaValidos := false;
          aviso('VALOR UNITÁRIO DO PRODUTO INVÁLIDO!!!'#13'É necessário preencher o valor unitário do produto.');
          GProdutos.col := 8;
        end;
  end;
  if vpaValidos then
  begin
    CarDConsumo;
    if VprDConsumo.QtdProduto = 0 then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      GProdutos.col := 7
    end
    else
      if VprDConsumo.ValorUnitario = 0 then
      begin
        VpaValidos := false;
        aviso('VALOR UNITÁRIO DO PRODUTO INVÁLIDO!!!'#13'É necessário preencher o valor unitário do produto com um valor diferente de 0.');
        GProdutos.col := 8;
      end;
    if VpaValidos then
    begin
      if (VprDConsumo.QtdEntretela = 0)and (VprDConsumo.CodProdutoEntretela <> '') then
        VprDConsumo.QtdEntretela := 1;
      if (VprDConsumo.QtdTermoColante = 0)and (VprDConsumo.CodProdutoTermoColante <> '') then
        VprDConsumo.QtdTermoColante := 1
    end;
  end;
  if VpaValidos then
  begin
    if FunProdutos.CorReferenciaDuplicada(VprDProduto) then
    begin
      VpaValidos := false;
      Aviso('COR REFERENCIA DUPLICADA!!!'#13'A cor de referencia não pode ser duplicada.');
      GProdutos.Col := 5;
    end;
  end;
end;

{******************************************************************************}
procedure TFMontaKit.GProdutosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3,10,14,18,21 :  Value := '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFMontaKit.GProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GProdutos.Col of
        1: LocalizaProduto;
        3: ECor.AAbreLocalizacao;
        10: EFaca.AAbreLocalizacao;
        14: EMaquina.AAbreLocalizacao;
        16: LocalizaEntretela;
        19: LocalizaTermocolante;
      end;
    end;
    115 :
    begin
      FMontaKitBastidor := TFMontaKitBastidor.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMontaKitBastidor'));
      FMontaKitBastidor.AdicionaBastidores(VprDConsumo);
      FMontaKitBastidor.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFMontaKit.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application, '', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.Showmodal;
  FCores.free;
  Localiza.AtualizaConsulta;
  atualizaConsulta(VprDProduto.SeqProduto);
end;

{******************************************************************************}
procedure TFMontaKit.ECorEnter(Sender: TObject);
begin
  ECor.clear;
end;

{******************************************************************************}
procedure TFMontaKit.ECorRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GProdutos.Cells[3,GProdutos.ALinha] := ECor.Text;
    GProdutos.Cells[4,GProdutos.ALinha] := Retorno1;
    GProdutos.AEstadoGrade := egEdicao;
  end;
end;

{******************************************************************************}
procedure TFMontaKit.GProdutosKeyPress(Sender: TObject; var Key: Char);
begin
  case GProdutos.Col of
    7,8,12,13: if Key = '.' then
         Key:= ',';
  end;
end;

{******************************************************************************}
procedure TFMontaKit.GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDProduto.ConsumosMP.Count >0 then
  begin
    VprDConsumo := TRBDConsumoMP(VprDProduto.ConsumosMP.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDConsumo.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFMontaKit.GProdutosNovaLinha(Sender: TObject);
begin
  VprDConsumo := VprDProduto.AddConsumoMP;
  VprDConsumo.CorKit := ECorKit.AInteiro;
end;

{******************************************************************************}
procedure TFMontaKit.GProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProdutos.AColuna <> ACol then
    begin
      case GProdutos.AColuna of
        1 :if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               GProdutos.Cells[1,GProdutos.ALinha] := '';
               GProdutos.Col := 1;
             end;
           end;
        3 : if GProdutos.Cells[3,GProdutos.Alinha] <> '' then
            begin
              if not Existecor then
              begin
                Aviso(CT_CORINEXISTENTE);
                GProdutos.Col := 3;
                abort;
              end;
            end;
        6 : if not ExisteUM then
            begin
              aviso(CT_UNIDADEVAZIA);
              GProdutos.col := 6;
              abort;
            end;
        7,8,9 :begin
               CalculaValorTotalItem;
             end;
        10: if not ExisteFaca then
              if not EFaca.AAbreLocalizacao then
              begin
                GProdutos.Cells[10,GProdutos.ALinha]:= '';
                GProdutos.Col:= 10;
                Aviso('CÓDIGO DA FACA INVÁLIDA!!!'#13'É necessário informar o código da faca.');
                abort;
              end;
        12,13 : CalculaConsumos;
        14: if not ExisteMaquina then
              if not EMaquina.AAbreLocalizacao then
              begin
                GProdutos.Cells[14,GProdutos.ALinha]:= '';
                GProdutos.Col:= 14;
                abort;
              end;
        16: if not ExisteEntretela then
            begin
              if not LocalizaProduto then
              begin
                GProdutos.Cells[16,GProdutos.ALinha] := '';
                GProdutos.Col := 16;
              end;
           end;
        19: if not ExisteTermoColante then
            begin
              if not LocalizaProduto then
              begin
                GProdutos.Cells[19,GProdutos.ALinha] := '';
                GProdutos.Col := 19;
              end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFMontaKit.GProdutosEnter(Sender: TObject);
begin
  if config.ConsumodoProdutoporCombinacao then
  begin
    if ECorKit.AInteiro = 0 then
    begin
      aviso('COR DO PRODUTO NÃO PREENCHIDO!!!'#13'Antes de preencher o consumo de materia prima é necessário selecionar a que cor o produto se refere.');
      ECorKit.SetFocus;
    end;
  end;
end;

{******************************************************************************}
procedure TFMontaKit.ECorKitRetorno(Retorno1, Retorno2: String);
var
  VpfResultado : String;
begin
  if retorno1 <> '' then
  begin
    begin
      VpfResultado := FunProdutos.GravaDConsumoMP(VprDProduto,VprCorKitAnterior);
      if VpfResultado <> '' then
      begin
        ECorKit.AInteiro := VprCorKitAnterior;
        aviso(VpfResultado);
      end
      else
        CarGrade;
    end;
  end;
end;

{******************************************************************************}
procedure TFMontaKit.Copiar1Click(Sender: TObject);
begin
  VprCorKitCopia := ECorKit.AInteiro;
end;

{******************************************************************************}
procedure TFMontaKit.Colar1Click(Sender: TObject);
begin
  if VprCorKitCopia <> 0 then
    CopiaConsumo;
end;

{******************************************************************************}
procedure TFMontaKit.EFacaRetorno(Retorno1, Retorno2: String);
begin
  GProdutos.Cells[10,GProdutos.ALinha]:= Retorno1;
  GProdutos.Cells[11,GProdutos.ALinha]:= Retorno2;
  GProdutos.AEstadoGrade := egEdicao;
end;

{******************************************************************************}
function TFMontaKit.ExisteFaca: Boolean;
begin
  Result:= True;
  if GProdutos.Cells[10,GProdutos.ALinha] <> '' then
  begin
    Result:= FunProdutos.ExisteFaca(StrToInt(GProdutos.Cells[10,GProdutos.ALinha]),VprDConsumo.Faca);
    if Result then
    begin
      VprDConsumo.CodFaca:= VprDConsumo.Faca.CodFaca;
      GProdutos.Cells[11,GProdutos.ALinha]:= VprDConsumo.Faca.NomFaca;
      CalculaConsumos;
    end;
  end
  else
  begin
    VprDConsumo.CodFaca := 0;
    VprDConsumo.Faca.CodFaca := 0;
    VprDConsumo.Faca.NomFaca := '';
  end;
end;

{******************************************************************************}
procedure TFMontaKit.EMaquinaRetorno(Retorno1, Retorno2: String);
begin
  GProdutos.Cells[14,GProdutos.ALinha]:= Retorno1;
  GProdutos.Cells[15,GProdutos.ALinha]:= Retorno2;
  GProdutos.AEstadoGrade := egEdicao;
end;

{******************************************************************************}
function TFMontaKit.ExisteMaquina: Boolean;
begin
  Result:= True;
  if GProdutos.Cells[14,GProdutos.ALinha] <> '' then
  begin
    Result:= FunProdutos.ExisteMaquina(StrToInt(GProdutos.Cells[14,GProdutos.ALinha]),VprDConsumo.Maquina);
    if Result then
    begin
      VprDConsumo.CodMaquina:= VprDConsumo.Maquina.CodMaquina;
      GProdutos.Cells[15,GProdutos.ALinha]:= VprDConsumo.Maquina.NomMaquina;
    end;
  end
  else
  begin
    VprDConsumo.Maquina.CodMaquina := 0;
    VprDConsumo.Maquina.NomMaquina := '';
    VprDConsumo.CodMaquina := 0;
  end;
end;

{******************************************************************************}
procedure TFMontaKit.ImportaConsumoAmostra1Click(Sender: TObject);
Var
  VpfCodAmostra : String;
begin
  if Entrada('Amostra','Amostra : ',VpfCodAmostra,false,ECor.Color,PCor.Color) then
  begin
    FunAmostra.CopiaConsumoAmostraProduto(StrToInt(VpfcodAmostra),VprDProduto.SeqProduto);
    CarGrade;
  end;
end;

{******************************************************************************}
procedure TFMontaKit.AtualizaConsulta(VpaSeqProduto : integer);
begin
 AdicionaSQLAbreTabela(MOVKIT, 'select PRO.C_COD_PRO, CON.SEQPRODUTO, CON.SEQLOG, CON.DATLOG, CON.CODUSUARIO, USU.C_NOM_USU, CON.DESCAMINHOLOG ' +
                               ' from consumoprodutolog CON, CADPRODUTOS PRO, CADUSUARIOS USU ' +
                               ' WHERE CON.SEQPRODUTO = PRO.I_SEQ_PRO AND ' +
                               ' CON.CODUSUARIO = USU.I_COD_USU '+
                               ' AND CON.SEQPRODUTO = '+ IntToStr(VpaSeqProduto));
 MOVKIT.Open;

end;

{******************************************************************************}
procedure TFMontaKit.Bastidores1Click(Sender: TObject);
begin
  FMontaKitBastidor := TFMontaKitBastidor.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMontaKitBastidor'));
  FMontaKitBastidor.AdicionaBastidores(VprDConsumo);
  FMontaKitBastidor.free;
end;

Initialization
 RegisterClasses([TFMontaKit]);
end.
