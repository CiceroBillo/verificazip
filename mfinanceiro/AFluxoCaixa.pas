unit AFluxoCaixa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, AxCtrls, OleCtrls,UnFluxoCaixa,
  StdCtrls, Spin, Buttons, EditorImagem, UnDadosCR, Grids, CGrades, Localizacao,
  UnRave;

type
  TFFluxoCaixa = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PFormatos: TCorPainelGra;
    BitBtn3: TBitBtn;
    PanelColor5: TPanelColor;
    BitBtn4: TBitBtn;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    SCorFonteCaixa: TShape;
    Label15: TLabel;
    SCorFundoCaixa: TShape;
    Label16: TLabel;
    SCorNegativo: TShape;
    ETamFonte: TSpinEditColor;
    ENomFonte: TComboBoxColor;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label10: TLabel;
    ELarLinha: TSpinEditColor;
    EAltLinha: TSpinEditColor;
    CImpPretoBranco: TCheckBox;
    BCofiguraImpressora: TBitBtn;
    GroupBox3: TGroupBox;
    Label19: TLabel;
    SCorFundoCR: TShape;
    Label20: TLabel;
    SCorFonteTituloCR: TShape;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    SCorFundoTituloCP: TShape;
    Label5: TLabel;
    SCorFonteCP: TShape;
    Cor: TCor16;
    Label1: TLabel;
    SCorFundoTituloCR: TShape;
    Label2: TLabel;
    SCorFonteCR: TShape;
    SCorFonteTituloCP: TShape;
    Label6: TLabel;
    PanelColor3: TPanelColor;
    BImprime: TBitBtn;
    BDetalhes: TBitBtn;
    BNivel: TBitBtn;
    BSalvar: TBitBtn;
    BExpandir: TBitBtn;
    BitBtn9: TBitBtn;
    BSuprimir: TBitBtn;
    BitBtn5: TBitBtn;
    PFiltros: TPanelColor;
    BGerarFluxo: TBitBtn;
    GPeriodo: TGroupBox;
    Label14: TLabel;
    Label17: TLabel;
    EMes: TSpinEditColor;
    EAno: TSpinEditColor;
    CDiario: TRadioButton;
    CMensal: TRadioButton;
    CClientesConfiaveis: TCheckBox;
    SCorFundoCP: TShape;
    Label18: TLabel;
    Grade: TRBStringGridColor;
    BMostrarFiltros: TSpeedButton;
    EFilial: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label7: TLabel;
    Label21: TLabel;
    CContasAPagarProrrogado: TCheckBox;
    zoom: TSpinEditColor;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure SCorFonteCaixaMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure GradeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SCorFonteCPContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure GradeDblClick(Sender: TObject);
    procedure BMostrarFiltrosClick(Sender: TObject);
    procedure BGerarFluxoClick(Sender: TObject);
    procedure BImprimeClick(Sender: TObject);
  private
    { Private declarations }
    VprDFluxo : TRBDFluxoCaixaCorpo;
    FunFluxoCaixa : TRBFuncoesFluxoCaixa;
    FunRave : TRBFunRave;
    procedure InicializaTela;
    procedure InicializaGrade;
    procedure CarDClasse;
  public
    { Public declarations }
    function FluxoCaixaGeralDiario(VpaMes, VpaAno : Integer):Boolean;
    function FluxoCaixaDiario(VpaMes, VpaAno : Integer):Boolean;
  end;

var
  FFluxoCaixa: TFFluxoCaixa;

implementation

uses APrincipal,FunData, AConsultaParcelasCRFluxoCaixa, AChequesOO;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFluxoCaixa.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDFluxo := TRBDFluxoCaixaCorpo.cria;
  FunRave := TRBFunRave.cria(FPrincipal.BaseDados);
  FunFluxoCaixa := TRBFuncoesFluxoCaixa.cria(FPrincipal.BaseDados);
  InicializaTela;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFluxoCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDFluxo.free;
  FunFluxoCaixa.free;
  FunRave.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFFluxoCaixa.InicializaGrade;
begin
  CarDClasse;
//D5  FunFluxoCaixa.LimpaFluxo(grade);
  FunFluxoCaixa.CarregaCores(SCorFonteCaixa.Brush.Color,SCorFundoCaixa.Brush.Color,SCorNegativo.Brush.Color,SCorFonteTituloCR.Brush.Color,
                             SCorFonteCR.Brush.Color,SCorFundoTituloCR.Brush.Color,SCorFundoCR.Brush.Color,SCorFonteCP.Brush.Color,SCorFundoCP.Brush.Color,
                             SCorFonteTituloCP.Brush.Color,SCorFundoTituloCP.Brush.Color,
                             ENomFonte.Text,ETamFonte.Value,EAltLinha.Value);
  FunFluxoCaixa.InicializaFluxoDiario(Grade,VprDFluxo);
end;

{******************************************************************************}
procedure TFFluxoCaixa.InicializaTela;
begin
  ENomFonte.Items := screen.Fonts;
  ENomFonte.Text := 'Arial';
end;


