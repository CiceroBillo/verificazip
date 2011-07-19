unit AImprimeEtiquetaPrateleira;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Mask,
  numericos, Componentes1;

type
  TFImprimeEtiquetaPrateleira = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EEstante: TEditColor;
    EPrateleiraInicial: TEditColor;
    EPrateleiraFinal: TEditColor;
    ENumeroInicial: Tnumerico;
    ENumeroFinal: Tnumerico;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImprimeEtiquetaPrateleira: TFImprimeEtiquetaPrateleira;

implementation

uses APrincipal, UnProdutos;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeEtiquetaPrateleira.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeEtiquetaPrateleira.BFecharClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFImprimeEtiquetaPrateleira.BImprimirClick(Sender: TObject);
begin
  FunProdutos.ImprimeEtiquetaPrateleira(EEstante.Text,EPrateleiraInicial.Text,EPrateleiraFinal.Text,ENumeroInicial.AsInteger,ENumeroFinal.AsInteger);
end;

{ **************************************************************************** }
procedure TFImprimeEtiquetaPrateleira.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFImprimeEtiquetaPrateleira]);
end.
