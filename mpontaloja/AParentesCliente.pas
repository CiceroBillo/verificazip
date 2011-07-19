unit AParentesCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, StdCtrls, UnDados,
  Buttons, Db, DBTables, Localizacao;

type
  TFParentesClientes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Aux: TQuery;
    ConsultaPadrao1: TConsultaPadrao;
    ECliente: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EClienteEnter(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprCodCliente : Integer;
    VprDParentesCliente : TRBdParenteCliente;
    VprParentes : TList;
    procedure CarTitulosGrade;
    function ExisteCliente : Boolean;
    procedure CarDParenteCliente;
  public
    { Public declarations }
    function ParentesClientes(VpaCodCliente : Integer ) : Boolean;
  end;

var
  FParentesClientes: TFParentesClientes;

implementation

uses APrincipal, UnClientes, FunObjeto, Constmsg, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFParentesClientes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
  VprAcao := false;
  VprPArentes := TList.create;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFParentesClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprParentes);
  VprParentes.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFParentesClientes.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Cliente';
end;

{******************************************************************************}
function TFParentesClientes.ExisteCliente : Boolean;
begin
  result := false;
  if Grade.Cells[1,Grade.Alinha] <> '' then
  begin
    AdicionaSqlAbreTabela(Aux,'Select C_NOM_CLI from CADCLIENTES ' +
                              ' Where I_COD_CLI = '+Grade.Cells[1,Grade.Alinha]);
    if not Aux.Eof then
    begin
      VprDParentesCliente.NomCliente := Aux.FieldByName('C_NOM_CLI').AsString;
      Grade.Cells[2,Grade.ALinha] := VprDParentesCliente.NomCliente;
      result := true;
    end;
  end;
end;

{******************************************************************************}
procedure TFParentesClientes.CarDParenteCliente;
begin
  VprDParentesCliente.CodCliente := StrtoInt(Grade.Cells[1,Grade.ALinha]);
end;

{******************************************************************************}
procedure TFParentesClientes.BCancelarClick(Sender: TObject);
begin
  VprACao := false;
  Close;
end;

{******************************************************************************}
function TFParentesClientes.ParentesClientes(VpaCodCliente : Integer ) : Boolean;
begin
  VprCodCliente := VpaCodCliente;
  FreeTObjectsList(VprParentes);
  FunClientes.CarDParenteCliente(VpaCodCliente,VprParentes);
  Grade.ADados := VprParentes;
  Grade.CarregaGrade;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFParentesClientes.BGravarClick(Sender: TObject);
Var
  VpfResultado : String;
begin
  VpfResultado := FunClientes.GravaDParentes(VprCodCliente,VprParentes);
  if VpfResultado = '' then
  begin
    VprAcao := true;
    Close;
  end
  else
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFParentesClientes.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDParentesCliente := TRBDParenteCliente(VprParentes.Items[VpaLinha-1]);
  if VprDParentesCliente.CodCliente <> 0 then
    Grade.cells[1,VpaLinha] := IntToStr(VprDParentesCliente.CodCliente)
  else
    Grade.cells[1,VpaLinha] := '';
  Grade.Cells[2,VpaLinha] := VprDParentesCliente.NomCliente;
end;

{******************************************************************************}
procedure TFParentesClientes.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if Grade.Cells[1,Grade.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso('CLIENTE NÃO PREENCHIDO!!!'#13'É necessário preencher o codigo do cliente...');
  end
  else
    if not ExisteCliente then
    begin
      VpaValidos := false;
      aviso('CLIENTE NÃO CADASTRADO!!!'#13'O cliente não existe no cadastro...');
      Grade.col := 1;
    end;
  if VpaValidos then
  begin
    CarDParenteCliente;
  end;
end;

{******************************************************************************}
procedure TFParentesClientes.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case Grade.Col of
        1 :  ECliente.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFParentesClientes.EClienteRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[1,Grade.ALinha] := ECliente.Text;
    Grade.Cells[2,Grade.ALinha] := Retorno1;
    Grade.AEstadoGrade := egEdicao;
  end;
end;

{******************************************************************************}
procedure TFParentesClientes.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprParentes.Count >0 then
  begin
    VprDParentesCliente := TRBDParenteCliente(VprParentes.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFParentesClientes.GradeNovaLinha(Sender: TObject);
begin
  VprDParentesCliente := TRBDParenteCliente.cria;
  VprParentes.add(VprDParentesCliente);
end;

{******************************************************************************}
procedure TFParentesClientes.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1 :if not ExisteCliente then
           begin
             if not ECliente.AAbreLocalizacao then
             begin
               Grade.Cells[1,Grade.ALinha] := '';
               Grade.Col := 1;
             end;
           end;
      end;
    end;
end;

procedure TFParentesClientes.EClienteEnter(Sender: TObject);
begin
  ECliente.clear;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFParentesClientes]);
end.
