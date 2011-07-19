Unit UnCondicaoPagamento;

Interface

Uses Classes, UnDadosCR,SQLExpr, tabela, SysUtils;

//classe funcoes
Type TRBFuncoesCondicaoPagamento = class
  private
    Cadastro : TSQL;
    Tabela,
    Aux : TSqlQuery;
    function RCodCondicaoPagamentoDisponivel : Integer;
    function GravaDParcelas(VpaDCondicaoPagamento : TRBDCondicaoPagamento) : String;
    procedure CarDParcelas(VpaDCondicaoPagamento : TRBDCondicaoPagamento);
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    procedure CriaParcelas(VpaDCondicaoPagamento : TRBDCondicaoPagamento);
    procedure VerificaPercentuais(VpaDCondicaoPagamento : TRBDCondicaoPagamento);
    function GravaDCondicaoPagamento(VpaDCondicaoPagamento : TRBDCondicaoPagamento):string;
    procedure CarDCondicaoPagamento(VpaDCondicaoPagamento : TRBDCondicaoPagamento;VpaCodCondicaoPagamento : Integer);
end;



implementation

Uses FunSql, FunNumeros,  FunObjeto, Fundata, Constantes, UnSistema;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesCondicaoPagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesCondicaoPagamento.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Cadastro := TSQL.create(nil);
  Cadastro.ASQlConnection := VpaBaseDados;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesCondicaoPagamento.destroy;
begin
  Cadastro.free;
  Aux.free;
  Tabela.Free;
  inherited;
end;

{******************************************************************************}
procedure TRBFuncoesCondicaoPagamento.CarDParcelas(VpaDCondicaoPagamento: TRBDCondicaoPagamento);
var
  VpfDParcela : TRBDParcelaCondicaoPagamento;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MOVCONDICAOPAGTO '+
                                 ' Where I_COD_PAG = '+ IntToStr(VpaDCondicaoPagamento.CodCondicaoPagamento)+
                                 ' ORDER BY I_NRO_PAR');
  while not Tabela.eof do
  begin
    VpfDParcela := VpaDCondicaoPagamento.AddParcela;
    with VpfDParcela do
    begin
      NumParcela := Tabela.FieldByName('I_NRO_PAR').AsInteger;
      QtdDias := Tabela.FieldByName('I_NUM_DIA').AsInteger;
      DiaFixo := Tabela.FieldByName('I_DIA_FIX').AsInteger;
      PerParcela := Tabela.FieldByName('N_PER_PAG').AsFloat;
      PerAcrescimoDesconto := Tabela.FieldByName('N_PER_CON').AsFloat;
      TipAcrescimoDesconto := Tabela.FieldByName('C_CRE_DEB').AsString;
      CodFormaPagamento := Tabela.FieldByName('I_COD_FRM').AsInteger;
      DatFixa := Tabela.FieldByName('D_DAT_FIX').AsDateTime;
      if Tabela.FieldByName('I_DIA_FIX').AsInteger = 100  then
        TipoParcela := tpProximoMes
        else
          if Tabela.FieldByName('I_DIA_FIX').AsInteger <> 0  then
            TipoParcela := tpDiaFixo
          else
            if Tabela.FieldByName('D_DAT_FIX').AsDateTime > MontaData(1,1,1900)  then
              TipoParcela := tpDataFixa
            else
              TipoParcela := tpQtdDias;
    end;
    Tabela.Next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesCondicaoPagamento.CarDCondicaoPagamento(VpaDCondicaoPagamento: TRBDCondicaoPagamento;VpaCodCondicaoPagamento : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADCONDICOESPAGTO '+
                                 ' Where I_COD_PAG = '+IntToStr(VpaCodCondicaoPagamento));
  with VpaDCondicaoPagamento do
  begin
    CodCondicaoPagamento := VpaCodCondicaoPagamento;
    NomCondicaoPagamento :=  Tabela.FieldByName('C_NOM_PAG').AsString;
    QtdParcelas := Tabela.FieldByName('I_QTD_PAR').AsInteger;
  end;
  CarDParcelas(VpaDCondicaoPagamento);
end;

{******************************************************************************}
function TRBFuncoesCondicaoPagamento.RCodCondicaoPagamentoDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select max(I_COD_PAG) ULTIMO from CADCONDICOESPAGTO ');
  Result := aux.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;
{******************************************************************************}
procedure TRBFuncoesCondicaoPagamento.CriaParcelas(VpaDCondicaoPagamento : TRBDCondicaoPagamento);
var
  VpfLaco : Integer;
  VpfTotalPercentual : Double;
  VpfDParcela : TRBDParcelaCondicaoPagamento;
begin
  VpfTotalPercentual := 0;
  FreeTObjectsList(VpaDCondicaoPagamento.Parcelas);
  for VpfLaco := 1 to VpaDCondicaoPagamento.QtdParcelas do
  begin
    VpfDParcela :=  VpaDCondicaoPagamento.AddParcela;
    VpfDParcela.NumParcela := VpfLaco;
    VpfDParcela.PerParcela :=  ArredondaDecimais(100 / VpaDCondicaoPagamento.QtdParcelas,2);
    VpfTotalPercentual := VpfTotalPercentual + VpfDParcela.PerParcela;
    if VpaDCondicaoPagamento.QtdParcelas = VpfDParcela.NumParcela then
    begin
      if VpfTotalPercentual < 100 then
        VpfDParcela.PerParcela := VpfDParcela.PerParcela + (100 - VpfTotalPercentual)
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesCondicaoPagamento.VerificaPercentuais(VpaDCondicaoPagamento : TRBDCondicaoPagamento);
var
  VpfLaco : Integer;
  VpfTotalPercentual : Double;
  VpfDPercentual : TRBDParcelaCondicaoPagamento;
