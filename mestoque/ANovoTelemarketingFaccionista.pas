unit ANovoTelemarketingFaccionista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, ComCtrls, Db,
  DBTables, Mask, DBCtrls, Tabela, numericos, Grids, DBGrids,
  DBKeyViolation, Localizacao, UnDados, Constantes, UnOrdemProducao, Menus,
  DBClient;

type
  TFNovoTelemarketingFaccionista = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BProximo: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Paginas: TPageControl;
    PLigacao: TTabSheet;
    Faccionistas: TSQL;
    DataFaccionistas: TDataSource;
    FaccionistasCODFACCIONISTA: TFMTBCDField;
    FaccionistasNOMFACCIONISTA: TWideStringField;
    FaccionistasNOMRESPONSAVEL: TWideStringField;
    FaccionistasTIPPESSOA: TWideStringField;
    FaccionistasDESCIDADE: TWideStringField;
    FaccionistasDESTELEFONE1: TWideStringField;
    FaccionistasDESTELEFONE2: TWideStringField;
    FaccionistasDESCELULAR: TWideStringField;
    FaccionistasQTDPESSOAS: TFMTBCDField;
    FaccionistasQTDDEVOLUCOES: TFMTBCDField;
    FaccionistasQTDPRODUTODEVOLVIDO: TFMTBCDField;
    FaccionistasQTDRENEGOCIACAO: TFMTBCDField;
    FaccionistasQTDLIGACAO: TFMTBCDField;
    PanelColor3: TPanelColor;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    DBEditColor5: TDBEditColor;
    DBEditColor6: TDBEditColor;
    DBEditColor7: TDBEditColor;
    DBEditColor8: TDBEditColor;
    DBEditColor9: TDBEditColor;
    DBEditColor10: TDBEditColor;
    DBEditColor11: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    DBEditColor12: TDBEditColor;
    DBEditColor13: TDBEditColor;
    PanelColor4: TPanelColor;
    FaccionistasQTDPRODUTO: TFMTBCDField;
    FaccionistasQTDFRACAO: TFMTBCDField;
    Label6: TLabel;
    DBEditColor14: TDBEditColor;
    DBEditColor15: TDBEditColor;
    Label8: TLabel;
    Label10: TLabel;
    EPerQtdDevolvida: Tnumerico;
    EPerProdutosDevolvidos: Tnumerico;
    Label14: TLabel;
    GridIndice1: TGridIndice;
    FracaoFaccionista: TSQL;
    FracaoFaccionistaDATCADASTRO: TSQLTimeStampField;
    FracaoFaccionistaDATRETORNO: TSQLTimeStampField;
    FracaoFaccionistaDATRENEGOCIADO: TSQLTimeStampField;
    FracaoFaccionistaQTDENVIADO: TFMTBCDField;
    FracaoFaccionistaDESUM: TWideStringField;
    FracaoFaccionistaQTDPRODUZIDO: TFMTBCDField;
    FracaoFaccionistaVALUNITARIO: TFMTBCDField;
    FracaoFaccionistaVALUNITARIOPOSTERIOR: TFMTBCDField;
    FracaoFaccionistaQTDLIGACAO: TFMTBCDField;
    FracaoFaccionistaQTDRENEGOCIACAO: TFMTBCDField;
    DataFracaoFaccionista: TDataSource;
    FracaoFaccionistaCODFILIAL: TFMTBCDField;
    FracaoFaccionistaSEQORDEM: TFMTBCDField;
    FracaoFaccionistaSEQFRACAO: TFMTBCDField;
    FracaoFaccionistaSEQESTAGIO: TFMTBCDField;
    FracaoFaccionistaC_NOM_PRO: TWideStringField;
    FracaoFaccionistaNOM_COR: TWideStringField;
    FracaoFaccionistaQTDDIAS: TFMTBCDField;
    FracaoFaccionistaDiasAtrasado: TFMTBCDField;
    Label18: TLabel;
    SpeedButton1: TSpeedButton;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    EHistorico: TEditLocaliza;
    CDatPromessa: TCheckBox;
    EDatPromessa: TCalendario;
    ENomContato: TEditColor;
    EObservacoes: TMemoColor;
    Label22: TLabel;
    Localiza: TConsultaPadrao;
    ETempoLigacao: TEditColor;
    Label28: TLabel;
    ValidaGravacao1: TValidaGravacao;
    Tempo: TTimer;
    Cadastro: TSQL;
    Aux: TSQL;
    FracaoFaccionistaSEQITEM: TFMTBCDField;
    PopupMenu1: TPopupMenu;
    VisualizaHistoricoLigaes1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BProximoClick(Sender: TObject);
    procedure FracaoFaccionistaCalcFields(DataSet: TDataSet);
    procedure EHistoricoSelect(Sender: TObject);
    procedure EHistoricoCadastrar(Sender: TObject);
    procedure EHistoricoRetorno(Retorno1, Retorno2: String);
    procedure EHistoricoChange(Sender: TObject);
    procedure CDatPromessaClick(Sender: TObject);
    procedure TempoTimer(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure VisualizaHistoricoLigaes1Click(Sender: TObject);
  private
    { Private declarations }
    VprIndAtivo : Boolean;
    VprDLigacao : TRBDTelemarketingFaccionista;
    VprOperacao : TRBDOperacaoCadastro;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    function RSeqTeleDisponivel(VpaCodFaccionista : Integer) : Integer;
    procedure PosFaccionistas;
    procedure PosFracoes(VpaCodFaccionita : Integer);
    procedure CalculaPercentuais;
    procedure CarDTela;
    procedure CarDClasse;
    function GravaDTelemarketing(VpaDLigacao : TRBDTelemarketingFaccionista) : String;
    function GravaDTelemarketinITEM(VpaDLigacao: TRBDTelemarketingFaccionista) : String;
    procedure proximaLigacao;
    procedure InicializaTela;
    procedure EstadoBotoes(VpaEstado : Boolean);
  public
    { Public declarations }
    procedure NovoTelemarketing;
  end;

var
  FNovoTelemarketingFaccionista: TFNovoTelemarketingFaccionista;

implementation

uses APrincipal, FunSql, FunData, Constmsg, AHistoricoLigacao, FunObjeto,
  ATelemarketingFaccionista;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoTelemarketingFaccionista.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDLigacao := TRBDTelemarketingFaccionista.cria;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoTelemarketingFaccionista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao.free;
  VprDLigacao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.NovoTelemarketing;
begin
  VprIndAtivo := true;
  PosFaccionistas;
  if Faccionistas.Eof then
    aviso('TELEMARKETING FACCIONISTA FINALIZADO!!!'#13'Não existe nenhum faccionista em atraso que ainda não tenha sido ligado.')
  else
  begin
    CarDTela;
    PosFracoes(FaccionistasCODFACCIONISTA.AsInteger);
  end;
  Showmodal;
end;


{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
function TFNovoTelemarketingFaccionista.RSeqTeleDisponivel(VpaCodFaccionista : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select max(SEQTELE) ULTIMO from TELEMARKETINGFACCIONISTACORPO '+
                            ' Where CODFACCIONISTA = ' +IntToStr(VpaCodFaccionista));
  result := Aux.FieldByname('ULTIMO').AsInteger+1;
  Aux.close;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.PosFaccionistas;
begin
  AdicionaSQLAbreTabela(Faccionistas,'select FAC.CODFACCIONISTA, FAC.NOMFACCIONISTA, FAC.NOMRESPONSAVEL, FAC.TIPPESSOA, '+
                                     ' FAC.DESCIDADE, FAC.DESTELEFONE1, FAC.DESTELEFONE2, FAC.DESCELULAR, '+
                                     ' FAC.QTDPESSOAS, FAC.QTDDEVOLUCOES, FAC.QTDPRODUTODEVOLVIDO, '+
                                     ' FAC.QTDRENEGOCIACAO, FAC.QTDLIGACAO, FAC.QTDPRODUTO, FAC.QTDFRACAO '+
                                     ' from FACCIONISTA FAC ' +
                                     ' Where EXISTS (SELECT * FROM FRACAOOPFACCIONISTA FRF ' +
                                     ' WHERE FRF.DATFINALIZACAO IS NULL ' +
                                     ' AND FRF.DATRENEGOCIADO <= '+SQLTextoDataAAAAMMMDD(incDia(date,1))+
                                     ' AND FRF.CODFACCIONISTA = FAC.CODFACCIONISTA)');

end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.PosFracoes(VpaCodFaccionita : Integer);
begin
  AdicionaSQLAbreTabela(FracaoFaccionista,'SELECT FRF.DATCADASTRO, FRF.DATRETORNO, FRF.DATRENEGOCIADO, FRF.QTDENVIADO, '+
                  ' FRF.DESUM, FRF.QTDPRODUZIDO, FRF.VALUNITARIO, FRF.VALUNITARIOPOSTERIOR, '+
                  ' FRF.QTDLIGACAO, FRF.QTDRENEGOCIACAO, FRF.CODFILIAL, '+
                  ' FRF.SEQORDEM, FRF.SEQFRACAO, FRF.SEQESTAGIO, FRF.SEQITEM,'+
                  ' PRO.C_NOM_PRO, COR.NOM_COR '+
                  ' FROM FRACAOOPFACCIONISTA FRF, ORDEMPRODUCAOCORPO ORD, COR, '+
                  ' CADPRODUTOS PRO '+
                  ' Where FRF.CODFILIAL = ORD.EMPFIL '+
                  ' and FRF.SEQORDEM  = ORD.SEQORD '+
                  ' and ORD.SEQPRO = PRO.I_SEQ_PRO '+
                  ' and '+SQLTextoRightJoin('ORD.CODCOM','COR.COD_COR')+
                  ' and FRF.CODFACCIONISTA = '+IntToStr(VpaCodFaccionita)+
                  ' and FRF.DATFINALIZACAO IS NULL'+
                  ' and FRF.DATRENEGOCIADO <= '+SQLTextoDataAAAAMMMDD(incdia(date,1)));
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.CalculaPercentuais;
begin
  if FaccionistasQTDFRACAO.AsInteger <> 0 then
  begin
    EPerQtdDevolvida.AValor := (FaccionistasQTDDEVOLUCOES.AsInteger * 100)/FaccionistasQTDFRACAO.AsInteger;
    EPerProdutosDevolvidos.AValor := (FaccionistasQTDPRODUTODEVOLVIDO.AsFloat * 100)/FaccionistasQTDPRODUTO.AsFloat;
  end
  else
  begin
    EPerQtdDevolvida.Clear;
    EPerProdutosDevolvidos.Clear;
  end;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.CarDTela;
begin
  CalculaPercentuais;
  InicializaTela;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.CarDClasse;
begin
  with VprDLigacao do
  begin
    CodFaccionista := FaccionistasCODFACCIONISTA.AsInteger;
    CodHistorico := EHistorico.AInteiro;
    DesFaladoCom := ENomContato.Text;
    DesObservacoes := EObservacoes.Lines.text;
    IndPrometeuData := CDatPromessa.Checked;
    DatPrometido := EDatPromessa.DateTime;
  end;
  Tempo.Enabled := false;
end;

{******************************************************************************}
function TFNovoTelemarketingFaccionista.GravaDTelemarketing(VpaDLigacao : TRBDTelemarketingFaccionista) : String;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TELEMARKETINGFACCIONISTACORPO');
  Cadastro.insert;
  Cadastro.FieldByname('CODFACCIONISTA').AsInteger := VpaDLigacao.CodFaccionista;
  Cadastro.FieldByname('CODUSUARIO').AsInteger := VpaDLigacao.CodUsuario;
  Cadastro.FieldByname('DATLIGACAO').AsDateTime := VpaDLigacao.DatLigacao;
  Cadastro.FieldByname('DESFALADOCOM').AsString := VpaDLigacao.DesFaladoCom;
  if VprDLigacao.IndPrometeuData then
  begin
    Cadastro.FieldByname('DATPROMETIDO').AsDateTime := VpaDLigacao.DatPrometido;
    Cadastro.FieldByname('INDPROMETIDO').AsString := 'S';
  end
  else
    Cadastro.FieldByname('INDPROMETIDO').AsString := 'N';
  Cadastro.FieldByname('DESOBSERVACAO').AsString := VpaDLigacao.DesObservacoes;
  Cadastro.FieldByname('CODHISTORICO').AsInteger := VpaDLigacao.CodHistorico;
  Cadastro.FieldByname('QTDSEGUNDOSLIGACAO').AsInteger := VpaDLigacao.QtdSegundosLigacao;
  VprDLigacao.SeqTele := RSeqTeleDisponivel(VprDLigacao.CodFaccionista);
  Cadastro.FieldByname('SEQTELE').AsInteger := VpaDLigacao.SeqTele;
  try
    Cadastro.Post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO TELEMARKETINGFACCIONISTACORPO!!!'#13+e.message;
  end;
  if result = '' then
    result := GravaDTelemarketinITEM(VprDLigacao);

  if result = '' then
    result := FunOrdemProducao.AtualizaQtdRenegociacoesFaccionista(VpaDLigacao.CodFaccionista,VpaDLigacao.IndPrometeuData);  
end;

{******************************************************************************}
function TFNovoTelemarketingFaccionista.GravaDTelemarketinITEM(VpaDLigacao: TRBDTelemarketingFaccionista) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from TELEMARKETINGFACCIONISTAITEM');
  FracaoFaccionista.first;
  while not FracaoFaccionista.eof do
  begin
    Cadastro.insert;
    Cadastro.FieldByname('CODFACCIONISTA').AsInteger := VpaDLigacao.CodFaccionista;
    Cadastro.FieldByname('SEQTELE').AsInteger := VpaDLigacao.SeqTele;
    Cadastro.FieldByname('SEQITEM').AsInteger := FracaoFaccionistaSEQITEM.AsInteger;
    try
      Cadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DO TELEMARKETINGFACCIONISTAITEM!!!'#13+e.message;
        exit;
      end;
    end;
    Result := FunOrdemProducao.AlteraDataRenegociacaoFracaoFaccionista(VpaDLigacao.CodFaccionista,FracaoFaccionistaSEQITEM.AsInteger,CDatPromessa.Checked, EDatPromessa.DateTime);
    if result <> '' then
      exit;
    FracaoFaccionista.next;
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.BCancelarClick(Sender: TObject);
begin
  VprOperacao := ocConsulta;
  Tempo.Enabled :=false;
  EstadoBotoes(false);
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.proximaLigacao;
begin
  Faccionistas.Next;
  if Faccionistas.Eof then
    aviso('TELEMARKETING FINALIZADO!!!'#13'Não existem mais faccionistas para serem ligados.')
  else
  begin
    CarDTela;
    PosFracoes(FaccionistasCODFACCIONISTA.AsInteger);
  end;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.InicializaTela;
begin
  VprDLigacao.free;
  VprDLigacao := TRBDTelemarketingFaccionista.cria;
  EHistorico.clear;
  EHistorico.atualiza;
  CDatPromessa.Checked := false;
  EDatPromessa.DateTime := date+1;
  ENomContato.Clear;
  EObservacoes.clear;
  VprOperacao := ocInsercao;

  VprDLigacao.CodUsuario := varia.CodigoUsuario;
  VprDLigacao.DatLigacao := now;
  VprDLigacao.QtdSegundosLigacao := 0;
  Tempo.Enabled := true;

  EstadoBotoes(true);
  ValidaGravacao1.execute;
  ActiveControl := EHistorico;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.EstadoBotoes(VpaEstado : Boolean);
begin
  BProximo.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.BProximoClick(Sender: TObject);
begin
  proximaLigacao;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.FracaoFaccionistaCalcFields(
  DataSet: TDataSet);
begin
  FracaoFaccionistaQTDDIAS.AsInteger := DiasPorPeriodo(FracaoFaccionistaDATCADASTRO.AsDateTime,date);
  FracaoFaccionistaDiasAtrasado.AsInteger := DiasPorPeriodo(FracaoFaccionistaDATRETORNO.AsDateTime,date);
end;

procedure TFNovoTelemarketingFaccionista.EHistoricoSelect(Sender: TObject);
var
  VpfTipoTelemarketing : String;
begin
  if VprIndAtivo then
    VpfTipoTelemarketing := ' AND DESTIPOLIGACAO = ''A'''
  ELSE
    VpfTipoTelemarketing := ' AND DESTIPOLIGACAO = ''R''';
  EHistorico.ASelectValida.Text := 'Select * from HISTORICOLIGACAO Where CODHISTORICO = @ AND INDATIVO = ''S'' '+VpfTipoTelemarketing;
  EHistorico.ASelectLocaliza.Text := 'Select * from HISTORICOLIGACAO Where DESHISTORICO like ''@%'' AND INDATIVO = ''S'' '+VpfTipoTelemarketing;
end;

procedure TFNovoTelemarketingFaccionista.EHistoricoCadastrar(
  Sender: TObject);
begin
  FHistoricoLigacao := TFHistoricoLigacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FHistoricoLigacao'));
  FHistoricoLigacao.BotaoCadastrar1.Click;
  FHistoricoLigacao.ShowModal;
  FHistoricoLigacao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.EHistoricoRetorno(Retorno1,
  Retorno2: String);
begin
  VprDLigacao.IndAtendeu := Retorno1 = 'S';
  if not VprDLigacao.IndAtendeu then
  begin
    AlteraCampoObrigatorioDet([ENomContato],false);
  end
  else
  begin
    AlteraCampoObrigatorioDet([ENomContato],true);
  end;
  CDatPromessa.Checked := VprDLigacao.IndAtendeu;
  if VprOperacao in [ocinsercao] then
    ValidaGravacao1.execute;
end;

procedure TFNovoTelemarketingFaccionista.EHistoricoChange(Sender: TObject);
begin
  if VprOperacao in [ocinsercao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.CDatPromessaClick(
  Sender: TObject);
begin
  EDatPromessa.Enabled := CDatPromessa.Checked;
end;

procedure TFNovoTelemarketingFaccionista.TempoTimer(Sender: TObject);
begin
  inc(VprDLigacao.QtdSegundosLigacao);
  ETempoLigacao.Text := FormatDateTime('HH:MM:SS',now - VprDLigacao.DatLigacao);
end;

procedure TFNovoTelemarketingFaccionista.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if VprOperacao = ocInsercao then
  begin
    CarDClasse;
    VpfResultado := GravaDTelemarketing(VprDLigacao);
    if VpfResultado = '' then
    begin
      EstadoBotoes(false);
      VprOperacao := ocConsulta;
    end
    else
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFNovoTelemarketingFaccionista.VisualizaHistoricoLigaes1Click(
  Sender: TObject);
begin
  if FracaoFaccionistaCODFILIAL.AsInteger <> 0 then
  begin
    FTelemarketingFaccionista := tFTelemarketingFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTelemarketingFaccionista'));
    FTelemarketingFaccionista.VisualizaLigacoesFracaoFaccionista(FaccionistasCODFACCIONISTA.AsInteger,FracaoFaccionistaCODFILIAL.AsInteger,FracaoFaccionistaSEQORDEM.AsInteger,
                               FracaoFaccionistaSEQFRACAO.AsInteger,FracaoFaccionistaSEQESTAGIO.AsInteger);
    FTelemarketingFaccionista.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoTelemarketingFaccionista]);
end.
