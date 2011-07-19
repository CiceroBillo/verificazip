unit AProdutosOrcados;

interface

uses
  UnDados, UnServicos,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  ComCtrls, Grids, CGrades;

type
  TRBDColunaGradeProdutosOrcados = (clPOAprovado, clPOCodigo, clPOProduto, clPOUM, clPOQuantidade, clPOValUnitario, clPOValTotal, clPODatProducao, clPODesNumSerie);

  TFProdutosOrcados = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    PanelColor1: TPanelColor;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    LNomProduto: TLabel;
    Label1: TLabel;
    EProduto: TEditLocaliza;
    ENumSerie: TEditColor;
    Localiza: TConsultaPadrao;
    PanelColor3: TPanelColor;
    PageControl1: TPageControl;
    PProdutosOrcados: TTabSheet;
    PServicosOrcados: TTabSheet;
    GProdutosOrcados: TRBStringGridColor;
    GServicosOrcados: TRBStringGridColor;
    PProdutosaProduzir: TTabSheet;
    GProdutosaProduzir: TRBStringGridColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EProdutoSelect(Sender: TObject);
    procedure GProdutosOrcadosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosOrcadosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosOrcadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosOrcadosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosOrcadosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosOrcadosNovaLinha(Sender: TObject);
    procedure GProdutosOrcadosSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure GServicosOrcadosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GServicosOrcadosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GServicosOrcadosGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure GServicosOrcadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GServicosOrcadosKeyPress(Sender: TObject; var Key: Char);
    procedure GServicosOrcadosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GServicosOrcadosNovaLinha(Sender: TObject);
    procedure GServicosOrcadosSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure GProdutosOrcadosCellClick(Button: TMouseButton;
      Shift: TShiftState; VpaColuna, VpaLinha: Integer);
    procedure GServicosOrcadosCellClick(Button: TMouseButton;
      Shift: TShiftState; VpaColuna, VpaLinha: Integer);
    procedure PageControl1Change(Sender: TObject);
    procedure GProdutosaProduzirDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosaProduzirCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosaProduzirKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosaProduzirKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosaProduzirMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosaProduzirNovaLinha(Sender: TObject);
    procedure GProdutosaProduzirSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GProdutosaProduzirGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: string);
    procedure GProdutosaProduzirClick(Sender: TObject);
    procedure GProdutosOrcadosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
  private
    VprAcao: Boolean;
    VprProdutoAnterior,
    VprServicoAnterior: String;
    // utilizar o servico anterior por causa do valor unitário, que seria zerado
    // ao mudar de linha
    VprDChamado: TRBDChamado;
    VprDProdutoChamado: TRBDChamadoProduto;
    VprDChamadoProdutoOrcado: TRBDChamadoProdutoOrcado;
    VprDChamadoProdutoaProduzir: TRBDChamadoProdutoaProduzir;
    VprDChamadoServicoOrcado: TRBDChamadoServicoOrcado;
    FunServico: TFuncoesServico;
    procedure CarTitulosGrade;
    function ExisteProduto: Boolean;
    function ExisteProdutoaProduzir: Boolean;
    function ExisteServico: Boolean;
    function LocalizaProduto: Boolean;
    function LocalizaProdutoaProduzir: Boolean;
    function LocalizaServico: Boolean;
    procedure CarDClasseProdutoOrcado;
    procedure CarDClasseServicosOrcados;
    procedure CarDClasseProdutoaProduzir;
    procedure CarDClasseProdutoOrcadoaPartirProdutosaProduzir;
    procedure CarValoresGrade;
    procedure CarValoresProdutoGrade;
    procedure CarValoresProdutoaProduzirGrade;
    procedure CalculaValorTotalProduto;
    procedure CalculaValorTotalServico;
    procedure CalculaValorTotalProdutoaProduzir;
    function RColunaGradeProdutoOrcados(VpaColuna: TRBDColunaGradeProdutosOrcados): integer;
  public
    function CadastraProdutosOrcados(VpaDChamado: TRBDChamado; VpaDProdutoChamado: TRBDChamadoProduto): Boolean;
  end;

var
  FProdutosOrcados: TFProdutosOrcados;

implementation
uses
  APrincipal, ConstMsg, FunString, UnProdutos, Constantes, ALocalizaProdutos,
  ANovoServico, ALocalizaServico, FunData;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProdutosOrcados.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  FunServico:= TFuncoesServico.Cria(FPrincipal.BaseDados);
  PageControl1.ActivePage:= PProdutosOrcados;
  ActiveControl:= GProdutosOrcados;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProdutosOrcados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunServico.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFProdutosOrcados.CarTitulosGrade;
begin
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),0] := 'Aprovado';
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOCodigo),0] := 'Código';
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOProduto),0] := 'Produto';
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOUM),0] := 'UM';
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOQuantidade),0] := 'Quantidade';
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValUnitario),0] := 'Valor Unitário';
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValTotal),0] := 'Valor Total';
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPODatProducao),0] := 'Data Produção';
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPODesNumSerie),0] := 'Numero serie';

  GServicosOrcados.Cells[1,0]:= 'Aprovado';
  GServicosOrcados.Cells[2,0]:= 'Código';
  GServicosOrcados.Cells[3,0]:= 'Serviço';
  GServicosOrcados.Cells[4,0]:= 'Quantidade';
  GServicosOrcados.Cells[5,0]:= 'Valor Unitário';
  GServicosOrcados.Cells[6,0]:= 'Valor Total';

  GProdutosaProduzir.Cells[1,0]:= 'Código';
  GProdutosaProduzir.Cells[2,0]:= 'Produto';
  GProdutosaProduzir.Cells[3,0]:= 'UM';
  GProdutosaProduzir.Cells[4,0]:= 'Quantidade';
  GProdutosaProduzir.Cells[5,0]:= 'Valor Unitário';
  GProdutosaProduzir.Cells[6,0] := 'Valor Total';
