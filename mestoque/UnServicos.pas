unit UnServicos;
{Verificado
-.edit;
}
interface
Uses Db, DBTables, classes, sysUtils, UnMoedas, UnDados, UnDadosProduto, SQLExpr;

// localizacao dos servicos
Type TLocalizaServico = class
  private
  public
  procedure LocalizaServico(VpaTabela : TDataset);
  procedure LocalizaServicoTabelaPreco( VpaTabela : TDataSet;VpaTabelaPreco ,
                                        VpaCodServico : String );
end;

//funcoes dos servicos
Type TFuncoesServico = Class(TLocalizaServico)
  private
    UnAux, UnCadServico : TSQLQuery ;
    VprBaseDados : TSQLConnection;
  public
    Constructor Cria(VpaBaseDados : TSQLConnection);
    procedure OrganizaTabelaPreco(VpaCodTabela : integer; SomenteAtividade : Boolean);
    procedure AlterarAtividadeServico(VpaCodServico, VpaAtividadeAtual : String);
    procedure AlteraValorServico(VpaCodServico,VpaTabela,VpaValor : String);
    procedure ConverteMoedaTabela(VpaNovaMoeda, VpaTabelaPreco, VpaCodServico : Integer );
    procedure AdicionaServicoNaTabelaPreco( VpaCodServico, VpaCodMoeda, VpaCodTabela : Integer; VpaValorVenda : double; VpaCifraoMoeda : string );
    function ExisteServico(VpaCodServico: Integer; VpaDPropostaServico: TRBDPropostaServico): Boolean; overload;
    function ExisteServico(VpaCodServico: Integer; VpaDChamadoServicoExecutado: TRBDChamadoServicoExecutado): Boolean; overload;
    function ExisteServico(VpaCodServico: Integer; VpaDChamadoServicoOrcado: TRBDChamadoServicoOrcado): Boolean; overload;
    function ExisteServico(VpaCodServico: Integer; VpaDServicoFixoAmostra : TRBDServicoFixoAmostra ): Boolean; overload;
end;

Var
  FunServico : TFuncoesServico;

implementation
Uses  FunSql, Constantes, FunString, UnProdutos;

{***************** localiza o servico passado como parametro ******************}
procedure TLocalizaServico.LocalizaServico(VpaTabela : TDataSet);
begin
  AdicionaSqlAbreTabela(VpaTabela,'Select * from CadServico '+
                                  ' Where I_Cod_Emp = ' + IntToStr(Varia.CodigoEmpresa));
end;

{******************* localiza o servico na tabela de preco ********************}
procedure TLocalizaServico.LocalizaServicoTabelaPreco( VpaTabela : TDataSet;VpaTabelaPreco,VpaCodServico : String );
begin
  AdicionaSQLAbreTabela(VpaTabela, ' SELECT * FROM MovTabelaPrecoServico' +
                                ' WHERE I_cod_emp =  ' + IntTostr(varia.CodigoEmpresa) +
                                ' and i_cod_tab = ' + VpaTabelaPreco +
                                ' and i_Cod_Ser = ' + VpaCodServico );
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         eventos da classe funcoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************************** cria a classe ************************************}
Constructor TFuncoesServico.Cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  VprBaseDados := VpaBaseDados;
  UnAux := TSQLQuery.Create(nil);
  UnAux.SQLConnection := VpaBaseDados;
  UnCadServico := TSQLQuery.Create(nil);
  UnCadServico.SQLConnection := VpaBaseDados
end;

{***************** organiza a tabela de preco *********************************}
procedure TFuncoesServico.OrganizaTabelaPreco(VpaCodTabela : integer; SomenteAtividade : Boolean );
begin
  LocalizaServico(UnCadServico);

  while not UnCadServico.Eof do
  begin
    LocalizaServicoTabelaPreco(UnAux, IntToStr(VpaCodTabela),
                                UnCadServico.FieldByName('I_Cod_Ser').AsString);

    //se nao existir o produto na tabela de preco
    if UnAux.eof then
    begin
      // se o produto estiver em atividade
      if (UnCadServico.FieldByName('C_ATI_Ser').AsString = 'S') or (SomenteAtividade) then
        ExecutaComandoSql(UnAux,'Insert Into MovTabelaPrecoServico '+
                                ' (I_Cod_Emp,I_Cod_Tab,I_Cod_Ser,I_Cod_Moe, C_Cif_Moe,D_ULT_ALT)'+
                                ' values('+IntToStr(varia.CodigoEmpresa)+','+
                                IntToStr(VpaCodTabela) +','+ UnCadServico.FieldByName('I_Cod_Ser').Asstring + ','+
                                IntToStr(Varia.MoedaBase) + ','''+CurrencyString+ ''','+ SQLTextoDataAAAAMMMDD(DATE)+ ')');
    end;
    UnCadServico.Next;
  end;
end;

{******************* Altera a atividade do servico ****************************}
procedure TFuncoesServico.AlterarAtividadeServico(VpaCodServico, VpaAtividadeAtual: String);
begin
  if VpaAtividadeAtual = 'S' Then
    ExecutaComandoSql(UnAux,'Update CadServico ' +
                            ' Set C_Ati_Ser = ''N'''+
                            ' , D_ULT_ALT = ' + SQLTextoDataAAAAMMMDD(DATE) +
                            ' Where I_Cod_Ser = ' + VpaCodServico)
  else
    ExecutaComandoSql(UnAux,'Update CadServico ' +
                            ' Set C_Ati_Ser = ''S'''+
                            ' , D_ULT_ALT = ' + SQLTextoDataAAAAMMMDD(DATE)+
                            ' Where I_Cod_Ser = ' + VpaCodServico);
