unit UnMoedas;
{Verificado
-.edit;
}
interface

uses
    Db, DBTables, classes, sysUtils, painelGradiente, sqlexpr, tabela;


// calculos
type
  TCalculosMoedas = class
  private
     calcula : TSQLQuery;
  public
     constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); virtual;
     destructor destroy; override;
     Function UnidadeMonetaria( CodigoMoeda : Integer ): string;
end;

// localizacao
Type
  TLocalizaMoedas = class(TCalculosMoedas)
  public
  function LocalizaIndice(  var unidadeMonetaria : string; CodigoMoeda : Integer; data : TDateTime ) : Double;
end;

// funcoes
type
  TFuncoesMoedas = class(TLocalizaMoedas)
  private
     Tabela : TSQLQuery;
     DataBase : TSqlConnection;
  public
     constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); override;
     destructor Destroy; override;
     function ConverteValorParaMoedaBase(  var VpaunidadeMonetaria : string; VpaCodMoeda : Integer; VpaData : TDateTime; VpaValAConverte : Double ) : Double;
     function ConverteValor(var VpaUnidadeMonetaria : string; VpaMoedaAtual, VpaNovaMoeda : Integer; VpaValor : double ) : Double;
  end;

implementation

uses constMsg, constantes, funSql, funstring, fundata;


{#############################################################################
                        TCalculo Moedas
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TCalculosMoedas.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  calcula := TSQLQuery.Create(aowner);
  calcula.SqlConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TCalculosMoedas.destroy;
begin
  calcula.Destroy;
inherited;
end;

{****************** retorna a  unidade Monetaria da moeda ******************* }
Function TCalculosMoedas.UnidadeMonetaria( CodigoMoeda : Integer ): string;
begin
  AdicionaSQLAbreTabela(calcula, 'Select * from cadMoedas where i_cod_moe = ' + IntTostr(CodigoMoeda));
  result := calcula.fieldByName('C_CIF_MOE').AsString;
  FechaTabela(calcula);
end;


{#############################################################################
                        TLocaliza Moedas
#############################################################################  }

{ **********  localiza indice para a moeda  ******************************** }
function TLocalizaMoedas.LocalizaIndice(  var unidadeMonetaria : string; CodigoMoeda : Integer; data : TDateTime ) : Double;
begin
Result := 1;
if varia.MoedaBase <> CodigoMoeda then
begin
    AdicionaSQLAbreTabela(calcula, 'select * from MovMoedas as MM key join CadMoedas as CM ' +
                                   ' where MM.i_cod_moe = ' + IntToStr(CodigoMoeda) +
                                   'and MM.D_DAT_ATU = ''' +
                                   DataToStrFormato(AAAAMMDD,Montadata(1,mes(date), ano(date)),'/') + '''');
    unidadeMonetaria := calcula.fieldByName('C_CIF_MOE').asString;
    result := calcula.fieldByName('N_VLR_D' + AdicionaCharE('0',IntToStr(Dia(data)),2)).AsFloat;
end
  else
     unidadeMonetaria := CurrencyString;
end;


{#############################################################################
                        TFuncoes Moedas
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesMoedas.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  DataBase := VpaBaseDados;
  Tabela := TSQLQuery.Create(aowner);
  Tabela.SQLConnection := vpabaseDados;
end;


{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesMoedas.Destroy;
begin
    FechaTabela(tabela);
    Tabela.Destroy;
inherited;
end;


function TFuncoesMoedas.ConverteValorParaMoedaBase(  var VpaUnidadeMonetaria : string; VpaCodMoeda : Integer; VpaData : TDateTime; VpaValAConverte : Double ) : Double;
begin
  Result := VpaValAConverte;
  if varia.MoedaBase <> VpaCodMoeda then
  begin
      AdicionaSQLAbreTabela(calcula, 'select * from MovMoedas  MM, CadMoedas CM ' +
                                     ' where CM.I_COD_MOE = MM.I_COD_MOE '+
                                     ' AND MM.I_COD_MOE = ' + IntToStr(VpaCodMoeda) +
                                     'and MM.D_DAT_ATU = ' +SQLTextoDataAAAAMMMDD(Montadata(1,mes(date), ano(date))));
      VpaunidadeMonetaria := calcula.fieldByName('C_CIF_MOE').asString;
      result := VpaValAConverte * (calcula.fieldByName('N_VLR_D' + AdicionaCharE('0',IntToStr(Dia(VpaData)),2)).AsFloat);
  end
  else
     VpaunidadeMonetaria := CurrencyString;
end;

{***************** converte um valor de uma moeda para outro **************** }
function TFuncoesMoedas.ConverteValor(var VpaUnidadeMonetaria : string; VpaMoedaAtual, VpaNovaMoeda : Integer; VpaValor : double ) : Double;
var
  VpfIndiceNovaMoeda, VpfIndiceMoedaAtual : double;
  VpfvalorVen : double;
  VpfCifraoNovaTabela : string;
begin
  result := Vpavalor;
  if VpaMoedaAtual <> VpaNovaMoeda then
  begin
    AdicionaSQLAbreTabela(calcula, 'Select N_VLR_DIA, C_CIF_MOE from CADMOEDAS where I_COD_MOE = ' + IntTostr(VpaNovaMoeda));
    VpfIndiceNovaMoeda := calcula.fieldByName('N_VLR_DIA').AsFloat;
    VpfCifraoNovaTabela := calcula.fieldByName('C_CIF_MOE').AsString;
    calcula.close;

    AdicionaSQLAbreTabela(calcula, 'Select N_VLR_DIA from CADMOEDAS where I_COD_MOE = ' + IntTostr(VpaMoedaAtual));
    VpfIndiceMoedaAtual := calcula.fieldByName('N_VLR_DIA').AsFloat;
    calcula.Close;

    VpfvalorVen := VpaValor;

    if VpamoedaAtual = Varia.MoedaBase then
      VpfvalorVen := VpfValorVen / VpfIndiceNovaMoeda
    else
      begin
         VpfValorVen := VpfValorVen * VpfIndiceMoedaAtual;
         VpfValorVen := VpfValorVen / VpfIndiceNovaMoeda;
      end;

    VpaUnidadeMonetaria := VpfCifraoNovaTabela;
    result :=  VpfValorVen;
  end;
end;

end.
