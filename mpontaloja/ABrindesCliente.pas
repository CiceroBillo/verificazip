unit ABrindesCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, Db, DBTables,
  DBGrids, Tabela, DBKeyViolation, StdCtrls, Buttons, UnDados, UnClientes, UnProdutos,
  ConvUnidade,sqlexpr;

type
  TFBrindesCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprCodCliente : Integer;
    VprBrindes : TList;
    VprDBrinde : TRBDBrindeCliente;
    VprProdutoAnterior : String;
    procedure CarTitulosGrade;
    function  LocalizaProduto : Boolean;
    function ExisteProduto : Boolean;
    procedure CarDProdutoBrinde;
    function VerificaProdutoBrindeDuplicado : Boolean;
  public
    { Public declarations }
    procedure BrindesCliente(VpaCodCliente : Integer);
  end;

var
  FBrindesCliente: TFBrindesCliente;

implementation

uses APrincipal,Constantes, Constmsg, ALocalizaProdutos, FunString, FunData;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBrindesCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBrindesCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFBrindesCliente.CarTitulosGrade;
begin
  Grade.Cells[1,0]:= 'Código';
  Grade.Cells[2,0]:= 'Produto';
  Grade.Cells[3,0]:= 'UM';
  Grade.Cells[4,0]:= 'Quantidade';
  Grade.Cells[5,0]:= 'Código';
  Grade.Cells[6,0]:= 'Usuário';
  Grade.Cells[7,0]:= 'Data Cadastro';
end;

{******************** localiza o produto digitado *****************************}
Function TFBrindesCliente.LocalizaProduto : Boolean;
var
  VpfClaFiscal : String;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDBrinde.SeqProduto,VprDBrinde.CodProduto,VprDBrinde.NomProduto,VprDBrinde.um,VpfClaFiscal);
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
    begin
      with VprDBrinde do
      begin
        UMOriginal := UM;
        VprDBrinde.UnidadeParentes.free;
        VprDBrinde.UnidadeParentes := FunProdutos.rUnidadesParentes(VprDBrinde.UMOriginal);
        VprProdutoAnterior := CodProduto;
        Grade.Cells[1,Grade.ALinha] := CodProduto;
        Grade.Cells[2,Grade.ALinha] := NomProduto;
        Grade.Cells[3,Grade.ALinha] := UM;
      end;
    end;
end;

