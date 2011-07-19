unit AEnviaEmailCobrancaPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Gauges,UnDados,
  ComCtrls, DB, DBClient, Tabela, CBancoDados, UnPedidoCompra, FunSql, constmsg;

type
  TFEnviaEmailCobrancaPedidoCompra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BarraStatus: TStatusBar;
    Animacao: TAnimate;
    Progresso: TProgressBar;
    BEnviar: TBitBtn;
    Aux: TRBSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
  private
    FunPedidoCompra: TRBFunPedidoCompra;
    VprDEmailECobrancaCompraCorpo: TRBDEmailECobrancaCompraCorpo;
    VprDEmailECobrancaCompraItem: TRBDEmailECobrancaCompraItem;

    procedure AtualizaBarraStatus(VpaTexto : String);
    procedure EnviarEmailPedidoCompra;
    procedure InicializaDadosECobrancaCompraCorpo;
    procedure InicializaDadosECobrancaCompraItem;
  public
    procedure EnviarEmails;
  end;

var
  FEnviaEmailCobrancaPedidoCompra: TFEnviaEmailCobrancaPedidoCompra;

implementation
{$R *.DFM}

  uses
  UnSistema, UnClientes, Constantes, APrincipal;




{ ****************** Na criação do Formulário ******************************** }
procedure TFEnviaEmailCobrancaPedidoCompra.FormCreate(Sender: TObject);
begin
  { abre tabelas }
  { chamar a rotina de atualização de menus }
  FunPedidoCompra := TRBFunPedidoCompra.Cria(FPrincipal.BaseDados);
  VprDEmailECobrancaCompraItem:= TRBDEmailECobrancaCompraItem.cria;
end;

{******************************************************************************}
procedure TFEnviaEmailCobrancaPedidoCompra.InicializaDadosECobrancaCompraCorpo;
begin
  VprDEmailECobrancaCompraCorpo := TRBDEmailECobrancaCompraCorpo.cria;
  VprDEmailECobrancaCompraCorpo.SeqEmail := FunPedidoCompra.RSeqPedidoDisponivel(Varia.CodigoFilial);
  VprDEmailECobrancaCompraCorpo.CodUsuario := varia.CodigoUsuario;
  VprDEmailECobrancaCompraCorpo.DataEnvio := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFEnviaEmailCobrancaPedidoCompra.InicializaDadosECobrancaCompraItem;
begin
  VprDEmailECobrancaCompraItem := VprDEmailECobrancaCompraCorpo.AddItem;
  VprDEmailECobrancaCompraItem.CodFilial     := Aux.FieldByName('CODFILIAL').AsInteger;
  VprDEmailECobrancaCompraItem.SeqPedido     := Aux.FieldByName('SEQPEDIDO').AsInteger;
  VprDEmailECobrancaCompraItem.Enviado       := 'N';
  VprDEmailECobrancaCompraItem.NomFornecedor := FunClientes.RNomCliente(Aux.FieldByName('CODCLIENTE').AsString);
  VprDEmailECobrancaCompraItem.Status        := '';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEnviaEmailCobrancaPedidoCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunPedidoCompra.Free;
  VprDEmailECobrancaCompraItem.Free;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEnviaEmailCobrancaPedidoCompra.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFEnviaEmailCobrancaPedidoCompra.AtualizaBarraStatus(VpaTexto: String);
begin
  BarraStatus.Panels[0].Text:= VpaTexto;
  BarraStatus.Refresh;
end;

{******************************************************************************}
procedure TFEnviaEmailCobrancaPedidoCompra.BEnviarClick(Sender: TObject);
begin
  BEnviar.Enabled := false;
  InicializaDadosECobrancaCompraCorpo;
  EnviarEmailPedidoCompra;
  AtualizaBarraStatus('E-mail''s enviados com sucesso.');
  BEnviar.Enabled := true;
end;

{******************************************************************************}
procedure TFEnviaEmailCobrancaPedidoCompra.EnviarEmailPedidoCompra;
var
  VpfDPedidoCompra : TRBDPedidoCompraCorpo;
  VpfResultado, VpfResultado1    : String;
  VpfCodFornecedor : integer;
begin
  VpfCodFornecedor := -1;
  VpfDPedidoCompra := TRBDPedidoCompraCorpo.Cria;
  AdicionaSqlAbreTabela(Aux,' Select CODFILIAL, SEQPEDIDO, CODCLIENTE ' +
                            '   from PEDIDOCOMPRACORPO                ' +
                            '  Where DATENTREGA IS NULL               ' +
                            '    AND DATPREVISTA < TRUNC(SYSDATE)     ' +
                            ' ORDER BY CODCLIENTE');

  Aux.First;
  Animacao.Active := True;
  Progresso.Max := Aux.RecordCount;
  Progresso.Position := 0;
  while not Aux.Eof do
  begin
    AtualizaBarraStatus('Filial : '+ Aux.FieldByName('CODFILIAL').AsString +' Pedido de Compra : ' +
                        Aux.FieldByName('SEQPEDIDO').AsString + ' Fornecedor: '+
                        VprDEmailECobrancaCompraItem.NomFornecedor);
    InicializaDadosECobrancaCompraItem;
    if VpfCodFornecedor <> Aux.FieldByName('CODCLIENTE').AsInteger then
    begin
      FunPedidoCompra.CarDPedidoCompra(Aux.FieldByName('CODFILIAL').AsInteger,
                                      Aux.FieldByName('SEQPEDIDO').AsInteger,
                                      VpfDPedidoCompra);
      VpfResultado := FunPedidoCompra.EnviaEmailCobrancaFornecedor(VpfDPedidoCompra);
      if VpfResultado = '' then
      begin
        VprDEmailECobrancaCompraItem.Enviado := 'S'
      end
      else
      begin
        VprDEmailECobrancaCompraItem.Status  := VpfResultado;
        VprDEmailECobrancaCompraItem.Enviado := 'N';
      end;
    end;
    VpfResultado1:= FunPedidoCompra.GravaDEmailPedidoCompra(VprDEmailECobrancaCompraCorpo);

     Progresso.Position := Progresso.Position + 1;

     Aux.Next;
  end;
  Aux.close;
  Animacao.Active := false;
  AtualizaBarraStatus('e-mail''s enviados com sucesso.');
  //VpfResultado := FunPedidoCompra.GravaDEmailMedidor(VprDMedidores);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    aviso('Email''s enviados com sucesso!');
  VpfDPedidoCompra.Free;
end;

{******************************************************************************}
procedure TFEnviaEmailCobrancaPedidoCompra.EnviarEmails;
begin
  ShowModal;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEnviaEmailCobrancaPedidoCompra]);
end.
