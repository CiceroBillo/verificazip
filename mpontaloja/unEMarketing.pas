Unit unEMarketing;
{Verificado
-.edit;
}
Interface

Uses Classes, DBTables, SysUtils, UnDados,IdMessage, IdSMTP, UnSistema, stdctrls, comctrls,
  forms, unClientes,idPop3, UnProspect, idtext,IdAttachmentFile,sqlExpr,
  tabela, db;

//classe localiza
Type TRBLocalizaEMarketing = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesEMarketing = class(TRBLocalizaEMarketing)
  private
    Aux,
    Tabela,
    Clientes :TSQLQUERY;
    Cadastro : TSQL;
    VprMensagem : TidMessage;
    VprSMTP : TIdSMTP;
    VprPop : TidPOP3;
    VprLabelStatus : TLabel;
    function GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpaQtdLigacoes : Integer) : Integer;
    procedure AdicionaTarefaItem(VpaSeqTarefa,VpaCodCliente : Integer;VpaErro : String);
    procedure AtualizaQtdEmailEnviados(VpaDTarefa : TRBDTarefaEMarketing);
    procedure AtualizaQtdEmailNovaTarefa(VpaSeqTarefa : Integer);
    procedure AtualizaStatusLeituraEmail(VpaStatus : String);
    function AdicionaEmailCliente(VpaCodCliente: Integer; VpaNomContato, VpaDesEmail,VpaContatoPrincipal : String):string;
    procedure PosClientesEMarketing(VpaTabela : TDataSet;VpaSeqTarefa : Integer);
    procedure PosClientesparaTeleMarketing(VpaTabela : TDataSet; VpaSeqTarefa : Integer);
    function RAssuntoEmail(VpaAssunto,VpaNomCliente : String) : String;
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial;VpaDEmailMarketing : TRBDEmailMarketing) : string;
    procedure MontaEmailHTML(VpaTexto : TStrings; VpaDTarefa: TRBDTarefaEMarketing);
    function ConectaEmail(VpaSMTP : TIdSMTP;VpaDEmailMarketing : TRBDEmailMarketing;VpaLabel : TLabel) : string;
    function ConectaPop(VpaPop : TidPOP3;VpaDEmailMarketing : TRBDEmailMarketing) : string;
    function MensagemEmailInvalido(VpaMensagem : TIdMessage) : Boolean;
    function MensagemRespostaAutomatica(VpaMensagem : TIdMessage) : Boolean;
    function REmailMensagemInvalida(VpaMensagem : TIdMessage;var VpaTempoemailExcedito : Boolean) : string;
    function REmailLinha(VpaLinha : String) : String;
    function REmailLinhaFinalRecipients(VpaLinha : String) : String;
    function GravaEnvioTarefaCliente(VpaSeqTarefa,VpaCODCliente,VpaSeqContato : Integer;VpaDesErro : String):string;
    procedure CadastraEmailsAdicionaisCliente(VpaCodCliente : Integer; VpaDominio : String);
    function DesativaEmail(VpaMensagem : TIdMessage) : boolean;
    function DesativaEmailCliente(VpaDesEmail : String) : Integer;
    function DesativaEmailContatoCliente(VpaDesEmail : String) : Integer;
    function DesativaEmailProspect(VpaDesEmail : String) : Integer;
    function DesativaEmailContatoProspect(VpaDesEmail : String) : Integer;
    function RQtdEMail(VpaSeqTarefa : Integer) : Integer;
    function RQTDEmailsNaoEnviados(VpaSeqTarefa : Integer) : Integer;
    function RQtdEmailEnviado(VpaSeqTarefa : Integer) : Integer;
    procedure MontaEmailTexto(VpaTexto : TStrings; VpaDTarefa: TRBDTAREFAEMARKETING);
    procedure PreparaEmailCliente(VpaDTarefa: TRBDTAREFAEMARKETING;VpaEmailRemente : string);
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    procedure AtualizaQtdEmail(VpaSeqTarefa : Integer);
    procedure CarDTarefaEMarkegting(VpaDTarefa : TRBDTarefaEMarketing;VpaSeqTarefa : Integer);
    function CadastraEmailsAdicionaisProspect(VpaCodProspect : Integer; VpaDominio, VpaOrigem : String) :string;
    function EnviaEMarketingCliente(VpaDTarefa : TRBDTAREFAEMARKETING;VpaLabel,VpaNomContaEmail,VpaEmailDestino,VpaQtdEmail : TLabel;VpaProgresso : TProgressBar;VpaListaEmail : TListBox):String;overload;
    function EmailDominioProvedores(VpaEmail : String) : Boolean;
    function GeraTarefaTeleMarketing(VpaSeqTarefa, VpaCodUsuario : Integer):string;
    function VerificaEmailInvalido(VpaProgresso : TProgressBar;VpaStatus,VpaContaEmail : TLabel) : string;
    function ExisteEmail(VpaEmail : string) : boolean;
    procedure ExcluiTarefa(VpaSeqTarefa : Integer);
end;



implementation

Uses FunSql, Constantes, FunArquivos, FunString, ConstMsg, funObjeto,FunData;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaEMarketing
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaEMarketing.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesEMarketing
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesEMarketing.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  Clientes := TSQLQuery.Create(nil);
  Clientes.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  //componentes indy
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);
  VprPop := TidPOP3.Create(nil);
end;

