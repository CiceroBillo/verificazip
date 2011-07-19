Unit UnPesquisaSatisfacao;
{Verificado
-.edit;
}
Interface

Uses Classes, unDados, SysUtils, SQLExpr,tabela;

//classe localiza
Type TRBLocalizaPesquisaSatisfacao = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesPesquisaSatisfacao = class(TRBLocalizaPesquisaSatisfacao)
  private
    Cadastro : TSQL;
    Aux : TSQLQuery;
    function RSeqPesquisaChamadoDisponivel(VpaCodFilial : Integer):integer;
    function GravaDPesquisaChamadoItem(VpaDPesquisa : TRBDPesquisaSatisfacaoCorpo) : string;
  public
    constructor cria(VpaBaseDados : TSQLConnection );
    destructor destroy;override;
    function GravaDPesquisaChamado(VpaDPesquisa : TRBDPesquisaSatisfacaoCorpo):string;

end;



implementation

Uses FunSql;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaPesquisaSatisfacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaPesquisaSatisfacao.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesPesquisaSatisfacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesPesquisaSatisfacao.cria(VpaBaseDados : TSQLConnection );
begin
  inherited create;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesPesquisaSatisfacao.destroy;
begin
  Cadastro.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesPesquisaSatisfacao.RSeqPesquisaChamadoDisponivel(VpaCodFilial : Integer):integer;
begin
  AdicionaSqlabreTabela(Aux,'Select MAX(SEQPESQUISA)ULTIMO from SATISFACAOCHAMADOCORPO '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  result := Aux.FieldByname('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesPesquisaSatisfacao.GravaDPesquisaChamadoItem(VpaDPesquisa : TRBDPesquisaSatisfacaoCorpo) : string;
Var
  VpfDItemPesquisa : TRBDPesquisaSatisfacaoItem;
  VpfLaco : Integer;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from SATISFACAOCHAMADOITEM');
  for VpfLaco := 0 to VpaDPesquisa.Items.Count - 1 do
  begin
    VpfDItemPesquisa := TRBDPesquisaSatisfacaoItem(VpaDPesquisa.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByname('CODFILIAL').AsInteger := VpaDPesquisa.CodFilial;
    Cadastro.FieldByname('SEQPESQUISA').AsInteger := VpaDPesquisa.SeqPesquisa;
    Cadastro.FieldByname('CODPESQUISA').AsInteger := VpaDPesquisa.CodPesquisa;
    Cadastro.FieldByname('SEQPERGUNTA').AsInteger := VpfDItemPesquisa.SeqPergunta;
    if VpfDItemPesquisa.DesSimNao <> '' then
      Cadastro.FieldByname('DESSIMNAO').AsString := VpfDItemPesquisa.DesSimNao;
    if VpfDItemPesquisa.NumBomRuim <> 0 then
      Cadastro.FieldByname('NUMBOMRUIM').AsInteger := VpfDItemPesquisa.NumBomRuim;
    if VpfDItemPesquisa.DesTexto <> '' then
      Cadastro.FieldByname('DESTEXTO').AsString := VpfDItemPesquisa.DesTexto;
    if VpfDItemPesquisa.NumNota >= 0 then
      Cadastro.FieldByname('NUMNOTA').AsInteger := VpfDItemPesquisa.NumNota;
    try
      Cadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVA플O DA PESQUISA DE SATISFA플O ITEM!!!'#13+e.message;
        exit;
      end;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesPesquisaSatisfacao.GravaDPesquisaChamado(VpaDPesquisa : TRBDPesquisaSatisfacaoCorpo):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from SATISFACAOCHAMADOCORPO');
  Cadastro.insert;
  Cadastro.FieldByname('CODFILIAL').AsInteger := VpaDPesquisa.CodFilial;
  Cadastro.FieldByname('CODUSUARIO').AsInteger := VpaDPesquisa.CodUsuario;
  Cadastro.FieldByname('NUMCHAMADO').AsInteger := VpaDPesquisa.NumChamado;
  Cadastro.FieldByname('CODTECNICO').AsInteger := VpaDPesquisa.CodTecnico;
  Cadastro.FieldByname('DATPESQUISA').AsDateTime := VpaDPesquisa.DatPesquisa;
  Cadastro.FieldByname('CODPESQUISA').AsInteger := VpaDPesquisa.CodPesquisa;
  VpaDPesquisa.SeqPesquisa := RSeqPesquisaChamadoDisponivel(VpaDPesquisa.CodFilial);
  Cadastro.FieldByname('SEQPESQUISA').AsInteger := VpaDPesquisa.SeqPesquisa;
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVA플O DA PESQUISA DE SATISFA허O DO CHAMADO!!!'#13+e.message;
  end;
  Cadastro.close;
  if result = ''then
    result := GravaDPesquisaChamadoItem(VpaDPesquisa);
end;

end.
