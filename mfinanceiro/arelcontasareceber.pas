unit ARelContasaReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons,  Componentes1, ExtCtrls, PainelGradiente,
  ComCtrls, Localizacao;

type
  TFRelContasaReceber = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    data1: TCalendario;
    data2: TCalendario;
    Filtro: TComboBoxColor;
    EditLocaliza4: TEditLocaliza;
    Label18: TLabel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Localiza: TConsultaPadrao;
    EditLocaliza3: TEditLocaliza;
    Label17: TLabel;
    SpeedButton3: TSpeedButton;
    Label19: TLabel;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    primeiro : boolean;
    procedure adicionaSQLAnalitico( TipoFiltro : Integer );
    procedure adicionaSQLSintetico( TipoFiltro : Integer );
    function TextoFilial( TipoFiltro : Integer ) : string;
    function TextoData : string;
    function TextoFornecedor : string;
    function TextoHistorico: string;
  public
    { Public declarations }
  end;

var
  FRelContasaReceber: TFRelContasaReceber;

implementation

uses APrincipal, fundata, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRelContasaReceber.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
{data1.date :=  PrimeiroDiaMes(date);
data2.date :=  UltimoDiaMes(date);
primeiro := false;
Filtro.ItemIndex := 0;
ContasaReceberAnalitico.ReportName := varia.PathRel + 'ContasaReceberAnalitico.rpt';
ContasaReceberSintetico.ReportName := varia.PathRel + 'ContasaReceberSintetico.rpt';}
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRelContasaReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;

function TFRelContasaReceber.TextoFilial( TipoFiltro : Integer ) : string;
begin
case TipoFiltro of
0 :  result := ' AND CADCONTASARECEBER."I_EMP_FIL" = ' + IntToStr(varia.CodigoEmpFil);
1 :  result := ' AND CADCONTASARECEBER."I_EMP_FIL" like ''' + IntToStr(varia.CodigoEmpresa) + '%''';
2 :  result := '';
end;
end;

function TFRelContasaReceber.TextoData : string;
begin
result := ' AND MOVCONTASARECEBER."D_DAT_VEN" >= ''' + DataToStrFormato(AAAAMMDD,data1.DateTime,'/') + '''' +
          ' AND MOVCONTASARECEBER."D_DAT_VEN" <= ''' + DataToStrFormato(AAAAMMDD,data2.DateTime,'/') + '''';
end;

function TFRelContasaReceber.TextoFornecedor : string;
begin
if EditLocaliza4.Text <> '' then
   result := 'AND CADCONTASARECEBER."I_COD_CLI" = ' + EditLocaliza4.Text
else
   result := ' ';
end;

function TFRelContasaReceber.TextoHistorico : string;
begin
if EditLocaliza3.Text <> '' then
   result := 'AND CADCONTASARECEBER."I_COD_HIS" = ' + EditLocaliza3.Text
else
   result := ' ';
end;

procedure TFRelContasaReceber.AdicionaSQLAnalitico( TipoFiltro : Integer );
begin
{if ContasaReceberAnalitico.SQL.Query.Count > 18 then
begin
  ContasaReceberAnalitico.SQL.Query.Delete(18);
  ContasaReceberAnalitico.SQL.Query.Delete(17);
  ContasaReceberAnalitico.SQL.Query.Delete(16);
  ContasaReceberAnalitico.SQL.Query.Delete(15);
end;
ContasaReceberAnalitico.SQL.Query.Insert(15, self.TextoFilial(tipoFiltro));
ContasaReceberAnalitico.SQL.Query.Insert(16, self.TextoData);
ContasaReceberAnalitico.SQL.Query.Insert(17, self.TextoFornecedor);
ContasaReceberAnalitico.SQL.Query.Insert(18, self.TextoHistorico);}
end;


procedure TFRelContasaReceber.AdicionaSQLSintetico( TipoFiltro : Integer );
begin
{if ContasaReceberSintetico.SQL.Query.Count > 15 then
begin
  ContasaReceberSintetico.SQL.Query.Delete(15);
  ContasaReceberSintetico.SQL.Query.Delete(14);
  ContasaReceberSintetico.SQL.Query.Delete(13);
  ContasaReceberSintetico.SQL.Query.Delete(12);
end;
ContasaReceberSintetico.SQL.Query.Insert(12, self.TextoFilial(tipoFiltro));
ContasaReceberSintetico.SQL.Query.Insert(13, self.TextoData);
ContasaReceberSintetico.SQL.Query.Insert(14, self.TextoFornecedor);
ContasaReceberSintetico.SQL.Query.Insert(15, self.TextoHistorico);}
end;


procedure TFRelContasaReceber.BitBtn1Click(Sender: TObject);
begin
{case filtro.ItemIndex of
0 : AdicionaSQLAnalitico(0);
1 : AdicionaSQLAnalitico(1);
2 : AdicionaSQLAnalitico(2);
end;
ContasaReceberAnalitico.ReportTitle := varia.NomeEmpresa + ' - ' + varia.NomeFilial + ' - Período de ' + DateToStr(data1.DateTime) + ' à ' + DateToStr(data2.DateTime);
ContasaReceberAnalitico.Execute;}
end;


procedure TFRelContasaReceber.BitBtn2Click(Sender: TObject);
begin
{case filtro.ItemIndex of
0 : AdicionaSQLSintetico(0);
1 : AdicionaSQLSintetico(1);
2 : AdicionaSQLSintetico(2);
end;
ContasaReceberSintetico.ReportTitle := varia.NomeEmpresa + ' - ' + varia.NomeFilial + ' - Período de ' + DateToStr(data1.DateTime) + ' à ' + DateToStr(data2.DateTime);
ContasaReceberSintetico.Execute;}
end;

Initialization
 RegisterClasses([TFRelContasaReceber]);
end.
