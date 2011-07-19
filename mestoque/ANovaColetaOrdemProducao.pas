unit ANovaColetaOrdemProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Grids,
  CGrades, Localizacao, Mask, numericos, UnDados, UnOrdemProducao,
  DBKeyViolation, UnDadosProduto;

type
  TFNovaColetaOrdemProducao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BCadastrar: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    EPedido: Tnumerico;
    ENroOPCliente: Tnumerico;
    Label29: TLabel;
    Label3: TLabel;
    ECliente: TEditLocaliza;
    Label7: TLabel;
    SpeedButton3: TSpeedButton;
    Label8: TLabel;
    EProduto: TEditLocaliza;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    EMaquina: TEditLocaliza;
    Label11: TLabel;
    SpeedButton5: TSpeedButton;
    Label12: TLabel;
    EQtdFitas: Tnumerico;
    Label20: TLabel;
    ENumeroOp: Tnumerico;
    Label1: TLabel;
    CFinal: TCheckBox;
    CReprogramacao: TCheckBox;
    EDatColeta: TEditColor;
    Bevel1: TBevel;
    Label2: TLabel;
    GColeta: TRBStringGridColor;
    ECodUsuario: TEditLocaliza;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    Label9: TLabel;
    ValidaGravacao1: TValidaGravacao;
    BImprimir: TBitBtn;
    CVisualizar: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EProdutoSelect(Sender: TObject);
    procedure GColetaGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure ENumeroOpExit(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure GColetaCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure ENumeroOpChange(Sender: TObject);
    procedure GColetaKeyPress(Sender: TObject; var Key: Char);
    procedure GColetaDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure BCadastrarClick(Sender: TObject);
    procedure GColetaMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GColetaEnter(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure GColetaGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure ENumeroOpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    VprOperacao : Integer;
    VprDColetaOP : TRBDColetaOP;
    VprDColetaItem : TRBDColetaOPItem;
    VprDOrdemProducao : TRBDOrdemProducaoEtiqueta;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure CarTitulosGrade;
    procedure CarDOPTela;
    procedure CarDColetaTela;
    procedure CarDClasse;
    procedure Cadastrar;
    procedure EnableBotaoCadastrar(VpaEstado : Boolean);
  public
    { Public declarations }
    procedure NovaColeta;
  end;

var
  FNovaColetaOrdemProducao: TFNovaColetaOrdemProducao;

implementation

uses APrincipal, Constantes, ConstMsg, FunObjeto, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaColetaOrdemProducao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
  VprDOrdemProducao := TRBDOrdemProducaoEtiqueta.cria;
  VprDColetaOP := TRBDColetaOP.Cria;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaColetaOrdemProducao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDColetaOP.free;
  VprDOrdemProducao.free;
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFNovaColetaOrdemProducao.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text := 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text := 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.CarTitulosGrade;
begin
  GColeta.Cells[1,0] := 'Combinação';
  GColeta.Cells[2,0] := 'Manequim';
  GColeta.Cells[3,0] := 'Nro Fitas';
  GColeta.Cells[4,0] := 'Qtd Coleta';
  GColeta.Cells[5,0] := 'Qtd a Produzir';
  GColeta.Cells[6,0] := 'Qtd Produzido';
  GColeta.Cells[7,0] := 'Saldo a Produzir';
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.CarDOPTela;
begin
  with VprDOrdemProducao do
  begin
    EPedido.AsInteger := NumPedido;
    ENroOPCliente.AsInteger := NroOPCliente;
    ECliente.AInteiro := CodCliente;
    ECliente.Atualiza;
    EMaquina.AInteiro := CodMaquina;
    EMaquina.Atualiza;
    EQtdFitas.AsInteger := QtdFita;
    EProduto.Text := CodProduto;
    EProduto.Atualiza;
  end;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.CarDColetaTela;
begin
  with VprDColetaOP do
  begin
    ENumeroOp.AsInteger := SeqOrdemProducao;
    EDatColeta.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS',DatColeta);
    CFinal.Checked := IndFinal;
    CReprogramacao.Checked := IndReprogramacao;
    ECodUsuario.AInteiro := CodUsuario;
    ECodUsuario.Atualiza;
  end;
  CarDOPTela;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.CarDClasse;
begin
  with VprDColetaOP do
  begin
    if config.EstoqueCentralizado then
      CodEmpresaFilial := varia.CodFilialControladoraEstoque
    else
      CodEmpresaFilial := Varia.CodigoEmpFil;
    SeqOrdemProducao := ENumeroOp.AsInteger;
    CodUsuario := ECodUsuario.AInteiro;
    IndFinal := CFinal.Checked;
    IndReprogramacao := CReprogramacao.Checked;
  end;
  FunOrdemProducao.AtualizaQtdMetrosColetadoOP(VprDColetaOP);
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.Cadastrar;
begin
  VprOperacao := 1;
  VprDColetaOP.Free;
  VprDOrdemProducao.free;
  VprDColetaOP := TRBDColetaOP.cria;
  VprDOrdemProducao := TRBDOrdemProducaoEtiqueta.cria;
  GColeta.ADados := VprDColetaOP.ItensColeta;
  GColeta.CarregaGrade;
  VprDColetaOP.DatColeta := now;
  VprDColetaOP.IndFinal := true;
  VprDColetaOP.IndReprogramacao := false;
  VprDColetaOP.IndGeradoRomaneio := false;
  VprDColetaOP.CodUsuario := varia.CodigoUsuario;
  CarDColetaTela;
  ActiveControl := ENumeroOp;
  EnableBotaoCadastrar(true);
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.EnableBotaoCadastrar(VpaEstado : Boolean);
begin
  BCadastrar.Enabled := not VpaEstado;
  BImprimir.Enabled := not VpaEstado;
  BFechar.Enabled := Not VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BGravar.Enabled := VpaEstado;
  if VprOperacao in [1,2] then
    ValidaGravacao1.Execute;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.NovaColeta;
begin
  Cadastrar;
  Showmodal;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.GColetaGetCellColor(Sender: TObject;
  ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush;
  AFont: TFont);
begin
  IF (ARow = 0) or (aCol = 0) then
    ABrush.Color := GColeta.ACorFoco.ACorTituloGrid
 else
    case ACol of
      4 :
         begin
             ABrush.Color := clInactiveCaption
        end;
    else
      ABrush.Color := GColeta.ACorFoco.AFundoComponentes;
    end;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.ENumeroOpExit(Sender: TObject);
begin
  if VprOperacao in [1,2] then
    if ENumeroOp.AsInteger <> 0 then
    begin
      if config.EstoqueCentralizado then
        VprDOrdemProducao.CodEmpresafilial := varia.CodFilialControladoraEstoque
      else
        VprDOrdemProducao.CodEmpresafilial := varia.CodigoEmpFil;
      VprDOrdemProducao.SeqOrdem := ENumeroOp.AsInteger;
      if FunOrdemProducao.CarDOrdemProducao(VprDOrdemProducao) then
      begin
        CarDOPTela;
        FunOrdemProducao.CarItensColetaOP(VprDColetaOP,VprDOrdemProducao);
        GColeta.CarregaGrade;
      end
      else
      begin
        Aviso('ORDEM DE PRODUÇÃO INVÁLIDA!!!'#13'A ordem de produção digitada não existe Cadastrada');
        ENumeroOp.Clear;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.BCancelarClick(Sender: TObject);
begin
  LimpaComponentes(PanelColor1,0);
  FreeTObjectsList(VprDColetaOP.ItensColeta);
  GColeta.CarregaGrade;
  EnableBotaoCadastrar(false);
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.GColetaCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDColetaItem := TRBDColetaOPItem(VprDColetaOP.ItensColeta.Items[VpaLinha-1]);
  GColeta.Cells[1,VpaLinha] := IntToStr(VprDColetaItem.CodCombinacao);
  GColeta.Cells[2,VpaLinha] := VprDColetaItem.CodManequim;
  GColeta.Cells[3,VpaLinha] := IntToStr(VprDColetaItem.NroFitas);
  if VprDColetaItem.MetrosColetados <> 0 then
    GColeta.Cells[4,VpaLinha] := FormatFloat('#,##0.00',VprDColetaItem.MetrosColetados)
  else
    GColeta.Cells[4,VpaLinha] := '';
  GColeta.Cells[5,VpaLinha] := FormatFloat('#,##0.00',VprDColetaItem.MetrosAProduzir);
  GColeta.Cells[6,VpaLinha] := FormatFloat('#,##0.00',VprDColetaItem.MetrosProduzidos);
  GColeta.Cells[7,VpaLinha] := FormatFloat('#,##0.00',VprDColetaItem.MetrosFaltante);
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.ENumeroOpChange(Sender: TObject);
begin
  If VprOperacao in [1,2] then
    ValidaGravacao1.Execute;
end;

procedure TFNovaColetaOrdemProducao.GColetaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = '.' then
    key := ',';
    
  if (GColeta.AColuna <> 3) and (GColeta.AColuna <> 4) then
    key := #0;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.GColetaDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GColeta.Cells[4,GColeta.ALinha] <> '' then
  begin
    try
      VprDColetaItem.MetrosColetados := StrToFloat(GColeta.Cells[4,GColeta.ALinha]);
    except
      VpaValidos := false;
      Aviso('QUANTIDADE COLETADA INVÁLIDA!!!'#13'A quantidade coletada não é um valor válido'); 
    end;
  end;
  if VpaValidos then
  begin
    if GColeta.Cells[3,GColeta.ALinha] <> '' then
    begin
      try
        VprDColetaItem.NroFitas := StrToInt(GColeta.Cells[3,GColeta.ALinha]);
      except
        VpaValidos := false;
        Aviso('NÚMERO DE FITAS INVÁLIDO!!!'#13'O número de fitas digitado não é um valor válido');
      end;
    end
    else
    begin
      VpaValidos := false;
      Aviso('NÚMERO DE FITAS INVÁLIDO!!!'#13'O número de fitas digitado não é um valor válido');
    end;
  end;

end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.BCadastrarClick(Sender: TObject);
begin
  Cadastrar;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.GColetaMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDColetaOP.ItensColeta.Count > 0 then
  begin
    VprDColetaItem := TRBDColetaOPItem(VprDColetaOP.ItensColeta.Items[VpaLinhaAtual-1]);
    GColeta.AColuna := 4;
    GColeta.Col := 4;
  end;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.GColetaEnter(Sender: TObject);
begin
  GColeta.AColuna := 4;
  GColeta.Col := 4;
end;

procedure TFNovaColetaOrdemProducao.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CarDClasse;
  VpfResultado := FunOrdemProducao.GravaDColetaOP(VprDColetaOP);
  if VpfResultado = '' then
  begin
    if (VprDOrdemProducao.TipPedido <> 3) and (VprDOrdemProducao.TipPedido <> 4) then //pedido para baixar do estoque
      VpfResultado := FunOrdemProducao.AdicionaEstoqueColetaOP(VprDOrdemProducao,VprDColetaOP);
  end;

  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprOperacao := 3;
    EnableBotaoCadastrar(false);
  end;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.Create(self);
  dtRave.ImprimeColetaOP(VprDColetaOP.CodEmpresafilial,VprDColetaOP.SeqOrdemProducao,VprDColetaOP.SeqColeta,CVisualizar.Checked);
  dtRave.free;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.GColetaGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  case ACol of
    3 :  Value := '0000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaColetaOrdemProducao.ENumeroOpKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    ENumeroOpExit(ENumeroOp);
end;

procedure TFNovaColetaOrdemProducao.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    if (sender is TRBStringGridColor) then
      TRBStringGridColor(sender).perform(WM_keydown,vk_tab,0)
    else
      Perform(Wm_NextDlgCtl,0,0);
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaColetaOrdemProducao]);
end.
