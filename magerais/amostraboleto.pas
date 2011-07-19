unit AMostraBoleto;

{          Autor: Douglas Thomas Jacobsen
    Data Criação: 28/02/2000;
          Função: TELA BÁSICA
  Data Alteração:
    Alterado por:
Motivo alteração:
}

interface

uses
  Windows, SysUtils, Classes,Controls, Forms, Componentes1, ExtCtrls,
  PainelGradiente, Formularios, StdCtrls, Buttons, Tabela, Grids, DBCtrls,
  Localizacao, Mask, DBGrids, LabelCorMove, numericos, UnImpressao, Db,
  DBTables, ComCtrls, UnClassesImprimir, DBClient;

type
  TFMostraBoleto = class(TFormularioPermissao)
    PanelFechar: TPanelColor;
    BFechar: TBitBtn;
    BImprimir: TBitBtn;
    PainelTitulo: TPainelGradiente;
    Panel: TPanelColor;
    Label76: TLabel;
    Shape4: TShape;
    Label14: TLabel;
    Label5: TLabel;
    EValorDocumento: Tnumerico;
    ELocalPagamento: TEditColor;
    PanelModelo: TPanelColor;
    Label1: TLabel;
    CModelo: TDBLookupComboBoxColor;
    CAD_DOC: TSQL;
    CAD_DOCI_NRO_DOC: TFMTBCDField;
    CAD_DOCI_SEQ_IMP: TFMTBCDField;
    CAD_DOCC_NOM_DOC: TWideStringField;
    CAD_DOCC_TIP_DOC: TWideStringField;
    DATACAD_DOC: TDataSource;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ECedente: TEditColor;
    Label10: TLabel;
    Label11: TLabel;
    ENumeroDocumento: TEditColor;
    Label12: TLabel;
    EEspecieDocumento: TEditColor;
    EAceite: TEditColor;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    ECarteira: TEditColor;
    EEspecie: TEditColor;
    Label17: TLabel;
    EQuantidade: TEditColor;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    EAgencia: TEditColor;
    Label21: TLabel;
    ENossoNumero: TEditColor;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    EDesconto: Tnumerico;
    Label25: TLabel;
    EOutras: Tnumerico;
    Label26: TLabel;
    EMoraMulta: Tnumerico;
    Label27: TLabel;
    EAcrescimos: Tnumerico;
    Label28: TLabel;
    EValoCobrado: Tnumerico;
    Label29: TLabel;
    Label30: TLabel;
    Shape9: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    EInstrucoes: TMemoColorLimite;
    ESacado: TMemoColorLimite;
    DBText2: TDBText;
    CAD_DOCC_NOM_IMP: TWideStringField;
    EValor: Tnumerico;
    EDataDocumento: TMaskEditColor;
    EDataProcessamento: TMaskEditColor;
    EVencimento: TMaskEditColor;
    BOK: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure CModeloCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    IMP : TFuncoesImpressao;
    procedure DesativaEdits;
  public
    { Public declarations }
    procedure ImprimeDocumento;
    procedure MostraDocumento(Dados: TDadosBoleto);
    procedure CarregaDados(Dados: TDadosBoleto);
    procedure CarregaEdits(Dados: TDadosBoleto);
  end;

var
  FMostraBoleto: TFMostraBoleto;

implementation

uses APrincipal, FunSql, FunString, ConstMsg, FunObjeto, Constantes;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraBoleto.FormCreate(Sender: TObject);
begin
  EDataDocumento.Text:=DateToStr(Date);
  EDataProcessamento.Text:=DateToStr(Date);
  EVencimento.Text:=DateToStr(Date);
  IMP := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
  AbreTabela(CAD_DOC);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraBoleto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CAD_DOC);
  IMP.Destroy;
  Action := CaFree;
end;

procedure TFMostraBoleto.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFMostraBoleto.BImprimirClick(Sender: TObject);
begin
  ImprimeDocumento;
end;

procedure TFMostraBoleto.ImprimeDocumento;
var
  Dados: TDadosBoleto;
