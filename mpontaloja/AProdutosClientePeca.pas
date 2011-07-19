unit AProdutosClientePeca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela, DBKeyViolation, StdCtrls,
  Buttons, Componentes1, DB, DBClient, ConstMsg, FunObjeto, CGrades, FunSql, UnDados, FunData, UnDadosProduto;

type
  TFProdutosClientePeca = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Grade: TRBStringGridColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeClick(Sender: TObject);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeDadosValidosForaGrade(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GradeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
  private
    { Private declarations }
    VprAcao,
    VprIndNota: Boolean;
    VprDItem : TRBDProdutoClientePeca;
    VprDProdutoCliente: TRBDProdutoCliente;
    VprProdutoAnterior : String;
    procedure CarTitulosGrade;
    function ExisteProduto : boolean;
    function LocalizaProduto : Boolean;
    procedure CarDItemProduto;
  public
    procedure AtualizaConsulta(VpaDProdutoCliente: TRBDProdutoCliente);
    procedure AtualizaConsultaNota(VpaProdutoNota: TList);
  end;

var
  FProdutosClientePeca: TFProdutosClientePeca;

implementation

uses APrincipal, UnClientes, ALocalizaProdutos, UnProdutos;

{$R *.DFM}


{ **************************************************************************** }
procedure TFProdutosClientePeca.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTitulosGrade;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItem := TRBDProdutoClientePeca(VprDProdutoCliente.Pecas.Items[vpaLinha-1]);
  Grade.Cells[1,VpaLinha] := VprDItem.CodProduto;
  Grade.Cells[2,VpaLinha] := VprDItem.NomProduto;
  Grade.Cells[3,VpaLinha] := VprDItem.NumSerieProduto;
  if VprDItem.DatInstalacao > MontaData(1,1,1900) then
    Grade.Cells[4,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDItem.DatInstalacao)
  else
    Grade.Cells[4,VpaLinha] := '';
end;

{******************************************************************************}
procedure TFProdutosClientePeca.GradeClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFProdutosClientePeca.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if Grade.Cells[1,Grade.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTONAOCADASTRADO);
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      Grade.Col := 1;
    end;

  if Vpavalidos then
  begin
    CarDItemProduto;
  end;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.GradeDadosValidosForaGrade(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  case ACol of
    4 :  Value := '!99/00/0000;1;_';
  end;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case Grade.AColuna of
        1: LocalizaProduto;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDProdutoCliente.Pecas.Count >0 then
  begin
    VprDItem := TRBDProdutoClientePeca(VprDProdutoCliente.Pecas.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDItem.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.GradeNovaLinha(Sender: TObject);
begin
  VprDItem := TRBDProdutoClientePeca.cria;
  VprDProdutoCliente.Pecas.add(VprDItem);
end;

{******************************************************************************}
procedure TFProdutosClientePeca.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1 :if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               Grade.Cells[1,Grade.ALinha] := '';
               abort;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
function TFProdutosClientePeca.LocalizaProduto: Boolean;
Var
  VpfUm, VpfClaFiscal: String;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDItem.SeqProdutoPeca,VprDItem.CodProduto,VprDItem.NomProduto,VpfUm,VpfClaFiscal);
  FlocalizaProduto.free;
  if result then  // se o usuario nao cancelou a consulta
  begin
    VprProdutoAnterior := VprDItem.CodProduto;
    Grade.Cells[1,Grade.ALinha] := VprDItem.CodProduto;
    Grade.Cells[2,Grade.ALinha] := VprDItem.NomProduto;
  end;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.CarDItemProduto;
begin
  VprDItem.CodProduto := Grade.Cells[1,Grade.Alinha];
  VprDItem.NomProduto := Grade.Cells[2,Grade.Alinha];
  VprDItem.NumSerieProduto := Grade.Cells[3,Grade.ALinha];
  if Grade.Cells[4,Grade.ALinha] <> '' then
    VprDItem.DatInstalacao := StrToDate(Grade.Cells[4,Grade.ALinha])
  else
    VprDItem.DatInstalacao := MontaData(1,1,1900);
end;

{******************************************************************************}
procedure TFProdutosClientePeca.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código Produto';
  Grade.Cells[2,0] := 'Produto';
  Grade.Cells[3,0] := 'Numero Série';
  Grade.Cells[4,0] := 'Data Instalação';
end;

{******************************************************************************}
function TFProdutosClientePeca.ExisteProduto: boolean;
begin
  if (Grade.Cells[1,Grade.ALinha] <> '') then
  begin
    if Grade.Cells[1,Grade.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      VprDItem.CodProduto := Grade.Cells[1,Grade.ALinha];
      result := FunProdutos.ExisteProduto(VprDItem.CodProduto,VprDItem.SeqProdutoPeca,VprDItem.NomProduto);
      if result then
      begin
        Grade.Cells[1,Grade.ALinha] := VprDItem.CodProduto;
        VprProdutoAnterior := VprDItem.CodProduto;
        Grade.Cells[2,Grade.ALinha] := VprDItem.NomProduto;
      end;
    end;
  end
  else
    result := false;
end;

{ *************************************************************************** }
procedure TFProdutosClientePeca.AtualizaConsulta(VpaDProdutoCliente: TRBDProdutoCliente);
begin
  VprDProdutoCliente:= VpaDProdutoCliente;
  grade.ADados:= VpaDProdutoCliente.Pecas;
  grade.CarregaGrade;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.AtualizaConsultaNota(VpaProdutoNota: TList);
begin
  VprDProdutoCliente:= TRBDProdutoCliente.cria;
  VprDProdutoCliente.Pecas:= VpaProdutoNota;
  Grade.ADados:= VprDProdutoCliente.Pecas;
  Grade.CarregaGrade;
  VprIndNota:= true;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFProdutosClientePeca.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if not VprIndNota then
  begin
    VpfResultado := FunClientes.GravaDProdutoClientePeca(VprDProdutoCliente);
  end;
  if VpfResultado = '' then
    begin
      VprAcao := true;
      close;
    end
    else
      aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFProdutosClientePeca.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFProdutosClientePeca]);
end.
