Unit unPremer;
{Verificado
-.edit;
}
Interface

Uses Classes, DB, UnDadosProduto, Gauges, SysUtils,stdctrls, Tabela, SqlExpr;

//classe localiza
Type TRBLocalizaPremer = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesPremer = class(TRBLocalizaPremer)
  private
    Aux : TSQLQuery;
    Cadastro : TSQL;
    VprLabel : TLabel;
    VprNivel : String;
    procedure LimpaConsumo(VpaSeqProduto : Integer);
    procedure LimpaEstagios(VpaSeqProduto : Integer);
    function LimpaAspasdoNome(VpaNomProduto : String):string;
    function RSeqConsumoDisponivel(VpaSeqProduto,VpaCodCor : Integer) : Integer;
    function RSeqEstagioDisponivel(VpaSeqProduto : Integer):Integer;
    function RProximoCodigoProduto : string;
    procedure CarNomeProdutoPrincipal(VpaDProduto : TRBDProduto;VpaNomArquivo : String);
    function AdicionaConsumoProduto(VpaSeqProdutoPai, VpfSeqProduto : Integer;VpaLinha : String):string;
    function AdicionaEstagioProduto(VpaSeqProduto, VpaCodEstagio : Integer):string;
    function AdicionaEstagioTipoCorte(VpaSeqProduto : Integer;VpaCodCorte : String) : String;
    function AdicionaEstagioSegundoProcesso(VpaSeqProduto : Integer;VpaCodProcesso : String):String;
    function RCodClassificacaoProdutoPrincipal(VpaCodProduto : String):string;
    function RCodClassificacaoProduto(VpaDProduto : TRBDProduto):string;
    function RMedidaComPerda(VpaMedida : String) : Double;
    function PrimeiraParteDoCodigoENumero(VpaCodProduto : string):Boolean;
    function CadastraClassificacao(VpaCodClassificacao, VpaCodProduto : String):string;
    function CadastraProdutoPrincipal(VpaNomArquivo : String;VpaProdutos : TStringList):String;
    function CadastraProduto(VpaLinha : String;VpaDProduto : TRBDProduto):String;
    function AssociaMateriaPrima(VpaLinha : String;VpaDProduto : TRBDProduto):String;
    function AssociaEstagiosProduto(VpaSeqProduto : Integer;VpaCodProduto, VpaLinha : String) : string;
    function AssociaEstagiosProdutoPremer(VpaSeqProduto : Integer;VpaCodProduto : String) : string;
    function AssociaEstagiosProdutoPerfor(VpaSeqProduto : Integer;VpaLinha : String) : string;
    function CadastraMateriaPrima(VpaNomeProduto, VpaDimensoes : String):Integer;
    procedure AtualizaStatus(VpaTexto : String);
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    function ImportaProjeto(VpaNomArquivo : String;VpaProgresso : TGauge;VpaStatus : TLabel) : String;
end;



implementation

Uses FunSql, UnProdutos,FunArquivos, FunString, ConstMsg, Constantes;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaPremer
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaPremer.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesPremer
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesPremer.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQlConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesPremer.destroy;
begin
  Aux.close;
  Aux.free;
  Cadastro.close;
  Cadastro.free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesPremer.LimpaConsumo(VpaSeqProduto : Integer);
begin
  ExecutaComandoSql(Aux,'Delete from MOVKIT '+
                        ' Where I_PRO_KIT = '+IntToStr(VpaSeqProduto));
end;

{******************************************************************************}
procedure TRBFuncoesPremer.LimpaEstagios(VpaSeqProduto : Integer);
begin
  ExecutaComandoSql(Aux,'Delete from PRODUTOESTAGIO '+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProduto));
end;

{******************************************************************************}
function TRBFuncoesPremer.PrimeiraParteDoCodigoENumero( VpaCodProduto: string): Boolean;
begin
  if (varia.CNPJFilial = CNPJ_PERFOR)or
     (varia.CNPJFilial = CNPJ_MAQMUNDI)or
     (varia.CNPJFilial = CNPJ_MIGRAMAQ) then
    result := false
  else
  begin
    try
       StrToInt(DeletaChars(DeletaEspaco(CopiaAteChar(VpaCodProduto,' ')),'.'));
       result := true;
    except
      result := false;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesPremer.LimpaAspasdoNome(VpaNomProduto : String):string;
begin
  if length(VpaNomProduto) > 0 then
  begin
    if VpaNomProduto[1] = '"' then
      VpaNomProduto := copy(VpaNomProduto,2,length(VpaNomProduto)-1);
    if (VpaNomProduto[Length(VpaNomProduto)] = '"') then
      VpaNomProduto := copy(VpaNomProduto,1,length(VpaNomProduto)-1);
  end;
  Result := VpaNomProduto;
end;

