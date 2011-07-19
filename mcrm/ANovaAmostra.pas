unit ANovaAmostra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Tabela,
  CBancoDados, ComCtrls, BotaoCadastro, StdCtrls, Buttons, DBKeyViolation,
  Mask, DBCtrls, Localizacao, UnAmostra, EditorImagem, UnDadosProduto, UnClassificacao,
  DBClient, FunSql, Grids, DBGrids, Constantes;

type
  TFNovaAmostra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Amostra: TRBSQL;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    PanelColor1: TPanelColor;
    Paginas: TPageControl;
    PAmostra: TTabSheet;
    AmostraCODAMOSTRA: TFMTBCDField;
    AmostraNOMAMOSTRA: TWideStringField;
    AmostraDATAMOSTRA: TSQLTimeStampField;
    AmostraDATENTREGA: TSQLTimeStampField;
    AmostraDATENTREGACLIENTE: TSQLTimeStampField;
    AmostraCODCOLECAO: TFMTBCDField;
    AmostraCODDESENVOLVEDOR: TFMTBCDField;
    AmostraCODPROSPECT: TFMTBCDField;
    AmostraDESIMAGEM: TWideStringField;
    AmostraDESIMAGEMCLIENTE: TWideStringField;
    AmostraINDCOPIA: TWideStringField;
    AmostraVALCUSTO: TFMTBCDField;
    AmostraVALVENDA: TFMTBCDField;
    Label1: TLabel;
    DataAmostra: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    EDatEntrega: TDBEditColor;
    DBEditColor4: TDBEditColor;
    SpeedButton1: TSpeedButton;
    AmostraDATAPROVACAO: TSQLTimeStampField;
    AmostraCODVENDEDOR: TFMTBCDField;
    EColecao: TDBEditLocaliza;
    EDesenvolvedor: TDBEditLocaliza;
    Localiza: TConsultaPadrao;
    Label14: TLabel;
    SpeedButton2: TSpeedButton;
    Label15: TLabel;
    SpeedButton3: TSpeedButton;
    ECliente: TDBEditLocaliza;
    Label16: TLabel;
    EVendedor: TDBEditLocaliza;
    Label17: TLabel;
    SpeedButton4: TSpeedButton;
    Label18: TLabel;
    DBEditColor5: TDBEditColor;
    DBEditColor6: TDBEditColor;
    Label11: TLabel;
    DBEditColor7: TDBEditColor;
    DBEditColor8: TDBEditColor;
    EDatAprovacao: TDBEditColor;
    Label12: TLabel;
    ValidaGravacao1: TValidaGravacao;
    AmostraTIPAMOSTRA: TWideStringField;
    ETipoAmostra: TDBRadioGroup;
    Label19: TLabel;
    SpeedButton5: TSpeedButton;
    Label20: TLabel;
    EAmostraIndefinida: TDBEditLocaliza;
    AmostraCODAMOSTRAINDEFINIDA: TFMTBCDField;
    BCadastrar: TBitBtn;
    AmostraDESOBSERVACAO: TWideStringField;
    DBMemoColor1: TDBMemoColor;
    Label21: TLabel;
    BConcluir: TBitBtn;
    AmostraQTDAMOSTRA: TFMTBCDField;
    AmostraCODPRODUTO: TWideStringField;
    AmostraQTDPREVISAOCOMPRA: TFMTBCDField;
    DBEditColor3: TDBEditColor;
    Label22: TLabel;
    DBEditColor9: TDBEditColor;
    Label23: TLabel;
    BFoto: TBitBtn;
    BitBtn1: TBitBtn;
    EditorImagem1: TEditorImagem;
    BConsumo: TBitBtn;
    AmostraINDALTERACAO: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    AmostraCODCLIENTE: TFMTBCDField;
    Label24: TLabel;
    AmostraDESDEPARTAMENTO: TWideStringField;
    Label25: TLabel;
    SpeedButton15: TSpeedButton;
    LNomClassificacao: TLabel;
    ECodClassificacao: TDBEditColor;
    AmostraCODCLASSIFICACAO: TWideStringField;
    AmostraCODDEPARTAMENTOAMOSTRA: TFMTBCDField;
    DBEditLocaliza5: TDBEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label27: TLabel;
    PanelColor3: TPanelColor;
    AmostraCODEMPRESA: TFMTBCDField;
    AmostraDESTIPOCLASSIFICACAO: TWideStringField;
    AmostraDATFICHAAMOSTRA: TSQLTimeStampField;
    AmostraINDAMOSTRAREALIZADA: TWideStringField;
    Aux: TSQL;
    AmostraDATFICHA: TSQLTimeStampField;
    AmostraDATPRECO: TSQLTimeStampField;
    AmostraDATALTERADOENTREGA: TSQLTimeStampField;
    PLog: TTabSheet;
    PanelColor4: TPanelColor;
    GridIndice1: TGridIndice;
    AmostraLog: TSQL;
    AmostraLogCODAMOSTRA: TFMTBCDField;
    AmostraLogSEQLOG: TFMTBCDField;
    AmostraLogCODUSUARIO: TFMTBCDField;
    AmostraLogDESLOCALARQUIVO: TWideStringField;
    AmostraLogC_NOM_USU: TWideStringField;
    Label26: TLabel;
    DBEditColor10: TDBEditColor;
    AmostraQTDTOTALPONTOSBORDADO: TFMTBCDField;
    AmostraQTDCORTES: TFMTBCDField;
    AmostraQTDTROCALINHA: TFMTBCDField;
    AmostraDESSOLVENDEDOR: TWideStringField;
    Label28: TLabel;
    EPrecoEstimado: TDBEditColor;
    Label29: TLabel;
    AmostraINDPRECOESTIMADO: TWideStringField;
    PMotivoAtraso: TTabSheet;
    DataAMOSTRACORMOTIVOATRASO: TDataSource;
    AMOSTRACORMOTIVOATRASO: TSQL;
    AMOSTRACORMOTIVOATRASOCODAMOSTRA: TFMTBCDField;
    AMOSTRACORMOTIVOATRASOCODCOR: TFMTBCDField;
    AMOSTRACORMOTIVOATRASOSEQITEM: TFMTBCDField;
    AMOSTRACORMOTIVOATRASOCODMOTIVOATRASO: TFMTBCDField;
    AMOSTRACORMOTIVOATRASODESOBSERVACAO: TWideStringField;
    AMOSTRACORMOTIVOATRASODESMOTIVOATRASO: TWideStringField;
    AMOSTRACORMOTIVOATRASOC_NOM_USU: TWideStringField;
    GradeMotivoAtraso: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure AmostraAfterInsert(DataSet: TDataSet);
    procedure ECodigoChange(Sender: TObject);
    procedure EDesenvolvedorCadastrar(Sender: TObject);
    procedure EColecaoCadastrar(Sender: TObject);
    procedure EClienteCadastrar(Sender: TObject);
    procedure AmostraAfterEdit(DataSet: TDataSet);
    procedure AmostraAfterScroll(DataSet: TDataSet);
    procedure BCadastrarClick(Sender: TObject);
    procedure AmostraAfterPost(DataSet: TDataSet);
    procedure AmostraAfterCancel(DataSet: TDataSet);
    procedure BConcluirClick(Sender: TObject);
    procedure BFotoClick(Sender: TObject);
    procedure BConsumoClick(Sender: TObject);
    procedure ETipoAmostraChange(Sender: TObject);
    procedure ECodClassifcacaoExit(Sender: TObject);
    procedure ECodClassifcacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton15Click(Sender: TObject);
    procedure AmostraBeforePost(DataSet: TDataSet);
    procedure EClienteRetorno(Retorno1, Retorno2: string);
    procedure BotaoGravar1DepoisAtividade(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure EPrecoEstimadoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    VprAcao : Boolean;
    FunAmostra : TRBFuncoesAmostra;
    VprDAmostra: TRBDAmostra;
    FunClassificacao : TFuncoesClassificacao;
    procedure EstadoBotoes(VpaEstado : Boolean);
    function LocalizaClassificacao : boolean;
    procedure CarNomeImagemPadrao(VpaNomClassificacao : String);
    procedure ConfiguraPermissaoUsuario;
    procedure PosLogAmostra(VpaCodAmostra : Integer);
    procedure PosMotivoAtraso(VpaCodAmostra: Integer);
  public
    { Public declarations }
    procedure NovaAmostra(VpaCodRequisicaoAmostra : Integer);
    procedure DuplicaAmostra(VpaCodAmostra: Integer);
  end;

var
  FNovaAmostra: TFNovaAmostra;

implementation

uses APrincipal, AAmostras, ADesenvolvedor, AColecao, ANovoProspect, FunObjeto, FunArquivos,
  Constmsg, AAmostraConsumo, ALocalizaClassificacao, FunData, Funstring;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaAmostra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ConfiguraPermissaoUsuario;
  EditorImagem1.DirServidor := varia.DriveFoto;
  Amostra.open;
  VprAcao := false;
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  FunClassificacao := TFuncoesClassificacao.criar(self,FPrincipal.BaseDados);
  VprDAmostra:= TRBDAmostra.cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaAmostra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra.free;
  FunClassificacao.free;
  VprDAmostra.Free;
  if Amostra.State in [dsedit,dsinsert] then
    Amostra.cancel;
  Amostra.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFNovaAmostra.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaAmostra.AmostraAfterInsert(DataSet: TDataSet);
begin
  activecontrol := ECodClassificacao;
  ECodigo.ProximoCodigo;
  AmostraINDCOPIA.AsString := 'N';
  AmostraINDALTERACAO.AsString := 'N';
  AmostraTIPAMOSTRA.AsString := 'D';
  AmostraDESDEPARTAMENTO.AsString := 'D';
  AmostraDATAMOSTRA.AsDateTime := now;
  AmostraCODEMPRESA.AsInteger := varia.CodigoEmpresa;
  if Varia.CodDesenvolvedor <> 0 then
    AmostraCODDESENVOLVEDOR.AsInteger := Varia.CodDesenvolvedor;
  if Varia.CodColecao <> 0 then
    AmostraCODCOLECAO.AsInteger := Varia.CodColecao;
  if varia.CodDepartamento <> 0 then
    AmostraCODDEPARTAMENTOAMOSTRA.AsInteger := VARIA.CodDepartamento;
  AmostraDESTIPOCLASSIFICACAO.AsString := 'P';
  AmostraINDAMOSTRAREALIZADA.AsString := 'N';
  EDatEntrega.ReadOnly := true;
  EDatAprovacao.readonly := true;
  EstadoBotoes(false);
end;

{******************************************************************************}
procedure TFNovaAmostra.ECodigoChange(Sender: TObject);
begin
  if Amostra.State in [dsedit,dsinsert] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaAmostra.EDesenvolvedorCadastrar(Sender: TObject);
begin
  FDesenvolvedor := TFDesenvolvedor.CriarSDI(self,'',FPrincipal.VerificaPermisao('FDesenvolvedor'));
  FDesenvolvedor.BotaoCadastrar1.click;
  FDesenvolvedor.showmodal;
  Localiza.AtualizaConsulta;
  FDesenvolvedor.free;
end;

{******************************************************************************}
procedure TFNovaAmostra.EPrecoEstimadoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['s','S','n','N',#8]) then
    key := #0
  else
  if key = 's' Then
    key := 'S'
  else
    if key = 'n' Then
     key := 'N';
end;

{******************************************************************************}
procedure TFNovaAmostra.EColecaoCadastrar(Sender: TObject);
begin
  FColecao := TFColecao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FColecao'));
  FColecao.BotaoCadastrar1.Click;
  FColecao.ShowModal;
  FColecao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaAmostra.EClienteCadastrar(Sender: TObject);
begin
  FNovoProspect := tFNovoProspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProspect'));
  FNovoProspect.Prospect.Insert;
  FNovoProspect.ShowModal;
  FNovoProspect.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaAmostra.EClienteRetorno(Retorno1, Retorno2: string);
begin
  if Retorno1 <> '' then
  begin
    AmostraCODVENDEDOR.AsString := Retorno1;
    EVendedor.Atualiza;
  end;
end;

{******************************************************************************}
procedure TFNovaAmostra.AmostraAfterEdit(DataSet: TDataSet);
begin
  EstadoBotoes(false);
  BConsumo.Enabled := true;
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFNovaAmostra.AmostraAfterScroll(DataSet: TDataSet);
begin
  AtualizaLocalizas(PanelColor1);
  ECodClassifcacaoExit(ECodClassificacao);
end;

procedure TFNovaAmostra.AmostraBeforePost(DataSet: TDataSet);
begin
  if Amostra.State = dsinsert then
  begin
    if config.CodigoAmostraGeradoPelaClassificacao then
    begin
      AmostraCODAMOSTRA.AsInteger := FunAmostra.RCodAmostraDisponivel(AmostraCODCLASSIFICACAO.AsString);
      CarNomeImagemPadrao(LNomClassificacao.Caption);
    end
    else
      ECodigo.VerificaCodigoUtilizado;
      if (AmostraTIPAMOSTRA.AsString = 'D') and (Config.ConcluirAmostraSeForFichaTecnica)  then
      begin
        if AmostraCODDEPARTAMENTOAMOSTRA.AsInteger = Config.CodDepartamentoFichaTecnica then
          AmostraDATFICHAAMOSTRA.AsDateTime := now;
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaAmostra.BCadastrarClick(Sender: TObject);
begin
  Amostra.Close;
  Amostra.Open;
  Amostra.insert;
end;

{******************************************************************************}
procedure TFNovaAmostra.AmostraAfterPost(DataSet: TDataSet);
var
  VpfResultado : String;
begin
  EstadoBotoes(true);
  VpfResultado := FunAmostra.GravaAmostraLog(Amostra.FieldByName('CODAMOSTRA').AsInteger);
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovaAmostra.AmostraAfterCancel(DataSet: TDataSet);
begin
  BCadastrar.enabled := true;
end;

{******************************************************************************}
procedure TFNovaAmostra.EstadoBotoes(VpaEstado : Boolean);
begin
  BCadastrar.Enabled := VpaEstado;
  BConsumo.Enabled := VpaEstado;
  if Config.CampoPrecoEstimadoObrigatorioNaAmostra then
    EPrecoEstimado.ACampoObrigatorio:= true;
end;

{******************************************************************************}
function TFNovaAmostra.LocalizaClassificacao : boolean;
var
  VpfCodClassificacao, VpfNomClassificacao : string;
begin
  result := true;
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomClassificacao, 'P') then
  begin
    if Amostra.State in [dsedit,dsinsert] then
      AmostraCODCLASSIFICACAO.AsString := VpfCodClassificacao;
    LNomClassificacao.Caption := VpfNomClassificacao;
    if (Amostra.State = dsinsert) and (config.CodigoAmostraGeradoPelaClassificacao) then
      AmostraCODAMOSTRA.AsInteger := FunAmostra.RCodAmostraDisponivel(AmostraCODCLASSIFICACAO.AsString);
  end
  else
    result := false;
end;

{******************************************************************************}
procedure TFNovaAmostra.NovaAmostra(VpaCodRequisicaoAmostra : Integer);
var
  VpfDAmostra : TRBDAmostra;
begin
  VpfDAmostra := TRBDAmostra.cria;
  FunAmostra.CarDAmostra(VpfDAmostra,VpaCodRequisicaoAmostra);
  Amostra.Insert;
  AmostraCODDEPARTAMENTOAMOSTRA.AsInteger := VpfDAmostra.CodDepartamento;
  AmostraDATENTREGACLIENTE.AsDateTime := VpfDAmostra.DatEntregaCliente;
  AmostraCODDESENVOLVEDOR.AsInteger := VpfDAmostra.CodDesenvolvedor;
  EDesenvolvedor.Atualiza;
  AmostraCODCLIENTE.AsInteger := VpfDAmostra.CodProspect;
  ECliente.Atualiza;
  AmostraCODVENDEDOR.AsInteger := VpfDAmostra.CodVendedor;
  EVendedor.Atualiza;
  AmostraCODAMOSTRAINDEFINIDA.AsInteger := VpaCodRequisicaoAmostra;
  EAmostraIndefinida.Atualiza;
  AmostraCODCOLECAO.AsInteger := VpfDAmostra.CodColecao;
  EColecao.Atualiza;
  AmostraINDPRECOESTIMADO.AsString:= VpfDAmostra.IndPossuiPrecoEstimado;
  VpfDAmostra.free;
  ShowModal;
end;

{******************************************************************************}
procedure TFNovaAmostra.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PLog then
  begin
    if not AmostraLog.Active then
      PosLogAmostra(AmostraCODAMOSTRA.AsInteger);
  end;
  if Paginas.ActivePage = PMotivoAtraso then
  begin
    if not AMOSTRACORMOTIVOATRASO.Active then
      PosMotivoAtraso(AmostraCODAMOSTRA.AsInteger);
  end;
end;

{******************************************************************************}
procedure TFNovaAmostra.PosLogAmostra(VpaCodAmostra: Integer);
begin
  AdicionaSQLAbreTabela(AmostraLog,'Select LOG.CODAMOSTRA, LOG.SEQLOG, LOG.CODUSUARIO, LOG.DESLOCALARQUIVO, '+
                                   ' USU.C_NOM_USU '+
                                   ' From AMOSTRALOG LOG, CADUSUARIOS USU '+
                                   ' WHERE LOG.CODUSUARIO = USU.I_COD_USU ' +
                                   ' and LOG.CODAMOSTRA = '+IntToStr(VpaCodAmostra)+
                                   ' ORDER BY SEQLOG');
end;

{******************************************************************************}
procedure TFNovaAmostra.PosMotivoAtraso(VpaCodAmostra: Integer);
begin
  AdicionaSQLAbreTabela(AMOSTRACORMOTIVOATRASO,'SELECT MOT.CODAMOSTRA, MOT.CODCOR, MOT.SEQITEM, MOT.CODMOTIVOATRASO, MOT.DESOBSERVACAO, ' +
                                   ' ATR.DESMOTIVOATRASO, ' +
                                   ' USU.C_NOM_USU ' +
                                   ' FROM AMOSTRACORMOTIVOATRASO MOT, MOTIVOATRASO ATR, CADUSUARIOS USU ' +
                                   ' WHERE MOT.CODMOTIVOATRASO = ATR.CODMOTIVOATRASO ' +
                                   ' AND MOT.CODUSUARIO = USU.I_COD_USU ' +
                                   ' AND MOT.CODAMOSTRA = ' + IntToStr(VpaCodAmostra) +
                                   ' ORDER BY MOT.SEQITEM' );
end;

{******************************************************************************}
procedure TFNovaAmostra.CarNomeImagemPadrao(VpaNomClassificacao: String);
begin
  if (varia.CNPJFilial = CNPJ_VENETO)  then
  begin
    AmostraDESIMAGEM.AsString := DeletaEspaco(CopiaAteChar(VpaNomClassificacao,'-'))+'\'+AmostraCODAMOSTRA.AsString +'A.BMP';
  end;
end;

{******************************************************************************}
procedure TFNovaAmostra.ConfiguraPermissaoUsuario;
begin
  AlterarVisibleDet([BConcluir],(puCRConcluirAmostra in varia.PermissoesUsuario));
end;

{******************************************************************************}
procedure TFNovaAmostra.DuplicaAmostra(VpaCodAmostra: Integer);
var
  VpfLaco: Integer;
begin
  AdicionaSQLAbreTabela(Aux, ' SELECT * FROM AMOSTRA                          ' +
                             ' WHERE CODAMOSTRA =      '+IntToStr(VpaCodAmostra));
  Amostra.Insert;
  for VpfLaco := 0 to Amostra.FieldCount - 1 do
    Amostra.FieldByName(Amostra.Fields[VpfLaco].FieldName).Value := Aux.FieldByName(Amostra.Fields[VpfLaco].FieldName).Value;
  AmostraAfterInsert(Amostra);
  AmostraDATFICHA.Clear;
  AmostraDATENTREGA.Clear;
  AmostraDATAPROVACAO.Clear;
  AmostraDATFICHAAMOSTRA.Clear;
  AmostraDESIMAGEM.Clear;
  AmostraDATPRECO.Clear;
  ShowModal;
end;

{******************************************************************************}
procedure TFNovaAmostra.BConcluirClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfREsultado := FunAmostra.ConcluirFichaAmostra(AmostraCODAMOSTRA.AsInteger);
  if VpfREsultado <> '' then
    aviso(VpfREsultado);

end;

{******************************************************************************}
procedure TFNovaAmostra.BFotoClick(Sender: TObject);
Var
  VpfNomArquivo : string;
begin
  if Amostra.State in [ dsInsert, dsedit] then
  begin
    if ExisteArquivo(varia.DriveFoto + AmostraDESIMAGEM.AsString) then
    VpfNomArquivo := varia.DriveFoto + AmostraDESIMAGEM.AsString
  else
    VpfNomArquivo := varia.DriveFoto;

     if editorImagem1.execute(VpfNomArquivo) then
        AmostraDESIMAGEM.asstring := EditorImagem1.PathImagem;
  end;

end;

procedure TFNovaAmostra.BotaoGravar1DepoisAtividade(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFNovaAmostra.BConsumoClick(Sender: TObject);
begin
  VprDAmostra.Free;
  VprDAmostra := TRBDAmostra.cria;
  FunAmostra.CarDAmostra(VprDAmostra,AmostraCODAMOSTRA.AsInteger);
  FAmostraConsumo := TFAmostraConsumo.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAmostraConsumo'));
  FAmostraConsumo.ConsumosAmostra(VprDAmostra);
  FAmostraConsumo.free;
end;

{******************************************************************************}
procedure TFNovaAmostra.ETipoAmostraChange(Sender: TObject);
begin
  if Amostra.State in [dsedit,dsinsert] then
  begin
    if ETipoAmostra.ItemIndex = 0 then
    begin
      EAmostraIndefinida.ACampoObrigatorio := true;
      BConcluir.Enabled := true;
    end
    else
    begin
      BConcluir.Enabled := false;
      EAmostraIndefinida.ACampoObrigatorio := false;
      if AmostraCODDESENVOLVEDOR.AsInteger = 0  then
      begin
        AmostraCODDESENVOLVEDOR.AsInteger := varia.CodDesenvolvedorRequisicaoAmostra;
        EDesenvolvedor.Atualiza;
      end;
      if (varia.QtdDiasUteisEntregaAmostra <> 0) and AmostraDATENTREGACLIENTE.IsNull  then
      begin
        AmostraDATENTREGACLIENTE.AsDateTime := IncDia(Date,Varia.QtdDiasUteisEntregaAmostra);
        while QdadeDiasUteis(date,AmostraDATENTREGACLIENTE.AsDateTime) < varia.QtdDiasUteisEntregaAmostra do
          AmostraDATENTREGACLIENTE.AsDateTime := IncDia(AmostraDATENTREGACLIENTE.AsDateTime,1);

      end;

    end;
    ValidaGravacao1.execute;
  end;
end;

{******************************************************************************}
procedure TFNovaAmostra.ECodClassifcacaoExit(Sender: TObject);
var
  VpfNomClassificacao : String;
begin
  if Amostra.State in [dsedit,dsinsert] then
  begin
    if AmostraCODCLASSIFICACAO.AsString <> '' then
    begin
      if not FunClassificacao.ValidaClassificacao(AmostraCODCLASSIFICACAO.AsString,VpfNomClassificacao, 'P') then
      begin
         if not LocalizaClassificacao then
           ECodClassificacao.SetFocus;
      end
      else
        LNomClassificacao.Caption := VpfNomClassificacao;
      if (Amostra.State = dsinsert) and config.CodigoAmostraGeradoPelaClassificacao then
        AmostraCODAMOSTRA.AsInteger := FunAmostra.RCodAmostraDisponivel(AmostraCODCLASSIFICACAO.AsString);
    end
    else
      LNomClassificacao.Caption := '';
  end;
end;

{******************************************************************************}
procedure TFNovaAmostra.ECodClassifcacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFNovaAmostra.SpeedButton15Click(Sender: TObject);
begin
  LocalizaClassificacao;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaAmostra]);
end.
