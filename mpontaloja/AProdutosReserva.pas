unit AProdutosReserva;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  UnDadosProduto, ExtCtrls, PainelGradiente, Grids, CGrades, Componentes1,
  StdCtrls, Buttons, UnClientes, ConstMsg, FunData, Localizacao, UnProdutos,
  Db, DBTables, Mask, DBCtrls, Tabela, DBKeyViolation, FunString,SQlExpr;

type
  TFProdutosReserva = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    BFechar: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BGravarClick(Sender: TObject);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
  private
    VprCodCliente: Integer;
    VprProdutosReserva: TList;
    VprDProdutosReserva: TRBDProdutoReserva;
    VprProdutoAnterior: String;
    procedure CarTitulosGrade;
    procedure CarDProdutoReserva;
    function ExisteProduto: Boolean;
    function LocalizaProduto: Boolean;
  public
    procedure ProdutosReserva(VpaCodCliente: Integer);
  end;

var
  FProdutosReserva: TFProdutosReserva;

implementation
uses
  APrincipal, ALocalizaProdutos, constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProdutosReserva.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProdutosReserva.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFProdutosReserva.ProdutosReserva(VpaCodCliente: Integer);
begin
  VprCodCliente:= VpaCodCliente;
  VprProdutosReserva:= TList.Create;
  Grade.ADados:= VprProdutosReserva;
  FunClientes.CarDProdutoReserva(VpaCodCliente,VprProdutosReserva);
  Grade.CarregaGrade;
  Self.ShowModal;
end;

{******************************************************************************}
procedure TFProdutosReserva.BCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

{******************************************************************************}
procedure TFProdutosReserva.CarTitulosGrade;
begin
  Grade.Cells[1,0]:= 'Código';
  Grade.Cells[2,0]:= 'Produto';
  Grade.Cells[3,0]:= 'Quantidade';
  Grade.Cells[4,0]:= 'Dias Consumo';
  Grade.Cells[5,0]:= 'Última Compra';
  Grade.Cells[6,0]:= 'Prod do Cliente';
end;

{******************************************************************************}
procedure TFProdutosReserva.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProdutosReserva:= TRBDProdutoReserva(VprProdutosReserva.Items[VpaLinha-1]);
  Grade.Cells[1,Grade.ALinha]:= VprDProdutosReserva.CodProduto;
  Grade.Cells[2,Grade.ALinha]:= VprDProdutosReserva.NomProduto;
  if VprDProdutosReserva.QtdProduto = 0 then
    Grade.Cells[3,Grade.ALinha]:= ''
  else
    Grade.Cells[3,Grade.ALinha]:= FormatFloat(varia.MascaraQtd, VprDProdutosReserva.QtdProduto);
  if VprDProdutosReserva.QtdDiasConsumo = 0 then
    Grade.Cells[4,Grade.ALinha]:= ''
  else
    Grade.Cells[4,Grade.ALinha]:= IntToStr(VprDProdutosReserva.QtdDiasConsumo);
  if VprDProdutosReserva.DatUltimaCompra <= MontaData(1,1,1900) then
    Grade.Cells[5,Grade.ALinha]:= ''
  else
    Grade.Cells[5,Grade.ALinha]:= FormatDateTime('DD/MM/YYYY',VprDProdutosReserva.DatUltimaCompra);
  Grade.Cells[6,Grade.ALinha]:= VprDProdutosReserva.IndCliente;
end;

