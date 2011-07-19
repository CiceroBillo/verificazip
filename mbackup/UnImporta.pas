Unit UnImporta;

Interface

Uses Classes, DBTables, comctrls, stdctrls, gauges, UnDados, SysUtils;

//classe localiza
Type TRBLocalizaImporta = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesImporta = class(TRBLocalizaImporta)
  private
    CadastroDe,
    CadastroPara,
    AuxDe,
    AuxPara : TQuery;
    VprCamposChaves : TList;
    function CarDCamposChave(VpaNomCampos :String;VpaTipCampos : TRBTipoCampo) : TRBDCampoChave;
    procedure ImportaTabela(VpaNomTabela : String; VpaCamposChave : TList;VpaBarraStatus : TStatusBar;VpaLabelTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
    procedure ImportaCliente(VpaBarraStatus : TStatusBar;VpaNomTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
    procedure ImportaProduto(VpaBarraStatus : TStatusBar;VpaNomTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
    procedure ImportaCotacao(VpaBarraStatus : TStatusBar;VpaNomTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
    procedure ImportaFinanceiro(VpaBarraStatus : TStatusBar;VpaNomTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
    procedure ZeraPosTabela(VpaPosRegistro : tProgressBar;VpaNomTabela : String);
    procedure AtualizaStatus(VpaBarraStatus : TStatusBar; VpaTexto : String);
    procedure AtualizaLabelNomTabela(VpaLabel : TLabel;VpaNomTabela : String);
    procedure PosTabelaDE(VpaNomTabela : String;VpaTabelaDE : TQuery);
    function ExisteRegistro(VpaNomTabela : string;VpaTabelaDe,VpaTabelaPara : TQuery;VpaCamposChave : TList) : Boolean;
  public
    constructor cria;
    destructor destroy;override;
    procedure ImportadaDados(VpaBarraStatus : TStatusBar;VpaNomTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
    procedure ApagaInformacoes;
end;



implementation

Uses FunSql, FunString,FunObjeto, FunData, ConstMsg;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaImporta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaImporta.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesImporta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesImporta.cria;
begin
  inherited create;
  CadastroPara := TQuery.Create(nil);
  CadastroPara.DatabaseName :='BaseDados';
  CadastroPara.RequestLive := true;
  AuxDe := TQuery.Create(nil);
  AuxDe.DatabaseName :='BaseOrigem';
  AuxPara := TQuery.Create(nil);
  AuxPara.DatabaseName :='BaseDados';
  VprCamposChaves := TList.Create;
end;

{******************************************************************************}
destructor TRBFuncoesImporta.destroy;
begin
  CadastroDe.free;
  CadastroPara.free;
  AuxDe.free;
  AuxPara.free;
  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesImporta.CarDCamposChave(VpaNomCampos :String;VpaTipCampos : TRBTipoCampo):TRBDCampoChave ;
begin
  result := TRBDCampoChave.cria;
  Result.NomCampo := VpaNomCampos;
  Result.TipCampo := VpaTipCampos;
end;

{******************************************************************************}
procedure TRBFuncoesImporta.ImportaTabela(VpaNomTabela : String; VpaCamposChave : TList;VpaBarraStatus : TStatusBar;VpaLabelTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
var
  VpfLaco : Integer;
begin
  AtualizaStatus(VpaBarraStatus,'Importando '+VpaNomTabela);
  AtualizaLabelNomTabela(VpaLabelTabela,VpaNomTabela);
  ZeraPosTabela(VpaPosRegistros,VpaNomTabela);
  PosTabelaDE(VpaNomTabela,AuxDe);
  while not AuxDe.Eof do
  begin
    if ExisteRegistro(VpaNomTabela,AuxDe,CadastroPara,VpaCamposChave) then
      CadastroPara.edit
    else
      CadastroPara.Insert;

    for VpfLaco := 0 to AuxDe.Fields.Count - 1 do
      CadastroPara.FieldByName(AuxDe.Fields[VpfLaco].DisplayName).AsVariant := AuxDe.FieldByName(AuxDe.Fields[VpfLaco].DisplayName).AsVariant;
    CadastroPara.Post;
    VpaPosRegistros.Position := VpaPosRegistros.Position+1;
    AuxDe.Next;
  end;
  VpaPosTabelas.AddProgress(1);
end;

{******************************************************************************}
procedure TRBFuncoesImporta.ImportaCliente(VpaBarraStatus : TStatusBar;VpaNomTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
begin
  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_EMP',tcInteiro));
  ImportaTabela('CADEMPRESAS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  ImportaTabela('CADFILIAIS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  ImportaTabela('CADCODIGO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_GRU',tcInteiro));
  ImportaTabela('CADGRUPOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_USU',tcInteiro));
  ImportaTabela('CADUSUARIOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_PRF',tcInteiro));
  ImportaTabela('CADPROFISSOES',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_SIT',tcInteiro));
  ImportaTabela('CADSITUACOESCLIENTES',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('COD_PAIS',tcString));
  ImportaTabela('CAD_PAISES',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('COD_PAIS',tcString));
  VprCamposChaves.Add(CarDCamposChave('COD_ESTADO',tcString));
  ImportaTabela('CAD_ESTADOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('COD_CIDADE',tcInteiro));
  ImportaTabela('CAD_CIDADES',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_REG',tcInteiro));
  ImportaTabela('CADREGIAOVENDA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_VEN',tcInteiro));
  ImportaTabela('CADVENDEDORES',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_PAG',tcInteiro));
  ImportaTabela('CADCONDICOESPAGTO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_PAG',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_NRO_PAR',tcInteiro));
  ImportaTabela('MOVCONDICAOPAGTO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_EVE',tcInteiro));
  ImportaTabela('CADEVENTOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('COD_RAMO_ATIVIDADE',tcInteiro));
  ImportaTabela('RAMO_ATIVIDADE',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_CLI',tcInteiro));
  ImportaTabela('CADCLIENTES',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_CLI',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_EVE',tcInteiro));
  ImportaTabela('MOVEVENTOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);
end;

{******************************************************************************}
procedure TRBFuncoesImporta.ImportaProduto(VpaBarraStatus : TStatusBar;VpaNomTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
begin
  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_EMP',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('C_COD_CLA',tcString));
  VprCamposChaves.Add(CarDCamposChave('C_TIP_CLA',tcString));
  ImportaTabela('CADCLASSIFICACAO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('C_COD_UNI',tcString));
  ImportaTabela('CADUNIDADE',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('C_UNI_ATU',tcString));
  VprCamposChaves.Add(CarDCamposChave('C_UNI_COV',tcString));
//  ImportaTabela('MOVINDICECONVERSAO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_MOE',tcInteiro));
  ImportaTabela('CADMOEDAS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_MOE',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('D_DAT_ATU',tcData));
  ImportaTabela('MOVMOEDAS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_FUN',tcInteiro));
  ImportaTabela('CADTIPOFUNDO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('COD_COR',tcInteiro));
  ImportaTabela('COR',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('CODMAQ',tcInteiro));
  ImportaTabela('MAQUINA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('CODEME',tcInteiro));
  ImportaTabela('TIPOEMENDA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_PRO',tcInteiro));
  ImportaTabela('CADPRODUTOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('SEQ_PRODUTO',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQ_REFERENCIA',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('COD_CLIENTE',tcInteiro));
  ImportaTabela('PRODUTO_REFERENCIA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('SEQPRO',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('CODCOM',tcInteiro));
  ImportaTabela('COMBINACAO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('SEQPRO',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('CODCOM',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQCOR',tcInteiro));
  ImportaTabela('COMBINACAOFIGURA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_MOV',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_PRO',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_PRO_KIT',tcInteiro));
  ImportaTabela('MOVKIT',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_BAR',tcInteiro));
  ImportaTabela('CAD_CODIGO_BARRA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_BAR',tcInteiro));
  ImportaTabela('CAD_CODIGO_BARRA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_PRO',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_COR',tcInteiro));
  ImportaTabela('MOVQDADEPRODUTO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_EMP',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_TAB',tcInteiro));
  ImportaTabela('CADTABELAPRECO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_EMP',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_CLI',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_TAB',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_PRO',tcInteiro));
  ImportaTabela('MOVTABELAPRECO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_EMP',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_TAB',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_SER',tcInteiro));
  ImportaTabela('MOVTABELAPRECOSERVICO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);


end;

{******************************************************************************}
procedure TRBFuncoesImporta.ImportaCotacao(VpaBarraStatus : TStatusBar;VpaNomTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
begin
  FreeTObjectsList(VprCamposChaves);
{  VprCamposChaves.Add(CarDCamposChave('I_COD_SIT',tcInteiro));
  ImportaTabela('CADSITUACOES',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_TRA',tcInteiro));
  ImportaTabela('CADTRANSPORTADORAS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('C_COD_EST',tcString));
  ImportaTabela('CADICMSESTADOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('C_COD_ICM',tcInteiro));
  ImportaTabela('CADICMSECF',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_TIP',tcInteiro));
  ImportaTabela('CADTIPOORCAMENTO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('COD_EMBALAGEM',tcInteiro));
  ImportaTabela('EMBALAGEM',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);
}
  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_ORC',tcInteiro));
  ImportaTabela('CADORCAMENTOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_ORC',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_PRO',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_MOV',tcInteiro));
  ImportaTabela('MOVORCAMENTOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

{  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_EMP',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_SER',tcInteiro));
  ImportaTabela('CADSERVICO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_ORC',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_SER',tcInteiro));
  ImportaTabela('MOVSERVICOORCAMENTO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('C_COD_NAT',tcString));
  ImportaTabela('CADNATUREZA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_OPE',tcString));
  ImportaTabela('CADOPERACAOESTOQUE',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_EMP',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('C_CLA_PLA',tcString));
  ImportaTabela('CAD_PLANO_CONTA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('C_COD_NAT',tcString));
  ImportaTabela('CADNATUREZA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('C_COD_NAT',tcString));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_MOV',tcInteiro));
  ImportaTabela('MOVNATUREZA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('C_SER_NOT',tcString));
  ImportaTabela('CADSERIENOTAS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_NOT',tcInteiro));
  ImportaTabela('CADNOTAFISCAIS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_NOT',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_MOV',tcInteiro));
  ImportaTabela('MOVNOTASFISCAIS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_NOT',tcInteiro));
  ImportaTabela('MOVSERVICONOTA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_NOT',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_ORC',tcInteiro));
  ImportaTabela('MOVNOTAORCAMENTO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_EST',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_PRO',tcInteiro));
  ImportaTabela('MOVESTOQUEPRODUTOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_FEC',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_PRO',tcInteiro));
  ImportaTabela('MOVSUMARIZAESTOQUE',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_NOT',tcInteiro));
  ImportaTabela('CADNOTAFISCAISFOR',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_NOT',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_MOV',tcInteiro));
  ImportaTabela('MOVNOTASFISCAISFOR',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_CLI',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_COM',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_PRO',tcInteiro));
  ImportaTabela('MOVFORNECPRODUTOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('CODEST',tcInteiro));
  ImportaTabela('ESTAGIOPRODUCAO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('COD_MOTIVO',tcInteiro));
  ImportaTabela('MOTIVOREPROGRAMACAO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('CODTIP',tcInteiro));
  ImportaTabela('TIPOESTAGIOPRODUCAO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('EMPFIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQORD',tcInteiro));
  ImportaTabela('ORDEMPRODUCAOCORPO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('EMPFIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQORD',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQITE',tcInteiro));
  ImportaTabela('ORDEMPRODUCAOITEM',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('EMPFIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQORD',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQITE',tcInteiro));
  ImportaTabela('OPITEMCADARCO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('EMPFIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQORD',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQITE',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQMAQ',tcInteiro));
  ImportaTabela('OPITEMCADARCO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('EMPFIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQORD',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQCOL',tcInteiro));
  ImportaTabela('COLETAOPCORPO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('EMPFIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQORD',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQCOL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQITE',tcInteiro));
  ImportaTabela('COLETAOPITEM',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('EMPFIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQORD',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQITE',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQMAQ',tcInteiro));
  ImportaTabela('OPITEMCADARCO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('EMPFIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQCOL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQORD',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('CODUSU',tcInteiro));
  ImportaTabela('REVISAOOPEXTERNA',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('EMPFIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQROM',tcInteiro));
  ImportaTabela('ROMANEIOCORPO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('EMPFIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQCOL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQORD',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQROM',tcInteiro));
  ImportaTabela('ROMANEIOITEM',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);



  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('COD_FILIAL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQ_INVENTARIO',tcInteiro));
  ImportaTabela('INVENTARIOCORPO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('COD_FILIAL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQ_INVENTARIO',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('SEQ_ITEM',tcInteiro));
  ImportaTabela('INVENTARIOITEM',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('SEQ_LOG',tcInteiro));
  ImportaTabela('LOG',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);}
end;

{******************************************************************************}
procedure TRBFuncoesImporta.ImportaFinanceiro(VpaBarraStatus : TStatusBar;VpaNomTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
begin
  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_BOL',tcInteiro));
  ImportaTabela('CAD_BOLETO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);


  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_NRO_DOC',tcInteiro));
  ImportaTabela('CAD_DOC',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_NRO_DOC',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_MOV_SEQ',tcInteiro));
  ImportaTabela('MOV_DOC',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_IMP',tcInteiro));
  ImportaTabela('CAD_DRIVER',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);


  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_BAN',tcInteiro));
  ImportaTabela('CADBANCOS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('C_NRO_CON',tcString));
  ImportaTabela('CADCONTAS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_COD_DES',tcInteiro));
  ImportaTabela('CADDESPESAS',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);


  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_COD_FRM',tcInteiro));
  ImportaTabela('CADFORMASPAGAMENTO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);


  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_NRO_DOC',tcInteiro));
  ImportaTabela('CADIMPRESSAO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);


  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_NRO_DOC',tcInteiro));
  ImportaTabela('CADIMPRESSAO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_NRO_DOC',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('C_NOM_COM',tcString));
  ImportaTabela('MOVIMPRESSAO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_APG',tcInteiro));
  ImportaTabela('CADCONTASAPAGAR',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_APG',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_NRO_PAR',tcInteiro));
  ImportaTabela('MOVCONTASAPAGAR',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_REC',tcInteiro));
  ImportaTabela('CADCONTASARECEBER',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_REC',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_NRO_PAR',tcInteiro));
  ImportaTabela('MOVCONTASARECEBER',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_REC',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_NRO_PAR',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_REC_PAI',tcInteiro));
  ImportaTabela('MOVCONTACONSOLIDADACR',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  VprCamposChaves.Add(CarDCamposChave('I_LAN_CON',tcInteiro));
  ImportaTabela('MOVCOMISSOES',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_SEQ_TER',tcInteiro));
  ImportaTabela('MOVCHEQUETERCEIRO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  ImportaTabela('CFG_FINANCEIRO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  ImportaTabela('CFG_FISCAL',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  VprCamposChaves.Add(CarDCamposChave('I_EMP_FIL',tcInteiro));
  ImportaTabela('CFG_GERAL',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  ImportaTabela('CFG_MODULO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  FreeTObjectsList(VprCamposChaves);
  ImportaTabela('CFG_PRODUTO',VprCamposChaves,VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);
end;

{******************************************************************************}
procedure TRBFuncoesImporta.ZeraPosTabela(VpaPosRegistro : tProgressBar;VpaNomTabela : String);
begin
  VpaPosRegistro.Position := 0;
  AdicionaSQLAbreTabela(AuxDe,'Select Count(*) QTD FROM '+ VpaNomTabela);
  VpaPosRegistro.Max := AuxDe.FieldByName('QTD').AsInteger;
  AuxDe.Close;
end;

{******************************************************************************}
procedure TRBFuncoesImporta.AtualizaStatus(VpaBarraStatus : TStatusBar; VpaTexto : String);
begin
  VpaBarraStatus.Panels[0].Text := VpaTexto;
  VpaBarraStatus.Refresh;
end;

{******************************************************************************}
procedure TRBFuncoesImporta.AtualizaLabelNomTabela(VpaLabel : TLabel;VpaNomTabela : String);
begin
  VpaLabel.Caption := VpaNomTabela+ '                                     ';
  VpaLabel.refresh;
end;

{******************************************************************************}
procedure TRBFuncoesImporta.PosTabelaDE(VpaNomTabela : String;VpaTabelaDE : TQuery);
begin
  AdicionaSQLAbreTabela(VpaTabelaDE,'Select * from '+ VpaNomTabela);
end;

{******************************************************************************}
function TRBFuncoesImporta.ExisteRegistro(VpaNomTabela : string;VpaTabelaDe,VpaTabelaPara : TQuery;VpaCamposChave : TList):Boolean;
var
  VpfLaco : Integer;
  VpfDCampoChave : TRBDCampoChave;
  VpfComando : String;
begin
  VpfComando := 'Select * from '+ VpaNomTabela+ '  ';
  for VpfLaco := 0 to VpaCamposChave.Count - 1 do
  begin
    VpfDCampoChave := TRBDCampoChave(VpaCamposChave.Items[VpfLaco]);
    if VpfLaco = 0 then
      VpfComando := VpfComando + ' where '
    else
      VpfComando := VpfComando + ' and ';

    case VpfDCampoChave.TipCampo of
      tcString : VpfComando := VpfComando + VpfDCampoChave.NomCampo +' = '''+VpaTabelaDe.FieldByName(VpfDCampoChave.NomCampo).AsString+'''';
      tcInteiro : VpfComando := VpfComando + VpfDCampoChave.NomCampo +' = '+VpaTabelaDe.FieldByName(VpfDCampoChave.NomCampo).AsString;
      tcData : VpfComando := VpfComando + VpfDCampoChave.NomCampo +' = '+SQLTextoDataAAAAMMMDD(VpaTabelaDe.FieldByName(VpfDCampoChave.NomCampo).AsDateTime);
    end;
  end;
  AdicionaSQLAbreTabela(VpaTabelaPara,VpfComando);
  result := not VpaTabelaPara.Eof;
end;

{******************************************************************************}
procedure TRBFuncoesImporta.ImportadaDados(VpaBarraStatus : TStatusBar;VpaNomTabela : TLabel;VpaPosRegistros : TProgressBar;VpaPosTabelas : TGauge);
begin
  VpaPosRegistros.Position := 0;
  VpaPosTabelas.Progress := 0;
  ImportaCliente(VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);
  ImportaProduto(VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);
  ImportaCotacao(VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);
  ImportaFinanceiro(VpaBarraStatus,VpaNomTabela,VpaPosRegistros,VpaPosTabelas);

  AtualizaStatus(VpaBarraStatus,'Importação realizada com sucesso.');
end;

{******************************************************************************}
procedure TRBFuncoesImporta.ApagaInformacoes;
var
  VpfDataExcluir : TDateTime;
begin
  VpfDataExcluir := PrimeiroDiaMes(DECMES(Date,3));
  if EntraData('Data a Restaurar','Restaurar a partir de :',VpfDataExcluir) then
  begin
    //CONTAS A PAGAR
    ExecutaComandoSql(AuxDe,'delete from MOVCONTASAPAGAR '+
                            ' Where D_DAT_VEN < '+ SQLTextoDataAAAAMMMDD(VpfDataExcluir)+
                            ' AND N_VLR_PAG IS NOT NULL');
    ExecutaComandoSql(AuxDe,'delete from CADCONTASAPAGAR '+
                            ' Where not exists (select * from MOVcontasapagar MOV '+
                            ' Where MOV.I_EMP_FIL = CADCONTASAPAGAR.I_EMP_FIL'+
                            ' and MOV.I_LAN_APG = CADCONTASAPAGAR.I_LAN_APG)');
    //CONTAS A RECEBER
    ExecutaComandoSql(AuxDe,'delete from MOVCONTASARECEBER '+
                            ' Where D_DAT_VEN < '+ SQLTextoDataAAAAMMMDD(VpfDataExcluir)+
                            ' AND N_VLR_PAG IS NOT NULL');
    ExecutaComandoSql(AuxDe,'delete from MOVCOMISSOES '+
                            ' Where not exists (select * from MOVcontasaRECEBER MOV '+
                            ' Where MOV.I_EMP_FIL = MOVCOMISSOES.I_EMP_FIL'+
                            ' and MOV.I_LAN_REC = MOVCOMISSOES.I_LAN_REC'+
                            ' and MOV.I_NRO_PAR = MOVCOMISSOES.I_NRO_PAR)');
    ExecutaComandoSql(AuxDe,'delete from CADCONTASARECEBER '+
                            ' Where not exists (select * from MOVcontasaRECEBER MOV '+
                            ' Where MOV.I_EMP_FIL = CADCONTASARECEBER.I_EMP_FIL'+
                            ' and MOV.I_LAN_REC = CADCONTASARECEBER.I_LAN_REC)');
    // NOTAS FISCAIS
    ExecutaComandoSql(AuxDe,'delete from MOVESTOQUEPRODUTOS '+
                            ' Where D_DAT_MOV < '+ SQLTextoDataAAAAMMMDD(VpfDataExcluir));
    ExecutaComandoSql(AuxDe,'delete from MOVNOTASFISCAIS '+
                            ' Where exists (select * from CADNOTAFISCAIS CAD '+
                            ' Where CAD.I_EMP_FIL = MOVNOTASFISCAIS.I_EMP_FIL '+
                            ' and CAD.I_SEQ_NOT = MOVNOTASFISCAIS.I_SEQ_NOT '+
                            ' and CAD.D_DAT_EMI < '+ SQLTextoDataAAAAMMMDD(VpfDataExcluir)+')');
    ExecutaComandoSql(AuxDe,'delete from CADNOTAFISCAIS '+
                            ' where D_DAT_EMI < '+ SQLTextoDataAAAAMMMDD(VpfDataExcluir));
  end;
    //ORCAMENTO
    ExecutaComandoSql(AuxDe,'delete from MOVORCAMENTOS '+
                            ' Where exists (select * from CADORCAMENTOS CAD '+
                            ' Where CAD.I_EMP_FIL = MOVORCAMENTOS.I_EMP_FIL '+
                            ' and CAD.I_LAN_ORC = MOVORCAMENTOS.I_LAN_ORC '+
                            ' and CAD.D_DAT_ORC < '+ SQLTextoDataAAAAMMMDD(VpfDataExcluir)+')');
    ExecutaComandoSql(AuxDe,'delete from CADORCAMENTOS '+
                            ' where D_DAT_ORC < '+ SQLTextoDataAAAAMMMDD(VpfDataExcluir));
end;

end.
