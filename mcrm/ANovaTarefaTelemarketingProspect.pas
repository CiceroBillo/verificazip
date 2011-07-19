unit ANovaTarefaTelemarketingProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, PainelGradiente, DBCtrls, Componentes1,
  Localizacao, Mask, Tabela, ExtCtrls, Db, DBTables, CBancoDados,
  DBKeyViolation, UnClassificacao, Menus, DBClient;

type
  TFNovaTarefaTelemarketingProspect = class(TFormularioPermissao)
    Tarefa: TRBSQL;
    DataTarefa: TDataSource;
    PainelGradiente1: TPainelGradiente;
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
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton3: TSpeedButton;
    Label3: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    BCidade: TSpeedButton;
    Label7: TLabel;
    Label9: TLabel;
    SpeedButton4: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    SpeedButton5: TSpeedButton;
    Label14: TLabel;
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
    DBEditColor1: TDBEditColor;
    ECampanhaVendas: TDBEditLocaliza;
    CUltimoContato: TDBCheckBox;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    PainelTempo1: TPainelTempo;
    ECidade: TDBEditLocaliza;
    EDonoMaquina: TDBEditLocaliza;
    EDatGarantia: TDBEditColor;
    DBEditColor2: TDBEditColor;
    EUsuarioTele: TDBEditLocaliza;
    ERamoAtividade: TDBEditLocaliza;
    EProspect: TDBEditLocaliza;
    ECodVendedor: TDBEditLocaliza;
    CProspectsSemProduto: TDBCheckBox;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    ValidaGravacao: TValidaGravacao;
    TarefaSEQTAREFA: TIntegerField;
    TarefaCODREGIAO: TIntegerField;
    TarefaSEQPRODUTO: TIntegerField;
    TarefaCODPRODUTO: TStringField;
    TarefaCODCLASSIFICACAO: TStringField;
    TarefaDATTAREFA: TDateTimeField;
    TarefaQTDLIGACAO: TIntegerField;
    TarefaDATAGENDAMENTO: TDateTimeField;
    TarefaDATULTIMOCONTATOATE: TDateTimeField;
    TarefaINDDATULTIMOCONTATO: TStringField;
    TarefaSEQCAMPANHA: TIntegerField;
    TarefaCODUSUARIO: TIntegerField;
    TarefaNOMCIDADE: TStringField;
    TarefaCODDONO: TIntegerField;
    TarefaDATGARANTIA: TDateTimeField;
    TarefaDATGARANTIAFIM: TDateTimeField;
    TarefaCODUSUARIOTELE: TIntegerField;
    TarefaCODRAMOATIVIDADE: TIntegerField;
    TarefaCODVENDEDOR: TIntegerField;
    TarefaCODPROSPECT: TIntegerField;
    TarefaINDPROSPECTSEMPRODUTO: TStringField;
    TarefaCODESTAGIOPROPOSTA: TIntegerField;
    Aux: TQuery;
    Cadastro: TQuery;
    Label21: TLabel;
    SpeedButton9: TSpeedButton;
    Label22: TLabel;
    EEstagioProposta: TDBEditLocaliza;
    Label23: TLabel;
    Label24: TLabel;
    DBEditColor5: TDBEditColor;
    DBEditColor6: TDBEditColor;
    TarefaDATINICIOPROPOSTA: TDateField;
    TarefaDATFIMPROPOSTA: TDateField;
    TarefaDATINICIOCOMPRAPROPOSTA: TDateField;
    TarefaDATFIMCOMPRAPROPOSTA: TDateField;
    Label25: TLabel;
    Label26: TLabel;
    DBEditColor7: TDBEditColor;
    DBEditColor8: TDBEditColor;
    PopupMenu1: TPopupMenu;
    PrimeiraLigao1: TMenuItem;
    NegociaoPrevisoCompra1: TMenuItem;
    Label27: TLabel;
    DBEditLocaliza1: TDBEditLocaliza;
    SpeedButton11: TSpeedButton;
    Label28: TLabel;
    TarefaDATULTIMAPROPOSTA: TDateTimeField;
    TarefaCODSETOR: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EProdutoSelect(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ECodClassificacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodClassificacaoExit(Sender: TObject);
    procedure ECampanhaVendasCadastrar(Sender: TObject);
    procedure TarefaAfterInsert(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure ERegiaoVendaChange(Sender: TObject);
    procedure TarefaBeforeDelete(DataSet: TDataSet);
    procedure TarefaAfterPost(DataSet: TDataSet);
    procedure TarefaBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure PrimeiraLigao1Click(Sender: TObject);
    procedure NegociaoPrevisoCompra1Click(Sender: TObject);
  private
    FunClassificacao : TFuncoesClassificacao;
    procedure GeraMailing;
    function RQtdProspect : Integer;
    procedure AdicionafiltrosMailing(VpaSql: TStrings);
    procedure ExcluiMailing;
    function LocalizaClassificacao: Boolean;
    function UsuarioValidoRegiaVendas: Boolean;
  public
  end;

var
  FNovaTarefaTelemarketingProspect: TFNovaTarefaTelemarketingProspect;

implementation
uses APrincipal, FunObjeto, ALocalizaClassificacao,
  ANovaCampanhaVendas, constantes, FunSQL, FunData, ConstMsg, UnClientes,
  ATarefaTelemarketingProspect, UnProspect;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaTarefaTelemarketingProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Tarefa.Open;
  FunClassificacao := TFuncoesClassificacao.criar(self,fprincipal.basedados);
  IniciallizaCheckBox([CUltimoContato,CProspectsSemProduto],'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaTarefaTelemarketingProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunClassificacao.free;
  Tarefa.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.EProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  if Tarefa.State in [dsedit,dsinsert] then
  begin
    if Retorno1 <> '' then
      TarefaSEQPRODUTO.AsInteger := StrtoInt(Retorno1)
    else
      TarefaSEQPRODUTO.Clear;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.EProdutoSelect(
  Sender: TObject);
begin
  EProduto.ASelectValida.Text := 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text := 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.SpeedButton2Click(
  Sender: TObject);
begin
  LocalizaClassificacao;
end;

{******************************************************************************}
function TFNovaTarefaTelemarketingProspect.RQtdProspect : Integer;
begin
  Aux.close;
  Aux.Sql.clear;
  Aux.Sql.add('Select COUNT(CODPROSPECT) QTD from PROSPECT PRC Where INDACEITATELEMARKETING = ''S''');
  AdicionafiltrosMailing(Aux.sql);
  Aux.open;
  result := Aux.FieldByname('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.GeraMailing;
begin
  PainelTempo1.execute('Gerando Mailing. Aguarde...');
  Aux.close;
  Aux.Sql.clear;
  Aux.Sql.add('Select CODPROSPECT, NOMPROSPECT from PROSPECT PRC Where INDACEITATELEMARKETING = ''S''');
  AdicionafiltrosMailing(Aux.sql);
  Aux.open;
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFATELEMARKETINGPROSPECTITEM');
  while not aux.eof do
  begin
    Cadastro.insert;
    Cadastro.FieldByName('SEQTAREFA').AsInteger := TarefaSEQTAREFA.AsInteger;
    Cadastro.FieldByName('CODUSUARIO').AsInteger := TarefaCODUSUARIOTELE.AsInteger;
    Cadastro.FieldByName('CODPROSPECT').AsInteger := Aux.FieldByName('CODPROSPECT').AsInteger;
    Cadastro.FieldByName('DATLIGACAO').AsDatetime := TarefaDATAGENDAMENTO.AsDateTime;
    Cadastro.FieldByName('SEQCAMPANHA').AsInteger := TarefaSEQCAMPANHA.AsInteger;
    Cadastro.FieldByName('INDREAGENDADO').AsString := 'N';
    Cadastro.post;
    aux.next;
  end;
  PainelTempo1.fecha;
  Aux.Close;
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.ExcluiMailing;
begin
  ExecutaComandoSql(Aux,'Delete from TAREFATELEMARKETINGPROSPECTITEM '+
                        ' Where SEQTAREFA = '+TarefaSEQTAREFA.Asstring);
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.AdicionafiltrosMailing(VpaSql: TStrings);
begin
  if TarefaCODPROSPECT.AsInteger <> 0 then
    VpaSql.add('AND PRC.CODPROSPECT = '+TarefaCODPROSPECT.AsString)
  else
  begin
    if TarefaCODREGIAO.AsInteger <> 0 then
      VpaSql.add('AND PRC.CODREGIAO = '+TarefaCODREGIAO.AsString);
    if TarefaNOMCIDADE.AsString <> '' then
      VpaSql.add('AND PRC.DESCIDADE = '''+TarefaNOMCIDADE.AsString+'''');
    if TarefaCODRAMOATIVIDADE.AsInteger <> 0 then
      VpaSql.add('AND PRC.CODRAMOATIVIDADE = '+TarefaCODRAMOATIVIDADE.AsString);
    if TarefaCODVENDEDOR.AsInteger <> 0 then
      VpaSql.add('AND PRC.CODVENDEDOR = '+TarefaCODVENDEDOR.AsString);
    if TarefaINDDATULTIMOCONTATO.AsString = 'S' then
    begin
      VpaSql.add('and ( PRC.DATULTIMALIGACAO < '+SQLTextoDataAAAAMMMDD(incdia(TarefaDATULTIMOCONTATOATE.AsDateTime,1))+
                 ' or PRC.DATULTIMALIGACAO IS NULL)');
    end;
    if (TarefaCODESTAGIOPROPOSTA.AsInteger <> 0)and
       (TarefaDATINICIOPROPOSTA.IsNull) and
       (TarefaDATINICIOCOMPRAPROPOSTA.IsNull) then
    begin
      VpaSql.add(' and exists ');
      VpaSql.Add('(select * from PROPOSTA CAD ');
      VpaSql.Add('where CAD.CODPROSPECT = PRC.CODPROSPECT '+
                 'and CODESTAGIO = '+TarefaCODESTAGIOPROPOSTA.AsString+')');
    end;
    if not(TarefaDATINICIOPROPOSTA.IsNull)  then
    begin
      VpaSql.add(' and exists ');
      VpaSql.Add('(select * from PROPOSTA CAD ');
      VpaSql.Add('where CAD.CODPROSPECT = PRC.CODPROSPECT '+
                 SQLTextoDataEntreAAAAMMDD('CAD.DATPROPOSTA',TarefaDATINICIOPROPOSTA.AsDateTime,incDia(TarefaDATFIMPROPOSTA.AsDateTime,1),true));
      if TarefaCODESTAGIOPROPOSTA.AsInteger <> 0 then
        VpaSql.add('and CODESTAGIO = '+TarefaCODESTAGIOPROPOSTA.AsString);
      VpaSql.add(')');
    end;
    if not (TarefaDATINICIOCOMPRAPROPOSTA.IsNull)  then
    begin
      VpaSql.add(' and exists ');
      VpaSql.Add('(select * from PROPOSTA CAD ');
      VpaSql.Add('where CAD.CODPROSPECT = PRC.CODPROSPECT '+
                 SQLTextoDataEntreAAAAMMDD('CAD.DATPREVISAOCOMPRA',TarefaDATINICIOCOMPRAPROPOSTA.AsDateTime,TarefaDATFIMCOMPRAPROPOSTA.AsDateTime,true));
      if TarefaCODESTAGIOPROPOSTA.AsInteger <> 0 then
        VpaSql.add('and CODESTAGIO = '+TarefaCODESTAGIOPROPOSTA.AsString);
      VpaSql.add(')');
    end;
    if (TarefaSEQPRODUTO.AsInteger <> 0) or (TarefaCODDONO.AsInteger <> 0) or
       not (TarefaDATGARANTIA.IsNull)  then
    begin
      VpaSql.add('and exists(select * FROM PRODUTOPROSPECT PCL '+
                  ' Where PCL.CODPROSPECT = PRC.CODPROSPECT ');
      if TarefaSEQPRODUTO.AsInteger <> 0 then
        VpaSql.add(' AND PCL.SEQPRODUTO = '+TarefaSEQPRODUTO.asstring );
      if TarefaCODDONO.AsInteger <> 0 then
        VpaSql.add(' AND PCL.CODDONO = '+TarefaCODDONO.asstring );
      if not TarefaDATGARANTIA.IsNull then
        VpaSql.Add(SQLTextoDataEntreAAAAMMDD('DATGARANTIA',TarefaDATGARANTIA.AsDateTime,TarefaDATGARANTIAFIM.AsDateTime,true));
      VpaSql.add(')');
    end;
    if TarefaCODCLASSIFICACAO.AsString <> '' then
      VpaSql.add('and exists(select * FROM PRODUTOPROSPECT PCL, CADPRODUTOS PRO '+
                 ' WHERE PCL.SEQPRODUTO = PRO.I_SEQ_PRO '+
                 ' AND PCL.CODPROSPECT = PRC.CODPROSPECT '+
                 ' AND PRO.C_COD_CLA like '''+TarefaCODCLASSIFICACAO.AsString+'%'')');
    if TarefaINDPROSPECTSEMPRODUTO.AsString  = 'S' then
    begin
      VpaSql.add('and not exists(select * FROM PRODUTOPROSPECT PCL '+
                 ' Where PCL.CODPROSPECT = PRC.CODPROSPECT )');
    end;
    if TarefaCODSETOR.AsInteger <> 0 then
    begin
      VpaSql.Add('AND EXISTS (SELECT *'+
                 '            FROM PROPOSTA PPR'+
                 '            WHERE PPR.CODSETOR = '+TarefaCODSETOR.AsString+
                 '            AND PPR.CODPROSPECT = PRC.CODPROSPECT)');
    end;
  end;

end;

{******************************************************************************}
function TFNovaTarefaTelemarketingProspect.LocalizaClassificacao: Boolean;
var
  VpfCodClassificacao, VpfNomClassificacao : string;
begin
  result := true;
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomClassificacao, 'P') then
  begin
    TarefaCODCLASSIFICACAO.AsString := VpfCodClassificacao;
    LNomClassificacao.Caption := VpfNomClassificacao;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaTarefaTelemarketingProspect.UsuarioValidoRegiaVendas: Boolean;
begin
  result := true;
  if TarefaCODREGIAO.AsInteger <> 0 then
  begin
    result := false;
    AdicionaSQLAbreTabela(Aux,'Select I_COD_USU from CADUSUARIOS '+
                              ' Where I_COD_REG = ' + TarefaCODREGIAO.AsString);
    while not aux.eof do
    begin
      if Aux.FieldByName('I_COD_USU').AsInteger = TarefaCODUSUARIOTELE.AsInteger then
        result := true;
      Aux.next;
    end;
  end
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.ECodClassificacaoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.ECodClassificacaoExit(
  Sender: TObject);
var
  VpfNomClassificacao : String;
begin
  if TarefaCODCLASSIFICACAO.AsString <> '' then
  begin
    if not FunClassificacao.ValidaClassificacao(TarefaCODCLASSIFICACAO.AsString,VpfNomClassificacao, 'P') then
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
procedure TFNovaTarefaTelemarketingProspect.ECampanhaVendasCadastrar(
  Sender: TObject);
begin
  FNovaCampanhaVendas := TFNovaCampanhaVendas.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCampanhaVendas'));
  FNovaCampanhaVendas.CampanhaVendas.Insert;
  FNovaCampanhaVendas.showmodal;
  FNovaCampanhaVendas.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.TarefaAfterInsert(
  DataSet: TDataSet);
begin
  TarefaINDPROSPECTSEMPRODUTO.AsString := 'N';
  TarefaINDDATULTIMOCONTATO.AsString := 'N';
  TarefaCODUSUARIO.AsInteger := varia.codigoUsuario;
  TarefaDATAGENDAMENTO.AsDateTime := date;
  TarefaDATULTIMOCONTATOATE.AsDateTime := DecDia(Date,15);
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.ERegiaoVendaChange(
  Sender: TObject);
begin
  if Tarefa.State in [dsinsert,dsedit] then
    ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.TarefaBeforeDelete(
  DataSet: TDataSet);
begin
   ExcluiMailing
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.TarefaAfterPost(
  DataSet: TDataSet);
begin
  GeraMailing;
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.TarefaBeforePost(
  DataSet: TDataSet);
begin
  if Tarefa.state = dsinsert then
  begin
    if not UsuarioValidoRegiaVendas then
      if not confirmacao('Usuário não pertence a essa região de vendas, deseja gerar tarefa?') then
        abort;

    TarefaDATTAREFA.AsDateTime := now;
    TarefaSEQTAREFA.AsInteger := FunProspect.RSeqTarefaTelemarketingProspectDisponivel;
    TarefaQTDLIGACAO.AsInteger := RQtdProspect;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.FormShow(Sender: TObject);
begin
  if Tarefa.State = dsBrowse then
    AtualizaLocalizas(PanelColor1);
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.PrimeiraLigao1Click(
  Sender: TObject);
begin
  TarefaDATINICIOPROPOSTA.AsDateTime := DecDia(date,30);
  TarefaDATFIMPROPOSTA.AsDateTime := DecDia(date,3);
  TarefaCODESTAGIOPROPOSTA.AsInteger := Varia.EstagioAguardandoRecebimentoProposta;
  TarefaSEQCAMPANHA.AsInteger := 1;
  ECampanhaVendas.Atualiza;
  EEstagioProposta.Atualiza;
  ActiveControl := EUsuarioTele;
end;

{******************************************************************************}
procedure TFNovaTarefaTelemarketingProspect.NegociaoPrevisoCompra1Click(
  Sender: TObject);
begin
  TarefaDATINICIOCOMPRAPROPOSTA.AsDateTime := DecDia(date,30);
  TarefaDATFIMCOMPRAPROPOSTA.AsDateTime := date;
  TarefaCODESTAGIOPROPOSTA.AsInteger := Varia.EstagioPropostaEmNegociacao;
  TarefaSEQCAMPANHA.AsInteger := 1;
  ECampanhaVendas.Atualiza;
  EEstagioProposta.Atualiza;
  ActiveControl := EUsuarioTele;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaTarefaTelemarketingProspect]);
end.
