
unit AMostraDuplicata;

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
  DBTables, ComCtrls, UnClassesImprimir, DBClient, UnDados,
  UnDadosLocaliza, UnClientes;

type
  TFMostraDuplicata = class(TFormularioPermissao)
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
    Shape2: TShape;
    Shape8: TShape;
    Label13: TLabel;
    Shape17: TShape;
    Shape1: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Shape6: TShape;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Shape9: TShape;
    Shape10: TShape;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Shape11: TShape;
    Shape12: TShape;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    ENroOrdem: TEditColor;
    ENomeSacado: TEditColor;
    EEnderecoSacado: TEditColor;
    EPracaPagto: TEditColor;
    ECidadeSacado: TEditColor;
    EEstadoSacado: TEditColor;
    EInscricaoCGC: TEditColor;
    EInscricaoEstadual: TEditColor;
    EDescValor1: TEditColor;
    EDescValor2: TEditColor;
    ECondEspeciais: TEditColor;
    EValor: Tnumerico;
    Label3: TLabel;
    DBText2: TDBText;
    CAD_DOCC_NOM_IMP: TWideStringField;
    EDescontoDe: Tnumerico;
    EDataEmissao: TMaskEditColor;
    EDataVencimento: TMaskEditColor;
    EDataPagtoAte: TMaskEditColor;
    BOK: TBitBtn;
    Shape13: TShape;
    Label2: TLabel;
    Label16: TLabel;
    ERepresentante: TEditColor;
    Label32: TLabel;
    ECodRepresentante: TEditColor;
    ECodSacado: TRBEditLocaliza;
    Label33: TLabel;
    ECep: TEditColor;
    EValorTotal: Tnumerico;
    ENumero: TEditColor;
    BLocalizaSacado: TSpeedButton;
    ConsultaPadrao: TConsultaPadrao;
    Label34: TLabel;
    EBairroSacado: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure CModeloCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EValorChange(Sender: TObject);
    procedure ECodSacadoRetorno(VpaColunas: TRBColunasLocaliza);
  private
    IMP : TFuncoesImpressao;
    VprDCliente : TRBDCliente;
    procedure DesativaEdits;
  public
    { Public declarations }
    procedure ImprimeDocumento;
    procedure MostraDocumento(Dados: TDadosDuplicata);
    procedure CarregaDados(Dados: TDadosDuplicata);
    procedure CarregaEdits(Dados: TDadosDuplicata);
  end;

var
  FMostraDuplicata: TFMostraDuplicata;

implementation

uses APrincipal, FunSql, FunString, ConstMsg, Constantes,
  FunNumeros, FunObjeto, dmRave;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraDuplicata.FormCreate(Sender: TObject);
begin
  VprDCliente := TRBDCliente.cria;
  EDataEmissao.Text := DateToStr(Date);
  EDataVencimento.Text := DateToStr(Date);
  EDataPagtoAte.Text := DateToStr(Date);
  IMP := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
  AbreTabela(CAD_DOC);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraDuplicata.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CAD_DOC);
  IMP.Destroy;
  VprDCliente.Free;
  Action := CaFree;
end;

procedure TFMostraDuplicata.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFMostraDuplicata.BImprimirClick(Sender: TObject);
begin
  ImprimeDocumento;
end;

procedure TFMostraDuplicata.ImprimeDocumento;
var
  Dados: TDadosDuplicata;
begin
  if varia.CNPJFilial = CNPJ_PAROS then
  begin
    Dados := TDadosDuplicata.Create;
    CarregaDados(Dados);
    dtRave := TdtRave.Create(self);
    dtRave.ImprimeDuplicataManual(Varia.CodigoEmpFil, Dados);
    dtRave.free;
    Dados.free;
  end
  else
  begin
    if ((not CAD_DOC.EOF) and (CModelo.Text <> '')) then
    begin
      Dados := TDadosDuplicata.Create;
      IMP.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
      CarregaDados(Dados);
      IMP.ImprimeDuplicata(Dados); // Imprime 1 documento.
      IMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
    end
    else
      Aviso('Não existe modelo de documento para imprimir.')
  end;
end;

procedure TFMostraDuplicata.MostraDocumento(Dados: TDadosDuplicata);
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

procedure TFMostraDuplicata.DesativaEdits;
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

