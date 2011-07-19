unit AManutencaoCP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Localizacao, Db, DBTables, ComCtrls, Componentes1, ExtCtrls,
  PainelGradiente, Mask, UnContasAPagar, numericos, UnDadosCR, FMTBcd, SqlExpr,
  DBClient, CGrades, unDadosLocaliza;
                                        
type
  TFManutencaoCP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelPor: TPanelColor;
    SpeedButton1: TSpeedButton;
    EDuplicata: TEditLocaliza;
    MovContasAPagar: TSQL;
    DataMovContasapagar: TDataSource;
    Localiza: TConsultaPadrao;
    CadContaapagar: TSQL;
    DataCadContaapagar: TDataSource;
    Label5: TLabel;
    ENota: TEditLocaliza;
    Label18: TLabel;
    SpeedButton3: TSpeedButton;
    MovContasAPagarI_EMP_FIL: TFMTBCDField;
    MovContasAPagarI_LAN_APG: TFMTBCDField;
    MovContasAPagarI_NRO_PAR: TFMTBCDField;
    MovContasAPagarC_NRO_CON: TWideStringField;
    MovContasAPagarI_LAN_BAC: TFMTBCDField;
    MovContasAPagarC_NRO_DUP: TWideStringField;
    MovContasAPagarD_DAT_VEN: TSQLTimeStampField;
    MovContasAPagarN_VLR_DUP: TFMTBCDField;
    MovContasAPagarD_DAT_PAG: TSQLTimeStampField;
    MovContasAPagarN_VLR_PAG: TFMTBCDField;
    MovContasAPagarN_VLR_DES: TFMTBCDField;
    MovContasAPagarN_PER_JUR: TFMTBCDField;
    MovContasAPagarN_PER_MOR: TFMTBCDField;
    MovContasAPagarN_PER_MUL: TFMTBCDField;
    MovContasAPagarI_COD_USU: TFMTBCDField;
    MovContasAPagarN_VLR_ACR: TFMTBCDField;
    MovContasAPagarN_PER_DES: TFMTBCDField;
    MovContasAPagarC_NRO_DOC: TWideStringField;
    MovContasAPagarN_VLR_JUR: TFMTBCDField;
    MovContasAPagarN_VLR_MOR: TFMTBCDField;
    MovContasAPagarN_VLR_MUL: TFMTBCDField;
    MovContasAPagarI_COD_FRM: TFMTBCDField;
    MovContasAPagarD_CHE_VEN: TSQLTimeStampField;
    MovContasAPagarC_BAI_BAN: TWideStringField;
    MovContasAPagarC_FLA_PAR: TWideStringField;
    MovContasAPagarL_OBS_APG: TWideStringField;
    MovContasAPagarI_PAR_FIL: TFMTBCDField;
    Aux: TSQLQuery;
    Tempo: TPainelTempo;
    CadContaapagarI_LAN_APG: TFMTBCDField;
    CadContaapagarI_EMP_FIL: TFMTBCDField;
    CadContaapagarI_COD_CLI: TFMTBCDField;
    CadContaapagarI_NRO_NOT: TFMTBCDField;
    CadContaapagarI_COD_DES: TFMTBCDField;
    CadContaapagarD_DAT_MOV: TSQLTimeStampField;
    CadContaapagarD_DAT_EMI: TSQLTimeStampField;
    CadContaapagarN_VLR_TOT: TFMTBCDField;
    CadContaapagarI_QTD_PAR: TFMTBCDField;
    CadContaapagarI_COD_USU: TFMTBCDField;
    CadContaapagarC_PAT_FOT: TWideStringField;
    CadContaapagarN_VLR_MOR: TFMTBCDField;
    CadContaapagarN_VLR_JUR: TFMTBCDField;
    CadContaapagarI_SEQ_NOT: TFMTBCDField;
    CadContaapagarI_COD_EMP: TFMTBCDField;
    CadContaapagarC_FLA_DES: TWideStringField;
    Label1: TLabel;
    EOrdem: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    MovContasAPagarC_FLA_CHE: TWideStringField;
    GradeMov: TGridIndice;
    PanelFiltro: TPanelColor;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Label7: TLabel;
    ECliente: TDBEditLocaliza;
    EPlano: TDBEditNumerico;
    Label3: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    Label2: TLabel;
    DBEditColor4: TDBEditColor;
    CadContaapagarN_VLR_REC: TFMTBCDField;
    PanelColor1: TPanelColor;
    ECentroCusto: TDBEditLocaliza;
    Label6: TLabel;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    CadContaapagarI_COD_CEN: TFMTBCDField;
    CadContaapagarC_COD_PLA: TWideStringField;
    CadContaapagarC_CLA_PLA: TWideStringField;
    PanelColor2: TPanelColor;
    PageControl1: TPageControl;
    PParcelas: TTabSheet;
    PanelColor3: TPanelColor;
    MObs: TDBMemoColor;
    BExclui: TBitBtn;
    BEstornar: TBitBtn;
    BPagamento: TBitBtn;
    BExcuiTitulo: TBitBtn;
    Label12: TLabel;
    BFecha: TBitBtn;
    PProjeto: TTabSheet;
    GProjetos: TRBStringGridColor;
    EConsultaProjeto: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDuplicataSelect(Sender: TObject);
    procedure EDuplicataRetorno(Retorno1, Retorno2: String);
    procedure ENotaSelect(Sender: TObject);
    procedure ENotaRetorno(Retorno1, Retorno2: String);
    procedure BFechaClick(Sender: TObject);
    procedure BExcluiClick(Sender: TObject);
    procedure MovContasAPagarAfterPost(DataSet: TDataSet);
    procedure CadContaapagarAfterInsert(DataSet: TDataSet);
    procedure BEstornarClick(Sender: TObject);
    procedure BExcuiTituloClick(Sender: TObject);
    procedure MovContasAPagarAfterScroll(DataSet: TDataSet);
    procedure MovContasAPagarBeforeInsert(DataSet: TDataSet);
    procedure EOrdemSelect(Sender: TObject);
    procedure EOrdemRetorno(Retorno1, Retorno2: String);
    procedure BBAjudaClick(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure GradeMovExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CamposExit(Sender: TObject);
    procedure GradeMovEditButtonClick(Sender: TObject);
    procedure AlteraFormaPagto;
    procedure AbreTransacao;
    procedure CommitTransacao;
    procedure RollbackTransacao;
    procedure GradeMovKeyPress(Sender: TObject; var Key: Char);
    procedure GProjetosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GProjetosDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GProjetosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EConsultaProjetoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GProjetosKeyPress(Sender: TObject; var Key: Char);
    procedure GProjetosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProjetosNovaLinha(Sender: TObject);
    procedure GProjetosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CadContaapagarBeforePost(DataSet: TDataSet);
  private
    VprTransacao : TTransactionDesc;
    VprDDespesaProjeto : TRBDContasaPagarProjeto;
    VprDContasAPagar : TRBDContasaPagar;
    procedure CarTitulosGrade;
    procedure CarValoresGrade;
    procedure CarDProjetoClasse;
    procedure CalculaValorDespesaPeloPercentual;
    procedure CalculaPercentualDespesaPeloValor;
    procedure AtualizaConsulta;
  public
    procedure CarregaConta( VpaCodFilial, VpaLanPagar: integer);
  end;

var
  FManutencaoCP: TFManutencaoCP;

implementation

{$R *.DFM}

uses
  Constantes, fundata, funstring, funsql, APrincipal, ConstMsg,
  APlanoConta, funObjeto, ABaixaContasaPagarOO, AMostraParPagarOO;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        formulario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ****************** Na criação do Formulário ******************************** }
