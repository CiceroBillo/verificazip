unit AGeraFracaoOP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  Mask, numericos, StdCtrls, Buttons, UnDadosProduto, UnOrdemProducao,
  EditorImagem, Menus, UnProdutos;

type
  TFGeraFracaoOP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PProduto: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    LNomProduto: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    LNomCor: TLabel;
    SpeedButton2: TSpeedButton;
    ECodProduto: TEditColor;
    EQtdProduto: Tnumerico;
    EUM: TEditColor;
    ECor: TEditLocaliza;
    EQtdFracoes: Tnumerico;
    Label4: TLabel;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BImprimir: TBitBtn;
    SpeedButton3: TSpeedButton;
    EditorImagem1: TEditorImagem;
    CProducaoExterna: TCheckBox;
    PopupMenu1: TPopupMenu;
    Gerartodososestagios1: TMenuItem;
    Label5: TLabel;
    EQtdNasFracoes: Tnumerico;
    N1: TMenuItem;
    GerarEstagioscomooPrimeiro1: TMenuItem;
    PanelColor4: TPanelColor;
    Grade: TRBStringGridColor;
    PanelColor3: TPanelColor;
    Label6: TLabel;
    EObservacoes: TMemoColor;
    GCompose: TRBStringGridColor;
    PopupMenu2: TPopupMenu;
    ImprimirConsumoOP1: TMenuItem;
    BMaquinas: TBitBtn;
    PainelTempo1: TPainelTempo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EQtdFracoesExit(Sender: TObject);
    procedure EQtdFracoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EQtdProdutoExit(Sender: TObject);
    procedure EQtdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetCellAlignment(sender: TObject; ARow, ACol: Integer;
      var HorAlignment: TAlignment; var VerAlignment: TVerticalAlignment);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BGerarClick(Sender: TObject);
    procedure GradeGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GradeDblClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure Gerartodososestagios1Click(Sender: TObject);
    procedure EQtdNasFracoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GerarEstagioscomooPrimeiro1Click(Sender: TObject);
    procedure GComposeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure ImprimirConsumoOP1Click(Sender: TObject);
    procedure BMaquinasClick(Sender: TObject);
    procedure GradeDepoisExclusao(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDOrdemProducao : TRBDOrdemProducao;
    VprDFracao : TRBDFracaoOrdemProducao;
    VprDCompCotacao : TRBDOrcCompose;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure CarTituloGrade;
    procedure CarDTela;
    procedure CarDClasse;
    procedure AtualizaQtdProdutos;
    function FracoesGeradas : Boolean;
    function BastidoresPreenchidos : Boolean;
    procedure AtualizaDataOP;
    function DadosValidos : string;
    procedure estadoBotoes(VpaEstado : Boolean);
    procedure ConfiguraTela;
    procedure ImprimeEtiquetasSubMontagens;
    procedure GeraTodosEstagio;
  public
    { Public declarations }
    function GeraFracaoOP(VpaDOrdemProducao : TRBDOrdemProducao) : Boolean;
  end;

var
  FGeraFracaoOP: TFGeraFracaoOP;

implementation

uses APrincipal,Constantes, ConstMsg, FunString, AGeraEstagiosOP, UnCrystal,FunData,
   FunObjeto, AGerarFracaoOPMaquinasCorte, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGeraFracaoOP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTituloGrade;
  VprAcao := false;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGeraFracaoOP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFGeraFracaoOP.CarTituloGrade;
begin
  Grade.Cells[1,0] := 'Fração';
  Grade.Cells[2,0] := 'Quantidade';
  Grade.Cells[3,0] := 'Qtd Utilizada';
  Grade.Cells[4,0] := 'UM';
  Grade.Cells[5,0] := 'Entrega';
  Grade.Cells[6,0] := 'Código';
  Grade.Cells[7,0] := 'Produto';
  Grade.Cells[8,0] := 'Código';
  Grade.Cells[9,0] := 'Cor';
  Grade.Cells[10,0] := 'Tamanho';

  GCompose.Cells[1,0] := 'Cor Ref';
  GCompose.Cells[2,0] := 'Código';
  GCompose.Cells[3,0] := 'Produto';
  GCompose.Cells[4,0] := 'Código';
  GCompose.Cells[5,0] := 'Cor';
end;

{******************************************************************************}
procedure TFGeraFracaoOP.CarDTela;
begin
  ECodProduto.Text := VprDOrdemProducao.CodProduto;
  LNomProduto.Caption := VprDOrdemProducao.NomProduto;
  EQtdProduto.AValor := VprDOrdemProducao.QtdProduto;
  EUM.Text := VprDOrdemProducao.UMPedido;
  EQtdFracoes.AsInteger := VprDOrdemProducao.QtdFracoes;
  ECor.AInteiro := VprDOrdemProducao.CodCor;
  ECor.Atualiza;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.CarDClasse;
begin
  VprDOrdemProducao.QtdProduto := EQtdProduto.AValor;
  VprDOrdemProducao.QtdFracoes := EQtdFracoes.AsInteger;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.AtualizaQtdProdutos;
var
  VpfLaco : Integer;
begin
  EQtdProduto.AValor := 0;
  for VpfLaco := 0 to VprDOrdemProducao.Fracoes.count - 1 do
  begin
    EQtdProduto.AValor := EQtdProduto.AValor + TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes.Items[VpfLaco]).QtdProduto;
  end;
