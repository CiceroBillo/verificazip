unit UnPcp;

interface

Uses classes;

Type
  TRBFuncoesPCP = class
    public
      constructor cria;
      destructor destroy;overload;
      function RQtdLinhas(VpaDatInicio, VpaDatFim : TDateTime;VpaIntervalo : Integer) :Integer;
end;



implementation

Uses FunData;

{******************************************************************************}
constructor TRBFuncoesPCP.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBFuncoesPCP.destroy;
begin
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesPCP.RQtdLinhas(VpaDatInicio, VpaDatFim : TDateTime;VpaIntervalo : Integer) :Integer;
begin
  if (VpaDatFim >= VpaDatInicio) and (VpaIntervalo > 0 ) then
  begin
    result := ((60 div VpaIntervalo) * 24);
    if VpaDatFim > VpaDatInicio then
      Result := result *(DiasPorPeriodo(VpaDatInicio,VpaDatFim)+1);
  end
  else
    result := 1;
end;


end.
