

Unit UnSistema;
{Verificado
-.edit;
}
Interface

Uses Classes, SysUtils,Windows, UnDados, forms, Registry, Tabela, SQLExpr,db,
     IdMessage, IdSMTP,  idtext, idAttachmentfile,unVersoes, dbClient,CBancoDados, ComCtrls, StdCtrls, Gauges, mapi ;

Const
  CT_OPERACAOINVETARIO = 'FALTA CONFIGURAÇÃO INVENTÁRIO!!!'#13'Falta nas configurações dos produtos indicar quais serão as operações de estoque de saida e entrada de inventário...';
  ATTACH_MAX = MaxInt div SizeOf(TMapiFileDesc);


//classe localiza
Type TRBLocalizaSistema = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type
  TAttachAccessArray = array [0..(ATTACH_MAX - 1)] of TMapiFileDesc;
  TlpAttachArray     = ^TAttachAccessArray;
  TszPathName   = array[0..256] of Char;
  TlpszPathname = ^TszPathname;
  TszFileName   = array[0..256] of Char;
  TlpszFileName = ^TszFileName;

 TRBFuncoesSistema = class(TRBLocalizaSistema)
  private
    SisCadastro : TSQL;
    SisAux : TSQLQuery;
    SisLog : TRBSql;
    function RTabelasQuePodemFicarAbertas : Integer;
    function RSeqLogDisponivel:Integer;
    function RDatValidadeSistema : TDatetime;
    function RQtdCustosPendentes : Integer;
    function RQtdCustosRealizado(VpaData : TDateTime):integer;
    function RQtdNumerosPedidosFilial(VpaCodFilial :integer) : Integer;
    procedure SalvarDataValidadeSistema(VpaData : TDateTime);
    function RegistraSistema : Boolean;
    function InicializaDiaCusto(VpaData : TDateTime;VpaQtdCustoPendente : Integer):string;
    function AtualizaCustoUltimoDia(VpaData : TDateTime;VpaQtdCustoPendente : Integer):string;
    function ExisteNumeroPedido(VpaCodFilial, VpaNumPedido : Integer):boolean;
    function ExisteSeqNota(VpaCodFilial, VpaSeqNota : Integer):boolean;
    function ExisteLanReceber(VpaCodFilial, VpaLanReceber : Integer):Boolean;
    function ExisteSeqComissao(VpaCodFilial, VpaSeqComissao : Integer):Boolean;
    procedure CopiasARquivosRede(VpaArquivos : TStringList);
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    function CarEmailMarketing(VpaEmails : TList) : String;
    function EnviaEmail(VpaDestinatario, VpaAssunto, VpaCorpo,VpaAnexo : String;VpaEmailParaRetorno :string=''):String;overload;
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP) : string;overload;
    function EnviaEmailPeloOutlook(const VpaAssunto, VpaCorpo : string; VpaArquivo : TStringList;VpaNomeDestinatario, VpaEmailDestinatario : string): Integer;
    function CFGInventarioValido : String;
    procedure GravaLogExclusao(VpaNomTabela :String; VpaComandoSQL : String);
    function RNomUsuario(VpaCodUsuario : Integer):String;
    function REmailUsuario(VpaCodUsuario : Integer) : String;
    function REmpresaFilial(VpaCodFilial : Integer) : Integer;
    function RNomFilial(VpaCodFilial : Integer) : String;
    function RNomComputador : String;
    function RTabelaPrecoFilial(VpaCodFilial : Integer) :Integer;
    function RDataServidor : TDateTime;
    function RDataUltimaImportacao : TDateTime;
    function RQtdNumerosNotasFilial(VpaCodFilial : Integer) : Integer;
    function RQtdSequenciaContasaReceberFilial(VpaCodFilial : Integer):Integer;
    function RQtdSequenciaComissaoFilial(VpaCodFilial : Integer):Integer;
    function RQtdFilial: integer;
    procedure GravaDataUltimaBaixa(VpaData : TDateTime);
    function RDataUltimaBaixa : TDateTime;
    procedure CarDFilial(VpaDFilial : TRBDFilial;VpaCodFilial : Integer);
    procedure CarDVendedor(VpaDVendedor: TRBDVendedor; VpaCodVendedor: integer);
    procedure SalvaTabelasAbertas;
    function ValidaSerieSistema : Boolean;
    function AtualizaInformacoesGerencialCustos(VpaDiaAnterior,VpaData : TDateTime) : String;
    function AtualizaDataInformacaoGerencial(VpaData : TDateTime) : string;
    function RQtdParcelasCondicaoPagamento(VpaCodCondicaoPagamento : Integer) : Integer;
    function RRodapeCRM(VpaCodFilial : integer) : string;
    procedure MarcaTabelaParaImportar(VpaNomTabela : String);
    function GeraNumeroPedidos(VpaRegistro: TProgressBar; VpaLabel: TLabel; VpaTabelas: TGauge) : string;
    function GeraSequenciasNotas(VpaRegistro: TProgressBar; VpaLabel : TLabel; VpaTabelas: TGauge) : string;
    function GeraSequenciaisContasaReceber(VpaRegistro: TProgressBar; VpaLabel : TLabel; VpaTabelas: TGauge) : String;
    function GeraSequenciaisComissao(VpaRegistro: TProgressBar; VpaLabel : TLabel; VpaTabelas: TGauge) : String;
    function ConfiguraVendedorSistemaPedido(VpaCodVendedor : Integer;VpaIndImportarTodosVendedores : Boolean):string;
    function GeraMD5 : string;
    procedure VerificaArquivosAuxiliares;
    function RAssinaturaRegistro(VpaTabela : TDataSet) : String;
    function AssinaturaValida(VpaTabela : TDataSet;VpaDesAssinatura : string) : boolean;
    procedure AtualizaDataUltimoBackup;
    procedure VerificaDataBackup;
    function PodeDivulgarEficacia : Boolean;
    function AnexaArquivoEmail(VpaNomArquivo : String;VpaMensagem : TIdMessage):string;
    function RMVAAjustado(VpaMVAOriginal, VpaICMSOrigem, VpaICMSDestino : Double) :double;
end;

Var
  Sistema  : TRBFuncoesSistema;
  lpAttachArray: TlpAttachArray;

implementation

Uses FunSql, Constantes, APrincipal, Constmsg, FunValida, fundata,AValidaSerieSistema,
  FunObjeto, FunArquivos, Funstring;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaSistema
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaSistema.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesSistema
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesSistema.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;

  SisCadastro := TSQL.Create(nil);
  SisCadastro.ASQLConnection := VpaBaseDados;
  SisAux := TSQLQUERY.Create(nil);
  SisAux.SQLConnection := VpaBaseDados;
  SisLog := TRBSQL.Create(nil);
  SisLog.ASQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesSistema.destroy;
begin
  SisCadastro.free;
  SisAux.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesSistema.EnviaEmail(VpaMensagem: TIdMessage;VpaSMTP: TIdSMTP): string;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';
  VpaMensagem.From.Address := varia.UsuarioSMTP;
  VpaMensagem.From.Name := varia.NomeFilial;

  VpaSMTP.UserName := varia.UsuarioSMTP;
  VpaSMTP.Password := Varia.SenhaEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := varia.PortaSMTP;
  if config.ServidorInternetRequerAutenticacao then
    VpaSMTP.AuthType := satDefault
  else
    VpaSMTP.AuthType := satNone;

  VpaMensagem.ReceiptRecipient.Text  :=VpaMensagem.From.Text;

  if VpaMensagem.ReceiptRecipient.Address = '' then
    result := 'E-MAIL DA FILIAL !!!'#13'É necessário preencher o e-mail da transportadora.';
  if VpaSMTP.UserName = '' then
    result := 'USUARIO DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações o e-mail de origem.';
  if VpaSMTP.Password = '' then
    result := 'SENHA SMTP DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações a senha do e-mail de origem';
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
    VpaMensagem.Clear;
  end;
end;

