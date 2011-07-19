unit AGeraOP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Grids,
  DBGrids, Tabela, DBKeyViolation, UnDadosProduto, Db, DBTables,
  Localizacao, ComCtrls, UnCotacao, UnOrdemProducao, Unprodutos, CGrades;

type
  TFGerarOP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    ECliente: TEditLocaliza;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    LDatEntrega: TLabel;
    Timer1: TTimer;
    BSElecionarTodos: TBitBtn;
    PGrades: TPanelColor;
    GProdutos: TRBStringGridColor;
    GCompose: TRBStringGridColor;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
    procedure BSElecionarTodosClick(Sender: TObject);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosCellClick(Button: TMouseButton; Shift: TShiftState;
      VpaColuna, VpaLinha: Integer);
    procedure GComposeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprProdutos : TList;
    VprDOrcamento : TRBDOrcamento;
    VprDOP : TRBDOrdemProducaoEtiqueta;
    VprDOPGeral : TRBDOrdemProducao;
    VprOrdem : String;
    FunCotacao : TFuncoesCotacao;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    VprDGerarOP : TRBDGerarOp;
    VprDCompCotacao : TRBDOrcCompose;
    procedure CarTitulosGrade;
    procedure InicializaDOpGeral(VpaDOPGeral : TRBDOrdemProducao);
    procedure GeraOPCadarco;
    procedure GeraOPGeral;
    procedure GeraOPAgrupada;
    procedure GeraOPSubmontagens;
    procedure SelecionaTodosRegistros;
    procedure DeletaProdutosAdicionados;
  public
    { Public declarations }
    function GerarOrdemProducao(VpaOrcamentos : TList) : Boolean;
  end;

var
  FGerarOP: TFGerarOP;

implementation

uses APrincipal,Constantes, ANovaOrdemProducaoCadarco, ConstMsg, AGeraFracaoOP;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGerarOP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
  VprAcao := false;
  FunCotacao := TFuncoesCotacao.Cria(FPrincipal.BaseDados);
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);
  VprDOP := TRBDOrdemProducaoEtiqueta.cria;
  VprProdutos := TList.Create;
  GProdutos.ADados := VprProdutos.Create;
  GProdutos.CarregaGrade;

  BSElecionarTodos.Visible := config.CadastroCadarco;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGerarOP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := VprProdutos.Count = 0;
  FunCotacao.free;
  FunOrdemProducao.free;
  if VprDOrcamento <> nil then
    VprDOP.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
function TFGerarOP.GerarOrdemProducao(VpaOrcamentos : TList) : Boolean;
begin
  GCompose.Visible := config.UtilizarCompose;
  if VpaOrcamentos.Count > 0 then
  begin
    VprDOrcamento := TRBDOrcamento(VpaOrcamentos.Items[0]);
    if varia.TipoOrdemProducao = toFracionada then
    begin
      ECliente.AInteiro := VprDOrcamento.CodCliente;
      ECliente.Atualiza;
    end;
    FunOrdemProducao.CarGerarOP(VpaOrcamentos,VprProdutos);
    GProdutos.CarregaGrade;
    showmodal;
  end;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFGerarOP.CarTitulosGrade;
begin
  GProdutos.Cells[1,0] := '';
  GProdutos.Cells[2,0] := 'Código';
  GProdutos.Cells[3,0] := 'Produto';
  GProdutos.Cells[4,0] := 'Cor';
  GProdutos.Cells[5,0] := 'Descrição';
  GProdutos.Cells[6,0] := 'Tamanho';
  GProdutos.Cells[7,0] := 'Quantidade';
  GProdutos.Cells[8,0] := 'UM';
  GProdutos.Cells[9,0] := 'Referencia Cliente';

  GCompose.Cells[1,0] := 'Cor Ref';
  GCompose.Cells[2,0] := 'Código';
  GCompose.Cells[3,0] := 'Produto';
  GCompose.Cells[4,0] := 'Código';
  GCompose.Cells[5,0] := 'Cor';
end;

