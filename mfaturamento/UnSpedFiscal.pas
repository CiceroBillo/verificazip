Unit UnSpedFiscal;

Interface

Uses Classes, DBTables, UnDados,SysUtils, Unsistema, comCtrls, Unclientes, Tabela,SqlExpr, UnDadosProduto,
   UnNotasFiscaisFor;

//classe localiza
Type TRBLocalizaSpedFiscal = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesSpedFiscal = class(TRBLocalizaSpedFiscal)
  private
    Tabela,
    Tabela2,
    Tabela3 : TSQL;
    VprBarraStatus : TStatusBar;
    VprBaseDados : TSQLConnection;
    procedure ZeraQtdLinhas(VpaDSped : TRBDSpedFiscal);
    procedure AtualizaStatus(VpaTexto : String);
    procedure LocalizaParticipantesREG0150(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaUnidadesMedidasREG0190(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaProdutosREG0200(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaProdutosREG0200Servicos(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaNaturezaOperacaoREG0400(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaNotasFiscaisSaidaRegC100(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaNotasFiscaisEntradaRegC100(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaProdutosNotafiscalSaidaRegC170(VpaTabela : TSQL;VpaCodFilial, VpaSeqNota : Integer);
    procedure LocalizaProdutosNotafiscalEntradaRegC170(VpaTabela : TSQL;VpaCodFilial, VpaSeqNota : Integer);
    procedure LocalizaServicosNotafiscalEntradaRegC170(VpaTabela : TSQL;VpaCodFilial, VpaSeqNota : Integer);
    function RBaseCalculoICMSRegitroC170Saida(VpaValTotProdutos, VpaPerReducaoBase : Double;VpaDNatureza : TRBDNaturezaOperacao) : double;
    function RAliquotaICMSRegitroC170Saida(VpaPerICMS : Double;VpaDNatureza : TRBDNaturezaOperacao) : double;
    function RValICMSRegitroC170Saida(VpaValTotProdutos,VpaPerICMS, VpaPerReducaoBase : Double;VpaDNatureza : TRBDNaturezaOperacao) : double;
    function RRegistroC490(VpaDSped : TRBDSpedFiscal;VpaCodCST, VpaCodCFOP : Integer;VpaPerICMS :Double): TRBDSpedFiscalRegistroC490;
    function RRegistro0450(VpaDSped : TRBDSpedFiscal;VpaDRegistroC100 : TRBDspedFiscalRegistroC100) : TRBDSpedFiscalRegistro0450;
    function DadosValidos(VpaDSped : TRBDSpedFiscal) : string;
    procedure DadosValidosParticipantesREG0150(VpaDSped : TRBDSpedFiscal);
    procedure DadosValidosProdutosREG0200(VpaDSped : TRBDSpedFiscal);
    procedure CarDRegistroC190(VpaDRegistroC100 :TRBDspedFiscalRegistroC100;VpaDRegistroC170 : TRBDSpedFiscalRegistroC170);
    procedure CarDRegistroE110TotalDebitos(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0000(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0005(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0100(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0150(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0190(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0200(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0200Servicos(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0400(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0450(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC001(VpaDSped : TRBDSpedFiscal);

    procedure CarregaBlocoCRegistroC100Entrada(VpaDSped : TRBDSpedFiscal);
    procedure CarregaBlocoCRegistroC100Saida(VpaDSped : TRBDSpedFiscal);
    procedure CarregaBlocoCRegistroC110(VpaDSped : TRBDSpedFiscal;VpaDRegistroC100 : TRBDspedFiscalRegistroC100);
    procedure CarregaBlocoCRegistroC140(VpaDSped : TRBDSpedFiscal);
    procedure CarregaBlocoCRegistroC141(VpaDSped : TRBDSpedFiscal;VpaDRegistroC140 : TRBDSpedfiscalRegistroC140);
    procedure CarregaBlocoCRegistroC160(VpaDRegistroC100 : TRBDSpedFiscalRegistroC100;VpaTabela : TSQL);
    procedure CarregaBlocoCRegistroC170Saida(VpaDSped : TRBDSpedFiscal);
    procedure CarregaBlocoCRegistroC170Entrada(VpaDSped : TRBDSpedFiscal);
    procedure CarregaBlocoCRegistroC170EntradaServico(VpaDSped : TRBDSpedFiscal);
    procedure CarregaBlocoCRegistroC321(VpaDSped : TRBDSpedFiscal);
    procedure CarregaBlocoCRegistroC400(VpaDSped : TRBDSpedFiscal);
    procedure CarregaBlocoCRegistroC420(VpaDSped : TRBDSpedFiscal;VpaDRegistroC405 : TRBDSpedFiscalRegistroC405);
    procedure CarregaBlocoCRegistroC425(VpaDSped : TRBDSpedFiscal; VpaDRegistroC405 : TRBDSpedFiscalRegistroC405;VpaDRegistroC420 : TRBDSpedFiscalRegistroC420);

    procedure GeraBlocoCRegistroC100(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC110(VpadSped : TRBDSpedFiscal;VpaDRegistroC100 : TRBDSpedfiscalRegistroC100);
    procedure GeraBlocoCRegistroC140(VpadSped : TRBDSpedFiscal;VpaDRegistroC100 : TRBDSpedfiscalRegistroC100);
    procedure GeraBlocoCRegistroC141(VpaDSped : TRBDSpedFiscal;VpaDRegistroC140 : TRBDSpedfiscalRegistroC140);
    procedure GeraBlocoCRegistroC160(VpadSped : TRBDSpedFiscal;VpaDRegistroC100 : TRBDSpedfiscalRegistroC100);
    procedure GeraBlocoCRegistroC170(VpaDSped : TRBDSpedFiscal;VpaDRegistroC100 : TRBDspedFiscalRegistroC100);
    procedure GeraBlocoCRegistroC190(VpaDSped : TRBDSpedFiscal;VpaDRegistroC100 : TRBDspedFiscalRegistroC100);
    procedure GeraBlocoCRegistroC300(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC320(VpaDSped : TRBDSpedFiscal;VpaDRegistroC300 : TRBDSpedFiscalRegistroC300);
    procedure GeraBlocoCRegistroC321(VpaDSped : TRBDSpedFiscal;VpaDRegistroC320 : TRBDSpedFiscalRegistroC320);
    procedure GeraBlocoCRegistroC310(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC400(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC405(VpaDSped : TRBDSpedFiscal;VpaDRegistroC400 : TRBDSpedFiscalRegistroC400);
    procedure GeraBlocoCRegistroC420(VpaDSped : TRBDSpedFiscal;VpaDRegistroC405 : TRBDSpedFiscalRegistroC405);
    procedure GeraBlocoCRegistroC425(VpaDSped : TRBDSpedFiscal;VpaDRegistroC420 : TRBDSpedFiscalRegistroC420);
    procedure GeraBlocoCRegistroC490(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC990(VpaDSped : TRBDSpedFiscal);

    procedure CarregaBlocoDRegistroD100Entrada(VpaDSped : TRBDSpedFiscal);

    procedure GeraBlocoDRegistroD001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoDRegistroD100(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoDRegistroD990(VpaDSped : TRBDSpedFiscal);

    procedure GeraBlocoERegistroE001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE100(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE110(VpaDSped : TRBDSpedFiscal);
    procedure CarregaBlocoERegistroE116(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE116(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE500(VpaDSped : TRBDSpedFiscal);
    procedure CarregaBlocoERegistroE510(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE510(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE520(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE990(VpaDSped : TRBDSpedFiscal);

    procedure GeraBlocoGRegistroG001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoGRegistroG990(VpaDSped : TRBDSpedFiscal);

    procedure GeraBlocoHRegistroH001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoHRegistroH990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoHRegistro1001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoHRegistro1990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco9Registro9001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco9Registro9900(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco9Registro9990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco9Registro9999(VpaDSped : TRBDSpedFiscal);
    procedure CarDSped(VpadSped : TRBDSpedFiscal);
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    procedure GeraSpedfiscal(VpaDSped : TRBDSpedFiscal;VpaBarraStatus : TStatusBar);
    procedure CorrigeNotasValICMSeST(VpaDSped : TRBDSpedFiscal;VpaBarraStatus : TStatusBar);
    procedure CorrigeNotaLimpaIPI(VpaDSped : TRBDSpedFiscal;VpaBarraStatus : TStatusBar);
    procedure CorrigeBaseCalculoNotaEntrada(VpaDSped : TRBDSpedFiscal;VpaBarraStatus : TStatusBar);
    procedure CorrigeBaseCalculoNotaSaida(VpaDSped : TRBDSpedFiscal;VpaBarraStatus : TStatusBar);
end;



implementation

Uses FunSql, Constantes, funString, funvalida, UnNotafiscal, FunObjeto, UnProdutos,Fundata, constmsg;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaSpedFiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaSpedFiscal.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesSpedFiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
procedure TRBFuncoesSpedFiscal.AtualizaStatus(VpaTexto: String);
begin
  VprBarraStatus.Panels[0].Text := VpaTexto;
  VprBarraStatus.Refresh;
end;

{********************************* cria a classe ********************************}
procedure TRBFuncoesSpedFiscal.CarDRegistroC190(VpaDRegistroC100 :TRBDspedFiscalRegistroC100;VpaDRegistroC170 : TRBDSpedFiscalRegistroC170);
Var
  VpfDRegistroC190 :TRBDSpedfiscalRegistroC190;
  VpfValOperacaoC170 : Double;
begin
  VpfDRegistroC190 := VpaDRegistroC100.RRegistroC190(VpaDRegistroC170.CST_ICMS,VpaDRegistroC170.CFOP,VpaDRegistroC170.ALIQ_ICMS);
  VpfValOperacaoC170 := VpaDRegistroC170.VL_ITEM+VpaDRegistroC170.VL_IPI+VpaDRegistroC170.ValAcrescimo+VpaDRegistroC170.ValFrete+ VpaDRegistroC170.VL_ICMS_ST;
  VpfDRegistroC190.ValOperacao := VpfDRegistroC190.ValOperacao + VpfValOperacaoC170;
  VpfDRegistroC190.ValBaseCalculoICMS := VpfDRegistroC190.ValBaseCalculoICMS + VpaDRegistroC170.VL_BC_ICMS;
  VpfDRegistroC190.ValICMS := VpfDRegistroC190.ValICMS + VpaDRegistroC170.VL_ICMS;
  //rever
  VpfDRegistroC190.ValBaseCalculoICMSSubstituica := 0;
  VpfDRegistroC190.ValICMSSubstituicao := 0;
  VpfDRegistroC190.ValIPI := VpfDRegistroC190.ValIPI + VpaDRegistroC170.VL_IPI;
  VpfDRegistroC190.ValReducaBaseCalculo := VpfDRegistroC190.ValReducaBaseCalculo + (VpfValOperacaoC170 - VpaDRegistroC170.VL_BC_ICMS);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarDRegistroE110TotalDebitos(VpaDSped: TRBDSpedFiscal);
var
  VpfLacoRegistroC100, VpfLacoRegistroC190 : Integer;
  VpfDRegistroC100 : TRBDspedFiscalRegistroC100;
  VpfDRegistroC190 : TRBDSpedfiscalRegistroC190;
begin
  VpaDSped.RegistroE110.VL_TOT_DEBITOS := 0;
  VpaDSped.RegistroE110.VL_TOT_CREDITOS := 0;
  for VpfLacoRegistroC100 := 0 to VpaDSped.RegistrosC100.Count - 1 do
  begin
    VpfDRegistroC100 := TRBDspedFiscalRegistroC100(VpaDSped.RegistrosC100.Items[VpfLacoRegistroC100]);
    for VpfLacoRegistroC190 := 0 to VpfDRegistroC100.RegistrosC190.Count - 1 do
    begin
      VpfDRegistroC190 := TRBDSpedfiscalRegistroC190(VpfDRegistroC100.RegistrosC190.Items[VpfLacoRegistroC190]);
      if ((IntToStr(VpfDRegistroC190.CodCFOP)[1] in ['5','6','7'])or
         (VpfDRegistroC190.CodCFOP = 1605)) and
         (VpfDRegistroC190.CodCFOP <> 5605) then
        VpaDSped.RegistroE110.VL_TOT_DEBITOS := VpaDSped.RegistroE110.VL_TOT_DEBITOS + VpfDRegistroC190.ValICMS
      else
        if ((IntToStr(VpfDRegistroC190.CodCFOP)[1] in ['1','2','3'])or
           (VpfDRegistroC190.CodCFOP = 5605)) and
           (VpfDRegistroC190.CodCFOP <> 1605)  then
          VpaDSped.RegistroE110.VL_TOT_CREDITOS := VpaDSped.RegistroE110.VL_TOT_CREDITOS + VpfDRegistroC190.ValICMS
    end;
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarDSped(VpadSped: TRBDSpedFiscal);
var
  VpfValICMSReducao, VpfValICMInternoUfDestino :double;
  VpfIndSubstituicao :Boolean;
begin
  FunNotaFiscal.CaRValICMSPadrao(VpadSped.PerICMSInterno,VpfValICMInternoUfDestino,VpfValICMSReducao, VpadSped.DFilial.DesUF,'ISENTO',true,false,VpfIndSubstituicao);
  VpadSped.QtdLinhasBloco0 := 0;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC100Saida(VpaDSped: TRBDSpedFiscal);
Var
  VpfIndPagamentoAVista : Boolean;
  VpfRegistroC100 : TRBDspedFiscalRegistroC100;
begin
  LocalizaNotasFiscaisSaidaRegC100(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    AtualizaStatus('Carregando Bloco C registro C100 - Nota Fiscal "'+    Tabela.FieldByName('I_NRO_NOT').AsString+'"');
    VpfRegistroC100 := VpaDSped.addRegistrC100;
    VpfRegistroC100.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfRegistroC100.SeqNota := Tabela.FieldByName('I_SEQ_NOT').AsInteger;
    FunNotaFiscal.CarDNaturezaOperacao(VpfRegistroC100.DNatureza,Tabela.FieldByName('C_COD_NAT').AsString,Tabela.FieldByName('I_ITE_NAT').AsInteger);
    VpfRegistroC100.DCliente.CodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
    FunClientes.CarDCliente(VpfRegistroC100.DCliente);
    VpfRegistroC100.DesObservacoesNota := Tabela.FieldByName('L_OB1_NOT').AsString;

    if Tabela.FieldByName('C_ENT_SAI').AsString = 'E' then
      VpfRegistroC100.IND_OPER := ioEntrada
    else
      VpfRegistroC100.IND_OPER := ioSaida;
    VpfRegistroC100.IND_EMIT := ieEmissaoPropria;
    VpfRegistroC100.COD_PART := Tabela.FieldByName('I_COD_CLI').AsInteger;
    if Tabela.FieldByName('I_MOD_DOC').AsInteger = 1 then
      VpfRegistroC100.COD_MOD := cmModelo1ou1A
    else
      VpfRegistroC100.COD_MOD := cmNfe;
    if Tabela.FieldByName('C_NOT_CAN').AsString = 'S' then
      VpfRegistroC100.COD_SIT := csCancelado
    else
      if Tabela.FieldByName('C_NOT_INU').AsString = 'S' then
        VpfRegistroC100.COD_SIT := csNFEouCTENumeracaoInutilizada
      else
        VpfRegistroC100.COD_SIT := csDocumentoRegular;
    VpfRegistroC100.SER := Tabela.FieldByName('C_SER_NOT').AsString;
    VpfRegistroC100.NUM_DOC := Tabela.FieldByName('I_NRO_NOT').AsInteger;
    VpfRegistroC100.CHV_NFE := Tabela.FieldByName('C_CHA_NFE').AsString;
    VpfRegistroC100.DT_DOC := Tabela.FieldByName('D_DAT_EMI').AsDatetime;
    VpfRegistroC100.DT_E_S := Tabela.FieldByName('D_DAT_SAI').AsDatetime;
    VpfRegistroC100.VL_DOC := Tabela.FieldByName('N_TOT_NOT').AsFloat;
    if Tabela.FieldByName('C_GER_FIN').AsString = 'S' then
    begin
      if Tabela.FieldByName('I_COD_PAG').AsInteger = varia.CondPagtoVista then
        VpfRegistroC100.IND_PAGTO := ipAVista
      else
        VpfRegistroC100.IND_PAGTO := ipAPrazo;
    end
    else
      VpfRegistroC100.IND_PAGTO := ipSemPagamento;

    if (Tabela.FieldByName('N_PER_DES').AsFloat > 0) then
      VpfRegistroC100.VL_DESC := ((Tabela.FieldByName('N_TOT_PRO').AsFloat+Tabela.FieldByName('N_TOT_SER').AsFloat)*Tabela.FieldByName('N_PER_DES').AsFloat)/100
    else
      if (Tabela.FieldByName('N_VLR_DES').AsFloat > 0) then
        VpfRegistroC100.VL_DESC := Tabela.FieldByName('N_VLR_DES').AsFloat
      else
        VpfRegistroC100.VL_DESC :=0;
    VpfRegistroC100.VL_ABAT_NT := 0;
    VpfRegistroC100.VL_MERC := Tabela.FieldByName('N_TOT_PRO').AsFloat+Tabela.FieldByName('N_TOT_SER').AsFloat;
    if Tabela.FieldByName('N_VLR_FRE').AsFloat > 0 then
    begin
      case Tabela.FieldByName('I_TIP_FRE').AsInteger of
        1 : VpfRegistroC100.IND_FRT := ifPorContadoEmitente;
        2 : VpfRegistroC100.IND_FRT := ifPorContadoDestinatario;
      end;
    end
    else
      VpfRegistroC100.IND_FRT := ifSemCobrancafrete;
    VpfRegistroC100.VL_FRT := Tabela.FieldByName('N_VLR_FRE').AsFloat;
    VpfRegistroC100.VL_SEG := Tabela.FieldByName('N_VLR_SEG').AsFloat;
    if (Tabela.FieldByName('N_PER_DES').AsFloat < 0) then
      VpfRegistroC100.VL_OUT_DA := (((Tabela.FieldByName('N_TOT_PRO').AsFloat+Tabela.FieldByName('N_TOT_SER').AsFloat)*(Tabela.FieldByName('N_PER_DES').AsFloat*-1))/100)+Tabela.FieldByName('N_OUT_DES').AsFloat
    else
      if (Tabela.FieldByName('N_VLR_DES').AsFloat < 0) then
        VpfRegistroC100.VL_OUT_DA := (Tabela.FieldByName('N_VLR_DES').AsFloat*-1)+Tabela.FieldByName('N_OUT_DES').AsFloat
      else
        VpfRegistroC100.VL_OUT_DA := Tabela.FieldByName('N_OUT_DES').AsFloat;
    VpfRegistroC100.VL_BC_ICMS := Tabela.FieldByName('N_BAS_CAL').AsFloat;
    VpfRegistroC100.VL_ICMS := Tabela.FieldByName('N_VLR_ICM').AsFloat;
    VpfRegistroC100.VL_BC_ICMS_ST := Tabela.FieldByName('N_BAS_SUB').AsFloat;
    VpfRegistroC100.VL_ICMS_ST := Tabela.FieldByName('N_VLR_SUB').AsFloat;
    VpfRegistroC100.VL_IPI := Tabela.FieldByName('N_TOT_IPI').AsFloat;
    VpfRegistroC100.VL_PIS := (Tabela.FieldByName('N_TOT_NOT').AsFloat * varia.PerPIS)/100;
    VpfRegistroC100.VL_COFINS := (Tabela.FieldByName('N_TOT_NOT').AsFloat * varia.PerCOFINS)/100;
    VpfRegistroC100.VL_PIS_ST := 0;
    VpfRegistroC100.VL_COFINS_ST := 0;
    if VpfRegistroC100.IND_OPER = ioSaida then
      CarregaBlocoCRegistroC160(VpfRegistroC100,Tabela);

    if VpfRegistroC100.COD_MOD = cmModelo1ou1A then
      CarregaBlocoCRegistroC110(VpaDSped,VpfRegistroC100);
    Tabela.next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC110(VpaDSped: TRBDSpedFiscal;VpaDRegistroC100 : TRBDspedFiscalRegistroC100);
var
  VpfDRegistro0450 : TRBDSpedFiscalRegistro0450;
  VpfDRegistroC110 : TRBDSpedFiscalRegistroC110;
begin
  VpfDRegistro0450 := RRegistro0450(VpaDSped,VpaDRegistroC100);
  if VpfDRegistro0450 <> nil then
  begin
    VpfDRegistroC110 := VpaDRegistroC100.AddRegistroC110;
    VpfDRegistroC110.COD_INF := VpfDRegistro0450.CodInformacao;
    if VpaDRegistroC100.DesObservacoesNota <> '' then
      VpfDRegistroC110.TXT_COMPL := VpaDRegistroC100.DesObservacoesNota;
  end
  else
    if VpaDRegistroC100.DesObservacoesNota <> '' then
    begin
      VpfDRegistro0450 := VpaDSped.addRegistro0450;
      VpfDRegistro0450.CodInformacao := 9999 + VpaDSped.Registros0450.Count +1;
      VpfDRegistro0450.SeqNatureza := 0;
      VpfDRegistro0450.DesInformacao := VpaDRegistroC100.DesObservacoesNota;

      VpfDRegistroC110 := VpaDRegistroC100.AddRegistroC110;
      VpfDRegistroC110.COD_INF := VpfDRegistro0450.CodInformacao;
    end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC140(VpaDSped: TRBDSpedFiscal);
var
  VpfLaco : Integer;
  VpfDRegistroC100 : TRBDspedFiscalRegistroC100;
begin
  for VpfLaco := 0 to VpaDSped.RegistrosC100.Count - 1 do
  begin
    VpfDRegistroC100 := TRBDspedFiscalRegistroC100(VpaDSped.RegistrosC100.Items[VpfLaco]);

    if VpfDRegistroC100.IND_EMIT = ieEmissaoPropria then
      AdicionaSQLAbreTabela(Tabela2,'Select CAD.I_EMP_FIL, CAD.I_LAN_REC, CAD.I_NRO_NOT, CAD.I_QTD_PAR, CAD.N_VLR_TOT '+
                                ' FROM CADCONTASARECEBER CAD '+
                                ' WHERE I_EMP_FIL = '+IntToStr(VpfDRegistroC100.CodFilial)+
                                ' AND I_SEQ_NOT = ' +IntToStr(VpfDRegistroC100.SeqNota))
    else
      AdicionaSQLAbreTabela(Tabela2,'Select CAD.I_EMP_FIL, CAD.I_LAN_APG, CAD.I_NRO_NOT, CAD.I_QTD_PAR, CAD.N_VLR_TOT '+
                                ' FROM CADCONTASAPAGAR CAD '+
                                ' WHERE I_EMP_FIL = '+IntToStr(VpfDRegistroC100.CodFilial)+
                                ' AND I_SEQ_NOT = ' +IntToStr(VpfDRegistroC100.SeqNota));

    AtualizaStatus('Carregando Bloco C registro C140 - Nota Fiscal "'+  IntToStr(VpfDRegistroC100.NUM_DOC) +'"');
    if not Tabela2.eof then
    begin
      VpfDRegistroC100.RegistroC140.IND_EMIT := VpfDRegistroC100.IND_EMIT;
      VpfDRegistroC100.RegistroC140.IND_TIT :=itDuplicata;
      VpfDRegistroC100.RegistroC140.DESC_TIT :='';
      VpfDRegistroC100.RegistroC140.NUM_TIT := Tabela2.FieldByName('I_NRO_NOT').AsString;
      VpfDRegistroC100.RegistroC140.QTD_PARC := Tabela2.FieldByName('I_QTD_PAR').AsInteger;
      VpfDRegistroC100.RegistroC140.VL_TIT := Tabela2.FieldByName('N_VLR_TOT').AsFloat;
      VpfDRegistroC100.RegistroC140.CodFilial := Tabela2.FieldByName('I_EMP_FIL').AsInteger;
      case VpfDRegistroC100.RegistroC140.IND_EMIT of
        ieEmissaoPropria:VpfDRegistroC100.RegistroC140.LanReceber := Tabela2.FieldByName('I_LAN_REC').AsInteger ;
        ieTerceiros: VpfDRegistroC100.RegistroC140.LanPagar := Tabela2.FieldByName('I_LAN_APG').AsInteger ;
      end;
      CarregaBlocoCRegistroC141(VpaDSped,VpfDRegistroC100.RegistroC140);
    end;
  end;
  Tabela2.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC141(VpaDSped: TRBDSpedFiscal;VpaDRegistroC140: TRBDSpedfiscalRegistroC140);
var
  VpfDREgistroC141 : TRBDSpedFiscalRegistroC141;
begin
  case VpaDRegistroC140.IND_EMIT of
    ieEmissaoPropria:
      begin ;
        AdicionaSQLAbreTabela(Tabela3,'Select MOV.I_NRO_PAR, MOV.N_VLR_PAR, MOV.D_DAT_VEN '+
                                ' FROM MOVCONTASARECEBER MOV '+
                                ' Where MOV.I_EMP_FIL = '+IntToStr(VpaDRegistroC140.CodFilial)+
                                ' AND MOV.I_LAN_REC = '+IntToStr(VpaDRegistroC140.LanReceber)+
                                ' ORDER BY MOV.I_NRO_PAR');
      end;
    ieTerceiros:
      begin
         AdicionaSQLAbreTabela(Tabela3,'Select MOV.I_NRO_PAR, MOV.N_VLR_DUP, MOV.D_DAT_VEN '+
                                ' FROM MOVCONTASAPAGAR MOV '+
                                ' Where MOV.I_EMP_FIL = '+IntToStr(VpaDRegistroC140.CodFilial)+
                                ' AND MOV.I_LAN_APG = '+IntToStr(VpaDRegistroC140.LanPagar)+
                                ' ORDER BY MOV.I_NRO_PAR');
      end;
  end;

  while not Tabela3.Eof do
  begin
    AtualizaStatus('Carregando Bloco C registro C141 - Duplicata "'+VpaDRegistroC140.NUM_TIT +'"');
    VpfDREgistroC141 := VpaDRegistroC140.addRegistroC141;
    VpfDREgistroC141.NUM_PARC := Tabela3.FieldByName('I_NRO_PAR').AsInteger;
    VpfDREgistroC141.DT_VCTO:= Tabela3.FieldByName('D_DAT_VEN').AsDateTime;
  case VpaDRegistroC140.IND_EMIT of
    ieEmissaoPropria: VpfDREgistroC141.VL_PARC := Tabela3.FieldByName('N_VLR_PAR').AsFloat;
    ieTerceiros : VpfDREgistroC141.VL_PARC := Tabela3.FieldByName('N_VLR_DUP').AsFloat;
  end;


    Tabela3.next;
  end;
  Tabela3.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC160(VpaDRegistroC100: TRBDSpedFiscalRegistroC100; VpaTabela: TSQL);
begin
  VpaDRegistroC100.RegistroC160.IndTranporteProprio := VpaTabela.FieldByName('C_VEI_PRO').AsString = 'S';
  if VpaDRegistroC100.RegistroC160.IndTranporteProprio then
    VpaDRegistroC100.RegistroC160.COD_PART := 0
  else
    VpaDRegistroC100.RegistroC160.COD_PART := VpaTabela.FieldByName('I_COD_TRA').AsInteger;
  VpaDRegistroC100.RegistroC160.VEIC_ID := DeletaEspaco(VpaTabela.FieldByName('C_NRO_PLA').AsString);
  VpaDRegistroC100.RegistroC160.QTD_VOL := VpaTabela.FieldByName('I_QTD_VOL').AsInteger;
  VpaDRegistroC100.RegistroC160.PESO_BRT := VpaTabela.FieldByName('N_PES_BRU').AsFloat;
  VpaDRegistroC100.RegistroC160.PESO_LIQ := VpaTabela.FieldByName('N_PES_LIQ').AsFloat;
  VpaDRegistroC100.RegistroC160.UF_ID := VpaTabela.FieldByName('C_EST_PLA').AsString;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC170Entrada(VpaDSped: TRBDSpedFiscal);
Var
  VpfDRegistroC100: TRBDSpedFiscalRegistroC100;
  VpfDRegistroC170 : TRBDSpedFiscalRegistroC170;
  VpfCodCST : String;
  VpfDProduto : TRBDProduto;
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDSped.RegistrosC100.Count - 1 do
  begin
    VpfDRegistroC100 := TRBDSpedFiscalRegistroC100(VpaDSped.RegistrosC100.Items[VpfLaco]);
    if VpfDRegistroC100.IND_EMIT = ieTerceiros then
    begin
      AtualizaStatus('Carregando Bloco C registro C170 Entrada - Nota Fiscal "'+  IntToStr(VpfDRegistroC100.NUM_DOC) +'"');
      LocalizaProdutosNotafiscalEntradaRegC170(Tabela2,VpfDRegistroC100.CodFilial,VpfDRegistroC100.SeqNota);
      while not Tabela2.eof do
      begin
        VpfDRegistroC170 := VpfDRegistroC100.AddRegistroC170;

        VpfDRegistroC170.PerReducaoBaseCalculoICMS := 0;

        VpfDProduto := TRBDProduto.cria;
        FunProdutos.CarDProduto(VpfDProduto,varia.codigoempresa,Tabela2.FieldByName('I_EMP_FIL').AsInteger,Tabela2.FieldByName('I_SEQ_PRO').AsInteger);

        VpfDRegistroC170.NUM_ITEM := Tabela2.FieldByName('I_SEQ_MOV').AsInteger;
        VpfDRegistroC170.COD_ITEM := Tabela2.FieldByName('I_SEQ_PRO').AsString;
        VpfDRegistroC170.DESCR_COMPL := '';
        VpfDRegistroC170.QTD := Tabela2.FieldByName('N_QTD_PRO').AsFloat;
        VpfDRegistroC170.UNID := Tabela2.FieldByName('C_COD_UNI').AsString;
        VpfDRegistroC170.QTD := Tabela2.FieldByName('N_QTD_PRO').AsFloat;
        VpfDRegistroC170.ValAcrescimo := Tabela2.FieldByName('N_OUT_DES').AsFloat;
        VpfDRegistroC170.VL_DESC := Tabela2.FieldByName('N_VLR_DES').AsFloat;
        VpfDRegistroC170.ValFrete := Tabela2.FieldByName('N_VLR_FRE').AsFloat;
        VpfDRegistroC170.VL_ITEM := Tabela2.FieldByName('N_TOT_PRO').AsFloat-VpfDRegistroC170.VL_DESC;
        if VpfDRegistroC100.DNatureza.IndMovimentacaoFisica then
          VpfDRegistroC170.IND_MOV := imSim
        else
          VpfDRegistroC170.IND_MOV := imNao;
        if Length(Tabela2.FieldByName('C_COD_CST').AsString) = 4 then //codigo do csosn ao inves do cst
          VpfDRegistroC170.CST_ICMS := copy(Tabela2.FieldByName('C_COD_CST').AsString,2,3)
        else
          VpfDRegistroC170.CST_ICMS := Tabela2.FieldByName('C_COD_CST').AsString;

        VpfDRegistroC170.CFOP := Tabela2.FieldByName('I_COD_CFO').AsInteger;
        VpfDRegistroC170.COD_NAT := VpfDRegistroC100.DNatureza.CodNatureza+IntToStr(VpfDRegistroC100.DNatureza.SeqNatureza);

        VpfDRegistroC170.VL_BC_ICMS := Tabela2.FieldByName('N_VLR_BIC').AsFloat;
        VpfDRegistroC170.ALIQ_ICMS := Tabela2.FieldByName('N_PER_ICM').AsFloat;
        VpfDRegistroC170.VL_ICMS := Tabela2.FieldByName('N_VLR_ICM').AsFloat;
        VpfDRegistroC170.VL_BC_ICMS_ST := Tabela2.FieldByName('N_VLR_BST').AsFloat;
        VpfDRegistroC170.VL_ICMS_ST := Tabela2.FieldByName('N_VLR_BST').AsFloat;
        VpfDRegistroC170.ALIQ_ST := 0;
        VpfDRegistroC170.IND_APUR := iaMensal;
        VpfDRegistroC170.CST_IPI := varia.CSTIPIEntrada;
        VpfDRegistroC170.COD_ENQ :='';
        VpfDRegistroC170.VL_BC_IPI := VpfDRegistroC170.VL_ITEM;
        VpfDRegistroC170.ALIQ_IPI := Tabela2.FieldByName('N_PER_IPI').AsFloat;
        VpfDRegistroC170.VL_IPI := (VpfDRegistroC170.VL_BC_IPI * VpfDRegistroC170.ALIQ_IPI)/100;
        VpfDRegistroC170.CST_PIS := Varia.CSTPISEntrada;
        VpfDRegistroC170.VL_BC_PIS := VpfDRegistroC170.VL_ITEM;
        VpfDRegistroC170.ALIQ_PIS_PER := varia.PerPIS;
        VpfDRegistroC170.QUANT_BC_PIS :=0;
        VpfDRegistroC170.ALIQ_PIS_VLR :=0;
        VpfDRegistroC170.VL_PIS :=(VpfDRegistroC170.VL_ITEM * VpfDRegistroC170.ALIQ_PIS_PER)/100;
        VpfDRegistroC170.CST_COFINS :=varia.CSTCofinsEntrada;
        VpfDRegistroC170.VL_BC_COFINS :=VpfDRegistroC170.VL_ITEM;
        VpfDRegistroC170.ALIQ_COFINS_PER :=varia.PerCOFINS;
        VpfDRegistroC170.QUANT_BC_COFINS := 0;
        VpfDRegistroC170.ALIQ_COFINS_VLR := 0;
        VpfDRegistroC170.VL_COFINS :=(VpfDRegistroC170.VL_ITEM * VpfDRegistroC170.ALIQ_COFINS_PER)/100;
        VpfDRegistroC170.COD_CTA := '0';

        CarDRegistroC190(VpfDRegistroC100,VpfDRegistroC170);
        tabela2.next;
        VpfDProduto.free;
      end;
    end;
  end;
  Tabela2.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC170EntradaServico(VpaDSped: TRBDSpedFiscal);
Var
  VpfDRegistroC100: TRBDSpedFiscalRegistroC100;
  VpfDRegistroC170 : TRBDSpedFiscalRegistroC170;
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDSped.RegistrosC100.Count - 1 do
  begin
    VpfDRegistroC100 := TRBDSpedFiscalRegistroC100(VpaDSped.RegistrosC100.Items[VpfLaco]);
    if VpfDRegistroC100.IND_EMIT = ieTerceiros then
    begin
      AtualizaStatus('Carregando Bloco C registro C170 Servicos Entrada - Nota Fiscal "'+  IntToStr(VpfDRegistroC100.NUM_DOC) +'"');
      LocalizaServicosNotafiscalEntradaRegC170(Tabela2,VpfDRegistroC100.CodFilial,VpfDRegistroC100.SeqNota);
      while not Tabela2.eof do
      begin
        VpfDRegistroC170 := VpfDRegistroC100.AddRegistroC170;
        VpfDRegistroC170.PerReducaoBaseCalculoICMS := 0;

        VpfDRegistroC170.NUM_ITEM := Tabela2.FieldByName('I_SEQ_MOV').AsInteger;
        VpfDRegistroC170.COD_ITEM := 'SE'+Tabela2.FieldByName('I_COD_SER').AsString;
        VpfDRegistroC170.DESCR_COMPL := '';
        VpfDRegistroC170.QTD := Tabela2.FieldByName('N_QTD_SER').AsFloat;
        VpfDRegistroC170.UNID := 'SE';
        VpfDRegistroC170.QTD := Tabela2.FieldByName('N_QTD_SER').AsFloat;
        VpfDRegistroC170.ValAcrescimo := 0;
        VpfDRegistroC170.VL_DESC := 0;
        VpfDRegistroC170.VL_ITEM := Tabela2.FieldByName('N_TOT_SER').AsFloat;
        VpfDRegistroC170.IND_MOV := imNao;
        VpfDRegistroC170.CST_ICMS := '90';

        VpfDRegistroC170.CFOP := Tabela2.FieldByName('I_COD_CFO').AsInteger;
        VpfDRegistroC170.COD_NAT := VpfDRegistroC100.DNatureza.CodNatureza+IntToStr(VpfDRegistroC100.DNatureza.SeqNatureza);

        VpfDRegistroC170.VL_BC_ICMS := 0;
        VpfDRegistroC170.ALIQ_ICMS := 0;
        VpfDRegistroC170.VL_ICMS := 0;
        VpfDRegistroC170.VL_BC_ICMS_ST := 0;
        VpfDRegistroC170.VL_ICMS_ST := 0;
        VpfDRegistroC170.ALIQ_ST := 0;
        VpfDRegistroC170.IND_APUR := iaMensal;
        VpfDRegistroC170.CST_IPI := varia.CSTIPIEntrada;
        VpfDRegistroC170.COD_ENQ :='';
        VpfDRegistroC170.VL_BC_IPI := VpfDRegistroC170.VL_ITEM;
        VpfDRegistroC170.ALIQ_IPI := 0;
        VpfDRegistroC170.VL_IPI := (VpfDRegistroC170.VL_BC_IPI * VpfDRegistroC170.ALIQ_IPI)/100;
        VpfDRegistroC170.CST_PIS := Varia.CSTPISEntrada;
        VpfDRegistroC170.VL_BC_PIS := VpfDRegistroC170.VL_ITEM;
        VpfDRegistroC170.ALIQ_PIS_PER := varia.PerPIS;
        VpfDRegistroC170.QUANT_BC_PIS :=0;
        VpfDRegistroC170.ALIQ_PIS_VLR :=0;
        VpfDRegistroC170.VL_PIS :=(VpfDRegistroC170.VL_ITEM * VpfDRegistroC170.ALIQ_PIS_PER)/100;
        VpfDRegistroC170.CST_COFINS :=varia.CSTCofinsEntrada;
        VpfDRegistroC170.VL_BC_COFINS :=VpfDRegistroC170.VL_ITEM;
        VpfDRegistroC170.ALIQ_COFINS_PER :=varia.PerCOFINS;
        VpfDRegistroC170.QUANT_BC_COFINS := 0;
        VpfDRegistroC170.ALIQ_COFINS_VLR := 0;
        VpfDRegistroC170.VL_COFINS :=(VpfDRegistroC170.VL_ITEM * VpfDRegistroC170.ALIQ_COFINS_PER)/100;
        VpfDRegistroC170.COD_CTA := '0';

        CarDRegistroC190(VpfDRegistroC100,VpfDRegistroC170);
        tabela2.next;
      end;
    end;
  end;
  Tabela2.Close;

end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC170Saida(VpaDSped: TRBDSpedFiscal);
Var
  VpfDRegistroC100: TRBDSpedFiscalRegistroC100;
  VpfDRegistroC170 : TRBDSpedFiscalRegistroC170;
  VpfCodCST : String;
  VpfDProduto : TRBDProduto;
  VpfLaco : Integer;
  VpfValAcrescimo, VpfPercentualSobreTotal : Double;
begin
  for VpfLaco := 0 to VpaDSped.RegistrosC100.Count - 1 do
  begin
    VpfDRegistroC100 := TRBDSpedFiscalRegistroC100(VpaDSped.RegistrosC100.Items[VpfLaco]);
    if VpfDRegistroC100.IND_EMIT = ieEmissaoPropria then
    begin
      AtualizaStatus('Carregando Bloco C registro C170 - Nota Fiscal "'+  IntToStr(VpfDRegistroC100.NUM_DOC) +'"');
      if not(VpfDRegistroC100.COD_SIT IN [csCancelado,csEscrituracaoExtemporaneaCancelado,csNFEouCTEDenegado,csNFEouCTENumeracaoInutilizada])  then
      begin
        LocalizaProdutosNotafiscalSaidaRegC170(Tabela2,VpfDRegistroC100.CodFilial,VpfDRegistroC100.SeqNota);
        while not Tabela2.eof do
        begin
          VpfDRegistroC170 := VpfDRegistroC100.AddRegistroC170;
          VpfValAcrescimo := 0;

          VpfDRegistroC170.PerReducaoBaseCalculoICMS := Tabela2.FieldByName('N_RED_BAS').AsFloat;
          VpfDRegistroC170.VL_DESC := Tabela2.FieldByName('N_VLR_DES').AsFloat;
          VpfDRegistroC170.ValAcrescimo := Tabela2.FieldByName('N_OUT_DES').AsFloat;
          VpfDRegistroC170.ValFrete := Tabela2.FieldByName('N_VLR_FRE').AsFloat;

          VpfDProduto := TRBDProduto.cria;
          FunProdutos.CarDProduto(VpfDProduto,varia.codigoempresa,Tabela2.FieldByName('I_EMP_FIL').AsInteger,Tabela2.FieldByName('I_SEQ_PRO').AsInteger);

          VpfDRegistroC170.NUM_ITEM := Tabela2.FieldByName('I_SEQ_MOV').AsInteger;
          VpfDRegistroC170.COD_ITEM := Tabela2.FieldByName('I_SEQ_PRO').AsString;
          VpfDRegistroC170.DESCR_COMPL := '';
          VpfDRegistroC170.QTD := Tabela2.FieldByName('N_QTD_PRO').AsFloat;
          VpfDRegistroC170.UNID := Tabela2.FieldByName('C_COD_UNI').AsString;
          VpfDRegistroC170.QTD := Tabela2.FieldByName('N_QTD_PRO').AsFloat;
          VpfDRegistroC170.VL_ITEM := Tabela2.FieldByName('N_TOT_PRO').AsFloat-VpfDRegistroC170.VL_DESC;
          if VpfDRegistroC100.DNatureza.IndMovimentacaoFisica then
            VpfDRegistroC170.IND_MOV := imSim
          else
            VpfDRegistroC170.IND_MOV := imNao;
          VpfDRegistroC170.CST_ICMS := Tabela2.FieldByName('C_COD_CST').AsString;
          if Tabela2.FieldByName('I_COD_CFO').AsInteger <> 0 then
            VpfDRegistroC170.CFOP := Tabela2.FieldByName('I_COD_CFO').AsInteger
          else
            VpfDRegistroC170.CFOP := FunNotaFiscal.RCFOPProduto(VpfDRegistroC100.DCliente,VpfDRegistroC100.DNatureza,VpfDProduto);

          VpfDRegistroC170.COD_NAT := VpfDRegistroC100.DNatureza.CodNatureza+IntToStr(VpfDRegistroC100.DNatureza.SeqNatureza);
          VpfDRegistroC170.VL_BC_ICMS := Tabela2.FieldByName('N_BAS_ICM').AsFloat;
          VpfDRegistroC170.ALIQ_ICMS := Tabela2.FieldByName('N_PER_ICM').AsFloat;
          VpfDRegistroC170.VL_ICMS := Tabela2.FieldByName('N_VLR_ICM').AsFloat;
          VpfDRegistroC170.VL_BC_ICMS_ST := 0;
          VpfDRegistroC170.ALIQ_ST := 0;
          VpfDRegistroC170.VL_ICMS_ST := 0;
          VpfDRegistroC170.IND_APUR := iaMensal;
          VpfDRegistroC170.CST_IPI := varia.CSTIPISaida;
          VpfDRegistroC170.COD_ENQ :='';
          VpfDRegistroC170.VL_BC_IPI := VpfDRegistroC170.VL_ITEM;
          VpfDRegistroC170.ALIQ_IPI := Tabela2.FieldByName('N_PER_IPI').AsFloat;
          VpfDRegistroC170.VL_IPI := Tabela2.FieldByName('N_VLR_IPI').AsFloat;
          VpfDRegistroC170.CST_PIS := Varia.CSTPISSaida;
          VpfDRegistroC170.VL_BC_PIS := VpfDRegistroC170.VL_ITEM;
          VpfDRegistroC170.ALIQ_PIS_PER := varia.PerPIS;
          VpfDRegistroC170.QUANT_BC_PIS :=0;
          VpfDRegistroC170.ALIQ_PIS_VLR :=0;
          VpfDRegistroC170.VL_PIS :=(VpfDRegistroC170.VL_ITEM * VpfDRegistroC170.ALIQ_PIS_PER)/100;
          VpfDRegistroC170.CST_COFINS :=varia.CSTCofinsSaida;
          VpfDRegistroC170.VL_BC_COFINS :=VpfDRegistroC170.VL_ITEM;
          VpfDRegistroC170.ALIQ_COFINS_PER :=varia.PerCOFINS;
          VpfDRegistroC170.QUANT_BC_COFINS := 0;
          VpfDRegistroC170.ALIQ_COFINS_VLR := 0;
          VpfDRegistroC170.VL_COFINS :=(VpfDRegistroC170.VL_ITEM * VpfDRegistroC170.ALIQ_COFINS_PER)/100;
          VpfDRegistroC170.COD_CTA := '0';

          CarDRegistroC190(VpfDRegistroC100,VpfDRegistroC170);
          VpfDProduto.free;
          tabela2.next;
        end;
      end;
    end;
  end;
  Tabela2.Close;
end;


{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC321(VpaDSped: TRBDSpedFiscal);
Var
  VpfDRegistroC300 : TRBDSpedFiscalRegistroC300;
  VpfDRegistroC320 : TRBDSpedFiscalRegistroC320;
  VpfDRegistroC321 : TRBDSpedFiscalRegistroC321;
  VpfDatAtual : TDateTime;
  VpfSerieAtual : string;
  VpfValBaseICMS : Double;
begin
  AdicionaSQLAbreTabela(Tabela,'select  MOV.C_COD_PRO, MOV.C_COD_UNI, MOV.N_TOT_PRO, MOV.C_COD_CST, MOV.I_COD_CFO, MOV.N_PER_ICM, MOV.N_RED_BAS, '+
                               ' MOV.N_QTD_PRO, '+
                               ' CAD.C_SER_NOT, TRUNC(CAD.D_DAT_EMI) D_DAT_EMI, CAD.I_NRO_NOT '+
                               ' from CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV '+
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               ' and CAD.C_VEN_CON = ''S'''+
                               ' AND C_NOT_CAN = ''N'''+
                               ' AND CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(CAD.D_DAT_EMI)',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' ORDER BY CAD.C_SER_NOT, CAD.D_DAT_EMI, CAD.I_NRO_NOT, MOV.C_COD_CST, MOV.I_COD_CFO, MOV.N_PER_ICM' );
  VpfSerieAtual := '-9999-';
  //cria um ponteiro de classe somente para nao dar acces violation, esse ponteiro nao sera utilizado;
  VpfDRegistroC320 := TRBDSpedFiscalRegistroC320.Create;
  while not Tabela.Eof do
  begin
    if (VpfDatAtual <> Tabela.FieldByName('D_DAT_EMI').AsDateTime) or
       (VpfSerieAtual <> Tabela.FieldByName('C_SER_NOT').AsString) then
    begin
      VpfDatAtual := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
      VpfSerieAtual := Tabela.FieldByName('C_SER_NOT').AsString;
      VpfDRegistroC300 := VpaDSped.addRegistroC300;
      VpfDRegistroC300.NumDocumentoInicial := Tabela.FieldByName('I_NRO_NOT').AsInteger;
      VpfDRegistroC300.DesSerieNota := Tabela.FieldByName('C_SER_NOT').AsString;
      VpfDRegistroC300.DesSubSerieNota := '';
      VpfDRegistroC300.DatDocumento := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
      //atualizado com -9000 para no if abaixo forçar novo registro;
      VpfDRegistroC320.CodCST := -999999;
    end;
    VpfDRegistroC300.ValDocumento := VpfDRegistroC300.ValDocumento + Tabela.FieldByName('N_TOT_PRO').AsFloat;
    VpfDRegistroC300.NumDocumentoFinal := Tabela.FieldByName('I_NRO_NOT').AsInteger;

    if (StrToInt(AdicionaCharE('0',Tabela.FieldByName('C_COD_CST').AsString,3)) <> VpfDRegistroC320.CodCST)or
       (Tabela.FieldByName('I_COD_CFO').AsInteger <> VpfDRegistroC320.CodCFOP) OR
       (Tabela.FieldByName('N_PER_ICM').AsFloat <> VpfDRegistroC320.PerICMS) then
    begin
      VpfDRegistroC320 := VpfDRegistroC300.addRegistroC320;
      VpfDRegistroC320.CodCST := StrToInt(AdicionaCharE('0',Tabela.FieldByName('C_COD_CST').AsString,3));
      VpfDRegistroC320.CodCFOP := Tabela.FieldByName('I_COD_CFO').AsInteger;
      VpfDRegistroC320.PerICMS := Tabela.FieldByName('N_PER_ICM').AsFloat;
    end;
    VpfDRegistroC320.ValOperacao := VpfDRegistroC320.ValOperacao +  Tabela.FieldByName('N_TOT_PRO').AsFloat;
    VpfValBaseICMS := Tabela.FieldByName('N_TOT_PRO').AsFloat - ((Tabela.FieldByName('N_RED_BAS').AsFloat/100)*Tabela.FieldByName('N_TOT_PRO').AsFloat);
    VpfDRegistroC320.ValBcICMS := VpfDRegistroC320.ValBcICMS + VpfValBaseICMS;
    VpfDRegistroC320.ValICMS := VpfDRegistroC320.ValICMS + (VpfValBaseICMS * (Tabela.FieldByName('N_PER_ICM').AsFloat /100));
    VpfDRegistroC320.ValReducaoBC := VpfDRegistroC320.ValReducaoBC + ((Tabela.FieldByName('N_RED_BAS').AsFloat/100)*Tabela.FieldByName('N_TOT_PRO').AsFloat);

    VpfDRegistroC321 := VpfDRegistroC320.AddRegistroC321;
    VpfDRegistroC321.CodProduto := Tabela.FieldByName('C_COD_PRO').Asstring;
    VpfDRegistroC321.DesUM := Tabela.FieldByName('C_COD_UNI').AsString;
    VpfDRegistroC321.QtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat;
    VpfDRegistroC321.ValItem := Tabela.FieldByName('N_TOT_PRO').AsFloat;
    VpfDRegistroC321.ValDesconto :=0;
    VpfDRegistroC321.ValBCICMS := VpfValBaseICMS;
    VpfDRegistroC321.ValICMS := VpfValBaseICMS * (Tabela.FieldByName('N_PER_ICM').AsFloat/100);
    VpfDRegistroC321.ValPIS := 0;
    VpfDRegistroC321.ValCofins := 0;

    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC400(VpaDSped: TRBDSpedFiscal);
var
  VpfDRegistroC400 : TRBDSpedFiscalRegistroC400;
  VpfDRegistroC405 : TRBDSpedFiscalRegistroC405;
  VpfSerieNotaAtual :string;
  VpfNumReducaoZAtual :Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'select SER.C_SER_NOT, SER.C_MOD_ECF, SER.I_NUM_USU, '+
                               ' REZ.NUMREDUCAOZ, REZ.DATMOVIMENTO,  '+
                               ' REZ.NUMCONTADOROPERACAO, REZ.NUMCONTADORREINICIOOPERACAO, REZ.VALGRANDETOTAL,  '+
                               ' REZ.VALVENDABRUTADIARIA '+
                               ' from CADSERIENOTAS SER, REDUCAOZ REZ '+
                               ' Where REZ.NUMSERIEECF = SER.C_SER_NOT ' +
                               ' AND SER.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                                SQLTextoDataEntreAAAAMMDD('TRUNC(REZ.DATMOVIMENTO)',VpaDSped.DatInicio, VpaDSped.DatFinal,true)+
                                ' order by SER.C_SER_NOT, REZ.NUMREDUCAOZ');
  VpfSerieNotaAtual := '-9000-';
  VpfNumReducaoZAtual := -900;
  while not Tabela.Eof do
  begin
    if Tabela.FieldByName('C_SER_NOT').AsString <> VpfSerieNotaAtual then
    begin
      VpfSerieNotaAtual := Tabela.FieldByName('C_SER_NOT').AsString;
      VpfDRegistroC400 := VpaDSped.addRegistroC400;
      VpfDRegistroC400.CodModeloDocumento := '2D';
      VpfDRegistroC400.CodModeloECF := Tabela.FieldByName('C_MOD_ECF').AsString;
      VpfDRegistroC400.DesSerie := Tabela.FieldByName('C_SER_NOT').AsString;
      VpfDRegistroC400.NumCaixa := Tabela.FieldByName('I_NUM_USU').AsInteger;
    end;
    VpfDRegistroC405 := VpfDRegistroC400.addRegistroC405;
    VpfDRegistroC405.NumSerieECF := Tabela.FieldByName('C_SER_NOT').AsString;
    VpfDRegistroC405.NumCRO := Tabela.FieldByName('NUMCONTADORREINICIOOPERACAO').AsInteger;
    VpfDRegistroC405.NumCRZ := Tabela.FieldByName('NUMREDUCAOZ').AsInteger;
    VpfDRegistroC405.NumCOO := Tabela.FieldByName('NUMCONTADOROPERACAO').AsInteger;
    VpfDRegistroC405.DatMovimento := Tabela.FieldByName('DATMOVIMENTO').AsDateTime;
    VpfDRegistroC405.ValVendaBrutaDiaria := Tabela.FieldByName('VALVENDABRUTADIARIA').AsFloat;
    VpfDRegistroC405.ValGrandeTotal := Tabela.FieldByName('VALGRANDETOTAL').AsFloat;
    CarregaBlocoCRegistroC420(VpaDSped,VpfDRegistroC405);
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC420(VpaDSped: TRBDSpedFiscal;VpaDRegistroC405: TRBDSpedFiscalRegistroC405);
var
 VpfDRegistroC420 : TRBDSpedFiscalRegistroC420;
begin
  AdicionaSQLAbreTabela(Tabela2,'SELECT * FROM REDUCAOZ '+
                                ' Where NUMSERIEECF = '''+VpaDRegistroC405.NumSerieECF+''''+
                                ' AND NUMREDUCAOZ = ' +IntToStr(VpaDRegistroC405.NumCRZ));
  if Tabela2.FieldByName('VALSTICMS').AsFloat <> 0then
  begin
    VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
    VpfDRegistroC420.CodTotalizadorParcial := 'F1';
    VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALSTICMS').AsFloat;
    CarregaBlocoCRegistroC425(VpaDSped,VpaDRegistroC405,VpfDRegistroC420);
  end;
  if Tabela2.FieldByName('VALISENTOICMS').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'I1';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALISENTOICMS').AsFloat;
    CarregaBlocoCRegistroC425(VpaDSped,VpaDRegistroC405,VpfDRegistroC420);
  end;
  if Tabela2.FieldByName('VALNAOTRIBUTADOICMS').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'N1';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALNAOTRIBUTADOICMS').AsFloat;
    CarregaBlocoCRegistroC425(VpaDSped,VpaDRegistroC405,VpfDRegistroC420);
  end;
  if Tabela2.FieldByName('VALSTISSQN').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'FS1';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALSTISSQN').AsFloat;
  end;
  if Tabela2.FieldByName('VALISENTOISSQN').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'IS1';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALISENTOISSQN').AsFloat;
  end;
  if Tabela2.FieldByName('VALNAOTRIBUTADOISSQN').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'NS1';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALNAOTRIBUTADOISSQN').AsFloat;
  end;
  if Tabela2.FieldByName('VALOPERACAONAOFISCAL').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'OPNF';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALOPERACAONAOFISCAL').AsFloat;
  end;
  if Tabela2.FieldByName('VALDESCONTOICMS').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'DT';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALDESCONTOICMS').AsFloat;
  end;
  if Tabela2.FieldByName('VALDESCONTOISSQN').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'DS';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALDESCONTOISSQN').AsFloat;
  end;
  if Tabela2.FieldByName('VALACRESCIMOICMS').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'AT';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALACRESCIMOICMS').AsFloat;
  end;
  if Tabela2.FieldByName('VALACRESCIMOISSQN').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'AS';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALACRESCIMOISSQN').AsFloat;
  end;
  if Tabela2.FieldByName('VALCANCELADOICMS').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'Can-T';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALCANCELADOICMS').AsFloat;
  end;
  if Tabela2.FieldByName('VALCANCELADOISSQN').AsFloat <> 0then
  begin
  	VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
  	VpfDRegistroC420.CodTotalizadorParcial := 'Can-S';
  	VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALCANCELADOISSQN').AsFloat;
  end;

  AdicionaSQLAbreTabela(Tabela2,'Select * from REDUCAOZALIQUOTA ' +
                                ' Where NUMSERIEECF = '''+VpaDRegistroC405.NumSerieECF+''''+
                                ' AND NUMREDUCAOZ = ' +IntToStr(VpaDRegistroC405.NumCRZ));
  while not Tabela2.Eof do
  begin
    if Tabela2.FieldByName('VALVENDA').AsFloat <> 0 then
    begin
      VpfDRegistroC420 := VpaDRegistroC405.addRegistroC420;
      VpfDRegistroC420.CodTotalizadorParcial := AdicionaCharE('0',Tabela2.FieldByName('SEQINDICE').AsString,2)+ DeletaChars(Tabela2.FieldByName('DESTIPO').AsString,' ') +DeletaChars(FormatFloat('00.00',Tabela2.FieldByName('PERALIQUOTA').AsFloat),',');
      VpfDRegistroC420.ValAcumulado := Tabela2.FieldByName('VALVENDA').AsFloat;
      CarregaBlocoCRegistroC425(VpaDSped,VpaDRegistroC405,VpfDRegistroC420);
    end;
    Tabela2.Next;
  end;

end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC425(VpaDSped: TRBDSpedFiscal;VpaDRegistroC405 : TRBDSpedFiscalRegistroC405;VpaDRegistroC420: TRBDSpedFiscalRegistroC420);
var
  VpfDRegistroC425 : TRBDSpedFiscalRegistroC425;
  VpfDRegistroC490 : TRBDSpedFiscalRegistroC490;
begin
  AdicionaSQLAbreTabela(Tabela3,'select MOV.C_COD_PRO, MOV.N_QTD_PRO,  MOV.N_TOT_PRO, MOV.C_COD_UNI, MOV.C_TPA_ECF, MOV.C_COD_CST, '+
                               ' MOV.I_COD_CFO, MOV.N_PER_ICM, '+
                               '  CAD.I_NRO_NOT, CAD.I_SEQ_NOT '+
                               ' from MOVNOTASFISCAIS MOV, CADNOTAFISCAIS CAD '+
                               ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                               ' AND MOV.I_SEQ_NOT = CAD.I_SEQ_NOT '+
                               ' AND CAD.I_NUM_CRZ = '+IntToStr(VpaDRegistroC405.NumCRZ)+
                               ' AND CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               ' AND MOV.C_TPA_ECF = '''+VpaDRegistroC420.CodTotalizadorParcial+'''');
  while not Tabela3.Eof do
  begin
    VpfDRegistroC425 := VpaDRegistroC420.addRegistroC425;
    VpfDRegistroC425.CodProduto := Tabela3.FieldByName('C_COD_PRO').AsString;
    VpfDRegistroC425.DesUM := Tabela3.FieldByName('C_COD_UNI').AsString;
    VpfDRegistroC425.QtdProduto := Tabela3.FieldByName('N_QTD_PRO').AsFloat;
    VpfDRegistroC425.ValTotal := Tabela3.FieldByname('N_TOT_PRO').AsFloat;
    VpfDRegistroC425.ValPis := 0;
    VpfDRegistroC425.ValCofins :=0;

    VpfDRegistroC490 := RRegistroC490(VpaDSped,StrToInt(AdicionaCharE('0',Tabela3.FieldByName('C_COD_CST').AsString,3)),Tabela3.FieldByName('I_COD_CFO').AsInteger,Tabela3.FieldByName('N_PER_ICM').AsFloat);
    VpfDRegistroC490.ValProdutos := VpfDRegistroC490.ValProdutos + Tabela3.FieldByname('N_TOT_PRO').AsFloat;
    VpfDRegistroC490.ValBaseCalculo := VpfDRegistroC490.ValBaseCalculo + Tabela3.FieldByname('N_TOT_PRO').AsFloat;
    VpfDRegistroC490.ValICMS := (VpfDRegistroC490.ValBaseCalculo *VpfDRegistroC490.PerICMS)/100;
    Tabela3.Next
  end;
  Tabela3.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoDRegistroD100Entrada(VpaDSped: TRBDSpedFiscal);
var
  VpfDRegistroD100 : TRBDSpedFiscalRegistroD100;
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT CON.CODTRANSPORTADORA, CON.CODMODELODOCUMENTO, CON.DATCONHECIMENTO, CON.NUMTIPOCONHECIMENTO, ' +
                               ' CON.VALCONHECIMENTO, CON.VALBASEICMS, CON.VALICMS, CON.PESFRETE, CON.VALNAOTRIBUTADO, CON.NUMCONHECIMENTO,  ' +
                               ' NOTA.I_NRO_NOT, NOTA.C_SER_NOT, NOTA.D_DAT_EMI, NOTA.I_TIP_FRE '+
                               ' FROM CONHECIMENTOTRANSPORTE CON, CADNOTAFISCAISFOR NOTA ' +
                               ' Where  CON.CODFILIALNOTA = NOTA.I_EMP_FIL ' +
                               ' AND CON.SEQNOTAENTRADA = NOTA.I_SEQ_NOT ' +
                               ' AND CODFILIALNOTA = ' +IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(DATCONHECIMENTO)',VpaDSped.DatInicio,VpaDSped.DatFinal,true) );
  while not Tabela.Eof do
  begin
    VpfDRegistroD100 := VpaDSped.addRegistroD100;
    with VpfDRegistroD100 do
    begin
      CodParticipante := Tabela.FieldByName('CODTRANSPORTADORA').AsInteger;
      NumDocumentoFiscal := Tabela.FieldByName('I_NRO_NOT').AsInteger;
      CodModeloDocumento := Tabela.FieldByName('CODMODELODOCUMENTO').AsString;
      DesSerieDocumentoFiscal := Tabela.FieldByName('C_SER_NOT').AsString;
      DesSubSerieDocumentoFiscal := '';
      DatDocumentoFiscal := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
      DatAquisicaoServico := Tabela.FieldByName('DATCONHECIMENTO').AsDateTime;
      ValDocumento := Tabela.FieldByName('VALDOCUMENTO').AsFloat;
      ValDesconto := 0;
      ValServico := Tabela.FieldByName('VALCONHECIMENTO').AsFloat;
      ValBaseICMS := Tabela.FieldByName('VALBASEICMS').AsFloat;
      ValICMS := Tabela.FieldByName('VALICMS').AsFloat;
      ValNaoTributado := Tabela.FieldByName('VALNAOTRIBUTADO').AsFloat;
      case Tabela.FieldByName('I_TIP_FRE').AsInteger of
        1 : IndFrete := ifPorContadoEmitente;
        2 : IndFrete := ifPorContadoDestinatario;
      else
        IndFrete := ifSemCobrancafrete;
      end;
      CodSituacao := csDocumentoRegular;
    end;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoERegistroE116(VpaDSped: TRBDSpedFiscal);
var
  VpfDREgistroE116 : TRBDSpedFiscalRegistroE116;
begin
  VpfDREgistroE116 := VpaDSped.AddRegistroE116;
  with VpfDREgistroE116 do
  begin
    COD_OR := coICMSaRecolher;
    VL_OR := VpaDSped.RegistroE110.VL_ICMS_RECOLHER +VpaDSped.RegistroE110.DEB_ESP;
    if VL_OR < 0 then
      VL_OR := 0;
    DT_VCTO := MontaData(Varia.DiaVencimentoICMS,Mes(IncMes(VpaDSped.DatInicio,1)),ano(IncMes(VpaDSped.DatInicio,1)));
    COD_REC := Varia.CodigoICMSReceita;
    MES_REF := VpaDSped.DatInicio;
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoERegistroE510(VpaDSped: TRBDSpedFiscal);
var
  VpfLacoRegistroC100, VpflacoRegistroC170 : Integer;
  VpfDRegistroE510 : TRBDSpedFiscalRegistroE510;
  VpfDRegistroC170 : TRBDSpedFiscalRegistroC170;
  VpfDRegistroC100 : TRBDspedFiscalRegistroC100;
begin
  for VpfLacoRegistroC100 := 0 to VpaDSped.RegistrosC100.Count - 1 do
  begin
    VpfDRegistroC100 := TRBDspedFiscalRegistroC100(VpaDSped.RegistrosC100.Items[VpfLacoRegistroC100]);
//    if VpfDRegistroC100.IND_EMIT = ieEmissaoPropria then
    begin
      for VpflacoRegistroC170 := 0 to VpfDRegistroC100.RegistrosC170.Count - 1 do
      begin
        VpfDRegistroC170 := TRBDSpedFiscalRegistroC170(VpfDRegistroC100.RegistrosC170.Items[VpflacoRegistroC170]);
        VpfDRegistroE510 := VpaDSped.RRegistroE510(VpfDRegistroC170.CFOP,VpfDRegistroC170.CST_IPI);
        VpfDRegistroE510.VL_CONT_IPI := VpfDRegistroE510.VL_CONT_IPI + VpfDRegistroC170.VL_BC_IPI;
        VpfDRegistroE510.VL_BC_IPI := VpfDRegistroE510.VL_BC_IPI + VpfDRegistroC170.VL_BC_IPI;
        VpfDRegistroE510.VL_IPI := VpfDRegistroE510.VL_IPI + VpfDRegistroC170.VL_IPI;
        if ((IntToStr(VpfDRegistroC170.CFOP)[1] in ['5','6','7'])or
           (VpfDRegistroC170.CFOP = 1605)) and
           (VpfDRegistroC170.CFOP <> 5605)  then
          VpaDSped.RegistroE520.VL_DEB_IPI := VpaDSped.RegistroE520.VL_DEB_IPI + VpfDRegistroC170.VL_IPI
        else
          if ((IntToStr(VpfDRegistroC170.CFOP)[1] in ['1','2','3']) or
             (VpfDRegistroC170.CFOP = 5605)) and
           (VpfDRegistroC170.CFOP <> 1605)  then
          VpaDSped.RegistroE520.VL_CRED_IPI := VpaDSped.RegistroE520.VL_CRED_IPI + VpfDRegistroC170.VL_IPI
      end;
    end
  end;
  if ((VpaDSped.RegistroE520.VL_DEB_IPI + VpaDSped.RegistroE520.VL_OD_IPI) - (VpaDSped.RegistroE520.VL_CRED_IPI + VpaDSped.RegistroE520.VL_OC_IPI)) <0  then
    VpaDSped.RegistroE520.VL_SC_IPI := (((VpaDSped.RegistroE520.VL_DEB_IPI + VpaDSped.RegistroE520.VL_OD_IPI) - (VpaDSped.RegistroE520.VL_CRED_IPI + VpaDSped.RegistroE520.VL_OC_IPI))*-1)
  else
    VpaDSped.RegistroE520.VL_SD_IPI := ((VpaDSped.RegistroE520.VL_DEB_IPI + VpaDSped.RegistroE520.VL_OD_IPI) - (VpaDSped.RegistroE520.VL_CRED_IPI + VpaDSped.RegistroE520.VL_OC_IPI));
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CorrigeBaseCalculoNotaEntrada(VpaDSped: TRBDSpedFiscal; VpaBarraStatus: TStatusBar);
Var
  VpfFunNotaFor : TFuncoesNFFor;
  VpfDNotaFor : TRBDNotaFiscalFor;
begin
  VpfFunNotaFor := TFuncoesNFFor.criar(nil,VprBaseDados);
  LocalizaNotasFiscaisEntradaRegC100(Tabela,VpaDSped);
  while not Tabela.Eof do
  begin
    VpfDNotaFor :=  TRBDNotaFiscalFor.cria;
    VpfDNotaFor.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfDNotaFor.SeqNota := Tabela.FieldByName('I_SEQ_NOT').AsInteger;
    VpfFunNotaFor.CarDNotaFor(VpfDNotaFor);
    VpfFunNotaFor.CalculaNota(VpfDNotaFor);
    VpfFunNotaFor.GravaDNotaFor(VpfDNotaFor);
    VpfDNotaFor.Free;
    Tabela.Next;
  end;
  VpfFunNotaFor.Free;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CorrigeBaseCalculoNotaSaida(VpaDSped: TRBDSpedFiscal; VpaBarraStatus: TStatusBar);
Var
  VpfDNota : TRBDNotaFiscal;
  VpfDCliente : TRBDCliente;
  VpfResultado : String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select CAD.I_EMP_FIL, CAD.I_SEQ_NOT, CAD.I_COD_CLI ' +
                               ' FROM CADNOTAFISCAIS CAD ' +
                               ' WHERE I_EMP_FIL = '+ IntToStr(VpaDSped.CodFilial)+
                               ' AND I_NRO_NOT = '+IntToStr(VpaDSped.NumNota) +
                               ' order by D_DAT_EMI');
  VpfDNota := TRBDNotaFiscal.cria;
  FunNotaFiscal.CarDNotaFiscal(VpfDNota,Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_SEQ_NOT').AsInteger);
  VpfDCliente := TRBDCliente.cria;
  VpfDCliente.CodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
  FunClientes.CarDCliente(VpfDCliente);
  FunNotaFiscal.CalculaValorTotal(VpfDNota,VpfDCliente);

  VpfResultado := FunNotaFiscal.GravaDNotaFiscal(VpfDNota);
  if VpfResultado <> '' then
    aviso(VpfResultado);
  VpfDNota.Free;
  VpfDCliente.Free;

end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CorrigeNotaLimpaIPI(VpaDSped: TRBDSpedFiscal; VpaBarraStatus: TStatusBar);
var
  VpfBaseCalculoICMS, VpfValICMS : Double;
begin
  VprBarraStatus :=  VpaBarraStatus;
  AtualizaStatus('Carregando os dados da filial');
  AdicionaSQLAbreTabela(Tabela,'Select * from CADNOTAFISCAIS '+
                              ' Where ' + SQLTextoDataEntreAAAAMMDD('D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,false)+
                              ' and I_EMP_FIL = '+ IntToStr(VpaDSped.CodFilial)+
                              ' and c_not_can = ''N'''+
                              ' ORDER BY I_NRO_NOT');
  while not Tabela.Eof do
  begin
    AdicionaSQLAbreTabela(Tabela2,'Select * from MOVNOTASFISCAIS '+
                                 ' Where I_EMP_FIL = '+Tabela.FieldByName('I_EMP_FIL').AsString+
                                 ' AND I_SEQ_NOT = ' +Tabela.FieldByName('I_SEQ_NOT').AsString );
    AtualizaStatus('Corrigindo nota fiscal Saida - Limpando IPI "'+Tabela.FieldByName('I_NRO_NOT').AsString+'"');
    while not tabela2.Eof do
    begin
      Tabela2.Edit;
      Tabela2.FieldByName('N_PER_IPI').clear;
      Tabela2.FieldByName('N_VLR_IPI').clear;
      Tabela2.Post;
      Tabela2.Next;
    end;
    Tabela.Edit;
    Tabela.FieldByName('N_TOT_IPI').clear;
    Tabela.Post;
    Tabela.Next;
  end;
  AtualizaStatus('Notas corrigidas com sucesso');

  tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.CorrigeNotasValICMSeST(VpaDSped: TRBDSpedFiscal; VpaBarraStatus: TStatusBar);
var
  VpfBaseCalculoICMS, VpfValICMS : Double;
begin
  VprBarraStatus :=  VpaBarraStatus;
  AtualizaStatus('Carregando os dados da filial');
  AdicionaSQLAbreTabela(Tabela,'Select * from CADNOTAFISCAIS '+
                              ' Where ' + SQLTextoDataEntreAAAAMMDD('D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,false)+
                              ' and I_EMP_FIL = '+ IntToStr(VpaDSped.CodFilial)+
                              ' and c_not_can = ''N'''+
                              ' ORDER BY I_NRO_NOT');
  while not Tabela.Eof do
  begin
    AdicionaSQLAbreTabela(Tabela2,'Select * from MOVNOTASFISCAIS '+
                                 ' Where I_EMP_FIL = '+Tabela.FieldByName('I_EMP_FIL').AsString+
                                 ' AND I_SEQ_NOT = ' +Tabela.FieldByName('I_SEQ_NOT').AsString );
    AtualizaStatus('Corrigindo nota fiscal Saida- Recalculando ICMS "'+Tabela.FieldByName('I_NRO_NOT').AsString+'"');
    VpfBaseCalculoICMS :=0;
    VpfValICMS :=0;
    while not tabela2.Eof do
    begin
      Tabela2.Edit;
      if Tabela2.FieldByName('I_COD_CFO').AsInteger = 5405 then
      Begin
        Tabela2.FieldByName('C_COD_CST').AsString := '060';
        Tabela2.FieldByName('N_PER_ICM').Asfloat := 0;
      End
      else
        if (Tabela2.FieldByName('I_COD_CFO').AsInteger = 5102)or
           (Tabela2.FieldByName('I_COD_CFO').AsInteger = 5101)or
           (Tabela2.FieldByName('I_COD_CFO').AsInteger = 6101)or
           (Tabela2.FieldByName('I_COD_CFO').AsInteger = 6102) then
        begin
          Tabela2.FieldByName('C_COD_CST').AsString := '000';
          VpfBaseCalculoICMS := VpfBaseCalculoICMS + Tabela2.FieldByName('N_TOT_PRO').AsFloat;
          VpfValICMS := VpfValICMS + (Tabela2.FieldByName('N_TOT_PRO').AsFloat * (Tabela2.FieldByName('N_PER_ICM').AsFloat/100));
        end;
      Tabela2.Post;
      Tabela2.Next;
    end;
    Tabela.Edit;
    Tabela.FieldByName('N_BAS_CAL').AsFloat := VpfBaseCalculoICMS;
    Tabela.FieldByName('N_VLR_ICM').AsFloat := VpfValICMS;
    Tabela.Post;
    Tabela.Next;
  end;
  AtualizaStatus('Notas corrigidas com sucesso');

  tabela.Close;
end;

{********************************************************************************}
constructor TRBFuncoesSpedFiscal.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  VprBaseDados := VpaBaseDados;
  Tabela :=  TSQL.create(nil);
  Tabela.ASQlConnection := VpaBaseDados;
  Tabela2 :=  TSQL.create(nil);
  Tabela2.ASQlConnection := VpaBaseDados;
  Tabela3 :=  TSQL.create(nil);
  Tabela3.ASQlConnection := VpaBaseDados;
end;

{********************************************************************************}
function TRBFuncoesSpedFiscal.DadosValidos(VpaDSped: TRBDSpedFiscal): string;
begin
  result := '';
  if VpaDSped.DFilial.CodIBGEMunicipio = 0 then
    VpaDSped.Incosistencias.add('CODIGO IBGE EMITENTE NÃO PREENCHIDO!!!'#13'É necessário corrigir o cadastro da FILIAL para associar o codigo IBGE.');
  if VpaDSped.DFilial.DesPerfilSpedFiscal = '' then
    VpaDSped.Incosistencias.add('PERFIL DE APRESENTAÇÃO DO ARQUIVO FISCAL NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais nas página Sped Fiscal e preencher o perfil da filial.');
  if VpaDSped.DFilial.CodContabilidade = 0 then
    VpaDSped.Incosistencias.add('CONTABILISTA NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais na pagina Sped Fiscal e preencher o contabilista da filial');
  if VpaDSped.DFilial.DesCPFContador = '' then
    VpaDSped.Incosistencias.add('CPF CONTABILISTA NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais na pagina Sped Fiscal e preencher o CPF do contabilista');
  if VpaDSped.DFilial.DesCRCContador = '' then
    VpaDSped.Incosistencias.add('CRC CONTABILISTA NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais na pagina Sped Fiscal e preencher o CRC do contabilista');
  if VpaDSped.DFilial.NomContador = '' then
    VpaDSped.Incosistencias.add('NOME DO CONTABILISTA NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais na pagina Sped Fiscal e preencher o CRC do contabilista');

  AtualizaStatus('Validando os dados dos participantes');
  DadosValidosParticipantesREG0150(VpaDSped);
  AtualizaStatus('Validando os dados dos produtos');
  DadosValidosProdutosREG0200(VpaDSped);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.DadosValidosParticipantesREG0150(VpaDSped: TRBDSpedFiscal);
begin
  LocalizaParticipantesREG0150(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    if Tabela.FieldByName('I_COD_PAI').AsInteger = 0 then
      VpaDSped.Incosistencias.add('CLIENTE INVÁLIDO "'+Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString+'" - Falta o codigo IBGE do pais');
    if (Tabela.FieldByName('I_COD_IBG').AsInteger = 0) and
       (Tabela.FieldByName('C_TIP_PES').AsString <> 'E') then
      VpaDSped.Incosistencias.add('CLIENTE INVÁLIDO "'+Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString+'" - Falta o codigo IBGE do municipio');
    if Tabela.FieldByName('C_TIP_PES').AsString = 'F' then
    begin
      if not VerificaCPF(Tabela.FieldByName('C_CPF_CLI').AsString) then
        VpaDSped.Incosistencias.add('CLIENTE INVÁLIDO "'+Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString+'" - CPF INVALIDO');
    end
    else
      if Tabela.FieldByName('C_TIP_PES').AsString = 'J' then
      begin
        if not VerificaCGC(Tabela.FieldByName('C_CGC_CLI').AsString) then
          VpaDSped.Incosistencias.add('CLIENTE INVÁLIDO "'+Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString+'" - CGC INVALIDO');
      end;
    if Tabela.FieldByName('C_END_CLI').AsString = '' then
      VpaDSped.Incosistencias.add('CLIENTE INVÁLIDO "'+Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString+'" - Endereco não preenchido');
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.DadosValidosProdutosREG0200(VpaDSped: TRBDSpedFiscal);
begin
  LocalizaProdutosREG0200(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    if Tabela.FieldByName('C_CLA_FIS').AsString = '' then
      VpaDSped.Incosistencias.add('PRODUTO INVÁLIDO "'+Tabela.FieldByName('C_COD_PRO').AsString+'-'+Tabela.FieldByName('C_NOM_PRO').AsString+'" - Falta o codigo NCM/Classificação fiscal')
    else
      if length(Deletachars(Tabela.FieldByName('C_CLA_FIS').AsString,'.')) <> 8 then
        VpaDSped.Incosistencias.add('PRODUTO INVÁLIDO "'+Tabela.FieldByName('C_COD_PRO').AsString+'-'+Tabela.FieldByName('C_NOM_PRO').AsString+'" - O tamanho do codigo NCM/Classificação fiscal é diferente de 8 caracteres');
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
destructor TRBFuncoesSpedFiscal.destroy;
begin
  Tabela.close;
  Tabela.free;
  Tabela2.close;
  Tabela2.free;
  Tabela3.close;
  Tabela3.free;
  inherited;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0000(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : string;
begin
  VpfLinha :='|'+
  //01 REG
    '0000|'+
  //02 COD_VER
  '004|';

  //03 COD_FIN
  case VpaDSped.CodFinalidade of
    cfRemessaOriginal: VpfLinha := VpfLinha + '0|';
    cfRemessaSubtituto: VpfLinha := VpfLinha + '1|';
  end;
  VpfLinha :=  VpfLinha +
  //04 DT_INI
  FormatDateTime('DDMMYYYY',VpaDSped.DatInicio)+'|'+
  //05 DT_FIM
  FormatDateTime('DDMMYYYY',VpaDSped.DatFinal)+'|'+
  //06 NOME
  VpaDSped.DFilial.NomFilial+'|'+
  //07 CNPJ
  DeletaChars(DeletaChars(DeletaChars(VpaDSped.DFilial.DesCNPJ,'/'),'.'),'-')+'|'+
  //08 CPF
  '|'+
  //09 UF
  VpaDSped.DFilial.DesUF+'|'+
  //10 IE
  DeletaChars(DeletaChars(VpaDSped.DFilial.DesInscricaoEstadual,'.'),'-')+'|'+
  //11 COD_MUN
  IntToStr(VpaDSped.DFilial.CodIBGEMunicipio)+'|'+
  //12 IM
  VpaDSped.DFilial.DesInscricaoMunicipal+'|'+
  //13 SUFRAMA
  '|'+
  //14 IND_PERFIL
  VpaDSped.DFilial.DesPerfilSpedFiscal+'|'+
  //15 IND_ATIV
  IntToStr(VpaDSped.DFilial.CodAtividadeSpedFiscal)+'|';
  VpaDSped.Arquivo.Add(VpfLinha);
  inc(VpaDSped.QtdLinhasBloco0);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|0001|0|');
  inc(VpaDSped.QtdLinhasBloco0);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0005(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : string;
begin
  VpfLinha := '|'+
  //01 REG
  '0005|'+
  //02 FANTASIA
  DeletaEspacoDE(VpaDSped.DFilial.NomFantasia)+'|'+
  //03 CEP
  AdicionaCharE('0',DeletaChars(VpaDSped.DFilial.DesCep,'-'),8)+ '|'+
  //04 END
  VpaDSped.DFilial.DesEnderecoSemNumero+'|'+
  //05 NUM
  IntToStr(VpaDSped.DFilial.NumEndereco)+'|'+
  //06 COMPL
  '|'+
  //07 BAIRRO
  VpaDSped.DFilial.DesBairro+'|'+
  //08 FONE
  DeletaCharE(DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaDSped.DFilial.DesFone,'('),')'),'*'),'-'),'0')+'|'+
  //09 FAX
  DeletaCharE(DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaDSped.DFilial.DesFax,'('),')'),'*'),'-'),'0')+'|'+
  //10 email
  VpaDSped.DFilial.DesEmail+'|';
  VpaDSped.Arquivo.Add(VpfLinha);
  inc(VpaDSped.QtdLinhasBloco0);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0100(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : string;
begin
  VpfLinha := '|'+
  //01 REG
  '0100|'+
  //02 NOME
  VpaDSped.DFilial.NomContador+'|'+
  //03 CPF
  DeletaChars(DeletaChars(VpaDSped.DFilial.DesCPFContador,'.'),'-')+'|'+
  //04 CRC
  VpaDSped.DFilial.DesCRCContador+'|'+
  //05 CNPJ
  DeletaChars(DeletaChars(DeletaChars(VpaDSped.DContabilidade.CGC_CPF,'.'),'/'),'-')+'|'+
  //06 CEP
  AdicionaCharE('0',DeletaChars(VpaDSped.DContabilidade.CepCliente,'-'),8)+ '|'+
  //07 END
  VpaDSped.DContabilidade.DesEndereco+'|'+
  //08 NUM
  VpaDSped.DContabilidade.NumEndereco+'|'+
  //09 COMPL
  VpaDSped.DContabilidade.DesComplementoEndereco+ '|'+
  //10 BAIRRO
  VpaDSped.DContabilidade.DesBairro+'|'+
  //11 FONE
  DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaDSped.DContabilidade.DesFone1,'('),')'),'*'),'-')+'|'+
  //12 FAX
  DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaDSped.DContabilidade.DesFax,'('),')'),'*'),'-')+'|'+
  //13 email
  VpaDSped.DContabilidade.DesEmail+'|'+
  //14 COD_MUN
  IntToStr(VpaDSped.DContabilidade.CodIBGECidade) +'|';
  VpaDSped.Arquivo.Add(VpfLinha);
  inc(VpaDSped.QtdLinhasBloco0);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0150(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : String;
begin
  LocalizaParticipantesREG0150(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    VpfLinha := '|'+
    //01 REG
    '0150|'+
    //02 COD_PART
    Tabela.FieldByName('I_COD_CLI').AsString+'|'+
    //03 nome
    DeletaEspacoDE(Tabela.FieldByName('C_NOM_CLI').AsString)+'|'+
    //04 COD_PAIS
    AdicionaCharE('0',Tabela.FieldByName('I_COD_PAI').AsString,5)+'|'+
    //05 CNPJ
    DeletaChars(DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_CGC_CLI').AsString,'.'),'-'),'/'),' ') +'|'+
    //06 CPF
    DeletaEspaco(DeletaChars(DeletaChars(Tabela.FieldByName('C_CPF_CLI').AsString,'.'),'-')) +'|';
    //07 IE
    if DeletaEspaco(Tabela.FieldByName('C_INS_CLI').AsString) <> 'ISENTO' then
      VpfLinha := VpfLinha + DeletaEspaco(DeletaChars(DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_INS_CLI').AsString,'.'),'-'),'/'),',')) +'|'
    else
      VpfLinha := VpfLinha + '|';

    //08 COD_MUN
    if (Tabela.FieldByName('C_TIP_PES').AsString = 'E') then
      VpfLinha :=  VpfLinha +'|'
    else
      VpfLinha := VpfLinha + Tabela.FieldByName('I_COD_IBG').AsString+'|';

    VpfLinha := VpfLinha +
    //09 SUFRAMA
    '|'+
    //10 END
    DeletaEspacoDE(Tabela.FieldByName('C_END_CLI').AsString)+'|'+
    //11 END
    Tabela.FieldByName('I_NUM_END').AsString+'|'+
    //12 COMPL
    DeletaEspacoDE(Tabela.FieldByName('C_COM_END').AsString)+'|'+
    //13 BAIRRO
    DeletaEspacoDE(Tabela.FieldByName('C_BAI_CLI').AsString)+'|';

    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    inc(VpaDSped.QtdLinhasRegistro0150);
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0190(VpaDSped: TRBDSpedFiscal);
Var
  vpfLinha : String;
begin
  LocalizaUnidadesMedidasREG0190(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    VpfLinha := '|'+
    //01REG
    '0190|'+
    //02 UNID
    Tabela.FieldByName('C_COD_UNI').AsString+'|'+
    //03 DESCRI
    Tabela.FieldByName('C_NOM_UNI').AsString+'|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    inc(VpaDSped.QtdLinhasRegistro0190);
    Tabela.next;
  end;
{  LocalizaProdutosREG0200Servicos(Tabela,VpaDSped);
  if not Tabela.Eof then//existe servico
  begin
    VpfLinha := '|'+
    //01REG
    '0190|'+
    //02 UNID
    'SE|'+
    //03 DESCRI
    'SERVICO|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    inc(VpaDSped.QtdLinhasRegistro0190);
  end;}
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0200(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : String;
begin
  LocalizaProdutosREG0200(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    VpfLinha := '|'+
    //01 REG
    '0200|' +
    //02 COD_ITEM
    Tabela.FieldByName('I_SEQ_PRO').AsString+'|'+
    //03 DESCR_ITEM
    DeletaChars(DeletaEspacoDE(Tabela.FieldByName('C_NOM_PRO').AsString),'*')+'|'+
    //04 COD_BARRAS
    '|'+
    //05 COD_ANT_ITEM
    '|'+
    //06 UNID_INV
    Tabela.FieldByName('C_COD_UNI').AsString+'|'+
    //07 TIPO_ITEM
    AdicionaCharE('0',Tabela.FieldByName('I_DES_PRO').AsString,2)+'|'+
    //08 CODIGO NCM
    DeletaChars(Tabela.FieldByName('C_CLA_FIS').AsString,'.')+'|'+
    //09 EX_IPI
    '|'+
    //10 COD_GEN - SAO OS 2 PRIMEIROS CARACTERES DO CODIGO NCM
    copy(Tabela.FieldByName('C_CLA_FIS').AsString,1,2)+ '|'+
    //11 COD_LST
    '|';
    if Tabela.FieldByName('N_RED_ICM').AsFloat <> 0 then
      VpfLinha := VpfLinha + Tabela.FieldByName('N_RED_ICM').Asstring+'|'
    else
      VpfLinha := VpfLinha +FormatFloat('0.00',VpaDSped.PerICMSInterno)  +'|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    inc(VpaDSped.QtdLinhasRegistro0200);
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0200Servicos(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : String;
begin
  exit;
  LocalizaProdutosREG0200Servicos(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    VpfLinha := '|'+
    //01 REG
    '0200|' +
    //02 COD_ITEM
    'SE'+Tabela.FieldByName('I_COD_SER').AsString+'|'+
    //03 DESCR_ITEM
    DeletaChars(DeletaEspacoDE(Tabela.FieldByName('C_NOM_SER').AsString),'*')+'|'+
    //04 COD_BARRAS
    '|'+
    //05 COD_ANT_ITEM
    '|'+
    //06 UNID_INV
    'SE|'+
    //07 TIPO_ITEM
    '09|'+
    //08 CODIGO NCM
    '|'+
    //09 EX_IPI
    '|'+
    //10 COD_GEN - SAO OS 2 PRIMEIROS CARACTERES DO CODIGO NCM
    '|'+
    //11 COD_LST
    Tabela.FieldByName('I_COD_FIS').Asstring+'|'+
    //12 ALIQ_ICMS
    '|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    inc(VpaDSped.QtdLinhasRegistro0200);
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0400(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : string;
begin
  LocalizaNaturezaOperacaoREG0400(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    VpfLinha := '|'+
    //01 REG
    '0400|' +
    //02 COD_NAT
    Tabela.FieldByName('C_COD_NAT').AsString+Tabela.FieldByName('I_SEQ_MOV').AsString+ '|'+
    //03 DESCR_NAT
    DeletaEspacoDE(Tabela.FieldByName('C_NOM_MOV').AsString)+'|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    inc(VpaDSped.QtdLinhasRegistro0400);
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0450(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : string;
  VpfDRegistro0450 : TRBDSpedFiscalRegistro0450;
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDSped.Registros0450.Count - 1 do
  begin
    VpfDRegistro0450 := TRBDSpedFiscalRegistro0450(VpaDSped.Registros0450.Items[VpfLaco]);
    VpfLinha := '|'+
    //01 REG
    '0450|' +
    //02  COD_INF
    IntToStr(VpfDRegistro0450.CodInformacao)+ '|'+
    //03 TXT
    VpfDRegistro0450.DesInformacao+'|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    inc(VpaDSped.QtdLinhasRegistro0450);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBloco0);
  VpaDSped.Arquivo.Add('|0990|'+IntToStr(VpaDSped.QtdLinhasBloco0)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco9Registro9001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|9001|0|');
  inc(VpaDSped.QtdLinhasBloco9);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco9Registro9900(VpaDSped: TRBDSpedFiscal);
Var
  VpfLinhaInicial : Integer;
begin
  VpfLinhaInicial := VpaDSped.Arquivo.Count;
  VpaDSped.Arquivo.Add('|9900|0000|1|');
  VpaDSped.Arquivo.Add('|9900|0001|1|');
  VpaDSped.Arquivo.Add('|9900|0005|1|');
  VpaDSped.Arquivo.Add('|9900|0100|1|');
  VpaDSped.Arquivo.Add('|9900|0150|'+IntToStr(VpaDSped.QtdLinhasRegistro0150)+'|');
  VpaDSped.Arquivo.Add('|9900|0190|'+IntToStr(VpaDSped.QtdLinhasRegistro0190)+'|');
  VpaDSped.Arquivo.Add('|9900|0200|'+IntToStr(VpaDSped.QtdLinhasRegistro0200)+'|');
  VpaDSped.Arquivo.Add('|9900|0400|'+IntToStr(VpaDSped.QtdLinhasRegistro0400)+'|');
  VpaDSped.Arquivo.Add('|9900|0450|'+IntToStr(VpaDSped.QtdLinhasRegistro0450)+'|');
  VpaDSped.Arquivo.Add('|9900|0990|1|');
  VpaDSped.Arquivo.Add('|9900|C001|1|');
  VpaDSped.Arquivo.Add('|9900|C100|'+IntToStr(VpaDSped.QtdLinhasRegistroC100)+'|');
  VpaDSped.Arquivo.Add('|9900|C110|'+IntToStr(VpaDSped.QtdLinhasRegistroC110)+'|');
  VpaDSped.Arquivo.Add('|9900|C140|'+IntToStr(VpaDSped.QtdLinhasRegistroC140)+'|');
  VpaDSped.Arquivo.Add('|9900|C141|'+IntToStr(VpaDSped.QtdLinhasRegistroC141)+'|');
  VpaDSped.Arquivo.Add('|9900|C160|'+IntToStr(VpaDSped.QtdLinhasRegistroC160)+'|');
  VpaDSped.Arquivo.Add('|9900|C170|'+IntToStr(VpaDSped.QtdLinhasRegistroC170)+'|');
  VpaDSped.Arquivo.Add('|9900|C190|'+IntToStr(VpaDSped.QtdLinhasRegistroC190)+'|');
  VpaDSped.Arquivo.Add('|9900|C300|'+IntToStr(VpaDSped.QtdLinhasRegistroC300)+'|');
  VpaDSped.Arquivo.Add('|9900|C320|'+IntToStr(VpaDSped.QtdLinhasRegistroC320)+'|');
  VpaDSped.Arquivo.Add('|9900|C321|'+IntToStr(VpaDSped.QtdLinhasRegistroC321)+'|');
  VpaDSped.Arquivo.Add('|9900|C400|'+IntToStr(VpaDSped.QtdLinhasRegistroC400)+'|');
  VpaDSped.Arquivo.Add('|9900|C405|'+IntToStr(VpaDSped.QtdLinhasRegistroC405)+'|');
  VpaDSped.Arquivo.Add('|9900|C420|'+IntToStr(VpaDSped.QtdLinhasRegistroC420)+'|');
  VpaDSped.Arquivo.Add('|9900|C425|'+IntToStr(VpaDSped.QtdLinhasRegistroC425)+'|');
  VpaDSped.Arquivo.Add('|9900|D001|1|');
  VpaDSped.Arquivo.Add('|9900|D100|'+IntToStr(VpaDSped.QtdLinhasRegistroD100)+'|');
  VpaDSped.Arquivo.Add('|9900|D990|1|');
  VpaDSped.Arquivo.Add('|9900|E116|'+IntToStr(VpaDSped.QtdLinhasRegistroE116)+'|');
  VpaDSped.Arquivo.Add('|9900|E500|1|');
  VpaDSped.Arquivo.Add('|9900|E510|'+IntToStr(VpaDSped.QtdLinhasRegistroE510)+'|');
  VpaDSped.Arquivo.Add('|9900|E520|1|');
  VpaDSped.Arquivo.Add('|9900|C990|1|');
  VpaDSped.Arquivo.Add('|9900|E001|1|');
  VpaDSped.Arquivo.Add('|9900|E100|1|');
  VpaDSped.Arquivo.Add('|9900|E110|1|');
  VpaDSped.Arquivo.Add('|9900|E990|1|');
  VpaDSped.Arquivo.Add('|9900|G001|1|');
  VpaDSped.Arquivo.Add('|9900|G990|1|');
  VpaDSped.Arquivo.Add('|9900|H001|1|');
  VpaDSped.Arquivo.Add('|9900|H990|1|');
  VpaDSped.Arquivo.Add('|9900|1001|1|');
  VpaDSped.Arquivo.Add('|9900|1990|1|');
  VpaDSped.Arquivo.Add('|9900|9001|1|');
  VpaDSped.QtdLinhasBloco9 := VpaDSped.Arquivo.Count - VpfLinhaInicial+3;
  VpaDSped.Arquivo.Add('|9900|9900|'+Inttostr(VpaDSped.QtdLinhasBloco9)+'|');
  VpaDSped.Arquivo.Add('|9900|9990|1|');
  VpaDSped.Arquivo.Add('|9900|9999|1|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco9Registro9990(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|9990|'+IntToStr(VpaDSped.QtdLinhasBloco9+3)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco9Registro9999(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|9999|'+IntToStr(VpaDSped.Arquivo.Count +1)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|C001|0|');
  inc(VpaDSped.QtdLinhasBlocoC);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.CarregaBlocoCRegistroC100Entrada(VpaDSped: TRBDSpedFiscal);
Var
  VpfLinha : String;
  VpfIndPagamentoAVista : Boolean;
  VpfRegistroC100 : TRBDspedFiscalRegistroC100;
begin
  LocalizaNotasFiscaisEntradaRegC100(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    AtualizaStatus('Gerando Bloco C registro C100 Entrada - Nota Fiscal "'+    Tabela.FieldByName('I_NRO_NOT').AsString+'"');
    VpfRegistroC100 := VpaDSped.addRegistrC100;
    VpfRegistroC100.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfRegistroC100.SeqNota := Tabela.FieldByName('I_SEQ_NOT').AsInteger;
    FunNotaFiscal.CarDNaturezaOperacao(VpfRegistroC100.DNatureza,Tabela.FieldByName('C_COD_NAT').AsString,Tabela.FieldByName('I_SEQ_NAT').AsInteger);
    VpfRegistroC100.DCliente.CodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
    FunClientes.CarDCliente(VpfRegistroC100.DCliente);
    VpfRegistroC100.IND_OPER := ioEntrada;
    VpfRegistroC100.IND_EMIT := ieTerceiros;
    VpfRegistroC100.COD_PART := Tabela.FieldByName('I_COD_CLI').AsInteger;
    if Tabela.FieldByName('C_MOD_DOC').AsString = '01' then
      VpfRegistroC100.COD_MOD := cmModelo1ou1A
    else
      if Tabela.FieldByName('C_MOD_DOC').AsString = '55' then
        VpfRegistroC100.COD_MOD := cmNfe;
    VpfRegistroC100.COD_SIT := csDocumentoRegular;
    VpfRegistroC100.SER := Tabela.FieldByName('C_SER_NOT').AsString;
    VpfRegistroC100.NUM_DOC := Tabela.FieldByName('I_NRO_NOT').AsInteger;
    VpfRegistroC100.CHV_NFE := '';
    VpfRegistroC100.DT_DOC := Tabela.FieldByName('D_DAT_EMI').AsDatetime;
    VpfRegistroC100.DT_E_S := Tabela.FieldByName('D_DAT_REC').AsDatetime;
    VpfRegistroC100.VL_DOC := Tabela.FieldByName('N_TOT_NOT').AsFloat;
    if Tabela.FieldByName('C_GER_FIN').AsString = 'S' then
    begin
      if Tabela.FieldByName('I_COD_PAG').AsInteger = varia.CondPagtoVista then
        VpfRegistroC100.IND_PAGTO := ipAVista
      else
        VpfRegistroC100.IND_PAGTO := ipAPrazo;
    end
    else
      VpfRegistroC100.IND_PAGTO := ipSemPagamento;

    if (Tabela.FieldByName('N_PER_DES').AsFloat > 0) then
      VpfRegistroC100.VL_DESC := ((Tabela.FieldByName('N_TOT_PRO').AsFloat)*Tabela.FieldByName('N_PER_DES').AsFloat)/100
    else
      if (Tabela.FieldByName('N_VLR_DES').AsFloat > 0) then
        VpfRegistroC100.VL_DESC := Tabela.FieldByName('N_VLR_DES').AsFloat
      else
        VpfRegistroC100.VL_DESC :=0;
    VpfRegistroC100.VL_ABAT_NT := 0;
    VpfRegistroC100.VL_MERC := Tabela.FieldByName('N_TOT_PRO').AsFloat;
    if Tabela.FieldByName('N_VLR_FRE').AsFloat > 0 then
    begin
      case Tabela.FieldByName('I_TIP_FRE').AsInteger of
        1 : VpfRegistroC100.IND_FRT := ifPorContadoEmitente;
        2 : VpfRegistroC100.IND_FRT := ifPorContadoDestinatario;
      end;
    end
    else
      VpfRegistroC100.IND_FRT := ifSemCobrancafrete;
    VpfRegistroC100.VL_FRT := Tabela.FieldByName('N_VLR_FRE').AsFloat;
    VpfRegistroC100.VL_SEG := Tabela.FieldByName('N_VLR_SEG').AsFloat;
    if (Tabela.FieldByName('N_PER_DES').AsFloat < 0) then
      VpfRegistroC100.VL_OUT_DA := (((Tabela.FieldByName('N_TOT_PRO').AsFloat)*(Tabela.FieldByName('N_PER_DES').AsFloat*-1))/100)+Tabela.FieldByName('N_OUT_DES').AsFloat
    else
      if (Tabela.FieldByName('N_VLR_DES').AsFloat < 0) then
        VpfRegistroC100.VL_OUT_DA := (Tabela.FieldByName('N_VLR_DES').AsFloat*-1)+Tabela.FieldByName('N_OUT_DES').AsFloat
      else
        VpfRegistroC100.VL_OUT_DA := Tabela.FieldByName('N_OUT_DES').AsFloat;
    VpfRegistroC100.VL_BC_ICMS := Tabela.FieldByName('N_BAS_CAL').AsFloat;
    VpfRegistroC100.VL_ICMS := Tabela.FieldByName('N_VLR_ICM').AsFloat;
    VpfRegistroC100.VL_BC_ICMS_ST := Tabela.FieldByName('N_BAS_SUB').AsFloat;
    VpfRegistroC100.VL_ICMS_ST := Tabela.FieldByName('N_VLR_SUB').AsFloat;
    VpfRegistroC100.VL_IPI := Tabela.FieldByName('N_TOT_IPI').AsFloat;
    VpfRegistroC100.VL_PIS := (Tabela.FieldByName('N_TOT_NOT').AsFloat * varia.PerPIS)/100;
    VpfRegistroC100.VL_COFINS := (Tabela.FieldByName('N_TOT_NOT').AsFloat * varia.PerCOFINS)/100;
    VpfRegistroC100.VL_PIS_ST := 0;
    VpfRegistroC100.VL_COFINS_ST := 0;
    Tabela.next;
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC100(VpaDSped: TRBDSpedFiscal);
Var
  VpfLinha : String;
  VpfLaco : Integer;
  VpfDRegistroC100 : TRBDspedFiscalRegistroC100;
begin
  for VpfLaco := 0 to VpaDSped.RegistrosC100.Count - 1 do
  begin
    VpfDRegistroC100 := TRBDspedFiscalRegistroC100(VpaDSped.RegistrosC100.Items[VpfLaco]);
    AtualizaStatus('Gerando Bloco C registro C100 - Nota Fiscal "'+    IntToStr(VpfDRegistroC100.NUM_DOC)+'"');
    VpfLinha := '|'+
    //01 REG
    'C100|';
    //02 IND_OPER
    case VpfDRegistroC100.IND_OPER of
      ioEntrada: VpfLinha := VpfLinha +'0|';
      ioSaida: VpfLinha := VpfLinha +'1|';
    end;
    //03 IND_EMIT
    case VpfDRegistroC100.IND_EMIT of
      ieEmissaoPropria:VpfLinha := VpfLinha + '0|';
      ieTerceiros: VpfLinha := VpfLinha + '1|' ;
    end;
    //04 COD_PART
    if VpfDRegistroC100.COD_SIT = csCancelado then
      VpfLinha := VpfLinha +'|'
    else
      VpfLinha := VpfLinha +IntToStr(VpfDRegistroC100.COD_PART)+'|';
    //05 COD_MOD
    case VpfDRegistroC100.COD_MOD of
      cmModelo1ou1A: VpfLinha := vpflinha+'01|' ;
      cmNfe:VpfLinha := vpflinha+ '55|';
    end;

    //06 COD_SIT
    case VpfDRegistroC100.COD_SIT of
      csDocumentoRegular: VpfLinha := VpfLinha +'00|';
      csEscrituracaoExtemporaneaRegular: VpfLinha := VpfLinha +'01|';
      csCancelado: VpfLinha := VpfLinha +'02|';
      csEscrituracaoExtemporaneaCancelado: VpfLinha := VpfLinha +'03|';
      csNFEouCTEDenegado: VpfLinha := VpfLinha +'04|';
      csNFEouCTENumeracaoInutilizada: VpfLinha := VpfLinha +'05|';
      csDocumentoFiscalComplentar: VpfLinha := VpfLinha +'06|';
      csEscrituracaoExtemporaneaComplentar: VpfLinha := VpfLinha +'07|';
      csDocumentoFiscalEspecial: VpfLinha := VpfLinha +'08|';
    end;
    // 07 SER
    VpfLinha := VpfLinha + VpfDRegistroC100.SER+ '|'+
    //08 NUM_DOC
    IntToStr(VpfDRegistroC100.NUM_DOC)+'|';
    if (VpfDRegistroC100.COD_SIT IN [csCancelado,csEscrituracaoExtemporaneaCancelado]) and
       (VpaDSped.DFilial.IndEmiteNFE) then
    begin
      VpfLinha := VpfLinha +
      //09 CHV_NFE
      VpfDRegistroC100.CHV_NFE+'|'+
       AdicionaCharD('|','',20);
    end
    else
    if VpfDRegistroC100.COD_SIT IN [csNFEouCTEDenegado,csNFEouCTENumeracaoInutilizada] then
      VpfLinha := VpfLinha +  AdicionaCharD('|','',21)
    else
    begin
      VpfLinha := VpfLinha +
      //09 CHV_NFE
      VpfDRegistroC100.CHV_NFE+'|'+
      //10 DT_DOC
      FormatDateTime('DDMMYYYY',VpfDRegistroC100.DT_DOC)+'|'+
      //11 DT_SAI
      FormatDateTime('DDMMYYYY', VpfDRegistroC100.DT_E_S)+'|'+
      //12 VL_DOC
      FormatFloat('0.00',VpfDRegistroC100.VL_DOC)+'|';
      //13 IND_PGTO
      case VpfDRegistroC100.IND_PAGTO of
        ipAVista: VpfLinha := VpfLinha + '0|';
        ipAPrazo: VpfLinha := VpfLinha + '1|';
        ipSemPagamento: VpfLinha := VpfLinha + '9|';
      end;
      //14 VL_DESC
      VpfLinha := VpfLinha + FormatFloat('0.00',VpfDRegistroC100.VL_DESC)+'|'+
      //15 VL_ABAT_NT
       '0,00|'+
      //16 VL_MERC
      FormatFloat('0.00',VpfDRegistroC100.VL_MERC)+'|';
      //17 IND_FRT
      case VpfDRegistroC100.IND_FRT of
        ifPorContaTerceiros: VpfLinha := VpfLinha + '0|';
        ifPorContadoEmitente: VpfLinha := VpfLinha + '1|';
        ifPorContadoDestinatario: VpfLinha := VpfLinha + '2|';
        ifSemCobrancafrete: VpfLinha := VpfLinha + '9|';
      end;
      //18 VL_FRT
      VpfLinha := VpfLinha+ FormatFloat('0.00',VpfDRegistroC100.VL_FRT)+'|'+
      //19 VL_SEG
      FormatFloat('0.00',VpfDRegistroC100.VL_SEG)+'|'+
      //20 VL_OUT_DA
      FormatFloat('0.00',VpfDRegistroC100.VL_OUT_DA)+'|'+
      //21 VL_BC_ICMS
      FormatFloat('0.00',VpfDRegistroC100.VL_BC_ICMS)+'|'+
      //22 VL_ICMS
      FormatFloat('0.00',VpfDRegistroC100.VL_ICMS)+'|'+
      //23 VL_BC_ICMS_ST
      FormatFloat('0.00',VpfDRegistroC100.VL_BC_ICMS_ST)+'|'+
      //24 VL_ICMS_ST
      FormatFloat('0.00',VpfDRegistroC100.VL_ICMS_ST)+'|'+
      //25 VL_IPI
      FormatFloat('0.00',VpfDRegistroC100.VL_IPI)+'|'+
      //26 VL_PIS
      FormatFloat('0.00',VpfDRegistroC100.VL_PIS )+'|'+
      //27 VL_COFINS
      FormatFloat('0.00',VpfDRegistroC100.VL_COFINS )+'|'+
      //28 VL_PIS_ST
      FormatFloat('0.00',VpfDRegistroC100.VL_PIS_ST)+'|'+
      //29 VL_COFINS_ST
      FormatFloat('0.00',VpfDRegistroC100.VL_COFINS_ST )+'|';
    end;

    VpaDSped.Arquivo.add(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC100);
    if not(VpfDRegistroC100.COD_SIT IN [csCancelado,csEscrituracaoExtemporaneaCancelado,csNFEouCTEDenegado,csNFEouCTENumeracaoInutilizada]) then
    begin
      if (VpfDRegistroC100.COD_MOD = cmModelo1ou1A) or (VpfDRegistroC100.IND_EMIT = ieTerceiros) then
      begin
        if (VpfDRegistroC100.COD_MOD = cmModelo1ou1A)  then
        begin
          GeraBlocoCRegistroC110(VpaDSped,VpfDRegistroC100);
          GeraBlocoCRegistroC140(VpaDSped,VpfDRegistroC100);
          GeraBlocoCRegistroC160(VpaDSped,VpfDRegistroC100);
        end;
        GeraBlocoCRegistroC170(VpaDSped,VpfDRegistroC100);
      end;

      GeraBlocoCRegistroC190(VpaDSped,VpfDRegistroC100);
    end;

  end;

end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC110(VpadSped: TRBDSpedFiscal;VpaDRegistroC100: TRBDSpedfiscalRegistroC100);
Var
  VpfLaco : Integer;
  VpfDRegistroC110 : TRBDSpedFiscalRegistroC110;
  VpfLinha : String;
begin
  AtualizaStatus('Gerando Bloco C registro C110 - Nota Fiscal "'+ IntToStr(VpaDRegistroC100.NUM_DOC) +'"');
  for VpfLaco := 0 to VpaDRegistroC100.RegistrosC110.Count -1 do
  begin
    VpfDRegistroC110 := TRBDSpedFiscalRegistroC110(VpaDRegistroC100.RegistrosC110.Items[VpfLaco]);
    VpfLinha :=
    //01 REG
    '|C110|'+
    //02 COD_INF
    IntToStr(VpfDRegistroC110.COD_INF)+'|'+
    //03 TXT_COMPL
    VpfDRegistroC110.TXT_COMPL+'|';

    VpadSped.Arquivo.Add(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC110);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC140(VpadSped: TRBDSpedFiscal;VpaDRegistroC100: TRBDSpedfiscalRegistroC100);
var
  VpfLinha : String;
begin
  if VpaDRegistroC100.RegistroC140.NUM_TIT <> '' then
  begin
    AtualizaStatus('Gerando Bloco C registro C140 - Nota Fiscal "'+ IntToStr(VpaDRegistroC100.NUM_DOC) +'"');
    VpfLinha :=
    //01 REG
    '|C140|';
    //02 IND_EMIT
    case VpaDRegistroC100.RegistroC140.IND_EMIT of
      ieEmissaoPropria: VpfLinha := VpfLinha +'0|' ;
      ieTerceiros: VpfLinha := VpfLinha +'1|' ;
    end;
    //03 IND_TIT
    case VpaDRegistroC100.RegistroC140.IND_TIT of
      itDuplicata: VpfLinha := VpfLinha +'00|';
      itCheque: VpfLinha := VpfLinha +'01|';
      itPromissoria: VpfLinha := VpfLinha +'02|';
      itRecibo: VpfLinha := VpfLinha +'03|';
      itOutros: VpfLinha := VpfLinha +'99|';
    end;
    //04 DESC_TIT
    VpfLinha := VpfLinha + VpaDRegistroC100.RegistroC140.DESC_TIT+'|'+
    //05 NUM_TIT
    VpaDRegistroC100.RegistroC140.NUM_TIT+'|'+
    //06 QTD PARC
    IntToStr(VpaDRegistroC100.RegistroC140.QTD_PARC) +'|'+
    //07 VL TIT
    FormatFloat('0.00',VpaDRegistroC100.RegistroC140.VL_TIT)+'|';

    VpadSped.Arquivo.Add(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC140);
    GeraBlocoCRegistroC141(VpadSped,VpaDRegistroC100.RegistroC140);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC141(VpaDSped : TRBDSpedFiscal;VpaDRegistroC140 : TRBDSpedfiscalRegistroC140);
Var
  VpfLaco : Integer;
  VpfDRegistroC141 : TRBDSpedFiscalRegistroC141;
  VpfLinha : String;
begin
  for VpfLaco := 0 to VpaDRegistroC140.RegistrosC141.Count - 1 do
  begin
    AtualizaStatus('Gerando Bloco C registro C141 - Duplicata "'+ VpaDRegistroC140.NUM_TIT+'"');
    VpfDRegistroC141 := TRBDSpedFiscalRegistroC141(VpaDRegistroC140.RegistrosC141.Items[VpfLaco]);
    VpfLinha :=
    //01 REG
    '|C141|'+
    //02 NUM PARC
     IntToStr(VpfDRegistroC141.NUM_PARC) +'|'+
    //03 DT_VCTO
    FormatDateTime('DDMMYYYY',VpfDRegistroC141.DT_VCTO)+'|'+
    //04 VL PARCTIT
    FormatFloat('0.00',VpfDRegistroC141.VL_PARC)+'|';

    VpadSped.Arquivo.Add(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC141);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC160(VpadSped : TRBDSpedFiscal;VpaDRegistroC100 : TRBDSpedfiscalRegistroC100);
var
  VpfLinha : String;
begin
  if (VpaDRegistroC100.IND_OPER = ioSaida) and
     (VpaDRegistroC100.RegistroC160.COD_PART <> 0)  then
  begin
    VpfLinha :=
    //01 reg
    '|C160|';
    //02 COD PART
    if VpaDRegistroC100.RegistroC160.IndTranporteProprio then
      VpfLinha := VpfLinha +  '|'
    else
      VpfLinha := VpfLinha +  IntToStr(VpaDRegistroC100.RegistroC160.COD_PART)+'|';
    //03 VEIC_ID
    VpfLinha := VpfLinha + DeletaEspaco(VpaDRegistroC100.RegistroC160.VEIC_ID)+'|'+
    //04 QTD_VOL
    FormatFloat('0',VpaDRegistroC100.RegistroC160.QTD_VOL)+'|'+
    //05 PESO_BRT
    FormatFloat('0.00',VpaDRegistroC100.RegistroC160.PESO_BRT)+'|'+
    //06 PESO_LIQ
    FormatFloat('0.00',VpaDRegistroC100.RegistroC160.PESO_LIQ)+'|'+
    //07 UF_ID
    VpaDRegistroC100.RegistroC160.UF_ID+'|';

    VpadSped.Arquivo.add(VpfLinha);
    inc(VpadSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC160);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC170(VpaDSped : TRBDSpedFiscal;VpaDRegistroC100 : TRBDspedFiscalRegistroC100);
Var
  VpfLinha : String;
  VpfLaco : Integer;
  VpfDRegistroC170 : TRBDSpedFiscalRegistroC170;
begin
  for VpfLaco := 0 to VpaDRegistroC100.RegistrosC170.Count - 1 do
  begin
    VpfDRegistroC170 := TRBDSpedFiscalRegistroC170(VpaDRegistroC100.RegistrosC170.Items[Vpflaco]);
    AtualizaStatus('Gerando Bloco C registro C170 - Nota Fiscal "'+ IntToStr(VpaDRegistroC100.NUM_DOC) +'" Produto '+VpfDRegistroC170.COD_ITEM);
    VpfLinha :=
    //01 REG
    '|C170|'+
    //02 NUM ITEM
    IntToStr(VpfDRegistroC170.NUM_ITEM) +'|'+
    //03 COD ITEM
    VpfDRegistroC170.COD_ITEM+'|'+
    //04 DESCR CMPL
    VpfDRegistroC170.DESCR_COMPL+ '|'+
    //05 QTD
    FormatFloat('0.00000',VpfDRegistroC170.QTD)+ '|'+
    //06 UNID
    VpfDRegistroC170.UNID + '|'+
    //07 VL ITEM
    FormatFloat('0.00',VpfDRegistroC170.VL_ITEM )+ '|'+
    //08 VL DESC
    FormatFloat('0.00',VpfDRegistroC170.VL_DESC)+ '|';
    //09 IND MOV
    case VpfDRegistroC170.IND_MOV of
      imSim: VpfLinha := VpfLinha +'0|' ;
      imNao: VpfLinha := VpfLinha +'1|' ;
    end;
    VpfLinha := VpfLinha +
    //10 CST_ICMS
    AdicionaCharD('0',VpfDRegistroC170.CST_ICMS,3)+'|'+
    //11 CFOP
    IntToStr(VpfDRegistroC170.CFOP)+'|'+
    //12 COD NAT
    VpfDRegistroC170.COD_NAT+'|'+
    //13 VL BC ICMS
    FormatFloat('0.00',VpfDRegistroC170.VL_BC_ICMS)+ '|'+
    //14 ALIQ ICMS
    FormatFloat('0.00',VpfDRegistroC170.ALIQ_ICMS)+ '|'+
    //15 VL ICMS
    FormatFloat('0.00',VpfDRegistroC170.VL_ICMS)+ '|'+
    //16 VL BC ICMS ST
    FormatFloat('0.00',VpfDRegistroC170.VL_BC_ICMS_ST)+ '|'+
    //17 ALIQ ICMS ST
    FormatFloat('0.00',VpfDRegistroC170.ALIQ_ST)+ '|'+
    //18 VL ICMS ST
    FormatFloat('0.00',VpfDRegistroC170.VL_ICMS_ST)+ '|';
    //19 IND APUR
    case VpfDRegistroC170.IND_APUR of
      iaMensal: VpfLinha := VpfLinha +'0|';
      iaDecendial: VpfLinha := VpfLinha +'1|';
    end;
    VpfLinha := VpfLinha +
    //20 CST IPI
    DeletaEspaco(VpfDRegistroC170.CST_IPI)+ '|'+
    //21 COD ENQ
    VpfDRegistroC170.COD_ENQ +'|'+
    //22 VL BC IPI
    FormatFloat('0.00',VpfDRegistroC170.VL_BC_IPI)+ '|'+
    //23 ALIQ IPI
    FormatFloat('0.00',VpfDRegistroC170.ALIQ_IPI)+ '|'+
    //24 VL IPI
    FormatFloat('0.00',VpfDRegistroC170.VL_IPI)+ '|'+
    //25 CST PIS
    DeletaEspaco(VpfDRegistroC170.CST_PIS)+ '|'+
    //26 VL BC PIS
    FormatFloat('0.00',VpfDRegistroC170.VL_BC_PIS)+ '|'+
    //27 ALIQ PIS
    FormatFloat('0.00',VpfDRegistroC170.ALIQ_PIS_PER)+ '|'+
    //28 QUANT BC PIS
    FormatFloat('0.00',VpfDRegistroC170.QUANT_BC_PIS)+ '|'+
    //29 ALIQ PIS
    FormatFloat('0.00',VpfDRegistroC170.ALIQ_PIS_VLR)+ '|'+
    //30 VL PIS
    FormatFloat('0.00',VpfDRegistroC170.VL_PIS)+ '|'+
    //31 CST COFINS
    DeletaEspaco(VpfDRegistroC170.CST_COFINS)+ '|'+
    //32 VL BASE COFINS
    FormatFloat('0.00',VpfDRegistroC170.VL_BC_COFINS)+ '|'+
    //33 ALIQ COFINS
    FormatFloat('0.00',VpfDRegistroC170.ALIQ_COFINS_PER)+ '|'+
    //34 QUANT BC COFINS
    FormatFloat('0.00',VpfDRegistroC170.QUANT_BC_COFINS)+ '|'+
    //35 ALIQ COFINS
    FormatFloat('0.00',VpfDRegistroC170.ALIQ_COFINS_VLR)+ '|'+
    //36 VL COFINS
    FormatFloat('0.00',VpfDRegistroC170.VL_COFINS)+ '|'+
    //37 COD CTA
    VpfDRegistroC170.COD_CTA+ '|';
    VpadSped.Arquivo.Add(VpfLinha);
    inc(VpadSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC170);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC190(VpaDSped : TRBDSpedFiscal;VpaDRegistroC100 : TRBDspedFiscalRegistroC100);
Var
  Vpflaco : integer;
  VpfDRegistroC190 : TRBDSpedfiscalRegistroC190;
  VpfLinha : String;
begin
  for vpflaco := 0 to VpaDRegistroC100.RegistrosC190.Count - 1 do
  begin
    VpfDRegistroC190 := TRBDSpedfiscalRegistroC190(VpaDRegistroC100.RegistrosC190.Items[vpfLaco]);
    AtualizaStatus('Gerando Bloco C registro C190 - Nota Fiscal "'+ IntToStr(VpaDRegistroC100.NUM_DOC) +'"');
    vpflinha :=
    //01 REG
    '|C190|'+
    //02 CST ICMS
    AdicionaCharE('0',VpfDRegistroC190.CodCST,3)+'|'+
    //03 CFOP
    AdicionaCharD('0',IntToStr(VpfDRegistroC190.CodCFOP),4)+'|'+
    //04 ALIQ ICMS
    FormatFloat('0.00',VpfDRegistroC190.PerICMS)+'|'+
    //05 VL OPR
    FormatFloat('0.00',VpfDRegistroC190.ValOperacao)+'|'+
    //06 VL BC ICMS
    FormatFloat('0.00',VpfDRegistroC190.ValBaseCalculoICMS)+'|'+
    //07 VL ICMS
    FormatFloat('0.00',VpfDRegistroC190.ValICMS)+'|'+
    //08 VL BC ICMS ST
    FormatFloat('0.00',VpfDRegistroC190.ValBaseCalculoICMSSubstituica)+'|'+
    //09 VL ICMS ST
    FormatFloat('0.00',VpfDRegistroC190.ValICMSSubstituicao)+'|'+
    //10 VL RED ICMS
    FormatFloat('0.00',VpfDRegistroC190.ValReducaBaseCalculo)+'|'+
    //11 VL IPI
    FormatFloat('0.00',VpfDRegistroC190.ValIPI)+'|'+
    //12 COD_OBS
    '|';
    VpaDSped.Arquivo.ADD(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC190);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC300(VpaDSped: TRBDSpedFiscal);
var
  VpfLaco : Integer;
  VpfDRegistroC300 : TRBDSpedFiscalRegistroC300;
  VpfLinha : String;
begin
  for VpfLaco := 0 to VpaDSped.RegistrosC300.Count - 1 do
  begin
    VpfDRegistroC300 := TRBDSpedfiscalRegistroC300(VpaDSped.RegistrosC300.Items[vpfLaco]);
    AtualizaStatus('Gerando Bloco C registro C300 - Serie "'+ VpfDRegistroC300.DesSerieNota +'"');
    vpflinha :=
    //01 REG
    '|C300|'+
    //01 COD_MOD
    '02|'+
    //03 SER
    VpfDRegistroC300.DesSerieNota+'|'+
    //04 SUBSERIE
    VpfDRegistroC300.DesSubSerieNota+'|'+
    //05 NUMDOCINI
    IntToStr(VpfDRegistroC300.NumDocumentoInicial)+'|'+
    //06 NUMDOCFIN
    IntToStr(VpfDRegistroC300.NumDocumentoFinal)+'|'+
    //07 DT_DOC
    FormatDateTime('DDMMYYYY',VpfDRegistroC300.DatDocumento)+'|'+
    //08 VL_DOC
    FormatFloat('0.00',VpfDRegistroC300.ValDocumento)+'|'+
    //09 VL_PIS
    FormatFloat('0.00',0)+'|'+
    //10 VL_COFINS
    FormatFloat('0.00',0)+'|'+
    //11 COD_CTA
    '|';
    VpaDSped.Arquivo.ADD(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC300);
    GeraBlocoCRegistroC320(VpaDSped,VpfDRegistroC300);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC310(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : String;
begin
  AdicionaSQLAbreTabela(Tabela,'select   CAD.I_NRO_NOT ' +
                               ' from CADNOTAFISCAIS CAD '+
                               ' Where CAD.C_VEN_CON = ''S'''+
                               ' AND C_NOT_CAN = ''S'''+
                               ' AND I_EMP_FIL = ' +IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('TRUNC(CAD.D_DAT_EMI)',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' ORDER BY  C_SER_NOT, CAD.I_NRO_NOT ' );
  while not Tabela.Eof do
  begin
    VpfLinha :=
    //01 REG
    '|C310|'+
    //01 COD_MOD
    IntToStr(Tabela.FieldByName('I_NRO_NOT').AsInteger)+'|';
    VpaDSped.Arquivo.Add(VpfLinha);
    tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC320(VpaDSped: TRBDSpedFiscal;VpaDRegistroC300: TRBDSpedFiscalRegistroC300);
var
  VpfLaco : Integer;
  VpfDRegistroC320 : TRBDSpedFiscalRegistroC320;
  VpfLinha : String;
begin
  for VpfLaco := 0 to VpaDRegistroC300.RegistrosC320.Count - 1 do
  begin
    VpfDRegistroC320 := TRBDSpedfiscalRegistroC320(VpaDRegistroC300.RegistrosC320.Items[vpfLaco]);
    AtualizaStatus('Gerando Bloco C registro C320 - CST "'+ IntToSTr(VpfDRegistroC320.CodCST) +'"');
    vpflinha :=
    //01 REG
    '|C320|'+
    //02 CST_ICMS
    AdicionaCharE('0',IntToStr(VpfDRegistroC320.CodCST),3)+'|'+
    //03 CFP
    AdicionaCharE('0',IntToStr(VpfDRegistroC320.CodCFOP),4)+'|'+
    //04 ALIQUOTA ICMS
    FormatFloat('0.00',VpfDRegistroC320.PerICMS)+'|'+
    //05 VL_OPR
    FormatFloat('0.00',VpfDRegistroC320.ValOperacao)+'|'+
    //06 VL_BC_ICMS
    FormatFloat('0.00',VpfDRegistroC320.ValBcICMS)+'|'+
    //07 VL_ICMS
    FormatFloat('0.00',VpfDRegistroC320.ValICMS)+'|'+
    //08 VL_RED_BC
    FormatFloat('0.00',VpfDRegistroC320.ValReducaoBC)+'|'+
    //09 COD OBS
    '|';
    VpaDSped.Arquivo.ADD(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC320);
    GeraBlocoCRegistroC321(VpaDSped,VpfDRegistroC320);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC321(VpaDSped: TRBDSpedFiscal;VpaDRegistroC320: TRBDSpedFiscalRegistroC320);
var
  VpfDRegistroC321 : TRBDSpedFiscalRegistroC321;
  VpfLaco : Integer;
  VpfLinha : string;
begin
  for VpfLaco := 0 to VpaDRegistroC320.RegistrosC321.Count - 1 do
  begin
    VpfDRegistroC321 := TRBDSpedFiscalRegistroC321(VpaDRegistroC320.RegistrosC321.Items[VpfLaco]);
    AtualizaStatus('Gerando Bloco C registro C321 - Produto "'+ VpfDRegistroC321.CodProduto+'"');
    VpfLinha :=
    //01 REG
    '|C321|'+
    //02 COD_ITEM
    VpfDRegistroC321.CodProduto+'|'+
    //03 QTD
    FormatFloat('0.000',VpfDRegistroC321.QtdProduto)+'|'+
    //04 UNID
    VpfDRegistroC321.DesUM+'|'+
    //05 VL_ITEM
    FormatFloat('0.00',VpfDRegistroC321.ValItem)+'|'+
    //06 VL_DESC
    FormatFloat('0.00',VpfDRegistroC321.ValDesconto)+'|'+
    //07 VL_BC_ICMS
    FormatFloat('0.00',VpfDRegistroC321.ValBCICMS)+'|'+
    //08 VL_ICMS
    FormatFloat('0.00',VpfDRegistroC321.ValICMS)+'|'+
    //09 VL_PIS
    FormatFloat('0.00',VpfDRegistroC321.ValPIS)+'|'+
    //10 VL_COFINS
    FormatFloat('0.00',VpfDRegistroC321.ValDesconto)+'|';
    VpaDSped.Arquivo.ADD(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC321);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC400(VpaDSped: TRBDSpedFiscal);
var
  VpfLaco : Integer;
  VpfDRegistroC400 : TRBDSpedFiscalRegistroC400;
  VpfLinha : String;
begin
  for VpfLaco := 0 to VpaDSped.RegistrosC400.Count - 1 do
  begin
    VpfDRegistroC400 := TRBDSpedfiscalRegistroC400(VpaDSped.RegistrosC400.Items[vpfLaco]);
    AtualizaStatus('Gerando Bloco C registro C400 - Serie "'+ VpfDRegistroC400.DesSerie +'"');
    vpflinha :=
    //01 REG
    '|C400|'+
    //02 COD_MOD
    VpfDRegistroC400.CodModeloDocumento+'|'+
    //03 ECF_MOD
    VpfDRegistroC400.CodModeloECF+'|'+
    //04 ECF_FAB
    VpfDRegistroC400.DesSerie+'|'+
    //05 ECF_CX
    IntToStr(VpfDRegistroC400.NumCaixa)+'|';

    VpaDSped.Arquivo.ADD(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC400);
    GeraBlocoCRegistroC405(VpaDSped,VpfDRegistroC400);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC405(VpaDSped: TRBDSpedFiscal;VpaDRegistroC400: TRBDSpedFiscalRegistroC400);
var
  VpfDRegistroC405 :TRBDSpedFiscalRegistroC405;
  VpfLaco : Integer;
  VpfLinha : String;
begin
  for VpfLaco := 0 to VpaDRegistroC400.RegistrosC405.Count - 1 do
  begin
    VpfDRegistroC405 := TRBDSpedFiscalRegistroC405(VpaDRegistroC400.RegistrosC405.Items[VpfLaco]);
    vpflinha :=
    //01 REG
    '|C405|'+
    //02 DT_DOC
    FormatDateTime('DDMMYYYY',VpfDRegistroC405.DatMovimento)+'|'+
    //03 CRO
    IntToStr(VpfDRegistroC405.NumCRO)+'|'+
    //04 CRZ
    IntToStr(VpfDRegistroC405.NumCRZ)+'|'+
    //05 COO
    IntToStr(VpfDRegistroC405.NumCOO)+'|'+
    //06 GT FIN
    FormatFloat('0.00',VpfDRegistroC405.ValGrandeTotal)+'|'+
    //07 GT FIN
    FormatFloat('0.00',VpfDRegistroC405.ValVendaBrutaDiaria)+'|';

    VpaDSped.Arquivo.ADD(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC405);
    GeraBlocoCRegistroC420(VpaDSped,VpfDRegistroC405);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC420(VpaDSped: TRBDSpedFiscal;VpaDRegistroC405: TRBDSpedFiscalRegistroC405);
Var
  VpfDRegistroC420 : TRBDSpedFiscalRegistroC420;
  VpfLaco : Integer;
  VpfLinha : String;
begin
  for VpfLaco := 0 to VpaDRegistroC405.RegistrosC420.Count - 1 do
  begin
    VpfDRegistroC420 := TRBDSpedFiscalRegistroC420(VpaDRegistroC405.RegistrosC420.Items[VpfLaco]);
    vpflinha :=
    //01 REG
    '|C420|'+
    //02COD TOTALIZADOR
    VpfDRegistroC420.CodTotalizadorParcial+'|'+
    //03 CRO
    FormatFloat('0.00',VpfDRegistroC420.ValAcumulado)+'|'+
    //04 NR TOTAL
    '|'+
    //05 DESCRICAO NR TOTAL
    '|';

    VpaDSped.Arquivo.ADD(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC420);
    GeraBlocoCRegistroC425(VpaDSped,VpfDRegistroC420);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC425(VpaDSped: TRBDSpedFiscal;VpaDRegistroC420: TRBDSpedFiscalRegistroC420);
Var
  VpfDRegistroC425 : TRBDSpedFiscalRegistroC425;
  VpfLaco : Integer;
  VpfLinha : String;
begin
  for VpfLaco := 0 to VpaDRegistroC420.RegistrosC425.Count - 1 do
  begin
    VpfDRegistroC425 := TRBDSpedFiscalRegistroC425(VpaDRegistroC420.RegistrosC425.Items[VpfLaco]);
    vpflinha :=
    //01 REG
    '|C425|'+
    //02 COD ITEM
    VpfDRegistroC425.CodProduto+'|'+
    //03 QTD
    FormatFloat('0.00',VpfDRegistroC425.QtdProduto)+'|'+
    //04 UNID
    VpfDRegistroC425.DesUM+'|'+
    //05 VL ITEM
    FormatFloat('0.00',VpfDRegistroC425.ValTotal)+'|'+
    //06 VL PIS
    FormatFloat('0.00',VpfDRegistroC425.ValPis)+'|'+
    //07 VL COFINS
    FormatFloat('0.00',VpfDRegistroC425.ValCofins)+'|';

    VpaDSped.Arquivo.ADD(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC425);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC490(VpaDSped: TRBDSpedFiscal);
Var
  VpfDRegistroC490 : TRBDSpedFiscalRegistroC490;
  VpfLaco : Integer;
  VpfLinha : String;
begin
  for VpfLaco := 0 to VpaDSped.RegistrosC490.Count - 1 do
  begin
    VpfDRegistroC490 := TRBDSpedFiscalRegistroC490(VpaDSped.RegistrosC490.Items[VpfLaco]);
    vpflinha :=
    //01 REG
    '|C490|'+
    //02 CST ICMS
    IntToStr(VpfDRegistroC490.CODCST) +'|'+
    //03 CFOP
    IntToStr(VpfDRegistroC490.CodCFOP) +'|'+
    //04 ALIQUOTA ICM
    FormatFloat('0.00',VpfDRegistroC490.PerICMS)+'|'+
    //05 VL OPR
    FormatFloat('0.00',VpfDRegistroC490.ValProdutos)+'|'+
    //06 VL BC ICMS
    FormatFloat('0.00',VpfDRegistroC490.ValBaseCalculo)+'|'+
    //07 VL ICMS
    FormatFloat('0.00',VpfDRegistroC490.ValICMS)+'|'+
    //08 COD OBS
    '|';
    VpaDSped.Arquivo.ADD(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC425);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBlocoC);
  VpaDSped.Arquivo.Add('|C990|'+IntToStr(VpaDSped.QtdLinhasBlocoC)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoDRegistroD001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|D001|1|');
  inc(VpaDSped.QtdLinhasBlocoD);
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoDRegistroD100(VpaDSped: TRBDSpedFiscal);
var
  VpfLaco : Integer;
  VpfLinha : String;
  VpfDRegistroD100 : TRBDSpedFiscalRegistroD100;
begin
  for VpfLaco := 0 to VpaDSped.RegistrosD100.Count - 1 do
  begin
    VpfDRegistroD100 := TRBDSpedFiscalRegistroD100(VpaDSped.RegistrosD100.Items[VpfLaco]);
    AtualizaStatus('Gerando Bloco D registro D100 - Nota Fiscal "'+    IntToStr(VpfDRegistroD100.NumDocumentoFiscal)+'"');
    VpfLinha := '|'+
    //01 REG
    'D100|'+
    //02 IND_OPER
    '0|'+
    //03 IND_EMITENTE
    '1|'+
    //04 COD_PART
    IntToStr(VpfDRegistroD100.CodParticipante)+ '|'+
    //05 COD_MOD
    VpfDRegistroD100.CodModeloDocumento+'|';
    //06 COD_SIT
    case VpfDRegistroD100.CodSituacao of
      csDocumentoRegular: VpfLinha := VpfLinha + '00|' ;
      csEscrituracaoExtemporaneaRegular: VpfLinha := VpfLinha + '01|' ;
      csCancelado: VpfLinha := VpfLinha + '02|' ;
      csEscrituracaoExtemporaneaCancelado: VpfLinha := VpfLinha + '03|' ;
      csNFEouCTEDenegado: VpfLinha := VpfLinha + '04|';
      csNFEouCTENumeracaoInutilizada: VpfLinha := VpfLinha + '05|' ;
      csDocumentoFiscalComplentar: VpfLinha := VpfLinha + '06|' ;
      csEscrituracaoExtemporaneaComplentar: VpfLinha := VpfLinha + '07|' ;
      csDocumentoFiscalEspecial: VpfLinha := VpfLinha + '08|' ;
    end;
    //07 SER
    VpfLinha := VpfLinha + VpfDRegistroD100.DesSerieDocumentoFiscal+'|'+
    //08 SUB
    VpfDRegistroD100.DesSubSerieDocumentoFiscal+'|'+
    //09 NUM DOC
    IntToStr(VpfDRegistroD100.NumDocumentoFiscal)+'|'+
    //10 CHV CTE
    ' |'+
    //11 DT DOC
    FormatDateTime('DDMMYYYY',VpfDRegistroD100.DatDocumentoFiscal)+'|'+
    //12 DT AP
    FormatDateTime('DDMMYYYY',VpfDRegistroD100.DatAquisicaoServico)+'|'+
    //13 TP-CTe
    '|'+
    //14 CHV_CTE_REF
    '|'+
    //15 VL DOC
    FormatFloat('0.00',VpfDRegistroD100.ValDocumento)+'|'+
    //16 VL DESC
    FormatFloat('0.00',VpfDRegistroD100.ValDesconto)+'|';
    //17 IND FTR
    case VpfDRegistroD100.IndFrete of
      ifPorContaTerceiros: VpfLinha := VpfLinha + '0|';
      ifPorContadoEmitente: VpfLinha := VpfLinha + '1|';
      ifPorContadoDestinatario: VpfLinha := VpfLinha + '2|';
      ifSemCobrancafrete: VpfLinha := VpfLinha + '9|';
    end;
    VpfLinha := VpfLinha +
   //18 VL SERV
    FormatFloat('0.00',VpfDRegistroD100.ValServico)+'|'+
   //19 VL BC ICMS
    FormatFloat('0.00',VpfDRegistroD100.ValBaseICMS)+'|'+
   //20 VL ICMS
    FormatFloat('0.00',VpfDRegistroD100.ValICMS)+'|'+
   //21 VL NT
    FormatFloat('0.00',VpfDRegistroD100.ValNaoTributado)+'|'+
   //22 COD INF
    '|'+
   //23   COD CTA
    '|';
    VpaDSped.Arquivo.add(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoD);
    Inc(VpaDSped.QtdLinhasRegistroD100);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoDRegistroD990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBlocoD);
  VpaDSped.Arquivo.Add('|D990|'+IntToStr(VpaDSped.QtdLinhasBlocoD)+'|');
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoGRegistroG001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|G001|1|');
  inc(VpaDSped.QtdLinhasBlocoG);
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoGRegistroG990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBlocoG);
  VpaDSped.Arquivo.Add('|G990|'+IntToStr(VpaDSped.QtdLinhasBlocoG)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|E001|0|');
  inc(VpaDSped.QtdLinhasBlocoE);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE100(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|E100|'+FormatDateTime('DDMMYYYY',VpaDSped.DatInicio)+'|'+FormatDateTime('DDMMYYYY',VpaDSped.DatFinal)+'|');
  inc(VpaDSped.QtdLinhasBlocoE);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE110(VpaDSped: TRBDSpedFiscal);
Var
  VpfLinha : String;
begin
  CarDRegistroE110TotalDebitos(VpaDSped);
  VpaDSped.RegistroE110.VL_SLD_APURADO := VpaDSped.RegistroE110.VL_TOT_DEBITOS - VpaDSped.RegistroE110.VL_TOT_CREDITOS ;
  if VpaDSped.RegistroE110.VL_SLD_APURADO < 0 then
    VpaDSped.RegistroE110.VL_SLD_APURADO := 0;
  VpaDSped.RegistroE110.VL_ICMS_RECOLHER := VpaDSped.RegistroE110.VL_SLD_APURADO;
  if VpaDSped.RegistroE110.VL_ICMS_RECOLHER < 0 then
    VpaDSped.RegistroE110.VL_ICMS_RECOLHER := 0;
  if (VpaDSped.RegistroE110.VL_TOT_DEBITOS - VpaDSped.RegistroE110.VL_TOT_CREDITOS) < 0 then
    VpaDSped.RegistroE110.VL_SLD_CREDOR_TRANSPORTAR := (VpaDSped.RegistroE110.VL_TOT_DEBITOS - VpaDSped.RegistroE110.VL_TOT_CREDITOS)*-1;

  VpfLinha :=
  //01 REG
  '|E110|'+
  //02 VL TOT DEBITOS
  FormatFloat('0.00',VpaDSped.RegistroE110.VL_TOT_DEBITOS)+'|'+
  //03 VL AJ DEBITOS
  FormatFloat('0.00',0)+'|'+
  //04 VL TOT AJ DEBITOS
  FormatFloat('0.00',0)+'|'+
  //05 VL ESTORNOS CRED
  FormatFloat('0.00',0)+'|'+
  //06 VL TOT CREDITO
  FormatFloat('0.00',VpaDSped.RegistroE110.VL_TOT_CREDITOS)+'|'+
  //07 VL AJ DEBITOS
  FormatFloat('0.00',0)+'|'+
  //08 VL TOT AJ DEBITOS
  FormatFloat('0.00',0)+'|'+
  //09 VL ESTORNOS DEBITOS
  FormatFloat('0.00',0)+'|'+
  //10 VL SALDO CREDOR ANT
  FormatFloat('0.00',0)+'|'+
  //11 VL SALDO APURADO
  FormatFloat('0.00',VpaDSped.RegistroE110.VL_SLD_APURADO)+'|'+
  //12 VL TOT DED
  FormatFloat('0.00',0)+'|'+
  //13 VL ICMS RECOLHER
  FormatFloat('0.00',VpaDSped.RegistroE110.VL_ICMS_RECOLHER)+'|'+
  //14 VL SLD CREDOR TRANSPORTAR
  FormatFloat('0.00',VpaDSped.RegistroE110.VL_SLD_CREDOR_TRANSPORTAR)+'|'+
  //15 DEB ESP
  FormatFloat('0.00',VpaDSped.RegistroE110.DEB_ESP)+'|';
  VpaDSped.Arquivo.Add(VpfLinha);
  inc(VpaDSped.QtdLinhasBlocoE);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE116(VpaDSped: TRBDSpedFiscal);
var
  VpfLaco : Integer;
  VpfDRegistroE116 : TRBDSpedFiscalRegistroE116;
  VpfLinha : String;
begin
  CarregaBlocoERegistroE116(VpaDSped);
  for VpfLaco := 0 to VpaDSped.RegistrosE116.Count - 1 do
  begin
    VpfDRegistroE116 := TRBDSpedFiscalRegistroE116(VpaDSped.RegistrosE116.Items[Vpflaco]);
    VpfLinha := '|E116|';
  //  02 COD_COR
    case VpfDRegistroE116.COD_OR of
      coICMSaRecolher: VpfLinha := VpfLinha +'000|' ;
      coICMSSTpelasEntradas: VpfLinha := VpfLinha +'001|' ;
      coICMSSTpelasSaidas: VpfLinha := VpfLinha +'002|' ;
      coAntecipacaoDiferencialAliquotaICMS: VpfLinha := VpfLinha +'003|' ;
      coAntecipacaoICMSImportacao: VpfLinha := VpfLinha +'004|' ;
      coAntecipacaoTributaria: VpfLinha := VpfLinha +'005|' ;
      coICMSFUNCEP: VpfLinha := VpfLinha +'006|' ;
      coOutrasObrigacoesICMS: VpfLinha := VpfLinha +'090|' ;
      coICMSSTpelasSaidasparaOutroEstado: VpfLinha := VpfLinha +'999|' ;
    end;
    VpfLinha := VpfLinha+
    // 03  VL_OR
    FormatFloat('0.00',VpfDRegistroE116.VL_OR)+'|'+
    // 04 DT_VCTO
    FormatDateTime('DDMMYYYY',VpfDRegistroE116.DT_VCTO)+'|'+
    // 05 COD_REC
    VpfDRegistroE116.COD_REC+'|';
    if VpfDRegistroE116.NUM_PROC <> '' then
    begin
      VpfLinha := VpfLinha +
      // 06 NUM_PROC
      VpfDRegistroE116.NUM_PROC+'|';
      // 07 IND_PROC
      case VpfDRegistroE116.IND_PROC of
        ipSEFAZ: VpfLinha := VpfLinha + '0|';
        ipJusticaFederal: VpfLinha := VpfLinha + '1|';
        ipJusticaEstadual: VpfLinha := VpfLinha + '2|';
        ipOutros: VpfLinha := VpfLinha + '9|';
      end;
      VpfLinha := VpfLinha +
      // 08 PROC
      VpfDRegistroE116.PROC+'|'+
      // 09 TXT_CMPL
      VpfDRegistroE116.TXT_COMPL+'|';
    end
    else
      VpfLinha := VpfLinha+ AdicionaCharD('|','',4);

    VpfLinha := VpfLinha+
        // 10 MES_REF
    FormatDateTime('MMYYYY',VpfDRegistroE116.MES_REF)+'|';

    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasREgistroE116);
    inc(VpaDSped.QtdLinhasBlocoE);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE500(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|E500|0|'+FormatDateTime('DDMMYYYY',VpaDSped.DatInicio)+'|'+FormatDateTime('DDMMYYYY',VpaDSped.DatFinal)+'|');
  inc(VpaDSped.QtdLinhasBlocoE);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE510(VpaDSped: TRBDSpedFiscal);
var
  VpfLaco : Integer;
  VpfDRegistroE510 : TRBDSpedFiscalRegistroE510;
  VpfLinha : string;
begin
  for VpfLaco := 0 to VpaDSped.RegistrosE510.Count - 1 do
  begin
    VpfDRegistroE510 := TRBDSpedFiscalRegistroE510(VpaDSped.RegistrosE510.Items[Vpflaco]);
    VpfLinha := '|E510|'+
    //02 CFOP
    AdicionaCharD('0',IntToStr(VpfDRegistroE510.CFOP),4)+'|'+
    //03 CST_IPI
    DeletaEspaco(VpfDRegistroE510.CST_IPI)+'|'+
    //04 VL_CONT_IPI
    FormatFloat('0.00',VpfDRegistroE510.VL_CONT_IPI)+'|'+
    //05 VL_BC_IPI
    FormatFloat('0.00',VpfDRegistroE510.VL_BC_IPI)+'|'+
    //06 VL_IPI
    FormatFloat('0.00',VpfDRegistroE510.VL_IPI)+'|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasREgistroE510);
    inc(VpaDSped.QtdLinhasBlocoE);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE520(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : String;
begin
  VpfLinha := '|E520|'+
  //02 VL_SD_ANT_IPI
  FormatFloat('0.00',VpaDSped.RegistroE520.VL_SD_ANT_IPI) +'|'+
  //03 VL_DEB_IPI
  FormatFloat('0.00',VpaDSped.RegistroE520.VL_DEB_IPI) +'|'+
  //04 VL_CRED_IPI
  FormatFloat('0.00',VpaDSped.RegistroE520.VL_CRED_IPI) +'|'+
  //05 VL_OD_IPI
  FormatFloat('0.00',VpaDSped.RegistroE520.VL_OD_IPI) +'|'+
  //06 VL_OC_IPI
  FormatFloat('0.00',VpaDSped.RegistroE520.VL_OC_IPI) +'|'+
  //07 VL_SC_IPI
  FormatFloat('0.00',VpaDSped.RegistroE520.VL_SC_IPI) +'|'+
  //08 VL_SD_IPI
  FormatFloat('0.00',VpaDSped.RegistroE520.VL_SD_IPI) +'|';
  VpaDSped.Arquivo.Add(VpfLinha);
  inc(VpaDSped.QtdLinhasBlocoE);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBlocoE);
  VpaDSped.Arquivo.Add('|E990|'+IntToStr(VpaDSped.QtdLinhasBlocoE)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoHRegistro1001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|1001|1|');
  inc(VpaDSped.QtdLinhasBloco1);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoHRegistro1990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBloco1);
  VpaDSped.Arquivo.Add('|1990|'+IntToStr(VpaDSped.QtdLinhasBloco1)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoHRegistroH001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|H001|1|');
  inc(VpaDSped.QtdLinhasBlocoH);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoHRegistroH990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBlocoH);
  VpaDSped.Arquivo.Add('|H990|'+IntToStr(VpaDSped.QtdLinhasBlocoH)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraSpedfiscal(VpaDSped: TRBDSpedFiscal;VpaBarraStatus : TStatusBar);
begin
  VpaDSped.Incosistencias.clear;
  ZeraQtdLinhas(VpaDSped);
  VprBarraStatus :=  VpaBarraStatus;
  AtualizaStatus('Carregando os dados da filial');
  Sistema.CarDFilial(VpaDSped.DFilial,VpaDSped.CodFilial);

  AtualizaStatus('Carregando os dados gerais do sped');
  CarDSped(VpaDSped);
  AtualizaStatus('Carregando os dados do contabilista');
  VpaDSped.DContabilidade.CodCliente := VpaDSped.DFilial.CodContabilidade;
  FunClientes.CarDCliente(VpaDSped.DContabilidade);

  VpaDSped.Arquivo.clear;
  AtualizaStatus('Validando as configurações');
  if VpaDSped.IndConsistirDados then
    DadosValidos(VpaDSped);
  if VpaDSped.Incosistencias.Count = 0 then
  begin
    AtualizaStatus('Gerando Bloco 0 registro 0000');
    GeraBloco0Registro0000(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0001');
    GeraBloco0Registro0001(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0005');
    GeraBloco0Registro0005(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0100');
    GeraBloco0Registro0100(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0150');
    GeraBloco0Registro0150(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0190');
    GeraBloco0Registro0190(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0200');
    GeraBloco0Registro0200(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0200');
    GeraBloco0Registro0200Servicos(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0400');
    GeraBloco0Registro0400(VpaDSped);

    if VpaDSped.IndSaidas then
    begin
      AtualizaStatus('Carregando Bloco C registro C100');
      CarregaBlocoCRegistroC100Saida(VpaDSped);
      AtualizaStatus('Carregando Bloco C registro C170');
      CarregaBlocoCRegistroC170Saida(VpaDSped);
      AtualizaStatus('Carregando Bloco C registro C300');
      CarregaBlocoCRegistroC321(VpaDSped);
      AtualizaStatus('Carregando Bloco C registro C400');
      CarregaBlocoCRegistroC400(VpaDSped);
    end;
    if VpaDSped.IndEntradas then
    begin
      AtualizaStatus('Gerando Bloco C registro C100 Entrada');
      CarregaBlocoCRegistroC100Entrada(VpaDSped);
      AtualizaStatus('Carregando Bloco C registro C170 Entrada');
      CarregaBlocoCRegistroC170Entrada(VpaDSped);
      AtualizaStatus('Carregando Bloco C registro C170 Servico Entrada');
      CarregaBlocoCRegistroC170EntradaServico(VpaDSped);

    end;
    AtualizaStatus('Carregando Bloco C registro C140');
    CarregaBlocoCRegistroC140(VpaDSped);

    AtualizaStatus('Gerando Bloco 0 registro 0450');
    GeraBloco0Registro0450(VpaDSped);

    AtualizaStatus('Gerando Bloco 0 registro 0990');
    GeraBloco0Registro0990(VpaDSped);
    AtualizaStatus('Gerando Bloco C registro C001');
    GeraBlocoCRegistroC001(VpaDSped);

    AtualizaStatus('Gerando Bloco C registro C100');
    GeraBlocoCRegistroC100(VpaDSped);
    AtualizaStatus('Gerando Bloco C registro C300');
    GeraBlocoCRegistroC300(VpaDSped);
    AtualizaStatus('Gerando Bloco C registro C310');
    GeraBlocoCRegistroC310(VpaDSped);
    AtualizaStatus('Gerando Bloco C registro C400');
    GeraBlocoCRegistroC400(VpaDSped);
    AtualizaStatus('Gerando Bloco C registro C490');
    GeraBlocoCRegistroC490(VpaDSped);
    AtualizaStatus('Gerando Bloco C registro C990');
    GeraBlocoCRegistroC990(VpaDSped);
    AtualizaStatus('Gerando Bloco D registro D001');
    GeraBlocoDRegistroD001(VpaDSped);
    AtualizaStatus('Gerando Bloco D registro D990');
    GeraBlocoDRegistroD990(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E001');
    GeraBlocoERegistroE001(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E100');
    GeraBlocoERegistroE100(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E110');
    GeraBlocoERegistroE110(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E116');
    GeraBlocoERegistroE116(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E500');
    GeraBlocoERegistroE500(VpaDSped);
    AtualizaStatus('Carregando Bloco E registro E510');
    CarregaBlocoERegistroE510(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E510');
    GeraBlocoERegistroE510(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E520');
    GeraBlocoERegistroE520(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E990');
    GeraBlocoERegistroE990(VpaDSped);
    AtualizaStatus('Gerando Bloco G registro G001');
    GeraBlocoGRegistroG001(VpaDSped);
    AtualizaStatus('Gerando Bloco G registro G990');
    GeraBlocoGRegistroG990(VpaDSped);
    AtualizaStatus('Gerando Bloco H registro H001');
    GeraBlocoHRegistroH001(VpaDSped);
    AtualizaStatus('Gerando Bloco H registro H990');
    GeraBlocoHRegistroH990(VpaDSped);
    AtualizaStatus('Gerando Bloco 1 registro 1001');
    GeraBlocoHRegistro1001(VpaDSped);
    AtualizaStatus('Gerando Bloco 1 registro 1990');
    GeraBlocoHRegistro1990(VpaDSped);
    AtualizaStatus('Gerando Bloco 9 registro 9001');
    GeraBloco9Registro9001(VpaDSped);
    AtualizaStatus('Gerando Bloco 9 registro 9990');
    GeraBloco9Registro9900(VpaDSped);
    AtualizaStatus('Gerando Bloco 9 registro 9990');
    GeraBloco9Registro9990(VpaDSped);
    AtualizaStatus('Gerando Bloco 9 registro 9999');
    GeraBloco9Registro9999(VpaDSped);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaNaturezaOperacaoREG0400(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(Tabela,'Select MOV.C_COD_NAT, MOV.I_SEQ_MOV, MOV.C_NOM_MOV '+
                               ' FROM MOVNATUREZA MOV '+
                               ' WHERE ');
    if VpaDSped.IndSaidas then
  begin
    AdicionaSQLTabela(VpaTabela,' EXISTS (SELECT * FROM CADNOTAFISCAIS CAD ' +
                               ' WHERE CAD.C_COD_NAT = MOV.C_COD_NAT '+
                               ' AND CAD.I_ITE_NAT = MOV.I_SEQ_MOV '+
                               ' and CAD.C_NOT_CAN = ''N'''+
                               ' AND CAD.C_CHA_NFE IS NULL '+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ')');
  end;
  if VpaDSped.IndEntradas then
  begin
    if VpaDSped.IndSaidas then
      AdicionaSQLTabela(VpaTabela,'OR');
    AdicionaSQLTabela(VpaTabela,' EXISTS (SELECT * FROM CADNOTAFISCAISFOR CAF ' +
                               ' WHERE CAF.C_COD_NAT = MOV.C_COD_NAT '+
                               ' AND CAF.I_SEQ_NAT = MOV.I_SEQ_MOV '+
                               ' AND CAF.C_MOD_DOC IS NOT NULL '+
                               ' AND CAF.C_MOD_DOC <> ''IS'''+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ')');
  end;
  AdicionaSQLTabela(VpaTabela,' ORDER BY C_COD_NAT, I_SEQ_MOV ');
  VpaTabela.Open;
//  VpaTabela.SQL.SaveToFile('c:\naturezas.sql');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaNotasFiscaisEntradaRegC100(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  AdicionaSQLAbreTabela(Tabela,'Select NAT.C_ENT_SAI, NAT.C_GER_FIN, '+
                               ' CAD.I_EMP_FIL, CAD.I_COD_CLI,  CAD.I_SEQ_NOT, CAD.I_NRO_NOT, CAD.C_SER_NOT,  CAD.D_DAT_EMI, '+
                               ' CAD.D_DAT_SAI, CAD.N_TOT_NOT, CAD.N_VLR_DES, CAD.N_PER_DES, CAD.N_TOT_PRO,  CAD.I_TIP_FRE, '+
                               ' CAD.N_VLR_FRE,  CAD.N_VLR_SEG, CAD.N_OUT_DES, CAD.N_BAS_CAL, CAD.N_VLR_ICM, CAD.N_BAS_SUB, CAD.N_VLR_SUB, '+
                               ' CAD.N_TOT_IPI, CAD.I_COD_TRA, CAD.C_MOD_DOC, CAD.D_DAT_REC, I_SEQ_NAT, CAD.C_COD_NAT, '+
                               ' TRA.C_VEI_PRO, '+
                               ' PAG.I_COD_PAG '+
                               ' from MOVNATUREZA NAT, CADNOTAFISCAISFOR CAD, CADCONDICOESPAGTO PAG, CADCLIENTES TRA '+
                               ' Where CAD.C_COD_NAT = NAT.C_COD_NAT '+
                               ' AND CAD.I_SEQ_NAT = NAT.I_SEQ_MOV '+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               ' and CAD.C_MOD_DOC IS NOT NULL '+
//                               ' AND CAD.I_SEQ_NOT = 1046 '+
                               ' and C_MOD_DOC <> ''IS'' '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND '+SQLTextoRightJoin('CAD.I_COD_PAG','PAG.I_COD_PAG')+
                               ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_CLI'));
// Tabela.SQL.SaveToFile('c:\notasentrada.sql');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaNotasFiscaisSaidaRegC100(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  AdicionaSQLAbreTabela(Tabela,'Select NAT.C_ENT_SAI, NAT.C_GER_FIN, NAT.L_TEX_FIS,'+
                               ' CAD.I_EMP_FIL, CAD.I_COD_CLI, CAD.C_NOT_CAN, CAD.I_SEQ_NOT, CAD.I_NRO_NOT, CAD.C_SER_NOT, CAD.C_CHA_NFE, CAD.D_DAT_EMI, '+
                               ' CAD.D_DAT_SAI, CAD.N_TOT_NOT, CAD.N_VLR_DES, CAD.N_PER_DES, CAD.N_TOT_PRO, CAD.N_TOT_SER, CAD.I_TIP_FRE, CAD.C_COD_NAT, CAD.I_ITE_NAT, '+
                               ' CAD.N_VLR_FRE,  CAD.N_VLR_SEG, CAD.N_OUT_DES, CAD.N_BAS_CAL, CAD.N_VLR_ICM, CAD.N_BAS_SUB, CAD.N_VLR_SUB, '+
                               ' CAD.N_TOT_IPI, CAD.I_COD_TRA, CAD.C_NRO_PLA, CAD.C_EST_PLA, CAD.I_QTD_VOL, CAD.N_PES_BRU, CAD.N_PES_LIQ, CAD.C_NOT_INU, '+
                               ' CAD.L_OBS_NOT, CAD.L_OB1_NOT, CAD.I_MOD_DOC, ' +
                               ' TRA.C_VEI_PRO, '+
                               ' PAG.I_COD_PAG '+
                               ' from MOVNATUREZA NAT, CADNOTAFISCAIS CAD, CADCONDICOESPAGTO PAG, CADCLIENTES TRA '+
                               ' Where CAD.C_COD_NAT = NAT.C_COD_NAT '+
                               ' AND CAD.I_ITE_NAT = NAT.I_SEQ_MOV '+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
//                               ' AND CAD.I_SEQ_NOT = 4382 '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND '+SQLTextoRightJoin('CAD.I_COD_PAG','PAG.I_COD_PAG')+
                               ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_CLI')+
                               ' and '+SqlTextoIsNull('CAD.C_FLA_ECF','''N''')+' = ''N'' '+
                               ' and '+SqlTextoIsNull('CAD.C_VEN_CON','''N''')+' = ''N'' '+
                               ' order by CAD.I_NRO_NOT ');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaParticipantesREG0150(VpaTabela: TSQL;VpaDSped : TRBDSpedFiscal);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(Tabela,'Select CLI.I_COD_CLI,CLI.C_NOM_CLI, CLI.C_TIP_PES, CLI.C_CGC_CLI, ' +
                               ' CLI.C_CPF_CLI, CLI.I_COD_IBG, CLI.I_COD_PAI, CLI.C_INS_CLI, CLI.C_END_CLI, '+
                               ' CLI.I_NUM_END, CLI.C_COM_END, CLI.C_BAI_CLI '+
                               ' FROM CADCLIENTES CLI '+
                               ' Where ');
  if VpaDSped.IndSaidas then
  begin
    AdicionaSQLTabela(VpaTabela,'  EXISTS (SELECT * FROM CADNOTAFISCAIS CAD '+
                               ' WHERE CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               ' and CAD.C_NOT_CAN = ''N'''+
                               '  ) ');
    if not VpaDSped.DFilial.IndEmiteNFE then
    begin
      AdicionaSQLTabela(VpaTabela,'OR');
      AdicionaSQLTabela(VpaTabela,'  EXISTS (SELECT * FROM CADNOTAFISCAIS CAD '+
                                 ' WHERE CAD.I_COD_TRA = CLI.I_COD_CLI ' +
                                 SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                                 ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                                 ' and CAD.C_NOT_CAN = ''N'''+
                                 '  ) ');
    end;

  end;

  if VpaDSped.IndEntradas then
  begin
    if VpaDSped.IndSaidas then
      AdicionaSQLTabela(VpaTabela,'OR');
    AdicionaSQLTabela(VpaTabela,'  EXISTS(SELECT * FROM CADNOTAFISCAISFOR CAF '+
                               ' WHERE CAF.I_COD_CLI = CLI.I_COD_CLI '+
                               ' AND CAF.C_MOD_DOC IS NOT NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               ' and CAF.C_MOD_DOC <> ''IS'''+
                               '  ) ');
  end;
//  VpaTabela.SQL.SaveToFile('c:\participantes.sql');
  VpaTabela.Open;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaProdutosNotafiscalEntradaRegC170(VpaTabela: TSQL; VpaCodFilial,
  VpaSeqNota: Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select MOV.I_EMP_FIL, MOV.I_SEQ_NOT, MOV.I_SEQ_MOV, MOV.I_SEQ_PRO, '+
                                  ' MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_TOT_PRO, MOV.C_COD_CST, MOV.I_COD_CFO,'+
                                  ' MOV.N_PER_ICM, MOV.N_PER_IPI, MOV.I_COD_COR, MOV.I_ITE_NAT, ' +
                                  ' MOV.N_VLR_DES, MOV.N_OUT_DES, MOV.N_VLR_FRE, MOV.N_VLR_BIC, ' +
                                  ' MOV.N_VLR_ICM, MOV.N_VLR_BST, MOV.N_VLR_TST '+
                                  ' FROM MOVNOTASFISCAISFOR MOV '+
                                  ' Where MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND MOV.I_SEQ_NOT = '+ IntToStr(VpaSeqNota)+
                                  ' ORDER BY MOV.I_SEQ_MOV');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaProdutosNotafiscalSaidaRegC170(VpaTabela: TSQL; VpaCodFilial, VpaSeqNota: Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select MOV.I_EMP_FIL, MOV.I_SEQ_NOT, MOV.I_SEQ_MOV, MOV.I_SEQ_PRO, '+
                                  ' MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_TOT_PRO, MOV.C_COD_CST, MOV.I_COD_CFO,'+
                                  ' MOV.N_PER_ICM, MOV.N_PER_IPI, MOV.N_VLR_IPI, MOV.I_COD_COR, MOV.N_RED_BAS, MOV.N_BAS_ICM, ' +
                                  ' MOV.N_VLR_ICM, MOV.N_OUT_DES, MOV.N_VLR_FRE, MOV.N_VLR_DES ' +
                                  ' FROM MOVNOTASFISCAIS MOV '+
                                  ' Where MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND MOV.I_SEQ_NOT = '+ IntToStr(VpaSeqNota)+
                                  ' ORDER BY MOV.I_SEQ_MOV');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaProdutosREG0200(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(Tabela,'Select PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI, PRO.I_DES_PRO, PRO.C_CLA_FIS, ' +
                               ' PRO.N_RED_ICM '+
                               ' FROM CADPRODUTOS PRO '+
                               ' WHERE ');
  if VpaDSped.IndSaidas then
  begin
    AdicionaSQLTabela(VpaTabela,' EXISTS (SELECT * FROM CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV '+
                               ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               ' and CAD.C_NOT_CAN = ''N'''+
                               ' AND CAD.C_CHA_NFE IS NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  ) ');
  end;
  if VpaDSped.IndEntradas then
  begin
    if VpaDSped.IndSaidas then
      AdicionaSQLTabela(VpaTabela,'OR');
    AdicionaSQLTabela(VpaTabela,' EXISTS (SELECT * FROM CADNOTAFISCAISFOR CAF, MOVNOTASFISCAISFOR MOF '+
                               ' WHERE CAF.I_EMP_FIL = MOF.I_EMP_FIL '+
                               ' AND CAF.I_SEQ_NOT = MOF.I_SEQ_NOT '+
                               ' AND CAF.C_MOD_DOC IS NOT NULL'+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOF.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                               ' )');
  end;
  VpaTabela.SQL.SaveToFile('C:\PRODUTOS.sql');
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaProdutosREG0200Servicos(VpaTabela: TSQL;VpaDSped: TRBDSpedFiscal);
begin
  if VpaDSped.IndEntradas then
  begin
    LimpaSQLTabela(VpaTabela);
    AdicionaSQLTabela(Tabela,'Select SER.I_COD_SER, SER.C_NOM_SER, SER.I_COD_FIS ' +
                               ' FROM CADSERVICO SER '+
                               ' WHERE ');
{  if VpaDSped.IndSaidas then
  begin
    AdicionaSQLTabela(VpaTabela,' EXISTS (SELECT * FROM CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV '+
                               ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               ' and CAD.C_NOT_CAN = ''N'''+
                               ' AND CAD.C_CHA_NFE IS NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  ) ');
  end;}
{    if VpaDSped.IndSaidas then
      AdicionaSQLTabela(VpaTabela,'OR');}
    AdicionaSQLTabela(VpaTabela,' EXISTS (SELECT * FROM CADNOTAFISCAISFOR CAF, MOVSERVICONOTAFOR MOF '+
                               ' WHERE CAF.I_EMP_FIL = MOF.I_EMP_FIL '+
                               ' AND CAF.I_SEQ_NOT = MOF.I_SEQ_NOT '+
                               ' AND CAF.C_MOD_DOC IS NOT NULL'+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOF.I_COD_SER = SER.I_COD_SER'+
                               ' )');
    VpaTabela.Open;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaServicosNotafiscalEntradaRegC170(VpaTabela: TSQL; VpaCodFilial, VpaSeqNota: Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select MOV.I_EMP_FIL, MOV.I_SEQ_NOT, MOV.I_SEQ_MOV, MOV.I_COD_SER, '+
                                  ' MOV.N_QTD_SER, MOV.N_TOT_SER,  MOV.I_COD_CFO'+
                                  ' FROM MOVSERVICONOTAFOR MOV '+
                                  ' Where MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND MOV.I_SEQ_NOT = '+ IntToStr(VpaSeqNota)+
                                  ' ORDER BY MOV.I_SEQ_MOV');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaUnidadesMedidasREG0190(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSQLTabela(Tabela,'Select UNI.C_COD_UNI, UNI.C_NOM_UNI ' +
                               ' FROM CADUNIDADE UNI '+
                               ' WHERE ');
  if VpaDSped.IndSaidas then
  begin
    AdicionaSQLTabela(VpaTabela,'EXISTS (SELECT * FROM CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV '+
                               ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               ' and CAD.C_NOT_CAN = ''N'''+
                               ' AND CAD.C_CHA_NFE IS NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOV.C_COD_UNI = UNI.C_COD_UNI'+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  )'+
                               ' or exists(SELECT * FROM CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV, CADPRODUTOS PRO '+
                               ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               ' and CAD.C_NOT_CAN = ''N'''+
                               ' AND CAD.C_CHA_NFE IS NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               ' AND PRO.C_COD_UNI = UNI.C_COD_UNI'+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                              '  ) ');
  end;
  if VpaDSped.IndEntradas then
  begin
    if VpaDSped.IndSaidas then
      AdicionaSQLTabela(VpaTabela,'OR');
    AdicionaSQLTabela(VpaTabela,' EXISTS (SELECT * FROM CADNOTAFISCAISFOR CAF, MOVNOTASFISCAISFOR MOF '+
                               ' WHERE CAF.I_EMP_FIL = MOF.I_EMP_FIL '+
                               ' AND CAF.I_SEQ_NOT = MOF.I_SEQ_NOT '+
                               ' AND CAF.C_MOD_DOC IS NOT NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOF.C_COD_UNI = UNI.C_COD_UNI'+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  )'+
                               ' or exists(SELECT * FROM CADNOTAFISCAISFOR CAF, MOVNOTASFISCAISFOR MOF, CADPRODUTOS PRO '+
                               ' WHERE CAF.I_EMP_FIL = MOF.I_EMP_FIL '+
                               ' AND CAF.I_SEQ_NOT = MOF.I_SEQ_NOT '+
                               ' AND CAF.C_MOD_DOC IS NOT NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOF.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               ' AND PRO.C_COD_UNI = UNI.C_COD_UNI'+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  )' );
  end;
  VpaTabela.Open;
end;

{********************************************************************************}
function TRBFuncoesSpedFiscal.RAliquotaICMSRegitroC170Saida(VpaPerICMS: Double; VpaDNatureza: TRBDNaturezaOperacao): double;
begin
  if VpaDNatureza.IndCalcularICMS then
    result := VpaPerICMS
  else
    result := 0;
end;

{********************************************************************************}
function TRBFuncoesSpedFiscal.RBaseCalculoICMSRegitroC170Saida(VpaValTotProdutos, VpaPerReducaoBase: Double; VpaDNatureza: TRBDNaturezaOperacao): double;
begin
  if VpaDNatureza.IndCalcularICMS then
    result := VpaValTotProdutos - ((VpaValTotProdutos* VpaPerReducaoBase)/100)
  else
    result := 0;
end;

{******************************************************************************}
function TRBFuncoesSpedFiscal.RRegistro0450(VpaDSped: TRBDSpedFiscal;VpaDRegistroC100: TRBDspedFiscalRegistroC100): TRBDSpedFiscalRegistro0450;
var
  VpfLaco : Integer;
  VpfDRegistro0450 : TRBDSpedFiscalRegistro0450;
  VpfAchou, VpfPercorreuLacoateoFim : Boolean;
begin
  result := nil;
  if VpaDRegistroC100.DNatureza.DesTextoFiscal <> '' then
  begin
    VpfAchou := false;
    VpfPercorreuLacoateoFim := true;
    for VpfLaco := 0 to VpaDSped.Registros0450.Count - 1 do
    begin
      VpfDRegistro0450 := TRBDSpedFiscalRegistro0450(VpaDSped.Registros0450.Items[VpfLaco]);
      if VpaDRegistroC100.DNatureza.SeqNatureza = VpfDRegistro0450.SeqNatureza then
      begin
        VpfAchou := true;
        result := VpfDRegistro0450;
        break;
      end;
      if (VpfDRegistro0450.SeqNatureza >VpaDRegistroC100.DNatureza.SeqNatureza) or
         (VpfDRegistro0450.SeqNatureza = 0) then
      begin
        VpfPercorreuLacoateoFim := false;
        Break;
      end;
    end;
    if not VpfAchou then
    begin
      Result := TRBDSpedFiscalRegistro0450.cria;
      if VpfPercorreuLacoateoFim  then
        VpaDSped.Registros0450.add(Result)
      else
        VpaDSped.Registros0450.Insert(VpfLaco,Result);

      Result.CodInformacao := VpaDSped.Registros0450.Count +1;
      Result.SeqNatureza := VpaDRegistroC100.DNatureza.SeqNatureza;
      Result.DesInformacao := VpaDRegistroC100.DNatureza.DesTextoFiscal;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesSpedFiscal.RRegistroC490(VpaDSped: TRBDSpedFiscal; VpaCodCST, VpaCodCFOP: Integer;VpaPerICMS: Double): TRBDSpedFiscalRegistroC490;
var
  VpfLaco : Integer;
  VpfDRegistroC490 : TRBDSpedFiscalRegistroC490;
begin
  result := nil;
  for VpfLaco := 0 to VpaDSped.RegistrosC490.Count - 1 do
  begin
    VpfDRegistroC490 := TRBDSpedFiscalRegistroC490(VpaDSped.RegistrosC490.Items[VpfLaco]);
    if (VpfDRegistroC490.CODCST = VpaCodCST)  and
       (VpfDRegistroC490.CodCFOP = VpaCodCFOP) and
       (VpfDRegistroC490.PerICMS = VpaPerICMS) then
    begin
      result := VpfDRegistroC490;
      break;
    end;
  end;

  if result = nil then
  begin
    Result := VpaDSped.addRegistroC490;
    Result.CODCST := VpaCodCST;
    result.CodCFOP := VpaCodCFOP;
    Result.PerICMS := VpaPerICMS;
  end;
end;

{********************************************************************************}
function TRBFuncoesSpedFiscal.RValICMSRegitroC170Saida(VpaValTotProdutos, VpaPerICMS, VpaPerReducaoBase: Double; VpaDNatureza: TRBDNaturezaOperacao): double;
begin
  if VpaDNatureza.IndCalcularICMS then
    result := ((VpaValTotProdutos -(VpaValTotProdutos*VpaPerReducaoBase/100)) * VpaPerICMS)/100
  else
    result := 0;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.ZeraQtdLinhas(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.QtdLinhasBloco0 := 0;
  VpaDSped.QtdLinhasBlocoC := 0;
  VpaDSped.QtdLinhasBlocoD := 0;
  VpaDSped.QtdLinhasBlocoE := 0;
  VpaDSped.QtdLinhasBlocoG := 0;
  VpaDSped.QtdLinhasBlocoH := 0;
  VpaDSped.QtdLinhasBloco1 := 0;
  VpaDSped.QtdLinhasBloco9 := 0;
  VpaDSped.QtdLinhasRegistro0150 := 0;
  VpaDSped.QtdLinhasRegistro0190 := 0;
  VpaDSped.QtdLinhasRegistro0200 := 0;
  VpaDSped.QtdLinhasRegistro0400 := 0;
  VpaDSped.QtdLinhasRegistro0450 := 0;
  VpaDSped.QtdLinhasRegistroC100 := 0;
  VpaDSped.QtdLinhasRegistroC110 := 0;
  VpaDSped.QtdLinhasRegistroC140 := 0;
  VpaDSped.QtdLinhasRegistroC141 := 0;
  VpaDSped.QtdLinhasRegistroC160 := 0;
  VpaDSped.QtdLinhasRegistroC170 := 0;
  VpaDSped.QtdLinhasRegistroC190 := 0;
  VpaDSped.QtdLinhasRegistroC300 := 0;
  VpaDSped.QtdLinhasRegistroC320 := 0;
  VpaDSped.QtdLinhasRegistroC321 := 0;
  VpaDSped.QtdLinhasRegistroC400 := 0;
  VpaDSped.QtdLinhasRegistroC405 := 0;
  VpaDSped.QtdLinhasRegistroC420 := 0;
  VpaDSped.QtdLinhasRegistroC425 := 0;
  VpaDSped.QtdLinhasRegistroD100 := 0;
  VpaDSped.QtdLinhasRegistroE116 := 0;
  VpaDSped.QtdLinhasRegistroE510 := 0;
end;

end.