procedure TFMostraDuplicata.CarregaEdits(Dados: TDadosDuplicata);
begin
  EDataEmissao.Text := DateToStr(Dados.DataEmissao);
  ENumero.Text := Dados.Numero;
  EValor.AValor := Dados.Valor;
  ENroOrdem.Text := Dados.NroOrdem;
  EDataVencimento.Text := DateToStr(Dados.DataVencimento);
  EDescontoDe.AValor := Dados.DescontoDe;
  EDataPagtoAte.Text := DateToStr(Dados.DataPagtoAte);
  ECondEspeciais.Text := Dados.CondEspeciais;
  ENomeSacado.Text := Dados.NomeSacado;
  EEnderecoSacado.Text := Dados.EnderecoSacado;
  ECidadeSacado.Text := Dados.CidadeSacado;
  EEstadoSacado.Text := Dados.EstadoSacado;
  EBairroSacado.Text := Dados.Bairro;
  EInscricaoCGC.Text := Dados.InscricaoCGC;
  EInscricaoEstadual.Text := Dados.InscricaoEstadual;
  EPracaPagto.Text := Dados.PracaPagto;
  EDescValor1.Text := Dados.DescValor1;
  EDescValor2.Text := Dados.DescValor2;
  EValorTotal.AValor := Dados.ValorTotal;
  ERepresentante.Text := Dados.Representante;
  ECodRepresentante.Text := Dados.Cod_Representante;
  ECodSacado.Text := Dados.Cod_Sacado;
  ECep.Text := Dados.CEP;
end;

procedure TFMostraDuplicata.CarregaDados(Dados: TDadosDuplicata);
begin
  Dados.DataEmissao := StrToDate(EDataEmissao.Text);
  Dados.Numero := ENumero.Text;
  Dados.Valor := EValor.AValor;
  Dados.NroOrdem := ENroOrdem.Text;
  Dados.DataVencimento := StrToDate(EDataVencimento.Text);
  Dados.DescontoDe := EDescontoDe.AValor;
  Dados.DataPagtoAte := StrToDate(EDataPagtoAte.Text);
  Dados.CondEspeciais := ECondEspeciais.Text;
  Dados.NomeSacado := ENomeSacado.Text;
  Dados.EnderecoSacado := EEnderecoSacado.Text;
  Dados.CidadeSacado := ECidadeSacado.Text;
  Dados.EstadoSacado := EEstadoSacado.Text;
  Dados.Bairro := EBairroSacado.Text;
  Dados.InscricaoCGC := EInscricaoCGC.Text;
  Dados.InscricaoEstadual := EInscricaoEstadual.Text;
  Dados.PracaPagto := EPracaPagto.Text;
  Dados.DescValor1 := EDescValor1.Text;
  Dados.DescValor2 := EDescValor2.Text;
  Dados.ValorTotal := EValorTotal.AValor;
  Dados.Representante := ERepresentante.Text;
  Dados.Cod_Representante  := ECodRepresentante.Text;
  Dados.Cod_Sacado := ECodSacado.Text;
  Dados.CEP := ECep.Text;
end;

procedure TFMostraDuplicata.CModeloCloseUp(Sender: TObject);
begin
  // Limpa os Edits.
  LimpaEdits(FMostraDuplicata);
  LimpaEditsNumericos(FMostraDuplicata);
  // Configura e limita os edits.
  if (not CAD_DOC.EOF) then
    IMP.LimitaTamanhoCampos(FMostraDuplicata, CAD_DOCI_NRO_DOC.AsInteger);
end;

procedure TFMostraDuplicata.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
 // Configura e limita os edits.
 if (not CAD_DOC.EOF) then
   IMP.LimitaTamanhoCampos(FMostraDuplicata, CAD_DOCI_NRO_DOC.AsInteger);
end;

procedure TFMostraDuplicata.ECodSacadoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if ECodSacado.AInteiro <> 0  then
  begin
    VprDCliente.CodCliente := ECodSacado.AInteiro;
    FunClientes.CarDCliente(VprDCliente);
    ENomeSacado.Text := VprDCliente.NomCliente;
    if  (VprDCliente.DesEnderecoCobranca <> '')
    and (VprDCliente.CepClienteCobranca <> '')
    and (VprDCliente.NumEnderecoCobranca <> '') then
    begin
      EEnderecoSacado.Text := VprDCliente.DesEnderecoCobranca + ', ' + VprDCliente.NumEnderecoCobranca;
      ECidadeSacado.Text := VprDCliente.DesCidadeCobranca;
      EEstadoSacado.Text := VprDCliente.DesUfCobranca;
      EBairroSacado.Text := VprDCliente.DesBairroCobranca;
      ECep.Text := VprDCliente.CepClienteCobranca;
    end else
    begin
      EEnderecoSacado.Text := VprDCliente.DesEndereco + ', ' + VprDCliente.NumEndereco;
      ECidadeSacado.Text := VprDCliente.DesCidade;
      EEstadoSacado.Text := VprDCliente.DesUF;
      EBairroSacado.Text := VprDCliente.DesBairro;
      ECep.Text := VprDCliente.CepCliente;
    end;
    EInscricaoCGC.Text := VprDCliente.CGC_CPF;
    EInscricaoEstadual.Text := VprDCliente.InscricaoEstadual;
    EPracaPagto.Text := VprDCliente.DesPracaPagto;
  end;
end;

procedure TFMostraDuplicata.EValorChange(Sender: TObject);
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
 RegisterClasses([TFMostraDuplicata]);
end.
