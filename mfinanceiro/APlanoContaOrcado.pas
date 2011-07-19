unit APlanoContaOrcado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, ExtCtrls, PainelGradiente, Buttons, Grids, CGrades, UnDados, Funobjeto,
  Spin, Localizacao, UnDadosLocaliza;

type
  TFPlanoContaOrcado = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    GPlano: TRBStringGridColor;
    PanelColor3: TPanelColor;
    BFechar: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    EAno: TSpinEditColor;
    Label2: TLabel;
    ECentroCusto: TRBEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GPlanoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure BGravarClick(Sender: TObject);
    procedure GPlanoDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure EAnoExit(Sender: TObject);
    procedure GPlanoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GPlanoKeyPress(Sender: TObject; var Key: Char);
    procedure GPlanoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EAnoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ECentroCustoRetorno(VpaColunas: TRBColunasLocaliza);
  private
    VprDPlanoContaOrcado: TRBDPlanoContaOrcado;
    VprDPlanoContaOrcadoItem : TRBDPlanoContaOrcadoItem;
    procedure CarTituloGrade;
    procedure CarDItemClasse;
    procedure AtualizaConsulta;
    procedure CalculaValorTotal;
    function GravaDados : string;
  public
    { Public declarations }
  end;

var
  FPlanoContaOrcado: TFPlanoContaOrcado;

implementation

uses APrincipal, UnContasAReceber, Constantes, FunData, FunString, constmsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFPlanoContaOrcado.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  EAno.Value := Ano(date);
  CarTituloGrade;
  VprDPlanoContaOrcado := TRBDPlanoContaOrcado.cria;
  VprDPlanoContaOrcado.AnoPlanoContaOrcado := EAno.Value;
  AtualizaConsulta;
  { chamar a rotina de atualização de menus }
end;

