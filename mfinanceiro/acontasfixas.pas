unit AContasFixas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, StdCtrls, Buttons, Grids, DBGrids, Tabela, LabelCorMove,
  ExtCtrls, Componentes1, ComCtrls;

type
  TFContasFixas = class(TFormulario)
    ContasExistesntes: TPanelColor;
    Bevel3: TBevel;
    Label3D2: TLabel3D;
    GradeContas: TDBGridColor;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    MovDespesas: TQuery;
    DataMovDespesas: TDataSource;
    data1: TDateTimePicker;
    Data2: TDateTimePicker;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MovDespesasD_DAT_VEN: TDateField;
    MovDespesasN_VLR_DUP: TFloatField;
    MovDespesasC_NOM_HIS: TStringField;
    MovDespesasI_LAN_APG: TIntegerField;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure data1Change(Sender: TObject);
    procedure Data2Change(Sender: TObject);
  private
    dataInicial, DataFinal : TDateTime;
    CodHis : string;
  public
   procedure CarregaConsulta( his : String );
  end;

var
  FContasFixas: TFContasFixas;

implementation

uses ANovoContasaPagar, constantes, Fundata, APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFContasFixas.FormCreate(Sender: TObject);
begin
  DataInicial := PrimeiroDiaMes(date);
  DataFinal := UltimoDiaMes(date);
  Data1.Date := dataInicial;
  Data2.Date := DataFinal;
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFContasFixas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MovDespesas.close;
 Action := CaFree;
end;


procedure  TFContasFixas.CarregaConsulta( his : String );
begin
   CodHis := his;
   FContasFixas.MovDespesas.Close;
   FContasFixas.MovDespesas.SQL.Clear;
   FContasFixas.MovDespesas.sql.Add('select MCP.D_DAT_VEN, MCP.N_VLR_DUP, HP.C_NOM_HIS, CP.I_LAN_APG ' +
               ' from dba.CadContasaPagar as CP, dba.MovContasaPagar as MCP, ' +
               ' dba.CadHistoricoPadroes as HP' +
               ' where ( CP.i_emp_fil = ' + IntTostr(varia.codigoEmpFil) +
               ' and CP.I_COD_HIS = ' + his + ' )' +
               ' and CP.I_EMP_FIL = MCP.I_EMP_FIL and CP.I_LAN_APG = MCP.I_LAN_APG ' +
               ' and CP.I_COD_HIS = HP.I_COD_HIS ' +
               ' and MCP.D_DAT_VEN >= ' + '''' + DataToStrFormato(AAAAMMDD,dataInicial,'/') + '''' +
               ' and MCP.D_DAT_VEN <= ' + '''' + DataToStrFormato(AAAAMMDD,dataFinal, '/') + ''''  );
   FContasFixas.MovDespesas.open;
end;


procedure TFContasFixas.BitBtn3Click(Sender: TObject);
begin
{   FNovoContasapagar.CadContasapagar.cancel;
   FNovoContasapagar.CadContasaPagar.close;
   FNovoContasapagar.CadContasaPagar.SQL.Clear;
   FNovoContasapagar.CadContasaPagar.SQL.Add('select * from dba.CadContasaPagar  where i_emp_fil = ' +
                            Inttostr(varia.CodigoEmpFil) + ' and i_lan_apg = ' +
                            IntToStr(MovDespesas.fieldByName('i_lan_apg').AsInteger));
   FNovoContasapagar.CadContasaPagar.open;
   FNovoContasapagar.CadContasApagar.Edit;}
close;
end;

procedure TFContasFixas.BitBtn4Click(Sender: TObject);
begin
close;
end;

procedure TFContasFixas.data1Change(Sender: TObject);
begin
dataInicial := data1.Date;
CarregaConsulta(CodHis);
end;

procedure TFContasFixas.Data2Change(Sender: TObject);
begin
dataFinal := data2.Date;
CarregaConsulta(CodHis);
end;

Initialization
 RegisterClasses([TFContasFixas]);
end.
