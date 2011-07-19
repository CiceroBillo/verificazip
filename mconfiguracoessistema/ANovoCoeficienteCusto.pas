unit ANovoCoeficienteCusto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, BotaoCadastro, StdCtrls, Buttons, Componentes1,
  ExtCtrls, PainelGradiente, Tabela, DBKeyViolation, Mask, DBCtrls, DB, DBClient;

type
  TFNovoCoeficienteCusto = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    CoeficienteCusto: TSQL;
    CoeficienteCustoCODCOEFICIENTE: TFMTBCDField;
    CoeficienteCustoNOMCOEFICIENTE: TWideStringField;
    CoeficienteCustoPERCOMISSAO: TFMTBCDField;
    CoeficienteCustoPERLUCRO: TFMTBCDField;
    DataCoeficienteCusto: TDataSource;
    CoeficienteCustoPERICMS: TFMTBCDField;
    CoeficienteCustoPERPISCOFINS: TFMTBCDField;
    CoeficienteCustoPERFRETE: TFMTBCDField;
    CoeficienteCustoPERADMINISTRATIVO: TFMTBCDField;
    CoeficienteCustoPERPROPAGANDA: TFMTBCDField;
    CoeficienteCustoPERVENDAPRAZO: TFMTBCDField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    DBEditColor5: TDBEditColor;
    DBEditColor6: TDBEditColor;
    DBEditColor7: TDBEditColor;
    Label11: TLabel;
    DBEditColor8: TDBEditColor;
    DBEditColor9: TDBEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CoeficienteCustoAfterInsert(DataSet: TDataSet);
    procedure CoeficienteCustoAfterEdit(DataSet: TDataSet);
    procedure CoeficienteCustoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNovoCoeficienteCusto: TFNovoCoeficienteCusto;

implementation

uses APrincipal, ACoeficientes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoCoeficienteCusto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CoeficienteCusto.Open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoCoeficienteCusto.BFecharClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFNovoCoeficienteCusto.CoeficienteCustoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{ **************************************************************************** }
procedure TFNovoCoeficienteCusto.CoeficienteCustoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{ **************************************************************************** }
procedure TFNovoCoeficienteCusto.CoeficienteCustoBeforePost(DataSet: TDataSet);
begin
  if CoeficienteCusto.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado
end;

{ **************************************************************************** }
procedure TFNovoCoeficienteCusto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoCoeficienteCusto]);
end.
