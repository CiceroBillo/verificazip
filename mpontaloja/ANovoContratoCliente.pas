unit ANovoContratoCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Mask,
  Localizacao, ComCtrls, Spin, numericos, Constantes, UnDados, Grids,
  CGrades, DBKeyViolation, UnContrato, UnProdutos;

type
  TRBDColunaGradeServicos =(clCodServico,clDescServico,clDescAdicional,clQtd,clValUnitario, clValTotal);

  TFNovoContratoCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    ENumContrato: TEditColor;
    Label1: TLabel;
    ETipContrato: TEditLocaliza;
    Label2: TLabel;
    Label3: TLabel;
    EValContrato: Tnumerico;
    Label4: TLabel;
    EQtdMeses: TSpinEditColor;
    Label5: TLabel;
    EDatAssinatura: TCalendario;
    Label6: TLabel;
    ECodVendedor: TEditLocaliza;
    Label9: TLabel;
    Label17: TLabel;
    SpeedButton1: TSpeedButton;
    ConsultaPadrao1: TConsultaPadrao;
    EDatCancelamento: TMaskEditColor;
    SpeedButton2: TSpeedButton;
    Label10: TLabel;
    ValidaGravacao1: TValidaGravacao;
    EServico: TEditLocaliza;
    Label11: TLabel;
    SpeedButton3: TSpeedButton;
    Label12: TLabel;
    ECondicaoPagamento: TEditLocaliza;
    Label13: TLabel;
    SpeedButton4: TSpeedButton;
    ETextoAdicional: TComboBoxColor;
    Label15: TLabel;
    Label16: TLabel;
    EPeriodicidade: TComboBoxColor;
    Label18: TLabel;
    ENotaCupom: TEditColor;
    PManutencaoImpressora: TPanelColor;
    EQtdFranquia: TSpinEditColor;
    Label7: TLabel;
    Label8: TLabel;
    EValExcedenteFranquia: Tnumerico;
    ECodTecnicoLeitura: TEditLocaliza;
    Label19: TLabel;
    SpeedButton5: TSpeedButton;
    Label20: TLabel;
    ENomContato: TEditColor;
    Label21: TLabel;
    Label22: TLabel;
    ECodFormaPagamento: TEditLocaliza;
    Label14: TLabel;
    SpeedButton6: TSpeedButton;
    Label23: TLabel;
    EContaBancaria: TEditLocaliza;
    Label24: TLabel;
    SpeedButton7: TSpeedButton;
    Label25: TLabel;
    EValDesconto: Tnumerico;
    lValDesconto: TLabel;
    Label26: TLabel;
    EDatUltimaExecucao: TMaskEditColor;
    CProcessaAutomatico: TCheckBox;
    BitBtn2: TBitBtn;
    EDiaLeitura: Tnumerico;
    Label27: TLabel;
    EQtdFranquiaColorida: TSpinEditColor;
    Label28: TLabel;
    Label29: TLabel;
    EValExcedenteColorido: Tnumerico;
    Label30: TLabel;
    EPreposto: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    Label31: TLabel;
    EComissaoVendedor: Tnumerico;
    Label32: TLabel;
    EComissaoPreposto: Tnumerico;
    Label33: TLabel;
    ScrollBox1: TScrollBox;
    PanelColor3: TPanelColor;
    EEmail: TEditColor;
    Label34: TLabel;
    Label35: TLabel;
    Shape1: TShape;
    Label36: TLabel;
    Shape2: TShape;
    Label37: TLabel;
    EInicioVigencia: TCalendario;
    Label38: TLabel;
    EFimVigencia: TCalendario;
    PPaginas: TPageControl;
    PProdutos: TTabSheet;
    Grade: TRBStringGridColor;
    PServicos: TTabSheet;
    GradeServicos: TRBStringGridColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ETipContratoCadastrar(Sender: TObject);
    procedure ECodVendedorCadastrar(Sender: TObject);
    procedure ENumContratoChange(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EServicoSelect(Sender: TObject);
    procedure EServicoCadastrar(Sender: TObject);
    procedure ECodTecnicoLeituraCadastrar(Sender: TObject);
    procedure EContaBancariaSelect(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure ECodFormaPagamentoRetorno(Retorno1, Retorno2: String);
    procedure GradeGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GradeCellClick(Button: TMouseButton; Shift: TShiftState;
      VpaColuna, VpaLinha: Integer);
    procedure EQtdMesesExit(Sender: TObject);
    procedure GradeServicosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeServicosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GradeServicosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GradeServicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeServicosKeyPress(Sender: TObject; var Key: Char);
    procedure GradeServicosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeServicosNovaLinha(Sender: TObject);
    procedure GradeServicosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    VprProdutoAnterior : string;
    VprCodCliente : Integer;
    VprAcao : Boolean;
    VprOperacaoCadastro : TRBDOperacaoCadastro;
    VprDContrato : TRBDContratoCorpo;
    VprDItem : TRBDContratoItem;
    FunContrato : TRBFuncoesContrato;
    VprDItemServico: TRBDContratoServico;
    VprServicoAnterior : String;
    procedure CarTitulosGrade;
    procedure InicializaClasse;
    procedure CarDTela;
    procedure CarDClasse;
    procedure CarDItemContrato;
    function ExisteProduto : Boolean;
    function LocalizaProduto : Boolean;
    function NumeroSerieValidos : String;
    function RColunaGradeServicos(VpaColuna : TRBDColunaGradeServicos):Integer;
    procedure CalculaValorTotalServico;
    function ExisteServico : Boolean;
    procedure CarDServicoContrato;
    function LocalizaServico : Boolean;
    procedure CalculaContrato;
  public
    { Public declarations }
    function NovoContrato(VpaCodCliente : Integer):Boolean;
    function AlteraContrato(VpaDContrato : TRBDContratoCorpo) : boolean;
    procedure ConsultaContrato(VpaDContrato : TRBDContratoCorpo);
  end;

var
  FNovoContratoCliente: TFNovoContratoCliente;

implementation

uses APrincipal, ATipoContrato, ANovoVendedor, FunData, FunString, constmsg,
  ALocalizaProdutos, ANovoServico, Funobjeto, ANovoTecnico, ALocalizaServico;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoContratoCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDContrato := TRBDContratoCorpo.cria;
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  PPaginas.ActivePage := PProdutos;
  Vpracao := false;
  CarTitulosGrade;
  Grade.ADados := VprDContrato.ItensContrato;
  Grade.CarregaGrade;
  GradeServicos.ADados:= VprDContrato.ServicoContrato;
  GradeServicos.CarregaGrade;
  PPaginas.ActivePage:= PProdutos;
  if not config.ManutencaoImpressoras then
  begin
    PManutencaoImpressora.Visible := false;
    PanelColor1.Height := PanelColor1.Height - PManutencaoImpressora.Height;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoContratoCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDContrato.free;
  FunContrato.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFNovoContratoCliente.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.ETipContratoCadastrar(Sender: TObject);
begin
  FTipoContrato := TFTipoContrato.CriarSDI(application,'', FPrincipal.VerificaPermisao('FTipoContrato'));
  FTipoContrato.BotaoCadastrar1.Click;
  FTipoContrato.showmodal;
  FTipoContrato.free;
  ConsultaPadrao1.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.ECodVendedorCadastrar(Sender: TObject);
begin
  FNovoVendedor := TFNovoVendedor.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoVendedor'));
  FNovoVendedor.CadVendedores.Insert;
  FNovoVendedor.showmodal;
  FNovoVendedor.free;
  ConsultaPadrao1.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Produto';
  Grade.Cells[3,0] := 'Número Série Produto';
  Grade.Cells[4,0] := 'Número Série Interno';
  Grade.Cells[5,0] := 'Contador Atual P/B';
  Grade.Cells[6,0] := 'Contador Atual Color.';
  Grade.Cells[7,0] := 'Setor Empresa';
  Grade.Cells[8,0] := 'Medidor Desativação P/B';
  Grade.Cells[9,0] := 'Medidor Desativação Color.';
  Grade.Cells[10,0] := 'Data Desativação';
  Grade.Cells[11,0] := 'Valor Custo Produto';

  GradeServicos.Cells[RColunaGradeServicos(clCodServico),0] := 'Código';
  GradeServicos.Cells[RColunaGradeServicos(clDescServico),0] := 'Descrição';
  GradeServicos.Cells[RColunaGradeServicos(clDescAdicional),0] := 'Descrição Adicional';
  GradeServicos.Cells[RColunaGradeServicos(clQtd),0] := 'Qtd';
  GradeServicos.Cells[RColunaGradeServicos(clValUnitario),0] := 'Val Unitário';
  GradeServicos.Cells[RColunaGradeServicos(clValTotal),0] := 'Valor Total';

end;

{******************************************************************************}
procedure TFNovoContratoCliente.InicializaClasse;
begin
  VprDContrato.free;
  VprDContrato := TRBDContratoCorpo.cria;
  Grade.ADados := VprDContrato.ItensContrato;
  Grade.CarregaGrade;
  GradeServicos.ADados:= VprDContrato.ServicoContrato;
  GradeServicos.CarregaGrade;
  VprDContrato.CodCliente := VprCodCliente;
  VprDContrato.CodFilial := varia.codigoEmpfil;
  VprDContrato.QtdMeses := 12;
  VprDContrato.DatAssinatura := date;
  VprDContrato.DatInicioVigencia := VprDContrato.DatAssinatura;
  VprDContrato.DatFimVigencia := IncMes(VprDContrato.DatInicioVigencia,VprDContrato.QtdMeses);
  VprDContrato.TipPeriodicidade := 0;
  VprDContrato.IndProcessamentoAutomatico := true;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.CarDTela;
begin
  ENumContrato.Text := VprDContrato.NumContrato;
  ETipContrato.AInteiro := VprDContrato.CodTipoContrato;
  ETipContrato.Atualiza;
  EValContrato.AValor := VprDContrato.ValContrato;
  EQtdMeses.Value := VprDContrato.QtdMeses;
  EDatAssinatura.DateTime := VprDContrato.DatAssinatura;
  EInicioVigencia.DateTime := VprDContrato.DatInicioVigencia;
  EFimVigencia.DateTime := VprDContrato.DatFimVigencia;
  if VprDContrato.DatUltimaExecucao > montadata(1,1,1950) then
    EDatUltimaExecucao.text := FormatDateTime('DD/MM/YYYY',VprDContrato.DatUltimaExecucao);
  if VprDContrato.DatCancelamento > montadata(1,1,1950) then
    EDatCancelamento.text := FormatDateTime('DD/MM/YYYY',VprDContrato.DatCancelamento);
  EQtdFranquia.Value := VprdContrato.QtdFranquia;
  EQtdFranquiaColorida.Value := VprDContrato.QtdFranquiaColorida;
  EValExcedenteFranquia.AValor := VprDContrato.ValExcedenteFranquia;
  EValExcedenteColorido.Avalor := VprDContrato.ValExcedenteColorido;
  EServico.AInteiro := VprDContrato.CodServico;
  EServico.Atualiza;
  ECodVendedor.AInteiro := VprDContrato.CodVendedor;
  ECodVendedor.Atualiza;
  EPreposto.AInteiro := VprDContrato.CodPreposto;
  Epreposto.Atualiza;
  ECodVendedor.Atualiza;
  ECondicaoPagamento.AInteiro := VprDContrato.CodCondicaoPagamento;
  ECondicaoPagamento.Atualiza;
  ECodFormaPagamento.AInteiro := VprDContrato.CodFormaPagamento;
  ECodFormaPagamento.Atualiza;
  EContaBancaria.Text := VprDContrato.NumContaBancaria;
  EContaBancaria.Atualiza;
  ETextoAdicional.ItemIndex := VprDContrato.NumTextoServico;
  ENotaCupom.Text := VprDContrato.NotaFiscalCupom;
  EPeriodicidade.ItemIndex := VprDContrato.TipPeriodicidade;
  ENomContato.Text := VprDContrato.NomContato;
  ECodTecnicoLeitura.AInteiro := VprDContrato.CodTecnicoLeitura;
  ECodTecnicoLeitura.Atualiza;
  EValDesconto.AValor := VprDContrato.ValDesconto;
  EDiaLeitura.AsInteger := VprDContrato.NumDiaLeitura;
  CProcessaAutomatico.Checked := VprDContrato.IndProcessamentoAutomatico;
  EComissaoVendedor.Avalor := VprDContrato.PerComissao;
  EComissaoPreposto.AValor := VprDContrato.PerComissaoPreposto;
  EEmail.Text := VprDContrato.desEmail;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.CalculaContrato;
begin
  if VprOperacaoCadastro in [ocInsercao,ocEdicao] then
  begin
    CarDClasse;
    FunContrato.CalculaContrato(VprDContrato);
    EValContrato.AValor:= VprDContrato.ValTotalServico;
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.CalculaValorTotalServico;
begin
  if (VprDItemServico.ValUnitario = 0) and (VprDItemServico.ValTotal <> 0) then
    VprDItemServico.ValUnitario := VprDItemServico.ValTotal / VprDItemServico.QtdServico
  else
    VprDItemServico.ValTotal := VprDItemServico.ValUnitario * VprDItemServico.QtdServico;
  GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha] := FormatFloat(varia.MascaraQtd,VprDItemServico.QtdServico);
  GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha] := FormatFloat('###,###,###,##0.0000',VprDItemServico.ValUnitario);
  GradeServicos.Cells[RColunaGradeServicos(clValTotal),GradeServicos.ALinha] := FormatFloat(Varia.MascaraValor,VprDItemServico.ValTotal);
