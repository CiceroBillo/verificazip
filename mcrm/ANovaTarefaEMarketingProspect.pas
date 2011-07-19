unit ANovaTarefaEMarketingProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons, Componentes1,
  DBCtrls, Localizacao, Mask, Tabela, Db, DBTables, CBancoDados, UnClassificacao,
  DBKeyViolation, UnProspect, ComCtrls, UnEMarketingProspect, DBClient;

type
  TFNovaTarefaEMarketingProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    TAREFAEMARKETINGPROSPECT: TRBSQL;
    Aux: TSQL;
    Cadastro: TSQL;
    DataTAREFAEARKETINGPROSPECT: TDataSource;
    ValidaGravacao: TValidaGravacao;
    TAREFAEMARKETINGPROSPECTSEQTAREFA: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTQTDENVIADO: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTCODREGIAO: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTSEQPRODUTO: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTCODPRODUTO: TWideStringField;
    TAREFAEMARKETINGPROSPECTCODCLASSIFICACAO: TWideStringField;
    TAREFAEMARKETINGPROSPECTDATTAREFA: TSQLTimeStampField;
    TAREFAEMARKETINGPROSPECTQTDEMAIL: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTDATULTIMOCONTATOATE: TSQLTimeStampField;
    TAREFAEMARKETINGPROSPECTINDDATULTIMOCONTATO: TWideStringField;
    TAREFAEMARKETINGPROSPECTCODUSUARIO: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTNOMCIDADE: TWideStringField;
    TAREFAEMARKETINGPROSPECTCODDONO: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTDATGARANTIA: TSQLTimeStampField;
    TAREFAEMARKETINGPROSPECTDATGARANTIAFIM: TSQLTimeStampField;
    TAREFAEMARKETINGPROSPECTCODRAMOATIVIDADE: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTINDDATULTIMOPEDIDO: TWideStringField;
    TAREFAEMARKETINGPROSPECTDATULTIMOPEDIDO: TSQLTimeStampField;
    TAREFAEMARKETINGPROSPECTCODVENDEDOR: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTCODPROSPECT: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTINDPROSPECTSEMPRODUTO: TWideStringField;
    TAREFAEMARKETINGPROSPECTINDPROPOSTADESDE: TWideStringField;
    TAREFAEMARKETINGPROSPECTDATPROPOSTADESDE: TSQLTimeStampField;
    TAREFAEMARKETINGPROSPECTDESASSUNTOEMAIL: TWideStringField;
    TAREFAEMARKETINGPROSPECTQTDEMAILENVIADO: TFMTBCDField;
    TAREFAEMARKETINGPROSPECTNOMARQUIVO: TWideStringField;
    TAREFAEMARKETINGPROSPECTDESLINKINTERNET: TWideStringField;
    PanelColor1: TPanelColor;
    PageControl1: TPageControl;
    PFiltros: TTabSheet;
    PanelColor3: TPanelColor;
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
    EProspect: TDBEditLocaliza;
    PainelTempo1: TPainelTempo;
    PComposicao: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton3: TSpeedButton;
    Label13: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditColor7: TDBEditColor;
    DBEditColor8: TDBEditColor;
    OpenDialog1: TOpenDialog;
    PanelColor4: TPanelColor;
    Label14: TLabel;
    TAREFAEMARKETINGPROSPECTDESTEXTO: TWideStringField;
    DBMemoColor1: TDBMemoColor;
    Label21: TLabel;
    CHtml: TRadioButton;
    Label22: TLabel;
    CTexto: TRadioButton;
    TAREFAEMARKETINGPROSPECTNUMFORMATOEMAIL: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EProdutoSelect(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ECodClassificacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodClassificacaoExit(Sender: TObject);
    procedure TAREFAEMARKETINGPROSPECTAfterInsert(DataSet: TDataSet);
    procedure ERegiaoVendaChange(Sender: TObject);
    procedure TAREFAEMARKETINGPROSPECTBeforePost(DataSet: TDataSet);
    procedure TAREFAEMARKETINGPROSPECTAfterPost(DataSet: TDataSet);
    procedure SpeedButton3Click(Sender: TObject);
    procedure CHtmlClick(Sender: TObject);
    procedure TAREFAEMARKETINGPROSPECTAfterScroll(DataSet: TDataSet);
  private
    FunProspect: TRBFuncoesProspect;
    FunClassificacao: TFuncoesClassificacao;
    FunEmarketing : TRBFuncoesEMarketingProspect;
    procedure InicializaTela;
    function LocalizaClassificacao: Boolean;
    procedure AdicionafiltrosAgendamento(VpaSql: TStrings);
    procedure GeraMailing;
  public
  end;

var
  FNovaTarefaEMarketingProspect: TFNovaTarefaEMarketingProspect;

implementation
uses
  APrincipal, ATarefaEMarketingProspect, FunData, FunSQL, Constantes,
  FunObjeto, ALocalizaClassificacao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaTarefaEMarketingProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  PageControl1.ActivePageIndex := 0;
  FunProspect:= TRBFuncoesProspect.cria(FPrincipal.BaseDados);
  TAREFAEMARKETINGPROSPECT.Open;
  FunClassificacao:= TFuncoesClassificacao.Criar(Self,FPrincipal.BaseDados);
  FunEmarketing := TRBFuncoesEMarketingProspect.cria(FPrincipal.BaseDados);
  InicializaTela;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaTarefaEMarketingProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunClassificacao.Free;
  TAREFAEMARKETINGPROSPECT.Close;
  FunProspect.Free;
  FunEmarketing.free;
  Action := CaFree;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFNovaTarefaEMarketingProspect.CHtmlClick(Sender: TObject);
begin
  if TAREFAEMARKETINGPROSPECT.State in [dsedit,dsinsert] then
  begin
    if CHtml.Checked then
      TAREFAEMARKETINGPROSPECTNUMFORMATOEMAIL.AsInteger := 0
    else
      TAREFAEMARKETINGPROSPECTNUMFORMATOEMAIL.AsInteger := 1;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.EProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  if TAREFAEMARKETINGPROSPECT.State in [dsEdit,dsInsert] then
  begin
    if Retorno1 <> '' then
      TAREFAEMARKETINGPROSPECTSEQPRODUTO.AsInteger:= StrToInt(Retorno1)
    else
      TAREFAEMARKETINGPROSPECTSEQPRODUTO.Clear;
  end
  else
  begin
    EProduto.Clear;
    Label5.Caption:= '';
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text:= 'SELECT * FROM CADPRODUTOS WHERE '+Varia.CodigoProduto + ' = ''@'' AND C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text:= 'SELECT * FROM CADPRODUTOS WHERE C_NOM_PRO LIKE ''@%'' AND C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.SpeedButton2Click(
  Sender: TObject);
begin
  if TAREFAEMARKETINGPROSPECT.State in [dsEdit,dsInsert] then
    LocalizaClassificacao;
end;

{******************************************************************************}
function TFNovaTarefaEMarketingProspect.LocalizaClassificacao : Boolean;
var
  VpfCodClassificacao, VpfNomClassificacao : string;
begin
  Result:= True;
  FLocalizaClassificacao:= TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomClassificacao, 'P') then
  begin
    TAREFAEMARKETINGPROSPECTCODCLASSIFICACAO.AsString:= VpfCodClassificacao;
    LNomClassificacao.Caption:= VpfNomClassificacao;
  end
  else
    Result:= False;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.AdicionafiltrosAgendamento(VpaSql: TStrings);