{******************** verifica se o produto existe ****************************}
function TFBrindesCliente.ExisteProduto : Boolean;
begin
  if (Grade.Cells[1,Grade.ALinha] <> '') then
  begin
    if Grade.Cells[1,Grade.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      result := FunProdutos.ExisteProduto(Grade.Cells[1,Grade.ALinha],VprDBrinde.SeqProduto,VprDBrinde.NomProduto,Vprdbrinde.UM);
      if result then
      begin
        VprDBrinde.UMOriginal := vprdBrinde.UM;
        VprDBrinde.UnidadeParentes.free;
        VprDBrinde.UnidadeParentes :=  FunProdutos.RUnidadesParentes(VprDBrinde.UMOriginal);
        VprDBrinde.CodProduto := Grade.Cells[1,grade.ALinha];
        VprProdutoAnterior := VprDBrinde.CodProduto;
        Grade.Cells[2,Grade.ALinha] := VprDBrinde.NomProduto;
        Grade.Cells[3,Grade.ALinha] := VprDBrinde.UM;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
procedure TFBrindesCliente.CarDProdutoBrinde;
begin
  VprDBrinde.CodProduto := Grade.Cells[1,Grade.Alinha];
  VprDBrinde.UM := Grade.Cells[3,Grade.ALinha];
  VprDBrinde.QtdProduto := StrToFloat(DeletaChars(Grade.Cells[4,Grade.ALinha],'.'));
end;

{******************************************************************************}
function TFBrindesCliente.VerificaProdutoBrindeDuplicado : Boolean;
var
  VpfLacoInterno,VpfLacoExterno : Integer;
  VpfDBrindeInterno,VpfDBrindeExterno : TRBDBrindeCliente;
begin
  result := false;
  for VpfLacoExterno := 0 to VprBrindes.Count - 2 do
  begin
    VpfDBrindeExterno := TRBDBrindeCliente(VprBrindes.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VprBrindes.Count - 1 do
    begin
      VpfDBrindeInterno := TRBDBrindeCliente(VprBrindes.Items[VpflacoInterno]);
      if VpfDBrindeExterno.SeqProduto = VpfDBrindeInterno.SeqProduto then
      begin
        result := true;
        aviso('PRODUTO DUPLICADO!!!'#13'O produto digitado está duplicado.');
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFBrindesCliente.BrindesCliente(VpaCodCliente : Integer);
begin
  VprCodCliente := VpaCodCliente;
  VprBrindes := TList.create;
  Grade.ADados := VprBrindes;
  FunClientes.CardBrinde(VpaCodCliente,VprBrindes);
  Grade.CarregaGrade;
  showmodal;
end;

{******************************************************************************}
procedure TFBrindesCliente.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFBrindesCliente.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDBrinde := TRBDBrindeCliente(VprBrindes.Items[VpaLinha-1]);
  Grade.cells[1,VpaLinha] := VprDBrinde.CodProduto;
  Grade.Cells[2,VpaLinha] := VprDBrinde.NomProduto;
  Grade.Cells[3,VpaLinha] := VprDBrinde.UM;
  Grade.Cells[4,VpaLinha] := FormatFloat(varia.MascaraQtd,VprDBrinde.QtdProduto);
  if VprDBrinde.CodUsuario <> 0 then
    Grade.Cells[5,VpaLinha]:= IntToStr(VprDBrinde.CodUsuario)
  else
    Grade.Cells[5,VpaLinha]:= '';
  Grade.Cells[6,VpaLinha]:= VprDBrinde.NomUsuario;
  if VprDBrinde.DatCadastro > MontaData(1,1,1900) then
    Grade.Cells[7,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDBrinde.DatCadastro)
  else
    Grade.Cells[7,VpaLinha]:= '';
end;

{******************************************************************************}
procedure TFBrindesCliente.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if Grade.Cells[1,Grade.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      Grade.col := 1;
    end
    else
      if (VprDBrinde.UnidadeParentes.IndexOf(Grade.Cells[3,Grade.Alinha]) < 0) then
      begin
        VpaValidos := false;
        aviso(CT_UNIDADEVAZIA);
        Grade.col := 3;
      end
      else
        if (Grade.Cells[4,Grade.ALinha] = '') then
        begin
          VpaValidos := false;
          aviso(CT_QTDPRODUTOINVALIDO);
          Grade.Col := 4;
        end;

  if VpaValidos then
  begin
    CarDProdutoBrinde;
    if VprDBrinde.QtdProduto = 0 then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      Grade.col := 4;
    end;
    if VpaValidos then
    begin
      VpaValidos := not VerificaProdutoBrindeDuplicado;
    end;
  end;
end;

{******************************************************************************}
procedure TFBrindesCliente.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case Grade.Col of
        1 :  LocalizaProduto;
      end;
    end;
  end;

end;

{******************************************************************************}
procedure TFBrindesCliente.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = '.') and (Grade.col <> 1) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFBrindesCliente.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprBrindes.Count > 0 then
  begin
    VprDBrinde := TRBDBrindeCliente(VprBrindes.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDBrinde.CodProduto;
  end;
end;


{******************************************************************************}
procedure TFBrindesCliente.GradeNovaLinha(Sender: TObject);
begin
  VprDBrinde := TRBDBrindeCliente.cria;
  VprDBrinde.CodUsuario:= Varia.CodigoUsuario;
  VprDBrinde.NomUsuario:= Varia.NomeUsuario;
  VprDBrinde.DatCadastro:= Now;
  VprBrindes.add(VprdBrinde);
end;

{******************************************************************************}
procedure TFBrindesCliente.GradeSelectCell(Sender: TObject; ACol,
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
               Grade.Col := 1;
             end;
           end;
        3 : if Grade.Cells[3,Grade.ALinha] <> '' then
              if (VprDBrinde.UnidadeParentes.IndexOf(Grade.Cells[3,Grade.ALinha]) < 0) then
              begin
                aviso(CT_UNIDADEVAZIA);
                Grade.col := 3;
                abort;
              end;
      end;
    end;
end;

{******************************************************************************}
procedure TFBrindesCliente.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao : TTransactionDesc;
begin
  VpfTransacao.IsolationLevel := xilREADCOMMITTED;
  FPrincipal.BaseDados.StartTransaction(VpfTransacao);
  VpfResultado := FunClientes.GravaDBrinde(VprCodCliente,VprBrindes);
  if vpfresultado = '' then
  begin
    Fprincipal.BaseDados.Commit(VpfTransacao);
    Close;
  end
  else
  begin
    FPrincipal.BaseDados.Rollback(VpfTransacao);
    Aviso(VpfResultado);
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFBrindesCliente]);
end.
