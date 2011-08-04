Unit UnNFe;
{Verificado
-.edit;
}
Interface

Uses Classes, SqlExpr, ACBrNFe, forms, pcnConversao,ComCtrls,ACBrNFeDANFEClass, ACBrNFeDANFERave,
  UnDadosProduto,pcnNFe, pcnAuxiliar, SysUtils, UnDados, IdAttachmentfile, idText,IdMessage, IdSMTP,
  UnSistema, Tabela,xmldom, XMLIntf, msxmldom, XMLDoc, unImpressaoBoleto, UnVersoes, Mapi;

//classe funcoes
Type TRBFuncoesNFe = class
  private
    VprStatusBar : TStatusBar;
    Aux : TSQLQuery;
    Cadastro : TSQL;
    VprMensagem : TidMessage;
    VprSMTP : TIdSMTP;
    FunImprimeBoleto : TImpressaoBoleto;
    function MontaHTML(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente):string;
    function MontaHTMLnfeCotabilidade : string;
    function AnexaNFE(VpaDNota : TRBDNotaFiscal):string;
    function AnexaNotasContabilidade(VpaNomArquivo : string):string;
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial) : string;
    procedure AtualizaStatus(VpaStatus : TStatusBar;VpaTexto : String);
    procedure HigienizaNaturezaOperacao(VpaCorrigidos : TStrings;VpaStatus : TStatusBar);
    procedure HigienizaPais(VpaErros : TStrings;VpaStatus : TStatusBar);
    procedure HigienizarCidades(VpaErros : TStrings;VpaStatus : TStatusBar);
    procedure HigienizarClientes(VpaErros,VpaCorrigidos : TStrings;VpaStatus : TStatusBar);
    function VerificacoesEmitente : String;
    function VerificacoesDestinatario(VpaDCliente : TRBDCliente):string;
    procedure CarDNotaNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDEmitenteNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDDestinatarioNfe(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente;VpaDNFe : TNFe);
    procedure CarDProdutoNfe(VpaDCliente : TRBDCliente; VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDServicosNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDTotalNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDTransporteNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarFaturas(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDObservacoesNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    function CarArquivoXMLNFE(VpaDNota : TRBDNotaFiscal) : String;
    procedure GeraNFEPDF(VpaDNota : TRBDNotaFiscal);
  public
    NFe : TACBrNFe;
    Danfe : TACBrNFeDANFERave;
    constructor cria(VpaBaseDados : TSQLConnection );
    destructor destroy;override;
    procedure MostraStatusOperacao(VpaObjeto : TObject);
    function VerificaStatusServico(VpaBarraStatus : TStatusBar) : String;
    function RUF(VpaCodFiscalMunicipio : String):String;
    function EmiteNota(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente;VpaBarraStatus : TStatusBar):string;
    function ImprimeDanfe(VpaDNota : TRBDNotaFiscal):String;
    function EnviaEmailDanfe(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente):String;
    function EnviaemailDanfePeloOutlook(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente):String;
    function CancelaNFE(VpaDNota : TRBDNotaFiscal;VpaMotivo : String):string;
    procedure HigienizarCadastros(VpaErros, VpaCorrigidos : TStrings;VpaStatus : TStatusBar);
    function InutilizaNumero(VpaCodFilial,VpaSeqNota, VpaNumNota : Integer):String;
    function VerificaseNotaFoiEnviadacomSucesso(VpaDNota : TRBDNotaFiscal):boolean;
    function ResolveproblemaComunicacao(VpaDNota : TRBDNotaFiscal):string;
    function EnviaEmailContabilidadeNfe(VpaARquivo, VpaEmail : string;VpaMes,VpaAno : Integer):string;
    procedure ConsultapelaChave(VpaChave : string) ;
    procedure GeraPDFXML(VpaArquivoXML : String);
    function NfeCanceladaSefaz(VpaDNota : TRBDNotaFiscal):boolean;
end;



implementation

Uses FunSql, Constantes, funString, Constmsg, UnNotaFiscal, UnClientes, FunValida, FunNumeros,
     FunArquivos, funData, APrincipal, UnProdutos;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesNFe
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesNFe.cria(VpaBaseDados : TSQLConnection );
begin
  inherited create;
  FunImprimeBoleto := TImpressaoBoleto.cria(VpaBaseDados);
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQlConnection := VpaBaseDados;
  NFe := TACBrNFe.Create(Application);
  NFe.OnStatusChange := MostraStatusOperacao;
  NFe.Configuracoes.Certificados.NumeroSerie := varia.CertificadoNFE;
  NFe.Configuracoes.Geral.Salvar := true;
  NFe.Configuracoes.Geral.PathSalvar := Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',DATE) ;
  NFe.Configuracoes.WebServices.IntervaloTentativas := 1;
  NFe.Configuracoes.WebServices.Tentativas := 10;

  if config.EmiteNFe then
  begin
    NFe.Configuracoes.WebServices.UF := Varia.UFSefazNFE;
    if config.NFEHomologacao then
      Nfe.Configuracoes.WebServices.Ambiente := taHomologacao
    else
      Nfe.Configuracoes.WebServices.Ambiente := taProducao;
    NFe.Configuracoes.WebServices.Visualizar := true;

    case Varia.FormaEmissaoNFE of
      feNormal : nfe.Configuracoes.Geral.FormaEmissao := teNormal;
      feScan   : NFe.Configuracoes.Geral.FormaEmissao := teSCAN;
    end;

  end;
  //componentes indy
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);
end;

{******************************************************************************}
destructor TRBFuncoesNFe.destroy;
begin
  NFE.free;
  Aux.Free;
  Cadastro.Free;
  VprMensagem.free;
  VprSMTP.free;
  FunImprimeBoleto.Free;
  inherited;
end;

{******************************************************************************}
function TRBFuncoesNFe.VerificacoesEmitente : String;
begin
  result := '';
  if Varia.CodIBGEMunicipio = 0  then
    result := 'CODIGO IBGE MUNICIPIO EMITENTE NÃO PREENCHIDO!!!'#13'É necessário importar os municipios com o codigo o IBGE, em seguida altere a filial entre e saia do campo cidade.';
end;

{******************************************************************************}
function TRBFuncoesNFe.VerificaseNotaFoiEnviadacomSucesso(VpaDNota: TRBDNotaFiscal): Boolean;
var
  VpfXMLDoc: TXMLDocument;
  VpfNode: IXMLNode;
  VpfAquivos : TStringList;
  VpfLaco : Integer;
  VpfChaveNFE : string;
  VpfDFilial : TRBDFilial;
begin


  result := false;
  NFe.WebServices.Consulta.Executar;
  VpfDFilial := TRBDFilial.cria;
  Sistema.CarDFilial(VpfDFilial,VpaDNota.CodFilial);
  VpfXMLDoc := TXMLDocument.Create(FPrincipal);
  VpfAquivos :=  RetornaListaDeArquivos(Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(VpfDFilial.DesCNPJ,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao),'*-pro-rec.xml');
  for vpflaco := 0 to VpfAquivos.Count - 1 do
  begin
    try
      VpfXMLDoc.LoadFromFile(VpfAquivos.Strings[VpfLaco]); //Le Arquivo Recibo XML');
      VpfNode := VpfXMLDoc.DocumentElement.ChildNodes.FindNode('protNFe').ChildNodes.FindNode('infProt').ChildNodes.FindNode('chNFe');
      VpfChaveNFE := VpfNode.Text;
      if StrToInt(copy(VpfChaveNFE,26,9)) = VpaDNota.NumNota then
      begin
        if VpfXMLDoc.DocumentElement.ChildNodes.FindNode('protNFe').ChildNodes.FindNode('infProt').ChildNodes.FindNode('cStat').Text = '100' then
        begin
          VpaDNota.DesChaveNFE := VpfXMLDoc.DocumentElement.ChildNodes.FindNode('protNFe').ChildNodes.FindNode('infProt').ChildNodes.FindNode('chNFe').Text;
          VpaDNota.NumReciboNFE := VpfXMLDoc.DocumentElement.ChildNodes.FindNode('nRec').Text;
          VpaDNota.NumProtocoloNFE := VpfXMLDoc.DocumentElement.ChildNodes.FindNode('protNFe').ChildNodes.FindNode('infProt').AttributeNodes.Get(0).Text;
          VpaDNota.CodMotivoNFE := VpfXMLDoc.DocumentElement.ChildNodes.FindNode('protNFe').ChildNodes.FindNode('infProt').ChildNodes.FindNode('cStat').Text;
          VpaDNota.DesMotivoNFE := VpfXMLDoc.DocumentElement.ChildNodes.FindNode('protNFe').ChildNodes.FindNode('infProt').ChildNodes.FindNode('xMotivo').Text;
          result := true;
          break;
        end;
      end;
    except
    end;
  end;
  VpfAquivos.Free;
  VpfXMLDoc.Free;
end;

{******************************************************************************}
function TRBFuncoesNFe.VerificacoesDestinatario(VpaDCliente : TRBDCliente):string;
begin
  result := '';
  if VpaDCliente.CodIBGECidade = 0  then
    result := 'CODIGO IBGE MUNICIPIO DESTINATARIO NÃO PREENCHIDO!!!'#13'É necessário importar os municipios com o codigo o IBGE, em seguida altere o cliente entre e saia do campo cidade.';
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDNotaNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
begin
  VpaDNFe.infNFe.ID := InttoStr(VpaDNota.NumNota);
  VpaDNFe.Ide.natOp     := FunNotaFiscal.RNomNaturezaOperacao(VpaDNota.CodNatureza,VpaDNota.SeqItemNatureza);
  VpaDNFe.Ide.nNF       := VpaDNota.NumNota;
  VpaDNFe.Ide.cNF       := VpaDNota.SeqNota;
  VpaDNFe.Ide.modelo    := 55;
  VpaDNFe.Ide.serie     := StrToInt(VpaDNota.DesSerie);
  VpaDNFe.ide.dEmi      := VpaDNota.DatEmissao;
  VpaDNFe.Ide.dSaiEnt   := VpaDNota.DatSaida;
  VpaDNFe.Ide.dSaiEnt   := VpaDNota.DatSaida;
  VpaDNFe.exporta.UFembarq := VpaDNota.DesUFEmbarque;
  VpaDNFe.exporta.xLocEmbarq := VpaDNota.DesLocalEmbarque;
  case Varia.FormaEmissaoNFE of
      feNormal : VpaDNFe.Ide.tpEmis    := teNormal;
      feScan   :  VpaDNFe.Ide.tpEmis    := teSCAN;
  end;

  if config.NFEHomologacao then
    VpaDNFe.Ide.tpAmb     := taHomologacao
  else
    VpaDNFe.Ide.tpAmb     := taProducao;

  if VpaDNota.DesTipoNota = 'E' then
    VpaDNFe.Ide.tpNF      := tnEntrada
  else
    VpaDNFe.Ide.tpNF      := tnSaida;
  if (VpaDNota.CodCondicaoPagamento = Varia.CondPagtoVista) then
    VpaDNFe.Ide.indPag    := ipVista
  else
    if (VpaDNota.CodCondicaoPagamento = 0) then
      VpaDNFe.Ide.indPag := ipOutras
    else
      VpaDNFe.Ide.indPag    := ipPrazo;
  VpaDNFe.Ide.verProc   := VersaoFaturamento;
  VpaDNFe.Ide.cUF       := StrToInt(copy(IntToStr(varia.CodIBGEMunicipio),1,2));
  VpaDNFe.Ide.cMunFG    := Varia.CodIBGEMunicipio;
  VpaDNFe.Ide.finNFe := fnnormal;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDEmitenteNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
begin
  VpaDNFe.Emit.CNPJCPF           := varia.CNPJFilial;
  VpaDNFe.Emit.xNome             := varia.RazaoSocialFilial;
  VpaDNFe.Emit.xFant             := varia.NomeFilial;
  VpaDNFe.Emit.EnderEmit.xLgr    := Varia.EnderecoFilialSemNumero;
  VpaDNFe.Emit.EnderEmit.nro     := varia.NumEnderecoFilial;
//    VpaDNFe.Emit.EnderEmit.xCpl    := edtEmitComp.Text;
  VpaDNFe.Emit.EnderEmit.xBairro := varia.BairroFilial;
  VpaDNFe.Emit.EnderEmit.cMun    := varia.CodIBGEMunicipio;
  VpaDNFe.Emit.EnderEmit.xMun    := varia.CidadeFilial;
  VpaDNFe.Emit.EnderEmit.UF      := varia.UFFilial;
  VpaDNFe.Emit.EnderEmit.CEP     := StrToInt(Deletachars(varia.CepFilial,'-'));
  VpaDNFe.Emit.enderEmit.cPais   := 1058;
  VpaDNFe.Emit.enderEmit.xPais   := 'BRASIL';
  VpaDNFe.Emit.EnderEmit.fone := DeletaCharE(DeletaChars(DeletaChars(DeletaChars(DeletaChars(varia.FoneFilial,'-'),')'),'('),'*'),'0');
  VpaDNFe.Emit.IE                := Deletachars(Deletachars(Deletachars(varia.IEFilial,'.'),'/'),'-');
  VpaDNFe.Emit.IM                := Varia.InscricaoMunicipal;
  VpaDNFe.Emit.CNAE              := VARIA.CodCNAE;
  if CONFIG.SimplesFederal and not VpaDNota.IndNaturezaNotaDevolucao then
    VpaDNFe.Emit.CRT     := crtSimplesNacional
  else
    VpaDNFe.Emit.CRT     := crtRegimeNormal;
end;

{******************************************************************************}
function TRBFuncoesNFe.AnexaNFE(VpaDNota: TRBDNotaFiscal): string;
var
  VpfAnexo : TIdAttachmentfile;
  VpfNomArquivo, VpfNomPDF : String;
begin
  result := '';
   if ExisteArquivo(Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'-nfe.xml') and
       (VpaDNota.DesChaveNFE <> '') then
    VpfNomArquivo := Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'-nfe.xml'
  else
    if ExisteArquivo(Varia.PathVersoes+'\nfe\'+VpaDNota.DesChaveNFE+'-nfe.xml') and
       (VpaDNota.DesChaveNFE <> '') then
      VpfNomArquivo := VpaDNota.DesChaveNFE+'-nfe.xml'
    else
      if ExisteArquivo(Varia.PathVersoes+'\nfe\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'-nfe.xml') and
         (VpaDNota.DesChaveNFE <> '') then
        VpfNomArquivo := FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'-nfe.xml'
      else
        if ExisteArquivo(Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+IntToStr(VpaDNota.NumNota)+'-NFe.xml') then
          VpfNomArquivo := Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+IntToStr(VpaDNota.NumNota)+'-NFe.xml'
        else
          VpfNomArquivo := IntToStr(VpaDNota.NumNota)+'-NFe.xml';
  //PDF
  if  ExisteArquivo(Varia.PathVersoes+'\nfe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'.pdf') then
    VpfNomPDF := Varia.PathVersoes+'\nfe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'.pdf'
  else
    if  ExisteArquivo(Varia.PathVersoes+'\nfe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+SubstituiStr(UPPERCASE(NFe.NotasFiscais.Items[0].NFe.infNFe.ID),'NFE','') +'.pdf') then
      VpfNomPDF := Varia.PathVersoes+'\nfe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+SubstituiStr(UPPERCASE(NFe.NotasFiscais.Items[0].NFe.infNFe.ID),'NFE','') +'.pdf'
    ELSE
      result := 'Falta arquivo "'+Varia.PathVersoes+'\nfe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'.pdf';
  //LOG EFICACIA
  if not ExisteArquivo(varia.PathVersoes+'\efi.jpg') then
    result := 'Falta arquivo "'+varia.PathVersoes+'\efi.jpg'+'"';

  if result = '' then
  begin
    VpfAnexo := TIdAttachmentfile.Create(VprMensagem.MessageParts,VpfNomPDF);
    VpfAnexo.ContentType := 'application/pdf';
    VpfAnexo.ContentDisposition := 'inline';
    VpfAnexo.DisplayName:=RetornaNomArquivoSemDiretorio(VpfNomPDF);
    VpfAnexo.ExtraHeaders.Values['content-id'] := RetornaNomArquivoSemDiretorio(VpfNomPDF);;
    VpfAnexo.DisplayName := RetornaNomArquivoSemDiretorio(VpfNomPDF);;

    VpfAnexo := TIdAttachmentfile.Create(VprMensagem.MessageParts,VpfNomArquivo);
    VpfAnexo.ContentType := 'application/xml';
    VpfAnexo.ContentDisposition := 'inline';
    VpfAnexo.DisplayName:=VpfNomArquivo;
    VpfAnexo.ExtraHeaders.Values['content-id'] := VpfNomArquivo;
    VpfAnexo.DisplayName := VpfNomArquivo;
  end;
end;

{******************************************************************************}
function TRBFuncoesNFe.AnexaNotasContabilidade(VpaNomArquivo: string): string;
var
  VpfAnexo : TIdAttachmentfile;
begin
  result := '';
  VpfAnexo := TIdAttachmentfile.Create(VprMensagem.MessageParts,VpaNomArquivo);
  VpfAnexo.ContentType := 'application/zip';
  VpfAnexo.ContentDisposition := 'inline';
  VpfAnexo.DisplayName:=RetornaNomArquivoSemDiretorio(VpaNomArquivo);
  VpfAnexo.ExtraHeaders.Values['content-id'] := RetornaNomArquivoSemDiretorio(VpaNomArquivo);;
  VpfAnexo.DisplayName := RetornaNomArquivoSemDiretorio(VpaNomArquivo);;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.AtualizaStatus(VpaStatus: TStatusBar; VpaTexto: String);
begin
  VpaStatus.Panels[0].Text := VpaTexto;
  VpaStatus.Refresh;
end;

{******************************************************************************}
function  TRBFuncoesNFe.CarArquivoXMLNFE(VpaDNota: TRBDNotaFiscal):String;
var
  VpfDCliente : TRBDCliente;
begin
  result := '';
  NFe.Configuracoes.Geral.PathSalvar := Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao) ;
  if ExisteArquivo(Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'-nfe.xml') then
    NFe.NotasFiscais.LoadFromFile(Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'-nfe.xml')
  else
    if ExisteArquivo(Varia.PathVersoes+'\NFe\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+VpaDNota.DesChaveNFE+'-nfe.xml') then
      NFe.NotasFiscais.LoadFromFile(Varia.PathVersoes+'\NFe\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+VpaDNota.DesChaveNFE+'-nfe.xml')
    else
      if ExisteArquivo(Varia.PathVersoes+'\nfe\'+VpaDNota.DesChaveNFE+'-nfe.xml') then
        NFe.NotasFiscais.LoadFromFile(Varia.PathVersoes+'\nfe\'+VpaDNota.DesChaveNFE+'-nfe.xml')
      else
      begin
        VpfDCliente := TRBDCliente.cria;
        VpfDCliente.CodCliente := VpaDNota.CodCliente;
        FunClientes.CarDCliente(VpfDCliente);
        result := EmiteNota(VpaDNota,VpfDCliente,nil);
        NFe.NotasFiscais.SaveToFile;
      end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDDestinatarioNfe(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente; VpaDNFe : TNFe);
begin
  VpaDNFe.Dest.CNPJCPF           := VpaDCliente.CGC_CPF;
  VpaDNFe.Dest.xNome             := IntToStr(VpaDCliente.CodCliente)+'-'+ VpaDCliente.NomCliente;
  VpaDNFe.Dest.EnderDest.xLgr    := VpaDCliente.DesEndereco;
  if (VpaDCliente.NumEndereco = '0') or
     (DeletaChars(VpaDCliente.NumEndereco,' ') = '') then
    VpaDNFe.Dest.EnderDest.nro    := 'S/N'
  else
    VpaDNFe.Dest.EnderDest.nro     := VpaDCliente.NumEndereco;
  VpaDNFe.Dest.EnderDest.xCpl    := VpaDCliente.DesComplementoEndereco;
  VpaDNFe.Dest.EnderDest.xBairro := VpaDCliente.DesBairro;
  if VpaDCliente.TipoPessoa = 'E' then
  begin
    VpaDNFe.Dest.EnderDest.cMun    := 9999999;
    VpaDNFe.Dest.EnderDest.xMun    := 'EXTERIOR';
    VpaDNFe.Dest.EnderDest.UF      := 'EX';
  end
  else
  begin
    VpaDNFe.Dest.EnderDest.cMun    := VpaDCliente.CodIBGECidade;
    VpaDNFe.Dest.EnderDest.xMun    := VpaDCliente.DesCidade;
    VpaDNFe.Dest.EnderDest.UF      := VpaDCliente.DesUF;
    VpaDNFe.Dest.EnderDest.CEP     := strToInt(DeletaChars(VpaDCliente.CepCliente,'-'));
  end;
  VpaDNFe.Dest.EnderDest.cPais   := VpaDCliente.CodPais;
  VpaDNFe.Dest.EnderDest.xPais   := FunClientes.RNomPais(VpaDCliente.CodPais);

  VpaDNFe.Dest.EnderDest.Fone    := DeletaCharE(DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaDCliente.DesFone1,'-'),')'),'('),'*'),'0');
  if VpaDCliente.TipoPessoa = 'J' then
    VpaDNFe.Dest.IE                := Deletachars(Deletachars(Deletachars(VpaDCliente.InscricaoEstadual,'.'),'/'),'-')
  else
  begin
    if VpaDCliente.DesUF <> 'TO' then
      VpaDNFe.Dest.IE := 'ISENTO';
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDProdutoNfe(VpaDCliente : TRBDCliente; VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
var
  VpfDProduto : TRBDNotaFiscalProduto;
  VpfDProdutoPeca: TRBDProdutoClientePeca;
  VpfLaco, VpfLacoPeca : Integer;
  VpfCSTICMS,
  VpfTexto : String;
begin
  for Vpflaco := 0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDProduto :=  TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
    with VpaDNFe.Det.Add do
    begin
      infAdProd := VpfDProduto.DesAdicional;
      with Prod do
      begin
        nItem    := VpfLaco+1;
        if config.AlturadoProdutonaGradedaCotacao and (VpfDProduto.AltProdutonaGrade <> 0) then
        begin
          cProd := VpfDProduto.CodProduto+'/'+DeletaChars(FloatToStr(VpfDProduto.AltProdutonaGrade),',');
          xProd    := VpfDProduto.NomProduto+' Alt = '+FormatFloat('#,##0.00',VpfDProduto.AltProdutonaGrade);
        end
        else
        begin
          cProd := VpfDProduto.CodProduto;
          xProd    := VpfDProduto.NomProduto;
        end;
        if VpfDProduto.DesCor <> '' then
          xProd := xProd +' ('+IntToStr(VpfDProduto.CodCor)+'-'+ VpfDProduto.DesCor+')';
        if (config.numeroserieproduto) and (VpfDProduto.DesRefCliente <> '') then
          xProd := xProd +' - NS='+ VpfDProduto.DesRefCliente;
        if config.ImprimirClassificacaoProdutonaNota then
          xProd := xProd + '-'+FunProdutos.RNomeClassificacao(varia.CodigoEmpresa,VpfDProduto.CodClassificacaoProduto);

        NCM      := DeletaChars(DeletaChars(DeletaChars(VpfDProduto.CodClassificacaoFiscal,'.'),','),' ');
        if VpfDProduto.CodCFOP <> 0 then
          CFOP     := IntToStr(VpfDProduto.CodCFOP)
        else
          if VpaDNota.CFOPProdutoIndustrializacao <> 0 then
            CFOP     := IntToStr(VpaDNota.CFOPProdutoIndustrializacao)
          else
            CFOP     := VpaDNota.CodNatureza;
        uCom     := VpfDProduto.UM;
        qCom     := VpfDProduto.QtdProduto;
        vProd    := ArredondaDecimais(VpfDProduto.ValTotal,3);
        vUnCom   := VpfDProduto.ValUnitario;
        uTrib    := VpfDProduto.UM;
        qTrib    := VpfDProduto.QtdProduto;
        vUnTrib  := VpfDProduto.ValUnitario;
        vDesc    := VpfDProduto.ValDesconto;
        vFrete   := VpfDProduto.ValFrete;
        vOutro   := VpfDProduto.ValOutrasDespesas;
      end;
      with Imposto do
      begin
        with ICMS do
        begin
          if VpfDProduto.CodCST <> '' then
            VpfCSTICMS := copy(VpfDProduto.CodCST,2,2);
          if config.SimplesFederal and not VpaDNota.IndNaturezaNotaDevolucao then
          begin
            if VpfCSTICMS = '60' then
              CSOSN := csosn500
            else
              if VpfCSTICMS = '10' then
                CSOSN := csosn201
              else
                CSOSN := csosn101;

            vCredICMSSN := VpaDNota.ValICMSSuperSimples;
            pCredSN := VpaDNota.PerICMSSuperSimples;
          end;

          CST := cst00;
          if VpfDProduto.CodCST <> '' then
          begin
            if VpfCSTICMS = '10' then
            begin
              CST := cst10;
            end
            else
            if VpfCSTICMS = '20' then
              CST := cst20
            else
            if VpfCSTICMS = '30' then
              CST := cst30
            else
            if VpfCSTICMS = '40' then
              CST := cst40
            else
            if VpfCSTICMS = '41' then
              CST := cst41
            else
            if VpfCSTICMS = '45' then
              CST := cst45
            else
            if VpfCSTICMS = '50' then
              CST := cst50
            else
            if VpfCSTICMS = '51' then
              CST := cst51
            else
            if VpfCSTICMS = '60' then
              CST := cst60
            else
            if VpfCSTICMS = '70' then
              CST := cst70
            else
            if VpfCSTICMS = '80' then
              CST := cst80
            else
            if VpfCSTICMS = '81' then
              CST := cst81
            else
            if VpfCSTICMS = '90' then
              CST := cst90;
          end;

          case VpfDProduto.NumOrigemProduto of
            0 : orig        := oeNacional;
            1 : orig        := oeEstrangeiraImportacaoDireta;
            2 : orig        := oeEstrangeiraAdquiridaBrasil;
          end;
          ICMS.modBC  := dbiValorOperacao;
          ICMS.vBC    := VpfDProduto.ValBaseICMS;
          ICMS.pRedBC := ArredondaDecimais(VpfDProduto.PerReducaoUFBaseICMS,2);
          modBCST := dbisMargemValorAgregado;
          pMVAST := VpfDProduto.PerSubstituicaoTributaria;

          ICMS.vBCST := VpfDProduto.ValBaseICMSSubstituicao;
          vBCST := VpfDProduto.ValBaseICMSSubstituicao;
          ICMS.vICMSST := VpfDProduto.ValICMSSubtituicao;
          vICMSST := ICMS.vICMSST;
          pICMSST := VpfDProduto.PerICMS;
          ICMS.pICMS  := VpfDProduto.PerICMS;
          ICMS.vICMS  := VpfDProduto.ValICMS;
        end;
        if config.SimplesFederal and not VpaDNota.IndNaturezaNotaDevolucao then
        begin
          PIS.CST := pis99;
          COFINS.CST := cof99;
        end
        else
        begin
          IPI.CST := ipi00;
          if VpfDProduto.PerIPI <> 0 then
          begin
            IPI.vBC := ArredondaDecimais(VpfDProduto.ValTotal,2);
            IPI.vIPI := VpfDProduto.ValIPI;
            IPI.pIPI := VpfDProduto.PerIPI;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDServicosNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
var
  VpfDServico : TRBDNotaFiscalServico;
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDNota.Servicos.Count - 1 do
  begin
    VpfDServico := TRBDNotaFiscalServico(VpaDNota.Servicos.Items[VpfLaco]);
    with VpaDNFe.Det.Add do
    begin
      with Prod do
      begin
        nItem    := VpaDNota.Produtos.Count+ VpfLaco+1;
        cProd    := inttoStr(VpfDServico.CodServico);
        xProd    := VpfDServico.NomServico;
        if VpfDServico.DesAdicional <> '' then
          xProd := xProd +' - '+VpfDServico.DesAdicional;

        CFOP     := IntToStr(VpaDNota.CFOPServico);
        uCom     := 'SE';
        qCom     := VpfDServico.QtdServico;
        vProd    := VpfDServico.ValTotal;
        vUnCom   := VpfDServico.ValUnitario;
        uTrib    := 'SE';
        qTrib    := VpfDServico.QtdServico;
        vUnTrib  := VpfDServico.ValUnitario;
        NCM := '99';
      end;
      with Imposto do
      begin
        with ISSQN do
        begin
          ISSQN.vBC := VpfDServico.ValTotal;
          ISSQN.vAliq := VpfDServico.PerISSQN;
          ISSQN.vISSQN :=(VpfDServico.ValTotal*VpfDServico.PerISSQN)/100;
          ISSQN.cMunFG := Varia.CodIBGEMunicipio;
          ISSQN.cListServ := VpfDServico.CodFiscal;
          ISSQN.cSitTrib :=  ISSQNcSitTribNORMAL;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDTotalNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
begin
  with VpaDNFe.Total.ICMSTot do
  begin
    vBCST := VpaDNota.ValBaseICMSSubstituicao;
    vST := VpaDNota.ValICMSSubtituicao;
    vBC   := VpaDNota.ValBaseICMS;
    vICMS := VpaDNota.ValICMS;
    vProd := VpaDNota.ValTotalProdutosSemDesconto + VpaDNota.ValTotalServicos;
    vFrete := VpaDNota.ValFrete;
    vSeg :=  VpaDNota.ValSeguro;
    vOutro := VpaDNota.ValOutrasDepesesas;
    vDesc := 0;
    if VpaDNota.ValDescontoTroca <> 0  then
      vDesc := VpaDNota.ValDescontoTroca;
    if VpaDNota.ValDesconto < 0  then
      vOutro := vOutro + (VpaDNota.ValDesconto *-1)
    else
      if VpaDNota.ValDesconto > 0  then
        vDesc := VDesc + VpaDNota.ValDesconto;
    if VpaDNota.PerDesconto < 0  then
      vOutro := vOutro + (((vProd * VpaDNota.PerDesconto)/100) *-1)
    else
      if VpaDNota.PerDesconto > 0  then
      begin
        vDesc := vDesc + (((VpaDNota.ValTotalProdutos + VpaDNota.ValTotalServicos) * 100)/(100-VpaDNota.PerDesconto)) - (VpaDNota.ValTotalProdutos + VpaDNota.ValTotalServicos);
      end;
    vIPI := VpaDNota.ValTotalIPI;
    vNF := VpaDNota.ValTotal;
  end;
  with VpaDNFe.Total.ISSQNtot do
  begin
    vServ := VpaDNota.ValTotalServicos;
    vBC := VpaDNota.ValTotalServicos;
    vISS := VpaDNota.ValIssqn;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDTransporteNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
var
  VpfDTransportadora : TRBDCliente;
begin
  if VpaDNota.CodTipoFrete = 1 then
    VpaDNFe.Transp.modFrete := mfContaEmitente
  else
    VpaDNFe.Transp.modFrete := mfContaDestinatario;

  if VpaDNota.CodTransportadora <> 0  then
  begin
    VpfDTransportadora := TRBDCliente.cria;
    VpfDTransportadora.CodCliente := VpaDNota.CodTransportadora;
    FunClientes.CarDCliente(VpfDTransportadora);

    with VpaDNFe.Transp.Transporta do
    begin
      CNPJCPF := VpfDTransportadora.CGC_CPF;
      xNome := VpfDTransportadora.NomCliente;
      IE := VpfDTransportadora.InscricaoEstadual;
      xEnder := VpfDTransportadora.DesEndereco+','+VpfDTransportadora.NumEndereco;
      xMun := VpfDTransportadora.DesCidade;
      UF := VpfDTransportadora.DesUF;
    end;
    VpfDTransportadora.free;
    VpaDNFe.Transp.veicTransp.placa := DeletaChars(VpaDNota.DesPlacaVeiculo,' ');
    VpaDNFe.Transp.veicTransp.UF := VpaDNota.DesUFPlacaVeiculo;
    with VpaDNFe.Transp.Vol.Add do
    begin
      qVol := VpaDNota.QtdEmbalagem;
      esp :=  VpaDNota.DesEspecie;
      marca := VpaDNota.DesMarcaEmbalagem;
      nVol := VpaDNota.NumEmbalagem;
      pesoL := VpaDNota.PesLiquido;
      pesoB := VpaDNota.PesBruto;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarFaturas(VpaDNota: TRBDNotaFiscal; VpaDNFe: TNFe);
var
  VpfLaco : Integer;
  VpfDFatura : TRBDImpressaoFaturaNotaFiscal;
begin
//  VpaDNFe.Cobr.Fat.nFat := IntToStr(VpaDNota.NumNota);
//  VpaDNFe.Cobr.Fat.vOrig := VpaDNota.ValTotal;
//  VpaDNFe.Cobr.Fat.vLiq := VpaDNota.ValTotal;
  FunNotaFiscal.CarFaturasImpressaoNotaFiscal(VpaDNota,1);
  for VpfLaco := 0 to VpaDNota.Faturas.Count - 1 do
  begin
    VpfDFatura := TRBDImpressaoFaturaNotaFiscal(VpaDNota.Faturas.Items[Vpflaco]);
    with VpaDNFe.Cobr.Dup.Add do
    begin
      nDup := VpfDFatura.Numero1;
      dVenc := VpfDFatura.DatVencimento1;
      vDup := VpfDFatura.Valor1;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.ConsultapelaChave(VpaChave : string);
var
 vChave : String;
 VpfTexto : TStringList;
begin
  vChave := VpaChave;
  NFe.WebServices.Consulta.NFeChave := vChave;
  NFe.WebServices.Consulta.Executar;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDObservacoesNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
var
  VpfDTransportadora : TRBDCliente;
begin
  with VpaDNFe.InfAdic do
  begin
    infCpl := VpaDNota.DesDadosAdicionaisImpressao.Text;
    if VpaDNota.DesOrdemCompra <> '' then
      infCpl := infCpl+';Ordem Compra : '+ SubstituiStr(VpaDNota.DesOrdemCompra,';','/');
    if (VpaDNota.NumPedidos <> '') and (Config.ImprimirNumeroCotacaonaNotaFiscal) then
      infCpl := infCpl+';'+ SubstituiStr(VpaDNota.NumPedidos,';','/');

    if VpaDNota.DesObservacao.Count > 0 then
      infCpl := infCpl+';'+VpaDNota.DesObservacao.Text;
    if VpaDNota.CodRedespacho <> 0 then
    begin
      VpfDTransportadora := TRBDCliente.Cria;
      VpfDTransportadora.CodCliente := VpaDNota.CodRedespacho;
      FunClientes.CarDCliente(VpfDTransportadora);
      infCpl := infCpl+';REDESPACHO :'+VpfDTransportadora.NomCliente+'   TELEFONE: '+VpfDTransportadora.DesFone1 +
      '    ENDERECO: ' + VpfDTransportadora.DesEndereco + '   - : ' + VpfDTransportadora.DesBairro + '    - ' + VpfDTransportadora.DesCidade + ' - ' + VpfDTransportadora.DesUF +
      '    CEP: ' + VpfDTransportadora.CepCliente;
      VpfDTransportadora.Free;
    end;

  end;
  VpaDNFe.compra.xPed := VpaDNota.DesOrdemCompra;
end;

{******************************************************************************}
function TRBFuncoesNFe.MontaHTML(VpaDNota: TRBDNotaFiscal;VpaDCliente : TRBDCliente) : string;
var
  VpfEmailHTML : TIdText;
  Vpfbmppart : TIdAttachmentfile;
  VpfArquivoPDF : string;
  VpfBoletoAnexo : Boolean;
begin
  result := '';
  if not ExisteArquivo(varia.PathVersoes+'\'+inttoStr(VpaDNota.CodFilial)+'.jpg') then
    result := 'Falta arquivo "'+varia.PathVersoes+'\'+inttoStr(VpaDNota.CodFilial)+'.jpg'+'"';
  if not ExisteArquivo(varia.PathVersoes+'\efi.jpg') then
    result := 'Falta arquivo "'+varia.PathVersoes+'\efi.jpg'+'"';
  if result = '' then
  begin
    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDNota.CodFilial)+'.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'attachment';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDNota.CodFilial)+'.jpg';
    Vpfbmppart.FileName := '';
    Vpfbmppart.DisplayName := '';

    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\efi.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'inline';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := 'efi.jpg';
    Vpfbmppart.FileName := '';
    Vpfbmppart.DisplayName := '';

    VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    VpfEmailHTML.DisplayName := 'Nfe';
    VpfEmailHTML.CharSet := 'ISO-8859-1'; // NOSSA LINGUAGEM PT-BR (Latin-1)!!!!
    VpfEmailHTML.ContentTransfer := '16bit'; // para SAIR ACENTUADO !!!! Pois, 8bit SAI SEM

    VpfEmailHtml.Body.Clear;
    VpfEmailHtml.Body.Add('<html>');
    VpfEmailHtml.Body.Add('<head>');
    VpfEmailHtml.Body.add('  <title>Nf-e Eficacia Sistemas e Consultoria ltda');
    VpfEmailHtml.Body.Add('</title>');
    VpfEmailHtml.Body.add('<body>');
    VpfEmailHtml.Body.Add('<center>');
    VpfEmailHtml.Body.add('<table width=80%  border=1 bordercolor="black" cellspacing="0" >');
    VpfEmailHtml.Body.Add('<tr>');
    VpfEmailHtml.Body.add('<td>');
    VpfEmailHtml.Body.Add('<table width=100%  border=0 >');
    VpfEmailHtml.Body.add(' <tr>');
    VpfEmailHtml.Body.Add('  <td width=40%>');
    VpfEmailHtml.Body.add('    <a > <img src="cid:'+IntToStr(VpaDNota.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' boder=0>');
    VpfEmailHtml.Body.Add('  </td>');
    VpfEmailHtml.Body.add('  <td width=20% align="center" > <font face="Verdana" size="5"><b>NF-e');
    VpfEmailHtml.Body.Add('  <td width=40% align="right" > <font face="Verdana" size="5"><right> <a title="Sistema de Gestão Desenvolvido por Eficacia Sistemas e Consultoria" href="http://www.eficaciaconsultoria.com.br"> <img src="cid:efi.jpg" border="0"');
    VpfEmailHtml.Body.add('  </td>');
    VpfEmailHtml.Body.Add('  </td>');
    VpfEmailHtml.Body.add('  </tr>');
    VpfEmailHtml.Body.Add('</table>');
    VpfEmailHtml.Body.add('<br>');
    VpfEmailHtml.Body.Add('<br>');
    VpfEmailHtml.Body.add('<table width=100%  border=0 cellpadding="0" cellspacing="0" >');
    VpfEmailHtml.Body.Add(' <tr>');
    VpfEmailHtml.Body.add('  <td width=100% bgcolor=#6699FF ><font face="Verdana" size="3">');
    VpfEmailHtml.Body.Add('   <br> <center>');
    VpfEmailHtml.Body.add('   <br>Esta mensagem refere-se a Nota Fiscal Eletronica Nacional "'+IntToStr(VpaDNota.NumNota)+'"');
    VpfEmailHtml.Body.Add('   <br></center>');
    VpfEmailHtml.Body.add('   <br>');
    VpfEmailHtml.Body.Add('   <br>');
    VpfEmailHtml.Body.add(' </tr><tr>');
    VpfEmailHtml.Body.Add('  <td width=100% bgcolor="silver" ><font face="Verdana" size="3">');
    VpfEmailHtml.Body.add('   <br><center>');
    VpfEmailHtml.Body.Add('   <br>Cliente : '+VpaDCliente.NomCliente );
    VpfEmailHtml.Body.add('   <br>CNPJ :'+VpaDCliente.CGC_CPF);
    VpfEmailHtml.Body.Add('   <br>');
    VpfEmailHtml.Body.add('   <br>');
    VpfEmailHtml.Body.Add('   <br>');
    VpfEmailHtml.Body.add(' </tr><tr>');
    VpfEmailHtml.Body.Add('  <td width=100% bgcolor=#6699FF ><font face="Verdana" size="3">');
    VpfEmailHtml.Body.add('   <br><center>');
    VpfEmailHtml.Body.Add('   Seguem abaixo os vencimentos das parcelas' );
    VpfEmailHtml.Body.add('   <br>  <table width=50%  border=1 cellpadding="0" cellspacing="0" font face="Verdana" size="3">');
    VpfEmailHtml.Body.add('       <tr>');
    VpfEmailHtml.Body.add('         <td width=33%> <font face="Verdana" size="3"> Duplicata </td>');
    VpfEmailHtml.Body.add('         <td width=33%> <font face="Verdana" size="3"> Vencimento </td>');
    VpfEmailHtml.Body.add('         <td width=34%> <font face="Verdana" size="3"> Valor </td>');
    VpfEmailHtml.Body.add('       </tr>');
    VpfBoletoAnexo := false;
    FunNotaFiscal.LocalizaParcelasBoleto(Aux,VpaDNota.CodFilial, VpaDNota.SeqNota);
    while not Aux.Eof do
    begin
      VpfEmailHtml.Body.add('       <tr>');
      VpfEmailHtml.Body.add('         <td width=33%> <font face="Verdana" size="2"> '+Aux.FieldByName('C_NRO_DUP').AsString+' </td>');
      VpfEmailHtml.Body.add('         <td width=33%> <font face="Verdana" size="2"> '+FormatDateTime('DD/MM/YYYY',Aux.FieldByName('D_DAT_VEN').AsDateTime)+' </td>');
      VpfEmailHtml.Body.add('         <td width=34%> <font face="Verdana" size="2"> '+FormatFloat('#,###,###,##0.00',Aux.FieldByName('N_VLR_PAR').AsFloat)+' </td>');
      VpfEmailHtml.Body.add('       </tr>');

      if  (config.ImprimirBoletoFolhaBranco)and (varia.FormaPagamentoBoleto = aux.FieldByName('I_COD_FRM').AsInteger) and
          (config.EnviarBoletoNaNotaFiscal) then
      begin
        VpfBoletoAnexo := true;
        VpfArquivoPDF := FunImprimeBoleto.GeraPDFBoleto(Aux.FieldByName('I_EMP_FIL').AsInteger,Aux.FieldByName('I_LAN_REC').AsInteger,Aux.FieldByName('I_NRO_PAR').AsInteger,VpaDCliente);
        Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,VpfArquivoPDF);
        Vpfbmppart.ContentType := 'application/pdf';
        Vpfbmppart.ContentDisposition := 'inline';
        Vpfbmppart.DisplayName:=RetornaNomArquivoSemDiretorio(VpfArquivoPDF);
        Vpfbmppart.ExtraHeaders.Values['content-id'] := RetornaNomArquivoSemDiretorio(VpfArquivoPDF);;
        Vpfbmppart.DisplayName := RetornaNomArquivoSemDiretorio(VpfArquivoPDF);;
      end;
      Aux.Next;
    end;
    VpfEmailHtml.Body.add('     </table>');
    if VpfBoletoAnexo then
      VpfEmailHtml.Body.Add('<br>Os boletos se encontram em anexo a essa mensagem' );
    VpfEmailHtml.Body.Add('   <br></center>');
    VpfEmailHtml.Body.Add('   <br>');
    VpfEmailHtml.Body.add(' </tr><tr>');
    VpfEmailHtml.Body.Add('  <td width=100% bgcolor="silver" ><font face="Verdana" size="2">');
    VpfEmailHtml.Body.add('   <br><center>');
    VpfEmailHtml.Body.Add('   <br>Para verificar a autorização da SEFAZ referente à nota acima mencionada, acesse o site <a href="http://www.nfe.fazenda.gov.br/portal"> http://www.nfe.fazenda.gov.br/portal');
    VpfEmailHtml.Body.add('   <br>');
    VpfEmailHtml.Body.Add('   <br>');
    VpfEmailHtml.Body.add('   <br>');
    VpfEmailHtml.Body.Add('   <br>');
    VpfEmailHtml.Body.add(' </tr>');
    VpfEmailHtml.Body.Add(' </tr><tr>');
    VpfEmailHtml.Body.add('  <td width=100% bgcolor=#6699FF ><font face="Verdana" size="3">');
    VpfEmailHtml.Body.Add('   <br><center>');
    VpfEmailHtml.Body.add('   <br>Chave Acesso : '+VpaDNota.DesChaveNFE);
    VpfEmailHtml.Body.Add('   <br>Protocolo : '+ VpaDNota.NumProtocoloNFE);
    VpfEmailHtml.Body.add('   <br>');
    VpfEmailHtml.Body.Add('   <br>');
    VpfEmailHtml.Body.add('   <br>');
    VpfEmailHtml.Body.Add(' </tr><tr>');
    VpfEmailHtml.Body.add('</table>');
    VpfEmailHtml.Body.Add('</td>');
    VpfEmailHtml.Body.add('</tr>');
    VpfEmailHtml.Body.Add('</table>');
    VpfEmailHtml.Body.add('<hr>');
    VpfEmailHtml.Body.Add('<center>');
    if Sistema.PodeDivulgarEficacia then
      VpfEmailHtml.Body.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
    VpfEmailHtml.Body.Add('</center>');
    VpfEmailHtml.Body.add('</body>');
    VpfEmailHtml.Body.Add('');
    VpfEmailHtml.Body.add('</html>');
  end;
end;

{******************************************************************************}
function TRBFuncoesNFe.MontaHTMLnfeCotabilidade: string;
var
  VpfEmailHTML : TIdText;
  Vpfbmppart : TIdAttachmentfile;
  VpfArquivoPDF : string;
  VpfBoletoAnexo : Boolean;
begin
  result := '';
  if not ExisteArquivo(varia.PathVersoes+'\'+inttoStr(varia.CodigoEmpFil)+'.jpg') then
    result := 'Falta arquivo "'+varia.PathVersoes+'\'+inttoStr(varia.CodigoEmpFil)+'.jpg'+'"';
  if not ExisteArquivo(varia.PathVersoes+'\efi.jpg') then
    result := 'Falta arquivo "'+varia.PathVersoes+'\efi.jpg'+'"';
  if result = '' then
  begin
    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(varia.CodigoEmpFil)+'.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'attachment';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(varia.CodigoEmpFil)+'.jpg';
    Vpfbmppart.FileName := '';
    Vpfbmppart.DisplayName := '';

    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\efi.jpg');
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'inline';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := 'efi.jpg';
    Vpfbmppart.FileName := '';
    Vpfbmppart.DisplayName := '';

    VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    VpfEmailHTML.DisplayName := 'Nfe';
    VpfEmailHTML.CharSet := 'ISO-8859-1'; // NOSSA LINGUAGEM PT-BR (Latin-1)!!!!
    VpfEmailHTML.ContentTransfer := '16bit'; // para SAIR ACENTUADO !!!! Pois, 8bit SAI SEM

    VpfEmailHtml.Body.Clear;
    VpfEmailHtml.Body.Add('<html>');
    VpfEmailHtml.Body.Add('<head>');
    VpfEmailHtml.Body.add('  <title>Nf-e Eficacia Sistemas e Consultoria ltda');
    VpfEmailHtml.Body.Add('</title>');
    VpfEmailHtml.Body.add('<body>');
    VpfEmailHtml.Body.Add('<center>');
    VpfEmailHtml.Body.add('<table width=80%  border=1 bordercolor="black" cellspacing="0" >');
    VpfEmailHtml.Body.Add('<tr>');
    VpfEmailHtml.Body.add('<td>');
    VpfEmailHtml.Body.Add('<table width=100%  border=0 >');
    VpfEmailHtml.Body.add(' <tr>');
    VpfEmailHtml.Body.Add('  <td width=40%>');
    VpfEmailHtml.Body.add('    <a > <img src="cid:'+IntToStr(varia.CodigoEmpFil)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' boder=0>');
    VpfEmailHtml.Body.Add('  </td>');
    VpfEmailHtml.Body.add('  <td width=20% align="center" > <font face="Verdana" size="5"><b>NF-e');
    VpfEmailHtml.Body.Add('  <td width=40% align="right" > <font face="Verdana" size="5"><right> <a title="Sistema de Gestão Desenvolvido por Eficacia Sistemas e Consultoria" href="http://www.eficaciaconsultoria.com.br"> <img src="cid:efi.jpg" border="0"');
    VpfEmailHtml.Body.add('  </td>');
    VpfEmailHtml.Body.Add('  </td>');
    VpfEmailHtml.Body.add('  </tr>');
    VpfEmailHtml.Body.Add('</table>');
    VpfEmailHtml.Body.add('<br>');
    VpfEmailHtml.Body.Add('<br>');
    VpfEmailHtml.Body.add('<table width=100%  border=0 cellpadding="0" cellspacing="0" >');
    VpfEmailHtml.Body.Add(' <tr>');
    VpfEmailHtml.Body.add('  <td width=100% bgcolor=#6699FF ><font face="Verdana" size="3">');
    VpfEmailHtml.Body.Add('   <br> <center>');
    VpfEmailHtml.Body.add('   <br>Esta mensagem refere-se aos arquivos XML da  empresa  "'+varia.RazaoSocialFilial+'"');
    VpfEmailHtml.Body.Add('   <br></center>');
    VpfEmailHtml.Body.add('   <br>');
    VpfEmailHtml.Body.Add('   <br>');
    VpfEmailHtml.Body.Add(' </tr>');
    VpfEmailHtml.Body.add('</table>');
    VpfEmailHtml.Body.add('<hr>');
    VpfEmailHtml.Body.Add('<center>');
    if Sistema.PodeDivulgarEficacia then
      VpfEmailHtml.Body.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
    VpfEmailHtml.Body.Add('</center>');
    VpfEmailHtml.Body.add('</body>');
    VpfEmailHtml.Body.Add('');
    VpfEmailHtml.Body.add('</html>');
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.MostraStatusOperacao(VpaObjeto : TObject);
begin
  if VprStatusBar <> nil then
  begin
    case NFe.Status of
      stIdle :
      begin
        VprStatusBar.Panels[0].Text := '';
      end;
      stNFeStatusServico :
      begin
        VprStatusBar.Panels[0].Text := 'Verificando Status do servico...';
      end;
{      stNFeRecepcao :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Enviando dados da NFe...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNfeRetRecepcao :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Recebendo dados da NFe...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNfeConsulta :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Consultando NFe...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNfeCancelamento :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Enviando cancelamento de NFe...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNfeInutilizacao :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Enviando pedido de Inutilização...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNFeRecibo :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Consultando Recibo de Lote...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNFeCadastro :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Consultando Cadastro...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stEmail :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Enviando Email...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;}
    end;
    VprStatusBar.Refresh;
  end;
end;

{******************************************************************************}
function TRBFuncoesNFe.NfeCanceladaSefaz(VpaDNota: TRBDNotaFiscal): boolean;
Var
  VpfVisulizarWebService : Boolean;
begin
  result := true;
  if (Config.EmiteNFe) and (VpaDNota.IndNFEEnviada) then
  begin
    VpfVisulizarWebService := NFe.Configuracoes.WebServices.Visualizar;
    NFe.Configuracoes.WebServices.Visualizar := false;
    ConsultapelaChave(VpaDNota.DesChaveNFE);
    result := nfe.WebServices.Consulta.cStat = 101;
    NFe.Configuracoes.WebServices.Visualizar := VpfVisulizarWebService;
  end;
end;

{******************************************************************************}
function TRBFuncoesNFe.ResolveproblemaComunicacao(VpaDNota: TRBDNotaFiscal): string;
var
  vpfChave : Ansistring;
  VpfDNFe : TNFe;
  VpfVisualizar : Boolean;
begin
  VpfVisualizar := NFe.Configuracoes.WebServices.Visualizar;
  NFe.Configuracoes.WebServices.Visualizar := false;

  VpfDNFe := NFe.NotasFiscais.Add.NFe;
  CarDNotaNfe(VpaDNota,VpfDNFe);
  CarDEmitenteNfe(VpaDNota,VpfDNFe);
  GerarChave(VpfChave,VpfDNFe.Ide.cUF, VpfDNFe.Ide.cNF, VpfDNFe.ide.modelo, VpfDNFe.ide.serie,
              VpfDNFe.ide.nNF, StrToInt(TpEmisToStr(VpfDNFe.ide.tpEmis)), VpfDNFe.ide.dEmi, VpfDNFe.emit.CNPJCPF);
  vpfChave := copy(vpfChave,4,44);
  NFe.WebServices.Consulta.NFeChave := vpfChave;
  NFe.WebServices.Consulta.Executar;

  if NFe.WebServices.Consulta.cStat = 562 then
  begin
    vpfChave := CopiaAteChar(DeleteAteChar(NFe.WebServices.Consulta.XMotivo,'['),']');
    NFe.WebServices.Consulta.NFeChave := vpfChave;
    NFe.WebServices.Consulta.Executar;
    if NFe.WebServices.Consulta.cStat = 100 then
    begin
      VpaDNota.NumProtocoloNFE := NFe.WebServices.Consulta.Protocolo;
      VpaDNota.DesChaveNFE := vpfChave;
      result := FunNotaFiscal.CancelaNotaFiscal(VpaDNota,true,true);
    end
  end
  else

    if NFe.WebServices.Consulta.cStat = 100 then
    begin
      VpaDNota.NumProtocoloNFE := NFe.WebServices.Consulta.Protocolo;
      VpaDNota.DesChaveNFE := vpfChave;
      Result := FunNotaFiscal.GravaDNotaFiscal(VpaDNota);
    end
    else
      if NFe.WebServices.Consulta.cStat = 101 then //nfe ja esta cancelada;
      begin
        VpaDNota.NumProtocoloNFE := NFe.WebServices.Consulta.Protocolo;
        VpaDNota.DesChaveNFE := vpfChave;
        Result := FunNotaFiscal.GravaDNotaFiscal(VpaDNota);
        if result = '' then
          result := FunNotaFiscal.CancelaNotaFiscal(VpaDNota,true,false);
      end
      else
        if NFe.WebServices.Consulta.cStat = 217 then //nfe nao consta na base da SEFAZ
        begin
          result := InutilizaNumero(VpaDNota.CodFilial,VpaDNota.SeqNota,VpaDNota.NumNota);
          if result = '' then
          begin
            VpaDNota.IndNotaInutilizada := true;
            result := FunNotaFiscal.CancelaNotaFiscal(VpaDNota,true,false);
            if result = '' then
              aviso('NFE INUTILIZADA!!!'#13'Houve um erro na comunicação com o SEFAZ e essa nota foi CANCELADA no SISTEMA e a numerção foi INUTILIZADA na SEFAZ');
          end
        end
        else
          result := 'ERRO NO ENVIO DA NOTA(CONSULTA NFE)!!!'#13+IntToStr(NFe.WebServices.Consulta.cStat)+'-'+NFe.WebServices.Consulta.XMotivo;

  NFe.Configuracoes.WebServices.Visualizar := VpfVisualizar;
end;


{******************************************************************************}
function TRBFuncoesNFe.RUF(VpaCodFiscalMunicipio: String): String;
var
  VpfCodigoEstado : String;
begin
  result := '';
  VpfCodigoEstado := copy(VpaCodFiscalMunicipio,1,2);
  if VpfCodigoEstado = '11' then
    result := 'RO'
  else
    if VpfCodigoEstado = '12' then
      result := 'AC'
    else
    if VpfCodigoEstado = '13' then
      result := 'AM'
    else
    if VpfCodigoEstado = '14' then
      result := 'RR'
    else
    if VpfCodigoEstado = '15' then
      result := 'PA'
    else
    if VpfCodigoEstado = '16' then
      result := 'AP'
    else
    if VpfCodigoEstado = '17' then
      result := 'TO'
    else
    if VpfCodigoEstado = '21' then
      result := 'MA'
    else
    if VpfCodigoEstado = '22' then
      result := 'PI'
    else
    if VpfCodigoEstado = '23' then
      result := 'CE'
    else
    if VpfCodigoEstado = '24' then
      result := 'RN'
    else
    if VpfCodigoEstado = '25' then
      result := 'PB'
    else
    if VpfCodigoEstado = '26' then
      result := 'PE'
    else
    if VpfCodigoEstado = '27' then
      result := 'AL'
    else
    if VpfCodigoEstado = '28' then
      result := 'SE'
    else
    if VpfCodigoEstado = '29' then
      result := 'BA'
    else
    if VpfCodigoEstado = '31' then
      result := 'MG'
    else
    if VpfCodigoEstado = '32' then
      result := 'ES'
    else
    if VpfCodigoEstado = '33' then
      result := 'RJ'
    else
    if VpfCodigoEstado = '35' then
      result := 'SP'
    else
    if VpfCodigoEstado = '41' then
      result := 'PR'
    else
    if VpfCodigoEstado = '42' then
      result := 'SC'
    else
    if VpfCodigoEstado = '43' then
      result := 'RS'
    else
    if VpfCodigoEstado = '50' then
      result := 'MS'
    else
    if VpfCodigoEstado = '51' then
      result := 'MT'
    else
    if VpfCodigoEstado = '52' then
      result := 'GO'
    else
    if VpfCodigoEstado = '53' then
      result := 'DF';
end;

{******************************************************************************}
function TRBFuncoesNFe.VerificaStatusServico(VpaBarraStatus : TStatusBar): String;
var
  VpfVisualizar : Boolean;
begin
  NFe.Configuracoes.Geral.PathSalvar := Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',DATE) ;
  VprStatusBar := VpaBarraStatus;
  VpfVisualizar := NFe.Configuracoes.WebServices.Visualizar;
  NFe.Configuracoes.WebServices.Visualizar := true;
  NFe.WebServices.StatusServico.Executar;
  result := UTF8Encode(NFe.WebServices.StatusServico.RetWS);
  NFe.Configuracoes.WebServices.Visualizar := VpfVisualizar;
end;

{******************************************************************************}
function TRBFuncoesNFe.EmiteNota(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente;VpaBarraStatus : TStatusBar):string;
var
  VpfDNFe : TNFe;
  VpfVisualizar : Boolean;
begin
  NFe.Configuracoes.Geral.PathSalvar := Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao) ;
  VpaDNota.IndNFEEnviada := true;
  NFe.Configuracoes.WebServices.Visualizar := false;
  VprStatusBar := VpaBarraStatus;
  result := VerificacoesEmitente;
  if result = '' then
    result :=  VerificacoesDestinatario(VpaDCliente);
  if result = '' then
  begin
    NFe.NotasFiscais.Clear;
    VpfDNFe := NFe.NotasFiscais.Add.NFe;
    CarDNotaNfe(VpaDNota,VpfDNFe);
    CarDEmitenteNfe(VpaDNota,VpfDNFe);
    CarDDestinatarioNfe(VpaDNota,VpaDCliente,VpfDNFe);
    CarDProdutoNfe(VpaDCliente,VpaDNota,VpfDNFe);
    CarDServicosNfe(VpaDNota,VpfDNFe);
    CarDTotalNota(VpaDNota,VpfDNFe);
    CarDTransporteNota(VpaDNota,VpfDNFe);
    FunNotaFiscal.CarObservacaoNotaFiscal(VpaDNota,VpaDCliente);
    CarFaturas(VpaDNota,VpfDNFe);
    CarDObservacoesNota(VpaDNota,VpfDNFe);

    nfe.DANFE := nil;
    if config.EmiteNFe then
    begin
      try
        NFe.NotasFiscais.Valida;
        VpfVisualizar := NFe.Configuracoes.WebServices.Visualizar;
        FunNotaFiscal.SetaNfeComoEnviada(VpaDNota.CodFilial,VpaDNota.SeqNota);
        NFe.Enviar(0);
      except
        on e : exception do
        begin
          result := E.Message;
        end;
      end;
      if result = '' then
      begin
        VpaDNota.NumReciboNFE := nfe.WebServices.Retorno.Recibo;
        VpaDNota.NumProtocoloNFE := nfe.WebServices.Retorno.Protocolo;
        VpaDNota.CodMotivoNFE := IntTostr(nfe.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].cStat);
        VpaDNota.DesMotivoNFE := nfe.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].xMotivo;
        VpaDNota.DesChaveNFE := nfe.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].chNFe;
      end;
    end;

    if result = '' then
    try
//      GeraNFEPDF(VpaDNota);
    except
    end;
    NFe.DANFE := Danfe;

  end;
  NFe.Configuracoes.WebServices.Visualizar := VpfVisualizar
end;

{******************************************************************************}
function TRBFuncoesNFe.ImprimeDanfe(VpaDNota: TRBDNotaFiscal): String;
var
  VpfDFilial : TRBDFilial;
begin
  VpfDFilial := TRBDFilial.cria;
  Sistema.CarDFilial(VpfDFilial,VpaDNota.CodFilial);
  NFe.Configuracoes.Geral.PathSalvar := Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao) ;
  result := '';
  Danfe := TACBrNFeDANFERave.Create(Application);
  Danfe.RavFile :=Varia.PathRelatorios+'\NotaFiscalEletronica.rav';
  Danfe.CasasDecimais._vUnCom := varia.Decimais;
  NFe.DANFE := Danfe;
  if config.NFEDanfeRetrato then
    NFE.DANFE.TipoDANFE := tiRetrato
  else
    NFE.DANFE.TipoDANFE := tiPaisagem;
  if ExisteArquivo(varia.PathVersoes+'\'+ DeletaChars(DeletaChars(DeletaChars(VpfDFilial.DesCNPJ,'.'),'-'),'/')+'.bmp') then
    NFe.DANFE.Logo := varia.PathVersoes+'\'+ DeletaChars(DeletaChars(DeletaChars(VpfDFilial.DesCNPJ,'.'),'-'),'/')+'.bmp'
  else
    NFe.DANFE.Logo := varia.PathVersoes+'\'+inttoStr(varia.CodigoEmpFil)+'.bmp';

  NFe.NotasFiscais.Clear;
  CarArquivoXMLNFE(VpaDNota);
  NFe.DANFE.ProtocoloNFe := VpaDNota.NumProtocoloNFE;
  if Sistema.PodeDivulgarEficacia then
    NFe.DANFE.Sistema := ' Eficácia Sistemas e Consultoria - www.eficaciaconsultoria.com.br';
  NFe.DANFE.Site := lowerCAse(varia.SiteFilial);
  NFe.DANFE.Usuario := varia.NomeUsuario;
  NFe.DANFE.Email := lowerCAse(varia.EMailFilial);
  NFe.NotasFiscais.Imprimir;
  NFe.DANFE := nil;
  Danfe.FREE;
  VpfDFilial.Free;
end;

{******************************************************************************}
function TRBFuncoesNFe.InutilizaNumero(VpaCodFilial,VpaSeqNota, VpaNumNota: Integer): String;
var
  VpfVisualizar : Boolean;
begin
  VpfVisualizar := NFe.Configuracoes.WebServices.Visualizar;
  NFe.Configuracoes.WebServices.Visualizar := false;

  NFe.Configuracoes.Certificados.NumeroSerie := varia.CertificadoNFE;
  NFe.Configuracoes.Geral.Salvar := false;
  NFe.Configuracoes.WebServices.UF := Varia.UFSefazNFE;
  if config.NFEHomologacao then
    Nfe.Configuracoes.WebServices.Ambiente := taHomologacao
  else
    Nfe.Configuracoes.WebServices.Ambiente := taProducao;

  result := '';
  try
    NFe.WebServices.Inutiliza(DeletaChars(DeletaChars(DeletaChars(varia.CNPJFilial,'.'),'-'),'/'),'NUMERO PERDIDO DO FORMULARIO PRINCIPAL',ANO(DATE),55,StrtoInt(Varia.SerieNota),VpaNumNota,VpaNumNota);
    result := FunNotaFiscal.SetaNotaInutilizada(VpaCodFilial,VpaSeqNota);
  except
     on e : exception do
     begin
       if NFe.WebServices.Inutilizacao.cStat = 563 then
       begin
         result := FunNotaFiscal.SetaNotaInutilizada(VpaCodFilial,VpaSeqNota);
       end
       else
         result := 'ERRO NA INUTLIZACAO DA NOTA FISCAL!!!'#13+ e.message;
     end;
  end;
  NFe.Configuracoes.WebServices.Visualizar := VpfVisualizar;
end;

{******************************************************************************}
function TRBFuncoesNFe.EnviaEmail(VpaMensagem: TIdMessage; VpaSMTP: TIdSMTP; VpaDFilial: TRBDFilial): string;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';
  VpaMensagem.From.Address := VpaDFilial.DesEmailComercial;
  VpaMensagem.From.Name := VpaDFilial.NomFantasia;

  VpaSMTP.UserName := varia.UsuarioSMTP;
  VpaSMTP.Password := Varia.SenhaEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := Varia.PortaSMTP;
  if config.ServidorInternetRequerAutenticacao then
    VpaSMTP.AuthType := satdefault
  else
    VpaSMTP.AuthType := satNone;

  if VpaMensagem.ReceiptRecipient.Address = '' then
    result := 'E-MAIL DA FILIAL !!!'#13'É necessário preencher o e-mail da filial.';
  if VpaSMTP.UserName = '' then
    result := 'USUARIO DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações o e-mail de origem.';
  if VpaSMTP.Host = '' then
    result := 'SERVIDOR DE SMTP NÃO CONFIGURADO!!!'#13'É necessário configurar qual o servidor de SMTP...';
  if result = '' then
  begin
    VpaSMTP.Connect;
    try
      VpaSMTP.Send(VpaMensagem);
    except
      on e : exception do
      begin
        result := 'ERRO AO ENVIAR O E-MAIL!!!'#13+e.message;
        VpaSMTP.Disconnect;
      end;
    end;
    VpaSMTP.Disconnect;
  end;
end;

{******************************************************************************}
function TRBFuncoesNFe.EnviaEmailContabilidadeNfe(VpaARquivo, VpaEmail: string;VpaMes,VpaAno : Integer): string;
var
  VpfDFilial : TRBDFilial;
begin
  Result := '';
  if (VpaEmail = '') then
    result := 'E-MAIL DA CONTABILIDADE NÃO PREENCHIDO!!!!'#13'É necessário preencher o e-mail da contabilidade.';
  if result = '' then
  begin
    VprMensagem.ReceiptRecipient.Text  := varia.UsuarioSMTP;
    VprMensagem.Recipients.Clear;
    VprMensagem.ReplyTo.EMailAddresses := varia.UsuarioSMTP;
    if result = '' then
    begin
      result := MontaHTMLnfeCotabilidade;
      if result = '' then
      begin
        result := AnexaNotasContabilidade(VpaARquivo);
        if result = '' then
        begin
          while VpaEmail <> '' do
          begin
            VprMensagem.Recipients.add.Address := DeletaChars(CopiaAteChar(VpaEmail,';'),';');
            VpaEmail := DeleteAteChar(VpaEmail,';');
          end;

          VpfDFilial := TRBDFilial.cria;
          Sistema.CarDFilial(VpfDFilial,Varia.CodigoEmpFil);

          VprMensagem.Subject :='Nfe referente a '+IntToStr(VpaMes)+'/'+IntToStr(VpaAno);

          result := EnviaEmail(VprMensagem,VprSMTP,VpfDFilial);
          VpfDFilial.Free;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesNFe.EnviaEmailDanfe(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente):String;
var
  VpfTextoEmail : TStringList;
  VpfEmail : string;
  VpfDFilial : TRBDFilial;
  VpfDVendedor : TRBDVendedor;
begin
  Result := '';
  NFe.Configuracoes.Geral.PathSalvar := Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao) ;
  NaoExisteCriaDiretorio(NFe.Configuracoes.Geral.PathSalvar,false);
  if (VpaDCliente.DesEmail = '') and (VpaDCliente.DesEmailFinanceiro = '') and
     (VpaDCliente.DesEmailNfe = '') then
    result := 'E-MAIL DO CLIENTE NÃO PREENCHIDO!!!!'#13'É necessário preencher o e-mail do cliente.';
  if result = '' then
  begin
    if VpaDCliente.DesEmailNfe <> '' then
       VpfEmail := VpaDCliente.DesEmailNfe
    else
      if VpaDCliente.DesEmail <> '' then
         VpfEmail := VpaDCliente.DesEmail
      else
        VpfEmail := VpaDCliente.DesEmailFinanceiro;
    VprMensagem.ReceiptRecipient.Text  := varia.EmailComercial;
    VprMensagem.Recipients.Clear;
    if varia.emailCopiaNfe <> '' then
      VprMensagem.Recipients.Add.Address := varia.emailCopiaNfe;

    if Varia.emailNFe <> '' then
    begin
      VprMensagem.ReplyTo.EMailAddresses := varia.emailNFe;
      VprMensagem.ReceiptRecipient.Text :=  varia.emailNFe;
    end
    else
      VprMensagem.ReplyTo.EMailAddresses := varia.EmailComercial;

    if VpaDNota.CodVendedor <> 0 then
    begin
      VpfDVendedor := TRBDVendedor.cria;
      Sistema.CarDVendedor(VpfDVendedor, VpaDNota.CodVendedor);
      if VpfDVendedor.IndEnviaCopiaEmailNfe then
      begin
        VprMensagem.Recipients.Add.Address := VpfDVendedor.DesEmail;
      end;
    end;

    if config.EmiteNFe then
    begin
      result := CarArquivoXMLNFE(VpaDNota);
    end
    else
    begin
      result := EmiteNota(VpaDNota,VpaDCliente,nil);
      NFe.NotasFiscais.SaveToFile;
    end;

    if result = '' then
    begin
      result := MontaHTML(VpaDNota,VpaDCliente);
      if result = '' then
      begin
        GeraNFEPDF(VpaDNota);
        result := AnexaNFE(VpaDNota);
        if result = '' then
        begin
          while VpfEmail <> '' do
          begin
//            VprMensagem.Recipients.add.Address := DeletaChars(CopiaAteChar(VpfEmail,';'),';');
            VprMensagem.Recipients.add.Address := CopiaAteChar(VpfEmail,';');
            VpfEmail := DeleteAteChar(VpfEmail,';');
          end;

          VpfDFilial := TRBDFilial.cria;
          Sistema.CarDFilial(VpfDFilial,VpaDNota.CodFilial);

          VprMensagem.Subject :=VpfDFilial.NomFilial + ' - nfe '+IntToStr(VpaDNota.NumNota);

          result := EnviaEmail(VprMensagem,VprSMTP,VpfDFilial);
          VpfDFilial.Free;
          VpfDVendedor.Free;
        end;
      end;
    end;
    VpfTextoEmail.free;
    NFe.DANFE := nil;
    Danfe.FREE;
  end;
end;

{******************************************************************************}
function TRBFuncoesNFe.EnviaemailDanfePeloOutlook(VpaDNota: TRBDNotaFiscal;VpaDCliente: TRBDCliente): String;
var
  VpfDFilial : TRBDFilial;
  VpfAssunto,VpfEmail : String;
  VpfArquivos : TStringList;
begin
  VpfArquivos := TStringList.Create;
  VpfDFilial := TRBDFilial.cria;
  Sistema.CarDFilial(VpfDFilial,VpaDNota.CodFilial);

  VpfAssunto := VpfDFilial.NomFilial + ' - nfe '+IntToStr(VpaDNota.NumNota);

  if ExisteArquivo(Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'-nfe.xml') then
  begin
    VpfArquivos.add(Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'-nfe.xml');
  end;
  VpfArquivos.add('c:\sqlnet.log');

  if not ExisteArquivo(Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'.pdf') then
    GeraNFEPDF(VpaDNota);
  VpfArquivos.add(Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao)+'\'+VpaDNota.DesChaveNFE+'.pdf');


  if VpaDCliente.DesEmailNfe <> '' then
    VpfEmail :=VpaDCliente.DesEmailNfe
  else
    VpfEmail := VpaDCliente.DesEmail;
  Sistema.EnviaEmailPeloOutlook(VpfAssunto,'Prezado cliente, '#13#10#13#10+'Segue anexo a nota fiscal eletronica',VpfArquivos,VpaDCliente.NomCliente,VpfEmail);

  VpfDFilial.Free;
  VpfArquivos.free;
end;


{******************************************************************************}
procedure TRBFuncoesNFe.GeraNFEPDF(VpaDNota : TRBDNotaFiscal);
begin
    Danfe := TACBrNFeDANFERave.Create(Application);
    Danfe.RavFile :=Varia.PathRelatorios+'\NotaFiscalEletronica.rav';
    Danfe.CasasDecimais._vUnCom := varia.Decimais;

    NFe.DANFE := Danfe;
    if config.NFEDanfeRetrato then
      NFE.DANFE.TipoDANFE := tiRetrato
    else
      NFE.DANFE.TipoDANFE := tiPaisagem;
    NFe.DANFE.Logo := varia.PathVersoes+'\'+inttoStr(varia.CodigoEmpFil)+'.bmp';
    if VpaDNota = nil then
      NFe.DANFE.PathPDF := Varia.PathVersoes+'\nfe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',NFe.NotasFiscais.Items[0].NFe.Ide.dEmi)
    else
      NFe.DANFE.PathPDF := Varia.PathVersoes+'\nfe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',VpaDNota.DatEmissao) ;
    NFe.DANFE.ImprimirDANFEPDF;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.GeraPDFXML(VpaArquivoXML: String);
begin
  NFe.NotasFiscais.LoadFromFile(VpaArquivoXML);
  NFe.Configuracoes.Geral.PathSalvar := Varia.PathVersoes+'\NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+FormatDateTime('YYYYMM',NFe.NotasFiscais.Items[0].NFe.Ide.dEmi) ;
  GeraNFEPDF(nil);
end;

{******************************************************************************}
procedure TRBFuncoesNFe.HigienizaNaturezaOperacao(VpaCorrigidos : TStrings; VpaStatus: TStatusBar);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVNATUREZA');
  while not Cadastro.Eof do
  begin
    AtualizaStatus(VpaStatus,'Verificando natureza de operacao "'+Cadastro.FieldByName('C_COD_NAT').AsString+'"');
    if (Cadastro.FieldByName('C_COD_NAT').AsString[1] in ['1','2','3']) and
       (Cadastro.FieldByName('C_ENT_SAI').AsString = 'S') then
    begin
      VpaCorrigidos.Insert(0,'Corrigindo natureza de operação "'+Cadastro.FieldByName('C_COD_NAT').AsString+'"');
      Cadastro.Edit;
      Cadastro.FieldByName('C_ENT_SAI').AsString := 'E';
      Cadastro.Post;
    end
    else
      if (Cadastro.FieldByName('C_COD_NAT').AsString[1] in ['5','6','7']) and
         (Cadastro.FieldByName('C_ENT_SAI').AsString = 'E') then
      begin
        VpaCorrigidos.Insert(0,'Corrigindo natureza de operação "'+Cadastro.FieldByName('C_COD_NAT').AsString+'"');
        Cadastro.Edit;
        Cadastro.FieldByName('C_ENT_SAI').AsString := 'S';
        Cadastro.Post;
      end;
    Cadastro.Next;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.HigienizaPais(VpaErros: TStrings;VpaStatus: TStatusBar);
begin
  AtualizaStatus(VpaStatus,'Verificando codigos dos paises');
  AdicionaSQLAbreTabela(Aux,'Select * from CAD_PAISES');
  while not aux.eof do
  begin
    AtualizaStatus(VpaStatus,'Verificando o país "'+Aux.FieldByName('DES_PAIS').AsString+'"');
    if Aux.FieldByName('COD_IBGE').AsInteger = 0 then
      VpaErros.Insert(0,'Cadastro do país "'+Aux.FieldByName('DES_PAIS').AsString+'" inválido, falto o codigo do IBGE' );
    Aux.next;
  end;
  aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.HigienizarCidades(VpaErros : TStrings;VpaStatus : TStatusBar);
begin
  AtualizaStatus(VpaStatus,'Verificando cidades');
  AdicionaSQLAbreTabela(Aux,'Select * from CAD_CIDADES');
  while not aux.eof do
  begin
    AtualizaStatus(VpaStatus,'Verificando a cidade "'+Aux.FieldByName('DES_CIDADE').AsString+'"');
    if (DeletaChars(Aux.FieldByName('COD_FISCAL').AsString,' ') = '') or
       (DeletaChars(Aux.FieldByName('COD_FISCAL').AsString,' ') = '0') then
      VpaErros.Insert(0,'Cadastro da cidade "'+Aux.FieldByName('DES_CIDADE').AsString+'" inválido, falto o codigo do IBGE' );
    Aux.next;
  end;
  aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.HigienizarClientes(VpaErros, VpaCorrigidos: TStrings; VpaStatus: TStatusBar);
Var
  VpfCodCidade, VpfCodPais : Integer;
begin
  AtualizaStatus(VpaStatus,'Verificando clientes');
  AdicionaSQLAbreTabela(Aux,'Select * from CADCLIENTES '+
                            ' Where C_IND_CLI = ''S'''+
                            ' OR C_IND_FOR = ''S''');
  while not aux.eof do
  begin
    AtualizaStatus(VpaStatus,'Verificando o cliente "'+Aux.FieldByName('C_NOM_CLI').AsString+'"');
//    if Aux.FieldByName('I_COD_IBG').AsInteger = 0 then
    begin
      VpfCodCidade := FunClientes.RCodCidade(DeletaChars(Aux.FieldByName('C_CID_CLI').AsString,''''),Aux.FieldByName('C_EST_CLI').AsString);
      if VpfCodCidade <> 0 then
      begin
        FunClientes.AtualizaCodCidadeCliente(Aux.FieldByName('I_COD_CLI').AsInteger,VpfCodCidade);
        VpaCorrigidos.Insert(0,'Atualizado o cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'", codigo IBGE do município' );
      end
      else
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, falta o codigo IBGE do município' );
    end;
    if Aux.FieldByName('I_COD_PAI').AsInteger = 0 then
    begin
      VpfCodPais := FunClientes.RCodPais(Aux.FieldByName('C_EST_CLI').AsString);
      if VpfCodPais <> 0 then
      begin
        FunClientes.AtualizaCodPaisCliente(Aux.FieldByName('I_COD_CLI').AsInteger,VpfCodPais);
        VpaCorrigidos.Insert(0,'Atualizado o cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'", codigo IBGE do pais' );
      end
      else
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, falta o codigo IBGE do pais' );
    end;
    if Aux.FieldByName('C_END_CLI').AsString = '' then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, falta o endereço' );
    if Aux.FieldByName('I_NUM_END').AsInteger = 0 then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, falta o número do endereço' );
    if Aux.FieldByName('C_BAI_CLI').AsString = '' then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, falta o bairro ' );
    if Aux.FieldByName('C_TIP_PES').AsString = 'F' then
    begin
      if not VerificaCPF(Aux.FieldByName('C_CPF_CLI').AsString) then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, CPF Inválido ou não preenchido' );
    end;
    if Aux.FieldByName('C_TIP_PES').AsString = 'J' then
    begin
      if not VerificaCGC(Aux.FieldByName('C_CGC_CLI').AsString) then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, CNPJ Inválido ou não preenchido' );
      if not VerificarIncricaoEstadual(DeletaChars(Aux.FieldByName('C_INS_CLI').AsString,' '),Aux.FieldByName('C_EST_CLI').AsString,false,true) then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, I.E. Inválido ou não preenchido' );
    end;

    Aux.next;
  end;
  aux.close;
end;

{******************************************************************************}
function TRBFuncoesNFe.CancelaNFE(VpaDNota: TRBDNotaFiscal;VpaMotivo : String):string;
begin
  Result := '';
  NFe.Configuracoes.Certificados.NumeroSerie := varia.CertificadoNFE;
  NFe.Configuracoes.Geral.Salvar := false;
  NFe.Configuracoes.WebServices.UF := Varia.UFSefazNFE;
  if config.NFEHomologacao then
    Nfe.Configuracoes.WebServices.Ambiente := taHomologacao
  else
    Nfe.Configuracoes.WebServices.Ambiente := taProducao;

  NFe.WebServices.Cancelamento.NFeChave      := VpaDNota.DesChaveNFE;
  NFe.WebServices.Cancelamento.Protocolo     := VpaDNota.NumProtocoloNFE;
  NFe.WebServices.Cancelamento.Justificativa := VpaMotivo;
  NFe.WebServices.Cancelamento.Executar;

  if NFe.WebServices.Cancelamento.cStat = 101 then
    VpaDNota.NumProtocoloCancelamentoNFE := NFe.WebServices.Cancelamento.Protocolo
  else
    result := NFe.WebServices.Cancelamento.xMotivo;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.HigienizarCadastros(VpaErros, VpaCorrigidos: TStrings;VpaStatus: TStatusBar);
begin
  VpaErros.clear;
  VpaCorrigidos.clear;
  HigienizaNaturezaOperacao(VpaCorrigidos,VpaStatus);
  HigienizaPais(VpaErros,VpaStatus);
  HigienizaPais(VpaErros,VpaStatus);
  HigienizarCidades(VpaErros,VpaStatus);
  HigienizarClientes(VpaErros,VpaCorrigidos,VpaStatus);
end;

end.