{******************************************************************************}
function TRBFuncoesSistema.EnviaEmailPeloOutlook(const VpaAssunto, VpaCorpo : string; VpaArquivo : TStringList;
  VpaNomeDestinatario, VpaEmailDestinatario : string): Integer;
var
message: TMapiMessage;
lpSender,
lpRecepient: TMapiRecipDesc;
FileAttach: TMapiFileDesc;
SM: TFNMapiSendMail;
MAPIModule: HModule;
SL: TStringList;
i: integer;
VpfLaco : Integer;
VpfDestinatarios, VpfNomesArquivo : TStringList;
begin
  VpfDestinatarios := TStringList.Create;
  VpfDestinatarios.Add('suporte@eficaciaconsultoria.com.br');
  VpfNomesArquivo := TStringList.Create;
  for VpfLaco := 0 to VpaArquivo.Count - 1 do
    VpfNomesArquivo.Add(ExtractFileName(VpaArquivo.Strings[VpfLaco]));
  CopiasARquivosRede(VpaArquivo);
  VpaArquivo.SaveToFile('c:\arquivo.txt');
//  SendEMailByMAPI('Eficacia consultoria','rafael@eficaciaconsultoria.com.br','teste',VpaAssunto,VpfDestinatarios,VpaArquivo,VpfNomesArquivo,true,false,false,1);
//  exit;
VpaEmailDestinatario := 'suporte@eficaciaconsultoria.com.br';
  FillChar(message, SizeOf(message), 0);
  with message do
  begin
    if (VpaAssunto <> '') then
      lpszSubject := PAnsiChar( AnsiString(VpaAssunto));

    if (VpaCorpo <> '') then
      lpszNoteText := PAnsiChar( AnsiString(VpaCorpo));

{    if (SenderEMail <> '') then
    begin
      lpSender.ulRecipClass := MAPI_ORIG;
      lpSender.lpszName := PAnsiChar( AnsiString(SenderEMail));
      lpSender.lpszAddress := PAnsiChar( AnsiString('SMTP:' + SenderEMail));
      lpSender.ulReserved := 0;
      lpSender.ulEIDSize := 0;
      lpSender.lpEntryID := nil;
      lpOriginator := @lpSender;
    end;}
    if (VpaEmailDestinatario <> '') then
    begin
      lpRecepient.ulRecipClass := MAPI_TO;
      if (VpaNomeDestinatario = '') then
        lpRecepient.lpszName := PAnsiChar( AnsiString(VpaEmailDestinatario))
      else
        lpRecepient.lpszName := PAnsiChar( AnsiString(VpaNomeDestinatario));
      lpRecepient.lpszAddress := PAnsiChar( AnsiString('SMTP:' + VpaEmailDestinatario));
      lpRecepient.ulReserved := 0;
      lpRecepient.ulEIDSize := 0;
      lpRecepient.lpEntryID := nil;
      nRecipCount := 1;
      lpRecips := @lpRecepient;
    end
    else
      lpRecips := nil;
    if (VpaArquivo.Count = 0) then
    begin
      nFileCount := 0;
      lpFiles := nil;
    end
    else
    begin


      nFileCount := VpaArquivo.Count;

      lpAttachArray := TlpAttachArray(StrAlloc(nFileCount*SizeOf(TMapiFileDesc)));
      FillChar(lpAttachArray^, StrBufSize(PChar(lpAttachArray)), 0);
      for i := 0 to nFileCount-1 do
      begin
        lpAttachArray^[i].nPosition := Cardinal(-1); //Cardinal($FFFFFFFF); //ULONG(-1);
        lpAttachArray^[i].lpszPathName := StrPCopy(PAnsiChar( AnsiString(new(TlpszPathname)^)), VpaArquivo[i]);
//        lpAttachArray^[i].lpszFileName := StrPCopy(PAnsiChar( AnsiString(new(TlpszFileName)^)), ExtractFileName(VpfNomesArquivo[i]));
      end;
      lpFiles := @lpAttachArray^


{
      nFileCount := VpaArquivo.Count;

      lpAttachArray := TlpAttachArray(StrAlloc(nFileCount*SizeOf(TMapiFileDesc)));
      FillChar(lpAttachArray^, StrBufSize(PChar(lpAttachArray)), 0);
      for i := 0 to nFileCount-1 do
      begin
        lpAttachArray^[i].nPosition := Cardinal(-1); //Cardinal($FFFFFFFF); //ULONG(-1);
        lpAttachArray^[i].lpszPathName := PAnsiChar( AnsiString(StrPCopy(new(TlpszPathname)^, VpaArquivo.Strings[i])));
        if i < VpaArquivo.Count then
          lpAttachArray^[i].lpszFileName := PAnsiChar( AnsiString(StrPCopy(new(TlpszFileName)^, VpaArquivo.Strings[i])))
        else
          lpAttachArray^[i].lpszFileName := PAnsiChar( AnsiString(StrPCopy(new(TlpszFileName)^, ExtractFileName(VpaArquivo.Strings[i]))));
      end;
      lpFiles := @lpAttachArray^


      for VpfLaco := 0 to VpaArquivo.Count - 1 do
      begin
      end;
      nFileCount := VpaArquivo.Count;

        SL := TStringList.Create;
        try
          SL.Text := VpaArquivo.Text;
          for i := 0 to SL.Count - 1 do
          begin
            FillChar(FileAttach, SizeOf(FileAttach), 0);
            FileAttach.nPosition := Cardinal($FFFFFFFF);
            FileAttach.lpszPathName :=
            PAnsiChar( AnsiString(SL.Strings[i]));//PAnsiChar( AnsiString(FileName);
 //           Inc(nFileCount);//FileCount := 1;
            lpFiles := @FileAttach;
          end;
        finally
          SL.Free;
        end;}
    end;
  end;
  MAPIModule := LoadLibrary(PWideChar( MAPIDLL));
  if MAPIModule = 0 then
    Result := -1
  else
  begin
    try
      @SM := GetProcAddress(MAPIModule, 'MAPISendMail');
      if @SM <> nil then
      begin
        Result := SM(0, Application.Handle, message, MAPI_DIALOG or
        MAPI_LOGON_UI, 0);
      end
      else
        Result := 1;
    finally
      FreeLibrary(MAPIModule);
    end;
  end;
  if Result <> 0 then
    erro('Error sending mail (' + IntToStr(Result) + ').')

end;

