
unit ANovoRomaneioOrcamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Grids, CGrades, Componentes1,
  ExtCtrls, PainelGradiente, StdCtrls, Mask, numericos, UnDados, Constantes, Buttons, Localizacao, UnCotacao, UnDadosLOcaliza,
  UnProdutos, DBKeyViolation,UnArgox ;

type
  TRBDColunaGrade =(clCodFilial,clNumCotacao,clCodProduto,clNomProduto,clUM,clCodCor,clNomCor, clCodTamanho, clNomTamanho, clQtd, clCodEmbalagem, clNomEmbalagem,
                    clValUnitario, clValTotal, clNumOrdemCompra, clRefCliente, clOrdemCorte, clCodBarra);

  TFNovoRomaneioOrcamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    PanelColor1: TPanelColor;
    GProdutos: TRBStringGridColor;
    ERomaneio: Tnumerico;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicio: TEditColor;
    EDatFim: TEditColor;
    Label3: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    ECliente: TRBEditLocaliza;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    ECor: TRBEditLocaliza;
    ETamanho: TRBEditLocaliza;
    EEmbalagem: TRBEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    EQtdVolumes: Tnumerico;
    EPesoBruto: Tnumerico;
    Label6: TLabel;
    Label7: TLabel;
    Bevel2: TBevel;
    BCotacoes: TBitBtn;
    LValorTotal: TLabel;
    EValTotal: Tnumerico;
    BImprimeCliente: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelColor1Click(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure GProdutosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GProdutosDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure ECorRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EEmbalagemRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
    procedure GProdutosNovaLinha(Sender: TObject);
    procedure GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure EClienteChange(Sender: TObject);
    procedure EClienteRetorno(VpaColunas: TRBColunasLocaliza);
    procedure BCotacoesClick(Sender: TObject);
    procedure GProdutosDepoisExclusao(Sender: TObject);
    procedure BImprimeClienteClick(Sender: TObject);
  private
    { Private declarations }
    VprDItem : TRBDRomaneioOrcamentoItem;
    VprDRomaneio : TRBDRomaneioOrcamento;
    VprOperacao : TRBDOperacaoCadastro;
    VprAcao : Boolean;
    VprUltimaCotacao : Integer;
    VprProdutoAnterior : string;
    FunArgox : TRBFuncoesArgox;
    procedure CarTitulosGrade;
    procedure InicializaClasse;
    procedure CarDTela;
    procedure CarDClasse;
    procedure CarDProdutoClasse;
    function LocalizaProduto : Boolean;
    function ExisteProduto : Boolean;
    procedure PreparaAlteracao(VpaCodFilial, VpaSeqRomaneio : Integer);
    procedure RecuperaDadosCotacao;
    procedure HabilitaBotoes(VpaEstado : Boolean);
    procedure CalculaValorTotalProduto;
    procedure CalculaValorTotal;
    procedure ConfiguraPermissaoUsuario;
    function RColunaGrade(VpaColuna : TRBDColunaGrade):Integer;
    procedure CarCodigobarras;
  public
    { Public declarations }
    function NovoRomaneio: Boolean;
    function AlteraRomaneio(VpaCodFilial, VpaSeqRomaneio : Integer) : Boolean;
    procedure ConsultaRomaneio(VpaCodFilial, VpaSeqRomaneio : Integer);
  end;

var
  FNovoRomaneioOrcamento: TFNovoRomaneioOrcamento;

implementation

uses APrincipal, FunData, ConstMsg, funString, ALocalizaProdutos, ACotacao, Funobjeto;

{$R *.DFM}


{ **************************************************************************** }
procedure TFNovoRomaneioOrcamento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDRomaneio := TRBDRomaneioOrcamento.cria;
  VprAcao := false;
  CarTitulosGrade;
  FunArgox := nil;
  ConfiguraPermissaoUsuario;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.GProdutosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDItem := TRBDRomaneioOrcamentoItem(VprDRomaneio.Produtos.Items[VpaLinha-1]);
  if (VprDItem.CodFilialOrcamento <> 0) then
    GProdutos.Cells[RColunaGrade(clCodFilial),VpaLinha] := IntToStr(VprDItem.CodFilialOrcamento)
  else
    GProdutos.Cells[RColunaGrade(clCodFilial),VpaLinha] := '';
  if VprDItem.LanOrcamento <> 0 then
    GProdutos.Cells[RColunaGrade(clNumCotacao),VpaLinha] := IntToStr(VprDItem.LanOrcamento)
  else
    GProdutos.Cells[RColunaGrade(clNumCotacao),VpaLinha] := '';
  GProdutos.Cells[RColunaGrade(clCodProduto),VpaLinha] := VprDItem.CodProduto;
  GProdutos.Cells[RColunaGrade(clNomProduto),VpaLinha] := VprDItem.NomProduto;
  GProdutos.Cells[RColunaGrade(clUM),VpaLinha] := VprDItem.DesUM;
  if VprDItem.CodCor <> 0 then
    GProdutos.Cells[RColunaGrade(clCodCor),VpaLinha] := IntToStr(VprDItem.CodCor)
  else
    GProdutos.Cells[RColunaGrade(clCodCor),VpaLinha] := '';
  GProdutos.Cells[RColunaGrade(clNomCor),VpaLinha] := VprDItem.NomCor;
  if VprDItem.CodTamanho <> 0 then
    GProdutos.Cells[RColunaGrade(clCodTamanho),VpaLinha] := IntToStr(VprDItem.CodTamanho)
  else
    GProdutos.Cells[RColunaGrade(clCodTamanho),VpaLinha] := '';
  GProdutos.Cells[RColunaGrade(clNomTamanho),VpaLinha] := VprDItem.NomTamanho;
  if VprDItem.QtdProduto <> 0 then
    GProdutos.Cells[RColunaGrade(clQtd),VpaLinha] := FormatFloat('#,##0.00',VprDItem.QtdProduto)
  else
    GProdutos.Cells[RColunaGrade(clQtd),VpaLinha] := '';
  if VprDItem.CodEmbalagem <> 0 then
    GProdutos.Cells[RColunaGrade(clCodEmbalagem),VpaLinha] := IntToStr(VprDItem.CodEmbalagem)
  else
    GProdutos.Cells[RColunaGrade(clCodEmbalagem),VpaLinha] := '';
  GProdutos.Cells[RColunaGrade(clNomEmbalagem),VpaLinha] := VprDItem.NomEmbalagem;
  GProdutos.Cells[RColunaGrade(clValUnitario),VpaLinha] := FormatFloat(varia.MascaraValorUnitario,VprDItem.ValUnitario);
  GProdutos.Cells[RColunaGrade(clValTotal),VpaLinha] := FormatFloat(varia.MascaraValor,VprDItem.ValTotal);
  GProdutos.Cells[RColunaGrade(clNumOrdemCompra),VpaLinha] := VprDItem.DesOrdemCompra;
  GProdutos.Cells[RColunaGrade(clRefCliente),VpaLinha] := VprDItem.DesReferenciaCliente;
  GProdutos.Cells[RColunaGrade(clOrdemCorte),VpaLinha] := VprDItem.DesOrdemCorte;
  GProdutos.Cells[RColunaGrade(clCodBarra),VpaLinha] := VprDItem.DesCodBarra;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.GProdutosDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if (GProdutos.Cells[RColunaGrade(clCodFilial),GProdutos.ALinha] = '') then
  begin
    VpaValidos := false;
    aviso('FILIAL NÃO PREENCHIDA!!!'#13'É necessário preencher o codigo da filial.');
    GProdutos.Col := RColunaGrade(clCodFilial);
  end
  else
    if (GProdutos.Cells[RColunaGrade(clNumCotacao),GProdutos.ALinha] = '') then
    begin
      VpaValidos := false;
      aviso('PEDIDO NÃO PREENCHIDO!!!'#13'É necessário preencher o numero do pedido.');
      GProdutos.Col := RColunaGrade(clNumCotacao);
    end
    else
    if not ExisteProduto then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GProdutos.col := RColunaGrade(clCodProduto);
    end
    else
      if not ECor.AExisteCodigo(GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.ALinha]) then
      begin
        VpaValidos := false;
        aviso('COR NÃO PREENCHIDA!!!'#13'É necessário preencher a cor do produto.');
        GProdutos.Col := RColunaGrade(clCodCor);
      end
      else
        if not ETamanho.AExisteCodigo(GProdutos.Cells[RColunaGrade(clCodTamanho),GProdutos.ALinha]) then
        begin
          VpaValidos := false;
          aviso('TAMANHO INVÁLIDO!!!'#13'É necessário preencher o tamanho do produto');
          GProdutos.Col := RColunaGrade(clCodTamanho);
        end
        else
          if DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[RColunaGrade(clQtd),GProdutos.ALinha],'0'),'.'),',') = '' then
          begin
            aviso('QUANTIDADE PRODUTO NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade de produtos.');
            GProdutos.Col := RColunaGrade(clQtd);
            VpaValidos := false;
          end
          else
            if not EEmbalagem.AExisteCodigo(GProdutos.Cells[RColunaGrade(clCodEmbalagem),GProdutos.ALinha]) then
            begin
              VpaValidos := false;
              aviso('EMBALAGEM INVÁLIDA!!!'#13'É necessário preencher a embalagem do produto');
              GProdutos.Col := RColunaGrade(clCodEmbalagem);
            end;
  if VpaValidos then
  begin
    CarDProdutoClasse;
    if VprDItem.QtdProduto = 0 then
    begin
      aviso('QUANTIDADE PRODUTO NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade de produtos.');
      GProdutos.Col := RColunaGrade(clQtd);
      VpaValidos := false;
    end;
    if VpaValidos then
    begin
      if not FunCotacao.ClienteItemRomaneioValido(VprDRomaneio,VprDItem) then
      begin
        aviso('COTAÇÃO INVÁLIDA!!!'#13'A cotação digitada não é do mesmo cliente do romaneio');
        GProdutos.Col := RColunaGrade(clNumCotacao);
        VpaValidos := false;
      end;
      if VpaValidos then
      begin
        if NOt FunCotacao.ProdutoRomaneioExistenoPedido(VprDItem) then
        begin
          aviso('PRODUTO INVÁLIDO!!!'#13'O produto digitado não existe na cotação');
          GProdutos.Col := RColunaGrade(clCodProduto);
          VpaValidos := false;
        end;
      end;
    end;
  end;
  if VpaValidos then
  begin
    if config.ImprimirEtiquetaNoRomaneioOrcamento then
    begin
      FunArgox :=  TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica);
      FunArgox.ImprimeEtiquetaRomaneioCotacao32X18(VprDItem);
      FunArgox.Free;
    end;
  end;
  if VpaValidos then
    CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.GProdutosDepoisExclusao(Sender: TObject);
begin
  CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
begin
  if (RColunaGrade(clCodCor) = ACol) or
     (RColunaGrade(clCodTamanho) = ACol) or
     (RColunaGrade(clCodEmbalagem) = ACol) then
    Value := '000000;0; ';
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.GProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin
      if RColunaGrade(clCodProduto) = GProdutos.Col then
        LocalizaProduto
      else
        if RColunaGrade(clCodCor) = GProdutos.Col then
          ECor.AAbreLocalizacao
        else
          if RColunaGrade(clCodTamanho) = GProdutos.Col then
            ETamanho.AAbreLocalizacao
          else
            if RColunaGrade(clCodEmbalagem) = GProdutos.Col then
              EEmbalagem.AAbreLocalizacao;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDRomaneio.Produtos.Count >0 then
  begin
    VprDItem := TRBDRomaneioOrcamentoItem(VprDRomaneio.Produtos.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDItem.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.GProdutosNovaLinha(Sender: TObject);
begin
  VprDItem := VprDRomaneio.addProduto;
  VprDItem.CodFilialOrcamento := varia.CodigoEmpFil;
  VprDItem.LanOrcamento := VprUltimaCotacao;
  VprProdutoAnterior := '';
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutos.AEstadoGrade in [egInsercao,EgEdicao] then
   if GProdutos.AColuna <> ACol then
    begin
      if RColunaGrade(clCodProduto) = GProdutos.Col then
      begin
         if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha] := '';
               GProdutos.Col := RColunaGrade(clCodProduto);
             end;
           end;
      end
      else
        if RColunaGrade(clCodCor) = GProdutos.Col then
        begin
           if not ECor.AExisteCodigo(GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.ALinha]) then
           begin
             if not ECor.AAbreLocalizacao then
             begin
               GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.ALinha] := '';
               abort;
             end;
           end;
        end
        else
          if RColunaGrade(clCodTamanho) = GProdutos.Col then
          begin
            if not ETamanho.AExisteCodigo(GProdutos.Cells[RColunaGrade(clCodTamanho),GProdutos.ALinha]) then
            begin
              if not ETamanho.AAbreLocalizacao then
              begin
                GProdutos.Cells[RColunaGrade(clCodTamanho),GProdutos.ALinha] := '';
                abort;
              end;
            end;
          end
          else
            if RColunaGrade(clQtd) = GProdutos.Col then
              CalculaValorTotalProduto
            else
              if RColunaGrade(clCodEmbalagem) = GProdutos.Col then
              begin
                if not EEmbalagem.AExisteCodigo(GProdutos.Cells[RColunaGrade(clCodEmbalagem),GProdutos.ALinha]) then
                begin
                  if not EEmbalagem.AAbreLocalizacao then
                  begin
                    GProdutos.Cells[RColunaGrade(clCodEmbalagem),GProdutos.ALinha] := '';
                    abort;
                  end;
                end;
              end;
    end;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.HabilitaBotoes(VpaEstado: Boolean);
begin
  BCotacoes.Enabled := VpaEstado;
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.InicializaClasse;
begin
  VprOperacao := ocInsercao;
  VprDRomaneio.Free;
  VprDRomaneio := TRBDRomaneioOrcamento.cria;
  VprDRomaneio.CodFilial := varia.CodigoEmpFil;
  VprDRomaneio.DatInicio := now;
  VprDRomaneio.CodUsuario := Varia.CodigoUsuario;
  GProdutos.ADados := VprDRomaneio.Produtos;
  GProdutos.CarregaGrade;
  CarDTela;
  ActiveControl := ECliente;
end;

{******************************************************************************}
function TFNovoRomaneioOrcamento.LocalizaProduto: Boolean;
var
  VpfCadastrou : Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VpfCadastrou,VprDItem.SeqProduto,VprDItem.CodProduto,VprDItem.NomProduto); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    with VprDItem do
    begin
      GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha] := CodProduto;
      GProdutos.Cells[RColunaGrade(clNomProduto),GProdutos.ALinha] := NomProduto;
      CarCodigobarras;
      VprProdutoAnterior := CodProduto;
      RecuperaDadosCotacao;
    end;
  end;
