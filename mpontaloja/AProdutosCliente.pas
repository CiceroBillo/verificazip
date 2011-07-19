unit AProdutosCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, StdCtrls,
  Buttons, UnDados, UnProdutos, Localizacao, UnClientes, Menus;

type
  TFProdutosCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    ConsultaPadrao1: TConsultaPadrao;
    ECliente: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    EDono: TEditLocaliza;
    PanelColor3: TPanelColor;
    Grade: TRBStringGridColor;
    Splitter1: TSplitter;
    EObservacoes: TMemoColor;
    PopupMenu1: TPopupMenu;
    MProdutoReserva: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure EDonoRetorno(Retorno1, Retorno2: String);
    procedure EDonoCadastrar(Sender: TObject);
    procedure GradeDadosValidosForaGrade(Sender: TObject;
      var VpaValidos: Boolean);
    procedure EObservacoesChange(Sender: TObject);
    procedure EObservacoesExit(Sender: TObject);
    procedure MProdutoReservaClick(Sender: TObject);
    procedure GradeRowMoved(Sender: TObject; FromIndex, ToIndex: Integer);
  private
    { Private declarations }
    VprCodCliente : Integer;
    VprAcao : Boolean;
    VprProdutoAnterior : String;
    VprDItem : TRBDProdutoCliente;
    VprProdutos : TList;
    procedure CarTitulosGrade;
    function ExisteProduto : boolean;
    function ExisteDonoProduto : Boolean;
    function LocalizaProduto : Boolean;
    procedure CarDItemProduto;
  public
    { Public declarations }
    function CadastraProdutos(VpaCodCliente : Integer):boolean;
  end;

var
  FProdutosCliente: TFProdutosCliente;

implementation

uses APrincipal, FunObjeto, Constantes, ALocalizaProdutos, FunString, ConstMsg, FunData,
  ADonoProduto, AProdutosClientePeca;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProdutosCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  VprProdutos := TList.Create;
  Grade.ADados := VprProdutos;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProdutosCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprProdutos);
  VprProdutos.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFProdutosCliente.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Produto';
  Grade.Cells[3,0] := 'UM';
  Grade.Cells[4,0] := 'Quantidade';
  Grade.Cells[5,0] := 'Garantia';
  Grade.Cells[6,0] := 'Qtd Cópias';
  Grade.Cells[7,0] := 'Código';
  Grade.Cells[8,0] := 'Proprietário';
  Grade.Cells[9,0] := 'Val Concorrente';
  Grade.Cells[10,0] := 'Numero Série Produto';
  Grade.Cells[11,0] := 'Numero Série Interno';
  Grade.Cells[12,0] := 'Setor';
  Grade.Cells[13,0] := 'Código';
  Grade.Cells[14,0] := 'Suprimento';
end;

{******************************************************************************}
function TFProdutosCliente.ExisteProduto : Boolean;
begin
  if (Grade.Cells[1,Grade.ALinha] <> '') then
  begin
    if Grade.Cells[1,Grade.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      VprDItem.CodProduto := Grade.Cells[1,Grade.ALinha];
      result := FunProdutos.ExisteProduto(VprDItem.CodProduto,VprDItem.SeqProduto,VprDItem.NomProduto,VprDItem.UM);
      if result then
      begin
        VprDItem.UnidadeParentes.free;
        VprDItem.UnidadeParentes := FunProdutos.RUnidadesParentes(VprDItem.UM);
        Grade.Cells[1,Grade.ALinha] := VprDItem.CodProduto;
        VprProdutoAnterior := VprDItem.CodProduto;
        Grade.Cells[2,Grade.ALinha] := VprDItem.NomProduto;
        VprDItem.UMOriginal := VprDItem.UM;
        Grade.Cells[3,Grade.ALinha] := VprDItem.UM;
        VprDItem.QtdProduto := 1;
        Grade.Cells[4,Grade.ALinha] := FormatFloat(varia.MascaraQTd,VprDItem.Qtdproduto);
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFProdutosCliente.ExisteDonoProduto : Boolean;
begin
  result := true;
  if (Grade.Cells[7,Grade.Alinha]<> '') then
  begin
    result := FunProdutos.ExisteDonoProduto(StrtoInt(Grade.Cells[7,Grade.ALinha]));
    if result then
    begin
      EDono.text := Grade.Cells[7,Grade.ALinha];
      EDono.Atualiza;
    end;
  end;
end;

{******************************************************************************}
function TFProdutosCliente.LocalizaProduto : Boolean;
var
  VpfClaFiscal : String;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDItem.SeqProduto,VprDItem.CodProduto,VprDItem.NomProduto,VprDItem.UM,VpfClaFiscal);
  FlocalizaProduto.free;
  if result then  // se o usuario nao cancelou a consulta
  begin
    VprDItem.UnidadeParentes.free;
    VprDItem.UnidadeParentes := FunProdutos.RUnidadesParentes(VprDItem.UM);
    VprProdutoAnterior := VprDItem.CodProduto;
    Grade.Cells[1,Grade.ALinha] := VprDItem.CodProduto;
    Grade.Cells[2,Grade.ALinha] := VprDItem.NomProduto;
    Grade.Cells[3,Grade.ALinha] := VprDItem.UM;
    VprDItem.QtdProduto := 1;
    Grade.Cells[4,Grade.ALinha] := FormatFloat(varia.MascaraQTd,VprDItem.Qtdproduto);
  end;
