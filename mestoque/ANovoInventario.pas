unit ANovoInventario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Grids,
  CGrades, UnDadosProduto, ConvUnidade, UnInventario, Localizacao, Db,
  Constantes, DBTables, UnDadosLocaliza,sqlexpr, DBClient, Tabela;

type
  TFNovoInventario = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    Grade: TRBStringGridColor;
    ValidaUnidade: TValidaUnidade;
    Aux: TSQL;
    Localiza: TConsultaPadrao;
    ECor: TEditLocaliza;
    ETamanho: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BCancelarClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorCadastrar(Sender: TObject);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure ETamanhoCadastrar(Sender: TObject);
    procedure ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
  private
    { Private declarations }
    VprDInventario : TRBDInventarioCorpo;
    VprDItemInventario : TRBDInventarioItem;
    VprProdutoAnterior,
    VprCorAnterior : String;
    VprOperacao : TRBDOperacaoCadastro;
    VprAcao : Boolean;
    FunInventario : TRBFuncoesInventario;
    procedure CarTituloGrade;
    function LocalizaProduto : Boolean;
    function ExisteProduto : Boolean;
    function ExisteCor(VpaCodCor :Integer ) : Boolean;
    function ExisteUM : Boolean;
    procedure CarDItem;
  public
    { Public declarations }
    function AdicionaProdutos(VpaDInventario : TRBDInventarioCorpo) :Boolean;
    function AlteraProdutos(VpaDInventario : TRBDInventarioCorpo) : Boolean;
  end;

var
  FNovoInventario: TFNovoInventario;

implementation

uses APrincipal, ALocalizaProdutos, FunSql, ConstMsg, FunString, ACores, FunNumeros,
  ATamanhos;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoInventario.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTituloGrade;
  ValidaUnidade.AInfo.UnidadeCX := varia.UnidadeCX;
  ValidaUnidade.AInfo.UnidadeUN := varia.UnidadeUN;
  ValidaUnidade.AInfo.UnidadeKit := varia.UnidadeKit;
  ValidaUnidade.AInfo.UnidadeBarra := varia.UnidadeBarra;
  FunInventario := TRBFuncoesInventario.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoInventario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunInventario.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoInventario.CarTituloGrade;
begin
  Grade.Cells[1,0]:='Produto';
  Grade.Cells[2,0]:='Descrição';
  Grade.Cells[3,0]:='Cor';
  Grade.Cells[4,0]:='Descrição';
  Grade.Cells[5,0]:='Tamanho';
  Grade.Cells[6,0]:='Descrição';
  Grade.Cells[7,0]:='Quantidade';
  Grade.Cells[8,0]:='UM';
  Grade.Cells[9,0]:='Usuário';

  if not Config.EstoquePorCor then
  begin
    Grade.ColWidths[2] := RetornaInteiro(Grade.ColWidths[2]*1.5);
    Grade.ColWidths[3] := -1;
    Grade.ColWidths[4] := -1;
    Grade.TabStops[3] := false;
    Grade.TabStops[4] := false;
  end;
  if not config.EstoquePorTamanho then
  begin
    Grade.ColWidths[5] := -1;
    Grade.ColWidths[6] := -1;
    Grade.TabStops[5] := false;
    Grade.TabStops[6] := false;
  end;

end;

{***************************localiza codigo de produto*************************}
function TFNovoInventario.LocalizaProduto : Boolean;
var
  VpfCodClassificacao : String;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDItemInventario.SeqProduto,VprDItemInventario.CodProduto,VprDItemInventario.NomProduto,VprDItemInventario.UMOriginal,
                                             VpfCodClassificacao); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    with VprDItemInventario do
    begin
      UM := UMOriginal;
      UnidadesParentes.free;
      UnidadesParentes := ValidaUnidade.UnidadesParentes(UMOriginal);
      VprProdutoAnterior := CodProduto;
      QtdProduto := 1;
      Grade.Cells[1,Grade.ALinha] := CodProduto;
      Grade.Cells[2,Grade.ALinha] := NomProduto;
      Grade.Cells[8,Grade.ALinha] := UM;
    end;
  end;
