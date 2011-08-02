unit UnDRave;

interface

uses
  SysUtils,Classes,FunObjeto;


Type
  TRBDNotaEntradaProdutosTibFaturadosST = class
  public
    NumNota : Integer;
    NomForncedore,
    DesCNPJ : String;
    DatEmissao : TDateTime;
    ProdutoFaturados : TList;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDProdutosTibFaturadosST = class
  public
    NumNota : Integer;
    CodProduto,
    NomProduto,
    CodUnidade : String;
    ValTotalProduto,
    ValTotalCompra,
    PerSubstituicao,
    ValBaseST,
    ValICMSST,
    PerICMS,
    ValICMSCompra : Double;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDTotalVendedorRave = class
  public
    CodVendedor : Integer;
    NomVendedor :String;
    ValContratos,
    ValRenovado : Double;
    constructor cria;
    destructor destroy;override;
  end;

Type
  TRBDLivroSaidasTotalUFRave = class
  public
    DesUF : String;
    ValContabil,
    ValBaseICMS,
    ValImposto,
    ValOutras : Double;
    constructor cria;
    destructor destroy;override;
  end;

Type
  TRBDLivroSaidasTotalCFOPRave = class
  public
    CodCFOP : String;
    ValContabil,
    ValBaseICMS,
    ValImposto,
    ValOutras : Double;
    constructor cria;
    destructor destroy;override;
  end;


Type
  TRBDLeiturasContratoLocacaoRave = class
  public
    MesLocacao,
    AnoLocacao,
    QtdCopia,
    QtdExcedente : Integer;
    ValTotalDesconto,
    ValExcessoFranquia,
    ValExcessoFranquiaColor : Double;
    DatDigitacao : TDateTime;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDEquipamentoContratoLocacaoRave = class
    public
      SeqProduto :Integer;
      CodProduto,
      NomProduto,
      NumSerie,
      DesSetor : String;
      ValorEquipamento : Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDPecasContratoLocacaoRave = class
    public
    SeqProduto : Integer;
    CodProduto,
    NomProduto : String;
    QtdPecas,
    ValCusto : Double;
    constructor cria;
    destructor destroy;override;
  end;


Type
  TRBDInsumoContratoLocacaoRave = class
    public
      SeqProduto :Integer;
      CodProduto,
      NomProduto : String;
      QtdProduto,
      ValCustoInsumo : Double;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDContratoLocacaoRave = class
    public
    CodFilial,
    SeqContrato,
    CodCliente : Integer;
    NomCliente : String;
    ValTotalLeituras,
    ValTotalEquipamentos,
    ValTotalInsumosContabilizados,
    ValTotalInsumosNaoContabilizados,
    ValTotalPecas,
    ValFinalContrato : Double;
    Leituras,
    Equipamentos,
    InsumosContabilizados,
    InsumosNaoContabilizados,
    Pecas : TList;
    constructor cria;
    destructor destroy;
    function AddLeituraLocacao : TRBDLeiturasContratoLocacaoRave;
    function addEquipamento : TRBDEquipamentoContratoLocacaoRave;
    function addInsumoContabilizado : TRBDInsumoContratoLocacaoRave;
    function addInsumoNaoContabilizado : TRBDInsumoContratoLocacaoRave;
    function addPeca : TRBDPecasContratoLocacaoRave;
end;

Type
  TRBDVendaMesProduto = class
    public
      Mes,
      Ano : Integer;
      QtdVendida : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDTamanhoProdutoRave = class
    public
     CodTamanho : Integer;
     NomTamanho : String;
     QtdEstoque,
     QtdProduzido,
     ValEstoque : Double;
     Vendas : TList;
     constructor cria;
     destructor destroy;override;
     function RVendaMes(VpaMes,VpaAno : Integer) : TRBDVendaMesProduto;
  end;

Type
  TRBDCorProdutoRave = class
    public
      CodCor : Integer;
      NomCor : String;
      QtdEstoque,
      QtdProduzido,
      ValEstoque  : Double;
      Tamanhos,
      Vendas : TList;
      constructor cria;
      destructor destroy;override;
      function addTamanho : TRBDTamanhoProdutoRave;
      function RVendaMes(VpaMes,VpaAno : Integer) : TRBDVendaMesProduto;
