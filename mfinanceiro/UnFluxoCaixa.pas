Unit UnFluxoCaixa;

Interface

Uses Classes,Graphics, unDadosCR, SysUtils, CGrades, SqlExpr,Tabela;

Const
  LinInicial = 0;
  LinFinal = 18;
  LinPrimeiraContaCaixa = 1;
  ColInicial = 0;
  ColTituloLinha = 1;
  ColAplicacao = 2;
  ColSaldoAtual = 3;
  ColSaldoAnterior = 4;

//classe localiza
Type TRBLocalizaFluxoCaixa = class
  private
  public
    procedure LocalizaContas(VpaTabela : TSQl;VpaCodFilial : Integer);
    procedure LocalizaSaldoAnteriorCR(VpaTabela : TSql;VpaDatInicio : TDateTime;VpaCodFilial : Integer);
    procedure LocalizaSaldoAnteriorCP(VpaTabela : TSql;VpaDatInicio : TDateTime;VpaCodFilial : Integer;VpaIndMostrarProrrogado : Boolean);
    procedure LocalizaChequeSaldoAnterior(VpaTabela : TSQl;VpaDatInicio : TDateTime;VpaCodFilial : Integer);
    procedure LocalizaCheques(VpaTabela : TSQl;VpaDatInicio, VpaDatFim: TDateTime;VpaCodFilial : Integer);
    procedure LocalizaContasAReceber(VpaTabela : TSQl;VpaDatInicio,VpaDatFim : TDateTime;VpaClientesDuvidosos : Boolean;VpaCodFilial : Integer);
    procedure LocalizaContasAPagar(VpaTabela : TSQl;VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial : Integer;VpaIndMostrarProrrogado : Boolean);
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesFluxoCaixa = class(TRBLocalizaFluxoCaixa)
  private
    Aux,
    Tabela,
    Conta : TSQL;
    // cores
    CorFonteCaixa,
    CorFundoCaixa,
    CorFonteNegativo,
    CorFonteTituloCR,
    CorFonteCR,
    CorFundoTituloCR,
    CorFundoCR,
    CorFundoCP,
    CorFonteCP,
    CorFonteTituloCP,
    CorFundoTituloCP: TColor;
    // fonte
    TamanhoFonte : integer;
    NomeFonte : string;
    AlturaLinha : Integer;

    TamanhoGrade : Integer;
    procedure InicializaGradeGeral(VpaGrade : TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
    function AdicionaContaFluxo(VpaNumConta : String;VpaDFluxo : TRBDFluxoCaixaCorpo):TRBDFluxoCaixaConta;
    procedure CarContasFluxo(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarSaldoAnterior(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarSaldoAnteriorCR(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarSaldoAnteriorCP(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarCheques(VpaDFluxo : TRBDFluxoCaixaCorpo;VpaIndSaldoAnterior : Boolean);
    procedure CarContasaReceber(VpaDFluxo : TRBDFluxoCaixaCorpo;VpaClientesDuvidosos : Boolean);
    procedure CarContasAPagar(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarMesContasaReceberGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo;VpaMes,VpaAno : Integer);
    procedure CarDiasTotaisFluxoGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo;VpaMes,VpaAno : Integer);
    procedure CarValorAplicacaoGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarContaCaixaGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure RContaCaixaDia(VpanumConta :string; VpaFluxoDia : TRBDFluxoCaixaDia;VpaDFluxoMes : TRBDFluxoCaixaMes; VpaDFluxo : TRBDFluxoCaixaCorpo);
    function RContaFluxoCaixa(VpaNumConta : string; VpaDFluxo : TRBDFluxoCaixaCorpo):TRBDFluxoCaixaConta;
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    procedure CarregaCores(VpaCorFonteCaixa, VpaCorFundoCaixa, VpaCorFonteNegativo, VpaCorFonteTituloCR, VpaCorFonteCR, VpaCorFundoTituloCR, VpaCorFundoCR, VpaCorFonteCP,VpaCorFundoCP, VpaCorFonteTituloCP, VpaCorFundoTituloCP: TColor; VpaNomFonte : string; VpaTamFonte,VpaAltLinha : Integer);
    procedure InicializaFluxoDiario(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarFluxoCaixa(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
    function LinhaParcelasContasAReceber(VpaLinha : Integer;VpaDFluxo : TRBDFluxoCaixaCorpo) : Boolean;
    function LinhaParcelasContasAReceberDuvidoso(VpaLinha : Integer;VpaDFluxo : TRBDFluxoCaixaCorpo) : Boolean;
    function LinhaParcelasContasaPagar(VpaLinha : Integer;VpaDFluxo : TRBDFluxoCaixaCorpo) : Boolean;
    function LinhaChequeCR(VpaLinha : Integer;VpaDFluxo : TRBDFluxoCaixaCorpo) : Boolean;
    function LinhaChequeCP(VpaLinha : Integer;VpaDFluxo : TRBDFluxoCaixaCorpo) : Boolean;
    function RDia(VpaLinha, VpaColuna : Integer;VpaDFluxo : TRBDFluxoCaixaCorpo): TRBDFluxoCaixaDia;
    function RContaCaixa(VpaLinha, VpaColuna : Integer;VpaDFluxo : TRBDFluxoCaixaCorpo): TRBDFluxoCaixaConta;
end;



implementation

Uses FunSql, FunObjeto, funData, Constmsg;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaFluxoCaixa
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaFluxoCaixa.cria;
begin
  inherited create;
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaContas(VpaTabela : TSQL;VpaCodFilial : Integer);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(VpaTabela,'Select CON.C_NRO_CON '+
                                  ' from CADCONTAS CON '+
                                  ' Where CON.C_IND_ATI = ''T''');
  if VpaCodFilial <> 0 then
    AdicionaSQLTabela(VpaTabela,'and CON.I_EMP_FIL = '+IntToStr(VpaCodFilial));
  AdicionaSQLTabela(VpaTabela,' order by C_NRO_CON ');
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaSaldoAnteriorCP(VpaTabela: TSql; VpaDatInicio: TDateTime;VpaCodFilial : Integer;VpaIndMostrarProrrogado : Boolean);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(VpaTabela,'Select  MOV.C_NRO_CON, MOV.I_EMP_FIL, MOV.I_LAN_APG, MOV.I_PAR_FIL, MOV.I_COD_FRM, MOV.D_DAT_VEN, MOV.C_NRO_DUP, MOV.N_VLR_DUP, '+
                                  ' MOV.D_DAT_VEN, '+
                                  ' CAD.I_COD_CLI, CAD.I_NRO_NOT, CAD.D_DAT_EMI, '+
                                  ' CLI.C_NOM_CLI '+
                                  ' from MOVCONTASAPAGAR MOV, CADCONTASAPAGAR CAD, CADCLIENTES CLI '+
                                 ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                                 ' AND MOV.I_LAN_APG = CAD.I_LAN_APG '+
                                 ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                 ' AND MOV.D_DAT_PAG IS NULL '+
                                 ' AND MOV.D_DAT_VEN < '+SQLTextoDataAAAAMMMDD(VpaDatInicio));
  if VpaCodFilial <> 0 then
    AdicionaSQLTabela(VpaTabela,'and MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial));
  if not VpaIndMostrarProrrogado then
    AdicionaSQLTabela(VpaTabela,'AND MOV.C_DES_PRR = ''N''');
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaSaldoAnteriorCR(VpaTabela : TSQL;VpaDatInicio: TDateTime;VpaCodFilial : Integer);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(VpaTabela,'Select  MOV.C_NRO_CON, MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_NRO_PAR, MOV.I_PAR_FIL, MOV.I_COD_FRM, MOV.D_DAT_VEN, MOV.C_NRO_DUP, MOV.N_VLR_PAR, '+
                                  ' MOV.D_DAT_PRO, MOV.C_MOS_FLU,'+
                                  ' CAD.I_COD_CLI, CAD.I_NRO_NOT, CAD.D_DAT_EMI, '+
                                  ' CLI.C_NOM_CLI '+
                                  ' from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADCLIENTES CLI '+
                                 ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                                 ' AND MOV.I_LAN_REC = CAD.I_LAN_REC '+
                                 ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                 ' AND MOV.D_DAT_PAG IS NULL '+
                                 ' AND MOV.D_DAT_PRO < '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                                 ' AND MOV.C_FUN_PER =  ''N''');

  if VpaCodFilial <> 0  then
    AdicionaSQLTabela(VpaTabela,'and MOV.I_EMP_FIL = ' +IntToStr(VpaCodFilial));
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaCheques(VpaTabela: TSQl; VpaDatInicio, VpaDatFim: TDateTime;VpaCodFilial : Integer);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(VpaTabela,'Select CHE.SEQCHEQUE, CHE.CODBANCO, CHE.CODFORMAPAGAMENTO, CHE.NUMCHEQUE, '+
                                  ' CHE.CODUSUARIO, CHE.NUMCONTACAIXA, CHE.NOMEMITENTE, CHE.TIPCHEQUE, '+
                                  ' CHE.VALCHEQUE, CHE.DATCADASTRO, CHE.DATVENCIMENTO, CHE.DATCOMPENSACAO, '+
                                  ' CHE.DATDEVOLUCAO,'+
                                  ' CON.C_NOM_CRR, CON.C_TIP_CON,  '+
                                  ' FRM.C_NOM_FRM ' +
                                  ' from CHEQUE CHE, CADCONTAS CON, CADFORMASPAGAMENTO FRM'+
                                 ' WHERE '+SQLTextoDataEntreAAAAMMDD('CHE.DATVENCIMENTO',VpaDatInicio,VpaDatFim,false)+
                                 ' AND CHE.DATCOMPENSACAO IS NULL'+
                                 ' AND CHE.CODFORMAPAGAMENTO = FRM.I_COD_FRM '+
                                 ' AND CHE.NUMCONTACAIXA = CON.C_NRO_CON ');
  if VpaCodFilial <> 0 then
    AdicionaSQLTabela(VpaTabela,'AND CON.I_EMP_FIL = '+IntToStr(VpaCodFilial));
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaChequeSaldoAnterior(VpaTabela : TSQL;VpaDatInicio : TDateTime;VpaCodFilial : Integer);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLAbreTabela(VpaTabela,'Select CHE.SEQCHEQUE, CHE.CODBANCO, CHE.CODFORMAPAGAMENTO, CHE.NUMCHEQUE, '+
                                  ' CHE.CODUSUARIO, CHE.NUMCONTACAIXA, CHE.NOMEMITENTE, CHE.TIPCHEQUE, '+
                                  ' CHE.VALCHEQUE, CHE.DATCADASTRO, CHE.DATVENCIMENTO, CHE.DATCOMPENSACAO, '+
                                  ' CHE.DATDEVOLUCAO,'+
                                  ' CON.C_NOM_CRR, CON.C_TIP_CON,  '+
                                  ' FRM.C_NOM_FRM ' +
                                  ' from CHEQUE CHE, CADCONTAS CON, CADFORMASPAGAMENTO FRM'+
                                 ' WHERE CHE.DATVENCIMENTO < '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                                 ' AND CHE.DATCOMPENSACAO IS NULL'+
                                 ' and CHE.DATDEVOLUCAO IS NULL '+
                                 ' AND CHE.CODFORMAPAGAMENTO = FRM.I_COD_FRM '+
                                 ' AND CHE.NUMCONTACAIXA = CON.C_NRO_CON ');
  if VpaCodFilial <> 0 then
    AdicionaSQLTabela(VpaTabela,'AND CON.I_EMP_FIL = '+IntToStr(VpaCodFilial));
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaContasAPagar(VpaTabela: TSQl; VpaDatInicio, VpaDatFim: TDateTime;VpaCodFilial : Integer;VpaIndMostrarProrrogado : Boolean);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(VpaTabela,'Select  MOV.C_NRO_CON, MOV.I_EMP_FIL, MOV.I_LAN_APG, MOV.I_PAR_FIL, MOV.I_COD_FRM, MOV.D_DAT_VEN, MOV.C_NRO_DUP, MOV.N_VLR_DUP, '+
                                  ' CAD.I_COD_CLI, CAD.I_NRO_NOT, CAD.D_DAT_EMI, '+
                                  ' CLI.C_NOM_CLI, CLI.C_FIN_CON, '+
                                  ' FRM.C_NOM_FRM '+
                                  ' from MOVCONTASAPAGAR MOV, CADCONTASAPAGAR CAD, CADCLIENTES CLI, CADFORMASPAGAMENTO FRM '+
                                  ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                                  ' AND MOV.I_LAN_APG = CAD.I_LAN_APG '+
                                  ' AND MOV.I_COD_FRM = FRM.I_COD_FRM '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                   SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_VEN',VpaDatInicio,VpaDatFim,true)+
                                  ' AND MOV.D_DAT_PAG IS NULL ');
  if VpaCodFilial <> 0 then
    AdicionaSQLTabela(VpaTabela,'AND MOV.I_EMP_FIL = ' +IntToStr(VpaCodFilial));
  if not VpaIndMostrarProrrogado then
    AdicionaSQLTabela(VpaTabela,'AND '+SQLTextoIsNull('MOV.C_DES_PRR','''N''')+'  = ''N''');
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaContasAReceber(VpaTabela : TSQL;VpaDatInicio,VpaDatFim : TDateTime;VpaClientesDuvidosos : Boolean;VpaCodFilial : Integer);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(VpaTabela,'Select  MOV.C_NRO_CON, MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_PAR_FIL, MOV.I_COD_FRM, MOV.D_DAT_VEN, MOV.C_NRO_DUP, MOV.N_VLR_PAR, '+
                                  ' MOV.D_DAT_PRO, MOV.I_NRO_PAR, '+
                                  ' CAD.I_COD_CLI, CAD.I_NRO_NOT, CAD.D_DAT_EMI, '+
                                  ' CLI.C_NOM_CLI, CLI.C_FIN_CON, '+
                                  ' FRM.C_NOM_FRM '+
                                  ' from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADCLIENTES CLI, CADFORMASPAGAMENTO FRM '+
                                  ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                                  ' AND MOV.I_LAN_REC = CAD.I_LAN_REC '+
                                  ' AND MOV.I_COD_FRM = FRM.I_COD_FRM '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                   SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_PRO',VpaDatInicio,VpaDatFim,true)+
                                  ' AND MOV.D_DAT_PAG IS NULL '+
                                  ' AND MOV.C_FUN_PER =  ''N'''+
                                  ' AND MOV.C_DUP_DES IS NULL '+
                                  ' AND ' +SQLTextoIsNull('MOV.C_MOS_FLU','''S''')+ ' = ''S'''+
                                  ' AND CAD.C_IND_DEV = ''N''');
  if VpaClientesDuvidosos then
    AdicionaSQLTabela(VpaTabela,'AND CLI.C_FIN_CON = ''N''')
  else
    AdicionaSQLTabela(VpaTabela,'AND CLI.C_FIN_CON = ''S''');
  if VpaCodFilial <> 0 then
    AdicionaSQLTabela(VpaTabela,'And MOV.I_EMP_FIL = ' +IntToStr(VpaCodFilial));
  VpaTabela.Open;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesFluxoCaixa
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesFluxoCaixa.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Tabela := TSQL.Create(nil);
  Tabela.ASQlConnection := VpaBaseDados;
  Aux := TSQL.Create(nil);
  Aux.ASQlConnection := VpaBaseDados;
  Conta := TSQL.Create(nil);
  Conta.ASQlConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesFluxoCaixa.destroy;
begin
  Tabela.free;
  Aux.free;
  Conta.Free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.InicializaGradeGeral(VpaGrade : TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
begin
  if VpaDFluxo.IndDiario then
    VpaGrade.Cells[ColInicial,LinInicial] := 'Fluxo Diário : '+IntToStr(VpaDFluxo.Mes)+'/'+IntToStr(VpaDFluxo.Ano)
  else
    VpaGrade.Cells[ColInicial,LinInicial] := 'Fluxo Mensal : '+ IntToStr(VpaDFluxo.Ano);
  VpaGrade.MesclarCelulas(ColInicial,ColInicial+1,LinInicial,LinInicial);
  VpaGrade.FormataCelula(ColInicial,ColInicial,LinInicial,LinInicial,TamanhoFonte+2,NomeFonte,clblue,true,false,clwhite,taCenter,vaCenter,
                bcSemBorda,clBlack);
  VpaGrade.cells[ColSaldoAnterior,LinInicial] := 'Saldo Anterior';
  VpaGrade.Cells[ColAplicacao,LinInicial] := 'Aplicação';
  VpaGrade.Cells[ColSaldoAtual,LinInicial] := 'Saldo Atual';

  VpaGrade.FormataCelula(ColAplicacao,ColSaldoAnterior,LinInicial,LinInicial,TamanhoFonte,NomeFonte,CorFonteCaixa,true,false,CorFundoCaixa,
                         taLeftJustify,vacenter,bcComBorda,clBlack);
  VpaGrade.RowHeights[LinInicial] := AlturaLinha+5;
  VpaGrade.ColWidths[ColInicial] := 10;
  VpaGrade.ColWidths[ColTituloLinha] := 200;
  VpaGrade.ColWidths[ColAplicacao] := 100;
  VpaGrade.ColWidths[ColSaldoAnterior] := 100;
  VpaGrade.ColWidths[ColSaldoAtual] := 100;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarContasFluxo(VpaDFluxo : TRBDFluxoCaixaCorpo);
begin
  FreeTObjectsList(VpaDFluxo.ContasCaixa);
  VpaDFluxo.ValAplicacao := 0;
  //adiciona uma conta vazia para as contas a receber se conta caixa associado;
  VpaDFluxo.ContaGeral:= VpaDFluxo.addContaCaixa;
  VpaDFluxo.ContaGeral.NumContaCaixa := '';
  LocalizaContas(Conta,VpaDFluxo.CodFilial);
  while not Conta.eof do
  begin
    AdicionaContaFluxo(Conta.FieldByName('C_NRO_CON').AsString,VpaDFluxo);
    Conta.next;
  end;
  Conta.close;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarDiasTotaisFluxoGrade(VpaGrade: TRBStringGridColor; VpaDFluxo: TRBDFluxoCaixaCorpo;
  VpaMes, VpaAno: Integer);
var
  VpfLacoDia : Integer;
  VpfDDia : TRBDFluxoCaixaDia;
begin
  for VpfLacoDia := 0 to VpaDFluxo.Dias.Count -1 do
  begin
    VpfDDia := TRBDFluxoCaixaDia(VpaDFluxo.Dias.Items[VpfLacoDia]);
    VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpaDFluxo.LinTotalAcumulado-1] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotal);
    VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotalAcumulado);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarSaldoAnterior(VpaDFluxo : TRBDFluxoCaixaCorpo);
begin
  if not VpaDFluxo.IndSomenteClientesQuePagamEmDia then
    CarSaldoAnteriorCR(VpaDFluxo);
  CarSaldoAnteriorCP(VpaDFluxo);
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarSaldoAnteriorCP(VpaDFluxo: TRBDFluxoCaixaCorpo);
var
  VpfDParcelaCP : TRBDParcelaCP;
  VpfDConta : TRBDFluxoCaixaConta;
begin
  VpaDFluxo.ValSaldoAnteriorCP := 0;
  LocalizaSaldoAnteriorCP(Tabela,VpaDFluxo.DatInicio,VpaDFluxo.CodFilial,VpaDFluxo.IndMostrarContasaPagarProrrogado);
  While not Tabela.eof do
  begin
    if VpaDFluxo.IndMostraContasSeparadas then
      VpfDConta := RContaFluxoCaixa(Tabela.FieldByName('C_NRO_CON').AsString,VpaDFluxo)
    else
      VpfDConta := VpaDFluxo.ContaGeral;
    VpfDParcelaCP := VpfDConta.addParcelaSaldoAnteriorCP;
    VpaDFluxo.ParcelasSaldoAnterior.Add(VpfDParcelaCP);

    VpfDParcelaCP.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfDParcelaCP.LanPagar := Tabela.FieldByName('I_LAN_APG').AsInteger;
    VpfDParcelaCP.NumParcelaParcial := Tabela.FieldByName('I_PAR_FIL').AsInteger;
    VpfDParcelaCP.CodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
    VpfDParcelaCP.CodFormaPagamento := Tabela.FieldByName('I_COD_FRM').AsInteger;
    VpfDParcelaCP.NumNotaFiscal := Tabela.FieldByName('I_NRO_NOT').AsInteger;
    VpfDParcelaCP.NumDiasAtraso := DiasPorPeriodo(Tabela.FieldByName('D_DAT_VEN').AsDateTime,Date);
    VpfDParcelaCP.NumContaCorrente := Tabela.FieldByName('C_NRO_CON').AsString;
    VpfDParcelaCP.NomCliente := Tabela.FieldByName('C_NOM_CLI').AsString;
    VpfDParcelaCP.NumDuplicata := Tabela.FieldByName('C_NRO_DUP').AsString;
    VpfDParcelaCP.DatVencimento := Tabela.FieldByName('D_DAT_VEN').AsDateTime;
    VpfDParcelaCP.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
    VpfDParcelaCP.ValParcela := Tabela.FieldByName('N_VLR_DUP').AsFloat;

    VpfDConta.ValSaldoAnteriorCP := VpfDConta.ValSaldoAnteriorCP + VpfDParcelaCP.ValParcela;
    VpaDFluxo.ValSaldoAnteriorCP := VpaDFluxo.ValSaldoAnteriorCP + VpfDParcelaCP.ValParcela;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarSaldoAnteriorCR(VpaDFluxo: TRBDFluxoCaixaCorpo);
var
  VpfDParcelaCR : TRBDParcelaBaixaCR;
  VpfDConta : TRBDFluxoCaixaConta;
begin
  VpaDFluxo.ValSaldoAnteriorCR := 0;
  LocalizaSaldoAnteriorCR(Tabela,VpaDFluxo.DatInicio,VpaDFluxo.CodFilial);
  While not Tabela.eof do
  begin
    if Tabela.FieldByName('C_MOS_FLU').AsString <> 'N' then
    begin
      if VpaDFluxo.IndMostraContasSeparadas then
        VpfDConta := RContaFluxoCaixa(Tabela.FieldByName('C_NRO_CON').AsString,VpaDFluxo)
      else
        VpfDConta := VpaDFluxo.ContaGeral;

      VpfDParcelaCR := VpfDConta.addParcelaSaldoAnteriorCR;
      VpaDFluxo.ParcelasSaldoAnterior.Add(VpfDParcelaCR);

      VpfDParcelaCR.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
      VpfDParcelaCR.LanReceber := Tabela.FieldByName('I_LAN_REC').AsInteger;
      VpfDParcelaCR.NumParcela := Tabela.FieldByName('I_NRO_PAR').AsInteger;
      VpfDParcelaCR.NumParcelaParcial := Tabela.FieldByName('I_PAR_FIL').AsInteger;
      VpfDParcelaCR.CodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
      VpfDParcelaCR.CodFormaPagamento := Tabela.FieldByName('I_COD_FRM').AsInteger;
      VpfDParcelaCR.NumNotaFiscal := Tabela.FieldByName('I_NRO_NOT').AsInteger;
      VpfDParcelaCR.NumDiasAtraso := DiasPorPeriodo(Tabela.FieldByName('D_DAT_VEN').AsDateTime,Date);
      VpfDParcelaCR.NumContaCorrente := Tabela.FieldByName('C_NRO_CON').AsString;
      VpfDParcelaCR.NomCliente := Tabela.FieldByName('C_NOM_CLI').AsString;
      VpfDParcelaCR.NumDuplicata := Tabela.FieldByName('C_NRO_DUP').AsString;
      VpfDParcelaCR.DatVencimento := Tabela.FieldByName('D_DAT_VEN').AsDateTime;
      VpfDParcelaCR.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
      VpfDParcelaCR.DatPromessaPagamento := Tabela.FieldByName('D_DAT_PRO').AsDateTime;
      VpfDParcelaCR.ValParcela := Tabela.FieldByName('N_VLR_PAR').AsFloat;

      VpfDConta.ValSaldoAnteriorCR := VpfDConta.ValSaldoAnteriorCR + VpfDParcelaCR.ValParcela;
      VpaDFluxo.ValSaldoAnteriorCR := VpaDFluxo.ValSaldoAnteriorCR + VpfDParcelaCR.ValParcela;
    end;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
function TRBFuncoesFluxoCaixa.AdicionaContaFluxo(VpaNumConta: String; VpaDFluxo: TRBDFluxoCaixaCorpo) : TRBDFluxoCaixaConta;
begin
  AdicionaSQLAbreTabela(Aux,'Select CON.C_NRO_CON, C_NOM_CRR, CON.N_LIM_CRE, CON.N_SAL_ATU, '+
                                  '       CON.N_VAL_APL, '+
                                  '       BAN.C_NOM_BAN '+
                                  ' from CADCONTAS CON, CADBANCOS BAN '+
                                  ' Where CON.C_NRO_CON = '''+VpaNumConta+''''+
                                  ' and CON.I_COD_BAN = BAN.I_COD_BAN '+
                                  ' order by C_NRO_CON ');
  if VpaDFluxo.IndMostraContasSeparadas then
  begin
    Result := VpaDFluxo.addContaCaixa;
    Result.NumContaCaixa := Aux.FieldByName('C_NRO_CON').AsString;
    Result.NomContaCaixa := Aux.FieldByName('C_NOM_BAN').AsString+'/'+Aux.FieldByName('C_NOM_CRR').AsString;
  end
  else
    result := VpaDFluxo.ContaGeral;
  Result.ValSaldoAtual := Result.ValSaldoAtual + Aux.FieldByName('N_SAL_ATU').AsFloat;
  Result.ValAplicado := Result.ValAplicado + Aux.FieldByName('N_VAL_APL').AsFloat;
  Result.ValLimiteCredito := Result.ValLimiteCredito + Aux.FieldByName('N_LIM_CRE').AsFloat;
  VpaDFluxo.ValAplicacao :=  VpaDFluxo.ValAplicacao + Aux.FieldByName('N_VAL_APL').AsFloat;
  VpaDFluxo.ValSaldoAtual :=  VpaDFluxo.ValSaldoAtual + Aux.FieldByName('N_SAL_ATU').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarCheques(VpaDFluxo: TRBDFluxoCaixaCorpo;VpaIndSaldoAnterior : Boolean);
var
  VpfDCheque : TRBDCheque;
  VpfDConta : TRBDFluxoCaixaConta;
begin
  VpaDFluxo.ValChequeCRSaldoAnterior := 0;
  VpaDFluxo.ValChequeCPSaldoAnterior := 0;
  if VpaIndSaldoAnterior then
    LocalizaChequeSaldoAnterior(Tabela,VpaDFluxo.DatInicio,VpaDFluxo.CodFilial)
  else
    LocalizaCheques(Tabela,VpaDFluxo.DatInicio,VpaDFluxo.DatFim,VpaDFluxo.CodFilial);
  While not Tabela.eof do
  begin
    if VpaDFluxo.IndMostraContasSeparadas then
      VpfDConta := RContaFluxoCaixa(Tabela.FieldByName('NUMCONTACAIXA').AsString,VpaDFluxo)
    else
      VpfDConta := VpaDFluxo.ContaGeral;

    if VpaIndSaldoAnterior then
    begin
      if Tabela.FieldByName('TIPCHEQUE').AsString = 'C' then
        VpfDCheque := VpfDConta.AddChequeCRSaldoAnterior
      else
        VpfDCheque := VpfDConta.AddChequeCPSaldoAnterior;
    end
    else
    begin
      if Tabela.FieldByName('TIPCHEQUE').AsString = 'C' then
        VpfDCheque := VpfDConta.addChequeCR(Tabela.FieldByName('DATVENCIMENTO').AsDateTime)
      else
        VpfDCheque := VpfDConta.AddChequeCP(Tabela.FieldByName('DATVENCIMENTO').AsDateTime);
    end;

    VpfDCheque.SeqCheque := Tabela.FieldByName('SEQCHEQUE').AsInteger;
    VpfDCheque.CodBanco := Tabela.FieldByName('CODBANCO').AsInteger;
    VpfDCheque.CodFormaPagamento := Tabela.FieldByName('CODFORMAPAGAMENTO').AsInteger;
    VpfDCheque.NumCheque := Tabela.FieldByName('NUMCHEQUE').AsInteger;
    VpfDCheque.CodUsuario := Tabela.FieldByName('CODUSUARIO').AsInteger;
    VpfDCheque.NumContaCaixa := Tabela.FieldByName('NUMCONTACAIXA').AsString;
    VpfDCheque.NomContaCaixa := Tabela.FieldByName('C_NOM_CRR').AsString;
    VpfDCheque.NomEmitente := Tabela.FieldByName('NOMEMITENTE').AsString;
    VpfDCheque.NomFormaPagamento := Tabela.FieldByName('C_NOM_FRM').AsString;
    VpfDCheque.TipCheque := Tabela.FieldByName('TIPCHEQUE').AsString;
    VpfDCheque.TipContaCaixa := Tabela.FieldByName('C_TIP_CON').AsString;
    VpfDCheque.ValCheque := Tabela.FieldByName('VALCHEQUE').AsFloat;
    VpfDCheque.DatCadastro := Tabela.FieldByName('DATCADASTRO').AsDateTime;
    VpfDCheque.DatVencimento := Tabela.FieldByName('DATVENCIMENTO').AsDateTime;
    VpfDCheque.DatCompensacao := Tabela.FieldByName('DATCOMPENSACAO').AsDateTime;
    VpfDCheque.DatDevolucao := Tabela.FieldByName('DATDEVOLUCAO').AsDateTime;

    if VpaIndSaldoAnterior then
    begin
      if Tabela.FieldByName('TIPCHEQUE').AsString = 'C' then
      begin
        VpfDConta.ValChequeCRSaldoAnterior := VpfDConta.ValChequeCRSaldoAnterior + VpfDCheque.ValCheque;
        VpaDFluxo.ValChequeCRSaldoAnterior := VpaDFluxo.ValChequeCRSaldoAnterior + VpfDCheque.ValCheque;
      end
      else
      begin
        VpfDConta.ValChequeCPSaldoAnterior := VpfDConta.ValChequeCPSaldoAnterior + VpfDCheque.ValCheque;
        VpaDFluxo.ValChequeCPSaldoAnterior := VpaDFluxo.ValChequeCPSaldoAnterior + VpfDCheque.ValCheque;
      end;
    end;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarContasAPagar(VpaDFluxo: TRBDFluxoCaixaCorpo);
Var
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDParcelaCP : TRBDParcelaCP;
begin
  LocalizaContasAPagar(Tabela,VpaDFluxo.DatInicio,VpaDFluxo.DatFim,VpaDFluxo.CodFilial,VpaDFluxo.IndMostrarContasaPagarProrrogado);
  while not Tabela.eof do
  begin
    if VpaDFluxo.IndMostraContasSeparadas then
      VpfDConta := RContaFluxoCaixa(Tabela.FieldByName('C_NRO_CON').AsString,VpaDFluxo)
    else
      VpfDConta := VpaDFluxo.ContaGeral;
    VpfDParcelaCP := VpfDConta.AddParcelaCP(Tabela.FieldByName('D_DAT_VEN').AsDateTime);

    VpfDParcelaCP.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfDParcelaCP.LanPagar := Tabela.FieldByName('I_LAN_APG').AsInteger;
    VpfDParcelaCP.NumParcelaParcial := Tabela.FieldByName('I_PAR_FIL').AsInteger;
    VpfDParcelaCP.CodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
    VpfDParcelaCP.CodFormaPagamento := Tabela.FieldByName('I_COD_FRM').AsInteger;
    VpfDParcelaCP.NumNotaFiscal := Tabela.FieldByName('I_NRO_NOT').AsInteger;
    VpfDParcelaCP.NumDiasAtraso := DiasPorPeriodo(Tabela.FieldByName('D_DAT_VEN').AsDateTime,Date);
    VpfDParcelaCP.NumContaCorrente := Tabela.FieldByName('C_NRO_CON').AsString;
    VpfDParcelaCP.NomCliente := Tabela.FieldByName('C_NOM_CLI').AsString;
    VpfDParcelaCP.NumDuplicata := Tabela.FieldByName('C_NRO_DUP').AsString;
    VpfDParcelaCP.DatVencimento := Tabela.FieldByName('D_DAT_VEN').AsDateTime;
    VpfDParcelaCP.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
    VpfDParcelaCP.ValParcela := Tabela.FieldByName('N_VLR_DUP').AsFloat;
    VpfDParcelaCP.NomFormaPagamento := Tabela.FieldByName('C_NOM_FRM').AsString;

    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarContasaReceber(VpaDFluxo : TRBDFluxoCaixaCorpo;VpaClientesDuvidosos : Boolean);
Var
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDParcelaCR : TRBDParcelaBaixaCR;
begin
  LocalizaContasAReceber(Tabela,VpaDFluxo.DatInicio,VpaDFluxo.DatFim,VpaClientesDuvidosos,VpaDFluxo.CodFilial);
  while not Tabela.eof do
  begin
    if VpaDFluxo.IndMostraContasSeparadas then
      VpfDConta := RContaFluxoCaixa(Tabela.FieldByName('C_NRO_CON').AsString,VpaDFluxo)
    else
      VpfDConta := VpaDFluxo.ContaGeral;
    if VpaClientesDuvidosos then
      VpfDParcelaCR := VpfDConta.AddParcelaDuvidosa(Tabela.FieldByName('D_DAT_PRO').AsDateTime)
    else
      VpfDParcelaCR := VpfDConta.addParcelaCR(Tabela.FieldByName('D_DAT_PRO').AsDateTime);

    VpfDParcelaCR.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfDParcelaCR.LanReceber := Tabela.FieldByName('I_LAN_REC').AsInteger;
    VpfDParcelaCR.NumParcela := Tabela.FieldByName('I_NRO_PAR').AsInteger;
    VpfDParcelaCR.NumParcelaParcial := Tabela.FieldByName('I_PAR_FIL').AsInteger;
    VpfDParcelaCR.CodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
    VpfDParcelaCR.CodFormaPagamento := Tabela.FieldByName('I_COD_FRM').AsInteger;
    VpfDParcelaCR.NumNotaFiscal := Tabela.FieldByName('I_NRO_NOT').AsInteger;
    VpfDParcelaCR.NumDiasAtraso := DiasPorPeriodo(Tabela.FieldByName('D_DAT_VEN').AsDateTime,Date);
    VpfDParcelaCR.NumContaCorrente := Tabela.FieldByName('C_NRO_CON').AsString;
    VpfDParcelaCR.NomCliente := Tabela.FieldByName('C_NOM_CLI').AsString;
    VpfDParcelaCR.NumDuplicata := Tabela.FieldByName('C_NRO_DUP').AsString;
    VpfDParcelaCR.DatVencimento := Tabela.FieldByName('D_DAT_VEN').AsDateTime;
    VpfDParcelaCR.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
    VpfDParcelaCR.DatPromessaPagamento := Tabela.FieldByName('D_DAT_PRO').AsDateTime;
    VpfDParcelaCR.ValParcela := Tabela.FieldByName('N_VLR_PAR').AsFloat;
    VpfDParcelaCR.NomFormaPagamento := Tabela.FieldByName('C_NOM_FRM').AsString;

    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarMesContasaReceberGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo;VpaMes,VpaAno : Integer);
var
  VpfLacoContas, VpfLacoMes, VpfLacoDia : Integer;
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDMes : TRBDFluxoCaixaMes;
  VpfDDia : TRBDFluxoCaixaDia;
begin
  for VpfLacoContas := 0 to VpaDFluxo.ContasCaixa.Count -1 do
  begin
    VpfDConta := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLacoContas]);
//VERIFICAR VALORES
//    VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinReceitasAcumuladas-1] := FormatFloat('#,###,###,##0.00',VpfDConta.ValTotalReceitas+VpfDConta.ValSaldoAnteriorCR);
    VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinReceitasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDConta.ValTotalReceitasAcumuladas);
    VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinDespesasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDConta.ValTotalDespesasAcumuladas);
    for VpfLacoMes := 0 to VpfDConta.Meses.Count - 1 do
    begin
      if (TRBDFluxoCaixaMes(VpfDConta.Meses.Items[VpfLacoMes]).Mes = VpaMes) and
         (TRBDFluxoCaixaMes(VpfDConta.Meses.Items[VpfLacoMes]).Ano = VpaAno) then
      begin
        VpfDMes := TRBDFluxoCaixaMes(VpfDConta.Meses.Items[VpfLacoMes]);
        for VpfLacoDia := 0 to VpfDMes.Dias.Count - 1 do
        begin
          VpfDDia := TRBDFluxoCaixaDia(VpfDMes.Dias.Items[VpfLacoDia]);
          //CONTAS A RECEBER
          if VpfDDia.ValCRPrevisto <> 0 then
            VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinContasReceberPrevisto] := FormatFloat('#,###,###,##0.00',VpfDDia.ValCRPrevisto)
          else
            VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinContasReceberPrevisto] := '';
          if VpfDDia.ValCRDuvidoso <> 0 then
            VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinContasReceberDuvidoso] := FormatFloat('#,###,###,##0.00',VpfDDia.ValCRDuvidoso)
          else
            VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinContasReceberDuvidoso] := '';
          if VpfDDia.ValChequesCR <> 0 then
            VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinChequesaCompensarCR] := FormatFloat('#,###,###,##0.00',VpfDDia.ValChequesCR)
          else
            VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinChequesaCompensarCR] := '';

          VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinReceitasAcumuladas-1] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotalReceita);
          VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinReceitasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotalReceitaAcumulada);
          //CONTAS A PAGAR;
          if VpfDDia.ValCP <> 0 then
            VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinContasAPagar] := FormatFloat('#,###,###,##0.00',VpfDDia.ValCP)
          else
            VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinContasAPagar] := '';
          if VpfDDia.ValChequesCP <> 0 then
            VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinChequesaCompensarCP] := FormatFloat('#,###,###,##0.00',VpfDDia.ValChequesCP)
          else
            VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinChequesaCompensarCP] := '';
          VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinDespesasAcumuladas-1] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotalDespesa);
          VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinDespesasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotalDespesaAcumulada);
          //CONTA
          VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinTotalConta] := FormatFloat('#,###,###,##0.00',VpfDDia.Valtotal);
          VpaGrade.cells[ColSaldoAnterior+VpfDDia.Dia,VpfDConta.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotalAcumulado);
        end;
        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinContasReceberPrevisto] := FormatFloat('#,###,###,##0.00',VpfDMes.ValCRPrevisto);
        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinContasReceberDuvidoso] := FormatFloat('#,###,###,##0.00',VpfDMes.ValCRDuvidoso);
        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinChequesaCompensarCR] := FormatFloat('#,###,###,##0.00',VpfDMes.ValChequesCR);
        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinReceitasAcumuladas-1] := FormatFloat('#,###,###,##0.00',VpfDMes.ValTotalReceita);

        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinContasAPagar] := FormatFloat('#,###,###,##0.00',VpfDMes.ValCP);
        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinChequesaCompensarCP] := FormatFloat('#,###,###,##0.00',VpfDMes.ValChequesCP);

        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinTotalConta] := FormatFloat('#,###,###,##0.00',VpfDMes.Valtotal);
        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpfDMes.ValTotalAcumulado);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarValorAplicacaoGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
var
  VpfLaco : Integer;
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDFormatacaoCelula : TRBFormatacaoCelula;
begin
  for VpfLaco := 0 to VpaDFluxo.ContasCaixa.Count -1 do
  begin
    VpfDConta := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLaco]);
    //contas a receber
    if VpfDConta.ValSaldoAnteriorCR <> 0 then
      VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinContasReceberPrevisto] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnteriorCR)
    else
      VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinContasReceberPrevisto] := '';

    if VpfDConta.ValChequeCRSaldoAnterior <> 0 then
      VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinChequesaCompensarCR] := FormatFloat('#,###,###,##0.00',VpfDConta.ValChequeCRSaldoAnterior)
    else
      VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinChequesaCompensarCR] := '';

    VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinReceitasAcumuladas-1] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnteriorCR+VpfDConta.ValChequeCRSaldoAnterior);
    VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinReceitasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnteriorCR+VpfDConta.ValChequeCRSaldoAnterior);

    //contas a pagar
    if VpfDConta.ValSaldoAnteriorCP <> 0 then
      VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinContasAPagar] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnteriorCP)
    else
      VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinContasAPagar] := '';

    if VpfDConta.ValChequeCPSaldoAnterior <> 0 then
      VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinChequesaCompensarCP] := FormatFloat('#,###,###,##0.00',VpfDConta.ValChequeCPSaldoAnterior)
    else
      VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinChequesaCompensarCP] := '';

    VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinDespesasAcumuladas-1] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnteriorCP+VpfDConta.ValChequeCPSaldoAnterior);
    VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinDespesasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnteriorCP+VpfDConta.ValChequeCPSaldoAnterior);

    VpaGrade.Cells[ColAplicacao,VpfDConta.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpfDConta.ValAplicado);
    //saldo atual
    VpaGrade.cells[ColSaldoAtual,VpfDConta.LinTotalConta] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAtual);
    VpfDFormatacaoCelula := VpaGrade.FormatacaoCelula[ColSaldoAtual,VpfDConta.LinTotalConta,true];
    if VpfDConta.ValSaldoAtual < 0 then
      VpfDFormatacaoCelula.CorFonte := clred
    else
      VpfDFormatacaoCelula.CorFonte := clWhite;
    VpaGrade.cells[ColSaldoAtual,VpfDConta.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpfDConta.ValAplicado+VpfDConta.ValSaldoAtual);

    //saldo anterior
    VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinTotalAcumulado-1] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnteriorCR+VpfDConta.ValChequeCRSaldoAnterior-VpfDConta.ValSaldoAnteriorCP-VpfDConta.ValChequeCPSaldoAnterior);
    VpfDFormatacaoCelula := VpaGrade.FormatacaoCelula[ColSaldoAnterior,VpfDConta.LinTotalAcumulado-1,true];

    VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnteriorCR+VpfDConta.ValAplicado+VpfDConta.ValSaldoAtual+VpfDConta.ValChequeCRSaldoAnterior-VpfDConta.ValSaldoAnteriorCP-VpfDConta.ValChequeCPSaldoAnterior);
  end;

  if VpaDFluxo.ValAplicacao <> 0 then
    VpaGrade.cells[ColAplicacao,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValAplicacao)
  else
    VpaGrade.cells[ColAplicacao,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',0);

  VpaGrade.cells[ColSaldoAtual,VpaDFluxo.LinTotalAcumulado-1] := FormatFloat('#,###,###,##0.00',VpaDFluxo.valSaldoAtual);
  VpaGrade.cells[ColSaldoAtual,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValAplicacao+VpaDFluxo.valSaldoAtual);
  VpaGrade.cells[ColSaldoAnterior,VpaDFluxo.LinTotalAcumulado-1] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValSaldoAnteriorCR -VpaDFluxo.ValSaldoAnteriorCP);
  VpaGrade.cells[ColSaldoAnterior,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValAplicacao+VpaDFluxo.ValSaldoAnteriorCR+VpaDFluxo.valSaldoAtual- VpaDFluxo.ValSaldoAnteriorCP);
  VpaGrade.cells[VpaDFluxo.QtdColunas,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValTotalAcumulado);
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarContaCaixaGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
Var
  vpfLinha : Integer;
  VpfLaco : integer;
  VpfDConta : TRBDFluxoCaixaConta;
begin
  for VpfLaco := 0 to VpaDFluxo.ContasCaixa.Count -1 do
  begin
    VpaGrade.RowCount := VpaGrade.RowCount + 19;
    VpfDConta := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLaco]);
    vpfLinha := LinPrimeiraContaCaixa +1 +(VpfLaco*19);
    VpaGrade.cells[ColInicial+1,vpfLinha] := VpfDConta.NumContaCaixa+ '-'+VpfDConta.NomContaCaixa;
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha+1;
    VpaGrade.FormataCelula(ColInicial,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clblue,taLeftJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.MesclarCelulas(ColInicial+1,ColInicial+5,vpfLinha,vpfLinha);

   VpaGrade.FormataCelula(ColInicial,VpaDFluxo.QtdColunas,VpfLinha - 1,VpfLinha - 1,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clWhite,taLeftJustify,vaCenter,bcComBorda,clBlack);
    //formata a cor da primeira coluna em azul
    VpaGrade.FormataCelula(ColInicial,ColInicial,VpfLinha,VpfLinha+16,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clblue,taLeftJustify,vaCenter,bcSemBorda,clBlack);
    VpaGrade.ColWidths[colInicial] := 10;

    //Titulo Contas a receber;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+2,NomeFonte,CorFonteTituloCR, true,
                 false,CorFundoTituloCR,taLeftJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Entradas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha+2;

    //Contas a receber Previsto;
    inc(vpflinha);
    VpfDConta.LinContasReceberPrevisto := VpfLinha;
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false,  CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.Cells[ColInicial+1,vpfLinha] := 'Entrada Previsto';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, CorFonteCR,false,
                false,CorFundoCR,taRightJustify,vaCenter,bcComBorda,clBlack);

    //Contas a receber Duvidoso;
    inc(vpflinha);
    VpfDConta.LinContasReceberDuvidoso := VpfLinha;
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false, CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Entrada Duvidosa';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false, CorFundoCR,taRightJustify,vaCenter,bcComBorda,clBlack);


    //Contas a Cheques a compensar;
    inc(vpflinha);
    VpfDConta.LinChequesaCompensarCR := VpfLinha;
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                 false,CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := '(+) Cheques a Compensar';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false,CorFundoCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    inc(Vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clWhite,taLeftJustify,vaCenter,bcComBorda,clBlack);
    //Total Receitas;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false, CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Total Entradas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;

    //Receitas Acumuladas;
    inc(vpflinha);
    VpfDConta.LinReceitasAcumuladas := VpfLinha;
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, CorFonteCR,false,
                false,CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Entradas Acumuladas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;

    //coloca a coluna do total em cinza
    VpaGrade.FormataCelula(VpaDFluxo.QtdColunas,VpaDFluxo.QtdColunas,VpfDConta.LinContasReceberPrevisto,VpfDConta.LinChequesaCompensarCR,TamanhoFonte,NomeFonte, CorFonteCaixa,false,
                false,CorFundoCaixa,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.FormataCelula(VpaDFluxo.QtdColunas,VpaDFluxo.QtdColunas,VpfDConta.LinReceitasAcumuladas-1,VpfLinha,TamanhoFonte,NomeFonte, CorFonteCaixa,false,
                false,CorFundoCaixa,taRightJustify,vaCenter,bcComBorda,clBlack);

    inc(Vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clWhite,taLeftJustify,vaCenter,bcComBorda,clBlack);
    //Titulo Contas a Pagar
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+2,NomeFonte,CorFonteTituloCP,true,
                false,CorFundoTituloCP, taLeftJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Saidas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    //Contas a pagar;
    inc(vpflinha);
    VpfDConta.LinContasAPagar := vpfLinha;
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, CorFonteCP,false,
                false,CorFundoTituloCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Saidas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false,CorFundoCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    //Cheques a compensar;
    inc(vpflinha);
    VpfDConta.LinChequesaCompensarCP := vpfLinha;
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false, CorFundoTituloCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.Cells[ColInicial+1,vpfLinha] := 'Cheques a compensar';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, CorFonteCP,false,
                false,CorFundoCP,taRightJustify,vaCenter,bcComBorda,clBlack);

    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clWhite,taLeftJustify,vaCenter,bcComBorda,clBlack);
    //Contas a pagar;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false,CorFundoTituloCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Total Saidas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;

    //Contas a pagar;
    inc(vpflinha);
    VpfDConta.LinDespesasAcumuladas := vpfLinha;
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false,CorFundoTituloCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.Cells[ColInicial+1,vpfLinha] := 'Saidas Acumuladas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;

    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clWhite,taLeftJustify,vaCenter,bcComBorda,clBlack);
    //Totais
    inc(vpflinha);
    VpfDConta.LinTotalConta := vpfLinha;
    VpaGrade.FormataCelula(ColInicial,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,clwhite,false,
                false, clblue,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.Cells[ColInicial+1,vpfLinha] := 'Total Conta ' + VpfDConta.NumContaCaixa+ ' :';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;

    inc(vpflinha);
    VpfDConta.LinTotalAcumulado := vpfLinha;
    VpaGrade.FormataCelula(ColInicial,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, clwhite,false,
                false,clblue,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Total Acumulado Conta ' +VpfDConta.NumContaCaixa+ ' :';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
  end;

  inc(vpflinha);
  //Total dia
  inc(vpflinha);
  VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, clBlack,true,
              false,clGray,taRightJustify,vaCenter,bcComBorda,clBlack);
  VpaGrade.cells[ColInicial+1,vpfLinha] := 'Total : ';
  VpaGrade.RowHeights[vpfLinha] := AlturaLinha+2;

  //Total Acumulado
  inc(vpflinha);
  VpaDFluxo.LinTotalAcumulado := VpfLinha;
  VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, clBlack,true,
              false,clGray,taRightJustify,vaCenter,bcComBorda,clBlack);
  VpaGrade.Cells[ColInicial+1,vpfLinha] := 'Total Acumulado : ';
  VpaGrade.RowHeights[vpfLinha] := AlturaLinha+2;
  VpaGrade.RowCount := vpfLinha+1;
end;

{******************************************************************************}
function TRBFuncoesFluxoCaixa.RContaCaixa(VpaLinha, VpaColuna: Integer;VpaDFluxo: TRBDFluxoCaixaCorpo): TRBDFluxoCaixaConta;
var
  VpfLacoContas : Integer;
  VpfDContaFluxo : TRBDFluxoCaixaConta;
  VpfDMesFluxo : TRBDFluxoCaixaMes;
begin
  result := nil;
  for VpfLacoContas := 0 to VpaDFluxo.ContasCaixa.Count - 1 do
  begin
    VpfDContaFluxo := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLacoContas]);
    if (VpaLinha >= VpfDContaFluxo.LinContasReceberPrevisto) and
       (VpaLinha < VpfDContaFluxo.LinTotalAcumulado)  then
    begin
      result := VpfDContaFluxo;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.RContaCaixaDia(VpanumConta :string; VpaFluxoDia : TRBDFluxoCaixaDia;VpaDFluxoMes : TRBDFluxoCaixaMes; VpaDFluxo : TRBDFluxoCaixaCorpo);
begin

end;

{******************************************************************************}
function TRBFuncoesFluxoCaixa.RContaFluxoCaixa(VpaNumConta : string; VpaDFluxo : TRBDFluxoCaixaCorpo):TRBDFluxoCaixaConta;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to  VpaDFluxo.ContasCaixa.Count - 1 do
  begin
    if  TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLaco]).NumContaCaixa = VpaNumConta then
    begin
      Result := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLaco]);
      break;
    end;
  end;
  if result = nil then
    result := AdicionaContaFluxo(VpaNumConta,VpaDFluxo);
end;


{******************************************************************************}
function TRBFuncoesFluxoCaixa.RDia(VpaLinha, VpaColuna: Integer;VpaDFluxo: TRBDFluxoCaixaCorpo): TRBDFluxoCaixaDia;
var
  VpfLacoContas : Integer;
  VpfDContaFluxo : TRBDFluxoCaixaConta;
  VpfDMesFluxo : TRBDFluxoCaixaMes;
begin
  result := nil;
  if (VpaColuna > ColSaldoAnterior) and
     (VpaColuna < VpaDFluxo.QtdColunas) then
  begin
    for VpfLacoContas := 0 to VpaDFluxo.ContasCaixa.Count - 1 do
    begin
      VpfDContaFluxo := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLacoContas]);
      if (VpaLinha >= VpfDContaFluxo.LinContasReceberPrevisto) and
         (VpaLinha < VpfDContaFluxo.LinTotalAcumulado)  then
      begin
        result := VpfDContaFluxo.RDia(MontaData(VpaColuna - ColSaldoAnterior,VpaDFluxo.Mes,VpaDFluxo.Ano));
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarregaCores(VpaCorFonteCaixa, VpaCorFundoCaixa, VpaCorFonteNegativo, VpaCorFonteTituloCR, VpaCorFonteCR, VpaCorFundoTituloCR, VpaCorFundoCR, VpaCorFonteCP, VpaCorFundoCP,VpaCorFonteTituloCP, VpaCorFundoTituloCP: TColor; VpaNomFonte : string; VpaTamFonte,VpaAltLinha : Integer);
begin
  CorFonteCaixa := VpaCorFonteCaixa;
  CorFundoCaixa := VpaCorFundoCaixa;
  CorFonteNegativo := VpaCorFonteNegativo;
  CorFonteTituloCR := VpaCorFonteTituloCR;
  CorFonteCR := VpaCorFonteCR;
  CorFundoTituloCR := VpaCorFundoTituloCR;
  CorFundoCR := VpaCorFundoCR;
  CorFonteCP := VpaCorFonteCP;
  CorFundoCP := VpaCorFundoCP;
  CorFonteTituloCP := VpaCorFonteTituloCP;
  CorFundoTituloCP := VpaCorFundoTituloCP;

  TamanhoFonte :=  VpaTamFonte;
  NomeFonte := VpaNomFonte;

  AlturaLinha := VpaAltLinha;
end;


{******************************************************************************}
function TRBFuncoesFluxoCaixa.LinhaChequeCP(VpaLinha: Integer;VpaDFluxo: TRBDFluxoCaixaCorpo): Boolean;
var
  VpfLacoContas : Integer;
  VpfDContaFluxo : TRBDFluxoCaixaConta;
begin
  result := false;
  for VpfLacoContas := 0 to VpaDFluxo.ContasCaixa.Count - 1 do
  begin
    VpfDContaFluxo := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLacoContas]);
    if VpfDContaFluxo.LinChequesaCompensarCP = VpaLinha then
    begin
      Result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesFluxoCaixa.LinhaChequeCR(VpaLinha: Integer;VpaDFluxo: TRBDFluxoCaixaCorpo): Boolean;
var
  VpfLacoContas : Integer;
  VpfDContaFluxo : TRBDFluxoCaixaConta;
begin
  result := false;
  for VpfLacoContas := 0 to VpaDFluxo.ContasCaixa.Count - 1 do
  begin
    VpfDContaFluxo := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLacoContas]);
    if VpfDContaFluxo.LinChequesaCompensarCR = VpaLinha then
    begin
      Result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesFluxoCaixa.LinhaParcelasContasaPagar(VpaLinha: Integer; VpaDFluxo: TRBDFluxoCaixaCorpo): Boolean;
var
  VpfLacoContas : Integer;
  VpfDContaFluxo : TRBDFluxoCaixaConta;
begin
  result := false;
  for VpfLacoContas := 0 to VpaDFluxo.ContasCaixa.Count - 1 do
  begin
    VpfDContaFluxo := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLacoContas]);
    if VpfDContaFluxo.LinContasAPagar = VpaLinha then
    begin
      Result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesFluxoCaixa.LinhaParcelasContasAReceber(VpaLinha: Integer;VpaDFluxo: TRBDFluxoCaixaCorpo): Boolean;
var
  VpfLacoContas : Integer;
  VpfDContaFluxo : TRBDFluxoCaixaConta;
begin
  result := false;
  for VpfLacoContas := 0 to VpaDFluxo.ContasCaixa.Count - 1 do
  begin
    VpfDContaFluxo := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLacoContas]);
    if VpfDContaFluxo.LinContasReceberPrevisto = VpaLinha then
    begin
      Result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesFluxoCaixa.LinhaParcelasContasAReceberDuvidoso(VpaLinha: Integer;VpaDFluxo: TRBDFluxoCaixaCorpo): Boolean;
var
  VpfLacoContas : Integer;
  VpfDContaFluxo : TRBDFluxoCaixaConta;
begin
  result := false;
  for VpfLacoContas := 0 to VpaDFluxo.ContasCaixa.Count - 1 do
  begin
    VpfDContaFluxo := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLacoContas]);
    if VpfDContaFluxo.LinContasReceberDuvidoso = VpaLinha then
    begin
      Result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.InicializaFluxoDiario(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
var
  VpfLaco : Integer;
begin
  LimpaGradeCompleta(VpaGrade);
  TamanhoGrade := 50;
  VpaGrade.ColCount := TamanhoGrade;
  InicializaGradeGeral(VpaGrade,VpaDFluxo);
  if VpaDFluxo.IndDiario then
    VpaDFluxo.QtdColunas := Dia(UltimoDiaMes(MontaData(1,VpaDFluxo.Mes,VpaDFluxo.Ano)))
  else
    VpaDFluxo.QtdColunas := 12;
  VpaGrade.ColCount := VpaDFluxo.QtdColunas + ColSaldoAnterior+2;

  VpaGrade.ColWidths[ColInicial] := 10;
  for VpfLaco := 1 to VpaDFluxo.QtdColunas do
  begin
    VpaGrade.cells[ColSaldoAnterior+VpfLaco,LinInicial] := IntToStr(VpfLaco);
    if DiaSemanaNumerico(MontaData(VpfLaco,VpaDFluxo.Mes,VpaDFluxo.Ano)) in [1,7] then
      VpaGrade.FormataCelula(ColSaldoAnterior+VpfLaco,ColSaldoAnterior+VpfLaco,LinInicial,LinInicial,TamanhoFonte,NomeFonte,clRed,true,
                false,CorFundoCaixa,taRightJustify,vacenter,bcComBorda,clBlack)
    else
      VpaGrade.FormataCelula(ColSaldoAnterior+VpfLaco,ColSaldoAnterior+VpfLaco,LinInicial,LinInicial,TamanhoFonte,NomeFonte,CorFonteCaixa,true,
                false,CorFundoCaixa,taRightJustify,vacenter,bcComBorda,clBlack);
  end;
  VpaGrade.cells[ColSaldoAnterior+VpaDFluxo.QtdColunas+1,LinInicial] := 'Total';
  VpaGrade.FormataCelula(ColSaldoAnterior+VpaDFluxo.QtdColunas+1,ColSaldoAnterior+VpaDFluxo.QtdColunas+1,LinInicial,LinInicial,TamanhoFonte,NomeFonte,CorFonteCaixa,true,
                false,CorFundoCaixa,taRightJustify,vaCenter,bcComBorda,clBlack);
  VpaGrade.ColWidths[VpaDFluxo.QtdColunas+ColSaldoAnterior+1] := 120;

  VpaDFluxo.QtdColunas := VpaDFluxo.QtdColunas+ColSaldoAnterior+1;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarFluxoCaixa(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
begin
  VpaDFluxo.ValSaldoAtual := 0;
  CarContasFluxo(VpaDFluxo);
  CarSaldoAnterior(VpaDFluxo);
  CarCheques(VpaDFluxo,True);
  CarContasaReceber(VpaDFluxo,false);
  CarContasAPagar(VpaDFluxo);
  if not VpaDFluxo.IndSomenteClientesQuePagamEmDia then
    CarContasaReceber(VpaDFluxo,true);
  CarCheques(VpaDFluxo,false);

  VpaDFluxo.CalculaValoresTotais;
  CarContaCaixaGrade(VpaGrade,VpaDFluxo);
  CarValorAplicacaoGrade(VpaGrade,VpaDFluxo);
  CarMesContasaReceberGrade(VpaGrade,VpaDFluxo,VpaDFluxo.Mes,VpaDFluxo.Ano);
  CarDiasTotaisFluxoGrade(VpaGrade,VpaDFluxo,VpaDFluxo.Mes,VpaDFluxo.Ano);
end;

end.
