unit AProdutosProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  UnDados, Localizacao, ExtCtrls, PainelGradiente, StdCtrls, Componentes1, DbTables, FunSql,
  Buttons, Grids, CGrades, FunObjeto, FunData, Constantes, ConstMsg, UnProdutos, FunString;

type
  TFProdutosProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Localiza: TConsultaPadrao;
    PanelColor1: TPanelColor;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    EProspect: TEditLocaliza;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    EDono: TEditLocaliza;
    PanelColor3: TPanelColor;
    Grade: TRBStringGridColor;
    Splitter1: TSplitter;
    EObservacoes: TMemoColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure EDonoRetorno(Retorno1, Retorno2: String);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EObservacoesExit(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EDonoCadastrar(Sender: TObject);
  private
    VprCodProspect: Integer;
    VprAcao: Boolean;
    VprProdutoAnterior: String;
    VprDItem: TRBDProdutoProspect;
    VprProdutos: TList;
    procedure CarTitulosGrade;
    function ExisteProduto: Boolean;
    function ExisteDonoProduto: Boolean;
    procedure CarDClasse;
    function LocalizaProduto: Boolean;
  public
    function CadastraProdutos(VpaCodProspect: Integer): Boolean;
  end;

var
  FProdutosProspect: TFProdutosProspect;

implementation
uses
  APrincipal, ALocalizaProdutos, ADonoProduto, UnProspect;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProdutosProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  VprProdutos:= TList.Create;
  Grade.ADados:= VprProdutos;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProdutosProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprProdutos);
  VprProdutos.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFProdutosProspect.CarTitulosGrade;
begin
  Grade.Cells[1,0]:= 'Código';
  Grade.Cells[2,0]:= 'Produto';
  Grade.Cells[3,0]:= 'UM';
  Grade.Cells[4,0]:= 'Quantidade';
  Grade.Cells[5,0]:= 'Garantia';
  Grade.Cells[6,0]:= 'Qtd Cópias';
  Grade.Cells[7,0]:= 'Código';
  Grade.Cells[8,0]:= 'Proprietário';
  Grade.Cells[9,0]:= 'Val Concorrente';
  Grade.Cells[10,0]:= 'N° Série';
  Grade.Cells[11,0]:= 'N° Série Interno';
  Grade.Cells[12,0]:= 'Setor';
end;

{******************************************************************************}
procedure TFProdutosProspect.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFProdutosProspect.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItem := TRBDProdutoProspect(VprProdutos.Items[VpaLinha-1]);
  Grade.Cells[1,VpaLinha]:= VprDItem.CodProduto;
  Grade.Cells[2,VpaLinha]:= VprDItem.NomProduto;
  Grade.Cells[12,VpaLinha]:= VprDItem.DesSetor;
  Grade.Cells[10,VpaLinha]:= VprDItem.NumSerie;
  Grade.Cells[11,VpaLinha]:= VprDItem.NumSerieInterno;
  if VprDItem.QtdProduto = 0 then
    Grade.Cells[4,VpaLinha]:= ''
  else
    Grade.Cells[4,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDItem.QtdProduto);
  Grade.Cells[3,VpaLinha]:= VprDItem.DesUM;
  if VprDItem.CodDono = 0 then
    Grade.Cells[7,VpaLinha]:= ''
  else
    Grade.Cells[7,VpaLinha]:= IntToStr(VprDItem.CodDono);
  Grade.Cells[8,VpaLinha]:= VprDItem.NomDono;
  if VprDItem.DatGarantia > MontaData(1,1,1900) then
    Grade.Cells[5,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDItem.DatGarantia)
  else
    Grade.Cells[5,VpaLinha]:= '';
  if VprDItem.ValConcorrente = 0 then
    Grade.Cells[9,VpaLinha]:= ''
  else
    Grade.Cells[9,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDItem.ValConcorrente);
  if VprDItem.QtdCopias = 0 then
    Grade.Cells[6,VpaLinha]:= ''
  else
    Grade.Cells[6,VpaLinha]:= IntToStr(VprDItem.QtdCopias);
end;