end;

Type
  TRBDProdutoRave = class
    public
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      DesUM,
      DesCifraoMoeda : String;
      QtdEstoque,
      QtdTrocada,
      QtdProduzido,
      ValEstoque,
      ValTroca : Double;
      Cores,
      Vendas : TList;
      constructor cria;
      destructor destroy;override;
      function AddCor : TRBDCorProdutoRave;
      function RVendaMes(VpaMes,VpaAno : Integer) : TRBDVendaMesProduto;
end;

Type
  TRBDClassificacaoRave = class
    CodClassificacao,
    CodReduzido,
    NomClassificacao : String;
    QTdProduto,
    QtdTrocado,
    QtdConsumido,
    ValTotal,
    VAlTrocado,
    QtdMesAnterior,
    QtdVenda,
    ValAnterior,
    ValVenda,
    ValCustoVenda : Double;
    IndNovo : Boolean;
  end;

Type
  TRBDPlanoContasRave = class
    CodPlanoCotas,
    CodReduzido,
    NomPlanoContas : String;
    ValPago,
    ValDuplicata,
    ValPrevisto : Double;
    IndNovo : Boolean;
  end;


Type
  TRBDVendaClienteMes = class
    public
      Mes : Integer;
      ValVenda : Double;
      IndReducaoVenda : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDVendaClienteClassificacaoProduto = class
    public
      CodClassificacao,
      NomClassificacao : string;
      ValTotal : Double;
      Meses : TList;
      constructor cria;
      destructor destroy;override;
      function addMes : TRBDVendaClienteMes;
end;

Type
  TRBDVendaClienteAno = class
    public
      Ano : Integer;
      ValVenda : Double;
      IndReducaoVenda : Boolean;
      ClassificacoesProduto,
      Meses : TList;
      Constructor cria;
      destructor destroy;override;
      function addMes : TRBDVendaClienteMes;
      function AddClassificacaoProduto : TRBDVendaClienteClassificacaoProduto;
end;

Type
  TRBDVendaClienteRepresentada = class
   public
     NomRepresentada : String;
     ValVenda : Double;
      Anos : TList;
     constructor cria;
     destructor destroy;override;
     function addAno : TRBDVendaClienteAno;
  end;


Type
  TRBDVendaCliente = class
    public
      Anos : TList;
      Representadas : TList;
      Constructor cria;
      destructor destroy;override;
      function addAno : TRBDVendaClienteAno;
      function addRepresentada : TRBDVendaClienteRepresentada;
end;

Type
  TRBDRCelulaTrabalhoDia = class
    public
      Dia,
      Quantidade: Integer;
      constructor cria;
  end;

Type
  TRBDRCelulaTrabalho = class
    public
      CodCelula,
      QtdTotal: Integer;
      NomCelula: String;
      Dias: TList;
      constructor cria;
      destructor destroy; override;
      function AddDia(VpaDia: Integer): TRBDRCelulaTrabalhoDia;
      function RDia(VpaDia: Integer): TRBDRCelulaTrabalhoDia;
  end;

Type
  TRBDRAmostraDesenvolvedorDia = class
    public
      Dia,
      Quantidade: Integer;
      constructor cria;
  end;

Type
  TRBDRAmostraDesenvolvedor = class
    public
      CodDesenvolvedor,
      QtdTotal: Integer;
      NomDesenvolvedor: String;
      Dias: TList;
      constructor cria;
      destructor destroy; override;
      function AddDia(VpaDia: Integer): TRBDRAmostraDesenvolvedorDia;
      function RDia(VpaDia: Integer): TRBDRAmostraDesenvolvedorDia;
  end;

Type
  TRBDRPedidosAtrasadosRave = class
    public
      QtdDias,
      QtdPedidos: integer;
      QtdProdutos,
      ValProdutos: Double;
      constructor cria;
      destructor destroy; override;
    end;

Type
  TRBDAmostraEntrega = class
    public
      CodAmostra,
      CodCor : Integer;
      NomAmostra : string;
      DatCadastro,
      DatEntrega : TDateTime;
      Constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDRConsumoEntregaAmostrasRave = class
    public
      QtdDias,
      QtdAmostras: integer;
      Amostras : TList;
      constructor cria;
      destructor destroy; override;
      function addAmostraEntrega : TRBDAmostraEntrega;
    end;


