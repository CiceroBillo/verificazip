unit ANovaComposicao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, StdCtrls, Mask, DBCtrls, Tabela, DBKeyViolation, DB, DBClient,
  BotaoCadastro, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao, UnDadosProduto,
  UnDadosLOcaliza, UnProdutos;

type
  TFNovaComposicao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    Composicao: TSQL;
    DataComposicao: TDataSource;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Grade: TRBStringGridColor;
    EFiguraGRF: TRBEditLocaliza;
    ComposicaoCODCOMPOSICAO: TFMTBCDField;
    ComposicaoNOMCOMPOSICAO: TWideStringField;
    ComposicaoDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ComposicaoAfterInsert(DataSet: TDataSet);
    procedure ComposicaoAfterEdit(DataSet: TDataSet);
    procedure ComposicaoBeforePost(DataSet: TDataSet);
    procedure BotaoGravar1DepoisAtividade(Sender: TObject);
    procedure EFiguraGRFRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ComposicaoAfterScroll(DataSet: TDataSet);
    procedure ComposicaoAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    VprDFigura : TRBDFiguraGRF;
    VprFiguras : TList;
    procedure CarTitulosGrade;
  public
    { Public declarations }
  end;

var
  FNovaComposicao: TFNovaComposicao;

implementation

uses APrincipal, AComposicoes, FunObjeto, ConstMsg, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaComposicao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Composicao.Open;
  CarTitulosGrade;
  VprFiguras := TList.Create;
end;

{******************************************************************************}
procedure TFNovaComposicao.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDFigura := TRBDFiguraGRF(VprFiguras.Items[VpaLinha-1]);
  if VprDFigura.CodFiguraGRF <> 0 then
    Grade.Cells[1,VpaLinha]:= InttoStr(VprDFigura.CodFiguraGRF)
  else
    Grade.Cells[1,VpaLinha]:= '';
  Grade.Cells[2,VpaLinha]:= VprDFigura.NomFiguraGRF;
end;

{******************************************************************************}
procedure TFNovaComposicao.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not EFiguraGRF.AExisteCodigo(Grade.Cells[1,Grade.ALinha]) then
  begin
    VpaValidos := false;
    aviso('FIGURA GRF NÃO CADASTRADA!!!'#13'A figura GRF digitada não existe cadastrada.');
    Grade.Col := 1;
  end;
  if Vpavalidos then
  begin
    if FunProdutos.FiguraGRFDuplicada(VprFiguras) then
    begin
      VpaValidos := false;
      aviso('FIGURA DUPLICADA!!!'#13'Essa figura já foi digitada.');
    end;
  end;

end;

{******************************************************************************}
procedure TFNovaComposicao.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case Grade.AColuna of
        1: EFiguraGRF.AAbreLocalizacao;
      end;
    end;
  end;
end;

procedure TFNovaComposicao.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprFiguras.Count >0 then
  begin
    VprDFigura := TRBDFiguraGRF(VprFiguras.Items[VpaLinhaAtual-1]);
  end;
end;

procedure TFNovaComposicao.GradeNovaLinha(Sender: TObject);
begin
  VprDFigura := TRBDFiguraGRF.cria;
  VprFiguras.add(VprDFigura);
end;

procedure TFNovaComposicao.GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1 :if not EFiguraGRF.AExisteCodigo(Grade.Cells[1,Grade.ALinha]) then
           begin
             if not EFiguraGRF.AAbreLocalizacao then
             begin
               Grade.Cells[1,Grade.ALinha] := '';
               abort;
             end;
           end;
      end;
    end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaComposicao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaComposicao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprFiguras);
  VprFiguras.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaComposicao.BotaoGravar1DepoisAtividade(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfResultado := FunProdutos.GravaFigurasGRF(ComposicaoCODCOMPOSICAO.AsInteger,VprFiguras);
  if vpfresultado <> '' then
    aviso(VpfResultado);
end;

procedure TFNovaComposicao.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Figura';
end;

{******************************************************************************}
procedure TFNovaComposicao.ComposicaoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFNovaComposicao.ComposicaoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

procedure TFNovaComposicao.ComposicaoAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('COMPOSICAO');
end;

{******************************************************************************}
procedure TFNovaComposicao.ComposicaoAfterScroll(DataSet: TDataSet);
begin
  FunProdutos.CarFigurasGRF(ComposicaoCODCOMPOSICAO.AsInteger,VprFiguras);
  Grade.ADados := VprFiguras;
  Grade.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaComposicao.ComposicaoBeforePost(DataSet: TDataSet);
begin
  if Composicao.State in [dsInsert] then
    ECodigo.VerificaCodigoUtilizado;
  ComposicaoDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFNovaComposicao.EFiguraGRFRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDFigura.CodFiguraGRF := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDFigura.NomFiguraGRF := VpaColunas.items[1].AValorRetorno;
    Grade.Cells[1,Grade.ALinha] := VpaColunas.items[0].AValorRetorno;
    Grade.Cells[2,Grade.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDFigura.CodFiguraGRF:= 0;
    VprDFigura.NomFiguraGRF := '';
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaComposicao]);
end.