{******************************************************************************}
procedure TFProdutosReserva.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteProduto then
  begin
    Aviso('PRODUTO NÃO CADASTRADO!!!'#13+'Informe um código do produto existente.');
    VpaValidos:= False;
  end
  else
    if (Grade.Cells[3,Grade.ALinha] = '') then
    begin
      aviso('QUANTIDADE DE PRODUTOS INVÁLIDO!!!'#13'É necessário preencher a quantidade de produtos.');
      VpaValidos:= False;
      Grade.Col:= 3;
    end
    else
    if DeletaEspaco(DeletaChars(Grade.Cells[5,Grade.ALinha],'/')) <> '' then
    begin
      try
        StrToDateTime(Grade.Cells[5,Grade.ALinha]);
      except
        Aviso('DATA INVÁLIDA!!!'#13'Digite uma data válida.');
        Grade.Cells[5,Grade.ALinha]:= '';
        VpaValidos:= False;
      end;
    end
    else
      if (Grade.Cells[6,Grade.ALinha] = '') or
         (Length(Grade.Cells[6,Grade.ALinha]) > 1) then
      begin
        aviso('PRODUTO DO CLIENTE INVÁLIDO!!!'#13'É necessário preencher se o produto é ou não do cliente. Use apenas S ou N.');
        VpaValidos:= False;
        Grade.Col:= 6;
      end;

  if VpaValidos then
  begin
    CarDProdutoReserva;
    if VprDProdutosReserva.CodProduto = '0' then
    begin
      Aviso('CÓDIGO DO PRODUTO INVÁLIDO'#13+'O código do produto deve ser diferente de 0.');
      VpaValidos:= False;
      Grade.Col:= 1;
    end
    else
      if VprDProdutosReserva.QtdProduto = 0 then
      begin
        Aviso('QUANTIDADE DO PRODUTO NÃO PREENCHIDO'#13+'É necessário preencher a quantidade do produto.');
        VpaValidos:= False;
        Grade.Col:= 3;
      end;
  end;
end;

{******************************************************************************}
procedure TFProdutosReserva.CarDProdutoReserva;
begin
  VprDProdutosReserva.CodCliente:= VprCodCliente;
  VprDProdutosReserva.CodProduto:= Grade.Cells[1,Grade.ALinha];
  VprDProdutosReserva.NomProduto:= Grade.Cells[2,Grade.ALinha];
  VprDProdutosReserva.QtdProduto:= StrToFloat(DeletaChars(Grade.Cells[3,Grade.ALinha],'.'));

  if Grade.Cells[4,Grade.ALinha] = '' then
    VprDProdutosReserva.QtdDiasConsumo:= 0
  else
    VprDProdutosReserva.QtdDiasConsumo:= StrToInt(Grade.Cells[4,Grade.ALinha]);
  if Grade.Cells[5,Grade.ALinha] = '' then
    VprDProdutosReserva.DatUltimaCompra:= MontaData(1,1,1900)
  else
    VprDProdutosReserva.DatUltimaCompra:= StrToDateTime(Grade.Cells[5,Grade.ALinha]);
  VprDProdutosReserva.IndCliente:= Grade.Cells[6,Grade.ALinha];
end;

{******************************************************************************}
procedure TFProdutosReserva.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    4: Value:= '000000;0; ';
    5: Value:= FPrincipal.CorFoco.AMascaraData;
  end;
end;

{******************************************************************************}
procedure TFProdutosReserva.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    114: case Grade.Col of
           1: LocalizaProduto;
         end;
  end;
end;

{******************************************************************************}
procedure TFProdutosReserva.EProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  if Grade.ALinha > 0 then
  begin
    Grade.Cells[1,Grade.ALinha]:= Retorno1;
    Grade.Cells[2,Grade.ALinha]:= Retorno2;
  end;
end;

{******************************************************************************}
procedure TFProdutosReserva.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprProdutosReserva.Count > 0 then
  begin
    VprDProdutosReserva:= TRBDProdutoReserva(VprProdutosReserva.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior:= VprDProdutosReserva.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFProdutosReserva.GradeNovaLinha(Sender: TObject);
begin
  VprDProdutosReserva:= TRBDProdutoReserva.cria;
  VprProdutosReserva.Add(VprDProdutosReserva);
end;

{******************************************************************************}
procedure TFProdutosReserva.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao, egEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1: if not ExisteProduto then
             if not LocalizaProduto then
             begin
               Grade.Cells[1,Grade.ALinha]:= '';
               Grade.Col:= 1;
             end;
        5: if DeletaEspaco(DeletaChars(Grade.Cells[4,Grade.ALinha],'/')) <> '' then
             try
               StrToDateTime(Grade.Cells[4,Grade.ALinha]);
             except
               Aviso('DATA INVÁLIDA!!!'#13'Digite uma data válida.');
               Grade.Cells[4,Grade.ALinha]:= '';
               Grade.AColuna:= 5;
             end;
      end;
    end;
end;

{******************************************************************************}
function TFProdutosReserva.ExisteProduto: Boolean;
begin
  Result:= False;
  if Grade.Cells[1,Grade.ALinha] <> '' then
    if Grade.Cells[1,Grade.ALinha] = VprProdutoAnterior then
      Result:= True
    else
    begin
      VprDProdutosReserva.CodProduto:= Grade.Cells[1,Grade.ALinha];
      Result:= FunProdutos.ExisteCodigoProduto(VprDProdutosReserva.SeqProduto,VprDProdutosReserva.CodProduto,VprDProdutosReserva.NomProduto);
      if Result then
      begin
        Grade.Cells[1,Grade.ALinha]:= VprDProdutosReserva.CodProduto;
        VprProdutoAnterior:= VprDProdutosReserva.CodProduto;
        Grade.Cells[2,Grade.ALinha]:= VprDProdutosReserva.NomProduto;
      end;
    end;
end;

{******************************************************************************}
procedure TFProdutosReserva.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
  VpfTransacao : TTransactionDesc;
begin
  VpfTransacao.IsolationLevel := xilREADCOMMITTED;
  FPrincipal.BaseDados.StartTransaction(VpfTransacao);
  VpfResultado:= FunClientes.GravaDProdutosReserva(VprCodCliente,VprProdutosReserva);
  if VpfResultado = '' then
  begin
    FPrincipal.BaseDados.Commit(VpfTransacao);
    Self.Close;
  end
  else
  begin
    FPrincipal.BaseDados.Rollback(VpfTransacao);
    Aviso(VpfResultado);
  end;
end;

{******************************************************************************}
function TFProdutosReserva.LocalizaProduto: Boolean;
var
  VpfUM,
  VpfClaFiscal: String;
begin
  FLocalizaProduto:= TFLocalizaProduto.CriarSDI(Application,'',True);
  Result:= FlocalizaProduto.LocalizaProduto(VprDProdutosReserva.SeqProduto,
                                            VprDProdutosReserva.CodProduto,
                                            VprDProdutosReserva.NomProduto,
                                            VpfUM, VpfClaFiscal);
  FLocalizaProduto.Free;
  if Result then
  begin
    VprProdutoAnterior:= VprDProdutosReserva.CodProduto;
    Grade.Cells[1,Grade.ALinha]:= VprDProdutosReserva.CodProduto;
    Grade.Cells[2,Grade.ALinha]:= VprDProdutosReserva.NomProduto;
  end;
end;

procedure TFProdutosReserva.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  if Grade.Col = 6 then
    if not (key in ['s','S','n','N',#8]) then
      Key:= #0
    else
      if Key = 's' Then
        Key:= 'S'
      else
        if Key = 'n' Then
          Key:= 'N';
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFProdutosReserva]);
end.
