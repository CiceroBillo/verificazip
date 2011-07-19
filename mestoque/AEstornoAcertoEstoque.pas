unit AEstornoAcertoEstoque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ComCtrls, Componentes1, Grids, DBGrids, Tabela, ExtCtrls, PainelGradiente,
  Db, DBTables, Buttons, StdCtrls, Localizacao, DBKeyViolation, UnDadosProduto,
  DBClient;

type
  TFEstornoAcertoEstoque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    data1: TCalendario;
    data2: TCalendario;
    Estoque: TSQL;
    DataEstoque: TDataSource;
    EditLocaliza2: TEditLocaliza;
    Label14: TLabel;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Localiza: TConsultaPadrao;
    EstoqueI_EMP_FIL: TFMTBCDField;
    EstoqueI_LAN_EST: TFMTBCDField;
    EstoqueI_COD_OPE: TFMTBCDField;
    EstoqueD_DAT_MOV: TSQLTimeStampField;
    EstoqueN_QTD_MOV: TFMTBCDField;
    EstoqueC_TIP_MOV: TWideStringField;
    EstoqueN_VLR_MOV: TFMTBCDField;
    EstoqueC_COD_UNI: TWideStringField;
    EstoqueC_NOM_OPE: TWideStringField;
    GridIndice1: TGridIndice;
    EstoqueI_SEQ_PRO: TFMTBCDField;
    BotaoFechar2: TBitBtn;
    EstoqueI_COD_COR: TFMTBCDField;
    EstoqueC_COD_PRO: TWideStringField;
    EstoqueUNIORIGINAL: TWideStringField;
    EstoqueC_NOM_PRO: TWideStringField;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EProduto: TEditColor;
    BProduto: TSpeedButton;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure data1CloseUp(Sender: TObject);
    procedure EditLocaliza2Retorno(Retorno1, Retorno2: String);
    procedure BitBtn1Click(Sender: TObject);
    procedure BotaoFechar2Click(Sender: TObject);
    procedure BProdutoClick(Sender: TObject);
    procedure EProdutoExit(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    VprSeqProduto: Integer;
    function ExisteProduto(var VpaSeqProduto: Integer): Boolean;
    function LocalizaProduto(var VpaSeqProduto: Integer): Boolean;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
  public
    { Public declarations }
  end;

var
  FEstornoAcertoEstoque: TFEstornoAcertoEstoque;

implementation

uses APrincipal, funsql, fundata, UnProdutos, constantes, ALocalizaProdutos;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEstornoAcertoEstoque.FormCreate(Sender: TObject);
begin
  data1.DateTime := date;
  data2.DateTime := date;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEstornoAcertoEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := CaFree;
end;

{*************** gera filtro do estoque a ser estornado ********************* }
procedure TFEstornoAcertoEstoque.AtualizaConsulta;
begin
 ESTOQUE.close;
  Estoque.Sql.Clear;
  Estoque.Sql.Add('select MOV.I_EMP_FIL, MOV.I_LAN_EST, MOV.I_SEQ_PRO, MOV.I_COD_OPE, MOV.C_TIP_MOV, MOV.N_QTD_MOV, '+
                  ' MOV.N_VLR_MOV, MOV.C_COD_UNI, MOV.I_COD_COR, PRO.C_COD_PRO, PRO.C_COD_UNI UNIORIGINAL, '+
                  ' MOV.D_DAT_MOV, '+
                  ' PRO.C_NOM_PRO, '+
                  ' OPE.C_NOM_OPE '+
                  ' from MOVESToQUEPRODUTOS MOV, CADOPERACAOESTOQUE OPE, CADPRODUTOS PRO '+
                  ' WHERE MOV.I_COD_OPE = OPE.I_COD_OPE '+
                  ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                  SQLTextoDataEntreAAAAMMDD( 'D_DAT_MOV', data1.DateTime, data2.DateTime, TRUE) +
                  ' and MOV.I_NRO_NOT IS NULL');

  Estoque.Sql.Add(' and MOV.I_COD_OPE = OPE.I_COD_OPE ');

  AdicionaFiltros(Estoque.SQL);

  Estoque.Sql.Add(' order by I_LAN_EST ');

  Estoque.Open;
  GridIndice1.ALinhaSQLOrderBy := Estoque.SQL.Count - 1;
end;

{******************************************************************************}
procedure TFEstornoAcertoEstoque.AdicionaFiltros(VpaSelect: TStrings);
begin
  if EditLocaliza2.Text <>  '' then
    VpaSelect.Add(' and MOV.I_COD_OPE = ' + EditLocaliza2.text );
  if EProduto.Text <> '' then
    VpaSelect.Add(' AND PRO.I_SEQ_PRO = ' + IntToStr(VprSeqProduto));
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFEstornoAcertoEstoque.data1CloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEstornoAcertoEstoque.EditLocaliza2Retorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEstornoAcertoEstoque.BitBtn1Click(Sender: TObject);
var
 VpfDMovimento : TRBDMovEstoque;
begin
  VpfDMovimento := TRBDMovEstoque.Cria;
  VpfDMovimento.LanEstoque := EstoqueI_LAN_EST.AsInteger;
  FunProdutoS.EstornaEstoque(VpfDMovimento);
  VpfDMovimento.free;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEstornoAcertoEstoque.BotaoFechar2Click(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFEstornoAcertoEstoque.EProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    BProduto.Click;
end;

{******************************************************************************}
procedure TFEstornoAcertoEstoque.BProdutoClick(Sender: TObject);
begin
  LocalizaProduto(VprSeqProduto);
  ActiveControl:= EProduto;
  AtualizaConsulta;
end;

{******************************************************************************}
function TFEstornoAcertoEstoque.ExisteProduto(var VpaSeqProduto: Integer): Boolean;
var
  VpfNomProduto,
  VpfUM: String;
begin
  Result:= FunProdutos.ExisteProduto(EProduto.Text,VpaSeqProduto,VpfNomProduto,VpfUM);
  if Result then
    Label5.Caption:= VpfNomProduto;
end;

{******************************************************************************}
function TFEstornoAcertoEstoque.LocalizaProduto(var VpaSeqProduto: Integer): Boolean;
var
  VpfCodProduto,
  VpfNomProduto,
  VpfUM, VpfClaFiscal: String;
begin
  FLocalizaProduto:= TFLocalizaProduto.CriarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VpaSeqProduto,VpfCodProduto,VpfNomProduto,VpfUM,VpfClaFiscal);
  FLocalizaProduto.Free;
  if Result then
  begin
    EProduto.Text:= VpfCodProduto;
    Label5.Caption:= VpfNomProduto;
  end
  else
  begin
    EProduto.Clear;
    Label5.Caption:= '';
  end
end;

{******************************************************************************}
procedure TFEstornoAcertoEstoque.EProdutoExit(Sender: TObject);
begin
  if EProduto.Text <> '' then
  begin
    if not ExisteProduto(VprSeqProduto) then
      BProduto.Click;
  end
  else
    Label5.Caption:= '';
  AtualizaConsulta;
end;

Initialization
  RegisterClasses([TFEstornoAcertoEstoque]);
end.
