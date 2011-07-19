Unit UnVendedor;
{Verificado
-.edit;
}
Interface

Uses Classes,  SysUtils,IdMessage, IdSMTP, UnDados, UnSistema, Constantes,IdEMailAddress,
    UnProdutos,IdAttachmentfile, idText,SQLExpr,db;

//classe localiza
Type TRBLocalizaVendedor = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesVendedor = class(TRBLocalizaVendedor)
  private
    Aux,
    Tabela,
    Vendedores : TSQLQuery;
    VprMensagem : TidMessage;
    VprSMTP : TIdSMTP;
    VprLog : TStrings;
    procedure PosProdutosPositivo(VpaTabela : TDataSet;VpaCodFilial : Integer);
    procedure PosVendedores(VpaTabela : TDataSet;VpaCodVendedor : Integer);
    procedure PosEntradaMetros(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer);
    procedure PosEntradaPedidos(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer);
    procedure PosNotasFiscaisFaturadas(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer);
    procedure MontaCabecalhoFilial(VpaTexto : TStrings;VpaDFilial : TRBDFilial);
    procedure MontaEmailHTMLPosEstoque(VpaTexto : TStrings;VpaDFilial : TRBDFilial);
    procedure MontaEmailHTMLResumoVendedor(VpaTexto : TStrings;VpaDFilial : TRBDFilial;VpaDatInicio, VpaDatFim : TDateTime; VpaCodVendedor : Integer;VpaNomVendedor : String);
    procedure MontaEmailHTMLResumoNomeVendedor(VpaTexto : TStrings;VpaNomVendedor : String;VpaDatInicio, VpaDatFim : TDateTime);
    procedure MontaEmailHTMLEntradaMetros(VpaTexto : TStrings;VpaDatInicio, VpaDatFim : TDateTime;VpaCodVendedor : Integer);
    procedure MontaEmailHTMLEntradaPedidos(VpaTexto : TStrings;VpaDatInicio, VpaDatFim : TDateTime;VpaCodVendedor : Integer);
    procedure MontaEmailHTMLNotasFaturadas(VpaTexto : TStrings;VpaDatInicio, VpaDatFim : TDateTime;VpaCodVendedor : Integer);
    procedure AdicionaEmailVendedores(VpaCodVendedor : Integer;VpaMensagem : TIdMessage);
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial) : string;
    procedure AdicionaLog(VpaTexto : String);
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    function RNomVendedor(VpaCodVendedor : String):String;
    function RQtdClientesVendedor(VpaCodVendedor : String) : Integer;
    function RTipComissao(VpaCodVendedor : Integer):Integer;
    function RPerComissaoVendedorClassificacao(VpaCodEmpresa,VpaCodVendedor : Integer;VpaCodClassificacao,VpaTipClassificacao : string):Double;
    function RPerComissao(VpaCodVendedor : Integer) : Double;
    function EnviaPosicaoEstoqueEmail(VpaCodVendedor : Integer;VpaDesLog : TStrings):string;
    function EnviaResumoDiarioEmail(VpaCodVendedor : Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaDesLog : TStrings):string;
    procedure CarDVendedor(VpaDVendedor : TRBDVendedor;VpaCodVendedor : Integer);
    function RValMetaVendedor(VpaCodVendedor : Integer;VpaDatInicio, VpaDatFim : TDateTime):Double;
    function RValContasaReceberEmissaoVendedor(VpaCodFilial, VpaCodVendedor : Integer; VpaDatInicio, VpaDatFim : TDateTime):double;
    function RValContasaReceberEmissaoVendedoresInativos(VpaCodFilial : Integer;VpaDatInicio, VpaDatFim : TDateTime):double;
    function RValContasaReceberEmissaoSemVendedor(VpaCodFilial : Integer; VpaDatInicio, VpaDatFim : TDateTime):double;
end;

Var
  FunVendedor : TRBFuncoesVendedor;


implementation

Uses FunSql, FunNumeros, Fundata, FunString;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaVendedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaVendedor.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesVendedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesVendedor.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Aux := TSQLQuery.create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  Vendedores := TSQLQuery.create(nil);
  Vendedores.SQLConnection := VpaBaseDados;
  //componentes indy
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);
end;

