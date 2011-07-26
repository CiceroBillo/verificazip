Unit unEMarketingProspect;

Interface

Uses Classes, DB, SysUtils, UnDados,IdMessage, IdSMTP, UnSistema, stdctrls, comctrls,
  forms, unProspect, idtext,IdAttachmentfile,SQLexpr, Tabela;

//classe localiza
Type TRBLocalizaEMarketingProspect = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesEMarketingProspect = class(TRBLocalizaEMarketingProspect)
  private
    Aux,
    Tabela  : TSQLQuery;
    Prospects,
    Cadastro : TSQL;
    VprMensagem : TidMessage;
    VprSMTP : TIdSMTP;
    function GravaEnvioTarefaProspect(VpaDTarefa : TRBDTarefaEMarketingProspect;VpaErro : String):string;
    function GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpaQtdLigacoes : Integer) : Integer;
    procedure AdicionaTarefaItem(VpaSeqTarefa,VpaCODPROSPECT : Integer;VpaErro : String);
    procedure AtualizaQtdEmailEnviados(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT);
    procedure PosProspectsEMarketing(VpaTabela : TDataSet;VpaSeqTarefa : Integer);
    procedure PosProspectsparaTeleMarketing(VpaTabela : TDataSet; VpaSeqTarefa : Integer);
    function RAssuntoEmail(VpaAssunto,VpaNomCliente : String) : String;
    procedure PreparaEmailProspect(VpaDTarefa: TRBDTAREFAEMARKETINGPROSPECT;VpaEmailRemente : string);
    function AdicionaEmailProspect(VpaCodProspect: Integer; VpaNomContato, VpaDesEmail,VpaContatoPrincipal : String):string;
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial;VpaDEmailMarketing : TRBDEmailMarketing) : string;
    procedure MontaEmailHTML(VpaTexto : TStrings; VpaDTarefa: TRBDTAREFAEMARKETINGPROSPECT);
    procedure MontaEmailTexto(VpaTexto : TStrings; VpaDTarefa: TRBDTAREFAEMARKETINGPROSPECT);
    function ConectaEmail(VpaSMTP : TIdSMTP;VpaDEmailMarketing : TRBDEmailMarketing;VpaLabel : TLabel) : string;
    function RQtdEMail(VpaSeqTarefa : Integer) : Integer;
    function RQTDEmailsNaoEnviados(VpaSeqTarefa : Integer) : Integer;
    function RQtdEmailEnviado(VpaSeqTarefa : Integer) : Integer;
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    procedure AtualizaQtdEmail(VpaSeqTarefa : Integer);
    procedure CarDTarefaEMarkegting(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT;VpaSeqTarefa : Integer);
    function EnviaEMarketingProspect(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT;VpaLabel,VpaNomContaEmail,VpaEmailDestino,VpaQtdEmail : TLabel;VpaProgresso : TProgressBar;VpaListaEmail : TListBox):String;
    function GeraTarefaTeleMarketing(VpaSeqTarefa, VpaCodUsuario : Integer):string;
    procedure ExcluiTarefaEmarketing(VpaSeqTarefa : Integer);
    procedure ExcluiemailclientesEficacia(VpaSeqTarefa : Integer);
end;



implementation

Uses FunSql, Constantes, FunArquivos, FunString, ConstMsg, FunObjeto, FunData;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaEMarketing
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaEMarketingProspect.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesEMarketingProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesEMarketingProspect.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  Prospects := TSQL.Create(nil);
  Prospects.ASQLConnection := VpaBaseDados;
  Prospects.PacketRecords := -1;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  //componentes indy
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);
end;

{******************************************************************************}
destructor TRBFuncoesEMarketingProspect.destroy;
begin
  Aux.Free;
  Prospects.free;
  Cadastro.free;
  VprMensagem.free;
  VprSMTP.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.GravaEnvioTarefaProspect(VpaDTarefa : TRBDTarefaEMarketingProspect;VpaErro : String):string;
