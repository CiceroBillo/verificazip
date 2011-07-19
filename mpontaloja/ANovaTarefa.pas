unit ANovaTarefa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  Db, Mask, DBCtrls, Tabela, DBTables, CBancoDados, UnClassificacao,
  BotaoCadastro, DBKeyViolation, ComCtrls, Menus, DBClient;

type
  TFNovaTarefa = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Tarefa: TRBSQL;
    TarefaSEQTAREFA: TFMTBCDField;
    TarefaCODREGIAO: TFMTBCDField;
    TarefaSEQPRODUTO: TFMTBCDField;
    TarefaCODPRODUTO: TWideStringField;
    TarefaCODCLASSIFICACAO: TWideStringField;
    TarefaDATTAREFA: TSQLTimeStampField;
    TarefaQTDLIGACOES: TFMTBCDField;
    TarefaDATAGENDAMENTO: TSQLTimeStampField;
    TarefaINDDATULTIMOCONTATO: TWideStringField;
    TarefaSEQCAMPANHA: TFMTBCDField;
    TarefaCODUSUARIO: TFMTBCDField;
    DataTarefa: TDataSource;
    Localiza: TConsultaPadrao;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    TarefaDATULTIMOCONTATOATE: TSQLTimeStampField;
    Aux: TSQL;
    TarefaNOMCIDADE: TWideStringField;
    TarefaCODDONO: TFMTBCDField;
    TarefaDATGARANTIA: TSQLTimeStampField;
    TarefaDATGARANTIAFIM: TSQLTimeStampField;
    TarefaCODUSUARIOTELE: TFMTBCDField;
    TarefaCODRAMOATIVIDADE: TFMTBCDField;
    Cadastro: TSQL;
    TarefaINDDATULTIMOPEDIDO: TWideStringField;
    TarefaDATULTIMOPEDIDO: TSQLTimeStampField;
    TarefaCODVENDEDOR: TFMTBCDField;
    TarefaCODCLIENTE: TFMTBCDField;
    TarefaINDCLIENTESEMPRODUTO: TWideStringField;
    TarefaDATCOMPRADESDE: TSQLTimeStampField;
    TarefaINDCOMPRADESDE: TWideStringField;
    PanelColor1: TPanelColor;
    PageControl1: TPageControl;
    PGerais: TTabSheet;
    PPedidosCompra: TTabSheet;
    Label21: TLabel;
    DBEditColor7: TDBEditColor;
    Label22: TLabel;
    DBEditColor8: TDBEditColor;
    TarefaDATCADASTROPEDIDO: TSQLTimeStampField;
    TarefaDATCADASTROPEDIDOFIM: TSQLTimeStampField;
    TarefaDATPRAZOPEDIDO: TSQLTimeStampField;
    TarefaDATPRAZOPEDIDOFIM: TSQLTimeStampField;
    TarefaCODESTAGIOPEDIDO: TFMTBCDField;
    TarefaCODCOMPRADORPEDIDO: TFMTBCDField;
    Label23: TLabel;
    DBEditColor9: TDBEditColor;
    Label24: TLabel;
    DBEditColor10: TDBEditColor;
    Label25: TLabel;
    BEstagio: TSpeedButton;
    Label26: TLabel;
    DBEditLocaliza2: TDBEditLocaliza;
    Label27: TLabel;
    SpeedButton9: TSpeedButton;
    Label28: TLabel;
    DBEditLocaliza3: TDBEditLocaliza;
    PPedidos: TPopupMenu;
    PrimeiraLigao1: TMenuItem;
    PedidosAtrasados1: TMenuItem;
    PProspect: TTabSheet;
    Label29: TLabel;
    SpeedButton11: TSpeedButton;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    SpeedButton12: TSpeedButton;
    Label36: TLabel;
    EEstagioProposta: TDBEditLocaliza;
    DBEditColor11: TDBEditColor;
    DBEditColor12: TDBEditColor;
    DBEditColor13: TDBEditColor;
    DBEditColor14: TDBEditColor;
    DBEditLocaliza4: TDBEditLocaliza;
    TarefaDATINICIOPROPOSTA: TSQLTimeStampField;
    TarefaDATFIMPROPOSTA: TSQLTimeStampField;
    TarefaDATINICIOCOMPRAPROPOSTA: TSQLTimeStampField;
    TarefaDATFIMCOMPRAPROPOSTA: TSQLTimeStampField;
    TarefaCODESTAGIOPROPOSTA: TFMTBCDField;
    TarefaCODSETORPROPOSTA: TFMTBCDField;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    NegociaoPrevisoCompra1: TMenuItem;
    TarefaDESBAIRRO: TWideStringField;
    ScrollBox1: TScrollBox;
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
    Label37: TLabel;
    ERegiaoVenda: TDBEditLocaliza;
    EProduto: TEditLocaliza;
    ECodClassificacao: TDBEditColor;
    DBEditColor1: TDBEditColor;
    DBEditLocaliza1: TDBEditLocaliza;
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
    CUltimoPedido: TDBCheckBox;
    DBEditColor5: TDBEditColor;
    ECliente: TDBEditLocaliza;
    ECodVendedor: TDBEditLocaliza;
    CClientesSemProduto: TDBCheckBox;
    DBEditColor6: TDBEditColor;
    CClientequeComprou: TDBCheckBox;
    DBEditColor15: TDBEditColor;
    Label38: TLabel;
    ESituacao: TDBEditLocaliza;
    SpeedButton13: TSpeedButton;
    Label39: TLabel;
    TarefaCODSITUACAO: TFMTBCDField;
    TarefaINDPROSPECT: TWideStringField;
    TarefaINDCLIENTE: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    TarefaINDSITUACAOCLIENTE: TWideStringField;
    DBCheckBox3: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EProdutoCadastrar(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EProdutoSelect(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ECodClassificacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodClassificacaoExit(Sender: TObject);
    procedure DBEditLocaliza1Cadastrar(Sender: TObject);
    procedure TarefaAfterInsert(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure TarefaBeforeInsert(DataSet: TDataSet);
    procedure DBEditLocaliza1Change(Sender: TObject);
    procedure TarefaBeforeDelete(DataSet: TDataSet);
    procedure TarefaAfterPost(DataSet: TDataSet);
    procedure PrimeiraLigao1Click(Sender: TObject);
    procedure PedidosAtrasados1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure NegociaoPrevisoCompra1Click(Sender: TObject);
    procedure BotaoGravar1Click(Sender: TObject);
  private
    { Private declarations }
    FunClassificacao : TFuncoesClassificacao;
    function AtualizaAgendamentosCliente:boolean;
    procedure AtualizaCadastroCliente;
    procedure GeraMailing;
    procedure ExcluiAgendamento;
    procedure ExcluiMailing;
    procedure AdicionafiltrosAgendamento(VpaSql : TStrings);
    function LocalizaClassificacao : Boolean;
    function UsuarioValidoRegiaVendas : Boolean;
  public
    { Public declarations }
  end;

var
  FNovaTarefa: TFNovaTarefa;

implementation

uses APrincipal, Constantes, ALocalizaClassificacao,
  ANovaCampanhaVendas,FunObjeto, ATarefas, UnClientes, FunData,FunSql, ConstMsg,
  ANovoProdutoPro;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaTarefa.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Tarefa.open;
  FunClassificacao := TFuncoesClassificacao.criar(self,fprincipal.basedados);
  PageControl1.ActivePage:= PGerais;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaTarefa.FormClose(Sender: TObject; var Action: TCloseAction);
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
procedure TFNovaTarefa.EProdutoCadastrar(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  FNovoProdutoPro.NovoProduto('');
  FNovoProdutoPro.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaTarefa.EProdutoRetorno(Retorno1, Retorno2: String);
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
procedure TFNovaTarefa.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text := 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text := 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFNovaTarefa.SpeedButton2Click(Sender: TObject);
begin
  LocalizaClassificacao;
end;

{******************************************************************************}
function TFNovaTarefa.AtualizaAgendamentosCliente:boolean;
begin
  PainelTempo1.execute('Gerando Agendamentos. Aguarde...');
  if not config.UtilizarMailing then
    AtualizaCadastroCliente;

  Aux.close;
  Aux.Sql.clear;
  Aux.Sql.add('Select count(I_COD_CLI) QTD from CADCLIENTES CLI Where C_ACE_TEL = ''S''');
  AdicionafiltrosAgendamento(Aux.sql);
  Aux.open;
  TarefaQTDLIGACOES.AsInteger := Aux.FieldByName('QTD').AsInteger;
  Aux.close;
  PainelTempo1.Fecha;
end;

{******************************************************************************}
procedure TFNovaTarefa.AtualizaCadastroCliente;
begin
  Aux.sql.clear;
  Aux.Sql.add('Update CADCLIENTES CLI '+
              ' SET D_PRO_LIG = '+SQLTextoDataAAAAMMMDD(TarefaDATAGENDAMENTO.AsDateTime)+
              ' ,I_SEQ_CAM = '+TarefaSEQCAMPANHA.AsString+
              ' Where CLI.C_ACE_TEL = ''S''');
  AdicionafiltrosAgendamento(Aux.sql);
  Aux.ExecSQL;
end;

{******************************************************************************}
procedure TFNovaTarefa.GeraMailing;
begin
  PainelTempo1.execute('Gerando Mailing. Aguarde...');
  Aux.close;
  Aux.Sql.clear;
  Aux.Sql.add('Select I_COD_CLI from CADCLIENTES CLI Where C_ACE_TEL = ''S''');
  AdicionafiltrosAgendamento(Aux.sql);
  Aux.open;
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFATELEMARKETINGITEM');
  while not aux.eof do
  begin
    Cadastro.insert;
    Cadastro.FieldByName('SEQTAREFA').AsInteger := TarefaSEQTAREFA.AsInteger;
    Cadastro.FieldByName('CODUSUARIO').AsInteger := TarefaCODUSUARIOTELE.AsInteger;
    Cadastro.FieldByName('CODCLIENTE').AsInteger := Aux.FieldByName('I_COD_CLI').AsInteger;
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
procedure TFNovaTarefa.ExcluiAgendamento;
begin
  Aux.sql.clear;
  Aux.Sql.add('Update CADCLIENTES CLI '+
              ' SET D_PRO_LIG =  null ' +
              ' Where CLI.C_ACE_TEL = ''S''');
  AdicionafiltrosAgendamento(Aux.sql);
  Aux.ExecSQL;
end;

{******************************************************************************}
procedure TFNovaTarefa.ExcluiMailing;
begin
  ExecutaComandoSql(Aux,'Delete from TAREFATELEMARKETINGITEM '+
                        ' Where SEQTAREFA = '+TarefaSEQTAREFA.Asstring);
end;

{******************************************************************************}
procedure TFNovaTarefa.AdicionafiltrosAgendamento(VpaSql : TStrings);
begin
  if TarefaCODCLIENTE.AsInteger <> 0 then
    VpaSql.add('AND CLI.I_COD_CLI = '+TarefaCODCLIENTE.AsString)
  else
  begin
    if TarefaCODREGIAO.AsInteger <> 0 then
      VpaSql.add('AND CLI.I_COD_REG = '+TarefaCODREGIAO.AsString);
    if TarefaNOMCIDADE.AsString <> '' then
      VpaSql.add('AND CLI.C_CID_CLI = '''+TarefaNOMCIDADE.AsString+'''');
    if TarefaDESBAIRRO.AsString <> '' then
      VpaSql.add('AND CLI.C_BAI_CLI = '''+TarefaDESBAIRRO.AsString+'''');
    if TarefaCODRAMOATIVIDADE.AsInteger <> 0 then
      VpaSql.add('AND CLI.I_COD_RAM = '+TarefaCODRAMOATIVIDADE.AsString);
    if TarefaCODVENDEDOR.AsInteger <> 0 then
      VpaSql.add('AND CLI.I_COD_VEN = '+TarefaCODVENDEDOR.AsString);
    if TarefaCODSITUACAO.AsInteger <> 0 then
      VpaSql.add('AND CLI.I_COD_SIT = '+TarefaCODSITUACAO.AsString);
    if TarefaINDCLIENTE.AsString = 'S' then
      VpaSql.add('AND CLI.C_IND_CLI = ''S''');
    if TarefaINDPROSPECT.AsString = 'S' then
      VpaSql.add('AND CLI.C_IND_PRC = ''S''');
    if TarefaINDSITUACAOCLIENTE.AsString = 'S' then
      VpaSql.add('AND CLI.C_IND_ATI = ''S''')
    Else
      VpaSql.add('AND CLI.C_IND_ATI = ''N''');


    if TarefaINDDATULTIMOCONTATO.AsString = 'S' then
    begin
      VpaSql.add('and ( CLI.D_ULT_TEL < '+SQLTextoDataAAAAMMMDD(incdia(TarefaDATULTIMOCONTATOATE.AsDateTime,1))+
                 ' or CLI.D_ULT_TEL IS NULL)');
    end;
    if TarefaINDDATULTIMOPEDIDO.AsString = 'S' then
    begin
      VpaSql.add(' and not exists ');
      VpaSql.Add('(select * from CADORCAMENTOS CAD ');
      VpaSql.Add('where CAD.I_COD_CLI = CLI.I_COD_CLI'+
                 ' and CAD.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(TarefaDATULTIMOPEDIDO.AsDateTime)+')');
    end;
    if TarefaINDCOMPRADESDE.AsString = 'S' then
    begin
      VpaSql.add(' and exists ');
      VpaSql.Add('(select * from CADORCAMENTOS CAD ');
      VpaSql.Add('where CAD.I_COD_CLI = CLI.I_COD_CLI'+
                 ' and CAD.I_TIP_ORC <> 1 AND CAD.I_TIP_ORC <> 5'+
                 ' and CAD.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(TarefaDATCOMPRADESDE.AsDateTime)+')');
    end;
    if (TarefaSEQPRODUTO.AsInteger <> 0) or (TarefaCODDONO.AsInteger <> 0) or
       not (TarefaDATGARANTIA.IsNull)  then
    begin
      VpaSql.add('and exists(select * FROM PRODUTOCLIENTE PCL '+
                  ' Where PCL.CODCLIENTE = CLI.I_COD_CLI ');
      if TarefaSEQPRODUTO.AsInteger <> 0 then
        VpaSql.add(' AND PCL.SEQPRODUTO = '+TarefaSEQPRODUTO.asstring );
      if TarefaCODDONO.AsInteger <> 0 then
        VpaSql.add(' AND PCL.CODDONO = '+TarefaCODDONO.asstring );
      if not TarefaDATGARANTIA.IsNull then
        VpaSql.Add(SQLTextoDataEntreAAAAMMDD('DATGARANTIA',TarefaDATGARANTIA.AsDateTime,TarefaDATGARANTIAFIM.AsDateTime,true));
      VpaSql.add(')');
    end;
    if TarefaCODCLASSIFICACAO.AsString <> '' then
      VpaSql.add('and exists(select * FROM PRODUTOCLIENTE PCL, CADPRODUTOS PRO '+
                  ' WHERE PCL.SEQPRODUTO = PRO.I_SEQ_PRO '+
                  ' AND PCL.CODCLIENTE = CLI.I_COD_CLI '+
                  ' AND PRO.C_COD_CLA like '''+TarefaCODCLASSIFICACAO.AsString+'%'')');
    if TarefaINDCLIENTESEMPRODUTO.AsString  = 'S' then
    begin
      VpaSql.add('and not exists(select * FROM PRODUTOCLIENTE PCL '+
                  ' Where PCL.CODCLIENTE = CLI.I_COD_CLI )');
    end;
    if (not TarefaDATCADASTROPEDIDO.IsNull) or
       (not TarefaDATPRAZOPEDIDO.IsNull) or
       (TarefaCODESTAGIOPEDIDO.AsInteger <> 0) or
       (TarefaCODCOMPRADORPEDIDO.AsInteger <> 0) then
    begin
      VpaSql.Add('AND EXISTS (SELECT * FROM PEDIDOCOMPRACORPO PCC'+
                 '            WHERE PCC.CODCLIENTE = CLI.I_COD_CLI');
      if not TarefaDATCADASTROPEDIDO.IsNull then
        VpaSql.Add(SQLTextoDataEntreAAAAMMDD('PCC.DATPEDIDO',TarefaDATCADASTROPEDIDO.AsDateTime,TarefaDATCADASTROPEDIDOFIM.AsDateTime,True));
      if not TarefaDATPRAZOPEDIDO.IsNull then
        VpaSql.Add(SQLTextoDataEntreAAAAMMDD('PCC.DATPREVISTA',TarefaDATPRAZOPEDIDO.AsDateTime,TarefaDATPRAZOPEDIDOFIM.AsDateTime,True));
      if TarefaCODESTAGIOPEDIDO.AsInteger <> 0 then
        VpaSql.Add(' AND PCC.CODESTAGIO = '+TarefaCODESTAGIOPEDIDO.AsString);
      if TarefaCODCOMPRADORPEDIDO.AsInteger <> 0 then
        VpaSql.Add(' AND PCC.CODCOMPRADOR = '+TarefaCODCOMPRADORPEDIDO.AsString);
      VpaSql.Add(')');
    end;
    if (not TarefaDATINICIOPROPOSTA.IsNull) or
       (not TarefaDATINICIOCOMPRAPROPOSTA.IsNull) or
       (TarefaCODESTAGIOPROPOSTA.AsInteger <> 0) or
       (TarefaCODSETORPROPOSTA.AsInteger <> 0) then
    begin
      VpaSql.Add(' AND EXISTS (SELECT * FROM PROPOSTA PPT'+
                 '             WHERE PPT.CODCLIENTE = CLI.I_COD_CLI');
      if not TarefaDATINICIOPROPOSTA.IsNull then
        VpaSql.Add(SQLTextoDataEntreAAAAMMDD('PPT.DATPROPOSTA',TarefaDATINICIOPROPOSTA.AsDateTime,TarefaDATFIMPROPOSTA.AsDateTime,True));
      if not TarefaDATINICIOCOMPRAPROPOSTA.IsNull then
        VpaSql.Add(SQLTextoDataEntreAAAAMMDD('PPT.DATPREVISAOCOMPRA',TarefaDATINICIOCOMPRAPROPOSTA.AsDateTime,TarefaDATFIMCOMPRAPROPOSTA.AsDateTime,True));
      if TarefaCODESTAGIOPROPOSTA.AsInteger <> 0 then
        VpaSql.Add(' AND PPT.CODESTAGIO = '+TarefaCODESTAGIOPROPOSTA.AsString);
      if TarefaCODSETORPROPOSTA.AsInteger <> 0 then
        VpaSql.Add(' AND PPT.CODSETOR = '+TarefaCODSETORPROPOSTA.AsString);
      VpaSql.Add(')');
    end;
  end;
end;

{************* abre a localizacao das classificacao ************************* }
function TFNovaTarefa.LocalizaClassificacao : Boolean;
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
function TFNovaTarefa.UsuarioValidoRegiaVendas : Boolean;
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
end;

{******************************************************************************}
procedure TFNovaTarefa.ECodClassificacaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFNovaTarefa.ECodClassificacaoExit(Sender: TObject);
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
procedure TFNovaTarefa.DBEditLocaliza1Cadastrar(Sender: TObject);
begin
  FNovaCampanhaVendas := TFNovaCampanhaVendas.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCampanhaVendas'));
  FNovaCampanhaVendas.CampanhaVendas.Insert;
  FNovaCampanhaVendas.showmodal;
  FNovaCampanhaVendas.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaTarefa.TarefaAfterInsert(DataSet: TDataSet);
begin
  TarefaINDDATULTIMOCONTATO.AsString := 'S';
  TarefaINDDATULTIMOPEDIDO.AsString := 'N';
  TarefaINDCLIENTESEMPRODUTO.AsString := 'N';
  TarefaINDCOMPRADESDE.AsString := 'N';
  TarefaINDCLIENTE.AsString := 'S';
  TarefaINDPROSPECT.AsString := 'N';
  TarefaINDSITUACAOCLIENTE.AsString := 'S';
  TarefaCODUSUARIO.AsInteger := varia.codigoUsuario;
  TarefaDATAGENDAMENTO.AsDateTime := date;
  TarefaCODUSUARIOTELE.AsInteger := varia.CodigoUsuario;
  EUsuarioTele.Atualiza; 
  TarefaDATULTIMOCONTATOATE.AsDateTime := DecDia(Date,15);
end;

{******************************************************************************}
procedure TFNovaTarefa.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFNovaTarefa.BotaoGravar1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovaTarefa.TarefaBeforeInsert(DataSet: TDataSet);
begin
  if Tarefa.state = dsinsert then
  begin
    if TarefaCODREGIAO.AsInteger <> 0 then
      if not UsuarioValidoRegiaVendas then
        if not confirmacao('Usuário não pertence a essa região de vendas, deseja gerar tarefa?') then
          abort;

    TarefaDATTAREFA.AsDateTime := now;
    TarefaSEQTAREFA.AsInteger := FunClientes.RSeqTarefaDisponivel;
    AtualizaAgendamentosCliente;
  end;
end;

{******************************************************************************}
procedure TFNovaTarefa.DBEditLocaliza1Change(Sender: TObject);
begin
  if Tarefa.State in [dsinsert,dsedit] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaTarefa.TarefaBeforeDelete(DataSet: TDataSet);
begin
  if config.UtilizarMailing then
    ExcluiMailing
  else
    ExcluiAgendamento;
end;

{******************************************************************************}
procedure TFNovaTarefa.TarefaAfterPost(DataSet: TDataSet);
begin
  if config.UtilizarMailing then
    GeraMailing;
end;

{******************************************************************************}
procedure TFNovaTarefa.PrimeiraLigao1Click(Sender: TObject);
begin
  TarefaSEQCAMPANHA.AsInteger := varia.SeqCampanhaTelemarketing;

  TarefaDATINICIOCOMPRAPROPOSTA.Clear;
  TarefaDATFIMCOMPRAPROPOSTA.Clear;
  TarefaDATINICIOPROPOSTA.Clear;
  TarefaDATFIMPROPOSTA.Clear;
  TarefaCODESTAGIOPROPOSTA.Clear;

  TarefaDATPRAZOPEDIDO.Clear;
  TarefaDATPRAZOPEDIDOFIM.Clear;
  TarefaDATCADASTROPEDIDO.AsDateTime:= DecMes(Now,1);
  TarefaDATCADASTROPEDIDOFIM.AsDateTime:= Now;
  TarefaCODESTAGIOPEDIDO.AsInteger:= Varia.EstagioComprasAguardandoConfirmacaoRecebFornececedor;
  DBEditLocaliza2.Atualiza;
end;

{******************************************************************************}
procedure TFNovaTarefa.PedidosAtrasados1Click(Sender: TObject);
begin
  TarefaSEQCAMPANHA.AsInteger := varia.SeqCampanhaTelemarketing;

  TarefaDATINICIOCOMPRAPROPOSTA.Clear;
  TarefaDATFIMCOMPRAPROPOSTA.Clear;
  TarefaDATINICIOPROPOSTA.Clear;
  TarefaDATFIMPROPOSTA.Clear;
  TarefaCODESTAGIOPROPOSTA.Clear;

  TarefaDATCADASTROPEDIDO.Clear;
  TarefaDATCADASTROPEDIDOFIM.Clear;
  TarefaDATPRAZOPEDIDO.AsDateTime:= DecMes(Now,4);
  TarefaDATPRAZOPEDIDOFIM.AsDateTime:= Now;
  TarefaCODESTAGIOPEDIDO.AsInteger:= Varia.EstagioComprasAguardandoEntregaFornecedor;
  DBEditLocaliza2.Atualiza;
end;

{******************************************************************************}
procedure TFNovaTarefa.MenuItem1Click(Sender: TObject);
begin
  TarefaDATPRAZOPEDIDO.Clear;
  TarefaDATPRAZOPEDIDOFIM.Clear;
  TarefaDATCADASTROPEDIDO.Clear;
  TarefaDATCADASTROPEDIDOFIM.Clear;

  TarefaDATINICIOCOMPRAPROPOSTA.Clear;
  TarefaDATFIMCOMPRAPROPOSTA.Clear;
  TarefaDATINICIOPROPOSTA.AsDateTime:= DecDia(date,30);
  TarefaDATFIMPROPOSTA.AsDateTime:= DecDia(date,3);
  TarefaCODESTAGIOPROPOSTA.AsInteger:= Varia.EstagioAguardandoRecebimentoProposta;
  EEstagioProposta.Atualiza;
end;

{******************************************************************************}
procedure TFNovaTarefa.NegociaoPrevisoCompra1Click(Sender: TObject);
begin
  TarefaDATPRAZOPEDIDO.Clear;
  TarefaDATPRAZOPEDIDOFIM.Clear;
  TarefaDATCADASTROPEDIDO.Clear;
  TarefaDATCADASTROPEDIDOFIM.Clear;
  
  TarefaDATINICIOPROPOSTA.Clear;
  TarefaDATFIMPROPOSTA.Clear;
  TarefaDATINICIOCOMPRAPROPOSTA.AsDateTime:= DecDia(date,30);
  TarefaDATFIMCOMPRAPROPOSTA.AsDateTime:= date;
  TarefaCODESTAGIOPROPOSTA.AsInteger:= Varia.EstagioPropostaEmNegociacao;
  EEstagioProposta.Atualiza;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaTarefa]);
end.