end;

{******************************************************************************}
function TFProdutosOrcados.ExisteProduto: Boolean;
begin
  Result:= False;
  if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOCodigo),GProdutosOrcados.ALinha] <> '' then
  begin
    if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOCodigo),GProdutosOrcados.ALinha] = VprProdutoAnterior then
      Result:= True
    else
    begin
      VprDChamadoProdutoOrcado.CodProduto:= GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOCodigo),GProdutosOrcados.ALinha];
      Result:= FunProdutos.ExisteProduto(VprDChamadoProdutoOrcado.CodProduto,VprDChamadoProdutoOrcado);
      if Result then
      begin
        VprDChamadoProdutoOrcado.UnidadesParentes.Free;
        VprDChamadoProdutoOrcado.UnidadesParentes:= FunProdutos.RUnidadesParentes(VprDChamadoProdutoOrcado.DesUM);
        GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOCodigo),GProdutosOrcados.ALinha]:= VprDChamadoProdutoOrcado.CodProduto;
        VprProdutoAnterior:= VprDChamadoProdutoOrcado.CodProduto;
        GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOProduto),GProdutosOrcados.ALinha]:= VprDChamadoProdutoOrcado.NomProduto;
        GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOUM),GProdutosOrcados.ALinha]:= VprDChamadoProdutoOrcado.DesUM;
        CarValoresProdutoGrade;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFProdutosOrcados.ExisteProdutoaProduzir: Boolean;
begin
  Result:= False;
  if GProdutosaProduzir.Cells[1,GProdutosaProduzir.ALinha] <> '' then
  begin
    if GProdutosaProduzir.Cells[1,GProdutosaProduzir.ALinha] = VprProdutoAnterior then
      Result:= True
    else
    begin
      VprDChamadoProdutoaProduzir.CodProduto:= GProdutosaProduzir.Cells[1,GProdutosaProduzir.ALinha];
      Result:= FunProdutos.ExisteProduto(VprDChamadoProdutoaProduzir.CodProduto,VprDChamadoProdutoaProduzir);
      if Result then
      begin
        VprDChamadoProdutoaProduzir.UnidadesParentes.Free;
        VprDChamadoProdutoaProduzir.UnidadesParentes:= FunProdutos.RUnidadesParentes(VprDChamadoProdutoaProduzir.DesUM);
        GProdutosaProduzir.Cells[1,GProdutosaProduzir.ALinha]:= VprDChamadoProdutoaProduzir.CodProduto;
        VprProdutoAnterior:= VprDChamadoProdutoaProduzir.CodProduto;
        GProdutosaProduzir.Cells[2,GProdutosaProduzir.ALinha]:= VprDChamadoProdutoaProduzir.NomProduto;
        GProdutosaProduzir.Cells[3,GProdutosaProduzir.ALinha]:= VprDChamadoProdutoaProduzir.DesUM;
        CarValoresProdutoaProduzirGrade;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFProdutosOrcados.LocalizaProduto: Boolean;
var
  VpfClaFiscal: String;
begin
  FLocalizaProduto:= TFLocalizaProduto.CriarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VprDChamado,VprDChamadoProdutoOrcado);
  FLocalizaProduto.Free;
  if Result then
  begin
    VprDChamadoProdutoOrcado.UnidadesParentes.Free;
    VprDChamadoProdutoOrcado.UnidadesParentes:= FunProdutos.RUnidadesParentes(VprDChamadoProdutoOrcado.DesUM);
    VprProdutoAnterior:= VprDChamadoProdutoOrcado.CodProduto;
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOCodigo),GProdutosOrcados.ALinha]:= VprDChamadoProdutoOrcado.CodProduto;
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOProduto),GProdutosOrcados.ALinha]:= VprDChamadoProdutoOrcado.NomProduto;
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOUM),GProdutosOrcados.ALinha]:= VprDChamadoProdutoOrcado.DesUM;
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOQuantidade),GProdutosOrcados.ALinha]:= FormatFloat(varia.MascaraQTd,VprDChamadoProdutoOrcado.Quantidade);
    CarValoresProdutoGrade;
  end;
end;

{******************************************************************************}
function TFProdutosOrcados.LocalizaProdutoaProduzir: Boolean;
var
  VpfClaFiscal: String;
begin
  FLocalizaProduto:= TFLocalizaProduto.CriarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VprDChamado,VprDChamadoProdutoaProduzir);
  FLocalizaProduto.Free;
  if Result then
  begin
    VprDChamadoProdutoaProduzir.UnidadesParentes.Free;
    VprDChamadoProdutoaProduzir.UnidadesParentes:= FunProdutos.RUnidadesParentes(VprDChamadoProdutoaProduzir.DesUM);
    VprProdutoAnterior:= VprDChamadoProdutoaProduzir.CodProduto;
    GProdutosaProduzir.Cells[1,GProdutosaProduzir.ALinha]:= VprDChamadoProdutoaProduzir.CodProduto;
    GProdutosaProduzir.Cells[2,GProdutosaProduzir.ALinha]:= VprDChamadoProdutoaProduzir.NomProduto;
    GProdutosaProduzir.Cells[3,GProdutosaProduzir.ALinha]:= VprDChamadoProdutoaProduzir.DesUM;
    GProdutosaProduzir.Cells[4,GProdutosaProduzir.ALinha]:= FormatFloat(varia.MascaraQTd,VprDChamadoProdutoaProduzir.Quantidade);
    CarValoresProdutoaProduzirGrade;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.CarDClasseProdutoaProduzir;