implementation

{ TRBDPecasContratoLocacaoRave }

{******************************************************************************}
constructor TRBDPecasContratoLocacaoRave.cria;
begin
  inherited;
end;

{******************************************************************************}
destructor TRBDPecasContratoLocacaoRave.destroy;
begin

  inherited;
end;

{ TRBDInsumoContratoLocacaoRave }

{******************************************************************************}
constructor TRBDInsumoContratoLocacaoRave.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDInsumoContratoLocacaoRave.destroy;
begin

  inherited;
end;


{ TRBDEquipamentoContratoLocacaoRave }

{******************************************************************************}
constructor TRBDEquipamentoContratoLocacaoRave.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDEquipamentoContratoLocacaoRave.destroy;
begin

  inherited;
end;

{ TRBDLeiturasContratoLocacaoRave }

{******************************************************************************}
constructor TRBDLeiturasContratoLocacaoRave.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDLeiturasContratoLocacaoRave.destroy;
begin

  inherited;
end;

{ TRBDVendaClienteRepresentada }

{******************************************************************************}
function TRBDVendaClienteRepresentada.addAno: TRBDVendaClienteAno;
begin
  Result := TRBDVendaClienteAno.cria;
  Anos.Add(result);
end;

{******************************************************************************}
constructor TRBDVendaClienteRepresentada.cria;
begin
  inherited create;
  Anos := TList.Create;
end;

{******************************************************************************}
destructor TRBDVendaClienteRepresentada.destroy;
begin
  FreeTObjectsList(Anos);
  Anos.Free;
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Dados da locacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
{ TRBDContratoLocacaoRave }
{******************************************************************************}
function TRBDContratoLocacaoRave.addEquipamento: TRBDEquipamentoContratoLocacaoRave;
begin
  result := TRBDEquipamentoContratoLocacaoRave.cria;
  Equipamentos.Add(result);
end;

{******************************************************************************}
function TRBDContratoLocacaoRave.addInsumoContabilizado: TRBDInsumoContratoLocacaoRave;
begin
  result := TRBDInsumoContratoLocacaoRave.cria;
  InsumosContabilizados.Add(result);
end;

{******************************************************************************}
function TRBDContratoLocacaoRave.addInsumoNaoContabilizado: TRBDInsumoContratoLocacaoRave;
begin
  result := TRBDInsumoContratoLocacaoRave.cria;
  InsumosContabilizados.Add(result);
end;

{******************************************************************************}
function TRBDContratoLocacaoRave.AddLeituraLocacao: TRBDLeiturasContratoLocacaoRave;
begin
  Result := TRBDLeiturasContratoLocacaoRave.cria;
  Leituras.Add(result);
end;

{******************************************************************************}
function TRBDContratoLocacaoRave.addPeca: TRBDPecasContratoLocacaoRave;
begin
  result := TRBDPecasContratoLocacaoRave.cria;
  Pecas.Add(result);
end;

{******************************************************************************}
constructor TRBDContratoLocacaoRave.cria;
begin
  Leituras := TList.Create;
  Equipamentos := TList.Create;
  InsumosContabilizados := TList.Create;
  InsumosNaoContabilizados := TList.Create;
  Pecas := TList.Create;
end;

{******************************************************************************}
destructor TRBDContratoLocacaoRave.destroy;
begin
  FreeTObjectsList(Leituras);
  FreeTObjectsList(Equipamentos);
  FreeTObjectsList(InsumosContabilizados);
  FreeTObjectsList(InsumosNaoContabilizados);
  FreeTObjectsList(Pecas);
  Leituras.Free;
  Equipamentos.Free;
  InsumosContabilizados.Free;
  InsumosNaoContabilizados.Free;
  Pecas.Free;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Dados da venda do cliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{ TRBDVendaClienteMes }



{******************************************************************************}
constructor TRBDVendaClienteMes.cria;
begin
  inherited create;
  IndReducaoVenda := false;
end;

{******************************************************************************}
destructor TRBDVendaClienteMes.destroy;
begin
  inherited destroy;
end;

{ TRBDVendaClienteAno }