end;

{******************************************************************************}
function TFNovoRomaneioOrcamento.NovoRomaneio: Boolean;
begin
  InicializaClasse;
  Showmodal;
  Result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.PanelColor1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.PreparaAlteracao(VpaCodFilial,VpaSeqRomaneio: Integer);
begin
  VprOperacao := ocConsulta;
  VprDRomaneio.Free;
  VprDRomaneio := TRBDRomaneioOrcamento.cria;
  FunCotacao.CarDRomaneioOrcamento(VprDRomaneio,VpaCodFilial,VpaSeqRomaneio);
  CarDTela;
  GProdutos.ADados := VprDRomaneio.Produtos;
  GProdutos.CarregaGrade;
  VprOperacao := ocEdicao;
end;

{******************************************************************************}
function TFNovoRomaneioOrcamento.RColunaGrade(VpaColuna: TRBDColunaGrade): Integer;
begin
  case VpaColuna of
    clCodFilial: result:= 1;
    clNumCotacao: result:= 2;
    clCodProduto: result:= 3;
    clNomProduto: result:= 4;
    clUM: result:= 5;
    clCodCor: result:= 6;
    clNomCor: result:= 7;
    clCodBarra: result:= 8;
    clCodTamanho: result:= 9;
    clNomTamanho: result:= 10;
    clQtd: result:= 11;
    clCodEmbalagem: result:= 12;
    clNomEmbalagem: result:= 13;
    clValUnitario: result:= 14;
    clValTotal: result:= 15;
    clNumOrdemCompra: result:= 16;
    clRefCliente: result:= 17;
    clOrdemCorte: result:= 18;
  end;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.RecuperaDadosCotacao;