{******************************************************************************}
destructor TRBFuncoesVendedor.destroy;
begin
  Aux.Free;
  Vendedores.free;
  Tabela.free;
  VprMensagem.free;
  VprSMTP.free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.PosProdutosPositivo(VpaTabela : TDataSet;VpaCodFilial : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select CLA.C_COD_CLA, CLA.C_NOM_CLA, '+
                                  ' PRO.C_COD_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO, '+
                                  ' QTD.N_QTD_PRO, QTD.I_COD_COR '+
                                  ' from CADPRODUTOS PRO, CADCLASSIFICACAO CLA, MOVQDADEPRODUTO QTD '+
                                  ' Where PRO.I_SEQ_PRO = QTD.I_SEQ_PRO '+
                                  ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' AND PRO.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' AND QTD.N_QTD_PRO > 0 '+
                                  ' and QTD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' ORDER BY CLA.C_COD_CLA, PRO.C_NOM_PRO');
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.PosVendedores(VpaTabela : TDataSet;VpaCodVendedor : Integer);
begin
  LimpaSqlTabela(VpaTabela);
  AdicionaSqlTabela(VpaTabela,'Select I_COD_VEN,  C_NOM_VEN, C_DES_EMA '+
                    ' from CADVENDEDORES ');
  if VpaCodVendedor <> 0 then
    AdicionaSqlTabela(VpaTabela,'Where I_COD_VEN = '+IntToStr(VpaCodVendedor))
  else
    AdicionaSqlTabela(VpaTabela,'Where C_IND_ATI = ''S''');
  VpaTabela.OPEN;
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.PosEntradaMetros(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime; VpaCodVendedor : Integer);
begin
  LimpaSqlTabela(VpaTabela);
  AdicionaSqlTabela(VpaTabela,'SELECT  CAD.D_DAT_ORC, CAD.I_TIP_ORC, '+
                    ' MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.C_COD_PRO, MOV.N_VLR_TOT, '+
                    ' PRO.C_COD_CLA, PRO.C_NOM_PRO, PRO.I_CMP_PRO, PRO.I_COD_EMP '+
                    ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                    ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                    ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                    ' AND CAD.C_IND_CAN = ''N'''+
                    ' AND CAD.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                    ' AND CAD.D_DAT_ORC <= '+SQLTextoDataAAAAMMMDD(VpaDatFim));
  if VpaCodVendedor <> 0 then
    AdicionaSqlTabela(VpaTabela,'and CAD.I_COD_VEN = '+IntToStr(VpaCodVendedor));
  AdicionaSqlTabela(VpaTabela,'ORDER BY PRO.C_COD_CLA');
  VpaTabela.open;
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.PosEntradaPedidos(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer);
begin
  LimpaSQLTabela(VpaTabela);
  AdicionaSqlTabela(VpaTabela,'SELECT CAD.D_DAT_ORC,CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.D_DAT_PRE, CAD.C_ORD_COM, CAD.I_VEN_PRE, CAD.I_COD_ATE, '+
                    ' CAD.N_VLR_TOT, '+
                    ' CLI.C_NOM_CLI, '+
                    ' PAG.C_NOM_PAG, '+
                    ' VEN.C_NOM_VEN, '+
                    ' TRA.C_NOM_CLI C_NOM_TRA, '+
                    ' TIP.C_NOM_TIP, '+
                    ' MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.C_COD_PRO, MOV.N_VLR_TOT TOTALPRODUTO, MOV.I_COD_COR, '+
                    ' MOV.N_VLR_PRO, MOV.C_PRO_REF, '+
                    ' PRO.C_NOM_PRO, PRO.I_CMP_PRO, PRO.I_COD_EMP '+
                    ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADPRODUTOS PRO, CADCLIENTES CLI, CADCONDICOESPAGTO PAG, '+
                    ' CADVENDEDORES VEN, CADCLIENTES TRA, CADTIPOORCAMENTO TIP '+
                    ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                    ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                    ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                    ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                    ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_CLI')+
                    ' AND CAD.I_TIP_ORC = TIP.I_COD_TIP '+
                    ' AND CAD.C_IND_CAN = ''N'''+
                    ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                    ' AND CAD.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                    ' AND CAD.D_DAT_ORC <= '+SQLTextoDataAAAAMMMDD(VpaDatFim));
  if VpaCodVendedor <> 0 then
    AdicionaSqlTabela(VpaTabela,'and CAD.I_COD_VEN = '+IntToStr(VpaCodVendedor));
  AdicionaSqlTabela(VpaTabela,'ORDER BY CAD.D_DAT_ORC, CAD.I_LAN_ORC');
  VpaTabela.open;
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.PosNotasFiscaisFaturadas(VpaTabela: TDataSet;VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor: Integer);
begin
  AdicionaSqlAbreTabeLa(VpaTabela,'select CAD.D_DAT_EMI, CAD.C_COD_NAT, CAD.I_NRO_NOT, CAD.N_TOT_NOT, CAD.C_TIP_NOT,' +
                             ' CAD.N_VLR_ICM, CAD.N_TOT_IPI, CAD.C_NOT_IMP, CAD.C_NOT_CAN, CAD.C_FIN_GER, ' +
                             ' CAD.N_TOT_PRO, '+
                             ' CLI.C_NOM_CLI ' +
                             ' from CADNOTAFISCAIS CAD, CADCLIENTES CLI ' +
                             ' WHERE CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                             ' AND CAD.D_DAT_EMI BETWEEN '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                             ' AND ' +SQLTextoDataAAAAMMMDD(VpaDatFim)+
                             ' AND CAD.I_COD_VEN = ' + IntToStr(VpaCodVendedor) +
                             'ORDER BY CAD.D_DAT_EMI, CAD.I_NRO_NOT ');
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.MontaCabecalhoFilial(VpaTexto : TStrings;VpaDFilial : TRBDFilial);
var
  Vpfbmppart : TIdAttachmentFile;
begin
  Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDFilial.CodFilial)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDFilial.CodFilial)+'.jpg';
  Vpfbmppart.DisplayName := inttoStr(VpaDFilial.CodFilial)+'.jpg';

  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+VpaDFilial.NomFilial+' - Resumo Vendedor');
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('    <td width='+IntToStr(varia.CRMTamanhoLogo)+' bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <a href="http://'+VpaDFilial.DesSite+ '">');
  VpaTexto.add('      <IMG src="cid:'+IntToStr(VpaDFilial.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+'border="0" >');
  VpaTexto.add('    </a></td> <td bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <b>'+VpaDFilial.NomFilial+ '.</b>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesEndereco+'              Bairro : '+VpaDFilial.DesBairro);
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesCidade +' / '+VpaDFilial.DesUF+ '                CEP : '+VpaDFilial.DesCep);
  VpaTexto.add('    <br>');
  VpaTexto.add('    Fone : '+VpaDFilial.DesFone +'         -             e-mail comercial :'+VpaDFilial.DesEmailComercial);
  VpaTexto.add('    <br>');
  VpaTexto.add('    CNPJ : '+VpaDFilial.DesCNPJ +'         -             Inscrição Estadual :'+VpaDFilial.DesInscricaoEstadual);
  VpaTexto.add('    <br>');
  VpaTexto.add('    site : <a href="http://'+VpaDFilial.DesSite+'">'+VpaDFilial.DesSite);
  VpaTexto.add('    </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('</left>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <br>');
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.MontaEmailHTMLPosEstoque(VpaTexto : TStrings;VpaDFilial : TRBDFilial);
Var
  VpfCodClassificacao : String;
begin
  PosProdutosPositivo(Tabela,VpaDFilial.CodFilial);
  VpfCodClassificacao := '';
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+VpaDFilial.NomFilial+' -Posição de Estoque');
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  VpaTexto.add('<b>Filial : '+IntToStr(VpaDFilial.CodFilial)+' - '+ VpaDFilial.NomFilial+'</b>');
  VpaTexto.add('<hr>');
  While not Tabela.eof do
  begin
    if VpfCodClassificacao <> Tabela.FieldByName('C_COD_CLA').AsString then
    begin
      if VpfCodClassificacao <> '' then
      begin
        VpaTexto.add('</table>');
        VpaTexto.add('<br>');
      end;
      VpaTexto.add('<br>');
      VpaTexto.add('<b>'+Tabela.FieldByName('C_COD_CLA').AsString+'-'+Tabela.FieldByName('C_NOM_CLA').AsString+'</b>');
      VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
      VpaTexto.add('  <tr>');
      VpaTexto.add('  <td width="15%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Código</td>');
      VpaTexto.add('  <td width="50%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Nome</td>');
      VpaTexto.add('  <td width="17%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Cor</td>');
      VpaTexto.add('  <td width="3%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>UM</td>');
      VpaTexto.add('  <td width="15%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Quantidade</td>');
      VpaTexto.add('  </tr>');
      VpfCodClassificacao := Tabela.FieldByName('C_COD_CLA').AsString;
    end;
    VpaTexto.add('  <tr>');
    VpaTexto.add('  <td width="15%" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">'+Tabela.FieldByName('C_COD_PRO').AsString+'</td>');
    VpaTexto.add('  <td width="50%" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">'+Tabela.FieldByName('C_NOM_PRO').AsString+'</td>');
    VpaTexto.add('  <td width="17%" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">&nbsp;</td>');
    VpaTexto.add('  <td width="3%" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">'+Tabela.FieldByName('C_COD_UNI').AsString+'</td>');
    VpaTexto.add('  <td width="15%" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">'+FormatFloat(vARIA.MascaraQtd,Tabela.FieldByName('N_QTD_PRO').AsFloat)+'</td>');
    VpaTexto.add('  </tr>');
    Tabela.next;
  end;
  if VpfCodClassificacao <> '' then
    VpaTexto.add('</table>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.MontaEmailHTMLResumoVendedor(VpaTexto : TStrings;VpaDFilial : TRBDFilial; VpaDatInicio, VpaDatFim : TDateTime;VpaCodVendedor : Integer;VpaNomVendedor : String);
begin
  MontaCabecalhoFilial(VpaTexto,VpaDFilial);
  MontaEmailHTMLResumoNomeVendedor(VpaTexto,VpaNomVendedor, VpaDatInicio,VpaDatFim);
  if config.NasInformacoesGerenciaisEnviarEntradaMetros then
    MontaEmailHTMLEntradaMetros(VpaTexto,VpaDatInicio,VpaDatFim, VpaCodVendedor);
  MontaEmailHTMLEntradaPedidos(VpaTexto,VpaDatInicio,VpaDatFim, VpaCodVendedor);
  MontaEmailHTMLNotasFaturadas(VpaTexto,VpaDatInicio,VpaDatFim, VpaCodVendedor);

  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
  VpaTexto.Text := RetiraAcentuacaoHTML(VpaTexto.Text);
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.MontaEmailHTMLResumoNomeVendedor(VpaTexto : TStrings;VpaNomVendedor : String;VpaDatInicio, VpaDatFim : TDateTime);
var
  VpfDia : string;
begin
  if  VpaDatInicio = VpaDatFim then
    VpfDia := FormatDateTime('DD/MM/YYYY',VpaDatInicio)
  else
    VpfDia := FormatDateTime('DD/MM/YY',VpaDatInicio)+'-'+FormatDateTime('DD/MM/YY',VpaDatFim);
  VpaTexto.add('<br>');
  VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
  VpaTexto.add('  <tr>');
  VpaTexto.add('  <td width="78%" align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>'+VpaNomVendedor+'</td>');
  VpaTexto.add('  <td width="22%" align="center" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3"><b>'+VpfDia+'</td>');
  VpaTexto.add('  </tr></table>');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.MontaEmailHTMLEntradaMetros(VpaTexto : TStrings;VpaDatInicio, VpaDatFim : TDateTime; VpaCodVendedor : Integer);
var
  VpfCodClassificacao, VpfErro : String;
  VpfCodEmpresa : Integer;
  VpfMetrosAmostra, VpfMetrosPedido, VpfMetrosItem, VpfValorAmostra, VpfValorPedido, VpfValorItem : Double;
  VpfTotalMetros, VpfValorTotal, VpfTotalAmostras, VpfMetrosTotalPedidos, VpfValTotalPedidos : Double;
begin
  VpfTotalAmostras := 0;
  VpfValorTotal :=0;
  VpfMetrosTotalPedidos := 0;
  VpfValTotalPedidos := 0;
  VpfTotalMetros := 0;
  PosEntradaMetros(Tabela,VpaDatInicio,VpaDatFim,VpaCodVendedor);
  VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
  VpaTexto.add('  <tr>');
  VpaTexto.add('  <td colspan="7"  align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="4"><b>Entrada Metros</td>');
  VpaTexto.add('  </tr><tr>');
  VpaTexto.add('  <td width="22%"  bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>Familia</td>');
  VpaTexto.add('  <td colspan="2"  bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3">'+
               ' <table border = 1 cellpadding="0" cellspacing="0" width=100%  >'+
               '  <tr>'+
               '  <td colspan="2"  align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>Amostras</td>'+
               '  </tr><tr>'+
               '  <td width="50%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Metros</td>'+
               '  <td width="50%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Valor</td>'+
               ' </tr>'+
               ' </table></td>');
  VpaTexto.add('  <td colspan="2"  align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3">'+
               ' <table border = 1 cellpadding="0" cellspacing="0" width=100%  >'+
               '  <tr>'+
               '  <td colspan="2"  align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>Pedidos</td>'+
               '  </tr><tr>'+
               '  <td width="50%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Metros</td>'+
               '  <td width="50%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Valor</td>'+
               ' </tr>'+
               ' </table></td>');
  VpaTexto.add('  <td colspan="2"  bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3">'+
               ' <table border = 1 cellpadding="0" cellspacing="0" width=100%  >'+
               '  <tr>'+
               '  <td colspan="2"  align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>Total</td>'+
               '  </tr><tr>'+
               '  <td width="50%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Metros</td>'+
               '  <td width="50%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Valor</td>'+
               ' </tr>'+
               ' </table></td>');
  VpaTexto.add('  </tr>');
  VpfCodClassificacao := '';
  While not Tabela.eof do
  begin
    if VpfCodClassificacao <> copy(Tabela.FieldByName('C_COD_CLA').AsString,1,Varia.QuantidadeLetrasClassificacaProdutoUnidadeFabricacao) then
    begin
     if VpfCodClassificacao <> '' then
      begin
        VpaTexto.add('  </tr><tr>');
        VpaTexto.add('  <td width="22%"  bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FunProdutos.RNomeClassificacao(VpfCodEmpresa,VpfCodClassificacao) +'</td>');
        VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfMetrosAmostra) +'</td>');
        VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfValorAmostra) +'</td>');
        VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfMetrosPedido) +'</td>');
        VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfValorPedido) +'</td>');
        VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfMetrosItem) +'</td>');
        VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfValorItem) +'</td>');
      end;
      VpfMetrosAmostra := 0;
      VpfMetrosPedido := 0;
      VpfMetrosItem := 0;
      VpfValorAmostra := 0;
      VpfValorPedido := 0;
      VpfValorItem := 0;
      VpfCodClassificacao := copy(Tabela.FieldByName('C_COD_CLA').AsString,1,Varia.QuantidadeLetrasClassificacaProdutoUnidadeFabricacao);
      VpfCodEmpresa := Tabela.FieldByName('I_COD_EMP').AsInteger;
    end;
    if Tabela.FieldByName('I_TIP_ORC').AsInteger = Varia.TipoCotacaoAmostra then
    begin
      VpfValorAmostra := VpfValorAmostra + ArredondaDecimais(Tabela.FieldByName('N_VLR_TOT').AsFloat,2);
      VpfMetrosAmostra := VpfMetrosAmostra +FunProdutos.RQtdMetrosFita(Tabela.FieldByName('C_COD_PRO').AsString,Tabela.FieldByName('C_NOM_PRO').AsString,Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
      VpfTotalAmostras := VpfTotalAmostras + FunProdutos.RQtdMetrosFita(Tabela.FieldByName('C_COD_PRO').AsString,Tabela.FieldByName('C_NOM_PRO').AsString,Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
    end
    else
    begin
      VpfValorPedido := VpfValorPedido + ArredondaDecimais(Tabela.FieldByName('N_VLR_TOT').AsFloat,2);
      VpfMetrosPedido := VpfMetrosPedido + FunProdutos.RQtdMetrosFita(Tabela.FieldByName('C_COD_PRO').AsString,Tabela.FieldByName('C_NOM_PRO').AsString,Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
      VpfMetrosTotalPedidos := VpfMetrosTotalPedidos + FunProdutos.RQtdMetrosFita(Tabela.FieldByName('C_COD_PRO').AsString,Tabela.FieldByName('C_NOM_PRO').AsString,Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
      VpfValTotalPedidos := VpfValTotalPedidos +ArredondaDecimais(Tabela.FieldByName('N_VLR_TOT').AsFloat,2);
    end;

    VpfValorItem := VpfValorItem + ArredondaDecimais(Tabela.FieldByName('N_VLR_TOT').AsFloat,2);
    VpfMetrosItem := VpfMetrosItem+FunProdutos.RQtdMetrosFita(Tabela.FieldByName('C_COD_PRO').AsString,Tabela.FieldByName('C_NOM_PRO').AsString,Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
    VpfTotalMetros := VpfTotalMetros +FunProdutos.RQtdMetrosFita(Tabela.FieldByName('C_COD_PRO').AsString,Tabela.FieldByName('C_NOM_PRO').AsString,Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
    VpfValorTotal := VpfValorTotal +ArredondaDecimais(Tabela.FieldByName('N_VLR_TOT').AsFloat,2);

    if VpfErro <> '' then
      VpaTexto.Add(VpfErro);
    Tabela.next;
  end;

  if VpfCodClassificacao <> '' then
  begin
    VpaTexto.add('  </tr><tr>');
    VpaTexto.add('  <td width="22%"  bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FunProdutos.RNomeClassificacao(VpfCodEmpresa,VpfCodClassificacao) +'</td>');
    VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfMetrosAmostra) +'</td>');
    VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfValorAmostra) +'</td>');
    VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfMetrosPedido) +'</td>');
    VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfValorPedido) +'</td>');
    VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfMetrosItem) +'</td>');
    VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3">'+FormatFloat('###,###,##0.00',VpfValorItem) +'</td>');
  end;
  VpaTexto.add('  </tr><tr>');
  VpaTexto.add('  <td width="22%"  bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3"><b>Total</td>');
  VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3"><b>'+FormatFloat('###,###,##0.00',VpfTotalAmostras) +'</td>');
  VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3"><b>'+FormatFloat('###,###,##0.00',VpfValorAmostra) +'</td>');
  VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3"><b>'+FormatFloat('###,###,##0.00',VpfMetrosTotalPedidos) +'</td>');
  VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3"><b>'+FormatFloat('###,###,##0.00',VpfValTotalPedidos) +'</td>');
  VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3"><b>'+FormatFloat('###,###,##0.00',VpfTotalMetros) +'</td>');
  VpaTexto.add('  <td width="13%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="3"><b>'+FormatFloat('###,###,##0.00',VpfValorTotal) +'</td>');
  VpaTexto.add('</table>');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.MontaEmailHTMLEntradaPedidos(VpaTexto : TStrings;VpaDatInicio, VpaDatFim : TDateTime;VpaCodVendedor : Integer);
