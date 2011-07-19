unit ANovaRepresentada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Localizacao, Tabela, StdCtrls, Mask, DBCtrls,
  DBKeyViolation, Buttons, DB, DBClient, CBancoDados, Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro;

type
  TFNovaRepresentada = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Representada: TRBSQL;
    RepresentadaCODREPRESENTADA: TFMTBCDField;
    RepresentadaNOMREPRESENTADA: TWideStringField;
    RepresentadaNOMFANTASIA: TWideStringField;
    RepresentadaDESENDERECO: TWideStringField;
    RepresentadaDESBAIRRO: TWideStringField;
    RepresentadaDESCEP: TWideStringField;
    RepresentadaDESCOMPLEMENTO: TWideStringField;
    RepresentadaNUMENDERECO: TFMTBCDField;
    RepresentadaDESCIDADE: TWideStringField;
    RepresentadaDESUF: TWideStringField;
    RepresentadaDESCNPJ: TWideStringField;
    RepresentadaDESINSCRICAOESTADUAL: TWideStringField;
    RepresentadaDESEMAIL: TWideStringField;
    DataRepresentada: TDataSource;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    BCidade: TSpeedButton;
    Label10: TLabel;
    SpeedButton11: TSpeedButton;
    Label14: TLabel;
    Label15: TLabel;
    Label42: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    DBEditColor5: TDBEditColor;
    DBEditColor6: TDBEditColor;
    DBEditColor7: TDBEditColor;
    ECidade: TDBEditLocaliza;
    DBEditUF1: TDBEditUF;
    DBEditCGC1: TDBEditCGC;
    DBEditInsEstadual1: TDBEditInsEstadual;
    DBEditColor8: TDBEditColor;
    Label11: TLabel;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    RepresentadaDESFONE: TWideStringField;
    RepresentadaDESFAX: TWideStringField;
    DBEditPos21: TDBEditPos2;
    Label52: TLabel;
    DBEditPos22: TDBEditPos2;
    Label12: TLabel;
    Localiza: TConsultaPadrao;
    RepresentadaDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ECidadeRetorno(Retorno1, Retorno2: string);
    procedure BFecharClick(Sender: TObject);
    procedure RepresentadaAfterInsert(DataSet: TDataSet);
    procedure RepresentadaAfterEdit(DataSet: TDataSet);
    procedure RepresentadaBeforePost(DataSet: TDataSet);
    procedure RepresentadaAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNovaRepresentada: TFNovaRepresentada;

implementation

uses APrincipal, ARepresentada, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaRepresentada.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Representada.open;
end;

{ **************************************************************************** }
procedure TFNovaRepresentada.RepresentadaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{ **************************************************************************** }
procedure TFNovaRepresentada.RepresentadaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{ **************************************************************************** }
procedure TFNovaRepresentada.RepresentadaAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('REPRESENTADA');
end;

{ **************************************************************************** }
procedure TFNovaRepresentada.RepresentadaBeforePost(DataSet: TDataSet);
begin
  if Representada.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  RepresentadaDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaRepresentada.BFecharClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFNovaRepresentada.ECidadeRetorno(Retorno1, Retorno2: string);
begin
  if (Retorno2 <> '') then
    if (Representada.State in [dsInsert, dsEdit]) then
    begin
      RepresentadaDESUF.AsString :=Retorno2; // Grava o Estado;
    end;
end;

{ **************************************************************************** }
procedure TFNovaRepresentada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Representada.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaRepresentada]);
end.
