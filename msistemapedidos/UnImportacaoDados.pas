Unit UnImportacaoDados;

Interface

Uses Classes, DBTables, Tabela, SysUtils, UnDados,SQLExpr, StdCtrls, ComCtrls ;

//classe funcoes
Type TRBFuncoesImportacaoDado = class
  private
    Aux,
    Tabela,
    TabelaMatriz : TSQL;
    VprLabelQtd : TLabel;
    VprBarraProgresso : TProgressBar;
    function RTipCampo(VpaCodTipoCampo : Integer): TRBDTipoCampo;
    procedure CarCamposChavePrimaria(VpaDTabela: TRBDImportacaoDados);
    procedure CarCamposChavePaiFilho(VpaDTabela: TRBDImportacaoDados);
    procedure CarCamposAIgnorar(VpaDTabela: TRBDImportacaoDados);
    function RFiltrosSelect(VpaDTabela : TRBDImportacaoDados; VpaTabelaMatriz : TSQL) : string;
    function RFiltroVendedor(VpaDTabela : TRBDImportacaoDados) : string;
    function RFiltrosTabelaPai(VpaDTabela : TRBDImportacaoDados) : string;
    function RNomTabelasSelect(VpaDTabela : TRBDImportacaoDados) : string;
    procedure AtualizaDataUltimaImportacao(VpaDTabela : TRBDImportacaoDados;VpaDatImportacao : tDateTime);
    Procedure InicializaImportacao(VpaQtdTotalRegistros : Integer);
  public
    constructor cria(VpaBaseDados, VpaBaseDadosMatriz : TSQLConnection;VpaLabelQtd : TLabel;VpaBarraProgresso : TProgressBar);
    destructor destroy;override;
    Function PosTabelasaImportar(VpaTabela : TSQl):Integer;
    function ImportaTabela(VpaDTabela: TRBDImportacaoDados;VpaDatImportacao : TDateTime): string;
    function CarDImportacao(VpaCodTabela : Integer):TRBDImportacaoDados;
    function RDataServidorMatriz : TDateTime;
end;



implementation

Uses FunSql, FunObjeto, Constantes;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesImportacaoDado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesImportacaoDado.cria(VpaBaseDados, VpaBaseDadosMatriz : TSQLConnection;VpaLabelQtd : TLabel;VpaBarraProgresso : TProgressBar);
begin
  inherited create;
  Aux :=TSQL.Create(nil);
  Aux.ASQlConnection := VpaBaseDados;
  Tabela :=TSQL.Create(nil);
  Tabela.ASQlConnection := VpaBaseDados;
  TabelaMatriz :=TSQL.Create(nil);
  TabelaMatriz.ASQlConnection := VpaBaseDadosMatriz;
//  TabelaMatriz.PacketRecords := 400;
  VprLabelQtd := VpaLabelQtd;
  VprBarraProgresso := VpaBarraProgresso;
end;

{********************************* ***********************************************}
destructor TRBFuncoesImportacaoDado.destroy;
begin
  Aux.Free;
  Tabela.Free;
  TabelaMatriz.Free;
  inherited;
end;

{********************************* ***********************************************}
function TRBFuncoesImportacaoDado.PosTabelasaImportar(VpaTabela: TSql):Integer;
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select count(*) QTD from TABELAIMPORTACAO ');
  result := VpaTabela.FieldByName('QTD').AsInteger;
  AdicionaSQLAbreTabela(VpaTabela,'Select * from TABELAIMPORTACAO ' +
//                                  ' WHERE CODTABELA = 31 '+
                                  ' ORDER BY SEQIMPORTACAO ');
end;

{********************************* ***********************************************}
function TRBFuncoesImportacaoDado.ImportaTabela(VpaDTabela: TRBDImportacaoDados;VpaDatImportacao : TDateTime): string;
var
  vpfLaco : Integer;
  VpfRegistroAtual : Integer;