end;

{******************************************************************************}
function TFGeraFracaoOP.FracoesGeradas : Boolean;
var
  VpfLaco : Integer;
begin
  result := true;
  for VpfLaco := 0 to VprDOrdemProducao.Fracoes.Count - 1 do
  begin
    if not TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes.Items[VpfLaco]).IndEstagioGerado then
    begin
      result := false;
      Grade.row := VpfLaco +1;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFGeraFracaoOP.BastidoresPreenchidos : Boolean;
var
  VpfLaco : Integer;
  VpfDCorteItem : TRBDOrdemCorteItem;
begin
  result := true;
  for VpfLaco := 0 to VprDOrdemProducao.OrdemCorte.Itens.Count - 1 do
  begin
    VpfDCorteItem := TRBDOrdemCorteItem(VprDOrdemProducao.OrdemCorte.Itens[VpfLaco]);
    if (VpfDCorteItem.CodMaquina <> 0) and (VpfDCorteItem.CodBastidor = 0 ) then
    begin
      result := false;
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.AtualizaDataOP;
var
  VpfLaco : Integer;
  VpfMenorData : TDateTime;
begin
  VpfMenorData := MontaData(1,1,3000);
  for VpfLaco := 0 to VprDOrdemProducao.Fracoes.count - 1 do
  begin
    if TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes.Items[VpfLaco]).DatEntrega < VpfMenorData then
      VpfMenorData := TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes.Items[VpfLaco]).DatEntrega;
  end;
  VprDOrdemProducao.DatEntregaPrevista := VpfMenorData;
  VprDOrdemProducao.DesObservacoes := EObservacoes.Lines.Text;
end;

{******************************************************************************}
function TFGeraFracaoOP.DadosValidos : string;
begin
  result := '';
  if not FracoesGeradas then
  begin
    result := 'FRAÇÕES NÃO GERADAS OS ESTAGIOS!!!'#13'Não é possível gravar pois exitem frações que não foram gerados os estágios.';
  end;
  if result = '' then
    if not BastidoresPreenchidos then
      result :='BASTIDORES NÃO PREENCHIDOS!!!'#13'Antes de gravar as frações é necessário associar os bastidotes...';
end;

