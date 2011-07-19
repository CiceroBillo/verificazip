Unit UnExportacaoDados;

Interface

Uses Classes, DBTables, Tabela, SysUtils, UnDados,SQLExpr, StdCtrls, ComCtrls, unVersoes, UnProdutos,
     UnDadosProduto, UnCotacao, UnNotaFiscal;

//classe localiza
Type TRBLocalizaExportacaoDados = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesExportacaoDados = class(TRBLocalizaExportacaoDados)
  private
    Pedido,
    Tabela,
    TabelaMatriz,
    PedidoMatriz,
    CadastroMatriz : TSQl;
    VprLabelQtd,
    VprLabelProcesso : TLabel;
    VprBarraProgresso : TProgressBar;
    procedure LocalizaClientesNaoExportados(VpaTabela : TSQL);
    procedure LocalizaPedidosNaoExportados(VpaTabela : TSQL);
    procedure LocalizaNotasNaoExportadas(VpaTabela : TSQL);
    procedure LocalizaContasaReceberNaoExportado(VpaTabela : TSQL);
    procedure LocalizaMovComissoesNaoExportado(VpaTabela : TSQL);
    procedure LocalizaMovOrcamento(VpaTabela : TSQl;VpaCodFilial,VpaLanOrcamento : Integer);
    procedure LocalizaMovServicoOrcamento(VpaTabela : TSQl;VpaCodFilial,VpaLanOrcamento : Integer);
    procedure LocalizaMovNotas(VpaTabela : TSQL;VpaCodFilial,VpaSeqNota : Integer);
    procedure LocalizaMovContasAReceber(VpaTabela : TSQL;VpaCodFilial, VpaLanReceber : Integer);
    procedure LocalizaMovServicoNota(VpaTabela : TSQL;VpaCodFilial,VpaSeqNota : Integer);
    procedure AtualizaProcesso(VpaDesProcesso : string);
    function ExisteClienteMatriz(VpaCodCliente : Integer; VpaNumCNPJ, VpaNUMCPF : string):string;
    function ExistePedidoMatriz(VpaCodFilial, VpaLanOrcamento : Integer) : string;
    function ExisteNotaMatriz(VpaCodFilial, VpaSeqNota : Integer):string;
    function ExisteContasaReceberMatriz(VpaCodFilial,VpaLanReceber : Integer) :string;
    function ExisteComissaoMatriz(VpaCodFilial, VpaLanComissao : Integer) : string;
    function ExportaMovOrcamento(VpaDExportacao : TRBDExportacaoDados;VpaCodFilial, VpaNumpedido :Integer):string;
    function ExportaMovServicoOrcamento(VpaDExportacao : TRBDExportacaoDados;VpaCodFilial, VpaNumpedido :Integer):string;
    function ExportaMovNotasFiscais(VpaDExportacao : TRBDExportacaoDados;VpaCodFilial, VpaSeqNota :Integer):string;
    function ExportaMovContasaReceber(VpaDExportacao : TRBDExportacaoDados;VpaCodFilial, VpaLanReceber :Integer):string;
    function ExportaMovNotasFiscaisServico(VpaDExportacao : TRBDExportacaoDados;VpaCodFilial, VpaSeqNota :Integer):string;
  public
    constructor cria(VpaBaseDados, VpaBaseDadosMatriz : TSQLConnection;VpaLabelProcesso, VpaLabelQtd : TLabel;VpaBarraProgresso : TProgressBar);
    function ExportaCliente(VpaDExportacao : TRBDExportacaoDados):string;
    function ExportaPedido(VpaDExportacao : TRBDExportacaoDados):string;
    function ExportaNotaFiscal(VpaDExportacao : TRBDExportacaoDados):string;
    function ExportaContasaReceber(VpaDExportacao : TRBDExportacaoDados):string;
    function ExportaComissao(VpaDExportacao : TRBDExportacaoDados):string;
end;



implementation

Uses FunSql,constantes, APrincipal;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaExportacaoDados
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaExportacaoDados.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesExportacaoDados
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
procedure TRBFuncoesExportacaoDados.AtualizaProcesso(VpaDesProcesso: string);
begin
  VprLabelProcesso.Caption := VpaDesProcesso;
  VprLabelProcesso.Refresh;
end;