{******************************************************************************}
procedure TFPlanoContaOrcado.GPlanoCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDPlanoContaOrcadoItem := TRBDPlanoContaOrcadoItem(VprDPlanoContaOrcado.PlanoContas.Items[VpaLinha-1]);
  GPlano.Cells[1,VpaLinha] := VprDPlanoContaOrcadoItem.CodPlanoContas;
  GPlano.Cells[2,VpaLinha] := VprDPlanoContaOrcadoItem.NomPlanoContas;
  if VprDPlanoContaOrcadoItem.ValJaneiro <> 0 then
    GPlano.Cells[3,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValJaneiro)
  Else
    GPlano.Cells[3,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValFevereiro <> 0 then
    GPlano.Cells[4,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValFevereiro)
  else
    GPlano.Cells[4,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValMarco <> 0 then
    GPlano.Cells[5,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValMarco)
  else
    GPlano.Cells[5,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValAbril <> 0 then
    GPlano.Cells[6,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValAbril)
  else
    GPlano.Cells[6,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValMaio <> 0 then
    GPlano.Cells[7,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValMaio)
  else
    GPlano.Cells[7,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValJunho <> 0 then
    GPlano.Cells[8,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValJunho)
  else
    GPlano.Cells[8,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValJulho <> 0 then
    GPlano.Cells[9,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValJulho)
  else
    GPlano.Cells[9,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValAgosto <> 0 then
    GPlano.Cells[10,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValAgosto)
  else
    GPlano.Cells[10,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValSetembro <> 0 then
    GPlano.Cells[11,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValSetembro)
  else
    GPlano.Cells[11,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValOutubro <> 0 then
    GPlano.Cells[12,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValOutubro)
  else
    GPlano.Cells[12,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValNovembro <> 0 then
    GPlano.Cells[13,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValNovembro)
  else
    GPlano.Cells[13,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValDezembro <> 0 then
    GPlano.Cells[14,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValDezembro)
  else
    GPlano.Cells[14,VpaLinha] := '';

  if VprDPlanoContaOrcadoItem.ValTotal <> 0 then
    GPlano.Cells[15,VpaLinha] := FormatFloat('#,###,###,##0.00',VprDPlanoContaOrcadoItem.ValTotal)
  else
    GPlano.Cells[15,VpaLinha] := '';

end;

{******************************************************************************}
procedure TFPlanoContaOrcado.GPlanoDadosValidos(Sender: TObject;var VpaValidos: Boolean);
var
  vpfLaco, VpfLinha : Integer;
begin
  CalculaValorTotal;
  CarDItemClasse;
  vpfLaco := 0;
  FunContasAReceber.AtualizaTotalContasOrcadas(VprDPlanoContaOrcado,TRBDPlanoContaOrcadoItem(VprDPlanoContaOrcado.PlanoContas.Items[0]),vpfLaco);
  GPlano.CarregaGrade(false);
end;

{******************************************************************************}
procedure TFPlanoContaOrcado.GPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_DELETE : if GPlano.AColuna in [1,2,15] then
                  key := 0;
  end;
end;

{******************************************************************************}
procedure TFPlanoContaOrcado.GPlanoKeyPress(Sender: TObject; var Key: Char);
begin
  if GPlano.AColuna in [1,2] then
    key := #0;
end;

{******************************************************************************}
procedure TFPlanoContaOrcado.GPlanoMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDPlanoContaOrcado.PlanoContas.Count >0 then
  begin
    VprDPlanoContaOrcadoItem := TRBDPlanoContaOrcadoItem(VprDPlanoContaOrcado.PlanoContas.Items[VpaLinhaAtual -1]);
  end;
end;

{******************************************************************************}
function TFPlanoContaOrcado.GravaDados: string;
begin
  result := FunContasAReceber.GravaPlanoContaOrcado(VprDPlanoContaOrcado);
end;

{ *************************************************************************** }
procedure TFPlanoContaOrcado.AtualizaConsulta;
var
  VpfResultado : string;
begin
  VpfResultado := '';

  if (VprDPlanoContaOrcado.AnoPlanoContaOrcado <> EAno.Value) or
     (VprDPlanoContaOrcado.CodCentroCusto <> ECentroCusto.AInteiro) then
  begin
    if confirmacao('Deseja salvar os dados digitados?') then
    begin
       vpfresultado := GravaDados;
    end;
  end;
  if VpfResultado = '' then
  begin
    VprDPlanoContaOrcado.Free;
    VprDPlanoContaOrcado := TRBDPlanoContaOrcado.cria;
    VprDPlanoContaOrcado.CodEmpresa := varia.CodigoEmpresa;

    FunContasAReceber.CarDPlanoContaOrcado(VprDPlanoContaOrcado,VprDPlanoContaOrcado.CodEmpresa,EAno.Value,ECentroCusto.AInteiro);
    VprDPlanoContaOrcado.AnoPlanoContaOrcado := EAno.Value;
    VprDPlanoContaOrcado.CodCentroCusto := ECentroCusto.AInteiro;

    GPlano.ADados:= VprDPlanoContaOrcado.PlanoContas;
    GPlano.CarregaGrade;
    GPlano.ALinha := 1;
    ActiveControl := GPlano;
  end;

end;

{******************************************************************************}
procedure TFPlanoContaOrcado.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFPlanoContaOrcado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDPlanoContaOrcado.Free;
  Action := CaFree;
end;

{******************************************************************************}
procedure TFPlanoContaOrcado.BGravarClick(Sender: TObject);
var
  VpfResultado: string;
begin
   VpfResultado := '';
   VpfResultado:= FunContasAReceber.GravaPlanoContaOrcado(VprDPlanoContaOrcado);
   if VpfResultado <> '' then
     aviso(VpfResultado);
   BFechar.Click;
end;

{******************************************************************************}
procedure TFPlanoContaOrcado.CalculaValorTotal;
begin
  GPlano.Cells[15,GPlano.ALinha]:= FloatToStr((StrToFloatDef(GPlano.Cells[3,GPlano.ALinha],0) + StrToFloatDef(GPlano.Cells[4,GPlano.ALinha],0) + StrToFloatDef(GPlano.Cells[5,GPlano.ALinha],0) +
    StrToFloatDef(GPlano.Cells[6,GPlano.ALinha],0) +  StrToFloatDef(GPlano.Cells[7,GPlano.ALinha],0) + StrToFloatDef(GPlano.Cells[8,GPlano.ALinha],0) +
    StrToFloatDef(GPlano.Cells[9,GPlano.ALinha],0) +  StrToFloatDef(GPlano.Cells[10,GPlano.ALinha],0) + StrToFloatDef(GPlano.Cells[11,GPlano.ALinha],0) +
    StrToFloatDef(GPlano.Cells[12,GPlano.ALinha],0) + StrToFloatDef(GPlano.Cells[13,GPlano.ALinha],0) + StrToFloatDef(GPlano.Cells[14,GPlano.ALinha],0)));
end;

{******************************************************************************}
Procedure TFPlanoContaOrcado.CarDItemClasse;
var
  VpfLaco : integer;
begin
  if GPlano.Cells[3,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValJaneiro := StrToFloat(DeletaChars(GPlano.Cells[3,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValJaneiro := 0;

  if GPlano.Cells[4,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValFevereiro := StrToFloat(DeletaChars(GPlano.Cells[4,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValFevereiro:= 0;

  if GPlano.Cells[5,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValMarco := StrToFloat(DeletaChars(GPlano.Cells[5,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValMarco := 0;

  if GPlano.Cells[6,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValAbril := StrToFloat(DeletaChars(GPlano.Cells[6,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValAbril := 0;

  if GPlano.Cells[7,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValMaio := StrToFloat(DeletaChars(GPlano.Cells[7,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValMaio := 0;

  if GPlano.Cells[8,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValJunho := StrToFloat(DeletaChars(GPlano.Cells[8,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValJunho := 0;

  if GPlano.Cells[9,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValJulho := StrToFloat(DeletaChars(GPlano.Cells[9,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValJulho := 0;

  if GPlano.Cells[10,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValAgosto := StrToFloat(DeletaChars(GPlano.Cells[10,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValAgosto := 0;

  if GPlano.Cells[11,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValSetembro := StrToFloat(DeletaChars(GPlano.Cells[11,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValSetembro := 0;

  if GPlano.Cells[12,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValOutubro := StrToFloat(DeletaChars(GPlano.Cells[12,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValOutubro := 0;

  if GPlano.Cells[13,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValNovembro := StrToFloat(DeletaChars(GPlano.Cells[13,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValNovembro := 0;

  if GPlano.Cells[14,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValDezembro := StrToFloat(DeletaChars(GPlano.Cells[14,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValDezembro := 0;

  if GPlano.Cells[15,GPlano.ALinha] <> '' then
    VprDPlanoContaOrcadoItem.ValTotal := StrToFloat(DeletaChars(GPlano.Cells[15,GPlano.ALinha],'.'))
  else
    VprDPlanoContaOrcadoItem.ValTotal := 0;
end;

{******************************************************************************}
procedure TFPlanoContaOrcado.CarTituloGrade;
begin
  GPlano.Cells[1,0] := 'Código';
  GPlano.Cells[2,0] := 'Plano de Conta';
  GPlano.Cells[3,0] := 'Janeiro';
  GPlano.Cells[4,0] := 'Fevereiro';
  GPlano.Cells[5,0] := 'Março';
  GPlano.Cells[6,0] := 'Abril';
  GPlano.Cells[7,0] := 'Maio';
  GPlano.Cells[8,0] := 'Junho';
  GPlano.Cells[9,0] := 'Julho';
  GPlano.Cells[10,0] := 'Agosto';
  GPlano.Cells[11,0] := 'Setembro';
  GPlano.Cells[12,0] := 'Outubro';
  GPlano.Cells[13,0] := 'Novembro';
  GPlano.Cells[14,0] := 'Dezembro';
  GPlano.Cells[15,0] := 'Total';
end;



procedure TFPlanoContaOrcado.EAnoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFPlanoContaOrcado.EAnoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN : AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFPlanoContaOrcado.ECentroCustoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  AtualizaConsulta;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPlanoContaOrcado]);
end.


uses UnDados;