end;

{******************************************************************************}
procedure TFNovoContratoCliente.CarDClasse;
begin
  VprDContrato.NumContrato := ENumContrato.Text;
  VprDContrato.CodTipoContrato := ETipContrato.AInteiro;
  VprDContrato.ValContrato := EValContrato.AValor;
  VprDContrato.QtdMeses := EQtdMeses.Value;
  VprDContrato.DatAssinatura := EDatAssinatura.DateTime;
  if DeletaChars(DeletaChars(EDatCancelamento.Text,'/'),' ') <> '' then
    VprDContrato.DatCancelamento := StrToDate(EDatCancelamento.text)
  else
    VprDContrato.DatCancelamento := 0;
  if DeletaChars(DeletaChars(EDatUltimaExecucao.Text,'/'),' ') <> '' then
    VprDContrato.DatUltimaExecucao := StrToDate(EDatUltimaExecucao.text);
  VprdContrato.QtdFranquia := EQtdFranquia.Value;
  VprDContrato.DatInicioVigencia := EInicioVigencia.Date;
  VprDContrato.DatFimVigencia := EFimVigencia.Date;
  VprDContrato.QtdFranquiaColorida := EQtdFranquiaColorida.Value;
  VprDContrato.ValExcedenteFranquia := EValExcedenteFranquia.AValor;
  VprDContrato.ValExcedenteColorido := EValExcedenteColorido.AValor;
  VprDContrato.CodServico :=  EServico.AInteiro;
  VprDContrato.CodVendedor := ECodVendedor.AInteiro;
  VprDContrato.CodPreposto := EPreposto.AInteiro;
  VprDContrato.CodCondicaoPagamento := ECondicaoPagamento.AInteiro;
  VprDContrato.CodFormaPagamento := ECodFormaPagamento.AInteiro;
  VprDContrato.NumContaBancaria := EContaBancaria.text;
  VprDContrato.NumTextoServico := ETextoAdicional.ItemIndex;
  VprDContrato.TipPeriodicidade := EPeriodicidade.ItemIndex;
  VprDContrato.NotaFiscalCupom := ENotaCupom.Text;
  VprDContrato.NomContato := ENomContato.Text;
  VprDContrato.CodTecnicoLeitura := ECodTecnicoLeitura.AInteiro;
  VprDContrato.ValDesconto := EValDesconto.avalor;
  VprDContrato.NumDiaLeitura := EDiaLeitura.AsInteger;
  VprDContrato.IndProcessamentoAutomatico := CProcessaAutomatico.Checked;
  VprDContrato.PerComissao := EComissaoVendedor.AValor;
  VprDContrato.PerComissaoPreposto := EComissaoPreposto.AValor;
  VprDContrato.DesEmail := EEmail.Text;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.CarDServicoContrato;
