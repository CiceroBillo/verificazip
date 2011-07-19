unit AMovMoeda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Spin, Componentes1, ExtCtrls, PainelGradiente, Grids,
  Localizacao, Db, DBTables, Mask, DBCtrls, Tabela, LabelCorMove, Buttons,
  numericos;

type
  TFMovMoedas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor3: TPanelColor;
    CAno: TSpinEditColor;
    CMes: TSpinEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditLocaliza1: TEditLocaliza;
    MovMoedas: TQuery;
    MovMoedasI_COD_MOE: TIntegerField;
    MovMoedasD_DAT_ATU: TDateField;
    MovMoedasN_VLR_D01: TFloatField;
    MovMoedasN_VLR_D02: TFloatField;
    MovMoedasN_VLR_D03: TFloatField;
    MovMoedasN_VLR_D04: TFloatField;
    MovMoedasN_VLR_D05: TFloatField;
    MovMoedasN_VLR_D06: TFloatField;
    MovMoedasN_VLR_D07: TFloatField;
    MovMoedasN_VLR_D08: TFloatField;
    MovMoedasN_VLR_D09: TFloatField;
    MovMoedasN_VLR_D10: TFloatField;
    MovMoedasN_VLR_D11: TFloatField;
    MovMoedasN_VLR_D12: TFloatField;
    MovMoedasN_VLR_D13: TFloatField;
    MovMoedasN_VLR_D14: TFloatField;
    MovMoedasN_VLR_D15: TFloatField;
    MovMoedasN_VLR_D16: TFloatField;
    MovMoedasN_VLR_D17: TFloatField;
    MovMoedasN_VLR_D18: TFloatField;
    MovMoedasN_VLR_D19: TFloatField;
    MovMoedasN_VLR_D20: TFloatField;
    MovMoedasN_VLR_D21: TFloatField;
    MovMoedasN_VLR_D22: TFloatField;
    MovMoedasN_VLR_D23: TFloatField;
    MovMoedasN_VLR_D24: TFloatField;
    MovMoedasN_VLR_D25: TFloatField;
    MovMoedasN_VLR_D26: TFloatField;
    MovMoedasN_VLR_D27: TFloatField;
    MovMoedasN_VLR_D28: TFloatField;
    MovMoedasN_VLR_D29: TFloatField;
    MovMoedasN_VLR_D30: TFloatField;
    MovMoedasN_VLR_D31: TFloatField;
    DataMovMoedas: TDataSource;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Localiza: TConsultaPadrao;
    PanelColor4: TPanelColor;
    Label3D1: TLabel3D;
    Label3D2: TLabel3D;
    Label3D3: TLabel3D;
    Label3D4: TLabel3D;
    Label3D5: TLabel3D;
    Label3D6: TLabel3D;
    Label3D7: TLabel3D;
    Label3D8: TLabel3D;
    Label3D9: TLabel3D;
    Label3D10: TLabel3D;
    Label3D20: TLabel3D;
    Label3D19: TLabel3D;
    Label3D18: TLabel3D;
    Label3D17: TLabel3D;
    Label3D16: TLabel3D;
    Label3D15: TLabel3D;
    Label3D14: TLabel3D;
    Label3D13: TLabel3D;
    Label3D12: TLabel3D;
    Label3D11: TLabel3D;
    Label3D31: TLabel3D;
    Label3D30: TLabel3D;
    Label3D29: TLabel3D;
    Label3D28: TLabel3D;
    Label3D27: TLabel3D;
    Label3D25: TLabel3D;
    Label3D24: TLabel3D;
    Label3D23: TLabel3D;
    Label3D22: TLabel3D;
    Label3D21: TLabel3D;
    Label3D26: TLabel3D;
    DBEditNumerico1: TDBEditNumerico;
    DBEditNumerico2: TDBEditNumerico;
    DBEditNumerico3: TDBEditNumerico;
    DBEditNumerico4: TDBEditNumerico;
    DBEditNumerico5: TDBEditNumerico;
    DBEditNumerico6: TDBEditNumerico;
    DBEditNumerico7: TDBEditNumerico;
    DBEditNumerico8: TDBEditNumerico;
    DBEditNumerico9: TDBEditNumerico;
    DBEditNumerico10: TDBEditNumerico;
    DBEditNumerico11: TDBEditNumerico;
    DBEditNumerico12: TDBEditNumerico;
    DBEditNumerico13: TDBEditNumerico;
    DBEditNumerico14: TDBEditNumerico;
    DBEditNumerico15: TDBEditNumerico;
    DBEditNumerico16: TDBEditNumerico;
    DBEditNumerico17: TDBEditNumerico;
    DBEditNumerico18: TDBEditNumerico;
    DBEditNumerico19: TDBEditNumerico;
    DBEditNumerico20: TDBEditNumerico;
    DBEditNumerico21: TDBEditNumerico;
    DBEditNumerico22: TDBEditNumerico;
    DBEditNumerico23: TDBEditNumerico;
    DBEditNumerico24: TDBEditNumerico;
    DBEditNumerico25: TDBEditNumerico;
    DBEditNumerico26: TDBEditNumerico;
    DBEditNumerico27: TDBEditNumerico;
    DBEditNumerico28: TDBEditNumerico;
    DBEditNumerico29: TDBEditNumerico;
    DBEditNumerico30: TDBEditNumerico;
    DBEditNumerico31: TDBEditNumerico;
    PanelColor1: TPanelColor;
    BFecha: TBitBtn;
    BGrava: TBitBtn;
    BAltera: TBitBtn;
    numerico1: Tnumerico;
    Label3D32: TLabel3D;
    BitBtn4: TBitBtn;
    CDIA: TSpinEditColor;
    Label3D33: TLabel3D;
    BBAjuda: TBitBtn;
    MovMoedasD_ULT_ALT: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditLocaliza1Retorno(Retorno1, Retorno2: String);
    procedure CMesChange(Sender: TObject);
    procedure BFechaClick(Sender: TObject);
    procedure BGravaClick(Sender: TObject);
    procedure BAlteraClick(Sender: TObject);
    procedure MovMoedasAfterEdit(DataSet: TDataSet);
    procedure BitBtn4Click(Sender: TObject);
    procedure numerico1Change(Sender: TObject);
    procedure EditLocaliza1Select(Sender: TObject);
  private
      function CarregaMovimento( codigoMoeda : string ) : Boolean;
      procedure CriaMovimento( codigoMoeda : integer );
      procedure VerificaMovimento( codigoMoeda : string );
      procedure AdiconaIndicePadrao;
      procedure ConfigDias;
      procedure Habilita;
  public

    { Public declarations }
  end;