end;

procedure TFProdutosCliente.MProdutoReservaClick(Sender: TObject);
begin
   FProdutosClientePeca := TFProdutosClientePeca.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCelulaTrabalho'));
   FProdutosClientePeca.AtualizaConsulta(VprDItem);
   FProdutosClientePeca.Showmodal;
   FProdutosClientePeca.free;
end;

{******************************************************************************}
procedure TFProdutosCliente.CarDItemProduto;
begin
  VprDItem.CodProduto := Grade.Cells[1,Grade.Alinha];
  VprDItem.UM := Grade.Cells[3,Grade.Alinha];
  VprDItem.QtdProduto := StrToFloat(DeletaChars(Grade.Cells[4,Grade.ALinha],'.'));
  if Grade.Cells[5,Grade.ALinha] <> '' then
    VprDItem.DatGarantia := StrToDate(Grade.Cells[5,Grade.ALinha])
  else
    VprDItem.DatGarantia := MontaData(1,1,1900);
  if Grade.Cells[6,Grade.ALinha] <> '' then
    VprDItem.QtdCopias := strtoInt(Grade.Cells[6,Grade.ALinha])
  else
    VprDItem.QtdCopias := 0;
  if Grade.Cells[7,Grade.ALinha] <> '' then
    VprDItem.CodDono := strtoInt(Grade.Cells[7,Grade.ALinha])
  else
    VprDItem.CodDono := 0;
  if Grade.Cells[9,grade.ALinha] <> '' then
    VprDItem.ValConcorrente := StrToFloat(Grade.Cells[9,Grade.ALinha])
  else
    VprDItem.ValConcorrente := 0;
  VprDItem.NumSerieProduto := Grade.Cells[10,Grade.ALinha];
  VprDItem.NumSerieInterno := Grade.Cells[11,Grade.ALinha];
  VprDItem.DesSetorEmpresa := Grade.Cells[12,Grade.ALinha];
  VprDItem.DatUltimaAlteracao := now;
end;

{******************************************************************************}
function TFProdutosCliente.CadastraProdutos(VpaCodCliente : Integer):boolean;
begin
  VprCodCliente := VpaCodCliente;
  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  FunClientes.CarDProdutoCliente(VpaCodCliente,VprProdutos);
  Grade.CarregaGrade;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFProdutosCliente.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFProdutosCliente.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFProdutosCliente.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunClientes.GravaDProdutoCliente(VprCodCliente,VprProdutos);
  if VpfResultado = '' then
  begin
    VprAcao := true;
    close;
  end
  else
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFProdutosCliente.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItem := TRBDProdutoCliente(VprProdutos.Items[vpaLinha-1]);
  Grade.Cells[1,VpaLinha] := VprDItem.CodProduto;
  Grade.Cells[2,VpaLinha] := VprDItem.NomProduto;
  Grade.Cells[3,VpaLinha] := VprDItem.UM;
  if VprDItem.QtdProduto > 0 then
    Grade.Cells[4,VpaLinha] := FormatFloat(Varia.MascaraQtd,VprDItem.QtdProduto)
  else
    Grade.Cells[4,VpaLinha] := '';
  if VprDItem.DatGarantia > MontaData(1,1,1900) then
    Grade.Cells[5,VpaLinha] := FormatDatetime('DD/MM/YYYY', VprDItem.DatGarantia)
  else
    Grade.Cells[5,VpaLinha] := '';
  if VprDItem.QtdCopias <> 0 then
    Grade.Cells[6,VpaLinha] := inttoStr(VprDItem.QtdCopias)
  else
    Grade.Cells[6,VpaLinha] := '';
  if VprDItem.CodDono <> 0 then
    Grade.Cells[7,VpaLinha] := inttoStr(VprDItem.CodDono)
  else
    Grade.Cells[7,VpaLinha] := '';
  Grade.Cells[8,VpaLinha] := VprDItem.NomDono;
  if VprDItem.ValConcorrente > 0 then
    Grade.Cells[9,VpaLinha] := FormatFloat(Varia.MascaraValorUnitario,VprDItem.ValConcorrente)
  else
    Grade.Cells[9,VpaLinha] := '';
  Grade.Cells[10,VpaLinha] := VprDItem.NumSerieProduto;
  Grade.Cells[11,VpaLinha] := VprDItem.NumSerieInterno;
  Grade.Cells[12,VpaLinha] := VprDItem.DesSetorEmpresa;
  EObservacoes.Lines.Text := VprDItem.DesObservacoes;
