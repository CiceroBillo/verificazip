Unit UnInventario;
{Verificado
-.edit;
-.post;
}
Interface

Uses Classes, Tabela, SQlExpr, UnProdutos, SysUtils, UnDadosProduto;

//classe localiza
Type TRBLocalizaInventario = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesInventario = class(TRBLocalizaInventario)
  private
    Inventario,
    InvAux : TSQLQuery;
    InvAza,
    InvCadastro : TSQL;
    function RSeqInventarioDisponivel : Integer;
    function RSeqItemInventarioDisponivel(VpaCodFilial, VpaSeqInventario : String) : Integer;
    procedure CarDItemInventario(VpaDInventario : TRBDInventarioCorpo);
    procedure AtualizaDataFechamento(VpaCodFilial, VpaSeqInventario : String);
    procedure ZeraProdutoForaInventario(VpaDInventario : TRBDInventarioCorpo);
    procedure ZeraProdutoReservados(VpaDInventario : TRBDInventarioCorpo);
    procedure ZeraProdutoAReservar(VpaDInventario : TRBDInventarioCorpo);
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    function ExisteInventarioAberto(VpaCodFilial : Integer) : Boolean;
    function GravaDInventario(VpaDInventario : TRBDInventarioCorpo):String ;
    function ExisteProduto(VpaCodProduto : String;VpaDItemInventario : TRBDInventarioItem):Boolean;
    function FechaInventario(VpaDInventario : TRBDInventarioCorpo):String;
    procedure AcertaInventario(FunProdutos : TFuncoesProduto);
    function AdicinaProdutoInventario(VpaDInventario : TRBDInventarioCorpo) :String;
    procedure CarDInventario(VpaDInventario : TRBDInventarioCorpo;VpaCodFilial,VpaSeqInventario : Integer);
    procedure DeletaItensInventario(VpaCodFilial, VpaSeqInventario : String);
    procedure DeletaInventario(VpaCodFilial,VpaSeqInventario : Integer);
end;



implementation

Uses FunSql,Constantes, FunString, FunData, ConstMsg, FunObjeto;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaInventario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaInventario.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesInventario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesInventario.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  InvAux := TSQLQuery.create(nil);
  InvAux.SQLConnection := VpaBaseDados;
  InvCadastro := TSQL.create(nil);
  invcadastro.ASQlConnection := VpaBaseDados;
  InvAza := TSQL.create(nil);
  InvAza.ASQLConnection := VpaBaseDados;
  Inventario := TSQLQuery.create(nil);;
  Inventario.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesInventario.destroy;
begin
  InvAux.free;
  invcadastro.free;
  Inventario.free;
  InvAza.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesInventario.RSeqInventarioDisponivel : Integer;
var
  VpfCodFilial : Integer;
begin
  if config.EstoqueCentralizado then
    VpfCodFilial := Varia.CodFilialControladoraEstoque
  else
    vpfCodfilial := varia.CodigoEmpFil;
  AdicionaSQLAbreTabela(InvAux,'Select MAX(SEQ_INVENTARIO) ULTIMO from INVENTARIOCORPO '+
                               ' Where COD_FILIAL = '+ IntTostr(VpfCodFilial));
  result := InvAux.FieldByName('ULTIMO').AsInteger + 1;
  InvAux.Close;
end;

{******************************************************************************}
function TRBFuncoesInventario.RSeqItemInventarioDisponivel(VpaCodFilial, VpaSeqInventario : String) : Integer;
begin
  AdicionaSQLAbreTabela(InvAux,'Select MAX(SEQ_ITEM) ULTIMO from INVENTARIOITEM '+
                               ' Where COD_FILIAL = '+ VpaCodFilial+
                               ' AND SEQ_INVENTARIO = '+ VpaSeqInventario);
  result := InvAux.FieldByName('ULTIMO').AsInteger + 1;
  InvAux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesInventario.CarDItemInventario(VpaDInventario : TRBDInventarioCorpo);
var
  VpfDItemInventario : TRBDInventarioItem;