var
  FMovMoedas: TFMovMoedas;

implementation

uses APrincipal, fundata, funstring, AMoedaDia, constMsg, constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMovMoedas.FormCreate(Sender: TObject);
begin
   CMes.Value := mes(date);
   CANo.Value := ano(date);

end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMovMoedas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := CaFree;
end;

procedure TFMovMoedas.ConfigDias;

  procedure MudaEstado(DBEdit  : array of TDBEditcolor; Texto : array of TLabel3D; estado : boolean);
  var
    laco : integer;
  begin
    for laco := low(DBEdit) to High(DBEdit) do
    begin
        DBedit[laco].Enabled := estado;
        texto[laco].Enabled := estado;
    end;
  end;

var
  ultimodia : integer;
begin
MudaEstado([DBEditNumerico29,DBEditNumerico30,DBEditNumerico31],[Label3D29,Label3D30,Label3D31], true);
ultimoDia := Dia(UltimoDiaMes(Montadata(1,cmes.Value, cano.Value)));
case ultimoDia of
28 : MudaEstado([DBEditNumerico29,DBEditNumerico30,DBEditNumerico31],[Label3D29,Label3D30,Label3D31], false);
29 : MudaEstado([DBEditNumerico30,DBEditNumerico31],[Label3D30,Label3D31], false);
30 : MudaEstado([DBEditNumerico31],[Label3D31], false);
end;
end;