{******************************************************************************}
procedure TFGerarOP.InicializaDOpGeral(VpaDOPGeral : TRBDOrdemProducao);
var
  VpfLaco : Integer;
  VpfDGerarOP : TRBDGerarOp;
begin
  VprDOPGeral.free;
  VprDOpGeral := TRBDOrdemProducao.cria;
  FunOrdemProducao.GeraOPdaCotacao(VprDOrcamento,VprDOPGeral);
  for VpfLaco := 0 to VprProdutos.Count - 1 do
  begin
    VpfDGerarOP := TRBDGerarOp(VprProdutos.Items[VpfLaco]);
    if VpfDGerarOP.IndGerar then
    begin
      VprDOPGeral.SeqProduto := VpfDGerarOP.SeqProduto;
      VprDOPGeral.SeqItemOrcamento := VpfDGerarOP.SeqItemOrcamento;
      VprDOPGeral.CodCor := VpfDGerarOP.CodCor;
      VprDOPGeral.CodTransportadora := VprDOrcamento.CodTransportadora;
      VprDOPGeral.CodProduto := VpfDGerarOP.CodProduto;
      VprDOPGeral.NomProduto := VpfDGerarOP.NomProduto;
      VprDOPGeral.NomCor := VpfDGerarOP.NomCor;
      VprDOPGeral.UMPedido := VpfDGerarOP.UM;
      if VpfDGerarOP.UM = varia.UnidadeKit then
      begin
        VprDOPGeral.QtdProduto :=  VpfDGerarOP.QtdProduto * VpfDGerarOP.QtdKit;
        VprDOPGeral.UMPedido := varia.UnidadeUN;
      end
      else
        VprDOPGeral.QtdProduto :=  VpfDGerarOP.QtdProduto;
      VprDOPGeral.CodEstagio := varia.EstagioOrdemProducao;
      VprDOPGeral.DatEntrega := VprDOrcamento.DatPrevista;
      FunProdutos.CarDProduto(VprDOPGeral.DProduto,Varia.CodigoEmpresa,Varia.CodigoEmpFil,VprDOPGeral.SeqProduto);
      FunProdutos.CarDEstagio(VprDOPGeral.DProduto);
      if CONFIG.CopiaObsPedidoOP then
        VprDOPGeral.DesObservacoes := VprDOrcamento.DesObservacao.Text
      else
        VprDOPGeral.DesObservacoes := VprDOPGeral.DProduto.DesObservacao;
      VprDOPGeral.DesReferenciaCliente := VpfDGerarOP.DesReferenciaCliente;
      VprDOPGeral.ValUnitario := VpfDGerarOP.ValUnitario;
//      if MovOrcamentosC_ORD_COM.AsString <> '' then
//        VprDOPGeral.DesOrdemCompra :=  MovOrcamentosC_ORD_COM.AsString;
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TFGerarOP.GeraOPCadarco;
var
  VpfDOpItem : TRBDOPItemCadarco;
  VpfDGerarOP : TRBDGerarOp;
  VpfProdutosAdicionados : TStringList;
  VpfLaco : Integer;