begin
  FreeTObjectsList(VpaDInventario.ItemsInventario);
  AdicionaSQLAbreTabela(InvAux,'Select ITE.SEQ_PRODUTO, ITE.COD_COR, ITE.COD_USUARIO, '+
                               ' ITE.COD_PRODUTO, ITE.COD_UNIDADE, PRO.C_NOM_PRO, ' +
                               ' ITE.QTD_PRODUTO, ITE.COD_TAMANHO, '+
                               ' PRO.C_COD_UNI, USU.C_NOM_USU '+
                               ' from INVENTARIOITEM ITE, CADPRODUTOS PRO, CADUSUARIOS USU'+
                               ' Where ITE.COD_FILIAL = '+ IntToStr(VpaDInventario.CodFilial) +
                               ' and ITE.SEQ_INVENTARIO = '+ IntToStr(VpaDInventario.SeqInventario)+
                               ' AND ITE.SEQ_PRODUTO = PRO.I_SEQ_PRO ' +
                               ' AND ITE.COD_USUARIO = USU.I_COD_USU '+
                               ' order by PRO.C_NOM_PRO');
  While not InvAux.Eof do
  begin
    VpfDItemInventario := VpaDInventario.AddInventarioItem;
    VpfDItemInventario.SeqProduto := InvAux.FieldByName('SEQ_PRODUTO').AsInteger;
    VpfDItemInventario.CodCor := InvAux.FieldByName('COD_COR').AsInteger;
    VpfDItemInventario.CodTamanho := InvAux.FieldByName('COD_TAMANHO').AsInteger;
    VpfDItemInventario.NomTamanho := FunProdutos.RNomeTamanho(InvAux.FieldByName('COD_TAMANHO').AsInteger);
    VpfDItemInventario.CodUsuario := InvAux.FieldByName('COD_USUARIO').AsInteger;
    VpfDItemInventario.CodProduto := InvAux.FieldByName('COD_PRODUTO').AsString;
    VpfDItemInventario.NomProduto := InvAux.FieldByName('C_NOM_PRO').AsString;
    VpfDItemInventario.NomCor := FunProdutos.RNomeCor(InvAux.FieldByName('COD_COR').AsString);
    VpfDItemInventario.UM := InvAux.FieldByName('COD_UNIDADE').AsString;
    VpfDItemInventario.UMOriginal := InvAux.FieldByName('C_COD_UNI').AsString;
    VpfDItemInventario.UnidadesParentes := FunProdutos.RUnidadesParentes(VpfDItemInventario.UMOriginal);
    VpfDItemInventario.NomUsuario := InvAux.FieldByName('C_NOM_USU').AsString;
    VpfDItemInventario.QtdProduto := InvAux.FieldByName('QTD_PRODUTO').AsFloat;
    InvAux.Next;
  end;
  InvAux.close;
end;

{******************************************************************************}
procedure TRBFuncoesInventario.AtualizaDataFechamento(VpaCodFilial, VpaSeqInventario : String);
begin
  AdicionaSQLAbreTabela(InvCadastro,'Select * from INVENTARIOCORPO '+
                                    ' Where COD_FILIAL = '+ VpaCodFilial+
                                    ' and SEQ_INVENTARIO = '+ VpaSeqInventario);
  InvCadastro.Edit;
  InvCadastro.FieldByName('DAT_FIM').AsDateTime := NOW;
  InvCadastro.Post;
end;

{******************************************************************************}
procedure TRBFuncoesInventario.ZeraProdutoAReservar(VpaDInventario: TRBDInventarioCorpo);
var
  VpfDProduto : TRBDProduto;
