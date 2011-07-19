unit AFaturamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, ComCtrls, Componentes1, Grids, DBGrids, Tabela, ExtCtrls,
  PainelGradiente, StdCtrls, Buttons, Mask, numericos, Localizacao;

type
  TFFaturamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    Data1: TCalendario;
    data2: TCalendario;
    Faturamento: TQuery;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    Aux: TQuery;
    Grade1: TDBGridColor;
    numerico1: Tnumerico;
    numerico2: Tnumerico;
    numerico3: Tnumerico;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    tipo: TRadioGroup;
    Grade2: TDBGridColor;
    Grade3: TDBGridColor;
    Label8: TLabel;
    Label10: TLabel;
    Label18: TLabel;
    EditLocaliza4: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Localiza: TConsultaPadrao;
    Grade4: TDBGridColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure Data1CloseUp(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    procedure CarregaFaturamento;
    procedure MostraGrid( QualGrade : Integer );
  public
    { Public declarations }
  end;

var
  FFaturamento: TFFaturamento;

implementation

uses APrincipal, FunData, funstring, constantes, ARelFaturamento;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFaturamento.FormCreate(Sender: TObject);
begin
   Data1.Date := PrimeiroDiaMes(Date);
   data2.Date := UltimoDiaMes(Date);
self.CarregaFaturamento;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFaturamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if FRelFaturamento <> nil then
   FRelFaturamento.Close;
 Action := CaFree;
end;

procedure TFFaturamento.MostraGrid( QualGrade : Integer );
begin
Grade1.Visible := false;
Grade2.Visible := false;
Grade3.Visible := false;
Grade4.Visible := false;
case QualGrade of
1: Grade1.Visible := true;
2: Grade2.Visible := true;
3: Grade3.Visible := true;
4: Grade4.Visible := true;
end;
end;

procedure TFFaturamento.CarregaFaturamento;
begin
Faturamento.close;
Faturamento.sql.clear;
Faturamento.sql.Insert(0, ' Select ' );
Faturamento.sql.Insert(1,'sum(MCR.N_VLR_PAR * moe.n_vlr_dia) as valorFat, sum(MCR.N_VLR_PAG  * moe.n_vlr_dia) as valorPag');
Faturamento.sql.Insert(2, ' from MovContasAReceber as MCR key join CadContasAReceber as CR, ' +
                          ' CadHistoricoPadroes as H, CadFormasPagamento as FRM, cadmoedas as moe, ' +
                          ' CadClientes as C ' +
                          ' where CR.I_COD_HIS = H.I_COD_HIS ' +
                          ' and C.I_COD_CLI = CR.I_COD_CLI ' +
                          ' and FRM.I_COD_FRM = MCR.I_COD_FRM ' +
                          ' and CR.I_COD_MOE = MOE.I_COD_MOE ' +
                          ' and CR.D_DAT_EMI between ''' + DataToStrFormato(AAAAMMDD,Data1.Date,'/') + '''' +
                          ' and ''' + DataToStrFormato(AAAAMMDD,Data2.Date,'/') + '''' +
                          ' and H.C_FLA_FAT = ''S''' +
                          ' and MCR.C_FLA_PAR = ''N''' +
                          ' and ISNULL(MCR.C_DUP_CAN, ''N'') = ''N''');

if EditLocaliza4.Text <> '' then
  Faturamento.sql.Insert(3,' and CR.I_COD_CLI =  ' + EditLocaliza4.Text )
else
  Faturamento.sql.Insert(3,' ');

aux.Close;
aux.sql.Clear;
aux.SQL := Faturamento.sql;
aux.open;

Numerico1.AValor := aux.fieldByName('valorFat').AsCurrency;
Numerico2.AValor := aux.fieldByName('valorPag').AsCurrency;
Numerico3.AValor :=  Numerico1.AValor - Numerico2.AValor;
aux.close;

case tipo.ItemIndex of
0 : begin
       Faturamento.sql.Delete(1);
       Faturamento.sql.Insert(1,' CR.I_LAN_REC, CR.D_DAT_EMI, H.C_NOM_HIS, MCR.D_DAT_VEN, MCR.I_NRO_PAR, ' +
                                ' MCR.C_NRO_DUP, CR.D_DAT_EMI, (MCR.N_VLR_PAR * moe.n_vlr_dia) as N_VLR_PAR, ' +
                                ' C.C_NOM_CLI, FRM.C_NOM_FRM ');
       Faturamento.SQL.add(' order by CR.D_DAT_EMI');
       Faturamento.open;
       if Faturamento.FieldByName('N_VLR_PAR') is TFloatField then
          (Faturamento.FieldByName('N_VLR_PAR') as TFloatField).currency := true;
       mostraGrid(1);
    end;

1: begin
       Faturamento.sql.Delete(1);
       Faturamento.sql.Insert(1,'H.C_NOM_HIS, sum(mcr.N_VLR_PAR * moe.n_vlr_dia) as ValorPar, ' +
                                ' sum(mcr.N_VLR_PAG * moe.n_vlr_dia) as ValorPag');
       Faturamento.sql.Insert(4,'group by H.C_NOM_HIS');
       Faturamento.open;
       mostraGrid(2);
   end;

2: begin
       Faturamento.sql.Delete(1);
       Faturamento.sql.Insert(1,'CR.D_DAT_EMI, sum(mcr.N_VLR_PAR * moe.n_vlr_dia) as valorPar, ' +
                                'sum(mcr.N_VLR_PAG * moe.n_vlr_dia) as ValorPag');
       Faturamento.sql.Insert(4,'group by CR.D_DAT_EMI');
       Faturamento.open;
       mostraGrid(3);
  end;

3: begin
       Faturamento.sql.Delete(1);
       Faturamento.sql.Insert(1,' FRM.C_NOM_FRM, sum(mcr.N_VLR_PAR * moe.n_vlr_dia) as valorPar, ' +
                                'sum(mcr.N_VLR_PAG * moe.n_vlr_dia) as ValorPag');
       Faturamento.sql.Insert(4,' group by FRM.C_NOM_FRM');
       Faturamento.open;
       mostraGrid(4);
  end;
end;

if Tipo.ItemIndex in [ 1,2,3 ] then
begin
       if Faturamento.FieldByName('ValorPar') is TFloatField then
          (Faturamento.FieldByName('ValorPar') as TFloatField).currency := true;
       if Faturamento.FieldByName('ValorPag') is TFloatField then
          (Faturamento.FieldByName('ValorPag') as TFloatField).currency := true;
end;
end;


procedure TFFaturamento.BitBtn1Click(Sender: TObject);
begin
self.close;
end;

procedure TFFaturamento.Data1CloseUp(Sender: TObject);
begin
self.CarregaFaturamento;
end;


procedure TFFaturamento.BitBtn2Click(Sender: TObject);
begin
if FRelFAturamento = nil then
   FRelFAturamento := TFRelFAturamento.CriarSDI(application, '', true);
FRelFAturamento.AcertaDados(data1.DateTime, data2.DateTime, EditLocaliza4.text);
case tipo.ItemIndex of
0 : FRelFaturamento.AtivaRelatorio(0);
2 : FRelFaturamento.AtivaRelatorio(1);
1 : FRelFaturamento.AtivaRelatorio(2);
3 : FRelFaturamento.AtivaRelatorio(3);
end;
end;



Initialization
 RegisterClasses([TFFaturamento]);
end.
