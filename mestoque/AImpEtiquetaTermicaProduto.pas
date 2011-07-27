unit AImpEtiquetaTermicaProduto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnArgox, UnProdutos,
  Localizacao, UnDadosProduto, DBKeyViolation, Mask, numericos, Menus,
  Grids, CGrades, Db, DBTables, unZebra;


type
  TFImpEtiquetaTermicaProduto = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    LNomProduto: TLabel;
    EProduto: TEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    EQtdProduto: Tnumerico;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    ConfigurarRetorno1: TMenuItem;
    Grade: TRBStringGridColor;
    BAdicionar: TBitBtn;
    Label14: TLabel;
    SpeedButton5: TSpeedButton;
    LNomCor: TLabel;
    ECor: TEditLocaliza;
    Aux: TQuery;
    BPequena: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EProdutoChange(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure EProdutoSelect(Sender: TObject);
    procedure ConfigurarRetorno1Click(Sender: TObject);
    procedure EQtdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BAdicionarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure ECorCadastrar(Sender: TObject);
    procedure EProdutoCadastrar(Sender: TObject);
    procedure BPequenaClick(Sender: TObject);
  private
    { Private declarations }
    VprEtiquetas : TList;
    VprDProduto : TRBDProduto;
    VprDEtiqueta : TRBDEtiquetaProduto;
    FunArgox : TRBFuncoesArgox;
    FunZebra : TRBFuncoesZebra;
    procedure CarTitulosGrade;
    procedure ImprimeEtiqueta8X15;
    procedure ImprimeEtiquetaKairos;
    procedure ImprimeEtiquetaKairosTexto;
    procedure AdicionaEtiquetaGrade;
  public
    { Public declarations }
  end;

var
  FImpEtiquetaTermicaProduto: TFImpEtiquetaTermicaProduto;

implementation

uses APrincipal, constantes, FunObjeto, ConstMsg, ACores, ANovoProdutoPro, unOrdemProducao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImpEtiquetaTermicaProduto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprEtiquetas := TList.Create;
  VprDProduto := TRBDProduto.cria;
  VprDProduto.CodEmpresa := VARIA.CodigoEmpresa;
  VprDProduto.CodEmpFil := Varia.CodigoEmpFil;
//  FunArgox := TRBFuncoesArgox.cria(Varia.PortaComunicacaoImpTermica);
  CarTitulosGrade;
  Grade.ADados := VprEtiquetas;
  Grade.CarregaGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImpEtiquetaTermicaProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprEtiquetas);
  VprEtiquetas.free;
//  FunArgox.Free;
  VprDProduto.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Produto';
  Grade.Cells[3,0] := 'Código';
  Grade.Cells[4,0] := 'Cor';
  Grade.Cells[5,0] := 'Qtd Etiqueta';
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.ImprimeEtiqueta8X15;
var
  VpfLaco,VpfSeqEstoqueBarra : Integer;
begin
  FunProdutos.AdicionaProdutoEtiquetado(VprEtiquetas);
  if FunArgox.ImprimeEtiquetaProduto8X15(VprEtiquetas) = 0 then
  begin
    for VpfLaco := 0 to VprEtiquetas.count - 1 do
    begin
      VprDEtiqueta :=TRBDEtiquetaProduto(VprEtiquetas.Items[VpfLaco]);
      VprDProduto := VprDEtiqueta.Produto;
      FunProdutos.BaixaProdutoEstoque(VprDProduto,varia.CodigoEmpFil, Varia.OperacaoEstoqueImpressaoEtiqueta,0,0,0,
                                    varia.MoedaBase,0,0,date,VprDEtiqueta.QtdProduto,VprDEtiqueta.QtdProduto*VprDProduto.VlrCusto,VprDProduto.CodUnidade,
                                    '',false,VpfSeqEstoqueBarra,true);
    end;
    ActiveControl := EProduto;
  end;
  FunArgox.free;
  FunArgox := TRBFuncoesArgox.cria(Varia.PortaComunicacaoImpTermica);

end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.ImprimeEtiquetaKairos;
begin
  FunArgox.ImprimeEtiquetaProduto50X25(VprEtiquetas);;
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.ImprimeEtiquetaKairosTexto;
begin
  FunArgox.ImprimeEtiquetaKairosTexto(VprEtiquetas);
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.EProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    VprDProduto.SeqProduto := StrToInt(Retorno1);
    FunProdutos.CarDProduto(VprDProduto);
  end;
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.EProdutoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.BImprimirClick(Sender: TObject);
var
  VpfModeloEtiqueta : Integer;
