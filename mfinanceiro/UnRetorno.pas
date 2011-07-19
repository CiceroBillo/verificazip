unit UnRetorno;

interface

Uses classes, SysUtils, UnDados, ComCtrls, UnContasAPagar, UnContasAReceber,
    UnComissoes, UnDadosCR, unCaixa, SqlExpr,tabela, DB,Provider,DBClient;

type
  TRBDLocalizacaoRetorno = class
    public
      procedure PosDuplicata(VpaTabela : TDataSet;VpaNumDuplicata :String);
      procedure PosNossoNumero(VpaTabela : TDataSet;VpaCodFilial : Integer;VpaNossoNumero : string);
  end;

  TRBDFuncoesRetorno = class(TRBDLocalizacaoRetorno)
    private
      Aux : TSQLQuery;
      Cadastro : TSQL;
      VprBarraStatus : TStatusBar;
      FunComissoes : TFuncoesComissao;
      procedure TextoStatus(VpaTexto : String);
      function IncrementaRetornosEfetuados(VpaDRetorno : TRBDRetornoCorpo):string;
      function RSeqRetornoDisponivel(VpaCodFilial : Integer):Integer;
      function RNomClienteContasReceber(VpaCodFilial,VpaLanReceber:Integer) : String;
      function RNumContaCorrente(VpaNumContrato : String) : string;
      function RErroBradesco(VpaCodErro : Integer):String;
      function RErroCNAB240(VpaCodErro : Integer):String;
      procedure AtualizaTotalTarifas(VpaTabela : TDataSet);
      function ConfirmaItemRemessa(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer):Boolean;
      procedure CarLanReceber(VpaDesIdentificacao : String; VpaDRetornoItem : TRBDREtornoItem);
      procedure CarLanReceberNossoNumeroItau(VpaDesIdentificacao : String; VpaDRetornoItem : TRBDREtornoItem);
      procedure CarLanReceberItem(VpaDRetorno : TRBDRetornoCorpo; VpaDItem : TRBDRetornoItem);
      function ContaCorrenteRetornoValida(VpaDRetorno : TRBDRetornoCorpo):string;
      procedure CarDesLiquidacao(VpaDItem : TRBDRetornoItem);
      function GravaDRetornoItem(VpaDRetorno : TRBDRetornoCorpo):String;
      function GravaDRetorno(VpaDRetorno : TRBDRetornoCorpo) : String;
      procedure processaEntradaConfirmada(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
      procedure processaDescontoDuplicata(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
      procedure ProcessaEntradaRejeitadaItau(VpaDRetorno : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
      procedure ProcessaLiquidacaoNormal(VpaDRetorno : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
      procedure ProcessaEnvioCartorio(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
      procedure ProcessaSustacaoProtesto(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
      procedure ProcessaDebitoTarifas(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
      procedure ProcessaBaixaSimples(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
      procedure ProcessaCancelamentoProtesto(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
      procedure ProcessaRetornoCorpoItau(VpaLinha : String;VpaDRetorno : TRBDRetornoCorpo);
      procedure ProcessaRetornoCorpoCNAB400(VpaLinha : String;VpaDRetorno : TRBDRetornoCorpo);
      procedure ProcessaRetornoCorpoCNAB240(VpaLinha : String;VpaDRetorno : TRBDRetornoCorpo);
      procedure ProcessaOcorrenciaItemItau(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
      procedure ProcessaRetornoItemCNAB240(VpaArquivo : TStringList;VpaDRetorno : TRBDRetornoCorpo);
      procedure ProcessaRetornoItemTCNAB240(VpfLinha : String;VpaDItemRetorno : TRBDRetornoItem);
      procedure ProcessaRetornoItemUCNAB240(VpfLinha : String;VpaDItemRetorno : TRBDRetornoItem);
      procedure LocalizaParcelaCNAB240(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItemRetorno : TRBDRetornoItem);
      procedure ProcessaRetornoItemItau(VpaArquivo : TStringList;VpaDRetorno : TRBDRetornoCorpo);
      procedure ProcessaRetornoItemCNAB400(VpaArquivo : TStringList;VpaDRetorno : TRBDRetornoCorpo);
      function processaRetornoItau(VpaArquivo : TStringList):String;
      function ProcessaRetornoCNAB240(VpaNomArquivo : String;VpaArquivo : TStringList):String;
      function ProcessaRetornoCNAB400(VpaNomArquivo : String;VpaArquivo : TStringList):String;
    public
      constructor cria(VpaBaseDados : TSQLConnection);
      destructor destroy;override;
      function processaRetorno(VpaNomArquivo :String;VpaBarraStatus : TStatusBar):String;
      procedure MarcaRetornoImpresso(VpaCodFilial, VpaSeqRetorno : Integer);
end;


implementation

Uses FunSql, Constantes, FunString, fundata, funarquivos, constmsg;

{******************************************************************************}
procedure TRBDLocalizacaoRetorno.PosDuplicata(VpaTabela : TDataSet;VpaNumDuplicata :String);
begin
  AdicionaSqlAbreTabela(VpaTabela,'Select * from MOVCONTASARECEBER '+
                                  ' Where C_NRO_DUP = '''+VpaNumDuplicata+'''' );
end;

{******************************************************************************}
procedure TRBDLocalizacaoRetorno.PosNossoNumero(VpaTabela : TDataSet;VpaCodFilial : Integer; VpaNossoNumero : string);
begin
  AdicionaSqlAbreTabela(VpaTabela,'Select * from MOVCONTASARECEBER '+
                                  ' Where C_NOS_NUM = '''+VpaNossoNumero+''''+
                                  ' and I_EMP_FIL = '+IntToStr(VpaCodFilial));
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    eventos das Funcoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
constructor TRBDFuncoesRetorno.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Aux := TSQLQuery.create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  FunComissoes := TFuncoesComissao.cria(VpaBaseDados);
end;

{******************************************************************************}
destructor TRBDFuncoesRetorno.destroy;
begin
  Aux.free;
  FunComissoes.free;
  Cadastro.free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.TextoStatus(VpaTexto : String);
begin
  if VprBarraStatus <> nil then
  begin
    VprBarraStatus.Panels[0].Text := VpaTexto;
    VprBarraStatus.refresh;
  end;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.RSeqRetornoDisponivel(VpaCodFilial : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select max(SEQRETORNO) ULTIMO from RETORNOCORPO '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  result := Aux.FieldByName('ULTIMO').AsInteger +1;
  aux.close;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.RNomClienteContasReceber(VpaCodFilial,VpaLanReceber : Integer) : String;
begin
  AdicionaSQLAbreTabela(Aux,'Select CLI.C_NOM_CLI from CADCONTASARECEBER CR, CADCLIENTES CLI '+
                            ' Where CR.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and CR.I_LAN_REC = '+IntToStr(VpaLanReceber)+
                            ' and CR.I_COD_CLI = CLI.I_COD_CLI');
  result := Aux.FieldByName('C_NOM_CLI').AsString;
  Aux.close;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.RNumContaCorrente(VpaNumContrato : String) : string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NRO_CON from CADCONTAS '+
                            ' Where C_NUM_CON = '''+VpaNumContrato +'''');
  result := Aux.FieldByName('C_NRO_CON').AsString;
  Aux.close;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.RErroBradesco(VpaCodErro : Integer):String;
begin
  case VpaCodErro of
    2  : result := 'CODIGO DO REGISTRO DETLHE INVÁLIDO.';
    3  : result := 'CODIGO DA OCORRÊNCIA INVÁLIDA.';
    4  : result := 'CODIGO DA OCORRÊNCIA NÃO PERMITIDA PARA A CARTEIRA.';
    5  : result := 'CODIGO DA OCRRÊNCIA NÃO NUMERICO.';
    7  : result := 'AGENCIA/CONTA/DIGITO - INVALIDO.';
    8  : result := 'NOSSO NUMERO INVALIDO.';
    9  : result := 'NOSSO NUMERO DUPLICADO';
    10 : result := 'CARTEIRA INVALIDA';
    13 : result := 'IDENTIFICACAO DA EMISSAO DO BOLETO INVALIDA';
    16 : result := 'DATA DE VENCIMENTO INVALIDA';
    18 : result := 'VENCIMENTO FORA DO PRAZO DE OPERACAO';
    20 : result := 'VALOR DO TITULO INVALIDO';
    21 : result := 'ESPECIE DO TITULO INVALIDA';
    22 : result := 'ESPECIE NAO PERMITIDA PARA A CARTEIRA';
    24 : result := 'DATA DE EMISSAO INVALIDA';
    28 : result := 'CODIGO DO DESCONTO INVALIDO';
    38 : result := 'PRAZO PARA PROTESTO INVALIDO';
    44 : result := 'AGENCIA CEDENTE NAO PREVISTA';
    45 : result := 'NOME DO SACADO NAO INFORMADO';
    46 : result := 'TIPO/NUMERO DE INSCRICAO DO SACADO INVALIDA';
    47 : result := 'ENDERECO DO SACADO NAO INFORMADO';
    48 : result := 'CEP INVALIDO';
    50 : result := 'CEP IRREGULAR - BANCO CORRESPONDENTE';
    63 : result := 'ENTRADA PARA TITULO JA CADASTRADO';
    65 : result := 'LIMITE EXCEDIDO';
    66 : result := 'NUMERO AUTORIZACAO INEXISTENTE';
    68 : result := 'DEBITO NAO AGENDADO - ERRO NOS DADOS DE REMESSA';
    69 : result := 'DEBITO NAO AGENDADO - SACADO NAO CONSTA NO CADAS DE AUTORIZANTE';
    70 : result := 'DEBITO NAO AGENDADO - CEDENTE NAO AUTORIZADO PELO SACADO';
    71 : result := 'DEBITO NAO AGENDADO - CEDENTE NAO PARTICIPA DO DEBITO AUTOMATICO';
    72 : result := 'DEBITO NAO AGENDADO - CODIGO DA MOEDA DIFERENTE DE R$';
    73 : result := 'DEBITO NAO AGENDADO - DATA DE VENCIMENTO INVALIDO';
    74 : result := 'DEBITO NAO AGENDADO - CONFORME SEU PEDIDO, TITULO NAO REGISTRADO';
    75 : result := 'DEBITO NAO AGENDADO - TIPO DE NUMERO DE INSCRICAO DO DEBITADO INVALIDO';
  else
    result := 'CODIGO DA REJEICAO NAO CADASTRADO!!!'+IntToStr(VpaCodErro);
  end;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.RErroCNAB240(VpaCodErro : Integer):String;
begin
  case VpaCodErro of
    3  : result := 'CEP INVÁLIDO!!! Não foi possivel atribuir a agência cobradora pelo CEP.';
    4  : result := 'UF INVÁLIDA!!! Sigla do estado inválida.';
    5  : result := 'DATA VENCIMENTO INVÁLIDA!!! Prazo da operação menor que prazo mínimo ou maior que o máximo.';
    7  : result := 'VALOR DO TÍTULO INVÁLIDO!!! Valor do título maior que 10.000.000,00.';
    8  : result := 'NOME DO SACADO INVÁLIDO!!! Não informado ou deslocado.';
    9  : result := 'CONTA INVÁLIDA INVÁLIDA!!! Agencia ou conta corrente encerrada.';
    10 : result := 'ENDEREÇO INVÁLIDO!!! Não informado ou deslocado.';
    11 : result := 'CEP INVÁLIDO!!! CEP não numérico.';
    12 : result := 'SACADOR/AVALISTA INVÁLIDO!!! Não informado ou deslocado.';
    13 : result := 'CEP INVÁLIDO!!! Incompatível com a sigla do estado.';
    14 : result := 'NOSSO NÚMERO INVÁLIDO!!! Já registrado no cadastro do bancou ou fora da faixa.';
    15 : result := 'NOSSO NÚMERO INVÁLIDO!!! Em duplicidade no mesmo movimento.';
    18 : result := 'DATA DE ENTRADA INVÁLIDA!!! Data de entrada inválida para operar com essa carteira.';
    19 : result := 'OCORRÊNCIA INVÁLIDA!!! Ocorrência inválida.';
    21 : result := 'AGENCIA COBRADORA INVÁLIDA!!!';
    27 : result := 'CNPJ INVÁLIDO INVÁLIDA!!!CNPJ do cedente inapto';
    48 : result := 'CEP INVÁLIDO!!! CEP não numérico.';
    54 : result := 'DATA DE VENCIMENTO INVÁLIDO!!!A data de vencimento não pode ser inferior a 15 dias.';
    60 : result := 'TITULO NÃO CADATRADO NO BANCO!!!Movimento para título não Cadastrado.';
    63 : result := 'TITULO JÁ CADASTRADO!!! Esse título já foi cadastrado no banco anteriormente';
  else
    result := 'CODIGO DA REJEICAO NAO CADASTRADO!!!'+IntToStr(VpaCodErro);
  end;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.AtualizaTotalTarifas(VpaTabela : TDataSet);
begin
  VpaTabela.FieldByName('N_TOT_TAR').AsFloat :=
        VpaTabela.FieldByName('N_VLR_ECA').AsFloat +
        VpaTabela.FieldByName('N_VLR_CAR').AsFloat +
        VpaTabela.FieldByName('N_VLR_EPR').AsFloat +
        VpaTabela.FieldByName('N_VLR_PRT').AsFloat +
        VpaTabela.FieldByName('N_VLR_TMA').AsFloat +
        VpaTabela.FieldByName('N_VLR_TBS').AsFloat +
        VpaTabela.FieldByName('N_VLR_CPR').AsFloat +
        VpaTabela.FieldByName('N_VLR_BPR').AsFloat ;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.ConfirmaItemRemessa(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer):Boolean;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from REMESSAITEM '+
                                 ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                 ' and LANRECEBER = '+IntToStr(VpaLanReceber)+
                                 ' and NUMPARCELA = '+IntToStr(VpaNumParcela));
  result := not Cadastro.eof;
  while not Cadastro.eof do
  begin
    Cadastro.edit;
    Cadastro.FieldByName('INDCONFIRMADA').AsString := 'S';
    Cadastro.post;
    cadastro.next;
  end;
  ExecutaComandoSql(Aux,'update MOVCONTASARECEBER '+
                        ' SET C_IND_RET = ''S'''+
                            ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                            ' and I_LAN_REC = '+IntToStr(VpaLanReceber) +
                            ' and I_NRO_PAR = '+IntToStr(VpaNumParcela));
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.CarLanReceber(VpaDesIdentificacao : String; VpaDRetornoItem : TRBDREtornoItem);
begin
  if (DeletaChars(VpaDesIdentificacao,'0') <> '')  then
  begin
    if CopiaAteChar(VpaDesIdentificacao,'=') = 'FL' then
    begin
      VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,'=');
      if ExisteLetraString('|',VpaDesIdentificacao) then
      begin
        VpaDRetornoItem.CodFilialRec := StrToInt(CopiaAteChar(VpaDesIdentificacao,'|'));
        VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,'|')
      end
      else
        if ExisteLetraString('/',VpaDesIdentificacao) then
        begin
          VpaDRetornoItem.CodFilialRec := StrToInt(CopiaAteChar(VpaDesIdentificacao,'/'));
          VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,'/')
        end
        else
        begin
          VpaDRetornoItem.CodFilialRec := StrToInt(CopiaAteChar(VpaDesIdentificacao,' '));
          VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,' ')
        end;
    end;
    if CopiaAteChar(VpaDesIdentificacao,'=') = 'LR' then
    begin
      VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,'=');
      if ExisteLetraString('|',VpaDesIdentificacao) then
      begin
        VpaDRetornoItem.LanReceber := StrToInt(CopiaAteChar(VpaDesIdentificacao,'|'));
        VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,'|')
      end
      else
        if ExisteLetraString('/',VpaDesIdentificacao) then
        begin
          VpaDRetornoItem.LanReceber := StrToInt(CopiaAteChar(VpaDesIdentificacao,'/'));
          VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,'/')
        end
        else
        begin
          VpaDRetornoItem.LanReceber := StrToInt(CopiaAteChar(VpaDesIdentificacao,' '));
          VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,' ')
        end;
    end;
    if CopiaAteChar(VpaDesIdentificacao,'=') = 'PC' then
    begin
      VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,'=');
      if ExisteLetraString('|',VpaDesIdentificacao) then
      begin
        VpaDRetornoItem.NumParcela := StrToInt(DeletaChars(CopiaAteChar(VpaDesIdentificacao,'|'),' '));
        VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,'|')
      end
      else
        if ExisteLetraString('/',VpaDesIdentificacao) then
        begin
          VpaDRetornoItem.NumParcela := StrToInt(DeletaChars(CopiaAteChar(VpaDesIdentificacao,'/'),' '));
          VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,'/')
        end
        else
        begin
          VpaDRetornoItem.NumParcela := StrToInt(DeletaChars(CopiaAteChar(VpaDesIdentificacao,' '),' '));
          VpaDesIdentificacao := DeleteAteChar(VpaDesIdentificacao,' ')
        end;
    end;
    if VpaDRetornoItem.NomSacado = '' then
      VpaDRetornoItem.NomSacado := RNomClienteContasReceber(VpaDRetornoItem.CodFilialRec,VpaDRetornoItem.LanReceber);  
  end
  else
  begin
    VpaDRetornoItem.CodFilialRec := 0;
    VpaDRetornoItem.LanReceber := 0;
    VpaDRetornoItem.NumParcela := 0;
  end;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.CarLanReceberNossoNumeroItau(VpaDesIdentificacao : String; VpaDRetornoItem : TRBDREtornoItem);
