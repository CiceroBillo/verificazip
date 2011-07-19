unit AGraficosFluxo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Graficos, Db, DBTables, StdCtrls, Buttons, Componentes1, ExtCtrls,
  PainelGradiente;

type
  TFGraficoFluxo = class(TFormulario)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    aux: TQuery;
    Graficos: TGraficosTrio;
    GraficosLinhas: TGraficosLinhas;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
  public
      procedure CarregaTabFluxo( SQLApagar, SQLReceber : String; DiasAno : Integer);
  end;

var
  FGraficoFluxo: TFGraficoFluxo;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGraficoFluxo.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGraficoFluxo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := CaFree;
end;


procedure TFGraficoFluxo.CarregaTabFluxo( SQLApagar, SQLReceber : String; DiasAno : Integer);
var
  valoresAPagar : array[1..31] of double;
  valoresAReceber : array[1..31] of double;
  laco : integer;
begin
aux.close;
aux.sql.Clear;
aux.sql.Add(SqlApagar);
aux.open;
aux.First;
while not aux.Eof do
begin
valoresApagar[aux.fieldByName('mes').AsInteger] := aux.fieldByName('valor').AsCurrency;
aux.Next;
end;

aux.close;
aux.sql.Clear;
aux.sql.Add(SqlReceber);
aux.open;
aux.First;
while not aux.Eof do
begin
valoresAReceber[aux.fieldByName('mes').AsInteger] := aux.fieldByName('valor').AsCurrency;
aux.Next;
end;


aux.close;
aux.RequestLive := true;
aux.sql.Clear;
aux.sql.Add('select * from CadDadosFluxo order by i_dia_mes ');
aux.open;
aux.first;

for laco := 1 to DiasAno do
begin
  aux.edit;
  aux.FieldByName('N_VLR_APG').Value := ValoresAPagar[laco];
  aux.FieldByName('N_VLR_REC').Value := ValoresAReceber[laco];
  aux.post;
  aux.next;
end;
aux.close;
aux.RequestLive := false;
self.ShowModal;
end;


procedure TFGraficoFluxo.BitBtn4Click(Sender: TObject);
begin
close;
end;

procedure TFGraficoFluxo.BitBtn1Click(Sender: TObject);
begin
graficos.info.ComandoSQL := 'select * from CadDadosFluxo where i_dia_mes < 13 order by i_dia_mes';
graficos.info.CampoRotulo := 'i_dia_mes';
graficos.info.CampoValor := 'n_vlr_apg';
graficos.info.TituloGrafico := 'Fluxo Mensal';
graficos.info.RodapeGrafico := 'uuuuu';
graficos.info.TituloFormulario := 'Gráfico do Fluxo Mensal';
graficos.info.TituloY := 'Valores por mes';
graficos.info.TituloX := 'Meses';
graficos.execute;
end;

procedure TFGraficoFluxo.BitBtn2Click(Sender: TObject);
begin
graficos.info.ComandoSQL := 'select * from CadDadosFluxo where i_dia_mes < 13 order by i_dia_mes';
graficos.info.CampoRotulo := 'i_dia_mes';
graficos.info.CampoValor := 'n_vlr_rec';
graficos.info.TituloGrafico := 'Fluxo Mensal';
graficos.info.RodapeGrafico := 'uuuuu';
graficos.info.TituloFormulario := 'Gráfico do Fluxo Mensal';
graficos.info.TituloY := 'Valores por mes';
graficos.info.TituloX := 'Meses';
graficos.execute;
end;

procedure TFGraficoFluxo.BitBtn3Click(Sender: TObject);
begin
GraficosLinhas.info.ComandoSQL[0] := 'select * from CadDadosFluxo where i_dia_mes < 13 order by i_dia_mes';
GraficosLinhas.info.ComandoSQL[1] := 'select * from CadDadosFluxo where i_dia_mes < 13 order by i_dia_mes';
GraficosLinhas.info.CampoRotulo[0] := 'i_dia_mes';
GraficosLinhas.info.CampoRotulo[1] := 'i_dia_mes';
GraficosLinhas.info.CampoValor[0] := 'n_vlr_apg';
GraficosLinhas.info.CampoValor[1] := 'n_vlr_rec';
GraficosLinhas.info.NomeLinha[0] := 'Contas a Pagar';
GraficosLinhas.info.NomeLinha[1] := 'Contas a Receber';
GraficosLinhas.info.TituloGrafico := 'Avalição Contas a Pagar e Receber';
GraficosLinhas.info.RodapeGrafico := 'uuuu';
GraficosLinhas.info.TituloFormulario := 'Gráficos Contas';
GraficosLinhas.info.TituloY := 'Valores por mes';
GraficosLinhas.info.TituloX := 'Meses';
GraficosLinhas.execute;
end;

Initialization
 RegisterClasses([TFGraficoFluxo]);
end.
