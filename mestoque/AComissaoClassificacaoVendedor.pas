unit AComissaoClassificacaoVendedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, Componentes1, PainelGradiente, StdCtrls, Buttons, Grids,
  CGrades, UnVendedor, UnDados, Localizacao, UnClassificacao;

type
  TFComissaoClassificacaoVendedor = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Grade: TRBStringGridColor;
    EVendedor: TEditLocaliza;
    Localiza: TConsultaPadrao;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    EClassificacao: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EVendedorRetorno(Retorno1, Retorno2: String);
    procedure BGravarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
  private
    VprCodEmpresa: Integer;
    VprCodClassificacao,
    VprTipClassificacao: String;
    VprAcao: Boolean;
    VprDComissaoClassificacaoVendedor: TRBDComissaoClassificacaoVendedor;
    VprComissoes: TList;
    FunVendedor: TRBFuncoesVendedor;
    FunClassificacao: TFuncoesClassificacao;
    function AddComissao: TRBDComissaoClassificacaoVendedor;
    procedure CarTitulosGrade;
    function ExisteVendedor: Boolean;
    procedure CarDClasse;
  public
    function CadastraComissaoClassificacaoVendedor(VpaCodEmpresa: Integer; VpaCodClassificacao, VpaTipClassificacao: String): Boolean;
  end;

var
  FComissaoClassificacaoVendedor: TFComissaoClassificacaoVendedor;

implementation
uses
  Constantes, FunObjeto, ConstMSG, FunString, APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFComissaoClassificacaoVendedor.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  VprComissoes:= TList.Create;
  FunVendedor:= TRBFuncoesVendedor.cria(FPrincipal.BaseDados);
  FunClassificacao:= TFuncoesClassificacao.criar(Self,FPrincipal.BaseDados);
  Grade.ADados:= VprComissoes;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFComissaoClassificacaoVendedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunVendedor.Free;
  FunClassificacao.Free;
  FreeTObjectsList(VprComissoes);
  VprComissoes.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
function TFComissaoClassificacaoVendedor.AddComissao: TRBDComissaoClassificacaoVendedor;
begin
  Result:= TRBDComissaoClassificacaoVendedor.Cria;
  VprComissoes.Add(Result);
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.CarTitulosGrade;
begin
  Grade.Cells[1,0]:= 'Código';
  Grade.Cells[2,0]:= 'Vendedor';
  Grade.Cells[3,0]:= 'Comissão';
end;

{******************************************************************************}
function TFComissaoClassificacaoVendedor.ExisteVendedor: Boolean;
begin
  Result:= False;
  if Grade.Cells[1,Grade.ALinha] <> '' then
  begin
    VprDComissaoClassificacaoVendedor.CodVendedor:= StrToInt(Grade.Cells[1,Grade.ALinha]);
    VprDComissaoClassificacaoVendedor.NomVendedor:= '';
    VprDComissaoClassificacaoVendedor.NomVendedor:= FunVendedor.RNomVendedor(Grade.Cells[1,Grade.ALinha]);
    Result:= (VprDComissaoClassificacaoVendedor.NomVendedor <> '');
    if Result then
    begin
      Grade.Cells[2,Grade.ALinha]:= VprDComissaoClassificacaoVendedor.NomVendedor;
    end;
  end;
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.EVendedorRetorno(Retorno1,
  Retorno2: String);
begin
  if Grade.ALinha > 0 then
    if Retorno1 <> '' then
    begin
      Grade.Cells[1,Grade.ALinha]:= Retorno1; 
      VprDComissaoClassificacaoVendedor.NomVendedor:= Retorno2;
      Grade.Cells[2,Grade.ALinha]:= VprDComissaoClassificacaoVendedor.NomVendedor;
      VprDComissaoClassificacaoVendedor.PerComissao:= 0;
      Grade.Cells[3,Grade.ALinha]:= '';
    end;
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.CarDClasse;
begin
  VprDComissaoClassificacaoVendedor.CodEmpresa:= VprCodEmpresa;
  VprDComissaoClassificacaoVendedor.CodClassificacao:= VprCodClassificacao;
  VprDComissaoClassificacaoVendedor.TipClassificacao:= VprTipClassificacao;
  if Grade.Cells[1,Grade.ALinha] <> '' then
    VprDComissaoClassificacaoVendedor.CodVendedor:= StrToInt(Grade.Cells[1,Grade.ALinha])
  else
    VprDComissaoClassificacaoVendedor.CodVendedor:= 0;
  if Grade.Cells[3,Grade.ALinha] <> '' then
    VprDComissaoClassificacaoVendedor.PerComissao:= StrToFloat(DeletaEspaco(DeletaChars(DeletaChars(Grade.Cells[3,Grade.ALinha],'%'),'.')))
  else
    VprDComissaoClassificacaoVendedor.PerComissao:= 0;   
