unit ADocumentosReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Tabela, Constantes,
  DBCtrls, ComCtrls, Localizacao, Mask, DBKeyViolation, TeeProcs, TeEngine,
  Chart, Series, DBChart, LabelCorMove, EditorImagem, Geradores, ToolWin,
  ImgList;

type
  TFDocumentosReceber = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    Localiza: TConsultaPadrao;
    DataMovParcelas: TDataSource;
    MovParcelas: TQuery;
    tempo: TPainelTempo;
    PanelColor3: TPanelColor;
    Label8: TLabel;
    Label10: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    SpeedButton4: TSpeedButton;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    EditLocaliza4: TEditLocaliza;
    GReceber: TGridIndice;
    MovParcelasC_NOM_PLA: TStringField;
    MovParcelasC_NOM_CLI: TStringField;
    MovParcelasC_COD_FRA: TStringField;
    MovParcelasC_NOM_PAG: TStringField;
    MovParcelasC_NRO_CON: TStringField;
    MovParcelasC_NRO_DOC: TStringField;
    MovParcelasD_FRA_VEN: TDateField;
    MovParcelasI_COD_BAN: TIntegerField;
    MovParcelasD_DAT_VEN: TDateField;
    MovParcelasN_VLR_PAG: TFloatField;
    MovParcelasC_NOM_BAN: TStringField;
    MovParcelasC_NOM_FRM: TStringField;
    Label1: TLabel;
    EPagto: TEditLocaliza;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label15: TLabel;
    EditColor4: TEditColor;
    Label11: TLabel;
    EditColor8: TEditColor;
    MovParcelasN_VLR_PAR: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  FDocumentosReceber: TFDocumentosReceber;

implementation

uses fundata, APrincipal, constmsg, ANovoContasaReceber, ABaixaContasReceber,
   AGraficosContasaReceber, AImprimeCR, AManutencaoCR, funsql, APlanoConta,
  AMovComissoes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDocumentosReceber.FormCreate(Sender: TObject);
begin
   DataParcela1.Date := PrimeiroDiaMes(date);
   DataParcela2.Date := UltimoDiaMes(date);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDocumentosReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaTabela(MovParcelas);
   Action := CaFree;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFDocumentosReceber.BitBtn1Click(Sender: TObject);
begin
  if FGraficosCR <> nil then
   FGraficosCR.close;
     close;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

Initialization
  RegisterClasses([TFDocumentosReceber]);
end.