begin
  VprDItemServico.CodServico := StrToInt(GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.Alinha]);
  if config.PermiteAlteraNomeProdutonaCotacao then
    VprDItemServico.NomServico := GradeServicos.Cells[RColunaGradeServicos(clDescServico),GradeServicos.ALinha];
  VprDItemServico.DesAdicional := GradeServicos.Cells[RColunaGradeServicos(clDescAdicional),GradeServicos.ALinha];
  VprDItemServico.QtdServico := StrToFloat(DeletaChars(GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha],'.'));
  VprDItemServico.ValUnitario := StrToFloat(DeletaChars(GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha],'.'));
  CalculaValorTotalServico;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.CarDItemContrato;
var
  VpfData : String;
begin
  VprDItem.CodProduto := Grade.Cells[1,Grade.Alinha];
  VprDItem.NumSerieProduto := Grade.Cells[3,Grade.ALinha];
  VprDItem.NumSerieInterno := Grade.Cells[4,Grade.ALinha];
  if Grade.Cells[5,Grade.ALinha] <> '' then
    VprDItem.QtdUltimaLeitura := StrToInt(DeletaChars(Grade.Cells[5,Grade.ALinha],'.'))
  else
    VprDItem.QtdUltimaLeitura := 0;
  if Grade.Cells[6,Grade.ALinha] <> '' then
    VprDItem.QtdUltimaLeituraColor := StrToInt(DeletaChars(Grade.Cells[6,Grade.ALinha],'.'))
  else
    VprDItem.QtdUltimaLeituraColor := 0;
  VprDItem.DesSetorEmpresa := Grade.Cells[7,Grade.ALinha];
  if Grade.Cells[8,Grade.ALinha] <> '' then
    VprDItem.QtdLeituraDesativacao := StrtoInt(DeletaChars(Grade.Cells[8,Grade.ALinha],'.'))
  else
    VprDItem.QtdLeituraDesativacao := 0;
  if Grade.Cells[9,Grade.ALinha] <> '' then
    VprDItem.QtdLeituraDesativacaoColor := StrtoInt(DeletaChars(Grade.Cells[9,Grade.ALinha],'.'))
  else
    VprDItem.QtdLeituraDesativacaoColor := 0;
  if Grade.Cells[10,Grade.ALinha] <> '' then
  begin
    try
      VpfData := Grade.Cells[10,Grade.ALinha];
      if VpfData[9] = ' ' then
      begin
        VpfData := copy(VpfData,1,6)+'20'+ copy(VpfData,7,2);
        Grade.Cells[10,Grade.ALinha] := VpfData;
      end;
      VprDItem.DatDesativacao := MontaData(StrToInt(Copy(Grade.Cells[10,Grade.ALinha],1,2)),StrToInt(Copy(Grade.Cells[10,Grade.ALinha],4,2)),StrToInt(Copy(Grade.Cells[10,Grade.ALinha],7,4)))
    except
      VprDItem.DatDesativacao :=MontaData(01,01,1950);
    end;
 end
  else
    VprDItem.DatDesativacao := MontaData(01,01,1950);
  VprDItem.ValCustoProduto := StrToFloat(Grade.Cells[11,Grade.ALinha]);
