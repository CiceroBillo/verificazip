unit ABaixaParcialCotacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Grids,
  CGrades, UnDadosProduto,UnCotacao, UnProdutos, Localizacao, MPlayer,
  Mask, numericos, SqlExpr;

type
  TFBaixaParcialCotacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    PUtilizarLeitor: TPanelColor;
    Localiza: TConsultaPadrao;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    LNomProduto: TLabel;
    EProduto: TEditLocaliza;
    Som: TMediaPlayer;
    PanelColor3: TPanelColor;
    GProdutos: TRBStringGridColor;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    EPerDesconto: Tnumerico;
    BEnviar: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    EPeso: Tnumerico;
    EVolume: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BEnviarClick(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    VprPressionadoR,
    VprAcao,
    VprFinanceiroGerado,
    VprPermiteFechar,
    VprIndConferindo : Boolean;
    VprDCotacao : TRBDOrcamento;
    VprDItemCotacao : TRBDOrcProduto;
    VprSeqParcial,
    VprProutoLiberado : Integer;
    FunCotacao : TFuncoesCotacao;
    procedure ConfiguraPermissaoUsuario;
    procedure CarTituloGrade;
    procedure AcertaQtdProdutosBaixarEstoque;
    procedure EstadoBotoes(VpaEstado : Boolean);
    procedure GeraFinanceiro;
    function GravaBaixaParcial : String;
    procedure AdicionaProduto(VpaSeqProduto : Integer);
    function VerificaQtdABaixar : string;
  public
    { Public declarations }
    function GeraBaixaParcial(VpaDCotacao : TRBDOrcamento;VpaIndConferencia : Boolean) : Boolean;
  end;

var
  FBaixaParcialCotacao: TFBaixaParcialCotacao;

implementation

uses APrincipal, funString, ConstMsg, UnContasAreceber, Constantes, UnClientes,
     FunValida, FunNumeros, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaParcialCotacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  VprPermiteFechar := false;
  VprFinanceiroGerado := false;
  VprIndConferindo := false;
  ConfiguraPermissaoUsuario;
  CarTituloGrade;
  FunCotacao := TFuncoesCotacao.Cria(FPrincipal.BaseDados);
  PUtilizarLeitor.Visible := config.UtilizarLeitorSeparacaoProduto;
  if config.UtilizarLeitorSeparacaoProduto then
    ActiveControl := EProduto;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBaixaParcialCotacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunCotacao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFBaixaParcialCotacao.ConfiguraPermissaoUsuario;
begin
  if not config.EstoquePorCor then
  begin
    GProdutos.ColWidths[6] := -1;
    GProdutos.ColWidths[7] := -1;
    GProdutos.ColWidths[5] := RetornaInteiro(GProdutos.ColWidths[5] *1.5);
  end;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.CarTituloGrade;
begin
  if VprIndConferindo then
  begin
    GProdutos.Cells[1,0] := 'Qtd Conferir';
    PainelGradiente1.caption := '  Confere Produtos Baixados   ';
    caption := 'Confere Produtos Baixados';
  end
  else
  begin
    GProdutos.Cells[1,0] := 'Qtd Baixar';
  end;
  GProdutos.Cells[2,0] := 'Qtd Cotacao';
  GProdutos.Cells[3,0] := 'Referencia';
  GProdutos.Cells[4,0] := 'Codigo';
  GProdutos.Cells[5,0] := 'Produto';
  GProdutos.Cells[6,0] := 'Cor';
  GProdutos.Cells[7,0] := 'Descrição';
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.AcertaQtdProdutosBaixarEstoque;
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VprDCotacao.Produtos.count - 1 do
  begin
    VprDItemCotacao := TRBDOrcProduto(VprDCotacao.Produtos.Items[VpfLaco]);
    VprDItemCotacao.QtdProduto := VprDItemCotacao.QtdABaixar;
    VprDItemCotacao.ValTotal := VprDItemCotacao.QtdProduto * VprDItemCotacao.ValUnitario;
  end;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.EstadoBotoes(VpaEstado : Boolean);
begin
  BImprimir.enabled := VpaEstado;
  BEnviar.Enabled := VpaEstado;
  BOk.Enabled := not VpaEstado;
  BCancelar.Enabled := not VpaEstado;
  BFechar.Enabled := VpaEstado;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.GeraFinanceiro;
var
  VpfResultado : String;
  VpfTransacao : TTransactionDesc;
begin
  if VprSeqParcial = 0 then
    aviso('ROMANEIO PARCIAL NÃO GRAVADO!!!'#13'Antes de gerar o finaneiro é necessário gravar o romaneio parcial.')
  else
  begin
    if VprFinanceiroGerado then
      if not confirmacao('FINANCEIRO JÁ FOI GERADO!!!'#13'O financeiro dessa baixa parcial já foi gerado, tem certeza que deseja gerar novamente?') then
        exit;

    VpfTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VpfTransacao);
    if FunCotacao.GeraFinanceiroParcial(VprDCotacao,FunContasAReceber,VprSeqParcial, VpfResultado) then
    begin
      if VpfResultado ='' then
      begin
        VprDCotacao.ValTotal := FunCotacao.RValTotalOrcamento(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento);
        FunCotacao.SetaFinanceiroGerado(VprDCotacao);
        VprDCotacao.FinanceiroGerado := true;
      end;
      if VpfResultado <> '' then
      begin
        FPrincipal.BaseDados.Rollback(VpfTransacao);
        aviso(VpfResultado);
      end
      else
        FPrincipal.BaseDados.Commit(VpfTransacao);
      VprFinanceiroGerado := true;
    end
    else
      FPrincipal.BaseDados.Rollback(VpfTransacao);
  end;
end;

{******************************************************************************}
function TFBaixaParcialCotacao.GravaBaixaParcial : String;
begin
  result := FunCotacao.GravaBaixaParcialCotacao(VprDCotacao,vprSeqParcial);
  if result = '' then
  begin
    if not VprIndConferindo then
    begin
      FunCotacao.BaixaProdutosEtiquetadosSeparados(VprDCotacao);
      AcertaQtdProdutosBaixarEstoque;
      result := FunCotacao.GeraEstoqueProdutos(VprDCotacao,FunProdutos,false);
    end;
    if result = '' then
      result := FunCotacao.BaixaProdutosParcialCotacao(VprDCotacao);
  end;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.AdicionaProduto(VpaSeqProduto : Integer);
var
  VpfLaco, VpfLinha : Integer;
  VpfDProCotacao : TRBDOrcProduto;
  VpfLocalizouProduto : Boolean;
begin
  VprProutoLiberado := 0;
  VpfLocalizouProduto := false;
  VpfDProCotacao := nil;
  for VpfLaco := 0 to VprDCotacao.Produtos.Count - 1 do
  begin
    if TRBDOrcProduto(VprDCotacao.Produtos.Items[VpfLaco]).SeqProduto = VpaSeqProduto then
    begin
      VpfDProCotacao := TRBDOrcProduto(VprDCotacao.Produtos.Items[VpfLaco]);
      VpfLinha := VpfLaco + 1;
      if VprIndConferindo then
      begin
        VpfLocalizouProduto := true;
        break;
      end
      else
      begin
        VpfLocalizouProduto := true;
        break;
      end;
    end;
  end;
{  if not VpfLocalizouProduto and (VpfDProCotacao <> nil) then
  begin
    VpfDProCotacao.QtdABaixar := VpfDProCotacao.QtdABaixar + 1;
    VpfLocalizouProduto := true;
  end;}

  if VpfLocalizouProduto then
  begin
    GProdutos.CarregaGrade;
    ActiveControl := GProdutos;
    GProdutos.Row := VpfLinha;
    VprProutoLiberado := VpaSeqProduto;
  end
  else
  begin
    try
    Som.play;
    except
    end;
    if VpfDProCotacao <> nil  then
      aviso('PRODUTO BAIXADO A MAIS!!!'#13'O produto "'+ VpfDProCotacao.CodProduto+'-'+VpfDProCotacao.NomProduto+'" possui '+ FormatFloat('##0.00',VpfDProCotacao.QtdProduto)+' '+ VpfDProCotacao.UM+' no pedido')
    else
      Aviso('PRODUTO INVÁLIDO!!!!'#13'O produto selecionado não existe na cotação');
  end;
end;

{******************************************************************************}
function TFBaixaParcialCotacao.VerificaQtdABaixar : string;
var
  VpfLaco : Integer;
  VpfDProCotacao : TRBDOrcProduto;
begin
  result := '';
  if (VARIA.CNPJFilial = CNPJ_MetalVidros) or (varia.CNPJFilial =  CNPJ_VIDROMAX) then
  begin
    for VpfLaco := 0 to VprDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VprDCotacao.Produtos.Items[VpfLaco]);
      if VprIndConferindo then
      begin
        if VpfDProCotacao.QtdConferido < 0 then
        begin
          if (VpfDProCotacao.QtdConferidoSalvo + VpfDProCotacao.QtdConferido) < 0  then
            result := #13+ 'A quantidade conferida a ser estornada do produto "'+VpfDProCotacao.CodProduto+'" é maior que a quantidade que foi conferida.';
        end
        else
          if VpfDProCotacao.QtdConferido > 0 then
          begin
            if (VpfDProCotacao.QtdConferidoSalvo + VpfDProCotacao.QtdConferido) <> (VpfDProCotacao.QtdBaixadoNota) then
              result := result + #13+VpfDProCotacao.CodProduto+'-'+VpfDProCotacao.NomProduto;
          end;
      end
      else
      begin
        if VpfDProCotacao.QtdABaixar < 0 then
        begin
          if VpfDProCotacao.QtdConferidoSalvo > 0 then
            result := #13+'Não é possivel estornar o produto "'+VpfDProCotacao.CodProduto+'" porque a quantidade já foi conferida. É necessário antes estornar a quantidade conferida.'
          else
          begin
            if (VpfDProCotacao.QtdBaixadoNota + VpfDProCotacao.QtdABaixar) < 0  then
              result :=#13+ 'A quantidade a ser estornada do produto "'+VpfDProCotacao.CodProduto+'" é maior que a quantidade que foi baixada.';
          end;
        end
        else
          if VpfDProCotacao.QtdABaixar > (VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixadoNota) then
            result := result + #13+VpfDProCotacao.CodProduto+'-'+VpfDProCotacao.NomProduto;
      end;
    end;
  end;
  if result <> '' then
    result := 'A quantidade baixada dos produtos abaixo é maior que a quantidade do pedido:'+result;
end;

{******************************************************************************}
function TFBaixaParcialCotacao.GeraBaixaParcial(VpaDCotacao : TRBDOrcamento;VpaIndConferencia : Boolean) : Boolean;
begin
  VprIndConferindo := VpaIndConferencia;
  CarTituloGrade;
  VprDCotacao := VpaDCotacao;
  EPeso.AValor:= VprDCotacao.PesLiquido;
  EVolume.AInteiro:= VprDCotacao.QtdVolumesTransportadora;
  GProdutos.ADados := VpaDCotacao.Produtos;
  GProdutos.CarregaGrade;
  EstadoBotoes(false);
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.BCancelarClick(Sender: TObject);
var
  VpfSenha : String;
begin
  if config.SolicitarSenhaparaCancelarBaixaParcial then
    if Entrada('Digite a senha para cancelar a baixa','Senha : ',VpfSenha,true,EProduto.Color,PanelColor2.Color) then
    begin
      if VpfSenha <> Descriptografa(Varia.senha) then
      begin
        aviso('SENHA INVÁLIDA!!!'#13'A senha digitada é diferente do usuario que começou a separação');
        exit;
      end;
    end
    else
      exit;
  VprAcao := false;
  if varia.EstagioBaixaParcialCancelada <> 0 then
    FunCotacao.AlteraEstagioCotacao(VprDCotacao.CodEmpFil,varia.CodigoUsuario,VprDCotacao.LanOrcamento,Varia.EstagioBaixaParcialCancelada,'');
  VprPermiteFechar := true;
  close;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.BOkClick(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao : TTransactionDesc;
begin
  VpfTransacao.IsolationLevel := xilREADCOMMITTED;
  FPrincipal.BaseDados.StartTransaction(VpfTransacao);
  VpfResultado := VerificaQtdABaixar;
  VprDCotacao.PerDesconto := EPerDesconto.AValor;
  if EVolume.AInteiro <> VprDCotacao.QtdVolumesTransportadora then
    VprDCotacao.QtdVolumesTransportadora:= EVolume.AInteiro;
  if EPeso.AValor <> VprDCotacao.PesLiquido then
    VprDCotacao.PesLiquido:= EPeso.AValor;

  VprDCotacao.ValTotal:= FunCotacao.RValTotalCotacaoParcial(VprDCotacao);
  if VprDCotacao.PerDesconto <> 0 then
      VprDCotacao.ValTotal := VprDCotacao.ValTotal - ((VprDCotacao.ValTotal*VprDCotacao.PerDesconto)/100);

  if VpfResultado = '' then
  begin
    VpfResultado := GravaBaixaParcial;
  end;

  if VpfResultado <> '' then
  begin
    FPrincipal.BaseDados.Rollback(VpfTransacao);
    aviso(VpfResultado);
  end
  else
  begin
    VprAcao := true;
    FPrincipal.BaseDados.Commit(VpfTransacao);
    EstadoBotoes(true);
    VprPermiteFechar := true;
  end;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItemCotacao := TRBDOrcProduto(VprDCotacao.Produtos.Items[GProdutos.ALinha - 1]);
  if VprIndConferindo then
    GProdutos.Cells[1,GProdutos.ALinha] := FormatFloat('#,###,##0.00',VprDItemCotacao.QtdConferido)
  else
    GProdutos.Cells[1,GProdutos.ALinha] := FormatFloat('#,###,##0.00',VprDItemCotacao.qtdaBaixar);
  if (VARIA.CNPJFilial = CNPJ_MetalVidros) or (varia.CNPJFilial =  CNPJ_VIDROMAX) then
    GProdutos.Cells[2,GProdutos.ALinha] := FormatFloat('#,###,##0.00',VprDItemCotacao.QtdProduto - VprDItemCotacao.QtdBaixadoNota)
  else
    GProdutos.Cells[2,GProdutos.ALinha] := FormatFloat('#,###,##0.00',VprDItemCotacao.QtdProduto);
  GProdutos.Cells[3,GProdutos.ALinha] := VprDItemCotacao.DesRefCliente;
  GProdutos.Cells[4,GProdutos.ALinha] := VprDItemCotacao.CodProduto;
  GProdutos.Cells[5,GProdutos.ALinha] := VprDItemCotacao.NomProduto;
  GProdutos.Cells[6,GProdutos.ALinha] := IntTostr(VprDItemCotacao.CodCor);
  GProdutos.Cells[7,GProdutos.ALinha] := VprDItemCotacao.DesCor;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.GProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if config.ControlarASeparacaodaCotacao then
  begin
    if not VprIndConferindo then
    begin
      if not VprDItemCotacao.IndPermiteAlterarQtdnaSeparacao then
      begin
        if VprDItemCotacao.SeqProduto <> VprProutoLiberado then
        begin
          aviso('PRODUTO INVÁLIDO!!!'#13'É necessário antes passar o produto no leitor de codigo de barras.');
          key := #0;
        end;
      end;
    end;
  end;

  if not(GProdutos.AColuna in [1])  then
    key := #0
  else
    if key = '.' then
      key := ',';

end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDCotacao.Produtos.Count > 0 then
  begin
    VprDItemCotacao := TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaLinhaAtual - 1]);
  end;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if VprIndConferindo then
    VprDItemCotacao.QtdConferido := StrToFloat(DeletaChars(GProdutos.Cells[1,GProdutos.ALinha],'.'))
  else
    VprDItemCotacao.QtdABaixar := StrToFloat(DeletaChars(GProdutos.Cells[1,GProdutos.ALinha],'.'));
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimePedidoParcial(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,VprSeqParcial);
  dtRave.free;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
        if (key = 87) then
        begin
          GeraFinanceiro;
          VprPressionadoR := false;
        end
        else
          VprPressionadoR := false;
  end;

end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.BEnviarClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.EProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if EProduto.AInteiro <> 0 then
    if key = 13 then
    begin
      EProduto.Atualiza;
      AdicionaProduto(EProduto.AInteiro);
      EProduto.clear;
    end;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.GProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
  begin
    ActiveControl := EProduto;
  end;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.GProdutosGetCellColor(Sender: TObject;
  ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush;
  AFont: TFont);
var
  VpfDItem : TRBDOrcProduto;
begin
  if (ACol > 0) and (ARow > 0) and (VprDCotacao <> nil) then
  begin
    if VprDCotacao.Produtos.Count > 0  then
    begin
     VpfDItem := TRBDOrcProduto(VprDCotacao.Produtos.Items[Arow - 1]);
     if VprIndConferindo then
     begin
       if VpfDItem.QtdBaixadoNota <= VpfDItem.QtdConferidoSalvo then
         ABrush.Color := clGray;
     end
     else
     begin
       if VpfDItem.QtdProduto <= VpfDItem.QtdBaixadoNota then
         ABrush.Color := clGray;
     end;
    end;
  end;

end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.FormShow(Sender: TObject);
begin
  try
    Som.Open;
  except
  end;
end;

{******************************************************************************}
procedure TFBaixaParcialCotacao.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := VprPermiteFechar;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFBaixaParcialCotacao]);
end.