{ ******************* Carrega Movimento das Moedas************************** }
function TFMovMoedas.CarregaMovimento( codigoMoeda : string ) : Boolean;
begin
result := true;
if codigoMoeda <> '' then
begin
  MovMoedas.close;
  MovMoedas.sql.clear;
  MovMoedas.sql.Add('Select * from MovMoedas where i_cod_moe = ' + codigoMoeda +
                    ' and d_dat_atu = ''' +
                    DataToStrFormato(AAAAMMDD,Montadata(1,cmes.Value, cano.Value),'/') + '''');
  MovMoedas.open;
end;

if MovMoedas.Eof then
  result := false;
end;

{ ******************* Cria um Novo movimento da moeda ************************ }
procedure TFMovMoedas.CriaMovimento( codigoMoeda : integer );
begin
  MovMoedas.close;
  MovMoedas.sql.clear;
  MovMoedas.sql.Add('select * from movmoedas');
  MovMoedas.open;
  MovMoedas.Insert;
  MovMoedasI_COD_MOE.Value := CodigoMoeda;
  MovMoedasD_DAT_ATU.Value := MontaData(1,CMes.Value, CAno.Value);
  MovMoedas.Post;
  MovMoedas.close;
end;

{ ********** Verifica se existe movimento, caso não cria novo **************** }
procedure TFMovMoedas.VerificaMovimento( codigoMoeda : string );
begin
ConfigDias;
if CodigoMoeda <> '' then
   if not CarregaMovimento(CodigoMoeda) then
   begin
     CriaMovimento(StrToInt(CodigoMoeda));
     CarregaMovimento(CodigoMoeda);
   end;
end;

{***************************************************************************}
procedure TFMovMoedas.AdiconaIndicePadrao;
var
  laco : integer;
begin
if Editlocaliza1.Text <> ''  then
begin
  if not (MovMoedas.State in [ dsEdit ]) then
    MovMoedas.Edit;
  for laco := CDia.Value to Dia(UltimoDiaMes(Montadata(1,cmes.Value, cano.Value))) do
     MovMoedas.FieldByName('N_VLR_D' + AdicionaCharE('0',IntToStr(laco),2)).Value := Numerico1.AValor;
end;
end;

{ ******************* Retorno do localiza ************************************ }
procedure TFMovMoedas.EditLocaliza1Retorno(Retorno1, Retorno2: String);
begin
  VerificaMovimento(retorno1)
end;

procedure TFMovMoedas.CMesChange(Sender: TObject);
begin
VerificaMovimento(EditLocaliza1.Text);
end;

procedure TFMovMoedas.BFechaClick(Sender: TObject);
begin
if confirmacao(CT_AtualizarMoedaDia) then
begin
  try
    FMoedaDia := TFMoedaDia.CriarSDI(application,'', true);
    FMoedaDia.CarregaMoedaDia(varia.MoedaBase,CurrencyString);
  finally
    FMoedaDia.Close;
  end;
end;
close;
end;

{***************************************************************************}
procedure TFMovMoedas.BGravaClick(Sender: TObject);
begin
if MovMoedas.State in [ dsInsert, dsEdit ] then
  MovMoedas.Post;
end;

{*****************************************************************************}
procedure TFMovMoedas.BAlteraClick(Sender: TObject);
begin
if MovMoedas.State in [ dsInsert, dsEdit ] then
 MovMoedas.Cancel;
end;

{ ************************ Habilitas os botoes e desabilita ****************** }
procedure TFMovMoedas.Habilita;
begin
BAltera.Enabled := not BAltera.Enabled;
BGrava.Enabled := not BGrava.Enabled;
BFecha.Enabled := not BFecha.Enabled;
CMes.Enabled := not CMes.Enabled;
CAno.Enabled := not CAno.Enabled;
EditLocaliza1.Enabled := not EditLocaliza1.Enabled;
Label1.Enabled := not Label1.Enabled;
Label2.Enabled := not Label2.Enabled;
Label3.Enabled := not Label3.Enabled;
end;

{******************* antes de gravar o registro *******************************}
procedure TFMovMoedas.MovMoedasAfterEdit(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  MovMoedasD_ULT_ALT.AsDateTime := Date;

  if MovMoedas.State in [dsEdit] then
    Habilita;
end;

{*****************************************************************************}
procedure TFMovMoedas.BitBtn4Click(Sender: TObject);
begin
AdiconaIndicePadrao;
end;

{****************************************************************************}
procedure TFMovMoedas.numerico1Change(Sender: TObject);
begin
if Numerico1.AValor <> 0 then
 BitBtn4.Enabled := true
else
 BitBtn4.Enabled := false;
end;

{*********** localiza a moeda para atualizar <> da moeda base **************** }
procedure TFMovMoedas.EditLocaliza1Select(Sender: TObject);
begin
EditLocaliza1.ASelectLocaliza.Clear;
EditLocaliza1.ASelectLocaliza.Add('select * from cadmoedas  where  c_nom_moe like ''@%''' +
                                  ' and i_cod_moe <> ' + IntToStr(varia.MoedaBase));
EditLocaliza1.ASelectValida.Clear;
EditLocaliza1.ASelectValida.Add('select * from cadmoedas where i_cod_moe = @' +
                                ' and i_cod_moe <> ' + IntToStr(varia.MoedaBase));
end;

Initialization
 RegisterClasses([TFMovMoedas]);
end.