end;

{******************************************************************************}
function TFNovoContratoCliente.ExisteProduto : Boolean;
var
  VpfCodProduto, vpfNomProduto : String;
  VpfseqProduto : Integer;
begin
  if (Grade.Cells[1,Grade.ALinha] <> '') then
  begin
    if Grade.Cells[1,Grade.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      VpfCodProduto := Grade.Cells[1,Grade.ALinha];
      result := FunProdutos.ExisteCodigoProduto(VpfSeqProduto,VpfCodProduto,VpfNomProduto);
      if result then
      begin
        VprDItem.SeqProduto := VpfseqProduto;
        Grade.Cells[1,Grade.ALinha] := VpfCodProduto;
        VprProdutoAnterior := VpfCodProduto;
        VprDItem.SeqProduto := VpfseqProduto;
        Grade.Cells[2,Grade.ALinha] := vpfNomProduto;
        VprDItem.CodProduto := VpfCodProduto;
        VprDItem.NomProduto := vpfNomProduto;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovoContratoCliente.ExisteServico: Boolean;
begin
 if (GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha] <> '') then
  begin
    if (GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha] = VprServicoAnterior)  then
      result := true
    else
    begin
      result := FunContrato.ExisteServico(GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha],VprDContrato,VprDItemServico);
      if result then
      begin
        VprServicoAnterior := GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha];
        GradeServicos.Cells[RColunaGradeServicos(clDescServico),GradeServicos.Alinha] := VprDItemServico.NomServico;
        GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha] :=  FormatFloat(varia.MascaraQtd,VprDItemServico.QtdServico);
        GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha] :=  FormatFloat(varia.MascaraValorUnitario,VprDItemServico.ValUnitario);
        //if VprDNotaFor.IndCalculaISS then
        //begin
        //  if VprDServicoNota.PerISSQN <> 0 then
        //    EPerISSQN.AValor := VprDServicoNota.PerISSQN
        //  else
        //    EPerISSQN.AValor := VprPerISSQN;
        //end;
        CalculaValorTotalServico;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovoContratoCliente.LocalizaProduto : Boolean;