begin
  VprDChamadoProdutoaProduzir.CodProduto:= GProdutosaProduzir.Cells[1,GProdutosaProduzir.ALinha];
  VprDChamadoProdutoaProduzir.NomProduto:= GProdutosaProduzir.Cells[2,GProdutosaProduzir.ALinha];
  VprDChamadoProdutoaProduzir.DesUM:= GProdutosaProduzir.Cells[3,GProdutosaProduzir.ALinha];

  if GProdutosaProduzir.Cells[4,GProdutosaProduzir.ALinha] <> '' then
    VprDChamadoProdutoaProduzir.Quantidade:= StrToFloat(DeletaChars(GProdutosaProduzir.Cells[4,GProdutosaProduzir.ALinha],'.'))
  else
    VprDChamadoProdutoaProduzir.Quantidade:= 0;
  if GProdutosaProduzir.Cells[5,GProdutosaProduzir.ALinha] <> '' then
    VprDChamadoProdutoaProduzir.ValUnitario:= StrToFloat(DeletaChars(GProdutosaProduzir.Cells[5,GProdutosaProduzir.ALinha],'.'))
  else
    VprDChamadoProdutoaProduzir.ValUnitario:= 0;
  VprDChamadoProdutoaProduzir.ValTotal:= VprDChamadoProdutoaProduzir.ValUnitario * VprDChamadoProdutoaProduzir.Quantidade;
end;

{******************************************************************************}
procedure TFProdutosOrcados.CarDClasseProdutoOrcado;
begin
  if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),GProdutosOrcados.ALinha] = 'S' then
    VprDChamadoProdutoOrcado.IndAprovado:= True
  else
    VprDChamadoProdutoOrcado.IndAprovado:= False;
  VprDChamadoProdutoOrcado.CodProduto:= GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOCodigo),GProdutosOrcados.ALinha];
  if config.PermiteAlteraNomeProdutonaCotacao then
    VprDChamadoProdutoOrcado.NomProduto:= GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOProduto),GProdutosOrcados.ALinha];
  VprDChamadoProdutoOrcado.DesUM:= GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOUM),GProdutosOrcados.ALinha];

  if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOQuantidade),GProdutosOrcados.ALinha] <> '' then
    VprDChamadoProdutoOrcado.Quantidade:= StrToFloat(DeletaChars(GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOQuantidade),GProdutosOrcados.ALinha],'.'))
  else
    VprDChamadoProdutoOrcado.Quantidade:= 0;
  if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValUnitario),GProdutosOrcados.ALinha] <> '' then
    VprDChamadoProdutoOrcado.ValUnitario:= StrToFloat(DeletaChars(GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValUnitario),GProdutosOrcados.ALinha],'.'))
  else
    VprDChamadoProdutoOrcado.ValUnitario:= 0;
  VprDChamadoProdutoOrcado.ValTotal:= VprDChamadoProdutoOrcado.ValUnitario * VprDChamadoProdutoOrcado.Quantidade;
  VprDChamadoProdutoOrcado.DesNumSerie:= GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPODesNumSerie), GProdutosOrcados.ALinha];
end;

{******************************************************************************}
procedure TFProdutosOrcados.CarDClasseProdutoOrcadoaPartirProdutosaProduzir;
begin
  VprDChamadoProdutoOrcado:= VprDProdutoChamado.AddProdutoOrcado;
  VprDChamadoProdutoOrcado.IndAprovado:= False;
  VprDChamadoProdutoOrcado.CodProduto:= GProdutosaProduzir.Cells[1,GProdutosaProduzir.ALinha];
  VprDChamadoProdutoOrcado.NomProduto:= GProdutosaProduzir.Cells[2,GProdutosaProduzir.ALinha];
  VprDChamadoProdutoOrcado.DesUM:= GProdutosaProduzir.Cells[3,GProdutosaProduzir.ALinha];

  if GProdutosaProduzir.Cells[4,GProdutosaProduzir.ALinha] <> '' then
    VprDChamadoProdutoOrcado.Quantidade:= StrToFloat(DeletaChars(GProdutosaProduzir.Cells[4,GProdutosaProduzir.ALinha],'.'))
  else
    VprDChamadoProdutoOrcado.Quantidade:= 0;
  if GProdutosaProduzir.Cells[5,GProdutosaProduzir.ALinha] <> '' then
    VprDChamadoProdutoOrcado.ValUnitario:= StrToFloat(DeletaChars(GProdutosaProduzir.Cells[5,GProdutosaProduzir.ALinha],'.'))
  else
    VprDChamadoProdutoOrcado.ValUnitario:= 0;
  VprDChamadoProdutoOrcado.ValTotal:= VprDChamadoProdutoOrcado.ValUnitario * VprDChamadoProdutoOrcado.Quantidade;
end;

{******************************************************************************}
function TFProdutosOrcados.CadastraProdutosOrcados(VpaDChamado: TRBDChamado; VpaDProdutoChamado: TRBDChamadoProduto): Boolean;
begin
  VprDChamado:= VpaDChamado;
  VprDProdutoChamado:= VpaDProdutoChamado;
  GProdutosOrcados.ADados:= VpaDProdutoChamado.ProdutosOrcados;
  GProdutosOrcados.CarregaGrade;
  GServicosOrcados.ADados:= VpaDProdutoChamado.ServicosOrcados;
  GServicosOrcados.CarregaGrade;
  GProdutosaProduzir.ADados:= VpaDProdutoChamado.ProdutosaProduzir;
  GProdutosaProduzir.CarregaGrade;
  EProduto.Text:= VpaDProdutoChamado.CodProduto;
  EProduto.Atualiza;
  ENumSerie.Text:= VpaDProdutoChamado.NumSerie;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFProdutosOrcados.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text:= 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text:= 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFProdutosOrcados.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