begin
  VpaDesIdentificacao := DeletaChars(VpaDesIdentificacao,' ');
  VpaDRetornoItem.CodFilialRec := varia.CodigoEmpFil;
  VpaDRetornoItem.LanReceber := StrToInt(copy(VpaDesIdentificacao,1,length(VpaDesIdentificacao)-2));
  VpaDRetornoItem.NumParcela := StrToInt(copy(VpaDesIdentificacao,length(VpaDesIdentificacao)-1,2));
  AdicionaSQLAbreTabela(Aux,'Select * from MOVCONTASARECEBER '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaDRetornoItem.CodFilialRec)+
                            ' and I_LAN_REC = '+IntToStr(VpaDRetornoItem.LanReceber)+
                            ' and I_NRO_PAR = '+IntToStr(VpaDRetornoItem.NumParcela));
  if Aux.FieldByName('N_VLR_PAR').AsFloat <> VpaDRetornoItem.ValTitulo then
  begin
    VpaDRetornoItem.CodFilialRec := 0;
    VpaDRetornoItem.LanReceber := 0;
    VpaDRetornoItem.NumParcela := 0;
  end
  else
  begin
    VpaDRetornoItem.NumDuplicata := Aux.FieldByName('C_NRO_DUP').AsString;
    VpaDRetornoItem.DatVencimento := Aux.FieldByName('D_DAT_VEN').AsDateTime;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.CarLanReceberItem(VpaDRetorno : TRBDRetornoCorpo; VpaDItem : TRBDRetornoItem);
