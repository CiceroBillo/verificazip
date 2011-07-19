unit UnDespesas;
{Verificado
-.edit;
}
interface

uses

  Db, DBTables, Classes, sysUtils,SQLExpr, Tabela;

type
  TFuncoesDespesas = class
    AUX : TSQLQuery;
    AUX1,
    CAD : TSQL;
    VprBaseDados : TSqlConnection;
  private
    Campos: TStringList;
    procedure CarregaMOV(VpaTstringMOV: TStringList);
    procedure CarregaCAD(VpaTstringCAD: TStringList);
  public
    constructor Criar( Aowner : TComponent; VpaBaseDados : TSqlConnection);
    destructor Destroy;
    function GeraDespesasFixas(TituloAPagar: Integer): Boolean;
    function AtualizaDespesas: Boolean;
    procedure GeraNovaDespesa(VpaValor: Double; VpaDiaVencimento,
      VpaQtdMesesInc: Integer; VpaDespesa: string);
    function BuscaValorDias(VpaDataInicio, VpaDespesa: string;
      var VpaValor: Double; var VpaDias: Integer): boolean;
    function ExisteDespesaPeriodo(VpaDespesa: string;
      VpaDataInicio, VpaDataFim: TDateTime): Integer;
    procedure AlteraDespesa(VpaLancamento: Integer;
      VpaNovaDataVencimento: TDateTime; VpaValor:Double);

end;

implementation

uses Constantes, fundata, funstring, funsql, ConstMsg;

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesDespesas.Criar( Aowner : TComponent; VpaBaseDados : TSqlConnection);
begin
  inherited;
  Campos := TStringList.Create;
  VprBaseDados := VpaBaseDados;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Cad := TSQL.Create(nil);
  Cad.ASQLConnection := VpaBaseDados;
  AUX1 := TSQL.Create(nil);
  AUX1.ASQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesDespesas.Destroy;
begin
  Campos.Free;
  AUX.Destroy;
  AUX1.Destroy;
  CAD.Destroy;
  inherited;
end;

{ ***** gera as despesas novas quando vira o mes ***** }
function TFuncoesDespesas.AtualizaDespesas: Boolean;
var
  VpfValor: Double;
  VpfDias: Integer;
begin
  // Seleciona as despesas fixas ativas.
  AdicionaSQLAbreTabela(CAD, ' SELECT * FROM CADDESPESAS,  ' +
                             ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
                             ' AND UPPER(C_ATI_DES) = ''S''');
  if (not CAD.EOF) then
  begin
    CAD.First;
    while (not CAD.EOF) do
    begin
      // Data inicial da média;
      if BuscaValorDias(DataToStrFormato(AAAAMMDD,DecMes(Date,
                        CAD.FieldByName('I_MES_MED').AsInteger),'/'),
                        Trim(CAD.FieldByName('I_COD_DES').AsString),
                        VpfValor,
                        VpfDias) then
        GeraNovaDespesa(VpfValor,
                        VpfDias,
                        CAD.FieldByName('I_MES_GER').AsInteger,
                        CAD.FieldByName('I_COD_DES').AsString);
      CAD.Next;
    end;
  end;
end;


function TFuncoesDespesas.BuscaValorDias(VpaDataInicio, VpaDespesa: string;
  var VpaValor: Double; var VpaDias: Integer): boolean;
var
  VpfDataFim: string;