begin
  CarDProdutoClasse;
  FunCotacao.ProdutoRomaneioExistenoPedido(VprDItem);
  GProdutosCarregaItemGrade(GProdutos,GProdutos.ALinha);
end;

{ *************************************************************************** }
function TFNovoRomaneioOrcamento.AlteraRomaneio(VpaCodFilial, VpaSeqRomaneio: Integer): Boolean;
begin
  PreparaAlteracao(VpaCodFilial,VpaSeqRomaneio);
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.BCotacoesClick(Sender: TObject);
begin
  FCotacao := TFCotacao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FCotacao'));
  FCotacao.ImprimePedidosPendentesCliente(ECliente.AInteiro);
  FCotacao.free;
  ActiveControl := GProdutos;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.BGravarClick(Sender: TObject);
var
  VpfResultado : string;
begin
  CarDClasse;
  VpfResultado := FunCotacao.GravaDRomaneioCotacao(VprDRomaneio);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao := true;
    close;
  end;
end;

procedure TFNovoRomaneioOrcamento.BImprimeClienteClick(Sender: TObject);
begin
  FunArgox :=  TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica);
  FunArgox.ImprimeEtiquetaRomaneioCotacaoCliente(VprDRomaneio);
  FunArgox.Free;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.CalculaValorTotal;
