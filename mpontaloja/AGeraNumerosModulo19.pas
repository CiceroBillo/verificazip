unit AGeraNumerosModulo19;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Spin, Componentes1, ExtCtrls, PainelGradiente,UnArgox,
  gbCobranca;

type
  TFGeraNumerosModulo10 = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    ENumInicial: TSpinEditColor;
    ENumFinal: TSpinEditColor;
    Label1: TLabel;
    Label2: TLabel;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
  private
    { Private declarations }
    FunArgox : TRBFuncoesArgox;
  public
    { Public declarations }
  end;

var
  FGeraNumerosModulo10: TFGeraNumerosModulo10;

implementation

uses APrincipal, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGeraNumerosModulo10.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunArgox := TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGeraNumerosModulo10.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunArgox.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFGeraNumerosModulo10.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFGeraNumerosModulo10.BGerarClick(Sender: TObject);
var
  VpfNumero : Integer;
  VpfListaNumeros : TStringList;
begin
//  if SaveDialog1.execute then
  begin
    VpfListaNumeros := TStringList.Create;
    VpfNumero := ENumInicial.Value;
    While (VpfNumero >= ENumInicial.Value) and (VpfNumero <= ENumFinal.Value) do
    begin
      VpfListaNumeros.Add(IntToStr(VpfNumero)+IntToStr(VpfNumero mod 7));
      inc(VpfNumero);
    end;
//    VpfListaNumeros.SaveToFile(SaveDialog1.FileName);
    FunArgox.ImprimeNumerosModulo10(VpfListaNumeros);
    VpfListaNumeros.Free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGeraNumerosModulo10]);
end.