{********************************************************************************}
constructor TRBFuncoesExportacaoDados.cria(VpaBaseDados, VpaBaseDadosMatriz : TSQLConnection;VpaLabelProcesso, VpaLabelQtd : TLabel;VpaBarraProgresso : TProgressBar);
begin
  inherited create;
  Tabela := TSQL.Create(nil);
  Tabela.ASQlConnection := VpaBaseDados;
  Pedido := TSQL.Create(nil);
  Pedido.ASQlConnection := VpaBaseDados;

  TabelaMatriz := TSQL.create(nil);
  TabelaMatriz.ASQlConnection := VpaBaseDadosMatriz;
  CadastroMatriz := TSQL.create(nil);
  CadastroMatriz.ASQlConnection := VpaBaseDadosMatriz;
  PedidoMatriz := TSQL.create(nil);
  PedidoMatriz.ASQlConnection := VpaBaseDadosMatriz;
  VprLabelQtd := VpaLabelQtd;
  VprLabelProcesso := VpaLabelProcesso;
  VprBarraProgresso := VpaBarraProgresso;
end;

{********************************************************************************}
function TRBFuncoesExportacaoDados.ExisteClienteMatriz( VpaCodCliente: Integer; VpaNumCNPJ, VpaNUMCPF: string): string;
var
  VpfFiltroCNPJCPF : string;
