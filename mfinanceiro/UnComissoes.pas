unit UnComissoes;
{Verificado
-.edit;
}
interface

uses
    Db, DBTables, classes, sysUtils, UnSistema, UnDadosCR, SQLExpr, Tabela;

// funcoes
type
  TFuncoesComissao = class
    Cadastro,
    Comissao : TSQL;
    Tabela : TSQLQuery;
  private
    procedure PosicionaComissao(VpaTabela : TDataSet; VpaCodfilial, VpaLanComissao : Integer);
    procedure PosicionaComisaoCR(VpaTabela : TDataSet; VpaCodFilial,VpLanReceber,VpaNumParcela : Integer);
    function RPerParcelaSobreValoTotal(VpaValTotal, VpaValParcela : Double):Double;
    function ExisteSequencialComissao(VpaCodFilial, VpaSeqComissao : Integer):Boolean;
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor Destroy; override;
    function RSeqComissaoDisponivel(VpaCodFilial : Integer) : Integer;
    function VerificaComissaoPaga(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer ) : Boolean;overload;
    function VerificaComissaoPaga(VpaCodFilial, VpaLanReceber : Integer ) : Boolean;overload;
    procedure ExcluiTodaComissaoDireto(VpaCodfilial, VpaLanReceber : Integer);
    function ExcluiUmaComissao(VpaCodFilial, VpaLanReceber,VpaNumParcela : Integer) : string;
    procedure AlteraVencimentos(VpaCodFilial,VpaLanReceber, VpaNumParcela : integer; VpaNovaData : TDateTime);
    function EfetuaBaixaPagamento(VpaCodfilial,VpaLanComissao : Integer;VpaDatPagamento : TDateTime):String;
    function EstornaBaixaPagamento(VpaCodfilial,VpaLanComissao : Integer):String;
    function EfetuaLiberacao(VpaCodfilial,VpaLanComissao : Integer;VpaDatLiberacao : TDateTime):String;
    function EstornaLiberacao(VpaCodfilial,VpaLanComissao : Integer):String;
    procedure AlteraVendedor( VpaCodVendedor, VpaCodFilial, VpaLanComissao: Integer);
    procedure AlterarPerComissao(VpaCodFilial, VpaNumLancamento, VpaNumLanReceber, VpaNroParcela : Integer;VpaNovoPercentual : Double);
    procedure GeraParcelasComissao(VpaDNovaCR : TRBDContasCR;VpaDComissao : TRBDComissao);
    function GravaDComissoes(VpaDComissao : TRBDComissao) : string;
    function LiberaComissao(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer;VpaDatPagamentoParcela : TDateTime) : String;
    function EstornaComissao(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer) : string;
  end;

implementation

uses constMsg, constantes, funSql, funData, FunObjeto;



