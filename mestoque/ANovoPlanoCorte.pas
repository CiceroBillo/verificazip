unit ANovoPlanoCorte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, UnDadosProduto,
  StdCtrls, Localizacao, Mask, numericos, Buttons, UnOrdemProducao, DBKeyViolation, Constantes;

type
  TFNovoPlanoCorte = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TRBStringGridColor;
    Localiza: TConsultaPadrao;
    Label7: TLabel;
    Label15: TLabel;
    SpeedButton6: TSpeedButton;
    Label16: TLabel;
    EPlanoCorte: Tnumerico;
    EFilial: TEditLocaliza;
    EDatEmissao: TEditColor;
    Label1: TLabel;
    BAdicionar: TBitBtn;
    BCancelar: TBitBtn;
    BGravar: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    ENumCNC: Tnumerico;
    Label2: TLabel;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    LMateriaPrima: TLabel;
    EMateriaPrima: TEditColor;
    ValidaGravacao1: TValidaGravacao;
    EPerUtilizacaoChapa: Tnumerico;
    Label3: TLabel;
    EChapa: TEditColor;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    CPecaAvulsa: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BAdicionarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure BGravarClick(Sender: TObject);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BCancelarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GradeAntesExclusao(Sender: TObject; var VpaPermiteExcluir: Boolean);
    procedure GradeDepoisExclusao(Sender: TObject);
    procedure EMateriaPrimaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure EMateriaPrimaChange(Sender: TObject);
    procedure EMateriaPrimaExit(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    VprOperacao :  TRBDOperacaoCadastro;
    VprAcao : Boolean;
    VprDPlanoCorte : TRBDPlanoCorteCorpo;
    VprDItemPlanoCorte : TRBDPlanoCorteItem;
    procedure CarTitulosGrade;
    procedure InicilizaTela;
    procedure CarDTela;
    procedure EstadoBotoes(VpaEstado : Boolean);
    function DadosValidos : String;
    procedure CarDClasse;
    procedure CancelaPlanoCorte;
    function DadosAcoValidos : boolean;
    function LocalizaMateriaPrima : Boolean;
    function ExisteMateriaPrima : Boolean;
  public
    { Public declarations }
    function NovoPlanoCorte : Boolean;
  end;

var
  FNovoPlanoCorte: TFNovoPlanoCorte;

implementation

uses APrincipal, FunObjeto,  ConstMsg, ALocalizaFracaoOP, ALocalizaProdutos, UnProdutos, ANovaNotaFiscaisFor,
  AMostraEstoqueChapas;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoPlanoCorte.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTitulosGrade;
  VprDPlanoCorte := TRBDPlanoCorteCorpo.cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoPlanoCorte.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDPlanoCorte.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoPlanoCorte.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'ID';
  Grade.Cells[2,0] := 'Quantidade';
  Grade.Cells[3,0] := 'Código';
  Grade.Cells[4,0] := 'Produto';

end;

{******************************************************************************}
procedure TFNovoPlanoCorte.InicilizaTela;
begin
  LimpaComponentes(PanelColor1,0);
  VprDPlanoCorte.free;
  VprDPlanoCorte := TRBDPlanoCorteCorpo.cria;
  Grade.ADados := VprDPlanoCorte.Itens;
  Grade.CarregaGrade;
  with VprDPlanoCorte do
  begin
    CodFilial := varia.CodigoEmpFil;
    DatEmissao := now;
    SeqPlanoCorte := 0;
    CodUsuario := varia.CodigoUsuario;
  end;
  CarDTela;
  ActiveControl := EMateriaPrima;
  EstadoBotoes(true);
  ValidaGravacao1.execute;
end;

{******************************************************************************}
function TFNovoPlanoCorte.LocalizaMateriaPrima: Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.CriarSDI(self,'',true);
  result := FlocalizaProduto.LocalizaProduto(VprDPlanoCorte.SeqMateriaPrima,VprDPlanoCorte.CodMateriaPrima,VprDPlanoCorte.NomMateriaPrima,VprDPlanoCorte.DensidadeVolumetricaMP,VprDPlanoCorte.EspessuraChapaMP);
  FlocalizaProduto.Free;
  if result then
    result := DadosAcoValidos;
  if result then
  begin
    EMateriaPrima.Text := VprDPlanoCorte.CodMateriaPrima;
    LMateriaPrima.Caption := VprDPlanoCorte.NomMateriaPrima;
  end;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.CarDTela;
begin
  EFilial.AInteiro := VprDPlanoCorte.CodFilial;
  EFilial.Atualiza;
  EPlanoCorte.AsInteger := VprDPlanoCorte.SeqPlanoCorte;
  EDatEmissao.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS', VprDPlanoCorte.DatEmissao);
  ENumCNC.AsInteger := VprDPlanoCorte.NumCNC;
  EMateriaPrima.Text := VprDPlanoCorte.CodMateriaPrima;
  LMateriaPrima.Caption := VprDPlanoCorte.NomMateriaPrima;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.EMateriaPrimaChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    ValidaGravacao1.execute;
end;


{******************************************************************************}
procedure TFNovoPlanoCorte.EMateriaPrimaExit(Sender: TObject);
begin
  ExisteMateriaPrima;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.EMateriaPrimaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key  of
    VK_F3 : LocalizaMateriaPrima;
  end;
end;

procedure TFNovoPlanoCorte.EstadoBotoes(VpaEstado : Boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BAdicionar.Enabled := VpaEstado;
  BImprimir.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
function TFNovoPlanoCorte.ExisteMateriaPrima: Boolean;
begin
  result := true;
  if EMateriaPrima.Text <> '' then
  begin
    result := FunProdutos.ExisteProduto(EMateriaPrima.Text,VprDPlanoCorte.SeqMateriaPrima,VprDPlanoCorte.NomMateriaPrima,VprDPlanoCorte.DensidadeVolumetricaMP,VprDPlanoCorte.EspessuraChapaMP);
    if result then
      LMateriaPrima.Caption := VprDPlanoCorte.NomMateriaPrima
    else
      result := LocalizaMateriaPrima;
    if result  then
    begin
      result := DadosAcoValidos;
    end;

  end;
  if not result  then
  begin
    EMateriaPrima.Clear;
    LMateriaPrima.Caption := '';
  end;


end;

{******************************************************************************}
function TFNovoPlanoCorte.DadosAcoValidos: boolean;
begin
  result := true;
  if (VprDPlanoCorte.DensidadeVolumetricaMP = 0) then
  begin
    aviso('DENSIDADE VOLUMÉTRICA NÃO PREENCHIDA!!!'#13'É necessário preencher a densidade volumetrica da materia prima.');
    result := false;
  end;
  if result then
  begin
    if (VprDPlanoCorte.EspessuraChapaMP = 0) then
    begin
      aviso('ESPESSURA AÇO NÃO PREENCHIDA!!!'#13'É necessário preencher a espessura da chapa de aço.');
      result := false;
    end;
  end;
end;

{******************************************************************************}
function TFNovoPlanoCorte.DadosValidos : String;
var
  VpfLaco : Integer;
  VpfDItemPlanoCorte : TRBDPlanoCorteItem;
begin
  result := '';
  if VprDPlanoCorte.Itens.Count = 0 then
    result := 'NENHUM PRODUTO FOI ADICIONADO!!!'#13+'É necessário adicionar pelo menos 1 produto';
  if result = '' then
  begin
    for VpfLaco := 0 to VprDPlanoCorte.Itens.Count - 1 do
    begin
      VpfDItemPlanoCorte := TRBDPlanoCorteItem(VprDPlanoCorte.Itens[VpfLaco]);
      if VpfDItemPlanoCorte.SeqIdentificacao = 0 then
        result := 'IDENTIFICAÇÃO NÃO PREENCHIDA!!!'#13'É necessário preencher a identificação de todos os produtos.';
    end;
  end;
  if Result = '' then
  begin
    if CPecaAvulsa.Checked then
    begin
      if EPerUtilizacaoChapa.AValor <> 0 then
        Result :='PERCENTUAL UTILIZAÇÃO DA CHAPA NÃO PODE SER PREENCHIDO!!!'#13'Não é permitido preencher o percentual de utilização da chapa quando a peça é avulsa.';
      if VprDPlanoCorte.SeqChapa <> 0 then
        Result :='A CHAPA NÃO PODE SER PREENCHIDO!!!'#13'Não é permitido preencher a chapa quando a peça é avulsa.';
    end
    else
    begin
      if EPerUtilizacaoChapa.AValor = 0 then
        Result :='PERCENTUAL UTILIZAÇÃO DA CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher o percentual de utilização da chapa';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.CarDClasse;
begin
  VprDPlanoCorte.NumCNC := ENumCNC.AsInteger;
  VprDPlanoCorte.PerChapa := EPerUtilizacaoChapa.AValor;
  VprDPlanoCorte.SeqChapa := EChapa.AInteiro;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.CancelaPlanoCorte;
begin
  FunOrdemProducao.ExtornaPlanoCortecomImpresso(VprDPlanoCorte);
end;

{******************************************************************************}
function TFNovoPlanoCorte.NovoPlanoCorte : Boolean;
begin
  VprOperacao := ocInsercao;
  InicilizaTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.SpeedButton1Click(Sender: TObject);
begin
  FMostraEstoqueChapas := TFMostraEstoqueChapas.CriarSDI(self,'',true);
  FMostraEstoqueChapas.MostraEstoqueChapasProduto(VprDPlanoCorte.SeqMateriaPrima,VprDPlanoCorte);
  FMostraEstoqueChapas.Free;
  EChapa.AInteiro := VprDPlanoCorte.SeqChapa;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.SpeedButton2Click(Sender: TObject);
begin
  LocalizaMateriaPrima;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.BAdicionarClick(Sender: TObject);
begin
  FLocalizaFracaoOP := TFLocalizaFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FLocalizaFracaoOP'));
  FLocalizaFracaoOP.LocalizaFracao(VprDPlanoCorte);
  FLocalizaFracaoOP.free;
  Grade.CarregaGrade;
  Grade.Row := 1;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.GradeAntesExclusao(Sender: TObject; var VpaPermiteExcluir: Boolean);
var
  VpfDPlanoItem : TRBDPlanoCorteItem;
  VpfDFracao : TRBDPlanoCorteFracao;
  VpfLaco : Integer;
begin
  VpfDPlanoItem := TRBDPlanoCorteItem(VprDPlanoCorte.Itens[Grade.ALinha -1]);
  for VpfLaco := 0 to VpfDPlanoItem.Fracoes.Count - 1 do
  begin
    VpfDFracao := TRBDPlanoCorteFracao(VpfDPlanoItem.Fracoes[VpfLaco]);
    FunOrdemProducao.SetaPlanoCorteGerado(VpfDFracao.CodFilial,VpfDFracao.SeqOrdem,VpfDFracao.SeqFracao,false);
  end;
end;

procedure TFNovoPlanoCorte.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItemPlanoCorte := TRBDPlanoCorteItem(VprDPlanoCorte.Itens[VpaLinha-1]);
  if VprDItemPlanoCorte.SeqIdentificacao <> 0 then
    Grade.Cells[1,VpaLinha]:= IntToStr(VprDItemPlanoCorte.SeqIdentificacao)
  else
    Grade.Cells[1,VpaLinha]:= '';
  if VprDItemPlanoCorte.QtdProduto <> 0 then
    Grade.Cells[2,VpaLinha]:= IntToStr(VprDItemPlanoCorte.QtdProduto)
  else
    Grade.Cells[2,VpaLinha]:= '';
  Grade.Cells[3,VpaLinha]:= VprDItemPlanoCorte.CodProduto;
  Grade.Cells[4,VpaLinha]:= VprDItemPlanoCorte.NomProduto;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = '' then
  begin
    CarDClasse;
    VpfResultado := FunOrdemProducao.GravaDPlanoCorte(VprDPlanoCorte);
  end;
  if VpfResultado = '' then
  begin
    EstadoBotoes(false);
    EPlanoCorte.AsInteger := VprDPlanoCorte.SeqPlanoCorte;
    VprAcao := true;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if VprDPlanoCorte.Itens.Count > 0 then
  begin
    if Grade.Cells[1,Grade.ALinha] <> '' then
      VprDItemPlanoCorte.SeqIdentificacao := StrToInt(Grade.Cells[1,Grade.ALinha])
    else
      VprDItemPlanoCorte.SeqIdentificacao := 0;
  end;
end;

procedure TFNovoPlanoCorte.GradeDepoisExclusao(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoPlanoCorte.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDPlanoCorte.Itens.Count > 0 then
  begin
    VprDItemPlanoCorte:= TRBDPlanoCorteItem(VprDPlanoCorte.Itens[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.BCancelarClick(Sender: TObject);
begin
  CancelaPlanoCorte;
  close;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.BImprimirClick(Sender: TObject);
begin
  FunOrdemProducao.ImprimeEtiquetasPlanoCorte(VprDPlanoCorte);
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := true;
  if not VprAcao then
    BCancelar.Click; 
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoPlanoCorte]);
end.