end;

{******************** verifica se o produto existe ****************************}
function TFNovoInventario.ExisteProduto : Boolean;
begin
  if (Grade.Cells[1,Grade.ALinha] <> '') then
  begin
    if Grade.Cells[1,Grade.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      result := FunInventario.ExisteProduto(Grade.Cells[1,Grade.ALinha],VprDItemInventario);
      if result then
      begin
        VprDItemInventario.UnidadesParentes.free;
        VprDItemInventario.UnidadesParentes := ValidaUnidade.UnidadesParentes(VprDItemInventario.UMOriginal);
        VprProdutoAnterior := VprDItemInventario.CodProduto;
        Grade.Cells[1,Grade.ALinha] := VprDItemInventario.CodProduto;
        Grade.Cells[2,Grade.ALinha] := VprDItemInventario.NomProduto;
        Grade.Cells[8,Grade.ALinha] := VprDItemInventario.UM;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovoInventario.ExisteCor(VpaCodCor :Integer ) : Boolean;
begin
  result := true;
  if VpaCodCor <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from COR '+
                              ' Where COD_COR = '+IntToStr(VpacodCor));
    result := not Aux.eof;
    if result then
    begin
      VprDItemInventario.CodCor := VpaCodCor;
      VprDItemInventario.NomCor := Aux.FieldByName('NOM_COR').AsString;
      Grade.Cells[4,Grade.ALinha] := Aux.FieldByName('NOM_COR').AsString;
      VprCorAnterior := IntToStr(VpacodCor);
    end;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFNovoInventario.ExisteUM : Boolean;
begin
  result := true;
  if Grade.Cells[1,Grade.ALinha] <> '' then
  begin
    result := (VprDItemInventario.UnidadesParentes.IndexOf(Grade.Cells[8,Grade.Alinha]) >= 0);
    if result then
    begin
      VprDItemInventario.UM := Grade.Cells[8,Grade.Alinha];
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoInventario.CarDItem;
begin
  VprDItemInventario.CodProduto := Grade.Cells[1,Grade.Alinha];
  if config.EstoquePorCor then
  begin
    if Grade.Cells[3,Grade.ALinha] <> '' then
      VprDItemInventario.CodCor := StrToInt(Grade.Cells[3,Grade.Alinha])
    else
      VprDItemInventario.CodCor := 0;
  end;
  if config.EstoquePorTamanho then
  begin
    if Grade.Cells[5,Grade.ALinha] <> '' then
      VprDItemInventario.CodTamanho := StrToInt(Grade.Cells[5,Grade.Alinha])
    else
      VprDItemInventario.CodTamanho := 0;
  end;
  VprDItemInventario.NomCor := Grade.Cells[4,Grade.ALinha];
  VprDItemInventario.UM := Grade.Cells[8,Grade.ALinha];
  VprDItemInventario.QtdProduto := StrToFloat(DeletaChars(Grade.Cells[7,Grade.ALinha],'.'));
end;

{******************************************************************************}
procedure TFNovoInventario.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  if VprDInventario.ItemsInventario.Count > 0 then
  begin
    VprDItemInventario := TRBDInventarioItem(VprDInventario.ItemsInventario.Items[VpaLinha-1]);
    Grade.Cells[1,Grade.ALinha] := VprDItemInventario.CodProduto;
    Grade.Cells[2,Grade.ALinha] := VprDItemInventario.NomProduto;
    if config.EstoquePorCor then
    begin
      if VprDItemInventario.CodCor <> 0 then
        Grade.Cells[3,Grade.ALinha] := IntTostr(VprDItemInventario.CodCor)
      else
        Grade.Cells[3,Grade.ALinha] := '';
      Grade.Cells[4,Grade.ALinha] := VprDItemInventario.NomCor;
    end;
    if Config.EstoquePorTamanho then
    begin
      if VprDItemInventario.CodTamanho <> 0 then
        Grade.Cells[5,Grade.ALinha] := IntTostr(VprDItemInventario.CodTamanho)
      else
        Grade.Cells[5,Grade.ALinha] := '';
      Grade.Cells[6,Grade.ALinha] := VprDItemInventario.NomTamanho;
    end;
    if VprDItemInventario.QtdProduto <> 0 then
      Grade.Cells[7,Grade.ALinha] := FormatFloat('0.000',VprDItemInventario.QtdProduto);
    Grade.Cells[8,Grade.ALinha] := VprDItemInventario.UM;
    Grade.Cells[9,Grade.ALinha] := IntToStr(VprDItemInventario.CodUsuario)+'-' + VprDItemInventario.NomUsuario;
  end;