begin
  InvAza.Close;
  InvAza.Sql.Clear;
  InvAza.Sql.add('SELECT MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.I_COD_TAM, MOV.N_QTD_ARE, '+
                               ' MOV.N_VLR_CUS, '+
                               ' PRO.C_COD_UNI, PRO.I_COD_MOE ' +
                               '  FROM MOVQDADEPRODUTO MOV, CADPRODUTOS PRO, CADCLASSIFICACAO CLA '+
                               ' WHERE MOV.N_QTD_ARE <> 0 '+
                               ' AND MOV.I_EMP_FIL = '+ IntToStr(VpaDInventario.CodFilial)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO' +
                               ' AND CLA.C_COD_CLA = PRO.C_COD_CLA ');
  if VpaDInventario.CodClassificacao <> '' then
    InvAza.sql.add('and CLA.C_COD_CLA like '''+VpaDInventario.CodClassificacao+'%''');
  InvAza.Sql.add(' order by mov.i_seq_pro');
  InvAza.open;
  While not InvAza.Eof do
  begin
    VpfDProduto := TRBDProduto.Cria;
    FunProdutos.CarDProduto(VpfDProduto,0,varia.CodigoEmpFil,InvAza.FieldByName('I_SEQ_PRO').AsInteger);
      if InvAza.FieldByName('N_QTD_ARE').AsFloat < 0  then
      FunProdutos.BaixaQtdAReservarProduto(varia.CodigoEmpFil,VpfDProduto.SeqProduto,InvAza.FieldByName('I_COD_COR').AsInteger,
                                        InvAza.FieldByName('I_COD_TAM').AsInteger,InvAza.FieldByName('N_QTD_ARE').AsFloat*-1,
                                        InvAza.FieldByName('C_COD_UNI').AsString,InvAza.FieldByName('C_COD_UNI').AsString,
                                        'E')
    else
      FunProdutos.BaixaQtdAReservarProduto(varia.CodigoEmpFil,VpfDProduto.SeqProduto,InvAza.FieldByName('I_COD_COR').AsInteger,
                                        InvAza.FieldByName('I_COD_TAM').AsInteger,InvAza.FieldByName('N_QTD_ARE').AsFloat,
                                        InvAza.FieldByName('C_COD_UNI').AsString,InvAza.FieldByName('C_COD_UNI').AsString,
                                        'S');
    VpfDProduto.free;
    InvAza.Next;
  end;
  InvAza.Close;
end;

{******************************************************************************}
procedure TRBFuncoesInventario.ZeraProdutoForaInventario(VpaDInventario : TRBDInventarioCorpo);
var
  VpfSeqEstoqueBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  InvAza.Close;
  InvAza.Sql.Clear;
  InvAza.Sql.add('SELECT MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.I_COD_TAM, MOV.N_QTD_PRO, '+
                               ' MOV.N_VLR_CUS, '+
                               ' PRO.C_COD_UNI, PRO.I_COD_MOE ' +
                               '  FROM MOVQDADEPRODUTO MOV, CADPRODUTOS PRO, CADCLASSIFICACAO CLA '+
                               ' WHERE MOV.N_QTD_PRO <> 0 '+
                               ' AND NOT EXISTS(SELECT * FROM INVENTARIOITEM ITE ' +
                               ' WHERE ITE.COD_FILIAL= MOV.I_EMP_FIL ' +
                               ' AND ITE.SEQ_PRODUTO = MOV.I_SEQ_PRO ' +
                               ' AND ITE.COD_COR = MOV.I_COD_COR '+
                               ' AND ITE.COD_TAMANHO = MOV.I_COD_TAM '+
                               ' AND ITE.COD_FILIAL = '+ IntToStr(VpaDInventario.CodFilial) +
                               ' AND ITE.SEQ_INVENTARIO = '+ IntToStr(VpaDInventario.SeqInventario)+')'+
                               ' AND MOV.I_EMP_FIL = '+ IntToStr(VpaDInventario.CodFilial)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO' +
                               ' AND CLA.C_COD_CLA = PRO.C_COD_CLA ');