begin
  VpfFiltroCNPJCPF := '';
  if VpaNumCNPJ <> '' then
   VpfFiltroCNPJCPF :=  ' or C_CGC_CLI = '''+VpaNumCNPJ+''''
  else
    if VpaNUMCPF <> '' then
     VpfFiltroCNPJCPF :=  ' or C_CPF_CLI = '''+VpaNumCPF+'''';
  AdicionaSQLAbreTabela(TabelaMatriz,'Select I_COD_CLI from CADCLIENTES ' +
                                     ' Where I_COD_CLI = '+IntToStr(VpaCodCliente) +
                                     VpfFiltroCNPJCPF);
  if not TabelaMatriz.Eof then
  begin
    if TabelaMatriz.FieldByName('I_COD_CLI').AsInteger = VpaCodCliente then
      result := 'CODIGO CLIENTE DUPLICADO. O código "'+IntToStr(VpaCodCliente)+'" já esta sendo utilizado na fábrica para outro cliente'
    else
      result := 'CLIENTE JA CADASTRADO NA FABRICA. Esse cliente já existe cadastrado na fábrica com o código "'+TabelaMatriz.FieldByName('I_COD_CLI').AsString+'"';
  end;
end;

{******************************************************************************}
function TRBFuncoesExportacaoDados.ExisteComissaoMatriz(VpaCodFilial, VpaLanComissao: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(TabelaMatriz,'Select I_EMP_FIL FROM MOVCOMISSOES ' +
                                     ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial) +
                                     ' AND I_LAN_CON = ' +IntToStr(VpaLanComissao));
  if not TabelaMatriz.Eof  then
    result := 'COMISSÃO DUPLICADA NA FABRICA!!!Já existe digitado na fábrica uma comissão com o mesmo sequencial.';
  TabelaMatriz.Close;
end;

{******************************************************************************}
function TRBFuncoesExportacaoDados.ExisteContasaReceberMatriz(VpaCodFilial, VpaLanReceber: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(TabelaMatriz,'Select I_EMP_FIL FROM CADCONTASARECEBER ' +
                                     ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                                     ' AND I_LAN_REC = ' +IntToStr(VpaLanReceber));
  if  not TabelaMatriz.Eof then
    result := 'CONTAS A RECEBER DUPLICADO NA FABRICA!!!Ja existe digitado na fabrica um contas a receber com o mesmo sequencial';
  TabelaMatriz.Close;
end;

{******************************************************************************}
function TRBFuncoesExportacaoDados.ExisteNotaMatriz(VpaCodFilial, VpaSeqNota: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(TabelaMatriz,'Select I_EMP_FIL FROM CADNOTAFISCAIS ' +
                                     ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                                     ' AND I_SEQ_NOT = ' +IntToStr(VpaSeqNota));
  if  not TabelaMatriz.Eof then
    result := 'NOTA FISCAL DUPLICADA NA FABRICA!!!Ja existe digitado na fabrica uma nota fiscal com o mesmo sequencial';
  TabelaMatriz.Close;
end;

{********************************************************************************}
function TRBFuncoesExportacaoDados.ExistePedidoMatriz(VpaCodFilial, VpaLanOrcamento: Integer): string;
begin
  result := '';
  AdicionaSQLAbreTabela(TabelaMatriz,'Select I_EMP_FIL from CADORCAMENTOS ' +
                                     ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                     ' AND I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  if not TabelaMatriz.eof then
    result :=  'PEDIDO DUPLICADO NA FÁBRICA!!!Ja existe digitado na fabrica um pedido com o mesmo numero';
  TabelaMatriz.Close;
end;

{********************************************************************************}
function TRBFuncoesExportacaoDados.ExportaCliente(VpaDExportacao: TRBDExportacaoDados): string;
Var
  VpfResultado : string;
  VpfLacoCampos : Integer;
begin
  result := '';
  VpfResultado := '';
  LocalizaClientesnaoExportados(Tabela);
  VprBarraProgresso.Position := 0;
  VprBarraProgresso.Max := Tabela.RecordCount;
  AdicionaSQLAbreTabela(CadastroMatriz,'Select * from CADCLIENTES ' +
                                       ' Where I_COD_CLI = 0 ');
  while not Tabela.Eof do
  begin
    AtualizaProcesso('Verificando se o clientes existe cadastrado na Matriz');
    VpfResultado := ExisteClienteMatriz(Tabela.FieldByName('I_COD_CLI').AsInteger,Tabela.FieldByName('C_CGC_CLI').AsString,Tabela.FieldByName('C_CPF_CLI').AsString);
    if VpfResultado = '' then
    begin
      AtualizaProcesso('Exportando dados do cliente');

      CadastroMatriz.Insert;
      for VpfLacoCampos := 0 to Tabela.FieldCount - 1 do
        CadastroMatriz.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value := Tabela.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value;

      CadastroMatriz.FieldByName('C_FLA_EXP').AsString := 'S';
      CadastroMatriz.FieldByName('D_DAT_ALT').AsDateTime := VpaDExportacao.DatExportacao;
      CadastroMatriz.FieldByName('D_DAT_EXP').AsDateTime := VpaDExportacao.DatExportacao;

      CadastroMatriz.Post;
      VpfResultado := CadastroMatriz.AMensagemErroGravacao;
    end;
    if VpfResultado <> '' then
    begin
      VpaDExportacao.AddErroExportacao('CLIENTES',Tabela.FieldByName('I_COD_CLI').AsString,VpfResultado);
      VpaDExportacao.ClientesNaoExportados.Add(Tabela.FieldByName('I_COD_CLI').AsString);
    end;

    if VpfResultado = '' then
    begin
      Tabela.Edit;
      Tabela.FieldByName('C_FLA_EXP').AsString := 'S';
      Tabela.Post;
      VpaDExportacao.ClientesExportados.Add(Tabela.FieldByName('I_COD_CLI').AsString);
    end;

    VprBarraProgresso.Position := VprBarraProgresso.Position + 1;
    Tabela.Next;
  end;
end;

{******************************************************************************}
function TRBFuncoesExportacaoDados.ExportaComissao(VpaDExportacao: TRBDExportacaoDados): string;
Var
  VpfLacoCampos : Integer;
  VpfTransacao : TTransactionDesc;
begin
  result := '';
  LocalizaMovComissoesNaoExportado(Pedido);
  VprBarraProgresso.Position := 0;
  VprBarraProgresso.Max := Pedido.RecordCount;
  AdicionaSQLAbreTabela(PedidoMatriz,'Select * from MOVCOMISSOES ' +
                                       ' Where I_EMP_FIL = 0 AND I_LAN_CON = 0');
  while not Pedido.Eof do
  begin
    VpfTransacao.IsolationLevel :=xilDIRTYREAD;
    FPrincipal.BaseDadosMatriz.StartTransaction(vpfTransacao);
    AtualizaProcesso('Verificando se o numero da comisão existe na Matriz');
    result := ExisteComissaoMatriz(Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_LAN_CON').AsInteger);
    if result = '' then
    begin
      AtualizaProcesso('Verificando se o contas a receber da comisão existe na Matriz');
      result := ExisteContasaReceberMatriz(Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_LAN_REC').AsInteger);
      //se o result vir preenchido é porque existe o contas a receber exportado.
      if result = '' then
        result := 'CONTAS A RECEBER DA COMISSÃO NÃO EXPORTADO PARA A FABRICA!!!O contas a receber dessa comissão não foi exportado para a fabrica'
      else
        result := '';

    end;
    if result = '' then
    begin
      AtualizaProcesso('Exportando dados da comissão '+IntToStr(Pedido.FieldByName('I_LAN_CON').AsInteger));
      PedidoMatriz.Insert;
      for VpfLacoCampos := 0 to Pedido.FieldCount - 1 do
        PedidoMatriz.FieldByName(Pedido.Fields[VpfLacoCampos].DisplayName).Value := Pedido.FieldByName(Pedido.Fields[VpfLacoCampos].DisplayName).Value;

      PedidoMatriz.FieldByName('C_FLA_EXP').AsString := 'S';
      PedidoMatriz.FieldByName('D_ULT_ALT').AsDateTime := VpaDExportacao.DatExportacao;
      PedidoMatriz.FieldByName('D_DAT_EXP').AsDateTime := VpaDExportacao.DatExportacao;

      PedidoMatriz.Post;
      result := PedidoMatriz.AMensagemErroGravacao;
    end;

    if result <> '' then
    begin
      VpaDExportacao.AddErroExportacao('COMISSÃO',Pedido.FieldByName('I_EMP_FIL').AsString+'/'+Pedido.FieldByName('I_LAN_CON').AsString,result);
    end
    else

    if result = '' then
    begin
      FPrincipal.BaseDadosMatriz.Commit(VpfTransacao);
      Pedido.Edit;
      Pedido.FieldByName('C_FLA_EXP').AsString := 'S';
      Pedido.Post;
      VpaDExportacao.ComissaoExportada.Add(Pedido.FieldByName('I_EMP_FIL').AsString+'/'+Pedido.FieldByName('I_LAN_CON').AsString);
    end
    else
      FPrincipal.BaseDadosMatriz.Rollback(VpfTransacao);

    VprBarraProgresso.Position := VprBarraProgresso.Position + 1;
    Pedido.Next;
  end;
end;

{******************************************************************************}
function TRBFuncoesExportacaoDados.ExportaContasaReceber(VpaDExportacao: TRBDExportacaoDados): string;
Var
  VpfResultado : string;
  VpfLacoCampos : Integer;
  VpfTransacao : TTransactionDesc;
begin
  result := '';
  VpfResultado := '';
  LocalizaContasaReceberNaoExportado(Pedido);
  VprBarraProgresso.Position := 0;
  VprBarraProgresso.Max := Pedido.RecordCount;
  AdicionaSQLAbreTabela(PedidoMatriz,'Select * from CADCONTASARECEBER ' +
                                       ' Where I_EMP_FIL = 0 AND I_LAN_REC = 0');
  while not Pedido.Eof do
  begin
    VpfTransacao.IsolationLevel :=xilDIRTYREAD;
    FPrincipal.BaseDadosMatriz.StartTransaction(vpfTransacao);
    AtualizaProcesso('Verificando se o numero do contas a receber existe na Matriz');
    VpfResultado := ExisteContasaReceberMatriz (Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_LAN_REC').AsInteger);
    if VpfResultado = '' then
    begin
      if VpaDExportacao.ClientesNaoExportados.IndexOf(Pedido.FieldByName('I_COD_CLI').AsString) >=0 then
        VpfResultado := 'Cliente referente a esse contas a receber nao exportado';
    end;
    if VpfResultado = '' then
    begin
      AtualizaProcesso('Exportando dados do corpo do contas a receber '+IntToStr(Pedido.FieldByName('I_LAN_REC').AsInteger));
      PedidoMatriz.Insert;
      for VpfLacoCampos := 0 to Pedido.FieldCount - 1 do
        PedidoMatriz.FieldByName(Pedido.Fields[VpfLacoCampos].DisplayName).Value := Pedido.FieldByName(Pedido.Fields[VpfLacoCampos].DisplayName).Value;

      PedidoMatriz.FieldByName('C_FLA_EXP').AsString := 'S';
      PedidoMatriz.FieldByName('D_ULT_ALT').AsDateTime := VpaDExportacao.DatExportacao;
      PedidoMatriz.FieldByName('D_DAT_EXP').AsDateTime := VpaDExportacao.DatExportacao;

      PedidoMatriz.Post;
      VpfResultado := PedidoMatriz.AMensagemErroGravacao;
    end;

    if VpfResultado <> '' then
    begin
      VpaDExportacao.AddErroExportacao('CONTAS A RECEBER CORPO',Pedido.FieldByName('I_EMP_FIL').AsString+'/'+Pedido.FieldByName('I_LAN_REC').AsString,VpfResultado);
    end
    else
    begin
      VpfResultado := ExportaMovContasaReceber(VpaDExportacao,Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_LAN_REC').AsInteger);
    end;

    if VpfResultado = '' then
    begin
      FPrincipal.BaseDadosMatriz.Commit(VpfTransacao);
      Pedido.Edit;
      Pedido.FieldByName('C_FLA_EXP').AsString := 'S';
      Pedido.Post;
      VpaDExportacao.ContasaReceberExportados.Add(Pedido.FieldByName('I_EMP_FIL').AsString+'/'+Pedido.FieldByName('I_LAN_REC').AsString);
    end
    else
      FPrincipal.BaseDadosMatriz.Rollback(VpfTransacao);

    VprBarraProgresso.Position := VprBarraProgresso.Position + 1;
    Pedido.Next;
  end;
end;

{********************************************************************************}
function TRBFuncoesExportacaoDados.ExportaMovContasaReceber(VpaDExportacao: TRBDExportacaoDados; VpaCodFilial,VpaLanReceber: Integer): string;
var
  VpfLacoCampos : Integer;
begin
  result := '';
  LocalizaMovContasAReceber(Tabela,VpaCodFilial,VpaLanReceber);
  AdicionaSQLAbreTabela(CadastroMatriz,'Select * from MOVCONTASARECEBER ' +
                                       ' Where I_EMP_FIL = 0 AND I_LAN_REC = 0 AND I_NRO_PAR = 0');
  while not Tabela.Eof do
  begin
    AtualizaProcesso('Exportando a parcela "'+Tabela.FieldByName('I_NRO_PAR').AsString+'" do contas a receber "'+IntToStr(VpaLanReceber)+'"');
    CadastroMatriz.Insert;
    for VpfLacoCampos := 0 to Tabela.FieldCount - 1 do
      CadastroMatriz.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value := Tabela.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value;
    CadastroMatriz.Post;
    result := CadastroMatriz.AMensagemErroGravacao;
    if result <> '' then
    begin
      VpaDExportacao.AddErroExportacao('CONTAS A RECEBER ITEM',TABELA.FieldByName('I_EMP_FIL').AsString+'/'+Tabela.FieldByName('I_LAN_REC').AsString+'/'+Tabela.FieldByName('I_NRO_PAR').AsString,result);
      exit;
    end;
    Tabela.Next;
  end;
  CadastroMatriz.Close;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesExportacaoDados.ExportaMovNotasFiscais(VpaDExportacao: TRBDExportacaoDados; VpaCodFilial,VpaSeqNota: Integer): string;
Var
  VpfLacoCampos : Integer;
begin
  result := '';
  LocalizaMovNotas(Tabela,VpaCodFilial,VpaSeqNota);
  AdicionaSQLAbreTabela(CadastroMatriz,'Select * from MOVNOTASFISCAIS ' +
                                       ' Where I_EMP_FIL = 0 AND I_SEQ_NOT = 0 AND I_SEQ_MOV = 0');
  while not Tabela.Eof do
  begin
    AtualizaProcesso('Exportando o produto "'+Tabela.FieldByName('C_COD_PRO').AsString+'" da nota "'+IntToStr(VpaSeqNota)+'"');
    CadastroMatriz.Insert;
    for VpfLacoCampos := 0 to Tabela.FieldCount - 1 do
      CadastroMatriz.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value := Tabela.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value;
    CadastroMatriz.Post;
    result := CadastroMatriz.AMensagemErroGravacao;
    if result <> '' then
    begin
      VpaDExportacao.AddErroExportacao('NOTA FISCAL ITEM',TABELA.FieldByName('I_EMP_FIL').AsString+'/'+Tabela.FieldByName('I_SEQ_NOT').AsString+'/'+Tabela.FieldByName('I_SEQ_MOV').AsString,result);
      exit;
    end;
    Tabela.Next;
  end;
  CadastroMatriz.Close;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesExportacaoDados.ExportaMovNotasFiscaisServico(VpaDExportacao: TRBDExportacaoDados; VpaCodFilial,VpaSeqNota: Integer): string;
Var
  VpfLacoCampos : Integer;
begin
  result := '';
  LocalizaMovServicoNota(Tabela,VpaCodFilial,VpaSeqNota);
  AdicionaSQLAbreTabela(CadastroMatriz,'Select * from MOVSERVICONOTA ' +
                                       ' Where I_EMP_FIL = 0 AND I_SEQ_NOT = 0 AND I_SEQ_MOV = 0');
  while not Tabela.Eof do
  begin
    AtualizaProcesso('Exportando o servico "'+Tabela.FieldByName('I_COD_SER').AsString+'" da nota "'+IntToStr(VpaSeqNota)+'"');
    CadastroMatriz.Insert;
    for VpfLacoCampos := 0 to Tabela.FieldCount - 1 do
      CadastroMatriz.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value := Tabela.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value;
    CadastroMatriz.Post;
    result := CadastroMatriz.AMensagemErroGravacao;
    if result <> '' then
    begin
      VpaDExportacao.AddErroExportacao('NOTA FISCAL SERVICO',TABELA.FieldByName('I_EMP_FIL').AsString+'/'+Tabela.FieldByName('I_SEQ_NOT').AsString+'/'+Tabela.FieldByName('I_SEQ_MOV').AsString,result);
      exit;
    end;
    Tabela.Next;
  end;
  CadastroMatriz.Close;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesExportacaoDados.ExportaMovOrcamento(VpaDExportacao: TRBDExportacaoDados; VpaCodFilial,VpaNumpedido : Integer): string;
Var
  VpfLacoCampos : Integer;
begin
  result := '';
  LocalizaMovOrcamento(Tabela,VpaCodFilial,VpaNumpedido);
  AdicionaSQLAbreTabela(CadastroMatriz,'Select * from MOVORCAMENTOS ' +
                                       ' Where I_EMP_FIL = 0 AND I_LAN_ORC = 0');
  while not Tabela.Eof do
  begin
    AtualizaProcesso('Exportando o produto "'+Tabela.FieldByName('C_COD_PRO').AsString+'" do pedido "'+IntToStr(VpaNumpedido)+'"');
    CadastroMatriz.Insert;
    for VpfLacoCampos := 0 to Tabela.FieldCount - 1 do
      CadastroMatriz.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value := Tabela.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value;
    CadastroMatriz.Post;
    result := CadastroMatriz.AMensagemErroGravacao;
    if result <> '' then
    begin
      VpaDExportacao.AddErroExportacao('PEDIDO ITEM',TABELA.FieldByName('I_EMP_FIL').AsString+'/'+Tabela.FieldByName('I_LAN_ORC').AsString+'/'+Tabela.FieldByName('I_SEQ_MOV').AsString,result);
      exit;
    end;
    Tabela.Next;
  end;
  CadastroMatriz.Close;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesExportacaoDados.ExportaMovServicoOrcamento(VpaDExportacao: TRBDExportacaoDados; VpaCodFilial,VpaNumpedido: Integer): string;
Var
  VpfLacoCampos : Integer;
begin
  result := '';
  LocalizaMovServicoOrcamento(Tabela,VpaCodFilial,VpaNumpedido);
  AdicionaSQLAbreTabela(CadastroMatriz,'Select * from MOVSERVICOORCAMENTO ' +
                                       ' Where I_EMP_FIL = 0 AND I_LAN_ORC = 0 AND I_SEQ_MOV = 0');
  while not Tabela.Eof do
  begin
    AtualizaProcesso('Exportando o serviço "'+Tabela.FieldByName('I_COD_SER').AsString+'" do pedido "'+IntToStr(VpaNumpedido)+'"');
    CadastroMatriz.Insert;
    for VpfLacoCampos := 0 to Tabela.FieldCount - 1 do
      CadastroMatriz.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value := Tabela.FieldByName(Tabela.Fields[VpfLacoCampos].DisplayName).Value;
    CadastroMatriz.Post;
    result := CadastroMatriz.AMensagemErroGravacao;
    if result <> '' then
    begin
      VpaDExportacao.AddErroExportacao('SERVICO PEDIDO',TABELA.FieldByName('I_EMP_FIL').AsString+'/'+Tabela.FieldByName('I_LAN_ORC').AsString+'/'+Tabela.FieldByName('I_SEQ_MOV').AsString,result);
      exit;
    end;
    Tabela.Next;
  end;
  CadastroMatriz.Close;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesExportacaoDados.ExportaNotaFiscal(VpaDExportacao: TRBDExportacaoDados): string;
Var
  VpfResultado : string;
  VpfLacoCampos : Integer;
  VpfTransacao : TTransactionDesc;
  VpfFunProdutosMatriz : TFuncoesProduto;
  VpfDNota : TRBDNotaFiscal;
begin
  VpfFunProdutosMatriz := TFuncoesProduto.criar(nil,FPrincipal.BaseDadosMatriz);
  result := '';
  VpfResultado := '';
  LocalizaNotasNaoExportadas(Pedido);
  VprBarraProgresso.Position := 0;
  VprBarraProgresso.Max := Pedido.RecordCount;
  AdicionaSQLAbreTabela(PedidoMatriz,'Select * from CADNOTAFISCAIS ' +
                                       ' Where I_EMP_FIL = 0 AND I_SEQ_NOT = 0');
  while not Pedido.Eof do
  begin
    VpfTransacao.IsolationLevel :=xilDIRTYREAD;
    FPrincipal.BaseDadosMatriz.StartTransaction(vpfTransacao);
    VpfDNota := TRBDNotaFiscal.cria;
    FunNotaFiscal.CarDNotaFiscal(VpfDNota,Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_SEQ_NOT').AsInteger);
    AtualizaProcesso('Verificando se o numero da nota existe digitado na Matriz');
    VpfResultado := ExisteNotaMatriz (Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_SEQ_NOT').AsInteger);
    if VpfResultado = '' then
    begin
      if VpaDExportacao.ClientesNaoExportados.IndexOf(Pedido.FieldByName('I_COD_CLI').AsString) >=0 then
        VpfResultado := 'Cliente referente a essa nota nao exportado';
    end;
    if VpfResultado = '' then
    begin
      AtualizaProcesso('Exportando dados do corpo da nota '+IntToStr(Pedido.FieldByName('I_NRO_NOT').AsInteger));
      PedidoMatriz.Insert;
      for VpfLacoCampos := 0 to Pedido.FieldCount - 1 do
        PedidoMatriz.FieldByName(Pedido.Fields[VpfLacoCampos].DisplayName).Value := Pedido.FieldByName(Pedido.Fields[VpfLacoCampos].DisplayName).Value;

      PedidoMatriz.FieldByName('C_FLA_EXP').AsString := 'S';
      PedidoMatriz.FieldByName('D_ULT_ALT').AsDateTime := VpaDExportacao.DatExportacao;
      PedidoMatriz.FieldByName('D_DAT_EXP').AsDateTime := VpaDExportacao.DatExportacao;

      PedidoMatriz.Post;
      VpfResultado := PedidoMatriz.AMensagemErroGravacao;
    end;

    if VpfResultado <> '' then
    begin
      VpaDExportacao.AddErroExportacao('NOTA FISCAL CORPO',Pedido.FieldByName('I_EMP_FIL').AsString+'/'+Pedido.FieldByName('I_SEQ_NOT').AsString,VpfResultado);
    end
    else
    begin
      VpfResultado := ExportaMovNotasFiscais(VpaDExportacao,Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_SEQ_NOT').AsInteger);
      if VpfResultado = '' then
      begin
        VpfResultado := ExportaMovNotasFiscaisServico(VpaDExportacao,Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_SEQ_NOT').AsInteger);
        if VpfResultado = '' then
        begin
          if (config.BaixarEstoqueECF) and (Pedido.FieldByName('C_NOT_CAN').AsString = 'N') then
          begin
            AtualizaProcesso('Atualizando estoque da nota '+Pedido.FieldByName('I_NRO_NOT').AsString);
            VpfResultado := FunNotaFiscal.BaixaEstoqueNota(VpfDNota,nil,VpfFunProdutosMatriz);
          end;
        end;
      end;
    end;

    if VpfResultado = '' then
    begin
      FPrincipal.BaseDadosMatriz.Commit(VpfTransacao);
      Pedido.Edit;
      Pedido.FieldByName('C_FLA_EXP').AsString := 'S';
      Pedido.Post;
      VpaDExportacao.NotasExportadas.Add(Pedido.FieldByName('I_EMP_FIL').AsString+'/'+Pedido.FieldByName('I_NRO_NOT').AsString);
    end
    else
      FPrincipal.BaseDadosMatriz.Rollback(VpfTransacao);

    VprBarraProgresso.Position := VprBarraProgresso.Position + 1;
    VpfDNota.Free;
    Pedido.Next;
  end;
  VpfFunProdutosMatriz.Free;
end;

{********************************************************************************}
function TRBFuncoesExportacaoDados.ExportaPedido(VpaDExportacao: TRBDExportacaoDados): string;
Var
  VpfResultado : string;
  VpfLacoCampos : Integer;
  VpfTransacao : TTransactionDesc;
  VpfFunProdutosMatriz : TFuncoesProduto;
  VpfDCotacao : TRBDOrcamento;
begin
  VpfFunProdutosMatriz := TFuncoesProduto.criar(nil,FPrincipal.BaseDadosMatriz);
  result := '';
  VpfResultado := '';
  LocalizaPedidosNaoExportados(Pedido);
  VprBarraProgresso.Position := 0;
  VprBarraProgresso.Max := Pedido.RecordCount;
  AdicionaSQLAbreTabela(PedidoMatriz,'Select * from CADORCAMENTOS ' +
                                       ' Where I_EMP_FIL = 0 AND I_LAN_ORC = 0');
  while not Pedido.Eof do
  begin
    VpfDCotacao := TRBDOrcamento.cria;
    FunCotacao.CarDOrcamento(VpfDCotacao,Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_LAN_ORC').AsInteger);
    VpfTransacao.IsolationLevel :=xilDIRTYREAD;
    FPrincipal.BaseDadosMatriz.StartTransaction(vpfTransacao);
    AtualizaProcesso('Verificando se o numero do pedido existe digitado na Matriz');
    VpfResultado := ExistePedidoMatriz (Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_LAN_ORC').AsInteger);
    if VpfResultado = '' then
    begin
      if VpaDExportacao.ClientesNaoExportados.IndexOf(Pedido.FieldByName('I_COD_CLI').AsString) >=0 then
        VpfResultado := 'Cliente referente ao pedido nao exportado';
    end;
    if VpfResultado = '' then
    begin
      AtualizaProcesso('Exportando dados do corpo do pedido '+IntToStr(VpfDCotacao.LanOrcamento));
      PedidoMatriz.Insert;
      for VpfLacoCampos := 0 to Pedido.FieldCount - 1 do
        PedidoMatriz.FieldByName(Pedido.Fields[VpfLacoCampos].DisplayName).Value := Pedido.FieldByName(Pedido.Fields[VpfLacoCampos].DisplayName).Value;

      PedidoMatriz.FieldByName('C_FLA_EXP').AsString := 'S';
      PedidoMatriz.FieldByName('C_IND_IMP').AsString := 'N';
      PedidoMatriz.FieldByName('D_ULT_ALT').AsDateTime := VpaDExportacao.DatExportacao;
      PedidoMatriz.FieldByName('D_DAT_EXP').AsDateTime := VpaDExportacao.DatExportacao;

      PedidoMatriz.Post;
      VpfResultado := PedidoMatriz.AMensagemErroGravacao;
    end;

    if VpfResultado <> '' then
    begin
      VpaDExportacao.AddErroExportacao('PEDIDO CORPO',Pedido.FieldByName('I_EMP_FIL').AsString+'/'+Pedido.FieldByName('I_LAN_ORC').AsString,VpfResultado);
    end
    else
    begin
      VpfResultado := ExportaMovOrcamento(VpaDExportacao,Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_LAN_ORC').AsInteger);
      if VpfResultado = '' then
      begin
        VpfResultado := ExportaMovServicoOrcamento(VpaDExportacao,Pedido.FieldByName('I_EMP_FIL').AsInteger,Pedido.FieldByName('I_LAN_ORC').AsInteger);
        if VpfResultado = '' then
        begin
{          if config.BaixarEstoqueCotacao then
          begin
            AtualizaProcesso('Atualizando estoque do pedido '+IntToStr(VpfDCotacao.LanOrcamento));
            VpfResultado := FunCotacao.GeraEstoqueProdutos(VpfDCotacao,VpfFunProdutosMatriz);
          end;}
        end;
      end;
    end;

    if VpfResultado = '' then
    begin
      FPrincipal.BaseDadosMatriz.Commit(VpfTransacao);
      Pedido.Edit;
      Pedido.FieldByName('C_FLA_EXP').AsString := 'S';
      Pedido.Post;
      VpaDExportacao.PedidosExportados.Add(Pedido.FieldByName('I_EMP_FIL').AsString+'/'+Pedido.FieldByName('I_LAN_ORC').AsString);
    end
    else
      FPrincipal.BaseDadosMatriz.Rollback(VpfTransacao);

    VprBarraProgresso.Position := VprBarraProgresso.Position + 1;
    VpfDCotacao.Free;
    Pedido.Next;
  end;
  VpfFunProdutosMatriz.Free;
end;

{********************************************************************************}
procedure TRBFuncoesExportacaoDados.LocalizaClientesnaoExportados(VpaTabela: TSQL);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from CADCLIENTES ' +
                                  ' Where C_FLA_EXP = ''N''');
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoDados.LocalizaContasaReceberNaoExportado(VpaTabela: TSQL);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from CADCONTASARECEBER ' +
                                  ' Where C_FLA_EXP = ''N'''+
                                  ' ORDER BY I_EMP_FIL, I_LAN_REC');