end;

{******************************************************************************}
procedure TFNovoInventario.GradeDadosValidos(Sender: TObject;
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
      if (VprDItemInventario.UnidadesParentes.IndexOf(Grade.Cells[8,Grade.Alinha]) < 0) then
      begin
        VpaValidos := false;
        aviso(CT_UNIDADEVAZIA);
        Grade.col := 8;
      end
      else
        if (Grade.Cells[7,Grade.ALinha] = '') then
        begin
          VpaValidos := false;
          aviso(CT_QTDPRODUTOINVALIDO);
          Grade.Col := 7;
        end;
  if VpaValidos then
  begin
    if config.EstoquePorCor then
    begin
      if (Grade.Cells[3,Grade.ALinha] <> '') then
      begin
        if not Existecor(StrToInt(Grade.Cells[3,Grade.ALinha])) then
        begin
          VpaValidos := false;
          Aviso(CT_CORINEXISTENTE);
          Grade.Col := 3;
        end;
      end;
    end;
    if VpaValidos then
    begin
      if config.EstoquePorTamanho then
      begin
        if not ETamanho.AExisteCodigo(Grade.Cells[5,Grade.ALinha]) then
        begin
          VpaValidos := false;
          aviso('TAMANHO NÃO CADASTRADO!!!'#13'O tamanho digitado não existe cadastrado..');
        end;
      end;
    end;
  end;

  if VpaValidos then
  begin
    CarDItem;
    if VprDItemInventario.QtdProduto = 0 then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      Grade.col := 7;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoInventario.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case Acol of
    3,5 :  Value := '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoInventario.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  case Grade.AColuna of
    2,4,9 : key := #0;
    7 : if key = '.' then
          key := ',';
  end;
end;

{******************************************************************************}
procedure TFNovoInventario.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDInventario.ItemsInventario.Count > 0 then
  begin
    VprDItemInventario := TRBDInventarioItem(VprDInventario.ItemsInventario.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDItemInventario.CodProduto;
    VprCorAnterior :=  InttoStr(VprDItemInventario.CodCor);
  end;
end;

{******************************************************************************}
procedure TFNovoInventario.GradeNovaLinha(Sender: TObject);
begin
  VprDItemInventario := VprDInventario.AddInventarioItem;
  VprDItemInventario.CodUsuario := Varia.CodigoUsuario;
  VprDItemInventario.NomUsuario := varia.NomeUsuario;
  if (config.EstoquePorCor) and (VprProdutoAnterior <> '') then
  begin
    Grade.Cells[1,Grade.ALinha] := VprProdutoAnterior;
    VprProdutoAnterior := '';
    ExisteProduto;
    Grade.Col := 3;
  end;
  if config.EstoquePorTamanho and (VprCorAnterior <> '') then
  begin
    Grade.Cells[3,Grade.ALinha] := VprCorAnterior;
    VprCorAnterior := '';
    ExisteCor(StrToInt(Grade.Cells[3,Grade.ALinha]));
    Grade.Col := 5;
  end;
  VprProdutoAnterior := '';
  VprCorAnterior := '';
end;

{******************************************************************************}
procedure TFNovoInventario.GradeSelectCell(Sender: TObject; ACol,
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
        3 : if Grade.Cells[3,Grade.Alinha] <> '' then
            begin
              if not ExisteCor(StrToInt(Grade.Cells[3,Grade.Alinha])) then
              begin
                if not ECor.AAbreLocalizacao then
                begin
                  Aviso(CT_CORINEXISTENTE);
                  Grade.Col := 3;
                  abort;
                end;
              end;
            end;
        5 : if not ETamanho.AExisteCodigo(Grade.Cells[5,Grade.Alinha]) then
            begin
              if not ETamanho.AAbreLocalizacao then
              begin
                Aviso('TAMANHO INEXISTENTE!!!'#13'O tamanho digitado não existe cadastrado.');
                Grade.Col := 5;
                abort;
              end;
            end;
        8 : if not ExisteUM then
            begin
              aviso(CT_UNIDADEVAZIA);
              Grade.col := 8;
              abort;
            end;
      end;
    end;
end;

{******************************************************************************}
function TFNovoInventario.AdicionaProdutos(VpaDInventario : TRBDInventarioCorpo) : Boolean;
begin
  VprDInventario := VpaDInventario;
  VprOperacao := ocInsercao;
  Grade.ADados := VprDInventario.ItemsInventario;
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovoInventario.AlteraProdutos(VpaDInventario : TRBDInventarioCorpo) : Boolean;
begin
  VprDInventario := VpaDInventario;
  VprOperacao := ocEdicao;
  Grade.ADados := VprDInventario.ItemsInventario;
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoInventario.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoInventario.BOkClick(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao : TTransactionDesc;
begin
  VpfTransacao.IsolationLevel := xilREADCOMMITTED;
  FPrincipal.BaseDados.StartTransaction(VpfTransacao);
  if VprOperacao = ocEdicao then
    FunInventario.DeletaItensInventario(IntToStr(VprDInventario.CodFilial),inttostr(VprDInventario.SeqInventario));
  VpfResultado := FunInventario.AdicinaProdutoInventario(VprDInventario);
  if VpfResultado <> '' then
  begin
    aviso(VpfResultado);
    FPrincipal.BaseDados.Rollback(VpfTransacao);;
  end
  else
  begin
    FPrincipal.BaseDados.Commit(VpfTransacao);;
    VprAcao := true;
    close;
  end;
end;

procedure TFNovoInventario.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :begin
           case Grade.AColuna of
             1 : LocalizaProduto;
             3 : ECor.AAbreLocalizacao;
             5 : ETamanho.AAbreLocalizacao;
           end;
         end;
  end;
end;

{******************************************************************************}
procedure TFNovoInventario.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.showmodal;
  FCores.free;
end;

{******************************************************************************}
procedure TFNovoInventario.ECorRetorno(Retorno1, Retorno2: String);
begin
  if ECor.AInteiro <> 0 then
  begin
    Grade.Cells[3,Grade.ALinha] := ECor.Text;
    Grade.Cells[4,Grade.ALinha] := Retorno1;
    Grade.AEstadoGrade := egEdicao;
    VprCorAnterior := ECor.Text;
  end
  else
  begin
    Grade.Cells[3,Grade.ALinha] := '';
    Grade.Cells[4,Grade.ALinha] := '';
    VprCorAnterior := '';
    Grade.AEstadoGrade := egEdicao;
  end;
end;

{******************************************************************************}
procedure TFNovoInventario.ETamanhoCadastrar(Sender: TObject);
begin
  FTamanhos := TFTamanhos.criarSDI(Application,'',FPrincipal.VerificaPermisao('FTamanhos'));
  FTamanhos.BCadastrar.Click;
  FTamanhos.showmodal;
  FTamanhos.free;
end;

{******************************************************************************}
procedure TFNovoInventario.ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDItemInventario.CodTamanho := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDItemInventario.NomTamanho := VpaColunas.items[1].AValorRetorno;
    Grade.Cells[5,Grade.ALinha] := VpaColunas.items[0].AValorRetorno;
    Grade.Cells[6,Grade.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDItemInventario.CodTamanho := 0;
    VprDItemInventario.NomTamanho := '';
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoInventario]);
end.