//                               ' and MOV.I_SEQ_PRO >= 1103' +
  if VpaDInventario.CodClassificacao <> '' then
    InvAza.sql.add('and CLA.C_COD_CLA like '''+VpaDInventario.CodClassificacao+'%''');
  InvAza.Sql.add(' order by mov.i_seq_pro');
  InvAza.open;
  While not InvAza.Eof do
  begin
    VpfDProduto := TRBDProduto.Cria;
    FunProdutos.CarDProduto(VpfDProduto,0,varia.CodigoEmpFil,InvAza.FieldByName('I_SEQ_PRO').AsInteger);
      if InvAza.FieldByName('N_QTD_PRO').AsFloat < 0  then
      FunProdutos.BaixaProdutoEstoque(VpfDProduto, varia.CodigoEmpFil,
                                      VARIA.InventarioEntrada,0,0,0,InvAza.FieldByName('I_COD_MOE').AsInteger,
                                      InvAza.FieldByName('I_COD_COR').AsInteger,InvAza.FieldByName('I_COD_TAM').AsInteger,Date,InvAza.FieldByName('N_QTD_PRO').AsFloat *-1,
                                      (InvAza.FieldByName('N_QTD_PRO').AsFloat * -1)*InvAza.FieldByName('N_VLR_CUS').AsFLOAT,
                                      InvAza.FieldByName('C_COD_UNI').AsString,'',false,VpfSeqEstoqueBarra)
    else
      FunProdutos.BaixaProdutoEstoque(VpfDProduto, varia.CodigoEmpFil,
                                      VARIA.InventarioSaida,0,0,0,InvAza.FieldByName('I_COD_MOE').AsInteger,
                                        InvAza.FieldByName('I_COD_COR').AsInteger,InvAza.FieldByName('I_COD_TAM').AsInteger,Date,InvAza.FieldByName('N_QTD_PRO').AsFloat,
                                        InvAza.FieldByName('N_QTD_PRO').AsFloat*InvAza.FieldByName('N_VLR_CUS').AsFLOAT,
                                        InvAza.FieldByName('C_COD_UNI').AsString,'',false,VpfSeqEstoqueBarra);
    VpfDProduto.free;
    InvAza.Next;
  end;
  InvAza.Close;
end;

{******************************************************************************}
procedure TRBFuncoesInventario.ZeraProdutoReservados(VpaDInventario: TRBDInventarioCorpo);
var
  VpfDProduto : TRBDProduto;
begin
  InvAza.Close;
  InvAza.Sql.Clear;
  InvAza.Sql.add('SELECT MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.I_COD_TAM, MOV.N_QTD_RES, '+
                               ' MOV.N_VLR_CUS, '+
                               ' PRO.C_COD_UNI, PRO.I_COD_MOE ' +
                               '  FROM MOVQDADEPRODUTO MOV, CADPRODUTOS PRO, CADCLASSIFICACAO CLA '+
                               ' WHERE MOV.N_QTD_RES <> 0 '+
                               ' AND MOV.I_EMP_FIL = '+ IntToStr(VpaDInventario.CodFilial)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO' +
                               ' AND CLA.C_COD_CLA = PRO.C_COD_CLA ');
//                               ' and MOV.I_SEQ_PRO >= 1103' +
  if VpaDInventario.CodClassificacao <> '' then
    InvAza.sql.add('and CLA.C_COD_CLA like '''+VpaDInventario.CodClassificacao+'%''');
  InvAza.Sql.add(' order by mov.i_seq_pro');
  InvAza.open;
  While not InvAza.Eof do
  begin
    VpfDProduto := TRBDProduto.Cria;
    FunProdutos.CarDProduto(VpfDProduto,0,varia.CodigoEmpFil,InvAza.FieldByName('I_SEQ_PRO').AsInteger);
      if InvAza.FieldByName('N_QTD_RES').AsFloat < 0  then
      FunProdutos.ReservaEstoqueProduto(varia.CodigoEmpFil,VpfDProduto.SeqProduto,InvAza.FieldByName('I_COD_COR').AsInteger,
                                        InvAza.FieldByName('I_COD_TAM').AsInteger,0, InvAza.FieldByName('N_QTD_RES').AsFloat*-1,
                                        InvAza.FieldByName('C_COD_UNI').AsString,InvAza.FieldByName('C_COD_UNI').AsString,
                                        'E')
    else
      FunProdutos.ReservaEstoqueProduto(varia.CodigoEmpFil,VpfDProduto.SeqProduto,InvAza.FieldByName('I_COD_COR').AsInteger,
                                        InvAza.FieldByName('I_COD_TAM').AsInteger,0, InvAza.FieldByName('N_QTD_RES').AsFloat,
                                        InvAza.FieldByName('C_COD_UNI').AsString,InvAza.FieldByName('C_COD_UNI').AsString,
                                        'S');
    VpfDProduto.free;
    InvAza.Next;
  end;
  InvAza.Close;