{******************************************************************************}
destructor TRBFuncoesEMarketing.destroy;
begin
  Aux.Free;
  Clientes.free;
  Cadastro.free;
  VprMensagem.free;
  VprSMTP.free;
  VprPop.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpaQtdLigacoes : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFATELEMARKETING');
  Cadastro.insert;
  Cadastro.FieldByname('DATTAREFA').AsDateTime := now;
  Cadastro.FieldByname('QTDLIGACOES').AsInteger := VpaQtdLigacoes;
  Cadastro.FieldByname('DATAGENDAMENTO').AsDateTime := Date;
  Cadastro.FieldByname('SEQCAMPANHA').AsInteger := Varia.SeqCampanhaCadastrarEmail;
  Cadastro.FieldByname('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByname('CODUSUARIOTELE').AsInteger := VpaCodUsuario;
  result := FunClientes.RSeqTarefaDisponivel;
  Cadastro.FieldByname('SEQTAREFA').AsInteger := result;
  Cadastro.post;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.AdicionaEmailCliente(VpaCodCliente: Integer;VpaNomContato, VpaDesEmail, VpaContatoPrincipal: String): string;
begin
  result := '';
  VpaDesEmail := RetiraAcentuacao(VpaDesEmail);
  VpaDesEmail := SubstituiStr(VpaDesEmail,',','.');
  if (VpaDesEmail = '') then
  begin
    if VpaContatoPrincipal = 'S' then
      result := 'Falta o email principal do prospect '+IntToStr(VpaCodCliente)
    else
      result := 'Falta e-mail do contato "'+VpaNomContato+'" do prospect '+IntToStr(VpaCodCliente);
  end;
  if result = '' then
  begin
    VprMensagem.Recipients.EMailAddresses := LowerCase(VpaDesEmail);
//    VprMensagem.BccList.Add.Address := 'rafael@eficaciaconsultoria.com.br';
  end;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.AdicionaTarefaItem(VpaSeqTarefa,VpaCodCliente : Integer;VpaErro : String);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETINGITEM ');
  Cadastro.insert;
  CadaStro.FieldByname('SEQTAREFA').AsInteger :=  VpaSeqTarefa;
  Cadastro.FieldByname('CODCLIENTE').AsInteger :=  VpaCodCliente;
  Cadastro.FieldByname('DESERRO').AsString :=  VpaErro;
  CadaStro.FieldByname('INDENVIADO').AsString := 'N';
  try
    Cadastro.post;
  except
    on e : Exception do aviso('ERRO NA GRAVAÇÃO DA TAREFAEMARKETINGITEM!!!!'#13+e.message);
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.AtualizaQtdEmailEnviados(VpaDTarefa : TRBDTarefaEMarketing);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETING '+
                                 ' Where SEQTAREFA = ' +IntToStr(VpaDTarefa.SeqTarefa));
  Cadastro.edit;
  Cadastro.FieldByname('QTDEMAILENVIADO').AsInteger :=RQtdEmailEnviado(VpaDTarefa.SeqTarefa) ;
  Cadastro.FieldByname('QTDNAOENVIADO').AsInteger :=RQTDEmailsNaoEnviados(VpaDTarefa.SeqTarefa);
  Cadastro.post;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.AtualizaQtdEmailNovaTarefa(VpaSeqTarefa : Integer);
var
  VpfQtd : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select COUNT(SEQTAREFA) QTD from TAREFAEMARKETINGITEM '+
                            ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa));
  Vpfqtd := Aux.FieldByname('QTD').AsInteger;
  ExecutaComandoSql(Aux,'Update TAREFAEMARKETING '+
                        ' set QTDEMAIL = ' + IntToStr(VpfQtd)+
                        ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa));
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.AtualizaStatusLeituraEmail(VpaStatus : String);
begin
  VprLabelStatus.Caption := AdicionaCharD(' ',VpaStatus,100);
  VprLabelStatus.Refresh;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.PosClientesEMarketing(VpaTabela : TDataSet;VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select TIM.CODCLIENTE, TIM.SEQCONTATO, TIM.NOMCONTATO, TIM.DESEMAIL, '+
                                  ' TIM.INDCONTATOPRINCIPAL ' +
                                  ' from TAREFAEMARKETINGITEM TIM '+
                                  ' WHERE TIM.SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                                  ' AND TIM.INDENVIADO = ''N''');
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.PosClientesparaTeleMarketing(VpaTabela : TDataSet; VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select I_COD_CLI, C_NOM_CLI,TIM.DESERRO  '+
                                  ' from CADCLIENTES CLI, TAREFAEMARKETINGITEM TIM '+
                                  ' WHERE CLI.I_COD_CLI = TIM.CODCLIENTE '+
                                  ' AND TIM.SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                                  ' AND TIM.INDENVIADO = ''N''');
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.PreparaEmailCliente(VpaDTarefa: TRBDTAREFAEMARKETING; VpaEmailRemente: string);
var
  VpfEmailHTML, VpfEMailTexto : TIdText;
  Vpfbmppart : TIdAttachmentfile;
begin
  VprMensagem.Clear;
  VprMensagem.ReplyTo.EMailAddresses := VpaEmailRemente;
  VprMensagem.ReceiptRecipient.Text := VpaEmailRemente;
  VpfEMailTexto := TIdText.Create(VprMensagem.MessageParts);
  VpfEMailTexto.ContentType := 'text/plain';
  MontaEmailTexto(VpfEMailTexto.Body,VpaDTarefa);
  VprMensagem.Headers.Add('X-Spam-Flag: anti-spam disabled');
  VprMensagem.Headers.Add('X-Mailer: Microsoft Windows Mail 6.0.6002.18006');
  VprMensagem.Headers.Add('X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6002.18006');

  if VpaDTarefa.FormatoEmail = feHTML then
  begin
    VprMensagem.ContentType := 'multipart/alternative';
    VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    MontaEmailHTML(VpfEmailHTML.Body,VpaDTarefa);
  end
  else
    if VpaDTarefa.FormatoEmail = feTexto then
      VprMensagem.ContentType := 'multipart/mixed';


  if copy(LowerCase(VpaDTarefa.NomArquivoAnexo),1,7) <> 'http://' then
  begin
    Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,VpaDTarefa.NomArquivoAnexo );
    Vpfbmppart.ContentType := 'image/jpg';
    Vpfbmppart.ContentDisposition := 'inline';
    Vpfbmppart.ExtraHeaders.Values['content-id'] := RetornaNomArquivoSemDiretorio(VpaDTarefa.NomArquivoAnexo) ;
    Vpfbmppart.DisplayName := RetornaNomArquivoSemDiretorio(VpaDTarefa.NomArquivoAnexo);

  end;

  VprMensagem.Subject := VpaDTarefa.DesAssuntoEmail;
//  VpfEmailHTML.free;
//  Vpfbmppart.free;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.RAssuntoEmail(VpaAssunto,VpaNomCliente : String) : String;
begin
  if ExisteLetraString('@',VpaAssunto) then
    result := SubstituiStr(VpaAssunto,'@',VpaNomCliente)
  else
    result := VpaAssunto;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.EnviaEMarketingCliente(VpaDTarefa: TRBDTAREFAEMARKETING; VpaLabel, VpaNomContaEmail,VpaEmailDestino, VpaQtdEmail: TLabel; VpaProgresso: TProgressBar;VpaListaEmail: TListBox): String;
var
  VpfDFilial : TRBDFilial;
  VpfQtdEmail, VpfQtdEnvioRemetente, VpfCodProspect,VpfIndiceEmailRemetente : Integer;
  VpfEmailsRemetente : TList;
  VpfDEmailMarketing : TRBDEmailMarketing;
  VpfUltimoEnvio : TDatetime;
  VpfdTarefaItem : TRBDTarefaEMarketingProspectItem;
