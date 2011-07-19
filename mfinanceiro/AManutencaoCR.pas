unit AManutencaoCR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Localizacao, Db, DBTables, ComCtrls, Componentes1, ExtCtrls,
  PainelGradiente, Mask, UnContasAReceber, numericos, UnDadosCR, FMTBcd,
  SqlExpr, DBClient;

type
  TFManutencaoCR = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    MovContasAReceber: TSQL;
    DataMovContasaReceber: TDataSource;
    Localiza: TConsultaPadrao;
    PanelFecha: TPanelColor;
    BFecha: TBitBtn;
    CadContaaReceber: TSQL;
    DataCadContaaReceber: TDataSource;
    BExclui: TBitBtn;
    MovContasAReceberI_EMP_FIL: TFMTBCDField;
    MovContasAReceberI_LAN_REC: TFMTBCDField;
    MovContasAReceberI_NRO_PAR: TFMTBCDField;
    MovContasAReceberI_COD_FRM: TFMTBCDField;
    MovContasAReceberD_DAT_VEN: TSQLTimeStampField;
    MovContasAReceberD_DAT_PAG: TSQLTimeStampField;
    MovContasAReceberN_VLR_PAR: TFMTBCDField;
    MovContasAReceberN_VLR_DES: TFMTBCDField;
    MovContasAReceberN_VLR_ACR: TFMTBCDField;
    MovContasAReceberN_TOT_PAR: TFMTBCDField;
    MovContasAReceberN_VLR_PAG: TFMTBCDField;
    MovContasAReceberN_PER_MOR: TFMTBCDField;
    MovContasAReceberN_PER_JUR: TFMTBCDField;
    MovContasAReceberN_PER_MUL: TFMTBCDField;
    MovContasAReceberN_PER_COR: TFMTBCDField;
    MovContasAReceberC_NRO_DOC: TWideStringField;
    MovContasAReceberI_COD_USU: TFMTBCDField;
    MovContasAReceberI_COD_BAN: TFMTBCDField;
    MovContasAReceberC_NRO_DUP: TWideStringField;
    MovContasAReceberN_DES_VEN: TFMTBCDField;
    MovContasAReceberC_FLA_PAR: TWideStringField;
    MovContasAReceberL_OBS_REC: TWideStringField;
    MovContasAReceberI_PAR_FIL: TFMTBCDField;
    MovContasAReceberI_PAR_MAE: TFMTBCDField;
    MovContasAReceberI_DIA_CAR: TFMTBCDField;
    MovContasAReceberN_PER_ACR: TFMTBCDField;
    MovContasAReceberN_PER_DES: TFMTBCDField;
    MovContasAReceberI_FIL_PAG: TFMTBCDField;
    Aux: TSQLQuery;
    BEstornar: TBitBtn;
    tempo: TPainelTempo;
    MovContasAReceberC_NRO_CON: TWideStringField;
    BExcuiTitulo: TBitBtn;
    CadContaaReceberI_LAN_REC: TFMTBCDField;
    CadContaaReceberI_COD_PAG: TFMTBCDField;
    CadContaaReceberI_EMP_FIL: TFMTBCDField;
    CadContaaReceberI_COD_CLI: TFMTBCDField;
    CadContaaReceberD_DAT_MOV: TSQLTimeStampField;
    CadContaaReceberN_VLR_TOT: TFMTBCDField;
    CadContaaReceberI_QTD_PAR: TFMTBCDField;
    CadContaaReceberI_NRO_NOT: TFMTBCDField;
    CadContaaReceberD_DAT_EMI: TSQLTimeStampField;
    CadContaaReceberI_COD_USU: TFMTBCDField;
    CadContaaReceberI_ULT_DUP: TFMTBCDField;
    CadContaaReceberI_SEQ_NOT: TFMTBCDField;
    CadContaaReceberC_CLA_PLA: TWideStringField;
    CadContaaReceberI_COD_EMP: TFMTBCDField;
    BPagamento: TBitBtn;
    MovContasAReceberC_DUP_DES: TWideStringField;
    BAtleraFormaPagamento: TBitBtn;
    PanelColor1: TPanelColor;
    PanelColor4: TPanelColor;
    DBMemoColor1: TDBMemoColor;
    GradeMov: TGridIndice;
    PanelFiltro: TPanelColor;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Label7: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    ECliente: TDBEditLocaliza;
    EPlano: TDBEditNumerico;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    PanelPor: TPanelColor;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label18: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    ENota: TEditLocaliza;
    EDuplicata: TEditLocaliza;
    EOrdem: TEditLocaliza;
    MovContasAReceberD_PRO_LIG: TSQLTimeStampField;
    MovContasAReceberC_IND_RET: TWideStringField;
    MovContasAReceberC_FUN_PER: TWideStringField;
    MovContasAReceberC_BAI_CAR: TWideStringField;
    BEstornaDesconto: TBitBtn;
    MovContasAReceberD_DAT_PRO: TSQLTimeStampField;
    MovContasAReceberI_COD_CLI: TFMTBCDField;
    BEstornaFundoPerdido: TBitBtn;
    BEstornaCobrancaExterna: TBitBtn;
    MovContasAReceberC_COB_EXT: TWideStringField;
    CadContaaReceberC_POS_SIN: TWideStringField;
    BConsultaAdiantamento: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDuplicataSelect(Sender: TObject);
    procedure EDuplicataRetorno(Retorno1, Retorno2: String);
    procedure ENotaSelect(Sender: TObject);
    procedure ENotaRetorno(Retorno1, Retorno2: String);
    procedure BFechaClick(Sender: TObject);
    procedure BExcluiClick(Sender: TObject);
    procedure MovContasAReceberAfterPost(DataSet: TDataSet);
    procedure CadContaaReceberAfterInsert(DataSet: TDataSet);
    procedure MovContasAReceberAfterScroll(DataSet: TDataSet);
    procedure BEstornarClick(Sender: TObject);
    procedure MovContasAReceberBeforeInsert(DataSet: TDataSet);
    procedure BExcuiTituloClick(Sender: TObject);
    procedure EOrdemSelect(Sender: TObject);
    procedure EOrdemRetorno(Retorno1, Retorno2: String);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMovExit(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure CamposExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMovEditButtonClick(Sender: TObject);
    procedure MovContasAReceberAfterEdit(DataSet: TDataSet);
    procedure GradeMovKeyPress(Sender: TObject; var Key: Char);
    procedure BAtleraFormaPagamentoClick(Sender: TObject);
    procedure MovContasAReceberBeforePost(DataSet: TDataSet);
    procedure MovContasAReceberD_DAT_VENChange(Sender: TField);
    procedure BEstornaDescontoClick(Sender: TObject);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure BEstornaFundoPerdidoClick(Sender: TObject);
    procedure BEstornaCobrancaExternaClick(Sender: TObject);
    procedure CadContaaReceberAfterScroll(DataSet: TDataSet);
    procedure BConsultaAdiantamentoClick(Sender: TObject);
  private
    VprDataVencimentoInicio : TDateTime;
    VprTransacao : TTransactionDesc;
    procedure InicializaTela(VpaCodFilial,VpaLanReceber : Integer);
    procedure GravaAlteracoes;
    procedure AbreTransacao;
    procedure CommitTransacao;
    procedure RollbackTransacao;
    procedure AlteraFormaPagto;
  public
    procedure AlteraContasaReceber(VpaCodFilial,VpaLanReceber : Integer);
  end;

var
  FManutencaoCR: TFManutencaoCR;

implementation

{$R *.DFM}

uses
     constantes, fundata, funstring, funsql, APrincipal, ConstMsg,
  APlanoConta, FunObjeto,
  AMostraParReceberOO, ABaixaContasAReceberOO, AContasAReceber;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        formulario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ****************** Na criação do Formulário ******************************** }