end;

{******************************************************************************}
function TRBFuncoesInventario.ExisteInventarioAberto(VpaCodFilial : Integer) : Boolean;
begin
  AdicionaSQLAbreTabela(InvAux,'Select * from INVENTARIOCORPO '+
                               ' Where COD_FILIAL = '+ IntToStr(VpaCodfilial)+
                               ' and DAT_FIM IS NULL');
  result := not InvAux.Eof;
  InvAux.Close;
end;

{******************************************************************************}
function TRBFuncoesInventario.GravaDInventario(VpaDInventario : TRBDInventarioCorpo):String;
begin
  result := '';
  if config.EstoqueCentralizado then
    VpaDInventario.CodFilial := varia.CodFilialControladoraEstoque;

  if ExisteInventarioAberto(VpaDInventario.CodFilial) then
    Result := 'NÃO FOI POSSIVEL CADASTRAR UM NOVO INVENTÁRIO!!!'#13'Para cadastrar um novo inventário é necessário que todos os anteriores estejam finalizados.';

  if result = '' then
  begin
    AdicionaSQLAbreTabela(InvCadastro,'Select * from INVENTARIOCORPO '+
                                      ' Where COD_FILIAL = '+IntToStr(VpaDInventario.CodFilial)+
                                      ' and SEQ_INVENTARIO = '+IntToStr(VpaDInventario.SeqInventario));
    if VpaDInventario.SeqInventario = 0 then
      InvCadastro.Insert
    else
      InvCadastro.Edit;

    InvCadastro.FieldByName('COD_FILIAL').AsInteger :=  VpaDInventario.CodFilial;
    InvCadastro.FieldByName('COD_USUARIO').AsInteger :=  VpaDInventario.CodUsuario;
    InvCadastro.FieldByName('DAT_INICIO').AsDateTime := now;
    if VpaDInventario.CodClassificacao <> '' then
      InvCadastro.FieldByName('CODCLASSIFICACAO').AsString := VpaDInventario.CodClassificacao;
    if VpaDInventario.SeqInventario = 0 then
      VpaDInventario.SeqInventario := RSeqInventarioDisponivel;
    InvCadastro.FieldByName('SEQ_INVENTARIO').AsInteger := VpaDInventario.SeqInventario;
    InvCadastro.post;
    result := InvCadastro.AMensagemErroGravacao;
  end;
  InvCadastro.Close;
end;


{******************************************************************************}
function TRBFuncoesInventario.ExisteProduto(VpaCodProduto : String;VpaDItemInventario : TRBDInventarioItem):Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(InvAux,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, Pro.C_Kit_Pro, PRO.C_FLA_PRO,PRO.C_NOM_PRO, '+
                                  ' PRO.C_CLA_FIS ' +
                                  ' from CADPRODUTOS PRO, MOVQDADEPRODUTO Qtd ' +
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and Qtd.I_Emp_Fil =  ' + IntTostr(Varia.CodigoEmpFil)+
                                  ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                                  ' and Pro.c_ven_avu = ''S''');

    result := not InvAux.Eof;
    if result then
    begin
      with VpaDItemInventario do
      begin
        UMOriginal := InvAux.FieldByName('C_Cod_Uni').Asstring;
        UM := InvAux.FieldByName('C_Cod_Uni').Asstring;
        CodProduto := InvAux.FieldByName(Varia.CodigoProduto).Asstring;
        QtdProduto := 1;
        SeqProduto := InvAux.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := InvAux.FieldByName('C_NOM_PRO').AsString;
      end;
    end;
  end;
end;