function TFProdutosOrcados.ExisteServico: Boolean;
begin
  Result:= False;
  if GServicosOrcados.Cells[2,GServicosOrcados.ALinha] <> '' then
  begin
    if GServicosOrcados.Cells[2,GServicosOrcados.ALinha] = VprServicoAnterior then
      Result:= True
    else
    begin
      VprDChamadoServicoOrcado.CodServico:= StrToInt(GServicosOrcados.Cells[2,GServicosOrcados.ALinha]);
      Result:= FunServico.ExisteServico(VprDChamadoServicoOrcado.CodServico,VprDChamadoServicoOrcado);
      if Result then
      begin
        GServicosOrcados.Cells[2,GServicosOrcados.ALinha]:= IntToStr(VprDChamadoServicoOrcado.CodServico);
        GServicosOrcados.Cells[3,GServicosOrcados.ALinha]:= VprDChamadoServicoOrcado.NomServico;
        VprServicoAnterior:= IntToStr(VprDChamadoServicoOrcado.CodServico);

        CarValoresGrade;
        CalculaValorTotalServico;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosaProduzirCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDChamadoProdutoaProduzir:= TRBDChamadoProdutoaProduzir(VprDProdutoChamado.ProdutosaProduzir.Items[VpaLinha-1]);

  GProdutosaProduzir.Cells[1,VpaLinha]:= VprDChamadoProdutoaProduzir.CodProduto;
  GProdutosaProduzir.Cells[2,VpaLinha]:= VprDChamadoProdutoaProduzir.NomProduto;
  GProdutosaProduzir.Cells[3,VpaLinha]:= VprDChamadoProdutoaProduzir.DesUM;
  CarValoresProdutoaProduzirGrade;
end;

