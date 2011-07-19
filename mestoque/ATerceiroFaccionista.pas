unit ATerceiroFaccionista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, CGrades, Componentes1, ExtCtrls, UnDadosProduto,
  PainelGradiente, Mask, numericos;

type
  TFTerceiroFaccionista = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Label1: TLabel;
    ETotal: Tnumerico;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeDepoisExclusao(Sender: TObject);
  private
    { Private declarations }
    VprDRevisao : TRBDRevisaoFracaoFaccionista;
    VprDTerceiro : TRBDRevisaoFracaoTerceiroFaccionista;
    VprAcao : Boolean;
    procedure CarTituloGrade;
    procedure CarDTErceiroClasse;
    procedure AtualizaQtdTotal;
  public
    { Public declarations }
    function CadastraTerceiros(VpaDRevisao : TRBDRevisaoFracaoFaccionista) : Boolean;
  end;

var
  FTerceiroFaccionista: TFTerceiroFaccionista;

implementation

uses APrincipal, constmsg, UnOrdemproducao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTerceiroFaccionista.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTituloGrade;
end;

{ **************************************************************************** }
procedure TFTerceiroFaccionista.GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDTerceiro := TRBDRevisaoFracaoTerceiroFaccionista(VprDRevisao.Terceiros.Items[VpaLinha-1]);
  Grade.Cells[1,VpaLinha]:= VprDTerceiro.NomTerceiro;
  if VprDTerceiro.QtdRevisado <> 0 then
    Grade.Cells[2,VpaLinha]:= InttoStr(VprDTerceiro.QtdRevisado)
  else
    Grade.Cells[2,VpaLinha]:= '';
  if VprDTerceiro.QtdDefeito <> 0 then
    Grade.Cells[3,VpaLinha]:= InttoStr(VprDTerceiro.QtdDefeito)
  else
    Grade.Cells[3,VpaLinha]:= '';
end;

{ **************************************************************************** }
procedure TFTerceiroFaccionista.GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if (Grade.Cells[1,Grade.ALinha] = '') then
  begin
    VpaValidos := false;
    aviso('NOME DO TERCEIRO NÃO PREENCHIDO!!!'#13'É necessário digitar o nome do terceiro.');
    Grade.Col := 1;
  end
  else
    if (Grade.Cells[2,Grade.ALinha] = '') then
    begin
      VpaValidos := false;
      aviso('QUANTIDADE REVISADA NÃO PREENCHIDA !!!'#13'É necessário digitar a quantidade revisada.');
      Grade.Col := 2;
    end;
  if VpaValidos then
  begin
    CarDTErceiroClasse;
    AtualizaQtdTotal;
    if VprDTerceiro.QtdRevisado = 0 then
    begin
      VpaValidos := false;
      aviso('QUANTIDADE REVISADA NÃO PREENCHIDA !!!'#13'É necessário digitar a quantidade revisada.');
      Grade.Col := 2;
    end
end;
end;

procedure TFTerceiroFaccionista.GradeDepoisExclusao(Sender: TObject);
begin
  AtualizaQtdTotal;
end;

{ **************************************************************************** }
procedure TFTerceiroFaccionista.GradeGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
begin
  case ACol of
    2,3 :  Value := '0000000;0; ';
  end;
end;

{ **************************************************************************** }
procedure TFTerceiroFaccionista.GradeMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDRevisao.Terceiros.Count >0 then
  begin
    VprDTerceiro := TRBDRevisaoFracaoTerceiroFaccionista(VprDRevisao.Terceiros.Items[VpaLinhaAtual-1]);
  end;
end;

procedure TFTerceiroFaccionista.GradeNovaLinha(Sender: TObject);
begin
  VprDTerceiro := VprDRevisao.AddTerceiro;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTerceiroFaccionista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTerceiroFaccionista.CarDTErceiroClasse;
begin
  VprDTerceiro.NomTerceiro := Grade.Cells[1,Grade.ALinha];
  VprDTerceiro.QtdRevisado := StrToInt(Grade.Cells[2,Grade.ALinha]);
  if Grade.Cells[3,Grade.ALinha] <> '' then
    VprDTerceiro.QtdDefeito := StrToInt(Grade.Cells[3,Grade.ALinha])
  else
    VprDTerceiro.QtdDefeito := 0;
end;

{******************************************************************************}
procedure TFTerceiroFaccionista.CarTituloGrade;
begin
  Grade.cells[1,0] := 'Nome';
  Grade.cells[2,0] := 'Qtd Revisada';
  Grade.cells[3,0] := 'Qtd Defeito';
end;

{******************************************************************************}
procedure TFTerceiroFaccionista.BGravarClick(Sender: TObject);
begin
  FunOrdemProducao.CalculaTotaisRevisaoTerceiro(VprDRevisao);
  VprAcao := true;
  close;
end;

{******************************************************************************}
function TFTerceiroFaccionista.CadastraTerceiros(VpaDRevisao : TRBDRevisaoFracaoFaccionista) : Boolean;
begin
  VprDRevisao := VpaDRevisao;
  Grade.ADados := VpaDRevisao.Terceiros;
  Grade.CarregaGrade;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFTerceiroFaccionista.AtualizaQtdTotal;
var
  VpfLaco, VpfQtd : Integer;
begin
  VpfQtd := 0;
  for VpfLaco := 0 to VprDRevisao.Terceiros.Count - 1 do
  begin
     VpfQtd := VpfQtd + TRBDRevisaoFracaoTerceiroFaccionista(VprDRevisao.Terceiros.Items[VpfLaco]).QtdRevisado;
  end;
  ETotal.AsInteger := VpfQtd;
end;

{******************************************************************************}
procedure TFTerceiroFaccionista.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTerceiroFaccionista]);
end.
