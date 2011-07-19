Unit UnZebra;

Interface

Uses Classes, DBTables, UnDadosProduto, SysUtils, Tabela;

//classe localiza
Type TRBLocalizaZebra = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type
 TRBTipoLinguagemZebra =(lzEPL, lzZPL);
 TRBFuncoesZebra = class(TRBLocalizaZebra)
  private
    VprArquivo : TextFile;
    VprTipoLinguagem : TRBTipoLinguagemZebra;
  public
    constructor cria(VpaPorta : String;VpaAlturaEtiqueta : integer; VpaTipoLinguagem : TRBTipoLinguagemZebra; VpaDistanciaEntre : Integer = 24);
    destructor destroy;override;
    procedure ImprimeTexto(VpaPosicaoX, VpaPosicaY,VpaRotacao, VpaFonte, VpaTamanhoFonteHorizontal, VaTamanhoFonteVertical : Integer;
                           VpaIndReverso : Boolean;VpaTexto : String);
    procedure ImprimeFigura(VpaPosicaoX, VpaPosicaY : Integer;VpaTexto : String);
    procedure ImprimeCodigoBarras(VpaPosicaoX, VpaPosicaY,VpaRotacao: Integer; VpaTipoCodBarras : String;VpaEspacamentoCodBarras, VpaLarguraCodBarras, VpaAlturaCodBarras : Integer;
                           VpaIndImprimeNumero : Boolean;VpaTexto : String);
    procedure ResetaImpressora;
    procedure ResetaImpressora2;
    procedure ImprimeConfiguracao;
    procedure FechaImpressao;
    function ImprimeEtiquetaProduto33X22(VpaEtiquetas : TList) : Integer;
    function ImprimeEtiquetaProduto33X57(VpaEtiquetas : TList) : Integer;
    procedure ImprimeEtiquetaPrateleira33X22(VpaPrateleiras : TStringList);
    procedure ImprimeEtiquetaIdentificaChapa33X22(VpaTabela : TSql);
    procedure ImprimeEtiquetaProdutoOP33X22(VpaEtiquetas : TList);
end;



implementation

Uses FunSql, FunString, Constantes;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaZebra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaZebra.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesZebra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesZebra.cria(VpaPorta : String;VpaAlturaEtiqueta : integer;VpaTipoLinguagem : TRBTipoLinguagemZebra;VpaDistanciaEntre : Integer = 24);
begin
  //altura da etiqueta em Dots 1 mm = 8 dots
  //geralmente a separacao entre as entiquetas possui 3 mm = 24 dots
  inherited create;
  VprTipoLinguagem := VpaTipoLinguagem;
  AssignFile(VprArquivo,VpaPorta);
  Rewrite(VprArquivo);
  if VpaTipoLinguagem = lzEPL then
  BEGIN
    Writeln(VprArquivo,'N');
    Writeln(VprArquivo,'Q'+intToStr(VpaAlturaEtiqueta)+','+IntToStr(VpaDistanciaEntre));
    Writeln(VprArquivo,'D13');
  END
  else
    if VpaTipoLinguagem = lzZPL then
    BEGIN
      Writeln(VprArquivo,'^XA');
      Writeln(VprArquivo,'^LH10,10');
    END;

end;

{******************************************************************************}
destructor TRBFuncoesZebra.destroy;
begin
  CloseFile(VprArquivo);
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesZebra.ImprimeTexto(VpaPosicaoX, VpaPosicaY,VpaRotacao, VpaFonte, VpaTamanhoFonteHorizontal, VaTamanhoFonteVertical : Integer;
                           VpaIndReverso : Boolean;VpaTexto : String);
var
  vpfComando : String;
