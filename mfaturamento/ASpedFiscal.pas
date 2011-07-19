unit ASpedFiscal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, StdCtrls, Buttons, Componentes1, Localizacao, ComCtrls,
  ExtCtrls, PainelGradiente, UnDados, UnSpedFiscal;

type
  TFSpedFiscal = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    StatusBar1: TStatusBar;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ECodFilial: TEditLocaliza;
    PanelColor2: TPanelColor;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    CEntradas: TCheckBox;
    CSaidas: TCheckBox;
    CConsistir: TCheckBox;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EDatInicioCloseUp(Sender: TObject);
  private
    { Private declarations }
    VprDSped : TRBDSpedFiscal;
    FunSpedFiscal : TRBFuncoesSpedFiscal;
    procedure CarDClasse;
    procedure CarDTela;
  public
    { Public declarations }
  end;

var
  FSpedFiscal: TFSpedFiscal;

implementation

uses Constantes, funData, constmsg, APrincipal, ACorrigeNotasSpedFiscal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFSpedFiscal.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunSpedFiscal := TRBFuncoesSpedFiscal.cria(FPrincipal.BaseDados);
  ECodFilial.AInteiro := Varia.CodigoEmpFil;
  ECodFilial.atualiza;
  EDatInicio.DateTime := PrimeiroDiaMesAnterior;
  EDatFim.Date := UltimoDiaMesAnterior;
  VprDSped := TRBDSpedFiscal.cria;
end;

{ **************************************************************************** }
procedure TFSpedFiscal.BFecharClick(Sender: TObject);
begin
   close;
end;

{ **************************************************************************** }
procedure TFSpedFiscal.BGerarClick(Sender: TObject);
begin
  CarDClasse;
  FunSpedFiscal.GeraSpedfiscal(VprDSped,StatusBar1);
  if (VprDSped.Incosistencias.Count > 0) then
  begin
    VprDSped.Incosistencias.SaveToFile('c:\InconsistenciasSped.txt');
    StatusBar1.Panels[0].Text := 'Foram gerados '+IntToStr(VprDSped.Incosistencias.Count)+' inconsistencias no arquivo "c:\Inconsistencias.txt"';
  end
  else
  begin
    VprDSped.Arquivo.SaveToFile('c:\A_spedeficacia.txt');
    StatusBar1.Panels[0].Text := 'Arquivo "c:\A_spedeficacia.txt" gerado com sucesso';
  end;
end;

procedure TFSpedFiscal.BitBtn1Click(Sender: TObject);
begin
  CarDClasse;
  FCorrigeNotasSpedFiscal := TFCorrigeNotasSpedFiscal.criarSDI(Application,'',FPrincipal.VerificaPermisao('FCorrigeNotasSpedFiscal'));
  FCorrigeNotasSpedFiscal.CorrigeNotas(VprDSped);
  FCorrigeNotasSpedFiscal.free;
  CarDTela;
end;

{ **************************************************************************** }
procedure TFSpedFiscal.CarDClasse;
begin
  VprDSped.free;
  VprDSped := TRBDSpedFiscal.cria;
  VprDSped.Codfilial := ECodFilial.AInteiro;
  VprDSped.DatInicio := EDatInicio.Date;
  VprDSped.DatFinal := EDatFim.Date;
  VprDSped.CodFinalidade := cfRemessaOriginal;
  VprDSped.IndEntradas := CEntradas.Checked;
  VprDSped.IndSaidas := CSaidas.Checked;
  VprDSped.IndConsistirDados := CConsistir.Checked;
end;

procedure TFSpedFiscal.CarDTela;
begin
  EDatInicio.Date := VprDSped.DatInicio;
  EDatFim.Date := VprDSped.DatFinal;
  ECodFilial.AInteiro := VprDSped.CodFilial;
  ECodFilial.Atualiza;
end;

procedure TFSpedFiscal.EDatInicioCloseUp(Sender: TObject);
begin
  if EDatFim.Date < EDatInicio.Date then
  begin
    EDatFim.Date := UltimoDiaMes(EDatInicio.date);
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFSpedFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunSpedFiscal.free;
  VprDSped.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFSpedFiscal]);
end.
