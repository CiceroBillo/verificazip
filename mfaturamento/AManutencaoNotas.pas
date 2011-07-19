unit AManutencaoNotas;
{          Autor: Rafael Budag
    Data Criação: 19/05/1999;
          Função: Consultar as notas fiscais

Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  formularios, StdCtrls, Componentes1, ExtCtrls, PainelGradiente,
  Localizacao, Buttons, Db, DBTables, ComCtrls,  Grids,
  DBGrids, printers, Mask, numericos, Tabela, DBCtrls, DBKeyViolation,
  Geradores, UnNotaFiscal, UnEDi, FileCtrl, UnDadosProduto, FMTBcd, SqlExpr,
  DBClient, UnNfe, Menus;

type
  TFManutencaoNotas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    NOTAS: TSQL;
    DATANOTAS: TDataSource;
    BitBtn3: TBitBtn;
    PageControl1: TPageControl;
    NOTASI_NRO_NOT: TFMTBCDField;
    NOTASC_NOM_CLI: TWideStringField;
    NOTASC_TIP_CAD: TWideStringField;
    NOTASC_FLA_ECF: TWideStringField;
    PanelColor3: TPanelColor;
    Label8: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    Data1: TCalendario;
    data2: TCalendario;
    EClientes: TEditLocaliza;
    NOTASc_not_can: TWideStringField;
    NOTASL_OBS_NOT: TWideStringField;
    NOTASN_TOT_PRO: TFMTBCDField;
    NOTASN_TOT_NOT: TFMTBCDField;
    NOTASI_NRO_LOJ: TFMTBCDField;
    NOTASI_NRO_CAI: TFMTBCDField;
    MObs: TDBMemoColor;
    NotaGrid: TGridIndice;
    NOTASC_NOT_IMP: TWideStringField;
    BCancelaNota: TBitBtn;
    BExcuiNota: TBitBtn;
    NOTASI_EMP_FIL: TFMTBCDField;
    NOTASI_SEQ_NOT: TFMTBCDField;
    T: TPainelTempo;
    NOTASD_DAT_EMI: TSQLTimeStampField;
    NOTASC_NOM_NAT: TWideStringField;
    BNotaDevolucaoFornecedor: TBitBtn;
    NOTASC_NOT_DEV: TWideStringField;
    Label27: TLabel;
    SpeedButton2: TSpeedButton;
    ENatureza: TEditLocaliza;
    Label4: TLabel;
    NOTASC_TIP_NOT: TWideStringField;
    ENota: TEditColor;
    NOTASNatureza: TWideStringField;
    NOTASi_COD_CLI: TFMTBCDField;
    NOTASC_COD_NAT: TWideStringField;
    MovNatureza: TSQLQuery;
    EItemNat: TEditColor;
    NOTASI_ITE_NAT: TFMTBCDField;
    NOTASC_SER_NOT: TWideStringField;
    ESerie: TEditColor;
    Label12: TLabel;
    BEDI: TBitBtn;
    BVerNota: TBitBtn;
    NOTASC_CHA_NFE: TWideStringField;
    NOTASC_REC_NFE: TWideStringField;
    NOTASC_PRO_NFE: TWideStringField;
    NOTASC_STA_NFE: TWideStringField;
    NOTASC_MOT_NFE: TWideStringField;
    BInutilizar: TBitBtn;
    NOTASC_NOM_USU: TWideStringField;
    NOTASD_DAT_CAN: TSQLTimeStampField;
    NOTASUSUARIOCANCELAMENTO: TWideStringField;
    BNotaDevolucao: TBitBtn;
    BConsultaSefaz: TBitBtn;
    NOTASC_NOT_INU: TWideStringField;
    NOTASC_ENV_NFE: TWideStringField;
    ETipoDocumento: TComboBoxColor;
    Label2: TLabel;
    Label5: TLabel;
    EInutilizacao: TComboBoxColor;
    CChaveAcessovazia: TCheckBox;
    NOTASC_MOC_NFE: TWideStringField;
    Label6: TLabel;
    ESituacaoNota: TComboBoxColor;
    PopupMenu1: TPopupMenu;
    AlterarCliente1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ENotasRetorno(Retorno1, Retorno2: String);
    procedure Data1Exit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure NOTASAfterScroll(DataSet: TDataSet);
    procedure BExcuiNotaClick(Sender: TObject);
    procedure BCancelaNotaClick(Sender: TObject);
    procedure CupomNotaClick(Sender: TObject);
    procedure BNotaDevolucaoFornecedorClick(Sender: TObject);
    procedure ENotaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ENaturezaRetorno(Retorno1, Retorno2: String);
    procedure BEDIClick(Sender: TObject);
    procedure BVerNotaClick(Sender: TObject);
    procedure NotaGridOrdem(Ordem: String);
    procedure BInutilizarClick(Sender: TObject);
    procedure BNotaDevolucaoClick(Sender: TObject);
    procedure BConsultaSefazClick(Sender: TObject);
    procedure NotaGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BConhecimentoClick(Sender: TObject);
    procedure AlterarCliente1Click(Sender: TObject);
  private
     VprOrdem : string;
     VprDNota : TRBDNotaFiscal;
     DevolucaoCupomNotaFiscal : Boolean;
     FunEDI : TRBFuncoesEDI;
     FunNfe : TRBFuncoesNFe;
     procedure ConfiguraPermissaoUsuario;
     procedure PosicionaNota(VpaGuardarPosicao : Boolean = false);
     procedure AdicionaFiltros(VpaSelect : TStrings);
     procedure CarNotasSelecionadas(VpaNotas : TList);
  public
    { Public declarations }
  end;

var
  FManutencaoNotas: TFManutencaoNotas;

implementation

uses APrincipal, Constantes, Fundata, ConstMsg,
     Funstring, FunNumeros, FunSql, funObjeto,
     AItensNatureza, ANovaNotaFiscalNota, ANovaNotaFiscaisFor,
  AConhecimentoTransporte, AConhecimentoTransporteSaida, ANovoCliente;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFManutencaoNotas.FormCreate(Sender: TObject);
begin
  Data1.DateTime := PrimeiroDiaMes(date);
  Data2.DateTime := UltimoDiaMes(Date);
  ETipoDocumento.ItemIndex := 1;
  EInutilizacao.ItemIndex := 2;
  ESituacaoNota.ItemIndex := 2;
  VprOrdem := 'order by NF.I_NRO_NOT';
  PosicionaNota;
  FunEDI := TRBFuncoesEDI.cria;
  FunNfe := TRBFuncoesNFe.cria(fPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFManutencaoNotas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(Notas);
  FechaTabela(MovNatureza);
  FunEdi.free;
  FunNFE.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Eventos da Consulta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFManutencaoNotas.ConfiguraPermissaoUsuario;
begin
  AlterarVisibleDet([BNotaDevolucaoFornecedor,BCancelaNota,BExcuiNota,BEDI],false);

  if (puFAManutencaoNota in varia.PermissoesUsuario)then
    AlterarVisibleDet([BNotaDevolucaoFornecedor,BCancelaNota,BExcuiNota,BEDI],true);
end;

{*********************** atualiza a consulta **********************************}
procedure TFManutencaoNotas.PosicionaNota(VpaGuardarPosicao : Boolean = false);
Var
  VpfPosicao : TBookMark;
begin
  VpfPosicao := NOTAS.GetBookmark;
  LimpaSQLTabela(Notas);
  Notas.Sql.Add(' select ' +
    ' NF.I_NRO_NOT, Cli.C_NOM_CLI, Cli.C_TIP_CAD, NF.C_FLA_ECF, NF.c_not_can, NF.L_OBS_NOT, ' +
    ' NF.N_TOT_PRO, NF.N_TOT_NOT, NF.I_NRO_LOJ, NF.I_NRO_CAI, NF.I_EMP_FIL, NF.I_SEQ_NOT, ' +
    ' NF.D_DAT_EMI, NF.C_COD_NAT,Nat.C_Cod_Nat ||''-''|| nat.C_NOM_NAT Natureza, nat.C_NOM_NAT,' +
    ' NF.C_NOT_DEV, NF.C_NOT_IMP, NF.C_TIP_NOT, NF.I_COD_CLI, NF.I_ITE_NAT, NF.C_SER_NOT, ' +
    ' NF.C_CHA_NFE, NF.C_REC_NFE, NF.C_PRO_NFE, NF.C_STA_NFE, NF.C_MOT_NFE, NF.D_DAT_CAN, '+
    ' NF.C_NOT_INU, NF.C_ENV_NFE, NF.C_MOC_NFE, '+
    ' USU.C_NOM_USU, '+
    ' USC.C_NOM_USU USUARIOCANCELAMENTO '+
    ' from ' +
    ' CadNotaFiscais NF, CadClientes  CLI, CadNatureza  Nat, CADUSUARIOS USU, CADUSUARIOS USC '+
    ' where  NF.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
                ' and nf.i_nro_not is not null '  +
                ' and '+SQLTextoRightJoin('NF.I_COD_CLI','CLI.I_COD_CLI')+
                ' and '+SQLTextoRightJoin('NF.C_COD_NAT','NAT.C_COD_NAT')+
                ' and '+SQLTextoRightJoin('NF.I_USU_CAN','USC.I_COD_USU')+
                ' AND NF.I_COD_USU = USU.I_COD_USU');

  AdicionaFiltros(Notas.Sql);

  Notas.Sql.Add(VprOrdem);
  NOTAS.open;
  NotaGrid.ALinhaSQLOrderBy := NOTAS.Sql.Count - 1;

  try
    if (VpaGuardarPosicao) and (not Notas.eof) then
      NOTAS.GotoBookmark(VpfPosicao);
    NOTAS.FreeBookmark(VpfPosicao);
  except
  end;
end;

{**************** adiciona os filtros da select *******************************}
procedure TFManutencaoNotas.AdicionaFiltros(VpaSelect : TStrings);
begin

  if ENota.Text <> '' Then
    VpaSelect.Add(' and NF.I_Nro_not = '+ ENota.Text)
  else
  begin
    VpaSelect.Add(SQLTextoDataEntreAAAAMMDD( ' NF.D_DAT_EMI ', Data1.Date, Data2.Date, true));

    if (EClientes.Text <> '') then
      VpaSelect.Add(' and NF.I_COD_CLI = ' + EClientes.Text);

    if ENatureza.Text <> '' then
      VpaSelect.Add(' and NF.C_COD_NAT = ''' + ENatureza.Text + '''' +
                    ' and i_ite_nat = ' + EItemNat.text  );

    case ETipoDocumento.ItemIndex of
      0 : VpaSelect.Add(' and NF.C_FLA_ECF = ''S''');
      1 : VpaSelect.Add(' and '+SqlTextoIsNull('NF.C_FLA_ECF','''N''')+' = ''N'''+
                        ' and '+SqlTextoIsNull('NF.C_VEN_CON','''N''')+' = ''N''' );
      2 : VpaSelect.Add(' and NF.C_VEN_CON = ''S''');
    end;
    case ESituacaoNota.ItemIndex of
      0 : VpaSelect.Add(' and NF.C_NOT_CAN = ''S''');
      1 : VpaSelect.Add(' and NF.C_NOT_CAN = ''N''');
    end;
    case EInutilizacao.ItemIndex  of
      0 : VpaSelect.Add(' and NF.C_NOT_INU = ''S''');
      1 : VpaSelect.Add(' and NF.C_NOT_INU = ''N''');
    end;
    if CChaveAcessovazia.Checked then
      VpaSelect.Add(' AND NF.C_CHA_NFE IS NULL');
   if ESerie.Text <> '' then
     VpaSelect.Add(' and NF.C_SER_NOT = ''' + ESerie.Text + '''' );

  end;
end;

{******************************************************************************}
procedure TFManutencaoNotas.CarNotasSelecionadas(VpaNotas : TList);
var
  VpfLaco : Integer;
  VpfDNota : TRBDNotaFiscal;
begin
  FreeTObjectsList(VpaNotas);
  if (NotaGrid.SelectedRows.Count = 0) and (NOTASI_SEQ_NOT.AsInteger <> 0) then
  begin
    VpfDNota := TRBDNotaFiscal.cria;
    FunNotaFiscal.CarDNotaFiscal(VpfDNota,NOTASI_EMP_FIL.AsInteger,NOTASI_SEQ_NOT.AsInteger);
    VpaNotas.add(VpfDNota);
  end
  else
  begin
    for VpfLaco := 0 to  NotaGrid.SelectedRows.Count - 1 do
    begin
      NOTAS.GotoBookmark(TBookmark(NotaGrid.SelectedRows.Items[VpfLaco]));
      VpfDNota := TRBDNotaFiscal.cria;
      FunNotaFiscal.CarDNotaFiscal(VpfDNota,NOTASI_EMP_FIL.AsInteger,NOTASI_SEQ_NOT.AsInteger);
      VpaNotas.add(VpfDNota);
    end;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Evetos dos filtros superiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************** atualica a consulta da grade *******************************}
procedure TFManutencaoNotas.ENotasRetorno(Retorno1, Retorno2: String);
begin
  PosicionaNota;
end;

{****************** retorno da natureza ************************************* }
procedure TFManutencaoNotas.ENaturezaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
      // verifica natureza
    FunNotaFiscal.LocalizaMovNatureza(MovNatureza, retorno1, false );

    if MovNatureza.RecordCount > 1 then
    begin
      FItensNatureza := TFItensNatureza.CriarSDI(application, '', true);
      FItensNatureza.PosicionaNatureza(MovNatureza);
    end;

    EItemNat.Text := MovNatureza.fieldByName('i_seq_mov').AsString;
    if EItemNat.Text = '' then
      EItemNat.Text := '0';

  end
  else
    EItemNat.Text := '';

  PosicionaNota;
end;

{**************** chama a rotina para atualizar a consulta ********************}
procedure TFManutencaoNotas.Data1Exit(Sender: TObject);
begin
  PosicionaNota;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        eventos dos botões inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********************** fecha o formulario ***********************************}
procedure TFManutencaoNotas.BConhecimentoClick(Sender: TObject);
begin
  FConhecimentoTransporteSaida := TFConhecimentoTransporteSaida.CriarSDI(self,'',true);
  FConhecimentoTransporteSaida.NovoConhecimento;
  FConhecimentoTransporteSaida.Free;
end;

{ *************************************************************************** }
procedure TFManutencaoNotas.BConsultaSefazClick(Sender: TObject);
begin
  FunNfe.ConsultapelaChave(NOTASC_CHA_NFE.AsString);
end;

{ *************************************************************************** }
procedure TFManutencaoNotas.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

{************************ exclui a nota fiscal *******************************}
procedure TFManutencaoNotas.BExcuiNotaClick(Sender: TObject);
var
  VpfDNotaFiscal : TRBDNotaFiscal;
  VpfTransacao :  TTransactionDesc;
  VpfREsultado : string;
begin
  if confirmacao(CT_DeletaRegistro) then
  begin
    VpfTransacao.IsolationLevel :=xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(vpfTransacao);
    T.Execute('Excluindo nota fiscal...');
    VpfDNotaFiscal := TRBDNotaFiscal.cria;
    VpfDNotaFiscal.CodFilial := NOTASI_EMP_FIL.AsInteger;
    VpfDNotaFiscal.SeqNota := NOTASI_SEQ_NOT.AsInteger;
    FunNotaFiscal.CarDNotaFiscal(VpfDNotaFiscal);
    VpfREsultado := FunNotaFiscal.ExcluiNotaFiscal(VpfDNotaFiscal);
    PosicionaNota(True);
    if VpfResultado <> '' then
    begin
      FPrincipal.BaseDados.Rollback(VpfTransacao);
      aviso(VpfResultado);
    end
    else
      FPrincipal.BaseDados.Commit(VpfTransacao);
    T.Fecha;
  end;
end;

procedure TFManutencaoNotas.BInutilizarClick(Sender: TObject);
var
  vpfResultado : String;
begin
  if NOTASI_NRO_NOT.AsInteger <> 0 then
  begin
    if confirmacao('Tem certeza que deseja inutilizar o número da nota?')  then
      VpfREsultado := FunNfe.InutilizaNumero(NOTASI_EMP_FIL.AsInteger,NOTASI_SEQ_NOT.AsInteger, NOTASI_NRO_NOT.AsInteger);
    if vpfResultado <> '' then
      aviso(vpfresultado);
  end;
end;

{******************* cancela a nota fiscal ************************************}
procedure TFManutencaoNotas.AlterarCliente1Click(Sender: TObject);
begin
  if NOTASI_NRO_NOT.AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoCliente'));
    AdicionaSqlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+NOTASi_COD_CLI.AsString);
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    FNovoCliente.Free;
  end;
end;

{******************************************************************************}
procedure TFManutencaoNotas.BCancelaNotaClick(Sender: TObject);
var
  VpfResultado : String;
  VpfDNota : TRBDNotaFiscal;
  VpfTransacao :  TTransactionDesc;
begin
  if NOTASI_SEQ_NOT.AsInteger <> 0 then
  begin
    VpfTransacao.IsolationLevel :=xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(vpfTransacao);
    T.Execute('Cancelando nota fiscal...');
    VpfDNota := TRBDNotaFiscal.cria;
    FunNotaFiscal.CarDNotaFiscal(VpfDNota,NOTASI_EMP_FIL.AsInteger,NOTASI_SEQ_NOT.AsInteger);
    VpfResultado := FunNotaFiscal.CancelaNotaFiscal(VpfDNota,true,true);
    VpfDNota.Free;
    PosicionaNota(true);
    T.Fecha;
    if VpfResultado <> '' then
    begin
      FPrincipal.BaseDados.Rollback(VpfTransacao);
      aviso(VpfResultado);
    end
    else
      FPrincipal.BaseDados.Commit(VpfTransacao);
  end;
end;

{******************************************************************************}
procedure TFManutencaoNotas.CupomNotaClick(Sender: TObject);
begin
  PosicionaNota;
end;

{******************** devolucao do cupom fiscal *******************************}
procedure TFManutencaoNotas.BNotaDevolucaoClick(Sender: TObject);
begin
   if NOTASI_SEQ_NOT.AsInteger <> 0 then
   begin
      FNovaNotaFiscalNota:= TFNovaNotaFiscalNota.CriarSDI(Application,'',True);
      if FNovaNotaFiscalNota.NotaDevolucao(NOTASI_EMP_FIL.AsInteger,NOTASI_SEQ_NOT.AsInteger) then
        PosicionaNota(true);
      FNovaNotaFiscalNota.Free;
   end;
end;

{******************************************************************************}
procedure TFManutencaoNotas.BNotaDevolucaoFornecedorClick(Sender: TObject);
var
  VpfNotas : TList;
begin
  VpfNotas := TList.create;
  CarNotasSelecionadas(VpfNotas);
  FNovaNotaFiscaisFor := TFNovaNotaFiscaisFor.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscaisFor'));
  FNovaNotaFiscaisFor.GeraNotaDevolucao(VpfNotas);
  FNovaNotaFiscaisFor.free;
  FreeTObjectsList(VpfNotas);
  VpfNotas.free;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************* apos o scrool da tabela ****************************}
procedure TFManutencaoNotas.NOTASAfterScroll(DataSet: TDataSet);
begin
//  AlterarEnabledDet([BExcuiNota, BCancelaNota, BNotaDevolucaoFornecedor ], false);
//  if CupomNota.ItemIndex = 1 then
  begin
//    BExcuiNota.Enabled := (NOTASC_NOT_IMP.AsString = 'N') AND (NOTASC_NOT_DEV.AsString = 'N') and (NOTASC_ENV_NFE.AsString = 'N');
    BCancelaNota.Enabled := (NOTASC_NOT_DEV.AsString = 'N') AND (NOTASC_NOT_CAN.AsString = 'N');
    BNotaDevolucaoFornecedor.Enabled := (NOTASC_NOT_DEV.AsString = 'N') AND (NOTASC_NOT_CAN.AsString = 'N') AND (NOTASC_TIP_NOT.AsString = 'S');
  end;
//  else
  begin
    BNotaDevolucaoFornecedor.Enabled := (NOTASC_NOT_DEV.AsString = 'N') AND (NOTASC_NOT_CAN.AsString = 'N');
  end;
end;

{********************* atualiza a consulta ************************************}
procedure TFManutencaoNotas.ENotaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    13 : PosicionaNota;
  end;
end;


procedure TFManutencaoNotas.BEDIClick(Sender: TObject);
begin
  if NOTASI_NRO_NOT.AsInteger <> 0 then
  begin
    FunEDI.GeraArquivoEDI(NOTASI_EMP_FIL.AsString,NOTASI_SEQ_NOT.AsString);
  end;
end;

{******************************************************************************}
procedure TFManutencaoNotas.BVerNotaClick(Sender: TObject);
begin
  VprDNota := TRBDNotaFiscal.cria;
  VprDNota.CodFilial := NOTASI_EMP_FIL.AsInteger;
  VprDNota.SeqNota := NOTASI_SEQ_NOT.AsInteger;
  FunNotaFiscal.CarDNotaFiscal(VprDNota);
  FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(self,'',true);
  FNovaNotaFiscalNota.ConsultaNota(VprDNota);
  FNovaNotaFiscalNota.free;
  PosicionaNota(True);
end;

{******************************************************************************}
procedure TFManutencaoNotas.NotaGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if NOTASc_not_can.AsString = 'S' then
  begin
    NotaGrid.Canvas.Font.Color:= clred;
    NotaGrid.DefaultDrawDataCell(Rect, NotaGrid.columns[datacol].field, State);
  end;
end;

{******************************************************************************}
procedure TFManutencaoNotas.NotaGridOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

Initialization
 RegisterClasses([TFManutencaoNotas]);
end.
