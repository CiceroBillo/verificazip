unit ATipoTransferenciaCaixa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnCaixa;

type
  TFTipoTransferenciaCaixa = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    CInterno: TRadioButton;
    CExterno: TRadioButton;
    OpenDialog1: TOpenDialog;
    CImportar: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprSeqCaixa : Integer;
    VprNumConta : String;
  public
    { Public declarations }
    function TransferenciaCaixa(VpaSeqCaixa : Integer; VpaNumConta : String):boolean;
  end;

var
  FTipoTransferenciaCaixa: TFTipoTransferenciaCaixa;

implementation

uses APrincipal, ANovaTransferencia, ANovaTransferenciaExterna, constmsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFTipoTransferenciaCaixa.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
end;

function TFTipoTransferenciaCaixa.TransferenciaCaixa(VpaSeqCaixa : Integer; VpaNumConta : String):boolean;
begin
  VprNumConta := VpaNumConta;
  VprSeqCaixa := VpaSeqCaixa;
  ShowModal;
  Result := VprAcao;
end;

{ *************************************************************************** }
procedure TFTipoTransferenciaCaixa.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

procedure TFTipoTransferenciaCaixa.BOkClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if CInterno.Checked then
  begin
    FNovaTransferencia := TFNovaTransferencia.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaTransferencia'));
    if FNovaTransferencia.TransferenciaCaixa(VprNumConta) then
      close;
    FNovaTransferencia.free;
  end
  else
    if CExterno.Checked then
    begin
      FNovaTransferenciaExterna := TFNovaTransferenciaExterna.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaTransferenciaExterna'));
      if FNovaTransferenciaExterna.NovaTransferencia(VprSeqCaixa) then
        close;
      FNovaTransferenciaExterna.free;
    end
    else
      if CImportar.Checked then
      begin
        if OpenDialog1.Execute then
        begin
          VpfResultado := FunCaixa.ImportaArquivoTransferencia(VprSeqCaixa,OpenDialog1.FileName);
          if VpfResultado <> '' then
            aviso(VpfResultado)
          else
            close;
      end;
      end
end;

procedure TFTipoTransferenciaCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoTransferenciaCaixa]);
end.