{******************************************************************************}
procedure TFFluxoCaixa.GradeDblClick(Sender: TObject);
var
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDDia : TRBDFluxoCaixaDia;
begin
  if Grade.Col = ColSaldoAnterior then
  begin
    if (Grade.Row = VprDFluxo.LinTotalAcumulado - 1) then
    begin
      FConsultaParcelasCRFluxoCaixa := TFConsultaParcelasCRFluxoCaixa.CriarSDI(Self,'',true);
      FConsultaParcelasCRFluxoCaixa.ConsultaParcelasFluxo(VprDFluxo.ParcelasSaldoAnterior);
      FConsultaParcelasCRFluxoCaixa.Free;
    end
    else
    begin
      VpfDConta := FunFluxoCaixa.RContaCaixa(Grade.Row,Grade.Col,VprDFluxo);
      if VpfDConta <> nil then
      begin
        if (Grade.Row = VpfDConta.LinContasReceberPrevisto)then//mostra as parcelas do saldo anterior da conta;
        begin
          FConsultaParcelasCRFluxoCaixa := TFConsultaParcelasCRFluxoCaixa.CriarSDI(Self,'',true);
          FConsultaParcelasCRFluxoCaixa.ConsultaParcelasFluxo(VpfDConta.ParcelasSaldoAnterior);
        end
        else
          if (Grade.Row = VpfDConta.LinContasAPagar)then//mostra as parcelas do saldo anterior da conta;
          begin
            FConsultaParcelasCRFluxoCaixa := TFConsultaParcelasCRFluxoCaixa.CriarSDI(Self,'',true);
            FConsultaParcelasCRFluxoCaixa.ConsultaParcelasFluxo(VpfDConta.ParcelasSaldoAnteriorCP);
          end
          else
            if (Grade.Row = VpfDConta.LinChequesaCompensarCR)then//mostra as parcelas do saldo anterior da conta;
            begin
              FChequesOO := TFChequesOO.criarSDI(Application,'',FPrincipal.VerificaPermisao('FChequesOO'));
              FChequesOO.ConsultaCheques(VpfDConta.ChequeCRSaldoAnterior);
              FChequesOO.hide;
              FChequesOO.ShowModal;
              FChequesOO.free;
            end
            else
              if (Grade.Row = VpfDConta.LinChequesaCompensarCP)then//mostra as parcelas do saldo anterior da conta;
              begin
                FChequesOO := TFChequesOO.criarSDI(Application,'',FPrincipal.VerificaPermisao('FChequesOO'));
                FChequesOO.ConsultaCheques(VpfDConta.ChequeCPSaldoAnterior);
                FChequesOO.hide;
                FChequesOO.ShowModal;
                FChequesOO.free;
              end;
      end;
    end;
  end
  else
  begin
    VpfDDia := FunFluxoCaixa.RDia(Grade.Row,Grade.Col,VprDFluxo);
    if VpfDDia <> nil then
    begin
      if FunFluxoCaixa.LinhaParcelasContasAReceber(Grade.Row,VprDFluxo) then
      begin//mostra as parcelas docontas a receber;
        FConsultaParcelasCRFluxoCaixa := TFConsultaParcelasCRFluxoCaixa.CriarSDI(Self,'',true);
        FConsultaParcelasCRFluxoCaixa.ConsultaParcelasFluxo(VpfDDia);
        FConsultaParcelasCRFluxoCaixa.Free;
      end
      else
        if FunFluxoCaixa.LinhaParcelasContasAReceberDuvidoso(Grade.Row,VprDFluxo) then
        begin//mostra as parcelas docontas a receber;
          FConsultaParcelasCRFluxoCaixa := TFConsultaParcelasCRFluxoCaixa.CriarSDI(Self,'',true);
          FConsultaParcelasCRFluxoCaixa.ConsultaParcelasFluxo(VpfDDia.ParcelasDuvidosas);
          FConsultaParcelasCRFluxoCaixa.Free;
        end
        else
          if FunFluxoCaixa.LinhaParcelasContasaPagar(Grade.Row,VprDFluxo) then
          begin//mostra as parcelas docontas a receber;
            FConsultaParcelasCRFluxoCaixa := TFConsultaParcelasCRFluxoCaixa.CriarSDI(Self,'',true);
            FConsultaParcelasCRFluxoCaixa.ConsultaParcelasFluxo(VpfDDia.ParcelasCP);
            FConsultaParcelasCRFluxoCaixa.Free;
          end
          else
            if FunFluxoCaixa.LinhaChequeCR(Grade.Row,VprDFluxo) then
            begin//mostra as parcelas docontas a receber;
              FChequesOO := TFChequesOO.criarSDI(Application,'',FPrincipal.VerificaPermisao('FChequesOO'));
              FChequesOO.ConsultaCheques(VpfDDia.ChequesCR);
              FChequesOO.hide;
              FChequesOO.ShowModal;
              FChequesOO.free;
            end
            else
              if FunFluxoCaixa.LinhaChequeCP(Grade.Row,VprDFluxo) then
              begin//mostra as parcelas docontas a receber;
                FChequesOO := TFChequesOO.criarSDI(Application,'',FPrincipal.VerificaPermisao('FChequesOO'));
                FChequesOO.ConsultaCheques(VpfDDia.ChequesCP);
                FChequesOO.hide;
                FChequesOO.ShowModal;
                FChequesOO.free;
              end
    end;
  end;
