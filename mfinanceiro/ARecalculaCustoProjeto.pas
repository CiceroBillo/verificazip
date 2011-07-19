unit ARecalculaCustoProjeto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, StdCtrls, Buttons,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao;

type
  TFRecalculaCustoProjeto = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BRecalcular: TBitBtn;
    EProjeto: TRBEditLocaliza;
    LProjeto: TLabel;
    BProjeto: TSpeedButton;
    LNomProjeto: TLabel;
    Bevel1: TBevel;
    CSomenteZerados: TCheckBox;
    Label10: TLabel;
    SpeedButton2: TSpeedButton;
    EProduto: TEditLocaliza;
    LProduto: TLabel;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: string);
    procedure BRecalcularClick(Sender: TObject);
    procedure EProdutoSelect(Sender: TObject);
  private
    { Private declarations }
    VprSeqProduto : Integer;
    function DadosValidos : string;
  public
    { Public declarations }
  end;

var
  FRecalculaCustoProjeto: TFRecalculaCustoProjeto;

implementation

uses APrincipal, constmsg, UnProdutos, Constantes;

{$R *.DFM}


{ **************************************************************************** }
procedure TFRecalculaCustoProjeto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ *************************************************************************** }
procedure TFRecalculaCustoProjeto.BFecharClick(Sender: TObject);
begin
  Close;
end;

{ *************************************************************************** }
procedure TFRecalculaCustoProjeto.BRecalcularClick(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = '' then
  begin
    FunProdutos.RecalculaCustoMateriaPrimaProjeto(EProjeto.AInteiro,CSomenteZerados.Checked,VprSeqProduto);
  end;

  if VpfResultado <> ''  then
    aviso(VpfResultado)
  else
    aviso('Projeto recalculado com sucesso.');
end;

{ *************************************************************************** }
function TFRecalculaCustoProjeto.DadosValidos: string;
begin
  result := '';
  if (VprSeqProduto =0) and not CSomenteZerados.Checked then
  begin
    if not confirmacao('Não foi selecionado nenhum filtro, o projeto inteiro será recalculado. Deseja continuar?') then
      result := 'Operação Cancelada';
  end;
  if Result = '' then
  begin
    if EProjeto.AInteiro = 0 then
    begin
      result := 'PROJETO NÃO PREENCHIDO!!!'#13'É necessário preenhcer o projeto.';
    end;
  end;

end;

{ *************************************************************************** }
procedure TFRecalculaCustoProjeto.EProdutoRetorno(Retorno1, Retorno2: string);
begin
  if Retorno1 <> '' then
    VprSeqProduto := StrtoInt(Retorno1)
  else
    VprSeqProduto := 0;
end;

procedure TFRecalculaCustoProjeto.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text := 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text := 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

procedure TFRecalculaCustoProjeto.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFRecalculaCustoProjeto]);
end.