begin
  VpfEmailsRemetente := TList.create;
  VpfIndiceEmailRemetente := 0;
  result := Sistema.CarEmailMarketing(VpfEmailsRemetente);
  if result = '' then
  begin
    VpfDEmailMarketing := TRBDEmailMarketing(VpfEmailsRemetente.Items[VpfIndiceEmailRemetente]);
    VpaNomContaEmail.Caption := VpfDEmailMarketing.DesEmail;
    VpaNomContaEmail.Refresh;

    VpaProgresso.Max := VpaDTarefa.QtdEmail;
    VpaProgresso.Position := 0;
    VpfUltimoEnvio := now;
    PreparaEmailCliente(VpaDTarefa,VpfDEmailMarketing.DesEmail);
    VpfQtdEmail := 999999;
    VpfQtdEnvioRemetente := 0;

    VpfDFilial := TRBDFilial.cria;
    Sistema.CarDFilial(VpfDFilial,Varia.CodigoEmpFil);

    PosClientesEMarketing(Clientes,VpaDTarefa.SeqTarefa);
    While not Clientes.eof do
    begin
      if VpfQtdEmail >= 10 then
      begin
        AtualizaQtdEmailEnviados(VpaDTarefa);

        if (VpfQtdEnvioRemetente > 6) then
        begin
          VpfQtdEnvioRemetente := 0;
          inc(VpfIndiceEmailRemetente);
          if VpfIndiceEmailRemetente >= VpfEmailsRemetente.Count then
             VpfIndiceEmailRemetente := 0;
          VpfDEmailMarketing := TRBDEmailMarketing(VpfEmailsRemetente.Items[VpfIndiceEmailRemetente]);
          VpaNomContaEmail.Caption := VpfDEmailMarketing.DesEmail;
          VpaNomContaEmail.Refresh;
        end;
        VprSMTP.Disconnect;
        while not VprSMTP.Connected do
        begin
          Result := ConectaEmail(VprSMTP,VpfDEmailMarketing,VpaLabel);
          VpaListaEmail.Items.Insert(0,FormatDateTime('HH:MM:SS ',now)+result);
          if VpaDTarefa.IndInterromper then
            break;
        end;
        VpfQtdEmail := 0;
      end;
      if VpaDTarefa.IndInterromper then
        break;
      result := EmailValido(Clientes.FieldByname('DESEMAIL').AsString);
      if result = '' then
      begin
        VpaEmailDestino.Caption := Clientes.FieldByname('DESEMAIL').AsString;
        VpaEmailDestino.Refresh;
        result := AdicionaEmailCliente(Clientes.FieldByname('CODCLIENTE').AsInteger,Clientes.FieldByname('NOMCONTATO').AsString,
                          Clientes.FieldByname('DESEMAIL').AsString,Clientes.FieldByname('INDCONTATOPRINCIPAL').AsString);
        if result = '' then
        begin
          VpaLabel.Caption := 'Aguardando tempo para enviar e-mail';
          VpaLabel.Refresh;
          while IncSegundo(VpfUltimoEnvio,6) > now do //espera 1 segundos para mandar cada e-mail;
            sleep(1000);
          VpaLabel.Caption := 'Enviando e-mail';
          VpaLabel.Refresh;

          result := EnviaEmail(VprMensagem,VprSMTP,VpfDFilial,VpfDEmailMarketing);
          VpaListaEmail.Items.Insert(0,Clientes.FieldByname('DESEMAIL').AsString+'('+result+')');
          VpaLabel.Caption := 'Gravando status envio';
          GravaEnvioTarefaCliente(VpaDTarefa.SeqTarefa,Clientes.FieldByname('CODCLIENTE').AsInteger,Clientes.FieldByname('SEQCONTATO').AsInteger,result);
          VpfUltimoEnvio := now;

          VprMensagem.BccList.Clear;
          VprMensagem.CCList.Clear;
          VprMensagem.Recipients.Clear;
          inc(VpfQtdEmail);
          inc(VpfQtdEnvioRemetente);
        end;
      end
      else
        VpaListaEmail.Items.Insert(0,Clientes.FieldByname('DESEMAIL').AsString+'(e-mail inválido,nao enviado)');

      VpaProgresso.Position := VpaProgresso.Position + 1;

      VpaQtdEmail.Caption := IntToStr(VpaProgresso.Position);
      VpaQtdEmail.refresh;
      Application.ProcessMessages;

      Clientes.Next;
    end;

    AtualizaQtdEmailEnviados(VpaDTarefa);

    if VprSMTP.Connected then
      VprSMTP.Disconnect;
    VpfDFilial.free;
  end;
  FreeTObjectsList(VpfEmailsRemetente);
  VpfEmailsRemetente.free;

end;

{******************************************************************************}
function TRBFuncoesEMarketing.EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial;VpaDEmailMarketing : TRBDEmailMarketing) : string;
begin
  VpaMensagem.Priority := mpNormal;
  VpaMensagem.From.Address := VpaDEmailMarketing.DesEmail;
  VpaMensagem.From.Name := PrimeirasMaiusculas(VpaDFilial.NomFantasia);


  if config.ServidorInternetRequerAutenticacao then
  begin
    if VpaSMTP.UserName = '' then
      result := 'USUARIO DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações o e-mail de origem.';
    if VpaSMTP.Password = '' then
      result := 'SENHA SMTP DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações a senha do e-mail de origem';
  end;
  if VpaSMTP.Host = '' then
    result := 'SERVIDOR DE SMTP NÃO CONFIGURADO!!!'#13'É necessário configurar qual o servidor de SMTP...';
  if result = '' then
  begin
    try
      VpaSMTP.Send(VpaMensagem);
    except
      on e : exception do
      begin
        result := 'ERRO AO ENVIAR O E-MAIL!!!'#13+e.message;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.MontaEmailHTML(VpaTexto : TStrings; VpaDTarefa: TRBDTarefaEMarketing);