begin
  if TAREFAEMARKETINGPROSPECTCODPROSPECT.AsInteger <> 0 then
    VpaSql.add('AND PRC.CODPROSPECT = '+TAREFAEMARKETINGPROSPECTCODPROSPECT.AsString)
  else
  begin
    if TAREFAEMARKETINGPROSPECTCODREGIAO.AsInteger <> 0 then
      VpaSql.add('AND PRC.CODREGIAO = '+TAREFAEMARKETINGPROSPECTCODREGIAO.AsString);
    if TAREFAEMARKETINGPROSPECTNOMCIDADE.AsString <> '' then
      VpaSql.add('AND PRC.DESCIDADE = '''+TarefaEMarketingProspectNOMCIDADE.AsString+'''');
    if TarefaEMarketingProspectCODRAMOATIVIDADE.AsInteger <> 0 then
      VpaSql.add('AND PRC.CODRAMOATIVIDADE = '+TarefaEMarketingProspectCODRAMOATIVIDADE.AsString);
    if TarefaEMarketingpROSPECTCODVENDEDOR.AsInteger <> 0 then
      VpaSql.add('AND PRC.CODVENDEDOR = '+TarefaEMarketingProspectCODVENDEDOR.AsString);
    if TarefaEMarketingProspectINDDATULTIMOCONTATO.AsString = 'S' then
    begin
      VpaSql.add('and ( PRC.DATULTIMOEMAIL < '+SQLTextoDataAAAAMMMDD(incdia(TarefaEMarketingProspectDATULTIMOCONTATOATE.AsDateTime,1))+
                 ' or PRC.DATULTIMOEMAIL IS NULL)');
    end;
    if TAREFAEMARKETINGPROSPECTINDDATULTIMOPEDIDO.AsString = 'S' then
    begin
      VpaSql.add(' and not exists ');
      VpaSql.Add('(select * from PROPOSTA CAD ');
      VpaSql.Add('where CAD.CODPROSPECT = PRC.CODPROSPECT'+
                 ' and CAD.DATPROPOSTA >= '+SQLTextoDataAAAAMMMDD(TAREFAEMARKETINGPROSPECTDATULTIMOPEDIDO.AsDateTime)+')');
    end;
    if (TarefaEMarketingProspectSEQPRODUTO.AsInteger <> 0) or (TarefaEMarketingProspectCODDONO.AsInteger <> 0) or
       not (TarefaEMarketingProspectDATGARANTIA.IsNull)  then
    begin
      VpaSql.add('and exists(select PCL.CODPROSPECT FROM PRODUTOPROSPECT PCL '+
                  ' Where PCL.CODPROSPECT = PRC.CODPROSPECT ');
      if TarefaEMarketingProspectSEQPRODUTO.AsInteger <> 0 then
        VpaSql.add(' AND PCL.SEQPRODUTO = '+TarefaEMarketingProspectSEQPRODUTO.asstring );
      if TarefaEMarketingProspectCODDONO.AsInteger <> 0 then
        VpaSql.add(' AND PCL.CODDONO = '+TarefaEMarketingProspectCODDONO.asstring );
      if not TarefaEMarketingProspectDATGARANTIA.IsNull then
        VpaSql.Add(SQLTextoDataEntreAAAAMMDD('DATGARANTIA',TarefaEMarketingProspectDATGARANTIA.AsDateTime,TarefaEMarketingProspectDATGARANTIAFIM.AsDateTime,true));
      VpaSql.add(')');
    end;
    if TarefaEMarketingProspectCODCLASSIFICACAO.AsString <> '' then
      VpaSql.add('and exists(select PCL.CODPROSPECT FROM PRODUTOPROSPECT PCL, CADPRODUTOS PRO '+
                  ' WHERE PCL.SEQPRODUTO = PRO.I_SEQ_PRO '+
                  ' AND PCL.CODPROSPECT = PRC.CODPROSPECT '+
                  ' AND PRO.C_COD_CLA like '''+TarefaEMarketingProspectCODCLASSIFICACAO.AsString+'%'')');
    if TAREFAEMARKETINGPROSPECTINDPROSPECTSEMPRODUTO.AsString  = 'S' then
    begin
      VpaSql.add('and not exists(select PCL.CODCLIENTE FROM PRODUTOPROSPECT PCL '+
                  ' Where PCL.CODPROSPECT = PRC.CODPROSPECT )');
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.GeraMailing;
var
  VpfCodProspect : Integer;