var
  vpfNumDuplicata : String;
begin
  IF (VpaDItem.NumDuplicata <> '') or (VpaDItem.DesNossoNumero <> '') then
  begin
    if VpaDItem.DesNossoNumero <> '' then
      PosNossoNumero(Aux,VpaDRetorno.CodFilial,VpaDItem.DesNossoNumero)
    else
    begin
      vpfNumDuplicata := VpaDItem.NumDuplicata;
      PosDuplicata(Aux,vpfNumDuplicata);
      if aux.Eof then
      begin
        vpfNumDuplicata := vpfNumDuplicata + '-01';
        PosDuplicata(Aux,vpfNumDuplicata);
      end;
    end;
    if not aux.eof then
    begin
      if (VpaDItem.DatVencimento = Aux.FieldByName('D_DAT_VEN').AsDateTime) then
      begin
        VpaDItem.CodFilialRec := Aux.FieldByName('I_EMP_FIL').AsInteger;
        VpaDItem.LanReceber := Aux.FieldByName('I_LAN_REC').AsInteger;
        VpaDItem.NumParcela := Aux.FieldByName('I_NRO_PAR').AsInteger;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.ContaCorrenteRetornoValida(VpaDRetorno : TRBDRetornoCorpo):string;
begin
  result := '';
  if VpaDRetorno.CodBanco = 104 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from CADCONTAS '+
                            ' Where C_NUM_CON = '''+DeletaChars(VpaDRetorno.NumConta,'-')+'''');
    VpaDRetorno.NumConta := Aux.FieldByname('C_NRO_CON').AsString;
    if Aux.Eof then
    begin
      AdicionaSQLAbreTabela(Aux,'Select * from CADCONTAS '+
                              ' Where C_CON_BAN = '''+DeletaChars(VpaDRetorno.NumConvenio,'-')+'''');
      VpaDRetorno.NumConta := Aux.FieldByname('C_NRO_CON').AsString;
    end;
  end
  else
    AdicionaSQLAbreTabela(Aux,'Select * from CADCONTAS '+
                            ' Where C_NRO_CON = '''+VpaDRetorno.NumConta+'''');

  VpaDRetorno.CodFornecedorBancario := Aux.FieldByName('I_COD_CLI').AsInteger;
  if Aux.eof then
    result := 'CONTA CORRENTE NÃO CADASTRADA!!!'#13'A conta corrente "'+VpaDRetorno.NumConta+''' não existe cadastrada no sistema.'
  else
  begin
    if Aux.FieldByName('I_EMP_FIL').AsInteger <> varia.CodigoEmpFil then
      result := 'FILIAL INVÁLIDA!!!'#13'A conta corrente "'+VpaDRetorno.NumConta+''' não pertence a filial ativa. Altere a filial ativa para a '+Aux.FieldByName('I_EMP_FIL').AsString;
  end;
  if result = '' then
  begin
    if config.Somente1RetornoporCaixa then
      if Aux.FieldByName('I_QTD_RET').AsInteger >= 1 then
        result := 'JÁ FOI EFETUADO RETORNO BANCÁRIO NESSE CAIXA!!!'#13'É permitido fazer apenas 1 retorno bancário por caixa';
  end;
  if result = '' then
  begin
    if ConfigModulos.Caixa then
      if not FunCaixa.ContaCaixaAberta(VpaDRetorno.NumConta) then
        result := 'CONTA CAIXA NÃO ABERTA!!!'#13'Antes de processar o retorno é necessário abrir o caixa dessa conta.';
  end;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.CarDesLiquidacao(VpaDItem : TRBDRetornoItem);
begin
  if (VpaDItem.CodLiquidacao = 'AA') or (VpaDItem.CodLiquidacao = 'BC') or (VpaDItem.CodLiquidacao = 'BF') or
     (VpaDItem.CodLiquidacao = 'BL') or (VpaDItem.CodLiquidacao = 'CK') or (VpaDItem.CodLiquidacao = 'CP') or
     (VpaDItem.CodLiquidacao = 'DG')then
    VpaDItem.DesLiquidacao := 'DISPONIVEL'
  else
    if (VpaDItem.CodLiquidacao = 'AC') or (VpaDItem.CodLiquidacao = 'B0') or (VpaDItem.CodLiquidacao = 'B1') or
       (VpaDItem.CodLiquidacao = 'B2') or (VpaDItem.CodLiquidacao = 'B3') or (VpaDItem.CodLiquidacao = 'B4') or
       (VpaDItem.CodLiquidacao = 'CC') or (VpaDItem.CodLiquidacao = 'LC') then
      VpaDItem.DesLiquidacao := 'A COMPENSAR';
end;

