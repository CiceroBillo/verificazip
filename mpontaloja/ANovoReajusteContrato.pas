unit ANovoReajusteContrato;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Spin, Buttons, Mask,
  numericos, Db, DBTables, UnContrato;

type
  TFNovoReajusteContrato = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EMes: TSpinEditColor;
    EAno: TSpinEditColor;
    Label1: TLabel;
    Label2: TLabel;
    EIndice: Tnumerico;
    Label3: TLabel;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    VprAcao: Boolean;
    FunContrato: TRBFuncoesContrato;
  public
    function ReajustaContratos: Boolean;
  end;

var
  FNovoReajusteContrato: TFNovoReajusteContrato;

implementation

uses APrincipal,FunData,Funsql, Funstring,constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoReajusteContrato.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunContrato:= TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  EMes.Value := Mes(date);
  Eano.value := Ano(date);
  VprAcao:= False;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoReajusteContrato.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunContrato.Free;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoReajusteContrato.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFNovoReajusteContrato.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= FunContrato.ReajustaContrato(EAno.Value, EMes.Value, EIndice.AValor);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    aviso('Reajuste efetuado com sucesso');
    VprAcao:= True;
    Close;
  end;
end;

{******************************************************************************}
function TFNovoReajusteContrato.ReajustaContratos: Boolean;
begin
  ShowModal;
  Result:= VprAcao;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFNovoReajusteContrato]);
end.