begin
  PainelTempo1.execute('Excluindo mailing existente. Aguarde...');
  ExecutaComandoSql(Aux,'DELETE FROM TAREFAEMARKETINGPROSPECTITEM'+
                                 ' Where SEQTAREFA = '+TAREFAEMARKETINGPROSPECTSEQTAREFA.AsString);
  PainelTempo1.execute('Gerando Mailing. Aguarde...');
  Aux.Close;
  Aux.SQL.Clear;
  Aux.SQL.Add('SELECT PRC.CODPROSPECT,  PRC.DESEMAILCONTATO, PRC.NOMCONTATO NOMPROSPECT, '+
              ' PRC.INDACEITASPAM, PRC.INDEMAILINVALIDO, '+
              ' CON.SEQCONTATO, CON.NOMCONTATO, CON.DESEMAIL '+
              ' FROM PROSPECT PRC, CONTATOPROSPECT CON ' +
              ' WHERE '+SQLTextoRightJoin('PRC.CODPROSPECT','CON.CODPROSPECT') +
              ' AND CON.INDACEITAEMARKETING = ''S'''+
              ' AND CON.INDEMAILINVALIDO = ''N''');
  AdicionafiltrosAgendamento(Aux.SQL);
  Aux.SQL.Add('ORDER BY PRC.CODPROSPECT, CON.SEQCONTATO');
  Aux.Open;
  VpfCodProspect := -99;
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM TAREFAEMARKETINGPROSPECTITEM'+
                                 ' Where SEQTAREFA = 0 AND CODPROSPECT = 0 AND SEQCONTATO = 0');
  while not Aux.Eof do
  begin
    if VpfCodProspect <> Aux.FieldByName('CODPROSPECT').AsInteger then
    begin
      if (Aux.FieldByname('INDACEITASPAM').AsString = 'S') AND (Aux.FieldByname('INDEMAILINVALIDO').AsString = 'N') then
      begin
        Cadastro.Insert;
        Cadastro.FieldByName('SEQTAREFA').AsInteger:= TAREFAEMARKETINGPROSPECTSEQTAREFA.AsInteger;
        Cadastro.FieldByName('CODPROSPECT').AsInteger:= Aux.FieldByName('CODPROSPECT').AsInteger;
        Cadastro.FieldByName('SEQCONTATO').AsInteger:= 0;
        Cadastro.FieldByName('INDENVIADO').AsString:= 'N';
        Cadastro.FieldByName('INDCONTATOPRINCIPAL').AsString:= 'S';
        Cadastro.FieldByName('DESEMAIL').AsString:= Aux.FieldByName('DESEMAILCONTATO').AsString;
        Cadastro.FieldByName('NOMCONTATO').AsString:= Aux.FieldByName('NOMPROSPECT').AsString;
        Cadastro.Post;
      end;
      VpfCodProspect := Aux.FieldByName('CODPROSPECT').AsInteger;
    end;
    if Aux.FieldByName('SEQCONTATO').AsInteger <> 0 then
    begin
      Cadastro.Insert;
      Cadastro.FieldByName('SEQTAREFA').AsInteger:= TAREFAEMARKETINGPROSPECTSEQTAREFA.AsInteger;
      Cadastro.FieldByName('CODPROSPECT').AsInteger:= Aux.FieldByName('CODPROSPECT').AsInteger;
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
procedure TFNovaTarefaEMarketingProspect.ECodClassificacaoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.ECodClassificacaoExit(Sender: TObject);
var
  VpfNomClassificacao : String;
