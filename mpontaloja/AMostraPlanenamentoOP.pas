unit AMostraPlanenamentoOP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, Buttons, UnDadosProduto,
  ComCtrls, StdCtrls, Mask, numericos, UnPCP;

type
  TFMostraPlanejamentoOP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    Grade: TRBStringGridColor;
    PanelColor1: TPanelColor;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    StatusBar1: TStatusBar;
    EIntervalo: Tnumerico;
    EDatInicio: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    EDatFim: TCalendario;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RBStringGridColor1DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure GradeGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GradeStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure GradeStartDock(Sender: TObject;
      var DragObject: TDragDockObject);
    procedure GradeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure GradeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GradeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EDatInicioExit(Sender: TObject);
  private
    { Private declarations }
    VprColInicial,
    VprLinInicial,
    VprColFinal,
    VprLinFinal : Integer;
    FunPCP : TRBFuncoesPCP;
  public
    { Public declarations }
  end;

var
  FMostraPlanejamentoOP: TFMostraPlanejamentoOP;

implementation

uses APrincipal, funData;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraPlanejamentoOP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunPCP := TRBFuncoesPCP.cria;
  EDatInicio.Datetime := date;
  EDatFim.Datetime := incdia(date,1);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraPlanejamentoOP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  funPcp.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFMostraPlanejamentoOP.RBStringGridColor1DragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := true;
end;

procedure TFMostraPlanejamentoOP.SpeedButton1Click(Sender: TObject);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 1 to Grade.ColCount - 1 do
  begin
    Grade.ColWidths[VpfLaco] := Grade.ColWidths[VpfLaco] + Grade.ColWidths[VpfLaco];     
  end;
end;

procedure TFMostraPlanejamentoOP.SpeedButton2Click(Sender: TObject);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 1 to Grade.ColCount - 1 do
  begin
    if Grade.ColWidths[VpfLaco] > 2 then
    begin
      Grade.ColWidths[VpfLaco] := Grade.ColWidths[VpfLaco] - ( Grade.ColWidths[VpfLaco] div 2);
    end;
  end;
end;

procedure TFMostraPlanejamentoOP.GradeGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (ACol = 0) or (ARow =0) then
    ABrush.Color := $00FF8080;
  if ARow = 3 then
    ABrush.Color := clred;
end;

{******************************************************************************}
procedure TFMostraPlanejamentoOP.GradeStartDrag(Sender: TObject;
  var DragObject: TDragObject);
var
  X, Y : Integer;
begin
  Grade.MouseCoord(x,y);
  Grade.Hint := 'x='+IntToStr(x);
  StatusBar1.Panels[0].Text := 'x='+IntToStr(x);
end;

procedure TFMostraPlanejamentoOP.GradeStartDock(Sender: TObject;
  var DragObject: TDragDockObject);
var
  X, Y : Integer;
begin
  Grade.MouseCoord(x,y);
  Grade.Hint := 'xx='+IntToStr(x);
  StatusBar1.Panels[0].Text := 'xx='+IntToStr(x);
end;

procedure TFMostraPlanejamentoOP.GradeDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := true;
end;

procedure TFMostraPlanejamentoOP.GradeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  VprColInicial := Grade.col;
  VprLinInicial := grade.row;
  StatusBar1.Panels[0].Text := 'Linha Inicio='+IntToStr(VprLinInicial)+ ' Coluna Inicio : '+IntToStr(VprColInicial);
end;

{******************************************************************************}
procedure TFMostraPlanejamentoOP.GradeMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  VprColFinal := Grade.col;
  VprLinFinal := grade.row;
  StatusBar1.Panels[0].Text := 'Linha Fim='+IntToStr(VprLinFinal)+ ' Coluna Fim : '+IntToStr(VprColFinal);
end;

{******************************************************************************}
procedure TFMostraPlanejamentoOP.EDatInicioExit(Sender: TObject);
begin
  Grade.ColCount := FunPCP.RQtdLinhas(EDatInicio.DateTime,EDatfim.datetime,EIntervalo.AsInteger);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMostraPlanejamentoOP]);
end.