{******************************************************************************}
function TRBFuncoesSistema.ExisteLanReceber(VpaCodFilial, VpaLanReceber: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(SisLog,'Select I_EMP_FIL from CADCONTASARECEBER ' +
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                               ' and I_LAN_REC = ' +IntToStr(VpaLanReceber));
  result := not SisLog.Eof;
  SisLog.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.ExisteNumeroPedido(VpaCodFilial, VpaNumPedido: Integer): boolean;
begin
  AdicionaSQLAbreTabela(SisLog,'Select I_EMP_FIL from CADORCAMENTOS ' +
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                               ' AND I_LAN_ORC = '+IntToStr(VpaNumPedido));
  result := not SisLog.Eof;
  SisLog.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.ExisteSeqComissao(VpaCodFilial, VpaSeqComissao: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(SisLog,'Select I_EMP_FIL from MOVCOMISSOES ' +
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                               ' and I_LAN_CON = ' +IntToStr(VpaSeqComissao));
  result := not SisLog.Eof;
  SisLog.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.ExisteSeqNota(VpaCodFilial, VpaSeqNota: Integer): boolean;
begin
  AdicionaSQLAbreTabela(SisLog,'Select I_EMP_FIL from CADNOTAFISCAIS ' +
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                               ' AND I_SEQ_NOT = '+IntToStr(VpaSeqNota));
  result := not SisLog.Eof;
  SisLog.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.CarEmailMarketing(VpaEmails : TList) : String;
var
  VpfDEmail : TRBDEmailMarketing;
begin
  FreeTObjectsList(VpaEmails);
  result := '';
  AdicionaSQLAbreTabela(SisLog,'Select * from EMAILMARKETING' +
                               ' order by SEQEMAIL ' );
  While not SisLog.eof do
  begin
    VpfDEmail := TRBDEmailMarketing.cria;
    VpaEmails.Add(VpfDEmail);
    VpfDEmail.SeqEmail := SisLog.FieldByName('SEQEMAIL').AsInteger;
    VpfDEmail.DesEmail := SisLog.FieldByName('DESEMAIL').AsString;
    VpfDEmail.DesSenha := SisLog.FieldByName('DESSENHA').AsString;
    SisLog.next;
  end;
  SisLog.close;
  if VpaEmails.count = 0 then
    result := 'EMAIL''S REMETENTE NÃO CADASTRADOS!!!'#13'É necessário cadastrar os e-mail''s remetentes nas configurações gerais do sistema na pagina Email Marketing';
end;

{******************************************************************************}
function TRBFuncoesSistema.EnviaEmail(VpaDestinatario, VpaAssunto, VpaCorpo,VpaAnexo : String;VpaEmailParaRetorno :string=''):String;
var
   VpfSMTP : TIdSMTP;
   VpfMensagem : TidMessage;
   VpfEmailTexto, VpfEmailHTML : TIdText;
   VpfAnexo : TIdAttachmentfile;
begin
  if Varia.ServidorSMTP = '' then
    result := 'O servidor SMTP não foi informado';
  if VpaAssunto = '' then
    result :='O assunto da mensagem não foi informado';
  if varia.UsuarioSMTP  = '' then
    result := 'Não foi preenchido o usuario de e-mail nas configurações do sistema';
  if result = ''  then
  begin
    VpfSMTP := TIdSMTP.Create(nil);

    VpfMensagem := TIdMessage.Create(nil);
    VpfMensagem.Clear;
    VpfMensagem.IsEncoded := True;
    VpfMensagem.AttachmentEncoding := 'MIME';
    VpfMensagem.Encoding := meMIME; // meDefault;
    VpfMensagem.ConvertPreamble := True;
    VpfMensagem.Priority := mpNormal;
    VpfMensagem.ContentType := 'multipart/mixed';
    VpfMensagem.CharSet := 'ISO-8859-1';
    VpfMensagem.Date := Now;

    VpfEmailHTML := TIdText.Create(VpfMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    VpfEmailHTML.CharSet := 'ISO-8859-1'; // NOSSA LINGUAGEM PT-BR (Latin-1)!!!!
    VpfEmailHTML.ContentTransfer := '16bit'; // para SAIR ACENTUADO !!!! Pois, 8bit SAI SEM
    VpfEmailHTML.Body.Text := VpaCorpo;

    TRY
      VpfAnexo := TIdAttachmentfile.Create(VpfMensagem.MessageParts,VpaAnexo);
      VpfAnexo.ContentType := 'application/pdf;'+RetornaNomArquivoSemDiretorio(VpaAnexo);

      if VpaEmailParaRetorno <> '' then
      begin
        VpfMensagem.ReceiptRecipient.Text  := VpaEmailParaRetorno;
        VpfMensagem.Recipients.Add.Address := VpaEmailParaRetorno;
        VpfMensagem.ReplyTo.EMailAddresses := VpaEmailParaRetorno;
        VpfMensagem.From.Address := VpaEmailParaRetorno;
      end
      else
      begin
        VpfMensagem.ReceiptRecipient.Text  := varia.UsuarioSMTP;
        VpfMensagem.Recipients.Add.Address := varia.UsuarioSMTP;
        VpfMensagem.ReplyTo.EMailAddresses := varia.UsuarioSMTP;
        VpfMensagem.From.Address := varia.UsuarioSMTP;
      end;
      VpfMensagem.From.Name := varia.Nomefilial;

      VpfMensagem.Recipients.EMailAddresses := VpaDestinatario;

      VpfMensagem.Subject := VpaAssunto;

      VpfMensagem.Priority := TIdMessagePriority(0);
      VpfSMTP.UserName := Varia.usuarioSMTP;
      VpfSMTP.Password :=Varia.SenhaEmail;
      VpfSMTP.Host := Varia.ServidorSMTP;
      VpfSMTP.Port := varia.PortaSMTP;
      if config.ServidorInternetRequerAutenticacao then
        VpfSMTP.AuthType := satDefault
      else
        VpfSMTP.AuthType := satNone;
      VpfSMTP.AuthType := satDefault;
      VpfSMTP.Connect;
      VpfSMTP.Send(VpfMensagem);
      VpfSMTP.Disconnect;
  EXCEPT
    if VpfSMTP.Connected then
      VpfSMTP.Disconnect;
    Raise;
  END;
  end;
  VpfSMTP.free;
  VpfMensagem.free;
end;

{******************************************************************************}
function TRBFuncoesSistema.RTabelasQuePodemFicarAbertas : Integer;
var
  VpfLaco : Integer;
begin
  result := 0;
{ tem que verificar no DBX COMO FAZ PARA BUSCAR ESSAS INFORMACOES
  for VpfLaco := 0 to FPrincipal.BaseBDE.DataSetCount - 1 do
  begin
    if TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner <> nil then
    begin
      if (FPrincipal.BaseDados.DataSets[VpfLaco] is TSQLQUERY) then
      begin
        if ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FCartuchos') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'PESOCARTUCHO'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FChamadoTecnico') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ChamadoTecnico'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FChamadoTecnico') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ChamadoProduto')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FClientes') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadClientes')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FCobrancas') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Cobranca'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FCobrancas') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CobrancaItem'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FContasaPagar') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'MovParcelas')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FContasaReceber') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'MovParcelas')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FCotacao') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadOrcamento')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FCotacao') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'MovOrcamentos')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FLeiturasLocacao') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Locacao'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FlocalizaProduto') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadProdutos'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovaCobranca') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadClientes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovaCobranca') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Parcelas'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovaCobranca') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Ligacoes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovaNotaFiscalNota') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'MovNatureza'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoCliente') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadClientes')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoCliente') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Eventos')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Ligacoes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ChamadoTecnico'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'HistoricoLigacoes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadClientes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadOrcamentos'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'MovOrcamentos'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ChamadoProduto'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ProdutosComContrato'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ProdutosSemContrato'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Inadimplentes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FPropostas') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Proposta'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FPropostasCliente') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Proposta'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FRomaneioGenerico') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'RomaneioCorpo'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FRomaneioGenerico') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'RomaneioProdutoItem'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FTeleMarketings') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Inadimplentes'))then
          inc(result);
      end;
    end;
  end;}
end;

{******************************************************************************}
function TRBFuncoesSistema.RSeqLogDisponivel:Integer;
begin
  AdicionaSQLAbreTabela(SisAux,'Select max(SEQ_LOG) Ultimo FROM LOG ');
  result := SisAux.FieldByName('Ultimo').AsInteger + 1;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RDatValidadeSistema : TDatetime;
begin
  AdicionaSQLAbreTabela(SisAux,'Select C_NOM_CLI from CFG_GERAL');
  if SisAux.FieldByname('C_NOM_CLI').AsString = '' then
    result := decdia(date,1)
  else
    result := StrToDate(Descriptografa(SisAux.FieldByname('C_NOM_CLI').AsString));
  SisAux.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdCustosPendentes : Integer;
begin
  AdicionaSQLAbreTabela(SisAux,'select COUNT(AMO.CODAMOSTRA) QTD '+
                   ' from AMOSTRA AMO '+
                   ' Where AMO.DATENTREGA IS NOT NULL '+
                   ' AND AMO.DATPRECO IS NULL '+
                   ' AND AMO.TIPAMOSTRA = ''D''');
  result := SisAux.FieldByName('QTD').AsInteger;
  SisAux.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdCustosRealizado(VpaData : TDateTime):integer;
begin
  AdicionaSQLAbreTabela(SisAux,'select COUNT(AMO.CODAMOSTRA) QTD '+
                   ' from AMOSTRA AMO '+
                   ' Where AMO.DATENTREGA IS NOT NULL '+
                   ' AND AMO.DATPRECO >='+SQLTextoDataAAAAMMMDD(VpaData)+
                   ' AND AMO.TIPAMOSTRA = ''D''');
  result := SisAux.FieldByName('QTD').AsInteger;
  SisAux.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdFilial: integer;