begin
  if ((not CAD_DOC.EOF) and (CModelo.Text <> '')) then
  begin
    Dados := TDadosBoleto.Create;
    IMP.InicializaImpressao( CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
    CarregaDados(Dados);
    IMP.ImprimeBoleto(Dados); // Imprime 1 documento.
    IMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
  end
  else
    Aviso('Não existe modelo de documento para imprimir.');
end;

procedure TFMostraBoleto.MostraDocumento(Dados: TDadosBoleto);
begin
  BOK.Visible := True;
  ActiveControl :=  BOK;
  CarregaEdits(Dados);
  DesativaEdits;
  if BImprimir.Visible then
    Height := Height - PanelModelo.Height - PanelFechar.Height - PainelTitulo.Height;
  BImprimir.Visible := False;
  PanelModelo.Visible := False;
  PanelFechar.Visible := False;
  PainelTitulo.Visible := False;
  if BImprimir.Visible then
    Height := Height - PanelModelo.Height - PanelFechar.Height - PainelTitulo.Height;  DesativaEdits;
  FormStyle := fsStayOnTop;
  BorderStyle := bsDialog;
  Show;
end;

procedure TFMostraBoleto.DesativaEdits;
var
 I: Integer;
begin
  for I := 0 to (ComponentCount -1) do
  begin
    if (Components[I] is TEditColor) then
      (Components[I] as TEditColor).ReadOnly := True;
    if (Components[I] is TNumerico) then
      (Components[I] as TNumerico).ReadOnly := True;
  end;
end;

procedure TFMostraBoleto.CarregaEdits(Dados: TDadosBoleto);
begin
  with Dados do
  begin
    ELocalPagamento.Text:=LocalPagamento;
    ECedente.Text:=Cedente;
    EDataDocumento.Text:=DateToStr(DataDocumento);
    ENumeroDocumento.Text:=NumeroDocumento;
    EEspecieDocumento.Text:=EspecieDocumento;
    EAceite.Text:=Aceite;
    EDataProcessamento.Text:=DateToStr(DataProcessamento);
    ECarteira.Text:=Carteira;
    EEspecie.Text:=Especie;
    EQuantidade.Text:=Quantidade;
    EVencimento.Text:=DateToStr(Vencimento);
    EAgencia.Text:=Agencia;
    ENossoNumero.Text:=NossoNumero;

    EValorDocumento.AValor := ValorDocumento;
    EValor.AValor := Valor;
    EDesconto.AValor := Desconto;
    EOutras.AValor := Outras;
    EMoraMulta.AValor := MoraMulta;
    EAcrescimos.AValor := Acrescimos;
    EValoCobrado.AValor := ValoCobrado;

    EInstrucoes.Lines := Instrucoes;
    ESacado.Lines  :=Sacado;
  end;
end;

procedure TFMostraBoleto.CarregaDados(Dados: TDadosBoleto);
var
  I : Integer;
begin
  with Dados do
  begin
    LocalPagamento    := ELocalPagamento.Text;
    Cedente           := ECedente.Text;
    DataDocumento     := StrToDate(EDataDocumento.Text);
    NumeroDocumento   := ENumeroDocumento.Text;
    EspecieDocumento  := EEspecieDocumento.Text;
    Aceite            := EAceite.Text;
    DataProcessamento := StrToDate(EDataProcessamento.Text);
    Carteira          := ECarteira.Text;
    Especie           := EEspecie.Text;
    Quantidade        := EQuantidade.Text;
    Valor             := EValor.AValor;
    Vencimento        := StrToDate(EVencimento.Text);
    Agencia           := EAgencia.Text;
    NossoNumero       := ENossoNumero.Text;
    ValorDocumento    := EValorDocumento.AValor;
    Desconto          := EDesconto.AValor;
    Outras            := EOutras.AValor;
    MoraMulta         := EMoraMulta.AValor;
    Acrescimos        := EAcrescimos.AValor;
    ValoCobrado       := EValoCobrado.AValor;
    Instrucoes := TStringList.Create;
    Instrucoes.Clear;
    for I:=0 to EInstrucoes.Lines.Count -1 do
      Instrucoes.Add(EInstrucoes.Lines.Strings[I]);
    Sacado := TStringList.Create;
    Sacado.Clear;
    for I:=0 to ESacado.Lines.Count -1 do
      Sacado.Add(ESacado.Lines.Strings[I]);
  end;
end;

procedure TFMostraBoleto.CModeloCloseUp(Sender: TObject);
begin
  LimpaEdits(FMostraBoleto);
  LimpaEditsNumericos(FMostraBoleto);
  // Configura e limita os edits.
  if (not CAD_DOC.EOF) then
    IMP.LimitaTamanhoCampos(FMostraBoleto, CAD_DOCI_NRO_DOC.AsInteger);
end;

procedure TFMostraBoleto.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
  // Configura e limita os edits.
  if (not CAD_DOC.EOF) then
    IMP.LimitaTamanhoCampos(FMostraBoleto, CAD_DOCI_NRO_DOC.AsInteger);
end;

Initialization
 RegisterClasses([TFMostraBoleto]);
end.