begin
  FunCotacao.CalculaValorTotalRomaneio(VprDRomaneio);
  EValTotal.AValor := VprDRomaneio.ValTotal;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.CalculaValorTotalProduto;
begin
  VprDItem.QtdProduto :=  StrToFloatDef(DeletaChars(GProdutos.Cells[RColunaGrade(clQtd),GProdutos.ALinha],'.'),0);
  VprDItem.ValTotal := VprDItem.QtdProduto * VprDItem.ValUnitario;
  GProdutos.Cells[RColunaGrade(clValTotal),GProdutos.ALinha] := FormatFloat(varia.MascaraValor,VprDItem.ValTotal);
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.CarCodigobarras;
begin
  VprDItem.DesCodBarra:= FunProdutos.RCodigoBarraProduto(VprDRomaneio.CodFilial, VprDItem.SeqProduto, VprDItem.CodCor, VprDItem.CodTamanho);
  VprDItem.DesCodBarrasAnterior:= VprDItem.DesCodBarra;
  GProdutos.Cells[RColunaGrade(clCodBarra),GProdutos.ALinha] := VprDItem.DesCodBarra;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.CarDClasse;
begin
  VprDRomaneio.CodCliente := ECliente.AInteiro;
  VprDRomaneio.PesBruto := EPesoBruto.AValor;
  VprDRomaneio.QtdVolume := EQtdVolumes.AsInteger;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.CarDProdutoClasse;
