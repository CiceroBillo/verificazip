unit AMostraCriticaFiscal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Grids,
  CGrades;

type
  TFMostraCriticaFiscal = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Grade: TRBStringGridColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MostraCritica(VpaCritica :TStringLIst);
  end;

var
  FMostraCriticaFiscal: TFMostraCriticaFiscal;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraCriticaFiscal.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraCriticaFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMostraCriticaFiscal.MostraCritica(VpaCritica :TStringLIst);
begin
  VpaCritica.Insert(0,'Críticas');
  Grade.RowCount := vpaCritica.Count;
  Grade.Cols[1].Assign(VpaCritica);
  Showmodal;
end;

{******************************************************************************}
procedure TFMostraCriticaFiscal.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFMostraCriticaFiscal.GradeGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (ACol = 1) and (Arow > 1) then
  begin
    if (ARow mod 2 ) = 0 then
      ABrush.Color := $0080FFFF;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMostraCriticaFiscal]);
end.