begin
  VpfDataFim:=DataToStrFormato(AAAAMMDD, UltimoDiaMesAnterior, '/');
  // Retorna o novo valor de cadastro e o dia de vencimento.
  AdicionaSQLAbreTabela(AUX, ' SELECT ISNULL(SUM(N_VLR_DUP)/ COUNT(*),0) AS VALOR ,' +
    ' ISNULL(SUM(DAY(D_DAT_VEN)) / COUNT(*),0) AS DIA ' +
    ' FROM CADCONTASAPAGAR CP KEY JOIN MOVCONTASAPAGAR MCP ' +
    ' WHERE MCP.D_DAT_VEN  BETWEEN ''' + VpaDataInicio + ''' AND ''' + VpfDataFim + '''' +
    ' AND CP.I_COD_DES = ' + VpaDespesa);
  VpaValor:=AUX.FieldByName('VALOR').AsFloat;
  VpaDias:=AUX.FieldByName('DIA').AsInteger;
  Result:=(VpaValor > 0);
end;


{ ***** gera a nova despesa deste lancamento para o próximo mês ***** }
procedure TFuncoesDespesas.GeraNovaDespesa(VpaValor: Double;
  VpaDiaVencimento, VpaQtdMesesInc: Integer; VpaDespesa: string);
var
  I,
  X,
  VpfProximoTitulo,
  VpfLancamento : Integer;
  VpfDataIni,
  VpfDataFim,
  VpfNovaDataVencimento: TDateTime;
begin
  // Posiciona no último título a ser copiado.
  AdicionaSQLAbreTabela(AUX, ' SELECT * FROM CADCONTASAPAGAR CP, MOVCONTASAPAGAR  MCP, CADDESPESAS DSP ' +
                             ' WHERE CP.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
                             ' AND   CP.I_COD_DES =  ' + VpaDespesa +
                             ' AND   CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                             ' AND   CP.I_EMP_FIL = DSP.I_EMP_FIL ' +
                             ' AND   CP.I_LAN_APG = MCP.I_LAN_APG ' +
                             ' AND   CP.I_COD_DES = DSP.I_COD_DES ' +
                             ' ORDER BY CP.I_EMP_FIL, CP.I_LAN_APG DESC ');
  // Se existir a despesa.
  if (not AUX.EOF) then
  begin
    AUX.First; // Posiciona no último pois é DESC.
    // Acha o primeiro e o último dia do proximo mês.
    VpfDataIni:=PrimeiroDiaProximoMes;
    VpfDataFim:=UltimoDiaMes(VpfDataIni);
    for X:=1 to VpaQtdMesesInc do
    begin
      // Nova data de vencimento das parcelas posteriores.
      VpfNovaDataVencimento:=IncDia(VpfDataIni, (VpaDiaVencimento - 1));
      VpfLancamento := ExisteDespesaPeriodo(VpaDespesa, VpfDataIni, VpfDataFim);
      // Se achar atualizar a data de vencimento e o valor, senão, criar com estes valores.
      if ( VpfLancamento > 0) then
      begin
        if Config.AtualizarDespesas then // Atualiza todas as depesas fixas que não foram baixas.
          AlteraDespesa(VpfLancamento, VpfNovaDataVencimento, VpaValor);
      end
      else
      begin
        // Criar a despesa com o novo valor e data de vencimento
        // Acha o próximo código a ser escolhido.
        VpfProximoTitulo:=ProximoCodigoFilial('CadContasAPagar', 'I_LAN_APG', 'I_EMP_FIL', Varia.CodigoEmpFil,VprBaseDados );
        // TABELA DE CABEÇALHO.
        AdicionaSQLAbreTabela(AUX1,' SELECT * FROM CADCONTASAPAGAR ');
        InserirReg(AUX1);
        CarregaCAD(Campos);
        for I := 0 to (Campos.Count - 1) do
          AUX1.FieldByName(Campos.Strings[I]).Value := AUX.fieldByName(Campos.Strings[I]).Value;
        AUX1.FieldByName('I_LAN_APG').AsInteger:=VpfProximoTitulo;
        AUX1.FieldByName('C_FLA_DES').AsString:='S'; // Identifica como despesa fixa.
        //atualiza a data de alteracao para poder exportar
        AUX1.FieldByName('D_ULT_ALT').AsDateTime := Date;
        GravaReg(AUX1);
        // TABELA DE MOVIMENTAÇÃO.
        AdicionaSQLAbreTabela(AUX1,' SELECT * FROM MOVCONTASAPAGAR ');
        InserirReg(AUX1);
        CarregaMOV(Campos);
        for I := 0 to Campos.Count - 1 do
          AUX1.FieldByName(Campos.Strings[I]).Value := AUX.fieldByName(Campos.Strings[I]).Value;
        AUX1.FieldByName('I_LAN_APG').AsInteger:=VpfProximoTitulo;
        // Valor Média.
        AUX1.FieldByName('N_VLR_DUP').AsFloat:=VpaValor;
        // Nova data de vencimento.
        AUX1.FieldByName('D_DAT_VEN').AsDateTime:=VpfNovaDataVencimento;
        //atualiza a data de alteracao para poder exportar
        AUX1.FieldByName('D_ULT_ALT').AsDateTime := Date;
        GravaReg(AUX1);
      end;
      // IMCREMENTAR O PERÍODO.
      VpfDataIni:=IncMes(VpfDataIni, 1); // Muda para o próximo mês;
      VpfDataFim:=UltimoDiaMes(VpfDataIni);
    end;
  end;
end;


{ *****  Atualizar a despesa com o novo valor e data de vencimento ***** }
procedure TFuncoesDespesas.AlteraDespesa(VpaLancamento: Integer;
  VpaNovaDataVencimento: TDateTime; VpaValor:Double);
begin
  LimpaSQLTabela(AUX1);
  AdicionaSQLTabela(AUX1,
    ' UPDATE MOVCONTASAPAGAR SET ' +
    ' D_DAT_VEN = '''     + DataToStrFormato(AAAAMMDD, VpaNovaDataVencimento, '/') + ''', ' +
    ' N_VLR_DUP = '       +  SubstituiStr(FloatToStr(VpaValor),',','.') +
    ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(DATE)+
    ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND I_LAN_APG = '   + IntToStr(VpaLancamento));
  AUX1.ExecSQL;
end;


{ ***** verifica se existe uma despesa no período informado ***** }
function TFuncoesDespesas.ExisteDespesaPeriodo(VpaDespesa: string;
  VpaDataInicio, VpaDataFim: TDateTime): Integer;
begin
  AdicionaSQLAbreTabela(AUX1,
    ' SELECT CP.I_LAN_APG FROM CADCONTASAPAGAR CP KEY JOIN MOVCONTASAPAGAR MCP ' +
    '   WHERE CP.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    '   AND CP.I_COD_DES = ' + VpaDespesa +
    '   AND MCP.D_DAT_VEN BETWEEN ''' + DataToStrFormato(AAAAMMDD, VpaDataInicio, '/') +
    ''' AND ''' + DataToStrFormato(AAAAMMDD, VpaDataFim, '/') + '''');
  Result:=AUX1.FieldByName('I_LAN_APG').AsInteger;
end;


{ ***** gera as despesas futuras ***** }
function TFuncoesDespesas.GeraDespesasFixas(TituloAPagar: Integer): Boolean;
var
  I,
  VpfMeses,
  VpfQuantidade,
  VpfProximoTitulo : Integer;
  VpfDataVencimento : TDateTime;
begin
    Result:=True;
    AdicionaSQLAbreTabela(AUX, ' SELECT * FROM CADCONTASAPAGAR CP, MOVCONTASAPAGAR  MCP, CADDESPESAS DSP ' +
                               ' WHERE CP.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
                               ' AND   CP.I_LAN_APG =  ' + IntToStr(TituloAPagar) +
                               ' AND   CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                               ' AND   CP.I_EMP_FIL = DSP.I_EMP_FIL ' +
                               ' AND   CP.I_LAN_APG = MCP.I_LAN_APG ' +
                               ' AND   CP.I_COD_DES = DSP.I_COD_DES ');
    if (not AUX.EOF) then
    begin
      VpfMeses := AUX.FieldByName('I_MES_GER').AsInteger;
      VpfDataVencimento:=AUX.FieldByName('D_DAT_VEN').AsDateTime;
      for VpfQuantidade := 1 to VpfMeses  do
      begin
        // Incrementa em 1 mês a data de vencimento.
        VpfDataVencimento:=IncMes(VpfDataVencimento, 1);
        // Acha o próximo código a ser escolhido.
        VpfProximoTitulo:=ProximoCodigoFilial('CadContasAPagar', 'I_LAN_APG', 'I_EMP_FIL', Varia.CodigoEmpFil,VprBaseDados);
        // TABELA DE CABEÇALHO.
        // Aqui contém um erro que deve ser achado ...
        CAD.close;
        AdicionaSQLAbreTabela(CAD,' SELECT * FROM CADCONTASAPAGAR ');
        InserirReg(CAD);

        //atualiza a data de alteracao para poder exportar
        CAD.FieldByName('D_ULT_ALT').AsDateTime := Date;

        CAD.FieldByName('I_LAN_APG').AsInteger := VpfProximoTitulo;
        CarregaCAD(Campos);
        for I := 0 to (Campos.Count - 1) do
          CAD.FieldByName(Campos.Strings[I]).Value := AUX.fieldByName(Campos.Strings[I]).Value;
        CAD.FieldByName('C_FLA_DES').AsString := 'S'; // Identifica como despesa fixa.
        GravaReg(CAD);

        // TABELA DE MOVIMENTAÇÃO.
        AdicionaSQLAbreTabela(CAD,' SELECT * FROM MOVCONTASAPAGAR ');
        InserirReg(CAD);
        CarregaMOV(Campos);
        for I := 0 to Campos.Count - 1 do
          CAD.FieldByName(Campos.Strings[I]).Value := AUX.fieldByName(Campos.Strings[I]).Value;
        CAD.FieldByName('I_LAN_APG').AsInteger:=VpfProximoTitulo;
        CAD.FieldByName('D_DAT_VEN').AsDateTime:=VpfDataVencimento;
        CAD.FieldByName('L_OBS_APG').AsString := AUX.FieldByName('L_OBS_APG').AsString + ' -> Despesa gerada automaticamente pelo sistema. ';
        //atualiza a data de alteracao para poder exportar
        CAD.FieldByName('D_ULT_ALT').AsDateTime := Date;
        GravaReg(CAD);
      end;
    end
    else Result := False;
end;

{ ***** carrega o TStringList com os campos da tabelas de movimentação ***** }
procedure TFuncoesDespesas.CarregaMOV(VpaTstringMOV: TStringList);
begin
  VpaTstringMOV.Clear;
  VpaTstringMOV.Add('I_EMP_FIL');
  VpaTstringMOV.Add('I_NRO_PAR');
  VpaTstringMOV.Add('C_NRO_CON');
  VpaTstringMOV.Add('I_LAN_BAC');
  VpaTstringMOV.Add('C_NRO_DUP');
  VpaTstringMOV.Add('N_VLR_DUP');
  VpaTstringMOV.Add('N_VLR_DES');
  VpaTstringMOV.Add('N_PER_JUR');
  VpaTstringMOV.Add('N_PER_MOR');
  VpaTstringMOV.Add('N_PER_MUL');
  VpaTstringMOV.Add('I_COD_USU');
  VpaTstringMOV.Add('N_VLR_ACR');
  VpaTstringMOV.Add('N_PER_DES');
  VpaTstringMOV.Add('C_NRO_DOC');
  VpaTstringMOV.Add('N_VLR_JUR');
  VpaTstringMOV.Add('N_VLR_MOR');
  VpaTstringMOV.Add('N_VLR_MUL');
  VpaTstringMOV.Add('I_COD_FRM');
  VpaTstringMOV.Add('D_CHE_VEN');
  VpaTstringMOV.Add('C_BAI_BAN');
  VpaTstringMOV.Add('C_FLA_PAR');
  VpaTstringMOV.Add('I_PAR_FIL');
  VpaTstringMOV.Add('C_DUP_CAN');
  VpaTstringMOV.Add('I_COD_MOE');
end;

{ ***** carrega o TStringList com os campos da tabelas de cabeçalho ***** }
procedure TFuncoesDespesas.CarregaCAD(VpaTstringCAD: TStringList);
begin
  VpaTstringCAD.Clear;
  VpaTstringCAD.Add('I_EMP_FIL');
  VpaTstringCAD.Add('I_COD_CLI');
  VpaTstringCAD.Add('I_NRO_NOT');
  VpaTstringCAD.Add('I_COD_DES');
  VpaTstringCAD.Add('C_CLA_PLA');
  VpaTstringCAD.Add('I_COD_EMP');
  VpaTstringCAD.Add('D_DAT_MOV');
  VpaTstringCAD.Add('D_DAT_EMI');
  VpaTstringCAD.Add('N_VLR_TOT');
  VpaTstringCAD.Add('I_QTD_PAR');
  VpaTstringCAD.Add('I_COD_USU');
  VpaTstringCAD.Add('N_VLR_MOR');
  VpaTstringCAD.Add('N_VLR_JUR');
  VpaTstringCAD.Add('I_SEQ_NOT');
end;

end.
