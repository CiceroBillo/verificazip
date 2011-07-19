unit UnImpressao;
{Verificado
-.edit;
}
interface

uses
  Windows, Db, DBTables, classes, sysUtils, PainelGradiente, UnDados,
  ConvUnidade, Componentes1, UnClassesImprimir, UnDadosProduto, UnClientes, UnNotaFiscal, UnCotacao,
  SQLExpr;

  const TamanhoArray = 25; // Tamaho do array a verificar.
  type
    TCabecalho = class
      AlturaLinha, // S Reduzida.
      DeteccaoPapel, // S Ativa.
      TipoDocumento: string;
      QuantidadePorPagina,
      SaltoPagina,
      RodDocumento: Integer;
      MesNumerico: Boolean;
      CharEsquerda,
      CharDireita : Char;
    end;

    TStatus = class
      Negrito,
      Italico,
      Condensado,
      Reduzido,
      LinhaTexto: string;
    end;

    TLinha = class
      Negrito,
      Italico,
      Condensado,
      Reduzido,
      Alinhamento: string;
      Tamanho,
      Coluna,
      LinhaAtual, // Linha a ser usada do StringList;
      LinhaUso: Integer; // Linha em uso do documento.
      Texto: TStringList;
    end;

    TConfigImp = class
      NegritoSim,
      NegritoNao,
      ItalicoSim,
      ItalicoNao,
      CondensadoSim,
      CondensadoNao,
      ReduzidoSim,
      ReduzidoNao,
      LinhaTextoSim,
      LinhaTextoNao,
      PapelSim,
      PapelNao,
      ComandoInicializa,
      ComandoMargemEsquerda,
      ComandoMargemDireita,
      ComandoBeep: string;
      PortaImpressao : string;

      A_MIN_TIO,
      A_MAI_TIO,
      A_MIN_AGUDO,
      A_MAN_AGUDO,
      A_MIN_CRASE,
      A_MAN_CRASE,
      A_MIN_CIRCUNFLEXO,
      A_MAN_CIRCUNFLEXO,
      A_MIN_TREMA,
      A_MAN_TREMA,
      E_MIN_AGUDO,
      E_MAN_AGUDO,
      E_MIN_CIRCUNFLEXO,
      E_MAN_CIRCUNFLEXO,
      I_MIN_AGUDO,
      I_MAN_AGUDO,
      O_MIN_TIO,
      O_MAN_TIO,
      O_MIN_AGUDO,
      O_MAN_AGUDO,
      O_MIN_CIRCUNFLEXO,
      O_MAN_CIRCUNFLEXO,
      O_MIN_TREMA,
      O_MAN_TREMA,
      U_MIN_AGUDO,
      U_MAN_AGUDO,
      U_MIN_TREMA,
      U_MAN_TREMA,
      C_MIN_CEDILHA,
      C_MAN_CEDILHA,
      A_MIN_NUMERO,
      O_MIN_NUMERO : Char;
    end;

    TConfiguraImp = class
      private
        Configura : TSQLQuery;
        Status : TStatus;
        ConfigImp : TConfigImp;
      public
        Coluna: Integer;
        constructor Criar(Aowner : TComponent; VpaBaseDados : TSQLConnection); virtual;
        destructor Destroy; override;
        procedure  LocalizaImpressora(Tab : TSQLQUERY; CodImpressora: Integer);
        function   LocalizaPortaImpressao(  CodImpressora: Integer ) : String;
        procedure  InicializaStatus;
        procedure  CarregaConfiguracao;
        function   MontaComandoImprimir(StringAsc, CDelimitador: string): string;
        function   ConfiguraTexto(Negrito, Italico, Condensado, Reduzido: string): string;
        function   ADicionaTexto(var Texto: string; Alinhamento: string; Tamanho, Horizontal: Integer): string;
        function   AcertaAcentuacao( Frase : string ) : String;
    end;


    TLocalizaImpressao = class
      public
        procedure LocalizaItems(Tab : TDataSet; NroDoc : Integer );
        procedure LocalizaUmItem(Tab : TSQLQUERY; NroDoc, Sequencial : Integer );
        procedure LocalizaCab(Tab : TSQLQUERY; NroDoc : Integer );
        procedure LocalizaTipoDocumento(Tab : TDataSet; VpaTipo: string );
        procedure LocalizaTipoBoleto(Tab : TSQLQUERY; VpaTipo: Integer );
    end;

    TFuncoesImpressao = class(TLocalizaImpressao)
      private
        VprDImpressao : TRBDImpressao;
        VprDNotaFiscal : TRBDNotaFiscal;
        VprDCotacao : TRBDOrcamento;
        VprDCliente : TRBDCliente;
        VprDTransportadora : TRBDCliente;

        DadosBoleto : TDadosBoleto;
        DadosCarne : TDadosCarne;
        DadosPromissoria : TDadosPromissoria;
        DadosCheque : TDadosCheque;
        VprDRecibo : TDadosRecibo;
        DadosDuplicata : TDadosDuplicata;
        DadosEnvelope : TDadosEnvelope;
        DadosEtiquetaCliente : TDadosEtiquetaCliente;
        ConfiguraImp : TConfiguraImp;
        Itens,
        Tabela,
        AUX,
        ClientesEmAberto : TSQLQUERY;
        DOC : TStringList;
        VprServicosNotaFiscal : TStringList;
        QuantidadeDocumentos : Integer;
        Linha : array [0..TamanhoArray] of TLinha;
        procedure PosClienteEmAberto(VpaTabela : TSQLQUERY;VpaCodFilial, VpaCodCliente : Integer;VpaDataEmAberto : TDateTime;VpaFundPerdido : Integer);
        procedure CarCabecalhoFilial(VpaDocumento : TStringList);
        procedure CarCabecalhoClienteEmAberto(VpaDocumento : TStringList;VpaCliente, VpaTelefone : String);
        function  ProximoSequencialMovDoc(NroDoc : Integer): Integer;
        procedure AlinhaHorizontalVertical(NroDoc: Integer );
        procedure ConfiguraDocumento(NroDoc: Integer);
        function  ProcuraCampoInserir(VpaSequencial: Integer; TipoDoc: string): string;
        procedure MontaDocumento(VpaTipoDocumento: string);
        procedure MontaLinhas(VpaTipoDocumento: string);
        procedure ImprimirPorta(TextoImprimir: TStringList; Porta : String);
        procedure CriaPendencia(Indice: Integer; Texto: TStringList);
        procedure LimpaArray;
        function VerificaPendencias(var Frase: string; LinhaAtual, ColunaAtual:Integer): Boolean;
        procedure CarServicosNotaFiscal(VpaDNota : TRBDNotaFiscal);
        procedure CarDImpressao(VpaDImpressao : TRBDImpressao);
        procedure CarDItemImpressao(VpaDImpressao : TRBDImpressao);
        procedure CarDItensDocumento(VpadImpressao :TRBDImpressao; VpaProximoItem : TRBDItemImpressao;VpaDoc : TStringList);
        procedure CarDocumento(VpaDImpressao : TRBDImpressao; VpaDoc : TStringList);
        function RIndiceItem(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : Integer;
        function RQtdFolhaImpressaoNota(VpaDNotaFiscal : TRBDNotaFiscal;VpaDImpressao : TRBDimpressao):Integer;
        function RValorCampoFormatado(VpaValor : String; VpaDItemImpressao : TRBDItemImpressao;VpaIndImprimeAsterisco : Boolean) : String;
        function RConfiguracaoCampo(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
        function RValorInserirPedido(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
        function RValorInserirNotaFiscal(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
        function RValorInserirRecibo(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
        function RValorTituloItemPedidoInserir(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
        function RValorTituloItemInserir(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
        function RValorInserir(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
        function FimDadosItemDocumentoPedido(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : Boolean;
        function FimDadosItemDocumentoNotaFiscal(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : Boolean;
        function FimDadosItemDocumento(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : Boolean;
        procedure ImprimirDocumento;
        function ImprimirComoAsterisco(VpaIndAsterisco : Boolean;VpaDItemImpressao : TRBDItemImpressao) : Boolean;
        procedure AdicionaIndiceNotaFiscal(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao);
      public
        CabecalhoDoc : TCabecalho;
        constructor Criar( Aowner : TComponent; VpaBaseDados : TSQLConnection ); virtual;
        destructor Destroy; override;
        procedure DeletaCabItems(NroDoc: Integer);
        function  InsereMovDoc(NroDoc, NroRegistro : Integer; PosHorizontal, PosVertical: Double; Tamanho: Integer; FlaImprime, Descricao, DireitaEsquerda, Condensado, Reduzido : string): Boolean;
        procedure ImprimeComando(Comando, Caractere, Frase, PortaImpressora : string);
        procedure InicializaImpressao(NroDoc, CodImpressora: Integer);
        procedure FechaImpressao(Porta: Boolean; NomeArquivo: string);
        procedure ImprimePromissoria(Dados: TDadosPromissoria);
        procedure ImprimeCheque(Dados: TDadosCheque);
        procedure ImprimeBoleto(Dados: TDadosBoleto);
        procedure ImprimeCarnePagamento(Dados: TDadosCarne);
        procedure ImprimeDuplicata(Dados: TDadosDuplicata);
        procedure ImprimeRecibo(Dados: TDadosRecibo);
        procedure ImprimirRecibo(VpaDRecibo : TDadosRecibo);
        procedure ImprimeEnvelope(Dados: TDadosEnvelope);
        procedure ImprimeEtiquetaCliente(Dados : TDadosEtiquetaCliente);
        procedure ImprimirPedido(VpaDCotacao : TRBDOrcamento);
        procedure ImprimeClientesEmAberto(VpaCodFilial, VpaCodCliente : Integer;VpaDataEmAberto : TDateTime;VpaFundoPerdido : Integer; VpaVisualizar : Boolean);
        procedure ImprimirNotaFiscal(VpaDNotaFiscal : TRBDNotaFiscal);
        procedure LimitaTamanhoCampos(ComponentePai: TComponent; CodModeloDocumento: Integer);
        function BuscaTamanhoCampo(Documento, Sequencial: Integer): Integer;
        function RetornaImpressoraPadrao(NroDoc: Integer): Integer;
        function RNroDocDisponivel : Integer;
        function ImprimirDocumentonaLaser(VpaNumDocumento : Integer) : Boolean;
    end;

implementation

uses FunString, FunSql, ConstMsg, Constantes, FunData, Registry, FunObjeto, unContasAReceber, UnProdutos;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Classe configura impressora
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************** cria uma nova classe *********************************** }
constructor TConfiguraImp.Criar( Aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  Configura := TSQLQuery.Create(Aowner);
  Configura.SQLConnection := VpaBaseDados;
  Status := TStatus.Create;
  ConfigImp := TConfigImp.Create;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TConfiguraImp.Destroy;
begin
  // Objetos.
  Status.Free;
  ConfigImp.Free;
  // Tabelas.
  FechaTabela(Configura);
  Configura.Destroy;
  inherited;
end;

{********************* Localiza um impressora ****************************** }
procedure TConfiguraImp.LocalizaImpressora(Tab : TSQLQUERY; CodImpressora: Integer);
begin
  AdicionaSQLAbreTabela(Tab,
    ' SELECT * FROM CAD_DRIVER ' +
    ' WHERE I_COD_DRV IS NULL ' + // Somente impressoras.
    ' AND I_SEQ_IMP = ' + IntToStr(CodImpressora));
end;

{************** localiza a porta de impressao da impressora selecionada ***** }
function  TConfiguraImp.LocalizaPortaImpressao(  CodImpressora: Integer ) : String;
//var
//  ini : TRegIniFile;
begin
//22/04/2009 as configuracos do caminho da impressora não sao mais salvos no regedit e sim no banco de dados.
//  ini := TRegIniFile.Create('Software\Systec\Sistema');
//  result := ini.ReadString('IMPRESSORA',IntTostr(CodImpressora),'');
//  ini.free;
result := '';
end;

{***************** inicializa status *************************************** }
procedure TconfiguraImp.InicializaStatus;
begin
  with Configura do
  begin
    if not configura.EOF then
    begin
      // Status .
      Status.Italico    := '';
      Status.Negrito    := '';
      Status.Condensado := '';
      Status.Reduzido   := '';
    end;
  end;
end;

{*********************** carrega configuracao da impressora *****************}
procedure TConfiguraImp.CarregaConfiguracao;
begin
  with Configura do
  begin
    if not EOF then
    begin
      // Comandos .
      ConfigImp.ComandoInicializa :=     MontaComandoImprimir(FieldByName('C_INI_IMP').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.ComandoMargemEsquerda := MontaComandoImprimir(FieldByName('C_MRG_ESQ').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.ComandoMargemDireita :=  MontaComandoImprimir(FieldByName('C_MRG_DIR').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.ComandoBeep :=           MontaComandoImprimir(FieldByName('C_BEP_BEP').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.NegritoSim :=            MontaComandoImprimir(FieldByName('C_NEG_SIM').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.NegritoNao :=            MontaComandoImprimir(FieldByName('C_NEG_NAO').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.ItalicoSim :=            MontaComandoImprimir(FieldByName('C_ITA_SIM').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.ItalicoNao :=            MontaComandoImprimir(FieldByName('C_ITA_NAO').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.CondensadoSim :=         MontaComandoImprimir(FieldByName('C_CND_SIM').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.CondensadoNao :=         MontaComandoImprimir(FieldByName('C_CND_NAO').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.ReduzidoSim :=           MontaComandoImprimir(FieldByName('C_CPI_SIM').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.ReduzidoNao :=           MontaComandoImprimir(FieldByName('C_CPI_NAO').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.LinhaTextoSim :=         MontaComandoImprimir(FieldByName('C_LIN_SIM').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.LinhaTextoNao :=         MontaComandoImprimir(FieldByName('C_LIN_NAO').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.PapelSim :=              MontaComandoImprimir(FieldByName('C_PAP_SIM').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.PapelNao :=              MontaComandoImprimir(FieldByName('C_PAP_NAO').AsString, FieldByName('C_CHR_SEP').AsString);
      ConfigImp.PortaImpressao :=        FieldByName('C_CAM_IMP').AsString;

      ConfigImp.A_MIN_TIO :=            Char(FieldByName('I_AMI_TIO').asinteger);
      ConfigImp.A_MAI_TIO :=            Char(FieldByName('I_AMA_TIO').asinteger);
      ConfigImp.A_MIN_AGUDO :=          Char(FieldByName('I_AMI_AGU').asinteger);
      ConfigImp.A_MAN_AGUDO :=          Char(FieldByName('I_AMA_AGU').asinteger);
      ConfigImp.A_MIN_CRASE :=          Char(FieldByName('I_AMI_CRA').asinteger);
      ConfigImp.A_MAN_CRASE :=          Char(FieldByName('I_AMA_CRA').asinteger);
      ConfigImp.A_MIN_CIRCUNFLEXO :=    Char(FieldByName('I_AMI_CIR').asinteger);
      ConfigImp.A_MAN_CIRCUNFLEXO :=    Char(FieldByName('I_AMA_CIR').asinteger);
      ConfigImp.A_MIN_TREMA :=          Char(FieldByName('I_AMI_TRE').asinteger);
      ConfigImp.A_MAN_TREMA :=          Char(FieldByName('I_AMA_TRE').asinteger);
      ConfigImp.E_MIN_AGUDO :=          Char(FieldByName('I_EMI_AGU').asinteger);
      ConfigImp.E_MAN_AGUDO :=          Char(FieldByName('I_EMA_AGU').asinteger);
      ConfigImp.E_MIN_CIRCUNFLEXO :=    Char(FieldByName('I_EMI_CIR').asinteger);
      ConfigImp.E_MAN_CIRCUNFLEXO :=    Char(FieldByName('I_EMA_CIR').asinteger);
      ConfigImp.I_MIN_AGUDO :=          Char(FieldByName('I_IMI_AGU').asinteger);
      ConfigImp.I_MAN_AGUDO :=          Char(FieldByName('I_IMA_AGU').asinteger);
      ConfigImp.O_MIN_TIO :=            Char(FieldByName('I_OMI_TIO').asinteger);
      ConfigImp.O_MAN_TIO :=            Char(FieldByName('I_OMA_TIO').asinteger);
      ConfigImp.O_MIN_AGUDO :=          Char(FieldByName('I_OMI_AGU').asinteger);
      ConfigImp.O_MAN_AGUDO :=          Char(FieldByName('I_OMI_AGU').asinteger);
      ConfigImp.O_MIN_CIRCUNFLEXO :=    Char(FieldByName('I_OMI_CIR').asinteger);
      ConfigImp.O_MAN_CIRCUNFLEXO :=    Char(FieldByName('I_OMA_CIR').asinteger);
      ConfigImp.O_MIN_TREMA :=          Char(FieldByName('I_OMI_TRE').asinteger);
      ConfigImp.O_MAN_TREMA :=          Char(FieldByName('I_OMA_TRE').asinteger);
      ConfigImp.U_MIN_AGUDO :=          Char(FieldByName('I_UMI_AGU').asinteger);
      ConfigImp.U_MAN_AGUDO :=          Char(FieldByName('I_UMA_AGU').asinteger);
      ConfigImp.U_MIN_TREMA :=          Char(FieldByName('I_UMI_TRE').asinteger);
      ConfigImp.U_MAN_TREMA :=          Char(FieldByName('I_UMA_TRE').asinteger);
      ConfigImp.C_MIN_CEDILHA :=        Char(FieldByName('I_CMI_CED').asinteger);
      ConfigImp.C_MAN_CEDILHA :=        Char(FieldByName('I_CMA_CED').asinteger);
      ConfigImp.A_MIN_NUMERO :=         Char(FieldByName('I_AMI_NUM').asinteger);
      ConfigImp.O_MIN_NUMERO :=         Char(FieldByName('I_OMA_NUM').asinteger);
    end;
  end;
end;

{*********** monta comando de impressao ************************************* }
function TconfiguraImp.MontaComandoImprimir(StringAsc, CDelimitador: string): string;
var
  S: string;
begin
  S := StringAsc;
  Result := '';
  WHILE (pos(CDelimitador, S) <> 0) DO
  begin
    try
      Result := Result + char(StrToInt(SeparaAteChar(S, CDelimitador[1])));
    except
      Result := Result + '';
    end;
  end;
  try
    Result := Result + char(StrToInt(SeparaAteChar(S, CDelimitador[1])));
  except
    Result := Result + '';
  end;
end;

{********************* configura texto de impressao ************************** }
function TConfiguraImp.ConfiguraTexto(Negrito, Italico, Condensado, Reduzido: string): string;
begin
  Result := '';
  if Negrito <> Status.Negrito then
  begin
    if Negrito = 'S' then
      Result := Result + ConfigImp.NegritoSim
    else
      Result := Result + ConfigImp.NegritoNao;
    Status.Negrito := Negrito; // Muda o Estado para o estado Atual;
  end;
  if Italico <> Status.Italico then
  begin
    if Italico = 'S' then
      Result := Result + ConfigImp.ItalicoSim
    else
      Result := Result + ConfigImp.ItalicoNao;
    Status.Italico := Italico; // Muda o Estado para o estado Atual;
  end;
  if Condensado <> Status.Condensado then
  begin
    if Condensado = 'S' then
      Result := Result + ConfigImp.CondensadoSim
    else
      Result := Result + ConfigImp.CondensadoNao;
    Status.Condensado := Condensado; // Muda o Estado para o estado Atual;
  end;
  if Reduzido <> Status.Reduzido then
  begin
    if Reduzido = 'S' then
      Result := Result + ConfigImp.ReduzidoSim
    else
      Result := Result + ConfigImp.ReduzidoNao;
    Status.Reduzido := Reduzido; // Muda o Estado para o estado Atual;
  end;
end;

{*********************** adiciona texto ************************************** }
function TConfiguraImp.ADicionaTexto(var Texto: string; Alinhamento: string; Tamanho, Horizontal: Integer): string;
var
  Qtd : Integer;
begin
  Result := '';
  texto := AcertaAcentuacao(Texto);
  Qtd := Horizontal - Coluna ;
  if (Qtd >= 0) then
  begin
    Texto := DeletaEspacoDE(Texto);
    if Alinhamento = 'E' then
    begin
      Texto := CortaString(Texto, Tamanho);
      Coluna := Horizontal + Length(Texto);
      Result := AdicionaBrancoE(Texto, Qtd+ Length(Texto));
    end
    else
    begin
      Coluna := Horizontal;
      Texto := CortaStringDireita(Texto, tamanho);
      if length(texto) > qtd then
      begin
        Texto := CortaStringDireita(Texto, Qtd);
      end;
      Result := AlinhaDireita(Texto, Qtd);
    end;
  end;
end;


function TConfiguraImp.AcertaAcentuacao( Frase : string ) : String;
  var
   laco : integer;

  function mudaCaracter( caracter : char ) : char;
  begin
  result := caracter;
    case caracter of
      'ã' : result := ConfigImp.A_MIN_TIO;
      'Ã' : result := ConfigImp.A_MAI_TIO;
      'á' : result := ConfigImp.A_MIN_AGUDO;
      'Á' : result := ConfigImp.A_MAN_AGUDO;
      'à' : result := ConfigImp.A_MIN_CRASE;
      'À' : result := ConfigImp.A_MAN_CRASE;
      'â' : result := ConfigImp.A_MIN_CIRCUNFLEXO;
      'Â' : result := ConfigImp.A_MAN_CIRCUNFLEXO;
      'ä' : result := ConfigImp.A_MIN_TREMA;
      'Ä' : result := ConfigImp.A_MAN_TREMA;
      'é' : result := ConfigImp.E_MIN_AGUDO;
      'É' : result := ConfigImp.E_MAN_AGUDO;
      'ê' : result := ConfigImp.E_MIN_CIRCUNFLEXO;
      'Ê' : result := ConfigImp.E_MAN_CIRCUNFLEXO;
      'í' : result := ConfigImp.I_MIN_AGUDO;
      'Í' : result := ConfigImp.I_MAN_AGUDO;
      'õ' : result := ConfigImp.O_MIN_TIO;
      'Õ' : result := ConfigImp.O_MAN_TIO;
      'ó' : result := ConfigImp.O_MIN_AGUDO;
      'Ó' : result := ConfigImp.O_MAN_AGUDO;
      'ô' : result := ConfigImp.O_MIN_CIRCUNFLEXO;
      'Ô' : result := ConfigImp.O_MAN_CIRCUNFLEXO;
      'ö' : result := ConfigImp.O_MIN_TREMA;
      'Ö' : result := ConfigImp.O_MAN_TREMA;
      'ú' : result := ConfigImp.U_MIN_AGUDO;
      'Ú' : result := ConfigImp.U_MAN_AGUDO;
      'ü' : result := ConfigImp.U_MIN_TREMA;
      'Ü' : result := ConfigImp.U_MAN_TREMA;
      'ç' : result := ConfigImp.C_MIN_CEDILHA;
      'Ç' : result := ConfigImp.C_MAN_CEDILHA;
      'ª' : result := ConfigImp.A_MIN_NUMERO;
      'º' : result := ConfigImp.O_MIN_NUMERO;
    end;
  end;

begin
  if frase > '' then
   for laco := 0 to length(frase) do
   begin
     if not (ord(frase[laco]) in [33..126]) then
       frase[laco] := mudaCaracter(frase[laco]);
   end;
  result := frase;
end;



{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((({{{{{{{{{{{{
                 ROTINAS DE LOCALIZAÇÃO   - TLocalizaImpressao
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TLocalizaImpressao.LocalizaItems(Tab : TDataSet; NroDoc : Integer );
begin
  AdicionaSQLAbreTabela(Tab,
    ' SELECT * FROM MOV_DOC WHERE I_NRO_DOC = ' +
    IntToStr(NroDoc) +
//    ' ORDER BY I_MOV_SEQ ');
    ' ORDER BY N_POS_VER, N_POS_HOR ');
end;

procedure TLocalizaImpressao.LocalizaUmItem(Tab : TSQLQUERY; NroDoc, Sequencial : Integer );
begin
  AdicionaSQLAbreTabela(Tab,
    ' SELECT * FROM MOV_DOC ' +
    ' WHERE I_NRO_DOC = ' + IntToStr(NroDoc) +
    ' AND I_MOV_SEQ = ' + IntToStr(Sequencial));
end;

procedure TLocalizaImpressao.LocalizaCab(Tab : TSQLQUERY; NroDoc : Integer );
begin
  AdicionaSQLAbreTabela(Tab,
    ' SELECT * FROM CAD_DOC WHERE I_NRO_DOC = ' +
    IntToStr(NroDoc));
end;

{ ***** Localiza documentos por tipo de documento ***** }
procedure TLocalizaImpressao.LocalizaTipoDocumento(Tab : TDataSet; VpaTipo: string );
begin
  AdicionaSQLAbreTabela(Tab,
    ' SELECT * FROM CAD_DOC WHERE C_TIP_DOC  = '''
    + VpaTipo + '''' +
    ' ORDER BY I_NRO_DOC ');
end;

{ ***** Localiza documentos por tipo de Boleto ***** }
procedure TLocalizaImpressao.LocalizaTipoBoleto(Tab : TSQLQUERY; VpaTipo: Integer );
begin
  AdicionaSQLAbreTabela(Tab,
    ' SELECT * FROM CAD_BOLETO WHERE I_SEQ_BOL  = ' +
    IntTostr(VpaTipo) );
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 FUNÇÕES DE IMPRESSÃO  - TFuncoesImpressao
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesImpressao.Criar(Aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  VprDImpressao := TRBDImpressao.cria;
  VprDCliente := TRBDCliente.cria;
  VprDTransportadora := TRBDCliente.cria;
  DOC := TStringList.Create;
  DOC.Clear;
  CabecalhoDoc := TCabecalho.Create;
  ConfiguraImp := TConfiguraImp.Criar(nil,VpaBaseDados);
  Itens := TSQLQuery.Create(nil);
  Itens.SQLConnection := VpaBaseDados;
  Tabela := TSQLQUERY.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  AUX := TSQLQUERY.Create(nil);
  AUX.SQLConnection := VpaBaseDados;
  ClientesEmAberto := TSQLQUERY.Create(nil);
  ClientesEmAberto.SQLConnection := VpaBaseDados;
  VprServicosNotaFiscal := TStringList.Create;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesImpressao.Destroy;
begin
  // Objetos.
  VprDImpressao.Free;
  DOC.Free;
  ConfiguraImp.Free;
  CabecalhoDoc.Free;
  // Tabelas.
  FechaTabela(Itens);
  Itens.Destroy;
  FechaTabela(Tabela);
  Tabela.Destroy;
  FechaTabela(AUX);
  AUX.Destroy;
  ClientesEmAberto.free;
  VprDTransportadora.free;
  VprDCliente.free;
  VprServicosNotaFiscal.free;
  inherited;
end;


{ ***** Configura os edits contidos no componente pai com o tamanho máximo de seu conteúdo se seu tag for igual a I_MOV_SEQ ***** }
procedure TFuncoesImpressao.LimitaTamanhoCampos(ComponentePai: TComponent; CodModeloDocumento: Integer);
var
 I: Integer;
begin
  // OBSERVAÇÃO: Os tags dos edits contidos no componete pai devem ser = ao campo I_MOV_SEQ para os tamanhos equivalerem.
  LocalizaItems(AUX, CodModeloDocumento); // Localiza os de configuração deste modelo de documento.
  AUX.First;
  while not AUX.EOF do
  begin
    for I := 0 to (ComponentePai.ComponentCount -1) do
    begin
      if (ComponentePai.Components[I] is TEditColor) then
        if (((ComponentePai.Components[I] as TEditColor).Tag) = AUX.FieldByName('I_MOV_SEQ').AsInteger) then
        begin
          // Limita o tamanho do edit de acordo com o tamanho do campo configurado.
          (ComponentePai.Components[I] as TEditColor).MaxLength :=
            AUX.FieldByName('I_TAM_CAM').AsInteger;
          Break; // Sai do for.
        end;
    end;
    AUX.Next;
  end;
end;

{******************************************************************************}
procedure TFuncoesImpressao.PosClienteEmAberto(VpaTabela : TSQLQUERY;VpaCodFilial, VpaCodCliente : Integer;VpaDataEmAberto : TDateTime;VpaFundPerdido : Integer);
begin
  VpaTabela.Close;
  VpaTabela.Sql.Clear;
  VpaTabela.Sql.add('Select CLI.I_COD_CLI, CLI.C_NOM_CLI, C_FO1_CLI, CR.D_DAT_EMI, '+
                    ' CR.I_NRO_NOT, MCR.I_NRO_PAR, MCR.D_DAT_VEN, MCR.N_VLR_PAR, MCR.D_PRO_LIG, '+
                    ' MCR.C_FUN_PER, '+
                    ' CR.I_LAN_REC, CR.I_EMP_FIL, CR.I_QTD_PAR, PAG.I_DIA_CAR ' +
                    '  from  MovContasaReceber MCR, CadContasaReceber CR, '+
                    '  CadClientes CLI, CADCONDICOESPAGTO PAG'+
                           ' Where CR.I_EMP_FIL = MCR.I_EMP_FIL '+
                           ' and CR.I_LAN_REC = MCR.I_LAN_REC '+
                           ' and CR.I_COD_CLI = CLI.I_COD_CLI '+
                           ' and CR.I_COD_PAG = PAG.I_COD_PAG '+
                           ' AND MCR.D_DAT_PAG IS NULL '+
                           ' and MCR.D_DAT_VEN <= '+SQLTextoDataAAAAMMMDD(VpaDataEmAberto));
  if VpaCodFilial <> 0 then
    VpaTabela.Sql.Add('and CR.I_EMP_FIL = '+ IntToStr(VpaCodFilial));
  if VpaCodCliente <> 0 then
    VpaTabela.Sql.Add('and CR.I_COD_CLI = '+ IntToStr(VpaCodCliente));
  case VpaFundPerdido  of
    1 : VpaTabela.sql.add('and MCR.C_FUN_PER = ''S''');
    2 : VpaTabela.sql.add('and MCR.C_FUN_PER = ''N''');
  end;
  VpaTabela.Sql.Add('order by CLI.C_NOM_CLI, MCR.D_DAT_VEN ');
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TFuncoesImpressao.CarCabecalhoFilial(VpaDocumento : TStringList);
begin
  VpaDocumento.Add(ConfiguraImp.AcertaAcentuacao(varia.NomeFilial));
  VpaDocumento.Add(ConfiguraImp.AcertaAcentuacao(Varia.EnderecoFilial)+ ' - '+ConfiguraImp.AcertaAcentuacao(Varia.BairroFilial));
  VpaDocumento.Add(ConfiguraImp.AcertaAcentuacao(varia.CidadeFilial)+ '  -  CEP :' +ConfiguraImp.AcertaAcentuacao(Varia.CepFilial));
  VpaDocumento.Add('Fone/Fax : '+ConfiguraImp.AcertaAcentuacao(varia.FoneFilial)+ '   e-mail : '+ConfiguraImp.AcertaAcentuacao(varia.EMailFilial));
  VpaDocumento.Add('');
end;

{******************************************************************************}
procedure TFuncoesImpressao.CarCabecalhoClienteEmAberto(VpaDocumento : TStringList;VpaCliente, VpaTelefone : String);
begin
  VpaDocumento.Add(AdicionaCharD('-','',80));
  VpaDocumento.Add(AdicionaCharD(' ','Cliente : '+ VpaCliente,50) +AdicionaCharE(' ','Telefone : '+VpaTelefone,30));
  VpaDocumento.Add('');
  VpaDocumento.Add('  NOTA NP DT EMISSAO  VAL PARCELA VENCIMENTO PROX COBRANCA   JUROS VALOR A PAGAR');
end;

{******************** Gera o proximo codigo mo mov doc ***********************}
function TFuncoesImpressao.ProximoSequencialMovDoc(NroDoc : Integer): Integer;
begin
  AdicionaSQLAbreTabela(Tabela,
    ' SELECT MAX(I_MOV_SEQ) PROXIMO FROM MOV_DOC WHERE I_NRO_DOC = ' + IntToStr(NroDoc));
  Result := Tabela.FieldByName('PROXIMO').AsInteger + 1;
end;

{ ****************** Insere um registro de configuração de um documento ***** }
function TFuncoesImpressao.InsereMovDoc(NroDoc, NroRegistro : Integer;
  PosHorizontal, PosVertical: Double; Tamanho: Integer;
  FlaImprime, Descricao, DireitaEsquerda, Condensado, Reduzido : string): Boolean;
begin
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela,
    ' INSERT INTO MOV_DOC (I_NRO_DOC, I_MOV_SEQ, N_POS_HOR, ' +
    ' N_POS_VER, I_TAM_CAM,  C_FLA_IMP, C_DES_CAM, C_DIR_ESQ, C_FLA_NEG, C_FLA_ITA, C_FLA_CND, C_FLA_RED ) VALUES ( ' +
      IntToStr(NroDoc) + ',' +
      IntToStr(NroRegistro) + ',' +
      SubstituiStr(FloatToStr(PosHorizontal) , ',', '.') + ',' +
      SubstituiStr(FloatToStr(PosVertical) , ',', '.') + ',' +
      IntToStr(Tamanho) + ',''' +
      FlaImprime + ''','''+
      Descricao + ''','''+
      DireitaEsquerda  + ''',''N'',''N'',''' +
      Condensado + ''','''+
      Reduzido + ''')' );
      // Negrito Italico Condensado e Reduzido.
  Tabela.ExecSQL;
end;

{ ******************** Exclui os itens e o cabeçalho de um documento ********* }
procedure TFuncoesImpressao.DeletaCabItems(NroDoc: Integer);
begin
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela,
    ' DELETE MOV_DOC WHERE I_NRO_DOC = ' + IntToStr(NroDoc) + ';' +
    ' DELETE CAD_DOC WHERE I_NRO_DOC = ' + IntToStr(NroDoc));
  Tabela.ExecSQL;
end;

{****************** retorna o codigo da impressora padrao de um documento ****}
function TFuncoesImpressao.RetornaImpressoraPadrao(NroDoc: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Tabela, ' SELECT I_SEQ_IMP FROM CAD_DOC ' +
                                ' WHERE I_NRO_DOC = ' + IntToStr(NroDoc));
  Result := Tabela.FieldByName('I_SEQ_IMP').AsInteger;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesImpressao.RNroDocDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,' SELECT MAX(I_NRO_DOC)ULTIMO  FROM CAD_DOC' );
  Result := Aux.FieldByName('ULTIMO').AsInteger+1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesImpressao.ImprimirDocumentonaLaser(VpaNumDocumento : Integer) : Boolean;
begin
  AdicionaSQLAbreTabela(Tabela, ' SELECT C_FLA_FOR FROM CAD_DOC ' +
                                ' WHERE I_NRO_DOC = ' + IntToStr(VpaNumDocumento));
  Result := Tabela.FieldByName('C_FLA_FOR').AsString = 'L';
end;

{ ************* Posiciona e Retorna a Quantidade de Linhas ******************* }
procedure TFuncoesImpressao.AlinhaHorizontalVertical(NroDoc: Integer );
begin
  AdicionaSQLAbreTabela(Itens,
    ' SELECT I_MOV_SEQ SEQUENCIAL, C_DIR_ESQ ALINHAMENTO, N_POS_VER VERTICAL , ' +
    ' N_POS_HOR HORIZONTAL, I_TAM_CAM TAMANHO, C_FLA_NEG NEGRITO,' +
    ' C_FLA_ITA ITALICO, C_FLA_CND CONDENSADO, C_FLA_RED REDUZIDO FROM MOV_DOC  ' +
    ' WHERE C_FLA_IMP = ''S'' ' +
    ' AND I_NRO_DOC = ' + IntToStr(NroDoc) +
    ' ORDER BY N_POS_VER, N_POS_HOR ');
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                CONFIGURAÇÕES GERAIS DO DOCUMENTO
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************** localiza o tamanho de um determinado campo ****************** }
function TFuncoesImpressao.BuscaTamanhoCampo(Documento, Sequencial: Integer): Integer;
begin
  LocalizaUmItem(Tabela, Documento, Sequencial);
  Result := Tabela.FieldByName('I_TAM_CAM').AsInteger;
end;

{ *********** Cria as Classes e posiciona a tabela para impressão *********** }
procedure TFuncoesImpressao.InicializaImpressao(NroDoc, CodImpressora: Integer);
begin
  DOC.Clear;
  ConfiguraImp.LocalizaImpressora(ConfiguraImp.Configura, CodImpressora);
  ConfiguraImp.InicializaStatus;
  ConfiguraImp.CarregaConfiguracao;
  ConfiguraImp.Coluna := 1;
  QuantidadeDocumentos := 0;
  ConfiguraDocumento(NroDoc);
  AlinhaHorizontalVertical(NroDoc);
end;

{ *************** Carrega/Configura o cabeçalho do documento **************** }
procedure TFuncoesImpressao.ConfiguraDocumento(NroDoc: Integer);
begin
  LocalizaCab(Tabela, NroDoc);
  CabecalhoDoc.SaltoPagina := Tabela.FieldByName('N_CAB_PAG').AsInteger;
  CabecalhoDoc.RodDocumento := Tabela.FieldByName('N_ROD_DOC').AsInteger;
  CabecalhoDoc.AlturaLinha  := Tabela.FieldByName('C_FLA_LIN').AsString;
  CabecalhoDoc.DeteccaoPapel := Tabela.FieldByName('C_FLA_PAP').AsString;
  CabecalhoDoc.QuantidadePorPagina := Tabela.FieldByName('I_QTD_PAG').AsInteger;
  if (Length(Tabela.FieldByName('C_CHR_ESQ').AsString) > 0) then
    CabecalhoDoc.CharEsquerda := Tabela.FieldByName('C_CHR_ESQ').AsString[1]
  else
    CabecalhoDoc.CharEsquerda := #0;
  if (Length(Tabela.FieldByName('C_CHR_DIR').AsString) > 0) then
    CabecalhoDoc.CharDireita := Tabela.FieldByName('C_CHR_DIR').AsString[1]
  else
    CabecalhoDoc.CharDireita := #0;
  CabecalhoDoc.MesNumerico := Tabela.FieldByName('C_FLA_EXT').AsString = 'N';
end;

{ ********************* Insere Cada Documento com seu Rodapé ***************** }
procedure TFuncoesImpressao.MontaDocumento(VpaTipoDocumento: string);
var
  I,
  Retirar : Integer;
begin
  Inc(QuantidadeDocumentos);
  MontaLinhas(VpaTipoDocumento);
  // Adiciona Rodapé do Documento;
  if (CabecalhoDoc.RodDocumento > 0) then
    AdicionaLinhaTString(DOC, CabecalhoDoc.RodDocumento ,' ');
  if QuantidadeDocumentos = CabecalhoDoc.QuantidadePorPagina then
  begin
    if CabecalhoDoc.SaltoPagina > 0 then
      // Adiciona o salto de página.
      AdicionaLinhaTString(DOC, CabecalhoDoc.SaltoPagina ,' ')
    else
    begin
      // Exclui o salto de pagina.
      if (Abs(CabecalhoDoc.SaltoPagina) >  CabecalhoDoc.RodDocumento) then
        Retirar := CabecalhoDoc.RodDocumento
      else
        Retirar := Abs(CabecalhoDoc.SaltoPagina);
      // Excluir os últimos ( n = RETIRAR) a retirar.
      if Retirar > 0 then
        for I := 1 to  Retirar do
          DOC.Delete(DOC.Count - 1);
    end;
    QuantidadeDocumentos := 0;
  end;
end;

{************************** Imprime Promissoria ******************************}
procedure TFuncoesImpressao.ImprimePromissoria(Dados: TDadosPromissoria);
begin
  DadosPromissoria := Dados;
  MontaDocumento('NOT');
  DadosPromissoria.Destroy;
end;

{************************** Imprime Duplicata ********************************}
procedure TFuncoesImpressao.ImprimeDuplicata(Dados: TDadosDuplicata);
begin
  DadosDuplicata := Dados;
  MontaDocumento('DUP');
  DadosDuplicata.Destroy;
end;

{******************************************************************************}
procedure TFuncoesImpressao.ImprimirPedido(VpaDCotacao : TRBDOrcamento);
begin
  DOC.Clear;
  VprDCotacao := VpaDCotacao;
  VprDCliente.CodCliente := VpaDCotacao.CodCliente;
  FunClientes.CarDCliente(VprDCliente);
  VprDTransportadora.CodCliente := VpaDCotacao.CodTransportadora;
  FunClientes.CarDCliente(VprDTransportadora);
  VprDImpressao.NumDocumento := Varia.DocPadraoPedido;

  ImprimirDocumento;
end;

procedure TFuncoesImpressao.ImprimeClientesEmAberto(VpaCodFilial, VpaCodCliente : Integer;VpaDataEmAberto : TDateTime;VpaFundoPerdido : Integer; VpaVisualizar : Boolean);
VAR
  VpfLinha : String;
  VpfValJuros, VpfValCliente, VpfValTotal : Double;
  VpfClienteAtual :Integer;
  VpfPrimeiroCliente : boolean;
begin
  DOC.Clear;
  VprDImpressao.NumDocumento := Varia.DocPadraoPedido;

  CarDImpressao(VprDImpressao);

  ConfiguraImp.LocalizaImpressora(ConfiguraImp.Configura, VprDImpressao.SeqImpressora);
  ConfiguraImp.InicializaStatus;
  ConfiguraImp.CarregaConfiguracao;
  ConfiguraDocumento(VprDImpressao.NumDocumento);

  CarCabecalhoFilial(DOC);
  DOC.add(AdicionaCharDE(' ','CONTAS EM ABERTO ATÉ '+FormatDateTime('DD/MM/YYYY',VpaDataEmAberto),75));
  DOC.add('');

  PosClienteEmAberto(ClientesEmAberto,VpaCodFilial,VpaCodCliente,VpaDataEmAberto,VpaFundoPerdido);

  VpfClienteAtual := -1;
  VpfValCliente := 0;
  VpfValTotal := 0;
  VpfPrimeiroCliente := true;
  While not ClientesEmAberto.eof do
  begin
    VpfLinha := '';
    if VpfClienteAtual <> ClientesEmAberto.FieldByName('I_COD_CLI').AsInteger then
    begin
      if not VpfPrimeiroCliente then
      begin
        DOC.Add(AdicionaCharE(' ','Total Cliente : '+FormatFloat('R$ #,###,###,###,##0.00',VpfValCliente),80));
      end;
      CarCabecalhoClienteEmAberto(DOC,ClientesEmAberto.FieldByName('I_COD_CLI').AsString + '-'+ ConfiguraImp.AcertaAcentuacao(ClientesEmAberto.FieldByName('C_NOM_CLI').AsString),ClientesEmAberto.FieldByName('C_FO1_CLI').AsString);
      VpfClienteAtual := ClientesEmAberto.FieldByName('I_COD_CLI').AsInteger;
      VpfValCliente := 0;
      VpfPrimeiroCliente := false;
    end;
    VpfLinha := VpfLinha + copy(AdicionaCharE(' ',ClientesEmAberto.FieldByName('I_NRO_NOT').AsString,6),1,6)+ ' ';
    VpfLinha := VpfLinha + copy(AdicionaCharE(' ',ClientesEmAberto.FieldByName('I_NRO_PAR').AsString,2),1,2)+ ' ';
    VpfLinha := VpfLinha + FormatDateTime('DD/MM/YYYY',ClientesEmAberto.FieldByName('D_DAT_EMI').AsDateTime)+' ';
    VpfLinha := VpfLinha + copy(AdicionaCharE(' ',FormatFloat('#,###,###,##0.00',ClientesEmAberto.FieldByName('N_VLR_PAR').AsFloat),12),1,12)+' ';
    VpfLinha := VpfLinha + FormatDateTime('DD/MM/YYYY',ClientesEmAberto.FieldByName('D_DAT_VEN').AsDateTime)+ '   ';
    VpfLinha := VpfLinha + FormatDateTime('DD/MM/YYYY',ClientesEmAberto.FieldByName('D_PRO_LIG').AsDateTime)+'  ';
    VpfValJuros := 0;
    if (DiasPorPeriodo(ClientesEmAberto.FieldByName('D_DAT_VEN').AsDateTime,Date) > ClientesEmAberto.FieldByName('I_DIA_CAR').AsInteger) and
       (ClientesEmAberto.FieldByName('D_DAT_VEN').AsDateTime < date)  then
    begin
      if (ClientesEmAberto.FieldByName('C_FUN_PER').AsString = 'S') AND
         (varia.CNPJFilial = CNPJ_Feldmann) then
        VpfValJuros := ((ClientesEmAberto.FieldByName('N_VLR_PAR').AsFloat * 1)/100)
      else
        VpfValJuros := ((ClientesEmAberto.FieldByName('N_VLR_PAR').AsFloat * Varia.Juro)/100);
      VpfValJuros := ((VpfValJuros /30)*DiasPorPeriodo(ClientesEmAberto.FieldByName('D_DAT_VEN').AsDateTime,Date));
    end;
    //retorna o valor de desconto da cotacao
    if ClientesEmAberto.FieldByName('I_QTD_PAR').AsInteger = 1 then
      VpfValJuros := VpfValJuros - FunContasAReceber.RDescontoCotacaoPgtoaVista(ClientesEmAberto.FieldByName('I_EMP_FIL').AsInteger,ClientesEmAberto.FieldByName('I_NRO_NOT').AsInteger,ClientesEmAberto.FieldByName('D_DAT_EMI').AsDateTime);
    if VpfValJuros <> 0 then
      VpfLinha := VpfLinha + copy(AdicionaCharE(' ',FormatFloat('####0.00',VpfValJuros),7),1,7) + ' '
    else
      VpfLinha := VpfLinha + AdicionaCharE(' ',' ',8);
    VpfLinha := VpfLinha + copy(AdicionaCharE(' ',FormatFloat('#,###,###,##0.00',ClientesEmAberto.FieldByName('N_VLR_PAR').AsFloat + VpfValJuros),13),1,13);
    Doc.Add(VpfLinha);
    VpfValCliente := VpfValCliente + ClientesEmAberto.FieldByName('N_VLR_PAR').AsFloat + VpfValJuros;
    VpfValTotal := VpfValTotal + ClientesEmAberto.FieldByName('N_VLR_PAR').AsFloat + VpfValJuros;
    ClientesEmAberto.Next;
  end;
  if VpfClienteAtual <> -1 then
    DOC.Add(AdicionaCharE(' ','Total Cliente : '+FormatFloat('R$ #,###,###,###,##0.00',VpfValCliente),80));

  DOC.Add('');
  DOC.Add(AdicionaCharD('*','',80));
  Doc.Add(AdicionaCharDE(' ','Valor Total em Aberto : '+FormatFloat('R$ #,###,###,###,##0.00',VpfValTotal),80));
  DOC.Add(AdicionaCharD('*','',80));

  if VprDImpressao.QtdLinhasSaltoPagina > 0 then
    AdicionaLinhaTString(DOC,VprDImpressao.QtdLinhasSaltoPagina,'');
  FechaImpressao(not VpaVisualizar,'impressao.txt');

end;

{******************************************************************************}
procedure TFuncoesImpressao.ImprimirNotaFiscal(VpaDNotaFiscal : TRBDNotaFiscal);
var
  VpfAcao : Boolean;
begin
  VpfAcao := true;
  if VpaDNotaFiscal.IndNotaImpressa then
    if not ConfirmacaoFormato(CT_NotaJaImpressa, [VpaDNotaFiscal.NumNota])  then
      VpfAcao := false;

  if VpfAcao then
  begin
    DOC.Clear;
    VprDNotaFiscal := VpaDNotaFiscal;
    VprDCliente.CodCliente := VpaDNotaFiscal.CodCliente;
    FunClientes.CarDCliente(VprDCliente);
    VprDTransportadora.CodCliente := VpaDNotaFiscal.CodTransportadora;
    FunClientes.CarDCliente(VprDTransportadora);
    FunNotaFiscal.CarObservacaoNotaFiscal(VpaDNotaFiscal,VprDCliente);
    CarServicosNotaFiscal(VpaDNotaFiscal);

    VprDImpressao.NumDocumento := Varia.NotaFiscalPadrao;
    CarDImpressao(VprDImpressao);
    FunNotaFiscal.CarFaturasImpressaoNotaFiscal(VpaDNotaFiscal,VprDImpressao.QtdColunasFatura);

    VprDNotaFiscal.NumFolhaImpressao := 1;
    VprDImpressao.IndiceProduto := 0;
    VprDImpressao.IndiceServico := 0;
    VprDImpressao.IndiceFaturas := 0;
    VprDNotaFiscal.QtdFolhaImpressao := RQtdFolhaImpressaoNota(VpaDNotaFiscal,VprDImpressao);

    ImprimirDocumento;
    FunNotaFiscal.SetaNotaImpressa(VpaDNotaFiscal.CodFilial,VpaDNotaFiscal.SeqNota);
    VprDNotaFiscal.IndNotaImpressa := true;
  end;
end;

{************************** Imprime Recibo ***********************************}
procedure TFuncoesImpressao.ImprimeRecibo(Dados: TDadosRecibo);
begin
  VprDRecibo := Dados;
  MontaDocumento('REC');
  VprDRecibo.Destroy;
end;

{************************** Imprime Cheques **********************************}
procedure TFuncoesImpressao.ImprimeCheque(Dados: TDadosCheque);
begin
  DadosCheque := Dados;
  MontaDocumento('CHE');
 // DadosCheque.Destroy;
end;

{************************** Imprime Boletos **********************************}
procedure TFuncoesImpressao.ImprimeBoleto(Dados: TDadosBoleto);
begin
  DadosBoleto := Dados;
  MontaDocumento('BOL');
  DadosBoleto.Destroy;
end;

{************************** Imprime carne ***** ******************************}
procedure TFuncoesImpressao.ImprimeCarnePagamento(Dados: TDadosCarne);
begin
  DadosCarne := Dados;
  MontaDocumento('CAR');
  DadosCarne.Destroy;
end;

{******************************************************************************}
procedure TFuncoesImpressao.ImprimirRecibo(VpaDRecibo : TDadosRecibo);
begin
  DOC.Clear;
  VprDRecibo := VpaDRecibo;
  VprDImpressao.NumDocumento := Varia.DocReciboPadrao;

  ImprimirDocumento;
end;

{************************** Imprime Envelopes *********************************}
procedure TFuncoesImpressao.ImprimeEnvelope(Dados : TDadosEnvelope);
begin
  DadosEnvelope := Dados;
  MontaDocumento('ENV');
  DadosEnvelope.Destroy;
end;

{************************** Imprime Envelopes *********************************}
procedure TFuncoesImpressao.ImprimeEtiquetaCliente(Dados : TDadosEtiquetaCliente);
begin
  DadosEtiquetaCliente := Dados;
  MontaDocumento('ETI');
  DadosEtiquetaCliente.Destroy;
end;

{ ************ Insere as Linhas do Documento. ******************************** }
procedure TFuncoesImpressao.MontaLinhas(VpaTipoDocumento: string);
var
  LinhaAtual,
  I: Integer;
  TextoInserir,
  Frase: string;
begin
  Frase := '';

  Itens.First;
  LinhaAtual := Itens.FieldByName('VERTICAL').AsInteger;
  for I := 1 to (LinhaAtual - 1) do
    DOC.Add(' ');
  while not Itens.EOF do
  begin
    // Verificar Pendências.
    while VerificaPendencias(Frase, LinhaAtual, Itens.FieldByName('HORIZONTAL').AsInteger) do
    begin
    end;
    // Acha o texto a ser inserido;
    TextoInserir := ProcuraCampoInserir(Itens.FieldByName('SEQUENCIAL').AsInteger, VpaTipoDocumento);
    if LinhaAtual = Itens.FieldByName('VERTICAL').AsInteger then
    begin
      Frase := Frase +
               ConfiguraImp.ConfiguraTexto(
                 Itens.FieldByName('NEGRITO').AsString,
                 Itens.FieldByName('ITALICO').AsString,
                 Itens.FieldByName('CONDENSADO').AsString,
                 Itens.FieldByName('REDUZIDO').AsString) +
               ConfiguraImp.ADicionaTexto(TextoInserir, Itens.FieldByName('ALINHAMENTO').AsString, Itens.FieldByName('TAMANHO').AsInteger, Itens.FieldByName('HORIZONTAL').AsInteger);
    end
    else
    begin
      while VerificaPendencias(Frase, LinhaAtual, 1000) do
      begin
      end;
      DOC.Add(Frase);
      // Zera a frase;
      Frase := '';
      // Zera a coluna a inserir;
      ConfiguraImp.Coluna := 1;
      // Adiciona linhas em branco que pulou.
      for I:= LinhaAtual to (Itens.FieldByName('VERTICAL').AsInteger - 2) do
      begin
        while VerificaPendencias(Frase, (I + 1) , 1000) do
        begin
        end;
        DOC.Add(Frase);
        ConfiguraImp.Coluna := 1;
        Frase := '';
      end;

      LinhaAtual:= Itens.FieldByName('VERTICAL').AsInteger;
      while VerificaPendencias(Frase, LinhaAtual, Itens.FieldByName('HORIZONTAL').AsInteger) do
      begin
      end;

      Frase := Frase +
             ConfiguraImp.ConfiguraTexto(
               Itens.FieldByName('NEGRITO').AsString,
               Itens.FieldByName('ITALICO').AsString,
               Itens.FieldByName('CONDENSADO').AsString,
               Itens.FieldByName('REDUZIDO').AsString) +
             ConfiguraImp.ADicionaTexto(TextoInserir, Itens.FieldByName('ALINHAMENTO').AsString, Itens.FieldByName('TAMANHO').AsInteger, Itens.FieldByName('HORIZONTAL').AsInteger);
    end;
    Itens.Next;
  end;
  if (Frase <> '') then
    DOC.Add(Frase);
  repeat
  begin
    Frase := '';
    Inc(LinhaAtual);
    ConfiguraImp.Coluna := 1;
    while VerificaPendencias(Frase, LinhaAtual, 1000) do
    begin
    end;
    if (Frase <> '') then
      DOC.Add(Frase);
  end;
  until (Frase = '');
end;

{ Retorna o Conteudo do Campo a Inserir de Acordo com o tipo de documento utilizado e o capmo a ser inserido ***** }
function TFuncoesImpressao.ProcuraCampoInserir(VpaSequencial: Integer; TipoDoc: string): string;
begin
  Result := '';
  // CHEQUE.
  if (TipoDoc = 'CHE') then
  begin
    case VpaSequencial of
      01 : Result := CabecalhoDOC.CharEsquerda + DeletaEspacoDE(FormatFloat('###,###,###,##0.00', DadosCheque.ValorCheque)) + CabecalhoDOC.CharDireita;
      02 : Result := DadosCheque.DescValor1;
      03 : Result := DadosCheque.DescValor2;
      04 : Result := DadosCheque.DescNominal;
      05 : Result := DadosCheque.CidadeEmitido;
      06 : Result := DadosCheque.DiaDeposito;
      07 : if CabecalhoDOC.MesNumerico then
             Result := DadosCheque.MesDeposito
           else
             Result := UpperCase((NumeroMes(StrToInt(DadosCheque.MesDeposito), False)));
      08 : Result := DadosCheque.AnodeDeposito;
      09 : Result := DadosCheque.Traco;
      10 : Result := DadosCheque.Numero;
      11 : Result := DadosCheque.Agencia;
      12 : Result := DadosCheque.Banco;
      13 : Result := DadosCheque.Conta;
      14 : Result := DadosCheque.Observ;
    end;
    Exit;
  end;
  // DUPLICATA.
  if (TipoDoc = 'NOT') then
  begin
    case VpaSequencial of
      01 : Result :=(DadosPromissoria.DiaVencimento);
      02 : begin
             if  CabecalhoDOC.MesNumerico then
               Result :=(DadosPromissoria.MesVencimento)
             else
               Result :=UpperCase(((NumeroMes(StrToInt(DadosPromissoria.MesVencimento), False))));
           end;
      03 : Result :=(DadosPromissoria.AnoVencimento);
      04 : Result :=(DadosPromissoria.NumeroDocumento);
           // Adiciona Caracteres de Controle;
      05 : Result :=((CabecalhoDOC.CharEsquerda + DeletaEspacoDE(FormatFloat('###,###,###,###,##0.00', DadosPromissoria.ValorDocumento)) +  CabecalhoDOC.CharDireita));
      06 : Result :=(DadosPromissoria.DescricaoDuplicata1);
      07 : Result :=(DadosPromissoria.DescricaoDuplicata2);
      08 : Result :=(DadosPromissoria.PessoaDuplicata);
      09 : Result :=(DadosPromissoria.NumeroCGCCPF);
           // Trata Descrição do Valor.
      10 : Result :=(DadosPromissoria.DescricaoValor1);
      11 : Result :=(DadosPromissoria.DescricaoValor2);
      12 : Result :=(DadosPromissoria.DescricaoPagamento);
      13 : Result :=(DadosPromissoria.Emitente);
      14 : Result :=(DadosPromissoria.CPFCGCEmitente);
      15 : Result :=(DadosPromissoria.EnderecoEmitente);
    end;
    Exit;
  end;
  // BOLETO BANCÁRIO.
  if (TipoDoc = 'BOL') then
  begin
    case VpaSequencial of
      01 : Result :=(DadosBoleto.LocalPagamento);
      02 : Result :=(DadosBoleto.Cedente);
      03 : Result :=DateToStr(DadosBoleto.DataDocumento);
      04 : Result :=(DadosBoleto.NumeroDocumento);
      05 : Result :=(DadosBoleto.EspecieDocumento);
      06 : Result :=(DadosBoleto.Aceite);
      07 : Result :=DateToStr(DadosBoleto.DataProcessamento);
      08 : Result :=(DadosBoleto.Carteira);
      09 : Result :=(DadosBoleto.Especie);
      10 : Result :=(DadosBoleto.Quantidade);
      11 : Result :=FormatFloat('###,###,###,###,##0.00', DadosBoleto.Valor);
      12 : Result :=DateToStr(DadosBoleto.Vencimento);
      13 : Result :=(DadosBoleto.Agencia);
      14 : Result :=(DadosBoleto.NossoNumero);
      15 : Result :=FormatFloat('###,###,###,###,##0.00', DadosBoleto.ValorDocumento);
      16 : Result :=FormatFloat('###,###,###,###,##0.00', DadosBoleto.Desconto);
      17 : Result :=FormatFloat('###,###,###,###,##0.00', DadosBoleto.Outras);
      18 : Result :=FormatFloat('###,###,###,###,##0.00', DadosBoleto.MoraMulta);
      19 : Result :=FormatFloat('###,###,###,###,##0.00', DadosBoleto.Acrescimos);
      20 : Result :=FormatFloat('###,###,###,###,##0.00', DadosBoleto.ValoCobrado);
      21 : begin
             if  (DadosBoleto.Instrucoes.Count > 0) then
             begin
               Result :=(DadosBoleto.Instrucoes[0]);
               // Adicionar em pendências.
               CriaPendencia(0, DadosBoleto.Instrucoes);
             end
             else Result := '';
           end;
      22 : begin
             if (DadosBoleto.Sacado.Count > 0) then
             begin
               Result :=(DadosBoleto.Sacado[0]);
               // Adicionar em pendências.
               CriaPendencia(1, DadosBoleto.Sacado);
             end
             else Result := '';
           end;
    end;
    Exit;
  end;
  // CARNE PAGAMENTO.
  if (TipoDoc = 'CAR') then
  begin
    with DadosCarne do
    begin
      case VpaSequencial of
        01 : Result :=CodigoClienteC;
        02 : Result :=NomeClienteC;
        03 : Result :=ParcelaC;
        04 : Result :=DateToStr(VencimentoC);
        05 : Result :=NumeroDocumentoC;
        06 : Result :=FormatFloat('###,###,###,##0.00', ValorParcelaC);
        07 : Result :=ObservacoesC;
        08 : Result :=FormatFloat('###,###,###,##0.00', AcrDescC);
        09 : Result :=AutentificacaoC;
        10 : Result :=FormatFloat('###,###,###,##0.00', ValorTotalC);
        11 : Result :=CodigoClienteL;
        12 : Result :=NomeClienteL;
        13 : Result :=ParcelaL;
        14 : Result :=DateToStr(VencimentoL);
        15 : Result :=NumeroDocumentoL;
        16 : Result :=FormatFloat('###,###,###,##0.00', ValorParcelaL);
        17 : Result :=ObservacoesL;
        18 : Result :=FormatFloat('###,###,###,##0.00', AcrDescL);
        19 : Result :=AutentificacaoL;
        20 : Result :=FormatFloat('###,###,###,##0.00', ValorTotalL);
      end;
    end;
    Exit;
  end;
  // RECIBO.
  if (TipoDoc = 'REC') then
  begin
    with VprDRecibo do
    begin
      case VpaSequencial of
        01 : Result := Numero;
        02 : Result := FormatFloat('###,###,###,##0.00', Valor);
        03 : Result := Pessoa;
        04 : Result := DescValor1;
        05 : Result := DescValor2;
        06 : Result := DescReferente1;
        07 : Result := DescReferente2;
        08 : Result := Cidade;
        09 : Result := Dia;
        10 : Result := Mes;
        11 : Result := Ano;
        12 : Result := Emitente;
        13 : Result := CGCCPFGREmitente;
        14 : Result := EnderecoEmitente;
      end;
    end;
    Exit;
  end;
  // DUPLICATA.
  if (TipoDoc = 'DUP') then
  begin
    with DadosDuplicata do
    begin
      case VpaSequencial of
        01 : Result := DateToStr(DataEmissao);
        02 : Result := Numero;
        03 : Result := FormatFloat('###,###,###,##0.00', Valor);
        04 : Result := NroOrdem;
        05 : Result := DateToStr(DataVencimento);
        06 : Result := FormatFloat('###,###,###,##0.00', DescontoDe);
        07 : Result := DateToStr(DataPagtoAte);
        08 : Result := CondEspeciais;
        09 : Result := NomeSacado;
        10 : Result := EnderecoSacado;
        11 : Result := CidadeSacado;
        12 : Result := EstadoSacado;
        13 : Result := InscricaoCGC;
        14 : Result := InscricaoEstadual;
        15 : Result := PracaPagto;
        16 : Result := DescValor1;
        17 : Result := DescValor2;
        18 : Result := FormatFloat('###,###,###,##0.00', ValorTotal);
        19 : Result := Representante;
        20 : Result := Cod_Representante;
        21 : Result := CEP;
        22 : Result := Cod_Sacado;
        23 : result := Bairro;
        24 : result := Varia.NomeFilial;
      end;
    end;
    Exit;
  end;

  // ENVELOPE.
  if (TipoDoc = 'ENV') then
  begin
    with DadosEnvelope do
    begin
      case VpaSequencial of
        01 : Result := nomeDes;
        02 : Result := ruaDes;
        03 : Result := bairroDes;
        04 : Result := cidade_estadoDes;
        05 : Result := cepDes;
        06 : Result := ContatoDes;
        07 : Result := nomeRem;
        08 : Result := ruaRem;
        09 : Result := bairroRem;
        10 : Result := cidade_estadoRem;
        11 : Result := cepRem;
      end;
    end;
    Exit;
  end;

  // Etiqueta de Cliente.
  if (TipoDoc = 'ETI') then
  begin
    with DadosEtiquetaCliente do
    begin
      case VpaSequencial of
        01 : Result := nome;
        02 : Result := nome1;
        03 : Result := nome2;
        04 : Result := Endereco;
        05 : Result := Endereco1;
        06 : Result := Endereco2;
        07 : Result := bairro;
        08 : Result := bairro1;
        09 : Result := bairro2;
        10 : Result := cidade;
        11 : Result := cidade1;
        12 : Result := cidade2;
        13 : Result := Estado;
        14 : Result := Estado1;
        15 : Result := Estado2;
        16 : Result := CEP;
        17 : Result := CEP1;
        18 : Result := CEP2;
        19 : result := Complemento;
        20 : result := Complemento1;
        21 : result := Complemento2;
      end;
    end;
    Exit;
  end;

end;

{******************************************************************************}
procedure TFuncoesImpressao.CarServicosNotaFiscal(VpaDNota : TRBDNotaFiscal);
var
  VpfLaco, VpfLacoDescricao : Integer;
  VpfDServico : TRBDNotaFiscalServico;
  VpfDescricao : TStringList;
begin
  VprServicosNotaFiscal.Clear;
  for vpfLaco := 0 to VpaDNota.Servicos.Count - 1 do
  begin
    VpfDServico := TRBDNotaFiscalServico(VpaDNota.Servicos.Items[VpfLaco]);
    VpfDescricao := DivideString(VpfDServico.NomServico+' '+ VpfDServico.DesAdicional,80);
    VprServicosNotaFiscal.Add(AdicionaCharD(' ',VpfDescricao.Strings[0],85)+AdicionaCharE(' ',FormatFloat('#,###,###,##0.00',VpfDServico.ValTotal),15));
    for VpfLacoDescricao := 1 to VpfDescricao.Count - 1 do
    begin
      VprServicosNotaFiscal.add(VpfDescricao.Strings[VpfLacoDescricao]);
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesImpressao.CarDImpressao(VpaDImpressao : TRBDImpressao);
begin
  AdicionaSQLAbreTabela(AUX,'Select * from CAD_DOC '+
                            'Where I_NRO_DOC = '+IntToStr(VpaDImpressao.NumDocumento));
  with VpaDImpressao do
  begin
    NomDocumento := AUX.FieldByName('C_NOM_DOC').AsString;
    QtdDocumentos := AUX.FieldByName('I_QTD_PAG').AsInteger;
    SeqImpressora := AUX.FieldByName('I_SEQ_IMP').AsInteger;
    DesTipoDocumento := AUX.FieldByName('C_TIP_DOC').AsString;
    QtdLinhasSaltoPagina := AUX.FieldByName('N_CAB_PAG').AsInteger;
    QtdLinhasRodDocumento := AUX.FieldByName('N_ROD_DOC').AsInteger;
    QtdLinhasFatura := AUX.FieldByName('I_QTD_FAT').AsInteger;
    QtdColunasFatura := AUX.FieldByName('I_QTD_COL').AsInteger;
    QtdLinhasObservacao := AUX.FieldByName('I_QTD_OBS').AsInteger;
    QtdLinhasProdutos := AUX.FieldByName('I_QTD_LIN').AsInteger;
    QtdLinhasDadosAdicionais := AUX.FieldByName('I_QTD_ADI').AsInteger;
    QtdLinhasServicos := AUX.FieldByName('I_QTD_SER').AsInteger;
    IndAltLinhaReduzida := (UpperCase(AUX.FieldByName('C_FLA_LIN').AsString) = 'S');
    IndDeteccaoFimPapel := (UpperCase(AUX.FieldByName('C_FLA_PAP').AsString) = 'S');
    IndFolhaemBranco := (UpperCase(AUX.FieldByName('C_FLA_FOR').AsString) = 'B');
    if AUX.FieldByName('C_CHR_DIR').AsString <> '' then
       DesCharDireita := AUX.FieldByName('C_CHR_DIR').AsString[1]
    else
      DesCharDireita := #0;
    if AUX.FieldByName('C_CHR_ESQ').AsString <> '' then
       DesCharEsquerda := AUX.FieldByName('C_CHR_ESQ').AsString[1]
    else
      DesCharEsquerda := #0;
  end;
  Aux.Close;
  CarDItemImpressao(VpaDImpressao);
end;

{******************************************************************************}
procedure TFuncoesImpressao.CarDItemImpressao(VpaDImpressao : TRBDImpressao);
var
  VpfDItemImpressao : TRBDItemImpressao;
begin
  FreeTObjectsList(VpaDImpressao.ItensImpressao);
  VpaDImpressao.ItensImpressao.Clear;
  VpaDImpressao.ItensDocumento.clear;
  AdicionaSQLAbreTabela(AUX,'Select * from MOV_DOC '+
                            ' Where I_NRO_DOC = '+ IntToStr(VpaDImpressao.NumDocumento)+
                            ' and C_FLA_IMP = ''S'''+
                            ' order by N_POS_VER, N_POS_HOR');
  While not AUX.eof do
  begin
    VpfDItemImpressao := VpaDImpressao.AddItemImpressao;
    VpfDItemImpressao.SeqDocumento := AUX.FieldByName('I_MOV_SEQ').AsInteger;
    VpfDItemImpressao.PosVertical := AUX.FieldByName('N_POS_VER').AsInteger;
    VpfDItemImpressao.PosHorizontal := AUX.FieldByName('N_POS_HOR').AsInteger;
    VpfDItemImpressao.TamCampo := AUX.FieldByName('I_TAM_CAM').AsInteger;
    VpfDItemImpressao.NomCampo := AUX.FieldByName('C_DES_CAM').AsString;
    VpfDItemImpressao.DesAlinhamento := AUX.FieldByName('C_DIR_ESQ').AsString;
    VpfDItemImpressao.IndNegrito := (UpperCase(AUX.FieldByName('C_FLA_NEG').AsString) = 'S');
    VpfDItemImpressao.IndItalico := (UpperCase(AUX.FieldByName('C_FLA_ITA').AsString) = 'S');
    VpfDItemImpressao.IndCondessado := (UpperCase(AUX.FieldByName('C_FLA_CND').AsString) = 'S');
    VpfDItemImpressao.IndReduzido := (UpperCase(AUX.FieldByName('C_FLA_RED').AsString) = 'S');
    VpfDItemImpressao.IndItemDocumento := false;
    Aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesImpressao.CarDItensDocumento(VpadImpressao :TRBDImpressao; VpaProximoItem : TRBDItemImpressao;VpaDoc : TStringList);
var
  VpfLaco,VpfLacoLinha, VpfQtdLinhasPagina,VpfQtdLinhasPorPagina : Integer;
  VpfDItemImpressao : TRBDItemImpressao;
  VpfValorCampo,VpfLinha : String;
begin
  VpadImpressao.NumLinhaAtual := TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[0]).PosVertical;
  VpaDImpressao.IndiceItem := RIndiceItem(VpadImpressao,TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[0]));
  VpfQtdLinhasPorPagina := TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[0]).QtdLinhasItem;
  VpfQtdLinhasPagina := 0;
  if not((VprDImpressao.DesTipoDocumento = 'NFP') or (VprDImpressao.DesTipoDocumento = 'NFS'))then
    VpfQtdLinhasPorPagina := 999;

  //carrega os titulos das colunas
  if VpaDImpressao.IndFolhaemBranco then
  begin
    for VpfLaco := 0 to VpadImpressao.ItensDocumento.Count - 1 do
    begin
        VpfDItemImpressao := TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[VpfLaco]);
        if VpfDItemImpressao.IndItemDocumento then
        begin
          VpfValorCampo := RValorTituloItemInserir(VpaDImpressao,VpfDItemImpressao);
          VpfLinha := AdicionaCharD(' ',VpfLinha,(VpfDItemImpressao.PosHorizontal + VpaDImpressao.QtdComandosLinha));
          VpfLinha := VpfLinha + RConfiguracaoCampo(VpaDImpressao,VpfDItemImpressao) + RValorCampoFormatado(VpfValorCampo,VpfDItemImpressao,false);
        end;
    end;
    VpaDoc.Add(VpfLinha);
  end;
  //carrega os valores dos items
  While not FimDadosItemDocumento(VpadImpressao,TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[0])) and
        (VpfQtdLinhasPagina < VpfQtdLinhasPorPagina) do
  begin
    VpfLinha := '';
    VpaDImpressao.QtdComandosLinha :=0;
    for VpfLaco := 0 to VpadImpressao.ItensDocumento.Count - 1 do
    begin
      VpfDItemImpressao := TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[VpfLaco]);
      if (VpfDItemImpressao.IndItemDocumento) or (VpfDItemImpressao.PosVertical = VpadImpressao.NumLinhaAtual) then
      begin
        VpfValorCampo := RValorInserir(VpaDImpressao,VpfDItemImpressao);
        VpfLinha := AdicionaCharD(' ',VpfLinha,(VpfDItemImpressao.PosHorizontal + VpaDImpressao.QtdComandosLinha));
        VpfLinha := VpfLinha + RConfiguracaoCampo(VpaDImpressao,VpfDItemImpressao) + RValorCampoFormatado(VpfValorCampo,VpfDItemImpressao,false);
      end;
    end;
    VpaDoc.Add(VpfLinha);
    inc(VpaDImpressao.NumLinhaAtual);
    inc(VpadImpressao.IndiceItem);
    AdicionaIndiceNotaFiscal(VpadImpressao,TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[0]));
    inc(VpfQtdLinhasPagina);
  end;
  if (VpfQtdLinhasPagina >= VpfQtdLinhasPorPagina)and
     not FimDadosItemDocumento(VpadImpressao,TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[0])) then
  begin
    if not(( (VpaDImpressao.DesTipoDocumento = 'NFP') or (VpaDImpressao.DesTipoDocumento = 'NFS')) and
       (TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[0]).SeqDocumento = 74)) then
      VpadImpressao.IndImprimeAsterisco := true;
  end;

  if (VpadImpressao.IndFolhaemBranco) and (varia.CNPJFilial <> CNPJ_BLOCONORTE) and
     (varia.CNPJFilial <> CNPJ_Majatex) then
  begin
    vpaDoc.Add('');
    VpadImpressao.NumLinhaAtual := VpaProximoItem.PosVertical;
  end
  else
  begin
    VpfDItemImpressao := TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[0]);
    for VpfLacoLinha := VpaDImpressao.NumLinhaAtual to (VpfDItemImpressao.PosVertical+VpfDItemImpressao.QtdLinhasItem) do
    begin
      VpfLinha := '';
      VpaDImpressao.QtdComandosLinha :=0;
      for VpfLaco := 0 to VpadImpressao.ItensDocumento.Count - 1 do
      begin
        VpfDItemImpressao := TRBDItemImpressao(VpadImpressao.ItensDocumento.Items[VpfLaco]);
        if not(VpfDItemImpressao.IndItemDocumento) and (VpfDItemImpressao.PosVertical = VpadImpressao.NumLinhaAtual) then
        begin
          VpfValorCampo := RValorInserir(VpaDImpressao,VpfDItemImpressao);
          VpfLinha := AdicionaCharD(' ',VpfLinha,(VpfDItemImpressao.PosHorizontal + VpaDImpressao.QtdComandosLinha));
          VpfLinha := VpfLinha + RConfiguracaoCampo(VpaDImpressao,VpfDItemImpressao) + RValorCampoFormatado(VpfValorCampo,VpfDItemImpressao,false);
        end;
      end;
      VpaDoc.Add(VpfLinha);
      inc(VpaDImpressao.NumLinhaAtual);
    end;
  end;
  VpadImpressao.ItensDocumento.Clear;
  VpadImpressao.QtdComandosLinha := 0;
  VpadImpressao.IndiceItem := 0;
end;

{******************************************************************************}
procedure TFuncoesImpressao.CarDocumento(VpaDImpressao : TRBDImpressao; VpaDoc : TStringList);
var
  VpfLaco, VpfLacoPulaLinha : Integer;
  VpfLinha :String;
  VpfDItemImpressao : TRBDItemImpressao;
  VpfValorCampo : String;
  VpfIndItalido,VpfIndNegrito,VpfIndCondensado, VpfIndReduzido : Boolean;
begin
  VpfLinha := '';
  VpaDImpressao.NumLinhaAtual := 1;
  VpaDImpressao.QtdComandosLinha := 0;
  VpaDImpressao.IndiceItem := 0;
  For VpfLaco := 0 to VpaDImpressao.ItensImpressao.Count - 1 do
  begin
    VpfDItemImpressao := TRBDItemImpressao(VpaDImpressao.ItensImpressao.Items[Vpflaco]);
    if VpaDImpressao.NumLinhaAtual > VpfDItemImpressao.PosVertical then
      VpaDImpressao.NumLinhaAtual := VpfDItemImpressao.PosVertical;

    if (VpaDImpressao.NumLinhaAtual < VpfDItemImpressao.PosVertical) then
    begin
      if VpaDImpressao.ItensDocumento.Count > 0 then
      begin
        if (VpfDItemImpressao.PosVertical > (TRBDItemImpressao(VpaDImpressao.ItensDocumento.Items[0]).PosVertical + TRBDItemImpressao(VpaDImpressao.ItensDocumento.Items[0]).QtdLinhasItem)) then
          CarDItensDocumento(VpaDImpressao,VpfDItemImpressao,VpaDoc)
        else
          VpaDImpressao.NumLinhaAtual := VpfDItemImpressao.PosVertical;
      end
      else
      begin
        VpaDoc.Add(VpfLinha);
        inc(VpaDImpressao.NumLinhaAtual);
        VpfLinha := '';
        VpaDImpressao.QtdComandosLinha :=0;
      end;
    end;

    for VpfLacoPulaLinha := VpaDImpressao.NumLinhaAtual to VpfDItemImpressao.PosVertical -1 do
    begin
      VpaDoc.Add('');
      inc(VpaDImpressao.NumLinhaAtual);
    end;

    VpfValorCampo := RValorInserir(VpaDImpressao,VpfDItemImpressao);
    if (VpfDItemImpressao.IndItemDocumento) or (VpaDImpressao.ItensDocumento.Count > 0) then
      VpaDImpressao.ItensDocumento.Add(VpfDItemImpressao)
    else
    begin
      VpfLinha := AdicionaCharD(' ',VpfLinha,(VpfDItemImpressao.PosHorizontal + VpaDImpressao.QtdComandosLinha));
      VpfLinha := VpfLinha + RConfiguracaoCampo(VpaDImpressao,VpfDItemImpressao) + RValorCampoFormatado(VpfValorCampo,VpfDItemImpressao,VpaDImpressao.IndImprimeAsterisco);
    end;
  end;

  if VpaDImpressao.ItensDocumento.Count > 0 then
    CarDItensDocumento(VpaDImpressao,VpfDItemImpressao,VpaDoc)
  else
    VpaDoc.Add(VpfLinha);

  VpfIndNegrito := VpfDItemImpressao.IndNegrito;
  VpfIndItalido := VpfDItemImpressao.IndItalico;
  VpfIndCondensado := VpfDItemImpressao.IndCondessado;
  VpfIndReduzido := VpfDItemImpressao.IndReduzido;
  VpfDItemImpressao.IndNegrito := false;
  VpfDItemImpressao.IndItalico := false;
  VpfDItemImpressao.IndCondessado := false;
  VpfDItemImpressao.IndReduzido := false;
  VpaDoc.Strings[VpaDoc.Count - 1] := VpaDoc.Strings[VpaDoc.Count - 1]+RConfiguracaoCampo(VpaDImpressao,VpfDItemImpressao);
  VpfDItemImpressao.IndNegrito := VpfIndNegrito;
  VpfDItemImpressao.IndItalico := VpfIndItalido;
  VpfDItemImpressao.IndCondessado := VpfIndCondensado;
  VpfDItemImpressao.IndReduzido := VpfIndReduzido;
end;

{******************************************************************************}
function TFuncoesImpressao.RIndiceItem(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : Integer;
begin
  result := 0;
  if (VpaDImpressao.DesTipoDocumento = 'NFP') or (VpaDImpressao.DesTipoDocumento = 'NFS')then
  begin
    case VpaDItemImpressao.SeqDocumento of
      49..59 : result := VpaDImpressao.IndiceProduto;
      61..72 : result := VpaDImpressao.IndiceFaturas;
      75 : result := VpaDImpressao.IndiceServico;

    end;
  end;
end;

{******************************************************************************}
function TFuncoesImpressao.RQtdFolhaImpressaoNota(VpaDNotaFiscal : TRBDNotaFiscal;VpaDImpressao : TRBDimpressao):Integer;
Var
  VpfPaginasServico, VpfQtdPaginasFatura : Integer;
begin
  result := (VpaDNotaFiscal.Produtos.Count div VpaDImpressao.QtdLinhasProdutos);
  if (VpaDNotaFiscal.Produtos.Count mod VpaDImpressao.QtdLinhasProdutos) > 0 then
    inc(result);
  VpfPaginasServico := (VpaDNotaFiscal.Servicos.Count div VpaDImpressao.QtdLinhasServicos);
  if (VpaDNotaFiscal.Servicos.Count mod VpaDImpressao.QtdLinhasServicos) > 0 then
    inc(VpfPaginasServico);
  if VpfPaginasServico > result then
    result := VpfPaginasServico;

  VpfQtdPaginasFatura := VprDNotaFiscal.Faturas.Count  div VpaDImpressao.QtdLinhasFatura;
  if (VprDNotaFiscal.Faturas.Count mod VpaDImpressao.QtdLinhasFatura) > 0 then
    inc(VpfQtdPaginasFatura);
  if VpfQtdPaginasFatura > result then
    result := VpfQtdPaginasFatura;
  if result = 0 then
    result := 1;
end;

{******************************************************************************}
function TFuncoesImpressao.RValorCampoFormatado(VpaValor : String; VpaDItemImpressao : TRBDItemImpressao;VpaIndImprimeAsterisco : Boolean) : String;
begin
  if ImprimirComoAsterisco(VpaIndImprimeAsterisco,VpaDItemImpressao) then
    result := AdicionaCharD('*','',VpaDItemImpressao.TamCampo)
  else
  begin
    VpaValor := ConfiguraImp.AcertaAcentuacao(VpaValor);
    if VpaDItemImpressao.DesAlinhamento = 'E' then
      result := AdicionaCharD(' ',VpaValor,VpaDItemImpressao.TamCampo)
    else
      result := AdicionaCharE(' ',VpaValor,VpaDItemImpressao.TamCampo);
    if length(Result) > VpaDItemImpressao.TamCampo then
      result := copy(result,1,VpaDItemImpressao.TamCampo);
  end;
end;

{******************************************************************************}
function TFuncoesImpressao.RConfiguracaoCampo(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
begin
  result := '';
  if VpaDItemImpressao.IndNegrito <> (ConfiguraImp.Status.Negrito = 'S') then
  begin
    if VpaDItemImpressao.IndNegrito then
    begin
      Result := Result + ConfiguraImp.ConfigImp.NegritoSim;
      ConfiguraImp.Status.Negrito := 'S';
    end
    else
    begin
      Result := Result + ConfiguraImp.ConfigImp.NegritoNao;
      ConfiguraImp.Status.Negrito := 'N';
    end;
    VpaDImpressao.QtdComandosLinha := VpaDImpressao.QtdComandosLinha + length(ConfiguraImp.ConfigImp.NegritoSim);
  end;
  //Italico
  if VpaDItemImpressao.IndItalico <> (ConfiguraImp.Status.Italico = 'S') then
  begin
    if VpaDItemImpressao.IndItalico then
    begin
      Result := Result + ConfiguraImp.ConfigImp.ItalicoSim;
      ConfiguraImp.Status.Italico := 'S';
    end
    else
    begin
      Result := Result + ConfiguraImp.ConfigImp.ItalicoNao;
      ConfiguraImp.Status.Italico := 'N';
    end;
    VpaDImpressao.QtdComandosLinha := VpaDImpressao.QtdComandosLinha + length(ConfiguraImp.ConfigImp.ItalicoSim);
  end;
  //condessado
  if VpaDItemImpressao.IndCondessado <> (ConfiguraImp.Status.Condensado = 'S') then
  begin
    if VpaDItemImpressao.IndCondessado then
    begin
      Result := Result + ConfiguraImp.ConfigImp.CondensadoSim;
      ConfiguraImp.Status.Condensado := 'S';
    end
    else
    begin
      Result := Result + ConfiguraImp.ConfigImp.CondensadoNao;
      ConfiguraImp.Status.Condensado := 'N';
    end;
    VpaDImpressao.QtdComandosLinha := VpaDImpressao.QtdComandosLinha + length(ConfiguraImp.ConfigImp.CondensadoSim);
  end;
  //reduzido
  if VpaDItemImpressao.IndReduzido <> (ConfiguraImp.Status.Reduzido = 'S') then
  begin
    if VpaDItemImpressao.IndReduzido then
    begin
      Result := Result + ConfiguraImp.ConfigImp.ReduzidoSim;
      ConfiguraImp.Status.Reduzido := 'S';
    end
    else
    begin
      Result := Result + ConfiguraImp.ConfigImp.ReduzidoNao;
      ConfiguraImp.Status.Reduzido := 'N';
    end;
    VpaDImpressao.QtdComandosLinha := VpaDImpressao.QtdComandosLinha + length(ConfiguraImp.ConfigImp.ReduzidoSim);
  end;
end;

{******************************************************************************}
function TFuncoesImpressao.RValorInserirPedido(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
begin
  result := '';
  case VpaDItemImpressao.SeqDocumento of
    01 : result := IntToStr(VprDCotacao.LanOrcamento);
    02 : result := IntToStr(VprDCliente.CodCliente) +'-'+ VprDCliente.NomCliente;
    03 : Result := VprDCliente.CGC_CPF;
    04 : result := FormatDateTime('DD/MM/YYYY',VprDCotacao.DatOrcamento);
    05 : result := VprDCliente.DesEndereco+', '+ VprDCliente.NumEndereco+ ' - '+VprDCliente.DesComplementoEndereco;
    06 : result := VprDCliente.DesBairro;
    07 : result := VprDCliente.CepCliente;
    08 : result := FormatDatetime('DD/MM/YYYY',VprDCotacao.DatOrcamento);
    09 : result := VprDCliente.DesCidade;
    10 : result := VprDCliente.Fone_FAX;
    11 : result := VprDCliente.DesUF;
    12 : Result := VprDCliente.InscricaoEstadual;
    13 : result := FormatDateTime('HH:MM',VprDCotacao.HorOrcamento);
    14 : result := FormatFloat(varia.mascaraValor, VprDCotacao.ValTotalProdutos);
    15 : result := FormatFloat(varia.mascaraValor, VprDCotacao.ValTotal);
    16 : result := VprDTransportadora.NomCliente ;
    17 : result := VprDCotacao.PlaVeiculo;
    18 : result := VprDCotacao.UFVeiculo;
    19 : result := VprDTransportadora.CGC_CPF;
    20 : result := VprDTransportadora.DesEndereco;
    21 : result := VprDTransportadora.DesCidade;
    22 : result := VprDTransportadora.DesUF;
    23 : result := VprDTransportadora.InscricaoEstadual;
    24 : result := IntToStr(VprDCotacao.QtdVolumesTransportadora);
    25 : result := VprDCotacao.EspTransportadora;
    26 : result := VprDCotacao.MarTransportadora;
    27 : result := IntToStr(VprDCotacao.NumTransportadora);
    28 : result := FormatFloat('0.00',VprDCotacao.PesBruto);
    29 : result := FormatFloat('0.00',VprDCotacao.PesLiquido);
    30 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
             result :=  TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).CodProduto;
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    31 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
             result :=  TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).NomProduto;
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    32 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
             result :=  TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).UM;
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    33 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
            if (Varia.CNPJFilial = CNPJ_Majatex)and (VprDImpressao.DesTipoDocumento = 'PED') Then
              result :=  FormatFloat(varia.MascaraQTD,TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).QtdProduto - TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).QtdBaixadoNota)
            else
              result :=  FormatFloat(varia.MascaraQTD,TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).QtdProduto);
            VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    34 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
             result :=  FormatFloat(varia.MascaraValor,TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).ValUnitario);
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    35 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
             result :=  FormatFloat(varia.MascaraValor,TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).ValTotal);
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    45 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
             result :=  FormatFloat('#0.00%',TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).PerDesconto);
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    36 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.DesObservacao.Count then
           begin
             result :=  VprDCotacao.DesObservacao.Strings[VpaDImpressao.IndiceItem];
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    37 : result := Varia.NomeFilial ;
    38 : result := varia.EnderecoFilial;
    39 : result := Varia.BairroFilial;
    40 : result := varia.CepFilial;
    41 : result := varia.CidadeFilial + '/'+Varia.UFFilial;
    42 : result := Varia.EMailFilial;
    43 : result := varia.SiteFilial;
    44 : result := Varia.FoneFilial;
    46 : result := FunNotaFiscal.RetornaVendedorNota(VprDCotacao.CodVendedor);
    47 : result := FunNotaFiscal.RetornaCondPagamento(VprDCotacao.CodCondicaoPagamento);
    48 : begin
           if VprDCotacao.PerDesconto <> 0 then
           begin
             if VprDCotacao.PerDesconto > 0 then
               result := 'Desconto : '+ FormatFloat('0.00%',VprDCotacao.PerDesconto)
             else
               result := 'Acréscimo : '+FormatFloat('0.00%',VprDCotacao.PerDesconto*-1);
           end
           else
             if VprDCotacao.ValDesconto <> 0 then
             begin
               if VprDCotacao.ValDesconto > 0 then
                 result := 'Desconto : '+ FormatFloat(CurrencyString+' #,###,###,##0.00',VprDCotacao.ValDesconto)
               else
                 result := 'Acréscimo : '+FormatFloat(CurrencyString+' #,###,###,##0.00',VprDCotacao.ValDesconto*-1);
             end;
         end;
    49 : result := FormatDateTime('DD/MM/YYYY',VprDCotacao.DatPrevista);
    50 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Parcelas.Count then
           begin
             result :=  VprDCotacao.Parcelas.Strings[VpaDImpressao.IndiceItem];
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    51 : result := FormatDateTime('HH:MM',VprDCotacao.HorPrevista);
    52 : result := 'Cotação válida por 10 dias';
    53 : begin
           if Varia.CondPagtoVista = VprDCotacao.CodCondicaoPagamento then
             result := 'Valor Total c/ Desconto : ' + FormatFloat('R$ ###,###,###,##0.00',VprDCotacao.ValTotalComDesconto)
           else
           begin
             if (VprDCotacao.ValTotal - VprDCotacao.ValTotalComDesconto > 0) then
               result := 'Para ganhar o desconto de '+FormatFloat('R$ ###,###,###,##0.00',VprDCotacao.ValTotal - VprDCotacao.ValTotalComDesconto)+ ' pague esta duplicata até '+FormatDateTime('DD/MM/YYYY',IncDia(VprDCotacao.DatOrcamento,7));
           end;
         end;
    54 : result := 'Após vencimento será cobrado '+ FormatFloat('0.00%',Varia.Juro)+' de juros ao mês.';
    55 : result := VprDCliente.NomCliente;
    56 : result := AdicionaCharD('-','',200);
    57 : result := 'Nao aceitamos troca ou devolucao apos pedido/nota fiscal confirmados.';
//    57 : result := 'Aceit. troca ate 15 dias apos a compra com a apresent. deste(exceto cimento)';
    58 : result := FunCotacao.RNomeTipoOrcamento(VprDCotacao.CodTipoOrcamento);
    59 : result := FunCotacao.RNomVendedor(VprDCotacao.CodPreposto);
    60 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
             if TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).QtdPecas > 0 then
               result := FloatToStr(TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).QtdPecas)+' PCS'
             else
               result :=  TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).DesRefCliente;
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    61 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
             result :=  TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).DesObservacao;
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    62 : result := VprDCotacao.OrdemCompra;
    63 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
             if TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).CodCor <> 0 then
               result := IntToStr(TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).CodCor)+'-'+TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).DesCor;
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;
    64 : begin
           if VpaDImpressao.IndiceItem < VprDCotacao.Produtos.Count then
           begin
             if TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).CodEmbalagem <> 0 then
               result := FunProdutos.RNomeEmbalagem( TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaDImpressao.IndiceItem]).CodEmbalagem);
             VpaDItemImpressao.IndItemDocumento := true;
           end;
         end;

  end;

  if VpaDImpressao.IndFolhaemBranco then
  begin
    case VpaDItemImpressao.SeqDocumento of
      01 : result := FunCotacao.RNomeTipoOrcamento(VprDCotacao.CodTipoOrcamento)+' : ' + result ;
      02 : result := 'Cliente : ' + result ;
      03 : Result := 'CGC / CPF : ' + result ;
      04 : result := 'Data Emissao : ' + result ;
      05 : result := 'Endereço : ' + result ;
      06 : result := 'Bairro : ' + result ;
      07 : result := 'CEP : ' + result ;
      08 : result := 'Data Saida : ' + result ;
      09 : result := 'Cidade : ' + result ;
      10 : result := 'Telefone : ' + result ;
      11 : result := 'UF : ' + result ;
      12 : Result := 'I.E : ' + result ;
      13 : result := 'Hora : ' + result ;
      14 : result := 'Valor Produtos : ' + result ;
      15 : result := 'Valor Total : ' + result ;
      16 : result := 'Transportadora : ' + result ;
      17 : result := 'Placa Veiculo : ' + result ;
      18 : result := 'UF : ' + result ;
      19 : result := 'CGC : ' + result ;
      20 : result := 'Endereço : ' + result ;
      21 : result := 'Cidade : ' + result ;
      22 : result := 'UF : ' + result ;
      23 : result := 'I.E : ' + result ;
      24 : result := 'Qtd Volumes : ' + result ;
      25 : result := 'Especie : ' + result ;
      26 : result := 'Marca : ' + result ;
      27 : result := 'Numero : ' + result ;
      28 : result := 'Peso Bruto ' + result ;
      29 : result := 'Peso Liquido ' + result ;
      39 : result := 'Bairro : ' + Result;
      40 : result := 'CEP : ' + result ;
      42 : result := 'e-mail : ' + result ;
      41 : result := 'Cidade : '+ result;
      43 : result := 'Site : ' + result ;
      44 : result := 'Fone : ' + result ;
      46 : result := 'Vendedor : '+result;
      47 : result := 'Cond. Pgto : '+result;
      49 : result := 'Previsao Entrega : '+result;
      51 : result := 'Hora Entrega : '+result;
      62 : result := 'Ordem Compra : '+ result;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesImpressao.RValorInserirNotaFiscal(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
begin
  result := '';
  case VpaDItemImpressao.SeqDocumento of
    01 : result := IntToStr(VprDNotaFiscal.NumNota);
    02 : if VprDNotaFiscal.DesTipoNota = 'E' then
           result := 'X';
    03 : if VprDNotaFiscal.DesTipoNota = 'S' then
           result := 'X';
    04 : result := FunNotaFiscal.RNomNaturezaOperacao(VprDNotaFiscal.CodNatureza,VprDNotaFiscal.SeqItemNatureza);
    05 : result := VprDNotaFiscal.CodNatureza;
    06 : result := Varia.IEFilial;
    07 : result := IntToStr(VprDCliente.CodCliente) +'-'+VprDCliente.NomCliente;
    08 : result := VprDCliente.CGC_CPF;
    09 : begin
{           if ((varia.CNPJFilial = '81.011.082/0001-71') or(varia.CNPJFilial = '00.539.911/0001-91'))and (Varia.NotaFiscalPadrao = 2) then
             result := IntToStr(Dia(VprDNotaFiscal.DatEmissao))+ '    '+AdicionaCharDE(' ', TextoMes(VprDNotaFiscal.DatEmissao,false),20)+'   '+IntToStr(Ano(VprDNotaFiscal.DatEmissao))
           else}  //fazer teste na Reloponto se reclamare reativar   -- 22/09/2007
             result := DateToStr(VprDNotaFiscal.DatEmissao);
         end;
    10 : begin
           if (VprDCliente.DesEnderecoCobranca <> '')  and config.MostrarEnderecoCobrancanaNota then
             result := VprDCliente.DesEnderecoCobranca+', '+ VprDCliente.NumEnderecoCobranca
           else
             result := VprDCliente.DesEndereco+', '+ VprDCliente.NumEndereco+ ' - '+VprDCliente.DesComplementoEndereco;
         end;
    11 : begin
           if (VprDCliente.DesEnderecoCobranca <> '')  and config.MostrarEnderecoCobrancanaNota then
             result := VprDCliente.DesBairroCobranca
           else
             result := VprDCliente.DesBairro;
         end;
    12 : begin
           if (VprDCliente.DesEnderecoCobranca <> '')  and config.MostrarEnderecoCobrancanaNota then
             result := VprDCliente.CepClienteCobranca
           else
             result := VprDCliente.CepCliente;
         end;
    13 : if VprDNotaFiscal.DatSaida > MontaData(1,1,1990) then
           result := DateToStr(VprDNotaFiscal.DatSaida);
    14 : begin
           if (VprDCliente.DesEnderecoCobranca <> '')  and config.MostrarEnderecoCobrancanaNota then
             result := VprDCliente.DesCidadeCobranca
           else
             result := VprDCliente.DesCidade;
         end;
    15 : result := VprDCliente.Fone_FAX;
    16 : begin
           if (VprDCliente.DesEnderecoCobranca <> '')  and config.MostrarEnderecoCobrancanaNota then
             result := VprDCliente.DesUfCobranca
           else
             result := VprDCliente.DesUF;
         end;
    17 : Result := VprDCliente.InscricaoEstadual;
    18 : if VprDNotaFiscal.DatSaida > MontaData(1,1,1990) then
           result := FormatDateTime('HH:MM',VprDNotaFiscal.HorSaida);
    19 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValBaseICMS);
    20 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValICMS);
    21 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValBaseICMSSubstituicao ); //base icms substituicao
    22 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValICMSSubtituicao); //Val icms substituicao
    23 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValTotalProdutos);
    24 : if (varia.CNPJFilial = CNPJ_ZUMM) and (VprDNotaFiscal.ValFrete <> 0) Then
          result := 'Taxa de Entrega : '+FormatFloat('#,###,##0.00', VprDNotaFiscal.ValFrete)
         else
           result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValFrete);
    25 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValSeguro);
    26 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValOutrasDepesesas);
    27 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValTotalIPI);
    28 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValTotal);
    29 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValIssqn); //valor total isqn
    30 : result := FormatFloat('#,###,##0.00', VprDNotaFiscal.ValTotalServicos);//valor total servicos
    31 : result := VprDTransportadora.NomCliente;
    32 : result := IntToStr(VprDNotaFiscal.CodTipoFrete);
    33 : result := VprDNotaFiscal.DesPlacaVeiculo;
    34 : result := VprDNotaFiscal.DesUFPlacaVeiculo;
    35 : result := VprDTransportadora.CGC_CPF;
    36 : result := VprDTransportadora.DesEndereco;
    37 : result := VprDTransportadora.DesCidade;
    38 : result := VprDTransportadora.DesUF;
    39 : result := VprDTransportadora.InscricaoEstadual;
    40 : result := IntToStr(VprDNotaFiscal.QtdEmbalagem);
    41 : result := VprDNotaFiscal.DesEspecie;
    42 : result := VprDNotaFiscal.DesMarcaEmbalagem;
    43 : result := VprDNotaFiscal.NumEmbalagem;
    44 : result := FormatFloat('####,###,##0.00',VprDNotaFiscal.PesBruto);
    45 : result := FormatFloat('####,###,##0.00',VprDNotaFiscal.PesLiquido);
    46 : result := FunNotaFiscal.RetornaCondPagamento(VprDNotaFiscal.CodCondicaoPagamento)+ FunNotaFiscal.RNumeroCotacaoTransportadoraTexto(VprDNotaFiscal.NumCotacaoTransportadora);
    47 : result := FunNotaFiscal.RetornaVendedorNota(VprDNotaFiscal.CodVendedor) ;
    48 : result := VprDNotaFiscal.DesClassificacaoFiscal;
    49 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             result :=  TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).CodProduto;
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    50 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             if TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).DesRefCliente <> '' then
             begin
               if config.numeroserieproduto then
                 result := TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).NomProduto+' - NS='+TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).DesRefCliente
               else
               begin
                 if config.ImprimirCodigoCorNaNota then
                   result := TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).DesRefCliente +' - '+ TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).NomProduto+TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).DesRefCliente +' ('+IntToStr(TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).CodCor)+ '-' +TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).DesCor+')'
                 else
                   result := TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).DesRefCliente +' - '+ TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).NomProduto+'-'+TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).DesCor+')';
               end;
             end
             else
               result := TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).NomProduto+'('+IntToStr(TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).CodCor)+'-'+TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).DesCor+')';
             if TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).DesOrdemCompra <> '' then
               result := result + '- OC '+ TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).DesOrdemCompra;
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    51 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             if varia.CNPJFilial = CNPJ_Kabran then
               result :=  TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).CodClassificacaoFiscal
             else
               result :=  InttoStr(TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).NumOrdemClaFiscal);
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    52 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             result :=  TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).CodCST;
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    53 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             result :=  TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).UM;
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    54 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             result := FloatToStr(TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).QtdProduto);
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    55 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             result := FormatFloat('###,###,###,##0.000#',TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).ValUnitario);
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    56 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             result := FormatFloat('###,###,###,##0.00',TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).ValTotal);
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    57 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             result := FormatFloat('0.00',TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).PerICMS);
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    58 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             result := FormatFloat('0.00',TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).PerIPI);
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    59 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Produtos.Count then
           begin
             result := FormatFloat('###,###,##0.00',TRBDNotaFiscalProduto(VprDNotaFiscal.Produtos.Items[VpaDImpressao.IndiceItem]).ValIPI);
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasProdutos;
           end;
         end;
    60 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.DesDadosAdicionaisImpressao.Count then
           begin
             result := VprDNotaFiscal.DesDadosAdicionaisImpressao.Strings[VpaDImpressao.IndiceItem];
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasDadosAdicionais;
           end;
         end;
    61 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             result := TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Numero1 ;//fatura numero
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    62 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             if TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).DatVencimento1 > MontaData(1,1,1990) then
               result := FormatDateTime('DD/MM/YYYY',TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).DatVencimento1)
             else
               result := '';
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    63 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             if TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Valor1 <> 0 then
               result := FormatFloat('###,###,###,##0.00',TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Valor1)
             else
               result := '';
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    64 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             result := TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Numero2 ;//fatura numero
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    65 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             if TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).DatVencimento2 > MontaData(1,1,1990) then
               result := FormatDateTime('DD/MM/YYYY',TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).DatVencimento2)
             else
               result := '';
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    66 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             if TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Valor2 <> 0 then
               result := FormatFloat('###,###,###,##0.00',TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Valor2)
             else
               result := '';
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    67 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             result := TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Numero3 ;//fatura numero
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    68 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             if TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).DatVencimento3 > MontaData(1,1,1990) then
               result := FormatDateTime('DD/MM/YYYY',TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).DatVencimento3)
             else
               result := '';
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    69 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             if TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Valor3 <> 0 then
               result := FormatFloat('###,###,###,##0.00',TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Valor3)
             else
               result := '';
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    70 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             result := TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Numero4 ;//fatura numero
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    71 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             if TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).DatVencimento4 > MontaData(1,1,1990) then
               result := FormatDateTime('DD/MM/YYYY',TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).DatVencimento4)
             else
               result := '';
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    72 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Faturas.Count then
           begin
             if TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Valor4 <> 0 then
               result := FormatFloat('###,###,###,##0.00',TRBDImpressaoFaturaNotaFiscal(VprDNotaFiscal.Faturas.Items[VpaDImpressao.IndiceItem]).Valor4)
             else
               result := '';
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasFatura;
           end;
         end;
    73 : result := intTostr(VprDNotaFiscal.NumNota);
    74 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.DesObservacao.Count then
           begin
             result := VprDNotaFiscal.DesObservacao.Strings[VpaDImpressao.IndiceItem];
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasObservacao;
           end;
         end;
    75 : begin
           if VpaDImpressao.IndiceItem < VprServicosNotaFiscal.Count then
           begin
             result := VprServicosNotaFiscal.Strings[VpaDImpressao.IndiceItem];
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasServicos;
           end;

         end;
     76 : result := VprDCliente.NomCliente;
     77 : begin
            if VprDNotaFiscal.DesOrdemCompra <> '' then
              result := 'Ordem de Compra : '+ VprDNotaFiscal.DesOrdemCompra
            else
              result := '';
            if config.ImprimirNumeroCotacaonaNotaFiscal then
            begin
              if result <> '' then
                result := result + '    - ';
              if VprDNotaFiscal.NumPedidos <> '' then
                result :=result + ' '+ VprDNotaFiscal.NumPedidos;
            end;
          end;
     78 : begin
            if (VprDNotaFiscal.ValDesconto <> 0) or (VprDNotaFiscal.PerDesconto <> 0) then
              result := FunNotaFiscal.RTextDescontoAcrescimo(VprDNotaFiscal)
            else
              result := '';
            if VprDNotaFiscal.ValDescontoTroca <> 0 then
              result := result + '      Desconto Referente a Troca: '+FormatFloat('R$ #,###,###,###,##0.00',VprDNotaFiscal.ValDescontoTroca);
          end;
     79 : begin
            if VpaDImpressao.IndiceItem < VprDNotaFiscal.DesDadosAdicinais.Count then
            begin
              result := VprDNotaFiscal.DesDadosAdicinais.Strings[VpaDImpressao.IndiceItem];
              VpaDItemImpressao.IndItemDocumento := true;
              VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasDadosAdicionais;
            end;
          end;
    80 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Servicos.Count then
           begin
             result := FormatFloat('###,###,##0.00',TRBDNotaFiscalServico(VprDNotaFiscal.Servicos.Items[VpaDImpressao.IndiceItem]).ValTotal);
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasServicos;
           end;
         end;
    81 : result := 'CT'+DeleteAteChar(VprDNotaFiscal.NumPedidos,':');
    82 : result := FormatFloat('0.00%',VprDNotaFiscal.PerIssqn);
    83 : result := varia.EnderecoFilial;
    84 : result := varia.CepFilial;
    85 : result := varia.CidadeFilial;
    86 : result := varia.UFFilial;
    87 : result := varia.FoneFilial;
    88 : result := varia.CNPJFilial;
    89 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Servicos.Count then
           begin
             result := FormatFloat('###,###,##0.00',TRBDNotaFiscalServico(VprDNotaFiscal.Servicos.Items[VpaDImpressao.IndiceItem]).QtdServico);
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasServicos;
           end;
         end;
    90 : begin
           if VpaDImpressao.IndiceItem < VprDNotaFiscal.Servicos.Count then
           begin
             result := FormatFloat('###,###,##0.00',TRBDNotaFiscalServico(VprDNotaFiscal.Servicos.Items[VpaDImpressao.IndiceItem]).ValUnitario);
             VpaDItemImpressao.IndItemDocumento := true;
             VpaDItemImpressao.QtdLinhasItem := VpaDImpressao.QtdLinhasServicos;
           end;
         end;
    91 : begin
           if (VprDNotaFiscal.Produtos.Count > VpaDImpressao.QtdLinhasProdutos) or
              (VprDNotaFiscal.Servicos.Count > VpaDImpressao.QtdLinhasServicos) then
           begin
             result := 'FOLHA '+AdicionaCharE('0',IntToStr(VprDNotaFiscal.NumFolhaImpressao),2)+'/'+AdicionaCharE('0',IntToStr(VprDNotaFiscal.QtdFolhaImpressao),2);
             inc(VprDNotaFiscal.NumFolhaImpressao);
           end
           else
             result := '';
         end;
  end;