{******************************************************************************}
procedure TFProdutosProspect.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if Grade.Cells[1,Grade.ALinha] = '' then
  begin
    Aviso('O CODIGO DO PRODUTO NÃO FOI PREENCHIDO!!!'#13'É necessário informar o código do produto.');
    VpaValidos:= False;
    Grade.Col:= 1;
  end
  else
    if not ExisteProduto then
    begin
      Aviso('O PRODUTO NÃO ESTÁ CADASTRADO!!!'#13'Informe um código do produto válido.');
      VpaValidos:= False;
      Grade.Col:= 1;
    end
    else
      if Grade.Cells[4,Grade.ALinha] = '' then
      begin
        Aviso('A QUANTIDADE DO PRODUTO NÃO FOI PREENCHIDA!!!'#13'É necessário informar a quantidade do produto.');
        VpaValidos:= False;
        Grade.Col:= 4;
      end
      else
        if (VprDItem.UnidadeParentes.IndexOf(Grade.Cells[3,Grade.Alinha]) < 0) then
        begin
          Aviso(CT_UNIDADEVAZIA);
          VpaValidos:= False;
          Grade.Col:= 3;
        end
        else
          if not ExisteDonoProduto then
          begin
            Aviso('O PROPRIETÁRIO DO PRODUTO NÃO ESTÁ CADASTRADO!!!'#13'Informe um código do proprietário válido.');
            VpaValidos:= False;
            Grade.Col:= 7;
          end
          else
            try
              if Grade.Cells[5,Grade.ALinha] <> '' then
                StrToDate(Grade.Cells[5,Grade.ALinha]);
            except
              Aviso('DATA INVALIDA!!!'#13'Informe uma data corretamente.');
              VpaValidos:= False;
              Grade.Col:= 5;
            end;
  if VpaValidos then
    CarDClasse;
end;

{******************************************************************************}
function TFProdutosProspect.ExisteProduto: Boolean;
begin
  Result:= False;
  if (Grade.Cells[1,Grade.ALinha] <> '') then
  begin
    if Grade.Cells[1,Grade.ALinha] = VprProdutoAnterior then
      Result:= True
    else
    begin
      VprDItem.CodProduto:= Grade.Cells[1,Grade.ALinha];
      Result:= FunProdutos.ExisteProduto(VprDItem.CodProduto,VprDItem.SeqProduto,VprDItem.NomProduto,VprDItem.DesUM);
      if Result then
      begin
        VprDItem.UnidadeParentes.Free;
        VprDItem.UnidadeParentes:= FunProdutos.RUnidadesParentes(VprDItem.DesUM);
        Grade.Cells[1,Grade.ALinha]:= VprDItem.CodProduto;
        VprProdutoAnterior:= VprDItem.CodProduto;
        Grade.Cells[2,Grade.ALinha]:= VprDItem.NomProduto;
        VprDItem.QtdProduto:= 1;
        Grade.Cells[3,Grade.ALinha]:= VprDItem.DesUM;
        Grade.Cells[4,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDItem.QtdProduto);
      end;
    end;
  end
end;

{******************************************************************************}
function TFProdutosProspect.ExisteDonoProduto: Boolean;
begin
  Result:= True;
  if Grade.Cells[7,Grade.ALinha] <> '' then
  begin
    Result:= FunProdutos.ExisteDonoProduto(StrtoInt(Grade.Cells[7,Grade.ALinha]));
    if Result then
    begin
      EDono.Text:= Grade.Cells[7,Grade.ALinha];
      EDono.Atualiza;
    end;
  end;
end;

{******************************************************************************}
procedure TFProdutosProspect.CarDClasse;
begin
  VprDItem.CodProspect:= StrToInt(EProspect.Text);
  VprDItem.CodProduto:= Grade.Cells[1,Grade.ALinha];
  VprDItem.NomProduto:= Grade.Cells[2,Grade.ALinha];
  VprDItem.DesSetor:= Grade.Cells[12,Grade.ALinha];
  VprDItem.NumSerie:= Grade.Cells[10,Grade.ALinha];
  VprDItem.NumSerieInterno:= Grade.Cells[11,Grade.ALinha];
  if Grade.Cells[4,Grade.ALinha] = '' then
    VprDItem.QtdProduto:= 0
  else
    VprDItem.QtdProduto:= StrToFloat(DeletaChars(Grade.Cells[4,Grade.ALinha],'.'));
  VprDItem.DesUM:= Grade.Cells[3,Grade.ALinha];
  if Grade.Cells[7,Grade.ALinha] = '' then
    VprDItem.CodDono:= 0
  else
    VprDItem.CodDono:= StrToInt(Grade.Cells[7,Grade.ALinha]);
  VprDItem.NomDono:= Grade.Cells[8,Grade.ALinha];
  if Grade.Cells[5,Grade.ALinha] = '' then
    VprDItem.DatGarantia:= MontaData(1,1,1900)
  else
    VprDItem.DatGarantia:= StrToDate(Grade.Cells[5,Grade.ALinha]);
  if Grade.Cells[9,Grade.ALinha] = '' then
    VprDItem.ValConcorrente:= 0
  else
    VprDItem.ValConcorrente:= StrToFloat(DeletaChars(Grade.Cells[9,Grade.ALinha],'.'));
  VprDItem.DatUltimaAlteracao:= Now;
  if Grade.Cells[6,Grade.ALinha] = '' then
    VprDItem.QtdCopias:= 0
  else
    VprDItem.QtdCopias:= StrToInt(Grade.Cells[6,Grade.ALinha]);
  VprDItem.DesObservacao:= EObservacoes.Text;
end;

{******************************************************************************}
procedure TFProdutosProspect.EDonoRetorno(Retorno1, Retorno2: String);
begin
  if Grade.ALinha > 0 then
  begin
    Grade.Cells[7,Grade.ALinha]:= Retorno1;
    Grade.Cells[8,Grade.ALinha]:= Retorno2;
  end;
end;

{******************************************************************************}
procedure TFProdutosProspect.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1, 6, 7: Value:= '000000;0; ';
    5: Value:= FPrincipal.CorFoco.AMascaraData;
  end;
end;

{******************************************************************************}
procedure TFProdutosProspect.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    114: case Grade.AColuna of
           1: LocalizaProduto;
           7: EDono.AAbreLocalizacao;
         end;
  end;
end;

{******************************************************************************}
procedure TFProdutosProspect.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '.': case Grade.AColuna of
           4, 9: Key:= DecimalSeparator;
         end;
  end;
end;

{******************************************************************************}
function TFProdutosProspect.LocalizaProduto: Boolean;
var
  VpfClaFiscal: String;
begin
  FLocalizaProduto:= TFLocalizaProduto.CriarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VprDItem.SeqProduto,VprDItem.CodProduto,VprDItem.NomProduto,VprDItem.DesUM,VpfClaFiscal);
  FLocalizaProduto.Free;
  if Result then
  begin
    VprDItem.UnidadeParentes.Free;
    VprDItem.UnidadeParentes:= FunProdutos.RUnidadesParentes(VprDItem.DesUM);
    Grade.Cells[1,Grade.ALinha]:= VprDItem.CodProduto;
    VprProdutoAnterior:= VprDItem.CodProduto;
    Grade.Cells[2,Grade.ALinha]:= VprDItem.NomProduto;
    Grade.Cells[12,Grade.ALinha]:= VprDItem.DesSetor;
    Grade.Cells[10,Grade.ALinha]:= VprDItem.NumSerie;
    Grade.Cells[11,Grade.ALinha]:= VprDItem.NumSerieInterno;
    VprDItem.QtdProduto:= 1;
    Grade.Cells[4,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDItem.QtdProduto);
    Grade.Cells[3,Grade.ALinha]:= VprDItem.DesUM;
  end;
end;

{******************************************************************************}
procedure TFProdutosProspect.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprProdutos.Count > 0 then
  begin
    VprDItem:= TRBDProdutoProspect(VprProdutos.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior:= VprDItem.CodProduto;
    EObservacoes.Lines.Text:= VprDItem.DesObservacao;
  end;
end;

{******************************************************************************}
procedure TFProdutosProspect.GradeNovaLinha(Sender: TObject);
begin
  VprDItem:= TRBDProdutoProspect.Cria;
  VprProdutos.Add(VprDItem);
end;

{******************************************************************************}
procedure TFProdutosProspect.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,egEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1: if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               Grade.Cells[1,Grade.ALinha]:= '';
               Abort;
             end;
           end;
        7: if not ExisteDonoProduto then
           begin
             if not EDono.AAbreLocalizacao then
             begin
               Grade.Cells[7,Grade.ALinha]:= '';
               Abort;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFProdutosProspect.EObservacoesExit(Sender: TObject);
begin
  VprDItem.DesObservacao:= EObservacoes.Lines.Text;
end;

{******************************************************************************}
function TFProdutosProspect.CadastraProdutos(VpaCodProspect: Integer): Boolean;
begin
  VprCodProspect:= VpaCodProspect;
  EProspect.AInteiro:= VpaCodProspect;
  EProspect.Atualiza;
  FunProspect.CarDProdutoProspect(VprCodProspect,VprProdutos);
  Grade.CarregaGrade;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFProdutosProspect.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= FunProspect.GravaDProdutoProspect(VprCodProspect,VprProdutos);
  if VpfResultado = '' then
  begin
    VprAcao:= True;
    Close;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFProdutosProspect.EDonoCadastrar(Sender: TObject);
begin
  FDonoProduto:= TFDonoProduto.CriarSDI(Application,'',True);
  FDonoProduto.BotaoCadastrar1.Click;
  FDonoProduto.ShowModal;
  Localiza.AtualizaConsulta;
  FDonoProduto.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFProdutosProspect]);
end.
