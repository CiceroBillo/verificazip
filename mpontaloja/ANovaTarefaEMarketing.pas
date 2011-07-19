unit ANovaTarefaEMarketing;

interface

uses
  ATarefaEMarketing,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, BotaoCadastro, StdCtrls, Buttons, ExtCtrls, Componentes1,
  DBCtrls, Localizacao, Mask, Tabela, Db, DBTables, UnClassificacao,
  DBKeyViolation, CBancoDados, ComCtrls, UnEmarketing, DBClient;

type
  TFNovaTarefaEMarketing = class(TFormularioPermissao)
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    PainelGradiente1: TPainelGradiente;
    DataTAREFAEMARKETING: TDataSource;
    Aux: TSQL;
    Cadastro: TSQL;
    ValidaGravacao1: TValidaGravacao;
    TAREFAEMARKETING: TRBSQL;
    TAREFAEMARKETINGSEQTAREFA: TFMTBCDField;
    TAREFAEMARKETINGCODREGIAO: TFMTBCDField;
    TAREFAEMARKETINGSEQPRODUTO: TFMTBCDField;
    TAREFAEMARKETINGCODPRODUTO: TWideStringField;
    TAREFAEMARKETINGCODCLASSIFICACAO: TWideStringField;
    TAREFAEMARKETINGDATTAREFA: TSQLTimeStampField;
    TAREFAEMARKETINGQTDEMAIL: TFMTBCDField;
    TAREFAEMARKETINGDATULTIMOCONTATOATE: TSQLTimeStampField;
    TAREFAEMARKETINGINDDATULTIMOCONTATO: TWideStringField;
    TAREFAEMARKETINGCODUSUARIO: TFMTBCDField;
    TAREFAEMARKETINGNOMCIDADE: TWideStringField;
    TAREFAEMARKETINGCODDONO: TFMTBCDField;
    TAREFAEMARKETINGDATGARANTIA: TSQLTimeStampField;
    TAREFAEMARKETINGDATGARANTIAFIM: TSQLTimeStampField;
    TAREFAEMARKETINGCODRAMOATIVIDADE: TFMTBCDField;
    TAREFAEMARKETINGINDDATULTIMOPEDIDO: TWideStringField;
    TAREFAEMARKETINGDATULTIMOPEDIDO: TSQLTimeStampField;
    TAREFAEMARKETINGCODVENDEDOR: TFMTBCDField;
    TAREFAEMARKETINGCODCLIENTE: TFMTBCDField;
    TAREFAEMARKETINGINDCLIENTESEMPRODUTO: TWideStringField;
    Localiza: TConsultaPadrao;
    TAREFAEMARKETINGINDCOMPRADESDE: TWideStringField;
    TAREFAEMARKETINGDATCOMPRADESDE: TSQLTimeStampField;
    PanelColor3: TPanelColor;
    PageControl1: TPageControl;
    PFiltros: TTabSheet;
    PanelColor1: TPanelColor;
    Label82: TLabel;
    SpeedButton10: TSpeedButton;
    Label83: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    LNomClassificacao: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    BCidade: TSpeedButton;
    Label7: TLabel;
    Label9: TLabel;
    SpeedButton4: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    SpeedButton6: TSpeedButton;
    Label16: TLabel;
    Label17: TLabel;
    SpeedButton7: TSpeedButton;
    Label18: TLabel;
    Label19: TLabel;
    SpeedButton8: TSpeedButton;
    Label20: TLabel;
    ERegiaoVenda: TDBEditLocaliza;
    EProduto: TEditLocaliza;
    ECodClassificacao: TDBEditColor;
    CUltimoContato: TDBCheckBox;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    ECidade: TDBEditLocaliza;
    EDonoMaquina: TDBEditLocaliza;
    EDatGarantia: TDBEditColor;
    DBEditColor2: TDBEditColor;
    CUltimoPedido: TDBCheckBox;
    DBEditColor5: TDBEditColor;
    ECodVendedor: TDBEditLocaliza;
    CClientesSemProduto: TDBCheckBox;
    ERamoAtividade: TDBEditLocaliza;
    ECliente: TDBEditLocaliza;
    PainelTempo1: TPainelTempo;
    DBEditColor6: TDBEditColor;
    CClientequeComprou: TDBCheckBox;
    PComposicaoEmail: TTabSheet;
    PanelColor4: TPanelColor;
    TAREFAEMARKETINGDESASSUNTOEMAIL: TWideStringField;
    TAREFAEMARKETINGQTDEMAILENVIADO: TFMTBCDField;
    TAREFAEMARKETINGNOMARQUIVO: TWideStringField;
    TAREFAEMARKETINGDESTEMPOPREVISTO: TWideStringField;
    DBEditColor1: TDBEditColor;
    DBEditColor7: TDBEditColor;
    DBEditColor8: TDBEditColor;
    Label1: TLabel;
    TAREFAEMARKETINGDESLINKINTERNET: TWideStringField;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton3: TSpeedButton;
    OpenDialog1: TOpenDialog;
    Label13: TLabel;
    CCliente: TDBCheckBox;
    CFornecedor: TDBCheckBox;
    CProspect: TDBCheckBox;
    TAREFAEMARKETINGINDCLIENTE: TWideStringField;
    TAREFAEMARKETINGINDPROSPECT: TWideStringField;
    TAREFAEMARKETINGINDFORNECEDOR: TWideStringField;
    TAREFAEMARKETINGDESUF: TWideStringField;
    SpeedButton5: TSpeedButton;
    Label14: TLabel;
    Label21: TLabel;
    EUF: TDBEditLocaliza;
    BarraStatus: TStatusBar;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    DBMemoColor1: TDBMemoColor;
    CHtml: TRadioButton;
    CTexto: TRadioButton;
    TAREFAEMARKETINGDESTEXTO: TWideStringField;
    TAREFAEMARKETINGNUMFORMATOEMAIL: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EProdutoCadastrar(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EProdutoSelect(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ECodClassificacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodClassificacaoExit(Sender: TObject);
    procedure TAREFAEMARKETINGAfterInsert(DataSet: TDataSet);
    procedure ERegiaoVendaChange(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure TAREFAEMARKETINGBeforePost(DataSet: TDataSet);
    procedure TAREFAEMARKETINGAfterPost(DataSet: TDataSet);
    procedure SpeedButton3Click(Sender: TObject);
    procedure CTextoClick(Sender: TObject);
    procedure TAREFAEMARKETINGAfterScroll(DataSet: TDataSet);
  private
    FunClassificacao : TFuncoesClassificacao;
    FunEmarketing : TRBFuncoesEMarketing;
    function LocalizaClassificacao: Boolean;
    procedure AdicionafiltrosAgendamento(VpaSql : TStrings);
    procedure GeraMailing;
  public
    { Public declarations }
  end;

var
  FNovaTarefaEMarketing: TFNovaTarefaEMarketing;

implementation
uses
  APrincipal, UnClientes, FunData, FunSQL, ALocalizaClassificacao, Constantes,
  FunObjeto, ANovoProdutoPro, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaTarefaEMarketing.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  PageControl1.ActivePageIndex := 0;
  FunClassificacao:= TFuncoesClassificacao.Criar(self,fprincipal.basedados);
  FunEmarketing := TRBFuncoesEMarketing.cria(FPrincipal.BaseDados);
  TAREFAEMARKETING.open;
  IniciallizaCheckBox([CUltimoContato,CUltimoPedido,CClientesSemProduto,CClientequeComprou,CCliente,CFornecedor,CProspect],'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaTarefaEMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  TAREFAEMARKETING.close;
  FunClassificacao.Free;
  FunEmarketing.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaTarefaEMarketing.EProdutoCadastrar(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  FNovoProdutoPro.NovoProduto('');
  FNovoProdutoPro.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.EProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  if TAREFAEMARKETING.State in [dsedit,dsinsert] then
  begin
    if Retorno1 <> '' then
      TAREFAEMARKETINGSEQPRODUTO.AsInteger:= StrToInt(Retorno1)
    else
      TAREFAEMARKETINGSEQPRODUTO.Clear;
  end
  else
  begin
    EProduto.Clear;
    Label5.Caption:= '';
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.EProdutoSelect(Sender: TObject);
begin
// ????????????
  EProduto.ASelectValida.Text := 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text := 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.SpeedButton2Click(Sender: TObject);
begin
  if TAREFAEMARKETING.State in [dsedit,dsinsert] then
    LocalizaClassificacao;
end;

{******************************************************************************}
function TFNovaTarefaEMarketing.LocalizaClassificacao : Boolean;
var
  VpfCodClassificacao, VpfNomClassificacao : string;
begin
  Result:= True;
  FLocalizaClassificacao:= TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomClassificacao, 'P') then
  begin
    TAREFAEMARKETINGCODCLASSIFICACAO.AsString:= VpfCodClassificacao;
    LNomClassificacao.Caption:= VpfNomClassificacao;
  end
  else
    Result:= False;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.AdicionafiltrosAgendamento(VpaSql : TStrings);
var
  VpfFiltro : String;
begin
  if TAREFAEMARKETINGCODCLIENTE.AsInteger <> 0 then
    VpaSql.add('AND CLI.I_COD_CLI = '+TarefaEMarketingCODCLIENTE.AsString)
  else
  begin
    if TarefaEMarketingCODREGIAO.AsInteger <> 0 then
      VpaSql.add('AND CLI.I_COD_REG = '+TarefaEMarketingCODREGIAO.AsString);
    if TarefaEMarketingNOMCIDADE.AsString <> '' then
      VpaSql.add('AND CLI.C_CID_CLI = '''+TarefaEMarketingNOMCIDADE.AsString+'''');
    if TAREFAEMARKETINGDESUF.AsString <> '' then
      VpaSql.add('AND CLI.C_EST_CLI = '''+TarefaEMarketingDesuf.AsString+'''');
    if TarefaEMarketingCODRAMOATIVIDADE.AsInteger <> 0 then
      VpaSql.add('AND CLI.I_COD_RAM = '+TarefaEMarketingCODRAMOATIVIDADE.AsString);
    if TarefaEMarketingCODVENDEDOR.AsInteger <> 0 then
      VpaSql.add('AND CLI.I_COD_VEN = '+TarefaEMarketingCODVENDEDOR.AsString);
    if (CCliente.Checked) or (CFornecedor.Checked) or (CProspect.Checked) then
    begin
      VpfFiltro := '';
      VpaSql.ADD('AND(');
      if TAREFAEMARKETINGINDCLIENTE.AsString = 'S' then
         VpfFiltro := 'CLI.C_IND_CLI = ''S''';
      if TAREFAEMARKETINGINDFORNECEDOR.AsString = 'S' then
      begin
        if  VpfFiltro <> '' then
          VpfFiltro := VpfFiltro + ' OR ';
        VpfFiltro := VpfFiltro + 'CLI.C_IND_FOR = ''S''';
      end;
      if TAREFAEMARKETINGINDPROSPECT.AsString = 'S' then
      begin
        if  VpfFiltro <> '' then
          VpfFiltro := VpfFiltro + ' OR ';
        VpfFiltro := VpfFiltro +  'CLI.C_IND_PRC = ''S''';
      end;
      VpaSql.Add(VpfFiltro);
      VpaSql.ADD(')');
    end;

    if TarefaEMarketingINDDATULTIMOCONTATO.AsString = 'S' then
    begin
      VpaSql.add('and ( CLI.D_ULT_EMA < '+SQLTextoDataAAAAMMMDD(incdia(TarefaEMarketingDATULTIMOCONTATOATE.AsDateTime,1))+
                 ' or CLI.D_ULT_EMA IS NULL)');
    end;
    if TarefaEMarketingINDDATULTIMOPEDIDO.AsString = 'S' then
    begin
      VpaSql.add(' and not exists ');
      VpaSql.Add('(select * from CADORCAMENTOS CAD ');
      VpaSql.Add('where CAD.I_COD_CLI = CLI.I_COD_CLI'+
                 ' and CAD.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(TarefaEMarketingDATULTIMOPEDIDO.AsDateTime)+')');
    end;
    if TarefaEMarketingINDCOMPRADESDE.AsString = 'S' then
    begin
      VpaSql.add(' and exists ');
      VpaSql.Add('(select * from CADORCAMENTOS CAD ');
      VpaSql.Add('where CAD.I_COD_CLI = CLI.I_COD_CLI'+
                 ' and CAD.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(TarefaEMarketingDATCOMPRADESDE.AsDateTime)+')');
    end;
    if (TarefaEMarketingSEQPRODUTO.AsInteger <> 0) or (TarefaEMarketingCODDONO.AsInteger <> 0) or
       not (TarefaEMarketingDATGARANTIA.IsNull)  then
    begin
      VpaSql.add('and exists(select PCL.CODCLIENTE FROM PRODUTOCLIENTE PCL '+
                  ' Where PCL.CODCLIENTE = CLI.I_COD_CLI ');
      if TarefaEMarketingSEQPRODUTO.AsInteger <> 0 then
        VpaSql.add(' AND PCL.SEQPRODUTO = '+TarefaEMarketingSEQPRODUTO.asstring );
      if TarefaEMarketingCODDONO.AsInteger <> 0 then
        VpaSql.add(' AND PCL.CODDONO = '+TarefaEMarketingCODDONO.asstring );
      if not TarefaEMarketingDATGARANTIA.IsNull then
        VpaSql.Add(SQLTextoDataEntreAAAAMMDD('DATGARANTIA',TarefaEMarketingDATGARANTIA.AsDateTime,TarefaEMarketingDATGARANTIAFIM.AsDateTime,true));
      VpaSql.add(')');
    end;
    if TarefaEMarketingCODCLASSIFICACAO.AsString <> '' then
      VpaSql.add('and exists(select PCL.CODCLIENTE FROM PRODUTOCLIENTE PCL, CADPRODUTOS PRO '+
                  ' WHERE PCL.SEQPRODUTO = PRO.I_SEQ_PRO '+
                  ' AND PCL.CODCLIENTE = CLI.I_COD_CLI '+
                  ' AND PRO.C_COD_CLA like '''+TarefaEMarketingCODCLASSIFICACAO.AsString+'%'')');
    if TarefaEMarketingINDCLIENTESEMPRODUTO.AsString  = 'S' then
    begin
      VpaSql.add('and not exists(select PCL.CODCLIENTE FROM PRODUTOCLIENTE PCL '+
                  ' Where PCL.CODCLIENTE = CLI.I_COD_CLI )');
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.GeraMailing;
var
  vpfCodCliente : Integer;
begin
  PainelTempo1.execute('Excluindo mailing existente. Aguarde...');
  ExecutaComandoSql(Aux,'DELETE FROM TAREFAEMARKETINGITEM'+
                                 ' Where SEQTAREFA = '+TAREFAEMARKETINGSEQTAREFA.AsString);

  PainelTempo1.execute('Gerando Mailing. Aguarde...');
  Aux.Close;
  Aux.SQL.Clear;
  Aux.SQL.Add('SELECT CLI.I_COD_CLI,  CLI.C_END_ELE, CLI.C_CON_CLI NOMCLIENTE, '+
              ' CLI.C_ACE_SPA, '+
              ' CON.SEQCONTATO, CON.NOMCONTATO, CON.DESEMAIL, '+
              ' CON.INDACEITAEMARKETING '+
              ' FROM CADCLIENTES CLI, CONTATOCLIENTE CON ' +
              ' WHERE '+ SQLTextoRightJoin('CLI.I_COD_CLI','CON.CODCLIENTE'));
  AdicionafiltrosAgendamento(Aux.SQL);
  aux.sql.add('order by CLI.I_COD_CLI');
  Aux.Open;
  VpfCodCliente := -99;
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM TAREFAEMARKETINGITEM '+
                                 ' Where SEQTAREFA = 0 AND CODCLIENTE = 0 AND SEQCONTATO = 0 ');
  while not Aux.Eof do
  begin
    BarraStatus.Panels[0].Text := 'Gerando e-mail para o cliente '+Aux.FieldByName('I_COD_CLI').AsString+'-'+Aux.FieldByName('NOMCLIENTE').AsString;
    if VpfCodCliente <> Aux.FieldByName('I_COD_CLI').AsInteger then
    begin
      if (Aux.FieldByname('C_ACE_SPA').AsString = 'S') then
      begin
        Cadastro.Insert;
        Cadastro.FieldByName('SEQTAREFA').AsInteger:= TAREFAEMARKETINGSEQTAREFA.AsInteger;
        Cadastro.FieldByName('CODCLIENTE').AsInteger:= Aux.FieldByName('I_COD_CLI').AsInteger;
        Cadastro.FieldByName('SEQCONTATO').AsInteger:= 0;
        Cadastro.FieldByName('INDENVIADO').AsString:= 'N';
        Cadastro.FieldByName('INDCONTATOPRINCIPAL').AsString:= 'S';
        Cadastro.FieldByName('DESEMAIL').AsString:= Aux.FieldByName('C_END_ELE').AsString;
        Cadastro.FieldByName('NOMCONTATO').AsString:= Aux.FieldByName('NOMCLIENTE').AsString;
        Cadastro.Post;
      end;
      VpfCodCliente := Aux.FieldByName('I_COD_CLI').AsInteger;
    end;
    if (Aux.FieldByName('SEQCONTATO').AsInteger <> 0) and
       (Aux.FieldByName('INDACEITAEMARKETING').Asstring = 'S') then
    begin
      Cadastro.Insert;
      Cadastro.FieldByName('SEQTAREFA').AsInteger:= TAREFAEMARKETINGSEQTAREFA.AsInteger;
      Cadastro.FieldByName('CODCLIENTE').AsInteger:= Aux.FieldByName('I_COD_CLI').AsInteger;
      Cadastro.FieldByName('SEQCONTATO').AsInteger:= Aux.FieldByName('SEQCONTATO').AsInteger;
      Cadastro.FieldByName('INDENVIADO').AsString:= 'N';
      Cadastro.FieldByName('INDCONTATOPRINCIPAL').AsString:= 'N';
      Cadastro.FieldByName('DESEMAIL').AsString:= Aux.FieldByName('DESEMAIL').AsString;
      Cadastro.FieldByName('NOMCONTATO').AsString:= Aux.FieldByName('NOMCONTATO').AsString;
      Cadastro.Post;
    end;
    Aux.Next;
  end;
  PainelTempo1.Fecha;
  Aux.Close;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.ECodClassificacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.ECodClassificacaoExit(Sender: TObject);
var
  VpfNomClassificacao : String;
begin
  if TAREFAEMARKETINGCODCLASSIFICACAO.AsString <> '' then
  begin
    if not FunClassificacao.ValidaClassificacao(TAREFAEMARKETINGCODCLASSIFICACAO.AsString,VpfNomClassificacao, 'P') then
    begin
      if not LocalizaClassificacao then
       ECodClassificacao.SetFocus;
    end
    else
      LNomClassificacao.Caption := VpfNomClassificacao;
  end
  else
    LNomClassificacao.Caption := '';
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.TAREFAEMARKETINGAfterInsert(
  DataSet: TDataSet);
begin
  TAREFAEMARKETINGINDDATULTIMOPEDIDO.AsString := 'N';
  TAREFAEMARKETINGINDDATULTIMOCONTATO.AsString := 'S';
  TAREFAEMARKETINGINDCLIENTESEMPRODUTO.AsString := 'N';
  TAREFAEMARKETINGINDCOMPRADESDE.AsString := 'N';
  TAREFAEMARKETINGINDFORNECEDOR.AsString := 'S';
  TAREFAEMARKETINGINDCLIENTE.AsString := 'S';
  TAREFAEMARKETINGINDPROSPECT.AsString := 'S';
  TAREFAEMARKETINGCODUSUARIO.AsInteger := varia.codigoUsuario;
  TAREFAEMARKETINGDATULTIMOCONTATOATE.AsDateTime := DecDia(Date,6);
  TAREFAEMARKETINGDESLINKINTERNET.AsString := varia.SiteFilial;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.ERegiaoVendaChange(Sender: TObject);
begin
  if TAREFAEMARKETING.State in [dsInsert, dsEdit] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFNovaTarefaEMarketing.CTextoClick(Sender: TObject);
begin
  if TAREFAEMARKETING.State in [dsedit,dsinsert] then
  begin
    if CHtml.Checked then
      TAREFAEMARKETINGNUMFORMATOEMAIL.AsInteger := 0
    else
      TAREFAEMARKETINGNUMFORMATOEMAIL.AsInteger := 1;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.TAREFAEMARKETINGBeforePost(
  DataSet: TDataSet);
begin
  if TAREFAEMARKETING.state = dsInsert then
  begin
    TAREFAEMARKETINGDATTAREFA.AsDateTime:= now;
    TAREFAEMARKETINGSEQTAREFA.AsInteger:= FunClientes.RSeqTarefaEMarketingDisponivel;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.TAREFAEMARKETINGAfterPost(
  DataSet: TDataSet);
begin
  GeraMailing;
  FunEmarketing.AtualizaQtdEmail(TAREFAEMARKETINGSEQTAREFA.AsInteger);
end;

procedure TFNovaTarefaEMarketing.TAREFAEMARKETINGAfterScroll(DataSet: TDataSet);
begin
  case TAREFAEMARKETINGNUMFORMATOEMAIL.AsInteger of
    0 : CHtml.Checked := true;
    1 : CTexto.Checked := true;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketing.SpeedButton3Click(Sender: TObject);
begin
  if TAREFAEMARKETING.State in [dsinsert] then
    if OpenDialog1.Execute then
      TAREFAEMARKETINGNOMARQUIVO.AsString := OpenDialog1.FileName;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaTarefaEMarketing]);
end.