begin
  VprDItem.CodFilialOrcamento := StrToIntDef(GProdutos.Cells[RColunaGrade(clCodFilial),GProdutos.ALinha],0);
  VprDItem.LanOrcamento := StrToIntDef(GProdutos.Cells[RColunaGrade(clNumCotacao),GProdutos.ALinha],0);
  VprDItem.CodProduto := GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha];
  VprDItem.QtdProduto :=  StrToFloatDef(DeletaChars(GProdutos.Cells[RColunaGrade(clQtd),GProdutos.ALinha],'.'),0);
  VprDItem.DesCodBarra:= GProdutos.Cells[RColunaGrade(clCodBarra),GProdutos.ALinha];
  VprUltimaCotacao := VprDItem.LanOrcamento;
  CalculaValorTotalProduto;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.CarDTela;
begin
  ERomaneio.AsInteger := VprDRomaneio.SeqRomaneio;
  EDatInicio.Text := FormatDateTime('DD/MM/YYYY',VprDRomaneio.DatInicio);
  if VprDRomaneio.DatFim > Montadata(1,1,1900) then
    EDatFim.Text := FormatDateTime('DD/MM/YYYY',VprDRomaneio.DatFim)
  else
    EDatFim.Clear;
  ECliente.AInteiro := VprDRomaneio.CodCliente;
  ECliente.Atualiza;
  EPesoBruto.AValor := VprDRomaneio.PesBruto;
  EQtdVolumes.AsInteger := VprDRomaneio.QtdVolume;
  EValTotal.AValor := VprDRomaneio.ValTotal;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.CarTitulosGrade;
