unit ANovoEmailContasAReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, ComCtrls, Componentes1, ExtCtrls, PainelGradiente, Db,
  DBTables, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP, IdMessage, UndadosCR, UnContasAReceber, UnDados, unSistema,
  IdExplicitTLSClientServerBase, IdSMTPBase, idtext,IdAttachmentfile, FMTBcd,
  SqlExpr, DBClient, Tabela;

type
  TFNovoEmailContasAReceber = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BarraStatus: TStatusBar;
    Progresso: TProgressBar;
    Animate1: TAnimate;
    BEnviar: TBitBtn;
    BFechar: TBitBtn;
    Titulos: TSQLQuery;
    SMTP: TIdSMTP;
    IdMessage: TIdMessage;
    ECobrancaCorpo: TSQL;
    ECobrancaCorpoSEQEMAIL: TFMTBCDField;
    ECobrancaCorpoDATENVIO: TSQLTimeStampField;
    ECobrancaCorpoQTDENVIADOS: TFMTBCDField;
    ECobrancaCorpoQTDERROS: TFMTBCDField;
    ECobrancaCorpoCODUSUARIO: TFMTBCDField;
    ECobrancaItem: TSQLQuery;
    ECobrancaItemSEQEMAIL: TFMTBCDField;
    ECobrancaItemSEQITEM: TFMTBCDField;
    ECobrancaItemCODFILIAL: TFMTBCDField;
    ECobrancaItemLANRECEBER: TFMTBCDField;
    ECobrancaItemNUMPARCELA: TFMTBCDField;
    ECobrancaItemNOMFINANCEIRO: TWideStringField;
    ECobrancaItemDESEMAIL: TWideStringField;
    ECobrancaItemDATENVIO: TSQLTimeStampField;
    ECobrancaItemDESSTATUS: TWideStringField;
    ECobrancaItemINDENVIADO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
  private
    { Private declarations }
    VprDECobranca : TRBDECobrancaCorpo;
    VprDItemECobranca : TRBDECobrancaItem;
    VprPosCobrancaItem : Integer;
    procedure GravaCobrancaCorpo;
    procedure InicializaDECobrancaItem;
    procedure MarcaStatusEmail(VpaEnviado : Boolean;VpaStatus : String);
    procedure ConectaEmail;
    procedure PosTitulosAVencer(VpaTabela :TSQLQUERY);
    procedure PosTitulosVencidos(VpaTabela :TSQLQuery;VpaCodCliente : Integer);
    procedure MontaCabecalhoFilial(VpaHTML : TStringList;VpaDFilial : TRBDFilial);
    procedure MontaTitulosCorrigidosEmail(VpaHTML : TStringList;VpaTabela : TSQLQuery);
    procedure MontaTitulosEmail(VpaHTML : TStringList;VpaTabela : TSQLQuery);
    function CarCabecalhoCliente(VpaHTML : TStringList;VpaDatVencimento:TDateTime;VpaDFilial : TRBDFilial):Boolean;
    procedure EnviaEmailCliente(VpaHTML : TStringList;VpaNomCliente, VpaDesEmail,VpaNomFilial : String;VpaAtrasadas : Boolean);
    procedure EnviaEmailTitulos;
    procedure EnviaEmail(VpaTabela : TSQLQuery);
    procedure AtualizaBarraStatus(VpaTexto : String);
  public
    { Public declarations }
    procedure EnviaHistoricoCobrancaCliente(VpaCodCliente : Integer);
  end;

var
  FNovoEmailContasAReceber: TFNovoEmailContasAReceber;

implementation

