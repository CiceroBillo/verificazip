Unit UnCotacaoGrafica;

Interface

Uses Classes, DBTables, UnDados;

//classe localiza
Type TRBLocalizaCotacaoGrafica = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesCotacaoGrafica = class(TRBLocalizaCotacaoGrafica)
  private
    function CalculaValorAcertos(VpaDCotacao : TRBDCotacaoGrafica) : string;
  public
    constructor cria;
    function CalculaCotacao(VpaDCotacao : TRBDCotacaoGrafica) : string;
end;



implementation

Uses FunSql, Constantes;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaCotacaoGrafica
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaCotacaoGrafica.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesCotacaoGrafica
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesCotacaoGrafica.cria;
begin
  inherited create;
end;

{******************************************************************************}
function TRBFuncoesCotacaoGrafica.CalculaValorAcertos(VpaDCotacao : TRBDCotacaoGrafica) : string;
begin
  result := '';
  VpaDCotacao.ValAcerto := (VpaDCotacao.QtdCorFrente + VpaDCotacao.QtdCorVerso - 1) * varia.ValAcerto;
end;

{******************************************************************************}
function TRBFuncoesCotacaoGrafica.CalculaCotacao(VpaDCotacao : TRBDCotacaoGrafica) : string;
begin
  result := CalculaValorAcertos(VpaDCotacao);
  VpaDCotacao.ValTotal := VpaDCotacao.ValAcerto;
end;

end.
