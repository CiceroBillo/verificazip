unit UnDados;

interface

Type
  TRBTipoCampo = (tcString,tcInteiro,tcNumerico,tcData);

  TRBDCampoChave = class
    public
      NomCampo : String;
      TipCampo : TRBTipoCampo;
      constructor cria;
  end;

Type
  TRBDFilial = class
    public
      CodFilial : Integer;
      NomFantasia,
      DesSite,
      DesEmail,
      DesEmailComercial,
      DesEndereco,
      DesBairro,
      DesCidade,
      DesUF,
      DesCep,
      DesCNPJ,
      DesInscricaoEstadual,
      DesFone : String;
//      constructor cria;
//      destructor destroy;override;
end;


implementation

{******************************************************************************}
constructor TRBDCampoChave.cria;
begin
  inherited;
end;

end.