procedure TFManutencaoCR.FormCreate(Sender: TObject);
begin
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFManutencaoCR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RollbackTransacao;
  CadContaaReceber.close;
  MovContasAReceber.Close;
  Action := CaFree;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      processos dos  botoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ******************* exclui uma conta *************************************** }
procedure TFManutencaoCR.BExcluiClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if MovContasAReceberI_EMP_FIL.AsInteger <> 0 then
    if Confirmacao(CT_ExcluiConta) then
    begin
       AbreTransacao;
        VpfResultado := FunContasAreceber.ExcluiConta( CadContaaReceber.FieldByname('I_EMP_FIL').AsInteger, CadContaaReceber.fieldByName('i_lan_rec').AsInteger,true,true);
        if VpfResultado <> '' then
        begin
          RollbackTransacao;
          aviso(VpfResultado)
        end
        else
        begin
           CommitTransacao;
           AtualizaSQLTabela(CadContaaReceber);
           AtualizaSQLTabela(MovContasAReceber);
        end;
    end;
end;

{ ******************* exclui um titulo *************************************** }
procedure TFManutencaoCR.BExcuiTituloClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if Confirmacao(CT_ExcluiTitulos) then
  begin
      VpfResultado := FunContasAreceber.ExcluiTitulo(MovContasAReceber.FieldByname('I_EMP_FIL').AsInteger,MovContasAReceber.fieldByName('I_LAN_REC').AsInteger, MovContasAReceber.fieldByName('I_NRO_PAR').AsInteger);
      if VpfResultado = ''  then
      begin
        AtualizaSQLTabela(CadContaaReceber);
        AtualizaSQLTabela(MovContasAReceber);
      end
      else
      begin
        aviso(VpfResultado);
      end;
   end;
