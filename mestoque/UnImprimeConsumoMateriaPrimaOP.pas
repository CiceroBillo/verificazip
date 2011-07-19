Unit UnImprimeConsumoMateriaPrimaOP;
{Verificado
-.edit;
}
Interface

Uses Classes, SQLExpr, tabela, SysUtils, UnDadosProduto, UnOrdemProducao;

//classe localiza
Type TRBLocalizaImprimeConsumoMateriaPrima = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesImprimeConsumoMateriaPrima = class(TRBLocalizaImprimeConsumoMateriaPrima)
  private
    Fracoes : TSQLQuery;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure ImprimeCabecalhoFichadeConsumo(VpaArquivo : TStringList;VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao :TRBDFracaoOrdemProducao);
    procedure ImprimeConsumos(VpaArquivo : TStringList;VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao :TRBDFracaoOrdemProducao);
  public
    constructor cria(VpaBaseDados : TSQLConnection );
    destructor destroy;override;
    procedure ImprimeFichadeConsumoFracao(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao : TRBDFracaoOrdemProducao);
    procedure ImprimeFichadeConsumo(VpaCodFilial,VpaSeqOrdem : Integer);
end;



implementation

Uses FunSql, Constantes, FunString, UnProdutos;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaImprimeConsumoMateriaPrima
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaImprimeConsumoMateriaPrima.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesImprimeConsumoMateriaPrima
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesImprimeConsumoMateriaPrima.cria(VpaBaseDados : TSQLConnection );
begin
  inherited create;
  Fracoes := TSQLQuery.create(nil);
  Fracoes.SQLConnection := VpaBaseDados;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(VpaBaseDados);
end;

{******************************************************************************}
destructor TRBFuncoesImprimeConsumoMateriaPrima.destroy;
begin
  Fracoes.free;
  FunOrdemProducao.free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesImprimeConsumoMateriaPrima.ImprimeCabecalhoFichadeConsumo(VpaArquivo : TStringList;VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao :TRBDFracaoOrdemProducao);
begin
  VpaArquivo.Add(AdicionaCharDE(' ','FICHA DE CONSUMO',78));
  VpaArquivo.add('');
  VpaArquivo.add('');
  VpaArquivo.add('');
  VpaArquivo.add('Filial  : '+IntToStr(VpaDOrdemProducao.CodEmpresafilial) + '     OP : '+IntToStr(VpaDOrdemProducao.SeqOrdem) +'    Fracao : '+IntToStr(VpaDFracao.SeqFracao)+ '           Entrega : '+formatdateTime('DD/MM/YYYY',VpaDFracao.DatEntrega) );
  VpaArquivo.add('');
  VpaArquivo.add('Data Op : '+ formatdateTime('DD/MM/YYYY',VpaDOrdemProducao.DatEmissao)+'               Data Impressao Ficha : '+FormatDateTime('DD/MM/YYYY HH:MM',Now) );
  VpaArquivo.add('');
  VpaArquivo.add('Produto : '+VpaDOrdemProducao.CodProduto+ ' - '+ AdicionaCharD(' ',VpaDOrdemProducao.DProduto.NomProduto,50));
  VpaArquivo.add('Cor     : '+IntToStr(VpaDOrdemProducao.CodCor) + ' - '+AdicionaCharD(' ',VpaDOrdemProducao.NomCor,35) + '  Qtd : '+FormatFloat(Varia.MascaraQtd,VpaDFracao.QtdProduto)+  '    UN : '+VpaDOrdemProducao.UMPedido );
  VpaArquivo.add('');
  VpaArquivo.add('');
  VpaArquivo.add(AdicionaCharD(' ','         QTD',5)+AdicionaCharDE(' ','MATERIA PRIMA',50)+'     QTD TOTAL');
end;

{******************************************************************************}
procedure TRBFuncoesImprimeConsumoMateriaPrima.ImprimeConsumos(VpaArquivo : TStringList;VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao :TRBDFracaoOrdemProducao);
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoMP;
  VpfQtdTotal : String;
begin
  FunProdutos.CarConsumoProduto(VpaDOrdemProducao.DProduto,VpaDOrdemProducao.CodCor);
  for VpfLaco := 0 to VpaDOrdemProducao.DProduto.ConsumosMP.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoMP(VpaDOrdemProducao.DProduto.ConsumosMP.Items[VpfLaco]);
    if (UpperCase(VpfDConsumo.UM) = 'CM') or (UpperCase(VpfDConsumo.UM) = 'MT') then
      VpfQtdTotal := FormatFloat(varia.MascaraQtd,VpaDFracao.QtdProduto)+' pc'
    else
      VpfQtdTotal :=FormatFloat(varia.MascaraQtd,VpfDConsumo.QtdProduto*VpaDFracao.QtdProduto)+ ' '+VpfDConsumo.UM;

    VpaArquivo.Add(AdicionaCharE(' ',FormatFloat(varia.MascaraQtd,VpfDConsumo.QtdProduto),10) +' ' +VpfDConsumo.UM+ '   '+VpfDConsumo.CodProduto+'-'+AdicionaCharD(' ',VpfDConsumo.NomProduto,40)+ ' '+
                  AdicionaCharE(' ',VpfQtdTotal,12)  );
    VpaArquivo.Add('    Cor : '+IntToStr(VpfDConsumo.CodCor)+'-'+ AdicionaCharD(' ',VpfDConsumo.NomCor,30)+'      Prateleira = '+VpfDConsumo.DesPrateleira );
    VpaArquivo.add('');
  end;

end;

{******************************************************************************}
procedure TRBFuncoesImprimeConsumoMateriaPrima.ImprimeFichadeConsumoFracao(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao : TRBDFracaoOrdemProducao );
var
  VpfArquivo : TStringList;
begin
  VpfArquivo := TStringList.Create;
  ImprimeCabecalhoFichadeConsumo(VpfArquivo,VpaDOrdemProducao,VpaDfracao);
  ImprimeConsumos(VpfArquivo,VpaDOrdemProducao,VpaDfracao);
  VpfArquivo.add('');
  VpfArquivo.add('');
  VpfArquivo.add('');
  VpfArquivo.add('');
  VpfArquivo.SaveToFile('lpt1');
  VpfArquivo.free;
end;

{******************************************************************************}
procedure TRBFuncoesImprimeConsumoMateriaPrima.ImprimeFichadeConsumo(VpaCodFilial,VpaSeqOrdem : Integer);
var
  VpfDOrdemProducao : TRBDOrdemProducao;
  VpfLaco : Integer;
begin
  VpfDOrdemProducao := TRBDOrdemProducao.cria;
  FunOrdemProducao.CarDOrdemProducaoBasica(VpaCodFilial,VpaSeqOrdem,VpfDOrdemProducao);
  for VpfLaco := 0 to VpfDOrdemProducao.Fracoes.Count - 1 do
  begin
    ImprimeFichadeConsumoFracao(VpfDOrdemProducao,TRBDFracaoOrdemProducao(VpfDOrdemProducao.Fracoes.Items[Vpflaco]));
  end;
  VpfDOrdemProducao.free;
end;

end.
