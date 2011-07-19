unit ACorrigeNotasSpedFiscal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, StdCtrls, Buttons,
  Componentes1, ExtCtrls, PainelGradiente, UnSpedfiscal, ComCtrls, UnDados, Localizacao,
  Mask, numericos;

type
  TFCorrigeNotasSpedFiscal = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BCorrigir: TBitBtn;
    BFechar: TBitBtn;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ECodFilial: TEditLocaliza;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel2: TBevel;
    CRecalcularICMSeST: TCheckBox;
    CLimparIPI: TCheckBox;
    CBaseCalculoProdutosNotaEntrada: TCheckBox;
    Label7: TLabel;
    ENota: Tnumerico;
    CBaseCalculoNotaSaida: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCorrigirClick(Sender: TObject);
  private
    { Private declarations }
    VprDSpedFiscal : TRBDSpedFiscal;
    FunSpedFiscal : TRBFuncoesSpedFiscal;
    procedure CarDClasse;
    procedure CarDTela;
  public
    { Public declarations }
    procedure CorrigeNotas(VpaDSpedFiscal:TRBDSpedFiscal);
  end;

var
  FCorrigeNotasSpedFiscal: TFCorrigeNotasSpedFiscal;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFCorrigeNotasSpedFiscal.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunSpedFiscal := TRBFuncoesSpedFiscal.cria(FPrincipal.BaseDados);
end;

{ *************************************************************************** }
procedure TFCorrigeNotasSpedFiscal.BCorrigirClick(Sender: TObject);
begin
  CarDClasse;
  if CRecalcularICMSeST.Checked then
    FunSpedFiscal.CorrigeNotasValICMSeST(VprDSpedFiscal,StatusBar1);
  if CLimparIPI.Checked then
    FunSpedFiscal.CorrigeNotaLimpaIPI(VprDSpedFiscal,StatusBar1);
  if CBaseCalculoProdutosNotaEntrada.Checked then
    FunSpedFiscal.CorrigeBaseCalculoNotaEntrada(VprDSpedFiscal,StatusBar1);
  if CBaseCalculoNotaSaida.Checked then
    FunSpedFiscal.CorrigeBaseCalculoNotaSaida(VprDSpedFiscal,StatusBar1);
end;

{******************************************************************************}
procedure TFCorrigeNotasSpedFiscal.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCorrigeNotasSpedFiscal.CarDClasse;
begin
  VprDSpedFiscal.DatInicio := EDatInicio.Date;
  VprDSpedFiscal.NumNota := ENota.AsInteger;
end;

{******************************************************************************}
procedure TFCorrigeNotasSpedFiscal.CarDTela;
begin
  ECodFilial.AInteiro :=  VprDSpedFiscal.CodFilial;
  ECodFilial.Atualiza;
  EDatInicio.Date := VprDSpedFiscal.DatInicio;
  EDatFim.Date := VprDSpedFiscal.DatFinal;
end;

procedure TFCorrigeNotasSpedFiscal.CorrigeNotas(VpaDSpedFiscal: TRBDSpedFiscal);
begin
   VprDSpedFiscal := VpaDSpedFiscal;
   CarDTela;
   ShowModal;
end;

{******************************************************************************}
procedure TFCorrigeNotasSpedFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunSpedFiscal.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCorrigeNotasSpedFiscal]);
end.
