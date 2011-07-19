unit AExcluiProdutoDuplicado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Buttons, StdCtrls, Localizacao, UnProdutos,
  UnDadosLocaliza;

type
  TFExcluiProdutoDuplicado = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EProdutoExcluido: TRBEditLocaliza;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    EProdutoDestino: TRBEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    BExcluir: TBitBtn;
    BFechar: TBitBtn;
    ELog: TMemoColor;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure EProdutoExcluidoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EProdutoDestinoRetorno(VpaColunas: TRBColunasLocaliza);
  private
    { Private declarations }
    VprSeqProdutoAExcluir,
    VprSeqProdutoDestino : Integer;
  public
    { Public declarations }
  end;

var
  FExcluiProdutoDuplicado: TFExcluiProdutoDuplicado;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFExcluiProdutoDuplicado.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFExcluiProdutoDuplicado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFExcluiProdutoDuplicado.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFExcluiProdutoDuplicado.BExcluirClick(Sender: TObject);
begin
  if (VprSeqProdutoAExcluir <> 0) and (VprSeqProdutoDestino <> 0) then
    FunProdutos.ExcluiProdutoDuplicado(VprSeqProdutoAExcluir,VprSeqProdutoDestino,ELog.Lines );
end;

{******************************************************************************}
procedure TFExcluiProdutoDuplicado.EProdutoExcluidoRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas[2].AValorRetorno <> '' then
    VprSeqProdutoAExcluir := StrToInt(VpaColunas[2].AValorRetorno)
  else
    VprSeqProdutoAExcluir := 0;
end;

{******************************************************************************}
procedure TFExcluiProdutoDuplicado.EProdutoDestinoRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas[2].AValorRetorno <> '' then
    VprSeqProdutoDestino := StrToInt(VpaColunas[2].AValorRetorno)
  else
    VprSeqProdutoDestino := 0;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFExcluiProdutoDuplicado]);
end.
