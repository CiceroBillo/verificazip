unit Afluxo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, mxgrid, mxDB, mxstore, Db, DBTables, mxtables, Componentes1,
  ExtCtrls, PainelGradiente, TeeProcs, TeEngine, Chart, mxgraph, mxpivsrc,
  StdCtrls, Buttons, ComCtrls, mxcommon;

type
  TFFluxo = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DataGradeCP: TDecisionSource;
    DecisionQuery2: TDecisionQuery;
    DecisionCube2: TDecisionCube;
    DecisionSource2: TDecisionSource;
    Query2: TQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DecisionGrid2: TDecisionGrid;
    PanelColor3: TPanelColor;
    Query1: TQuery;
    Query3: TQuery;
    Data1: TCalendario;
    Data2: TCalendario;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Aux: TQuery;
    Button1: TButton;
    MapaGradeCP: TDecisionCube;
    Button2: TButton;
    DecisionGrid1: TDecisionGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Data2CloseUp(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    mascara : array[1..8] of byte;
    TamanhoMascara : integer;
    procedure ConfiguraFiltroData;
    function SQLCP : TstringList;
    function StringData : string;
  public
    { Public declarations }
  end;

var
  FFluxo: TFFluxo;

implementation

uses APrincipal, constmsg, fundata, funstring, constantes, funsql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFluxo.FormCreate(Sender: TObject);
begin
  AdicionaSQLAbreTabela(aux, 'select c_mas_pla from cadempresas ' +
                             ' where i_cod_emp =  ' + IntTostr(varia.CodigoEmpresa));
  varia.MascaraPlanoConta := aux.fieldByName('c_mas_pla').AsString;
  TamanhoMascara := DesmontaMascara(mascara,varia.MascaraPlanoConta);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFluxo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := CaFree;
end;


procedure TFFluxo.ConfiguraFiltroData;
begin
  if mes(data1.DateTime) <> mes(data2.DateTime) then
  begin
    RadioButton3.Enabled := false;
    RadioButton2.Checked := true;
  end
  else
     RadioButton2.Enabled:= true;

  if ano(data1.DateTime) <> ano(data2.DateTime) then
  begin
    RadioButton2.Enabled := false;
    RadioButton1.Checked := true;
  end
  else
      RadioButton3.Enabled := true;
end;

function TFFluxo.StringData : string;
begin
   if RadioButton1.Checked then
     result := 'year(mcp.d_dat_ven) vencimento '
   else
      if RadioButton2.Checked then
        result := 'month(mcp.d_dat_ven) vencimento '
      else
        if RadioButton3.Checked then
          result := 'day(mcp.d_dat_ven) vencimento '
end;

function TFFluxo.SQLCP : TstringList;
var
  laco, somaTamanho : integer;
begin
  result := TStringList.Create;
  result.Clear;
  Result.add( 'select ' );
  result.add( stringData );

  for laco := 1 to TamanhoMascara do
    Result.add( ',pl' + intToStr(laco) + '.c_nom_pla nomePla' + intToStr(laco));

  Result.add( ',sum(mcp.n_vlr_dup)  as soma ' );
  Result.add( ' from cadcontasapagar as cp key join movcontasapagar as mcp ' );

  for laco := 1 to TamanhoMascara do
    Result.add( ' ,cad_plano_conta as pl' + intToStr(laco) );

  Result.add( 'where' );
  result.add( ' mcp.d_dat_ven between ' + SQLTextoDataAAAAMMMDD(data1.date) + ' and ' + SQLTextoDataAAAAMMMDD(data2.date));
  result.add( ' and isnull(mcp.c_dup_can,''N'') = ''N'' and isnull(mcp.c_fla_par,''N'') = ''N''');

  somaTamanho := 0;
  for laco := 1 to TamanhoMascara  do
  begin
    somaTamanho := somaTamanho + mascara[laco];
    result.add( ' and pl' + intToStr(laco) + '.i_cod_emp =* cp.i_cod_emp ' );
    result.add( ' and  pl' + intToStr(laco) + '.c_cla_pla = substr(cp.c_cla_pla,0,' + intToStr(SomaTamanho) + ') ' );
    result.add( ' and length(pl' + intToStr(laco)+ '.c_cla_pla) = ' + intToStr(SomaTamanho) );
  end;

  result.add( ' group by vencimento ');

  somaTamanho := 0;
  for laco := 1 to TamanhoMascara do
  begin
    somaTamanho := somaTamanho + mascara[laco];
    result.add( ' ,substr(cp.c_cla_pla,0,' + intToStr(SomaTamanho) + '), nomePla' + intToStr(laco));
  end;

end;

procedure TFFluxo.Data2CloseUp(Sender: TObject);
begin
ConfiguraFiltroData;
end;

procedure TFFluxo.Button1Click(Sender: TObject);
var
  laco : integer;
begin
  Query1.sql := SQLCP;
  MapaGradeCP.DimensionMap.Clear;
  MapaGradeCP.DimensionMap.add;
//  MapaGradeCP.DimensionMap.Items[0].DisplayName := 'Vencimento';
  MapaGradeCP.DimensionMap.Items[0].DimensionType := dimDimension;
  MapaGradeCP.DimensionMap.Items[0].ActiveFlag := diAsNeeded;
  MapaGradeCP.DimensionMap.Items[0].BinType := binNone;
  MapaGradeCP.DimensionMap.Items[0].BaseName :=  'vencimento';
  MapaGradeCP.DimensionMap.Items[0].Fieldname := 'vencimento';
for laco := 1 to TamanhoMascara  do
begin
  MapaGradeCP.DimensionMap.add;
//  MapaGradeCP.DimensionMap.Items[laco].DisplayName := 'Nivel ' + IntTostr(laco);
  MapaGradeCP.DimensionMap.Items[laco].DimensionType := dimDimension;
  MapaGradeCP.DimensionMap.Items[laco].ActiveFlag := diAsNeeded;
  MapaGradeCP.DimensionMap.Items[laco].BinType := binNone;
  MapaGradeCP.DimensionMap.Items[laco].BaseName :=  'nomePla' + intToStr(laco);
  MapaGradeCP.DimensionMap.Items[laco].Fieldname := 'nomePla' + intToStr(laco);
end;
  MapaGradeCP.DimensionMap.add;
//  MapaGradeCP.DimensionMap.Items[laco].DisplayName := 'Valor';
  MapaGradeCP.DimensionMap.Items[laco].DimensionType := dimSum;
  MapaGradeCP.DimensionMap.Items[laco].ActiveFlag := diAsNeeded;
  MapaGradeCP.DimensionMap.Items[laco].BinType := binNone;
  MapaGradeCP.DimensionMap.Items[laco].BaseName :=  'soma';
  MapaGradeCP.DimensionMap.Items[laco].Fieldname := 'soma';
  ImprimeSqlArq(query1, 'c:\x\sqlcp.sql');
  query1.open;
//  GradeCP.Dimensions[0].DisplayName := 'Data';
//  for laco := 1 to TamanhoMascara  do
//    GradeCP.Dimensions[laco].DisplayName := 'Nivel ' + IntTostr(laco);
end;

procedure TFFluxo.Button2Click(Sender: TObject);
var
  laco : integer;
begin
for laco := 0 to MapaGradeCP.DimensionMap.Count - 1 do
  aviso(MapaGradeCP.DimensionMap[laco].Fieldname);
end;

Initialization
 RegisterClasses([TFFluxo]);
end.
