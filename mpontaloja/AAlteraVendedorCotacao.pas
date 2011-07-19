unit AAlteraVendedorCotacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Buttons, StdCtrls, Localizacao, UnCotacao, UnDadosProduto;

type
  TFAlteraVendedorCotacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    ConsultaPadrao1: TConsultaPadrao;
    EVendedor: TEditLocaliza;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprPreposto : Boolean;
    VprAcao : Boolean;
    VprDCotacao : TRBdOrcamento;
  public
    { Public declarations }
    function AlteraVendedor(VpaDCotacao : TRBDorcamento) : Boolean;
    function AlteraPreposto(VpaDCotacao : TRBDorcamento) :Boolean;
  end;

var
  FAlteraVendedorCotacao: TFAlteraVendedorCotacao;

implementation

uses APrincipal, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraVendedorCotacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  VprPreposto := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraVendedorCotacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFAlteraVendedorCotacao.AlteraVendedor(VpaDCotacao : TRBDorcamento) : Boolean;
begin
  VprDCotacao := VpaDCotacao;
  EVendedor.ainteiro := VprDCotacao.CodVendedor;
  EVendedor.Atualiza;
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraVendedorCotacao.AlteraPreposto(VpaDCotacao : TRBDorcamento) :Boolean;
begin
  VprPreposto := true;
  VprDCotacao := VpaDCotacao;
  Label11.Caption := 'Preposto : ';
  PainelGradiente1.Caption := '   Altera Preposto   ';
  EVendedor.ainteiro := VprDCotacao.CodPreposto;
  EVendedor.Atualiza;
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFAlteraVendedorCotacao.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFAlteraVendedorCotacao.BGravarClick(Sender: TObject);
begin
  if (EVendedor.AInteiro = 0) and not VprPreposto then
  begin
    aviso('VENDEDOR NÃO PREENCHIDO!!!'#13'É necessário preencher o código do vendedor.');
  end
  else
  begin
    if VprPreposto then
    begin
      VprDCotacao.CodPreposto := EVendedor.Ainteiro;
      Funcotacao.AlteraPreposto(VprDCotacao);
    end
    else
    begin
      VprDCotacao.CodVendedor := EVendedor.Ainteiro;
      Funcotacao.AlteraVendedor(VprDCotacao);
    end;
    VprAcao := true;
    close;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraVendedorCotacao]);
end.