end;

{******************************************************************************}
function TFuncoesImpressao.RValorInserirRecibo(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
begin
  result := '';
  case VpaDItemImpressao.SeqDocumento of
    01 : result := VprDRecibo.Numero;
    02 : result := FormatFloat(CurrencyString+' ###,###,###,##0.00',VprdRecibo.Valor);
    03 : result := VprDRecibo.Pessoa;
    04 : result := VprDRecibo.DescValor1;
    05 : result := VprDRecibo.DescValor2;
    06 : result := VprDRecibo.DescReferente1;
    07 : result := VprDRecibo.DescReferente2;
    08 : result := VprDRecibo.Cidade;
    09 : result := VprDRecibo.Dia;
    10 : result := VprDRecibo.Mes;
    11 : result := VprDRecibo.Ano;
    12 : result := VprDRecibo.Emitente;
    13 : result := VprDRecibo.CGCCPFGREmitente;
    14 : result := VprDRecibo.EnderecoEmitente;
    15 : result := varia.NomeFilial;
    16 : result := Varia.EnderecoFilial;
    17 : result := varia.BairroFilial;
    18 : result := varia.CepFilial;
    19 : result := varia.cidadefilial;
    20 : result := varia.EmailFilial;
    21 : result := varia.Sitefilial;
    22 : result := varia.FoneFilial;
    23 : result := 'Para maior clareza firmo(amos) o presente';
    24 : result := AdicionaCharD('_','',120);
    25 : result := 'RECIBO';
  end;

  if VpaDImpressao.IndFolhaemBranco then
  begin
    case VpaDItemImpressao.SeqDocumento of
      01 : result := 'Numero : ' + result ;
      02 : result := 'Valor ' + result ;
      03 : result := 'Recebi(emos) do Sr.(a) ' + result ;
      04 : result := 'A quantia de ' + result ;
      06 : result := 'Correspondente a ' + result ;
      08 : result := result+', ' ;
      10 : result := ' de '+ result ;
      11 : result := ' de ' + result ;
      17 : result := 'Bairro : '+ result;
      18 : result := 'CEP : '+ result;
      19 : result := 'Cidade : '+ result;
      20 : result := 'e-mail : '+ result;
      21 : result := 'site : '+ result;
      22 : result := 'Fone : '+result;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesImpressao.RValorTituloItemPedidoInserir(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
begin
  result := '';
  case VpaDItemImpressao.SeqDocumento of
    30 : result := 'Cod.';
    31 : result := 'Produto';
    32 : result := 'UM';
    33 : result := 'Qtd';
    34 : result := 'Val Unitario';
    35 : result := 'Val Total';
    45 : result := 'Desc';
    36 : result := 'Observacoes';
    60 : result := 'Ref Cliente';
    61 : result := 'Observação';
    63 : result := 'Cor';
    64 : result := 'Embalagem';
  end;
end;

{******************************************************************************}
function TFuncoesImpressao.RValorTituloItemInserir(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
begin
  if VpaDImpressao.DesTipoDocumento = 'PED' then
    result := RValorTituloItemPedidoInserir(VpaDImpressao,VpaDItemImpressao);
end;

{******************************************************************************}
function TFuncoesImpressao.RValorInserir(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : String;
begin
  VpaDItemImpressao.QtdLinhasItem := 0;
  if VpaDImpressao.DesTipoDocumento = 'PED' then
    result := RValorInserirPedido(VpaDImpressao,VpaDItemImpressao)
  else
    if (VpaDImpressao.DesTipoDocumento = 'NFP') or (VpaDImpressao.DesTipoDocumento = 'NFS') then
      result := RValorInserirNotaFiscal(VpaDImpressao,VpaDItemImpressao)
    else
      if VpaDImpressao.DesTipoDocumento = 'REC' then
        result := RValorInserirRecibo(VpaDImpressao,VpaDItemImpressao);
end;

{******************************************************************************}
function TFuncoesImpressao.FimDadosItemDocumentoPedido(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : Boolean;
begin
  result := true;
  case VpaDItemImpressao.SeqDocumento of
    30..35 : result := VpaDImpressao.IndiceItem >= VprDCotacao.Produtos.Count;
    36 : result := VpaDImpressao.IndiceItem >= VprDCotacao.DesObservacao.Count;
    50 : result := VpaDImpressao.IndiceItem >= VprDCotacao.Parcelas.Count;
  end;
end;

{******************************************************************************}
function TFuncoesImpressao.FimDadosItemDocumentoNotaFiscal(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : Boolean;
begin
  result := true;
  case VpaDItemImpressao.SeqDocumento of
    49..59 : result := VpaDImpressao.IndiceItem >= VprDNotaFiscal.Produtos.Count;
    60 : result := VpaDImpressao.IndiceItem >= VprDNotaFiscal.DesDadosAdicionaisImpressao.Count;
    74 : result := VpaDImpressao.IndiceItem >= VprDNotaFiscal.DesObservacao.Count;
    61..72 : result := VpaDImpressao.IndiceItem >= VprDNotaFiscal.Faturas.count;
    75 : result := VpaDImpressao.IndiceItem >= VprServicosNotaFiscal.Count;
  end;
end;

{******************************************************************************}
function TFuncoesImpressao.FimDadosItemDocumento(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao) : Boolean;
begin
  result := true;
  if VpaDImpressao.DesTipoDocumento = 'PED' then
    result := FimDadosItemDocumentoPedido(VpaDImpressao,VpaDItemImpressao)
  else
    if (VpaDImpressao.DesTipoDocumento = 'NFP') or (VpaDImpressao.DesTipoDocumento = 'NFS')then
      result := FimDadosItemDocumentoNotaFiscal(VpaDImpressao,VpaDItemImpressao)

end;

{******************************************************************************}
procedure TFuncoesImpressao.ImprimirDocumento;
var
  VpfLaco : Integer;
begin
  CarDImpressao(VprDImpressao);

  ConfiguraImp.LocalizaImpressora(ConfiguraImp.Configura, VprDImpressao.SeqImpressora);
  ConfiguraImp.InicializaStatus;
  ConfiguraImp.CarregaConfiguracao;
  ConfiguraDocumento(VprDImpressao.NumDocumento);
  if (VprDImpressao.DesTipoDocumento = 'NFP') or (VprDImpressao.DesTipoDocumento = 'NFS')then
    VprDImpressao.QtdDocumentos := VprDNotaFiscal.QtdFolhaImpressao;

  for VpfLaco := 1 to VprDImpressao.QtdDocumentos do
  begin
    VprDImpressao.IndImprimeAsterisco := false;
    CarDocumento(VprDImpressao,Doc);
    if VprDImpressao.QtdLinhasRodDocumento > 0 then
      AdicionaLinhaTString(DOC,VprDImpressao.QtdLinhasRodDocumento,'');
  end;
  if VprDImpressao.QtdLinhasSaltoPagina > 0 then
    AdicionaLinhaTString(DOC,VprDImpressao.QtdLinhasSaltoPagina,'');
  FechaImpressao(true,'c:\pedido.txt');
end;

{******************************************************************************}
function TFuncoesImpressao.ImprimirComoAsterisco(VpaIndAsterisco : Boolean;VpaDItemImpressao : TRBDItemImpressao) : Boolean;
begin
  result := VpaIndAsterisco;
  if VpaIndAsterisco then
  begin
    if (VprDImpressao.DesTipoDocumento = 'NFP') or (VprDImpressao.DesTipoDocumento = 'NFS')then
    begin
      case VpaDItemImpressao.SeqDocumento of
        46,47,73,74,76,77,78,81 : result := false;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesImpressao.AdicionaIndiceNotaFiscal(VpaDImpressao : TRBDImpressao;VpaDItemImpressao : TRBDItemImpressao);
begin
  if (VprDImpressao.DesTipoDocumento = 'NFP') or (VprDImpressao.DesTipoDocumento = 'NFS')then
  begin
    case VpaDItemImpressao.SeqDocumento of
      49..59 : inc(VpaDImpressao.IndiceProduto);
      61..72 : inc(VpaDImpressao.IndiceFaturas);
      75 : inc(VpaDImpressao.IndiceServico);
    end;
  end;
end;

{**************** cria string de pendencias a serem impressas **************** }
procedure TFuncoesImpressao.CriaPendencia(Indice: Integer; Texto: TStringList);
begin
  Linha[Indice] := TLinha.Create;
  Linha[Indice].Negrito := Itens.FieldByName('NEGRITO').AsString;
  Linha[Indice].Italico := Itens.FieldByName('ITALICO').AsString;
  Linha[Indice].Condensado := Itens.FieldByName('CONDENSADO').AsString;
  Linha[Indice].Reduzido := Itens.FieldByName('REDUZIDO').AsString;
  Linha[Indice].Coluna := Itens.FieldByName('HORIZONTAL').AsInteger;
  Linha[Indice].Alinhamento := Itens.FieldByName('ALINHAMENTO').AsString;
  Linha[Indice].Tamanho := Itens.FieldByName('TAMANHO').AsInteger;
  Linha[Indice].LinhaAtual := 1;
  Linha[Indice].LinhaUso := Itens.FieldByName('VERTICAL').AsInteger + 1;
  Linha[Indice].Texto := Texto;
end;

{************* verifica se a pendencias a serem impressas ******************* }
function TFuncoesImpressao.VerificaPendencias(var Frase: string; LinhaAtual, ColunaAtual:Integer): Boolean;
var
  I, LAtual, ColunaLimite: Integer;
  LinhaInserir: string;
begin
  Result := False;
  LAtual := -1; // Não foi escolhido nenhum ainda.
  ColunaLimite := 1000;
  for I:=0 to TamanhoArray do
  begin
    if Linha[I] <> nil then
    begin
      if (Linha[I].LinhaUso = LinhaAtual) then
        if (Linha[I].Coluna <= ColunaAtual) then
          if (Linha[I].Coluna <= ColunaLimite) then
          begin
            LAtual := I;
            ColunaLimite := Linha[I].Coluna;
          end;
    end;
  end;
  // Se achou alguém para inserir.
  if (LAtual >= 0) then // Achou alguém.
  begin
    if (Linha[LAtual] <> nil) then
    begin
      Result := True;
      if ((Linha[LAtual].LinhaAtual) <= (Linha[LAtual].Texto.Count -1)) then
      begin
        LinhaInserir := Linha[LAtual].Texto[Linha[LAtual].LinhaAtual];
        // Altera a frase.
        Frase := Frase + ConfiguraImp.ConfiguraTexto(Linha[LAtual].Negrito, Linha[LAtual].Italico, Linha[LAtual].Condensado, Linha[LAtual].Reduzido) + ConfiguraImp.ADicionaTexto(LinhaInserir, Linha[LAtual].Alinhamento, Linha[LAtual].Tamanho, Linha[LAtual].Coluna);
        Linha[LAtual].LinhaUso := Linha[LAtual].LinhaUso + 1;
        Linha[LAtual].LinhaAtual  := Linha[LAtual].LinhaAtual + 1;
      end
      else
      Result := False; // Não tem mais linhas para inserir
    end
    else Result := False;
  end
  else Result := False;
end;

{ ****** Manda o TStringList DOC para impressão em porta ou em componente ***** }
procedure TFuncoesImpressao.FechaImpressao(Porta: Boolean; NomeArquivo: string);
begin
  if Porta then
    ImprimirPorta(DOC, ConfiguraImp.ConfigImp.PortaImpressao)
  else
  begin
    DOC.SaveToFile(NomeArquivo);
    WinExec(PAnsiChar('NOTEPAD.EXE impressao.txt'), SW_ShowNormal);
  end;
  LimpaArray;
end;

{***************** limpa o array de pendencias ***************************** }
procedure TFuncoesImpressao.LimpaArray;
var
  I: Integer;
begin
  for I:=0 to TamanhoArray do
    if Linha[I] <> nil  then
      Linha[I] := NIL;
end;

{ ************** Imprime o TStringList DOC direto em porta ****************** }
procedure TFuncoesImpressao.ImprimirPorta(TextoImprimir: TStringList; Porta : String);
var
  Texto : TextFile;
  I: Integer;
begin
  try
    if not (Porta = '') then
    begin

      AssignFile(Texto, Porta);
      Rewrite(Texto);
      // Reseta a Impressora.
      Write(Texto, ConfiguraImp.ConfigImp.ComandoInicializa);

      // desabilita Negrito
      write(Texto, ConfiguraImp.ConfigImp.NegritoNao);
      // desabilita Italico
      write(Texto, ConfiguraImp.ConfigImp.ItalicoNao);
      // desabilita Reduzido
      write(Texto, ConfiguraImp.ConfigImp.ReduzidoNao);
      // desabilita Condensado
      write(Texto, ConfiguraImp.ConfigImp.CondensadoNao);

      // Margem Esquerda.
      Write(Texto, ConfiguraImp.ConfigImp.ComandoMargemEsquerda);
      // Margem Direita.
      Write(Texto, ConfiguraImp.ConfigImp.ComandoMargemDireita);
      // Configura o Tamanho de linha.
      if (CabecalhoDOC.AlturaLinha  = 'S') then
        Write(Texto, ConfiguraImp.ConfigImp.LinhaTextoSim ) // 1/8.
      else
        Write(Texto, ConfiguraImp.ConfigImp.LinhaTextoNao); // 1/6.
{      if (CabecalhoDOC.DeteccaoPapel  = 'S') then
        Write(Texto, ConfiguraImp.ConfigImp.PapelSim )
      else
        Write(Texto, ConfiguraImp.ConfigImp.PapelNao);}

      // IMPRIME O TEXTO.
      for I := 0  to (TextoImprimir.Count - 1) do
        Writeln(Texto, TextoImprimir[I]);
      CloseFile(Texto);
    end
    else
      erro(CT_PortaVazia);
  except
    CloseFile(Texto);
    Aviso(CT_ErroFaltaImpressora);
  end;
end;

{******************* imprime um comando na porta da impressora *************** }
procedure TFuncoesImpressao.ImprimeComando(Comando, Caractere, Frase, PortaImpressora : string);
var
  Texto : TextFile;
begin
  try
    if not (PortaImpressora = '') then
    begin
      AssignFile(Texto, PortaImpressora);
      Rewrite(Texto);
      Write(Texto, ConfiguraImp.MontaComandoImprimir(Comando, Caractere));
      if Frase <> '' then
      Writeln(Texto, Frase);
      CloseFile(Texto);
    end
    else
      erro(CT_PortaVazia);
  except
    CloseFile(Texto);
    Aviso(CT_ErroFaltaImpressora);
  end;
end;

end.


