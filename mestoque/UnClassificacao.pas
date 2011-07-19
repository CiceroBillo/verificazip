unit UnClassificacao;
{Verificado
-.edit;
}
interface

uses
  DB,DBTables, classes, sysUtils, painelGradiente, ConvUnidade, UnMoedas,
  UnSumarizaEstoque, UnCodigoBarra, UnDados, unDadosProduto, sqlexpr,tabela;

type
  TClassificacao = class
    CodServico,
    SeqProduto : Integer;
    CodClassificacao,
    CodClassificacoReduzido,
    CodProduto,
    NomClassificacao,
    DesPathFoto,
    Tipo : String;
    ProdutosCarregados : Boolean;
    constructor cria;
    destructor destroy;override;
end;



// localizacao
Type
  TLocalizaClassificacao = class
  public
    procedure LocalizaClassificacao(Tabela : TdataSet; Classificacao : string; TipoCla : string );
end;

// funcoes
type
  TFuncoesClassificacao = class(TLocalizaClassificacao)
  private
    Calcula,
    Tabela : TSQLQUERY;
    Cadastro: TSQL;
    DataBase: TSQLConnection;
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
    destructor Destroy; override;
    function ValidaClassificacao( codClassificao : string; Var nomeClassificacao : string; TipoCla : string  ) : Boolean;
    function ProximoCodigoClassificacao(tamanhoPicture : Integer; CodigoBase : string; TipoCla : string  ) : string;
    function GeraMascara( TamanhoPicture : integer ) : string;
    Function ClassificacaoExistente( CodClassificacao : string; TipoCla : string  ) : Boolean;
    Function RetornaNomeClassificacao(VpaCodClassificacao, VpaTipo : String):String;
    procedure CarDComissaoClassificacaoVendedor(VpaCodEmpresa: Integer; VpaCodClassificacao, VpaTipClassificacao: String; VpaComissoes: TList);
    function GravaDComissaoClassificacaoVendedor(VpaCodEmpresa: Integer; VpaCodClassificacao, VpaTipClassificacao: String; VpaComissoes: TList): String;
    function VendedorDuplicado(VpaComissoes: TList): Boolean;
 end;

implementation

uses constMsg, constantes, funSql, funstring, fundata, funnumeros, FunObjeto;

{******************************************************************************}
constructor TClassificacao.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TClassificacao.destroy;
begin
  inherited destroy;
end;