{******************************************************************************}
function TRBFuncoesInventario.FechaInventario(VpaDInventario : TRBDInventarioCorpo):String;
var
  VpfProdutoAtual, VpfCorAtual, VpfTamanhoAtual, VpfSeqEstoqueBarra : Integer;
  VpfQtdProduto, VpfQtdMovimento : Double;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  if varia.InventarioEntrada = 0 then
    result := 'OPERAÇÃO DE ESTOQUE PARA ENTRADA DO INVENTÁRIO NÃO CADASTRADA!!!'#13'É necessário nas configurações dos produtos informar qual será a operação de estoque para entrada do inventário.'
  else
    if varia.InventarioSaida = 0 then
    result := 'OPERAÇÃO DE ESTOQUE PARA SAIDA DO INVENTÁRIO NÃO CADASTRADA!!!'#13'É necessário nas configurações dos produtos informar qual será a operação de estoque para saida do inventário.';
  if result = '' then
  begin
    AdicionaSQLAbreTabela(InvAza,'select ITE.SEQ_PRODUTO, ITE.COD_COR, ITE.COD_TAMANHO, ITE.COD_UNIDADE, ITE.QTD_PRODUTO, '+
                                 ' PRO.I_COD_MOE,  PRO.C_COD_UNI, '+
                                 ' MOV.N_QTD_PRO, MOV.N_VLR_CUS '+
                                 ' from INVENTARIOITEM ITE, CADPRODUTOS PRO, MOVQDADEPRODUTO MOV '+
                                 ' Where ITE.SEQ_PRODUTO = PRO.I_SEQ_PRO '+
                                 ' AND '+SQLTextoRightJoin('ITE.COD_FILIAL','MOV.I_EMP_FIL')+
                                 ' AND '+SQLTextoRightJoin('ITE.SEQ_PRODUTO','MOV.I_SEQ_PRO')+
                                 ' AND '+SQLTextoRightJoin('ITE.COD_COR','MOV.I_COD_COR')+
                                 ' and '+SQLTextoRightJoin('ITE.COD_TAMANHO','MOV.I_COD_TAM')+
                                 ' and ITE.COD_FILIAL = '+IntToStr(VpaDInventario.CodFilial)+
                                 ' and ITE.SEQ_INVENTARIO = '+IntToStr(VpaDInventario.SeqInventario)+
                                 ' ORDER BY ITE.SEQ_PRODUTO, ITE.COD_COR, ITE.COD_TAMANHO');
    VpfProdutoAtual := InvAza.FieldByName('SEQ_PRODUTO').AsInteger;
    VpfCorAtual := InvAza.FieldByName('COD_COR').AsInteger;
    VpfTamanhoAtual := InvAza.FieldByName('COD_TAMANHO').AsInteger;
    VpfQtdProduto := 0;

    While not InvAza.eof do
    begin
      VpfQtdProduto := VpfQtdProduto + FunProdutos.CalculaQdadePadrao(InvAza.FieldByName('COD_UNIDADE').AsString,InvAza.FieldByName('C_COD_UNI').AsString,InvAza.FieldByName('QTD_PRODUTO').AsFloat,InvAza.FieldByName('SEQ_PRODUTO').AsString);
      InvAza.next;
      if (VpfProdutoAtual <> InvAza.FieldByName('SEQ_PRODUTO').AsInteger) or
         (VpfCorAtual <> InvAza.FieldByName('COD_COR').AsInteger) or
         (VpfTamanhoAtual <> InvAza.FieldByName('COD_TAMANHO').AsInteger)or
         InvAza.Eof then
      begin
        VpfProdutoAtual := InvAza.FieldByName('SEQ_PRODUTO').AsInteger;
        VpfCorAtual := InvAza.FieldByName('COD_COR').AsInteger;
        VpfTamanhoAtual := InvAza.FieldByName('COD_TAMANHO').AsInteger;
        if not InvAza.Eof then
          InvAza.Prior;
        if VpfQtdProduto <> InvAza.FieldByName('N_QTD_PRO').AsFloat then
        begin
          VpfDProduto := TRBDProduto.Cria;
          FunProdutos.CarDProduto(VpfDProduto,0,VpaDInventario.CodFilial, InvAza.FieldByName('SEQ_PRODUTO').AsInteger);
          if VpfQtdProduto > InvAza.FieldByName('N_QTD_PRO').AsFloat then
            FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDInventario.CodFilial, VARIA.InventarioEntrada,0,0,0,InvAza.FieldByName('I_COD_MOE').AsInteger,
                                            InvAza.FieldByName('COD_COR').AsInteger,InvAza.FieldByName('COD_TAMANHO').AsInteger,Date,VpfQtdProduto  - InvAza.FieldByName('N_QTD_PRO').AsFloat,
                                            (VpfQtdProduto  - InvAza.FieldByName('N_QTD_PRO').AsFloat)*InvAza.FieldByName('N_VLR_CUS').AsFLOAT,
                                            InvAza.FieldByName('C_COD_UNI').AsString,'',false,VpfSeqEstoqueBarra)
          else
            FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDInventario.CodFilial, VARIA.InventarioSaida,0,0,0,InvAza.FieldByName('I_COD_MOE').AsInteger,
                                              InvAza.FieldByName('COD_COR').AsInteger, InvAza.FieldByName('COD_TAMANHO').AsInteger,Date,InvAza.FieldByName('N_QTD_PRO').AsFloat - VpfQtdProduto,
                                              (InvAza.FieldByName('N_QTD_PRO').AsFloat - VpfQtdProduto)*InvAza.FieldByName('N_VLR_CUS').AsFLOAT,
                                              InvAza.FieldByName('C_COD_UNI').AsString,'',false,VpfSeqEstoqueBarra);
          VpfDProduto.free;
        end;
        VpfQtdProduto := 0;
      end
      else
        InvAza.prior;

      InvAza.Next;
    end;
    ZeraProdutoForaInventario(VpaDINventario);
    ZeraProdutoReservados(VpaDInventario);
    ZeraProdutoAReservar(VpaDInventario);
    AtualizaDataFechamento(IntToStr(VpaDInventario.CodFilial),IntToStr(VpaDInventario.SeqInventario));
  end;