begin
  VprDOP.free;
  VprDOp := TRBDOrdemProducaoEtiqueta.cria;
  VpfProdutosAdicionados := TStringLIst.Create;

  FunOrdemProducao.GeraOPdaCotacao(VprDOrcamento,VprDOP);

  for VpfLaco := 0 to VprProdutos.Count - 1 do
  begin
    VpfDGerarOP := TRBDGerarOp(VprProdutos.Items[VpfLaco]);
    if VpfDGerarOP.IndGerar then
    begin
      VpfDOpItem := VprDOP.AddItemsCadarco;
      VpfDOpItem.SeqProduto := VpfDGerarOP.SeqProduto;
      VpfDOpItem.CodCor := VpfDGerarOP.CodCor;
      VpfDOpItem.CodProduto := VpfDGerarOP.CodProduto;
      VpfDOpItem.NomProduto := VpfDGerarOP.NomProduto;
      VpfDOpItem.NomCor := VpfDGerarOP.NomCor;
      VpfDOpItem.UM := VpfDGerarOP.UM;
      VpfDOpItem.QtdProduto :=  VpfDGerarOP.QtdProduto;
      FunOrdemProducao.CarDTecnicosCadarco(VprDOP,VpfDOpItem);
      FunOrdemProducao.CarQtdMetrosMaquina(VpfDOpItem);
      if VpfDOpItem.DesTecnica <> '' then
      begin
        if VpfProdutosAdicionados.IndexOf(InttoStr(VpfDOpItem.SeqProduto)) < 0 then
        begin
          VpfProdutosAdicionados.Add(IntTostr(VpfDOpItem.SeqProduto));
          if VprDOP.DesObservacoes = '' then
            VprDOP.DesObservacoes := VpfDOpItem.DesTecnica
          else
            VprDOP.DesObservacoes := VprDOP.DesObservacoes +#13+VpfDOpItem.DesTecnica;
        end;
      end;
    end;
  end;

  FNovaOrdemProducaoCadarco := TFNovaOrdemProducaoCadarco.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaOrdemProducaoCadarco'));
  if FNovaOrdemProducaoCadarco.GeraNovaOP(VprDOP) then
    DeletaProdutosAdicionados;

  FNovaOrdemProducaoCadarco.free;
  VpfProdutosAdicionados.free;
end;

{******************************************************************************}
procedure TFGerarOP.GeraOPGeral;
begin
  InicializaDOpGeral(VprDOPGeral);
  if VprDOPGeral.SeqProduto <> 0 then
  begin
    FGeraFracaoOP := TFGeraFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGeraFracaoOP'));
    if  FGeraFracaoOP.GeraFracaoOP(VprDOPGeral) then
    begin
      DeletaProdutosAdicionados;
    end;
    FGeraFracaoOP.free;
  end;
end;

{******************************************************************************}
procedure TFGerarOP.GeraOPAgrupada;
var
  VpfLaco : Integer;
  VpfDGerarOP : TRBDGerarOp;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  VprDOPGeral.free;
  VprDOpGeral := TRBDOrdemProducao.cria;
  FunOrdemProducao.GeraOPdaCotacao(VprDOrcamento,VprDOPGeral);
  for VpfLaco := 0 to VprProdutos.Count - 1 do
  begin
    VpfDGerarOP := TRBDGerarOp(VprProdutos.Items[VpfLaco]);
    if VpfDGerarOP.IndGerar then
    begin
      VpfDFracao := VprDOPGeral.AddFracao;
      VpfDFracao.SeqProduto := VpfDGerarOP.SeqProduto;
      VpfDFracao.CodCor := VpfDGerarOP.CodCor;
      VpfDFracao.CodTamanho := VpfDGerarOP.CodTamanho;
      VpfDFracao.CodProduto := VpfDGerarOP.CodProduto;
      VpfDFracao.NomProduto := VpfDGerarOP.NomProduto;
      VpfDFracao.DesObservacao := VpfDGerarOP.DesObservacao;
      VpfDFracao.NomCor := VpfDGerarOP.NomCor;
      VpfDFracao.NomTamanho := VpfDGerarOP.NomTamanho;
      VpfDFracao.UM := VpfDGerarOP.UM;
      VpfDFracao.UMOriginal := VpfDGerarOP.UMOriginal;
      VpfDFracao.QtdUtilizada :=  VpfDGerarOP.QtdProduto;
      VpfDFracao.QtdProduto :=  VpfDGerarOP.QtdProduto;
      if config.AdicionarQtdIdealEstoquenaOP then
        VpfDFracao.QtdProduto := VpfDFracao.QtdProduto +  FunProdutos.RQtdIdealEstoque(varia.CodigoEmpFil,VpfDGerarOP.SeqProduto,VpfDGerarOP.CodCor) ;
      VpfDFracao.DatEntrega := VpfDGerarOP.DatEntrega;
      VpfDFracao.CodEstagio := Varia.EstagioOrdemProducao;
      VpfDFracao.IndEstagioGerado := true;
      VpfDFracao.IndEstagiosCarregados := true;
      FunOrdemProducao.CopiaCompose(VpfDGerarOP.Compose,VpfDFracao.Compose);
    end;
  end;

  FGeraFracaoOP := TFGeraFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGeraFracaoOP'));
  if  FGeraFracaoOP.GeraFracaoOP(VprDOPGeral) then
  begin
    DeletaProdutosAdicionados;
  end;
  FGeraFracaoOP.free;