uses APrincipal, FunSql, FunData, FunString, Constantes, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoEmailContasAReceber.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ECobrancaCorpo.Open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoEmailContasAReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  ECobrancaCorpo.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoEmailContasAReceber.EnviaHistoricoCobrancaCliente(VpaCodCliente : Integer);
begin
  PanelColor2.Visible := false;
  Show;
  GravaCobrancaCorpo;
  PosTitulosVencidos(Titulos,VpaCodCliente);
  EnviaEmail(Titulos);
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.PosTitulosAVencer(VpaTabela :TSQLQuery);
begin
  AtualizaBarraStatus('Verificando a quantidade de titulos a enviar');
  VpaTabela.sql.clear;
  VpaTabela.sql.add('select count(MOV.I_NRO_PAR) QTD');
  VpaTabela.sql.add('from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADCLIENTES CLI, CADFILIAIS FIL '+
                    ' WHERE  CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ' +
                    ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                    ' AND CAD.I_EMP_FIL = FIL.I_EMP_FIL '+
                    ' AND MOV.D_DAT_PAG IS NULL '+
                    ' AND '+SQLTextoIsNull('MOV.C_BAI_CAR','''N''')+ '= ''N'''+
                    ' AND '+SQLTextoIsNull('MOV.D_ULT_EMA',SQLTextoDataAAAAMMMDD(DecDia(date,1)))+ '< '+SQLTextoDataAAAAMMMDD(date)+
                    ' AND MOV.C_FUN_PER = ''N''');
    VpaTabela.sql.add(SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_VEN',date,IncDia(date,2),true));
  if varia.CNPJFilial = CNPJ_MKJ then
    VpaTabela.sql.add('AND MOV.I_COD_FRM <> '+IntToStr(Varia.FormaPagamentoContrato));


  VpaTabela.open;
  Progresso.Max := VpaTabela.FieldByName('QTD').AsInteger;
  Progresso.Position := 0;
  AtualizaBarraStatus('Posicionando os titulos a serem enviados');
  VpaTabela.close;
  VpaTabela.sql.Strings[0] :='select MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_NRO_PAR, MOV. C_NRO_DUP, MOV.N_VLR_PAR,  MOV.D_DAT_VEN,'+
                    ' CAD.I_NRO_NOT, ' +
                    ' CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_EMA_FIN, CLI.C_CON_FIN, CLI.C_TIP_PES, CLI.C_END_ELE, '+
                    ' FIL.C_NOM_FAN ';
  VpaTabela.sql.ADD(' ORDER BY CAD.I_COD_CLI, CAD.I_EMP_FIL, MOV.D_DAT_VEN');
  VpaTabela.open;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.PosTitulosVencidos(VpaTabela :TSQLQuery;VpaCodCliente : Integer);
begin
  AtualizaBarraStatus('Verificando a quantidade de titulos a enviar');
  VpaTabela.sql.clear;
  VpaTabela.sql.add('select count(MOV.I_NRO_PAR) QTD');
  VpaTabela.sql.add('from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADCLIENTES CLI, CADFILIAIS FIL '+
                    ' WHERE  CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ' +
                    ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                    ' AND CAD.I_EMP_FIL = FIL.I_EMP_FIL '+
                    ' AND MOV.D_DAT_PAG IS NULL '+
                    ' AND '+SQLTextoIsNull('MOV.C_BAI_CAR','''N''')+ '= ''N'''+
                    ' AND '+SQLTextoIsNull('MOV.C_COB_EXT','''N''')+ '= ''N'''+
                    ' AND MOV.C_FUN_PER = ''N'''+
                    ' AND CAD.C_IND_DEV = ''N''');
  if VpaCodCliente <> 0 then
    VpaTabela.sql.add('and CAD.I_COD_CLI = '+IntToStr(VpaCodCliente))
  else
  begin
    if config.EmailCobrancaPelaDataCobranca then
      VpaTabela.sql.add('AND MOV.D_PRO_LIG <= '+SQLTextoDataAAAAMMMDD(date)+
                ' AND '+SQLTextoIsNull('MOV.D_ULT_EMA',SQLTextoDataAAAAMMMDD(DecDia(date,1)))+ '< '+SQLTextoDataAAAAMMMDD(date))
    else
      VpaTabela.sql.add('AND MOV.D_DAT_VEN <= '+SQLTextoDataAAAAMMMDD(date)+
                ' AND '+SQLTextoIsNull('MOV.D_ULT_EMA',SQLTextoDataAAAAMMMDD(DecDia(date,1)))+' < '+SQLTextoDataAAAAMMMDD(date));
  end;
  if varia.CNPJFilial = CNPJ_MKJ then
    VpaTabela.sql.add('AND MOV.I_COD_FRM <> '+IntToStr(Varia.FormaPagamentoContrato));

  VpaTabela.open;
  Progresso.Max := VpaTabela.FieldByName('QTD').AsInteger;
  Progresso.Position := 0;
  AtualizaBarraStatus('Posicionando os titulos a serem enviados');
  VpaTabela.close;
  VpaTabela.sql.Strings[0] :='select MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_NRO_PAR, MOV. C_NRO_DUP, MOV.N_VLR_PAR,  MOV.D_DAT_VEN,'+
                    ' CAD.I_NRO_NOT, ' +
                    ' CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_EMA_FIN, CLI.C_CON_FIN, CLI.C_TIP_PES, CLI.C_END_ELE, '+
                    ' FIL.C_NOM_FAN ';
  VpaTabela.sql.ADD(' ORDER BY CAD.I_COD_CLI, CAD.I_EMP_FIL, MOV.D_DAT_VEN');
  VpaTabela.open;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.GravaCobrancaCorpo;
begin
  ECobrancaCorpo.insert;
  ECobrancaCorpoDATENVIO.AsDateTime := now;
  ECobrancaCorpoQTDENVIADOS.AsInteger := 0;
  ECobrancaCorpoQTDERROS.AsInteger := 0;
  ECobrancaCorpoCODUSUARIO.AsInteger := varia.CodigoUsuario;
  ECobrancaCorpoSEQEMAIL.AsInteger := FunContasAReceber.RSeqEmailDisponivel;
  ECobrancaCorpo.Post;
  VprDECobranca := TRBDECobrancaCorpo.cria;
  VprDECobranca.SeqEmail := ECobrancaCorpoSEQEMAIL.AsInteger;
  VprDECobranca.DatEnvio := now;
  VprDECobranca.QtdEnvidados := 0;
  VprDECobranca.QtdNaoEnviados := 0;
  VprDECobranca.CodUsuario := varia.Codigousuario;
  VprDECobranca.SeqItemEmailDisponivel := 1;
  VprPosCobrancaItem := 0;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.InicializaDECobrancaItem;
begin
  VprDItemECobranca.CodFilial := Titulos.FieldByName('I_EMP_FIL').AsInteger;
  VprDItemECobranca.LanReceber := Titulos.FieldByName('I_LAN_REC').AsInteger;
  VprDItemECobranca.NumParcela := Titulos.FieldByName('I_NRO_PAR').AsInteger;
  if Titulos.FieldByname('C_TIP_PES').AsString = 'F' Then
    VprDItemECobranca.DesEmail := Titulos.FieldByName('C_END_ELE').AsString
  else
    VprDItemECobranca.DesEmail := Titulos.FieldByName('C_EMA_FIN').AsString;
  VprDItemECobranca.UsuarioEmail := Titulos.FieldByName('C_CON_FIN').AsString;
  VprDItemECobranca.NomCliente := Titulos.FieldByName('C_NOM_CLI').AsString;
  VprDItemECobranca.NomFantasiaFilial := Titulos.FieldByName('C_NOM_FAN').AsString;
  VprDItemECobranca.DatEnvio := now;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.MarcaStatusEmail(VpaEnviado : Boolean;VpaStatus : String);
Var
  VpfLaco : Integer;
  VpfDItemCobranca : TRBDECobrancaItem;
  VpfResultado : String;
begin
  for VpfLaco := VprPosCobrancaItem to VprDECobranca.Items.Count - 1 do
  begin
    VpfDItemCobranca := TRBDECobrancaItem(VprDECobranca.Items[VpfLaco]);
    VpfDItemCobranca.DesEstatus := VpaStatus;
    VpfDItemCobranca.IndEnviado := VpaEnviado;
    AtualizaBarraStatus('Gravando dados do item do e-cobrança');
    VpfResultado := FunContasAReceber.GravaDECobrancaItem(VprDECobranca,VpfDItemCobranca);
    if VpfResultado <> '' then
      aviso(VpfResultado);
  end;
  VprPosCobrancaItem := VprDECobranca.Items.Count;
  AdicionaSQLAbreTabela(ECobrancaCorpo,'Select * from ECOBRANCACORPO '+
                                       ' Where SEQEMAIL = ' +IntToStr(VprDECobranca.SeqEmail));
  ECobrancaCorpo.edit;
  ECobrancaCorpoQTDENVIADOS.AsInteger := VprDECobranca.QtdEnvidados;
  ECobrancaCorpoQTDERROS.AsInteger :=  VprDECobranca.QtdNaoEnviados;
  ECobrancaCorpo.post;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.ConectaEmail;
begin
  if SMTP.Connected then
    SMTP.Disconnect;
  if config.ServidorInternetRequerAutenticacao then
  begin
    SMTP.UserName := varia.UsuarioSMTP;
    SMTP.Password := varia.SenhaEmail;
    SMTP.Port := varia.PortaSMTP;
    SMTP.AuthType := satdefault;
  end
  else
    SMTP.AuthType := satDefault;
  SMTP.Host := varia.ServidorSMTP;
  AtualizaBarraStatus('Conectando com o Servidor SMTP');
  SMTP.Connect;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.EnviaEmailCliente(VpaHTML : TStringList;VpaNomCliente, VpaDesEmail,VpaNomFilial : String;VpaAtrasadas : Boolean);
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
  VpfLaco : Integer;
begin
  VpaHTML.Add('</table>');
  VpaHTML.Add('<br>');
  if VpaAtrasadas then
  begin
    VpaHTML.Add('<br>');
    VpaHTML.Add('Solicitamos que vossa empresa verifique e, se possível, nos envie o <br> '+
                 ' comprovante de pagamento do título mencionado.');
    VpaHTML.Add('<br>');
    if varia.QtdDiasProtesto <> 0 then
    begin
      VpaHTML.Add('<br>');
      VpaHTML.Add('Lembrando que no '+IntToStr(varia.QtdDiasProtesto)+'º dia útil o título é enviado a cartório automaticamente.');
      VpaHTML.Add('<br>');
    end;
    VpaHTML.Add('<br>');
    VpaHTML.Add('Estamos no aguardo para devidos esclarecimentos!');
  end
  else
  begin
    VpaHTML.Add('<br>');
    VpaHTML.Add('Caso não tenha recebido o referido título, favor entrar em contato.');
  end;
  VpaHTML.Add('<br>');
  VpaHTML.Add('<br>');

  VpaHTML.Add(varia.RodapeECobranca);
  VpaHTML.Add('<br>');
  VpaHTML.add('Mensagem gerada automaticamente pelo sistema de e-cobrança.');
  VpaHTML.add('<hr>');
  VpaHTML.add('<center>');
  if Sistema.PodeDivulgarEficacia then
    VpaHTML.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaHTML.add('</center>');
  VpaHTML.add('</body>');
  VpaHTML.add('</html>');

  with IdMessage do
  begin
  //28/10/2010 foi colocado em comentario porque na copyline esta indo tudo desconfigurado
  // exemplo = Informamos atrav&eacutes desta que dentro dos pr&oacuteximos 02 dias estar&atildeo vencendo os
//    VpaHTML.Text := RetiraAcentuacaoHTML(VpaHtml.Text);
    VpfEmailHtml := TIdText.Create(IdMessage.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    VpfEmailHTML.Body.Assign(VpaHTML);

//    Body.Clear;
//    Body.Assign(VpaHTML);
    From.Name := 'Financeiro - '+VpaNomFilial;
    From.Address := Varia.emailECobranca;
    ReceiptRecipient.Text := Varia.emailECobranca;
    Recipients.EMailAddresses := VpaDesEmail;
    if VpaAtrasadas then
      Subject := 'Pagamento - '+VpaNomFilial
    else
      Subject := 'Programação de pagamento - '+VpaNomFilial;
  end;
  AtualizaBarraStatus('Enviando e-mail para o cliente "'+VpaNomCliente+'"');
  try

    SMTP.Send(IdMessage);
    MarcaStatusEmail(true,'e-mail enviado com sucesso');
  except
    on e : exception do MarcaStatusEmail(false,e.message);
  end;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.EnviaEmailTitulos;
begin
  if config.ECobrancaEnviarAvisoProgramacaoPagamento then
  begin
    PosTitulosAVencer(Titulos);
    EnviaEmail(Titulos);
  end;
  if config.ECobrancaEnviarAvisoPagamentoAtrasado then
  begin
    PosTitulosVencidos(Titulos,0);
    EnviaEmail(Titulos);
  end;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.EnviaEmail(VpaTabela : TSQLQuery);
var
  VpfCliente,VpfQtdTitulos,VpfQtdEmailEnviado : Integer;
  VpfPossuiEmailCliente,VpfEnviandoVencidas : Boolean;
  VpfHTMLEmail : TStringList;
  VpfDFilial : TRBDFilial;
begin
  VpfHTMLEmail := TStringList.create;
  VpfDFilial := TRBDFilial.cria;
  VpfDFilial.CodFilial := -1;
  VpfCliente := -1;
  VpfQtdEmailEnviado := 999;
  Animate1.Active := true;
  While not VpaTabela.eof do
  begin
    if (VpfCliente <> VpaTabela.FieldByName('I_COD_CLI').AsInteger) or
       (VpfDFilial.CodFilial <>  VpaTabela.FieldByName('I_EMP_FIL').AsInteger) or
       (VpfEnviandoVencidas and (VpaTabela.FieldByName('D_DAT_VEN').AsDateTime >= date)) or
       (not VpfEnviandoVencidas and (VpaTabela.FieldByName('D_DAT_VEN').AsDateTime < date)) then
    begin
      if (VpfCliente <> -1) and VpfPossuiEmailCliente then
      begin
        if (VpfQtdTitulos > 0) then
        begin
          VprDECobranca.QtdEnvidados := VprDECobranca.QtdEnvidados + 1;
          inc(VpfQtdEmailEnviado);
          if VpfQtdEmailEnviado > 40 then
          begin
            ConectaEmail;
            VpfQtdEmailEnviado := 0;
          end;
          EnviaEmailCliente(VpfHTMLEmail, VprDItemECobranca.NomCliente,VprDItemECobranca.DesEmail,VprDItemECobranca.NomFantasiaFilial,VpfEnviandoVencidas);
        end
        else
          MarcaStatusEmail(false,'Vencimento final de semana');
      end
      else
        if (VpfCliente <> -1) then
        begin
          VprDECobranca.QtdNaoEnviados := VprDECobranca.QtdNaoEnviados +1;
          MarcaStatusEmail(false,'Falta o e-mail do contato financeiro');
        end;

      Sistema.CarDFilial(VpfDFilial,VpaTabela.FieldByName('I_EMP_FIL').AsInteger);
      VpfPossuiEmailCliente := CarCabecalhoCliente(VpfHTMLEmail ,VpaTabela.FieldByName('D_DAT_VEN').AsDateTime,VpfDFilial);
      VpfCliente := VpaTabela.FieldByName('I_COD_CLI').AsInteger;
      VpfEnviandoVencidas := VpaTabela.FieldByName('D_DAT_VEN').AsDateTime < Date;
      VpfQtdTitulos := 0;
    end;

    VprDItemECobranca := VprDECobranca.AddECobrancaItem;
    InicializaDECobrancaItem;
    if VpfPossuiEmailCliente then
    begin
      inc(VpfQtdTitulos);
      if VpfEnviandoVencidas then
      begin
        //se for segunda feira nao é para enviar os VpaTabela que venceram no domingo ou sabado anterior.
        if (DiaSemanaNumerico(date) = 2) and (DiasPorPeriodo(VpaTabela.FieldByName('D_DAT_VEN').AsDateTime,date) < 3)  then
          dec(VpfQtdTitulos)
        else
        begin
          if config.ECobrancaEnviarValoresCorrigidos then
            MontaTitulosCorrigidosEmail(VpfHTMLEmail, VpaTabela)
          else
            MontaTitulosEmail(VpfHTMLEmail, VpaTabela);
        end;
      end
      else
        MontaTitulosEmail(VpfHTMLEmail, VpaTabela);
    end;
    VpaTabela.next;
    Progresso.Position := Progresso.Position+1;
  end;

  if (VpfCliente <> -1) and VpfPossuiEmailCliente  then
  begin
    if (VpfQtdTitulos > 0) then
    begin
      VprDECobranca.QtdEnvidados := VprDECobranca.QtdEnvidados + 1;
      ConectaEmail;
      EnviaEmailCliente(VpfHTMLEmail, VprDItemECobranca.NomCliente,VprDItemECobranca.DesEmail,VprDItemECobranca.NomFantasiaFilial,VpfEnviandoVencidas);
    end
    else
      MarcaStatusEmail(false,'Vencimento final de semana');
  end
  else
    if (VpfCliente <> -1) then
    begin
      VprDECobranca.QtdNaoEnviados := VprDECobranca.QtdNaoEnviados +1;
      MarcaStatusEmail(false,'Falta o e-mail do contato financeiro');
    end;
  AtualizaBarraStatus('e-mail''s enviados com sucesso.');
  Animate1.Active := false;
  VpaTabela.close;
  VpfHTMLEmail.free;
  VpfDFilial.free;
  try
    SMTP.Disconnect;
  except
  end;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.MontaCabecalhoFilial(VpaHTML : TStringList;VpaDFilial : TRBDFilial);
var
  Vpfbmppart : TIdAttachmentfile;
  VpfLaco : Integer;
begin
  IdMessage.MessageParts.Clear;
  if (varia.CNPJFilial = CNPJ_Listeners) then
  begin
    Vpfbmppart := TIdAttachmentfile.Create(IdMessage.MessageParts,varia.PathVersoes+'\Logo.gif');
    Vpfbmppart.ExtraHeaders.Values['content-id'] := 'logo.gif';
    Vpfbmppart.DisplayName := 'logo.gif';
  end
  else
  begin
    Vpfbmppart := TIdAttachmentfile.Create(IdMessage.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDFilial.CodFilial)+'.jpg');
    Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDFilial.CodFilial)+'.jpg';
    Vpfbmppart.DisplayName := inttoStr(VpaDFilial.CodFilial)+'.jpg';
  end;
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';

  VpaHTML.clear;
  VpaHTML.add('<html>');
  VpaHTML.add('<title> '+VpaDFilial.NomFantasia);
  VpaHTML.add('</title>');
  VpaHTML.add('<body>');
  VpaHTML.add('<left>');
  VpaHTML.add('<table width=100%>');
  VpaHTML.add('  <tr>');
  VpaHTML.add('    <td width='+IntToStr(varia.CRMTamanhoLogo)+' >');
  VpaHTML.add('    <a >');
  if (varia.CNPJFilial = CNPJ_Listeners) then
    VpaHTML.add('      <IMG src="cid:logo.gif" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+'>')
  else
    VpaHTML.add('      <IMG src="cid:'+IntToStr(VpaDFilial.CodFilial) +'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+'>');
  VpaHTML.add('    </td> <td>');
  VpaHTML.add('    <b>'+VpaDFilial.NomFantasia+'</b>');
  VpaHTML.add('    <br>');
  VpaHTML.add('    '+VpaDFilial.DesEndereco);
  VpaHTML.add('    <br>');
  VpaHTML.add('    '+VpaDFilial.DesCidade +' / '+VpaDFilial.DesUF);
  VpaHTML.add('    <br>');
  VpaHTML.add('    Fone : '+VpaDFilial.DesFone);
  VpaHTML.add('    <br>');
  VpaHTML.add('    site : <a href="http://'+VpaDFilial.DesSite+'">'+VpaDFilial.DesSite);
  VpaHTML.add('    </td>');
  VpaHTML.add('  </tr>');
  VpaHTML.add('</table>');
  VpaHTML.add('<left>');
  VpaHTML.add(' '+varia.CidadeFilial+',' +IntToStr(dia(date))+' de '+TextoMes(date,false)+ ' de '+IntToStr(ano(Date)) );
  VpaHTML.add('</left>');
  VpaHTML.add('</left>');
  VpaHTML.add('<br>');
  VpaHTML.add('<br> ');
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.MontaTitulosCorrigidosEmail(VpaHTML : TStringList;VpaTabela : TSQLQuery);
var
  VpfQtdDias : Integer;
  VpfValMoraMes : double;
begin
  VpfQtdDias := DiasPorPeriodo(VpaTabela.FieldByName('D_DAT_VEN').AsDateTime,Date);
  VpfValMoraMes := (VpaTabela.FieldByName('N_VLR_PAR').AsFloat * Varia.Mora)/100;

  VpaHTML.add('<tr>');
  VpaHTML.add('  <td width="15%" align="right"><font face="Verdana" size="-1">'+VpaTabela.FieldByName('C_NRO_DUP').AsString+'</td>');
  VpaHTML.add('  <td width="15%" align="right"><font face="Verdana" size="-1">'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'</td>');
  VpaHTML.add('  <td width="25%" align="right"><font face="Verdana" size="-1">'+FormatFloat('R$ ###,###,###,##0.00',VpaTabela.FieldByName('N_VLR_PAR').AsFloat)+'</td>');
  VpaHTML.add('  <td width="25%" align="center"><font face="Verdana" size="-1">'+FormatDateTime('DD/MM/YYYY',VpaTabela.FieldByName('D_DAT_VEN').AsDateTime)+'</td>');
  VpaHTML.add('  <td width="20%" align="right"><font face="Verdana" size="-1">'+FormatFloat('R$ ###,###,###,##0.00',VpaTabela.FieldByName('N_VLR_PAR').AsFloat +((VpfValMoraMes * VpfQtdDias)/30))+'</td>');
  VpaHTML.add('</tr>');

end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.MontaTitulosEmail(VpaHTML : TStringList;VpaTabela : TSQLQuery);
begin
  VpaHTML.add('<tr>');
  VpaHTML.add('  <td width="20%" align="right"><font face="Verdana" size="-1">'+VpaTabela.FieldByName('C_NRO_DUP').AsString+'</td>');
  VpaHTML.add('  <td width="20%" align="right"><font face="Verdana" size="-1">'+VpaTabela.FieldByName('I_NRO_NOT').AsString+'</td>');
  VpaHTML.add('  <td width="30%" align="right"><font face="Verdana" size="-1">'+FormatFloat('R$ ###,###,###,##0.00',VpaTabela.FieldByName('N_VLR_PAR').AsFloat)+'</td>');
  VpaHTML.add('  <td width="30%" align="center"><font face="Verdana" size="-1">'+FormatDateTime('DD/MM/YYYY',VpaTabela.FieldByName('D_DAT_VEN').AsDateTime)+'</td>');
  VpaHTML.add('</tr>');

end;

{******************************************************************************}
function TFNovoEmailContasAReceber.CarCabecalhoCliente(VpaHTML : TStringList;VpaDatVencimento:TDateTime;VpaDFilial : TRBDFilial):Boolean;
begin
  result := false;
  MontaCabecalhoFilial(VpaHTML,VpaDFilial);
  if (Titulos.FieldByName('C_EMA_FIN').AsString <> '') or
     ((Titulos.FieldByName('C_TIP_PES').AsString = 'F') and (Titulos.FieldByName('C_END_ELE').AsString <> '')) Then
  begin
    result := true;
    if (Titulos.FieldByName('C_TIP_PES').AsString = 'F') then
    begin
      VpaHTML.add('Prezado(a) <b>'+Titulos.FieldByName('C_NOM_CLI').AsString+'</b>,');
    end
    else
    begin
      VpaHTML.add('Prezado(a) <b>'+Titulos.FieldByName('C_CON_FIN').AsString+'</b>,');
    end;

    VpaHTML.add('<br> ');
    VpaHTML.add('<br> ');
    if VpaDatVencimento < date then
    begin
      AtualizaBarraStatus('Carregando as duplicatas vencidas do cliente "'+Titulos.FieldByName('C_NOM_CLI').AsString+'"');
      VpaHTML.add('<P>Nosso sistema de cobrança ainda não detectou o pagamento da(s) fatura(s) abaixo.<br>');
      VpaHTML.add('<br>');
    end
    else
    begin
      AtualizaBarraStatus('Carregando as duplicatas a vencer do cliente "'+Titulos.FieldByName('C_NOM_CLI').AsString+'"');
{      VpaHTML.add('<P> Informamos através desta que dentro dos próximos 02 dias estarão vencendo os <br>');
Alterado a descricao pois o sistema envia todas as duplicatas com mais de 2 dias e nossos
clientes estavao reclamando desta mensagem}
      VpaHTML.add('<P> Informamos através desta os próximos compromissos financeiros: <br>');
//      VpaHTML.add('seguintes compromissos financeiros: ');
      VpaHTML.add('<br>');
      VpaHTML.add('<br>');
    end;

    VpaHTML.add('<br>');
    VpaHTML.add('Fornecedor : '+ VpaDFilial.NomFantasia);
    VpaHTML.add('<br>');
    VpaHTML.add('Cliente    : '+Titulos.FieldByName('C_NOM_CLI').AsString);
    VpaHTML.add('<br>');
    VpaHTML.add('<br>');
    VpaHTML.add('<table border=1 CELLSPACING=0 width=100%> ');
    VpaHTML.add('<tr>');
    if (config.ECobrancaEnviarValoresCorrigidos) and (VpaDatVencimento < date) then
    begin
      VpaHTML.add('  <td width="15%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Título</td>');
      VpaHTML.add('  <td width="15%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Nota Fiscal</td>');
      VpaHTML.add('  <td width="25%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor</td>');
      VpaHTML.add('  <td width="25%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Vencimento</td>');
      VpaHTML.add('  <td width="20%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Corrigido</td>');
      VpaHTML.add('</tr>');
    end
    else
    begin
      VpaHTML.add('  <td width="20%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Título</td>');
      VpaHTML.add('  <td width="20%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Nota Fiscal</td>');
      VpaHTML.add('  <td width="30%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor</td>');
      VpaHTML.add('  <td width="30%" align="center"><font face="Verdana" size="-1"><b>&nbsp;Vencimento</td>');
      VpaHTML.add('</tr>');
    end
  end;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.AtualizaBarraStatus(VpaTexto : String);
begin
  BarraStatus.Panels[0].Text := VpaTexto;
  BarraStatus.Refresh;
end;

{******************************************************************************}
procedure TFNovoEmailContasAReceber.BEnviarClick(Sender: TObject);
var
  VpfREsultado : String;
begin
  GravaCobrancaCorpo;
  EnviaEmailTitulos;
  BEnviar.Enabled := false;
  AtualizaBarraStatus('E-mail enviados com sucesso.');
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoEmailContasAReceber]);
end.