var
  VpfCadastrou : boolean;
  VpfSeqProduto : Integer;
  VpfCodProduto,VpfNomProduto: String;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VpfCadastrou,VpfSeqProduto,VpfCodProduto,VpfNomProduto);
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    VprProdutoAnterior := VpfCodProduto;
    Grade.Cells[1,Grade.ALinha] := VpfCodProduto;
    Grade.Cells[2,Grade.ALinha] := VpfNomProduto;
    VprDItem.CodProduto := VpfCodProduto;
    VprDItem.NomProduto := VpfNomProduto;
    VprDItem.SeqProduto := VpfSeqProduto;
  end;
end;

{******************************************************************************}
function TFNovoContratoCliente.LocalizaServico: Boolean;
begin
  FlocalizaServico := TFlocalizaServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaServico'));
  result := FlocalizaServico.LocalizaServico(VprDItemServico);
  FlocalizaServico.free; // destroi a classe;

  if result then  // se o usuario nao cancelou a consulta
  begin
    VprDItemServico.QtdServico := 1;
    GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha] := IntToStr(VprDItemServico.CodServico);
    GradeServicos.Cells[RColunaGradeServicos(clDescServico),GradeServicos.ALinha] := VprDItemServico.NomServico;
    GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha] :=  FormatFloat(varia.mascaraQtd,VprDItemServico.QtdServico);
    GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha] :=  FormatFloat(varia.MascaraValorUnitario,VprDItemServico.ValUnitario);
    {if VprDNota.IndCalculaISS then
    begin
      if VprDServicoNota.PerISSQN <> 0 then
        EPerISSQN.AValor := VprDServicoNota.PerISSQN
      else
        EPerISSQN.AValor := VprPerISSQN;
    end;}
    CalculaValorTotalServico;
  end;
end;

{******************************************************************************}
function TFNovoContratoCliente.NovoContrato(VpaCodCliente : Integer):Boolean;
begin
  VprCodCliente := VpaCodCliente;
  VprOperacaoCadastro := ocInsercao;
  InicializaClasse;
  CarDTela;
  Showmodal;
  result := Vpracao;
end;