end;

//{Essa rotina foi feita para quebrar o galho do Bilibio
{******************************************************************************}
procedure TRBFuncoesInventario.AcertaInventario(FunProdutos : TFuncoesProduto);
var
  VpfSequencial : Integer;
begin
  AdicionaSQLAbreTabela(InvAza,'SELECT * From movsumarizaestoque mov, cadprodutos pro'+
                               ' Where i_emp_fil ='+ IntToStr(varia.CodigoEmpFil)+
                               ' and i_mes_fec = 12 '+
                               ' and i_ano_fec = 2003'+
                               ' and pro.i_seq_pro = mov.i_seq_pro');

  vpfsequencial := 1;
  while not InvAza.eof do
  begin
    if InvAza.FieldByName('N_QTD_PRO').AsInteger <> 0 then
    begin
      AdicionaSQLAbreTabela(invAux,'select * from inventario mov ' +
                              ' where i_seq_pro = ' + InvAza.FieldByName('I_SEQ_PRO').AsString+
                              ' AND i_emp_fil = '+ IntToStr(varia.CodigoEmpFil)+
                              ' and d_dat_inv >= ''2003/12/15''');
      if  invAux.eof then
      begin
        ExecutaComandoSql(InvCadastro,'INSERT INTO INVENTARIO(I_EMP_FIL,I_COD_INV,I_NUM_SEQ,I_SEQ_PRO,C_COD_PRO,I_QTD_ANT,I_QTD_INV,N_CUS_PRO,C_COD_UNI,D_DAT_INV)'+
                                      ' VALUES ('+InttoStr(Varia.CodigoEmpFil)+',48,'+IntTostr(vpfSequencial)+
                                      ','+InvAza.FieldByName('I_SEQ_PRO').AsString+ ','''+
                                      InvAza.FieldByName('C_BAR_FOR').AsString+''','+
                                      InvAza.FieldByName('N_QTD_PRO').ASSTRING + ',0,'+
                                      SubstituiStr(FloatToStr(InvAza.FieldByName('N_VLR_CMV').ASFLOAT),',','.')+
                                      ',''PC'','''+DataToStrFormato(AAAAMMDD,Date,'/')+''')');

        inc(Vpfsequencial);
      end;
    end;
    InvAza.next;
  end;
end;

{******************************************************************************}
function TRBFuncoesInventario.AdicinaProdutoInventario(VpaDInventario : TRBDInventarioCorpo) :String;
Var
  VpfLaco : Integer;
  VpfDItemInventario :TRBDInventarioItem;
begin
  AdicionaSQLAbreTabela(InvCadastro,'Select * from INVENTARIOITEM ' +
                                    ' Where COD_FILIAL = 0 AND SEQ_INVENTARIO = 0 AND SEQ_ITEM = 0 ');
  for VpfLaco := 0 to VpaDInventario.ItemsInventario.Count - 1 do
  begin
    VpfDItemInventario := TRBDInventarioItem(VpaDInventario.ItemsInventario.Items[Vpflaco]);
    InvCadastro.Insert;
    InvCadastro.FieldByName('COD_FILIAL').AsInteger := VpaDInventario.CodFilial;
    InvCadastro.FieldByName('SEQ_INVENTARIO').AsInteger := VpaDInventario.SeqInventario;
    InvCadastro.FieldByName('COD_COR').AsInteger := VpfDItemInventario.CodCor;
    InvCadastro.FieldByName('COD_PRODUTO').AsString := VpfDItemInventario.CodProduto;
    InvCadastro.FieldByName('COD_UNIDADE').AsString := VpfDItemInventario.UM;
    InvCadastro.FieldByName('COD_USUARIO').AsInteger := VpfDItemInventario.CodUsuario;
    InvCadastro.FieldByName('DAT_INVENTARIO').AsDatetime := now;
    InvCadastro.FieldByName('QTD_PRODUTO').AsFloat := VpfDItemInventario.QtdProduto;
    InvCadastro.FieldByName('SEQ_PRODUTO').AsInteger := VpfDItemInventario.SeqProduto;
    InvCadastro.FieldByName('COD_TAMANHO').AsInteger := VpfDItemInventario.CodTamanho;
    InvCadastro.FieldByName('SEQ_ITEM').AsInteger := RSeqItemInventarioDisponivel(IntTostr(VpaDInventario.CodFilial),IntToStr(VpaDInventario.SeqInventario));
    InvCadastro.Post;
    result := InvCadastro.AMensagemErroGravacao;
    if InvCadastro.AErronaGravacao then
      break;
  end;
  InvCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesInventario.CarDInventario(VpaDInventario : TRBDInventarioCorpo;VpaCodFilial,VpaSeqInventario : Integer);
begin
  AdicionaSQLAbreTabela(Inventario,'Select * from INVENTARIOCORPO '+
                                   ' Where COD_FILIAL = '+ IntToStr(VpaCodFilial)+
                                   ' AND SEQ_INVENTARIO = '+IntToStr(VpaSeqInventario));

  VpaDInventario.CodFilial := Inventario.FieldByname('COD_FILIAL').AsInteger;
  VpaDInventario.SeqInventario := Inventario.FieldByname('SEQ_INVENTARIO').AsInteger;
  VpaDInventario.CodClassificacao := Inventario.FieldByname('CODCLASSIFICACAO').AsString;
  VpaDInventario.CodUsuario := Inventario.FieldByname('COD_USUARIO').AsInteger;
  Inventario.close;

  CarDItemInventario(VpaDInventario);
end;

{******************************************************************************}
procedure TRBFuncoesInventario.DeletaItensInventario(VpaCodFilial, VpaSeqInventario : String);
begin
  ExecutaComandoSql(InvAux,'Delete from INVENTARIOITEM '+
                           ' Where COD_FILIAL = ' + VpaCodFilial +
                           ' and SEQ_INVENTARIO = '+ VpaSeqInventario);
end;

{******************************************************************************}
procedure TRBFuncoesInventario.DeletaInventario(VpaCodFilial,VpaSeqInventario : Integer);
begin
  ExecutaComandoSql(InvAux,'Delete from INVENTARIOITEM '+
                           ' Where COD_FILIAL = ' + IntToStr(VpaCodFilial) +
                           ' and SEQ_INVENTARIO = '+ IntToStr(VpaSeqInventario));
  ExecutaComandoSql(InvAux,'Delete from INVENTARIOCORPO '+
                           ' Where COD_FILIAL = ' + IntToStr(VpaCodFilial) +
                           ' and SEQ_INVENTARIO = '+ IntToStr(VpaSeqInventario));
end;

end.