begin
  VpaTexto.clear;
  VpaTexto.add('<html>');
  VpaTexto.add('<title> e-Marketing Listeners Sistemas');
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('  <center>');
  VpaTexto.add('    <a title="Clique, para maiores informações" href="http://'+VpaDTarefa.DesLinkInternet + '">');
  if copy(LowerCase(VpaDTarefa.NomArquivoAnexo),1,7) <> 'http://' then
    VpaTexto.add('      <IMG src="cid:'+RetornaNomArquivoSemDiretorio(VpaDTarefa.NomArquivoAnexo) +' " border="0" >')
  else
    VpaTexto.add('      <IMG src="'+VpaDTarefa.NomArquivoAnexo +' " border="0" >');
  VpaTexto.add('    </a>');
  VpaTexto.add('  </center>');
  VpaTexto.add('  <br>');
  VpaTexto.add('  <center>');
  VpaTexto.add('  <font face="Verdana" size =-3>');
  VpaTexto.add('Esta mensagem não pode ser considerada SPAM por possuir as seguintes características:<br>');
  VpaTexto.add('identificação do remetente, descrição clara do conteúdo e opção para remoção da lista de distribuição');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>Para excluir seu cadastro responda esse e-mail com o assunto REMOVER');
  VpaTexto.add('  </font>');
  VpaTexto.add('  </center>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  if Sistema.PodeDivulgarEficacia then
    VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.MontaEmailTexto(VpaTexto: TStrings;VpaDTarefa: TRBDTAREFAEMARKETING);
begin
  VpaTexto.Text := VpaDTarefa.DesTextoEmail;
  VpaTexto.add('');
  VpaTexto.add('');
  VpaTexto.add('Esta mensagem nao pode ser considerada S - P - A - M por possuir as seguintes caracteristicas:<br>');
  VpaTexto.add('identificacao do remetente, descricao clara do conteudo e opcao para remocao');
  VpaTexto.add('');
  VpaTexto.add('Para excluir seu cadastro responda e-mail com o assunto REMOVER');
  VpaTexto.add('-------------------------------------------------------------------');
end;

{******************************************************************************}
function TRBFuncoesEMarketing.ConectaEmail(VpaSMTP : TIdSMTP;VpaDEmailMarketing : TRBDEmailMarketing;VpaLabel : TLabel) : string;
begin
  result := '';
  if VpaLabel <> nil then
  begin
    VpaLabel.Caption := 'Conectando com o servidor de e-mail';
    VpaLabel.Refresh;
  end;
  if VpaSMTP.Connected then
     VpaSMTP.Disconnect;
  VpaSMTP.UserName := VpaDEmailMarketing.DesEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := varia.PortaSMTP;
  if config.ServidorInternetRequerAutenticacao then
  begin
    VpaSMTP.Password := VpaDEmailMarketing.DesSenha;
    VpaSMTP.AuthType := satDefault;
  end
  else
    VpaSMTP.AuthType := satNone;
  try
    VpaSMTP.Connect;
  except
    on e : exception do result := 'ERRO AO CONECTAR O SERVIDOR'+e.Message;
  end;
  Application.ProcessMessages;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.ConectaPop(VpaPop : TidPOP3;VpaDEmailMarketing : TRBDEmailMarketing) : string;
begin
  result := '';
  if VpaPop.Connected then
    VpaPop.Disconnect;
  AtualizaStatusLeituraEmail('Conectando com o servidor POP');
  VpaPop.Host := Varia.ServidorPop;
  VpaPop.UserName := VpaDEmailMarketing.DesEmail;
  VpaPop.Password := VpaDEmailMarketing.DesSenha;
  NaoExisteCriaDiretorio(RetornaDiretorioCorrente+'\AnexosEmail',false);
  DeletaArquivo(RetornaDiretorioCorrente+'\AnexosEmail\*.*');
  try
    VpaPop.Connect;
    AtualizaStatusLeituraEmail('E-mail conectado com sucesso');
  except
    on e : exception do result := 'ERRO AO CONECTAR O E-MAIL!!!'#13+e.message;
  end;
end;


{******************************************************************************}
function TRBFuncoesEMarketing.MensagemEmailInvalido(VpaMensagem : TIdMessage) : Boolean;
begin
  result := false;
  if (LowerCase(DeletaEspacoE(VpaMensagem.Subject)) = 'failure notice') or
     (LowerCase(VpaMensagem.From.Address) = 'postmaster@hotmail.com') or
     (CopiaAteChar(DeleteAtechar(LowerCase(VpaMensagem.From.Address),'<'),'>') = 'postmaster@'+DeleteAteChar(Varia.SiteFilial,'.')) or
     (LowerCase(CopiaAteChar(VpaMensagem.From.Address,'@')) = 'mailer-daemon') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = 'deliverystatusnotification(failure)') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = '[***spam***]deliverynotification:deliveryhasfailed') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = '') or
//colocado em comentario pois acho que isso seja uma confirmacao de recebimento
//     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = 'deliverystatus') or
//     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = 'deliveryreport') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,21) = 'nãofoipossívelenviar:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,23) = 'nãofoipossívelentregar:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,15) = 'deliveryfailure') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,15) = 'contadesativada') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,16) = 'desativaçãoemail') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,31) = '[??probablespam]deliveryfailure') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = 'deliveryfinalfailurenotice') or
     (LowerCase(DeletaEspacoE(VpaMensagem.Subject)) = 'undelivered mail returned to sender') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,16) = 'deliveryfailure:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,13) = 'undeliverable') or
     (LowerCase(DeletaEspacoE(VpaMensagem.Subject)) = 'n/a') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = 'entregavencida:problemasdeentrega') or
     ExistePalavra(LowerCase(VpaMensagem.Subject),'bulk') or
     (LowerCase(CopiaAteChar(DeleteAteChar(VpaMensagem.From.Address,'<'),'@')) = 'mailer-daemon') then
    result := true;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.MensagemRespostaAutomatica(VpaMensagem : TIdMessage) : Boolean;