begin
  AdicionaSQLAbreTabela(SisLog, 'SELECT COUNT(I_EMP_FIL) QTD FROM CADFILIAIS ');
  Result:= SisLog.FieldByName('QTD').AsInteger;
  SisLog.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdNumerosNotasFilial(VpaCodFilial: Integer): Integer;
begin
  AdicionaSQLAbreTabela(SisLog,'Select COUNT(*) QTD FROM NUMERONOTA '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  result := SisLog.FieldByName('QTD').AsInteger;
  SisLog.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdNumerosPedidosFilial(VpaCodFilial :integer) : Integer;
begin
  AdicionaSQLAbreTabela(SisLog,'Select COUNT(*) QTD FROM NUMEROPEDIDO '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  result := SisLog.FieldByName('QTD').AsInteger;
  SisLog.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdParcelasCondicaoPagamento(VpaCodCondicaoPagamento: Integer): Integer;
begin
  AdicionaSQLAbreTabela(SisAux,'select I_QTD_PAR from CADCONDICOESPAGTO '+
                               ' Where I_COD_PAG = '+IntToStr(VpaCodCondicaoPagamento));
  result := SisAux.FieldByName('I_QTD_PAR').AsInteger;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdSequenciaComissaoFilial(VpaCodFilial: Integer): Integer;
begin
  AdicionaSQLAbreTabela(SisLog,'Select COUNT(*) QTD FROM SEQUENCIALCOMISSAO '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  result := SisLog.FieldByName('QTD').AsInteger;
  SisLog.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdSequenciaContasaReceberFilial(VpaCodFilial: Integer): Integer;
begin
  AdicionaSQLAbreTabela(SisLog,'Select COUNT(*) QTD FROM SEQUENCIALCONTASARECEBER '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial));
  result := SisLog.FieldByName('QTD').AsInteger;
  SisLog.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RRodapeCRM(VpaCodFilial: integer): string;
begin
  AdicionaSQLAbreTabela(SisAux,'Select L_ROD_EMA from CADFILIAIS '+
                            ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial));
  result := sisAux.FieldByname('L_ROD_EMA').AsString;
  SisAux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSistema.SalvarDataValidadeSistema(VpaData : TDateTime);
begin
  AdicionaSQLAbreTabela(SisCadastro,'Select * from CFG_GERAL ');
  SisCadastro.edit;
  SisCadastro.FieldByname('C_NOM_CLI').AsString := Criptografa(DateToStr(VpaData));
  SisCadastro.post;
  SisCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RegistraSistema : Boolean;
var
  VpfData : TDateTime;
  VpfDSerie : TRBDSerie;
  VpfBase : string;
  VpfQtdMeses : integer;
begin
  VpfDSerie := TRBDSerie.Create;
  FValidaSerieSistema := TFValidaSerieSistema.Create(nil);
  VpfDSerie.Serie := FValidaSerieSistema.RSerie;
  result :=  FValidaSerieSistema.SolicitaSerieSenha('1',VpfDSerie);
  if result then
  begin
    VpfBase := FValidaSerieSistema.rsenhaSistema(Copy(VpfDSerie.Serie,4,length(VpfDSerie.Serie)));
    VpfQtdMeses := StrToInt(Copy(VpfDSerie.Senha,(length(VpfBase) +3),3));
    VpfData := IncMes(VpfDSerie.Dat_Instalacao,VpfQtdMeses);
    SalvarDataValidadeSistema(VpfData);
  end;
  FValidaSerieSistema.free;
end;

{******************************************************************************}
function TRBFuncoesSistema.InicializaDiaCusto(VpaData : TDateTime;VpaQtdCustoPendente : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(SisCadastro,'Select * from RESUMOCUSTO '+
                                    ' Where DATRESUMO = ' +SQLTextoDataAAAAMMMDD(VpaData));
  if SisCadastro.Eof then
    SisCadastro.insert
  else
    SisCadastro.edit;
  SisCadastro.FieldByName('DATRESUMO').AsDateTime := VpaData;
  SisCadastro.FieldByName('QTDINICIAL').AsInteger := VpaQtdCustoPendente;
  SisCadastro.post;
  result := SisCadastro.AMensagemErroGravacao;
  SisCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesSistema.MarcaTabelaParaImportar(VpaNomTabela: String);
var
  VpfDatBancoDados : TDateTime;
begin
  VpfDatBancoDados := RDataServidor;
  AdicionaSQLAbreTabela(SisCadastro,'Select * from TABELAIMPORTACAO '+
                                    ' Where NOMTABELA = ''' +VpaNomTabela+'''');
  SisCadastro.Edit;
  SisCadastro.FieldByName('DATULTIMAALTERACAOMATRIZ').AsDateTime := VpfDatBancoDados;
  SisCadastro.Post;
  SisCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.PodeDivulgarEficacia: Boolean;
begin
   result := (varia.CNPJFilial <> CNPJ_HORNBURG) and (Varia.CNPJFilial <> CNPJ_Majatex) and
             (varia.CNPJFilial <> CNPJ_Telitex);
end;

{******************************************************************************}
function TRBFuncoesSistema.AnexaArquivoEmail(VpaNomArquivo: String;
  VpaMensagem: TIdMessage): string;
var
  VpfAnexo : TIdAttachmentfile;
  VpfExtArquivo: String;
begin
  VpfAnexo := TIdAttachmentfile.Create(VpaMensagem.MessageParts,VpaNomArquivo);
  VpfExtArquivo:= CopiaEsquerda(VpaNomArquivo, 3);
  if (VpfExtArquivo = 'PEG') or (VpfExtArquivo = 'peg') then
    VpfExtArquivo:= 'jpg';
  VpfAnexo.ContentType := 'application/' + VpfExtArquivo;
  VpfAnexo.ContentDisposition := 'inline';
  VpfAnexo.DisplayName:=RetornaNomArquivoSemDiretorio(VpaNomArquivo);
  VpfAnexo.ExtraHeaders.Values['content-id'] := RetornaNomArquivoSemDiretorio(VpaNomArquivo);;
  VpfAnexo.DisplayName := RetornaNomArquivoSemDiretorio(VpaNomArquivo);;
end;

{******************************************************************************}
function TRBFuncoesSistema.AssinaturaValida(VpaTabela: TDataSet; VpaDesAssinatura: string): boolean;
var
  VpfAssinaturaCalculada : string;
begin
  VpfAssinaturaCalculada := RAssinaturaRegistro(VpaTabela);
  result := VpfAssinaturaCalculada = VpaDesAssinatura;
end;

{******************************************************************************}
function TRBFuncoesSistema.AtualizaCustoUltimoDia(VpaData : TDateTime;VpaQtdCustoPendente : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(SisCadastro,'Select * from RESUMOCUSTO '+
                                    ' Where DATRESUMO = ' +SQLTextoDataAAAAMMMDD(VpaData));
  if not SisCadastro.Eof then
  begin
    SisCadastro.edit;
    SisCadastro.FieldByName('QTDPENDENTE').AsInteger := VpaQtdCustoPendente;
    SisCadastro.FieldByName('QTDREALIZADO').AsInteger := RQtdCustosRealizado(VpaData);
    SisCadastro.post;
    result := SisCadastro.AMensagemErroGravacao;
  end;
  SisCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.CFGInventarioValido : String;
begin
  result := '';
  if not((Varia.InventarioEntrada <> 0) and (varia.InventarioSaida <> 0)) then
    result := CT_OPERACAOINVETARIO;
end;

{******************************************************************************}
function TRBFuncoesSistema.ConfiguraVendedorSistemaPedido(VpaCodVendedor: Integer;VpaIndImportarTodosVendedores: Boolean): string;
begin
  AdicionaSQLAbreTabela(SisCadastro,'Select * from CFG_GERAL');
  SisCadastro.Edit;
  SisCadastro.FieldByName('C_TIP_BAD').AsString :=  'RE';
  SisCadastro.FieldByName('I_SIP_VEN').AsInteger :=  VpaCodVendedor;
  SisCadastro.FieldByName('C_DIR_VER').AsString :=  'C:\EFICACIA' ;
  SisCadastro.FieldByName('C_DIR_REL').AsString :=  'C:\EFICACIA\RELATORIOS' ;
  if VpaIndImportarTodosVendedores then
    SisCadastro.FieldByName('C_SIP_ITV').AsString := 'T'
  else
    SisCadastro.FieldByName('C_SIP_ITV').AsString := 'F';


  SisCadastro.post;
  result := SisCadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
procedure TRBFuncoesSistema.CopiasARquivosRede(VpaArquivos: TStringList);
var
  VpfLaco : Integer;
  VpfNomArquivo : string;
begin
  if not ExisteDiretorio(Varia.DiretorioSistema+'Anexos') then
    CriaDiretorio(Varia.DiretorioSistema+'Anexos');
  for VpfLaco := 0 to VpaArquivos.Count - 1 do
  begin
    VpfNomArquivo := VpaArquivos.Strings[VpfLaco];
    if VpfNomArquivo[1] = '\' then
    begin
      if Length(ExtractFileName(VpaArquivos.Strings[Vpflaco])) >= 11 then
        VpfNomArquivo := Varia.DiretorioSistema+'Anexos\'+copy(ExtractFileName(VpaArquivos.Strings[Vpflaco]),1,5)+'~'+IntToStr(VpfLaco)+'.'+copy(VpaArquivos.Strings[Vpflaco],length(VpaArquivos.Strings[Vpflaco])-2,3)
      else
        VpfNomArquivo := Varia.DiretorioSistema+'Anexos\'+ExtractFileName(VpaArquivos.Strings[Vpflaco]);
      CopiaArquivo(VpaArquivos.Strings[VpfLaco],VpfNomArquivo);
      VpaArquivos.Strings[VpfLaco] := VpfNomArquivo;
    end;
  end;

end;

{******************************************************************************}
procedure TRBFuncoesSistema.GravaLogExclusao(VpaNomTabela :String;VpaComandoSQL : String);
var
  VpfLaco,VpfQtdGravacao : Integer;
  VpfResultado : String;
  VpfNomArquivo : String;
begin
  AdicionaSQLAbreTabela(SisCadastro,'Select * from LOG '+
                                    ' Where SEQ_LOG = 0 ');
  AdicionaSQLAbreTabela(SisLog,VpaComandoSQL);
  VpfNomArquivo := varia.PathVersoes+'\LOG\EXLUSAO\'+ FormatDateTime('YYYYMM',date)+'\'+FormatDateTime('YYYYMMDDHHMMSSMM',NOW)+'_u'+IntToStr(Varia.CodigoUsuario)+'_'+ VpaNomTabela+ '.xml';
  SisCadastro.Insert;
  SisCadastro.FieldByName('DAT_LOG').AsDateTime := now;
  SisCadastro.FieldByName('COD_USUARIO').AsInteger := Varia.CodigoUsuario;
  SisCadastro.FieldByName('DES_LOG').AsString := 'Exclusão';
  SisCadastro.FieldByName('NOM_TABELA').AsString := VpaNomTabela;
  SisCadastro.FieldByName('NOM_MODULO_SISTEMA').AsString := NomeModulo;
  SisCadastro.FieldByName('NOM_COMPUTADOR').AsString := varia.NomeComputador;
  SisCadastro.FieldByName('DES_INFORMACOES').AsString := VpfNomArquivo;
  repeat
    SisCadastro.FieldByName('SEQ_LOG').AsInteger := RSeqLogDisponivel;
    VpfResultado := '';
    SisCadastro.Post;
    VpfResultado := SisCadastro.AMensagemErroGravacao;
    inc(VpfQtdGravacao);
  until ((VpfResultado = '') or (VpfQtdGravacao > 3));
  if VpfResultado <> '' then
    aviso(VpfREsultado);

  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VpfNomArquivo),false);
  SisLog.SaveToFile(VpfNomArquivo,dfxml);
  SisLog.close;
  SisCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RNomUsuario(VpaCodUsuario : Integer):String;
begin
  AdicionaSQLAbreTabela(SisAux,'Select * from CADUSUARIOS '+
                               ' Where I_COD_USU = '+ IntTostr(VpaCodUsuario));
  result := SisAux.FieldByName('C_NOM_USU').AsString;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.REmailUsuario(VpaCodUsuario: Integer): String;
begin
  AdicionaSQLAbreTabela(SisAux,'Select C_DES_EMA from CADUSUARIOS '+
                               ' Where I_COD_USU = '+ IntTostr(VpaCodUsuario));
  result := SisAux.FieldByName('C_DES_EMA').AsString;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.REmpresaFilial(VpaCodFilial : Integer) : Integer;
begin
  if VpaCodFilial = 0 then
    VpaCodFilial := varia.CodigoEmpFil;
  AdicionaSQLAbreTabela(Sisaux,'Select I_COD_EMP from CADFILIAIS '+
                               ' Where I_EMP_FIL = '+IntTostr(VpaCodFilial));
  result := Sisaux.FieldByName('I_COD_EMP').AsInteger;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RMVAAjustado(VpaMVAOriginal, VpaICMSOrigem,VpaICMSDestino: Double): double;
Var
  VpfA, VpfB : Double;
begin
  result := VpaMVAOriginal;
  if (VpaICMSOrigem <> VpaICMSDestino) and (VpaMVAOriginal > 0) then
  begin
    VpfA := 1+(VpaMVAOriginal/100);
    VpfB := (1-(VpaICMSOrigem/100))/((1-(VpaICMSDestino/100)));
    result := ((VpfA*VpfB)-1)*100;
  end;
end;

{******************************************************************************}
function TRBFuncoesSistema.RNomFilial(VpaCodFilial : Integer) : String;
begin
  AdicionaSQLAbreTabela(SisAux,'Select * from CADFILIAIS '+
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodfilial));
  result := SisAux.FieldByName('C_NOM_FAN').AsString;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RNomComputador : String;
var
  lpBuffer : Array[0..20] of Char;
  nSize : dWord;
  mRet : boolean;
begin
  nSize :=120;
  mRet:= GetComputerName(lpBuffer,nSize);
  if mRet then
    Result:= lpBuffer
  else
    result := 'INDEFINIDO';
end;

{******************************************************************************}
function TRBFuncoesSistema.RTabelaPrecoFilial(VpaCodFilial : Integer) :Integer;
begin
  AdicionaSqlabreTabela(SisAux,'Select I_COD_TAB from CADFILIAIS '+
                               ' Where I_EMP_FIL = '+ InttoStr(VpacodFilial));
  result := SisAux.FieldByName('I_COD_TAB').AsInteger;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.GeraMD5 : string;
var
  VpfmMD5Principal : string;
  VpfArquivo : TStringList;
begin
  if not ExisteArquivo(Varia.DiretorioSistema+ '\fsum.exe') then
  begin
    if ExisteArquivo(varia.PathVersoes+'\fsum.exe') then
      CopiaArquivo(varia.PathVersoes+'\fsum.exe',varia.DiretorioSistema+'\fsum.exe')
    else
      aviso('ARQUIVO '+Varia.DiretorioSistema+ 'FSUM.EXE NÃO ENCONTRADO!!!'#13'O arquivo FSUM.EXE que é necessário para gerar o codigo md5 não foi encontrato.');
  end;

  VpfArquivo := TStringList.Create;

  VpfArquivo.Clear;
  VpfArquivo.Add('fsum -md5 EfiPDV.exe >md5efiPDV.txt');
  VpfArquivo.SaveToFile(Varia.DiretorioSistema+ '\vmd5.bat');

  ExecutaArquivoEXE('"'+Varia.DiretorioSistema+ '\vmd5.bat"',Sw_Hide);

    //Deleta as 5 primeiras linhas do arquivo gerado, pois é gerado pelo FSum.
  VpfArquivo.LoadFromFile(Varia.DiretorioSistema+'\md5EfiPDV.txt');
  VpfArquivo.Delete(0);
  VpfArquivo.Delete(0);
  VpfArquivo.Delete(0);
  VpfArquivo.Delete(0);
  VpfArquivo.SaveToFile(Varia.DiretorioSistema+'\md5EfiPDV.txt');
  VpfmMD5Principal := DeletaEspaco(CopiaAteChar(VpfArquivo.Strings[0],'*'));

  //Vamos agora pegar o MD5 do arquivo.
  VpfArquivo.Clear;
  VpfArquivo.Add('fsum -md5 md5EfiPDV.txt >md5final.txt');
  VpfArquivo.SaveToFile(Varia.DiretorioSistema+ '\vmd52.bat');

  ExecutaArquivoEXE('"'+Varia.DiretorioSistema+ '\vmd52.bat"',Sw_Hide);

    //Deleta as 5 primeiras linhas do arquivo gerado, pois é gerado pelo FSum.
  VpfArquivo.LoadFromFile(Varia.DiretorioSistema+'\md5Final.txt');
  VpfArquivo.Delete(0);
  VpfArquivo.Delete(0);
  VpfArquivo.Delete(0);
  VpfArquivo.Delete(0);
  VpfArquivo.SaveToFile(Varia.DiretorioSistema+'\md5Final.txt');
  DeletaArquivo(Varia.DiretorioSistema+'\vmd5.bat');
  DeletaArquivo(Varia.DiretorioSistema+'\vmd52.bat');
  DeletaArquivo(Varia.DiretorioSistema+'\md5EfiPDV.txt');
  DeletaArquivo(Varia.DiretorioSistema+'\md5Final.txt');
  result := DeletaEspaco(CopiaAteChar(VpfArquivo.Strings[0],'*'));
end;

{******************************************************************************}
function TRBFuncoesSistema.GeraNumeroPedidos(VpaRegistro: TProgressBar; VpaLabel : TLabel; VpaTabelas: TGauge): string;
var
  VpfQtdPedidosAGerar, VpfUltimoPedidoGerado : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(SisAux,'Select I_EMP_FIL, I_ULT_PED FROM CADFILIAIS');
  AdicionaSQLAbreTabela(SisCadastro,'Select * FROM NUMEROPEDIDO '+
                               ' Where CODFILIAL = 0 AND NUMPEDIDO = 0');
  while not SisAux.Eof do
  begin
    VpfQtdPedidosAGerar := Varia.QtdNumeroPedidoGerar - RQtdNumerosPedidosFilial(SisAux.FieldByName('I_EMP_FIL').AsInteger);
    VpaRegistro.Max:= 0;
    VpaRegistro.Max:= VpfQtdPedidosAGerar;
    VpfUltimoPedidoGerado := SisAux.FieldByName('I_ULT_PED').AsInteger;
    INC(VpfUltimoPedidoGerado);
    while VpfQtdPedidosAGerar > 0 do
    begin
      while ExisteNumeroPedido(SisAux.FieldByName('I_EMP_FIL').AsInteger,VpfUltimoPedidoGerado) do
        INC(VpfUltimoPedidoGerado);

      SisCadastro.Insert;
      SisCadastro.FieldByName('CODFILIAL').AsInteger := SisAux.FieldByName('I_EMP_FIL').AsInteger;
      SisCadastro.FieldByName('NUMPEDIDO').AsInteger := VpfUltimoPedidoGerado;
      SisCadastro.Post;
      dec(VpfQtdPedidosAGerar);
      inc(VpfUltimoPedidoGerado);
      VpaLabel.Caption:= 'numero de Pedidos filial: ' + IntToStr(SisCadastro.FieldByName('CODFILIAL').AsInteger);
      VpaLabel.Refresh;
      VpaRegistro.Position:= VpaRegistro.Position + 1;
    end;
    VpaTabelas.Progress:= VpaTabelas.Progress + 1;
    ExecutaComandoSql(SisLog,'UPDATE CADFILIAIS ' +
                             ' SET I_ULT_PED = '+IntToStr(VpfUltimoPedidoGerado-1)+
                             ' WHERE I_EMP_FIL = '+IntToStr(SisAux.FieldByName('I_EMP_FIL').ASinteger));
    SisAux.Next;
  end;
  Sisaux.Close;
  SisCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.GeraSequenciaisComissao(VpaRegistro: TProgressBar; VpaLabel : TLabel; VpaTabelas: TGauge): String;
var
  VpfQtdAGerar, VpfUltimoGerado : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(SisAux,'Select I_EMP_FIL, I_ULT_COM FROM CADFILIAIS');
  AdicionaSQLAbreTabela(SisCadastro,'Select * FROM SEQUENCIALCOMISSAO '+
                               ' Where CODFILIAL = 0 AND SEQCOMISSAO = 0');
  while not SisAux.Eof do
  begin
    VpaLabel.Caption:= 'Sequencias de comissao filial: ' + IntToStr(SisCadastro.FieldByName('CODFILIAL').AsInteger);
    VpaLabel.Refresh;
    VpfQtdAGerar := Varia.QtdNumeroPedidoGerar - RQtdSequenciaComissaoFilial(SisAux.FieldByName('I_EMP_FIL').AsInteger);
    VpaRegistro.Max:= 0;
    VpaRegistro.Max:= VpfQtdAGerar;
    VpfUltimoGerado := SisAux.FieldByName('I_ULT_COM').AsInteger;
    INC(VpfUltimoGerado);
    while VpfQtdAGerar > 0 do
    begin
      while ExisteSeqComissao(SisAux.FieldByName('I_EMP_FIL').AsInteger,VpfUltimoGerado) do
        INC(VpfUltimoGerado);

      SisCadastro.Insert;
      SisCadastro.FieldByName('CODFILIAL').AsInteger := SisAux.FieldByName('I_EMP_FIL').AsInteger;
      SisCadastro.FieldByName('SEQCOMISSAO').AsInteger := VpfUltimoGerado;
      SisCadastro.Post;
      dec(VpfQtdAGerar);
      inc(VpfUltimoGerado);
      VpaRegistro.Position:= VpaRegistro.Position + 1;
    end;
    VpaTabelas.Progress:= VpaTabelas.Progress + 1;
    ExecutaComandoSql(SisLog,'UPDATE CADFILIAIS ' +
                             ' SET I_ULT_COM = '+IntToStr(VpfUltimoGerado-1)+
                             ' WHERE I_EMP_FIL = '+IntToStr(SisAux.FieldByName('I_EMP_FIL').ASinteger));
    SisAux.Next;
  end;
  Sisaux.Close;
  SisCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.GeraSequenciaisContasaReceber(VpaRegistro: TProgressBar; VpaLabel : TLabel; VpaTabelas: TGauge): String;
var
  VpfQtdReceberAGerar, VpfUltimoReceberGerado : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(SisAux,'Select I_EMP_FIL, I_ULT_REC FROM CADFILIAIS');
  AdicionaSQLAbreTabela(SisCadastro,'Select * FROM SEQUENCIALCONTASARECEBER '+
                               ' Where CODFILIAL = 0 AND LANRECEBER = 0');
  while not SisAux.Eof do
  begin
    VpaLabel.Caption:= 'contas a receber filial: ' + IntToStr(SisCadastro.FieldByName('CODFILIAL').AsInteger);
    VpaLabel.Refresh;
    VpfQtdReceberAGerar := Varia.QtdNumeroPedidoGerar - RQtdSequenciaContasaReceberFilial(SisAux.FieldByName('I_EMP_FIL').AsInteger);
    VpaRegistro.Max:= 0;
    VpaRegistro.Max:= VpfQtdReceberAGerar;
    VpfUltimoReceberGerado := SisAux.FieldByName('I_ULT_REC').AsInteger;
    INC(VpfUltimoReceberGerado);
    while VpfQtdReceberAGerar > 0 do
    begin
      while ExisteLanReceber(SisAux.FieldByName('I_EMP_FIL').AsInteger,VpfUltimoReceberGerado) do
        INC(VpfUltimoReceberGerado);

      SisCadastro.Insert;
      SisCadastro.FieldByName('CODFILIAL').AsInteger := SisAux.FieldByName('I_EMP_FIL').AsInteger;
      SisCadastro.FieldByName('LANRECEBER').AsInteger := VpfUltimoReceberGerado;
      SisCadastro.Post;
      dec(VpfQtdReceberAGerar);
      inc(VpfUltimoReceberGerado);
      VpaRegistro.Position:= VpaRegistro.Position + 1;
    end;
    VpaTabelas.Progress:= VpaTabelas.Progress + 1;
    ExecutaComandoSql(SisLog,'UPDATE CADFILIAIS ' +
                             ' SET I_ULT_REC = '+IntToStr(VpfUltimoReceberGerado-1)+
                             ' WHERE I_EMP_FIL = '+IntToStr(SisAux.FieldByName('I_EMP_FIL').ASinteger));
    SisAux.Next;
  end;
  Sisaux.Close;
  SisCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.GeraSequenciasNotas(VpaRegistro: TProgressBar; VpaLabel : TLabel; VpaTabelas: TGauge): string;
var
  VpfQtdNotasAGerar, VpfUltimaNotaGerada : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(SisAux,'Select I_EMP_FIL, I_ULT_SEN FROM CADFILIAIS');
  AdicionaSQLAbreTabela(SisCadastro,'Select * FROM NUMERONOTA '+
                               ' Where CODFILIAL = 0 AND SEQNOTA = 0');
  while not SisAux.Eof do
  begin
    VpfQtdNotasAGerar := Varia.QtdNumeroPedidoGerar - RQtdNumerosNotasFilial(SisAux.FieldByName('I_EMP_FIL').AsInteger);
    VpaRegistro.Max:= 0;
    VpaRegistro.Max:= VpfQtdNotasAGerar;
    VpfUltimaNotaGerada := SisAux.FieldByName('I_ULT_SEN').AsInteger;
    INC(VpfUltimaNotaGerada);
    while VpfQtdNotasAGerar > 0 do
    begin
      while ExisteSeqNota(SisAux.FieldByName('I_EMP_FIL').AsInteger,VpfUltimaNotaGerada) do
        INC(VpfUltimaNotaGerada);

      SisCadastro.Insert;
      SisCadastro.FieldByName('CODFILIAL').AsInteger := SisAux.FieldByName('I_EMP_FIL').AsInteger;
      SisCadastro.FieldByName('SEQNOTA').AsInteger := VpfUltimaNotaGerada;
      SisCadastro.Post;
      dec(VpfQtdNotasAGerar);
      inc(VpfUltimaNotaGerada);
      VpaLabel.Caption:= 'Sequencias de notas filial: ' + IntToStr(SisCadastro.FieldByName('CODFILIAL').AsInteger);
      VpaLabel.Refresh;
      VpaRegistro.Position:= VpaRegistro.Position + 1;
    end;
    VpaTabelas.Progress:= VpaTabelas.Progress + 1;
    ExecutaComandoSql(SisLog,'UPDATE CADFILIAIS ' +
                             ' SET I_ULT_SEN = '+IntToStr(VpfUltimaNotaGerada-1)+
                             ' WHERE I_EMP_FIL = '+IntToStr(SisAux.FieldByName('I_EMP_FIL').ASinteger));
    SisAux.Next;
  end;
  Sisaux.Close;
  SisCadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSistema.GravaDataUltimaBaixa(VpaData : TDateTime);
var
 VpfIni : TRegIniFile;
begin
 // informacoes do ini
  VpfIni := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  VpfIni.OpenKey('GERAIS',true);
  VpfIni.WriteDate('DATABAIXACR', VpaData);
  VpfIni.free;
end;

{******************************************************************************}
function TRBFuncoesSistema.RAssinaturaRegistro(VpaTabela: TDataSet): String;
var
  VpfLacoCampos, VpfLacoLetras,VpfValorCampos : Integer;
  VpfTextoCampo : String;
begin
  VpfValorCampos := 0;
  for VpfLacoCampos := 0 to VpaTabela.FieldCount - 1 do
  begin
    if (VpaTabela.Fields[VpfLacoCampos].DisplayName = 'C_ASS_REG') or
       (VpaTabela.Fields[VpfLacoCampos].DisplayName = 'DESASSINATURAREGISTRO')then
      break;
    VpfTextoCampo := VpaTabela.Fields[VpfLacoCampos].AsString;
    for VpfLacoLetras := 1 to Length(VpfTextoCampo) do
    begin
      VpfValorCampos := VpfValorCampos + Ord(VpfTExtoCampo[VpfLacoLetras]);
    end;
  end;
  result := Criptografa(IntToStr(VpfValorCampos));
end;

{******************************************************************************}
function TRBFuncoesSistema.RDataServidor: TDateTime;
begin
  AdicionaSQLAbreTabela(SisAux,'Select SYSDATE from DUAL');
  result := SisAux.FieldByName('SYSDATE').AsDateTime;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RDataUltimaBaixa : TDateTime;
var
 VpfIni : TRegIniFile;
begin
 // informacoes do ini
  VpfIni := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  VpfIni.OpenKey('GERAIS',true);
  try
    result := VpfIni.ReadDate('DATABAIXACR');
  except
    result := date;
  end;
  VpfIni.free;
end;

{******************************************************************************}
function TRBFuncoesSistema.RDataUltimaImportacao: TDateTime;
begin
  AdicionaSQLAbreTabela(SisAux,'Select D_ULT_IMP FROM CFG_GERAL');
  result := SisAux.FieldByName('D_ULT_IMP').AsDateTime;
  SisAux.Close;
end;

{******************************************************************************}
procedure  TRBFuncoesSistema.CarDFilial(VpaDFilial : TRBDFilial;VpaCodFilial : Integer);
begin
  AdicionaSQLAbreTabela(SisAux,'Select I_EMP_FIL, C_NOM_FIL, C_NOM_FAN, C_WWW_FIL, C_END_ELE, C_FAX_FIL, '+
                               ' C_BAI_FIL, C_CID_FIL, C_EST_FIL, I_CEP_FIL, C_FON_FIL, C_END_FIL,I_NUM_FIL, '+
                               ' C_CRM_CES, C_CRM_CCL, C_EMA_COM, C_CGC_FIL, C_INS_FIL, C_CAB_EMA, C_MEI_EMA,  '+
                               ' L_ROD_EMA, I_COD_FIS, C_INS_MUN, C_PER_SPE, I_ATI_SPE, C_CPC_SPE, '+
                               ' C_CRC_SPE, C_NCO_SPE, I_CON_SPE, C_IND_NFE '+
                               ' from CADFILIAIS '+
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial));
  with VpaDFilial do
  begin
    CodFilial := VpaCodFilial;
    NomFilial := SisAux.FieldByname('C_NOM_FIL').AsString;
    NomFantasia := SisAux.FieldByname('C_NOM_FAN').AsString;
    DesSite := SisAux.FieldByname('C_WWW_FIL').AsString;
    DesEmail := SisAux.FieldByname('C_END_ELE').AsString;
    DesEndereco := SisAux.FieldByname('C_END_FIL').AsString+', '+SisAux.FieldByname('I_NUM_FIL').AsString;
    DesEnderecoSemNumero := SisAux.FieldByname('C_END_FIL').AsString;
    NumEndereco :=SisAux.FieldByname('I_NUM_FIL').AsInteger;
    DesBairro := SisAux.FieldByname('C_BAI_FIL').AsString;
    DesCidade := SisAux.FieldByname('C_CID_FIL').AsString;
    DesUF := SisAux.FieldByname('C_EST_FIL').AsString;
    DesCep := SisAux.FieldByname('I_CEP_FIL').AsString;
    DesFone := SisAux.FieldByname('C_FON_FIL').AsString;
    DesEmailComercial := SisAux.FieldByname('C_EMA_COM').AsString;
    DesCNPJ := SisAux.FieldByname('C_CGC_FIL').AsString;
    DesInscricaoEstadual := SisAux.FieldByname('C_INS_FIL').AsString;
    DesInscricaoMunicipal := SisAux.FieldByname('C_INS_MUN').AsString;
    DesCabecalhoEmailProposta := SisAux.FieldByname('C_CAB_EMA').AsString;
    DesMeioEmailProposta := SisAux.FieldByname('C_MEI_EMA').AsString;
    DesRodapeEmailProposta := SisAux.FieldByname('L_ROD_EMA').AsString;
    Varia.CRMCorEscuraEmail := SisAux.FieldByName('C_CRM_CES').AsString;
    varia.CRMCorClaraEmail := SisAux.FieldByName('C_CRM_CCL').AsString;
    CodIBGEMunicipio := SisAux.FieldByname('I_COD_FIS').AsInteger;
    DesPerfilSpedFiscal := SisAux.FieldByName('C_PER_SPE').AsString;
    CodAtividadeSpedFiscal := SisAux.FieldByName('I_ATI_SPE').AsInteger;
    DesCPFContador := SisAux.FieldByName('C_CPC_SPE').AsString;
    DesCRCContador := SisAux.FieldByName('C_CRC_SPE').AsString;
    NomContador := SisAux.FieldByName('C_NCO_SPE').AsString;
    CodContabilidade := SisAux.FieldByName('I_CON_SPE').AsInteger;
    IndEmiteNFE := SisAux.FieldByName('C_IND_NFE').AsString = 'T';
    DesFax:= SisAux.FieldByName('C_FAX_FIL').AsString;
  end;
  sisAux.Close;

end;

{******************************************************************************}
procedure TRBFuncoesSistema.CarDVendedor(VpaDVendedor: TRBDVendedor;
  VpaCodVendedor: integer);
begin
  AdicionaSQLAbreTabela(SisAux,'SELECT I_COD_VEN, C_NOM_VEN,  C_DES_EMA, C_IND_NFE ' +
                               ' FROM CADVENDEDORES ' +
                               ' WHERE I_COD_VEN = ' + IntToStr(VpaCodVendedor));
  with VpaDVendedor do
  begin
    CodVendedor := VpaCodVendedor;
    NomVendedor:= SisAux.FieldByname('C_NOM_VEN').AsString;
    DesEmail:= SisAux.FieldByname('C_DES_EMA').AsString;
    IndEnviaCopiaEmailNfe:= SisAux.FieldByname('C_IND_NFE').AsString='S';
  end;
  sisAux.Close;

end;

{******************************************************************************}
procedure TRBFuncoesSistema.SalvaTabelasAbertas;
var
  VpfArquivo : TStringList;
  VpfLaco : Integer;
  VpfTabela : TSQLQUERY;
begin
{ tem que verificar no dbx como faz essa rotina;
  if FPrincipal.BaseBDE.DataSetCount > RTabelasQuePodemFicarAbertas then
  begin
    VpfArquivo := TStringList.create;
    VpfArquivo.Add('Aplicativo = '+Application.ExeName);
    VpfArquivo.Add('Formulario Ativo = '+Screen.ActiveForm.Name);
    VpfArquivo.Add('');
    VpfArquivo.Add('Formularios Aberto');
    for VpfLaco := Screen.FormCount - 1 downto 0 do
    begin
      VpfArquivo.Add(Screen.Forms[vpflaco].Name);
    end;

    VpfArquivo.Add('');
    VpfArquivo.Add('Tabelas Abertas');
    for VpfLaco := 0 to FPrincipal.BaseBDE.DataSetCount - 1 do
    begin
      if (FPrincipal.BaseBDE.DataSets[VpfLaco] is TSQLQUERY) then
      begin
        VpfTabela := TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]);
        VpfArquivo.add('----------------------------------------------------');
        VpfArquivo.add('Nome Componente = '+VpfTabela.Name);
        if VpfTabela.Owner <> nil then
          VpfArquivo.add('Dono = '+VpfTabela.Owner.Name);
        VpfArquivo.add(VpfTabela.SQL.text);
      end;
    end;
    if VpfArquivo.Count > 0 then
    begin
      VpfArquivo.add(Application.Name);
//      VpfArquivo.savetofile(Varia.DiretorioSistema+'\tabelas'+FormatDateTime('YYYYMMDD_HHMMSS',now)+'.txt');
    end;
    VpfArquivo.free;
  end;}
end;

{******************************************************************************}
function TRBFuncoesSistema.ValidaSerieSistema : Boolean;
var
  VpfData : TDateTime;
begin
  result := false;
  VpfData := RDatValidadeSistema;
  result := VpfData > date;
  if not result then
  begin
    result := RegistraSistema;
  end
  else
    if VpfData < IncDia(date,10) then
      if confirmacao('O registro do sistema irá expirar em '+IntToStr(DiasPorPeriodo(date,VpfData)) + ' dias. Entre em contato o mais breve possível com o seu fornecedor de Software para adquirir um novo registro.'#13+
                     'Deseja registrar o sistema agora?') then
        RegistraSistema;
end;


{******************************************************************************}
procedure TRBFuncoesSistema.VerificaArquivosAuxiliares;
begin
  AdicionaSQLAbreTabela(SisAux,'Select * from ARQUIVOAUXILIAR ' +
                               ' ORDER BY NOMARQUIVO ');
  while not SisAux.eof do
  begin
    if not ExisteArquivo(varia.DiretorioSistema+'\'+SisAux.FieldByName('NOMARQUIVO').AsString) then
      CopiaArquivo(Varia.PathVersoes+'\'+SisAux.FieldByName('NOMARQUIVO').AsString,varia.DiretorioSistema+'\'+SisAux.FieldByName('NOMARQUIVO').AsString);
    SisAux.next;
  end;
  SisAux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSistema.VerificaDataBackup;
var
  VpfDatUltimoBackup : TDatetime;
begin
  AdicionaSQLAbreTabela(SisAux,'Select D_ULT_BAC from CFG_GERAL');
  VpfDatUltimoBackup := SisAux.FieldByName('D_ULT_BAC').AsDateTime;
  if QdadeDiasUteis(VpfDatUltimoBackup ,Sistema.RDataServidor) >= 2  then
    aviso('BACKUP INATIVO!!!!'#13'A rotina de backup não está funcionando corretamente, o ultimo backup executado foi em '+FormatDateTime('DD/MM/YYYY HH:MM',VpfDatUltimoBackup)+'.');
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.AtualizaInformacoesGerencialCustos(VpaDiaAnterior,VpaData : TDateTime) : String;
var
  vpfQtdCustoPendentes : Integer;
begin
  result := '';
  vpfQtdCustoPendentes := RQtdCustosPendentes;
  result := InicializaDiaCusto(VpaData,vpfQtdCustoPendentes);
  if result = '' then
    result := AtualizaCustoUltimoDia(VpaDiaAnterior,vpfQtdCustoPendentes);
end;

{******************************************************************************}
function TRBFuncoesSistema.AtualizaDataInformacaoGerencial(VpaData : TDateTime) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(SisCadastro,'Select * from CFG_GERAL');
  SisCadastro.edit;
  SisCadastro.FieldByName('D_INF_GER').AsDateTime := VpaData;
  SisCadastro.post;
  result := SisCadastro.AMensagemErroGravacao;
  SisCadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesSistema.AtualizaDataUltimoBackup;
begin
  AdicionaSQLAbreTabela(SisCadastro,'Select * from CFG_GERAL');
  SisCadastro.Edit;
  SisCadastro.FieldByName('D_ULT_BAC').AsDateTime := RDataServidor;
  SisCadastro.fieldbyName('D_ULT_ALT').AsDateTime := SisCadastro.FieldByName('D_ULT_BAC').AsDateTime;
  SisCadastro.Post;
  SisCadastro.Close;
  MarcaTabelaParaImportar('CFG_GERAL');
end;

end.