{******************************************************************************}
procedure TFGeraFracaoOP.estadoBotoes(VpaEstado : Boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BGerar.Enabled := VpaEstado;
  BImprimir.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.ConfiguraTela;
begin
  if varia.TipoOrdemProducao in [toAgrupada,toSubMontagem] then
  begin
    PProduto.Visible := false;
    if config.UtilizarCompose then
      GCompose.Visible := true;
  end
  else
  begin
    ActiveControl := EQtdFracoes;
    Grade.ColWidths[6] := 0;
    Grade.ColWidths[7] := 0;
    Grade.ColWidths[8] := 0;
    Grade.ColWidths[9] := 0;
    Grade.ColWidths[10] := 0;
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.ImprimeEtiquetasSubMontagens;
begin
  FunOrdemProducao.ImprimeEtiquetaFracao(VprDOrdemProducao);
end;

{******************************************************************************}
function TFGeraFracaoOP.GeraFracaoOP(VpaDOrdemProducao : TRBDOrdemProducao) : Boolean;
begin
  ConfiguraTela;
  Grade.ADados := VpaDOrdemProducao.Fracoes;
  VprDOrdemProducao := VpaDOrdemProducao;
  CarDTela;
  if VpaDOrdemProducao.Fracoes.Count = 0 then
    FunOrdemProducao.GeraFracoesOP(VpaDOrdemProducao);
  FunOrdemProducao.GeraOrdemCorte(VprDOrdemProducao);
  EObservacoes.Lines.Text :=  VpaDOrdemProducao.DesObservacoes;
  if (VpaDOrdemProducao.CodCor = 0) and (VpaDOrdemProducao.NomCor <> '') then
  begin
    LNomCor.Caption := VpaDOrdemProducao.NomCor;
  end;
  Grade.CarregaGrade;
  estadoBotoes(true);
  // 12/11/2010
  //hoje ninguem esta usando essa rotina para fazer a programação da produçao por isso foi colocado para gerar todos os estagios automaticamente
  //solicitacao feita pelo Rafael da Rafthel.
  GeraTodosEstagio;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.EQtdFracoesExit(Sender: TObject);
begin
  if EQtdFracoes.AsInteger <> VprDOrdemProducao.QtdFracoes then
  begin
    if EQtdFracoes.AsInteger = 0 then
    begin
      aviso('QUANTIDADE DE FRAÇÕES INVÁLIDA!!!'#13'A quantidade de frações tem que ser maior que zero.');
      EQtdFracoes.AsInteger := VprDOrdemProducao.QtdFracoes;
    end
    else
    begin
      VprDOrdemProducao.QtdFracoes := EQtdFracoes.AsInteger;
      FunOrdemProducao.GeraFracoesOP(VprDOrdemProducao);
      Grade.CarregaGrade;
    end;
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.EQtdFracoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    EQtdFracoesExit(EQtdFracoes);
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.EQtdProdutoExit(Sender: TObject);
begin
  if EQtdProduto.AValor <> VprDOrdemProducao.QtdProduto then
  begin
    VprDOrdemProducao.QtdProduto := EQtdProduto.AValor;
    FunOrdemProducao.GeraFracoesOP(VprDOrdemProducao);
    FunOrdemProducao.GeraOrdemCorte(VprDOrdemProducao);
    Grade.carregagrade;
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.EQtdProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    EQtdProdutoExit(EQtdProduto);
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDFracao := TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes.Items[VpaLinha-1]);
  Grade.cells[1,VpaLinha] := InttoStr(VprDFracao.SeqFracao)+'-'+InttoStr(VprDFracao.SeqFracaoPai);
  Grade.Cells[2,VpaLinha] := FormatFloat(Varia.MascaraQtd, VprDFracao.QtdProduto);
  Grade.Cells[3,VpaLinha] := FormatFloat(Varia.MascaraQtd, VprDFracao.QtdUtilizada);
  Grade.cells[4,VpaLinha] := VprDFracao.UM;
  Grade.cells[5,VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDFracao.DatEntrega);
  Grade.cells[6,VpaLinha] := VprDFracao.CodProduto;
  Grade.cells[7,VpaLinha] := VprDFracao.NomProduto;
  if VprDFracao.CodCor <> 0 then
    Grade.cells[8,VpaLinha] := InttosTr(VprDFracao.CodCor)
  else
    Grade.cells[8,VpaLinha] := '';
  Grade.cells[9,VpaLinha] := VprDFracao.NomCor;
  Grade.cells[10,VpaLinha] := VprDFracao.NomTamanho;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
var
  VpfData : String;
begin
  VpaValidos := true;
  if (Grade.Cells[2,Grade.ALinha] = '') then
  begin
    Aviso('QUANTIDADE DA FRAÇÃO NÃO PREENCHIDO!!!'#13'É necessário digitar a quantidade de produto que será produzido na fração');
    Grade.Col := 2;
    VpaValidos :=false;
  end
  else
    if (Grade.Cells[5,Grade.ALinha] = '') then
    begin
      Aviso('DATA DE ENTREGA INVÁLIDA!!!'#13'É necessário digitar um formato de data válido.');
      Grade.Col := 5;
      VpaValidos :=false;
    end;

  if Grade.Cells[5,Grade.ALinha] <> '' then
  begin
    try
      VpfData := Grade.Cells[5,Grade.ALinha];
      if VpfData[9] = ' ' then
      begin
        VpfData := copy(VpfData,1,6)+'20'+ copy(VpfData,7,2);
        Grade.Cells[5,Grade.ALinha] := VpfData;
      end;
      VprDFracao.DatEntrega := MontaData(StrToInt(Copy(VpfData,1,2)),StrToInt(Copy(VpfData,4,2)),StrToInt(Copy(VpfData,7,4)))
    except
      VpaValidos := false;
      Grade.Col := 5;
      aviso('DATA DE ENTREGA INVÁLIDA!!!'#13'É necessário digitar um formato de data válido.');
    end;
  end;
  VprDFracao.QtdProduto := StrToFloat(DeletaChars(Grade.Cells[2,Grade.Alinha],'.'));

  if VprDFracao.QtdProduto = 0 then
  begin
    Aviso('QUANTIDADE DA FRAÇÃO PREENCHIDO COM ZERO!!!'#13'É necessário digitar a quantidade de produto que será produzido na fração');
    Grade.Col := 2;
    VpaValidos :=false;
  end;

  if VpaValidos then
    AtualizaQtdProdutos;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GradeGetCellAlignment(sender: TObject; ARow,
  ACol: Integer; var HorAlignment: TAlignment;
  var VerAlignment: TVerticalAlignment);
begin
  if ARow > 0 then
  begin
    case ACol of
      2,3 : HorAlignment := taRightJustify;
    end;
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDOrdemProducao.Fracoes.Count > 0 then
  begin
    VprDFracao := TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes.Items[VpaLinhaAtual-1]);
    GCompose.ADados := VprDFracao.Compose;
    GCompose.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.BGerarClick(Sender: TObject);
begin
  if not VprDFracao.IndEstagiosCarregados then
    FunOrdemProducao.AdicionaEstagiosOP(VprDOrdemProducao.DProduto,VprDFracao,CProducaoExterna.Checked);
  FGeraEstagiosOP := tFGeraEstagiosOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGeraEstagiosOP'));
  if FGeraEstagiosOP.GeraEstagioOP(VprDOrdemProducao,VprDFracao) then
  begin
    VprDFracao.IndEstagioGerado := true;
    Grade.CarregaGrade;
  end;
  FGeraEstagiosOP.free;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GradeGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  VpfDItem : TRBDFracaoOrdemProducao;
begin
  if (ACol > 0) and (ARow > 0) and (VprDOrdemProducao <> nil) then
  begin
    if VprDOrdemProducao.Fracoes.Count > 0  then
    begin
      VpfDItem := TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes.Items[Arow-1]);
      if varia.TipoOrdemProducao = toFracionada then
      begin
        if VpfDItem.IndEstagioGerado then
          ABrush.Color := clGray
      end
      else
      if varia.TipoOrdemProducao = toSubMontagem then
      begin
        if VpfDItem.IndPossuiEmEstoque then
          ABrush.Color := $0080FF80;
      end;

    end;
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GradeDblClick(Sender: TObject);
begin
  BGerar.Click;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = '' then
  begin
    AtualizaDataOP;
    PainelTempo1.execute('Gravando os dados das frações. Aguarde ');
    Vpfresultado := FunOrdemProducao.GravaDOrdemProducaoBasicao(VprDOrdemProducao);

    if Vpfresultado = '' then
    begin
      PainelTempo1.execute('Gerando os consumos das frações. Aguarde ');
      FunOrdemProducao.GeraConsumoOP(VprDOrdemProducao);
      PainelTempo1.execute('Gravando os dados dos consumos das frações. Aguarde ');
      VpfResultado := FunOrdemProducao.GravaConsumoOP(VprDOrdemProducao);
      if VpfResultado = '' then
      begin
        PainelTempo1.execute('Gravando os dados da ordem de corte das frações. Aguarde ');
        VpfResultado := FunOrdemProducao.GravaDOrdemCorte(VprDOrdemProducao.OrdemCorte);
      end;
    end;
  end;

  if VpfResultado = '' then
  begin
    VprAcao := true;
    estadoBotoes(false);
  end
  else
    aviso(VpfResultado);
  PainelTempo1.fecha;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.BImprimirClick(Sender: TObject);
var
  VpfLaco : Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if varia.TipoOrdemProducao = toAgrupada then
  begin
      dtRave := TdtRave.create(self);
      dtRave.ImprimeOPAgrupada(VprDOrdemProducao.CodEmpresafilial,VprDOrdemProducao.SeqOrdem);
      dtRave.free;
  end
  else
    if Varia.TipoOrdemProducao = toSubMontagem then
    begin
      ImprimeEtiquetasSubMontagens;
    end
    else
    begin
      if config.ImprimirOPImpressoraTermica then
        FunOrdemProducao.ImprimeEtiquetasOrdemProducao(VprDOrdemProducao)
      else
      begin
        dtRave := TdtRave.create(self);
        for Vpflaco := 0 to VprDOrdemProducao.Fracoes.Count - 1 do
        begin
          VpfDFracao := TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes.Items[VpfLaco]);
          dtRave.ImprimeFracaoOP(VprDOrdemProducao.CodEmpresafilial,VprDOrdemProducao.SeqOrdem,VpfDFracao.SeqFracao,false);
        end;
        dtRave.free;
      end;
      FunOrdemProducao.GeraImpressaoConsumoFracao(VprDOrdemProducao.CodEmpresafilial,VprDOrdemProducao.SeqOrdem,0,false);
      dtRave := TdtRave.create(self);
      dtRave.ImprimeConsumoFracionada(VprDOrdemProducao.CodEmpresafilial,VprDOrdemProducao.SeqOrdem,false);
      dtRave.free;

      if VprDOrdemProducao.OrdemCorte.Itens.Count > 0 then
      begin
        dtRave := TdtRave.create(self);
        dtRave.ImprimeOrdemCorteOP(VprDOrdemProducao.CodEmpresafilial,VprDOrdemProducao.SeqOrdem,false);
        dtRave.free;
      end;
    end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.SpeedButton3Click(Sender: TObject);
begin
  EditorImagem1.execute(Varia.DriveFoto+ VprDOrdemProducao.DProduto.PatFoto);
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    5 :  Value := '!99/00/0000;1;_';
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.Gerartodososestagios1Click(Sender: TObject);
begin
  GeraTodosEstagio;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GeraTodosEstagio;
var
  VpfLaco : Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if (varia.TipoOrdemProducao in [toFracionada]) then
  begin
    for VpfLaco := 0 to VprDOrdemProducao.Fracoes.Count - 1 do
    begin
      VpfDFracao := TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes[VpfLaco]);
      FreeTObjectsList(VpfDFracao.Estagios);
      FunOrdemProducao.AdicionaEstagiosOP(VprDOrdemProducao.DProduto,VpfDFracao,CProducaoExterna.Checked);
      VpfDFracao.IndEstagioGerado := true;
    end;
  end;
  Grade.CarregaGrade;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.EQtdNasFracoesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  VpfLaco : Integer;
  VpfQtd : Double;
begin
  if (key = 13 ) then
  begin
    VprDOrdemProducao.QtdFracoes := (EQtdProduto.AsInteger div EQtdNasFracoes.AsInteger);
    if ((EQtdProduto.AsInteger mod EQtdNasFracoes.AsInteger) > 0) then
      VprDOrdemProducao.QtdFracoes := VprDOrdemProducao.QtdFracoes + 1;
    FunOrdemProducao.GeraFracoesOP(VprDOrdemProducao);
    VpfQtd := 0;
    For vpflaco := 0 to VprDOrdemProducao.Fracoes.Count - 2 do
    begin
      TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes.Items[VpfLaco]).QtdProduto := EQtdNasFracoes.AsInteger;
      VpfQtd := VpfQtd + EQtdNasFracoes.AsInteger;
    end;
    TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes.Items[VprDOrdemProducao.Fracoes.Count - 1]).QtdProduto := EQtdProduto.AsInteger - VpfQtd;
    Grade.CarregaGrade;
  end;
  EQtdFracoes.AsInteger := VprDOrdemProducao.Fracoes.Count;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GerarEstagioscomooPrimeiro1Click(Sender: TObject);
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfDFracaoOrigem, VpfDFracaoDestino : TRBDFracaoOrdemProducao;
  VpfDEstagioOrigem, VpfDEstagioDestino :  TRBDordemProducaoEstagio;