{******************************************************************************}
Constructor TRBDVendaClienteAno.cria;
begin
  inherited create;
  Meses := TList.Create;
  ClassificacoesProduto := TList.Create;
  IndReducaoVenda := false;
end;

{******************************************************************************}
destructor TRBDVendaClienteAno.destroy;
begin
  FreeTObjectsList(Meses);
  Meses.Free;
  FreeTObjectsList(ClassificacoesProduto);
  ClassificacoesProduto.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDVendaClienteAno.AddClassificacaoProduto: TRBDVendaClienteClassificacaoProduto;
begin
  Result := TRBDVendaClienteClassificacaoProduto.cria;
  ClassificacoesProduto.Add(result);
end;

{******************************************************************************}
function TRBDVendaClienteAno.addMes : TRBDVendaClienteMes;
begin
  result := TRBDVendaClienteMes.cria;
  Meses.add(result);
end;


{ TRBDVendaCliente }

{******************************************************************************}
Constructor TRBDVendaCliente.cria;
begin
  inherited create;
  Anos := TLIst.Create;
  Representadas := TList.Create;
end;

{******************************************************************************}
destructor TRBDVendaCliente.destroy;
begin
  FreeTObjectsList(Anos);
  Anos.free;
  FreeTObjectsList(Representadas);
  Representadas.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDVendaCliente.addAno : TRBDVendaClienteAno;
begin
  Result := TRBDVendaClienteAno.cria;
  Anos.Add(result);
end;

{******************************************************************************}
function TRBDVendaCliente.addRepresentada: TRBDVendaClienteRepresentada;
begin
  result := TRBDVendaClienteRepresentada.cria;
  Representadas.Add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Dados da classe dos tamanhos dos produtos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************************************************}
constructor TRBDTamanhoProdutoRave.cria;
begin
  inherited create;
  Vendas := TList.Create;
end;

{********************************************************************}
destructor TRBDTamanhoProdutoRave.destroy;
begin
  FreeTObjectsList(Vendas);
  vendas.Free;
  inherited;
end;

{******************************************************************************}
function TRBDTamanhoProdutoRave.RVendaMes(VpaMes,VpaAno: Integer): TRBDVendaMesProduto;
var
  VpfLaco : Integer;
  VpfDVendaMes : TRBDVendaMesProduto;
begin
  result := nil;
  for VpfLaco := 0 to Vendas.Count - 1 do
  begin
    VpfDVendaMes := TRBDVendaMesProduto(Vendas.Items[VpfLaco]);
    if (VpaMes = VpfDVendaMes.Mes) and (VpaAno = VpfDVendaMes.Ano) then
    begin
      result := VpfDVendaMes;
      break;
    end;
  end;
  if result = nil then
  begin
    Result := TRBDVendaMesProduto.cria;
    Vendas.Add(result);
    result.Mes := VpaMes;
    result.Ano := VpaAno;
  end;
end;

{ TRBDTamanhoProdutoRave }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Dados da classe das cores dos produtos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************************************************}
function TRBDCorProdutoRave.addTamanho: TRBDTamanhoProdutoRave;
begin
  result := TRBDTamanhoProdutoRave.cria;
  Tamanhos.add(result);
end;

{********************************************************************}
constructor TRBDCorProdutoRave.cria;
begin
  inherited create;
  Tamanhos := TList.Create;
  Vendas := TList.Create;
end;

{********************************************************************}
destructor TRBDCorProdutoRave.destroy;
begin
  FreeTObjectsList(Tamanhos);
  Tamanhos.free;
  FreeTObjectsList(Vendas);
  Vendas.Free;
  inherited;
end;

{******************************************************************************}
function TRBDCorProdutoRave.RVendaMes(VpaMes,VpaAno : Integer): TRBDVendaMesProduto;
var
  VpfLaco : Integer;
  VpfDVendaMes : TRBDVendaMesProduto;
begin
  result := nil;
  for VpfLaco := 0 to Vendas.Count - 1 do
  begin
    VpfDVendaMes := TRBDVendaMesProduto(Vendas.Items[VpfLaco]);
    if (VpaMes = VpfDVendaMes.Mes) and (VpaAno = VpfDVendaMes.Ano) then
    begin
      result := VpfDVendaMes;
      break;
    end;
  end;
  if result = nil then
  begin
    Result := TRBDVendaMesProduto.cria;
    Vendas.Add(result);
    result.Mes := VpaMes;
    result.Ano := VpaAno;
  end;