{******************************************************************************}
function TRBFuncoesPremer.RSeqConsumoDisponivel(VpaSeqProduto,VpaCodCor : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select max(I_SEQ_MOV) ULTIMO FROM MOVKIT '+
                            ' Where I_PRO_KIT = '+IntToStr(VpaSeqProduto)+
                            ' and I_COR_KIT = '+IntToStr(VpaCodCor));
  result := Aux.FieldByname('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesPremer.RSeqEstagioDisponivel(VpaSeqProduto : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQESTAGIO) ULTIMO from PRODUTOESTAGIO '+
                            ' Where SEQPRODUTO = '+IntToStr(VpaSeqProduto));
  result := Aux.FieldByname('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesPremer.RProximoCodigoProduto : string;
begin
  AdicionaSQLAbreTabela(Aux, ' select max(I_ULT_PRO) as ULTIMO ' +
                            ' from CADEMPRESAS '+
                            ' where i_cod_emp = ' +IntToStr(varia.CodigoEmpresa) );

  result := IntTostr(Aux.FieldByName('ULTIMO').AsInteger+1);
  Aux.Close;
  ExecutaComandoSql(Aux,'update CADEMPRESAS '+
                           ' Set I_ULT_PRO = I_ULT_PRO + 1'+
                            ' where i_cod_emp = ' +IntToStr(varia.CodigoEmpresa) );
end;

{******************************************************************************}
function TRBFuncoesPremer.RCodClassificacaoProdutoPrincipal(VpaCodProduto : String):string;
var
  VpfSigProduto : String;
begin
  if (Varia.CNPJFilial = CNPJ_Premer) or
     (Varia.CNPJFilial = CNPJ_Half) then
  begin
    result := '01';
    VpfSigProduto := copy(VpaCodProduto,1,2);
    if VpfSigProduto = 'PP' then
      result := '0101'
    else
      if VpfSigProduto = 'PC' then
        result := '0102'
      else
        if VpfSigProduto = 'PS' then
          result := '0103'
        else
          if VpfSigProduto = 'PM' then
            result := '0104';
  end
  else
    if (Varia.CNPJFilial = CNPJ_PERFOR) then
    begin
      VpfSigProduto := Copy(VpaCodProduto,1,6);
      VpfSigProduto := DeletaChars(VpfSigProduto,' ');
      if not SomenteNumeros(VpfSigProduto) then
      begin
        aviso('ERRO NA IMPORTAÇÃO DO PRODUTO "'+VpaCodProduto+'"');
        VpfSigProduto := '90';
      end;

      if VpfSigProduto = '' then
        result := '90'
      else
      begin
        result := VpfSigProduto;
        CadastraClassificacao(VpfSigProduto,'SEM NOME');
      end;
    end
    else
      if (Varia.CNPJFilial = CNPJ_MAQMUNDI) or
         (Varia.CNPJFilial = CNPJ_MIGRAMAQ) then
      begin
        VpfSigProduto := Copy(VpaCodProduto,1,3);
        VpfSigProduto := DeletaChars(VpfSigProduto,' ');
        if not SomenteNumeros(VpfSigProduto) then
        begin
          aviso('ERRO NA IMPORTAÇÃO DO PRODUTO "'+VpaCodProduto+'"');
          VpfSigProduto := '90';
        end;

        if VpfSigProduto = '' then
          result := '209'
        else
        begin
          result := VpfSigProduto;
          CadastraClassificacao(VpfSigProduto,'SEM NOME');
        end;
      end;
end;

{******************************************************************************}
function TRBFuncoesPremer.AdicionaConsumoProduto(VpaSeqProdutoPai, VpfSeqProduto : Integer;VpaLinha : String):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVKIT'+
                                 ' Where I_PRO_KIT = 0 AND I_SEQ_MOV = 0 AND I_COR_KIT = 0 ');
  Cadastro.insert;
  Cadastro.FieldByname('I_PRO_KIT').AsInteger := VpaSeqProdutoPai;
  Cadastro.FieldByname('I_SEQ_PRO').AsInteger := VpfSeqProduto;
  Cadastro.FieldByname('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
  Cadastro.FieldByname('D_ULT_ALT').AsDateTime := now;
  Cadastro.FieldByname('C_COD_UNI').AsString := 'PC';
  Cadastro.FieldByname('I_COR_KIT').AsInteger := 0;
  Cadastro.FieldByname('I_COD_COR').AsInteger := 0;

  VpaLinha := CopiaateChar(DeleteAteChar(DeleteAteChar(DeleteAteChar(DeleteAteChar(DeleteAteChar(VpaLinha,';'),';'),';'),';'),';'),';');
  Cadastro.FieldByname('N_QTD_PRO').AsInteger := StrToInt(VpaLinha);
  Cadastro.FieldByName('I_SEQ_MOV').AsInteger := RSeqConsumoDisponivel(VpaSeqProdutoPai,Cadastro.FieldByname('I_COR_KIT').AsInteger);
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO CONSUMO DO PRODUTO!!!'+#13+e.message;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesPremer.AdicionaEstagioProduto(VpaSeqProduto, VpaCodEstagio : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from PRODUTOESTAGIO '+
                                 ' Where SEQPRODUTO = 0 AND SEQESTAGIO = 0 ');
  Cadastro.insert;
  Cadastro.FieldByname('SEQPRODUTO').AsInteger := VpaSeqProduto;
  Cadastro.FieldByname('SEQESTAGIO').AsInteger := RSeqEstagioDisponivel(VpaSeqProduto);
  Cadastro.FieldByname('NUMORDEM').AsInteger := Cadastro.FieldByname('SEQESTAGIO').AsInteger;
  Cadastro.FieldByname('CODESTAGIO').AsInteger := VpaCodEstagio;
  Cadastro.FieldByname('QTDPRODUCAOHORA').AsInteger := 1;
  Cadastro.FieldByname('INDCONFIG').AsString := 'N';
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO ESTAGIO DO PRODUTO!!!'+#13+e.message;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesPremer.AdicionaEstagioTipoCorte(VpaSeqProduto : Integer;VpaCodCorte : String) : String;
Var
  VpfCodEstagio : Integer;
