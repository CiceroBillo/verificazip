Unit UnMetalVidros;

Interface

Uses Classes, DBTables, UnDadosProduto,Gauges, stdctrls, SysUtils;

//classe localiza
Type TRBLocalizaMetalVidros = class 
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesMetalVidros = class(TRBLocalizaMetalVidros)
  private
    function AdicionaConsumo(VpaDProduto : TRBDProduto;VpaSeqProduto : Integer;VpaQuantidade : Double):string;
  public
    constructor cria;
    destructor destroy;override;
    function ImportaArquivo(VpaNomArquivo : String;VpaProgresso :  TGauge;VpaStatus : TLabel) : String;
end;



implementation

Uses FunSql, UnProdutos, FunString;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaMetalVidros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaMetalVidros.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesMetalVidros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBFuncoesMetalVidros.AdicionaConsumo(VpaDProduto : TRBDProduto; VpaSeqProduto: Integer; VpaQuantidade: Double): string;
var
  VpfDConsumo : TRBDConsumoMP;
begin
  result := '';
  VpfDConsumo := VpaDProduto.AddConsumoMP;
  VpfDConsumo.CorKit := 0;
  VpfDConsumo.SeqProduto := VpaSeqProduto;
  VpfDConsumo.CorReferencia := 1;
  VpfDConsumo.UM  := 'PC';
  VpfDConsumo.QtdProduto := VpaQuantidade;
end;

{********************************* cria a classe ********************************}
constructor TRBFuncoesMetalVidros.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBFuncoesMetalVidros.destroy;
begin

  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesMetalVidros.ImportaArquivo(VpaNomArquivo: String;VpaProgresso : TGauge;VpaStatus : TLabel) : String;
var
  VpfLinha, VpfCampo, VpfCorpo, VpfPlaca, VpfPlacaD, VpfPlacaE, VpfFixo, VpfCortica,
  VpfCortica2 : string;
  VpfLaco : Integer;
  VpfArquivo : TStringList;
  VpfDProduto : TRBDProduto;
  VpfDConsumo : TRBDConsumoMP;
begin
  result := '';
  VpfArquivo := TStringList.Create;
  VpfArquivo.LoadFromFile(VpaNomArquivo);
  VpaProgresso.MaxValue := VpfArquivo.Count;
  VpaProgresso.Progress := 0;
  for VpfLaco := 0 to VpfArquivo.Count - 1 do
  begin
    VpaProgresso.Progress := VpaProgresso.Progress + 1;
    VpfLinha := VpfArquivo.Strings[VpfLaco];
    VpfDProduto := TRBDProduto.Cria;
    VpfDProduto.CodEmpresa := 1;
    VpfDProduto.CodEmpFil := 11;
    VpfDProduto.CodProduto := CopiaAteChar(VpfLinha,';');
    VpaStatus.Caption := 'Importando produto "'+VpfDProduto.CodProduto+'"';
    VpaStatus.Refresh;
    if not FunProdutos.ExisteProduto(VpfDProduto.CodProduto,VpfDProduto.SeqProduto,VpfDProduto.NomProduto,VpfDProduto.CodUnidade) then
    begin
      if not FunProdutos.ExisteProduto(VpfDProduto.CodProduto+'MC',VpfDProduto.SeqProduto,VpfDProduto.NomProduto,VpfDProduto.CodUnidade) then
      begin
      end;

    end;
    VpfLinha := DeleteAteChar(VpfLinha,';');

    //corpo;
    VpfCorpo := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    //placa
    VpfPlaca := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    //placaD
    VpfPlacaD := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    //placaE
    VpfPlacaE := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    //fixo
    VpfFixo := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    //parafuso15
    VpfCampo := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    if VpfCampo <> '' then
      AdicionaConsumo(VpfDProduto,110433,StrToInt(VpfCampo));
    //parafuso17
    VpfCampo := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    if VpfCampo <> '' then
      AdicionaConsumo(VpfDProduto,110434,StrToInt(VpfCampo));
    //parafuso20
    VpfCampo := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    if VpfCampo <> '' then
      AdicionaConsumo(VpfDProduto,110451,StrToInt(VpfCampo));
    //parafuso 28
    VpfCampo := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    if VpfCampo <> '' then
      AdicionaConsumo(VpfDProduto,110435,StrToInt(VpfCampo));
    //parafuso 30
    VpfCampo := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    if VpfCampo <> '' then
      AdicionaConsumo(VpfDProduto,110786,StrToInt(VpfCampo));
    //porca 1
    VpfCampo := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    if VpfCampo <> '' then
      AdicionaConsumo(VpfDProduto,110385,StrToInt(VpfCampo));
    //porca 0
    VpfCampo := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    if VpfCampo <> '' then
      AdicionaConsumo(VpfDProduto,110787,StrToInt(VpfCampo));
    //Cortica
    VpfCortica := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');
    //Cortica2
    VpfCortica2 := CopiaAteChar(VpfLinha,';');
    VpfLinha := DeleteAteChar(VpfLinha,';');


    if VpfDProduto.SeqProduto > 0 then
    begin
      FunProdutos.GravaDConsumoMP(VpfDProduto,0);
    end;


    VpfDProduto.Free;
  end;
end;

end.