end;

{ TRBDCorProdutoRave }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Dados da classe dos produtos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************************************************}
function TRBDProdutoRave.AddCor: TRBDCorProdutoRave;
begin
  result := TRBDCorProdutoRave.cria;
  Cores.Add(result);
end;

{********************************************************************}
constructor TRBDProdutoRave.cria;
begin
  inherited create;
  Cores := TList.create;
  Vendas := TList.Create;
  QtdEstoque := 0;
  ValEstoque := 0;
end;

{********************************************************************}
destructor TRBDProdutoRave.destroy;
begin
  FreeTObjectsList(Cores);
  Cores.free;
  FreeTObjectsList(Vendas);
  Vendas.Free;
  inherited;
end;

{******************************************************************************}
function TRBDProdutoRave.RVendaMes(VpaMes,VpaAno: Integer): TRBDVendaMesProduto;
var
  VpfLaco : Integer;
  VpfDVendaMes : TRBDVendaMesProduto;
begin
  result := nil;
  for VpfLaco := 0 to Vendas.Count - 1 do
  begin
    VpfDVendaMes := TRBDVendaMesProduto(Vendas.Items[VpfLaco]);
    if (VpaMes = VpfDVendaMes.Mes) and (VpaAno = VpfDVendaMes.Ano) then
    begin
      result := VpfDVendaMes;
      break;
    end;
  end;
  if result = nil then
  begin
    Result := TRBDVendaMesProduto.cria;
    Vendas.Add(result);
    result.Mes := VpaMes;
    result.Ano := VpaAno;
  end;
end;

{ TRBDProdutoRave }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Dados da classe dos TRBDRCelulaTrabalho
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************************************************}
function TRBDRCelulaTrabalho.AddDia(VpaDia: Integer): TRBDRCelulaTrabalhoDia;
begin
  Result := TRBDRCelulaTrabalhoDia.cria;
  Result.Dia := VpaDia;
  Dias.Add(Result);
end;

{********************************************************************}
constructor TRBDRCelulaTrabalho.cria;
var
  VpfLaco: Integer;
begin
  inherited create;
  Dias := TList.Create;
  for VpfLaco := 1 to 31  do
    AddDia(VpfLaco);
end;

{********************************************************************}
destructor TRBDRCelulaTrabalho.destroy;
begin
  FreeTObjectsList(Dias);
  Dias.Free;
  inherited;
end;

{********************************************************************}
function TRBDRCelulaTrabalho.RDia(VpaDia: Integer): TRBDRCelulaTrabalhoDia;
begin
  Result := nil;
  if VpaDia < 32 then
    Result := TRBDRCelulaTrabalhoDia(Dias[VpaDia-1]);
end;

{ TRBDRCelulaTrabalho }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Dados da classe dos TRBDRCelulaTrabalhoDia
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************************************************}
constructor TRBDRCelulaTrabalhoDia.cria;
begin
  inherited create;
end;

{ TRBDRCelulaTrabalhoDia }

{ TRBDRAmostraDesenvolvedorDia }
{********************************************************************}
constructor TRBDRAmostraDesenvolvedorDia.cria;
begin
  inherited create;
end;

{ TRBDRAmostraDesenvolvedor }
{********************************************************************}
function TRBDRAmostraDesenvolvedor.AddDia(VpaDia: Integer): TRBDRAmostraDesenvolvedorDia;
begin
  Result := TRBDRAmostraDesenvolvedorDia.cria;
  Result.Dia := VpaDia;
  Dias.Add(Result);
end;

{********************************************************************}
constructor TRBDRAmostraDesenvolvedor.cria;
var
  VpfLaco: Integer;
begin
  inherited create;
  Dias := TList.Create;
  for VpfLaco := 1 to 31  do
    AddDia(VpfLaco);
end;

{********************************************************************}
destructor TRBDRAmostraDesenvolvedor.destroy;
begin
  FreeTObjectsList(Dias);
  Dias.Free;

  inherited;
end;

{********************************************************************}
function TRBDRAmostraDesenvolvedor.RDia(VpaDia: Integer): TRBDRAmostraDesenvolvedorDia;
begin
  Result := nil;
  if VpaDia < 32 then
    Result := TRBDRAmostraDesenvolvedorDia(Dias[VpaDia-1]);