end;

{******************************************************************************}
procedure TFGerarOP.GeraOPSubmontagens;
var
  VpfLaco : Integer;
  VpfDGerarOP : TRBDGerarOp;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  InicializaDOpGeral(VprDOPGeral);
  for VpfLaco := 0 to VprProdutos.Count - 1 do
  begin
    VpfDGerarOP := TRBDGerarOp(VprProdutos.Items[VpfLaco]);
    if VpfDGerarOP.IndGerar then
    begin
      VpfDFracao := VprDOPGeral.AddFracao;
      VpfDFracao.SeqProduto := VpfDGerarOP.SeqProduto;
      VpfDFracao.CodCor := VpfDGerarOP.CodCor;
      VpfDFracao.CodProduto := VpfDGerarOP.CodProduto;
      VpfDFracao.NomProduto := VpfDGerarOP.NomProduto;
      VpfDFracao.DesObservacao := VpfDGerarOP.DesObservacao;
      VpfDFracao.NomCor := VpfDGerarOP.NomCor;
      VpfDFracao.UM := VpfDGerarOP.UM;
      VpfDFracao.UMOriginal := VpfDGerarOP.UMOriginal;
      VpfDFracao.QtdUtilizada :=  VpfDGerarOP.QtdProduto;
      VpfDFracao.QtdProduto :=  VpfDGerarOP.QtdProduto;
      VpfDFracao.DatEntrega := VpfDGerarOP.DatEntrega;
      VpfDFracao.CodEstagio := Varia.EstagioOrdemProducao;
      VpfDFracao.IndEstagioGerado := true;
      VpfDFracao.IndEstagiosCarregados := true;
      FunOrdemProducao.VplQtdFracoes := 0;
      FunOrdemProducao.AdicionaProdutosSubMontagem(VprDOPGeral,VpfDFracao,StatusBar1);
    end;
  end;

  FGeraFracaoOP := TFGeraFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGeraFracaoOP'));
  if  FGeraFracaoOP.GeraFracaoOP(VprDOPGeral) then
  begin
    DeletaProdutosAdicionados;
  end;
  FGeraFracaoOP.free;
end;

{******************************************************************************}
procedure TFGerarOP.SelecionaTodosRegistros;
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VprProdutos.Count - 1 do
    TRBDGerarOp(VprProdutos.Items[VpfLaco]).IndGerar := true;
  GProdutos.carregaGrade;
end;

{******************************************************************************}
procedure TFGerarOP.DeletaProdutosAdicionados;
var
  VpfLaco, VprSeqOrdem : Integer;
begin
  if VprDOPGeral.SeqOrdem <> 0 then
    VprSeqOrdem := VprDOPGeral.SeqOrdem
  else
    VprSeqOrdem := VprDOP.SeqOrdem;
  for VpfLaco := VprProdutos.Count - 1 downto 0 do
  begin
    VprDGerarOP := TRBDGerarOp(VprProdutos.Items[VpfLaco]);
    if VprDGerarOP.IndGerar then
    begin
      FunCotacao.SetaDataOpGeradaProduto(VprDOrcamento.CodEmpFil,VprDOrcamento.LanOrcamento,VprDGerarOP.SeqItemOrcamento,VprSeqOrdem );
      VprDGerarOP.free;
      VprProdutos.Delete(VpfLaco);
      if not(config.CadastroCadarco) and (varia.TipoOrdemProducao = toFracionada) then
        break;
    end;
  end;
  GProdutos.CarregaGrade;
end;