procedure TFProdutosOrcados.GProdutosaProduzirClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosaProduzirDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteProdutoaProduzir then
  begin
    VpaValidos:= False;
    GProdutosaProduzir.Col:= 1;
    aviso('PRODUTO NÃO CADASTRADO!!!'#13'É necessário informar um produto que esteja cadastrado.');
  end
  else
    if VprDChamadoProdutoaProduzir.UnidadesParentes.IndexOf(GProdutosaProduzir.Cells[3,GProdutosaProduzir.ALinha]) < 0 then
    begin
      VpaValidos:= False;
      GProdutosaProduzir.Col:= 3;
      aviso('UNIDADE INVÁLIDA!!!'#13'A unidade preenchida é inválida.');
    end
    else
      if GProdutosaProduzir.Cells[4,GProdutosaProduzir.ALinha] = '' then
      begin
        VpaValidos:= False;
        GProdutosaProduzir.Col:= 4;
        aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher uma quantidade.');
      end
      else
        if GProdutosaProduzir.Cells[5,GProdutosaProduzir.ALinha] = '' then
        begin
          VpaValidos:= False;
          GProdutosaProduzir.Col:= 5;
          aviso('VALOR UNITÁRIO NÃO PREENCHIDO!!!'#13'É necessário preencher o valor unitário.');
        end
        else
        begin
          CalculaValorTotalProdutoaProduzir;
          if GProdutosaProduzir.Cells[6,GProdutosaProduzir.ALinha] = '' then
          begin
            VpaValidos:= False;
            GProdutosaProduzir.Col:= 7;
            aviso('VALOR TOTAL NÃO PREENCHIDO!!!'#13'É necessário preencher o valor total.');
          end;
        end;
  if VpaValidos then
  begin
    CarDClasseProdutoaProduzir;
    if VprDChamadoProdutoaProduzir.Quantidade = 0 then
    begin
      VpaValidos:= False;
      GProdutosaProduzir.Col:= 4;
      aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher uma quantidade.');
    end
    else
      if VprDChamadoProdutoaProduzir.ValUnitario = 0 then
      begin
        VpaValidos:= False;
        GProdutosaProduzir.Col:= 5;
        aviso('VALOR UNITÁRIO NÃO PREENCHIDO!!!'#13'É necessário preencher o valor unitário.');
      end;
  end;
end;

procedure TFProdutosOrcados.GProdutosaProduzirGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  case ACol of
    7 :  Value := FPrincipal.CorFoco.AMascaraData;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosaProduzirKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    114: case GProdutosaProduzir.AColuna of
           1: LocalizaProdutoaProduzir;
         end;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosaProduzirKeyPress(Sender: TObject;
  var Key: Char);
begin
  case GProdutosaProduzir.AColuna of
    5,6: if Key in [',','.'] then
             Key:= DecimalSeparator;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosaProduzirMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProdutoChamado.ProdutosaProduzir.Count > 0 then
  begin
    VprDChamadoProdutoaProduzir:= TRBDChamadoProdutoaProduzir(VprDProdutoChamado.ProdutosaProduzir.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior:= VprDChamadoProdutoaProduzir.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosaProduzirNovaLinha(Sender: TObject);
begin
  VprDChamadoProdutoaProduzir:= VprDProdutoChamado.AddProdutoaProduzir;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosaProduzirSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutosaProduzir.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProdutosaProduzir.AColuna <> ACol then
    begin
      case GProdutosaProduzir.AColuna of
        1: if not ExisteProdutoaProduzir then
           begin
             if not LocalizaProdutoaProduzir then
             begin
               GProdutosaProduzir.Cells[1,GProdutosOrcados.ALinha]:= '';
               GProdutosaProduzir.Cells[2,GProdutosOrcados.ALinha]:= '';
               Abort;
             end;
           end;
        5,6: CalculaValorTotalProdutoaProduzir;
      end;
    end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosOrcadosCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDChamadoProdutoOrcado:= TRBDChamadoProdutoOrcado(VprDProdutoChamado.ProdutosOrcados.Items[VpaLinha-1]);

  if VprDChamadoProdutoOrcado.IndAprovado then
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),VpaLinha]:= '1'
  else
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),VpaLinha]:= '0';
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOCodigo),VpaLinha]:= VprDChamadoProdutoOrcado.CodProduto;
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOProduto),VpaLinha]:= VprDChamadoProdutoOrcado.NomProduto;
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOUM),VpaLinha]:= VprDChamadoProdutoOrcado.DesUM;
  if VprDChamadoProdutoOrcado.DatProducao > MontaData(1,1,1900) then
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPODatProducao),VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDChamadoProdutoOrcado.DatProducao)
  else
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPODatProducao),VpaLinha] := '';
  GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPODesNumSerie),VpaLinha]:= VprDChamadoProdutoOrcado.DesNumSerie;
  CarValoresProdutoGrade;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosOrcadosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;

  if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),GProdutosOrcados.ALinha] = '' then
  begin
    VpaValidos:= False;
    GProdutosOrcados.Col:= RColunaGradeProdutoOrcados(clPOAprovado);
    aviso('CAMPO APROVADO NÃO PREENCHIDO!!!'#13'É necessário preencher se o produto foi aprovado.');
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos:= False;
      GProdutosOrcados.Col:= RColunaGradeProdutoOrcados(clPOCodigo);
      aviso('PRODUTO NÃO CADASTRADO!!!'#13'É necessário informar um produto que esteja cadastrado.');
    end
    else
      if VprDChamadoProdutoOrcado.UnidadesParentes.IndexOf(GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOUM),GProdutosOrcados.ALinha]) < 0 then
      begin
        VpaValidos:= False;
        GProdutosOrcados.Col:= RColunaGradeProdutoOrcados(clPOUM);
        aviso('UNIDADE INVÁLIDA!!!'#13'A unidade preenchida é inválida.');
      end
      else
        if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOQuantidade),GProdutosOrcados.ALinha] = '' then
        begin
          VpaValidos:= False;
          GProdutosOrcados.Col:= RColunaGradeProdutoOrcados(clPOQuantidade);
          aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher uma quantidade.');
        end
        else
          if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValUnitario),GProdutosOrcados.ALinha] = '' then
          begin
            VpaValidos:= False;
            GProdutosOrcados.Col:= RColunaGradeProdutoOrcados(clPOValUnitario);
            aviso('VALOR UNITÁRIO NÃO PREENCHIDO!!!'#13'É necessário preencher o valor unitário.');
          end
          else
          begin
            CalculaValorTotalProduto;
            if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValTotal),GProdutosOrcados.ALinha] = '' then
            begin
              VpaValidos:= False;
              GProdutosOrcados.Col:= RColunaGradeProdutoOrcados(clPOValTotal);
              aviso('VALOR TOTAL NÃO PREENCHIDO!!!'#13'É necessário preencher o valor total.');
            end;
          end;
  if VpaValidos then
  begin
    CarDClasseProdutoOrcado;
    if VprDChamadoProdutoOrcado.Quantidade = 0 then
    begin
      VpaValidos:= False;
      GProdutosOrcados.Col:= RColunaGradeProdutoOrcados(clPOQuantidade);
      aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher uma quantidade.');
    end
    else
      if VprDChamadoProdutoOrcado.ValUnitario = 0 then
      begin
        VpaValidos:= False;
        GProdutosOrcados.Col:= RColunaGradeProdutoOrcados(clPOValUnitario);
        aviso('VALOR UNITÁRIO NÃO PREENCHIDO!!!'#13'É necessário preencher o valor unitário.');
      end;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosOrcadosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  if RColunaGradeProdutoOrcados(clPODatProducao) = GProdutosOrcados.Col then
    Value := '!99/00/0000;1;_';
end;

{******************************************************************************}
procedure TFProdutosOrcados.CalculaValorTotalProduto;
begin
  if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOQuantidade),GProdutosOrcados.ALinha] <> '' then
    VprDChamadoProdutoOrcado.Quantidade:= StrToFloat(DeletaChars(GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOQuantidade),GProdutosOrcados.ALinha],'.'))
  else
    VprDChamadoProdutoOrcado.Quantidade:= 0;
  if GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValUnitario),GProdutosOrcados.ALinha] <> '' then
    VprDChamadoProdutoOrcado.ValUnitario:= StrToFloat(DeletaChars(GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValUnitario),GProdutosOrcados.ALinha],'.'))
  else
    VprDChamadoProdutoOrcado.ValUnitario:= 0;

  VprDChamadoProdutoOrcado.ValTotal:= VprDChamadoProdutoOrcado.ValUnitario * VprDChamadoProdutoOrcado.Quantidade;

  if VprDChamadoProdutoOrcado.ValTotal <> 0 then
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValTotal),GProdutosOrcados.ALinha]:= FormatFloat(Varia.MascaraValor,VprDChamadoProdutoOrcado.ValTotal)
  else
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValTotal),GProdutosOrcados.ALinha]:= '';
end;