end;

{******************************************************************************}
function TFComissaoClassificacaoVendedor.CadastraComissaoClassificacaoVendedor(VpaCodEmpresa: Integer; VpaCodClassificacao, VpaTipClassificacao: String): Boolean;
begin
  VprCodEmpresa:= VpaCodEmpresa;
  VprCodClassificacao:= VpaCodClassificacao;
  VprTipClassificacao:= VpaTipClassificacao;
  EClassificacao.Text:= VprCodClassificacao;
  EClassificacao.Atualiza;
  FunClassificacao.CarDComissaoClassificacaoVendedor(VpaCodEmpresa, VpaCodClassificacao, VpaTipClassificacao, VprComissoes);
  Grade.CarregaGrade;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= FunClassificacao.GravaDComissaoClassificacaoVendedor(VprCodEmpresa,VprCodClassificacao,VprTipClassificacao,VprComissoes);
  if VpfResultado = '' then
  begin
    VprAcao:= True;
    Close;
  end
  else
    Aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.GradeCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDComissaoClassificacaoVendedor:= TRBDComissaoClassificacaoVendedor(VprComissoes.Items[VpaLinha-1]);
  if VprDComissaoClassificacaoVendedor.CodVendedor <> 0 then
    Grade.Cells[1,VpaLinha]:= IntToStr(VprDComissaoClassificacaoVendedor.CodVendedor)
  else
    Grade.Cells[1,VpaLinha]:= '';
  Grade.Cells[2,VpaLinha]:= VprDComissaoClassificacaoVendedor.NomVendedor;
  if VprDComissaoClassificacaoVendedor.PerComissao <> 0 then
    Grade.Cells[3,VpaLinha]:= FormatFloat('##0.00 %',VprDComissaoClassificacaoVendedor.PerComissao)
  else
    Grade.Cells[3,VpaLinha]:= '';
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.GradeDadosValidos(
  Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteVendedor then
  begin
    Grade.Col:= 1;
    VpaValidos:= False;
    aviso('VENDEDOR NÃO CADASTRADO!!!'#13+'É necessário informar um vendedor que esteja cadastrado.');
  end
  else
    if Grade.Cells[3,Grade.ALinha] = '' then
    begin
      Grade.Col:= 3;
      VpaValidos:= False;
      aviso('COMISSÃO NÃO PREENCHIDA!!!'#13+'É necessário preencher a comissão.')
    end;

  if VpaValidos then
  begin
    CarDClasse;
    if VprDComissaoClassificacaoVendedor.CodVendedor = 0 then
    begin
      Grade.Col:= 1;
      VpaValidos:= False;
      aviso('VENDEDOR NÃO CADASTRADO!!!'#13+'É necessário informar um vendedor que esteja cadastrado.');
    end
    else
      if VprDComissaoClassificacaoVendedor.PerComissao = 0 then
      begin
        Grade.Col:= 3;
        VpaValidos:= False;
        aviso('COMISSÃO NÃO PREENCHIDA!!!'#13+'É necessário prencher a comissão com um valor diferente de 0.')
      end
      else
        if FunClassificacao.VendedorDuplicado(VprComissoes) then
        begin
          Grade.Col:= 1;
          VpaValidos:= False;
          aviso('VENDEDOR DUPLICADO!!!'#13+'Não é possível preencher o mesmo vendedor duas vezes.');
        end;
  end;
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.GradeGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  case ACol of
    1: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.GradeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    114: case Grade.AColuna of
           1: EVendedor.AAbreLocalizacao;
         end;
  end;
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprComissoes.Count > 0 then
    VprDComissaoClassificacaoVendedor:= TRBDComissaoClassificacaoVendedor(VprComissoes.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.GradeNovaLinha(Sender: TObject);
begin
  VprDComissaoClassificacaoVendedor:= AddComissao;
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.GradeSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1: if not ExisteVendedor then
             if not EVendedor.AAbreLocalizacao then
             begin
               Grade.Cells[1,Grade.ALinha]:= '';
               Grade.Cells[2,Grade.ALinha]:= '';
               Grade.Cells[3,Grade.ALinha]:= '';
               Abort;
             end;
      end;
    end;
end;

{******************************************************************************}
procedure TFComissaoClassificacaoVendedor.GradeKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Grade.AColuna of
    3: if Key in ['.',','] then
         Key:= DecimalSeparator;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFComissaoClassificacaoVendedor]);
end.