begin
  AdicionaSQLAbreTabela(TabelaMatriz,'Select TAB.* from '+RNomTabelasSelect(VpaDTabela) +
                                     ' Where '+SQLTextoIsNull('TAB.'+VpaDTabela.NomCampoData,SQLTextoDataAAAAMMMDD(VpaDatImportacao))+ '>= '+ SQLTextoDataAAAAMMMDD(VpaDTabela.DatUltimaImportacao)+
                                      RFiltroVendedor(VpaDTabela)+
                                      RFiltrosTabelaPai(VpaDTabela) );
  InicializaImportacao(TabelaMatriz.RecordCount);
  VpfRegistroAtual := 0;
  while not TabelaMatriz.Eof do
  begin
    AdicionaSQLAbreTabela(Tabela,'Select * from '+VpaDTabela.Nomtabela + RFiltrosSelect(VpaDTabela,TabelaMatriz));
    if Tabela.Eof then
      Tabela.Insert
    else
      Tabela.Edit;
    for vpfLaco := 0 to Tabela.Fields.Count - 1 do
    begin
      if VpaDTabela.CamposIgnorar.IndexOf(Tabela.Fields[vpfLaco].DisplayName) < 0 then
        Tabela.FieldByName(Tabela.Fields[vpfLaco].DisplayName).Value := TabelaMatriz.FieldByName(Tabela.Fields[vpfLaco].DisplayName).Value;
    end;


    inc(VpfRegistroAtual);
    VprLabelQtd.Caption :=  IntToStr(VpfRegistroAtual);
    VprLabelQtd.Refresh;
    VprBarraProgresso.Position := VprBarraProgresso.Position + 1;
    VprBarraProgresso.Refresh;
    Tabela.Post;
    TabelaMatriz.Next;
  end;
  AtualizaDataUltimaImportacao(VpaDTabela,VpaDatImportacao);
end;

{********************************* ***********************************************}
procedure TRBFuncoesImportacaoDado.InicializaImportacao(VpaQtdTotalRegistros : Integer);
begin
  VprLabelQtd.Caption := '0';
  VprLabelQtd.Refresh;
  VprBarraProgresso.Position := 0;
  VprBarraProgresso.Max := VpaQtdTotalRegistros;
end;

{********************************* ***********************************************}
function TRBFuncoesImportacaoDado.RDataServidorMatriz: TDateTime;
begin
  AdicionaSQLAbreTabela(TabelaMatriz,'Select SYSDATE from DUAL');
  result := TabelaMatriz.FieldByName('SYSDATE').AsDateTime;
  TabelaMatriz.Close;
end;

{********************************* ***********************************************}
function TRBFuncoesImportacaoDado.RFiltrosSelect(VpaDTabela: TRBDImportacaoDados; VpaTabelaMatriz: TSQL): string;
var
  VpfLaco : Integer;
  VpfDCampo : TRBDCamposImportacaoDados;
begin
  result := '';
  for Vpflaco := 0 to VpaDTabela.CamposChavePrimaria.Count - 1 do
  begin
    VpfDCampo := TRBDCamposImportacaoDados(VpaDTabela.CamposChavePrimaria.Items[VpfLaco]);
    if VpfLaco = 0 then
      result := ' Where '
    else
      result := result + ' AND ';
    result := result + VpfDCampo.NomCampo + ' = ';
    case VpfDCampo.TipCampo of
      tcInteiro  : result := result + VpaTabelaMatriz.FieldByName(VpfDCampo.NomCampo).AsString ;
      tcCaracter :  result := result + ''''+ VpaTabelaMatriz.FieldByName(VpfDCampo.NomCampo).AsString +'''';
      tcData     :  result := result + SQLTextoDataAAAAMMMDD(VpaTabelaMatriz.FieldByName(VpfDCampo.NomCampo).AsDateTime);
    end;
  end;


end;

{********************************* ***********************************************}
function TRBFuncoesImportacaoDado.RFiltrosTabelaPai(VpaDTabela: TRBDImportacaoDados): string;
var
  VpfLaco : Integer;
  VpfDCampo : TRBDCamposImportacaoDados;
begin
  result := '';
  for VpfLaco := 0 to VpaDTabela.CamposChavePaiFilho.Count - 1 do
  begin
    VpfDCampo := TRBDCamposImportacaoDados(VpaDTabela.CamposChavePaiFilho.Items[VpfLaco]);
    result := RESULT + ' AND TAB.'+VpfDCampo.NomCampo + ' = PAI.'+ VpfDCampo.NomCampoPai

  end;
end;

{********************************* ***********************************************}
function TRBFuncoesImportacaoDado.RFiltroVendedor(VpaDTabela: TRBDImportacaoDados): string;
begin
  result := '';
  if not config.ImportarTodosVendedores then
  begin
    if VpaDTabela.DesFiltroVendedor <> '' then
    begin
      if VpaDTabela.NomTabelaPai <> '' then
        result := 'AND PAI.'+VpaDTabela.DesFiltroVendedor +' = '+IntToStr(varia.CodVendedorSistemaPedidos)
      else
        result := 'AND TAB.'+VpaDTabela.DesFiltroVendedor +' = '+IntToStr(varia.CodVendedorSistemaPedidos);
    end;
  end;

end;

{********************************* ***********************************************}
function TRBFuncoesImportacaoDado.RNomTabelasSelect(VpaDTabela: TRBDImportacaoDados): string;
begin
  result := VpaDTabela.Nomtabela + ' TAB ';
  if VpaDTabela.NomTabelaPai <> '' then
    result := result +' , '+VpaDTabela.NomTabelaPai + ' PAI ';