end;

{******************************************************************************}
procedure TFFluxoCaixa.GradeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  VpfLinha,VpfColuna : Integer;
  VpfFormatacaoCelula : TRBFormatacaoCelula;
begin
  exit;
  Grade.MouseToCell(x,y,VpfColuna,VpfLinha);
  VpfFormatacaoCelula := Grade.FormatacaoCelula[VpfLinha,VpfColuna,true];
  VpfFormatacaoCelula.CorFundo := clRed;
  VpfFormatacaoCelula.IndMostrarFormatacao := not VpfFormatacaoCelula.IndMostrarFormatacao;
end;

{******************************************************************************}
procedure TFFluxoCaixa.CarDClasse;
begin
  VprDFluxo.IndDiario := CDiario.Checked;
  VprDFluxo.Mes := EMes.Value;
  VprDFluxo.Ano := EAno.Value;
  VprDFluxo.CodFilial := EFilial.AInteiro;
  VprDFluxo.IndSomenteClientesQuePagamEmDia := CClientesConfiaveis.Checked;
  if CDiario.Checked then
  begin
    VprDFluxo.DatInicio := MontaData(1,EMes.Value,EAno.Value);
    VprDFluxo.DatFim :=UltimoDiaMes(VprDFluxo.DatInicio);
  end
  else
  begin
    VprDFluxo.DatInicio := MontaData(1,1,EAno.Value);
    VprDFluxo.DatFim :=MontaData(31,12,EAno.Value);
  end;
  VprDFluxo.IndMostrarContasaPagarProrrogado := CContasAPagarProrrogado.Checked;
end;

{******************************************************************************}
function TFFluxoCaixa.FluxoCaixaDiario(VpaMes, VpaAno : Integer):boolean;
begin
  CDiario.Checked := true;
  EMes.Value := VpaMes;
  EAno.Value := VpaAno;
  VprDFluxo.IndMostraContasSeparadas := true;
  InicializaGrade;
  FunFluxoCaixa.CarFluxoCaixa(Grade,VprDFluxo);
  ShowModal;
end;

{******************************************************************************}
function TFFluxoCaixa.FluxoCaixaGeralDiario(VpaMes, VpaAno: Integer): Boolean;
begin
  CDiario.Checked := true;
  EMes.Value := VpaMes;
  EAno.Value := VpaAno;
  VprDFluxo.IndMostraContasSeparadas := false;
  InicializaGrade;
  FunFluxoCaixa.CarFluxoCaixa(Grade,VprDFluxo);
  ShowModal;
end;

{******************************************************************************}
procedure TFFluxoCaixa.BGerarFluxoClick(Sender: TObject);
begin
  InicializaGrade;
  FunFluxoCaixa.CarFluxoCaixa(Grade,VprDFluxo);
end;

{******************************************************************************}
procedure TFFluxoCaixa.BImprimeClick(Sender: TObject);
begin
  FunRave.ImprimeFluxoDiario(VprDFluxo);
end;

procedure TFFluxoCaixa.BitBtn1Click(Sender: TObject);
begin
//  grade.FormatAlignmentDlg;
{D5  Grade.SelStartCol := 5;
  Grade.SelEndCol := 5;
  Grade.SelStartRow := 5;
  Grade.SelEndRow := 5;
  Grade.SetPattern(2,SCorFundoCaixa.Brush.Color,SCorFundoCaixa.Brush.Color);
  Grade.SetFont( 'Arial',10,true , false, false, false,
                SCorFonteCaixa.Brush.Color, true,false);
  grade.FormatFontDlg;
  grade.SetAlignment(F1HAlignCenter,false,F1HAlignCenter,0);
  grade.SetBorder(1,-1,1,1,1,1,clRed,clRed,clRed,clRed,clRed);
}
end;

{******************************************************************************}
procedure TFFluxoCaixa.SCorFonteCaixaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  VpfShape : TShape;
begin
  VpfShape := TShape(Sender);
  if Cor.execute(VpfShape.Brush.color) then
  begin
    VpfShape.Brush.Color := Cor.ACor;
  end;
end;

procedure TFFluxoCaixa.SCorFonteCPContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

end;

{******************************************************************************}
procedure TFFluxoCaixa.BitBtn5Click(Sender: TObject);
begin
  PFormatos.Visible :=True;
end;

{******************************************************************************}
procedure TFFluxoCaixa.BitBtn4Click(Sender: TObject);
begin
  InicializaGrade;
  PFormatos.Visible := False;
  BGerarFluxo.Click;
end;

{******************************************************************************}
procedure TFFluxoCaixa.BitBtn9Click(Sender: TObject);
begin
  close;
end;

procedure TFFluxoCaixa.BMostrarFiltrosClick(Sender: TObject);
begin
  PFiltros.Visible := BMostrarFiltros.Down;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFluxoCaixa]);
end.