begin
  GProdutos.Cells[RColunaGrade(clCodFilial),0] := 'Filial';
  GProdutos.Cells[RColunaGrade(clNumCotacao),0] := 'Cotação';
  GProdutos.Cells[RColunaGrade(clCodProduto),0] := 'Codigo';
  GProdutos.Cells[RColunaGrade(clNomProduto),0] := 'Produto';
  GProdutos.Cells[RColunaGrade(clUM),0] := 'UM';
  GProdutos.Cells[RColunaGrade(clCodCor),0] := 'Código';
  GProdutos.Cells[RColunaGrade(clNomCor),0] := 'Cor';
  GProdutos.Cells[RColunaGrade(clCodBarra),0] := 'Código de Barras';
  GProdutos.Cells[RColunaGrade(clCodTamanho),0] := 'Código';
  GProdutos.Cells[RColunaGrade(clNomTamanho),0] := 'Tamanho';
  GProdutos.Cells[RColunaGrade(clQtd),0] := 'Quantidade';
  GProdutos.Cells[RColunaGrade(clCodEmbalagem),0] := 'Código';
  GProdutos.Cells[RColunaGrade(clNomEmbalagem),0] := 'Embalagem';
  GProdutos.Cells[RColunaGrade(clValUnitario),0] := 'Valor Unitario';
  GProdutos.Cells[RColunaGrade(clValTotal),0] := 'Valor Total';
  GProdutos.Cells[RColunaGrade(clNumOrdemCompra),0] := 'Ordem Compra';
  GProdutos.Cells[RColunaGrade(clRefCliente),0] := 'Referencia Cliente';
  GProdutos.Cells[RColunaGrade(clOrdemCorte),0] := 'Ordem Corte';
  if not config.EstoquePorTamanho then
  begin
    GProdutos.TabStops[RColunaGrade(clCodTamanho)] := false;
    GProdutos.TabStops[RColunaGrade(clNomTamanho)] := false;
    GProdutos.ColWidths[RColunaGrade(clCodTamanho)] := -1;
    GProdutos.ColWidths[RColunaGrade(clNomTamanho)] := -1;
  end;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.ConfiguraPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([LValorTotal,EValTotal],false);
    GProdutos.ColWidths[RColunaGrade(clValUnitario)] := -1;
    GProdutos.ColWidths[RColunaGrade(clValTotal)] := -1;
    if (puPLImprimirValoresRelatorioPedidosPendentes in Varia.PermissoesUsuario) then
    begin
      GProdutos.ColWidths[RColunaGrade(clValUnitario)] := 100;
      GProdutos.ColWidths[RColunaGrade(clValTotal)] := 100;
      AlterarVisibleDet([LValorTotal,EValTotal],true);
    end;
  end;

