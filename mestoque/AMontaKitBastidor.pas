unit AMontaKitBastidor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, StdCtrls,
  Buttons, UnDadosProduto, Localizacao;

type
  TFMontaKitBastidor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    EBastidor: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EBastidorRetorno(Retorno1, Retorno2: String);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDConsumo : TRBDConsumoMP;
    VprDConsumoBastidor : TRBDConsumoMPBastidor;
    procedure CarTitulosGrade;
    function ExisteBastidor : Boolean;
    procedure CarDClasse;
  public
    { Public declarations }
    function AdicionaBastidores(VpaDConsumo : TRBDConsumoMP):Boolean;
  end;

var
  FMontaKitBastidor: TFMontaKitBastidor;

implementation

uses APrincipal, unProdutos, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMontaKitBastidor.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
  VprAcao := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMontaKitBastidor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMontaKitBastidor.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Bastidor';
  Grade.Cells[3,0] := 'Qtd Peças';
end;

{******************************************************************************}
function TFMontaKitBastidor.ExisteBastidor : Boolean;
begin
  result := false;
  if Grade.Cells[1,Grade.Alinha] <> '' then
  begin
    Result:= FunProdutos.ExisteBastidor(Grade.Cells[1,Grade.ALinha],VprDConsumoBastidor.NomBastidor);
    if Result then
    begin
      Grade.Cells[2,Grade.ALinha]:= VprDConsumoBastidor.NomBastidor;
    end;
  end;
end;                                                    

{******************************************************************************}
procedure TFMontaKitBastidor.CarDClasse;
begin
  VprDConsumoBastidor.CodBastidor := StrToInt(Grade.Cells[1,Grade.ALinha]);
  VprDConsumoBastidor.QtdPecas := StrToInt(Grade.Cells[3,Grade.ALinha]);
end;

{******************************************************************************}
function TFMontaKitBastidor.AdicionaBastidores(VpaDConsumo : TRBDConsumoMP):Boolean;
begin
  VprDConsumo := VpaDConsumo;
  Grade.ADados := VprDConsumo.Bastidores;
  Grade.CarregaGrade;  
  showmodal;
end;

{******************************************************************************}
procedure TFMontaKitBastidor.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDConsumoBastidor := TRBDConsumoMPBastidor(VprDConsumo.Bastidores[VpaLinha-1]);
  if VprDConsumoBastidor.CodBastidor <> 0 then
    Grade.Cells[1,VpaLinha]:= IntToStr(VprDConsumoBastidor.CodBastidor)
  else
    Grade.Cells[1,VpaLinha]:= '';
  Grade.Cells[2,VpaLinha]:= VprDConsumoBastidor.NomBastidor;
  if VprDConsumoBastidor.QtdPecas <> 0 then
    Grade.Cells[3,VpaLinha]:= IntToStr(VprDConsumoBastidor.QtdPecas)
  else
    Grade.Cells[3,VpaLinha]:= '';
end;

{******************************************************************************}
procedure TFMontaKitBastidor.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ExisteBastidor then
  begin
    aviso('BASTIDOR NÃO CADASTRADO!!!'#13'O bastidor digitado não existe cadastrado');
    VpaValidos:= False;
    Grade.Col:= 1;
  end
  else
    if Grade.Cells[3,Grade.ALinha] = '' then
    begin
      aviso('QUANTIDADE DE PEÇAS NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade de peças');
      VpaValidos:= False;
      Grade.Col:= 3;
    end;
  if vpavalidos then
  begin
    CarDClasse;
    if FunProdutos.ExisteBastidorDuplicado(VprDConsumo) then
    begin
      aviso('BASTIDOR DUPLICADO!!!'#13'O bastido digitado já existe nesse consumo.');
      VpaValidos := false;
    end;
  end;
end;

procedure TFMontaKitBastidor.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1,3: Value:= '0000000;0; ';
  end;

end;

procedure TFMontaKitBastidor.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    case Grade.AColuna of
      1: EBastidor.AAbreLocalizacao;
    end;
end;

{******************************************************************************}
procedure TFMontaKitBastidor.EBastidorRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[1,Grade.ALinha]:= EBastidor.Text;
    Grade.Cells[2,Grade.ALinha]:= Retorno1;
  end;
end;

{******************************************************************************}
procedure TFMontaKitBastidor.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDConsumo.Bastidores.Count > 0 then
  begin
    VprDConsumoBastidor:= TRBDConsumoMPBastidor(VprDConsumo.Bastidores.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFMontaKitBastidor.GradeNovaLinha(Sender: TObject);
begin
  VprDConsumoBastidor := VprDConsumo.addBastidor;
end;

{******************************************************************************}
procedure TFMontaKitBastidor.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1: if not ExisteBastidor then
           begin
             if not EBastidor.AAbreLocalizacao then
             begin
               Grade.Cells[1,Grade.ALinha]:= '';
               Abort;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFMontaKitBastidor.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMontaKitBastidor.BGravarClick(Sender: TObject);
begin
  close; 
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMontaKitBastidor]);
end.
