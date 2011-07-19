unit AConsultaVendaPeriodo;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls,
  Localizacao, Grids, DBGrids, Tabela, DBKeyViolation, Db, DBTables, Mask,
  DBCtrls, numericos, UnNotaFiscal, DBClient;

type
  TFConsultaVendaPeriodo = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    Cheques: TSQL;
    DataCheques: TDataSource;
    ChequesI_NRO_NOT: TFMTBCDField;
    ChequesD_DAT_PAG: TSQLTimeStampField;
    ChequesN_VLR_PAG: TFMTBCDField;
    ChequesC_NOM_CLI: TWideStringField;
    ChequesI_SEQ_NOT: TFMTBCDField;
    ChequesI_COD_CLI: TFMTBCDField;
    ChequesD_DAT_VEN: TSQLTimeStampField;
    ChequesD_DAT_EMI: TSQLTimeStampField;
    ChequesI_COD_FRM: TFMTBCDField;
    PanelColor1: TPanelColor;
    Paginas: TPageControl;
    PagamentoTab: TTabSheet;
    GridIndice1: TGridIndice;
    PanelColor3: TPanelColor;
    Label18: TLabel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    EditLocaliza4: TEditLocaliza;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    FormaPagto: TEditLocaliza;
    Label2: TLabel;
    FormaPagamento: TSQL;
    ChequesI_LAN_REC: TFMTBCDField;
    ChequesN_VLR_PAR: TFMTBCDField;
    ChequesC_NOM_FRM: TWideStringField;
    ChequesI_COD_BAN: TFMTBCDField;
    ChequesI_NRO_PAR: TFMTBCDField;
    ChequesC_NOM_BAN: TWideStringField;
    Soma: TSQL;
    numerico1: Tnumerico;
    Label9: TLabel;
    BCancelaVenda: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure FormaPagtoRetorno(Retorno1, Retorno2: String);
    procedure dataParcela2CloseUp(Sender: TObject);
    procedure MovChequesAfterInsert(DataSet: TDataSet);
  private
    TipoFrm : string;
    NF : TFuncoesNotaFiscal;
    procedure AbreConsulta;
  public
    { Public declarations }
  end;

var
  FConsultaVendaPeriodo: TFConsultaVendaPeriodo;

implementation

uses APrincipal, funsql, fundata, Constantes;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaVendaPeriodo.FormCreate(Sender: TObject);
begin
  Paginas.ActivePage := PagamentoTab;
  DataParcela1.Date := PrimeiroDiaMes(date);
  DataParcela2.Date := UltimoDiaMes(date);
  BCancelaVenda.Enabled := not ConfigModulos.NotaFiscal;
  AbreConsulta;
  NF := TFuncoesNotaFiscal.Criar(self, FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaVendaPeriodo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  NF.free;
  Action := CaFree;
end;

procedure TFConsultaVendaPeriodo.BFecharClick(Sender: TObject);
begin
  Self.close;
end;

procedure TFConsultaVendaPeriodo.AbreConsulta;
begin
  LimpaSQLTabela(Cheques);
  InseriLinhaSQL(Cheques, 0, ' select ' );
  InseriLinhaSQL(Cheques, 1, ' CP.I_LAN_REC, CP.I_SEQ_NOT, MCP.I_NRO_PAR, ' +
                             ' CP.I_COD_CLI, CP.I_NRO_NOT,  ' +
                             ' MCP.D_DAT_VEN, CP.D_DAT_EMI, ' +
                             ' MCP.N_VLR_PAR, MCP.D_DAT_PAG, ' +
                             ' MCP.N_VLR_PAG, MCP.I_COD_FRM, B.C_NOM_BAN, ' +
                             ' MCP.I_COD_BAN, ' +
                             ' C.C_NOM_CLI, F.C_NOM_FRM ' );
  InseriLinhaSQL(Cheques, 2, ' from ' +
                             ' MovContasAReceber MCP, ' +
                             ' CadContasAReceber CP, ' +
                             ' CadClientes C, '+
                             ' cadformaspagamento F, ' +
                             ' cadbancos B '  +
                             ' where ' );
  InseriLinhaSQL(Cheques, 3, SQLTextoDataEntreAAAAMMDD('CP.D_DAT_EMI',
                             DataParcela1.Date, DataParcela2.Date, false));
  if FormaPagto.Text <> '' then
    InseriLinhaSQL(Cheques, 4, ' and MCP.I_COD_FRM = ' + FormaPagto.Text )
  else
    InseriLinhaSQL(Cheques, 4, ' ');
  if EditLocaliza4.Text <> '' then
    InseriLinhaSQL(Cheques, 5, ' and CP.I_COD_CLI = ' +  EditLocaliza4.Text )
  else
    InseriLinhaSQL(Cheques, 5, ' ');
  InseriLinhaSQL(Cheques, 6, ' and CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                             ' and CP.I_LAN_REC = MCP.I_LAN_REC ' +
                             ' and CP.I_COD_CLI = C.I_COD_CLI '  +
                             ' and MCP.I_COD_FRM = F.I_COD_FRM ' +
                             ' and '+SQLTextoRightJoin('MCP.I_COD_BAN','B.I_COD_BAN'));
  Cheques.open;

  soma.close;
  soma.sql.clear;
  soma.sql := Cheques.sql;
  soma.sql.Delete(1);
  soma.sql.Insert(1, ' sum(mcp.n_vlr_par) total');
  soma.open;
  numerico1.AValor := soma.FieldByName('total').AsCurrency;
end;

procedure TFConsultaVendaPeriodo.FormaPagtoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    TipoFrm := Retorno1;
  end;
  AbreConsulta;
end;

procedure TFConsultaVendaPeriodo.dataParcela2CloseUp(Sender: TObject);
begin
  AbreConsulta;
end;



procedure TFConsultaVendaPeriodo.MovChequesAfterInsert(DataSet: TDataSet);
begin
  Abort;
end;


Initialization
  RegisterClasses([TFConsultaVendaPeriodo]);
end.