procedure TFManutencaoCP.FormCreate(Sender: TObject);
begin
  VprDContasAPagar :=  TRBDContasaPagar.cria;
  VprDContasAPagar.CodFilial :=0;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFManutencaoCP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RollbackTransacao;
  if VprDContasAPagar.CodFilial <> 0 then
    FunContasAPagar.GravaDDespesaProjeto(VprDContasAPagar);
  VprDContasAPagar.Free;
  Action := CaFree;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      processos dos  botoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{********************** excluir conta *************************************** }
procedure TFManutencaoCP.BExcluiClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if MovContasAPagarI_EMP_FIL.AsInteger <> 0 then
    if Confirmacao(CT_ExcluiConta) then
    begin
       AbreTransacao;
       VpfResultado := FunContasAPagar.ExcluiConta(CadContaapagarI_EMP_FIL.AsInteger,CadContaAPagarI_LAN_APG.AsInteger, true );
       if VpfResultado <> '' then
       begin
         RollbackTransacao;
         aviso(VpfResultado);
       end
       else
       begin
          AtualizaSQLTabela(CadContaapagar);
          AtualizaSQLTabela(MovContasAPagar);
          CommitTransacao;
       end;
    end;
end;

{**************** excluir titulo ******************************************** }
procedure TFManutencaoCP.BExcuiTituloClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if Confirmacao(CT_ExcluiTitulos) then
  begin
    AbreTransacao;
    VpfResultado := FunContasAPagar.ExcluiTitulo(MovContasAPagar.fieldByName('I_EMP_FIL').AsInteger,MovContasAPagar.fieldByName('i_lan_apg').AsInteger,MovContasAPagar.fieldByName('i_nro_par').AsInteger);
    if VpfResultado <> ''  then
    begin
      aviso(VpfResultado);
      RollbackTransacao;
    end
    else
    begin
      AtualizaSQLTabela(CadContaapagar);
      AtualizaSQLTabela(MovContasAPagar);
     CommitTransacao;
    end;
  end;