{******************************************************************************}
procedure TFProdutosOrcados.CalculaValorTotalProdutoaProduzir;
begin
  if GProdutosaProduzir.Cells[4,GProdutosOrcados.ALinha] <> '' then
    VprDChamadoProdutoaProduzir.Quantidade:= StrToFloat(DeletaChars(GProdutosaProduzir.Cells[4,GProdutosaProduzir.ALinha],'.'))
  else
    VprDChamadoProdutoaProduzir.Quantidade:= 0;
  if GProdutosaProduzir.Cells[5,GProdutosOrcados.ALinha] <> '' then
    VprDChamadoProdutoaProduzir.ValUnitario:= StrToFloat(DeletaChars(GProdutosaProduzir.Cells[5,GProdutosaProduzir.ALinha],'.'))
  else
    VprDChamadoProdutoaProduzir.ValUnitario:= 0;

  VprDChamadoProdutoaProduzir.ValTotal:= VprDChamadoProdutoaProduzir.ValUnitario * VprDChamadoProdutoaProduzir.Quantidade;

  if VprDChamadoProdutoaProduzir.ValTotal <> 0 then
    GProdutosaProduzir.Cells[6,GProdutosaProduzir.ALinha]:= FormatFloat(Varia.MascaraValor,VprDChamadoProdutoaProduzir.ValTotal)
  else
    GProdutosaProduzir.Cells[6,GProdutosaProduzir.ALinha]:= '';
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosOrcadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    114: if RColunaGradeProdutoOrcados(clPOCodigo) = GProdutosOrcados.Col then
           LocalizaProduto;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosOrcadosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if RColunaGradeProdutoOrcados(clPOAprovado) = GProdutosOrcados.Col then
  begin
    if not (key in ['s','S','n','N',#8,#13]) then
      key := #0
    else
      if key = 's' Then
        key := 'S'
      else
        if key = 'n' Then
          key := 'N';
  end
  else
  begin
    if (RColunaGradeProdutoOrcados(clPOQuantidade) = GProdutosOrcados.Col) or
       (RColunaGradeProdutoOrcados(clPOValUnitario) = GProdutosOrcados.Col) or
       (RColunaGradeProdutoOrcados(clPOValTotal) = GProdutosOrcados.Col) then
     // Key:= DecimalSeparator;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosOrcadosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProdutoChamado.ProdutosOrcados.Count > 0 then
  begin
    VprDChamadoProdutoOrcado:= TRBDChamadoProdutoOrcado(VprDProdutoChamado.ProdutosOrcados.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior:= VprDChamadoProdutoOrcado.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosOrcadosNovaLinha(Sender: TObject);
begin
  VprDChamadoProdutoOrcado:= VprDProdutoChamado.AddProdutoOrcado;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosOrcadosSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutosOrcados.AEstadoGrade in [egInsercao,EgEdicao] then
  begin
    if GProdutosOrcados.AColuna <> ACol then
    begin
      if RColunaGradeProdutoOrcados(clPOAprovado) = GProdutosOrcados.Col then
      begin
        if Length(GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),GProdutosOrcados.ALinha]) > 1 then
          begin
             GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),GProdutosOrcados.ALinha]:= '';
             GProdutosOrcados.Col:= RColunaGradeProdutoOrcados(clPOAprovado);
             aviso('CAMPO APROVADO NÃO PREENCHIDO CORRETAMENTE!!!'#13'É necessário preencher se o produto foi aprovado apenas com S ou N.');
             Abort;
          end;
      end
      else
      begin
        if RColunaGradeProdutoOrcados(clPOCodigo) = GProdutosOrcados.Col then
        begin
          if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOCodigo),GProdutosOrcados.ALinha]:= '';
               GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOProduto),GProdutosOrcados.ALinha]:= '';
               Abort;
             end;
           end;
        end
        else
        begin
          if (RColunaGradeProdutoOrcados(clPOQuantidade) = GProdutosOrcados.Col) or
             (RColunaGradeProdutoOrcados(clPOValUnitario) = GProdutosOrcados.Col) then
            CalculaValorTotalProduto;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GServicosOrcadosCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDChamadoServicoOrcado:= TRBDChamadoServicoOrcado(VprDProdutoChamado.ServicosOrcados.Items[VpaLinha-1]);

  if VprDChamadoServicoOrcado.IndAprovado then
    GServicosOrcados.Cells[1,VpaLinha]:= '1'
  else
    GServicosOrcados.Cells[1,VpaLinha]:= '0';
  if VprDChamadoServicoOrcado.CodServico <> 0 then
    GServicosOrcados.Cells[2,VpaLinha]:= IntToStr(VprDChamadoServicoOrcado.CodServico)
  else
    GServicosOrcados.Cells[2,VpaLinha]:= '';
  GServicosOrcados.Cells[3,VpaLinha]:= VprDChamadoServicoOrcado.NomServico;
  if VprDChamadoServicoOrcado.QtdServico <> 0 then
    GServicosOrcados.Cells[4,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDChamadoServicoOrcado.QtdServico)
  else
    GServicosOrcados.Cells[4,VpaLinha]:= '';
  if VprDChamadoServicoOrcado.ValUnitario <> 0 then
    GServicosOrcados.Cells[5,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDChamadoServicoOrcado.ValUnitario)
  else
    GServicosOrcados.Cells[5,VpaLinha]:= '';
  if VprDChamadoServicoOrcado.ValTotal <> 0 then
    GServicosOrcados.Cells[6,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDChamadoServicoOrcado.ValTotal)
  else
    GServicosOrcados.Cells[6,VpaLinha]:= '';
end;

