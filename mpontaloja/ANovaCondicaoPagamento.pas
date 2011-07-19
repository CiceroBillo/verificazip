unit ANovaCondicaoPagamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, DBKeyViolation, constantes,
  ComCtrls, Grids, CGrades, Mask, numericos, UnDadosCR, UnCondicaoPagamento,
  Localizacao;

type
  TFNovaCondicaoPagamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    Paginas: TPageControl;
    PGeral: TTabSheet;
    PParcela1: TTabSheet;
    PanelColor3: TPanelColor;
    ENome: TEditColor;
    Label1: TLabel;
    EQtdParcelas: Tnumerico;
    Label2: TLabel;
    GPercentual: TRBStringGridColor;
    Label3: TLabel;
    PParcela: TPanelColor;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    COpcao2: TRadioButton;
    Label5: TLabel;
    COpcao3: TRadioButton;
    COpcao4: TRadioButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    EQtdDias: Tnumerico;
    LTexto3: TLabel;
    LTexto31: TLabel;
    EDiaFixo: Tnumerico;
    LTexto4: TLabel;
    LTexto41: TLabel;
    LTexto42: TLabel;
    LTexto43: TLabel;
    EDatFixa: TMaskEditColor;
    Label14: TLabel;
    numerico2: Tnumerico;
    Panel1: TPanelColor;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Label6: TLabel;
    Label9: TLabel;
    EFormaPagamento: TRBEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure EQtdParcelasExit(Sender: TObject);
    procedure EQtdParcelasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GPercentualCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GPercentualDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GPercentualMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure COpcao2Click(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure ENomeChange(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprOperacao : TRBDOperacaoCadastro;
    VprDCondicaoPagamento : TRBDCondicaoPagamento;
    VprDPercentual : TRBDParcelaCondicaoPagamento;
    FunCondicaoPagamento : TRBFuncoesCondicaoPagamento;
    procedure HabilitaCampos(VpaDono : TWinControl);
    procedure EstadoBotoes(VpaEstado : boolean);
    procedure InicializaTela;
    procedure CarTitulosGrade;
    procedure CriaParcelas;
    procedure CriaPaginasParcelas(VpaQtdParcelas : Integer);
    procedure CarDClasse;
    procedure CarDParcelas;
    procedure CarDTela;
    procedure CarDParcelaTela;
  public
    { Public declarations }
    function NovaCondicaoPagamento: boolean;
    function AlteraCondicaoPagamento(VpaCodCondicaoPagamento : Integer):Boolean;
  end;

var
  FNovaCondicaoPagamento: TFNovaCondicaoPagamento;

implementation

uses APrincipal, FunObjeto, ConstMsg, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaCondicaoPagamento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunCondicaoPagamento := TRBFuncoesCondicaoPagamento.cria(FPrincipal.BaseDados);
  VprAcao := false;
  CarTitulosGrade;
  VprDCondicaoPagamento := TRBDCondicaoPagamento.cria;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.GPercentualCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDPercentual := TRBDParcelaCondicaoPagamento(VprDCondicaoPagamento.Parcelas.Items[VpaLinha-1]);
  GPercentual.Cells[1,VpaLinha]:= InttoStr(VprDPercentual.NumParcela);
  GPercentual.Cells[2,VpaLinha]:= FormatFloat('0.00',VprDPercentual.PerParcela);
end;

procedure TFNovaCondicaoPagamento.GPercentualDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
var
  VpfLinhaAtual : Integer;
begin
  VpfLinhaAtual := GPercentual.Row;
  VpaValidos := true;
  if (GPercentual.Cells[2,GPercentual.ALinha] = '') then
  begin
    VpaValidos := false;
    aviso('PERCENTUAL NÃO PREENCHIDO!!!'#13'É necessário preencher o percentual da parcela');
    GPercentual.Col := 2;
  end;
  if VpaValidos then
  begin
    VprDPercentual.PerParcela := StrToFloat(DeletaChars(GPercentual.Cells[2,GPercentual.ALinha],'.'));
    if VprDPercentual.PerParcela = 0 then
    begin
      VpaValidos := false;
      aviso('PERCENTUAL NÃO PREENCHIDO!!!'#13'É necessário preencher o percentual da parcela');
      GPercentual.Col := 2;
    end;
    if VpaValidos then
    begin
      FunCondicaoPagamento.VerificaPercentuais(VprDCondicaoPagamento);
      GPercentual.CarregaGrade;
      GPercentual.Row := VpfLinhaAtual;
    end;
  end;
end;

procedure TFNovaCondicaoPagamento.GPercentualMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDCondicaoPagamento.Parcelas.Count >0 then
    VprDPercentual := TRBDParcelaCondicaoPagamento(VprDCondicaoPagamento.Parcelas.Items[VpaLinhaAtual-1]);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaCondicaoPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDCondicaoPagamento.Free;
  FunCondicaoPagamento.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovaCondicaoPagamento.AlteraCondicaoPagamento(VpaCodCondicaoPagamento: Integer): Boolean;
begin
  VprDCondicaoPagamento.Free;
  VprDCondicaoPagamento :=TRBDCondicaoPagamento.cria;
  FunCondicaoPagamento.CarDCondicaoPagamento(VprDCondicaoPagamento,VpaCodCondicaoPagamento);
  GPercentual.ADados := VprDCondicaoPagamento.Parcelas;
  GPercentual.CarregaGrade;
  CarDTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  Close;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFNovaCondicaoPagamento.BGravarClick(Sender: TObject);
var
  VpfResultado : string;
begin
  CarDClasse;
  VpfResultado := FunCondicaoPagamento.GravaDCondicaoPagamento(VprDCondicaoPagamento);
  if VpfResultado <> '' then
  begin
    aviso(VpfResultado);
    if VprOperacao = ocInsercao then
      VprDCondicaoPagamento.CodCondicaoPagamento := 0;
  end
  else
  begin
    VprAcao := true;
    close;
  end;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.ENomeChange(Sender: TObject);
begin
  if VprOperacao in [ocinsercao,ocedicao] then
    ValidaGravacao1.execute;
end;

procedure TFNovaCondicaoPagamento.EQtdParcelasExit(Sender: TObject);
begin
  CriaParcelas;
end;

procedure TFNovaCondicaoPagamento.EQtdParcelasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    CriaParcelas;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.HabilitaCampos(VpaDono : TWinControl);
var
  VpfNumerico : TNumerico;
  VpfCheckBox : TCheckBox;
  VpfMaskEdit : TMaskEditColor;
begin
  //opcao 1
  VpfCheckBox := TCheckBox(LocalizaComponente(VpaDono,2));
  VpfCheckBox.Enabled := TRadioButton(LocalizaComponente(VpaDono,1)).Checked;
  VpfCheckBox.Checked := VpfCheckBox.Enabled;
  TLabel(LocalizaComponente(VpaDono,3)).Enabled := VpfCheckBox.Enabled;
  TLabel(LocalizaComponente(VpaDono,4)).Enabled := VpfCheckBox.Enabled;

  //opcao 2
  VpfNumerico := TNumerico(LocalizaComponente(VpaDono,11));
  VpfNumerico.Enabled := TRadioButton(LocalizaComponente(VpaDono,10)).Checked;
  if not VpfNumerico.Enabled then
    VpfNumerico.clear;
  TLabel(LocalizaComponente(VpaDono,12)).Enabled := VpfNumerico.Enabled;
  TLabel(LocalizaComponente(VpaDono,13)).Enabled := VpfNumerico.Enabled;

  //opcao 3
  VpfNumerico := TNumerico(LocalizaComponente(VpaDono,21));
  VpfNumerico.Enabled := TRadioButton(LocalizaComponente(VpaDono,20)).Checked;
  if not VpfNumerico.Enabled then
    VpfNumerico.clear;
  TLabel(LocalizaComponente(VpaDono,22)).Enabled := VpfNumerico.Enabled;
  TLabel(LocalizaComponente(VpaDono,23)).Enabled := VpfNumerico.Enabled;

  //opcao 4
  VpfMaskEdit := TMaskEditColor(LocalizaComponente(VpaDono,31));
  VpfMaskEdit.Enabled := TRadioButton(LocalizaComponente(VpaDono,30)).Checked;
  if not VpfMaskEdit.Enabled then
    VpfMaskEdit.clear;
  TLabel(LocalizaComponente(VpaDono,32)).Enabled := VpfMaskEdit.Enabled;
  TLabel(LocalizaComponente(VpaDono,33)).Enabled := VpfMaskEdit.Enabled;
  TLabel(LocalizaComponente(VpaDono,34)).Enabled := VpfMaskEdit.Enabled;
  TLabel(LocalizaComponente(VpaDono,35)).Enabled := VpfMaskEdit.Enabled;

end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.EstadoBotoes(VpaEstado : boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.InicializaTela;
begin
  EstadoBotoes(true);

  VprDCondicaoPagamento.free;
  VprDCondicaoPagamento := TRBDCondicaoPagamento.cria;
  GPercentual.ADados := VprDCondicaoPagamento.Parcelas;
  GPercentual.CarregaGrade;
  LimpaComponentes(PanelColor1,0);
  EQtdParcelas.AsInteger := 1;
  CriaParcelas;
  Paginas.ActivePage := PGeral;
  ActiveControl := ENome;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.CarDClasse;
begin
  with VprDCondicaoPagamento do
  begin
    NomCondicaoPagamento := ENome.Text;
    QtdParcelas := EQtdParcelas.AsInteger;
  end;
  CarDParcelas;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.CarDParcelas;
Var
  Vpflaco : Integer;
  VpfPagina : TTabSheet;
  VpfDParcela : TRBDParcelaCondicaoPagamento;
  VpfNumerico : TNumerico;
  VpfMaskEdit : TMaskEditColor;
begin
  for VpfLaco := 1 to Paginas.PageCount - 1 do
  begin
    VpfDParcela := TRBDParcelaCondicaoPagamento(VprDCondicaoPagamento.Parcelas.Items[VpfLaco - 1]);
    VpfPagina := Paginas.Pages[VpfLaco];
    if TCheckBox(LocalizaComponente(VpfPagina,1)).Checked then
    begin
      VpfDParcela.TipoParcela := tpProximoMes;
      VpfDParcela.DiaFixo := 100;
    end
    else
      if TCheckBox(LocalizaComponente(VpfPagina,10)).Checked then
      begin
        VpfDParcela.TipoParcela := tpQtdDias;
        VpfNumerico := TNumerico(LocalizaComponente(VpfPagina,11));
        VpfDParcela.QtdDias := VpfNumerico.AsInteger;
      end
      else
        if TCheckBox(LocalizaComponente(VpfPagina,20)).Checked then
        begin
          VpfDParcela.TipoParcela := tpDiaFixo;
          VpfNumerico := TNumerico(LocalizaComponente(VpfPagina,21));
          VpfDParcela.DiaFixo := VpfNumerico.AsInteger;
        end
        else
          if TCheckBox(LocalizaComponente(VpfPagina,30)).Checked then
          begin
            VpfDParcela.TipoParcela := tpDataFixa;
            VpfDParcela.DatFixa := StrToDate(TMaskEditColor(LocalizaComponente(VpfPagina,31)).Text);
          end;
    VpfNumerico := TNumerico(LocalizaComponente(VpfPagina,50));
    VpfDParcela.PerAcrescimoDesconto := VpfNumerico.AValor;
    VpfDParcela.CodFormaPagamento := TRBEditLocaliza(LocalizaComponente(VpfPagina,60)).AInteiro;
    if TCheckBox(LocalizaComponente(VpfPagina,51)).Checked then
      VpfDParcela.TipAcrescimoDesconto := 'C'
    else
      VpfDParcela.TipAcrescimoDesconto := 'D';
  end;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.CarDParcelaTela;
Var
  Vpflaco : Integer;
  VpfPagina : TTabSheet;
  VpfDParcela : TRBDParcelaCondicaoPagamento;
  VpfNumerico : TNumerico;
  VpfMaskEdit : TMaskEditColor;
  VpfEditLocaliza : TRBEditLocaliza;
begin
  if VprDCondicaoPagamento.Parcelas.Count = 0 then
  begin
    VprDCondicaoPagamento.QtdParcelas := 0;
    EQtdParcelas.AsInteger := 1;
    CriaParcelas;
  end;

  CriaPaginasParcelas(VprDCondicaoPagamento.QtdParcelas);
  for VpfLaco := 1 to VprDCondicaoPagamento.Parcelas.Count  do
  begin
    VpfDParcela := TRBDParcelaCondicaoPagamento(VprDCondicaoPagamento.Parcelas.Items[VpfLaco - 1]);
    VpfPagina := Paginas.Pages[VpfLaco];
    TCheckBox(LocalizaComponente(VpfPagina,1)).Checked := false;
    TCheckBox(LocalizaComponente(VpfPagina,10)).Checked := false;
    TCheckBox(LocalizaComponente(VpfPagina,20)).Checked := false;
    TCheckBox(LocalizaComponente(VpfPagina,30)).Checked := false;
    case VpfDParcela.TipoParcela of
      tpProximoMes:
      begin
        TCheckBox(LocalizaComponente(VpfPagina,1)).Checked := true ;
      end;
      tpQtdDias:
      begin
        TCheckBox(LocalizaComponente(VpfPagina,10)).Checked := true;
        VpfNumerico := TNumerico(LocalizaComponente(VpfPagina,11));
        VpfNumerico.AsInteger := VpfDParcela.QtdDias;
      end;
      tpDiaFixo:
      begin
        TCheckBox(LocalizaComponente(VpfPagina,20)).Checked := true;
        VpfNumerico := TNumerico(LocalizaComponente(VpfPagina,21));
        VpfNumerico.AsInteger := VpfDParcela.DiaFixo;
      end;
      tpDataFixa:
      begin
        TCheckBox(LocalizaComponente(VpfPagina,30)).Checked := true;
        TMaskEditColor(LocalizaComponente(VpfPagina,31)).Text := FormatDateTime('DD/MM/YYYY',VpfDParcela.DatFixa);
      end;
    end;
    VpfNumerico := TNumerico(LocalizaComponente(VpfPagina,50));
    VpfNumerico.AValor := VpfDParcela.PerAcrescimoDesconto;
    if VpfDParcela.TipAcrescimoDesconto = 'C' then
      TCheckBox(LocalizaComponente(VpfPagina,51)).Checked := true;
    VpfEditLocaliza := TRBEditLocaliza(LocalizaComponente(VpfPagina,60));
    VpfEditLocaliza.AInteiro := VpfDParcela.CodFormaPagamento;
    VpfEditLocaliza.Atualiza;
  end;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.CarDTela;
begin
  with VprDCondicaoPagamento do
  begin
    ENome.Text := NomCondicaoPagamento;
    EQtdParcelas.AsInteger := QtdParcelas;
  end;
  CarDParcelaTela;
  Paginas.ActivePage := PGeral;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.CarTitulosGrade;
begin
  GPercentual.Cells[1,0] := 'Parcela';
  GPercentual.Cells[2,0] := 'Percentual';
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.COpcao2Click(Sender: TObject);
begin
//  HabilitaCampos(TCheckBox(sender).parent);
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.CriaPaginasParcelas(VpaQtdParcelas: Integer);
var
  VpfLaco : Integer;
  VpfPagina : TTabSheet;
begin
  for VpfLaco  := Paginas.PageCount-1 downto 2 do
   Paginas.Pages[VpfLaco].Destroy;

  AlterarVisibleDet([COpcao3,COpcao4,EDiaFixo,LTexto3,LTexto31,LTexto4,LTexto41,LTexto42,LTexto43,EDatFixa],EQtdParcelas.AsInteger = 1);

  for Vpflaco  := 2 to VpaQtdParcelas do
  begin
    VpfPagina := TTabSheet.Create(Paginas);
    Paginas.InsertControl(VpfPagina);
    VpfPagina.PageControl := Paginas;
    VpfPagina.Caption := 'Parcela '+ IntToStr(VpfLaco);
    CopiaComponente(PParcela1,VpfPagina);
  end;
end;

{******************************************************************************}
procedure TFNovaCondicaoPagamento.CriaParcelas;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EQtdParcelas.AsInteger = 0  then
    begin
      aviso('QUANTIDADE DE PARCELAS INVÁLIDO!!!'#13+'É necessãrio digitar no mínimo 1 parcela');
      EQtdParcelas.AsInteger := VprDCondicaoPagamento.QtdParcelas;
    end
    else
    begin
      if varia.QtdParcelasCondicaoPagamento <> 0 then
      begin
        if EQtdParcelas.AsInteger > Varia.QtdParcelasCondicaoPagamento  then
        begin
          aviso('QUANTIDADE DE PARCELAS INVÁLIDA!!!!'#13'É permitido no máximo "'+IntToStr(Varia.QtdParcelasCondicaoPagamento) +'" parcelas');
          EQtdParcelas.AsInteger := 1;
        end;
      end;
      if VprDCondicaoPagamento.QtdParcelas <> EQtdParcelas.AsInteger then
      begin
        VprDCondicaoPagamento.QtdParcelas := EQtdParcelas.AsInteger;
        FunCondicaoPagamento.CriaParcelas(VprDCondicaoPagamento);
        GPercentual.CarregaGrade;
        CriaPaginasParcelas(VprDCondicaoPagamento.QtdParcelas);
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaCondicaoPagamento.NovaCondicaoPagamento: boolean;
begin
  InicializaTela;
  VprOperacao := ocInsercao;
  showmodal;
  result := VprAcao;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaCondicaoPagamento]);
end.





