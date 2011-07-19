Unit UnDER;

Interface

Uses Classes, DBTables, UnDadosCR, SysUtils,Graphics;

Const
  LinInicial = 1;
  LinFinal = 20;
  ColFinal = 20;
  ColInicial = 1;
  ColDescricao = 2;
  ColOrcado = 3;
  ColRealizado = 4;
  ColDiferenca = 5;


//classe localiza
Type TRBLocalizaDER = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesDER = class(TRBLocalizaDER)
  private
    CorFonteTitulo,
    CorFundoTitulo,
    CorFonteNegativo,
    CorFonteTituloReceitas,
    CorFonteReceitas,
    CorFundoTituloReceitas,
    CorFundoReceitas,
    CorFundoDespesas,
    CorFonteDespesas,
    CorFonteTituloDespesas,
    CorFundoTituloDespesas: TColor;

    // fonte
    TamanhoFonte : integer;
    NomeFonte : string;
    AlturaLinha : Integer;

    TamanhoGrade : Integer;

    Aux,
    DER :TQuery;
  public
    constructor cria;
    procedure CarMetasVendedores(VpaDDER : TRBDDERCorpo);
end;



implementation

Uses FunSql, FunObjeto, FunData;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaDER
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaDER.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesDER
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesDER.cria;
begin
  inherited create;
  Aux := TQuery.Create(nil);
  Aux.DataBaseName := 'BaseDados';

  DER := TQuery.Create(nil);
  DER.DataBaseName := 'BaseDados';
end;


{******************************************************************************}
procedure TRBFuncoesDER.CarMetasVendedores(VpaDDER : TRBDDERCorpo);
var
  VpfDVendedor : TRBDDERVendedor;
begin
  AdicionaSQLAbreTabela(DER,'SELECT VEN.I_COD_VEN, VEN.C_NOM_VEN , '+
                            '  MET.VALMETA '+
                            ' FROM CADVENDEDORES VEN, METAVENDEDOR MET '+
                            ' Where VEN.I_COD_VEN = MET.CODVENDEDOR '+
                            ' AND MET.ANOMETA = '+IntToStr(VpaDDER.Ano)+
                            ' and MET.MESMETA = '+IntToStr(VpaDDER.Mes));
  While not DER.eof do
  begin
    VpfDVendedor := VpaDDER.addVendedor;
    VpfDVendedor.CodVendedor := DER.FieldByName('I_COD_VEN').AsInteger;
    VpfDVendedor.NomVendedor := DER.FieldByName('C_NOM_VEN').AsString;
    VpfDVendedor.ValMeta := DER.FieldByName('VALMETA').AsFloat;
    DER.next;
  end;
  DER.close;
end;


end.
