unit ACreditoCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, StdCtrls,
  Buttons, UnDados, UnClientes;

type
  TFCreditoCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    VprCreditos : TList;
    VprCodCliente : Integer;
    VprDCreditoCliente : TRBDCreditoCliente;
    VprAcao : Boolean;
    procedure CarTituloGrade;
    procedure CarDClasse;
  public
    { Public declarations }
    function CreditoCliente(VpaCodCliente : Integer):boolean;
    procedure ConsultaCreditoCliente(VpaCodCliente : Integer);
  end;

var
  FCreditoCliente: TFCreditoCliente;

implementation

uses APrincipal, FunObjeto, Constantes, FunData, FunString, Constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCreditoCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTituloGrade;
  VprCreditos := TList.Create;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCreditoCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprCreditos);
  VprCreditos.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCreditoCliente.CarTituloGrade;
begin
  Grade.Cells[1,0] := 'C/D';
  Grade.Cells[2,0] := 'Valor Inicial';
  Grade.Cells[3,0] := 'Valor';
  Grade.Cells[4,0] := 'Data';
  Grade.Cells[5,0] := 'Observações';
end;

{******************************************************************************}
procedure TFCreditoCliente.ConsultaCreditoCliente(VpaCodCliente: Integer);
begin
  VprCodCliente := vpaCodCliente;
  AlterarVisibleDet([BGravar,BCancelar],false);
  BFechar.Visible := true;
  FunClientes.CarCreditoCliente(VpaCodCliente,VprCreditos,false,dcCredito);
  if VprCreditos.Count > 0 then
  begin
    Grade.ADados := VprCreditos;
    Grade.CarregaGrade;
    showmodal;
  end;
end;

{******************************************************************************}
procedure TFCreditoCliente.CarDClasse;
begin
  if UpperCase(Grade.Cells[1,Grade.ALinha]) = 'C' then
    VprDCreditoCliente.TipCredito := dcCredito
  else
    VprDCreditoCliente.TipCredito := dcDebito;
  VprDCreditoCliente.ValCredito := StrToFloat(DeletaChars(Grade.Cells[3,Grade.ALinha],'.'));
  if Grade.AEstadoGrade in [egInsercao] then
    VprDCreditoCliente.ValInicial := VprDCreditoCliente.ValCredito;
  try
    VprDCreditoCliente.DatCredito := StrToDate(Grade.Cells[4,Grade.ALinha])
  except
    VprDCreditoCliente.DatCredito := MontaData(1,1,1900);
  end;
  VprDCreditoCliente.DesObservacao := Grade.Cells[5,Grade.ALinha];
end;

{******************************************************************************}
function TFCreditoCliente.CreditoCliente(VpaCodCliente : Integer):boolean;
begin
  VprCodCliente := vpaCodCliente;
  FunClientes.CarCreditoCliente(VpaCodCliente,VprCreditos,false,dcTodos);
  Grade.ADados := VprCreditos;
  Grade.CarregaGrade;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFCreditoCliente.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCreditoCliente:= TRBDCreditoCliente(VprCreditos.Items[VpaLinha-1]);
  case VprDCreditoCliente.TipCredito of
    dcCredito: Grade.Cells[1,VpaLinha]:= 'C';
    dcDebito: Grade.Cells[1,VpaLinha]:= 'D';
  end;
  Grade.Cells[2,VpaLinha]:= FormatFloat(varia.MascaraValor,VprDCreditoCliente.ValInicial);
  Grade.Cells[3,VpaLinha]:= FormatFloat(varia.MascaraValor,VprDCreditoCliente.ValCredito);
  if VprDCreditoCliente.DatCredito > MontaData(1,1,1900) then
    Grade.Cells[4,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDCreditoCliente.DatCredito)
  else
    Grade.Cells[4,VpaLinha]:= '';
  Grade.Cells[5,VpaLinha]:= VprDCreditoCliente.DesObservacao;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if (UpperCase(Grade.Cells[1,Grade.ALinha]) <> 'C') and
     (UpperCase(Grade.Cells[1,Grade.ALinha]) <> 'D') then
  begin
    VpaValidos := false;
    aviso('TIPO DEBITO/CREDITO INVÁLIDO!!!'#13'É permitido digitar somente :'#13'C- Crédito'#13'D - Débito');
    Grade.COL := 1;
  end;
  if Grade.Cells[3,Grade.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso('VALOR DO CRÉDITO NÃO PREENCHIDO!!!'#13'É necessário preenhcer o valor do crédito.');
    Grade.COL := 3;
  end;
  if VpaValidos then
  begin
    CarDClasse;
    if VprDCreditoCliente.ValCredito = 0 then
    begin
      VpaValidos := false;
      aviso('VALOR DO CRÉDITO NÃO PREENCHIDO!!!'#13'É necessário preenhcer o valor do crédito.');
      Grade.COL := 3;
    end
    else
      if (VprDCreditoCliente.ValCredito > VprDCreditoCliente.ValInicial) then
      begin
        VpaValidos := false;
        aviso('VALOR DO CRÉDITO NÃO PODE SER MAIOR QUE O VALOR INICIAL!!!'#13'O valor do crédito não pode ser maior que o valor inicial');
        Grade.COL := 3;
      end;
    if VprDCreditoCliente.DatCredito <= montadata(1,1,1900) then
    begin
      VpaValidos := false;
      aviso('DATA DO CRÉDITO INVÁLIDA!!!'#13'É necessário digitar uma data válida.');
      Grade.col := 4;
    end;
  end;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    4 : Value := DeletaChars(Fprincipal.CorFoco.AMascaraData,'\');
  end;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprCreditos.Count >0 then
  begin
    VprDCreditoCliente := TRBDCreditoCliente(VprCreditos.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeNovaLinha(Sender: TObject);
begin
  VprDCreditoCliente := TRBDCreditoCliente.cria;
  VprCreditos.add(VprDCreditoCliente);
  VprDCreditoCliente.DatCredito := date;
end;

{******************************************************************************}
procedure TFCreditoCliente.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCreditoCliente.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunClientes.GravaCreditoCliente(VprCodCliente,VprCreditos);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    close;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  if Grade.col = 2 then
    key := #0;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCreditoCliente]);
end.