end;

{ TRBDRPedidosAtrasadosRave }

{******************************************************************************}
constructor TRBDRPedidosAtrasadosRave.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDRPedidosAtrasadosRave.destroy;
begin
  inherited destroy;
end;

{******************************************************************************}
{ TRBDRConsumoEntregaAmostrasRave }
{******************************************************************************}

{******************************************************************************}
function TRBDRConsumoEntregaAmostrasRave.addAmostraEntrega: TRBDAmostraEntrega;
begin
  result := TRBDAmostraEntrega.Cria;
  Amostras.Add(result);
end;

{******************************************************************************}
constructor TRBDRConsumoEntregaAmostrasRave.cria;
begin
  inherited create;
  Amostras := TList.Create;
end;

{******************************************************************************}
destructor TRBDRConsumoEntregaAmostrasRave.destroy;
begin
  FreeTObjectsList(Amostras);
  inherited destroy;
end;

{******************************************************************************}
                       { TRBDVendaClienteMesClassificacao }
{******************************************************************************}

{******************************************************************************}
function TRBDVendaClienteClassificacaoProduto.addMes: TRBDVendaClienteMes;
begin
  result := TRBDVendaClienteMes.cria;
  Meses.Add(result);
end;

{******************************************************************************}
constructor TRBDVendaClienteClassificacaoProduto.cria;
begin
  inherited create;
  ValTotal := 0;
  Meses := TList.Create;
end;

{******************************************************************************}
destructor TRBDVendaClienteClassificacaoProduto.destroy;
begin
  FreeTObjectsList(Meses);
  Meses.Free;
  inherited;
end;

{******************************************************************************}
                      { TRBDLivroSaidasTotalCFOPRave }
{******************************************************************************}
{******************************************************************************}
constructor TRBDLivroSaidasTotalCFOPRave.cria;
begin
  inherited create;
  ValContabil := 0;
  ValBaseICMS := 0;
  ValImposto := 0;
  ValOutras := 0;
end;

{******************************************************************************}
destructor TRBDLivroSaidasTotalCFOPRave.destroy;
begin

  inherited destroy;
end;

{******************************************************************************}
                   { TRBDLivroSaidasTotalUFRave }
{******************************************************************************}

{******************************************************************************}
constructor TRBDLivroSaidasTotalUFRave.cria;
begin
  inherited create;
  ValContabil := 0;
  ValBaseICMS := 0;
  ValImposto := 0;
  ValOutras := 0;
end;

{******************************************************************************}
destructor TRBDLivroSaidasTotalUFRave.destroy;
begin

  inherited destroy;
end;

{******************************************************************************}
                    { TRBDTotalVendedorRave }
{******************************************************************************}

{******************************************************************************}
constructor TRBDTotalVendedorRave.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDTotalVendedorRave.destroy;
begin

  inherited;
end;

{******************************************************************************}
                   { TRBDProdutosTibFaturadosST }
{******************************************************************************}

{******************************************************************************}
constructor TRBDProdutosTibFaturadosST.cria;
begin

end;

{******************************************************************************}
destructor TRBDProdutosTibFaturadosST.destroy;
begin

  inherited;
end;

{******************************************************************************}
{ TRBDNotaEntradaProdutosTibFaturadosST }
{******************************************************************************}

{******************************************************************************}
constructor TRBDNotaEntradaProdutosTibFaturadosST.cria;
begin
  inherited create;
  ProdutoFaturados := TList.Create;
end;

{******************************************************************************}
destructor TRBDNotaEntradaProdutosTibFaturadosST.destroy;
begin
  FreeTObjectsList(ProdutoFaturados);
  ProdutoFaturados.Free;
  inherited;
end;

{ TRBDAmostrasEntrega }

{******************************************************************************}
constructor TRBDAmostraEntrega.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDAmostraEntrega.destroy;
begin

  inherited;
end;

{******************************************************************************}
{ TRBDVendaMesProduto }
{******************************************************************************}

{******************************************************************************}
constructor TRBDVendaMesProduto.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDVendaMesProduto.destroy;
begin
  inherited destroy;
end;

end.
