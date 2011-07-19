unit ACancelaContratos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, ComCtrls, Componentes1, ExtCtrls, PainelGradiente, UnContrato;

type
  TFCancelaContrato = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    EFimVigencia: TCalendario;
    BitBtn1: TBitBtn;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    FunContrato : TRBFuncoesContrato;
  public
    { Public declarations }
  end;

var
  FCancelaContrato: TFCancelaContrato;

implementation

uses APrincipal,constmsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFCancelaContrato.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  EFimVigencia.DateTime := date;
end;

{ *************************************************************************** }
procedure TFCancelaContrato.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCancelaContrato.BitBtn1Click(Sender: TObject);
var
  VpfQtdCancelados : Integer;
begin
  VpfQtdCancelados := FunContrato.CancelaContratosVigenciaVencida(EFimVigencia.Date);
  aviso(IntToStr(VpfQtdCancelados)+ ' contratos cancelados');
end;

procedure TFCancelaContrato.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunContrato.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCancelaContrato]);
end.
