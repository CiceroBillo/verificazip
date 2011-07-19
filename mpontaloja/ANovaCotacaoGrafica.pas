unit ANovaCotacaoGrafica;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Mask, numericos, UnDados,
  Buttons, UnCotacaoGrafica;

type
  TFNovaCotacaoGrafica = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    EQtdCorFrente: Tnumerico;
    Label1: TLabel;
    EQtdCorVerso: Tnumerico;
    Label2: TLabel;
    Label3: TLabel;
    EValAcerto: Tnumerico;
    Label4: TLabel;
    EValTotal: Tnumerico;
    EAltura: Tnumerico;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ELargura: Tnumerico;
    Label8: TLabel;
    Label9: TLabel;
    EQtdCopias: Tnumerico;
    BitBtn1: TBitBtn;
    BCalcular: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCalcularClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    VprDCotacao : TRBDCotacaoGrafica;
    VprAcao : Boolean;
    FunCotacaoGrafica : TRBFuncoesCotacaoGrafica;
    procedure CarDClasse;
    procedure CarValTotalTela;
    procedure CalculaCotacao;
  public
    { Public declarations }
     function NovaCotacao : Boolean;
  end;

var
  FNovaCotacaoGrafica: TFNovaCotacaoGrafica;

implementation

uses APrincipal, Constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaCotacaoGrafica.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDCotacao := TRBDCotacaoGrafica.cria;
  FunCotacaoGrafica := TRBFuncoesCotacaoGrafica.cria;
  VprAcao := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaCotacaoGrafica.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDCotacao.free;
  FunCotacaoGrafica.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovaCotacaoGrafica.NovaCotacao : Boolean;
begin
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaCotacaoGrafica.CarDClasse;
begin
  with VprDCotacao do
  begin
    QtdCorFrente := EQtdCorFrente.AsInteger;
    QtdCorVerso := EQtdCorVerso.AsInteger;
    Altura := EAltura.AsInteger;
    Largura := ELargura.AsInteger;
    QtdCopias := EQtdCopias.AsInteger;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacaoGrafica.CarValTotalTela;
begin
  EValAcerto.AValor := VprDCotacao.ValAcerto;
  EValTotal.AValor := VprDCotacao.ValTotal;
end;

{******************************************************************************}
procedure TFNovaCotacaoGrafica.CalculaCotacao;
var
  VpfResultado : String;
begin
  CarDClasse;
  VpfResultado := FunCotacaoGrafica.CalculaCotacao(VprDCotacao);
  if VpfResultado <> '' then
    aviso(vpfResultado)
  else
  begin
    CarValTotalTela;
  end;

end;

{******************************************************************************}
procedure TFNovaCotacaoGrafica.BCalcularClick(Sender: TObject);
begin
  CalculaCotacao;
end;

{******************************************************************************}
procedure TFNovaCotacaoGrafica.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaCotacaoGrafica]);
end.