var
  VpfDTarefaItem : TRBDTarefaEMarketingProspectItem;
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDTarefa.Itens.Count - 1 do
  begin
    VpfDTarefaItem := TRBDTarefaEMarketingProspectItem(VpaDTarefa.Itens.Items[VpfLaco]);
    AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETINGPROSPECTITEM '+
                                 ' Where SEQTAREFA = '+IntToStr(VpaDTarefa.SeqTarefa)+
                                 ' and CODPROSPECT = '+IntToStr(VpfDTarefaItem.CodProspect)+
                                 ' and SEQCONTATO = '+IntToStr(VpfDTarefaItem.SeqContato));
    Cadastro.Edit;
    if VpaErro = '' then
    begin
      Cadastro.FieldByname('INDENVIADO').AsString := 'S';
      Cadastro.FieldByname('DATENVIO').AsDateTime := now;
      Cadastro.FieldByname('DESERRO').Clear;
    end
    else
    begin
      Cadastro.FieldByname('INDENVIADO').AsString := 'S';
      Cadastro.FieldByname('DESERRO').AsString := VpaErro;
    end;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
    if VpaErro = '' then
    begin
      if VpfDTarefaItem.SeqContato = 0 then
        FunProspect.AlteraDatUltimoEmail(VpfDTarefaItem.CodProspect,now)
      else
        FunProspect.AlteraDatUltimoEmailContato(VpfDTarefaItem.CodProspect,VpfDTarefaItem.SeqContato,now);
    end;
  end;
  Cadastro.close;
  FreeTObjectsList(VpaDTarefa.Itens);
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpaQtdLigacoes : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFATELEMARKETINGPROSPECT');
  Cadastro.insert;
  Cadastro.FieldByname('DATTAREFA').AsDateTime := now;
  Cadastro.FieldByname('QTDLIGACOES').AsInteger := VpaQtdLigacoes;
  Cadastro.FieldByname('DATAGENDAMENTO').AsDateTime := Date;
  Cadastro.FieldByname('SEQCAMPANHA').AsInteger := Varia.SeqCampanhaCadastrarEmail;
  Cadastro.FieldByname('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByname('CODUSUARIOTELE').AsInteger := VpaCodUsuario;
  result := FunProspect.RSeqTarefaDisponivel;
  Cadastro.FieldByname('SEQTAREFA').AsInteger := result;
  Cadastro.post;
  Cadastro.close;
end;


{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.AdicionaTarefaItem(VpaSeqTarefa,VpaCODPROSPECT : Integer;VpaErro : String);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETINGPROSPECTITEM ');
  Cadastro.insert;
  CadaStro.FieldByname('SEQTAREFA').AsInteger :=  VpaSeqTarefa;
  Cadastro.FieldByname('CODPROSPECT').AsInteger :=  VpaCODPROSPECT;
  Cadastro.FieldByname('DESERRO').AsString :=  VpaErro;
  CadaStro.FieldByname('INDENVIADO').AsString := 'N';
  try
    Cadastro.post;
  except
    on e : Exception do aviso('ERRO NA GRAVAÇÃO DA TAREFAEMARKETINGPROSPECTITEM!!!!'#13+e.message);
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.AtualizaQtdEmailEnviados(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETINGPROSPECT '+
                                 ' Where SEQTAREFA = ' +IntToStr(VpaDTarefa.SeqTarefa));
  Cadastro.edit;
  Cadastro.FieldByname('QTDEMAILENVIADO').AsInteger :=RQtdEmailEnviado(VpaDTarefa.SeqTarefa) ;
  Cadastro.FieldByname('QTDNAOENVIADO').AsInteger :=RQTDEmailsNaoEnviados(VpaDTarefa.SeqTarefa);
  Cadastro.post;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.PosProspectsEMarketing(VpaTabela : TDataSet;VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select TIM.CODPROSPECT, TIM.SEQCONTATO, TIM.NOMCONTATO, TIM.DESEMAIL, '+
                                  ' TIM.INDCONTATOPRINCIPAL ' +
                                  ' from TAREFAEMARKETINGPROSPECTITEM TIM '+
                                  ' WHERE TIM.SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                                  ' AND TIM.INDENVIADO = ''N'''+
                                  ' order by TIM.DESEMAIL');
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.PosProspectsparaTeleMarketing(VpaTabela : TDataSet; VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select CODPROSPECT, NOMPROSPECT,TIM.DESERRO  '+
                                  ' from PROSPECT PRO, TAREFAEMARKETINGPROSPECTITEM TIM '+
                                  ' WHERE PRO.CODPROSPECT = TIM.CODPROSPECT '+
                                  ' AND TIM.SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                                  ' AND TIM.INDENVIADO = ''N''');
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.PreparaEmailProspect(VpaDTarefa: TRBDTAREFAEMARKETINGPROSPECT;VpaEmailRemente : string);
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
function TRBFuncoesEMarketingProspect.RAssuntoEmail(VpaAssunto,VpaNomCliente : String) : String;
begin
  if ExisteLetraString('@',VpaAssunto) then
    result := SubstituiStr(VpaAssunto,'@',VpaNomCliente)
  else
    result := VpaAssunto;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.AdicionaEmailProspect(VpaCodProspect: Integer; VpaNomContato, VpaDesEmail,VpaContatoPrincipal : String):string;
begin
  result := '';
  VpaDesEmail := RetiraAcentuacao(VpaDesEmail);
  VpaDesEmail := SubstituiStr(VpaDesEmail,',','.');
  if (VpaDesEmail = '') then
  begin
    if VpaContatoPrincipal = 'S' then
      result := 'Falta o email principal do prospect '+IntToStr(VpaCodProspect)
    else
      result := 'Falta e-mail do contato "'+VpaNomContato+'" do prospect '+IntToStr(VpaCodProspect);
  end;
  if result = '' then
  begin
    VprMensagem.Recipients.EMailAddresses := LowerCase(VpaDesEmail);
//    VprMensagem.BccList.Add.Address := 'rafael@eficaciaconsultoria.com.br';
  end;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial;VpaDEmailMarketing : TRBDEmailMarketing) : string;
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
procedure TRBFuncoesEMarketingProspect.MontaEmailHTML(VpaTexto : TStrings; VpaDTarefa: TRBDTAREFAEMARKETINGPROSPECT);
begin
  VpaTexto.add('<html>');
  VpaTexto.add('<title> Eficácia Sistemas e Consultoria');
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('  <center>');
  if copy(LowerCase(VpaDTarefa.NomArquivoAnexo),1,7) = 'http://' then
    VpaTexto.add('    <a " href="'+VpaDTarefa.DesLinkInternet + '">')
  else
    VpaTexto.add('    <a  href="'+VpaDTarefa.DesLinkInternet + '">');
  if copy(LowerCase(VpaDTarefa.NomArquivoAnexo),1,7) <> 'http://' then
    VpaTexto.add('      <IMG src="cid:'+RetornaNomArquivoSemDiretorio(VpaDTarefa.NomArquivoAnexo) +' " border="0" >')
  else
    VpaTexto.add('      <IMG src="'+VpaDTarefa.NomArquivoAnexo +' " border="0" >');
  VpaTexto.add('    </a>');
  VpaTexto.add('  </center>');
  VpaTexto.add('  <br>');
  VpaTexto.add('  <center>');
  VpaTexto.add('  <font face="Verdana" size =-3>');
  VpaTexto.add('Esta mensagem nao pode ser considerada S - P - A - M por possuir as seguintes caracteristicas:<br>');
  VpaTexto.add('identificacao do remetente, descricao clara do conteudo e opcao para remocao');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>Para excluir seu cadastro responda e-mail com o assunto REMOVER');
  VpaTexto.add('  </font>');
  VpaTexto.add('  </center>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  VpaTexto.add('<address>Sistema de gestao desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficacia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('<br><font face="Verdana" size =-5 color="white"> '+
               ' Com matriz situada em Blumenau/SC nossa empresa nasceu após um grande projeto de automação de força de vendas. '+
               ' Atuamos em Curitiba, São Paulo, Blumenau e região. Possuímos experiências de diversos segmentos e localidades. '+
               ' Desde o ano 1999, crescemos e desenvolvemos diversas soluções focadas nas empresas de médio e grande porte. '+
               ' A Eficácia Consultoria tem como política manter um relacionamento transparente e de respeito com os clientes,'+
               'colaboradores e o público em geral, procurando sempre atingir a excelência através de novas idéias e tecnologias, com foco na qualidade dos serviços e produtos oferecidos. '+
               ' Hoje, nossa carteira de clientes, confirma que nosso produto e comprometimento são nossos alicerces para crescermos cada vez mais. '+
               ' <br> '+
               ' <br> '+
               ' Missão '+
               ' <br> '+
               ' Tornar nossos clientes administradores e fornecer-lhes ferramentas, treinamento e metodologia para que possuam controle total de suas organizações. Eliminando os erros e'+
               ' multiplicando os acertos, conseguindo com isso um crescimento e um lucro acima do mercado. '+
               ' <br> '+
               ' <br> '+
               ' Valores '+
               ' <br> '+
               ' Ser um agente de mudança. '+
               ' Ter clareza em nossas ferramentas e linguagens. '+
               ' Permitir somente a comunicação aberta. '+
               ' Ser intolerante com a falta de franqueza. '+
               '   </font> ');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.MontaEmailTexto(VpaTexto: TStrings; VpaDTarefa: TRBDTAREFAEMARKETINGPROSPECT);
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
function TRBFuncoesEMarketingProspect.ConectaEmail(VpaSMTP : TIdSMTP;VpaDEmailMarketing : TRBDEmailMarketing;VpaLabel : TLabel) : string;
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
//    VpaSMTP.UserName := 'rafael';
//    VpaSMTP.Password := 'rf1020';
    VpaSMTP.Connect;
  except
    on e : exception do result := 'ERRO AO CONECTAR O SERVIDOR'+e.Message;
  end;
  Application.ProcessMessages;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.RQtdEMail(VpaSeqTarefa : Integer) : Integer;
begin
  Aux.Close;
  Aux.SQL.Clear;
  Aux.SQL.Add('SELECT COUNT(SEQTAREFA) QTD '+
              ' FROM TAREFAEMARKETINGPROSPECTITEM  ' +
              ' WHERE SEQTAREFA = '+IntTosTr(VpaSeqTarefa));
  Aux.Open;
  result := Aux.FieldByname('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.RQtdEmailsNaoEnviados(VpaSeqTarefa : Integer) : Integer;
begin
  AdicionaSqlabreTabela(Aux,'Select COUNT(SEQTAREFA) QTD  FROM TAREFAEMARKETINGPROSPECTITEM '+
                            ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                            ' and INDENVIADO = ''N''');
  Result := Aux.FieldByname('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.RQtdEmailEnviado(VpaSeqTarefa : Integer) : Integer;
begin
  AdicionaSqlabreTabela(Aux,'Select COUNT(SEQTAREFA) QTD  FROM TAREFAEMARKETINGPROSPECTITEM '+
                            ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                            ' and INDENVIADO = ''S''');
  Result := Aux.FieldByname('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.AtualizaQtdEmail(VpaSeqTarefa : Integer);
begin
  ExecutaComandoSql(Tabela,'Update TAREFAEMARKETINGPROSPECT SET QTDEMAIL = '+IntToStr(RQtdEMail(VpaSeqTarefa))+
                           ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa));
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.CarDTarefaEMarkegting(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT;VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from TAREFAEMARKETINGPROSPECT '+
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
function TRBFuncoesEMarketingProspect.EnviaEMarketingProspect(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT;VpaLabel,VpaNomContaEmail,VpaEmailDestino, VpaQtdEmail : TLabel;VpaProgresso : TProgressBar;VpaListaEmail : TListBox):String;
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
    PreparaEmailProspect(VpaDTarefa,VpfDEmailMarketing.DesEmail);
    VpfQtdEmail := 999999;
    VpfQtdEnvioRemetente := 0;

    VpfDFilial := TRBDFilial.cria;
    Sistema.CarDFilial(VpfDFilial,Varia.CodigoEmpFil);

    PosProspectsEMarketing(Prospects,VpaDTarefa.SeqTarefa);
    While not Prospects.eof do
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
      result := EmailValido(Prospects.FieldByname('DESEMAIL').AsString);
      if result = '' then
      begin
        VpaEmailDestino.Caption :=Prospects.FieldByname('DESEMAIL').AsString;
        VpaEmailDestino.Refresh;
        result := AdicionaEmailProspect(Prospects.FieldByname('CODPROSPECT').AsInteger,Prospects.FieldByname('NOMCONTATO').AsString,
                          Prospects.FieldByname('DESEMAIL').AsString,Prospects.FieldByname('INDCONTATOPRINCIPAL').AsString);
        if result = '' then
        begin
          VpaLabel.Caption := 'Aguardando tempo para enviar e-mail';
          VpaLabel.Refresh;
          while IncSegundo(VpfUltimoEnvio,1) > now do //espera 1 segundos para mandar cada e-mail;
            sleep(1000);
          VpaLabel.Caption := 'Enviando e-mail';
          VpaLabel.Refresh;

          result := EnviaEmail(VprMensagem,VprSMTP,VpfDFilial,VpfDEmailMarketing);
          VpaListaEmail.Items.Insert(0,Prospects.FieldByname('DESEMAIL').AsString+'('+result+')');
          VpaLabel.Caption := 'Gravando status envio';
          GravaEnvioTarefaProspect(VpaDTarefa,result);
          VpfUltimoEnvio := now;

          VprMensagem.BccList.Clear;
          VprMensagem.CCList.Clear;
          VprMensagem.Recipients.Clear;
          inc(VpfQtdEmail);
          inc(VpfQtdEnvioRemetente);
        end;
      end
      else
        VpaListaEmail.Items.Insert(0,Prospects.FieldByname('DESEMAIL').AsString+'(e-mail inválido,nao enviado)');

      VpfdTarefaItem := VpaDTarefa.addItem;
      VpfdTarefaItem.CodProspect := Prospects.FieldByname('CODPROSPECT').AsInteger;
      VpfdTarefaItem.SeqContato := Prospects.FieldByname('SEQCONTATO').AsInteger;

      VpaProgresso.Position := VpaProgresso.Position + 1;

      VpaQtdEmail.Caption := IntToStr(VpaProgresso.Position);
      VpaQtdEmail.refresh;
      Application.ProcessMessages;

      Prospects.Next;
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
procedure TRBFuncoesEMarketingProspect.ExcluiemailclientesEficacia(VpaSeqTarefa: Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM TAREFAEMARKETINGPROSPECTITEM '+
                       ' where seqtarefa = ' +IntToStr(VpaSeqTarefa)+
                       ' and( desemail like ''%RELOPONTO%'''+
                       ' or desemail like ''%KAIROS%'''+
                       ' or desemail like ''%LATICINIOSPOMERODE%'''+
                       ' or desemail like ''%PROAROMA%'''+
                       ' or desemail like ''%EMBUTIDOSOLHO%'''+
                       ' or desemail like ''%ZUMM%'''+
                       ' or desemail like ''%TELASSCHNEIDER%'''+
                       ' or desemail like ''%ETIKART%'''+
                       ' or desemail like ''%MTR.COM%'''+
                       ' or desemail like ''%CORBELLA%'''+
                       ' or desemail like ''%METALVIDROS%'''+
                       ' or desemail like ''%WORKRECICLOS%'''+
                       ' or desemail like ''%RAFTHEL%'''+
                       ' or desemail like ''%KABRAN%'''+
                       ' or desemail like ''%ISOAUDIOVISUAIS%'''+
                       ' or desemail like ''%MAQMUNDI%'''+
                       ' or desemail like ''%PREMER%'''+
                       ' or desemail like ''%MARCIALINGERIE%'''+
                       ' or desemail like ''%PAROS%'''+
                       ' or desemail like ''%AGZIMP%'''+
                       ' or desemail like ''%REELTEX%'''+
                       ' or desemail like ''%TECNOMAQUINAS%'''+
                       ' or desemail like ''%BLOCONORTE%'''+
                       ' or desemail like ''%TECNOTAG%'''+
                       ' or desemail like ''%INFORTEL%'''+
                       ' or desemail like ''%PERFOR%'''+
                       ' or desemail like ''%VENETO%'''+
                       ' or desemail like ''%IDEALCARTUCHOS%'''+
                       ' or desemail like ''%CEBOBINAS%'''+
                       ' or desemail like ''%TELASFRANZ%'''+
                       ' or desemail like ''%CORENGE%'''+
                       ' or desemail like ''%RCTEXTIL%'''+
                       ' or desemail like ''%VIDROHOUSE%'''+
                       ' or desemail like ''%CADARTEX%'')');
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.ExcluiTarefaEmarketing(VpaSeqTarefa: Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM TAREFAEMARKETINGPROSPECTITEM '+
                        ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa));
  ExecutaComandoSql(Aux,'DELETE FROM TAREFAEMARKETINGPROSPECT '+
                        ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa));
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.GeraTarefaTeleMarketing(VpaSeqTarefa, VpaCodUsuario: Integer): string;
var
  VpfQtdEmailNaoEnviados, VpfSeqTarefaTele : Integer;
begin
  VpfQtdEmailNaoEnviados := RQTDEmailsNaoEnviados(VpaSeqTarefa);
  if  VpfQtdEmailNaoEnviados > 0  then
  begin
    VpfSeqTarefaTele := GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpfQtdEmailNaoEnviados);
    AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFATELEMARKETINGPROSPECTITEM');
    PosProspectsparaTeleMarketing(Prospects,VpaSeqTarefa);
    While not Prospects.Eof do
    begin
      Cadastro.insert;
      Cadastro.FieldByname('SEQTAREFA').AsInteger := VpfSeqTarefaTele;
      Cadastro.FieldByname('CODUSUARIO').AsInteger := VpaCodUsuario;
      Cadastro.FieldByname('CODPROSPECT').AsInteger := Prospects.FieldByname('CODPROSPECT').AsInteger;
      Cadastro.FieldByname('DATLIGACAO').AsDateTime := Date;
      Cadastro.FieldByname('SEQCAMPANHA').AsInteger := Varia.SeqCampanhaCadastrarEmail;
      Cadastro.FieldByname('INDREAGENDADO').AsString := 'N';
      Cadastro.post;

      FunProspect.AlterarObsLigacao(Prospects.FieldByname('CODPROSPECT').AsInteger,Prospects.FieldByname('DESERRO').AsString);
      Prospects.Next;
    end;
    Prospects.close;
  end;
  Prospects.Close;
  Cadastro.close;
end;

end.