begin
  if TAREFAEMARKETINGPROSPECTCODCLASSIFICACAO.AsString <> '' then
  begin
    if not FunClassificacao.ValidaClassificacao(TAREFAEMARKETINGPROSPECTCODCLASSIFICACAO.AsString,VpfNomClassificacao, 'P') then
    begin
      if not LocalizaClassificacao then
       ECodClassificacao.SetFocus;
    end
    else
      LNomClassificacao.Caption:= VpfNomClassificacao;
  end
  else
    LNomClassificacao.Caption:= '';
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.TAREFAEMARKETINGPROSPECTAfterInsert(DataSet: TDataSet);
begin
  TAREFAEMARKETINGPROSPECTINDDATULTIMOPEDIDO.AsString:= 'N';
  TAREFAEMARKETINGPROSPECTINDDATULTIMOCONTATO.AsString:= 'N';
  TAREFAEMARKETINGPROSPECTINDPROSPECTSEMPRODUTO.AsString := 'N';
  TAREFAEMARKETINGPROSPECTCODUSUARIO.AsInteger:= varia.codigoUsuario;
  TAREFAEMARKETINGPROSPECTDATULTIMOCONTATOATE.AsDateTime:= DecDia(Date,5);
  TAREFAEMARKETINGPROSPECTDESLINKINTERNET.AsString:= varia.SiteFilial;
  CHtml.Checked := true;
  CHtmlClick(CHtml);
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.ERegiaoVendaChange(Sender: TObject);
begin
  if TAREFAEMARKETINGPROSPECT.State in [dsInsert, dsEdit] then
    ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.TAREFAEMARKETINGPROSPECTBeforePost(DataSet: TDataSet);
begin
  if TAREFAEMARKETINGPROSPECT.State = dsInsert then
  begin
    TAREFAEMARKETINGPROSPECTDATTAREFA.AsDateTime:= Now;
    TAREFAEMARKETINGPROSPECTSEQTAREFA.AsInteger:= FunProspect.RSeqTarefaEMarketingProspectDisponivel;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.TAREFAEMARKETINGPROSPECTAfterPost(DataSet: TDataSet);
begin
  GeraMailing;
  FunEmarketing.AtualizaQtdEmail(TAREFAEMARKETINGPROSPECTSEQTAREFA.AsInteger);
end;

procedure TFNovaTarefaEMarketingProspect.TAREFAEMARKETINGPROSPECTAfterScroll(
  DataSet: TDataSet);
begin
  case TAREFAEMARKETINGPROSPECTNUMFORMATOEMAIL.AsInteger of
    0 : CHtml.Checked := true;
    1 : CTexto.Checked := true;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.InicializaTela;
begin
  IniciallizaCheckBox([CUltimoContato,CUltimoPedido,CClientesSemProduto],'S','N');
end;

{******************************************************************************}
procedure TFNovaTarefaEMarketingProspect.SpeedButton3Click(
  Sender: TObject);
begin
  if TAREFAEMARKETINGPROSPECT.State in [dsinsert,dsedit] then
    if OpenDialog1.Execute then
      TAREFAEMARKETINGPROSPECTNOMARQUIVO.AsString := OpenDialog1.FileName;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaTarefaEMarketingProspect]);
end.