{******************************************************************************}
function TFNovoContratoCliente.NumeroSerieValidos: String;
begin
  if config.NumeroSerieObrigatorioNoContrato then
  begin
    result := FunContrato.NumeroSerieDuplicado(VprDContrato);
    if result <> '' then
      Grade.CarregaGrade;
  end;
end;

{******************************************************************************}
function TFNovoContratoCliente.AlteraContrato(VpaDContrato : TRBDContratoCorpo) : boolean;
begin
  VprCodCliente := VpaDContrato.CodCliente;
  VprOperacaoCadastro := ocEdicao;
  VprDContrato.free;
  VprDContrato := VpaDContrato;
  Grade.ADados := VpaDContrato.ItensContrato;
  Grade.CarregaGrade;
  GradeServicos.ADados:= VpaDContrato.ServicoContrato;
  GradeServicos.CarregaGrade;
  CarDTela;
  Showmodal;
  result := vprAcao;
end;

procedure TFNovoContratoCliente.ConsultaContrato(VpaDContrato : TRBDContratoCorpo);
begin
  AlterarEnabledDet([BGravar,BCancelar],false);
  VprCodCliente := VpaDContrato.CodCliente;
  PanelColor1.Enabled := false;
  VprOperacaoCadastro := ocConsulta;
  VprDContrato.free;
  VprDContrato := VpaDContrato;
  Grade.ADados := VpaDContrato.ItensContrato;
  Grade.CarregaGrade;
  GradeServicos.ADados:= VpaDContrato.ServicoContrato;
  GradeServicos.CarregaGrade;
  CarDTela;
  Showmodal;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.ENumContratoChange(Sender: TObject);
begin
  if VprOperacaoCadastro in [ocinsercao,ocedicao] then
    validagravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.EQtdMesesExit(Sender: TObject);
begin
  if VprOperacaoCadastro in [ocinsercao,ocedicao] then
  begin
    if VprDContrato.QtdMeses <> EQtdMeses.Value then
    begin
      EFimVigencia.Date := IncMes(EInicioVigencia.Date,EQtdMeses.Value);
      VprDContrato.QtdMeses := EQtdMeses.Value;
    end;
  end;

end;

procedure TFNovoContratoCliente.BGravarClick(Sender: TObject);
var
  vpfResultado : string;
begin
  if VprOperacaoCadastro in [ocinsercao,ocedicao] then
  begin
    vpfResultado := NumeroSerieValidos;
    if  vpfResultado = '' then
    begin
      CarDClasse;
      VpfResultado := FunContrato.GravaDContrato(VprDContrato);
    end;
    if VpfResultado = '' then
    begin
      VprAcao := true;
      close;
    end
    else
      aviso(vpfResultado);
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.BCancelarClick(Sender: TObject);
begin
  Vpracao := false;
  close;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin

  VprDItem := TRBDContratoItem(VprDContrato.ItensContrato.Items[vpaLinha-1]);
  Grade.Cells[1,VpaLinha] := VprDItem.CodProduto;
  Grade.Cells[2,VpaLinha] := VprDItem.NomProduto;
  Grade.Cells[3,VpaLinha] := VprDItem.NumSerieProduto;
  Grade.Cells[4,VpaLinha] := VprDItem.NumSerieInterno;
  Grade.Cells[5,VpaLinha] := FormatFloat('0',VprDItem.QtdUltimaLeitura);
  Grade.Cells[6,VpaLinha] := FormatFloat('0',VprDItem.QtdUltimaLeituraColor);
  Grade.Cells[7,VpaLinha] := VprDItem.DesSetorEmpresa;
  if VprDItem.QtdLeituraDesativacao <> 0 then
    Grade.Cells[8,VpaLinha] := FormatFloat('0',VprDItem.QtdLeituraDesativacao)
  else
    Grade.Cells[8,VpaLinha] := '';
  if VprDItem.QtdLeituraDesativacaoColor <> 0 then
    Grade.Cells[9,VpaLinha] := FormatFloat('0',VprDItem.QtdLeituraDesativacaoColor)
  else
    Grade.Cells[9,VpaLinha] := '';
  if VprDItem.DatDesativacao > MontaData(01,01,1970) then
    Grade.Cells[10,VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDItem.DatDesativacao)
  else
    Grade.Cells[10,VpaLinha] := '';
  Grade.Cells[11,VpaLinha] := FormatFloat('#,##0.00',VprDItem.ValCustoProduto);
end;

procedure TFNovoContratoCliente.GradeCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin

