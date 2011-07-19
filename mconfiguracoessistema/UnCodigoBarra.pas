unit UnCodigoBarra;

interface

uses sysUtils, classes ;

type
 TCodigoBarra = class
   private
   public
     function retornaItem( Mascara : String ) : TstringList;
     function retornaTamanhos( Mascara : String ) : TstringList;
     Function GeraCodigoBarra( Mascara, Empresa, CodEmpFil, Classificacao, Produto,
                               Referencia, Sequencial, BarraFor : string ) : string;
  end;

implementation

uses constantes, funstring;

{***************** Gera os codigos dos Items do codigo ***********************
      'A' = Empresa
      'B' = filial
      'C' = Classificacao do Produto
      'D' = Codigo do Produto
      'E' = Referencia do Fornecedor
      'F' = Sequencial
      'G' = Codigo de Barra do Fornecedor
******************************************************************************}
function TCodigoBarra.retornaItem( Mascara : String ) : TstringList;
var
  laco : integer;
begin
  result := TStringList.create;
  laco := 2;
  while laco < length(mascara) do
  begin
    result.Add(mascara[laco]);
    laco := laco + 3;
  end;
end;

{ ********** gera uma lista com os tamanhos dos items ************************ }
function TCodigoBarra.retornaTamanhos( Mascara : String ) : TstringList;
var
  laco : integer;
begin
  result := TStringList.create;
  laco := 3;
  while laco < length(mascara) do
  begin
    result.Add(mascara[laco] + mascara[laco + 1] );
    laco := laco + 3;
  end;
end;

{***************** gera o codigo de barras *********************************** }
Function TCodigoBarra.GeraCodigoBarra( Mascara, Empresa, CodEmpFil, Classificacao, Produto,
                                       Referencia, Sequencial, BarraFor : string ) : string;
var
  Tipo, Tamanho : TStringList;
  codigo : string;
  laco : integer;
begin
  tipo := retornaItem(mascara);
  tamanho := retornaTamanhos(mascara);
  codigo := '';
  for laco := 0 to Tipo.count - 1 do
    case tipo.Strings[laco][1] of
      'A' : begin codigo := codigo + AdicionaCharE('0', Empresa, StrToInt(Tamanho.Strings[laco])); end;
      'B' : begin codigo := codigo + AdicionaCharE('0', CodEmpFil, StrToInt(Tamanho.Strings[laco])); end;
      'C' : begin codigo := codigo + AdicionaCharE('0', Classificacao, StrToInt(Tamanho.Strings[laco])); end;
      'D' : begin codigo := codigo + AdicionaCharE('0', Produto, StrToInt(Tamanho.Strings[laco])); end;
      'E' : begin codigo := codigo + AdicionaCharE('0', Referencia, StrToInt(Tamanho.Strings[laco])); end;
      'F' : begin codigo := codigo + AdicionaCharE('0', Sequencial, StrToInt(Tamanho.Strings[laco])); end;
      'G' : begin codigo := codigo + AdicionaCharE('0', BarraFor, StrToInt(Tamanho.Strings[laco])); end;
    end;
    result := codigo;
end;

end.