end;

{********************* baixar conta ****************************************** }
procedure TFManutencaoCP.BEstornarClick(Sender: TObject);
Var
  VpfResultado : String;
begin
  if Confirmacao(CT_EstornarTitulo) then
  begin
    AbreTransacao;
    Tempo.Execute('Estornando Baixa ... ');
    Vpfresultado := FunContasAPagar.EstornoParcela(MovContasAPagarI_EMP_FIL.AsInteger, MovContasAPagarI_LAN_APG.AsInteger,MovContasAPagarI_NRO_PAR.AsInteger,
                          MovContasAPagarI_PAR_FIL.AsInteger,CadContaapagarI_COD_CLI.AsInteger, true);
    if VpfResultado <> '' then
    begin
      RollbackTransacao;
      aviso(VpfResultado);
    end
    else
      CommitTransacao;
    AtualizaConsulta;
    Tempo.Fecha;
  end;
end;

{*************** pagamento de uma conta ************************************** }
procedure TFManutencaoCP.BPagamentoClick(Sender: TObject);
var
  VpfDBaixaCP : TRBDBaixaCP;
  VpfDParcela : TRBDParcelaCP;
begin
  VpfDBaixaCP := TRBDBaixaCP.Cria;
  VpfDParcela := VpfDBaixaCP.AddParcela;
  if MovContasAPagarI_EMP_FIL.AsInteger <> 0 then
  begin
    FunContasAPagar.CarDParcelaBaixa(VpfDParcela,MovContasAPagarI_EMP_FIL.AsInteger,MovContasAPagarI_LAN_APG.AsInteger,MovContasAPagarI_NRO_PAR.AsInteger);
    FBaixaContasaPagarOO := TFBaixaContasaPagarOO.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBaixaContasaPagarOO'));
    if FBaixaContasaPagarOO.BaixarContasAPagar(VpfDBaixaCP) then
    begin
      AtualizaSQLTabela(MovContasAPagar);
    end;
  end;
  VpfDBaixaCP.free;
end;