begin
  VpfDFracaoOrigem := TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes[0]);
  for VpfLacoExterno := 1 to VprDOrdemProducao.Fracoes.Count - 1 do
  begin
    VpfDFracaoDestino := TRBDFracaoOrdemProducao(VprDOrdemProducao.Fracoes[VpfLacoExterno]);
    FreeTObjectsList(VpfDFracaoDestino.Estagios);
    for VpfLacoInterno := 0 to VpfDFracaoOrigem.Estagios.Count - 1 do
    begin
      VpfDEstagioOrigem := TRBDordemProducaoEstagio(VpfDFracaoOrigem.Estagios[VpfLacoInterno]);
      VpfDEstagioDestino := VpfDFracaoDestino.AddEstagio;
      VpfDEstagioDestino.CodEstagio := VpfDEstagioOrigem.CodEstagio;
      VpfDEstagioDestino.SeqEstagio := VpfDEstagioOrigem.SeqEstagio;
      VpfDEstagioDestino.DesEstagio := VpfDEstagioOrigem.DesEstagio;
      VpfDEstagioDestino.IndProducaoInterna := VpfDEstagioOrigem.IndProducaoInterna;
      VpfDEstagioDestino.SeqEstagioAnterior := VpfDEstagioOrigem.SeqEstagioAnterior;
      VpfDEstagioDestino.QtdCelula := VpfDEstagioOrigem.QtdCelula;
      VpfDEstagioDestino.NumOrdem := VpfDEstagioOrigem.NumOrdem;
      FunProdutos.ExisteEstagio(IntToStr(VpfDEstagioDestino.CodEstagio),VpfDEstagioDestino.NomEstagio);
      VpfDEstagioDestino.QtdHoras := VpfDEstagioOrigem.QtdHoras;

    end;
    VpfDFracaoDestino.IndEstagioGerado := true;
    VpfDFracaoDestino.IndEstagiosCarregados := true;
  end;
  Grade.CarregaGrade;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GComposeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCompCotacao := TRBDOrcCompose(VprDFracao.Compose.Items[VpaLinha-1]);
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
procedure TFGeraFracaoOP.ImprimirConsumoOP1Click(Sender: TObject);
begin
  if varia.TipoOrdemProducao = toAgrupada then
  begin
    dtRave := TdtRave.Create(self);
    dtRave.ImprimeConsumoOrdemProducao(VprDOrdemProducao.CodEmpresafilial,VprDOrdemProducao.SeqOrdem);
    dtRave.Free;
  end;
end;

{******************************************************************************}
procedure TFGeraFracaoOP.BMaquinasClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if VpfResultado = '' then
  begin
    FGerarFracaoOPMaquinasCorte := TFGerarFracaoOPMaquinasCorte.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGerarFracaoOPMaquinasCorte'));
    FGerarFracaoOPMaquinasCorte.GeraOrdemCorte(VprDOrdemProducao);
    FGerarFracaoOPMaquinasCorte.free;
  end;

  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFGeraFracaoOP.GradeDepoisExclusao(Sender: TObject);
begin
  VprDOrdemProducao.QtdFracoes := VprDOrdemProducao.Fracoes.Count;
  EQtdFracoes.AValor := VprDOrdemProducao.Fracoes.Count;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGeraFracaoOP]);
end.
