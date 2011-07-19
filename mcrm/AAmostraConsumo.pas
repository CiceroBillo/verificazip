unit AAmostraConsumo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  StdCtrls, Buttons, UnDadosProduto, UnProdutos, Constantes, UnAmostra,
  ComCtrls, UnServicos, Mask, numericos, UnDadosLocaliza, Menus;

type
  TRBDColunaGradeValorVenda =(clVVQtdAmostra,clVVValVenda,clVVCodTabelaPreco,clVVNomTabelaPreco,clVVPerlucro,clVVPerComissao,clVVVAlCustoMateriaPrima,clVVValCustoProcesso,clVVValCustoMaoObraBordado,clVVVAlCustoProduto,clVVValCustoComImpostos,clVVValSemItensEspeciais);
  TFAmostraConsumo = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;    
    PanelColor1: TPanelColor;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    ECorKit: TEditLocaliza;
    Localiza: TConsultaPadrao;
    ECor: TEditLocaliza;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    EFaca: TEditLocaliza;
    EMaquina: TEditLocaliza;
    PanelColor3: TPanelColor;
    Paginas: TPageControl;
    PMateriaPrima: TTabSheet;
    Grade: TRBStringGridColor;
    PItensEspeciais: TTabSheet;
    GItensEspeciais: TRBStringGridColor;
    PanelColor4: TPanelColor;
    PValorVenda: TTabSheet;
    ETotalPontos: Tnumerico;
    Label3: TLabel;
    ETipoMateriaPrima: TRBEditLocaliza;
    PanelColor5: TPanelColor;
    GQuantidade: TRBStringGridColor;
    GValorVenda: TRBStringGridColor;
    EPerLucro: Tnumerico;
    EPerComissao: Tnumerico;
    LPerLucro: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EValSugerido: Tnumerico;
    GPrecoCliente: TRBStringGridColor;
    BitBtn1: TBitBtn;
    EQtdTrocasLinha: Tnumerico;
    Label7: TLabel;
    Label8: TLabel;
    EQtdCortes: Tnumerico;
    PopupMenu1: TPopupMenu;
    Copiar1: TMenuItem;
    Colar1: TMenuItem;
    BImprimir: TBitBtn;
    PImagem: TTabSheet;
    PanelColor6: TPanelColor;
    EImagem: TEditColor;
    Label9: TLabel;
    BExportaFicha: TBitBtn;
    EProspect: TRBEditLocaliza;
    PProcessos: TTabSheet;
    GProcessos: TRBStringGridColor;
    ECodEstagio: TRBEditLocaliza;
    ECodProcessoProd: TRBEditLocaliza;
    Label10: TLabel;
    EPrecoEstimado: Tnumerico;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure ECorKitCadastrar(Sender: TObject);
    procedure ECorKitRetorno(Retorno1, Retorno2: String);
    procedure BGravarClick(Sender: TObject);
    procedure GradeEnter(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure EFacaRetorno(Retorno1, Retorno2: String);
    procedure EMaquinaRetorno(Retorno1, Retorno2: String);
    procedure ECorCadastrar(Sender: TObject);
    procedure ETipoMateriaPrimaCadastrar(Sender: TObject);
    procedure ETipoMateriaPrimaRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GQuantidadeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GQuantidadeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GQuantidadeGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
    procedure GQuantidadeMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
    procedure GQuantidadeNovaLinha(Sender: TObject);
    procedure GValorVendaCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GValorVendaDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GValorVendaMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
    procedure EPerLucroEnter(Sender: TObject);
    procedure EPerLucroExit(Sender: TObject);
    procedure EPerComissaoEnter(Sender: TObject);
    procedure EPerComissaoExit(Sender: TObject);
    procedure EValSugeridoEnter(Sender: TObject);
    procedure EValSugeridoExit(Sender: TObject);
    procedure GPrecoClienteCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure BitBtn1Click(Sender: TObject);
    procedure EQtdCortesExit(Sender: TObject);
    procedure GItensEspeciaisCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GItensEspeciaisDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GItensEspeciaisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaginasChange(Sender: TObject);
    procedure GItensEspeciaisKeyPress(Sender: TObject; var Key: Char);
    procedure GItensEspeciaisMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GItensEspeciaisNovaLinha(Sender: TObject);
    procedure GItensEspeciaisSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Copiar1Click(Sender: TObject);
    procedure Colar1Click(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BExportaFichaClick(Sender: TObject);
    procedure GPrecoClienteDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GPrecoClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GPrecoClienteSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure EProspectRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GProcessosDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GProcessosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GProcessosNovaLinha(Sender: TObject);
    procedure GProcessosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodProcessoProdRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ECodEstagioRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GProcessosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GItensEspeciaisDepoisExclusao(Sender: TObject);
    procedure ECodProcessoProdCadastrar(Sender: TObject);
    procedure ECodProcessoProdSelect(Sender: TObject);
    procedure GProcessosMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
    procedure ECodEstagioCadastrar(Sender: TObject);
    procedure GValorVendaSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    VprProdutoAnterior,
    VprItemEspecialAnterior: String;
    VprCorAmostraAnterior, VprCorAmostraCopia : Integer;
    VprAcao : Boolean;
    VprPerLucro,
    VprPerComissao,
    VprValSugerido : Double;
    VprDAmostra: TRBDAmostra;
    VprDConsumoAmostra: TRBDConsumoAmostra;
    VprDItemEspecial : TRBDItensEspeciaisAmostra;
    VprDQuantidadeAmostra : TRBDQuantidadeAmostra;
    VprDValorVendaAmostra : TRBDValorVendaAmostra;
    VprDPrecoCliente : TRBDPrecoClienteAmostra;
    VprDAmostraProcesso : TRBDAmostraProcesso;
    FunAmostra : TRBFuncoesAmostra;
    procedure CarTitulosGrade;
    procedure CarQtdPecaMetroGrade;
    procedure CarregaDadosClasse;
    procedure CarDClasse;
    procedure CarDProcessosAmostra;
    procedure CarDItensEspeciais;
    function LocalizaProduto: Boolean;
    function LocalizaItemEspecial : Boolean;
    function ExisteProduto: Boolean;
    function ExisteItemEspecial : boolean;
    function ExisteCor: Boolean;
    function ExisteFaca : Boolean;
    function ExisteMaquina : Boolean;
    function ExisteUM : Boolean;
    procedure CalculaValorTotalItem;
    procedure CalculaValorVenda;
    procedure CarGrade;
    function GravaConsumo : string;
    procedure CalculaConsumos;
    procedure CarComissaoLucroPadrao;
    procedure InicializaPaginaValorVenda;
    procedure CopiaConsumo;
    function RColunaGrade(VpaColuna : TRBDColunaGradeValorVenda):Integer;
    procedure ConfiguraTela;
  public
    function ConsumosAmostra(VpaDAmostra: TRBDAmostra): Boolean;
  end;

var
  FAmostraConsumo: TFAmostraConsumo;

implementation
uses
  APrincipal, ConstMSG, ALocalizaProdutos, funString, ACores, FunObjeto,
  ALocalizaServico, ATipoMateriaPrima, UnClientes, dmRave, ANovoProcessoProducao, ANovoEstagio;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFAmostraConsumo.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  Paginas.ActivePage := PMateriaPrima;
  VprDConsumoAmostra := TRBDConsumoAmostra.cria;
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  CarTitulosGrade;
  CarComissaoLucroPadrao;
  ConfiguraTela;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAmostraConsumo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAmostraConsumo.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Produto';
  Grade.Cells[3,0] := 'Código';
  Grade.Cells[4,0] := 'Cor';
  Grade.Cells[5,0] := 'UM';
  Grade.Cells[6,0] := 'Quantidade';
  Grade.Cells[7,0] := 'Valor Unitario';
  Grade.Cells[8,0] := 'Valor Total';
  Grade.Cells[9,0] := 'Legenda';
  Grade.Cells[10,0] := 'Sequen.';
  Grade.Cells[11,0] := 'Qtd Pontos';
  Grade.Cells[12,0] := 'Código';
  Grade.Cells[13,0] := 'Tipo Material';
  Grade.Cells[14,0] := 'Código';
  Grade.Cells[15,0] := 'Faca';
  Grade.Cells[16,0] := 'Lar Molde';
  Grade.Cells[17,0] := 'Alt Molde';
  Grade.Cells[18,0] := 'Código';
  Grade.Cells[19,0] := 'Máquina';
  Grade.Cells[20,0] := 'Código';
  Grade.Cells[21,0] := 'Entretela';
  Grade.Cells[22,0] := 'Qtd';
  Grade.Cells[23,0] := 'Código';
  Grade.Cells[24,0] := 'Termocolante';
  Grade.Cells[25,0] := 'Qtd';
  Grade.Cells[26,0] := 'Pcs em MT';
  Grade.Cells[27,0] := 'Indice MT';
  Grade.Cells[28,0] := 'Observações';

  GItensEspeciais.Cells[1,0] := 'Código';
  GItensEspeciais.Cells[2,0] := 'Produto';
  GItensEspeciais.Cells[3,0] := 'Valor';
  GItensEspeciais.Cells[4,0] := 'Descrição Adicional';

  GQuantidade.Cells[1,0] := 'Quantidade';

  GValorVenda.Cells[RColunaGrade(clVVQtdAmostra),0] := 'Quantidade';
  GValorVenda.Cells[RColunaGrade(clVVValVenda),0] := 'Valor Venda';
  GValorVenda.Cells[RColunaGrade(clVVCodTabelaPreco),0] := 'Codigo';
  GValorVenda.Cells[RColunaGrade(clVVNomTabelaPreco),0] := 'Tabela';
  if config.CalcularPrecoAmostracomValorLucroenaoPercentual then
    GValorVenda.Cells[RColunaGrade(clVVPerlucro),0] := 'Valor Lucro'
  else
    GValorVenda.Cells[RColunaGrade(clVVPerlucro),0] := '%Lucro';
  GValorVenda.Cells[RColunaGrade(clVVPerComissao),0] := '%Comissão';
  GValorVenda.Cells[RColunaGrade(clVVVAlCustoMateriaPrima),0] := 'Custo Mat Prima';
  GValorVenda.Cells[RColunaGrade(clVVValCustoProcesso),0] := 'Custo Processos';
  GValorVenda.Cells[RColunaGrade(clVVValCustoMaoObraBordado),0] := 'Custo M.O Bordado';
  GValorVenda.Cells[RColunaGrade(clVVVAlCustoProduto),0] := 'Custo Produto';
  GValorVenda.Cells[RColunaGrade(clVVValCustoComImpostos),0] := 'Custo com Impostos';
  GValorVenda.Cells[RColunaGrade(clVVValSemItensEspeciais),0] := 'Preço sem Items Especiais';

  GPrecoCliente.Cells[1,0] := 'Quantidade';
  GPrecoCliente.Cells[2,0] := 'Valor Venda';
  GPrecoCliente.Cells[3,0] := 'Código';
  GPrecoCliente.Cells[4,0] := 'Tabela';
  GPrecoCliente.Cells[5,0] := '% Lucro';
  GPrecoCliente.Cells[6,0] := '% Comissão';
  GPrecoCliente.Cells[7,0] := 'Codigo';
  GPrecoCliente.Cells[8,0] := 'Cliente';

  GProcessos.Cells[1,0] := 'Código';
  GProcessos.Cells[2,0] := 'Estágio';
  GProcessos.Cells[3,0] := 'Código';
  GProcessos.Cells[4,0] := 'Processo';
  GProcessos.Cells[5,0] := 'Qtd. Horas';
  GProcessos.Cells[6,0] := 'Configuração';
  GProcessos.Cells[7,0] := 'Tempo Config.';
  GProcessos.Cells[8,0] := 'Valor Unitario';
  GProcessos.Cells[9,0] := 'Observações';
end;

{******************************************************************************}
procedure TFAmostraConsumo.CarQtdPecaMetroGrade;
begin
  if VprDConsumoAmostra.QtdPecasemMetro <> 0 then
    Grade.Cells[26,Grade.ALinha]:= FormatFloat('###,###,##0.00',VprDConsumoAmostra.QtdPecasemMetro)
  else
    Grade.Cells[26,Grade.ALinha]:= '';
  if VprDConsumoAmostra.ValIndiceConsumo <> 0 then
    Grade.Cells[27,Grade.ALinha]:= FormatFloat('###,###,##0.00',VprDConsumoAmostra.ValIndiceConsumo)
  else
    Grade.Cells[27,Grade.ALinha]:= '';
end;

{******************************************************************************}
procedure TFAmostraConsumo.GValorVendaCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDValorVendaAmostra := TRBDValorVendaAmostra(VprDAmostra.ValoresVenda.Items[VpaLinha-1]);
  GValorVenda.Cells[RColunaGrade(clVVQtdAmostra),GValorVenda.ALinha]:= FormatFloat('#,###,###,###,##0',VprDValorVendaAmostra.Quantidade);
  GValorVenda.Cells[RColunaGrade(clVVValVenda),GValorVenda.ALinha]:= FormatFloat('#,###,###,###,##0.000',VprDValorVendaAmostra.ValVenda);
  GValorVenda.Cells[RColunaGrade(clVVCodTabelaPreco),GValorVenda.ALinha]:= IntToStr(VprDValorVendaAmostra.CodTabela);
  GValorVenda.Cells[RColunaGrade(clVVNomTabelaPreco),GValorVenda.ALinha]:= VprDValorVendaAmostra.NomTabela;
  GValorVenda.Cells[RColunaGrade(clVVPerlucro),GValorVenda.ALinha]:= FormatFloat('#,##0.00',VprDValorVendaAmostra.PerLucro);
  GValorVenda.Cells[RColunaGrade(clVVPerComissao),GValorVenda.ALinha]:= FormatFloat('#,##0.00',VprDValorVendaAmostra.PerComissao);
  GValorVenda.Cells[RColunaGrade(clVVVAlCustoMateriaPrima),GValorVenda.ALinha]:= FormatFloat('#,###,###,##0.00',VprDAmostra.CustoMateriaPrima);
  GValorVenda.Cells[RColunaGrade(clVVValCustoProcesso),GValorVenda.ALinha]:= FormatFloat('#,###,###,##0.00',VprDAmostra.CustoProcessos);
  GValorVenda.Cells[RColunaGrade(clVVValCustoMaoObraBordado),GValorVenda.ALinha]:= FormatFloat('#,###,###,##0.00',VprDAmostra.CustoMaodeObraBordado);
  GValorVenda.Cells[RColunaGrade(clVVVAlCustoProduto),GValorVenda.ALinha]:= FormatFloat('#,###,###,##0.00',VprDAmostra.CustoProduto);
  GValorVenda.Cells[RColunaGrade(clVVValSemItensEspeciais),GValorVenda.ALinha]:= FormatFloat('#,###,###,##0.00',VprDValorVendaAmostra.CustoComImposto);
end;

{******************************************************************************}
procedure TFAmostraConsumo.GValorVendaDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if DeletaChars(GValorVenda.Cells[RColunaGrade(clVVPerlucro),GValorVenda.ALinha],'0') = '' then
  begin
    aviso('PERCENTUAL LUCRO INVÁIDO!!!'#13'O percentual de lucro deve ser preenchida.');
    VpaValidos:= False;
    GValorVenda.Col:= RColunaGrade(clVVPerlucro);
  end;
  if VpaValidos then
  begin
    VprDValorVendaAmostra.PerLucro := StrToFloat(DeletaChars(DeletaChars(GValorVenda.Cells[RColunaGrade(clVVPerlucro),GValorVenda.ALinha],'.'),'%'))
  end;
  if VpaValidos then
  begin
    FunAmostra.CalculaValorVendaUnitario(VprDAmostra,VprDValorVendaAmostra);
    GValorVenda.Cells[RColunaGrade(clVVValVenda),GValorVenda.ALinha]:= FormatFloat('#,###,###,###,##0.000',VprDValorVendaAmostra.ValVenda);
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GValorVendaMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDAmostra.ValoresVenda.Count > 0 then
  begin
    VprDValorVendaAmostra := TRBDValorVendaAmostra(VprDAmostra.ValoresVenda.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GValorVendaSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GValorVenda.AEstadoGrade in [egInsercao,EgEdicao] then
    if GValorVenda.AColuna <> ACol then
    begin
      if RColunaGrade(clVVPerlucro) = GValorVenda.AColuna then
      begin
        VprDValorVendaAmostra.PerLucro := StrToFloat(DeletaChars(DeletaChars(GValorVenda.Cells[RColunaGrade(clVVPerlucro),GValorVenda.ALinha],'.'),'%'));
        FunAmostra.CalculaValorVendaUnitario(VprDAmostra,VprDValorVendaAmostra);
        GValorVenda.Cells[RColunaGrade(clVVValVenda),GValorVenda.ALinha]:= FormatFloat('#,###,###,###,##0.000',VprDValorVendaAmostra.ValVenda);
     end
    end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.InicializaPaginaValorVenda;
begin
  if VprDAmostra.ValoresVenda.Count = 0  then
  begin
    FreeTObjectsList(VprDAmostra.Quantidades);
    VprDQuantidadeAmostra:= VprDAmostra.addQuantidade;
    VprDQuantidadeAmostra.Quantidade := 500;
    if (varia.CNPJFilial <> CNPJ_Telitex) then
    begin
      VprDQuantidadeAmostra:= VprDAmostra.addQuantidade;
      VprDQuantidadeAmostra.Quantidade := 1000;
    end;
    GQuantidade.CarregaGrade;
    FunAmostra.CalculaValorVendaUnitario(VprDAmostra);
  end;
  GValorVenda.CarregaGrade;
end;

{*****************************************************************************}
procedure TFAmostraConsumo.GPrecoClienteCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDPrecoCliente := TRBDPrecoClienteAmostra(VprDAmostra.PrecosClientes.Items[VpaLinha-1]);
  GPrecoCliente.Cells[1,GPrecoCliente.ALinha]:= FormatFloat('#,###,###,###,##0',VprDPrecoCliente.QtdVenda);
  GPrecoCliente.Cells[2,GPrecoCliente.ALinha]:= FormatFloat('#,###,###,###,##0.000',VprDPrecoCliente.ValVenda);
  GPrecoCliente.Cells[3,GPrecoCliente.ALinha]:= IntToStr(VprDPrecoCliente.CodTabela);
  GPrecoCliente.Cells[4,GPrecoCliente.ALinha]:= VprDPrecoCliente.NomTabela;
  GPrecoCliente.Cells[5,GPrecoCliente.ALinha]:= FormatFloat('#,##0.00',VprDPrecoCliente.PerLucro);
  GPrecoCliente.Cells[6,GPrecoCliente.ALinha]:= FormatFloat('#,##0.00',VprDPrecoCliente.PerComissao);
  GPrecoCliente.Cells[7,GPrecoCliente.ALinha]:= IntToStr(VprDPrecoCliente.CodCliente);
  GPrecoCliente.Cells[8,GPrecoCliente.ALinha]:= VprDPrecoCliente.NomCliente;
end;

{*****************************************************************************}
procedure TFAmostraConsumo.GPrecoClienteDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if DeletaChars(DeletaChars(DeletaChars(GPrecoCliente.Cells[2,GPrecoCliente.ALinha],'0'),'.'),',') = '' then
  begin
    aviso('PREÇO CLIENTE INVÁLIDO!!!'#13'O valor do cliente devepercentual deve preenchido.');
    VpaValidos:= False;
    GPrecoCliente.Col:= 2;
  end;
  if VpaValidos then
  begin
    VprDPrecoCliente.ValVenda := StrToFloat(DeletaChars(GPrecoCliente.Cells[2,GPrecoCliente.ALinha],'.'))
  end;
end;

{*****************************************************************************}
procedure TFAmostraConsumo.GPrecoClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vk_f3 then
  begin
    case GPrecoCliente.Col of
      7 :  EProspect.AAbreLocalizacao;
    end;
  end;
end;

{*****************************************************************************}
procedure TFAmostraConsumo.GPrecoClienteSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if GPrecoCliente.AEstadoGrade in [egInsercao, egEdicao] then
  begin
    if GPrecoCliente.AColuna <> ACol then
      case GPrecoCliente.AColuna of
        7: if not EProspect.AExisteCodigo then
             if not EProspect.AAbreLocalizacao then
             begin
               GPrecoCliente.Cells[7,GPrecoCliente.ALinha]:= '';
               Abort;
             end;
      end;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GProcessosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
var
  VpfNomEstagio: String;
begin
  VprDAmostraProcesso := TRBDAmostraProcesso(VprDAmostra.Processos.Items[VpaLinha-1]);
  if VprDAmostraProcesso.CodEstagio <> 0 then
    GProcessos.Cells[1,VpaLinha] := IntToStr(VprDAmostraProcesso.CodEstagio)
  else
    GProcessos.Cells[1,VpaLinha] := '';
  FunProdutos.ExisteEstagio(IntToStr(VprDAmostraProcesso.CodEstagio), VpfNomEstagio);
  GProcessos.Cells[2,VpaLinha] := VpfNomEstagio;
  if VprDAmostraProcesso.CodProcessoProducao <> 0 then
    GProcessos.Cells[3,VpaLinha] := IntToStr(VprDAmostraProcesso.CodProcessoProducao)
  else
    GProcessos.Cells[3,VpaLinha] := '';
  GProcessos.Cells[4,VpaLinha] := FunAmostra.RNomeProcessoProducao(VprDAmostraProcesso.CodProcessoProducao);
  GProcessos.Cells[5,VpaLinha] := FormatFloat('#,##0.00',VprDAmostraProcesso.QtdProducaoHora);
  if VprDAmostraProcesso.Configuracao then
    GProcessos.Cells[6,VpaLinha] := 'S'
  else
    GProcessos.Cells[6,VpaLinha] := 'N';

  GProcessos.Cells[7,VpaLinha] := VprDAmostraProcesso.DesTempoConfiguracao;
  if VprDAmostraProcesso.ValUnitario = 0 then
    GProcessos.Cells[8,GProcessos.ALinha]:= ''
  else
    GProcessos.Cells[8,GProcessos.ALinha]:= FormatFloat('#,###,###,###,##0.000###',VprDAmostraProcesso.ValUnitario);

  GProcessos.Cells[9,VpaLinha] := VprDAmostraProcesso.DesObservacoes;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GProcessosDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ECodEstagio.AExisteCodigo(GProcessos.Cells[1,GProcessos.ALinha]) then
  begin
    GProcessos.Col := 1;
    aviso('ESTAGIO NÃO PREENCHIDO!!!'#13'É necessário digitar o estagio.');
  end
  else
    if not ECodProcessoProd.AExisteCodigo(GProcessos.Cells[3,GProcessos.ALinha]) then
    begin
      GProcessos.Col := 3;
      aviso('PROCESSO NÃO PREENHCIDO!!!'#13'É necessário digitar o processo');
    end;

  if VpaValidos then
  begin
    CarDProcessosAmostra;
    CalculaValorVenda;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GProcessosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin     // F3
      case GProcessos.Col of
        1 : ECodEstagio.AAbreLocalizacao;
        3 : ECodProcessoProd.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GProcessosMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDAmostra.Processos.Count > 0 then
  begin
    VprDAmostraProcesso := TRBDAmostraProcesso(VprDAmostra.Processos.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GProcessosNovaLinha(Sender: TObject);
begin
  VprDAmostraProcesso := VprDAmostra.addProcesso;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GProcessosSelectCell(Sender: TObject; ACol,ARow: Integer; var CanSelect: Boolean);
begin
  if GProcessos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProcessos.AColuna <> ACol then
    begin
      case GProcessos.AColuna of
        1 : if not ECodEstagio.AExisteCodigo(GProcessos.Cells[1,GProcessos.ALinha]) then
            begin
              if not ECodEstagio.AAbreLocalizacao then
              begin
                GProcessos.Cells[1,GProcessos.ALinha] := '';
              end;
            end;
        3 : if not ECodProcessoProd.AExisteCodigo(GProcessos.Cells[3,GProcessos.ALinha]) then
            begin
              if not ECodProcessoProd.AAbreLocalizacao then
              begin
                GProcessos.Cells[3,GProcessos.ALinha] := '';
              end;
            end;
      end;
    end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GQuantidadeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDQuantidadeAmostra  := TRBDQuantidadeAmostra(VprDAmostra.Quantidades.Items[VpaLinha-1]);
  GQuantidade.Cells[1,GQuantidade.ALinha]:= FormatFloat('#,###,###,###0',VprDQuantidadeAmostra.Quantidade);
end;

{******************************************************************************}
procedure TFAmostraConsumo.GQuantidadeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if DeletaChars(GQuantidade.Cells[1,GQuantidade.ALinha],'0') = '' then
  begin
    aviso('INFORME A QUANTIDADE!!!'#13'A quantidade deve ser preenchida.');
    VpaValidos:= False;
    GQuantidade.Col:= 1;
  end;
  if VpaValidos then
  begin
    VprDQuantidadeAmostra.Quantidade:= StrToFloat(DeletaChars(GQuantidade.Cells[1,GQuantidade.ALinha],'.'))
  end;
  if VpaValidos then
  begin
    FunAmostra.CalculaValorVendaUnitario(VprDAmostra);
    GValorVenda.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GQuantidadeGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
begin
  case ACol of
    1 : Value:= '0000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GQuantidadeMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDAmostra.Quantidades.Count > 0 then
  begin
    VprDQuantidadeAmostra:= TRBDQuantidadeAmostra(VprDAmostra.Quantidades.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GQuantidadeNovaLinha(Sender: TObject);
begin
  VprDQuantidadeAmostra:= VprDAmostra.addQuantidade;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDConsumoAmostra:= TRBDConsumoAmostra(VprDAmostra.DCor.Consumos.Items[VpaLinha-1]);
  Grade.Cells[1,Grade.ALinha]:= VprDConsumoAmostra.CodProduto;
  Grade.Cells[2,Grade.ALinha]:= VprDConsumoAmostra.NomProduto;
  if VprDConsumoAmostra.CodCor = 0 then
    Grade.Cells[3,Grade.ALinha]:= ''
  else
    Grade.Cells[3,Grade.ALinha]:= IntToStr(VprDConsumoAmostra.CodCor);
  Grade.Cells[4,Grade.ALinha]:= VprDConsumoAmostra.NomCor;
  Grade.Cells[5,Grade.ALinha]:= VprDConsumoAmostra.DesUM;
  if VprDConsumoAmostra.Qtdproduto = 0 then
    Grade.Cells[6,Grade.ALinha]:= ''
  else
    Grade.Cells[6,Grade.ALinha]:= FormatFloat('#,###,###,###,##0.000#',VprDConsumoAmostra.Qtdproduto);
  if VprDConsumoAmostra.ValUnitario = 0 then
    Grade.Cells[7,Grade.ALinha]:= ''
  else
    Grade.Cells[7,Grade.ALinha]:= FormatFloat('#,###,###,###,##0.000###',VprDConsumoAmostra.ValUnitario);
  if VprDConsumoAmostra.ValTotal = 0 then
    Grade.Cells[8,Grade.ALinha]:= ''
  else
    Grade.Cells[8,Grade.ALinha]:= FormatFloat('#,###,###,###,##0.000###', VprDConsumoAmostra.ValTotal);
  Grade.Cells[9,Grade.ALinha]:= VprDConsumoAmostra.DesLegenda;
  if VprDConsumoAmostra.NumSequencia = 0 then
    Grade.Cells[10,Grade.ALinha]:= ''
  else
    Grade.Cells[10,Grade.ALinha]:= IntToStr(VprDConsumoAmostra.NumSequencia);
  if VprDConsumoAmostra.QtdPontos = 0 then
    Grade.Cells[11,Grade.ALinha]:= ''
  else
    Grade.Cells[11,Grade.ALinha]:= IntToStr(VprDConsumoAmostra.QtdPontos);
  if VprDConsumoAmostra.CodTipoMateriaPrima = 0 then
    Grade.Cells[12,Grade.ALinha]:= ''
  else
    Grade.Cells[12,Grade.ALinha]:= IntToStr(VprDConsumoAmostra.CodTipoMateriaPrima);
  Grade.Cells[13,Grade.ALinha]:= VprDConsumoAmostra.NomTipoMateriaPrima;
  if VprDConsumoAmostra.CodFaca = 0 then
    Grade.Cells[14,Grade.ALinha]:= ''
  else
    Grade.Cells[14,Grade.ALinha]:= IntToStr(VprDConsumoAmostra.CodFaca);
  Grade.Cells[15,Grade.ALinha]:= VprDConsumoAmostra.Faca.NomFaca;
  if VprDConsumoAmostra.LarMolde = 0 then
    Grade.Cells[16,Grade.ALinha]:= ''
  else
  begin
    if config.ConverterMTeCMparaMM then
      Grade.Cells[16,Grade.ALinha]:= FormatFloat('#,##0.00',VprDConsumoAmostra.LarMolde*10)
    else
      Grade.Cells[16,Grade.ALinha]:= FormatFloat('#,##0.00',VprDConsumoAmostra.LarMolde);
  end;
  if VprDConsumoAmostra.AltMolde = 0 then
    Grade.Cells[17,Grade.ALinha]:= ''
  else
  begin
    if config.ConverterMTeCMparaMM then
      Grade.Cells[17,Grade.ALinha]:= FormatFloat('#,##0.00',VprDConsumoAmostra.AltMolde*10)
    else
      Grade.Cells[17,Grade.ALinha]:= FormatFloat('#,##0.00',VprDConsumoAmostra.AltMolde);

  end;
  if VprDConsumoAmostra.CodMaquina = 0 then
    Grade.Cells[18,Grade.ALinha]:= ''
  else
    Grade.Cells[18,Grade.ALinha]:= IntToStr(VprDConsumoAmostra.CodMaquina);
  Grade.Cells[19,Grade.ALinha]:= VprDConsumoAmostra.Maquina.NomMaquina;
  Grade.Cells[20,Grade.ALinha]:= VprDConsumoAmostra.CodEntretela;
  Grade.Cells[21,Grade.ALinha]:= VprDConsumoAmostra.NomEntretela;
  Grade.Cells[28,Grade.ALinha]:= VprDConsumoAmostra.DesObservacao;
  CarQtdPecaMetroGrade;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteProduto then
  begin
    aviso(CT_PRODUTONAOCADASTRADO);
    VpaValidos:= False;
    Grade.Col:= 1;
  end
  else
    if not ExisteCor then
    begin
      aviso('COR INVÁLIDA!!!'#13'A cor digitada não existe cadastrada.');
      VpaValidos:= False;
      Grade.Col:= 3;
    end
    else
      if (VprDConsumoAmostra.UnidadeParentes.IndexOf(Grade.Cells[5,Grade.Alinha]) < 0) then
      begin
        VpaValidos := false;
        aviso(CT_UNIDADEVAZIA);
        Grade.col := 5;
      end
      else
        if Grade.Cells[6,Grade.ALinha] = '' then
        begin
          aviso('INFORME A QUANTIDADE!!!'#13'A quantidade deve ser preenchida.');
          VpaValidos:= False;
          Grade.Col:= 6;
        end
        else
          if not ETipoMateriaPrima.AExisteCodigo(Grade.Cells[12,Grade.ALinha]) then
          begin
            VpaValidos := false;
            aviso('TIPO MATERIAL NÃO CADASTRADO!!!!'#13'O tipo de material digitado não existe cadastrado.');
            Grade.Col := 12;
          end
          else
            if not ExisteFaca then
            begin
              VpaValidos := false;
              aviso('FACA NÃO CADASTRADA!!!!'#13'A faca digitada não existe cadastrada.');
              Grade.Col := 14;
            end
            else
              if not ExisteMaquina then
              begin
                VpaValidos := false;
                aviso('MAQUINA NÃO CADASTRADA!!!!'#13'A maquina digitada não existe cadastrada.');
                Grade.Col := 18;
              end;
{              else
                if not ExisteEntretela then
                begin
                  aviso('ENTRETELA NÃO CADASTRADA!!!!'#13'A entretela digitada não existe cadastrada.');
                  VpaValidos:= Fase;
                  Grade.Col:= 19;
                end}

  if VpaValidos then
  begin
    CarregaDadosClasse;
    FunAmostra.CarQtdPontos(VprDAmostra);
    ETotalPontos.AValor := VprDAmostra.QtdTotalPontos;
    EQtdTrocasLinha.AValor := VprDAmostra.QtdTrocasLinhaBordado;
    CalculaValorVenda;
    if VprDConsumoAmostra.Qtdproduto = 0 then
    begin
      aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do produto.');
      VpaValidos:= False;
      Grade.Col:= 6;
    end
    else
      if ((VprDConsumoAmostra.CodFaca <> 0) or (VprDConsumoAmostra.AltMolde <> 0) or
         (VprDConsumoAmostra.LarMolde <> 0)) and (VprDConsumoAmostra.AltProduto = 0) then
      begin
        aviso('ALTURA DO PRODUTO NÃO PREENCHIDA!!!'#13'Para se calcular o consumo do produto é necessário que a altura do produto esteja preenhcida');
        VpaValidos:= False;
        Grade.Col:= 16;
      end;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.CarregaDadosClasse;
begin
  VprDConsumoAmostra.NomProduto := Grade.Cells[2,Grade.ALinha];
  if Grade.Cells[3,Grade.ALinha] <> '' then
    VprDConsumoAmostra.CodCor:= StrToInt(Grade.Cells[3,Grade.ALinha])
  else
    VprDConsumoAmostra.CodCor:= 0;

  VprDConsumoAmostra.DesUM:= Grade.Cells[5,Grade.ALinha];
  CalculaValorTotalItem;
  VprDConsumoAmostra.DesLegenda:= Grade.Cells[9,Grade.ALinha];

  if Grade.Cells[10,Grade.ALinha] <> '' then
    VprDConsumoAmostra.NumSequencia:= StrToInt(Grade.Cells[10,Grade.ALinha])
  else
    VprDConsumoAmostra.NumSequencia := 0;

  if Grade.Cells[11,Grade.ALinha] <> '' then
    VprDConsumoAmostra.QtdPontos := StrToInt(Grade.Cells[11,Grade.ALinha])
  else
    VprDConsumoAmostra.QtdPontos := 0;

  if Grade.Cells[14,Grade.ALinha] <> '' then
    VprDConsumoAmostra.CodFaca:= StrToInt(Grade.Cells[14,Grade.ALinha])
  else
    VprDConsumoAmostra.CodFaca := 0;
  if Grade.Cells[16,Grade.ALinha] <> '' then
  begin
    if config.ConverterMTeCMparaMM then
      VprDConsumoAmostra.LarMolde:= StrToFloat(Grade.Cells[16,Grade.ALinha])/10
    else
      VprDConsumoAmostra.LarMolde:= StrToFloat(Grade.Cells[16,Grade.ALinha]);
  end
  else
    VprDConsumoAmostra.LarMolde := 0;
  if Grade.Cells[17,Grade.ALinha] <> '' then
  begin
    if config.ConverterMTeCMparaMM then
      VprDConsumoAmostra.AltMolde:= StrToFloat(Grade.Cells[17,Grade.ALinha])/10
    else
      VprDConsumoAmostra.AltMolde:= StrToFloat(Grade.Cells[17,Grade.ALinha]);
  end
  else
    VprDConsumoAmostra.AltMolde := 0;
  if Grade.Cells[18,Grade.ALinha] <> '' then
    VprDConsumoAmostra.CodMaquina:= StrToInt(Grade.Cells[18,Grade.ALinha])
  else
    VprDConsumoAmostra.CodMaquina := 0;
  VprDConsumoAmostra.DesObservacao:= Grade.Cells[28,Grade.ALinha];
end;

{******************************************************************************}
procedure TFAmostraConsumo.CarComissaoLucroPadrao;
var
  VpfPerLucro, VpfPerComissao : Double;
begin
  FunAmostra.CarPerLucroComissaoCoeficienteCusto(Varia.CodCoeficienteCustoPadrao,VpfPerLucro,VpfPerComissao);
  EPerLucro.AValor := VpfPerLucro;
  EPerComissao.AValor := VpfPerComissao;
end;

{******************************************************************************}
procedure TFAmostraConsumo.CarDClasse;
begin
  VprDAmostra.DCor.DesImagemCor := EImagem.Text;
  VprDAmostra.DCor.CodCor := VprCorAmostraAnterior;
  VprDAmostra.DCor.ValPrecoEstimado:= EPrecoEstimado.AValor;
end;

{******************************************************************************}
procedure TFAmostraConsumo.CarDItensEspeciais;
begin
  VprDItemEspecial.ValProduto := StrToFloat(DeletaChars(GItensEspeciais.Cells[3,GItensEspeciais.ALinha],'.'));
  VprDItemEspecial.DesObservacao := GItensEspeciais.Cells[4,GItensEspeciais.ALinha];
end;

{******************************************************************************}
procedure TFAmostraConsumo.CarDProcessosAmostra;
begin
  VprDAmostraProcesso.CodAmostra := VprDAmostra.CodAmostra;
  VprDAmostraProcesso.SeqProcesso := GProcessos.ALinha;
  if GProcessos.Cells[1, GProcessos.ALinha] <> '' then
    VprDAmostraProcesso.CodEstagio := StrToInt(GProcessos.Cells[1, GProcessos.ALinha]);
  if GProcessos.Cells[3, GProcessos.ALinha] <> '' then
    VprDAmostraProcesso.CodProcessoProducao := StrToInt(GProcessos.Cells[3, GProcessos.ALinha]);
  if GProcessos.Cells[5, GProcessos.ALinha] <> '' then
    VprDAmostraProcesso.QtdProducaoHora := StrToFloat(GProcessos.Cells[5, GProcessos.ALinha]);
  VprDAmostraProcesso.Configuracao := GProcessos.Cells[6, GProcessos.ALinha] = 'S';
  VprDAmostraProcesso.DesTempoConfiguracao := GProcessos.Cells[7, GProcessos.ALinha];
  if GProcessos.Cells[8,GProcessos.ALinha] <> '' then
    VprDAmostraProcesso.ValUnitario:= StrToFloat(DeletaChars(GProcessos.Cells[8,GProcessos.ALinha],'.'))
  else
    VprDAmostraProcesso.ValUnitario := 0;
  VprDAmostraProcesso.DesObservacoes:= GProcessos.Cells[9, GProcessos.ALinha];
end;

{******************************************************************************}
procedure TFAmostraConsumo.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3,10,12,14,18: Value:= '0000;0; ';
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDAmostra.DCor.Consumos.Count > 0 then
  begin
    VprDConsumoAmostra:= TRBDConsumoAmostra(VprDAmostra.DCor.Consumos.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDConsumoAmostra.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GradeNovaLinha(Sender: TObject);
begin
  VprDConsumoAmostra:= VprDAmostra.DCor.addConsumo;
  VprDConsumoAmostra.CodCorAmostra := ECorKit.Ainteiro;
  VprDConsumoAmostra.DesLegenda := FunAmostra.RLegendaDisponivel(VprDAmostra);
end;

{******************************************************************************}
procedure TFAmostraConsumo.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao, egEdicao] then
  begin
    if Grade.AColuna <> ACol then
      case Grade.AColuna of
        1: if not ExisteProduto then
             if not LocalizaProduto then
             begin
               Grade.Cells[1,Grade.ALinha]:= '';
               Abort;
             end;
        3: if not ExisteCor then
             if not ECor.AAbreLocalizacao then
             begin
               Aviso('CÓDIGO DA COR INVÁLIDA !!!'#13'É necessário informar o código da cor.');
               abort;
             end;
        5  : if not ExisteUM then
             begin
               aviso(CT_UNIDADEVAZIA);
               Grade.col := 5;
               abort;
             end;
        6,7 :begin
               CalculaConsumos;
               CalculaValorTotalItem;
             end;
        12: if not ETipoMateriaPrima.AExisteCodigo(Grade.Cells[12,Grade.ALinha]) then
              if not ETipoMateriaPrima.AAbreLocalizacao then
              begin
               aviso('CÓDIGO DO TIPO DO MATERIALA INVÁLIDO!!!'#13'O código do tipo do material digitado não existe cadatrado.');
               Grade.col := 12;
               abort;
              end;
        14: if not ExisteFaca then
             if not EFaca.AAbreLocalizacao then
             begin
               Aviso('CÓDIGO DA FACA INVÁLIDA!!!'#13'É necessário informar o código da faca.');
               Grade.col := 14;
               abort;
             end;
       16,17 : CalculaConsumos;
       18: if not ExisteMaquina then
             if not EMaquina.AAbreLocalizacao then
             begin
               Aviso('CÓDIGO DA MAQUINA INVÁLIDA!!!'#13'É necessário informar o código da maquina.');
               Grade.col := 18;
               abort;
             end;
      end;
  end;
end;

{******************************************************************************}
function TFAmostraConsumo.GravaConsumo: string;
begin
  CarDClasse;
  result := FunAmostra.GravaConsumoAmostra(VprDAmostra);
end;

{******************************************************************************}
function TFAmostraConsumo.ExisteCor: Boolean;
begin
  Result:= True;
  if Grade.Cells[3,Grade.ALinha] <> '' then
  begin
    result := FunProdutos.ExisteCor(Grade.Cells[3,Grade.ALinha]);
    if result then
    begin
      ecor.Text := Grade.Cells[3,Grade.ALinha];
      ECor.Atualiza;
    end;
  end;
end;

{******************************************************************************}
function TFAmostraConsumo.ExisteFaca : Boolean;
begin
  Result:= True;
  if Grade.Cells[14,Grade.ALinha] <> '' then
  begin
    result := FunProdutos.ExisteFaca(StrToInt(Grade.Cells[14,Grade.ALinha]),VprDConsumoAmostra.Faca);
    if result then
    begin
      VprDConsumoAmostra.CodFaca := VprDConsumoAmostra.Faca.CodFaca;
      Grade.Cells[15,Grade.ALinha] := VprDConsumoAmostra.Faca.NomFaca;
    end;
  end
  else
    Grade.Cells[15,Grade.ALinha] := '';
  CalculaConsumos;
end;

{******************************************************************************}
function TFAmostraConsumo.ExisteItemEspecial: boolean;
begin
  if (GItensEspeciais.Cells[1,GItensEspeciais.ALinha] <> '') then
  begin
    if GItensEspeciais.Cells[1,GItensEspeciais.ALinha] = VprItemEspecialAnterior then
      result := true
    else
    begin
      VprDItemEspecial.CodProduto := GItensEspeciais.Cells[1,GItensEspeciais.ALinha];
      Result:= FunProdutos.ExisteProduto(GItensEspeciais.Cells[1,GItensEspeciais.ALinha], VprDItemEspecial);
      if result then
      begin
        VprItemEspecialAnterior := VprDItemEspecial.CodProduto;
        GItensEspeciais.Cells[2,GItensEspeciais.ALinha] := VprDItemEspecial.NomProduto;
        GItensEspeciais.Cells[3,GItensEspeciais.ALinha] := FormatFloat(Varia.MascaraValor,VprDItemEspecial.ValProduto);;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFAmostraConsumo.ExisteMaquina : Boolean;
begin
  result := true;
  if Grade.cells[18,Grade.ALinha] <> '' then
  begin
    result := FunProdutos.ExisteMaquina(StrToInt(Grade.Cells[18,Grade.ALinha]),VprDConsumoAmostra.Maquina);
    if result then
    begin
      VprDConsumoAmostra.CodMaquina := VprDConsumoAmostra.Maquina.CodMaquina;
      Grade.Cells[19,Grade.ALinha] := VprDConsumoAmostra.Maquina.NomMaquina;
      if Grade.Cells[16,Grade.ALinha] <> '' then
        VprDConsumoAmostra.LarMolde:= StrToFloat(Grade.Cells[16,Grade.ALinha])
      else
        VprDConsumoAmostra.LarMolde := 0;
      if Grade.Cells[17,Grade.ALinha] <> '' then
        VprDConsumoAmostra.AltMolde:= StrToFloat(Grade.Cells[17,Grade.ALinha])
      else
        VprDConsumoAmostra.AltMolde := 0;
      CalculaConsumos;
    end;
  end;
end;

{******************************************************************************}
function TFAmostraConsumo.ExisteUM : Boolean;
begin
  if (VprDConsumoAmostra.UMAnterior = Grade.cells[5,Grade.ALinha]) then
    result := true
  else
  begin
    result := (VprDConsumoAmostra.UnidadeParentes.IndexOf(Grade.Cells[5,Grade.Alinha]) >= 0);
    if result then
    begin
      VprDConsumoAmostra.DesUM := Grade.Cells[5,Grade.Alinha];
      VprDConsumoAmostra.ValUnitario := FunProdutos.ValorPelaUnidade(VprDConsumoAmostra.UMAnterior,VprDConsumoAmostra.DesUM,VprDConsumoAmostra.SeqProduto,
                                               VprDConsumoAmostra.ValUnitario);
      VprDConsumoAmostra.UMAnterior := VprDConsumoAmostra.DesUM;
      Grade.Cells[7,Grade.ALinha]:= FormatFloat(varia.MascaraValorUnitario,VprDConsumoAmostra.ValUnitario);
      CalculaValorTotalItem;
    end;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.CalculaValorTotalItem;
begin
  if Grade.Cells[6,Grade.ALinha] <> '' then
    VprDConsumoAmostra.Qtdproduto:= StrToFloat(DeletaChars(Grade.Cells[6,Grade.ALinha],'.'))
  else
    VprDConsumoAmostra.Qtdproduto := 0;
  if Grade.Cells[7,Grade.ALinha] <> '' then
    VprDConsumoAmostra.ValUnitario:= StrToFloat(DeletaChars(Grade.Cells[7,Grade.ALinha],'.'))
  else
    VprDConsumoAmostra.ValUnitario := 0;
  if VprDConsumoAmostra.QtdPecasemMetro <> 0 then
    VprDConsumoAmostra.ValTotal := ((VprDConsumoAmostra.ValUnitario*VprDConsumoAmostra.ValIndiceConsumo)/VprDConsumoAmostra.QtdPecasemMetro)*VprDConsumoAmostra.Qtdproduto
  else
    VprDConsumoAmostra.ValTotal := VprDConsumoAmostra.Qtdproduto * VprDConsumoAmostra.ValUnitario;
  if VprDConsumoAmostra.PerAcrescimoPerda <> 0 then
     VprDConsumoAmostra.ValTotal := VprDConsumoAmostra.ValTotal +  (VprDConsumoAmostra.ValTotal*VprDConsumoAmostra.PerAcrescimoPerda)/100;

  Grade.Cells[8,grade.ALinha] := FormatFloat('#,###,###,###,##0.000###',VprDConsumoAmostra.ValTotal);
end;

{******************************************************************************}
procedure TFAmostraConsumo.CalculaValorVenda;
begin
  FunAmostra.CalculaValorVendaUnitario(VprDAmostra);
//  EValVenda.AValor := VprDAmostra.ValVendaUnitario;
end;

{******************************************************************************}
procedure TFAmostraConsumo.CarGrade;
begin
  FunAmostra.CarConsumosAmostra(VprDAmostra,ECorKit.AInteiro);
  Grade.ADados := VprDAmostra.DCor.Consumos;
  Grade.CarregaGrade;
  GQuantidade.ADados := VprDAmostra.Quantidades;
  GQuantidade.CarregaGrade;
  GValorVenda.ADados := VprDAmostra.ValoresVenda;
  GValorVenda.CarregaGrade;
  GPrecoCliente.ADados := VprDAmostra.PrecosClientes;
  GPrecoCliente.CarregaGrade;
  GItensEspeciais.ADados := VprDAmostra.ItensEspeciais;
  GItensEspeciais.CarregaGrade;
  VprCorAmostraAnterior := ECorKit.AInteiro;
  if (VprDAmostra.DCor.DesImagemCor = '') and
     (Config.FichaTecnicaAmotraporCor) and
     (config.CodigoAmostraGeradoPelaClassificacao)  then
  begin
    VprDAmostra.DCor.DesImagemCor := DeletaEspaco(CopiaAteChar(FunProdutos.RNomeClassificacao(varia.CodigoEmpresa,VprDAmostra.CodClassificacao),'-'))+'\'+IntToStr(VprDAmostra.CodAmostra)+ DeletaEspaco(DeleteAteChar(FunProdutos.RNomeCor(IntToStr(ECorKit.AInteiro)),' '))+ '.BMP';

  end;
  EImagem.Text := VprDAmostra.DCor.DesImagemCor;
  EPrecoEstimado.AValor:=VprDAmostra.DCor.ValPrecoEstimado;
  GProcessos.ADados := VprDAmostra.Processos;
  GProcessos.CarregaGrade;
end;

{******************************************************************************}
procedure TFAmostraConsumo.CalculaConsumos;
begin
  if (VprDConsumoAmostra.LarMolde <> 0 )or(VprDConsumoAmostra.AltMolde <> 0) or
     (VprDConsumoAmostra.CodFaca <> 0) or (VprDConsumoAmostra.CodMaquina <> 0) then
    if VprDConsumoAmostra.AltProduto = 0 then
    begin
      aviso('ALTURA DO PRODUTO NÃO PREENCHIDA!!!'#13'É necessário informar a altura do produto');
      VprDConsumoAmostra.QtdPecasemMetro := 0;
    end;
  CarregaDadosClasse;
  VprDConsumoAmostra.QtdPecasemMetro := 0;
  if VprDConsumoAmostra.CodFaca <> 0 then
  begin
    VprDConsumoAmostra.QtdPecasemMetro := FunProdutos.RQtdPecaemMetro(VprDConsumoAmostra.AltProduto,100,VprDConsumoAmostra.Faca.QtdProvas,VprDConsumoAmostra.Faca.AltFaca,VprDConsumoAmostra.Faca.LarFaca,false,VprDConsumoAmostra.ValIndiceConsumo);
    VprDConsumoAmostra.Qtdproduto := 1 / VprDConsumoAmostra.QtdPecasemMetro;
  end
  else
    if (VprDConsumoAmostra.LarMolde <> 0 )and
       (VprDConsumoAmostra.AltMolde <> 0) then
    begin
      VprDConsumoAmostra.QtdPecasemMetro := FunProdutos.RQtdPecaemMetro(VprDConsumoAmostra.AltProduto,100,1,VprDConsumoAmostra.AltMolde,VprDConsumoAmostra.LarMolde,false,VprDConsumoAmostra.ValIndiceConsumo);
    end;

  CarQtdPecaMetroGrade;
  CalculaValorTotalItem;
end;

{******************************************************************************}
function TFAmostraConsumo.ExisteProduto: Boolean;
begin
  if (Grade.Cells[1,Grade.ALinha] <> '') then
  begin
    if Grade.Cells[1,Grade.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      VprDConsumoAmostra.CodProduto := Grade.Cells[1,Grade.ALinha];
      Result:= FunProdutos.ExisteProduto(Grade.Cells[1,Grade.ALinha], VprDConsumoAmostra);
      if result then
      begin
        VprDConsumoAmostra.UnidadeParentes.free;
        VprDConsumoAmostra.UnidadeParentes := FunProdutos.RUnidadesParentes(VprDConsumoAmostra.DesUM);
        VprProdutoAnterior := VprDConsumoAmostra.CodProduto;
        Grade.Cells[2,Grade.ALinha] := VprDConsumoAmostra.NomProduto;
        Grade.Cells[5,Grade.ALinha] := VprDConsumoAmostra.DesUM;
        Grade.Cells[6,Grade.ALinha] := FormatFloat(Varia.MascaraQtd,VprDConsumoAmostra.Qtdproduto);
        Grade.Cells[7,Grade.ALinha] := FormatFloat('#,###,###,###,##0.000###',VprDConsumoAmostra.ValUnitario);;
      end;
    end;
  end
  else
    result := false;
end;


{******************************************************************************}
procedure TFAmostraConsumo.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    114: case Grade.Col of
           1: LocalizaProduto;
           3: ECor.AAbreLocalizacao;
          12: ETipoMateriaPrima.AAbreLocalizacao;
          14: EFaca.AAbreLocalizacao;
          18: EMaquina.AAbreLocalizacao;
         end;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  case Grade.Col of
    6,7,16,17: if Key = '.' then
         Key:= ',';
  end;
end;

{******************************************************************************}
function TFAmostraConsumo.LocalizaItemEspecial: Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',True);
  Result:= FlocalizaProduto.LocalizaProduto(VprDItemEspecial);
  FlocalizaProduto.free;
  if Result then  // se o usuario nao cancelou a consulta
  begin
    VprItemEspecialAnterior:= VprDItemEspecial.CodProduto;
    GItensEspeciais.Cells[1,GItensEspeciais.ALinha] := VprDItemEspecial.CodProduto;
    GItensEspeciais.Cells[2,GItensEspeciais.ALinha] := VprDItemEspecial.NomProduto;
    GItensEspeciais.Cells[3,GItensEspeciais.ALinha] := FormatFloat(Varia.MascaraValor, VprDItemEspecial.ValProduto);
  end;
end;

{******************************************************************************}
function TFAmostraConsumo.LocalizaProduto: Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',True);
  Result:= FlocalizaProduto.LocalizaProduto(VprDConsumoAmostra);
  FlocalizaProduto.free;
  if Result then  // se o usuario nao cancelou a consulta
  begin
    VprDConsumoAmostra.UnidadeParentes.free;
    VprDConsumoAmostra.UnidadeParentes := FunProdutos.RUnidadesParentes(VprDConsumoAmostra.DesUM);
    VprProdutoAnterior:= VprDConsumoAmostra.CodProduto;
    Grade.Cells[1,Grade.ALinha] := VprDConsumoAmostra.CodProduto;
    Grade.Cells[2,Grade.ALinha] := VprDConsumoAmostra.NomProduto;
    Grade.Cells[5,Grade.ALinha] := VprDConsumoAmostra.DesUM;
    Grade.Cells[7,Grade.ALinha] := FormatFloat('#,###,###,###,##0.000###', VprDConsumoAmostra.ValUnitario);
  end;
end;

procedure TFAmostraConsumo.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PValorVenda then
  begin
    InicializaPaginaValorVenda;
  end;
end;

{******************************************************************************}
function TFAmostraConsumo.RColunaGrade(VpaColuna: TRBDColunaGradeValorVenda): Integer;
begin
  case VpaColuna of
    clVVQtdAmostra: Result := 1;
    clVVValVenda: Result := 2;
    clVVCodTabelaPreco: Result := 3;
    clVVNomTabelaPreco: Result := 4;
    clVVPerlucro: Result := 5;
    clVVPerComissao: Result := 6;
    clVVVAlCustoMateriaPrima: Result := 7;
    clVVValCustoProcesso: Result := 8;
    clVVValCustoMaoObraBordado: Result := 9;
    clVVVAlCustoProduto: Result := 10;
    clVVValCustoComImpostos: Result := 11;
    clVVValSemItensEspeciais: Result := 12;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.EValSugeridoEnter(Sender: TObject);
begin
  VprValSugerido := EValSugerido.AValor;
end;

{******************************************************************************}
procedure TFAmostraConsumo.EValSugeridoExit(Sender: TObject);
begin
  if VprValSugerido <> EValSugerido.AValor then
  begin
    FunAmostra.CalculaValorVendaPeloValorSugerido(VprDAmostra,EValSugerido.AValor);
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.Colar1Click(Sender: TObject);
begin
  if VprCorAmostraCopia <> 0 then
    CopiaConsumo;
end;

{******************************************************************************}
procedure TFAmostraConsumo.ConfiguraTela;
begin
  if config.CalcularPrecoAmostracomValorLucroenaoPercentual then
    LPerLucro.Caption := 'Valor Lucro :';

end;

{******************************************************************************}
function TFAmostraConsumo.ConsumosAmostra(VpaDAmostra: TRBDAmostra): Boolean;
begin
  VprDAmostra:= VpaDAmostra;
  FunAmostra.CarItensEspeciais(VprDAmostra);
  FunAmostra.CarProcessosAmostra(VpaDAmostra);
  CarGrade;
  ETotalPontos.AValor := VprDAmostra.QtdTotalPontos;
  EQtdTrocasLinha.AValor := VprDAmostra.QtdTrocasLinhaBordado;
  EQtdCortes.AValor := VprDAmostra.QtdCortesBordado;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFAmostraConsumo.CopiaConsumo;
begin
  FunAmostra.CarConsumosAmostra(VprDAmostra,VprCorAmostraCopia);
  if Config.QuandoColarConsumoNaoPuxarPrecoDeVenda then
    FreeTObjectsList(VprDAmostra.PrecosClientes);
  Grade.ADados := VprDAmostra.DCor.Consumos;
  Grade.CarregaGrade;
  VprCorAmostraAnterior := ECorKit.AInteiro;
end;

{******************************************************************************}
procedure TFAmostraConsumo.Copiar1Click(Sender: TObject);
begin
  VprCorAmostraCopia := ECorKit.AInteiro;
end;

{******************************************************************************}
procedure TFAmostraConsumo.ECorRetorno(Retorno1, Retorno2: String);
begin
  Grade.Cells[3,grade.ALinha] := retorno1;
  Grade.Cells[4,Grade.ALinha] := Retorno2;
  VprDConsumoAmostra.NomCor := Retorno2;
  if Retorno1 <> '' then
    VprDConsumoAmostra.CodCor := StrToInt(Retorno1)
  else
    VprDConsumoAmostra.CodCor := 0;
end;

{******************************************************************************}
procedure TFAmostraConsumo.ECorKitCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application, '', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.Showmodal;
  FCores.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostraConsumo.ECorKitRetorno(Retorno1, Retorno2: String);
var
  VpfResultado : String;
begin
  if retorno1 <> '' then
  begin
    if (ECorKit.AInteiro <> VprCorAmostraAnterior) and (VprCorAmostraAnterior <> 0) then
      VpfResultado := GravaConsumo;
    if VpfResultado <> '' then
    begin
      ECorKit.AInteiro := VprCorAmostraAnterior;
      aviso(VpfResultado);
    end
    else
      CarGrade;
  end;

end;

{******************************************************************************}
procedure TFAmostraConsumo.BExportaFichaClick(Sender: TObject);
Var
  VpfResultado :String;
begin
  BExportaFicha.Enabled := false;
  if ECorKit.AInteiro <> 0 then
  begin
    VpfResultado := GravaConsumo;
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
    begin
      VprAcao := true;
    end;
    FunAmostra.ExportaFichaTecnicaAmostra(VprDAmostra);
  end
  ELSE
    aviso('COR DA AMOSTRA NÃO PREENCHIDA!!!'#13'Antes de preencher o consumo da amostra é necessário selecionar a que cor a amostra se refere.');
  BExportaFicha.Enabled := true;
end;

{******************************************************************************}
procedure TFAmostraConsumo.BGravarClick(Sender: TObject);
Var
  VpfResultado :String;
begin
  if ECorKit.AInteiro <> 0 then
  begin
    VpfResultado := GravaConsumo;
    if VpfResultado = '' then
    begin
      VpfResultado := FunAmostra.GravaDItensEspeciais(VprDAmostra);
      if VpfResultado = '' then
      begin
        VpfResultado := FunAmostra.GravaDProcessoAmostra(VprDAmostra);
      end;
    end;

    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
    begin
      VprAcao := true;
      close;
    end;
  end
  else
    aviso('COR DA AMOSTRA NÃO PREENCHIDA!!!'#13'Antes de preencher o consumo da amostra é necessário selecionar a que cor a amostra se refere.');
end;

{******************************************************************************}
procedure TFAmostraConsumo.BImprimirClick(Sender: TObject);
Var
  VpfResultado :String;
begin
  BImprimir.Enabled :=false;
  if ECorKit.AInteiro <> 0 then
  begin
    VpfResultado := GravaConsumo;
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
    begin
      VprAcao := true;
    end;
    try
      dtRave := TdtRave.create(self);
      dtRave.ImprimeFichaTecnicaAmostraCor(VprDAmostra.CodAmostra, ECorKit.AInteiro, true,'');

    finally
      dtRave.free;
    end;
  end
  else
    aviso('COR DA AMOSTRA NÃO PREENCHIDA!!!'#13'Antes de preencher o consumo da amostra é necessário selecionar a que cor a amostra se refere.');
  BImprimir.Enabled := true;
end;

{******************************************************************************}
procedure TFAmostraConsumo.BitBtn1Click(Sender: TObject);
begin
  VprDPrecoCliente := VprDAmostra.addPrecoCliente;
  VprDPrecoCliente.CodTabela := VprDValorVendaAmostra.CodTabela;
  VprDPrecoCliente.NomTabela := VprDValorVendaAmostra.NomTabela;
  VprDPrecoCliente.QtdVenda := VprDValorVendaAmostra.Quantidade;
  VprDPrecoCliente.CodCliente := VprDAmostra.CodProspect;
  VprDPrecoCliente.NomCliente := FunClientes.RNomCliente(IntToStr(VprDAmostra.CodProspect));
  VprDPrecoCliente.PerLucro := VprDValorVendaAmostra.PerLucro;
  VprDPrecoCliente.PerComissao := VprDValorVendaAmostra.PerComissao;
  VprDPrecoCliente.ValVenda := VprDValorVendaAmostra.ValVenda;
  VprDPrecoCliente.QtdVenda := VprDValorVendaAmostra.Quantidade;
  GPrecoCliente.CarregaGrade;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GradeEnter(Sender: TObject);
begin
  if ECorKit.AInteiro = 0 then
  begin
    aviso('COR DA AMOSTRA NÃO PREENCHIDA!!!'#13'Antes de preencher o consumo da amostra é necessário selecionar a que cor a amostra se refere.');
    ECorKit.SetFocus;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFAmostraConsumo.EFacaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    FunProdutos.ExisteFaca(StrToInt(Retorno1),VprDConsumoAmostra.Faca);
    Grade.Cells[14,Grade.ALinha] := IntTostr(VprDConsumoAmostra.Faca.CodFaca);
    Grade.Cells[15,Grade.ALinha] := VprDConsumoAmostra.Faca.NomFaca;
  end
  else
    VprDConsumoAmostra.CodFaca := 0;
end;

{******************************************************************************}
procedure TFAmostraConsumo.EMaquinaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    FunProdutos.ExisteMaquina(StrToInt(Retorno1),VprDConsumoAmostra.Maquina);
    Grade.Cells[18,Grade.ALinha] := IntToStr(VprDConsumoAmostra.Maquina.CodMaquina);
    Grade.Cells[19,Grade.ALinha] := VprDConsumoAmostra.Maquina.NomMaquina;
  end
  else
    VprDConsumoAmostra.CodMaquina := 0;
end;

{******************************************************************************}
procedure TFAmostraConsumo.EPerComissaoEnter(Sender: TObject);
begin
  VprPerComissao := EPerComissao.AValor;
end;

{******************************************************************************}
procedure TFAmostraConsumo.EPerComissaoExit(Sender: TObject);
var
  VpfLaco : Integer;
  VpfDValorVenda : TRBDValorVendaAmostra;
begin
  if VprPerComissao <> EPerComissao.AValor then
  begin
    for VpfLaco := 0 to VprDAmostra.ValoresVenda.Count - 1 do
    begin
      VpfDValorVenda := TRBDValorVendaAmostra(VprDAmostra.ValoresVenda.Items[VpfLaco]);
      VpfDValorVenda.PerComissao := EPerComissao.AValor;
      FunAmostra.CalculaValorVendaUnitario(VprDAmostra,VpfDValorVenda);
    end;
  end;
  GValorVenda.CarregaGrade;
end;

{******************************************************************************}
procedure TFAmostraConsumo.EPerLucroEnter(Sender: TObject);
begin
  VprPerLucro := EPerLucro.AValor;
end;

{******************************************************************************}
procedure TFAmostraConsumo.EPerLucroExit(Sender: TObject);
var
  VpfLaco : Integer;
  VpfDValorVenda : TRBDValorVendaAmostra;
begin
  if VprPerLucro <> EPerLucro.AValor then
  begin
    for VpfLaco := 0 to VprDAmostra.ValoresVenda.Count - 1 do
    begin
      VpfDValorVenda := TRBDValorVendaAmostra(VprDAmostra.ValoresVenda.Items[VpfLaco]);
      VpfDValorVenda.PerLucro := EPerLucro.AValor;
      FunAmostra.CalculaValorVendaUnitario(VprDAmostra,VpfDValorVenda);
    end;
  end;
  GValorVenda.CarregaGrade;
end;

{******************************************************************************}
procedure TFAmostraConsumo.EProspectRetorno(VpaColunas: TRBColunasLocaliza);
begin
//  GPrecoCliente.AEstadoGrade := egEdicao;
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDPrecoCliente.CodCliente := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDPrecoCliente.NomCliente := VpaColunas.items[1].AValorRetorno;
    GPrecoCliente.Cells[7,GPrecoCliente.ALinha] := VpaColunas.items[0].AValorRetorno;
    GPrecoCliente.Cells[8,GPrecoCliente.ALinha] := VpaColunas.items[1].AValorRetorno;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.EQtdCortesExit(Sender: TObject);
var
  VpfResultado : String;
begin
  if EQtdCortes.AsInteger <> VprDAmostra.QtdCortesBordado then
  begin
    VprDAmostra.QtdCortesBordado := EQtdCortes.AsInteger;
    VpfResultado := FunAmostra.AtualizaTrocaLinhasQtdTotalPontosAmostra(VprDAmostra);
    if VpfResultado = '' then
    begin
      FunAmostra.CalculaValorVendaUnitario(VprDAmostra);
      GValorVenda.CarregaGrade;
    end;
    if VpfResultado <> '' then
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.ETipoMateriaPrimaCadastrar(Sender: TObject);
begin
  FTipoMateriaPrima := TFTipoMateriaPrima.CriarSDI(self,'',true);
  FTipoMateriaPrima.BotaoCadastrar1.Click;
  FTipoMateriaPrima.ShowModal;
  FTipoMateriaPrima.free;
end;

{******************************************************************************}
procedure TFAmostraConsumo.ETipoMateriaPrimaRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDConsumoAmostra.CodTipoMateriaPrima := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDConsumoAmostra.NomTipoMateriaPrima := VpaColunas.items[1].AValorRetorno;
    Grade.Cells[12,Grade.ALinha] := VpaColunas.items[0].AValorRetorno;
    Grade.Cells[13,Grade.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDConsumoAmostra.CodTipoMateriaPrima := 0;
    VprDConsumoAmostra.NomTipoMateriaPrima := '';
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.ECodEstagioCadastrar(Sender: TObject);
begin
  FNovoEstagio := TFNovoEstagio.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoEstagio'));
  FNovoEstagio.EstagioProducao.Insert;
  FNovoEstagio.showmodal;
  FNovoEstagio.free;
end;

procedure TFAmostraConsumo.ECodEstagioRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDAmostraProcesso.CodEstagio := StrToIntDef(VpaColunas.items[0].AValorRetorno, 0);
    GProcessos.Cells[1, GProcessos.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProcessos.Cells[2, GProcessos.ALinha] := VpaColunas.items[1].AValorRetorno;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.ECodProcessoProdCadastrar(Sender: TObject);
begin
  FNovoProcessoProducao := TFNovoProcessoProducao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoProcessoProducao'));
  FNovoProcessoProducao.CadastraProcesso(VprDAmostraProcesso.CodEstagio);
  FNovoProcessoProducao.free;
end;

{******************************************************************************}
procedure TFAmostraConsumo.ECodProcessoProdRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDAmostraProcesso.CodProcessoProducao := StrToIntDef(VpaColunas.items[0].AValorRetorno, 0);
    FunAmostra.CarDAmostraProcesso(VprDAmostraProcesso, VprDAmostraProcesso.CodProcessoProducao);
    GProcessos.Cells[3, GProcessos.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProcessos.Cells[4, GProcessos.ALinha] := VpaColunas.items[1].AValorRetorno;
    GProcessos.Cells[5, GProcessos.ALinha] := FormatFloat('#,##0.00', VprDAmostraProcesso.QtdProducaoHora);
    if VprDAmostraProcesso.Configuracao then
      GProcessos.Cells[6, GProcessos.ALinha] := 'S'
    else
      GProcessos.Cells[6, GProcessos.ALinha] := 'N';

    GProcessos.Cells[7, GProcessos.ALinha] := VprDAmostraProcesso.DesTempoConfiguracao;
  end;
end;


{******************************************************************************}
procedure TFAmostraConsumo.ECodProcessoProdSelect(Sender: TObject);
begin
  ECodProcessoProd.ASelectValida.Text := 'SELECT CODPROCESSOPRODUCAO,DESPROCESSOPRODUCAO, QTDPRODUCAOHORA '+
                                         ' FROM PROCESSOPRODUCAO '+
                                         ' WHERE CODPROCESSOPRODUCAO = @ '+
                                         ' AND CODESTAGIO = '+IntToStr(VprDAmostraProcesso.CodEstagio);
  ECodProcessoProd.ASelectLocaliza.Text := 'SELECT CODPROCESSOPRODUCAO,DESPROCESSOPRODUCAO, QTDPRODUCAOHORA ' +
                                           ' FROM PROCESSOPRODUCAO '+
                                           ' Where CODESTAGIO = '+IntToStr(VprDAmostraProcesso.CodEstagio);
end;

{******************************************************************************}
procedure TFAmostraConsumo.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.ShowModal;
  FCores.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GItensEspeciaisCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItemEspecial:= TRBDItensEspeciaisAmostra(VprDAmostra.ItensEspeciais.Items[VpaLinha-1]);
  GItensEspeciais.Cells[1,GItensEspeciais.ALinha]:= VprDItemEspecial.CodProduto;
  GItensEspeciais.Cells[2,GItensEspeciais.ALinha]:= VprDItemEspecial.NomProduto;
  if VprDItemEspecial.ValProduto <> 0 then
    GItensEspeciais.Cells[3,GItensEspeciais.ALinha]:= FormatFloat(varia.MascaraValor,VprDItemEspecial.ValProduto)
  else
    GItensEspeciais.Cells[3,GItensEspeciais.ALinha]:= '';
  GItensEspeciais.Cells[4,GItensEspeciais.ALinha]:= VprDItemEspecial.DesObservacao;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GItensEspeciaisDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteItemEspecial then
  begin
    aviso(CT_PRODUTONAOCADASTRADO);
    VpaValidos:= False;
    GItensEspeciais.Col:= 1;
  end
  else
    if GItensEspeciais.Cells[3,GItensEspeciais.ALinha] = '' then
    begin
      aviso('INFORME O VALOR!!!'#13'O valor deve ser preenchido.');
      VpaValidos:= False;
      GItensEspeciais.Col:= 3;
    end;
  if VpaValidos then
  begin
    CarDItensEspeciais;
    CalculaValorVenda;
    if VprDItemEspecial.ValProduto = 0 then
    begin
      aviso('VALOR NÃO PREENCHIDO!!!'#13'É necessário preencher o valor do produto.');
      VpaValidos:= False;
      GItensEspeciais.Col:= 3;
    end;
  end;
end;

procedure TFAmostraConsumo.GItensEspeciaisDepoisExclusao(Sender: TObject);
begin
    CalculaValorVenda;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GItensEspeciaisKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    114: case GItensEspeciais.Col of
           1: LocalizaItemEspecial;
         end;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GItensEspeciaisKeyPress(Sender: TObject;
  var Key: Char);
begin
  case GItensEspeciais.Col of
    3 : if Key = '.' then
         Key:= ',';
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GItensEspeciaisMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDAmostra.ItensEspeciais.Count > 0 then
  begin
    VprDItemEspecial := TRBDItensEspeciaisAmostra(VprDAmostra.ItensEspeciais.Items[VpaLinhaAtual-1]);
    VprItemEspecialAnterior := VprDItemEspecial.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFAmostraConsumo.GItensEspeciaisNovaLinha(Sender: TObject);
begin
  VprDItemEspecial := VprDAmostra.addItemEspecial;
  VprItemEspecialAnterior := '-1';
end;

{******************************************************************************}
procedure TFAmostraConsumo.GItensEspeciaisSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GItensEspeciais.AEstadoGrade in [egInsercao, egEdicao] then
  begin
    if GItensEspeciais.AColuna <> ACol then
      case GItensEspeciais.AColuna of
        1: if not ExisteItemEspecial then
             if not LocalizaItemEspecial then
             begin
               GItensEspeciais.Cells[1,GItensEspeciais.ALinha]:= '';
               Abort;
             end;
      end;
  end;
end;



Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAmostraConsumo]);
end.