end;

{*************** estorna titulo pago ************************************** }
procedure TFManutencaoCR.BEstornarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if Confirmacao(CT_EstornarTitulo) then
  begin
    AbreTransacao;
    Tempo.Execute('Estornando Baixa ... ');
    VpfResultado := FunContasAreceber.EstornaParcela(CadContaaReceberI_COD_CLI.AsInteger, MovContasAReceberI_EMP_FIL.AsInteger, MovContasAReceberI_LAN_REC.AsInteger, MovContasAReceberI_NRO_PAR.AsInteger,
                      MovContasAReceberI_PAR_FIL.AsInteger,true);
    if VpfResultado <> '' then
    begin
      RollbackTransacao;
      aviso('ESTORNO CANCELADO!!!'#13#13+VpfREsultado);
    end
    else
    begin
      AtualizaSQLTabela(MovContasAReceber);
      CommitTransacao;
    end;
    Tempo.Fecha;
  end;
end;

{************** pagamento de um titulo ************************************** }
procedure TFManutencaoCR.BPagamentoClick(Sender: TObject);
var
  VpfDBaixaCR : TRBDBaixaCR;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  if MovContasAReceberI_EMP_FIL.AsInteger <> 0 then
  begin
    VpfDBaixaCR := TRBDBaixaCR.Cria;
    VpfDParcela := VpfDBaixaCR.AddParcela;
    FunContasAReceber.CarDParcelaBaixa(VpfDParcela,MovContasAReceberI_EMP_FIL.AsInteger,MovContasAReceberI_LAN_REC.AsInteger,MovContasAReceberI_NRO_PAR.AsInteger);
    FBaixaContasaReceberOO := TFBaixaContasaReceberOO.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBaixaContasaReceberOO'));
    if FBaixaContasaReceberOO.BaixarContasAReceber(VpfDBaixaCR) then
    begin
      AtualizaSQLTabela(CadContaaReceber);
      AtualizaSQLTabela(MovContasAreceber);
    end;
    FBaixaContasaReceberOO.free;
    VpfDBaixaCR.free;
  end;
end;

{******************* fecha formulario *************************************** }
procedure TFManutencaoCR.BFechaClick(Sender: TObject);
begin
  GravaAlteracoes;
  close;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      localiza conta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{******************************************************************************}
procedure TFManutencaoCR.AlteraContasaReceber(VpaCodFilial,VpaLanReceber : Integer);
begin
  InicializaTela(VpaCodFilial,VpaLanReceber);
  showmodal;
end;

{******************************************************************************}
procedure TFManutencaoCR.EDuplicataSelect(Sender: TObject);
begin
  EDuplicata.ASelectLocaliza.Clear;
  EDuplicata.ASelectLocaliza.Add('select * from MovContasaReceber as MCR key join CadContasaReceber as CCR, CadClientes as Cli where ' +
                                    ' MCR.i_emp_fil =  ' + InttoStr(varia.CodigoEmpFil) +
                                    ' and CCR.i_cod_cli = Cli.i_cod_cli ' +
                                    ' and  MCR.c_nro_dup like ''@%''');
  EDuplicata.ASelectValida.Clear;
  EDuplicata.ASelectValida.Add('select * from MovContasaReceber as MCR key join CadContasaReceber as CCR, CadClientes as Cli where ' +
                                  ' MCR.i_emp_fil =  ' + InttoStr(varia.CodigoEmpFil) +
                                  ' and CCR.i_cod_cli = Cli.i_cod_cli ' +
                                  ' and  MCR.c_nro_dup = ''@''');
end;

{******************************************************************************}
procedure TFManutencaoCR.EDuplicataRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    InicializaTela(StrToInt(retorno1),StrToInt(RETORNO2));
  ENota.Clear;
  EOrdem.Clear;
end;

{******************************************************************************}
procedure TFManutencaoCR.ENotaSelect(Sender: TObject);
begin
  ENota.ASelectValida.Clear;
  ENota.ASelectValida.Add(' select CLI.C_NOM_CLI, CLI.C_NOM_CLI, '+
                          ' CR.I_EMP_FIL, CR.I_LAN_REC, CR.I_NRO_NOT '+
                          ' from CADCONTASARECEBER CR, CADCLIENTES CLI '+
                          ' where CR.I_COD_CLI = CLI.I_COD_CLI ' +
                          ' and CR.I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                          ' and CR.I_NRO_NOT = @');
  ENota.ASelectLocaliza.Clear;
  ENota.ASelectLocaliza.Add(' select CLI.C_NOM_CLI, CLI.C_NOM_CLI, '+
                          ' CR.I_EMP_FIL, CR.I_LAN_REC, CR.I_NRO_NOT '+
                           ' from CADCONTASARECEBER CR, CADCLIENTES CLI '+
                           ' where CR.I_COD_CLI = CLI.I_COD_CLI ' +
                           ' and CR.I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                           ' and CR.I_NRO_NOT like ''@%''' +
                           ' and not CR.I_NRO_NOT is null ');
end;

{******************************************************************************}
procedure TFManutencaoCR.ENotaRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    InicializaTela(StrToInt(retorno1),StrToInt(RETORNO2));
  EDuplicata.Clear;
  EOrdem.Clear;
end;

{******************************************************************************}
procedure TFManutencaoCR.EOrdemSelect(Sender: TObject);
begin
  EOrdem.ASelectValida.Clear;
  EOrdem.ASelectValida.Add(' Select CR.I_EMP_FIL, CR.I_LAN_REC, C.C_NOM_CLI, CR.I_NRO_NOT ' +
                           ' from   CadContasAReceber CR, CadClientes C' +
                           ' where  CR.I_COD_CLI = C.I_COD_CLI ' +
                           ' and    CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                           ' and    CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                           ' and    CR.I_LAN_REC = @ ' +
                           ' ORDER BY I_LAN_REC ');
  EOrdem.ASelectLocaliza.Clear;
  EOrdem.ASelectLocaliza.Add(' Select CR.I_EMP_FIL, CR.I_LAN_REC, C.C_NOM_CLI, CR.I_NRO_NOT ' +
                             ' from   CadContasAReceber as CR, CadClientes  C ' +
                             ' where  CR.I_COD_CLI = C.I_COD_CLI ' +
                             ' and    CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                             ' and    CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                             ' and    C.C_NOM_CLI like ''@%'' ' +
                             ' ORDER BY I_LAN_REC ');

end;

{******************************************************************************}
procedure TFManutencaoCR.EOrdemRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    InicializaTela(StrToInt(retorno1),StrToInt(RETORNO2));
  ENota.Clear;
  EDuplicata.Clear;
end;

procedure TFManutencaoCR.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'C', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
  if (CadContaaReceber.State in [dsInsert, dsEdit]) then
    CadContaaReceber.Post;
  if CadContaaReceber.Active then
    CadContaaReceber.Edit;
end;

procedure TFManutencaoCR.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    BPlano.Click;
end;

procedure TFManutencaoCR.CamposExit(Sender: TObject);
begin
  if (CadContaaReceber.State in [dsInsert, dsEdit]) then
    CadContaaReceber.Post;
  if CadContaaReceber.Active then
  CadContaaReceber.Edit;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      acoes das tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFManutencaoCR.MovContasAReceberAfterEdit(DataSet: TDataSet);
begin
  VprDataVencimentoInicio := MovContasAReceberD_DAT_VEN.AsDateTime;
end;

{******************************************************************************}
procedure TFManutencaoCR.MovContasAReceberAfterPost(DataSet: TDataSet);
begin
  if VprDataVencimentoInicio <> MovContasAReceberD_DAT_VEN.AsDateTime then
     FunContasAReceber.atualizaVencimentoComissao(MovContasAReceberI_EMP_FIL.AsInteger,MovContasAReceberI_LAN_REC.AsInteger, MovContasAReceberI_NRO_PAR.AsInteger, MovContasAReceberD_DAT_VEN.AsDateTime);
  FunContasAreceber.AtualizaValorTotal(MovContasAReceber.FieldByname('I_EMP_FIL').AsInteger, MovContasAReceber.fieldByName('i_lan_rec').AsInteger);
  AtualizaSQLTabela(CadContaaReceber);
end;

procedure TFManutencaoCR.CadContaaReceberAfterInsert(DataSet: TDataSet);
begin
  CadContaaReceber.Cancel;
end;

{******************************************************************************}
procedure TFManutencaoCR.CadContaaReceberAfterScroll(DataSet: TDataSet);
begin
  BConsultaAdiantamento.Visible := CadContaaReceberC_POS_SIN.AsString = 'S';
end;

{******************************************************************************}
procedure TFManutencaoCR.MovContasAReceberAfterScroll(DataSet: TDataSet);
begin
  BExclui.Enabled :=(MovContasAReceberN_VLR_PAG.AsFloat = 0 ) and (MovContasAReceberI_NRO_PAR.AsInteger <> 0);
  BExcuiTitulo.Enabled := (MovContasAReceberN_VLR_PAG.AsFloat = 0 )and (MovContasAReceberI_NRO_PAR.AsInteger <> 0);
  BEstornar.Enabled := (MovContasAReceberD_DAT_PAG.AsFloat <> 0);
  BEstornaDesconto.Enabled := (MovContasAReceberC_DUP_DES.AsString = 'S');
  BEstornaCobrancaExterna.Enabled := (MovContasAReceberC_COB_EXT.AsString = 'S');
  BEstornaFundoPerdido.Enabled := (MovContasAReceberC_FUN_PER.AsString = 'S');
  BPagamento.Enabled := (MovContasAReceberD_DAT_PAG.AsFloat = 0 ) and (MovContasAReceberI_NRO_PAR.AsInteger <> 0);
  GradeMov.ReadOnly := MovContasAReceberN_VLR_PAG.AsFloat <> 0;
  BAtleraFormaPagamento.Enabled := BPagamento.Enabled;
end;

{******************************************************************************}
procedure TFManutencaoCR.MovContasAReceberBeforeInsert(DataSet: TDataSet);
var
  VpfValparcelaemAberto : Double;
  VpfResultado : string;
begin
  if not confirmacao('Tem certeza que deseja adicionar uma nova parcela ?') then
    abort;

  VpfValparcelaemAberto := FunContasAReceber.RValorParcelaEmAberto(MovContasAReceberI_EMP_FIL.AsInteger,MovContasAReceberI_LAN_REC.AsInteger);
  if VpfValparcelaemAberto = 0  then
  begin
    aviso('CONTAS A RECEBER BAIXADO!!!'#13'Para adicionar uma nova parcela é necessário ter no mínimo 1 parcela em aberto.');
    abort;
  end;
  VpfResultado := FunContasAReceber.DuplicaParcelaemAberto(MovContasAReceberI_EMP_FIL.AsInteger,MovContasAReceberI_LAN_REC.AsInteger);
  if VpfResultado = '' then
    VpfResultado := FunContasAReceber.DivideValoresParcelasEmAberto(VpfValparcelaemAberto,MovContasAReceberI_EMP_FIL.AsInteger,MovContasAReceberI_LAN_REC.AsInteger);
  if VpfResultado <> '' then
    aviso(VpfResultado);
  FunContasAReceber.LocalizaParcelasComParciais(MovContasAReceber,MovContasAReceberI_EMP_FIL.AsInteger,MovContasAReceberI_LAN_REC.AsInteger);
  abort;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }


procedure TFManutencaoCR.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 115) and (CadContaAReceber.Active) then // F4.
  begin
    if PossuiFoco(PanelPor) then
      ECliente.SetFocus
    else
      if PossuiFoco(PanelFiltro) then
        GradeMov.SetFocus
      else
        if PossuiFoco(GradeMov) then
          BExclui.SetFocus
        else
          EOrdem.SetFocus;
  end
  else
    if Key = 116 then // F5.
    begin
      ENota.Clear;
      EDuplicata.Clear;
      EOrdem.Clear;
      if CadContaaReceber.State in [ dsEdit, dsInsert ] then
        CadContaaReceber.post;
      if MovContasAReceber.State in [ dsEdit, dsInsert ] then
        MovContasAReceber.post;
      FechaTabela(CadContaAReceber);
      FechaTabela(MovContasAReceber);
      case Varia.ConsultaPor of
        'O' : EOrdem.SetFocus;
        'D' : EDuplicata.SetFocus;
        'N' : ENota.SetFocus;
      end;
    end
    else
    if Key = 117 then // F6.
      AlteraFormaPagto;
end;

procedure TFManutencaoCR.GradeMovExit(Sender: TObject);
begin
  if (MovContasaReceber.State = dsEdit) then
     MovContasaReceber.Post;
end;

procedure TFManutencaoCR.GradeMovEditButtonClick(Sender: TObject);
begin
  if GradeMov.SelectedIndex = 3 then
    AlteraFormaPagto;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            transacoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{******************************************************************************}
procedure TFManutencaoCR.InicializaTela(VpaCodFilial,VpaLanReceber : Integer);
begin
  FunContasAReceber.LocalizaContaCR(CadContaaReceber,VpaCodFilial,VpaLanReceber);
  FunContasAReceber.LocalizaParcelasComParciais(MovContasaReceber,VpaCodFilial,VpaLanReceber);
  ECliente.Atualiza;
  EPlanoExit(self);
end;

{******************************************************************************}
procedure TFManutencaoCR.GravaAlteracoes;
begin
  IF CadContaaReceber.state = dsedit then
    CadContaaReceber.Post;
  if MovContasAReceber.State = dsedit then
    MovContasAReceber.post;
end;

{******************************************************************************}
procedure TFManutencaoCR.AbreTransacao;
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);

  if not FPrincipal.BaseDados.InTransaction then
  begin
    VprTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VprTransacao);
  end;
end;

{******************************************************************************}
procedure TFManutencaoCR.CommitTransacao;
begin
 if FPrincipal.BaseDados.InTransaction then
   FPrincipal.BaseDados.Commit(VprTransacao);
end;

{******************************************************************************}
procedure TFManutencaoCR.RollbackTransacao;
begin
 if FPrincipal.BaseDados.InTransaction then
   FPrincipal.BaseDados.Rollback(VprTransacao);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        altera forma pagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{**************** altera a forma de pagamento ****************************** }
procedure TFManutencaoCR.AlteraFormaPagto;
var
  vpfDContasCR : TRBDContasCR;
  VpfResultado : string;
begin
  if not CadContaaReceber.eof then
  begin
    if (MovContasARecebern_vlr_pag.AsCurrency = 0) then
    begin
      vpfDContasCR := TRBDContasCR.cria;
      FunContasAReceber.CarDContasReceberParcela(CadContaaReceberI_EMP_FIL.AsString,CadContaaReceberI_LAN_REC.AsString,
                                                 MovContasAReceberI_NRO_PAR.AsString,vpfDContasCR);
      FMostraParReceberOO := TFMostraParReceberOO.CriarSDI(application , '', FPrincipal.VerificaPermisao('FMostraParReceberOO'));
      if FMostraParReceberOO.AlteraFormaPagamento(vpfDContasCR) then
      begin
        vpfresultado := FunContasAReceber.GravaDParcelaCR(vpfDContasCR,TRBDMovContasCR(vpfDContasCR.Parcelas.Items[0]));
        if VpfResultado <> '' then
          aviso(VpfResultado)
        else
          AtualizaSQLTabela(MovContasAReceber);
      end;
      FMostraParReceberOO.free;
      vpfDContasCR.free;
    end
    else
      Aviso(CT_ContaPagaCancelada);
  end;
end;

{******************************************************************************}
procedure TFManutencaoCR.GradeMovKeyPress(Sender: TObject; var Key: Char);
begin
  if key = '.' then
    key := ',';
end;

{******************************************************************************}
procedure TFManutencaoCR.BAtleraFormaPagamentoClick(Sender: TObject);
begin
  AlteraFormaPagto;
end;

procedure TFManutencaoCR.BConsultaAdiantamentoClick(Sender: TObject);
begin
  FContasaReceber := TFContasaReceber.criarSDI(Application,'',FPrincipal.VerificaPermisao('FContasaReceber'));
  FContasaReceber.ConsultaAdiantamento(CadContaaReceberI_EMP_FIL.AsInteger,CadContaaReceberI_LAN_REC.AsInteger);
  FContasaReceber.free;
end;

{******************************************************************************}
procedure TFManutencaoCR.MovContasAReceberBeforePost(DataSet: TDataSet);
begin
  if (MovContasAReceberD_PRO_LIG.AsDateTime < MovContasAReceberD_DAT_VEN.AsDateTime) then
  begin
    MovContasAReceberD_PRO_LIG.AsDateTime := IncDia(MovContasAReceberD_DAT_VEN.AsDateTime,2);
  end;
end;

{******************************************************************************}
procedure TFManutencaoCR.MovContasAReceberD_DAT_VENChange(Sender: TField);
var
  VpfResultado : String;
begin
  if MovContasAReceberC_IND_RET.AsString = 'S' then
  begin
    if confirmacao('Duplicata já se encontra no banco. Deseja adicionar o titulo no arquivo de remessa para que seja realizada a alteração no banco?') then
    begin
      VpfResultado := FunContasAReceber.AdicionaRemessa(MovContasAReceberI_EMP_FIL.AsInteger,MovContasAReceberI_LAN_REC.AsInteger,MovContasAReceberI_NRO_PAR.AsInteger,6,'Alteracao Vencimento');
      if vpfresultado <> '' then
        aviso(VpfResultado);
    end;
  end;
  MovContasAReceberD_DAT_PRO.AsDateTime := IncDia(MovContasAReceberD_DAT_VEN.AsDateTime,FunContasAReceber.RDiasCompensacaoConta(MovContasAReceberC_NRO_CON.AsString));
end;

{******************************************************************************}
procedure TFManutencaoCR.BEstornaCobrancaExternaClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if Confirmacao('Tem certeza que deseja estornar a cobrança externa?') then
  begin
    AbreTransacao;
    Tempo.Execute('Estornando cobrança externa ... ');
    VpfResultado := FunContasAreceber.EstornaCobrancaExterna(MovContasAReceberI_EMP_FIL.AsInteger, MovContasAReceberI_LAN_REC.AsInteger, MovContasAReceberI_NRO_PAR.AsInteger);
    if VpfResultado <> '' then
    begin
      RollbackTransacao;
      aviso(VpfREsultado);
    end
    else
    begin
      AtualizaSQLTabela(MovContasAReceber);
      CommitTransacao;
    end;
    Tempo.Fecha;
  end;
end;

{******************************************************************************}
procedure TFManutencaoCR.BEstornaDescontoClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if Confirmacao('Tem certeza que deseja estornar o desconto do título?') then
  begin
    AbreTransacao;
    Tempo.Execute('Estornando Desconto ... ');
    VpfResultado := FunContasAreceber.EstornaDesconto(MovContasAReceberI_EMP_FIL.AsInteger, MovContasAReceberI_LAN_REC.AsInteger, MovContasAReceberI_NRO_PAR.AsInteger);
    if VpfResultado <> '' then
    begin
      RollbackTransacao;
      aviso('ESTORNO DO DESCONTO CANCELADO!!!'#13#13+VpfREsultado);
    end
    else
    begin
      AtualizaSQLTabela(MovContasAReceber);
      CommitTransacao;
    end;
    Tempo.Fecha;
  end;
end;

procedure TFManutencaoCR.BEstornaFundoPerdidoClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if Confirmacao('Tem certeza que deseja estornar o Fundo Perdido?') then
  begin
    AbreTransacao;
    Tempo.Execute('Estornando Fundo Perdido ... ');
    VpfResultado := FunContasAreceber.EstornaFundoPerdido(MovContasAReceberI_EMP_FIL.AsInteger, MovContasAReceberI_LAN_REC.AsInteger, MovContasAReceberI_NRO_PAR.AsInteger);
    if VpfResultado <> '' then
    begin
      RollbackTransacao;
      aviso('ESTORNO DO FUNDO PERDIDO CANCELADO!!!'#13#13+VpfREsultado);
    end
    else
    begin
      AtualizaSQLTabela(MovContasAReceber);
      CommitTransacao;
    end;
    Tempo.Fecha;
  end;
end;

{******************************************************************************}
procedure TFManutencaoCR.EClienteRetorno(Retorno1, Retorno2: String);
begin
  if (CadContaaReceber.State in [dsInsert, dsEdit]) then
    CadContaaReceber.Post;
  if CadContaaReceber.Active then
  CadContaaReceber.Edit;
  if MovContasAReceberI_COD_CLI.AsInteger <> CadContaaReceberI_COD_CLI.AsInteger then
  begin
    MovContasAReceber.first;
    while not MovContasAReceber.Eof do
    begin
      MovContasAReceber.edit;
      MovContasAReceberI_COD_CLI.AsInteger := CadContaaReceberI_COD_CLI.AsInteger;
      MovContasAReceber.post;
      MovContasAReceber.next;
    end;
  end;
end;

Initialization
  RegisterClasses([TFManutencaoCR]);
end.