end;

{********************************************************************************}
procedure TRBFuncoesExportacaoDados.LocalizaMovComissoesNaoExportado(VpaTabela: TSQL);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVCOMISSOES ' +
                                  ' Where C_FLA_EXP = ''N''' +
                                  ' ORDER BY I_EMP_FIL, I_LAN_CON');
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoDados.LocalizaMovContasAReceber(VpaTabela: TSQL; VpaCodFilial, VpaLanReceber : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVCONTASARECEBER ' +
                                  ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial)+
                                  ' and I_LAN_REC  = ' + IntToStr(VpaLanReceber)+
                                  ' order by I_NRO_PAR ');
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoDados.LocalizaMovNotas(VpaTabela: TSQL; VpaCodFilial, VpaSeqNota: Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVNOTASFISCAIS ' +
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND I_SEQ_NOT = '+IntToStr(VpaSeqNota)+
                                  ' ORDER BY I_SEQ_MOV');
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoDados.LocalizaMovOrcamento(VpaTabela: TSQl; VpaCodFilial, VpaLanOrcamento: Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVORCAMENTOS '+
                                  ' WHERE I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                  ' ORDER BY I_SEQ_MOV' );
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoDados.LocalizaMovServicoNota(VpaTabela: TSQL; VpaCodFilial, VpaSeqNota: Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVSERVICONOTA ' +
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND I_SEQ_NOT = '+IntToStr(VpaSeqNota)+
                                  ' ORDER BY I_SEQ_MOV');
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoDados.LocalizaMovServicoOrcamento(VpaTabela: TSQl; VpaCodFilial,VpaLanOrcamento: Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVSERVICOORCAMENTO '+
                                  ' WHERE I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                  ' ORDER BY I_SEQ_MOV' );
end;

{******************************************************************************}
procedure TRBFuncoesExportacaoDados.LocalizaNotasNaoExportadas(VpaTabela: TSQL);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from CADNOTAFISCAIS ' +
                                  ' Where C_FLA_EXP = ''N''' +
                                  ' ORDER BY I_NRO_NOT ');
end;

{********************************************************************************}
procedure TRBFuncoesExportacaoDados.LocalizaPedidosNaoExportados(VpaTabela: TSQL);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from CADORCAMENTOS ' +
                                  ' Where C_FLA_EXP = ''N'''+
                                  ' ORDER BY I_LAN_ORC ');
end;

end.