end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeDadosValidos(Sender: TObject;
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
      if ((Grade.Cells[3,Grade.ALinha]) = '') and (config.NumeroSerieObrigatorioNoContrato)  then
      begin
        VpaValidos := false;
        aviso('NUMERO DE SÉRIE NÃO PREENCHIDO!!!'#13'É necessário digitar o número de série do produto');
        Grade.Col := 3;
      end
      else
        if (Grade.Cells[10,Grade.ALinha]) <> '' then
          try
            if not ValidaData(StrToInt(Copy(Grade.Cells[10,Grade.ALinha],1,2)),StrToInt(Copy(Grade.Cells[10,Grade.ALinha],4,2)),StrToInt(Copy(Grade.Cells[10,Grade.ALinha],7,4))) then
            begin
              aviso(CT_DATADESATIVACAOINVALIDA);
              VpaValidos := false;
              Grade.Col := 10;
            end;
          except
            aviso(CT_DATADESATIVACAOINVALIDA);
            VpaValidos := false;
            Grade.Col := 10;
          end;

  if Vpavalidos then
  begin
    CarDItemContrato;
    if (VprDItem.QtdLeituraDesativacao <> 0) then
      if ((VprDItem.QtdLeituraDesativacao - VprDItem.QtdUltimaLeitura) < 0) then
      begin
        aviso('QUANTIDADE MEDIDOR DESATIVAÇÃO INVÁLIDO!!!'#13'A quantidade digitada no medido de desativação não pode ser menor que o da última leitura.');
        VpaValidos := false;
      end;
  end;
  if VpaValidos then
  begin
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case Grade.AColuna of
        1: LocalizaProduto;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDContrato.ItensContrato.Count >0 then
  begin
    VprDItem := TRBDContratoItem(VprDContrato.ItensContrato.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDItem.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeNovaLinha(Sender: TObject);
begin
  VprDItem := VprDContrato.addItemContrato;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeSelectCell(Sender: TObject; ACol,
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
      end;
    end;

end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeServicosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItemServico := TRBDContratoServico(VprDContrato.ServicoContrato.Items[VpaLinha-1]);
  if VprDItemServico.CodServico <> 0 then
    GradeServicos.Cells[RColunaGradeServicos(clCodServico),VpaLinha] := IntToStr(VprDItemServico.CodServico)
  else
    GradeServicos.Cells[RColunaGradeServicos(clCodServico),VpaLinha] := '';
  GradeServicos.Cells[RColunaGradeServicos(clDescServico),VpaLinha] := VprDItemServico.NomServico;
  GradeServicos.Cells[RColunaGradeServicos(clDescAdicional),VpaLinha] := VprDItemServico.DesAdicional;
  GradeServicos.Cells[RColunaGradeServicos(clQtd),VpaLinha] := FormatFloat(Varia.MascaraQtd,VprDItemServico.QtdServico);
  GradeServicos.cells[RColunaGradeServicos(clValUnitario),VpaLinha] := FormatFloat(Varia.MascaraValorUnitario,VprDItemServico.ValUnitario);
  GradeServicos.Cells[RColunaGradeServicos(clValTotal),VpaLinha] := FormatFloat(Varia.MascaraValor,VprDItemServico.ValTotal);
  CalculaValorTotalServico;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeServicosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := false;
  if not ExisteServico then
  begin
    GradeServicos.col := RColunaGradeServicos(clCodServico);
    aviso('SERVIÇO NÃO PREENCHIDO!!!'#13'É necessário preencher o código do serviço.');
  end
  else
    if GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha] = '' then
    begin
      GradeServicos.col := RColunaGradeServicos(clQtd);
      Aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do serviço.');
    end
    else
      if GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha] = '' then
      begin
        GradeServicos.col := RColunaGradeServicos(clValUnitario);
        aviso('VALOR UNITÁRIO INVÁLIDO!!!'#13'É necessário preencher o valor unitário do serviço.');
     end
      else
        VpaValidos := true;
  if VpaValidos then
  begin
    CarDServicoContrato;
    CalculaContrato;

    if VprDItemServico.QtdServico = 0 then
    begin
      VpaValidos := false;
      GradeServicos.col := RColunaGradeServicos(clQtd);
      Aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do serviço.');
    end
    else
      if VprDItemServico.ValUnitario = 0 then
      begin
        VpaValidos := false;
        GradeServicos.col := RColunaGradeServicos(clValUnitario);
        aviso('VALOR UNITÁRIO INVÁLIDO!!!'#13'É necessário preencher o valor unitário do serviço.');
      end;
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeServicosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  case ACol of
    1 :  Value := '0000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeServicosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GradeServicos.Col of
        1 :  LocalizaServico;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeServicosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = '.')  then
  key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeServicosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDContrato.ServicoContrato.Count >0 then
  begin
    VprDItemServico := TRBDContratoServico(VprDContrato.ServicoContrato.Items[VpaLinhaAtual-1]);
    VprServicoAnterior := InttoStr(VprDItemServico.CodServico);
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeServicosNovaLinha(Sender: TObject);
begin
  VprDItemServico:= VprDContrato.addServicoContrato;
  VprServicoAnterior := '-10';
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeServicosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   if GradeServicos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GradeServicos.AColuna <> ACol then
    begin
      case GradeServicos.AColuna of
        1 :if not ExisteServico then
           begin
             if not LocalizaServico then
             begin
               GradeServicos.Cells[RColunaGradeServicos(clCodServico),GradeServicos.ALinha] := '';
               GradeServicos.Col := RColunaGradeServicos(clCodServico);
             end;
           end;
        4,5 :
             begin
               if GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha] <> '' then
                 VprDItemServico.QtdServico := StrToFloat(DeletaChars(GradeServicos.Cells[RColunaGradeServicos(clQtd),GradeServicos.ALinha],'.'))
               else
                 VprDItemServico.QtdServico := 0;
               if GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha] <> '' then
                 VprDItemServico.ValUnitario := StrToFloat(DeletaChars(GradeServicos.Cells[RColunaGradeServicos(clValUnitario),GradeServicos.ALinha],'.'))
               else
                 VprDItemServico.ValUnitario := 0;
               CalculaValorTotalServico;
             end;
      end;
    end;
end;

{******************************************************************************}
function TFNovoContratoCliente.RColunaGradeServicos(
  VpaColuna: TRBDColunaGradeServicos): Integer;
begin
  case VpaColuna of
    clCodServico: result:=1;
    clDescServico: result:=2 ;
    clDescAdicional: result:=3;
    clQtd: result:=4;
    clValUnitario: result:=5;
    clValTotal: result:=6;
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.EServicoSelect(Sender: TObject);
begin
 EServico.ASelectLocaliza.Text := 'Select * from CADSERVICO '+
                                  ' Where C_NOM_SER like ''@%'''+
                                  ' AND I_COD_EMP = '+ InttoStr(varia.CodigoEmpresa)+
                                  ' order by C_NOM_SER ';
 EServico.ASelectValida.Text := 'Select * from CADSERVICO '+
                                  ' Where I_COD_SER = @ '+
                                  ' AND I_COD_EMP = '+ InttoStr(varia.CodigoEmpresa)+
                                  ' order by C_NOM_SER ';
end;

{******************************************************************************}
procedure TFNovoContratoCliente.EServicoCadastrar(Sender: TObject);
var
  VpfCodServico, VpfNomServico : String;
begin
  FNovoServico := TFNovoServico.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoServico'));
  FNovoServico.InsereNovoServico('',VpfCodServico,VpfNomServico,true);
  FNovoServico.free;
  ConsultaPadrao1.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.ECodTecnicoLeituraCadastrar(
  Sender: TObject);
begin
  FNovoTecnico := TFNovoTecnico.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoTecnico'));
  FNovoTecnico.Tecnico.Insert;
  FNovoTecnico.showmodal;
  FNovoTecnico.free;
  ConsultaPadrao1.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.EContaBancariaSelect(Sender: TObject);
begin
  EContaBancaria.ASelectValida.Text := 'Select * from CADCONTAS CON, CADBANCOS BAN '+
                                       ' Where CON.I_EMP_FIL = '+ IntTostr(VprDContrato.CodFilial)+
                                       ' and CON.C_NRO_CON = ''@'''+
                                       ' AND C_IND_ATI = ''T'''+
                                       ' AND CON.I_COD_BAN = BAN.I_COD_BAN ';
  EContaBancaria.ASelectLocaliza.Text := 'Select * from CADCONTAS CON, CADBANCOS BAN '+
                                       ' Where CON.I_EMP_FIL = '+ IntTostr(VprDContrato.CodFilial)+
                                       ' and CON.C_NOM_CRR LIKE ''@%'''+
                                       ' AND CON.I_COD_BAN = BAN.I_COD_BAN '+
                                       ' AND C_IND_ATI = ''T'''+
                                       ' order by CON.C_NOM_CRR';
end;

{******************************************************************************}
procedure TFNovoContratoCliente.BitBtn2Click(Sender: TObject);
begin
  EDatCancelamento.Clear;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  VpfDItem : TRBDContratoItem;
begin
  if (ARow > 0) and (Acol > 0) then
  begin
    if VprDContrato.ItensContrato.Count >0 then
    begin
      VpfDItem := TRBDContratoItem(VprDContrato.ItensContrato.Items[arow-1]);
      if VpfDItem.DatDesativacao > MontaData(1,1,1950) then
        ABrush.Color := $008080FF;
      if VpfDItem.IndNumeroSerieDuplicado then
        ABrush.Color := clYellow;

    end;
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    10 :  Value := '!99/00/0000;1;_';
  end;
end;

{******************************************************************************}
procedure TFNovoContratoCliente.ECodFormaPagamentoRetorno(Retorno1,
  Retorno2: String);
begin
  if VprOperacaoCadastro in [ocinsercao,ocedicao] then
  begin
    EContaBancaria.ACampoObrigatorio := Retorno1 = 'B';
    ValidaGravacao1.execute;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoContratoCliente]);
end.