{******************************************************************************}
procedure TFGerarOP.BFecharClick(Sender: TObject);
begin
  VprAcao := VprProdutos.Count = 0;
  close;
end;

{******************************************************************************}
procedure TFGerarOP.Timer1Timer(Sender: TObject);
begin
  LDatEntrega.Visible := not LDatEntrega.Visible;
end;

{******************************************************************************}
procedure TFGerarOP.BGerarClick(Sender: TObject);
begin
  if Config.CadastroCadarco then
    GeraOPCadarco
  else
    if varia.TipoOrdemProducao = toAgrupada then
      GeraOPAgrupada
    else
      if varia.TipoOrdemProducao = toFracionada then
        GeraOPGeral
      else
        if varia.TipoOrdemProducao = toSubMontagem then
          GeraOPSubmontagens;

end;

{******************************************************************************}
procedure TFGerarOP.BSElecionarTodosClick(Sender: TObject);
begin
  SelecionaTodosRegistros;
end;

{******************************************************************************}
procedure TFGerarOP.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDGerarOP := TRBDGerarOp(VprProdutos.Items[VpaLinha-1]);
  if VprDGerarOP.IndGerar then
    GProdutos.Cells[1,VpaLinha] := '1'
  else
    GProdutos.Cells[1,VpaLinha] := '0';
  GProdutos.Cells[2,VpaLinha] := VprDGerarOP.CodProduto;
  GProdutos.Cells[3,VpaLinha] := VprDGerarOP.NomProduto;
  if VprDGerarOP.CodCor <> 0 then
    GProdutos.Cells[4,VpaLinha] := InttoStr(VprDGerarOP.CodCor)
  else
    GProdutos.Cells[4,VpaLinha] := '';
  GProdutos.Cells[5,VpaLinha] := VprDGerarOP.NomCor;
  GProdutos.Cells[6,VpaLinha] := VprDGerarOP.NomTamanho;
  GProdutos.Cells[7,VpaLinha] := FormatFloat(varia.MascaraQtd,VprDGerarOP.QtdProduto);
  GProdutos.Cells[8,VpaLinha] := VprDGerarOP.UM;
  GProdutos.Cells[9,VpaLinha] := VprDGerarOP.DesReferenciaCliente;
end;

{******************************************************************************}
procedure TFGerarOP.GProdutosCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if VpaLinha >= 1 then
  begin
    if GProdutos.Cells[1,VpaLinha] = '0' then
    begin
      GProdutos.Cells[1,VpaLinha] := '1';
      TRBDGerarOp(VprProdutos.Items[VpaLinha - 1]).IndGerar := true;
    end
    else
    begin
      TRBDGerarOp(VprProdutos.Items[VpaLinha - 1]).IndGerar := false;
      GProdutos.Cells[1,VpaLinha] := '0';
    end;
  end;
end;

{******************************************************************************}
procedure TFGerarOP.GComposeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCompCotacao := TRBDOrcCompose(VprDGerarOP.Compose.Items[VpaLinha-1]);
  GCompose.Cells[1,VpaLinha] := IntToStr(VprDCompCotacao.CorRefencia);
  GCompose.Cells[2,VpaLinha] := VprDCompCotacao.CodProduto;
  GCompose.Cells[3,VpaLinha] := VprDCompCotacao.NomProduto;
  if VprDCompCotacao.CodCor <> 0 then
    GCompose.Cells[4,VpaLinha] := InttoStr(VprDCompCotacao.CodCor)
  else
    GCompose.Cells[4,VpaLinha] := '';
  GCompose.Cells[5,VpaLinha] := VprDCompCotacao.NomCor;
end;

{******************************************************************************}
procedure TFGerarOP.GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprProdutos.Count >0 then
  begin
    VprDGerarOP := TRBDGerarOp(VprProdutos.Items[VpaLinhaAtual-1]);
    GCompose.ADados := VprDGerarOP.Compose;
    GCompose.CarregaGrade;
  end;

end;

{******************************************************************************}
Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGerarOP]);
end.