end;

{******************************************************************************}
procedure TFProdutosCliente.GradeDadosValidos(Sender: TObject;
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
    end
    else
      if (VprDItem.UnidadeParentes.IndexOf(Grade.Cells[3,Grade.Alinha]) < 0) then
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
        end
        else
          if not ExisteDonoProduto then
          begin
            VpaValidos := false;
            aviso(CT_DONOPRODUTONAOCADATRADO);
            Grade.Col := 7;
          end;
  if Vpavalidos then
  begin
    CarDItemProduto;
    if (VprDItem.QtdProduto = 0)  then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      Grade.col :=4;
    end
  end;
end;

{******************************************************************************}
procedure TFProdutosCliente.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case Grade.AColuna of
        1: LocalizaProduto;
        7: EDono.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFProdutosCliente.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprProdutos.Count >0 then
  begin
    VprDItem := TRBDProdutoCliente(VprProdutos.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDItem.CodProduto;
    EObservacoes.Lines.Text := VprDItem.DesObservacoes;
  end;
end;

{******************************************************************************}
procedure TFProdutosCliente.GradeNovaLinha(Sender: TObject);
begin
  VprDItem := TRBDProdutoCliente.cria;
  VprDItem.CodCliente:= VprCodCliente;
  VprProdutos.add(VprDItem);
end;

procedure TFProdutosCliente.GradeRowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
begin

end;

{******************************************************************************}
procedure TFProdutosCliente.GradeSelectCell(Sender: TObject; ACol,
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
        7 : if not ExisteDonoProduto then
            begin
              if not EDono.AAbreLocalizacao then
              begin
                Grade.Cells[7,Grade.ALinha] := '';
                abort;
              end;
            end;
      end;
    end;
end;

{******************************************************************************}
procedure TFProdutosCliente.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    5 : Value := DeletaChars(Fprincipal.CorFoco.AMascaraData,'\');
    7 :  Value := '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFProdutosCliente.EDonoRetorno(Retorno1, Retorno2: String);
begin
  VprDItem.CodDono := EDono.AInteiro;
  VprDItem.NomDono := retorno1;
  Grade.cells[7,Grade.ALinha] := EDono.text;
  Grade.Cells[8,grade.Alinha] := VprDItem.Nomdono;
end;

procedure TFProdutosCliente.EDonoCadastrar(Sender: TObject);
begin
  FDonoProduto := TFDonoProduto.CriarSDI(self,'',FPrincipal.VerificaPermisao('FDonoProduto'));
  FDonoProduto.BotaoCadastrar1.Click;
  FDonoProduto.ShowModal;
  ConsultaPadrao1.AtualizaConsulta;
  FDonoProduto.free;
end;

{******************************************************************************}
procedure TFProdutosCliente.GradeDadosValidosForaGrade(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
end;

{******************************************************************************}
procedure TFProdutosCliente.EObservacoesChange(Sender: TObject);
begin
  Grade.AEstadoGrade := egEdicao;
end;

procedure TFProdutosCliente.EObservacoesExit(Sender: TObject);
begin
  VprDItem.DesObservacoes := EObservacoes.Lines.text;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFProdutosCliente]);
end.
