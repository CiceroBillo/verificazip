unit AMostraErrosExportacaoDados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, Grids, CGrades, StdCtrls, Buttons, UnDados;

type
  TFMostraErrosExportacaoDados = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    GErrosExportacao: TRBStringGridColor;
    PanelColor1: TPanelColor;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GErrosExportacaoCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GErrosExportacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GErrosExportacaoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
  private
    { Private declarations }
    VprDErroExportacao: TRBDExportacadoDadosErros;
    VprDExportacao: TRBDExportacaoDados;
    procedure CarTitulosGrade;
  public
    { Public declarations }
    procedure MostraErro(VpaDErroExportacao: TRBDExportacaoDados);
  end;

var
  FMostraErrosExportacaoDados: TFMostraErrosExportacaoDados;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFMostraErrosExportacaoDados.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
end;

{ *************************************************************************** }
procedure TFMostraErrosExportacaoDados.GErrosExportacaoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDErroExportacao := TRBDExportacadoDadosErros(VprDExportacao.ErrosExportacao.Items[VpaLinha-1]);
  GErrosExportacao.Cells[1,VpaLinha] := VprDErroExportacao.NomTabela;
  GErrosExportacao.Cells[2,VpaLinha]:= VprDErroExportacao.DesRegistro;
  GErrosExportacao.Cells[3,VpaLinha]:= VprDErroExportacao.DesErro;
end;

{ *************************************************************************** }
procedure TFMostraErrosExportacaoDados.GErrosExportacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  key := 0;
end;

{ *************************************************************************** }
procedure TFMostraErrosExportacaoDados.GErrosExportacaoMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDExportacao.ErrosExportacao.Count > 0 then
  begin
    VprDErroExportacao := TRBDExportacadoDadosErros(VprDExportacao.ErrosExportacao.Items[VpaLinhaAtual-1]);
  end;
end;

{ *************************************************************************** }
procedure TFMostraErrosExportacaoDados.MostraErro(VpaDErroExportacao: TRBDExportacaoDados);
begin
  VprDExportacao := VpaDErroExportacao;
  GErrosExportacao.ADados := VprDExportacao.ErrosExportacao;
  GErrosExportacao.CarregaGrade;
  if VpaDErroExportacao.ErrosExportacao.Count > 0 then
    showmodal;
end;

{ *************************************************************************** }
procedure TFMostraErrosExportacaoDados.BFecharClick(Sender: TObject);
begin
  close;
end;

{ *************************************************************************** }
procedure TFMostraErrosExportacaoDados.CarTitulosGrade;
begin
  GErrosExportacao.Cells[1,0] := 'Tabela';
  GErrosExportacao.Cells[2,0] := 'Registro';
  GErrosExportacao.Cells[3,0] := 'Erro';
end;

procedure TFMostraErrosExportacaoDados.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFMostraErrosExportacaoDados]);
end.
