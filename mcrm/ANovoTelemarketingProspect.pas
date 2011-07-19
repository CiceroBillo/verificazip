unit ANovoTelemarketingProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  Tabela, DBCtrls, Mask, ComCtrls, DBKeyViolation, UnDados, Db, DBTables,
  Constantes, UnTeleMarketing, Grids, DBGrids, Menus, EditorImagem, FMTBcd,
  DBClient, SqlExpr;

type
  TFNovoTelemarketingProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    ValidaGravacao: TValidaGravacao;
    Ligacoes: TSQLQuery;
    PanelColor3: TPanelColor;
    Paginas: TPageControl;
    PLigacao: TTabSheet;
    PanelColor1: TPanelColor;
    Label12: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label16: TLabel;
    SpeedButton1: TSpeedButton;
    Label17: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    EObservacoes: TMemoColor;
    ENomContato: TEditColor;
    EHistorico: TEditLocaliza;
    EProximaLigacao: TCalendario;
    EProximaObservacao: TEditColor;
    EHoraProximaLigacao: TMaskEditColor;
    EDatAgendado: TEditColor;
    ETempoLigacao: TEditColor;
    CData: TCheckBox;
    PnProspect: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Bevel1: TBevel;
    ECodProspect: TEditColor;
    ENomProspect: TEditColor;
    EContato: TEditColor;
    EFone1: TEditColor;
    EFone2: TEditColor;
    CAceitaTeleMarketing: TCheckBox;
    EObsLigacaoProspect: TMemoColor;
    EDatUltimaLigacacao: TEditColor;
    EQtdLigacoesComProposta: TEditColor;
    PProspect: TTabSheet;
    PProdutos: TTabSheet;
    PPropostas: TTabSheet;
    PHistoricos: TTabSheet;
    EQtdLigacoesSemProposta: TEditColor;
    Label10: TLabel;
    ScrollBox1: TScrollBox;
    DataPROSPECT: TDataSource;
    PROSPECT: TSQL;
    PROSPECTCODPROSPECT: TFMTBCDField;
    PROSPECTNOMPROSPECT: TWideStringField;
    PROSPECTNOMFANTASIA: TWideStringField;
    PROSPECTTIPPESSOA: TWideStringField;
    PROSPECTDESENDERECO: TWideStringField;
    PROSPECTNUMENDERECO: TFMTBCDField;
    PROSPECTDESCOMPLEMENTO: TWideStringField;
    PROSPECTDESBAIRRO: TWideStringField;
    PROSPECTNUMCEP: TWideStringField;
    PROSPECTDESCIDADE: TWideStringField;
    PROSPECTDESUF: TWideStringField;
    PROSPECTDESFONE1: TWideStringField;
    PROSPECTDESSITE: TWideStringField;
    PROSPECTDESFONE2: TWideStringField;
    PROSPECTDESFAX: TWideStringField;
    PROSPECTDESCPF: TWideStringField;
    PROSPECTDESCNPJ: TWideStringField;
    PROSPECTDESRG: TWideStringField;
    PROSPECTDESINSCRICAO: TWideStringField;
    PROSPECTNOMCONTATO: TWideStringField;
    PROSPECTDESFONECONTATO: TWideStringField;
    PROSPECTDESEMAILCONTATO: TWideStringField;
    PROSPECTCODPROFISSAOCONTATO: TFMTBCDField;
    PROSPECTINDACEITASPAM: TWideStringField;
    PROSPECTCODCLIENTE: TFMTBCDField;
    PROSPECTCODRAMOATIVIDADE: TFMTBCDField;
    PROSPECTINDACEITATELEMARKETING: TWideStringField;
    PROSPECTDESOBSERVACOES: TWideStringField;
    PROSPECTCODUSUARIO: TFMTBCDField;
    PROSPECTDATCADASTRO: TSQLTimeStampField;
    PROSPECTCODMEIODIVULGACAO: TFMTBCDField;
    PROSPECTDATNASCIMENTO: TSQLTimeStampField;
    PROSPECTCODVENDEDOR: TFMTBCDField;
    PROSPECTQTDFUNCIONARIO: TFMTBCDField;
    PROSPECTINDCONTATOVENDEDOR: TWideStringField;
    Tempo: TTimer;
    PanelColor5: TPanelColor;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label64: TLabel;
    Label65: TLabel;
    SpeedButton5: TSpeedButton;
    Label66: TLabel;
    SpeedButton6: TSpeedButton;
    Label67: TLabel;
    Label68: TLabel;
    Bevel6: TBevel;
    Label69: TLabel;
    Label70: TLabel;
    SpeedButton7: TSpeedButton;
    Label71: TLabel;
    Label72: TLabel;
    SpeedButton8: TSpeedButton;
    Label73: TLabel;
    Bevel7: TBevel;
    Label74: TLabel;
    BAlteraProspect: TSpeedButton;
    PanelColor6: TPanelColor;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    DBEditColor4: TDBEditColor;
    DBEditCPF2: TDBEditCPF;
    DBEditColor6: TDBEditColor;
    DBEditColor8: TDBEditColor;
    DBEditColor9: TDBEditColor;
    DBEditColor10: TDBEditColor;
    DBEditColor11: TDBEditColor;
    DBEditColor12: TDBEditColor;
    DBEditColor14: TDBEditColor;
    DBEditColor15: TDBEditColor;
    DBEditColor16: TDBEditColor;
    DBEditColor17: TDBEditColor;
    DBKeyViolation1: TDBKeyViolation;
    DBEditColor18: TDBEditColor;
    DBEditColor19: TDBEditColor;
    DBRadioGroup1: TDBRadioGroup;
    DBEditLocaliza3: TDBEditLocaliza;
    DBEditUF2: TDBEditUF;
    DBEditPos23: TDBEditPos2;
    DBEditPos25: TDBEditPos2;
    DBEditPos26: TDBEditPos2;
    DBEditLocaliza4: TDBEditLocaliza;
    DBEditLocaliza5: TDBEditLocaliza;
    PainelCGC: TPanelColor;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    DBEditCGC2: TDBEditCGC;
    DBEditInsEstadual1: TDBEditInsEstadual;
    DBEditColor20: TDBEditColor;
    GProdutos: TGridIndice;
    PanelColor4: TPanelColor;
    BCadastrarProdutoCliente: TBitBtn;
    PRODUTOSPROSPECT: TSQL;
    DataPRODUTOSPROSPECT: TDataSource;
    PRODUTOSPROSPECTCODPRODUTO: TWideStringField;
    PRODUTOSPROSPECTC_NOM_PRO: TWideStringField;
    PRODUTOSPROSPECTC_COD_UNI: TWideStringField;
    PRODUTOSPROSPECTQTDPRODUTO: TFMTBCDField;
    PRODUTOSPROSPECTDATGARANTIA: TSQLTimeStampField;
    PRODUTOSPROSPECTQTDCOPIAS: TFMTBCDField;
    PRODUTOSPROSPECTNOMDONO: TWideStringField;
    PRODUTOSPROSPECTVALCONCORRENTE: TFMTBCDField;
    PRODUTOSPROSPECTNUMSERIE: TWideStringField;
    PRODUTOSPROSPECTNUMSERIEINTERNO: TWideStringField;
    PRODUTOSPROSPECTDESSETOR: TWideStringField;
    DBMemoColor1: TDBMemoColor;
    GHistorico: TGridIndice;
    HISTORICOLIGACOES: TSQL;
    DataHISTORICOLIGACOES: TDataSource;
    HISTORICOLIGACOESSEQTELE: TFMTBCDField;
    HISTORICOLIGACOESDATLIGACAO: TSQLTimeStampField;
    HISTORICOLIGACOESSEQPROPOSTA: TFMTBCDField;
    HISTORICOLIGACOESDESFALADOCOM: TWideStringField;
    HISTORICOLIGACOESDESOBSERVACAO: TWideStringField;
    HISTORICOLIGACOESDATTEMPOLIGACAO: TSQLTimeStampField;
    HISTORICOLIGACOESC_NOM_USU: TWideStringField;
    PageControl1: TPageControl;
    GPropostas: TGridIndice;
    PItens: TTabSheet;
    PAmostras: TTabSheet;
    PROPOSTAS: TSQL;
    DataPROPOSTAS: TDataSource;
    PROPOSTASCODFILIAL: TFMTBCDField;
    PROPOSTASSEQPROPOSTA: TFMTBCDField;
    PROPOSTASDATPROPOSTA: TSQLTimeStampField;
    PROPOSTASDATPREVISAOCOMPRA: TSQLTimeStampField;
    PROPOSTASINDCOMPROU: TWideStringField;
    PROPOSTASINDCOMPROUCONCORRENTE: TWideStringField;
    PROPOSTASVALTOTAL: TFMTBCDField;
    PROPOSTASC_NOM_PAG: TWideStringField;
    PROPOSTASNOMEST: TWideStringField;
    MovITENSPROPOSTA: TSQL;
    DataMovITENSPROPOSTA: TDataSource;
    GProdutosProposta: TGridIndice;
    GAmostraProposta: TGridIndice;
    MovAMOSTRAPROPOSTA: TSQL;
    DataMovAMOSTRAPROPOSTA: TDataSource;
    MovAMOSTRAPROPOSTANOMAMOSTRA: TWideStringField;
    MovAMOSTRAPROPOSTANOMCOR: TWideStringField;
    MovAMOSTRAPROPOSTAQTDAMOSTRA: TFMTBCDField;
    MovAMOSTRAPROPOSTAVALUNITARIO: TFMTBCDField;
    MovAMOSTRAPROPOSTAVALTOTAL: TFMTBCDField;
    MovITENSPROPOSTANOMPRODUTO: TWideStringField;
    MovITENSPROPOSTANOMCOR: TWideStringField;
    MovITENSPROPOSTADESUM: TWideStringField;
    MovITENSPROPOSTAQTDPRODUTO: TFMTBCDField;
    MovITENSPROPOSTAVALUNITARIO: TFMTBCDField;
    MovITENSPROPOSTAVALTOTAL: TFMTBCDField;
    MovITENSPROPOSTANUMOPCAO: TFMTBCDField;
    PContatos: TTabSheet;
    PanelColor7: TPanelColor;
    BContatos: TBitBtn;
    GContatos: TGridIndice;
    CONTATOS: TSQL;
    DataCONTATOS: TDataSource;
    CONTATOSNOMCONTATO: TWideStringField;
    CONTATOSDATNASCIMENTO: TSQLTimeStampField;
    CONTATOSDESTELEFONE: TWideStringField;
    CONTATOSDESEMAIL: TWideStringField;
    CONTATOSC_NOM_PRF: TWideStringField;
    CONTATOSINDACEITAEMARKETING: TWideStringField;
    PopupMenu1: TPopupMenu;
    Consultar1: TMenuItem;
    N1: TMenuItem;
    Alterar1: TMenuItem;
    PanelColor8: TPanelColor;
    Foto: TImage;
    MovAMOSTRAPROPOSTADESIMAGEM: TWideStringField;
    VisualizadorImagem1: TVisualizadorImagem;
    BProximo: TBitBtn;
    Aux: TSQL;
    Label5: TLabel;
    EConcorrente: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    HISTORICOLIGACOESDESHISTORICO: TWideStringField;
    N3: TMenuItem;
    NovaProposta1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure CDataClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure TempoTimer(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EHistoricoRetorno(Retorno1, Retorno2: String);
    procedure EHistoricoChange(Sender: TObject);
    procedure ENomContatoChange(Sender: TObject);
    procedure BCadastrarProdutoClienteClick(Sender: TObject);
    procedure PROPOSTASAfterScroll(DataSet: TDataSet);
    procedure PageControl1Change(Sender: TObject);
    procedure BContatosClick(Sender: TObject);
    procedure Consultar1Click(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure MovAMOSTRAPROPOSTAAfterScroll(DataSet: TDataSet);
    procedure FotoDblClick(Sender: TObject);
    procedure BProximoClick(Sender: TObject);
    procedure EHistoricoCadastrar(Sender: TObject);
  private
    VprAcao,
    VprIndAtivo : Boolean;
    VprDProspect: TRBDProspect;
    VprDTelemarketingProspect: TRBDTelemarketingProspect;
    VprOperacao : TRBDOperacaoCadastro;
    FunTeleMarketing: TRBFuncoesTeleMarketing;
    procedure PosProspect(VpaCodProspect: Integer);
    procedure PosProdutos(VpaCodProspect: Integer);
    procedure PosHistoricos(VpaCodProspect: Integer);
    procedure PosContatos(VpaCodProspect: Integer);
    procedure PosPropostas(VpaCodProspect: Integer);
    procedure PosItensProposta(VpaSeqProposta: Integer);
    procedure PosAmostrasProposta(VpaSeqProposta: Integer);
    procedure EstadoBotoes(VpaEstado: Boolean);
    procedure NovaLigacao;
    procedure CarDClasse;
    procedure ConfiguraTeleMarketingAtivo;
    procedure PosProspectTelemarketingAtivo;
    procedure CarDProspectTela(VpaCodProspect : Integer);
    procedure ExcluirProspectMailing;
    procedure ProximaLigacao;
  public
    function TeleMarketingProspect(VpaCodProspect : Integer):boolean;
    procedure EfetuaTeleMarketingAtivo;
  end;

var
  FNovoTelemarketingProspect: TFNovoTelemarketingProspect;

implementation
uses
  APrincipal, ANovoProspect, FunSQL, UnProspect, FunData, FunObjeto, ConstMsg,
  AProdutosProspect, AContatosProspect, ANovaProposta,
  AAlteraEstagioProposta, AHistoricoLigacao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoTelemarketingProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  VprDProspect:= TRBDProspect.Cria;
  VprDTelemarketingProspect:= TRBDTelemarketingProspect.Cria;
  FunTeleMarketing:= TRBFuncoesTeleMarketing.Cria(FPrincipal.BaseDados);
  Paginas.ActivePage:= PLigacao;
  if ConfigModulos.Amostra then
    PageControl1.ActivePage := PAmostras
  else
    PageControl1.ActivePage := PItens;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoTelemarketingProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunTeleMarketing.Free;
  VprDProspect.Free;
  VprDTelemarketingProspect.Free;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoTelemarketingProspect.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.SpeedButton2Click(Sender: TObject);
begin
  FNovoProspect:= TFNovoProspect.CriarSDI(Application,'',True);
  AdicionaSQLAbreTabela(FNovoProspect.Prospect,'SELECT * FROM PROSPECT '+
                                               ' WHERE CODPROSPECT = '+Ligacoes.FieldByName('CODPROSPECT').AsString);
  FNovoProspect.Prospect.Edit;
  FNovoProspect.ShowModal;

  CarDProspectTela(Ligacoes.FieldByName('CODPROSPECT').AsInteger);
  PosProspect(ECodProspect.AInteiro);
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.CarDProspectTela(VpaCodProspect: Integer);
begin
  FunProspect.CarDProspect(VprDProspect,VpaCodProspect);

  ECodProspect.Text:= IntToStr(VpaCodProspect);
  ENomProspect.Text:= VprDProspect.NomProspect;
  EContato.Text:= VprDProspect.NomContato;
  EFone1.Text:= VprDProspect.DesFone1;
  EFone2.Text:= VprDProspect.DesFone2;
  CAceitaTeleMarketing.Checked:= VprDProspect.IndAceitaTeleMarketing;
  EConcorrente.AInteiro:= VprDProspect.CodConcorrente;
  if EConcorrente.AInteiro <> 0 then
    EConcorrente.Atualiza;
  if VprDProspect.DatUltimaLigacao > MontaData(1,1,1990) then
    EDatUltimaLigacacao.Text:= FormatDateTime('DD/MM/YYYY HH:MM',VprDProspect.DatUltimaLigacao)
  else
    EDatUltimaLigacacao.Clear;
  EQtdLigacoesComProposta.AInteiro:= VprDProspect.QtdLigacaoComProposta;
  EQtdLigacoesSemProposta.AInteiro:= VprDProspect.QtdLigacaoSemProposta;
  EObsLigacaoProspect.Lines.Text:= VprDProspect.DesObservacaoTelemarketing;
  if (VprIndAtivo) then
    EDatAgendado.Text := FormatDateTime('DD/MM/YYYY HH:MM',Ligacoes.FieldByName('DATLIGACAO').AsDateTime)
//    else
//      EDatAgendado.Text := FormatDateTime('DD/MM/YYYY HH:MM',DatProximaLigacao);
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.ExcluirProspectMailing;
begin
  if VprIndAtivo then
  Begin
    if Ligacoes.FieldByName('SEQTAREFA').AsInteger <> 0 then
    begin
      if CData.Checked then
        ExecutaComandoSql(Aux,'UPDATE TAREFATELEMARKETINGPROSPECTITEM'+
                          ' Set DATLIGACAO = '+SQLTextoDataAAAAMMMDD(EProximaLigacao.DateTime)+
                          ' , INDREAGENDADO = ''S'''+
                          ' Where SEQTAREFA = '+Ligacoes.FieldByName('SEQTAREFA').AsString+
                          ' and CODUSUARIO = '+Inttostr(varia.CodigoUsuario)+
                          ' and CODPROSPECT = '+Ligacoes.FieldByName('CODPROSPECT').AsString)
      else
        ExecutaComandoSql(Aux,'DELETE FROM TAREFATELEMARKETINGPROSPECTITEM'+
                          ' Where CODUSUARIO = '+Inttostr(varia.CodigoUsuario)+
                          ' and CODPROSPECT = '+Ligacoes.FieldByName('CODPROSPECT').AsString);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.ProximaLigacao;
begin
  Ligacoes.Next;
  if Ligacoes.Eof then
    aviso('TELEMARKETING FINALIZADO!!!'#13'Não existe mais clientes agendados para serem ligados.')
  else
  begin
    NovaLigacao;
    CarDProspectTela(Ligacoes.FieldByName('CODPROSPECT').AsInteger);
  end;
end;

{******************************************************************************}
function TFNovoTelemarketingProspect.TeleMarketingProspect(VpaCodProspect: Integer):boolean;
begin
  AdicionaSQLAbreTabela(Ligacoes,'SELECT CODPROSPECT FROM PROSPECT ' +
                                 ' WHERE CODPROSPECT = '+IntToStr(VpaCodProspect));
  CarDProspectTela(VpaCodProspect);
  NovaLigacao;

  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.EfetuaTeleMarketingAtivo;
begin
  VprIndAtivo := true;
  ConfiguraTeleMarketingAtivo;
  PosProspectTelemarketingAtivo;
  NovaLigacao;
  CarDProspectTela(Ligacoes.FieldByName('CODPROSPECT').AsInteger);
  if Ligacoes.Eof then
    aviso('TELEMARKETING FINALIZADO!!!'#13'Não existe mais clientes agendados para serem ligados.');
  showmodal;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.PosProspect(VpaCodProspect: Integer);
begin
  AdicionaSQLAbreTabela(PROSPECT,'SELECT * FROM PROSPECT '+
                                 ' WHERE CODPROSPECT = '+IntToStr(VpaCodProspect));
  AtualizaLocalizas(PanelColor5);
  PainelCGC.Visible:= (PROSPECT.FieldByname('TIPPESSOA').AsString = 'J');
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.PosProdutos(VpaCodProspect: Integer);
begin
  PRODUTOSPROSPECT.SQL.Clear;
  PRODUTOSPROSPECT.SQL.Add('SELECT'+
                           ' PPR.CODPRODUTO, PRO.C_NOM_PRO,'+
                           ' PRO.C_COD_UNI, PPR.QTDPRODUTO,'+
                           ' PPR.DATGARANTIA, PPR.QTDCOPIAS, DNO.NOMDONO,'+
                           ' PPR.VALCONCORRENTE, PPR.NUMSERIE, PPR.NUMSERIEINTERNO,'+
                           ' PPR.DESSETOR'+
                           ' FROM PRODUTOPROSPECT PPR, CADPRODUTOS PRO, DONOPRODUTO DNO'+
                           ' WHERE'+
                           ' PPR.CODPRODUTO = PRO.C_COD_PRO'+
                           ' AND PPR.CODDONO *= DNO.CODDONO'+
                           ' AND PPR.CODPROSPECT = '+IntToStr(VpaCodProspect));
  PRODUTOSPROSPECT.SQL.Add(' ORDER BY PPR.CODPRODUTO');
  PRODUTOSPROSPECT.Open;
  GProdutos.ALinhaSQLOrderBy:= PRODUTOSPROSPECT.SQL.Count-1;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.PosHistoricos(
  VpaCodProspect: Integer);
begin
  HISTORICOLIGACOES.SQL.Clear;
  HISTORICOLIGACOES.SQL.Add('SELECT'+
                            ' TEL.SEQTELE, TEL.DATLIGACAO,TEL.SEQPROPOSTA,'+
                            ' TEL.DESFALADOCOM, TEL.DESOBSERVACAO, TEL.DATTEMPOLIGACAO,'+
                            ' USU.C_NOM_USU, TEL.DESOBSERVACAO, HIS.DESHISTORICO '+
                            ' FROM TELEMARKETINGPROSPECT TEL, CADUSUARIOS USU, HISTORICOLIGACAO HIS'+
                            ' WHERE'+
                            ' TEL.CODUSUARIO = USU.I_COD_USU'+
                            ' AND HIS.CODHISTORICO = TEL.CODHISTORICO '+
                            ' AND TEL.CODPROSPECT = '+IntToStr(VpaCodProspect));
  HISTORICOLIGACOES.SQL.Add(' ORDER BY TEL.DATLIGACAO DESC');
  HISTORICOLIGACOES.Open;
  GHistorico.ALinhaSQLOrderBy:= HISTORICOLIGACOES.SQL.Count-1;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.PosContatos(VpaCodProspect: Integer);
begin
  CONTATOS.SQL.Clear;
  CONTATOS.SQL.Add('SELECT'+
                   ' CPR.NOMCONTATO, CPR.DATNASCIMENTO, CPR.DESTELEFONE,'+
                   ' CPR.DESEMAIL, PRF.C_NOM_PRF, CPR.INDACEITAEMARKETING'+
                   ' FROM'+
                   ' CONTATOPROSPECT CPR, CADPROFISSOES PRF'+
                   ' WHERE'+
                   ' PRF.I_COD_PRF =* CPR.CODPROFISSAO'+
                   ' AND CPR.CODPROSPECT = '+IntToStr(VpaCodProspect));
  CONTATOS.SQL.Add(' ORDER BY CPR.NOMCONTATO');
  CONTATOS.Open;
  GContatos.ALinhaSQLOrderBy:= CONTATOS.SQL.Count-1;
end;


{******************************************************************************}
procedure TFNovoTelemarketingProspect.PosPropostas(VpaCodProspect: Integer);
begin
  PROPOSTAS.SQL.Clear;
  PROPOSTAS.SQL.Add('SELECT'+
                    ' PRO.CODFILIAL, PRO.SEQPROPOSTA, PRO.DATPROPOSTA, PRO.DATPREVISAOCOMPRA,'+
                    ' PRO.INDCOMPROU, PRO.INDCOMPROUCONCORRENTE, PRO.VALTOTAL,'+
                    ' CON.C_NOM_PAG, EST.NOMEST'+
                    ' FROM PROPOSTA PRO, CADCONDICOESPAGTO CON, ESTAGIOPRODUCAO EST'+
                    ' WHERE'+
                    ' PRO.CODCONDICAOPAGAMENTO = CON.I_COD_PAG'+
                    ' AND PRO.CODESTAGIO = EST.CODEST'+
                    ' AND PRO.CODPROSPECT = '+IntToStr(VpaCodProspect));
  PROPOSTAS.SQL.Add(' ORDER BY PRO.DATPROPOSTA DESC');
  PROPOSTAS.Open;
  GPropostas.ALinhaSQLOrderBy:= PROPOSTAS.SQL.Count-1;
  PosItensProposta(PROPOSTASSEQPROPOSTA.AsInteger);
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.PosAmostrasProposta(
  VpaSeqProposta: Integer);
begin
  MovAMOSTRAPROPOSTA.SQL.Clear;
  MovAMOSTRAPROPOSTA.SQL.Add('SELECT'+
                             ' APR.NOMAMOSTRA, APR.NOMCOR, APR.QTDAMOSTRA,'+
                             ' APR.VALUNITARIO, APR.VALTOTAL, '+
                             ' AMO.DESIMAGEM '+
                             ' FROM PROPOSTAAMOSTRA APR, AMOSTRA AMO'+
                             ' WHERE APR.SEQPROPOSTA = '+IntToStr(VpaSeqProposta)+
                             ' AND APR.CODAMOSTRA = AMO.CODAMOSTRA ');
  MovAMOSTRAPROPOSTA.SQL.Add(' ORDER BY APR.NOMAMOSTRA');
  MovAMOSTRAPROPOSTA.Open;
  GAmostraProposta.ALinhaSQLOrderBy:= MovAMOSTRAPROPOSTA.SQL.Count-1;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.PosItensProposta(
  VpaSeqProposta: Integer);
begin
  MovITENSPROPOSTA.SQL.Clear;
  MovITENSPROPOSTA.SQL.Add('SELECT'+
                           ' PPR.NOMPRODUTO, PPR.NOMCOR, PPR.DESUM,'+
                           ' PPR.QTDPRODUTO, PPR.VALUNITARIO, PPR.VALTOTAL, '+
                           ' PPR.NUMOPCAO '+
                           ' FROM PROPOSTAPRODUTO PPR'+
                           ' WHERE PPR.SEQPROPOSTA = '+IntToStr(VpaSeqProposta));
  MovITENSPROPOSTA.SQL.Add(' ORDER BY PPR.NUMOPCAO');
  MovITENSPROPOSTA.Open;
  GProdutosProposta.ALinhaSQLOrderBy:= MovITENSPROPOSTA.SQL.Count-1;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.EstadoBotoes(VpaEstado: Boolean);
begin
  BGravar.Enabled:= VpaEstado;
  BCancelar.Enabled:= VpaEstado;
  BFechar.Enabled:= not VpaEstado;
  BProximo.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PProspect then
    PosProspect(ECodProspect.AInteiro)
  else
    if Paginas.ActivePage = PProdutos then
      PosProdutos(VprDProspect.CodProspect)
    else
      if Paginas.ActivePage = PPropostas then
        PosPropostas(VprDProspect.CodProspect)
      else
        if Paginas.ActivePage = PHistoricos then
          PosHistoricos(VprDProspect.CodProspect)
        else
          if Paginas.ActivePage = PContatos then
            PosContatos(VprDProspect.CodProspect)
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.CDataClick(Sender: TObject);
begin
  EProximaLigacao.Enabled:= CData.Checked;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.BCancelarClick(Sender: TObject);
begin
  if Confirmacao('Tem certeza que deseja cancelar a ligação em processo?') then
  begin
    Tempo.Enabled:= False;
    LimpaComponentes(PanelColor1,0);
    EstadoBotoes(False);
    VprOperacao:= ocConsulta;
  end;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.TempoTimer(Sender: TObject);
begin
  Inc(VprDTelemarketingProspect.QtdSegundosLigacao);
  ETempoLigacao.Text:= FormatDateTime('HH:MM:SS',Now - VprDTelemarketingProspect.DatLigacao);
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.NovaLigacao;
begin
  EHistorico.Clear;
  ENomContato.Clear;
  EObservacoes.Clear;
  EProximaLigacao.DateTime:= Date;
  EProximaObservacao.Clear;
  CData.Checked:= False;
  CDataClick(CData);
  Paginas.ActivePageIndex:= 0;
  ActiveControl:= EHistorico;
  EstadoBotoes(True);
  ValidaGravacao.Execute;
  VprOperacao:= ocInsercao;
  VprDTelemarketingProspect.Free;
  VprDTelemarketingProspect:= TRBDTelemarketingProspect.Cria;
  VprDTelemarketingProspect.DatLigacao:= Now;
  VprDTelemarketingProspect.QtdSegundosLigacao:= 0;
  Tempo.Enabled:= True;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  CarDClasse;
  VpfResultado:= FunTeleMarketing.GravaDTeleMarketingProspect(VprDTeleMarketingProspect);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao:= True;
    ExcluirProspectMailing;
    EstadoBotoes(False);
    Tempo.Enabled:= False;
    VprOperacao:= ocConsulta;
  end;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.CarDClasse;
begin
  VprDTelemarketingProspect.CodProspect:= ECodProspect.AInteiro;
  VprDTelemarketingProspect.SeqTele := 0;
  VprDTelemarketingProspect.CodUsuario:= Varia.CodigoUsuario;
  VprDTelemarketingProspect.CodHistorico:= EHistorico.AInteiro;
  VprDTelemarketingProspect.DataTempoLigacao:= Now - VprDTelemarketingProspect.DatLigacao;
  VprDTelemarketingProspect.DesFaladoCom:= ENomContato.Text;
  VprDTelemarketingProspect.DesObservacao:= EObservacoes.Text;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.ConfiguraTeleMarketingAtivo;
begin
  ECodProspect.ReadOnly := true;
  ENomProspect.ReadOnly := true;
  ECodProspect.TabStop := false;
  ENomProspect.TabStop := false;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.PosProspectTelemarketingAtivo;
begin
  AdicionaSQLAbreTabela(Ligacoes,'Select TAR.SEQTAREFA,TAR.CODUSUARIO,TAR.SEQCAMPANHA,TAR.DATLIGACAO, PRC.CODPROSPECT '+
                                 ' FROM PROSPECT PRC, TAREFATELEMARKETINGPROSPECTITEM TAR '+
                                 ' Where PRC.CODPROSPECT = TAR.CODPROSPECT '+
                                 ' AND TAR.CODUSUARIO = '+IntToStr(Varia.CodigoUsuario)+
                                 ' order by TAR.DATLIGACAO, TAR.INDREAGENDADO DESC, PRC.NOMPROSPECT');
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.EHistoricoRetorno(Retorno1,
  Retorno2: String);
begin
  VprDTelemarketingProspect.IndAtendeu:= Retorno1 = 'S';
  if not VprDTelemarketingProspect.IndAtendeu then
    AlteraCampoObrigatorioDet([ENomContato],False)
  else
    AlteraCampoObrigatorioDet([ENomContato],True);
  if VprOperacao in [ocInsercao] then
    ValidaGravacao.Execute;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.EHistoricoChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao] then
    ValidaGravacao.Execute;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.ENomContatoChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao] then
    ValidaGravacao.Execute;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.BCadastrarProdutoClienteClick(
  Sender: TObject);
begin
  if VprDProspect.CodProspect <> 0 then
  begin
    FProdutosProspect:= TFProdutosProspect.CriarSDI(Self,'',True);
    FProdutosProspect.ActiveControl:= FProdutosProspect.Grade;
    FProdutosProspect.CadastraProdutos(VprDProspect.CodProspect);
    FProdutosProspect.Free;
    PosProdutos(VprDProspect.CodProspect);
  end;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.PROPOSTASAfterScroll(
  DataSet: TDataSet);
begin
  PageControl1Change(PageControl1);
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = PItens then
    PosItensProposta(PROPOSTASSEQPROPOSTA.AsInteger)
  else
    PosAmostrasProposta(PROPOSTASSEQPROPOSTA.AsInteger);
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.BContatosClick(Sender: TObject);
begin
  if VprDProspect.CodProspect <> 0 then
  begin
    FContatosProspect:= TFContatosProspect.CriarSDI(Application,'',True);
    FContatosProspect.CadastraContatos(VprDProspect.CodProspect);
    FContatosProspect.Free;
    PosContatos(VprDProspect.CodProspect);
  end;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.Consultar1Click(Sender: TObject);
begin
  if PropostasSEQPROPOSTA.AsInteger <> 0 then
  begin
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    FNovaProposta.ConsultaProposta(PropostasCODFILIAL.AsInteger,PropostasSEQPROPOSTA.AsInteger);
    FNovaProposta.free;
  end;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.Alterar1Click(Sender: TObject);
begin
  if PropostasSEQPROPOSTA.AsInteger <> 0 then
  begin
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    FNovaProposta.AlteraProposta(PropostasCODFILIAL.AsInteger,PropostasSEQPROPOSTA.AsInteger);
    FNovaProposta.free;
  end;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.MovAMOSTRAPROPOSTAAfterScroll(
  DataSet: TDataSet);
begin
  if MovAMOSTRAPROPOSTADESIMAGEM.AsString <> '' then
    Foto.Picture.LoadFromFile(varia.DriveFoto + MovAMOSTRAPROPOSTADESIMAGEM.AsString)
 else
    Foto.Picture := nil;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.FotoDblClick(Sender: TObject);
begin
  VisualizadorImagem1.execute(varia.DriveFoto + MovAMOSTRAPROPOSTADESIMAGEM.AsString);
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.BProximoClick(Sender: TObject);
begin
  ProximaLigacao;
end;

{******************************************************************************}
procedure TFNovoTelemarketingProspect.EHistoricoCadastrar(Sender: TObject);
begin
  FHistoricoLigacao := TFHistoricoLigacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FHistoricoLigacao'));
  FHistoricoLigacao.BotaoCadastrar1.click;
  FHistoricoLigacao.showmodal;
  FHistoricoLigacao.free;
  Localiza.AtualizaConsulta;
end;


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFNovoTelemarketingProspect]);
end.