end;

{******************** altera o valor do servico *******************************}
procedure TFuncoesServico.AlteraValorServico(VpaCodServico, VpaTabela,VpaValor : String);
begin
  VpaValor := SubstituiStr(Vpavalor,',','.' );
  ExecutaComandoSql(UnAux,'Update MovTabelaPrecoServico '+
                          ' set N_Vlr_Ven = ' + VpaValor +
                          ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(DATE) +
                          ' Where I_Cod_Emp = ' + IntToStr(Varia.CodigoEmpresa) +
                          ' and I_Cod_Tab =  '+ VpaTabela +
                          ' and I_Cod_Ser = ' + VpaCodServico);
end;

{******************* converte o valor da moeda da tabela **********************}
procedure TFuncoesServico.ConverteMoedaTabela(VpaNovaMoeda, VpaTabelaPreco, VpaCodServico : Integer );
var
  VpfCifraoNovaTabela : string;
  Moedas : TFuncoesMoedas;
  VpfValor : Double;
begin
  AdicionaSQLAbreTabela(UnCadServico, ' select * from MovTabelaPrecoServico ' +
                                ' where i_cod_emp = ' + intToStr(varia.CodigoEmpresa) +
                                ' and i_cod_tab = ' + intToStr(VpaTabelaPreco) +
                                ' and i_Cod_Ser = ' + intToStr(VpaCodServico) );
  Moedas := TFuncoesMoedas.criar(nil,VprBaseDados);
  VpfValor := Moedas.ConverteValor( VpfCifraoNovaTabela,UnCadServico.fieldByname('i_cod_moe').AsInteger,
                                                VpaNovaMoeda, UnCadServico.fieldByname('n_vlr_ven').AsFloat);
  ExecutaComandoSql(UnAux,'Update MovTabelaPrecoServico '+
                     ' set I_Cod_Moe = ' + IntToStr(VpaNovaMoeda)+ ', '+
                     ' C_Cif_Moe = '''+ vpfCifraoNovaTabela + ''',' +
                     ' N_Vlr_Ven = ' + SubstituiStr(FloatToStr(VpfValor),',','.') +
                     ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(DATE) +
                     ' where i_cod_emp = ' + intToStr(varia.CodigoEmpresa) +
                     ' and i_cod_tab = ' + intToStr(VpaTabelaPreco) +
                     ' and i_Cod_Ser = ' + intToStr(VpaCodServico) );
end;

{********************* adiciona o servico na tabela de preco ******************}
procedure TFuncoesServico.AdicionaServicoNaTabelaPreco( VpaCodServico, VpaCodMoeda, VpaCodTabela : Integer; VpaValorVenda : double; VpaCifraoMoeda : string );
var
  Produtos : TFuncoesProduto;
  VpfValor : String;
begin
  // esta select é feita somente para a tabela aux achar o seu database para depois passar de parametro para a unprodutos
  AdicionaSqlAbreTabela(UnAux,'Select * from cfg_Geral');

  VpfValor := SubstituiStr(FloatToStr(VpaValorVenda),',','.');
  Produtos := TFuncoesProduto.criar(nil,VprBaseDados);
  produtos.LocalizaCadTabelaPreco(UnAux, VpaCodTabela);
  if not UnAux.Eof then
  begin
    ExecutaComandoSql(UnAux,'insert into MovTabelaPrecoServico ' +
                            ' (I_Cod_Emp , I_Cod_Tab, I_Cod_Ser, I_Cod_Moe,C_Cif_Moe,'+
                            ' N_Vlr_Ven,D_ULT_ALT)  values ('+IntToStr(Varia.CodigoEmpresa) +','+
                            IntToStr(VpaCodTabela) + ',' +IntToStr(VpaCodServico) +','+
                            InttoStr(VpaCodMoeda) + ',''' + VpaCifraoMoeda +''','+
                            VpfValor+','+ SQLTextoDataAAAAMMMDD(DATE)+ ')');
  end;
end;

{******************************************************************************}
function TFuncoesServico.ExisteServico(VpaCodServico: Integer; VpaDPropostaServico: TRBDPropostaServico): Boolean;
begin
  AdicionaSQLAbreTabela(UnAux,'SELECT SER.I_COD_EMP, SER.C_NOM_SER, TBS.N_VLR_VEN'+
                              ' FROM CADSERVICO SER, MOVTABELAPRECOSERVICO TBS'+
                              ' WHERE'+
                              ' TBS.I_COD_EMP = SER.I_COD_EMP'+
                              ' AND TBS.I_COD_SER = SER.I_COD_SER'+
                              ' AND SER.I_COD_SER = '+IntToStr(VpaCodServico)+
                              ' AND SER.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa));
  Result:= not UnAux.Eof;
  VpaDPropostaServico.CodServico:= VpaCodServico;
  VpaDPropostaServico.CodEmpresaServico:= UnAux.FieldByName('I_COD_EMP').AsInteger;
  VpaDPropostaServico.NomServico:= UnAux.FieldByName('C_NOM_SER').AsString;
  VpaDPropostaServico.QtdServico:= 1;
  VpaDPropostaServico.ValUnitario:= UnAux.FieldByName('N_VLR_VEN').AsFloat;
  UnAux.Close;
end;

{******************************************************************************}
function TFuncoesServico.ExisteServico(VpaCodServico: Integer; VpaDChamadoServicoExecutado: TRBDChamadoServicoExecutado): Boolean;
begin
  AdicionaSQLAbreTabela(UnAux,'SELECT SER.I_COD_EMP, SER.C_NOM_SER, TBS.N_VLR_VEN'+
                              ' FROM CADSERVICO SER, MOVTABELAPRECOSERVICO TBS'+
                              ' WHERE'+
                              ' TBS.I_COD_EMP = SER.I_COD_EMP'+
                              ' AND TBS.I_COD_SER = SER.I_COD_SER'+
                              ' AND SER.I_COD_SER = '+IntToStr(VpaCodServico)+
                              ' AND SER.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa));
  Result:= not UnAux.Eof;
  VpaDChamadoServicoExecutado.CodServico:= VpaCodServico;
  VpaDChamadoServicoExecutado.NomServico:= UnAux.FieldByName('C_NOM_SER').AsString;
  VpaDChamadoServicoExecutado.CodEmpresaServico:= UnAux.FieldByName('I_COD_EMP').AsInteger;
  VpaDChamadoServicoExecutado.ValUnitario:= UnAux.FieldByName('N_VLR_VEN').AsFloat;
  VpaDChamadoServicoExecutado.Quantidade := 1;
  UnAux.Close;
end;

{******************************************************************************}
function TFuncoesServico.ExisteServico(VpaCodServico: Integer; VpaDChamadoServicoOrcado: TRBDChamadoServicoOrcado): Boolean;
begin
  AdicionaSQLAbreTabela(UnAux,'SELECT SER.I_COD_EMP, SER.C_NOM_SER, TBS.N_VLR_VEN'+
                              ' FROM CADSERVICO SER, MOVTABELAPRECOSERVICO TBS'+
                              ' WHERE'+
                              ' TBS.I_COD_EMP = SER.I_COD_EMP'+
                              ' AND TBS.I_COD_SER = SER.I_COD_SER'+
                              ' AND SER.I_COD_SER = '+IntToStr(VpaCodServico)+
                              ' AND SER.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa));
  Result:= not UnAux.Eof;
  VpaDChamadoServicoOrcado.CodServico:= VpaCodServico;
  VpaDChamadoServicoOrcado.NomServico:= UnAux.FieldByName('C_NOM_SER').AsString;
  VpaDChamadoServicoOrcado.CodEmpresaServico:= UnAux.FieldByName('I_COD_EMP').AsInteger;
  VpaDChamadoServicoOrcado.ValUnitario:= UnAux.FieldByName('N_VLR_VEN').AsFloat;
  UnAux.Close;
end;

{******************************************************************************}
function TFuncoesServico.ExisteServico(VpaCodServico: Integer; VpaDServicoFixoAmostra : TRBDServicoFixoAmostra ): Boolean;
begin
  AdicionaSQLAbreTabela(UnAux,'SELECT SER.I_COD_EMP, SER.C_NOM_SER, TBS.N_VLR_VEN'+
                              ' FROM CADSERVICO SER, MOVTABELAPRECOSERVICO TBS'+
                              ' WHERE'+
                              ' TBS.I_COD_EMP = SER.I_COD_EMP'+
                              ' AND TBS.I_COD_SER = SER.I_COD_SER'+
                              ' AND SER.I_COD_SER = '+IntToStr(VpaCodServico)+
                              ' AND SER.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa));
  Result:= not UnAux.Eof;
  VpaDServicoFixoAmostra.CodServico:= VpaCodServico;
  VpaDServicoFixoAmostra.NomServico:= UnAux.FieldByName('C_NOM_SER').AsString;
  VpaDServicoFixoAmostra.CodEmpresaServico:= UnAux.FieldByName('I_COD_EMP').AsInteger;
  VpaDServicoFixoAmostra.ValUnitario:= UnAux.FieldByName('N_VLR_VEN').AsFloat;
  VpaDServicoFixoAmostra.QtdServico := 1;
  UnAux.Close;
end;

{d5 ******************************************************************************
initialization
  FunServico := TFuncoesServico.cria;

{******************************************************************************
finalization
  FunServico.free;}


end.