var
  VpfData : TDateTime;
  VpfCodFilial, VpfLanOrcamento : Integer;
  VpfValTotalPedido, VpfMetrosPedido, VpfMetrosDia, VpfTotalDia, VpfMetrosPeriodo, VpfTotalPeriodo : Double;
  VpfErro :String;
begin
  VpfData := Montadata(1,1,1900);
  VpfLanOrcamento := 0;
  VpfCodFilial := 0;
  VpfMetrosPedido := 0;
  VpfMetrosDia := 0;
  VpfTotalDia := 0;
  VpfMetrosPeriodo := 0;
  VpfTotalPeriodo := 0;
  VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
  VpaTexto.add('  <tr>');
  VpaTexto.add('  <td align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="4"><b>Entrada Pedidos</td>');
  VpaTexto.add('  </tr></table>');

  PosEntradaPedidos(Tabela,VpaDatInicio,VpaDatFim,VpaCodVendedor);
  While not Tabela.eof do
  begin
    if (VpfLanOrcamento <> Tabela.FieldByName('I_LAN_ORC').AsInteger) or
       (VpfCodFilial <> Tabela.FieldByName('I_EMP_FIL').AsInteger) then
    begin
      if VpfData <> Tabela.FieldByName('D_DAT_ORC').AsDateTime then
      begin
        if VpfData <> montadata(1,1,1900) then
        begin
          VpaTexto.add('</tr></table></tr></table>');
          VpaTexto.add('<br>');
          VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
          if Config.NasInformacoesGerenciaisEnviarEntradaMetros then
          begin
            VpaTexto.add('  <tr>');
            VpaTexto.add('  <td align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Total Metros dia '+FormatDateTime('DD/MM/YY',VpfData)+ ' : '+FormatFloat('#,###,###,##0.00',VpfMetrosDia) +'</td>');
            VpaTexto.add('  </tr>');
          end;
          VpaTexto.add('  <tr>');
          VpaTexto.add('  <td align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Valor Total dia '+FormatDateTime('DD/MM/YY',VpfData)+ ' : '+FormatFloat('R$ #,###,###,##0.00',VpfTotalDia) +'</td>');
          VpaTexto.add('  </tr></table>');
          VpfMetrosDia := 0;
          VpfTotalDia := 0;
        end;
        VpaTexto.add('<br>');
        VpaTexto.add('<b>'+FormatDateTime('DD/MM/YYYY',Tabela.FieldByName('D_DAT_ORC').AsDateTime)+'</b>');
        VpfData := Tabela.FieldByName('D_DAT_ORC').AsDateTime;
      end
      else
        if VpfLanOrcamento <> 0 then
        begin
          VpaTexto.add('</tr></table></tr><tr>');
          VpaTexto.add('<td colspan="6"  bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"> <table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
          VpaTexto.add('<td width="20%"  align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">Total Metros</td>');
          VpaTexto.add('<td width="30%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2"><b>'+FormatFloat('###,###,##0.00',VpfMetrosPedido)+'</td>');
          VpaTexto.add('<td width="20%"  align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">Total Pedido</td> ');
          VpaTexto.add('<td width="30%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2"><b>'+FormatFloat('###,###,##0.00',VpfValTotalPedido)+'</td>');
          VpaTexto.add('</tr></table></tr>');
          VpaTexto.add('</table>');
          VpaTexto.add('<br>');
        end;
      VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
      VpaTexto.add('  <tr>');
      VpaTexto.add('  <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>'+Tabela.FieldByName('C_NOM_TIP').AsString+'</b>&nbsp;</td>');
      VpaTexto.add('  <td width="15%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+Tabela.FieldByName('I_LAN_ORC').AsString +'</td>');
      VpaTexto.add('  <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">Cliente&nbsp;</td>');
      VpaTexto.add('  <td width="35%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+Tabela.FieldByName('C_NOM_CLI').AsString +'</td>');
      VpaTexto.add('  <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">Vendedor&nbsp;</td>');
      VpaTexto.add('  <td width="20%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+Tabela.FieldByName('C_NOM_VEN').AsString +'</td>');
      VpaTexto.add('  </tr><tr>');
      VpaTexto.add('  <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">Entrega&nbsp;</td>');
      VpaTexto.add('  <td width="15%"  align="center" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_PRE').AsDateTime) +'</td>');
      VpaTexto.add('  <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">Cond. Pgto&nbsp;</td>');
      VpaTexto.add('  <td width="35%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+Tabela.FieldByName('C_NOM_PAG').AsString +'</td>');
      VpaTexto.add('  <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">Preposto&nbsp;</td>');
      VpaTexto.add('  <td width="20%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">&nbsp;'+RNomVendedor(Tabela.FieldByName('I_VEN_PRE').AsString) +'</td>');
      VpaTexto.add('  </tr><tr>');
      VpaTexto.add('  <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">Ord Compra&nbsp;</td>');
      VpaTexto.add('  <td width="15%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+Tabela.FieldByName('C_ORD_COM').AsString +'</td>');
      VpaTexto.add('  <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">Transportadora&nbsp;</td>');
      VpaTexto.add('  <td width="35%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+Tabela.FieldByName('C_NOM_TRA').AsString +'</td>');
      VpaTexto.add('  <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">Atendente&nbsp;</td>');
      VpaTexto.add('  <td width="20%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">&nbsp;'+RNomVendedor(Tabela.FieldByName('I_COD_ATE').AsString) +'</td>');
      VpaTexto.add('  </tr><tr>');
      VpaTexto.add('  <td colspan="6"  align="Center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>PRODUTOS </b></td> ');
      VpaTexto.add('  </tr><tr>');
      VpaTexto.add('  <td colspan="6"  bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">'+
                   ' <table border = 1 cellpadding="0" cellspacing="0" width=100%  >' );
      VpaTexto.add('   <tr>');
      VpaTexto.add('   <td width="10%"  align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Código</td>');
      VpaTexto.add('   <td width="31%"  align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Produto</td>');
      VpaTexto.add('   <td width="10%"  align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Cor</td>');
      VpaTexto.add('   <td width="10%"  align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Ref Cliente</td>');
      VpaTexto.add('   <td width="4%"  align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>UM</td>');
      VpaTexto.add('   <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Qtd</td>');
      VpaTexto.add('   <td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Val Unitario</td>');
      VpaTexto.add('   <td width="15%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>Val Total</td>');
      VpfLanOrcamento := Tabela.FieldByName('I_LAN_ORC').AsInteger;
      VpfCodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
      VpfValTotalPedido := Tabela.FieldByName('N_VLR_TOT').AsFloat;
      VpfMetrosPedido := 0;
      VpfTotalDia := VpfTotalDia + VpfValTotalPedido;
      VpfTotalPeriodo := VpfTotalPeriodo + VpfValTotalPedido;
    end;
    VpaTexto.add('   </tr><tr>');
    VpaTexto.add('   <td width="10%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">'+Tabela.FieldByName('C_COD_PRO').AsString+'</td>');
    VpaTexto.add('   <td width="31%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">'+Tabela.FieldByName('C_NOM_PRO').AsString +'</td>');
    VpaTexto.add('   <td width="10%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">&nbsp;'+FunProdutos.RNomeCor(Tabela.FieldByName('I_COD_COR').AsString) +'</td>');
    VpaTexto.add('   <td width="10%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">&nbsp;'+Tabela.FieldByName('C_PRO_REF').AsString+'</td>');
    VpaTexto.add('   <td width="4%"  align="center" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">'+Tabela.FieldByName('C_COD_UNI').AsString+'</td>');
    VpaTexto.add('   <td width="10%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">'+FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_QTD_PRO').AsFloat) +'</td>');
    VpaTexto.add('   <td width="10%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">'+FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_VLR_PRO').AsFloat) +'</td>');
    VpaTexto.add('   <td width="15%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="1">'+FormatFloat('#,###,###,##0.00',Tabela.FieldByName('TOTALPRODUTO').AsFloat) +'</td>');
    VpfMetrosPedido := VpfMetrosPedido +FunProdutos.RQtdMetrosFita(Tabela.FieldByName('C_COD_PRO').AsString,Tabela.FieldByName('C_NOM_PRO').AsString,Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
    VpfMetrosDia := VpfMetrosDia +FunProdutos.RQtdMetrosFita(Tabela.FieldByName('C_COD_PRO').AsString,Tabela.FieldByName('C_NOM_PRO').AsString,Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
    VpfMetrosPeriodo := VpfMetrosPeriodo +FunProdutos.RQtdMetrosFita(Tabela.FieldByName('C_COD_PRO').AsString,Tabela.FieldByName('C_NOM_PRO').AsString,Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
    Tabela.next;
  end;
  if VpfData <> montadata(1,1,1900) then
  begin
    VpaTexto.add('</tr></table></tr><tr>');
    VpaTexto.add('<td colspan="6"  bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"> <table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
    VpaTexto.add('<td width="20%"  align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">Total Metros</td>');
    VpaTexto.add('<td width="30%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2"><b>'+FormatFloat('###,###,##0.00',VpfMetrosPedido)+'</td>');
    VpaTexto.add('<td width="20%"  align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">Total Pedido</td> ');
    VpaTexto.add('<td width="30%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2"><b>'+FormatFloat('###,###,##0.00',VpfValTotalPedido)+'</td>');
    VpaTexto.add('</tr></table></tr>');
    VpaTexto.add('</table>');
    VpaTexto.add('<br>');
    VpaTexto.add('</tr></table></tr></table>');
    VpaTexto.add('<br>');
    VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
    VpaTexto.add('  <tr>');
    VpaTexto.add('  <td align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Total Metros dia '+FormatDateTime('DD/MM/YY',VpfData)+ ' : '+FormatFloat('#,###,###,##0.00',VpfMetrosDia) +'</td>');
    VpaTexto.add('  </tr><tr>');
    VpaTexto.add('  <td align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Valor Total dia '+FormatDateTime('DD/MM/YY',VpfData)+ ' : '+FormatFloat('R$ #,###,###,##0.00',VpfTotalDia) +'</td>');
    VpaTexto.add('  </tr></table>');
    VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0" width=100%  >');
    VpaTexto.add('  <tr>');
    VpaTexto.add('  <td align="center" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2"><b>Total Metros Período : '+FormatFloat('#,###,###,##0.00',VpfMetrosPeriodo) +'</td>');
    VpaTexto.add('  </tr><tr>');
    VpaTexto.add('  <td align="center" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2"><b>Valor Total Período : '+FormatFloat('R$ #,###,###,##0.00',VpfTotalPeriodo) +'</td>');
    VpaTexto.add('  </tr></table>');
    VpfMetrosDia := 0;
    VpfTotalDia := 0;
  end;

end;

{******************************************************************************}
procedure TRBFuncoesVendedor.MontaEmailHTMLNotasFaturadas(VpaTexto: TStrings;VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor: Integer);
var
  VpfItem : Integer;
  VpfTotalFinanceiro, VpfTotalNotas :Double;
begin
  VpfItem := 0;
  VpfTotalFinanceiro := 0;
  VpfTotalNotas :=0;
  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
  VpaTexto.add('<table border = 1 cellpadding="0" cellspacing="0"  width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('  <td align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="4"><b>Notas Fiscais Faturadas</td>');
  VpaTexto.add('  </tr></table>');
  VpaTexto.add('<table><tr>');
  VpaTexto.add('<td width="4%"   align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Item </td>');
  VpaTexto.add('<td width="10%"  align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Emissao</td>');
  VpaTexto.add('<td width="10%"  align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b> Nat Ope</td>');
  VpaTexto.add('<td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Nota </td>');
  VpaTexto.add('<td width="48%"  align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b> Cliente</td>');
  VpaTexto.add('<td width="15%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Valor </td>');
  VpaTexto.add('<td width="3%"   align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b>Fin</td>');
  VpaTexto.add('<td width="10%"  align="right" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2"><b> Situacao</td>');
  VpaTexto.add('</tr>');

  PosNotasFiscaisFaturadas(Tabela,VpaDatInicio,VpaDatFim,VpaCodVendedor);
  While not Tabela.eof do
  begin
    inc(VpfItem);
    VpaTexto.add('<tr>');
    VpaTexto.add('<td width="4%"   align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+IntToStr(VpfItem)+' </td>');
    VpaTexto.add('<td width="10%"  align="center" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+FormatDateTime('DD/MM/YYYY',Tabela.FieldByName('D_DAT_EMI').AsDateTime)+'</td>');
    VpaTexto.add('<td width="10%"  align="center" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+Tabela.FieldByName('C_COD_NAT').AsString+'</td>');
    VpaTexto.add('<td width="10%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+Tabela.FieldByName('I_NRO_NOT').AsString+'</td>');
    VpaTexto.add('<td width="48%"  align="left" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+Tabela.FieldByName('C_NOM_CLI').AsString+'</td>');
    VpaTexto.add('<td width="15%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+FormatFloat('#,###,##0.00',Tabela.FieldByName('N_TOT_NOT').AsFloat) +'</td>');
    VpaTexto.add('<td width="3%"  align="center" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">'+Tabela.FieldByName('C_FIN_GER').AsString+'</td>');
    if Tabela.FieldByName('C_NOT_CAN').AsString = 'S' then
    begin
      VpaTexto.add('<td width="10%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2">CANCELADA</td>')
    end
    else
    begin
      VpaTexto.add('<td width="10%"  align="right" bgcolor="#'+varia.CRMCorClaraEmail+'"><font face="Verdana" size="2"></td>');
      VpfTotalNotas := VpfTotalNotas + Tabela.FieldByName('N_TOT_NOT').AsFloat;
      if Tabela.FieldByName('C_FIN_GER').AsString = 'S' then
        VpfTotalFinanceiro := VpfTotalFinanceiro + Tabela.FieldByName('N_TOT_NOT').AsFloat
    end;
    VpaTexto.add('</tr>');
    Tabela.next;
  end;
  VpaTexto.add('</table>');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
  VpaTexto.add('<b>Valor Total das Notas Emitidas : '+FormatFloat('#,###,###,##0.00',VpfTotalNotas));
  VpaTexto.add('<br>');
  VpaTexto.add('<b>Valor Total das Notas Geradas Financeiro : '+FormatFloat('#,###,###,##0.00',VpfTotalFinanceiro));
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.AdicionaEmailVendedores(VpaCodVendedor : Integer;VpaMensagem : TIdMessage);
var
  VpfEndereco : TIdEMailAddressItem;
begin
  VpaMensagem.Recipients.Clear;
  PosVendedores(Tabela,VpaCodVendedor);
  while not Tabela.Eof do
  begin
    VpfEndereco := VpaMensagem.Recipients.Add;
    VpfEndereco.Address := Tabela.FieldByName('C_DES_EMA').AsString;
    VpfEndereco.Name := Tabela.FieldByName('C_NOM_VEN').AsString;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
function TRBFuncoesVendedor.EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial) : string;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';
  VpaMensagem.From.Address := VpaDFilial.DesEmailComercial;
  VpaMensagem.From.Name := VpaDFilial.NomFantasia;

  VpaSMTP.UserName := varia.UsuarioSMTP;
  VpaSMTP.Password := Varia.SenhaEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := varia.PortaSMTP;
  VpaSMTP.AuthType := satdefault;


  if VpaMensagem.ReceiptRecipient.Address = '' then
    result := 'E-MAIL DA FILIAL !!!'#13'É necessário preencher o e-mail da filial.';
  if VpaSMTP.UserName = '' then
    result := 'USUARIO DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações o e-mail de origem.';
  if VpaSMTP.Password = '' then
    result := 'SENHA SMTP DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações a senha do e-mail de origem';
  if VpaSMTP.Host = '' then
    result := 'SERVIDOR DE SMTP NÃO CONFIGURADO!!!'#13'É necessário configurar qual o servidor de SMTP...';
  if result = '' then
  begin
    VpaSMTP.Connect;
    try
      VpaSMTP.Send(VpaMensagem);
    except
      on e : exception do
      begin
        result := 'ERRO AO ENVIAR O E-MAIL!!!'#13+e.message;
        VpaSMTP.Disconnect;
      end;
    end;
    VpaSMTP.Disconnect;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesVendedor.AdicionaLog(VpaTexto : String);
begin
  VprLog.Insert(0,VpaTexto);
end;


{******************************************************************************}
procedure TRBFuncoesVendedor.CarDVendedor(VpaDVendedor: TRBDVendedor; VpaCodVendedor: Integer);
begin
  AdicionaSqlAbreTabela(Tabela,'Select * from CADVENDEDORES ' +
                               ' Where I_COD_VEN = '+IntToStr(VpaCodVendedor));
  VpaDVendedor.CodVendedor := VpaCodVendedor;
  VpaDVendedor.NomVendedor := Tabela.FieldByName('C_NOM_VEN').AsString;
  VpaDVendedor.TipComissao := Tabela.FieldByName('I_TIP_COM').AsInteger;
  VpaDVendedor.TipValorComissao := Tabela.FieldByName('I_TIP_VAL').AsInteger;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesVendedor.RNomVendedor(VpaCodVendedor : String):String;
begin
  result := '';
  If VpaCodVendedor <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from CADVENDEDORES'+
                                 ' Where I_COD_VEN = '+VpaCodVendedor);
    result := Aux.FieldByName('C_NOM_VEN').AsString;
    Aux.close;
  end;
end;

{******************************************************************************}
function TRBFuncoesVendedor.RQtdClientesVendedor(VpaCodVendedor : String) : Integer;
begin
  if VpaCodVendedor <> '' then
    AdicionaSQLAbreTabela(Aux,'Select count(*) QTD from  CADCLIENTES '+
                               ' Where I_COD_VEN = '+ VpaCodVendedor+
                               ' AND C_TIP_CAD IN (''C'',''A'')')
  else
    AdicionaSQLAbreTabela(Aux,'Select count(*) QTD from CADCLIENTES ' +
                                 ' Where I_COD_VEN IS NULL '+
                                 ' AND C_TIP_CAD IN (''C'',''A'')');
  result :=  Aux.FieldByName('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesVendedor.RTipComissao(VpaCodVendedor : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_TIP_COM from CADVENDEDORES '+
                               ' Where I_COD_VEN = '+IntToStr(VpaCodVendedor));
  result := Aux.FieldByname('I_TIP_COM').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesVendedor.RValContasaReceberEmissaoSemVendedor(VpaCodFilial : Integer;VpaDatInicio, VpaDatFim: TDateTime): double;
var
  VpfFiltroFilial : string;
begin
  result := 0;
  if VpaCodFilial <> 0 then
    VpfFiltroFilial := ' and CR.I_EMP_FIL = '+IntToStr(VpaCodFilial);
  AdicionaSQLAbreTabela(Aux,'SELECT SUM(CR.N_VLR_TOT) TOTAL ' +
                            ' FROM CADCONTASARECEBER CR ' +
                            ' WHERE CR.I_SEQ_NOT IS NULL '+
                            ' AND CR.I_LAN_ORC IS NULL '+
                            VpfFiltroFilial +
                            SQLTextoDataEntreAAAAMMDD('CR.D_DAT_EMI',VpaDatInicio,VpaDatFim, true));
  result := Aux.FieldByName('TOTAL').AsFloat;
end;

{******************************************************************************}
function TRBFuncoesVendedor.RValContasaReceberEmissaoVendedor(VpaCodFilial, VpaCodVendedor: Integer; VpaDatInicio,
  VpaDatFim: TDateTime): double;
var
  VpfFiltroFilial : string;
begin
  result := 0;
  if VpaCodFilial <> 0 then
    VpfFiltroFilial := ' and CR.I_EMP_FIL = '+IntToStr(VpaCodFilial);
  AdicionaSQLAbreTabela(Aux,'SELECT SUM(CR.N_VLR_TOT) TOTAL ' +
                            ' FROM CADCONTASARECEBER CR , CADORCAMENTOS COT ' +
                            ' WHERE CR.I_EMP_FIL = COT.I_EMP_FIL ' +
                            ' AND CR.I_LAN_ORC = COT.I_LAN_ORC ' +
                            ' AND COT.I_COD_VEN = '+IntToStr(VpaCodVendedor)+
                            VpfFiltroFilial +
                            SQLTextoDataEntreAAAAMMDD('CR.D_DAT_EMI',VpaDatInicio,VpaDatFim, true));
  result := Aux.FieldByName('TOTAL').AsFloat;
  AdicionaSQLAbreTabela(Aux,'SELECT SUM(CR.N_VLR_TOT) TOTAL' +
                            ' FROM CADCONTASARECEBER CR , CADNOTAFISCAIS NOTA ' +
                            ' WHERE CR.I_EMP_FIL = NOTA.I_EMP_FIL ' +
                            ' AND CR.I_SEQ_NOT = NOTA.I_SEQ_NOT ' +
                            ' AND CR.I_LAN_ORC IS NULL ' +
                            ' AND NOTA.I_COD_VEN = '+IntToStr(VpaCodVendedor)+
                            VpfFiltroFilial +
                            SQLTextoDataEntreAAAAMMDD('CR.D_DAT_EMI',VpaDatInicio,VpaDatFim, true));
  result := result +Aux.FieldByName('TOTAL').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesVendedor.RValContasaReceberEmissaoVendedoresInativos(VpaCodFilial : Integer; VpaDatInicio, VpaDatFim: TDateTime): double;
var
  VpfFiltroFilial : string;
begin
  result := 0;
  if VpaCodFilial <> 0 then
    VpfFiltroFilial := ' and CR.I_EMP_FIL = '+IntToStr(VpaCodFilial);
  AdicionaSQLAbreTabela(Aux,'SELECT SUM(CR.N_VLR_TOT) TOTAL ' +
                            ' FROM CADCONTASARECEBER CR , CADORCAMENTOS COT, CADVENDEDORES VEN ' +
                            ' WHERE CR.I_EMP_FIL = COT.I_EMP_FIL ' +
                            ' AND CR.I_LAN_ORC = COT.I_LAN_ORC ' +
                            ' AND COT.I_COD_VEN = VEN.I_COD_VEN ' +
                            ' AND VEN.C_IND_ATI = ''N'''+
                            VpfFiltroFilial +
                            SQLTextoDataEntreAAAAMMDD('CR.D_DAT_EMI',VpaDatInicio,VpaDatFim, true));
  result := Aux.FieldByName('TOTAL').AsFloat;
  AdicionaSQLAbreTabela(Aux,'SELECT SUM(CR.N_VLR_TOT) TOTAL' +
                            ' FROM CADCONTASARECEBER CR , CADNOTAFISCAIS NOTA, CADVENDEDORES VEN ' +
                            ' WHERE CR.I_EMP_FIL = NOTA.I_EMP_FIL ' +
                            ' AND CR.I_SEQ_NOT = NOTA.I_SEQ_NOT ' +
                            ' AND CR.I_LAN_ORC IS NULL ' +
                            ' AND NOTA.I_COD_VEN = VEN.I_COD_VEN '+
                            ' AND VEN.C_IND_ATI = ''N'''+
                            VpfFiltroFilial +
                            SQLTextoDataEntreAAAAMMDD('CR.D_DAT_EMI',VpaDatInicio,VpaDatFim, true));
  result := result +Aux.FieldByName('TOTAL').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesVendedor.RValMetaVendedor(VpaCodVendedor : Integer;VpaDatInicio, VpaDatFim : TDateTime): Double;
Var
  VpfLaco : Integer;
  VpfMesAtual : TDateTime;
begin
  result := 0;
  VpfMesAtual := VpaDatInicio;
  for VpfLaco := 0 to ArredondaPraMaior(MesesPorPeriodo(VpaDatInicio,VpaDatFim)) do
  begin
    AdicionaSQLAbreTabela(Aux,'Select VALMETA FROM METAVENDEDOR ' +
                              ' Where CODVENDEDOR = '+IntToStr(VpaCodVendedor)+
                              ' AND MESMETA = '+IntToStr(Mes(VpfMesAtual))+
                              ' AND ANOMETA = '+IntToStr(ano(VpfMesAtual)));
    Result := result + Aux.FieldByName('VALMETA').AsFloat;
    VpfMesAtual := incmes(VpfMesAtual,1);
    Aux.Close;
  end;
end;

{******************************************************************************}
function TRBFuncoesVendedor.RPerComissaoVendedorClassificacao(VpaCodEmpresa,VpaCodVendedor : Integer;VpaCodClassificacao,VpaTipClassificacao : string):Double;
begin
  AdicionaSQLAbreTabela(Aux,'Select PERCOMISSAO FROM COMISSAOCLASSIFICACAOVENDEDOR '+
                               ' Where CODEMPRESA = '+IntToStr(VpaCodEmpresa)+
                               ' AND CODVENDEDOR = '+IntToStr(VpaCodVendedor)+
                               ' AND CODCLASSIFICACAO = '''+VpaCodClassificacao+''''+
                               ' AND TIPCLASSIFICACAO = '''+VpaTipClassificacao+'''');
  result := Aux.FieldByname('PERCOMISSAO').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesVendedor.RPerComissao(VpaCodVendedor : Integer) : Double;
begin
  AdicionaSQLAbreTabela(Aux,'Select N_PER_COM from CADVENDEDORES '+
                               ' Where I_COD_VEN = '+IntToStr(VpaCodVendedor));
  result := Aux.FieldByname('N_PER_COM').AsFloat;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesVendedor.EnviaPosicaoEstoqueEmail(VpaCodVendedor : Integer;VpaDesLog : TStrings):string;
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
  VpfDFilial : TRBDFilial;
begin
  VpfDFilial := TRBDFilial.cria;
  Sistema.CarDFilial(VpfDFilial,varia.CodigoEmpFil);

  VprMensagem.Clear;
  VpfEmailTexto := TIdText.Create(VprMensagem.MessageParts);
  VpfEmailTexto.ContentType := 'text/plain';

  VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
  VpfEmailHTML.ContentType := 'text/html';
  VpfEmailHTML.DisplayName := 'Proposta Seguranca2';
  MontaEmailHTMLPosEstoque(VpfEmailHTML.Body,VpfDFilial );

  AdicionaEmailVendedores(VpaCodVendedor,VprMensagem);

  VprMensagem.Subject := 'Posição Estoque '+VpfDFilial.NomFantasia;
  VprMensagem.ReceiptRecipient.Text  := VpfDFilial.DesEmailComercial;

  Result := EnviaEmail(VprMensagem,VprSMTP,VpfDFilial);
  VpfEmailTexto.free;
  VpfEmailHTML.free;
  Tabela.close;
  VpfDFilial.free;
end;

{******************************************************************************}
function TRBFuncoesVendedor.EnviaResumoDiarioEmail(VpaCodVendedor : Integer; VpaDatInicio, VpaDatFim : TDateTime; VpaDesLog : TStrings):string;
var
  VpfEmailHTML : TIdText;
  VpfDFilial : TRBDFilial;
  VpfEndereco : TIdEMailAddressItem;
begin
  VpfDFilial := TRBDFilial.cria;
  Sistema.CarDFilial(VpfDFilial,varia.CodigoEmpFil);
  VprLog := VpaDesLog;

  AdicionaLog('Localizando vendedores');
  PosVendedores(Vendedores,VpaCodVendedor);
  While not Vendedores.eof do
  begin
    if Vendedores.FieldByName('C_DES_EMA').AsString = '' then
      AdicionaLog('Vendedor "'+Vendedores.FieldByName('C_NOM_VEN').AsString+'" não possui e-mail cadastrado')
    else
    begin
      AdicionaLog('Montando e-mail com as informações do vendedor "'+Vendedores.FieldByName('C_NOM_VEN').AsString+'"');
      VprMensagem.Clear;

      VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
      VpfEmailHTML.ContentType := 'text/html';

      MontaEmailHTMLResumoVendedor(VpfEmailHTML.Body,VpfDFilial,VpaDatInicio,VpaDatFim,Vendedores.FieldByName('I_COD_VEN').AsInteger,Vendedores.FieldByName('C_NOM_VEN').AsString);
      VprMensagem.Subject := 'Informações Vendas Diárias';

      VpfEndereco := VprMensagem.Recipients.Add;
      VpfEndereco.Address := Vendedores.FieldByName('C_DES_EMA').AsString;
      VpfEndereco.Name := Vendedores.FieldByName('C_NOM_VEN').AsString;
      VprMensagem.ReceiptRecipient.Address := varia.EmailComercial;
      AdicionaLog('Enviando e-mail para o vendedor "'+Vendedores.FieldByName('C_NOM_VEN').AsString+'"');
      EnviaEmail(VprMensagem,VprSMTP,VpfDFilial);
    end;

    Vendedores.next;
  end;
  if Result = '' then
    AdicionaLog('E-mail enviado com sucesso!!!');

  VpfEmailHTML.free;
  Tabela.close;
  VpfDFilial.free;
end;

end.