begin
  result := false;
  if (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = '[mensagemautomatica]respostaautomática') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = '[mensagemautomatica]Endereçoinutilizado') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = 'avisodeleitura') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = 'avisodeferias') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = 'ausenciatemporaria') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = 'suamensagemfoirecebida,masestouausente') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = '[mensagemautomatica]=?iso-8859-1?q?resposta_autom=e1tica?=') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = '[mensagemautomatica]re:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,5) = 'lida:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,15) = 'e-mailrecebido!') or
     (copy(LowerCase(DeletaEspaco(RetiraAcentuacao(VpaMensagem.Subject))),1,8) = 'naolida:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,17) = 'aviso de leitura:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,6) = 'lidas:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,5) = 'read:') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = 'e-mailrecebido') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,9) = 'entregue:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,8) = 'noleído:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,20) = 'confirmaçãodeleitura') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,8) = 'notread:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,20) = 'confirmacaodeleitura') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,12) = 'confirmação:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,13) = 'nãoentregues:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,20) = '[mensagemautomatica]') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,19) = 'ausênciatemporária:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,21) = 'outofofficeautoreply:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,12) = 'outofoffice:') or
     (copy(DeletaEspaco(VpaMensagem.Subject),1,6) = 'FÉRIAS') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,5) = 'lido:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,15) = 'avisodeleitura:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,7) = 'férias/') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,9) = 'ausencia-') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,16) = 'deliverydelayed:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,16) = 'entregaatrasada:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,14) = 'returnreceipt:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,26) = '[??probablespam]delivered:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,10) = 'delivered:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,20) = 'deliveryconfirmation') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,18) = 'respostaautomatica') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,18) = 'respostaautomática') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,18) = 'mensagemautomatica') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,6) = 'leído:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,14) = 'automaticreply') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,13) = 'auto-resposta') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,13) = 'autoresposta:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,14) = 'automaticreply') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,13) = 'read-receipt:') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,12) = '[auto-reply]') or
     (copy(LowerCase(DeletaEspaco(VpaMensagem.Subject)),1,8) = '[grupos]') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = '[!!spam]dispositivodesegurançadesativado.') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = '[!!spam]chavesdesegurançaexpirada.') or
     (LowerCase(DeletaEspaco(VpaMensagem.Subject)) = '[mensagemautomatica]')then
    result := true;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.REmailLinha(VpaLinha : String) : String;
var
  VpfPosInicial,VpfIndiceLinha, VpfQtdCaracteres : Integer;
begin
  VpfQtdCaracteres := 0;
  if ExisteLetraString('@',VpaLinha) then
  begin
    if ExisteLetraString('#',VpaLinha) then
      VpaLinha := DeleteAteChar(VpaLinha,'@');
    if ExisteLetraString('@',VpaLinha) then
    begin
      VpfIndiceLinha := pos('@',VpaLinha);
      while (VpaLinha[VpfIndiceLinha] <> ' ') and
            (VpaLinha[VpfIndiceLinha] <> '<') and
            (VpfIndiceLinha > 1) do
        dec(VpfIndiceLinha);

      inc(VpfIndiceLinha);
      VpfPosInicial := VpfIndiceLinha;
      while (VpaLinha[VpfIndiceLinha] <> ' ') and
            (VpaLinha[VpfIndiceLinha] <> '>') and
            (VpfIndiceLinha <= Length(VpaLinha) ) do
      begin
        inc(VpfIndiceLinha);
        inc(VpfQtdCaracteres);
      end;
      result := copy(VpaLinha,VpfPosInicial,VpfQtdCaracteres);
      exit;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.REmailLinhaFinalRecipients(VpaLinha: String): String;
begin
  if ExisteLetraString('@',VpaLinha) then
  begin
    VpaLinha := DeleteAteChar(VpaLinha,';');
    if ExisteLetraString('@',VpaLinha) then
    begin
      result := VpaLinha;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.REmailMensagemInvalida(VpaMensagem : TIdMessage;var VpaTempoemailExcedito : Boolean) :string;
var
  VpfLacoMensagem, VpfLacoTexto : Integer;
  VpfCorpo : TStrings;
  VpfLinha : String;