begin
  result := '';
  VpfCodEstagio := 0;
  if VpaCodCorte = '1' then
    VpfCodEstagio := 100
  else
    if VpaCodCorte = '2' then
      VpfCodEstagio := 110;
  if VpfCodEstagio <> 0 then
    result := AdicionaEstagioProduto(VpaSeqProduto,VpfCodEstagio);
end;

{******************************************************************************}
function TRBFuncoesPremer.AdicionaEstagioSegundoProcesso(VpaSeqProduto : Integer;VpaCodProcesso : String):String;
begin
  result := '';
  if VpaCodProcesso[1] = '2' then
  begin
    VpaCodProcesso := copy(VpaCodProcesso,3,2);
    if VpaCodProcesso = '' then
    begin
      aviso('FALTA PROCESSO DE USINAGEM');
    end
    else
    begin
      case StrToInt(VpaCodProcesso) of
        1 : result := AdicionaEstagioProduto(VpaSeqProduto,130);
        2 : result := AdicionaEstagioProduto(VpaSeqProduto,140);
        3 : result := AdicionaEstagioProduto(VpaSeqProduto,150);
        4 : result := AdicionaEstagioProduto(VpaSeqProduto,160);
        5 : result := AdicionaEstagioProduto(VpaSeqProduto,170);
        6 : result := AdicionaEstagioProduto(VpaSeqProduto,180);
        7 : result := AdicionaEstagioProduto(VpaSeqProduto,190);
       10 : begin
              result := AdicionaEstagioProduto(VpaSeqProduto,130);
              if result = '' then
                result := AdicionaEstagioProduto(VpaSeqProduto,140);
            end;
       11 : begin
              result := AdicionaEstagioProduto(VpaSeqProduto,130);
              if result = '' then
                result := AdicionaEstagioProduto(VpaSeqProduto,150);
            end;
       12 : begin
              result := AdicionaEstagioProduto(VpaSeqProduto,130);
              if result = '' then
                result := AdicionaEstagioProduto(VpaSeqProduto,160);
            end;
       13 : begin
              result := AdicionaEstagioProduto(VpaSeqProduto,130);
              if result = '' then
                result := AdicionaEstagioProduto(VpaSeqProduto,170);
            end;
       14 : begin
              result := AdicionaEstagioProduto(VpaSeqProduto,130);
              if result = '' then
                result := AdicionaEstagioProduto(VpaSeqProduto,180);
            end;
       15 : begin
              result := AdicionaEstagioProduto(VpaSeqProduto,140);
              if result = '' then
                result := AdicionaEstagioProduto(VpaSeqProduto,160);
            end;
       16 : begin
              result := AdicionaEstagioProduto(VpaSeqProduto,160);
              if result = '' then
                result := AdicionaEstagioProduto(VpaSeqProduto,130);
            end;
       17 : begin
              result := AdicionaEstagioProduto(VpaSeqProduto,160);
              if result = '' then
                result := AdicionaEstagioProduto(VpaSeqProduto,140);
            end;
       18 : begin
              result := AdicionaEstagioProduto(VpaSeqProduto,140);
              if result = '' then
                result := AdicionaEstagioProduto(VpaSeqProduto,170);
            end;
       19 : begin
              result := AdicionaEstagioProduto(VpaSeqProduto,160);
              if result = '' then
                result := AdicionaEstagioProduto(VpaSeqProduto,140);
            end;
      end;
    end;
  end
  else
  begin
    if VpaCodProcesso[1] = '1' then
      result := AdicionaEstagioProduto(VpaSeqProduto,120)
    else
      if VpaCodProcesso[1] = '3' then
        result := AdicionaEstagioProduto(VpaSeqProduto,210)
      else
        if VpaCodProcesso[1] = '4' then
          result := AdicionaEstagioProduto(VpaSeqProduto,220)
        else
          if VpaCodProcesso[1] = '5' then
            result := AdicionaEstagioProduto(VpaSeqProduto,230)
          else
            if VpaCodProcesso[1] = '6' then
              result := AdicionaEstagioProduto(VpaSeqProduto,240)
            else
              if VpaCodProcesso[1] = '7' then
                result := AdicionaEstagioProduto(VpaSeqProduto,250)
              else
                if VpaCodProcesso[1] = '8' then
                  result := AdicionaEstagioProduto(VpaSeqProduto,260);
  end;