{******************************************************************************}
procedure TFProdutosOrcados.GServicosOrcadosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteServico then
  begin
    VpaValidos:= False;
    GServicosOrcados.Col:= 2;
    aviso('SERVIÇO NÃO CADASTRADO!!!'#13'É necessário informar um serviço que esteja cadastrado.');
  end
  else
    if GServicosOrcados.Cells[4,GServicosOrcados.ALinha] = '' then
    begin
      VpaValidos:= False;
      GServicosOrcados.Col:= 4;
      aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher uma quantidade.');
    end
    else
      if GServicosOrcados.Cells[5,GServicosOrcados.ALinha] = '' then
      begin
        VpaValidos:= False;
        GServicosOrcados.Col:= 5;
        aviso('VALOR UNITÁRIO NÃO PREENCHIDO!!!'#13'É necessário preencher o valor unitário.');
      end
      else
      begin
        CalculaValorTotalServico;
        if GServicosOrcados.Cells[6,GServicosOrcados.ALinha] = '' then
        begin
          VpaValidos:= False;
          GServicosOrcados.Col:= 6;
          aviso('VALOR TOTAL NÃO PREENCHIDO!!!'#13'É necessário preencher o valor total.');
        end;
      end;

  if VpaValidos then
  begin
    CarDClasseServicosOrcados;
    if VprDChamadoServicoOrcado.QtdServico = 0 then
    begin
      VpaValidos:= False;
      GServicosOrcados.Col:= 4;
      aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher uma quantidade.');
    end
    else
      if VprDChamadoServicoOrcado.ValUnitario = 0 then
      begin
        VpaValidos:= False;
        GServicosOrcados.Col:= 5;
        aviso('VALOR UNITÁRIO NÃO PREENCHIDO!!!'#13'É necessário preencher o valor unitário.');
      end;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.CarDClasseServicosOrcados;
begin
  if GServicosOrcados.Cells[1,GServicosOrcados.ALinha] = 'S' then
    VprDChamadoServicoOrcado.IndAprovado:= True
  else
    VprDChamadoServicoOrcado.IndAprovado:= False;
  if GServicosOrcados.Cells[2,GServicosOrcados.ALinha] <> '' then
    VprDChamadoServicoOrcado.CodServico:= StrToInt(GServicosOrcados.Cells[2,GServicosOrcados.ALinha])
  else
    VprDChamadoServicoOrcado.CodServico:= 0;
  VprDChamadoServicoOrcado.NomServico:= GServicosOrcados.Cells[3,GServicosOrcados.ALinha];
  if GServicosOrcados.Cells[4,GServicosOrcados.ALinha] <> '' then
    VprDChamadoServicoOrcado.QtdServico:= StrToFloat(DeletaChars(GServicosOrcados.Cells[4,GServicosOrcados.ALinha],'.'))
  else
    VprDChamadoServicoOrcado.QtdServico:= 0;
  if GServicosOrcados.Cells[5,GServicosOrcados.ALinha] <> '' then
    VprDChamadoServicoOrcado.ValUnitario:= StrToFloat(DeletaChars(GServicosOrcados.Cells[5,GServicosOrcados.ALinha],'.'))
  else
    VprDChamadoServicoOrcado.ValUnitario:= 0;
end;

{******************************************************************************}
procedure TFProdutosOrcados.CalculaValorTotalServico;
begin
  if GServicosOrcados.Cells[4,GServicosOrcados.ALinha] <> '' then
    VprDChamadoServicoOrcado.QtdServico:= StrToFloat(DeletaChars(GServicosOrcados.Cells[4,GServicosOrcados.ALinha],'.'))
  else
    VprDChamadoServicoOrcado.QtdServico:= 0;
  if GServicosOrcados.Cells[5,GServicosOrcados.ALinha] <> '' then
    VprDChamadoServicoOrcado.ValUnitario:= StrToFloat(DeletaChars(GServicosOrcados.Cells[5,GServicosOrcados.ALinha],'.'))
  else
    VprDChamadoServicoOrcado.ValUnitario:= 0;

  VprDChamadoServicoOrcado.ValTotal:= VprDChamadoServicoOrcado.QtdServico*VprDChamadoServicoOrcado.ValUnitario;

  if VprDChamadoServicoOrcado.ValTotal <> 0 then
    GServicosOrcados.Cells[6,GServicosOrcados.ALinha]:= FormatFloat(Varia.MascaraValor,VprDChamadoServicoOrcado.ValTotal)
  else
    GServicosOrcados.Cells[6,GServicosOrcados.ALinha]:= '';
end;

{******************************************************************************}
procedure TFProdutosOrcados.GServicosOrcadosGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  case ACol of
    2: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GServicosOrcadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    114: case GServicosOrcados.AColuna of
           2: LocalizaServico;
         end;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GServicosOrcadosKeyPress(Sender: TObject;
  var Key: Char);
begin
  case GServicosOrcados.AColuna of
    1: begin
         if not (key in ['s','S','n','N',#8,#13]) then
           key := #0
         else
           if key = 's' Then
             key := 'S'
           else
             if key = 'n' Then
               key := 'N';
       end;
    4,5,6: if Key in [',','.'] then
             Key:= DecimalSeparator;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GServicosOrcadosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProdutoChamado.ServicosOrcados.Count > 0 then
  begin
    VprDChamadoServicoOrcado:= TRBDChamadoServicoOrcado(VprDProdutoChamado.ServicosOrcados.Items[VpaLinhaAtual-1]);
    VprServicoAnterior:= IntToStr(VprDChamadoServicoOrcado.CodServico);    
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GServicosOrcadosNovaLinha(Sender: TObject);
begin
  VprDChamadoServicoOrcado:= VprDProdutoChamado.AddServicoOrcado;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GServicosOrcadosSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if GServicosOrcados.AEstadoGrade in [egInsercao,EgEdicao] then
    if GServicosOrcados.AColuna <> ACol then
    begin
      case GServicosOrcados.AColuna of
        1: if Length(GServicosOrcados.Cells[1,GServicosOrcados.ALinha]) > 1 then
           begin
             GServicosOrcados.Cells[1,GServicosOrcados.ALinha]:= '';
             GServicosOrcados.Col:= 1;
             aviso('CAMPO APROVADO NÃO PREENCHIDO CORRETAMENTE!!!'#13'É necessário preencher se o serviço foi aprovado apenas com S ou N.');
             Abort;
           end;
        2: if not ExisteServico then
           begin
             if not LocalizaServico then
             begin
               GServicosOrcados.Cells[2,GServicosOrcados.ALinha]:= '';
               GServicosOrcados.Cells[3,GServicosOrcados.ALinha]:= '';
               Abort;
             end;
           end;
        4,5,6: CalculaValorTotalServico;
      end;
    end;
end;

{******************************************************************************}
function TFProdutosOrcados.LocalizaServico: Boolean;
begin
  FLocalizaServico:= TFLocalizaServico.CriarSDI(Application,'',True);
  Result:= FlocalizaServico.LocalizaServico(VprDChamadoServicoOrcado);
  FlocalizaServico.Free;
  if Result then
  begin
    if GServicosOrcados.Cells[2,GServicosOrcados.ALinha] <> IntToStr(VprDChamadoServicoOrcado.CodServico) then
    begin
      VprServicoAnterior:= IntToStr(VprDChamadoServicoOrcado.CodServico);

      GServicosOrcados.Cells[2,GServicosOrcados.ALinha]:= IntToStr(VprDChamadoServicoOrcado.CodServico);
      GServicosOrcados.Cells[3,GServicosOrcados.ALinha]:= VprDChamadoServicoOrcado.NomServico;

      CarValoresGrade;
      CalculaValorTotalServico;
      GServicosOrcados.AEstadoGrade:= egEdicao;
    end;
  end;
end;

procedure TFProdutosOrcados.PageControl1Change(Sender: TObject);
begin

end;

{******************************************************************************}
function TFProdutosOrcados.RColunaGradeProdutoOrcados(VpaColuna: TRBDColunaGradeProdutosOrcados): integer;
begin
  case VpaColuna of
    clPOAprovado: result:= 1;
    clPOCodigo: result:= 2;
    clPOProduto: result:= 3;
    clPOUM: result:= 4;
    clPOQuantidade: result:= 5;
    clPOValUnitario: result:= 6;
    clPOValTotal: result:= 7;
    clPODatProducao: result:= 8;
    clPODesNumSerie: result:= 9;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.CarValoresGrade;
begin
  if VprDChamadoServicoOrcado.QtdServico <> 0 then
    GServicosOrcados.Cells[4,GServicosOrcados.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDChamadoServicoOrcado.QtdServico)
  else
    GServicosOrcados.Cells[4,GServicosOrcados.ALinha]:= '';
  if VprDChamadoServicoOrcado.ValUnitario <> 0 then
    GServicosOrcados.Cells[5,GServicosOrcados.ALinha]:= FormatFloat(Varia.MascaraValor,VprDChamadoServicoOrcado.ValUnitario)
  else
    GServicosOrcados.Cells[5,GServicosOrcados.ALinha]:= '';
end;

{******************************************************************************}
procedure TFProdutosOrcados.CarValoresProdutoaProduzirGrade;
begin
  if VprDChamadoProdutoaProduzir.Quantidade <> 0 then
    GProdutosaProduzir.Cells[4,GProdutosaProduzir.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDChamadoProdutoaProduzir.Quantidade)
  else
    GProdutosaProduzir.Cells[4,GProdutosaProduzir.ALinha]:= '';
  if VprDChamadoProdutoaProduzir.ValUnitario <> 0 then
    GProdutosaProduzir.Cells[5,GProdutosaProduzir.ALinha]:= FormatFloat(Varia.MascaraValor,VprDChamadoProdutoaProduzir.ValUnitario)
  else
    GProdutosaProduzir.Cells[5,GProdutosaProduzir.ALinha]:= '';
  if VprDChamadoProdutoaProduzir.ValTotal <> 0 then
    GProdutosaProduzir.Cells[6,GProdutosaProduzir.ALinha]:= FormatFloat(Varia.MascaraValor,VprDChamadoProdutoaProduzir.ValTotal)
  else
    GProdutosaProduzir.Cells[6,GProdutosaProduzir.ALinha]:= '';
end;

{******************************************************************************}
procedure TFProdutosOrcados.CarValoresProdutoGrade;
begin
  if VprDChamadoProdutoOrcado.Quantidade <> 0 then
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOQuantidade),GProdutosOrcados.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDChamadoProdutoOrcado.Quantidade)
  else
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOQuantidade),GProdutosOrcados.ALinha]:= '';
  if VprDChamadoProdutoOrcado.ValUnitario <> 0 then
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValUnitario),GProdutosOrcados.ALinha]:= FormatFloat(Varia.MascaraValor,VprDChamadoProdutoOrcado.ValUnitario)
  else
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValUnitario),GProdutosOrcados.ALinha]:= '';
  if VprDChamadoProdutoOrcado.ValTotal <> 0 then
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValTotal),GProdutosOrcados.ALinha]:= FormatFloat(Varia.MascaraValor,VprDChamadoProdutoOrcado.ValTotal)
  else
    GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOValTotal),GProdutosOrcados.ALinha]:= '';