begin
  VpaTempoemailExcedito := false;
  result := '';
  VpfCorpo := VpaMensagem.Body;
  if ExistePalavra(VpfCorpo.Text,'exceeded the max emails per hour') then
  begin
    VpaTempoemailExcedito := true;
    exit;
  end;
  for VpfLacoTexto := 0 to VpfCorpo.Count - 1 do
  begin
    VpfLinha := VpfCorpo.Strings[VpfLacoTexto];
    if (Uppercase(copy(VpfLinha,1,16)) = 'FINAL-RECIPIENT:')or
       (Uppercase(copy(VpfLinha,1,19)) = 'ORIGINAL-RECIPIENT:') then
    begin
      result :=  REmailLinhaFinalRecipients(VpfLinha);
      break;
    end;
    if LowerCase(copy(VpfLinha,1,7)) = 'sender:' then
      Continue;

    if ExisteLetraString('@',VpfLinha) then
    begin
      result :=  VpfLinha;
      break;
    end;

  end;
  if result = '' then
  begin
    for VpfLacoMensagem := 0 to VpaMensagem.MessageParts.Count - 1 do
    begin
      if VpaMensagem.MessageParts.Items[VpfLacoMensagem] is TIdText then
      begin
        VpfCorpo := TIdText(VpaMensagem.MessageParts.Items[VpfLacoMensagem]).Body;
        if ExistePalavra(VpfCorpo.Text,'exceeded the max emails per hour') then
        begin
          VpaTempoemailExcedito := true;
          exit;
        end;
        for VpfLacoTexto := 0 to VpfCorpo.Count - 1 do
        begin
          VpfLinha := VpfCorpo.Strings[VpfLacoTexto];
          if LowerCase(copy(VpfLinha,1,7)) = 'sender:' then
            Continue;
          if ExisteLetraString('@',VpfLinha) and ExisteLetraString('>',VpfLinha) then
          begin
            while ExisteLetraString('<',VpfLinha) do
            begin
              VpfLinha := DeleteAteChar(VpfLinha,'<');
              if ExisteLetraString('@',VpfLinha) and not ExisteLetraString('#',VpfLinha) then
              begin
                result :=  CopiaAteChar(VpfLinha,'>');
                break;
              end;
            end;
            if result <> '' then
              break;
          end;
          if ExisteLetraString('@',VpfLinha) and not ExisteLetraString('#',VpfLinha) then
          begin
            result :=  VpfLinha;
            break;
          end;
        end;
      end;
      if result <> '' then
        break;
    end;
  end;
  Result := DeletaChars(DeletaChars(DeletaChars(DeletaChars(DeletaChars(result,''''),' '),'<'),'>'),':');
end;

function TRBFuncoesEMarketing.EmailDominioProvedores(VpaEmail : String) : Boolean;
begin
  result := false;
  if ExisteLetraString('@',VpaEmail) then
    VpaEmail := DeleteAteChar(VpaEmail,'@');
  if (VpaEmail = 'terra.com.br') or
     (VpaEmail = 'hotmail.com') or
     (VpaEmail = 'hotmail.com.br') or
     (VpaEmail = 'iscc.com.br') or
     (VpaEmail = 'netvale.net') or
     (VpaEmail = 'bol.com.br') or
     (VpaEmail = 'uol.com.br') or
     (VpaEmail = 'unetvale.com.br') or
     (VpaEmail = 'matrix.com.br') or
     (VpaEmail = 'yahoo.com.br') or
     (VpaEmail = 'brturbo.com.br') or
     (VpaEmail = 'gmail.com') or
     (VpaEmail = 'gmail.com.br') or
     (VpaEmail = 'zaz.com.br') or
     (VpaEmail = 'nutecnet.com.br') or
     (VpaEmail = 'ig.com.br') or
     (VpaEmail = 'tpa.com.br') or
     (VpaEmail = 'superig.com.br') or
     (VpaEmail = 'globo.com') or
     (VpaEmail = 'sol.com') or
     (VpaEmail = 'correioweb.com.br') or
     (VpaEmail = 'aol.com.br') or
     (VpaEmail = 'braznet.com.br') or
     (VpaEmail = 'creativenet.com.br') or
     (VpaEmail = 'zipmail.com.br') or
     (VpaEmail = 'flynet.com.br') or
     (VpaEmail = 'netron.com.br') or
     (VpaEmail = 'pop.com.br') or
     (VpaEmail = 'onda.com.br') or
     (VpaEmail = 'netron.com.br') or
     (VpaEmail = 'microsoft.msn.com') or
     (VpaEmail = 'bb.com') or
     (VpaEmail = 'bb.com.br') or
     (VpaEmail = 'americanas.com') or
     (VpaEmail = 'besc.com.br') or
     (VpaEmail = 'netuno.com.br') or
     (VpaEmail = 'gvt.com.br') or
     (VpaEmail = 'branet.com.br') or
     (Pos('.gov.', VpaEmail) > 0) or
     (VpaEmail = 'caixa.org.br') or
     (VpaEmail = 'live.com') or
     (VpaEmail = 'br.turbo.com') or
     (VpaEmail = 'net.com.br') or
     (VpaEmail = 'brasil.net') or
     (VpaEmail = 'brturbo.com') or
     (VpaEmail = 'net.com.br') or
     (VpaEmail = 'net.com.br') or
     (VpaEmail = 'ibest.com.br') then
    result := true;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.ExcluiTarefa(VpaSeqTarefa: Integer);
begin
  ExecutaComandoSql(Aux,'Delete from TAREFAEMARKETINGITEM ' +
                        ' Where SEQTAREFA = '+  IntToStr(VpaSeqTarefa));
  ExecutaComandoSql(Aux,'Delete from TAREFAEMARKETING ' +
                        ' Where SEQTAREFA = '+  IntToStr(VpaSeqTarefa));
end;

{******************************************************************************}
function TRBFuncoesEMarketing.ExisteEmail(VpaEmail : string) : boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_CLI  from CADCLIENTES ' +
                                 ' Where LOWER(C_END_ELE) = '''+LowerCase(VpaEmail)+'''');
  result := not Aux.Eof;

  if not result then
  begin
    AdicionaSQLAbreTabela(Aux,'Select CODCLIENTE '+
                                 ' from CONTATOCLIENTE ' +
                                 ' Where lower(DESEMAIL) = '''+LowerCase(VpaEmail)+'''');
    result := not Aux.Eof;

    if not result then
    begin
      AdicionaSQLAbreTabela(Aux,'Select CODPROSPECT '+
                                 ' from PROSPECT ' +
                                 ' Where LOWER(DESEMAILCONTATO) = '''+LowerCase(VpaEmail)+'''');

      result := not Aux.Eof;

      if not result then
      begin
        AdicionaSQLAbreTabela(Aux,'Select CODPROSPECT '+
                                 ' from CONTATOPROSPECT ' +
                                 ' Where Lower(DESEMAIL) = '''+LowerCase(VpaEmail)+'''');
        result := not Aux.Eof;
      end;
    end;
  end;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.GravaEnvioTarefaCliente(VpaSeqTarefa,VpaCODCliente,VpaSeqContato : Integer;VpaDesErro : String):string;
begin
  begin
    AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETINGITEM '+
                                 ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa)+
                                 ' and CODCLIENTE = '+IntToStr(VpaCODCliente)+
                                 ' and SEQCONTATO = '+IntToStr(VpaSeqContato));
    Cadastro.Edit;
    if VpaDesErro = '' then
    begin
      Cadastro.FieldByname('INDENVIADO').AsString := 'S';
      Cadastro.FieldByname('DATENVIO').AsDateTime := now;
      Cadastro.FieldByname('DESERRO').Clear;
    end
    else
    begin
      Cadastro.FieldByname('INDENVIADO').AsString := 'N';
      Cadastro.FieldByname('DESERRO').AsString := VpaDesErro;
    end;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
  end;

  if VpaDesErro = '' then
  begin
    if VpaSeqContato = 0 then
      FunClientes.AlteraDatUltimoEmail(VpaCodCliente,now);
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.CadastraEmailsAdicionaisCliente(VpaCodCliente : Integer; VpaDominio : String);
begin
  if not ExisteEmail(UpperCase('diretoria@'+VpaDominio)) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'diretoria@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail(UpperCase('financeiro@'+VpaDominio)) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'financeiro@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail(UpperCase(CopiaAteChar(VpaDominio,'.')+'@'+VpaDominio)) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,CopiaAteChar(VpaDominio,'.')+'@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail(UpperCase('contato@'+VpaDominio)) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'contato@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail(UpperCase('vendas@'+VpaDominio)) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'vendas@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail(UpperCase('sac@'+VpaDominio)) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'sac@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail(UpperCase('comercial@'+VpaDominio)) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'comercial@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail(UpperCase('compras@'+VpaDominio)) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'compras@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail(UpperCase('rh@'+VpaDominio)) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'rh@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
end;

{******************************************************************************}
function TRBFuncoesEMarketing.CadastraEmailsAdicionaisProspect(VpaCodProspect : Integer; VpaDominio, VpaOrigem : String) : string;
begin
  if not ExisteEmail('diretoria@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'diretoria@'+VpaDominio,VpaOrigem);
    result := result + 'diretoria@'+VpaDominio+';';
  end;
  if not ExisteEmail('financeiro@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'financeiro@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'financeiro@'+VpaDominio+';';
  end;
  if not ExisteEmail(CopiaAteChar(VpaDominio,'.')+ '@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,CopiaAteChar(VpaDominio,'.')+ '@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + CopiaAteChar(VpaDominio,'.')+ '@'+VpaDominio+';';
  end;
  if not ExisteEmail('contato@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'contato@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'contato@'+VpaDominio+';';
  end;
  if not ExisteEmail('vendas@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'vendas@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'vendas@'+VpaDominio+';';
  end;
  if not ExisteEmail('sac@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'sac@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'sac@'+VpaDominio+';';
  end;
  if not ExisteEmail('comercial@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'comercial@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'comercial@'+VpaDominio+';';
  end;
  if not ExisteEmail('compras@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'compras@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'compras@'+VpaDominio+';';
  end;
  if not ExisteEmail('rh@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'rh@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'rh@'+VpaDominio+';';
  end;
  if not ExisteEmail('faturamento@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'faturamento@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'faturamento@'+VpaDominio+';';
  end;
  if not ExisteEmail('estoque@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'estoque@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'estoque@'+VpaDominio+';';
  end;
  if not ExisteEmail('almoxarifado@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'almoxarifado@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'almoxarifado@'+VpaDominio+';';
  end;
  if not ExisteEmail('ti@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'ti@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'ti@'+VpaDominio+';';
  end;
  if not ExisteEmail('informatica@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'informatica@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'informatica@'+VpaDominio+';';
  end;
  if not ExisteEmail('supervisao@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'supervisao@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'supervisao@'+VpaDominio+';';
  end;
  if not ExisteEmail('gerencia@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'gerencia@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'gerencia@'+VpaDominio+';';
  end;
  if not ExisteEmail('cobranca@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'cobranca@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'cobranca@'+VpaDominio+';';
  end;
  if not ExisteEmail('recrutamento@'+VpaDominio) then
  begin
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'recrutamento@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
    result := result + 'recrutamento@'+VpaDominio+';';
  end;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.DesativaEmail(VpaMensagem : TIdMessage) : Boolean;
var
  VpfEmail : String;
  VpfCodCliente, VpfCodProspect : Integer;
  VpfTempoEmailExcedito : Boolean;
begin
  VpfCodProspect := 0;
  VpfEmail := REmailMensagemInvalida(VpaMensagem,VpfTempoEmailExcedito);
  if VpfTempoEmailExcedito  then
    exit(false);
  VpfCodCliente := DesativaEmailCliente(VpfEmail);
  if VpfCodCliente = 0 then
    VpfCodProspect := DesativaEmailProspect(VpfEmail);
  if not EmailDominioProvedores(VpfEmail) then
  begin
    if not ExisteEmail('diretoria@'+DeleteAteChar(VpfEmail,'@')) then
    begin
      if VpfCodCliente <> 0 then
        CadastraEmailsAdicionaisCliente(VpfCodCliente,DeleteAteChar(VpfEmail,'@'))
      else
        if VpfCodProspect <> 0 then
          CadastraEmailsAdicionaisProspect(VpfCodProspect,DeleteAteChar(VpfEmail,'@'),'Cadastrado atraves de um e-mail invalido desse dominio');
    end;
  end;
  result := (VpfCodCliente <> 0) or (VpfCodProspect <> 0);
end;

{******************************************************************************}
function TRBFuncoesEMarketing.DesativaEmailCliente(VpaDesEmail : String) : Integer;
begin
  result := 0;
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCLIENTES ' +
                                 ' Where UPPER(C_END_ELE) = '''+UpperCase(VpaDesEmail)+''''+
                                 ' AND C_ACE_SPA = ''S''');
  if not Cadastro.eof then
  begin
    result := Cadastro.FieldByname('I_COD_CLI').AsInteger;
    Cadastro.Edit;
    Cadastro.FieldByname('I_QTD_EMI').AsInteger := Cadastro.FieldByname('I_QTD_EMI').AsInteger + 1;
    Cadastro.FieldByname('C_EMA_INV').AsString := 'S';
    Cadastro.Post;
  end;
  Cadastro.close;

  if result = 0 then
    result := DesativaEmailContatoCliente(VpaDesEmail);
end;

{******************************************************************************}
function TRBFuncoesEMarketing.DesativaEmailContatoCliente(VpaDesEmail : String) : Integer;
begin
  result := 0;
  AdicionaSQLAbreTabela(Cadastro,'Select *  '+
                                 ' from CONTATOCLIENTE ' +
                                 ' Where UPPER(DESEMAIL) = '''+UpperCase(VpaDesEmail)+''''+
                                 ' AND INDACEITAEMARKETING = ''S''');
  if not Cadastro.eof then
  begin
    result := Cadastro.FieldByname('CODCLIENTE').AsInteger;
    Cadastro.Edit;
    Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger := Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger + 1;
    Cadastro.FieldByname('INDEMAILINVALIDO').AsString := 'S';
    Cadastro.Post;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.DesativaEmailProspect(VpaDesEmail : String) : Integer;
begin
  result := 0;
  AdicionaSQLAbreTabela(Cadastro,'Select * '+
                                 ' from PROSPECT ' +
                                 ' Where UPPER(DESEMAILCONTATO) = '''+UpperCase(VpaDesEmail)+''''+
                                 ' AND INDACEITASPAM = ''S''');
  if not Cadastro.eof then
  begin
    result := Cadastro.FieldByname('CODPROSPECT').AsInteger;
    Cadastro.Edit;
    Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger := Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger + 1;
    Cadastro.FieldByname('INDEMAILINVALIDO').AsString := 'S';
    Cadastro.Post;
  end;
  Cadastro.close;
  if result = 0 then
    result := DesativaEmailContatoProspect(VpaDesEmail);
end;

{******************************************************************************}
function TRBFuncoesEMarketing.DesativaEmailContatoProspect(VpaDesEmail : String) : Integer;
begin
  result := 0;
  AdicionaSQLAbreTabela(Cadastro,'Select * '+
                                 ' from CONTATOPROSPECT ' +
                                 ' Where UPPER(DESEMAIL) = '''+UpperCase(VpaDesEmail)+''''+
                                 ' AND INDACEITAEMARKETING = ''S''');
  if not Cadastro.eof then
  begin
    result := Cadastro.FieldByname('CODPROSPECT').AsInteger;
    Cadastro.Edit;
    Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger := Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger +1;
    Cadastro.FieldByname('INDEMAILINVALIDO').AsString := 'S';
    Cadastro.Post;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.RQtdEMail(VpaSeqTarefa : Integer) : Integer;
begin
  Aux.Close;
  Aux.SQL.Clear;
  Aux.SQL.Add('SELECT COUNT(SEQTAREFA) QTD '+
              ' FROM TAREFAEMARKETINGITEM  ' +
              ' WHERE SEQTAREFA = '+IntTosTr(VpaSeqTarefa));
  Aux.Open;
  result := Aux.FieldByname('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.RQtdEmailsNaoEnviados(VpaSeqTarefa : Integer) : Integer;
begin
  AdicionaSqlabreTabela(Aux,'Select COUNT(SEQTAREFA) QTD  FROM TAREFAEMARKETINGITEM '+
                            ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                            ' and INDENVIADO = ''N''');
  Result := Aux.FieldByname('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.RQtdEmailEnviado(VpaSeqTarefa : Integer) : Integer;
begin
  AdicionaSqlabreTabela(Aux,'Select COUNT(SEQTAREFA) QTD  FROM TAREFAEMARKETINGITEM '+
                            ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                            ' and INDENVIADO = ''S''');
  Result := Aux.FieldByname('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.AtualizaQtdEmail(VpaSeqTarefa : Integer);
begin
  ExecutaComandoSql(Tabela,'Update TAREFAEMARKETING SET QTDEMAIL = '+IntToStr(RQtdEMail(VpaSeqTarefa))+
                           ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa));
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.CarDTarefaEMarkegting(VpaDTarefa : TRBDTarefaEMarketing;VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from TAREFAEMARKETING '+
                               ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa));
  VpaDTarefa.SeqTarefa := VpaSeqTarefa;
  VpaDTarefa.QtdEmail := Tabela.FieldByname('QTDEMAIL').AsInteger;
  VpaDTarefa.DesAssuntoEmail := Tabela.FieldByname('DESASSUNTOEMAIL').AsString;
  VpaDTarefa.DesLinkInternet :=Tabela.FieldByname('DESLINKINTERNET').AsString;
  VpaDTarefa.NomArquivoAnexo :=Tabela.FieldByname('NOMARQUIVO').AsString;
  VpaDTarefa.DesTextoEmail := Tabela.FieldByName('DESTEXTO').AsString;
  case Tabela.FieldByName('NUMFORMATOEMAIL').AsInteger of
    0 : VpaDTarefa.FormatoEmail := feHTML;
    1 : VpaDTarefa.FormatoEmail := feTexto;
  end;

  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.GeraTarefaTeleMarketing(VpaSeqTarefa, VpaCodUsuario: Integer): string;
var
  VpfQtdEmailNaoEnviados, VpfSeqTarefaTele : Integer;
begin
  VpfQtdEmailNaoEnviados := RQTDEmailsNaoEnviados(VpaSeqTarefa);
  if  VpfQtdEmailNaoEnviados > 0  then
  begin
    VpfSeqTarefaTele := GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpfQtdEmailNaoEnviados);
    AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFATELEMARKETINGITEM');
    PosClientesparaTeleMarketing(Clientes,VpaSeqTarefa);
    While not Clientes.Eof do
    begin
      Cadastro.insert;
      Cadastro.FieldByname('SEQTAREFA').AsInteger := VpfSeqTarefaTele;
      Cadastro.FieldByname('CODUSUARIO').AsInteger := VpaCodUsuario;
      Cadastro.FieldByname('CODCLIENTE').AsInteger := Clientes.FieldByname('I_COD_CLI').AsInteger;
      Cadastro.FieldByname('DATLIGACAO').AsDateTime := Date;
      Cadastro.FieldByname('SEQCAMPANHA').AsInteger := Varia.SeqCampanhaCadastrarEmail;
      Cadastro.FieldByname('INDREAGENDADO').AsString := 'N';
      Cadastro.post;

      FunClientes.AlterarObsLigacao(Clientes.FieldByname('I_COD_CLI').AsInteger,Clientes.FieldByname('DESERRO').AsString);
      Clientes.Next;
    end;
    Clientes.close;
  end;
  Clientes.Close;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.VerificaEmailInvalido(VpaProgresso : TProgressBar;VpaStatus,VpaContaEmail : TLabel) : string;
var
  VpfLacoMensagem, VpfLacoContaEmail,  VpfQtdMensagens, VpfQtdExcluido : Integer;
  VpfEmailsMarketing : TList;
  VpfDEmailMarketing : TRBDEmailMarketing;
  VpfTitulosNaoTratados : TStringList;
begin
  VpfEmailsMarketing := TList.Create;
  VpfTitulosNaotratados := TStringList.create;
  result := Sistema.CarEmailMarketing(VpfEmailsMarketing);
  if result = '' then
  begin
    for VpfLacoContaEmail := 0 to VpfEmailsMarketing.Count - 1 do
    begin
      VpfDEmailMarketing := TRBDEmailMarketing(VpfEmailsMarketing.Items[VpfLacoContaEmail]);
      VpaContaEmail.Caption := VpfDEmailMarketing.DesEmail;
      VpaContaEmail.Refresh;

      VprLabelStatus := VpaStatus;
      VpfQtdExcluido := 0;
      result := ConectaPop(VprPop,VpfDEmailMarketing);
      if result = '' then
      begin
        AtualizaStatusLeituraEmail('Verificando a quantidade de e-mail''s');
        VpfQtdMensagens := VprPop.CheckMessages;
        VpaProgresso.Max := VpfQtdMensagens;
        VpaProgresso.Position := 0;
        for VpfLacoMensagem := VpfQtdMensagens downto 1 do
        begin
          inc(VpfQtdExcluido);
          if VpfQtdExcluido > 40 then
          begin
            ConectaPop(VprPop,VpfDEmailMarketing);
            VpfQtdExcluido := 0;
          end;
          VpaProgresso.Position := VpaProgresso.Position + 1;
          VprPop.Retrieve(VpfLacoMensagem,VprMensagem);
          AtualizaStatusLeituraEmail('Verificando se a mensagem '+IntToStr(VpaProgresso.Position) +' de '+IntToStr(VpfQtdMensagens)+' é válida "'+VprMensagem.Subject);
          if MensagemEmailInvalido(VprMensagem) then
          begin
            DesativaEmail(VprMensagem);
            VprPop.Delete(VpfLacoMensagem);
          end
          else
            if MensagemRespostaAutomatica(VprMensagem)then
              VprPop.Delete(VpfLacoMensagem)
            else
              if VpfTitulosNaoTratados.IndexOf(VprMensagem.Subject) = -1 then
                VpfTitulosNaoTratados.add(VprMensagem.Subject);
          Application.ProcessMessages;
        end;
        VprMensagem.Clear;
      end;
      VprPop.Disconnect;
    end;
  end;
  FreeTObjectsList(VpfEmailsMarketing);
  VpfEmailsMarketing.free;
  VpfTitulosNaoTratados.SaveToFile('TitulosNaoTratados.txt');
  VpfTitulosNaoTratados.free;
end;

end.