end;

{********************************* ***********************************************}
function TRBFuncoesImportacaoDado.RTipCampo(VpaCodTipoCampo: Integer): TRBDTipoCampo;
begin
  case VpaCodTipoCampo of
    1 : Result := tcInteiro;
    2 : result := tcNumerico;
    3 : Result := tcCaracter;
    4 : Result := tcData;
  end;
end;

{********************************* ***********************************************}
procedure TRBFuncoesImportacaoDado.AtualizaDataUltimaImportacao(VpaDTabela: TRBDImportacaoDados;VpaDatImportacao: tDateTime);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from TABELAIMPORTACAO '+
                               ' Where CODTABELA = '+IntToStr(VpaDTabela.CodTabela));
  Tabela.Edit;
  Tabela.FieldByName('DATIMPORTACAO').AsDateTime := VpaDatImportacao;
  Tabela.Post;
  Tabela.Close;
end;

{********************************* ***********************************************}
procedure TRBFuncoesImportacaoDado.CarCamposAIgnorar(VpaDTabela: TRBDImportacaoDados);
begin
  VpaDTabela.CamposIgnorar.Clear;
  AdicionaSQLAbreTabela(Tabela,'Select * from TABELAIMPORTACAOIGNORARCAMPO '+
                            ' Where CODTABELA = '+IntToStr(VpaDTabela.CodTabela));
  while not Tabela.Eof do
  begin
    VpaDTabela.CamposIgnorar.Add(Tabela.FieldByName('NOMCAMPO').AsString);
    Tabela.Next;
  end;
  Tabela.Close;
end;

{********************************* ***********************************************}
procedure TRBFuncoesImportacaoDado.CarCamposChavePaiFilho(VpaDTabela: TRBDImportacaoDados);
var
  VpfDCampo : TRBDCamposImportacaoDados;
begin
  FreeTObjectsList(VpaDTabela.CamposChavePaiFilho);
  AdicionaSQLAbreTabela(Tabela,'Select * from TABELAIMPORTACAOCAMPOPAIFILHO '+
                            ' Where CODTABELA = '+IntToStr(VpaDTabela.CodTabela));
  while not Tabela.Eof do
  begin
    VpfDCampo := VpaDTabela.addCampoPaiFilho;
    VpfDCampo.NomCampo := Tabela.FieldByName('NOMCAMPO').AsString;
    VpfDCampo.NomCampoPai := Tabela.FieldByName('NOMCAMPOPAI').AsString;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{********************************* ***********************************************}
procedure TRBFuncoesImportacaoDado.CarCamposChavePrimaria(VpaDTabela: TRBDImportacaoDados);
var
  VpfDCampo : TRBDCamposImportacaoDados;
begin
  FreeTObjectsList(VpaDTabela.CamposChavePrimaria);
  AdicionaSQLAbreTabela(Tabela,'Select * from TABELAIMPORTACAOFILTRO '+
                            ' Where CODTABELA = '+IntToStr(VpaDTabela.CodTabela));
  while not Tabela.Eof do
  begin
    VpfDCampo := VpaDTabela.addCampoFiltro;
    VpfDCampo.NomCampo := Tabela.FieldByName('NOMCAMPO').AsString;
    VpfDCampo.TipCampo := RTipCampo(Tabela.FieldByName('TIPCAMPO').AsInteger);
    Tabela.Next;
  end;
  Tabela.Close;
end;

{********************************* ***********************************************}
function TRBFuncoesImportacaoDado.CarDImportacao(VpaCodTabela : Integer): TRBDImportacaoDados;
begin
  result := TRBDImportacaoDados.cria;
  Result.CamposIgnorar.Clear;
  FreeTObjectsList(Result.CamposChavePrimaria);
  AdicionaSQLAbreTabela(Tabela,'Select * from TABELAIMPORTACAO ' +
                               ' Where CODTABELA = '+IntToStr(VpaCodTabela));
  Result.CodTabela := Tabela.FieldByName('CODTABELA').AsInteger;
  Result.Nomtabela := Tabela.FieldByName('NOMTABELA').AsString;
  Result.NomTabelaPai := Tabela.FieldByName('NOMTABELAPAI').AsString;
  Result.Destabela := Tabela.FieldByName('DESTABELA').AsString;
  result.NomCampoData := Tabela.FieldByName('DESCAMPODATA').AsString;
  result.DesFiltroVendedor := Tabela.FieldByName('DESFILTROVENDEDOR').AsString;
  result.DatUltimaImportacao := Tabela.FieldByName('DATIMPORTACAO').AsDateTime;
  if result.CodTabela > 0 then
  begin
    CarCamposChavePrimaria(Result);
    CarCamposAIgnorar(result);
    CarCamposChavePaiFilho(result);
  end;
end;

end.
