unit AMostraRecibo;

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
  DBTables, UnClassesImprimir, DBClient, UnDados, unSistema,
  UnClientes, unDadosLocaliza;

type
  TFMostraRecibo = class(TFormularioPermissao)
    PanelFechar: TPanelColor;
    BFechar: TBitBtn;
    BImprimir: TBitBtn;
    PainelTitulo: TPainelGradiente;
    PanelModelo: TPanelColor;
    Label1: TLabel;
    CModelo: TDBLookupComboBoxColor;
    CAD_DOC: TSQL;
    CAD_DOCI_NRO_DOC: TFMTBCDField;
    CAD_DOCI_SEQ_IMP: TFMTBCDField;
    CAD_DOCC_NOM_DOC: TWideStringField;
    CAD_DOCC_TIP_DOC: TWideStringField;
    DATACAD_DOC: TDataSource;
    PanelPai: TPanelColor;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Shape8: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Label12: TLabel;
    Shape15: TShape;
    ENumero: TEditColor;
    EPessoa: TEditColor;
    EDescValor1: TEditColor;
    EDescValor2: TEditColor;
    EDescReferente1: TEditColor;
    EDescReferente2: TEditColor;
    ECidade: TEditColor;
    EDia: TEditColor;
    EMes: TEditColor;
    EAno: TEditColor;
    Shape16: TShape;
    Shape17: TShape;
    EEmitente: TEditColor;
    Label13: TLabel;
    Shape18: TShape;
    ECGCCPFGREmitente: TEditColor;
    Label14: TLabel;
    Shape19: TShape;
    EEnderecoEmitente: TEditColor;
    Label15: TLabel;
    Shape4: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape20: TShape;
    EValor: Tnumerico;
    DBText2: TDBText;
    CAD_DOCC_NOM_IMP: TWideStringField;
    ECliente: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    EBairro: TEditColor;
    Label16: TLabel;
    Shape21: TShape;
    ECidadePagador: TEditColor;
    Label17: TLabel;
    EUF: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure CModeloCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EValorChange(Sender: TObject);
    procedure EClienteRetorno(VpaColunas: TRBColunasLocaliza);
  private
    IMP : TFuncoesImpressao;
    VprDCliente : TRBDCliente;
    procedure DesativaEdits;
    procedure ImprimeReciboFolhaemBranco;
    procedure CarDCliente;
  public
    { Public declarations }
    procedure ImprimeDocumento;
    procedure MostraDocumento(Dados: TDadosRecibo);
    procedure CarregaDados(Dados: TDadosRecibo);
    procedure CarregaEdits(Dados: TDadosRecibo);
  end;

var
  FMostraRecibo: TFMostraRecibo;

implementation

uses APrincipal, FunSql, FunString, ConstMsg, Constantes,
  FunNumeros, FunObjeto, FunData, dmRave;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraRecibo.FormCreate(Sender: TObject);
begin
  IMP := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
  VprDCliente := TRBDCliente.cria;
  AbreTabela(CAD_DOC);
  ECidade.Text := Varia.CidadeFilial;
  EDia.AInteiro := dia(date);
  EMes.Text := TextoMes(date,false);
  EAno.AInteiro := Ano(date);
  EEmitente.Text := varia.NomeFilial;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraRecibo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CAD_DOC);
  IMP.Destroy;
  VprDCliente.free;
  Action := CaFree;
end;

procedure TFMostraRecibo.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFMostraRecibo.BImprimirClick(Sender: TObject);
begin
  ImprimeDocumento;
end;

{******************************************************************************}
procedure TFMostraRecibo.ImprimeDocumento;
var
  VpfDados: TDadosRecibo;
begin
  if ((not CAD_DOC.EOF) and (CModelo.Text <> '')) then
  begin
    if IMP.ImprimirDocumentonaLaser(CAD_DOCI_NRO_DOC.AsInteger) then
      ImprimeReciboFolhaemBranco
    else
    begin
      VpfDados := TDadosRecibo.Create;
      CarregaDados(VpfDados);
      IMP.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
      IMP.ImprimirRecibo(VpfDados); // Imprime 1 documento.
      IMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
    end;
  end
  else
    Aviso('Não existe modelo de documento para imprimir.');
end;

procedure TFMostraRecibo.MostraDocumento(Dados: TDadosRecibo);
begin
  CarregaEdits(Dados);
  BImprimir.Visible := False;
  PanelModelo.Visible := False;
  PanelFechar.Visible := False;
  PainelTitulo.Visible := False;
  Height := Height - PanelModelo.Height - PanelFechar.Height - PainelTitulo.Height;
  DesativaEdits;
  FormStyle := fsStayOnTop;
  BorderStyle := bsDialog;
  Show;
end;