begin
  if VprTipolinguagem = lzEPL then
  begin
    VpaTexto := SubstituiStr(VpaTexto,'"','''');
    VpfComando :=  'A'+intToStr(VpaPosicaoX)+','+IntToStr(VpaPosicaY)+','+IntToStr(VpaRotacao)+','+IntToStr(VpaFonte)+','+
                 IntToStr(VpaTamanhoFonteHorizontal)+','+IntToStr(VaTamanhoFonteVertical);
    if  VpaIndReverso then
      vpfComando := vpfComando + ',R'
    else
      VpfComando := vpfComando + ',N';
    vpfComando := vpfComando+',"'+RetiraAcentuacao(VpaTexto)+'"';
  end
  else
    if VprTipolinguagem = lzZPL then
    begin
      VpfComando :=  '^FO'+intToStr(VpaPosicaoX)+','+IntToStr(VpaPosicaY);
      case VpaFonte  of
        1 : VpfComando :=  VpfComando +'^A0';
      end;
      if VpaRotacao = 90 then
        VpfComando := VpfComando +'R';

      VpfComando := VpfComando +','+IntToStr(VpaTamanhoFonteHorizontal)+','+IntToStr(VaTamanhoFonteVertical);
      VpfComando := VpfComando +'^FD'+VpaTexto +'^FS';
    end;
  writeLn(VprArquivo,VpfComando);
end;

{******************************************************************************}
procedure TRBFuncoesZebra.ImprimeCodigoBarras(VpaPosicaoX, VpaPosicaY,VpaRotacao: Integer; VpaTipoCodBarras : String;VpaEspacamentoCodBarras, VpaLarguraCodBarras, VpaAlturaCodBarras : Integer;
                           VpaIndImprimeNumero : Boolean;VpaTexto : String);
Var
  VpfComando : String;
begin
  if VprTipolinguagem = lzEPL then
  begin
    VpaTexto := SubstituiStr(VpaTexto,'"','''');
    VpfComando :=  'B'+intToStr(VpaPosicaoX)+','+IntToStr(VpaPosicaY)+','+IntToStr(VpaRotacao)+','+VpaTipoCodBarras+','+
                 IntToStr(VpaEspacamentoCodBarras)+','+IntToStr(VpaLarguraCodBarras)+','+IntToStr(VpaAlturaCodBarras);
    if VpaIndImprimeNumero then
      vpfComando := vpfComando + ',B'
    else
      VpfComando := vpfComando + ',N';
    vpfComando := vpfComando+',"'+VpaTexto+'"';
  end
  else
    if VprTipolinguagem = lzZPL then
    begin
      VpfComando :=  '^FO'+intToStr(VpaPosicaoX)+','+IntToStr(VpaPosicaY);
      if  VpaTipoCodBarras = '1' then //ean 13
        VpfComando :=  VpfComando +'^BE';
      if VpaRotacao = 90 then
        VpfComando := VpfComando +'R';

      VpfComando := VpfComando +','+IntToStr(VpaAlturaCodBarras);
      if VpaIndImprimeNumero  then
        VpfComando := VpfComando +',Y,N'
      else
        VpfComando := VpfComando +',N,N';
      VpfComando := VpfComando +'^FD'+VpaTexto+'^FS';
    end;
  writeLn(VprArquivo,VpfComando);
end;

{******************************************************************************}
procedure TRBFuncoesZebra.ImprimeFigura(VpaPosicaoX, VpaPosicaY : Integer;VpaTexto : String);
Var
  VpfComando, VpfNomImagem : String;
begin
  if VprTipolinguagem = lzZPL then
  begin
    VpfComando :=  VpaTexto;
    VpfNomImagem := DeleteAteChar(CopiaAteChar(VpaTexto,','),':');
    VpfComando := VpfComando +'^FO'+IntToStr(VpaPosicaoX)+','+IntToStr(VpaPosicaY)+'^XGR:'+VpfNomImagem+'.GRF^FS';
  end;
  writeLn(VprArquivo,VpfComando);
end;

{******************************************************************************}
procedure TRBFuncoesZebra.FechaImpressao;
begin
  if VprTipoLinguagem = lzEPL then
  begin
    Writeln(VprArquivo,'P1');
    Writeln(VprArquivo,'N');
  end
  else
    if VprTipoLinguagem = lzZPL then
    begin
      Writeln(VprArquivo,'^XZ');
      Writeln(VprArquivo,'^XA');
      Writeln(VprArquivo,'^LH10,10');
    end;

end;


{******************************************************************************}
procedure TRBFuncoesZebra.ImprimeEtiquetaIdentificaChapa33X22(VpaTabela: TSql);
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfNomProduto : String;
begin
  VpfColuna := 0;
  VpaTabela.First;
  while not VpaTabela.eof do
  begin
    VpfPosicaoX := VpfColuna * 265;
    ImprimeTexto(VpfPosicaoX+40,10,0,1,2,2,false,copy(VpaTabela.FieldByName('C_NOM_PRO').AsString,1,12));
    if Length(VpaTabela.FieldByName('C_NOM_PRO').AsString) > 12 then
      ImprimeTexto(VpfPosicaoX+40,40,0,1,2,2,false,copy(VpaTabela.FieldByName('C_NOM_PRO').AsString,13,12));
    if Length(VpaTabela.FieldByName('C_NOM_PRO').AsString) > 24 then
      ImprimeTexto(VpfPosicaoX+40,60,0,1,1,1,false,copy(VpaTabela.FieldByName('C_NOM_PRO').AsString,26,12));
    ImprimeTexto(VpfPosicaoX+40,80,0,1,1,1,false,'Largura');
    ImprimeTexto(VpfPosicaoX+150,80,0,1,1,1,false,'Comprimento');
    ImprimeTexto(VpfPosicaoX+40,100,0,1,2,2,false,VpaTabela.FieldByName('LARCHAPA').AsString+'X' );
    ImprimeTexto(VpfPosicaoX+150,100,0,1,2,2,false,VpaTabela.FieldByName('COMCHAPA').AsString);
    ImprimeTexto(VpfPosicaoX+40,140,0,1,1,1,false,'Sequencial');
    ImprimeTexto(VpfPosicaoX+140,130,0,1,2,2,false,VpaTabela.FieldByName('SEQCHAPA').AsString);
    inc(VpfColuna);
    if VpfColuna > 2 then
    begin
      FechaImpressao;
      VpfColuna := 0;
    end;
    Vpatabela.next;
  end;
  if VpfColuna > 0 then
     FechaImpressao;
end;

{******************************************************************************}
procedure TRBFuncoesZebra.ImprimeEtiquetaPrateleira33X22(VpaPrateleiras: TStringList);
Var
  VpfLaco, VpfQtdEtiqueta, VpfPosicaoX : Integer;
begin
  VpfQtdEtiqueta := -1;
  for VpfLaco := 0 to VpaPrateleiras.Count - 1 do
  begin
    inc(VpfQtdEtiqueta);
    VpfPosicaoX := VpfQtdEtiqueta * 265;
    if Length(VpaPrateleiras.Strings[VpfLaco]) = 1 then
      ImprimeTexto(VpfPosicaoX+55,0,0,4,8,8,false,VpaPrateleiras.Strings[VpfLaco])
    else
      if Length(VpaPrateleiras.Strings[VpfLaco]) = 2 then
        ImprimeTexto(VpfPosicaoX+50,20,0,3,8,8,false,VpaPrateleiras.Strings[VpfLaco])
      else
        if Length(VpaPrateleiras.Strings[VpfLaco]) > 2 then
          ImprimeTexto(VpfPosicaoX+30,50,0,4,5,5,false,VpaPrateleiras.Strings[VpfLaco]);
    if VpfQtdEtiqueta >= 2 then
    begin
      FechaImpressao;
      VpfQtdEtiqueta := -1;
    end;
  end;
  if (VpaPrateleiras.Count mod 3) <> 0 then
    FechaImpressao;
end;

{******************************************************************************}
function TRBFuncoesZebra.ImprimeEtiquetaProduto33X22(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfNomProduto : String;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 2 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 265;
        ImprimeTexto(VpfPosicaoX+40,10,0,1,2,2,false,copy(VpfDEtiqueta.Produto.CodProduto, 1,12));
        if Length(VpfDEtiqueta.Produto.CodProduto) > 12 then
          ImprimeTexto(VpfPosicaoX+45,35,0,1,2,2,false,copy(VpfDEtiqueta.Produto.CodProduto, 13,12));
        ImprimeTexto(VpfPosicaoX+40,60,0,1,1,1,false,copy(VpfDEtiqueta.Produto.NomProduto,1,25));
        if Length(VpfDEtiqueta.Produto.NomProduto) > 26 then
          ImprimeTexto(VpfPosicaoX+40,85,0,1,1,1,false,copy(VpfDEtiqueta.Produto.NomProduto,26,26));
        ImprimeTexto(VpfPosicaoX+190,110,0,1,1,1,false,'NF:'+IntTostr(VpfDEtiqueta.NumPedido));
        ImprimeTexto(VpfPosicaoX+190,125,0,1,1,1,false,FormatDateTime('DD/MM/YY',date));
        ImprimeTexto(VpfPosicaoX+190,140,0,1,1,1,false,'Localiz.:');
        ImprimeTexto(VpfPosicaoX+190,155,0,1,2,2,false,VpfDEtiqueta.Produto.PraProduto);
        ImprimeCodigoBarras(VpfPosicaoX+45,100,0,'2',2,4,40,true,AdicionaCharE('0',FloatToStr(VpfDEtiqueta.Produto.SeqProduto),8));
      end;
      if VpfColuna >= 2 then
      begin
        FechaImpressao;
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
     FechaImpressao;
  end;
end;

{******************************************************************************}
function TRBFuncoesZebra.ImprimeEtiquetaProduto33X57(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfNomProduto : String;
  VpfLaco : INteger;
  VpfDFigura : TRBDFiguraGRF;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 2 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 265;
        ImprimeCodigoBarras(VpfPosicaoX+220,70,90,'1',2,4,50,true,AdicionaCharE('0',VpfDEtiqueta.CodBarras,12));
        ImprimeTexto(VpfPosicaoX+165,30,90,1,22,22,false,'CNPJ : '+Varia.CNPJFilial);
        ImprimeTexto(VpfPosicaoX+145,30,90,1,22,22,false,'CODIGO : '+copy(VpfDEtiqueta.Produto.NomProduto,1,Pos('MM',VpfDEtiqueta.Produto.NomProduto)));
        ImprimeTexto(VpfPosicaoX+125,30,90,1,22,22,false,'COR : '+copy(AdicionaCharD(' ',IntToStr(VpfDEtiqueta.CodCor)+'-'+ VpfDEtiqueta.NomCor,17),1,17) +  ' - ' +FormatFloat('#,###,###,##0.##',VpfDEtiqueta.QtdProduto)+ ' '+VpfDEtiqueta.Produto.CodUnidade );
        ImprimeTexto(VpfPosicaoX+105,30,90,1,22,22,false,'COMP : '+VpfDEtiqueta.NomComposicao);
        for vpflaco := 0 to VpfDEtiqueta.Produto.FigurasComposicao.Count - 1 do
        begin
          VpfDFigura := TRBDFiguraGRF(VpfDEtiqueta.Produto.FigurasComposicao.Items[VpfLaco]);
          ImprimeFigura(VpfPosicaoX+40,(VpfLaco*85)+30,VpfDFigura.DesImagem);
        end;
        ImprimeTexto(VpfPosicaoX+10,30,90,1,22,22,false,'INDUSTRIA BRASILEIRA'+ '   '+VpfDEtiqueta.NumSerie);
{        ImprimeTexto(VpfPosicaoX+30,50,0,1,1,1,false,copy(VpfDEtiqueta.Produto.NomProduto,1,25));
        if Length(VpfDEtiqueta.Produto.NomProduto) > 26 then
          ImprimeTexto(VpfPosicaoX+30,75,0,1,1,1,false,copy(VpfDEtiqueta.Produto.NomProduto,26,26));
        ImprimeTexto(VpfPosicaoX+180,100,0,1,1,1,false,'NF:'+IntTostr(VpfDEtiqueta.NumPedido));
        ImprimeTexto(VpfPosicaoX+180,115,0,1,1,1,false,FormatDateTime('DD/MM/YY',date));
        ImprimeCodigoBarras(VpfPosicaoX+35,90,0,'2',2,4,40,true,AdicionaCharE('0',FloatToStr(VpfDEtiqueta.Produto.SeqProduto),8));}
      end;
      if VpfColuna >= 2 then
      begin
        FechaImpressao;
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
     FechaImpressao;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesZebra.ImprimeEtiquetaProdutoOP33X22(VpaEtiquetas: TList);
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfColuna : Integer;
  VpfDEtiquetaProduto : TRBDEtiquetaProdutoOP;
  VpfNomProduto : String;
begin
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiquetaProduto := TRBDEtiquetaProdutoOP(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    inc(VpfColuna);
    VpfPosicaoX := VpfColuna * 265;
    ImprimeCodigoBarras(VpfPosicaoX+45,10,0,'2',2,4,40,true,IntToStr(VpfDEtiquetaProduto.CodFilial)+ AdicionaCharE('0',IntToStr(VpfDEtiquetaProduto.SeqOrdemProducao),6)+ AdicionaCharE('0',FloatToStr(VpfDEtiquetaProduto.SeqProduto),6));
    ImprimeTexto(VpfPosicaoX+40,85,0,1,1,1,false,'Cod:'+copy(VpfDEtiquetaProduto.CodProduto, 1,20));
    if Length(VpfDEtiquetaProduto.CodProduto) > 20  then
      ImprimeTexto(VpfPosicaoX+80,100,0,1,1,1,false,copy(VpfDEtiquetaProduto.CodProduto, 21,20));
    ImprimeTexto(VpfPosicaoX+40,115,0,1,1,1,false,'Desc:'+copy(VpfDEtiquetaProduto.NomProduto,1,20));
    if Length(VpfDEtiquetaProduto.NomProduto) > 20 then
      ImprimeTexto(VpfPosicaoX+90,130,0,1,1,1,false,copy(VpfDEtiquetaProduto.NomProduto,21,26));
    ImprimeTexto(VpfPosicaoX+40,150,0,1,1,2,false,'OP:'+IntToStr(VpfDEtiquetaProduto.SeqOrdemProducao));
    ImprimeTexto(VpfPosicaoX+160,150,0,1,1,2,false,'Qtd:'+IntToStr(VpfDEtiquetaProduto.QtdProdutos));
    if VpfColuna >= 2 then
    begin
      FechaImpressao;
      VpfColuna := -1;
    end;
  end;
  if VpfColuna > -1 then
  begin
     FechaImpressao;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesZebra.ResetaImpressora;
begin
  Writeln(VprArquivo,'^@');
  FechaImpressao;
end;

{******************************************************************************}
procedure TRBFuncoesZebra.ResetaImpressora2;
begin
  Writeln(VprArquivo,'^default');
  FechaImpressao;
end;

{******************************************************************************}
procedure TRBFuncoesZebra.ImprimeConfiguracao;
begin
  Writeln(VprArquivo,'U');
  FechaImpressao;
end;


end.