end;

{******************************************************************************}
procedure TFProdutosOrcados.GProdutosOrcadosCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VpaColuna = 1) then
  begin
    if (GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),VpaLinha] = '0')or (GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),VpaLinha] = '') then
    begin
      GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),VpaLinha] := '1';
      TRBDChamadoProdutoOrcado(VprDProdutoChamado.ProdutosOrcados.Items[VpaLinha-1]).IndAprovado := true;
    end
    else
    begin
      GProdutosOrcados.Cells[RColunaGradeProdutoOrcados(clPOAprovado),VpaLinha] := '0';
      TRBDChamadoProdutoOrcado(VprDProdutoChamado.ProdutosOrcados.Items[VpaLinha-1]).IndAprovado := false;
    end;
  end;
end;

{******************************************************************************}
procedure TFProdutosOrcados.GServicosOrcadosCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VpaColuna = 1) then
  begin
    if (GServicosOrcados.Cells[1,VpaLinha] = '0')or (GServicosOrcados.Cells[1,VpaLinha] = '') then
    begin
      GServicosOrcados.Cells[1,VpaLinha] := '1';
      TRBDChamadoServicoOrcado(VprDProdutoChamado.ServicosOrcados.Items[VpaLinha-1]).IndAprovado := true;
    end
    else
    begin
      GServicosOrcados.Cells[1,VpaLinha] := '0';
      TRBDChamadoServicoOrcado(VprDProdutoChamado.ServicosOrcados.Items[VpaLinha-1]).IndAprovado := false;
    end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFProdutosOrcados]);
end.