begin
  VpfTotalPercentual := 0;
  for VpfLaco := 0 to VpaDCondicaoPagamento.Parcelas.Count -1 do
  begin
    VpfDPercentual := TRBDParcelaCondicaoPagamento(VpaDCondicaoPagamento.Parcelas.Items[VpfLaco]);
    VpfTotalPercentual := VpfTotalPercentual + VpfDPercentual.PerParcela;
    if VpfLaco = VpaDCondicaoPagamento.Parcelas.Count -1 then
    begin
      if VpfTotalPercentual <> 100 then
        VpfDPercentual.PerParcela := VpfDPercentual.PerParcela + (100 - VpfTotalPercentual);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesCondicaoPagamento.GravaDCondicaoPagamento(VpaDCondicaoPagamento : TRBDCondicaoPagamento) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCONDICOESPAGTO '+
                                 ' Where I_COD_PAG = '+IntToStr(VpaDCondicaoPagamento.CodCondicaoPagamento));
  if VpaDCondicaoPagamento.CodCondicaoPagamento = 0  then
    Cadastro.insert
  else
    Cadastro.edit;
  Cadastro.FieldByName('C_NOM_PAG').AsString := VpaDCondicaoPagamento.NomCondicaoPagamento;
  Cadastro.FieldByName('I_QTD_PAR').AsInteger := VpaDCondicaoPagamento.QtdParcelas;
  Cadastro.FieldByName('D_VAL_CON').AsDateTime := MontaData(1,1,2100);
  Cadastro.FieldByName('N_IND_REA').AsInteger := 0;
  Cadastro.FieldByName('N_PER_DES').AsInteger := 0;
  Cadastro.FieldByName('I_DIA_CAR').AsInteger := 0;
  Cadastro.FieldByName('C_GER_CRE').AsString := 'S';
  Cadastro.FieldByName('D_ULT_ALT').AsDateTime := DATE;
  Cadastro.FieldByName('I_COD_USU').AsInteger := varia.CodigoUsuario;
  if VpaDCondicaoPagamento.CodCondicaoPagamento = 0  then
    VpaDCondicaoPagamento.CodCondicaoPagamento := RCodCondicaoPagamentoDisponivel;
  Cadastro.FieldByName('I_COD_PAG').AsInteger := VpaDCondicaoPagamento.CodCondicaoPagamento;
  cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Sistema.MarcaTabelaParaImportar('CADCONDICOESPAGTO');
  if result = ''  then
    result := GravaDParcelas(VpaDCondicaoPagamento);
end;

{******************************************************************************}
function TRBFuncoesCondicaoPagamento.GravaDParcelas(VpaDCondicaoPagamento: TRBDCondicaoPagamento): String;
var
  VpfDParcela : TRBDParcelaCondicaoPagamento;
  VpfLaco : Integer;
begin
  ExecutaComandoSql(Aux,'Delete from MOVCONDICAOPAGTO '+
                        ' Where I_COD_PAG = '+IntToStr(VpaDCondicaoPagamento.CodCondicaoPagamento));
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCONDICAOPAGTO '+
                                 ' Where I_COD_PAG = 0 AND I_NRO_PAR = 0');
  for VpfLaco := 0 to VpaDCondicaoPagamento.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaCondicaoPagamento(VpaDCondicaoPagamento.Parcelas.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('I_COD_PAG').AsInteger := VpaDCondicaoPagamento.CodCondicaoPagamento;
    Cadastro.FieldByName('I_NRO_PAR').AsInteger := VpfLaco+1;
    case VpfDParcela.TipoParcela of
      tpProximoMes:
      begin
        Cadastro.FieldByName('I_NUM_DIA').AsInteger := 0;
        Cadastro.FieldByName('I_DIA_FIX').AsInteger := 100;
      end;
      tpQtdDias:
      begin
        Cadastro.FieldByName('I_NUM_DIA').AsInteger := VpfDParcela.QtdDias;
        Cadastro.FieldByName('I_DIA_FIX').AsInteger := 0;
      end;
      tpDiaFixo:
      begin
        Cadastro.FieldByName('I_NUM_DIA').AsInteger := 0;
        Cadastro.FieldByName('I_DIA_FIX').AsInteger := VpfDParcela.DiaFixo;
      end;
      tpDataFixa:
      begin
        Cadastro.FieldByName('I_NUM_DIA').AsInteger := 0;
        Cadastro.FieldByName('I_DIA_FIX').AsInteger := 0;
        Cadastro.FieldByName('D_DAT_FIX').AsDateTime := VpfDParcela.DatFixa;
      end;
    end;
    Cadastro.FieldByName('N_PER_CON').AsFloat := VpfDParcela.PerAcrescimoDesconto;
    Cadastro.FieldByName('C_CRE_DEB').AsString := VpfDParcela.TipAcrescimoDesconto;
    Cadastro.FieldByName('N_PER_PAG').AsFloat := VpfDParcela.PerParcela;
    Cadastro.FieldByName('N_PER_COM').AsFloat := VpfDParcela.PerParcela;
    Cadastro.FieldByName('I_TIP_COM').AsInteger := 1;
    Cadastro.FieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
    Cadastro.FieldByName('I_COD_FRM').AsInteger := VpfDParcela.CodFormaPagamento;
    cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Sistema.MarcaTabelaParaImportar('MOVCONDICAOPAGTO');
  cadastro.close;
end;

end.