{********************* fecha o formulario *********************************** }
procedure TFManutencaoCP.BFechaClick(Sender: TObject);
begin
  VerificaAtesGravar(CadContaapagar);
  VerificaAtesGravar(MovContasAPagar);
  Close;
end;

{************************** help ******************************************** }
procedure TFManutencaoCP.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FManutencaoCP.HelpContext);
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      localiza conta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{***************** chamda externa para carregar uma conta ******************* }
procedure TFManutencaoCP.CarDProjetoClasse;
begin
  if VprDDespesaProjeto.PerDespesa <> StrToFloat(DeletaChars(DeletaChars(GProjetos.Cells[3,GProjetos.ALinha],'.'),'%')) then
  begin
    CalculaValorDespesaPeloPercentual;
  end
  else
    if VprDDespesaProjeto.ValDespesa <> StrToFloat(DeletaChars(GProjetos.Cells[4,GProjetos.ALinha],'.')) then
    begin
      CalculaPercentualDespesaPeloValor;
    end;
  CarValoresGrade;
end;

{***************************************************************************** }
procedure TFManutencaoCP.CarregaConta(VpaCodFilial, VpaLanPagar : integer);
begin
  PageControl1.ActivePage := PParcelas;
  if VprDContasAPagar.CodFilial <> 0 then
    FunContasAPagar.GravaDDespesaProjeto(VprDContasAPagar);
  VprDContasAPagar.Free;
  VprDContasAPagar := TRBDContasaPagar.cria;
  PProjeto.TabVisible := Config.ControlarProjeto;
  VerificaAtesGravar(CadContaapagar);
  VerificaAtesGravar(MovContasAPagar);
  FunContasAPagar.LocalizaContaCP(CadContaapagar,VpaCodFilial, VpaLanpagar);
  FunContasAPagar.LocalizaParcelasComParciais(MovContasapagar,VpaCodFilial,VpaLanpagar );
  FunContasAPagar.CarDContasaPagar(VprDContasAPagar,VpaCodFilial,VpaLanPagar,false);
  FunContasAPagar.CarDProjetoContasaPagar(VprDContasAPagar);
  GProjetos.ADados := VprDContasAPagar.DespesaProjeto;
  GProjetos.CarregaGrade;
  EditarReg(CadContaapagar);
  ECliente.Atualiza;
  ECentroCusto.Atualiza;
  EPlanoExit(self);
end;

{***************************************************************************** }
procedure TFManutencaoCP.CarTitulosGrade;
begin
  GProjetos.Cells[1,0] := 'Código';
  GProjetos.Cells[2,0] := 'Projeto';
  GProjetos.Cells[3,0] := 'Percentual';
  GProjetos.Cells[4,0] := 'Valor';
end;

{***************************************************************************** }
procedure TFManutencaoCP.CarValoresGrade;
begin
  GProjetos.Cells[3,GProjetos.ALinha]:= FormatFloat('0.00 %',VprDDespesaProjeto.PerDespesa);
  GProjetos.Cells[4,GProjetos.ALinha]:= FormatFloat('#,###,###,##0.00',VprDDespesaProjeto.ValDespesa);
end;

{********************* localiza duplicata ************************************ }
procedure TFManutencaoCP.EDuplicataSelect(Sender: TObject);
begin
  EDuplicata.ASelectLocaliza.Clear;
  EDuplicata.ASelectLocaliza.Add(' select * ' +
                                 ' from MovContasaPagar MCP, CadContasaPagar CCP, CadClientes Cli ' +
                                 ' Where MCP.i_emp_fil =  ' + InttoStr(varia.CodigoEmpFil) +
                                 ' and MCP.I_EMP_FIL = CCP.I_EMP_FIL '+
                                 ' AND MCP.I_LAN_APG = CCP.I_LAN_APG '+
                                 ' and CCP.i_cod_cli = Cli.i_cod_cli ' +
                                 ' and  MCP.c_nro_dup like ''@%''');
  EDuplicata.ASelectValida.Clear;
  EDuplicata.ASelectValida.Add(' select * ' +
                               ' from MovContasaPagar MCP, CadContasaPagar CCP, CadClientes Cli ' +
                               ' Where MCP.i_emp_fil =  ' + InttoStr(varia.CodigoEmpFil) +
                               ' and MCP.I_EMP_FIL = CCP.I_EMP_FIL '+
                               ' AND MCP.I_LAN_APG = CCP.I_LAN_APG '+
                               ' and CCP.i_cod_cli = Cli.i_cod_cli ' +
                               ' and  MCP.c_nro_dup = ''@''');
