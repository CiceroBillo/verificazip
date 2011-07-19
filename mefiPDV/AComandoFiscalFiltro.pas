unit AComandoFiscalFiltro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, StdCtrls, Mask, numericos,
  ComCtrls, Componentes1, Buttons, ExtCtrls, PainelGradiente, UnDados, UnECF;

type
  TFComandoFiscalFiltro = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PPeriodo: TPanelColor;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    PCRZ: TPanelColor;
    ECRZInicial: Tnumerico;
    ECRZFinal: Tnumerico;
    Label3: TLabel;
    Label4: TLabel;
    PCOO: TPanelColor;
    Label5: TLabel;
    Label6: TLabel;
    ECOOInicial: Tnumerico;
    ECOOFinal: Tnumerico;
    PTipoFiltro: TPanelColor;
    Label7: TLabel;
    CPeriodo: TRadioButton;
    CCRZ: TRadioButton;
    CCOO: TRadioButton;
    PanelColor1: TPanelColor;
    CGerarArquivo: TCheckBox;
    PNumeroECF: TPanelColor;
    Label8: TLabel;
    ENumeroECF: TComboBoxColor;
    PFormatoArquivo: TPanelColor;
    CSintegra: TRadioButton;
    CSped: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOkClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure CPeriodoClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDFiltro : TRBDFiltroMenuFiscalECF;
    FunECF :TRBFuncoesECF;
    procedure ConfiguraTela;
    procedure CarDClasse;
    function DadosValidos : string;
  public
    { Public declarations }
    function FiltraMenuFiscal(VpaDFiltro : TRBDFiltroMenuFiscalECF):boolean;
  end;

var
  FComandoFiscalFiltro: TFComandoFiscalFiltro;

implementation

uses APrincipal, FunData, FunObjeto,ConstMsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFComandoFiscalFiltro.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunECF := TRBFuncoesECF.cria(nil,FPrincipal.BaseDados);
  VprAcao := false;
  EDatInicio.Date := PrimeiroDiaMes(date);
  EDatFim.date := UltimoDiaMes(date);
end;

{ *************************************************************************** }
procedure TFComandoFiscalFiltro.BCancelarClick(Sender: TObject);
begin
  close;
end;

{ *************************************************************************** }
procedure TFComandoFiscalFiltro.BOkClick(Sender: TObject);
Var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado <> '' then
  begin
    aviso(VpfResultado);
  end
  else
  begin
    VprAcao := true;
    close;
  end;
end;

{******************************************************************************}
procedure TFComandoFiscalFiltro.CarDClasse;
begin
  VprDFiltro.DatInicio := EDatInicio.Date;
  VprDFiltro.DatFim := EDatFim.Date;
  VprDFiltro.NumIntervaloCRZInicio := ECRZInicial.AsInteger;
  VprDFiltro.NumIntervaloCRZFim := ECRZFinal.AsInteger;
  VprDFiltro.NumIntervaloCOOInicio := ECOOInicial.AsInteger;
  VprDFiltro.NumIntervaloCOOFim := ECOOFinal.AsInteger;
  VprDFiltro.IndGerarArquivo := CGerarArquivo.Checked;
end;

{******************************************************************************}
procedure TFComandoFiscalFiltro.ConfiguraTela;
begin
  if VprDFiltro.IndMostrarNumECF then
  begin
    FunECF.CarNumerosECF(ENumeroECF.Items);
    PNumeroECF.Visible := true;
    PPeriodo.Visible := true;
    PTipoFiltro.Visible := false;
  end;
  CPeriodo.Visible := VprDFiltro.IndMostrarPeriodo;
  CCRZ.Visible := VprDFiltro.IndMostrarCRZ;
  CCOO.Visible := VprDFiltro.IndMostrarCOO;
  CGerarArquivo.Visible := VprDFiltro.IndMostrarGerarArquivo;
  PFormatoArquivo.Visible :=  VprDFiltro.IndMostrarFormatoArquivo;
  if PFormatoArquivo.Visible then
    Self.Height := Self.Height + PFormatoArquivo.Height;
end;

{******************************************************************************}
procedure TFComandoFiscalFiltro.CPeriodoClick(Sender: TObject);
begin
  AlterarVisibleDet([PPeriodo,PCRZ,PCOO],false);
  case TCheckBox(Sender).Tag of
    1 : PPeriodo.Visible := true;
    2 : PCRZ.Visible := true;
    3 : PCOO.Visible := true;
  end;
  Self.Height := PainelGradiente1.Top+ PainelGradiente1.Height++PCRZ.Height+PanelColor2.Height+PTipoFiltro.Height+PTipoFiltro.Height;
end;

{******************************************************************************}
function TFComandoFiscalFiltro.DadosValidos: string;
begin
  result := '';
  if VprDFiltro.IndMostrarNumECF then
  begin
    if ENumeroECF.ItemIndex = -1 then
      result := 'NÚMERO DO ECF NÃO PREENCHIDO!!!'#13'É necessário preencher o numero de serie do equipamento ECF.';
  end;
end;

{ *************************************************************************** }
function TFComandoFiscalFiltro.FiltraMenuFiscal(VpaDFiltro: TRBDFiltroMenuFiscalECF): boolean;
begin
  VprDFiltro := VpaDFiltro;
  CPeriodoClick(CPeriodo);
  ConfiguraTela;
  showmodal;
  result :=  vprAcao;
  if result then
  begin
    VpaDFiltro.DatInicio := EDatInicio.Date;
    VpaDFiltro.DatFim := EDatFim.Date;
    VpaDFiltro.NumIntervaloCRZInicio := ECRZInicial.AsInteger;
    VpaDFiltro.NumIntervaloCRZFim := ECRZFinal.AsInteger;
    VpaDFiltro.IndGerarArquivo:= CGerarArquivo.Checked;
    VpaDFiltro.NumSerieECF := ENumeroECF.Text;
    if CPeriodo.Checked then
      VpaDFiltro.TipFiltro := tfPeriodo
    else
      if CCRZ.Checked then
        VpaDFiltro.TipFiltro := tfCRZ
      else
        if CCOO.Checked then
          VpaDFiltro.TipFiltro := tfCOO;
    if CSintegra.Checked then
      VpaDFiltro.TipFormatoArquivo := faSintegra
    else
      VpaDFiltro.TipFormatoArquivo := faSped;
  end;
end;

{ *************************************************************************** }
procedure TFComandoFiscalFiltro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunECF.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFComandoFiscalFiltro]);
end.
