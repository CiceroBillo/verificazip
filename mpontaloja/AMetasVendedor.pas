unit AMetasVendedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, ComCtrls,
  Localizacao, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, Spin,
  DBClient;

type
  TFMetasVendedor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    GridIndice1: TGridIndice;
    MetaVendedor: TSQL;
    DataMetaVendedor: TDataSource;
    MetaVendedorCODVENDEDOR: TFMTBCDField;
    MetaVendedorMESMETA: TFMTBCDField;
    MetaVendedorANOMETA: TFMTBCDField;
    Label1: TLabel;
    Label2: TLabel;
    EVendedor: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    EAno: TSpinEditColor;
    MetaVendedorVALMETA: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MetaVendedorAfterInsert(DataSet: TDataSet);
    procedure MetaVendedorAfterPost(DataSet: TDataSet);
    procedure GridIndice1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure AtualizaConsulta;
  public
    { Public declarations }
    procedure CadastraMeta(VpaCodVendedor : Integer);
  end;

var
  FMetasVendedor: TFMetasVendedor;

implementation

uses APrincipal, FunData, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMetasVendedor.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Eano.Value := ano(date);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMetasVendedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  MetaVendedor.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMetasVendedor.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMetasVendedor.CadastraMeta(VpaCodVendedor : Integer);
begin
  EVendedor.AInteiro := VpaCodVendedor;
  EVendedor.Atualiza;
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFMetasVendedor.AtualizaConsulta;
begin
  MetaVendedor.sql.clear;
  MetaVendedor.sql.add('Select CODVENDEDOR, MESMETA,ANOMETA, VALMETA '+
                       ' FROM METAVENDEDOR '+
                       ' Where ANOMETA = '+EAno.Text+
                       ' AND CODVENDEDOR = '+IntToStr(EVendedor.AInteiro));
  MetaVendedor.SQL.ADD('ORDER BY ANOMETA, MESMETA');
  MetaVendedor.open;
end;



procedure TFMetasVendedor.MetaVendedorAfterInsert(DataSet: TDataSet);
begin
  if EVendedor.AInteiro <> 0 then
  begin
    MetaVendedorCODVENDEDOR.AsInteger := EVendedor.AInteiro;
    MetaVendedorANOMETA.AsInteger := EAno.Value;
  end
  else
  begin
    MetaVendedor.cancel;
    aviso('VENDEDOR NÃO PREENCHIDO!!!'#13'É necessário preencher o vendedor');
  end;
end;

{******************************************************************************}
procedure TFMetasVendedor.MetaVendedorAfterPost(DataSet: TDataSet);
begin
  AtualizaConsulta;
  MetaVendedor.Last;
end;

procedure TFMetasVendedor.GridIndice1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = 46)  and not(MetaVendedor.State in [dsedit,dsinsert]) then
  begin
    if confirmacao(CT_DeletaRegistro) then
    begin
      MetaVendedor.delete;
      AtualizaConsulta;
    end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMetasVendedor]);
end.