end;

{***************************************************************************** }
procedure TFManutencaoCP.EConsultaProjetoRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDDespesaProjeto.CodProjeto := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDDespesaProjeto.NomProjeto := VpaColunas.items[1].AValorRetorno;
    GProjetos.Cells[1,GProjetos.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProjetos.Cells[2,GProjetos.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDDespesaProjeto.CodProjeto := 0;
    VprDDespesaProjeto.NomProjeto := '';
  end;
end;

{***************************************************************************** }
procedure TFManutencaoCP.EDuplicataRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    CarregaConta(varia.CodigoEmpFil,Strtoint(retorno1));
  ENota.Clear;
  EOrdem.Clear;
end;

{********************* localiza nota **************************************** }
procedure TFManutencaoCP.ENotaSelect(Sender: TObject);
begin
  ENota.ASelectValida.Clear;
  ENota.ASelectValida.Add(' select C.c_nom_CLI, cp.I_LAN_APG from CadContasaPagar  CP, CadClientes C '+
                          ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                          ' and I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                          ' and CP.I_NRO_NOT = @');
  ENota.ASelectLocaliza.Clear;
  ENota.ASelectLocaliza.Add(' Select CP.I_LAN_APG, CP.I_NRO_NOT, C.C_NOM_CLI, C.I_COD_CLI from '+
                            ' CadContasaPagar CP, CadClientes C '+
                            ' where CP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                            ' and CP.I_COD_CLI = C.I_COD_CLI and I_NRO_NOT like ''@%''' +
                            ' and not CP.I_NRO_NOT is null ');
end;

{*********************** retorno da nota ************************************* }
procedure TFManutencaoCP.ENotaRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    CarregaConta(Varia.CodigoEmpFil, StrToInt(retorno1));
  EDuplicata.Clear;
  EOrdem.Clear;
end;

{****************** localiza ordem ******************************************* }
procedure TFManutencaoCP.EOrdemSelect(Sender: TObject);
begin
  EOrdem.ASelectValida.Clear;
  EOrdem.ASelectValida.Add(' Select CP.I_EMP_FIL, CP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT ' +
                           ' from CadContasAPagar CP, CadClientes C ' +
                           ' where   ' +
                           ' CP.I_LAN_APG = @ ' +
                           ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                           ' and CP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                           ' ORDER BY I_LAN_APG ');
  EOrdem.ASelectLocaliza.Clear;
  EOrdem.ASelectLocaliza.Add(' Select CP.I_EMP_FIL,CP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT  ' +
                             ' from CadContasAPagar CP, CadClientes C ' +
                             ' where ' +
                             ' C.C_NOM_CLI like ''@%'''  +
                             ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                             ' and C.C_TIP_CAD <> ''C''' +
                             ' and CP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                             ' ORDER BY I_LAN_APG ');
end;

{******************* retorno do Ordem *************************************** }
procedure TFManutencaoCP.EOrdemRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    CarregaConta(Varia.CodigoEmpFil,StrToInt(retorno1));
  ENota.Clear;
  EDuplicata.Clear;
end;

{***************************************************************************** }
procedure TFManutencaoCP.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'D', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
  if (CadContaAPagar.State in [dsInsert, dsEdit]) then
    CadContaAPagar.Post;
  if CadContaAPagar.Active then
    CadContaAPagar.Edit;
end;

{***************************************************************************** }
procedure TFManutencaoCP.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    BPlano.Click;
end;

{***************************************************************************** }
procedure TFManutencaoCP.CamposExit(Sender: TObject);
begin
  if (CadContaAPagar.State in [dsInsert, dsEdit]) then
    CadContaAPagar.Post;
  if CadContaAPagar.Active then
    CadContaAPagar.Edit;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      acoes das tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{***************************************************************************** }
procedure TFManutencaoCP.MovContasAPagarAfterPost(DataSet: TDataSet);
begin
  FunContasAPagar.AtualizaValorTotal(MovContasAPagar.fieldByName('I_EMP_FIL').AsInteger, MovContasAPagar.fieldByName('i_lan_apg').AsInteger);
  AtualizaSQLTabela(CadContaapagar);
end;

{***************************************************************************** }
procedure TFManutencaoCP.CadContaapagarAfterInsert(DataSet: TDataSet);
begin
  CadContaapagar.Cancel;
end;

procedure TFManutencaoCP.CadContaapagarBeforePost(DataSet: TDataSet);
begin
  if CadContaapagarC_CLA_PLA.AsString = '' then
  begin
    aviso('PLANO DE CONTAS NÃO PREENCHIDO!!!'#13'É necessário preencher o plano de contas');
    abort;
  end;
end;

{***************************************************************************** }
procedure TFManutencaoCP.CalculaPercentualDespesaPeloValor;
var
  VpfValContasAPagar : Double;
begin
  VpfValContasAPagar := VprDContasAPagar.ValTotal;
  if VpfValContasAPagar > 0  then
  begin
    VprDDespesaProjeto.ValDespesa := StrToFloat(DeletaChars(GProjetos.Cells[4,GProjetos.ALinha],'.'));
    VprDDespesaProjeto.PerDespesa :=  (VprDDespesaProjeto.ValDespesa *100)/VpfValContasAPagar;
  end;
end;

{***************************************************************************** }
procedure TFManutencaoCP.CalculaValorDespesaPeloPercentual;
var
  VpfValContasAPagar : Double;
begin
  VpfValContasAPagar := VprDContasAPagar.ValTotal;
  if VpfValContasAPagar > 0  then
  begin
    VprDDespesaProjeto.PerDespesa := StrToFloat(DeletaChars(DeletaChars(GProjetos.Cells[3,GProjetos.ALinha],'.'),'%'));
    VprDDespesaProjeto.ValDespesa := VpfValContasAPagar * (VprDDespesaProjeto.PerDespesa / 100);
  end;
end;

{***************************************************************************** }
procedure TFManutencaoCP.MovContasAPagarAfterScroll(DataSet: TDataSet);
begin
  BExclui.Enabled := (MovContasAPagarN_VLR_PAG.AsFloat = 0 ) and (MovContasAPagarI_NRO_PAR.AsInteger <> 0);
  BExcuiTitulo.Enabled := (MovContasAPagarN_VLR_PAG.AsFloat = 0 ) and (MovContasAPagarI_NRO_PAR.AsInteger <> 0);
  BEstornar.Enabled := (MovContasAPagarN_VLR_PAG.AsFloat <> 0 ) and (MovContasAPagarI_NRO_PAR.AsInteger <> 0);
  BPagamento.Enabled := (MovContasAPagarD_DAT_PAG.AsFloat = 0 ) and (MovContasAPagarI_NRO_PAR.AsInteger <> 0);
  GradeMov.ReadOnly := MovContasAPagarN_VLR_PAG.AsFloat <> 0;
end;

{***************************************************************************** }
procedure TFManutencaoCP.MovContasAPagarBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{***************************************************************************** }
procedure TFManutencaoCP.GradeMovExit(Sender: TObject);
begin
  if (MovContasAPagar.State = dsEdit) then
    MovContasAPagar.Post;
end;

{***************************************************************************** }
procedure TFManutencaoCP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 115) and (CadContaapagar.Active) then // F4.
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
      if CadContaaPagar.State in [ dsEdit, dsInsert ] then
        CadContaaPagar.post;
      if MovContasAPagar.State in [ dsEdit, dsInsert ] then
        MovContasAPagar.post;
      FechaTabela(CadContaapagar);
      FechaTabela(MovContasAPagar);
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


{***************************************************************************** }
procedure TFManutencaoCP.GProjetosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDDespesaProjeto := TRBDContasaPagarProjeto(VprDContasAPagar.DespesaProjeto.Items[VpaLinha-1]);
  if VprDDespesaProjeto.CodProjeto <> 0 then
    GProjetos.Cells[1,VpaLinha]:= InttoStr(VprDDespesaProjeto.CodProjeto)
  else
    GProjetos.Cells[1,VpaLinha]:= '';
  GProjetos.Cells[2,VpaLinha]:= VprDDespesaProjeto.NomProjeto;
  CarValoresGrade;
end;

{***************************************************************************** }
procedure TFManutencaoCP.GProjetosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not EConsultaProjeto.AExisteCodigo(GProjetos.Cells[1,GProjetos.ALinha]) then
  begin
    VpaValidos := false;
    aviso('PROJETO NÃO CADASTRADO!!!'#13'O projeto digitado não existe cadastrado.');
    GProjetos.Col := 1;
  end
  else
    if (DeletaChars(DeletaChars(DeletaChars(GProjetos.Cells[3,GProjetos.ALinha],'%'),'0'),' ') = '') then
    begin
      VpaValidos := false;
      aviso('PERCENTUAL NÃO PREENCHIDO!!!'#13'É necessário digitar o percentual da despesa no projeto.');
      GProjetos.Col := 3;
    end
    else
      if (DeletaChars(DeletaChars(GProjetos.Cells[4,GProjetos.ALinha],'0'),' ') = '') then
      begin
        VpaValidos := false;
        aviso('VALOR NÃO PREENCHIDO!!!'#13'É necessário digitar o valor da despesa no projeto.');
        GProjetos.Col := 4;
      end;
  if VpaValidos then
  begin
    CarDProjetoClasse;
    if VprDDespesaProjeto.PerDespesa = 0  then
    begin
      VpaValidos := false;
      aviso('PERCENTUAL NÃO PREENCHIDO!!!'#13'É necessário digitar o percentual da despesa no projeto.');
      GProjetos.Col := 3;
    end
    else
      if VprDDespesaProjeto.ValDespesa = 0  then
      begin
        VpaValidos := false;
        aviso('VALOR NÃO PREENCHIDO!!!'#13'É necessário digitar o valor da despesa no projeto.');
        GProjetos.Col := 4;
      end;
  end;
  if Vpavalidos then
  begin
    if FunContasAPagar.ProjetoDuplicado(VprDContasAPagar) then
    begin
      vpaValidos := false;
      aviso('PROJETO DUPLICADO!!!'#13'Esse projeto já foi digitado.');
      GProjetos.Col := 1;
    end;
  end;
end;

{***************************************************************************** }
procedure TFManutencaoCP.GProjetosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case GProjetos.AColuna of
        1: EConsultaProjeto.AAbreLocalizacao;
      end;
    end;
  end;
end;

{***************************************************************************** }
procedure TFManutencaoCP.GProjetosKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = '.') and  not(GProjetos.col in [3,4]) then
    key := DecimalSeparator;
end;

{***************************************************************************** }
procedure TFManutencaoCP.GProjetosMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDContasAPagar.DespesaProjeto.Count >0 then
    VprDDespesaProjeto := TRBDContasaPagarProjeto(VprDContasAPagar.DespesaProjeto.Items[VpaLinhaAtual-1]);
end;

{***************************************************************************** }
procedure TFManutencaoCP.GProjetosNovaLinha(Sender: TObject);
begin
  VprDDespesaProjeto := VprDContasAPagar.addDespesaProjeto;
  VprDDespesaProjeto.PerDespesa := FunContasAPagar.RPercentualProjetoFaltante(VprDContasAPagar);
  CarValoresGrade;
  CalculaValorDespesaPeloPercentual;
  CarValoresGrade;
end;

{***************************************************************************** }
procedure TFManutencaoCP.GProjetosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProjetos.AEstadoGrade in [egInsercao,EgEdicao] then
  begin
    if GProjetos.AColuna <> ACol then
    begin
      case GProjetos.AColuna of
        1 :if not EConsultaProjeto.AExisteCodigo(GProjetos.Cells[1,GProjetos.ALinha]) then
           begin
             if not EConsultaProjeto.AAbreLocalizacao then
             begin
               GProjetos.Cells[1,GProjetos.ALinha] := '';
               abort;
             end;
           end;
        3 : if VprDDespesaProjeto.PerDespesa <> StrToFloat(DeletaChars(DeletaChars(GProjetos.Cells[3,GProjetos.ALinha],'.'),'%')) then
            begin
              CalculaValorDespesaPeloPercentual;
              CarValoresGrade;
            end;
        4 : if VprDDespesaProjeto.ValDespesa <> StrToFloat(DeletaChars(GProjetos.Cells[4,GProjetos.ALinha],'.')) then
            begin
              CalculaPercentualDespesaPeloValor;
              CarValoresGrade;
            end;
      end;
    end;
  end;
end;

{***************************************************************************** }
procedure TFManutencaoCP.GradeMovEditButtonClick(Sender: TObject);
begin
  if GradeMov.SelectedIndex = 4 then
     AlteraFormaPagto;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        altera forma pagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{**************** altera a forma de pagamento ****************************** }
procedure TFManutencaoCP.AlteraFormaPagto;
var
  VpfDContasAPagar : TRBDContasaPagar;
  VpfResultado : string;
begin
  if CadContaapagarI_EMP_FIL.AsInteger <> 0 then
  begin
    if MovContasAPagarN_VLR_PAG.AsFloat = 0 then
    begin
      VpfDContasAPagar := TRBDContasaPagar.cria;
      FunContasAPagar.CarDContasaPagarParcela(VpfDContasAPagar,MovContasAPagarI_EMP_FIL.AsInteger,MovContasAPagarI_LAN_APG.AsInteger,MovContasAPagarI_NRO_PAR.AsInteger);
      FMostraParPagarOO := TFMostraParPagarOO.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMostraParPagarOO'));
      if FMostraParPagarOO.AlteraFormaPagamento(VpfDContasAPagar) then
      begin
        VpfResultado := FunContasAPagar.GravaDParcelaCP(TRBDParcelaCP(VpfDContasAPagar.Parcelas.Items[0]));
        if VpfResultado <> '' then
          aviso(VpfResultado)
        else
        AtualizaConsulta;
      end;
      FMostraParPagarOO.free;
    end
    else
      Aviso(CT_ContaPagaCancelada);
  end;
end;

{******************************************************************************}
procedure TFManutencaoCP.AtualizaConsulta;
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := MovContasAPagar.GetBookmark;
  AtualizaSQLTabela(MovContasAPagar);
  MovContasAPagar.GotoBookmark(VpfPosicao);
  MovContasAPagar.FreeBookmark(VpfPosicao);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            transacoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFManutencaoCP.AbreTransacao;
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);

  if not FPrincipal.BaseDados.InTransaction then
  begin
    VprTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VprTransacao);
  end;
end;

procedure TFManutencaoCP.CommitTransacao;
begin
 if FPrincipal.BaseDados.InTransaction then
   FPrincipal.BaseDados.Commit(VprTransacao);
end;

procedure TFManutencaoCP.RollbackTransacao;
begin
 if FPrincipal.BaseDados.InTransaction then
   FPrincipal.BaseDados.Rollback(VprTransacao);
end;




procedure TFManutencaoCP.GradeMovKeyPress(Sender: TObject; var Key: Char);
begin
  if key = '.' then
    key := ',';
end;

Initialization
  RegisterClasses([TFManutencaoCP]);
end.