begin
  case TBitBtn(Sender).Tag of
    10 : VpfModeloEtiqueta := varia.ModeloEtiquetaNotaEntrada;
    20 : VpfModeloEtiqueta := varia.ModeloEtiquetaPequena;
  end;

  if EProduto.Text <> '' then
    BAdicionar.Click;
  if VpfModeloEtiqueta = 0 then
  begin

  end
  else
    if VpfModeloEtiqueta in [1,2,3,4,8,9,10] then
    begin
      FunArgox := TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica);
      case VpfModeloEtiqueta of
        1 : ImprimeEtiqueta8X15;
        2 : ImprimeEtiquetaKairos;
        3 : ImprimeEtiquetaKairosTexto;
        4 : FunArgox.ImprimeEtiquetaProduto54X28(VprEtiquetas);
        8 : FunArgox.ImprimeEtiquetaProduto35X89(VprEtiquetas);
        9 : FunArgox.ImprimeEtiquetaProduto34X23(VprEtiquetas);
       10 : FunArgox.ImprimeEtiquetaProduto33X14(VprEtiquetas);
      end;
      FunArgox.free;
    end
      else
      if VpfModeloEtiqueta in [6] then
      begin
        if VpfModeloEtiqueta in [6] then
          FunZebra := TRBFuncoesZebra.cria(Varia.PortaComunicacaoImpTermica,176,lzEPL);
        case VpfModeloEtiqueta of
          6 : FunZebra.ImprimeEtiquetaProduto33X22(VprEtiquetas);
        end;
        FunZebra.free;
      end;
  FreeTObjectsList(VprEtiquetas);
  Grade.CarregaGrade;
end;

procedure TFImpEtiquetaTermicaProduto.BPequenaClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text := 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text := 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.ConfigurarRetorno1Click(
  Sender: TObject);
begin
  FunArgox.VoltarEtiqueta;
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.EQtdProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    BImprimir.Click;
end;

procedure TFImpEtiquetaTermicaProduto.BAdicionarClick(Sender: TObject);
begin
  if EQtdProduto.AsInteger <> 0 then
    AdicionaEtiquetaGrade
  else
    aviso('QUANTIDADE DE ETIQUETAS NÃO PREENHCIDO!!!'#13'É necessário preencher a quantidade de etiquetas.');
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.AdicionaEtiquetaGrade;
begin
  VprDEtiqueta := TRBDEtiquetaProduto.cria;
  VprDEtiqueta.Produto := VprDProduto;
  VprDEtiqueta.QtdEtiquetas := EQtdProduto.AsInteger;
  VprDEtiqueta.QtdOriginalEtiquetas := EQtdProduto.AsInteger;
  VprDEtiqueta.QtdProduto := EQtdProduto.AsInteger;
  VprDEtiqueta.CodCor := ECor.AInteiro;
  VprDEtiqueta.NomCor := LNomCor.caption;
  VprEtiquetas.add(VprDEtiqueta);
  Grade.CarregaGrade;

  VprDProduto := TRBDProduto.cria;
  VprDProduto.CodEmpresa := VARIA.CodigoEmpresa;
  VprDProduto.CodEmpFil := Varia.CodigoEmpFil;
  EProduto.Clear;
  ECor.Clear;
  EQtdProduto.Clear;
  ActiveControl := EProduto;
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.GradeCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDEtiqueta := TRBDEtiquetaProduto(VprEtiquetas.Items[VpaLinha-1]);
  Grade.Cells[1,VpaLinha] := VprDEtiqueta.Produto.CodProduto;
  Grade.Cells[2,VpaLinha] := VprDEtiqueta.Produto.NomProduto;
  if VprDEtiqueta.CodCor <> 0 then
    Grade.Cells[3,VpaLinha] := IntTosTr(VprDEtiqueta.CodCor)
  else
    Grade.Cells[3,VpaLinha] := '';
  Grade.Cells[4,VpaLinha] := VprDEtiqueta.NomCor;
  Grade.Cells[5,VpaLinha] :=  IntToStr(VprDEtiqueta.QtdEtiquetas);
end;

{******************************************************************************}
procedure TFImpEtiquetaTermicaProduto.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.showmodal;
  FCores.free;
  Localiza.AtualizaConsulta;
end;

procedure TFImpEtiquetaTermicaProduto.EProdutoCadastrar(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  FNovoProdutoPro.NovoProduto('');
  FNovoProdutoPro.free;
  Localiza.AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImpEtiquetaTermicaProduto]);
end.