{#############################################################################
                        TFuncoesComissoes
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesComissao.cria(VpaBaseDados : TSQLConnection);
begin
  inherited;
    Comissao := TSQL.Create(nil);
    Comissao.ASQLConnection := VpaBaseDados;
    Cadastro := TSQL.Create(nil);
    Cadastro.ASQLConnection := VpaBaseDados;
    Tabela := TSQLQuery.Create(nil);
    Tabela.SQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesComissao.Destroy;
begin
    FechaTabela(Comissao);
    FechaTabela(tabela);
    Comissao.free;
    Cadastro.free;
    Tabela.free;
  inherited;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 funcoes de carregamento da classe
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{******************************************************************************}
function TFuncoesComissao.RSeqComissaoDisponivel(VpaCodFilial : Integer) : Integer;
begin
  if varia.TipoBancoDados = bdMatrizSemRepresentante then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select max(I_LAN_CON) ULTIMO FROM MOVCOMISSOES '+
                                 ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial));
    result := Tabela.FieldByname('ULTIMO').AsInteger + 1;
    Tabela.close;
  end
  else
  begin
    repeat
      AdicionaSQLAbreTabela(Tabela,'Select SEQCOMISSAO FROM SEQUENCIALCOMISSAO '+
                                ' where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                ' order by SEQCOMISSAO');
      result := Tabela.FieldByName('SEQCOMISSAO').AsInteger;
      if result = 0 then
      begin
        aviso('FINAL SEQUENCIAL COMISSÃO!!!'#13'Não existem mais sequenciais de comissão disponiveis, é necessário gerar mais sequenciais ou fazer uma importação de dados.');
        break;
      end;
      Tabela.Close;
      ExecutaComandoSql(Tabela,'Delete from SEQUENCIALCOMISSAO ' +
                            ' where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' and SEQCOMISSAO = '+IntToStr(result));
    until (not ExisteSequencialComissao(VpaCodFilial,result));
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Exclusao da comissao
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{ ********************* exclui comisssao ************************************}
procedure TFuncoesComissao.ExcluiTodaComissaoDireto(VpaCodfilial, VpaLanReceber : Integer);
begin
  Sistema.GravaLogExclusao('MOVCOMISSOES','Select * from MOVCOMISSOES '+
                           ' where I_EMP_FIL = '+ InttoStr(VpaCodFilial) +
                           ' and I_LAN_REC = ' + IntToStr(VpaLanReceber));
  ExecutaComandoSql(Comissao,' Delete from MovComissoes ' +
                             ' where i_emp_fil = '+ InttoStr(VpaCodFilial) +
                             ' and I_LAN_REC = ' + IntToStr(VpaLanReceber));
end;

{ ********************* exclui uma única comisssao ************************************}
function TFuncoesComissao.ExcluiUmaComissao(VpaCodFilial, VpaLanReceber,VpaNumParcela : Integer) : string;
begin
  Result := '';
  // Exclui a comissão;
  if  VerificaComissaoPaga(VpaCodFilial, VpalanReceber, VpaNumParcela) then
  begin
    if not Confirmacao(CT_CanExcluiComissao) then
      result := 'COMISSAO PAGA!!!'#13'A comissão referente a esse título foi paga.';
  end;

  if result = '' then
  begin
    ExecutaComandoSql(comissao, ' Delete from MOVCOMISSOES '+
                                ' where I_EMP_FIL = '+ InttoStr(VpaCodFilial) +
                                ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                ' and I_NRO_PAR = ' + IntToStr(VpaNumParcela));
  end;
end;

{******************************************************************************}
function TFuncoesComissao.ExisteSequencialComissao(VpaCodFilial, VpaSeqComissao: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,'Select I_EMP_FIL FROM MOVCOMISSOES ' +
                               ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                               ' and I_LAN_CON = ' +IntToStr(VpaSeqComissao));
  result := not Tabela.eof;
  Tabela.Close;
end;

{ *** verifica se a comissão foi paga *** }
function  TFuncoesComissao.VerificaComissaoPaga(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer ) : Boolean;
begin
  AdicionaSQLAbreTabela(Tabela, ' select I_EMP_FIL from MOVCOMISSOES ' +
                                ' where I_EMP_FIL = '+ InttoStr(VpaCodFilial) +
                                ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                ' and I_NRO_PAR = ' + IntToStr(VpaNumParcela) +
                                ' and not D_DAT_PAG is null ');
  Result := (not Tabela.EOF);
  FechaTabela(Tabela);
end;


{******************************************************************************}
function TFuncoesComissao.VerificaComissaoPaga(VpaCodFilial, VpaLanReceber : Integer ) : Boolean;
begin
  AdicionaSQLAbreTabela(Tabela, ' select I_EMP_FIL from MOVCOMISSOES ' +
                                ' where I_EMP_FIL = '+ InttoStr(VpaCodFilial) +
                                ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                ' and not D_DAT_PAG is null ');
  Result := (not Tabela.EOF);
  FechaTabela(Tabela);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Altera o vencimento da comissao
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ***** Altera o venvimento da comissao ************************************* }
procedure TFuncoesComissao.AlteraVencimentos(VpaCodFilial,VpaLanReceber, VpaNumParcela : integer; VpaNovaData : TDateTime);
begin
  PosicionaComisaoCR(Comissao, VpaCodFilial,VpaLanReceber, VpaNumParcela);
  if not Comissao.eof then
  begin
    Comissao.edit;
    Comissao.FieldByName('D_DAT_VEN').Value := VpaNovaData;
    //atualiza a data de alteracao para poder exportar
    Comissao.FieldByName('D_ULT_ALT').AsDateTime := SISTEMA.RDataServidor;
    Comissao.post;
    Sistema.MarcaTabelaParaImportar('MOVCOMISSOES');
  end;
  Comissao.close;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Manutencao de pagamentos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFuncoesComissao.PosicionaComissao(VpaTabela : TDataSet; VpaCodfilial, VpaLanComissao : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVCOMISSOES MOC ' +
                                  ' Where I_EMP_FIL = ' +IntToStr(VpaCodfilial)+
                                  ' and I_LAN_CON = ' +IntToStr(VpaLanComissao));
end;

{******************************************************************************}
procedure TFuncoesComissao.PosicionaComisaoCR(VpaTabela : TDataSet; VpaCodFilial,VpLanReceber,VpaNumParcela : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVCOMISSOES MOC ' +
                                  ' Where I_EMP_FIL = ' +IntToStr(VpaCodfilial)+
                                  ' and I_LAN_REC = ' +IntToStr(VpLanReceber)+
                                  ' and I_NRO_PAR = ' +IntToStr(VpaNumParcela));
end;

{******************************************************************************}
function TFuncoesComissao.RPerParcelaSobreValoTotal(VpaValTotal, VpaValParcela : Double) : Double;
begin
  result := 100;
  if VpaValTotal > 0 then
    result := (VpaValParcela * 100)/VpaValTotal;
end;

{ ********** efetua baixas de pagamentos de parcelas ou de efetiva ********** }
function TFuncoesComissao.EfetuaBaixaPagamento(VpaCodfilial,VpaLanComissao : Integer;VpaDatPagamento : TDateTime):String;
begin
  result := '';
  PosicionaComissao(Comissao,VpaCodfilial,VpaLanComissao);
  Comissao.Edit;
  Comissao.FieldByName('D_DAT_PAG').AsDateTime := VpaDatPagamento;
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  Comissao.post;
  result := Comissao.AMensagemErroGravacao;
  comissao.close;
  Sistema.MarcaTabelaParaImportar('MOVCOMISSOES');
end;

{******************************************************************************}
function TFuncoesComissao.EstornaBaixaPagamento(VpaCodfilial,VpaLanComissao : Integer):String;
begin
  result := '';
  PosicionaComissao(Comissao,VpaCodfilial,VpaLanComissao);
  Comissao.Edit;
  Comissao.FieldByName('D_DAT_PAG').clear;
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := SISTEMA.RDataServidor;
  Comissao.post;
  result := Comissao.AMensagemErroGravacao;
  comissao.close;
  Sistema.MarcaTabelaParaImportar('MOVCOMISSOES');
end;

{******************************************************************************}
function TFuncoesComissao.EfetuaLiberacao(VpaCodfilial,VpaLanComissao : Integer;VpaDatLiberacao : TDateTime):String;
begin
  result := '';
  PosicionaComissao(Comissao,VpaCodfilial,VpaLanComissao);
  Comissao.Edit;
  Comissao.FieldByName('D_DAT_VAL').AsDateTime := VpaDatLiberacao;
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := sistema.RDataServidor;
  Comissao.post;
  result := comissao.AMensagemErroGravacao;
  comissao.close;
  Sistema.MarcaTabelaParaImportar('MOVCOMISSOES');
end;

{******************************************************************************}
function TFuncoesComissao.EstornaLiberacao(VpaCodfilial,VpaLanComissao : Integer):String;
begin
  result := '';
  PosicionaComissao(Comissao,VpaCodfilial,VpaLanComissao);
  Comissao.Edit;
  Comissao.FieldByName('D_DAT_VAL').clear;
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := sistema.RDataServidor;
  Comissao.post;
  result := Comissao.AMensagemErroGravacao;
  comissao.close;
  Sistema.MarcaTabelaParaImportar('MOVCOMISSOES');
end;

{******************************************************************************}
procedure TFuncoesComissao.AlteraVendedor( VpaCodVendedor, VpaCodFilial, VpaLanComissao : Integer);
begin
  PosicionaComissao(Comissao,VpaCodfilial,VpaLanComissao);
  Comissao.edit;
  Comissao.FieldByName('I_COD_VEN').AsInteger := VpaCodVendedor;
  //atualiza a data de alteracao para poder exportar
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  Comissao.post;
  Comissao.close;
  Sistema.MarcaTabelaParaImportar('MOVCOMISSOES');
end;

{******************************************************************************}
procedure TFuncoesComissao.AlterarPerComissao(VpaCodFilial, VpaNumLancamento, VpaNumLanReceber, VpaNroParcela : Integer;VpaNovoPercentual : Double);
begin
  AdicionaSqlAbreTabela(Tabela,'Select (MOV.N_VLR_PAR * MOE.N_VLR_DIA) Valor '+
                               ' from MOVCONTASARECEBER MOV, CADMOEDAS MOE ' +
                               ' Where MOV.I_EMP_FIL = '+IntTostr(VpaCodFilial)+
                               ' and MOV.I_LAN_REC = ' + IntToStr(VpaNumLanReceber)+
                               ' and MOV.I_NRO_PAR = '+ IntToStr(VpaNroParcela)+
                               ' and MOE.I_COD_MOE = MOV.I_COD_MOE');
  AdicionaSQLAbreTabela(Comissao,'Select * from MOVCOMISSOES MOC' +
                               ' Where MOC.I_EMP_FIL = '+IntTostr(VpaCodFilial)+
                               ' and MOC.I_LAN_CON = ' + IntToStr(VpaNumLancamento));
  Comissao.Edit;
  Comissao.FieldByName('N_VLR_COM').AsFloat := ((Tabela.FieldByName('Valor').AsFloat * VpaNovoPercentual)/100);
  Comissao.FieldByName('N_PER_COM').AsFloat := VpaNovoPercentual;
  Comissao.FieldByName('N_VLR_INI').AsFloat := ((Tabela.FieldByName('Valor').AsFloat * VpaNovoPercentual)/100);
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  Comissao.post;
  Sistema.MarcaTabelaParaImportar('MOVCOMISSOES');
  Comissao.close;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesComissao.GeraParcelasComissao(VpaDNovaCR : TRBDContasCR;VpaDComissao : TRBDComissao);
var
  VpfDParcela : TRBDMovContasCR;
  VpfDParcelaComissao : TRBDComissaoItem;
  VpfLaco : Integer;
  VpfValTotalComissao, VpfValBaseComissao : Double;
begin
  FreeTObjectsList(VpaDComissao.Parcelas);
  VpfValTotalComissao := VpaDComissao.ValTotalComissao;

  if VpaDNovaCR.TipValorComissao = 1 then //50% no faturamento e o restante nas liquidacao;
  begin
    VpfDParcelaComissao := VpaDComissao.AddParcela;
    VpfDParcelaComissao.NumParcela := 1;
    VpfDParcelaComissao.DatVencimento := VpaDComissao.DatEmissao;
    VpfValTotalComissao := VpfValTotalComissao / 2;
    VpfDParcelaComissao.ValComissaoParcela := VpfValTotalComissao;
    VpfValBaseComissao := VpaDNovaCR.ValBaseComissao / 2;
    VpfDParcelaComissao.ValBaseComissao := VpfValBaseComissao;
    VpfDParcelaComissao.DatLiberacao := VpaDComissao.DatEmissao;
    VpfDParcelaComissao.IndLiberacaoAutomatica := true;
  end;

  for VpfLaco := 0 to VpaDNovaCR.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDMovContasCR(VpaDNovaCR.Parcelas.Items[VpfLaco]);
    VpfDParcelaComissao := VpaDComissao.AddParcela;
    VpfDParcelaComissao.IndLiberacaoAutomatica := false;
    VpfDParcelaComissao.NumParcela := VpfDParcela.NumParcela;
    VpfDParcelaComissao.DatVencimento := VpfDParcela.DatVencimento;
    if VpaDComissao.ValTotalComissao < 0 then
    begin
      VpfDParcelaComissao.ValComissaoParcela := VpfValTotalComissao;
      VpfDParcelaComissao.DatLiberacao := date;
    end
    else
    begin
      VpfDParcelaComissao.ValComissaoParcela := (VpfValTotalComissao * RPerParcelaSobreValoTotal(VpaDNovaCR.ValTotal,VpfDParcela.Valor))/100;
      VpfDParcelaComissao.ValBaseComissao :=  (VpfValBaseComissao * RPerParcelaSobreValoTotal(VpaDNovaCR.ValTotal,VpfDParcela.Valor))/100;
      VpfDParcelaComissao.DatLiberacao := montadata(1,1,1900);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesComissao.GravaDComissoes(VpaDComissao : TRBDComissao) : string;
Var
  VpfLaco : Integer;
  VpfDParcela : TRBDComissaoItem;
begin
  result := '';
  if VpaDComissao.SeqComissao <> 0 then
    ExcluiTodaComissaoDireto(VpaDComissao.CodFilial,VpaDComissao.LanReceber);
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCOMISSOES '+
                                 ' Where I_EMP_FIL = 0 AND I_LAN_CON = 0');
  for VpfLaco := 0 to VpaDComissao.Parcelas.count - 1 do
  begin
    VpfDParcela := TRBDComissaoItem(VpaDComissao.Parcelas.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByname('I_EMP_FIL').AsInteger := VpaDComissao.CodFilial;
    Cadastro.FieldByname('I_LAN_REC').AsInteger := VpaDComissao.LanReceber;
    Cadastro.FieldByname('I_NRO_PAR').AsInteger := VpfDParcela.NumParcela;
    Cadastro.FieldByname('I_COD_VEN').AsInteger := VpaDComissao.CodVendedor;
    Cadastro.FieldByname('D_DAT_VEN').AsDateTime := VpfDParcela.DatVencimento;
    if VpfDParcela.DatPagamento > montadata(1,1,1900) then
      Cadastro.FieldByname('D_DAT_PAG').AsDateTime := VpfDParcela.DatPagamento;
    if VpfDParcela.DatLiberacao > montadata(1,1,1900) then
      Cadastro.FieldByname('D_DAT_VAL').AsDateTime := VpfDParcela.DatLiberacao;
    Cadastro.FieldByname('N_VLR_COM').AsFloat := VpfDParcela.ValComissaoParcela;
    Cadastro.FieldByname('N_VLR_INI').AsFloat := VpfDParcela.ValComissaoParcela;
    Cadastro.FieldByname('N_BAS_PRO').AsFloat := VpfDParcela.ValBaseComissao;
    Cadastro.FieldByname('I_TIP_COM').AsInteger := VpaDComissao.TipComissao;
    if VpaDComissao.PerComissao <> 0 then
      Cadastro.FieldByname('N_PER_COM').AsFloat := VpaDComissao.PerComissao;
    Cadastro.FieldByname('L_OBS_COM').AsString := VpaDComissao.DesObservacao;
    Cadastro.FieldByname('D_DAT_EMI').AsDateTime := VpaDComissao.DatEmissao;
    Cadastro.FieldByname('D_ULT_ALT').AsDateTime := sistema.RDataServidor;
    if VpfDParcela.ValComissaoParcela < 0 then
      Cadastro.FieldByname('C_IND_DEV').AsString := 'S'
    else
      Cadastro.FieldByname('C_IND_DEV').AsString := 'N';
    if VpfDParcela.IndLiberacaoAutomatica then
      Cadastro.FieldByname('C_LIB_AUT').AsString := 'S'
    else
      Cadastro.FieldByname('C_LIB_AUT').AsString := 'N';

    VpaDComissao.SeqComissao := RSeqComissaoDisponivel(VpaDComissao.CodFilial);
    Cadastro.FieldByname('I_LAN_CON').AsInteger := VpaDComissao.SeqComissao;
    if varia.TipoBancoDados = bdRepresentante then
      Cadastro.FieldByName('C_FLA_EXP').AsString := 'N'
    else
      Cadastro.FieldByName('C_FLA_EXP').AsString := 'S';

    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Sistema.MarcaTabelaParaImportar('MOVCOMISSOES');
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesComissao.LiberaComissao(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer;VpaDatPagamentoParcela : TDateTime) : String;
begin
  result := '';
  PosicionaComisaoCR(Comissao,VpaCodfilial,VpaLanReceber,VpaNumParcela);
  while  not Comissao.eof do
  begin
    if Comissao.FieldByName('C_LIB_AUT').AsString = 'N' then
    begin
      Comissao.Edit;
      Comissao.FieldByName('D_DAT_VAL').AsDateTime := date;
      Comissao.FieldByName('D_ULT_ALT').AsDateTime := SISTEMA.RDataServidor;
      Comissao.FieldByName('D_PAG_REC').AsDateTime := VpaDatPagamentoParcela;
      Comissao.post;
      result := Comissao.AMensagemErroGravacao;
      Sistema.MarcaTabelaParaImportar('MOVCOMISSOES');
      if Comissao.AErronaGravacao then
        exit;
    end;
    Comissao.next;
  end;
  comissao.close;
end;

{******************************************************************************}
function TFuncoesComissao.EstornaComissao(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer) : string;
begin
  result := '';
  PosicionaComisaoCR(Comissao,VpaCodfilial,VpaLanReceber,VpaNumParcela);
  while not Comissao.Eof do
  begin
    if Comissao.FieldByName('C_LIB_AUT').AsString = 'N' then
    begin
      if not Comissao.FieldByname('D_DAT_PAG').IsNull then
        result := 'COMISSÃO PAGA!!!'#13'Não é possivel concluir a operação pois a comissão já foi paga para o vendedor';

      if result = '' then
      begin
        Comissao.Edit;
        Comissao.FieldByName('D_DAT_VAL').clear;
        Comissao.FieldByName('D_PAG_REC').clear;
        Comissao.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
        Comissao.post;
        result := Comissao.AMensagemErroGravacao;
      end;
    end;
    Comissao.Next;
  end;
  Sistema.MarcaTabelaParaImportar('MOVCOMISSOES');
  comissao.close;
end;

end.