{#############################################################################
                        TLocaliza Produtos
#############################################################################  }

{ ***************** localiza uma conta bancaria *************************** }
procedure TLocalizaClassificacao.LocalizaClassificacao(Tabela : TDataset; Classificacao : string; TipoCla : string );
begin
  AdicionaSQLAbreTabela(tabela,'select * from cadClassificacao where i_cod_emp = ' +
                                IntToStr(varia.CodigoEmpresa) +
                               ' and c_tip_cla = ''' + TipoCla + '''' +
                               ' and c_cod_cla = ''' + Classificacao + '''');
end;

{#############################################################################
                        TFuncoes Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesClassificacao.criar( aowner : TComponent; VpaBaseDados : TSQLConnection);
begin
  inherited;
  DataBase := VpaBaseDados;
  Calcula := TSQLQuery.Create(nil);
  Calcula.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  Cadastro:= TSQL.Create(nil);
  Cadastro.ASqlConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesClassificacao.Destroy;
begin
  FechaTabela(Cadastro);
  Cadastro.Free;
  FechaTabela(tabela);
  Tabela.Destroy;
  Calcula.free;
  inherited;
end;

function TFuncoesClassificacao.ValidaClassificacao( codClassificao : string; Var nomeClassificacao : string; TipoCla : string  ) : Boolean;
begin
  AdicionaSQLAbreTabela(Calcula, 'Select * from CadClassificacao'+
                                 ' where I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                                 ' and c_tip_cla = ''' + TipoCla + '''' +
                                 ' and c_Cod_Cla = ''' + codClassificao + '''' );
  result := not calcula.Eof;
  nomeClassificacao := calcula.fieldbyName('c_nom_cla').AsString;
  Calcula.close;
end;

{************* cria novo codigo para uma classificacao *********************** }
function TFuncoesClassificacao.ProximoCodigoClassificacao(tamanhoPicture : Integer; CodigoBase : string; TipoCla : string  ) : string;
var
  codi : string;
begin
  codi := AdicionaCharD('_',CodigoBase,length(CodigoBase) + tamanhoPicture);

  AdicionaSQLAbreTabela(tabela, ' select  max(c_cod_cla) as maximo ' +
                                ' from cadClassificacao where i_cod_emp = ' +
                                IntToStr(varia.CodigoEmpresa) +
                                ' and c_tip_cla = ''' + TipoCla + '''' +
                                ' and c_cod_cla like ''' + Codi + '''' );
  try
    if Tabela.fieldByName('maximo').AsString <> '' then
    begin
      codi := IntToStr(StrToInt(Tabela.fieldByName('maximo').AsString)+ 1);
      result := AdicionaCharE('0',copy(AdicionaCharE('0',codi,length(CodigoBase)+tamanhoPicture), length(CodigoBase)+1, tamanhoPicture),tamanhoPicture);
    end
    else
      result := AdicionaCharE('0','1',tamanhoPicture);
  except
    result := '';
  end;
  FechaTabela(Tabela);
end;

function TFuncoesClassificacao.GeraMascara( TamanhoPicture : integer ) : String;
var
  laco : integer;
begin
  result := '';
  for laco := 1 to TamanhoPicture do
     result := result + '0';
 result := result + ';0;_';
end;

{ **************** verifica se ja existe uma determinada Classificacao ******* }
Function TFuncoesClassificacao.ClassificacaoExistente( CodClassificacao : string; TipoCla : string  ) : Boolean;
begin
  result := true;

  LocalizaClassificacao(tabela,CodClassificacao, TipoCla );

  if not tabela.EOF then
  begin
    erro(CT_DuplicacaoClassificacao);
    result := false;
  end;

  FechaTabela(tabela);
end;

{********************* retorna o nome da classificacao ************************}
Function TFuncoesClassificacao.RetornaNomeClassificacao(VpaCodClassificacao, VpaTipo : String):String;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * From CadClassificacao ' +
                               ' Where I_Cod_Emp = ' + IntToStr(Varia.CodigoEmpresa)+
                               ' and C_Cod_Cla = '''+ VpaCodClassificacao + ''''+
                               ' and C_Tip_Cla = '''+ VpaTipo + '''');
  result := Tabela.FieldByName('C_Nom_Cla').Asstring;
end;

{******************************************************************************}
procedure TFuncoesClassificacao.CarDComissaoClassificacaoVendedor(
  VpaCodEmpresa: Integer; VpaCodClassificacao, VpaTipClassificacao: String;
  VpaComissoes: TList);
var
  VpfDComissao: TRBDComissaoClassificacaoVendedor;
begin
  FreeTObjectsList(VpaComissoes);
  AdicionaSQLAbreTabela(Tabela,'SELECT CCV.CODEMPRESA, CCV.CODCLASSIFICACAO, CCV.TIPCLASSIFICACAO,'+
                               ' CCV.CODVENDEDOR, VEN.C_NOM_VEN, CCV.PERCOMISSAO'+
                               ' FROM COMISSAOCLASSIFICACAOVENDEDOR CCV, CADVENDEDORES VEN'+
                               ' WHERE'+
                               ' CCV.CODEMPRESA = '+IntToStr(VpaCodEmpresa)+
                               ' AND CCV.CODCLASSIFICACAO = '''+VpaCodClassificacao+''''+
                               ' AND CCV.TIPCLASSIFICACAO = '''+VpaTipClassificacao+''''+
                               ' AND VEN.I_COD_VEN = CCV.CODVENDEDOR');
  while not Tabela.Eof do
  begin
    VpfDComissao:= TRBDComissaoClassificacaoVendedor.Cria;
    VpaComissoes.Add(VpfDComissao);

    VpfDComissao.CodEmpresa:= Tabela.FieldByName('CODEMPRESA').AsInteger;
    VpfDComissao.CodVendedor:= Tabela.FieldByName('CODVENDEDOR').AsInteger;
    VpfDComissao.TipClassificacao:= Tabela.FieldByName('TIPCLASSIFICACAO').AsString;
    VpfDComissao.CodClassificacao:= Tabela.FieldByName('CODCLASSIFICACAO').AsString;
    VpfDComissao.NomVendedor:= Tabela.FieldByName('C_NOM_VEN').AsString;
    VpfDComissao.PerComissao:= Tabela.FieldByName('PERCOMISSAO').AsFloat;

    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesClassificacao.GravaDComissaoClassificacaoVendedor(VpaCodEmpresa: Integer; VpaCodClassificacao, VpaTipClassificacao: String; VpaComissoes: TList): String;
var
  VpfLaco: Integer;
  VpfDComissaoVendedor: TRBDComissaoClassificacaoVendedor;
begin
  Result:= '';
  ExecutaComandoSql(Cadastro,'DELETE FROM COMISSAOCLASSIFICACAOVENDEDOR'+
                             ' WHERE CODEMPRESA = '+IntToStr(VpaCodEmpresa)+
                             ' AND CODCLASSIFICACAO = '''+VpaCodClassificacao+''''+
                             ' AND TIPCLASSIFICACAO = '''+VpaTipClassificacao+'''');
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM COMISSAOCLASSIFICACAOVENDEDOR');
  for VpfLaco:= 0 to VpaComissoes.Count-1 do
  begin
    VpfDComissaoVendedor:= TRBDComissaoClassificacaoVendedor(VpaComissoes.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('CODEMPRESA').AsInteger:= VpaCodEmpresa;
    Cadastro.FieldByName('CODCLASSIFICACAO').AsString:= VpaCodClassificacao;
    Cadastro.FieldByName('TIPCLASSIFICACAO').AsString:= VpaTipClassificacao;
    Cadastro.FieldByName('CODVENDEDOR').AsInteger:= VpfDComissaoVendedor.CodVendedor;
    Cadastro.FieldByName('PERCOMISSAO').AsFloat:= VpfDComissaoVendedor.PerComissao;
    try
      Cadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO GRAVAR A COMISSAO CLASSIFICACAO VENDEDOR'#13+E.Message;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TFuncoesClassificacao.VendedorDuplicado(VpaComissoes: TList): Boolean;
var
  VpfLaco, VpfLacoInterno,
  VpfCodVendedor: Integer;
  VpfDComissao: TRBDComissaoClassificacaoVendedor;
begin
  Result:= False;
  //verificar
  for VpfLaco:= 0 to VpaComissoes.Count-1 do
  begin
    VpfDComissao:= TRBDComissaoClassificacaoVendedor(VpaComissoes.Items[VpfLaco]);
    VpfCodVendedor:= VpfDComissao.CodVendedor;
    for VpfLacoInterno:= 0 to VpaComissoes.Count-1 do
    begin
      VpfDComissao:= TRBDComissaoClassificacaoVendedor(VpaComissoes.Items[VpfLacoInterno]);
      if (VpfDComissao.CodVendedor = VpfCodVendedor) and
         (VpfLaco <> VpfLacoInterno) then
      begin
        Result:= True;
        Break;
      end;
    end;
    if Result = True then
      Break;    
  end;
end;

end.
