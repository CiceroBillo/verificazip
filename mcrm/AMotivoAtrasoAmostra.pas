unit AMotivoAtrasoAmostra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, Localizacao, ComCtrls, Buttons, ExtCtrls,
  PainelGradiente, Grids, DBGrids, Tabela, DB, DBClient, UnAmostra, UnDados, ConstMsg;

type
  TFMotivoAtrasoAmostra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    SpeedButton8: TSpeedButton;
    LMotivo: TLabel;
    EMotivoAtraso: TEditLocaliza;
    Label2: TLabel;
    EObservacao: TEditColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    DataAMOSTRACORMOTIVOATRASO: TDataSource;
    AMOSTRACORMOTIVOATRASO: TSQL;
    AMOSTRACORMOTIVOATRASOCODAMOSTRA: TFMTBCDField;
    AMOSTRACORMOTIVOATRASOCODCOR: TFMTBCDField;
    AMOSTRACORMOTIVOATRASOSEQITEM: TFMTBCDField;
    AMOSTRACORMOTIVOATRASOCODMOTIVOATRASO: TFMTBCDField;
    AMOSTRACORMOTIVOATRASODESMOTIVOATRASO: TWideStringField;
    AMOSTRACORMOTIVOATRASODESOBSERVACAO: TWideStringField;
    localiza: TConsultaPadrao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    FunAmostra : TRBFuncoesAmostra;
    VprCodAmostra,
    VprCodCor: Integer;
    VprDMotivoAmostra: TRBDPropostaAmostraMotivoAtraso;
    procedure CarDClasse;
  public
    procedure AbreMotivoAmostra(VpaCodAmostra, VpaCodCor: Integer);
  end;

var
  FMotivoAtrasoAmostra: TFMotivoAtrasoAmostra;

implementation

uses AAmostras, APrincipal, Constantes;

{$R *.DFM}


{ **************************************************************************** }
procedure TFMotivoAtrasoAmostra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
end;

{ *************************************************************************** }
procedure TFMotivoAtrasoAmostra.AbreMotivoAmostra(VpaCodAmostra,
  VpaCodCor: Integer);
begin
  VprCodAmostra:= VpaCodAmostra;
  VprCodCor:= VpaCodCor;
  ShowModal;
end;

{******************************************************************************}
procedure TFMotivoAtrasoAmostra.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMotivoAtrasoAmostra.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMotivoAtrasoAmostra.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  CarDClasse;
  VpfResultado:= FunAmostra.GravaDMotivoAmostra(VprDMotivoAmostra);
  if VpfResultado <> '' then
    aviso(VpfResultado);
  close;
end;

{******************************************************************************}
procedure TFMotivoAtrasoAmostra.BOkClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFMotivoAtrasoAmostra.CarDClasse;
begin
   VprDMotivoAmostra:= TRBDPropostaAmostraMotivoAtraso.Cria;
   VprDMotivoAmostra.SeqItem:= FunAmostra.RSeqItemDisponivelMotivoAmostra;
   VprDMotivoAmostra.CodAmostra:= VprCodAmostra;
   VprDMotivoAmostra.CodCor:= VprCodCor;
   VprDMotivoAmostra.CodMotivoAtraso:= EMotivoAtraso.AInteiro;
   VprDMotivoAmostra.DesObservacao:= EObservacao.Text;
   VprDMotivoAmostra.CodUsuario:= varia.CodigoUsuario;
end;

{******************************************************************************}
procedure TFMotivoAtrasoAmostra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMotivoAtrasoAmostra]);
end.