end;

{******************************************************************************}
function TRBFuncoesPremer.RCodClassificacaoProduto(VpaDProduto : TRBDProduto):string;
var
  VpfSigProduto, VpfResultado : String;
begin
  if (varia.CNPJFilial = CNPJ_Premer)or
     (varia.CNPJFilial = CNPJ_HALF) then
  begin
    VpfSigProduto := copy(VpaDProduto.CodProduto,1,2);
    if VpfSigProduto = 'PP' then
      result := '0201'
    else
      if VpfSigProduto = 'PC' then
        result := '0202'
      else
        if VpfSigProduto = 'PS' then
          result := '0203'
        else
          if VpfSigProduto = 'PM' then
            result := '0204'
          else
            result := '0301';
    if (copy(VpaDProduto.CodProduto,2,1) = '.') or (copy(VpaDProduto.CodProduto,3,1)= '.') then
    begin
      result := '07' +AdicionaCharE('0',CopiaAteChar(VpaDProduto.CodProduto,'.'),2)+AdicionaCharE('0',DeletaChars(CopiaAteChar(DeleteAteChar(VpaDProduto.CodProduto,'.'),' '),' '),3);
      VpfResultado := CadastraClassificacao(Result,VpaDProduto.CodProduto);
      repeat
        VpaDProduto.CodProduto := RProximoCodigoProduto;
      until not FunProdutos.ExisteProduto(VpaDProduto.CodProduto);
      if VpfResultado <> '' then
        aviso(VpfResultado);
    end;
  end
  else
    if (varia.CNPJFilial = CNPJ_PERFOR) or
       (varia.CNPJFilial = CNPJ_MAQMUNDI) or
       (varia.CNPJFilial = CNPJ_MIGRAMAQ) then
      result := RCodClassificacaoProdutoPrincipal(VpaDProduto.CodProduto);

end;


{******************************************************************************}
function TRBFuncoesPremer.RMedidaComPerda(VpaMedida : String) : Double;
begin
  if ExisteLetraString('+',VpaMedida) then //se tiver perda no campo possui um sinal + somando a largura original mais a perda
  begin
    result := StrToFloat(SubstituiStr(CopiaAteChar(VpaMedida,'+'),'.',','));
    VpaMedida := DeleteAteChar(VpaMedida,'+');
    Result := (Result +StrToFloat(SubstituiStr(VpaMedida,'.',',')))/10;
  end
  else
    result := StrToFloat(SubstituiStr(VpaMedida,'.',','))/10;
end;

