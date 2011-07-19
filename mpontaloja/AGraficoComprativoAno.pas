unit AGraficoComprativoAno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, PainelGradiente, Componentes1, Localizacao, ExtCtrls, Spin,Series,
  TeeProcs,TeEngine,Graficos, FMTBcd, DB, SqlExpr, UnNotaFiscal;

type
  TTipoGraficoComparativo = (tgComparativoAnoCliente);
  TFGraficoComparativoAno = class(TFormularioPermissao)
    PCliente: TPanelColor;
    SpeedButton1: TSpeedButton;
    LNomeCliente: TLabel;
    Label7: TLabel;
    ECliente: TRBEditLocaliza;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BMostrarConta: TSpeedButton;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    EAno1: TSpinEditColor;
    Label2: TLabel;
    EAno2: TSpinEditColor;
    Grafico: TRBGraDinamico;
    Tabela: TSQLQuery;
    PVendedor: TPanelColor;
    SpeedButton2: TSpeedButton;
    LVendedor: TLabel;
    Label4: TLabel;
    EVendedor: TRBEditLocaliza;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
  private
    { Private declarations }
    VprTipoGrafico : TTipoGraficoComparativo;
    procedure ConfiguraTela;
    procedure CarGraficoComparativoAnoCliente(VpaCodCliente : Integer;VpaNomCliente : String);
    procedure GeraGraficoComparativoAnoCliente;
  public
    { Public declarations }
    procedure GraficoComparativoAnoCliente;
  end;

var
  FGraficoComparativoAno: TFGraficoComparativoAno;

implementation

uses APrincipal, FunData, Constantes, FunNumeros, Constmsg, FunSql, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGraficoComparativoAno.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EAno1.Value := Ano(date)-1;
  EAno2.Value := Ano(date);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGraficoComparativoAno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFGraficoComparativoAno.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFGraficoComparativoAno.BGerarClick(Sender: TObject);
begin
  case VprTipoGrafico of
    tgComparativoAnoCliente: GeraGraficoComparativoAnoCliente;
  end;
end;

procedure TFGraficoComparativoAno.ConfiguraTela;
begin
  case VprTipoGrafico of
    tgComparativoAnoCliente:
    begin
      Caption := 'Comparativo Cliente Ano Faturamento ';
      PainelGradiente1.Caption := '  Comparativo Cliente Ano Faturamento   ';
    end;
  end;
end;

procedure TFGraficoComparativoAno.CarGraficoComparativoAnoCliente(VpaCodCliente : Integer;VpaNomCliente : String);
var
  VpfMes : Integer;
  VpfData : String;
  VpfSerie1, VpfSerie2 : TBarSeries;
  Vpflaco: Integer;
  VpfNomeMes : String;
  VpfDatInicio, VpfDatFim : TDateTime;
begin
  Grafico.InicializaGrafico;
  VpfSerie1 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie1);
  VpfSerie1.Marks.Style := smsValue;
  VpfSerie1.ColorEachPoint := false;
  VpfSerie1.BarBrush.Color := clYellow;
  VpfSerie1.Title := IntToStr(EAno1.Value);

  VpfSerie2 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie2);
  VpfSerie2.Marks.Style := smsValue;
  VpfSerie2.ColorEachPoint := false;
  VpfSerie2.BarBrush.Color := clYellow;
  VpfSerie2.Title := IntToStr(EAno2.Value);
  for VpfMes := 1 to 12 do
  begin
    VpfNomeMes := TextoMes(MontaData(1,VpfMes,2000),false);
    VpfDatInicio := MontaData(1,VpfMes,EAno1.Value);
    VpfDatFim := UltimoDiaMes(VpfDatInicio);
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais(FunNotaFiscal.RValNotasClientePeriodo(VpfDatInicio,VpfDatFim,VpaCodCliente),2),VpfNomeMes);
    VpfDatInicio := MontaData(1,VpfMes,EAno2.Value);
    VpfDatFim := UltimoDiaMes(VpfDatInicio);
    Grafico.AGrafico.Series[1].Add(ArredondaDecimais(FunNotaFiscal.RValNotasClientePeriodo(VpfDatInicio,VpfDatFim,VpaCodCliente),2),VpfNomeMes);
  end;

  Grafico.AInfo.TituloGrafico := VpaNomCliente;
  Grafico.AInfo.TituloFormulario := 'Comparativo Ano Cliente';
  Grafico.AInfo.TituloY := 'Valor Notas';
  Grafico.AInfo.RodapeGrafico := varia.NomeFilial;
end;

{******************************************************************************}
procedure TFGraficoComparativoAno.GeraGraficoComparativoAnoCliente;
begin
  if (ECliente.AInteiro = 0) and
     (EVendedor.AInteiro = 0) then
  begin
    aviso('CLIENTE NÃO PREENCHIDO!!!'#13'É necessário preencher o código do cliente');
  end;

  if ECliente.AInteiro <> 0  then
  begin
    CarGraficoComparativoAnoCliente(ECliente.AInteiro,LNomeCliente.Caption);
    Grafico.Executa;
  end
  else
  begin
    AdicionaSQLAbreTabela(Tabela,'Select I_COD_CLI, C_NOM_CLI from CADCLIENTES '+
                                 ' Where I_COD_VEN = '+EVendedor.TEXT );
    while not tabela.eof  do
    begin
      CarGraficoComparativoAnoCliente(Tabela.FieldByName('I_COD_CLI').AsInteger,Tabela.FieldByName('C_NOM_CLI').AsString);
      Grafico.ExportaBMP(Varia.DiretorioSistema+'\'+CopiaAteChar(LVendedor.Caption,' ')+'\'+DeletaEspaco(DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_NOM_CLI').AsString,'.'),'/'),'\')+'.bmp'));
      tabela.next;
    end;

    Tabela.Close;
  end;


end;

{******************************************************************************}
procedure TFGraficoComparativoAno.GraficoComparativoAnoCliente;
begin
  VprTipoGrafico := tgComparativoAnoCliente;
  ConfiguraTela;
  showModal;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGraficoComparativoAno]);
end.