end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.ConsultaRomaneio(VpaCodFilial,VpaSeqRomaneio: Integer);
begin
  PreparaAlteracao(VpaCodFilial,VpaSeqRomaneio);
  VprOperacao := ocConsulta;
  HabilitaBotoes(false);
  AlterarEnabledDet(PanelColor1,0,false);
  GProdutos.ReadOnly := true;
  showmodal;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.EClienteChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.EClienteRetorno(VpaColunas: TRBColunasLocaliza);
var
  VpfSeqRomaneio : Integer;
begin
  if VprOperacao in [ocinsercao,ocedicao] then
  begin
    if not Config.PermitirGerarNovoRomaneioQuandoOutroEstiverAberto then
    begin
      if VprDRomaneio.CodCliente <> ECliente.AInteiro then
      begin
        VpfSeqRomaneio := FunCotacao.RRomaneioemAbertoCliente(VprDRomaneio.CodFilial,ECliente.AInteiro);
        if VpfSeqRomaneio <> 0 then
        begin
          aviso('ROMANEIO EM ABERTO!!!'#13'Existe o romaneio "'+IntToStr(VpfSeqRomaneio)+'" em aberto para esse cliente. O sistema irá recupera esse romaneio');
          PreparaAlteracao(VprDRomaneio.CodFilial,VpfSeqRomaneio);
          GProdutos.SetFocus;
          GProdutos.NovaLinha;
        end;
      end;
      VprDRomaneio.CodCliente := ECliente.AInteiro;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.ECorRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDItem.CodCor := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDItem.NomCor := VpaColunas.items[1].AValorRetorno;
    CarCodigobarras;
    GProdutos.Cells[RColunaGrade(clCodCor),GProdutos.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProdutos.Cells[RColunaGrade(clNomCor),GProdutos.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDItem.CodCor := 0;
    VprDItem.NomCor := '';
  end;
  RecuperaDadosCotacao;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.EEmbalagemRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDItem.CodEmbalagem := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDItem.NomEmbalagem := VpaColunas.items[1].AValorRetorno;
    VprDItem.QtdEmbalagem := StrToFloat(VpaColunas.items[2].AValorRetorno);
    GProdutos.Cells[RColunaGrade(clCodEmbalagem),GProdutos.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProdutos.Cells[RColunaGrade(clNomEmbalagem),GProdutos.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDItem.CodEmbalagem := 0;
    VprDItem.NomEmbalagem := '';
    VprDItem.QtdEmbalagem := 0;
  end;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDItem.CodTamanho := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDItem.NomTamanho := VpaColunas.items[1].AValorRetorno;
    CarCodigobarras;
    GProdutos.Cells[RColunaGrade(clCodTamanho),GProdutos.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProdutos.Cells[RColunaGrade(clNomTamanho),GProdutos.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDItem.CodTamanho := 0;
    VprDItem.NomTamanho := '';
  end;
end;

{******************************************************************************}
function TFNovoRomaneioOrcamento.ExisteProduto: Boolean;
begin
  if (GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha] <> '') then
  begin
    if GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      result := FunProdutos.ExisteProduto(GProdutos.Cells[RColunaGrade(clCodProduto),GProdutos.ALinha],VprDItem.SeqProduto,VprDItem.NomProduto);
      if result then
      begin
        GProdutos.cells[RColunaGrade(clNomProduto),GProdutos.ALinha] := VprDItem.NomProduto;
        CarCodigobarras;
        VprProdutoAnterior := GProdutos.cells[RColunaGrade(clCodProduto),GProdutos.ALinha];
        RecuperaDadosCotacao;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
procedure TFNovoRomaneioOrcamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDRomaneio.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoRomaneioOrcamento]);
end.