procedure TFMostraRecibo.DesativaEdits;
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

{******************************************************************************}
procedure TFMostraRecibo.ImprimeReciboFolhaemBranco;
var
  VpfDFilial : TRBDFilial;
begin
  VpfDFilial := TRBDFilial.Cria;
  Sistema.CarDFilial(VpfDFilial,Varia.CodigoEmpFil);
  CarDCliente;

  dtRave := TdtRave.create(self);
  dtRave.ImprimeRecibo(Varia.CodigoEmpFil,VprDCliente,EDescReferente1.Text+EDescReferente2.text,FormatFloat('#,###,##0.00',EValor.AValor),EDescValor1.Text+EDescValor2.Text,ECidade.text+', '+EDia.Text+' de '+EMes.Text+' de '+EAno.Text);
  dtRave.free;
  VpfDFilial.Free;
end;

procedure TFMostraRecibo.CarDCliente;
begin
  VprDCliente.NomCliente := EPessoa.Text;
  VprDCliente.DesEndereco := EEnderecoEmitente.Text;
  VprDCliente.DesBairro := EBairro.Text;
  VprDCliente.DesCidade := ECidadePagador.Text;
  VprDCliente.DesUF := EUF.Text;
end;

procedure TFMostraRecibo.CarregaEdits(Dados: TDadosRecibo);
begin
  ENumero.Text := Dados.Numero;
  EValor.AValor := Dados.Valor;
  EPessoa.Text := Dados.Pessoa;
  EDescValor1.Text := Dados.DescValor1;
  EDescValor2.Text := Dados.DescValor2;
  EDescReferente1.Text := Dados.DescReferente1;
  EDescReferente2.Text := Dados.DescReferente2;
  ECidade.Text := Dados.Cidade;
  EDia.Text := Dados.Dia;
  EMes.Text := Dados.Mes;
  EAno.Text := Dados.Ano;
  EEmitente.Text := Dados.Emitente;
  ECGCCPFGREmitente.Text := Dados.CGCCPFGREmitente;
  EEnderecoEmitente.Text := Dados.EnderecoEmitente;
end;

procedure TFMostraRecibo.CarregaDados(Dados: TDadosRecibo);
begin
  Dados.Numero := ENumero.Text;
  Dados.Valor := EValor.AValor;
  Dados.Pessoa := EPessoa.Text;
  Dados.DescValor1 := EDescValor1.Text;
  Dados.DescValor2 := EDescValor2.Text;
  Dados.DescReferente1 := EDescReferente1.Text;
  Dados.DescReferente2 := EDescReferente2.Text;
  Dados.Cidade := ECidade.Text;
  Dados.Dia := EDia.Text;
  Dados.Mes := EMes.Text;
  Dados.Ano := EAno.Text;
  Dados.Emitente := EEmitente.Text;
  Dados.CGCCPFGREmitente := ECGCCPFGREmitente.Text;
  Dados.EnderecoEmitente := EEnderecoEmitente.Text;
end;

procedure TFMostraRecibo.CModeloCloseUp(Sender: TObject);
begin
  // Limpa os Edits.
  LimpaEdits(FMostraRecibo);
  LimpaEditsNumericos(FMostraRecibo);
  // Configura e limita os edits.
  if (not CAD_DOC.EOF) then
    IMP.LimitaTamanhoCampos(FMostraRecibo, CAD_DOCI_NRO_DOC.AsInteger);
end;

procedure TFMostraRecibo.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
 // Configura e limita os edits.
 if (not CAD_DOC.EOF) then
   IMP.LimitaTamanhoCampos(FMostraRecibo, CAD_DOCI_NRO_DOC.AsInteger);
end;

procedure TFMostraRecibo.EClienteRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if ECliente.AInteiro <> 0  then
  begin
    VprDCliente.CodCliente := ECliente.AInteiro;
    FunClientes.CarDCliente(VprDCliente);
    EPessoa.Text := VprDCliente.NomCliente;
    EEnderecoEmitente.Text := VprDCliente.DesEndereco;
    EBairro.Text := VprDCliente.DesBairro;
    ECidadePagador.Text := VprDCliente.DesCidade;
    EUF.Text := VprDCliente.DesUF;
  end;
end;

procedure TFMostraRecibo.EValorChange(Sender: TObject);
var
  AUX: string;
begin
  if (EValor.AValor > 0) then
  begin
    AUX  := Maiusculas(RetiraAcentuacao(Extenso(EValor.AValor, 'reais', 'real')));
    DivideTextoDoisComponentes(EDescValor1, EDescValor2, AUX);
  end
  else
  begin
    // Limpa descrição de valores.
    EDescValor1.Clear;
    EDescValor2.Clear;
  end;
end;

Initialization
 RegisterClasses([TFMostraRecibo]);
end.