{******************************************************************************}
function TRBDFuncoesRetorno.GravaDRetornoItem(VpaDRetorno : TRBDRetornoCorpo ):String;
var
  VpfDItem : TRBDREtornoItem;
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDRetorno.Itens.count - 1 do
  begin
    VpfDItem := TRBDREtornoItem(VpaDRetorno.Itens.Items[VpfLaco]);
    Aux.close;
    Aux.Sql.clear;
    Aux.sql.add('INSERT INTO RETORNOITEM (CODFILIAL,SEQRETORNO,SEQITEM,INDPROCESSADO,INDPOSSUIERRO, CODOCORRENCIA,'+
                ' DATOCORRENCIA,NOMSACADO,DESDUPLICATA,DESNOSSONUMERO,DATVENCIMENTO,VALTITULO,');
    Aux.sql.add(' VALTARIFA,VALMULTA,VALOUTRASDESPESAS,DATCREDITO,CODCANCELADA,DESCODERRO,'+
                'DESERRO,CODLIQUIDACAO,DESDISPONIVEL,CODUSUARIO,NOMOCORRENCIA)VALUES(' );
    Aux.sql.add(InttoStr(VpaDRetorno.CodFilial)+ ','+
                InttoStr(VpaDRetorno.SeqRetorno)+ ','+
                InttoStr(VpfLaco+1)+ ',');
    if VpfDItem.IndProcessada then
      Aux.sql.add('''S'',')
    else
      Aux.sql.add('''N'',');
    if VpfDItem.IndPOSSUIERRO then
      Aux.sql.add('''S'',')
    else
      Aux.sql.add('''N'',');
    Aux.sql.add(IntToStr(VpfDItem.CodOcorrencia)+','+
                SqlTextoDataAAAAMMMDD(VpfDItem.DatOcorrencia)+','''+
                DeletaChars(copy(VpfDItem.NomSacado,1,30),'''') +''','''+
                VpfDItem.NumDuplicata+''','''+
                VpfDItem.DesNossoNumero+''',');
    if VpfDItem.DatVencimento > MontaData(1,1,1900) then
      Aux.sql.add(SqlTextoDataAAAAMMMDD(VpfDItem.DatVencimento)+',')
    else
      Aux.sql.add('null,');
    Aux.sql.add(SQLRetornaValorTipoCampo(VpfDItem.ValTitulo)+','+
                SQLRetornaValorTipoCampo(VpfDItem.ValTarifa)+','+
                SQLRetornaValorTipoCampo(VpfDItem.ValJuros)+','+
                SQLRetornaValorTipoCampo(VpfDItem.ValOutrasDespesas)+','+
                SQLRetornaValorTipoCampo(VpfDItem.DatCredito)+',');
    if VpfDItem.CodCancelada <> 0 then
      Aux.sql.add(SQLRetornaValorTipoCampo(VpfDItem.CodCancelada)+',')
    else
      Aux.sql.add('null,');
    Aux.sql.add(''''+copy(VpfDItem.CodErros,1,8)+''','''+
                copy(RetiraAcentuacao(VpfDItem.DesErro),1,100)+''','''+
                VpfDItem.CodLiquidacao+''','''+
                VpfDItem.DesLiquidacao+''','+
                SQLRetornaValorTipoCampo(varia.CodigoUsuario)+','''+
                VpfDItem.NomOcorrencia+''')');
    Aux.execsql;
  end;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.IncrementaRetornosEfetuados(VpaDRetorno: TRBDRetornoCorpo): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCONTAS ' +
                                 'Where C_NRO_CON = '''+VpaDRetorno.NumConta+'''');
  Cadastro.edit;
  Cadastro.FieldByName('I_QTD_RET').AsInteger := Cadastro.FieldByName('I_QTD_RET').AsInteger +1;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.GravaDRetorno(VpaDRetorno : TRBDRetornoCorpo) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from RETORNOCORPO');

  Cadastro.Insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDRetorno.CodFilial;
  Cadastro.FieldByName('SEQARQUIVO').AsInteger := VpaDRetorno.SeqArquivo;
  Cadastro.FieldByName('NUMCONTA').AsString := VpaDRetorno.NumConta;
  Cadastro.FieldByName('NOMARQUIVO').AsString := VpaDRetorno.NomArquivo;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaDRetorno.CodUsuario;
  Cadastro.FieldByName('DATRETORNO').AsDateTime := VpaDRetorno.DatRetorno;
  Cadastro.FieldByName('DATGERACAO').AsDateTime := VpaDRetorno.DatGeracao;
  Cadastro.FieldByName('INDIMPRESSO').AsString := 'N';
  if VpaDRetorno.DatCredito > MontaData(1,1,1900) then
    Cadastro.FieldByName('DATCREDITO').AsDateTime := VpaDRetorno.DatCredito;

  if VpaDRetorno.SeqRetorno = 0 then
    VpaDRetorno.SeqRetorno := RSeqRetornoDisponivel(VpaDRetorno.CodFilial);
  Cadastro.FieldByName('SEQRETORNO').AsInteger := VpaDRetorno.SeqRetorno;

  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO RETORNO CORPO!!!'#13+e.message;
  end;
  if result = '' then
    result := GravaDRetornoItem(VpaDRetorno);
  if result = '' then
    result :=IncrementaRetornosEfetuados(VpaDRetorno);
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.processaEntradaConfirmada(VpaDRetornoCorpo : TRBDRetornoCorpo; VpaDItem : TRBDREtornoItem);
begin
  VpaDItem.DesErro := '';
  VpaDItem.NomOcorrencia := 'ENTRADA CONFIRMADA';
  if (VpaDItem.LanReceber = 0) then
     VpaDItem.DesErro := 'NAO FOI POSSIVEL CONFIRMAR A ENTRADA!!!LANREC = 0.'
  else
  begin
    if not ConfirmaItemRemessa(VpaDItem.CodFilialRec,VpaDItem.LanReceber,VpaDItem.NumParcela) then
       VpaDItem.DesErro := 'NAO FOI POSSIVEL CONFIRMAR A ENTRADA!!! Lançamento nao encontrado.'
    else
    begin
      if VpaDItem.ValTarifa <> 0 then
        FunContasAPagar.GeraCPTarifasRetorno(VpaDRetornoCorpo,VpaDItem,VpaDItem.ValTarifa,'TARIFA REGISTRO DUPLICATA','');
      VpaDItem.IndProcessada := true;
      VpaDItem.IndPossuiErro := false;
    end;
  end;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.processaDescontoDuplicata(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
begin
  VpaDItem.NomOcorrencia := 'DESCONTO DUPLICATA';
   if VpaDItem.LanReceber = 0 then
     CarLanReceberItem(VpaDRetornoCorpo,VpaDItem);
   if VpaDItem.LanReceber <> 0 then
   begin
     AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaDItem.CodFilialRec)+
                                    ' and I_LAN_REC = '+IntToStr(VpaDItem.LanReceber)+
                                    ' AND I_NRO_PAR = '+IntToStr(VpadItem.NumParcela));
     if not Cadastro.Eof then
     begin
       if Cadastro.FieldByName('C_DUP_DES').AsString = '' then
       begin
         Cadastro.Edit;
         Cadastro.FieldByName('C_DUP_DES').AsString := 'S';
         Cadastro.Post;
         FunContasAPagar.GeraCPTarifasRetorno(VpaDRetornoCorpo,VpaDItem,VpaDItem.ValJuros,'TARIFA DESCONTO DUPLICATA',varia.PlanoDescontoDuplicata);
         VpaDItem.IndProcessada := true;
         VpaDItem.IndPossuiErro := false;
       end
       else
         VpaDItem.DesErro:= 'DUPLICATA JÁ PROCESSADA PELO SISTEMA!!!O sistema já processou o envio para cartorio dessa duplicata em outro retorno.'

     end
     else
       VpaDItem.DesErro:= 'DUPLICATA EXCLUIDA!!!O sistema nao envio para cartorio o titulo pois o mesmo foi excluido do sistema.'
   end
   else
     VpaDItem.DesErro:= 'DUPLICATA NAO ENCONTRADA NO SISTEMA!!!O sistema nao localizou o titulo para enviar para marcar como enviado para cartorio.'
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaEntradaRejeitadaItau(VpaDRetorno : TRBDRetornoCorpo; VpaDItem : TRBDREtornoItem);
var
  VpfAux : String;
  VpfCodErro : Integer;
begin
  VpaDItem.NomOcorrencia := 'ENTRADA REJEITADA';
  VpfAux := DeletaChars(VpaDItem.CodErros,' ');
  while length(VpfAux) > 1 do
  begin
    VpfCodErro := StrToInt(copy(VpfAux,1,2));
    VpfAux := copy(VpfAux,3,10);
    if VpfCodErro <> 0 then
    begin
      case VpaDRetorno.CodBanco of
        237 : VpaDItem.DesErro := RErroBradesco(VpfCodErro);
      else
        VpaDItem.DesErro := RErroCNAB240(VpfCodErro);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaLiquidacaoNormal(VpaDRetorno : TRBDRetornoCorpo; VpaDItem : TRBDREtornoItem);
var
  VpfDBaixa : TRBDBaixaCR;
  VpfDParela : TRBDParcelaBaixaCR;
  VpfVAlor : Double;
begin
  if VpaDItem.CodOcorrencia = 16 then
    VpaDItem.NomOcorrencia := 'TITULO PAGO EM CHEQUE - VINCULADO'
  else
    if VpaDItem.CodOcorrencia = 17 then
      VpaDItem.NomOcorrencia := 'LIQ TITULO NAO REGISTRADO'
    ELSE
      if VpaDItem.CodOcorrencia = 8 then
        VpaDItem.NomOcorrencia := 'LIQUIDACAO EM CARTORIO'
      ELSE
        VpaDItem.NomOcorrencia := 'LIQUIDACAO NORMAL';
   if VpaDItem.LanReceber = 0 then
     CarLanReceberItem(VpaDRetorno,VpaDItem);
   if VpaDItem.LanReceber <> 0 then
   begin
     AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaDItem.CodFilialRec)+
                                    ' and I_LAN_REC = '+IntToStr(VpaDItem.LanReceber)+
                                    ' AND I_NRO_PAR = '+IntToStr(VpadItem.NumParcela));
     if not Cadastro.Eof then
     begin
       if Cadastro.FieldByName('N_VLR_PAG').AsFLOAT = 0 then
       begin
         VpfVAlor :=(VpaDItem.ValTitulo + VpaDItem.ValJuros);
         if (Cadastro.FieldByName('N_VLR_PAR').AsFLOAT <= VpfVAlor) then
         begin
           VpfDBaixa := TRBDBaixaCR.Cria;
           VpfDBaixa.CodFormaPagamento := varia.FormaPagamentoBoleto;
           VpfDBaixa.TipFormaPagamento := fpCobrancaBancaria;
           VpfDBaixa.NumContaCaixa := VpaDRetorno.NumConta;
           VpfDBaixa.ValorAcrescimo := VpaDItem.ValJuros;
           VpfDBaixa.ValorPago := VpaDItem.ValTitulo + VpaDItem.ValJuros;
           VpfDBaixa.DatPagamento := VpaDItem.DatOcorrencia;
           VpfDBaixa.IndPagamentoParcial := false;
           VpfDBaixa.IndBaixaRetornoBancario := true;
           VpfDParela := VpfDBaixa.AddParcela;
           FunContasAReceber.CarDParcelaBaixa(VpfDParela,VpaDItem.CodFilialRec,VpaDItem.LanReceber,VpaDItem.NumParcela);
           VpfDParela.ValAcrescimo := VpaDItem.ValJuros;
           if VpfDParela.DesObservacoes <> '' then
             VpfDParela.DesObservacoes := VpfDParela.DesObservacoes+#13;
           VpfDParela.DesObservacoes := VpfDParela.DesObservacoes + ' Baixa automatica pelo retorno do banco '+DeletaEspacoD(VpaDRetorno.NomBanco)+' ('+VpaDRetorno.NumConta+')';
           FunContasAReceber.BaixaContasAReceber(VpfDBaixa);
           if VpaDItem.ValTarifa <> 0 then
             FunContasAPagar.GeraCPTarifasRetorno(VpaDRetorno,VpaDItem,VpaDItem.ValTarifa,'TARIFA REGISTRO DUPLICATA','');
           VpaDItem.IndProcessada := true;
           VpaDItem.IndPossuiErro := false;
         end
         else
           VpaDItem.DesErro:= 'VALOR PAGO MENOR QUE O VALOR DA DUPLICATA!!!O sistema nao baixou o titulo por detectar diferenca nos valores.'
       end
       else
         VpaDItem.DesErro:= 'DUPLICATA JA PAGA!!!O sistema nao baixou o titulo pois o mesmo ja se encontrava baixado.'
     end
     else
       VpaDItem.DesErro:= 'DUPLICATA EXCLUIDA!!!O sistema nao baixou o titulo pois o mesmo foi excluido do sistema.'
   end
   else
     VpaDItem.DesErro:= 'DUPLICATA NAO ENCONTRADA NO SISTEMA!!!O sistema nao localizou o titulo do contas a receber para baixar.'
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaEnvioCartorio(VpaDRetornoCorpo : TRBDRetornoCorpo; VpaDItem : TRBDREtornoItem);
begin
  VpaDItem.NomOcorrencia := 'ENVIO CARTORIO';
   if VpaDItem.LanReceber = 0 then
     CarLanReceberItem(VpaDRetornoCorpo, VpaDItem);
   if VpaDItem.LanReceber <> 0 then
   begin
     AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaDItem.CodFilialRec)+
                                    ' and I_LAN_REC = '+IntToStr(VpaDItem.LanReceber)+
                                    ' AND I_NRO_PAR = '+IntToStr(VpadItem.NumParcela));
     if not Cadastro.Eof then
     begin
       if Cadastro.FieldByName('N_VLR_ECA').AsFloat = 0 then
       begin
         Cadastro.Edit;
         Cadastro.FieldByName('D_ENV_CAR').AsDateTime := VpaDItem.DatOcorrencia;
         Cadastro.FieldByName('N_VLR_ECA').AsFloat := VpaDItem.ValTarifa;
         AtualizaTotalTarifas(Cadastro);
         Cadastro.Post;
         FunContasAPagar.GeraCPTarifasRetorno(VpaDRetornoCorpo,VpaDItem,VpaDItem.ValTarifa,'TARIFA ENVIO CARTORIO','');
         VpaDItem.IndProcessada := true;
         VpaDItem.IndPossuiErro := false;
       end
       else
         VpaDItem.DesErro:= 'DUPLICATA JÁ PROCESSADA PELO SISTEMA!!!O sistema já processou o envio para cartorio dessa duplicata em outro retorno.'

     end
     else
       VpaDItem.DesErro:= 'DUPLICATA EXCLUIDA!!!O sistema nao envio para cartorio o titulo pois o mesmo foi excluido do sistema.'
   end
   else
     VpaDItem.DesErro:= 'DUPLICATA NAO ENCONTRADA NO SISTEMA!!!O sistema nao localizou o titulo para enviar para marcar como enviado para cartorio.'
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaDebitoTarifas(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
begin
  VpaDItem.NomOcorrencia := 'DEBITO DE TARIFAS';
   if VpaDItem.LanReceber = 0 then
     CarLanReceberItem(VpaDRetornoCorpo, VpaDItem);
   if VpaDItem.LanReceber <> 0 then
   begin
     AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaDItem.CodFilialRec)+
                                    ' and I_LAN_REC = '+IntToStr(VpaDItem.LanReceber)+
                                    ' AND I_NRO_PAR = '+IntToStr(VpadItem.NumParcela));
     if not Cadastro.Eof then
     begin
       Cadastro.Edit;
       VpaDItem.CodErros := copy(VpaDItem.CodErros,1,2);
       // duplicata em cartorio
       if VpaDItem.CodErros = '08' then
       begin
         if Cadastro.FieldByName('N_VLR_CAR').AsFloat = 0 then
         begin
           Cadastro.FieldByName('N_VLR_CAR').AsFloat := VpaDItem.ValOutrasDespesas;
           Cadastro.FieldByName('D_ENV_CAR').AsDateTime := VpaDItem.DatOcorrencia;
           FunContasAPagar.GeraCPTarifasRetorno(VpaDRetornoCorpo,VpaDItem,VpaDItem.ValOutrasDespesas,'DUPLICATA EM CARTORIO','');
         end
         else
           VpaDItem.DesErro:= 'DUPLICATA JÁ PROCESSADA PELO SISTEMA!!!O sistema já processou o envio para cartorio dessa duplicata em outro retorno.'
       end

       //sustacao de protesto
       else
         if VpaDItem.CodErros = '09' then
         begin
           if Cadastro.FieldByName('N_VLR_BPR').AsFloat = 0 then
           begin
             Cadastro.FieldByName('N_VLR_BPR').AsFloat := VpaDItem.ValOutrasDespesas;
             FunContasAPagar.GeraCPTarifasRetorno(VpaDRetornoCorpo,VpaDItem,VpaDItem.ValOutrasDespesas,'SUSTACAO DE PROTESTO','');
           end
           else
             VpaDItem.DesErro:= 'DUPLICATA JÁ PROCESSADA PELO SISTEMA!!!O sistema já processou o envio para cartorio dessa duplicata em outro retorno.'
         end
         else

           //TARIFA DE MANUTENCAO DE TITULO VENCIDO
           if VpaDItem.CodErros = '02' then
           begin
           if Cadastro.FieldByName('N_VLR_TMA').AsFloat = 0 then
           begin
             Cadastro.FieldByName('N_VLR_TMA').AsFloat := VpaDItem.ValTarifa;
             FunContasAPagar.GeraCPTarifasRetorno(VpaDRetornoCorpo,VpaDItem,VpaDItem.ValTarifa,'TARIFA MANUTENCAO TITULO VENCIDO','');
           end
           else
             VpaDItem.DesErro:= 'DUPLICATA JÁ PROCESSADA PELO SISTEMA!!!O sistema já processou a tarifa de manutencao de titulo vencido desta duplicata em outro retorno.'
           end;

       AtualizaTotalTarifas(Cadastro);
       Cadastro.Post;
       if VpaDItem.DesErro = '' then
       begin
         VpaDItem.IndProcessada := true;
         VpaDItem.IndPossuiErro := false;
       end;
     end
     else
       VpaDItem.DesErro:= 'DUPLICATA EXCLUIDA!!!O sistema nao envio para cartorio o titulo pois o mesmo foi excluido do sistema.'
   end
   else
     VpaDItem.DesErro:= 'DUPLICATA NAO ENCONTRADA NO SISTEMA!!!O sistema nao localizou o titulo.'
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaBaixaSimples(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
begin
  VpaDItem.NomOcorrencia := 'BAIXA SIMPLES';
   if VpaDItem.LanReceber = 0 then
     CarLanReceberItem(VpaDRetornoCorpo,VpaDItem);
   if VpaDItem.LanReceber <> 0 then
   begin
     AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaDItem.CodFilialRec)+
                                    ' and I_LAN_REC = '+IntToStr(VpaDItem.LanReceber)+
                                    ' AND I_NRO_PAR = '+IntToStr(VpadItem.NumParcela));
     if not Cadastro.Eof then
     begin
       if Cadastro.FieldByName('N_VLR_TBS').AsFloat = 0 then
       begin
         Cadastro.Edit;
         Cadastro.FieldByName('N_VLR_TBS').AsFloat := VpaDItem.ValTarifa;
         AtualizaTotalTarifas(Cadastro);
         Cadastro.Post;
         FunContasAPagar.GeraCPTarifasRetorno(VpaDRetornoCorpo,VpaDItem,VpaDItem.ValTarifa,'BAIXA SIMPLES','');
         VpaDItem.IndProcessada := true;
         VpaDItem.IndPossuiErro := false;
       end
       else
         VpaDItem.DesErro:= 'DUPLICATA JÁ PROCESSADA PELO SISTEMA!!!O sistema já processou a instrução de cancelamento de envio para protesto dessa duplicata em outro retorno.'

     end
     else
       VpaDItem.DesErro:= 'DUPLICATA EXCLUIDA!!!O sistema nao processou o titulo pois o mesmo foi excluido do sistema.'
   end
   else
     VpaDItem.DesErro:= 'DUPLICATA NAO ENCONTRADA NO SISTEMA!!!O sistema nao localizou o titulo para processar.'
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaCancelamentoProtesto(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
begin
  VpaDItem.NomOcorrencia := 'CANCELAMENTO PROTESTO';
   if VpaDItem.LanReceber = 0 then
     CarLanReceberItem(VpaDRetornoCorpo,VpaDItem);
   if VpaDItem.LanReceber <> 0 then
   begin
     AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaDItem.CodFilialRec)+
                                    ' and I_LAN_REC = '+IntToStr(VpaDItem.LanReceber)+
                                    ' AND I_NRO_PAR = '+IntToStr(VpadItem.NumParcela));
     if not Cadastro.Eof then
     begin
       if Cadastro.FieldByName('N_VLR_CPR').AsFloat = 0 then
       begin
         Cadastro.Edit;
         Cadastro.FieldByName('N_VLR_CPR').AsFloat := VpaDItem.ValTarifa;
         AtualizaTotalTarifas(Cadastro);
         Cadastro.Post;
         FunContasAPagar.GeraCPTarifasRetorno(VpaDRetornoCorpo,VpaDItem,VpaDItem.ValTarifa,'INSTRUCAO DE CANCELAMENTO PROTESTO','');
         VpaDItem.IndProcessada := true;
         VpaDItem.IndPossuiErro := false;
       end
       else
         VpaDItem.DesErro:= 'DUPLICATA JÁ PROCESSADA PELO SISTEMA!!!O sistema já processou a instrução de cancelamento de envio para protesto dessa duplicata em outro retorno.'

     end
     else
       VpaDItem.DesErro:= 'DUPLICATA EXCLUIDA!!!O sistema nao processou o titulo pois o mesmo foi excluido do sistema.'
   end
   else
     VpaDItem.DesErro:= 'DUPLICATA NAO ENCONTRADA NO SISTEMA!!!O sistema nao localizou o titulo para processar.'
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaRetornoCorpoItau(VpaLinha : String;VpaDRetorno : TRBDRetornoCorpo);
begin
  TextoStatus('Carregando Header do Banco "'+copy(VpaLinha,80,15)+'"');
  VpaDRetorno.CodBanco := StrToInt(copy(VpaLinha,77,3));
  VpaDRetorno.NomBanco := copy(VpaLinha,80,15);
  VpaDRetorno.CodFilial := varia.CodigoEmpFil;
  if (varia.CNPJFilial = CNPJ_INFORMARE) or
     (varia.CNPJFilial = CNPJ_INFORWAP) or
     (varia.CNPJFilial = CNPJ_INFORMANET) then
    VpaDRetorno.NumConta := '206490'
  else
    VpaDRetorno.NumConta := DeletaCharE(copy(VpaLinha,33,6),'0');
  insert('-',VpaDRetorno.NumConta,length(VpadRetorno.Numconta));
  VpaDRetorno.DatRetorno := now;
  VpaDRetorno.DatGeracao := MontaData(StrToInt(copy(VpaLinha,95,2)),strtoint(copy(VpaLinha,97,2)),StrToInt('20'+copy(VpaLinha,99,2)));
  VpaDRetorno.SeqArquivo := StrToIntDef(copy(VpaLinha,109,5),0);
  try
    VpaDRetorno.DatCredito := MontaData(StrToInt(copy(VpaLinha,114,2)),strtoint(copy(VpaLinha,116,2)),StrToInt('20'+copy(VpaLinha,118,2)));
  except
    VpaDRetorno.DatCredito := MontaData(StrToInt(copy(VpaLinha,95,2)),strtoint(copy(VpaLinha,97,2)),StrToInt('20'+copy(VpaLinha,99,2)));
  end;
  VpaDRetorno.CodUsuario := varia.CodigoUsuario;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaRetornoCorpoCNAB400(VpaLinha : String;VpaDRetorno : TRBDRetornoCorpo);
begin
  TextoStatus('Carregando Header do Banco "'+copy(VpaLinha,80,15)+'"');
  VpaDRetorno.CodBanco := StrToInt(copy(VpaLinha,77,3));
  VpaDRetorno.NomBanco := copy(VpaLinha,80,15);
  VpaDRetorno.CodFilial := varia.CodigoEmpFil;
  VpaDRetorno.NumConta := RNumContaCorrente(copy(VpaLinha,40,7));
  VpaDRetorno.DatRetorno := now;
  VpaDRetorno.DatGeracao := MontaData(StrToInt(copy(VpaLinha,95,2)),strtoint(copy(VpaLinha,97,2)),StrToInt('20'+copy(VpaLinha,99,2)));
  VpaDRetorno.SeqArquivo := StrToInt(copy(VpaLinha,109,5));
  VpaDRetorno.DatCredito := MontaData(StrToInt(copy(VpaLinha,380,2)),strtoint(copy(VpaLinha,382,2)),StrToInt('20'+copy(VpaLinha,384,2)));
  VpaDRetorno.CodUsuario := varia.CodigoUsuario;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaRetornoCorpoCNAB240(VpaLinha : String;VpaDRetorno : TRBDRetornoCorpo);
begin
  TextoStatus('Carregando Header do Banco "'+copy(VpaLinha,103,30)+'"');
  VpaDRetorno.CodBanco := StrToInt(Copy(VpaLinha,1,3));
  VpaDRetorno.NomBanco := copy(VpaLinha,103,30);
  VpaDRetorno.CodFilial := varia.CodigoEmpFil;
  if varia.CNPJFilial = CNPJ_AGZ then
    VpaDRetorno.NumConta := copy(VpaLinha,66,5)+'-'+copy(VpaLinha,71,2)
  else
  begin
    VpaDRetorno.NumConta := DeletaCharE(copy(VpaLinha,59,12),'0');
    if VpaDRetorno.CodBanco = 399 then
      VpaDRetorno.NumConta := AdicionaCharE('0',copy(VpaDRetorno.NumConta,1,length(VpaDRetorno.NumConta)-2)+'-'+copy(VpaDRetorno.NumConta,length(VpaDRetorno.NumConta)-1,2),8)
    else
      VpaDRetorno.NumConta := VpaDRetorno.NumConta+'-'+copy(VpaLinha,71,1);
  end;
  VpaDRetorno.DatRetorno := now;
  VpaDRetorno.DatGeracao := MontaData(StrToInt(copy(VpaLinha,144,2)),strtoint(copy(VpaLinha,146,2)),StrToInt(copy(VpaLinha,148,4)));
  VpaDRetorno.SeqArquivo := StrToInt(copy(VpaLinha,158,6));
  VpaDRetorno.DatCredito := VpaDRetorno.DatGeracao;
  VpaDRetorno.NumConvenio := copy(VpaLinha,33,16);
  VpaDRetorno.CodUsuario := varia.CodigoUsuario;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaOcorrenciaItemItau(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItem : TRBDREtornoItem);
begin
  if VpaDRetornoCorpo.CodBanco = 341 then
  begin
    case VpaDItem.CodOcorrencia of
      2 : processaEntradaConfirmada(VpaDRetornoCorpo,VpaDItem); //entradaConfirmada;
      3 : ProcessaEntradaRejeitadaItau(VpaDRetornoCorpo,VpaDItem); //entrada rejeitada
      6,8 : ProcessaLiquidacaoNormal(VpaDRetornoCorpo,VpaDItem); //liquidação normal;
      9 : ProcessaBaixaSimples(VpaDRetornoCorpo, VpaDItem);
      14,29 : begin
            VpaDItem.DesErro := '';//
            VpaDItem.IndProcessada := true;
            VpaDItem.IndPossuiErro := false;
          end;
      15 :begin
            VpaDItem.NomOcorrencia := 'BAIXA REJEITADA';
            VpaDItem.DesErro := '';//
            VpaDItem.IndProcessada := true;
            VpaDItem.IndPossuiErro := false;
          end;
      19 :begin
            VpaDItem.NomOcorrencia := 'CONFIRMACAO RECEBIMENTO PROTESTO';
            VpaDItem.DesErro := '';//
            VpaDItem.IndProcessada := true;
            VpaDItem.IndPossuiErro := false;
          end;
      20 : ProcessaSustacaoProtesto(VpaDRetornoCorpo, VpaDItem);
      24 : ProcessaCancelamentoProtesto(VpaDRetornoCorpo, VpaDItem);
      23 : ProcessaEnvioCartorio(VpaDRetornoCorpo, VpaDItem);
      28 : ProcessaDebitoTarifas(VpaDRetornoCorpo, VpaDItem);
      47 : processaDescontoDuplicata(VpaDRetornoCorpo,VpaDItem);
    else
      VpaDItem.DesErro:= 'OCORRÊNCIA NAO CADASTRADA!!!';
    end;
  end
  else
    if VpaDRetornoCorpo.CodBanco = 104 then
    begin
      case VpaDItem.CodOcorrencia of
        2 : processaEntradaConfirmada(VpaDRetornoCorpo,VpaDItem); //entradaConfirmada;
        3 : ProcessaEntradaRejeitadaItau(VpaDRetornoCorpo,VpaDItem); //entrada rejeitada
        6 : ProcessaLiquidacaoNormal(VpaDRetornoCorpo,VpaDItem); //liquidação normal;
        9 : ProcessaBaixaSimples(VpaDRetornoCorpo, VpaDItem);
        14: begin
              VpaDItem.DesErro := '';//
              VpaDItem.IndProcessada := true;
              VpaDItem.IndPossuiErro := false;
            end;
        24 : ProcessaCancelamentoProtesto(VpaDRetornoCorpo, VpaDItem);
        23 : ProcessaEnvioCartorio(VpaDRetornoCorpo, VpaDItem);
        28 : ProcessaDebitoTarifas(VpaDRetornoCorpo, VpaDItem);
      else
        VpaDItem.DesErro:= 'OCORRÊNCIA NAO CADASTRADA!!!';
      end;
    end
    else
      if VpaDRetornoCorpo.CodBanco = 237 then
      begin
        case VpaDItem.CodOcorrencia of
          2 : processaEntradaConfirmada(VpaDRetornoCorpo,VpaDItem); //entradaConfirmada;
          3 : ProcessaEntradaRejeitadaItau(VpaDRetornoCorpo,VpaDItem); //entrada rejeitada
          6 : ProcessaLiquidacaoNormal(VpaDRetornoCorpo,VpaDItem); //liquidação normal;
          10 : ProcessaBaixaSimples(VpaDRetornoCorpo, VpaDItem);
          14: begin
                VpaDItem.DesErro := '';//
                VpaDItem.IndProcessada := true;
                VpaDItem.IndPossuiErro := false;
              end;
          24 : ProcessaCancelamentoProtesto(VpaDRetornoCorpo, VpaDItem);
          23 : ProcessaEnvioCartorio(VpaDRetornoCorpo, VpaDItem);
          28 : ProcessaDebitoTarifas(VpaDRetornoCorpo, VpaDItem);
        else
          VpaDItem.DesErro:= 'OCORRÊNCIA NAO CADASTRADA!!!';
        end;
      end
      else
      begin
        case VpaDItem.CodOcorrencia of
          2 : processaEntradaConfirmada(VpaDRetornoCorpo,VpaDItem); //entradaConfirmada;
          3 : ProcessaEntradaRejeitadaItau(VpaDRetornoCorpo,VpaDItem); //entrada rejeitada
          4 : processaDescontoDuplicata(VpaDRetornoCorpo,VpaDItem);
          6,16,17 : ProcessaLiquidacaoNormal(VpaDRetornoCorpo,VpaDItem); //liquidação normal;
          9 : ProcessaBaixaSimples(VpaDRetornoCorpo, VpaDItem);
          14,29 : begin
                VpaDItem.DesErro := '';//
                VpaDItem.IndProcessada := true;
                VpaDItem.IndPossuiErro := false;
              end;
          20 : ProcessaCancelamentoProtesto(VpaDRetornoCorpo, VpaDItem);
          23 : ProcessaEnvioCartorio(VpaDRetornoCorpo, VpaDItem);
          28 : ProcessaDebitoTarifas(VpaDRetornoCorpo, VpaDItem);
        else
          VpaDItem.DesErro:= 'OCORRÊNCIA NAO CADASTRADA!!!';
        end;
      end;
end;
{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaRetornoItemCNAB240(VpaArquivo : TStringList;VpaDRetorno : TRBDRetornoCorpo);
var
  VpfDItem : TRBDREtornoItem;
  VpfLaco : Integer;
  VpfLinha : String;
begin
  for VpfLaco := 2 to VpaArquivo.Count-3 do
  begin
    VpfLinha := VpaArquivo.Strings[VpfLaco];
    if copy(VpfLinha,14,1) = 'T' then
    begin
      VpfDItem := VpaDRetorno.addItem;
      ProcessaRetornoItemTCNAB240(VpfLinha,VpfDItem)
    end
    else
    if copy(VpfLinha,14,1) = 'U' then
    begin
      ProcessaRetornoItemUCNAB240(VpfLinha,VpfDItem);
      if VpfDItem.CodFilialRec = 0 then
        LocalizaParcelaCNAB240(VpaDRetorno,VpfDItem);
      ProcessaOcorrenciaItemItau(VpaDRetorno,VpfDItem);
    end;
  end;
end;


{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaRetornoItemTCNAB240(VpfLinha : String;VpaDItemRetorno : TRBDRetornoItem);
begin
    VpaDItemretorno.NomSacado := DeletaCharD(DeletaCharD(copy(VpfLinha,149,40),' '),'0');
    CarLanReceber(Copy(VpfLinha,106,25),VpaDItemretorno);
    VpaDItemretorno.CodOcorrencia := StrToInt(copy(vpfLinha,16,2));
    VpaDItemretorno.NumDuplicata := DeletaCharD(copy(vpfLinha,59,15),' ');
    if copy(VpfLinha,75,1) <> '0' then
      VpaDItemretorno.DatVencimento := MontaData(StrToInt(copy(VpfLinha,74,2)),StrToInt(copy(VpfLinha,76,2)),StrToInt(copy(VpfLinha,78,4)));
    VpaDItemretorno.ValTitulo := StrToFloat(copy(VpfLinha,82,15))/100 ;
    VpaDItemretorno.ValTarifa := StrToFloat(copy(VpfLinha,199,15))/100 ;
    VpaDItemRetorno.DesNossoNumero := DeletaCharE(DeletaChars(DeletaCharD(copy(vpfLinha,38,20),' '),' '),'0');
//    VpaDItemretorno.CodLiquidacao := copy(VpfLinha,393,2);
    VpaDItemretorno.CodErros := copy(VpfLinha,214,10);
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaRetornoItemUCNAB240(VpfLinha : String;VpaDItemRetorno : TRBDRetornoItem);
begin
    VpaDItemretorno.DatOcorrencia := MontaData(StrToInt(copy(VpfLinha,138,2)),StrToInt(copy(VpfLinha,140,2)),StrToInt(copy(VpfLinha,142,4)));
    VpaDItemretorno.ValJuros := StrToFloat(copy(VpfLinha,18,15))/100 ;
    if (copy(vpflinha,146,1) <> ' ') and (copy(vpflinha,146,1) <> '0') then
      VpaDItemretorno.DatCredito := MontaData(StrToInt(copy(VpfLinha,146,2)),StrToInt(copy(VpfLinha,148,2)),StrToInt(copy(VpfLinha,150,4)));
    VpaDItemretorno.ValOutrasDespesas := StrToFloat(copy(VpfLinha,108,15))/100 ;
    VpaDItemretorno.ValLiquido := StrToFloat(copy(VpfLinha,93,15))/100 ;
//    VpaDItemretorno.CodCancelada := StrToInt(copy(vpfLinha,302,4));

end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaSustacaoProtesto(VpaDRetornoCorpo: TRBDRetornoCorpo; VpaDItem: TRBDREtornoItem);
begin
  VpaDItem.NomOcorrencia := 'SUSTACAO CARTORIO';
   if VpaDItem.LanReceber = 0 then
     CarLanReceberItem(VpaDRetornoCorpo, VpaDItem);
   if VpaDItem.LanReceber <> 0 then
   begin
     AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONTASARECEBER '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaDItem.CodFilialRec)+
                                    ' and I_LAN_REC = '+IntToStr(VpaDItem.LanReceber)+
                                    ' AND I_NRO_PAR = '+IntToStr(VpadItem.NumParcela));
     if not Cadastro.Eof then
     begin
       if Cadastro.FieldByName('N_VLR_BPR').AsFloat = 0 then
       begin
         Cadastro.Edit;
         Cadastro.FieldByName('N_VLR_BPR').AsFloat := VpaDItem.ValTarifa;
         AtualizaTotalTarifas(Cadastro);
         Cadastro.Post;
         FunContasAPagar.GeraCPTarifasRetorno(VpaDRetornoCorpo,VpaDItem,VpaDItem.ValTarifa,'SUSTACAO PROTESTO','');
         VpaDItem.IndProcessada := true;
         VpaDItem.IndPossuiErro := false;
       end
       else
         VpaDItem.DesErro:= 'DUPLICATA JÁ PROCESSADA PELO SISTEMA!!!O sistema já processou o envio para cartorio dessa duplicata em outro retorno.'

     end
     else
       VpaDItem.DesErro:= 'DUPLICATA EXCLUIDA!!!O sistema nao envio para cartorio o titulo pois o mesmo foi excluido do sistema.'
   end
   else
     VpaDItem.DesErro:= 'DUPLICATA NAO ENCONTRADA NO SISTEMA!!!O sistema nao localizou o titulo para enviar para marcar como enviado para cartorio.'
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.LocalizaParcelaCNAB240(VpaDRetornoCorpo : TRBDRetornoCorpo;VpaDItemRetorno : TRBDRetornoItem);
var
  vpfNumDuplicata : String;
begin
  if VpaDItemRetorno.NumDuplicata <>'' then
  begin
    VpaDItemRetorno.NumDuplicata := DeletaChars(VpaDItemRetorno.NumDuplicata,' ');
    VpaDItemRetorno.NumDuplicata := DeletaChars(VpaDItemRetorno.NumDuplicata,'V');
    VpaDItemRetorno.NumDuplicata := DeletaChars(VpaDItemRetorno.NumDuplicata,'S');
    if length(VpaDItemRetorno.NumDuplicata) < 6 then
      vpfNumDuplicata := VpaDItemRetorno.NumDuplicata +'/1'
    else
      vpfNumDuplicata := copy(VpaDItemRetorno.NumDuplicata,1,length(VpaDItemRetorno.NumDuplicata)-3)+'/'+DeletaCharE(copy(VpaDItemRetorno.NumDuplicata,length(VpaDItemRetorno.NumDuplicata)-2,4),'0');
    AdicionaSQLAbreTabela(Aux,'Select * from MOVCONTASARECEBER '+
                             ' Where C_NRO_DUP = '''+vpfNumDuplicata+'''');
    if not Aux.Eof then
    begin
      if (Aux.FieldByName('D_DAT_VEN').AsDateTime = VpaDItemRetorno.DatVencimento) and
         (Aux.FieldByName('N_VLR_PAR').AsFloat = VpaDItemRetorno.ValTitulo) then
      begin
        VpaDItemRetorno.CodFilialRec := Aux.FieldByName('I_EMP_FIL').AsInteger;
        VpaDItemRetorno.LanReceber := Aux.FieldByName('I_LAN_REC').AsInteger;
        VpaDItemRetorno.NumParcela := Aux.FieldByName('I_NRO_PAR').AsInteger;
      end;
    end;
  end
  else
    if (VpaDItemRetorno.DesNossoNumero <> '') and
       (VpaDRetornoCorpo.CodBanco = 104) then
    begin
      AdicionaSQLAbreTabela(Aux,'Select * from MOVCONTASARECEBER '+
                               ' Where C_NOS_NUM = '''+copy(DeletaCharE(VpaDItemRetorno.DesNossoNumero,' '),1,10)+''''+
                               ' AND I_EMP_FIL = '+ IntToStr(VpaDRetornoCorpo.CodFilial));
      if not Aux.Eof then
      begin
        if (Aux.FieldByName('D_DAT_VEN').AsDateTime >= VpaDItemRetorno.DatVencimento) and
           (Aux.FieldByName('N_VLR_PAR').AsFloat = VpaDItemRetorno.ValTitulo) then
        begin
          VpaDItemRetorno.CodFilialRec := Aux.FieldByName('I_EMP_FIL').AsInteger;
          VpaDItemRetorno.LanReceber := Aux.FieldByName('I_LAN_REC').AsInteger;
          VpaDItemRetorno.NumParcela := Aux.FieldByName('I_NRO_PAR').AsInteger;
        end;
      end;
    end;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaRetornoItemItau(VpaArquivo : TStringList;VpaDRetorno : TRBDRetornoCorpo);
var
  VpfDItem : TRBDREtornoItem;
  VpfLaco : Integer;
  VpfLinha : String;
begin
  for VpfLaco := 1 to VpaArquivo.Count-2 do
  begin
    VpfLinha := VpaArquivo.Strings[VpfLaco];
    VpfDItem := VpaDRetorno.addItem;

    VpfDItem.NomSacado := copy(VpfLinha,325,30);
    CarLanReceber(Copy(VpfLinha,38,25),VpfDItem);
    VpfDItem.CodOcorrencia := StrToInt(copy(vpfLinha,109,2));
    VpfDItem.DesNossoNumero := copy(vpfLinha,63,8);
    VpfDItem.DatOcorrencia := MontaData(StrToInt(copy(VpfLinha,111,2)),StrToInt(copy(VpfLinha,113,2)),StrToInt('20'+copy(VpfLinha,115,2)));
    VpfDItem.NumDuplicata := DeletaCharD(copy(vpfLinha,117,10),' ');
    if StrToInt(copy(VpfLinha,147,2)) <> 0 then // so monta da data se o dia for diferente de zero.
      VpfDItem.DatVencimento := MontaData(StrToInt(copy(VpfLinha,147,2)),StrToInt(copy(VpfLinha,149,2)),StrToInt('20'+copy(VpfLinha,151,2)));
    VpfDItem.ValTitulo := StrToFloat(copy(VpfLinha,153,13))/100 ;
    VpfDItem.ValTarifa := StrToFloat(copy(VpfLinha,176,13))/100 ;
    VpfDItem.ValJuros := StrToFloat(copy(VpfLinha,267,13))/100 ;
    VpfDItem.ValLiquido := VpfDItem.ValTitulo + VpfDItem.ValJuros ;
    if copy(vpflinha,296,1) <> ' ' then
      VpfDItem.DatCredito := MontaData(StrToInt(copy(VpfLinha,296,2)),StrToInt(copy(VpfLinha,298,2)),StrToInt('20'+copy(VpfLinha,300,2)));
    VpfDItem.CodCancelada := StrToInt(copy(vpfLinha,302,4));
    VpfDItem.CodErros := copy(VpfLinha,378,8);
    VpfDItem.CodLiquidacao := copy(VpfLinha,393,2);
    CarDesLiquidacao(VpfDItem);
    if VpfDItem.LanReceber = 0 then
      CarLanReceberNossoNumeroItau(Copy(VpfLinha,63,8),VpfDItem);
    ProcessaOcorrenciaItemItau(VpaDRetorno, VpfDItem);
  end;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.ProcessaRetornoItemCNAB400(VpaArquivo : TStringList;VpaDRetorno : TRBDRetornoCorpo);
var
  VpfDItem : TRBDREtornoItem;
  VpfLaco : Integer;
  VpfLinha : String;
begin
  for VpfLaco := 1 to VpaArquivo.Count-2 do
  begin
    VpfLinha := VpaArquivo.Strings[VpfLaco];
    VpfDItem := VpaDRetorno.addItem;

    CarLanReceber(Copy(VpfLinha,38,25),VpfDItem);
    VpfDItem.CodOcorrencia := StrToInt(copy(vpfLinha,109,2));
    VpfDItem.DesNossoNumero := copy(vpfLinha,71,12);
    VpfDItem.DatOcorrencia := MontaData(StrToInt(copy(VpfLinha,111,2)),StrToInt(copy(VpfLinha,113,2)),StrToInt('20'+copy(VpfLinha,115,2)));
    VpfDItem.NumDuplicata := DeletaCharD(copy(vpfLinha,117,10),' ');
    if StrToInt(copy(VpfLinha,147,2)) <> 0 then // so monta da data se o dia for diferente de zero.
      VpfDItem.DatVencimento := MontaData(StrToInt(copy(VpfLinha,147,2)),StrToInt(copy(VpfLinha,149,2)),StrToInt('20'+copy(VpfLinha,151,2)));
    VpfDItem.ValTitulo := StrToFloat(copy(VpfLinha,153,13))/100 ;
    VpfDItem.ValTarifa := StrToFloat(copy(VpfLinha,176,13))/100 ;
    VpfDItem.ValJuros := StrToFloat(copy(VpfLinha,267,13))/100 ;
    VpfDItem.ValLiquido := VpfDItem.ValTitulo + VpfDItem.ValJuros ;
    if (copy(vpflinha,296,1) <> ' ') and (copy(vpflinha,296,2) <> '00')then
      VpfDItem.DatCredito := MontaData(StrToInt(copy(VpfLinha,296,2)),StrToInt(copy(VpfLinha,298,2)),StrToInt('20'+copy(VpfLinha,300,2)));
    VpfDItem.CodErros := copy(VpfLinha,319,10);
    ProcessaOcorrenciaItemItau(VpaDRetorno, VpfDItem);
  end;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.processaRetornoItau(VpaArquivo : TStringList):String;
var
  VpfDRetorno : TRBDRetornoCorpo;
begin
  result := '';
  VpfDRetorno := TRBDRetornoCorpo.cria;
  ProcessaRetornoCorpoItau(VpaArquivo.Strings[0],VpfDRetorno);
  Result := ContaCorrenteRetornoValida(VpfDRetorno);
  if result = '' then
  begin
    ProcessaRetornoItemItau(VpaArquivo,VpfDRetorno);

    if result = '' then
      result := GravaDRetorno(VpfDRetorno);
  end;

  VpfDRetorno.free;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.ProcessaRetornoCNAB240(VpaNomArquivo : String;VpaArquivo : TStringList):String;
var
  VpfDRetorno : TRBDRetornoCorpo;
begin
  result := '';
  VpfDRetorno := TRBDRetornoCorpo.cria;
  VpfDRetorno.NomArquivo := VpaNomArquivo;
  ProcessaRetornoCorpoCNAB240(VpaArquivo.Strings[0],VpfDRetorno);
  Result := ContaCorrenteRetornoValida(VpfDRetorno);
  if result = '' then
  begin
    ProcessaRetornoItemCNAB240(VpaArquivo,VpfDRetorno);

    if result = '' then
      result := GravaDRetorno(VpfDRetorno);
  end;
  VpfDRetorno.free;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.ProcessaRetornoCNAB400(VpaNomArquivo : String;VpaArquivo : TStringList):String;
var
  VpfDRetorno : TRBDRetornoCorpo;
begin
  result := '';
  VpfDRetorno := TRBDRetornoCorpo.cria;
  VpfDRetorno.NomArquivo := VpaNomArquivo;
  ProcessaRetornoCorpoCNAB400(VpaArquivo.Strings[0],VpfDRetorno);
  Result := ContaCorrenteRetornoValida(VpfDRetorno);
  if result = '' then
  begin
    ProcessaRetornoItemCNAB400(VpaArquivo,VpfDRetorno);

    if result = '' then
      result := GravaDRetorno(VpfDRetorno);
  end;
  VpfDRetorno.free;
end;

{******************************************************************************}
function TRBDFuncoesRetorno.processaRetorno(VpaNomArquivo :String;VpaBarraStatus : TStatusBar):String;
var
  VpfArquivo : TStringList;
begin
  result := '';
  VprBarraStatus := VpaBarraStatus;
  VpfArquivo := TStringList.Create;
  TextoStatus('Abrindo arquivo de retorno "'+VpaNomArquivo+'"');
  VpfArquivo.loadFromfile(VpaNomArquivo);
  TextoStatus('Verificando o Banco do arquivo.');
  if (copy(VpfArquivo.Strings[0],77,3) ='341')or
     (copy(VpfArquivo.Strings[0],77,3) ='001') then //itau
    result := processaRetornoItau(VpfArquivo)
  else
    if (copy(VpfArquivo.Strings[0],1,3) ='001') or (copy(VpfArquivo.Strings[0],1,3) ='409') or
       (copy(VpfArquivo.Strings[0],1,3) ='399')or (copy(VpfArquivo.Strings[0],1,3) ='104') or
       (copy(VpfArquivo.Strings[0],1,3) ='356') then
      result := ProcessaRetornoCNAB240(VpaNomArquivo,VpfArquivo)
    else
      if (copy(VpfArquivo.Strings[0],77,3) ='237') then //bradesco
        result := ProcessaRetornoCNAB400(VpaNomArquivo,VpfArquivo);


  VpfArquivo.free;
  if result = '' then
  begin
    TextoStatus('Retorno efetuado com sucesso.');
    CopiaArquivo(VpaNomArquivo,RetornaDiretorioArquivo(VpaNomArquivo)+'Backup\'+RetornaNomArquivoSemDiretorio(VpaNomArquivo));
    DeletaArquivo(VpaNomArquivo);
  end;
end;

{******************************************************************************}
procedure TRBDFuncoesRetorno.MarcaRetornoImpresso(VpaCodFilial, VpaSeqRetorno : Integer);
begin
  ExecutaComandoSql(Aux,'Update RETORNOCORPO '+
                        ' SET INDIMPRESSO = ''S'''+
                        ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' and SEQRETORNO = '+ InttoStr(VpaSeqRetorno));     
end;

end.