{******************************************************************************}
function TRBFuncoesPremer.CadastraClassificacao(VpaCodClassificacao, VpaCodProduto : String):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCLASSIFICACAO '+
                                 ' Where C_COD_CLA = '''+VpaCodClassificacao+'''');
  if Cadastro.eof then
  begin
    Cadastro.Insert;
    Cadastro.FieldByName('I_COD_EMP').AsInteger := 1;
    Cadastro.FieldByName('C_COD_CLA').AsString := VpaCodClassificacao;
    if (varia.CNPJFilial = CNPJ_PREMER) OR
       (varia.CNPJFilial = CNPJ_HALF) then
      Cadastro.FieldByName('C_NOM_CLA').AsString := CopiaAteChar(DeleteAteChar(VpaCodProduto,' '),' ')
    else
      if (varia.CNPJFilial = CNPJ_PERFOR) or
         (varia.CNPJFilial = CNPJ_MAQMUNDI)or
         (varia.CNPJFilial = CNPJ_MIGRAMAQ) then
        Cadastro.FieldByName('C_NOM_CLA').AsString := VpaCodProduto;
    Cadastro.FieldByName('C_CON_CLA').AsString := 'S';
    Cadastro.FieldByName('C_TIP_CLA').AsString := 'P';
    Cadastro.FieldByName('D_ULT_ALT').AsDateTime := date;
    Cadastro.FieldByName('C_ALT_QTD').AsString := 'N';
    Cadastro.FieldByName('C_IND_FER').AsString := 'N';
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesPremer.CadastraProdutoPrincipal(VpaNomArquivo : String;VpaProdutos : TStringList):String;
var
  VpfDProduto : TRBDProduto;
begin
  VpaNomArquivo := UpperCase(VpaNomArquivo);
  VpaNomArquivo := RetornaNomeSemExtensao(VpaNomArquivo);
  VpfDProduto := TRBDProduto.Cria;
  VpfDProduto.CodEmpresa := varia.CodigoEmpresa;
  VpfDProduto.CodEmpFil := varia.CodigoEmpFil;
  AtualizaStatus('Cadastrando o produto principal "'+VpaNomArquivo+'"');

  CarNomeProdutoPrincipal(VpfDProduto,VpaNomArquivo);

  if FunProdutos.ExisteCodigoProduto(VpfDProduto.SeqProduto,VpfDProduto.CodProduto,VpfDProduto.NomProduto) then
    FunProdutos.CarDProduto(VpfDProduto)
  else
  begin
    CarNomeProdutoPrincipal(VpfDProduto,VpaNomArquivo);
  end;

  VpfDProduto.CodMoeda := Varia.MoedaBase;
  VpfDProduto.CodUnidade :=  'PC';
  VpfDProduto.CodClassificacao :=RCodClassificacaoProdutoPrincipal(VpfDProduto.CodProduto);
  VpfDProduto.IndProdutoAtivo := true;
  VpfDProduto.NumDestinoProduto := dpProdutoAcabado;
  Result := FunProdutos.GravaDProduto(VpfDProduto);
  if result = '' then
  begin
    result := FunProdutos.InsereProdutoEmpresa(Varia.CodigoEmpresa,VpfDProduto.SeqProduto);
    if result = '' then
      result := FunProdutos.AdicionaProdutoNaTabelaPreco(Varia.TabelaPreco,VpfDProduto,0,0);
  end;
  VpaProdutos.Add(IntToStr(VpfDProduto.SeqProduto));
  LimpaConsumo(VpfDProduto.SeqProduto);
  VpfDProduto.free;
end;

{******************************************************************************}
procedure TRBFuncoesPremer.CarNomeProdutoPrincipal(VpaDProduto: TRBDProduto; VpaNomArquivo: String);
begin
  if (varia.CNPJFilial = CNPJ_Premer) or
     (varia.CNPJFilial = CNPJ_HALF) then
  begin
    VpaDProduto.NomProduto := RetiraAcentuacao(CopiaAteChar(VpaNomArquivo,'-'));
    VpaDProduto.CODProduto :=UpperCase(DeletaCharD(DeleteAteChar(VpaNomArquivo,' '),' '));
  end
  else
    if (varia.CNPJFilial = CNPJ_PERFOR) or
       (varia.CNPJFilial = CNPJ_MAQMUNDI) or
       (varia.CNPJFilial = CNPJ_MIGRAMAQ) then
    begin
      VpaDProduto.CODProduto :=UpperCase(DeletaEspacoD(CopiaAteChar(VpaNomArquivo,'-')));
      VpaDProduto.NomProduto := RetiraAcentuacao(DeletaEspacoE(DeleteAteChar(VpaNomArquivo,'-')));
    end;
end;

{******************************************************************************}
function TRBFuncoesPremer.CadastraProduto(VpaLinha : String;VpaDProduto : TRBDProduto):String;
begin
  result := '';
  VpaDProduto.CodEmpresa := varia.CodigoEmpresa;
  VpaDProduto.CodEmpFil := varia.CodigoEmpFil;
  VpaDProduto.CodClassificacao := '';
  VpaDProduto.CodProduto := '';
  VpaLinha := DeleteAteChar(VpaLinha,';');
  VpaLinha := DeletaEspacoE(VpaLinha);
  VpaDProduto.CodProduto := UpperCase(CopiaAteChar(VpaLinha,';'));
  if FunProdutos.ExisteCodigoProduto(VpaDProduto.SeqProduto,VpaDProduto.CodProduto,VpaDProduto.NomProduto) then
    FunProdutos.CarDProduto(VpaDProduto)
  else
  begin
    VpaDProduto.CodProduto := UpperCase(CopiaAteChar(VpaLinha,';'));
    if PrimeiraParteDoCodigoENumero(VpaDProduto.CodProduto) then
      if FunProdutos.ExisteNomeProduto(VpaDProduto.SeqProduto,RetiraAcentuacao(UpperCase(LimpaAspasdoNome(CopiaAteChar(DeleteAteChar(VpaLinha,';'),';'))))) then
        FunProdutos.CarDProduto(VpaDProduto);
  end;
  if VpaDProduto.CodProduto = '' then
    VpaDProduto.CodProduto := UpperCase(CopiaAteChar(VpaLinha,';'));
  VpaLinha := DeleteAteChar(VpaLinha,';');
  VpaDProduto.NomProduto := SubstituiStr(RetiraAcentuacao(UpperCase(LimpaAspasdoNome(CopiaAteChar(VpaLinha,';')))),#$9D,'DIAM ');
  if VpaDProduto.NomProduto = '' then
    VpaDProduto.NomProduto := VpaDProduto.CodProduto;
  AtualizaStatus('Cadastrando Produto "'+VpaDProduto.NomProduto+'"');

  VpaDProduto.NumDestinoProduto := dpSubProduto;
  VpaDProduto.CodMoeda := Varia.MoedaBase;
  VpaDProduto.CodUnidade :=  'PC';
  if VpaDProduto.CodClassificacao = '' then
    VpaDProduto.CodClassificacao :=RCodClassificacaoProduto(VpaDProduto);
  VpaDProduto.IndProdutoAtivo := true;
  Result := FunProdutos.GravaDProduto(VpaDProduto);
  if result = '' then
  begin
    result := FunProdutos.InsereProdutoEmpresa(Varia.CodigoEmpresa,VpaDProduto.SeqProduto);
    if result = '' then
      result := FunProdutos.AdicionaProdutoNaTabelaPreco(Varia.TabelaPreco,VpaDProduto,0,0);
  end;
  LimpaConsumo(VpaDProduto.SeqProduto);
  LimpaEstagios(VpaDProduto.SeqProduto);
  if result = '' then
  begin
    VpaLinha := DeleteAteChar(VpaLinha,';');
    result := AssociaMateriaPrima(VpaLinha,VpaDProduto);
    if result = '' then
      result := AssociaEstagiosProduto(VpaDProduto.SeqProduto,VpaDProduto.CodProduto,VpaLinha);
  end;
end;

{******************************************************************************}
function TRBFuncoesPremer.AssociaMateriaPrima(VpaLinha : String;VpaDProduto : TRBDProduto):String;
var
  VpfSeqProduto : Integer;
  VpfNomProduto,VpfCodProduto, VpfDimensoes, VpfQtd, VpfAux : string;
begin
  result := '';
  VpfNomProduto := RetiraAcentuacao(UpperCase(CopiaAteChar(VpaLinha,';')));
  VpaLinha := DeleteAteChar(VpaLinha,';');
  VpfDimensoes := CopiaAteChar(VpaLinha,';');
  VpfDimensoes := DeletaChars(VpfDimensoes,' ');
  VpfDimensoes := UpperCase(VpfDimensoes);
  VpfDimensoes := DeletaChars(DeletaChars(VpfDimensoes,'M'),'-');
  if (DeletaChars(DeletaChars(VpfNomProduto,'-'),' ') <> '') and
     (VpfDimensoes <> '') then
  begin
    if VpfNomProduto[1] = '"' then
      VpfNomProduto := UpperCase(Copy(VpfNomProduto,2,length(VpfNomProduto)));
    if (VpfNomProduto[length(VpfNomProduto)] = '"') and (VpfNomProduto[length(VpfNomProduto)-1] = '"') then
      VpfNomProduto := Copy(VpfNomProduto,1,length(VpfNomProduto)-1);
    if (VpfNomProduto[length(VpfNomProduto)] = '"') and (VpfNomProduto[length(VpfNomProduto)-1] = '"') then
      VpfNomProduto := Copy(VpfNomProduto,1,length(VpfNomProduto)-1);
    VpfNomProduto := RetiraAcentuacao(VpfNomProduto);

    if Config.NaImportacaodoSolidWorkAMateriaPrimabuscarPeloCodigo then
    begin
      VpfCodProduto := VpfNomProduto;
      if not FunProdutos.ExisteCodigoProduto(VpfSeqProduto,VpfCodProduto,vpfAux)then
        result := 'CÓDIGO "'+VpfNomProduto+'" NÃO EXISTE CADASTRADO NO SISTEMA!!!!!'#13'É necessário cadastrar o codigo do sistema antes da importação';
    end
    else
      if not FunProdutos.ExisteNomeProduto(VpfSeqProduto,VpfNomProduto)then
        VpfSeqProduto := CadastraMateriaPrima(VpfNomPRODUTO,VpfDimensoes);
    if result = '' then
    begin
      AdicionaSQLAbreTabela(Cadastro,'Select * from MOVKIT '+
                                     ' Where I_PRO_KIT = 0 AND I_SEQ_MOV = 0 AND I_COR_KIT = 0 ');
      Cadastro.insert;
      Cadastro.FieldByname('I_PRO_KIT').AsInteger := VpaDProduto.SeqProduto;
      Cadastro.FieldByname('I_SEQ_PRO').AsInteger := VpfSeqProduto;
      Cadastro.FieldByname('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
      Cadastro.FieldByname('D_ULT_ALT').AsDateTime := now;
      Cadastro.FieldByname('I_COR_KIT').AsInteger := 0;
      Cadastro.FieldByname('I_COD_COR').AsInteger := 0;

      if ContaLetra(VpfDimensoes,'X') = 0 then // Refil Aco colocar o comprimento;
      begin
        Cadastro.FieldByname('C_COD_UNI').AsString := 'CM';
        Cadastro.FieldByname('N_QTD_PRO').AsFloat := RMedidaComPerda(VpfDimensoes);
      end
      else
        if ContaLetra(VpfDimensoes,'X') = 1 then // chapa de aco;
        begin
          Cadastro.FieldByname('C_COD_UNI').AsString := 'KG';
          Cadastro.FieldByname('N_QTD_PRO').AsFloat := 1;
          Cadastro.FieldByname('I_LAR_MOL').AsFloat := RMedidaComPerda(CopiaAteChar(VpfDimensoes,'X'));
          VpfDimensoes := DeleteAteChar(VpfDimensoes,'X');
          Cadastro.FieldByname('I_ALT_MOL').AsFloat := RMedidaComPerda(VpfDimensoes);
        end
        else
        begin
          Cadastro.FieldByname('C_COD_UNI').AsString := 'CM';
          Cadastro.FieldByname('N_QTD_PRO').AsFloat := 1;
        end;

      Cadastro.FieldByName('I_SEQ_MOV').AsInteger := RSeqConsumoDisponivel(VpaDProduto.SeqProduto,0);
      Cadastro.post;
      if Cadastro.AErronaGravacao then
        result := 'ERRO NA GRAVAÇÃO DO CONSUMO DO PRODUTO!!!'+#13+Cadastro.AMensagemErroGravacao;
      Cadastro.close;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesPremer.AssociaEstagiosProduto(VpaSeqProduto : Integer;VpaCodProduto, VpaLinha : String) : string;
begin
  if (varia.CNPJFilial = CNPJ_Premer)or
     (varia.CNPJFilial = CNPJ_HALF) then
    result := AssociaEstagiosProdutoPremer(VpaSeqProduto,VpaCodProduto)
  else
    if (varia.CNPJFilial = CNPJ_PERFOR) then
      AssociaEstagiosProdutoPerfor(VpaSeqProduto,VpaLinha);
end;

{******************************************************************************}
function TRBFuncoesPremer.AssociaEstagiosProdutoPerfor(VpaSeqProduto: Integer; VpaLinha: String): string;
var
  VpfEstagio : string;
begin
  result := '';
  VpaLinha := DeleteAteChar(VpaLinha,';');
  VpaLinha := DeleteAteChar(VpaLinha,';');
  VpaLinha := DeleteAteChar(VpaLinha,';');
  VpaLinha := DeletaChars(VpaLinha,' ');
  while Vpalinha <> '' do
  begin
    VpfEstagio := DeletaChars(Uppercase(CopiaAteChar(VpaLinha,'-')),' ');
    VpaLinha := DeleteAteChar(VpaLinha,'-');
    if VpfEstagio = 'INTERNO' then
      AdicionaEstagioProduto(VpaSeqProduto,120)
    else
      if VpfEstagio = 'LASER' then
        AdicionaEstagioProduto(VpaSeqProduto,130)
      else
        if VpfEstagio = 'CORTEAAGUA' then
          AdicionaEstagioProduto(VpaSeqProduto,140)
      else
        if VpfEstagio = 'DOBRA' then
          AdicionaEstagioProduto(VpaSeqProduto,150)
        else
          if VpfEstagio = 'USINAGEM' then
            AdicionaEstagioProduto(VpaSeqProduto,160)
          else
            aviso('ESTAGIO NÃO CADASTRADO!!!'#13'O estágio "'+VpfEstagio+'" não existe cadastrado.');
  end;
end;

{******************************************************************************}
function TRBFuncoesPremer.AssociaEstagiosProdutoPremer(VpaSeqProduto: Integer; VpaCodProduto: String): string;
begin
  result := '';
  if (ContaLetra(UpperCase(VpaCodProduto),'-') >1) then
  begin
    VpaCodProduto := DeleteAteChar(VpaCodProduto,'-');
    VpaCodProduto := DeleteAteChar(VpaCodProduto,'-');
    if VpaCodProduto <>'' then
    begin
      result := AdicionaEstagioTipoCorte(VpaSeqProduto,VpaCodProduto[1]);
      if result = '' then
      begin
        VpaCodProduto := copy(VpaCodProduto,2,length(VpaCodProduto)-1);
        while (VpaCodProduto <> '')and (Result = '') do
        begin
          result := AdicionaEstagioSegundoProcesso(VpaSeqProduto,copy(VpaCodProduto,1,4));
          if Copy(VpaCodProduto,2,1) = '-' then
            VpaCodProduto := copy(VpaCodProduto,5,length(VpaCodProduto)-4)
          else
            VpaCodProduto := copy(VpaCodProduto,2,length(VpaCodProduto)-1)
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesPremer.CadastraMateriaPrima(VpaNomeProduto, VpaDimensoes : String):Integer;
var
  VpfDProduto : TRBDProduto;
begin
  VpfDProduto := TRBDProduto.Cria;
  VpfDProduto.CodEmpresa := varia.CodigoEmpresa;
  VpfDProduto.CodEmpFil := varia.CodigoEmpFil;
  if (Varia.CNPJFilial = CNPJ_Premer) or
     (Varia.CNPJFilial = CNPJ_HALF) then
    VpfDProduto.CodClassificacao :='0302'
  else
    if Varia.CNPJfilial = CNPJ_PERFOR then
      VpfDProduto.CodClassificacao :='60';
  VpfDProduto.CodProduto := FunProdutos.ProximoCodigoProduto(VpfDProduto.CodClassificacao,length(Varia.MascaraPro));
  VpaNomeProduto := SubstituiStr(VpaNomeProduto,#8364,'C');
  VpfDProduto.NumDestinoProduto := dpMateriaPrima;
  VpfDProduto.NomProduto := VpaNomeProduto;
  VpfDProduto.CodMoeda := Varia.MoedaBase;
  if ContaLetra(VpaDimensoes,'X') = 0 then // Refil Aco colocar o comprimento;
  begin
    VpfDProduto.CodUnidade := 'BR';
    VpfDProduto.QtdUnidadesPorCaixa := 6;
  end
  else
    VpfDProduto.CodUnidade := 'KG';
  VpfDProduto.IndProdutoAtivo := true;
  FunProdutos.GravaDProduto(VpfDProduto);
  Result := VpfDProduto.SeqProduto;
  FunProdutos.InsereProdutoEmpresa(Varia.CodigoEmpresa,VpfDProduto.SeqProduto);
  FunProdutos.AdicionaProdutoNaTabelaPreco(Varia.TabelaPreco,VpfDProduto,0,0);
  LimpaConsumo(VpfDProduto.SeqProduto);
  VpfDProduto.free;
end;

{******************************************************************************}
procedure TRBFuncoesPremer.AtualizaStatus(VpaTexto : String);
begin
  VprLabel.Caption := AdicionaCharD(' ',VprNivel+'  '+ VpaTexto,50);
  VprLabel.Refresh;
end;

{******************************************************************************}
function TRBFuncoesPremer.ImportaProjeto(VpaNomArquivo : String;VpaProgresso : TGauge;VpaStatus : TLabel) : String;
var
  VpfArquivo, VpfProdutos : TStringList;
  VpfLaco, VpfNivel, VpfQtdCamposExcel : Integer;
  VpfLinha : String;
  VpfDProduto : TRBDProduto;
  VpfCaracterInvalido : Boolean;
begin
  VprLabel := VpaStatus;
  VpfArquivo := TStringList.Create;
  VpfProdutos := TStringList.Create;
  VpfArquivo.LoadFromFile(VpaNomArquivo);
  VpfArquivo.Delete(0);
  VpaProgresso.MaxValue := VpfArquivo.Count;
  VpaProgresso.Progress := 0;
  if (Varia.CNPJFilial = CNPJ_PERFOR) then
    VpfQtdCamposExcel := 6
  else
    VpfQtdCamposExcel := 5;

  result := CadastraProdutoPrincipal(VpaNomArquivo,VpfProdutos);
  VpaProgresso.Progress :=   VpaProgresso.Progress +1;
  if result = '' then
  begin
    for VpfLaco := 0 to VpfArquivo.Count - 1 do
    begin
      VpaProgresso.Progress :=   VpaProgresso.Progress +1;
      if VpfCaracterInvalido then
        VpfLinha := VpfLinha + VpfArquivo.Strings[VpfLaco]
      else
        VpfLinha := VpfArquivo.Strings[VpfLaco];
      if (ContaLetra(VpfLinha,';') < VpfQtdCamposExcel) then
      begin
        VpfCaracterInvalido := true;
        continue;
      end;
      VpfLinha := UpperCase(VpfLinha);
      VpfCaracterInvalido := false;
      VprNivel := CopiaAteChar(VpfLinha,';');
      if VpfLinha <> '' then
      begin
        VpfDProduto := TRBDProduto.Cria;
        Result := CadastraProduto(VpfLinha,VpfDProduto);
        if result = '' then
        begin
          VpfNivel := ContaLetra(CopiaAteChar(SubstituiStr(VpfLinha,',','.'),';'),'.')+1;
          VpfProdutos.Insert(VpfNivel,IntToStr(VpfDProduto.SeqProduto));
          AtualizaStatus('Adicionando o consumo do produto "'+VpfDProduto.NomProduto+'"');
          result := AdicionaConsumoProduto(StrToInt(VpfProdutos.Strings[VpfNivel-1]),VpfDProduto.SeqProduto,VpfLinha);
        end;
        VpfDProduto.free;
        if result <> '' then
          break;
      end;
    end;
  end;

  VpfProdutos.free;
  VpfArquivo.free;
end;

end.
