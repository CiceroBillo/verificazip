unit AImportacaoDados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Gauges, StdCtrls, Buttons, ComCtrls, Componentes1, ExtCtrls, PainelGradiente,
  DB, DBClient, Tabela, CBancoDados, SqlExpr, UnImportacaoDados, UnDados, UnCotacao, UnSistema;

type
  TFImportacaoDados = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GroupBox1: TGroupBox;
    PRegistros: TProgressBar;
    Label1: TLabel;
    LQtd: TLabel;
    Label2: TLabel;
    LNomTabela: TLabel;
    BImportacaoTotal: TBitBtn;
    PTabelas: TGauge;
    BFechar: TBitBtn;
    Animate1: TAnimate;
    TabelaMatriz: TRBSQL;
    Cadastro: TRBSQL;
    TabelasaImportarMatriz: TRBSQL;
    TabelasAImportarLocal: TRBSQL;
    Label3: TLabel;
    LHoraInicio: TLabel;
    Label4: TLabel;
    LHoraFim: TLabel;
    BMenuFiscal: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImportacaoTotalClick(Sender: TObject);
    procedure FPrincipalClientesExecute(Sender: TObject);
    procedure BMenuFiscalClick(Sender: TObject);
  private
    { Private declarations }
    VprRegistrosImportados : Integer;
    VprTransacao : TTransactionDesc;
    FunImportacaoDados : TRBFuncoesImportacaoDado;
    procedure ConfiguraPermissaoUsuario;
    function VendedorAtivo : Boolean;
    procedure ImportacaoTotal;
    procedure AtualizaCodigosClientes;
    procedure AtualizaNumerosPedidos;
    procedure AtualizaSequenciaisNotas;
    procedure AtualizaSequencialContasaReceber;
    procedure AtualizaSequencialComissao;
    procedure AtualizaNomeTabelaImportar(VpaNomeTabela : string);
    procedure IncrementaRegistro;
    procedure AtualizaDataUltimaImportacao(VpaDatImportacao : TDateTime);
  public
    { Public declarations }
  end;

var
  FImportacaoDados: TFImportacaoDados;

implementation

uses APrincipal, funstring, UnClientes, FunSql, Constmsg, Constantes, AVersaoDesatualizada, AMenuFiscalECF;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImportacaoDados.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ConfiguraPermissaoUsuario;
  FunImportacaoDados := TRBFuncoesImportacaoDado.cria(FPrincipal.BaseDados, FPrincipal.BaseDadosMatriz,LQtd,PRegistros);
end;

procedure TFImportacaoDados.FPrincipalClientesExecute(Sender: TObject);
begin

end;

{ **************************************************************************** }
procedure TFImportacaoDados.ImportacaoTotal;
Var
  VpfDImportacao : TRBDImportacaoDados;
  VpfDataImportacao : TDateTime;
begin
  VpfDataImportacao := FunImportacaoDados.RDataServidorMatriz;
  LHoraInicio.Caption := FormatDateTime('DD/MM/YYYY HH:MM:SS',VpfDataImportacao);
  LHoraInicio.Refresh;

  if not VendedorAtivo then
  begin
    aviso('VENDEDOR "'+IntToStr(Varia.CodVendedorSistemaPedidos)+'" INATIVO!!!'#13'Não é permitido importar os dados para o representante, pois o mesmo se encontra inativo');
    exit;
  end;

  PTabelas.Progress := 0;
  PTabelas.MaxValue :=  FunImportacaoDados.PosTabelasaImportar(TabelasAImportarMatriz)+5;

  AtualizaCodigosClientes;
  AtualizaNumerosPedidos;
  AtualizaSequenciaisNotas;
  AtualizaSequencialContasaReceber;
  AtualizaSequencialComissao;

  while not TabelasaImportarMatriz.Eof do
  begin
    VpfDImportacao := FunImportacaoDados.CarDImportacao(TabelasaImportarMatriz.FieldByName('CODTABELA').AsInteger);
    AtualizaNomeTabelaImportar(VpfDImportacao.Destabela+'('+VpfDImportacao.Nomtabela+')');
    if VpfDImportacao.CodTabela > 0 then
    begin
      if (TabelasaImportarMatriz.FieldByName('DATULTIMAALTERACAOMATRIZ').AsDateTime > VpfDImportacao.DatUltimaImportacao) or
         (TabelasaImportarMatriz.FieldByName('DATULTIMAALTERACAOMATRIZ').IsNull) then
      begin
        FunImportacaoDados.ImportaTabela(VpfDImportacao,VpfDataImportacao);
      end;
    end
    else
    begin
      //gravar em algum lugar o log das tabelas que náo estao sendo importadas por quais representantes;
    end;
    VpfDImportacao.Free;
    PTabelas.Progress := PTabelas.Progress+1;
    Application.ProcessMessages;
    TabelasaImportarMatriz.Next;
  end;
  LHoraFim.Caption := FormatDateTime('DD/MM/YYYY HH:MM:SS',FunImportacaoDados.RDataServidorMatriz);
  LNomTabela.Caption := 'Importação Realizada com Sucesso.';
  AtualizaDataUltimaImportacao(VpfDataImportacao);

  FVersaoDesatualizada := TFVersaoDesatualizada.criarSDI(Application,'',FPrincipal.VerificaPermisao('FVersaoDesatualizada'));
  if not FVersaoDesatualizada.VersaoSistemaPedidosValida then
  begin
    FVersaoDesatualizada.free;
    Application.Terminate;
  end;
end;

{ **************************************************************************** }
procedure TFImportacaoDados.AtualizaCodigosClientes;
var
  VpfQtdImportar, VpfLaco, VpfCodCliente : Integer;
begin
  AtualizaNomeTabelaImportar('CODIGOS CLIENTES');
  VpfQtdImportar := 100 - FunClientes.RQtdCodigosClientes;
  PRegistros.Max := VpfQtdImportar;

  TabelaMatriz.PacketRecords := VpfQtdImportar;
  VprTransacao.IsolationLevel :=xilDIRTYREAD;
  FPrincipal.BaseDadosMatriz.StartTransaction(VprTransacao);

  AdicionaSQLAbreTabela(Cadastro,'Select * from CODIGOCLIENTE ' +
                                 ' Where CODCLIENTE = 0');
  for  VpfLaco := 1 to VpfQtdImportar  do
  begin
    AdicionaSQLAbreTabela(TabelaMatriz,'Select MIN(CODCLIENTE) CODCLIENTE from CODIGOCLIENTE ');
    if TabelaMatriz.FieldByName('CODCLIENTE').AsInteger = 0 then
    begin
      aviso('FINAL DA FAIXA DOS CODIGOS DOS CLIENTES!!!'#13'Não existem codigos de clientes disponivel na Fabrica. Solicita a fabrica para que eles gerem mais codigo de clientes, após isso faça uma nova importação.');
      break;
    end;
    VpfCodCliente := TabelaMatriz.FieldByName('CODCLIENTE').AsInteger;
    ExecutaComandoSql(TabelaMatriz,'Delete from CODIGOCLIENTE  ' +
                                   ' Where CODCLIENTE = '+IntToStr(VpfCodCliente));
    Cadastro.Insert;
    cadastro.FieldByName('CODCLIENTE').AsInteger := VpfCodCliente;
    Cadastro.Post;
    IncrementaRegistro;
  end;
  Cadastro.Close;
  TabelaMatriz.Close;
  FPrincipal.BaseDadosMatriz.Commit(VprTransacao);
  PTabelas.Progress := PTabelas.Progress +1;
end;

{ **************************************************************************** }
procedure TFImportacaoDados.AtualizaDataUltimaImportacao(VpaDatImportacao : TDateTime);
begin
  AdicionaSQLAbreTabela(TabelasAImportarLocal,'Select * from CFG_GERAL');
  TabelasAImportarLocal.edit;
  TabelasAImportarLocal.fieldbyname('D_ULT_IMP').ASdatetime := VpaDatImportacao;
  TabelasAImportarLocal.post;
  varia.DatUltimaImportacao := VpaDatImportacao;
end;

{ **************************************************************************** }
procedure TFImportacaoDados.AtualizaNomeTabelaImportar(VpaNomeTabela: string);
begin
  LNomTabela.Caption := AdicionaCharD(' ',VpaNomeTabela,50);
  LNomTabela.Refresh;
  PRegistros.Position := 0;
  VprRegistrosImportados := 0;
end;

{ **************************************************************************** }
procedure TFImportacaoDados.AtualizaNumerosPedidos;
var
  VpfQtdImportar, VpfLaco, VpfNumeroPedido : Integer;
begin
  AtualizaNomeTabelaImportar('NUMERO PEDIDO');
  AdicionaSQLAbreTabela(TabelasAImportarLocal,'Select I_EMP_FIL from CADFILIAIS ');
  while not TabelasAImportarLocal.Eof do
  begin
    VpfQtdImportar := 100 - FunCotacao.RQtdNumeroPedido(TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsInteger);
    PRegistros.Max := VpfQtdImportar;

    TabelaMatriz.PacketRecords := VpfQtdImportar;
    VprTransacao.IsolationLevel :=xilDIRTYREAD;
    FPrincipal.BaseDadosMatriz.StartTransaction(VprTransacao);

    AdicionaSQLAbreTabela(Cadastro,'Select * from NUMEROPEDIDO ' +
                                   ' WHERE CODFILIAL =0 AND NUMPEDIDO = 0');
    for  VpfLaco := 1 to VpfQtdImportar  do
    begin
      AdicionaSQLAbreTabela(TabelaMatriz,'Select min(NUMPEDIDO) NUMPEDIDO from NUMEROPEDIDO'+
                                       ' Where CODFILIAL = '+TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsString+
                                       ' ORDER BY NUMPEDIDO');
      if TabelaMatriz.FieldByName('NUMPEDIDO').AsInteger = 0 then
      begin
        aviso('FINAL DA FAIXA DOS NUMEROS DOS PEDIDOS!!!'#13'Não existem numeros de pedidos disponivel na Fabrica. Solicita a fabrica para que eles gerem mais numeros de pedidos, após isso faça uma nova importação.');
        break;
      end;
      VpfNumeroPedido := TabelaMatriz.FieldByName('NUMPEDIDO').AsInteger;
      ExecutaComandoSql(TabelaMatriz,'DELETE FROM NUMEROPEDIDO '+
                                     ' Where CODFILIAL = '+TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsString+
                                     ' AND NUMPEDIDO = '+IntToStr(VpfNumeroPedido));
      Cadastro.Insert;
      cadastro.FieldByName('CODFILIAL').AsInteger := TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsInteger;
      cadastro.FieldByName('NUMPEDIDO').AsInteger := VpfNumeroPedido;
      Cadastro.Post;
      IncrementaRegistro;
    end;
    TabelasAImportarLocal.Next;
    FPrincipal.BaseDadosMatriz.Commit(VprTransacao);
  end;
  Cadastro.Close;
  TabelaMatriz.Close;
  TabelasAImportarLocal.Close;
  PTabelas.Progress := PTabelas.Progress +1;
end;

{******************************************************************************}
procedure TFImportacaoDados.AtualizaSequencialContasaReceber;
var
  VpfQtdImportar, VpfLaco, VpfSequencial : Integer;
begin
  AtualizaNomeTabelaImportar('SEQUENCIAL CONTAS A RECEBER');
  AdicionaSQLAbreTabela(TabelasAImportarLocal,'Select I_EMP_FIL from CADFILIAIS ');
  while not TabelasAImportarLocal.Eof do
  begin
    VpfQtdImportar := 100 - Sistema.RQtdSequenciaContasaReceberFilial(TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsInteger);
    PRegistros.Max := VpfQtdImportar;

    TabelaMatriz.PacketRecords := VpfQtdImportar;
    VprTransacao.IsolationLevel :=xilDIRTYREAD;
    FPrincipal.BaseDadosMatriz.StartTransaction(VprTransacao);

    AdicionaSQLAbreTabela(Cadastro,'Select * from SEQUENCIALCONTASARECEBER ' +
                                   ' WHERE CODFILIAL =0 AND LANRECEBER = 0');
    for  VpfLaco := 1 to VpfQtdImportar  do
    begin
      AdicionaSQLAbreTabela(TabelaMatriz,'Select min(LANRECEBER) LANRECEBER from SEQUENCIALCONTASARECEBER '+
                                       ' Where CODFILIAL = '+TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsString);
      if TabelaMatriz.FieldByName('LANRECEBER').AsInteger = 0 then
      begin
        aviso('FINAL DA FAIXA DOS SEQUENCIAIS DO CONTAS A RECEBER!!!'#13'Não existem sequenciais de contas a receber disponivel na Fabrica. Solicita a fabrica para que eles gerem mais sequenciais de contas a receber, após isso faça uma nova importação.');
        break;
      end;
      VpfSequencial := TabelaMatriz.FieldByName('LANRECEBER').AsInteger;
      ExecutaComandoSql(TabelaMatriz,'DELETE FROM SEQUENCIALCONTASARECEBER '+
                                     ' Where CODFILIAL = '+TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsString+
                                     ' AND LANRECEBER = '+IntToStr(VpfSequencial));
      Cadastro.Insert;
      cadastro.FieldByName('CODFILIAL').AsInteger := TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsInteger;
      cadastro.FieldByName('LANRECEBER').AsInteger := VpfSequencial;
      Cadastro.Post;
      IncrementaRegistro;
    end;
    TabelasAImportarLocal.Next;
    FPrincipal.BaseDadosMatriz.Commit(VprTransacao);
  end;
  Cadastro.Close;
  TabelaMatriz.Close;
  TabelasAImportarLocal.Close;
  PTabelas.Progress := PTabelas.Progress +1;
end;

{******************************************************************************}
procedure TFImportacaoDados.AtualizaSequenciaisNotas;
var
  VpfQtdImportar, VpfLaco, VpfSequencial : Integer;
begin
  AtualizaNomeTabelaImportar('SEQUENCIAL NOTA');
  AdicionaSQLAbreTabela(TabelasAImportarLocal,'Select I_EMP_FIL from CADFILIAIS ');
  while not TabelasAImportarLocal.Eof do
  begin
    VpfQtdImportar := 100 - Sistema.RQtdNumerosNotasFilial(TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsInteger);
    PRegistros.Max := VpfQtdImportar;

    TabelaMatriz.PacketRecords := VpfQtdImportar;
    VprTransacao.IsolationLevel :=xilDIRTYREAD;
    FPrincipal.BaseDadosMatriz.StartTransaction(VprTransacao);

    AdicionaSQLAbreTabela(Cadastro,'Select * from NUMERONOTA ' +
                                   ' WHERE CODFILIAL =0 AND SEQNOTA = 0');
    for  VpfLaco := 1 to VpfQtdImportar  do
    begin
      AdicionaSQLAbreTabela(TabelaMatriz,'Select min(SEQNOTA) SEQNOTA from NUMERONOTA '+
                                       ' Where CODFILIAL = '+TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsString);
      if TabelaMatriz.FieldByName('SEQNOTA').AsInteger = 0 then
      begin
        aviso('FINAL DA FAIXA DOS SEQUENCIAIS DAS NOTAS!!!'#13'Não existem sequenciais de nota disponivel na Fabrica. Solicita a fabrica para que eles gerem mais sequenciais de notas, após isso faça uma nova importação.');
        break;
      end;
      VpfSequencial := TabelaMatriz.FieldByName('SEQNOTA').AsInteger;
      ExecutaComandoSql(TabelaMatriz,'DELETE FROM NUMERONOTA '+
                                     ' Where CODFILIAL = '+TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsString+
                                     ' AND SEQNOTA = '+IntToStr(VpfSequencial));
      Cadastro.Insert;
      cadastro.FieldByName('CODFILIAL').AsInteger := TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsInteger;
      cadastro.FieldByName('SEQNOTA').AsInteger := VpfSequencial;
      Cadastro.Post;
      IncrementaRegistro;
    end;
    TabelasAImportarLocal.Next;
    FPrincipal.BaseDadosMatriz.Commit(VprTransacao);
  end;
  Cadastro.Close;
  TabelaMatriz.Close;
  TabelasAImportarLocal.Close;
  PTabelas.Progress := PTabelas.Progress +1;
end;

{******************************************************************************}
procedure TFImportacaoDados.AtualizaSequencialComissao;
var
  VpfQtdImportar, VpfLaco, VpfSequencial : Integer;
begin
  AtualizaNomeTabelaImportar('SEQUENCIAL COMISSÃO');
  AdicionaSQLAbreTabela(TabelasAImportarLocal,'Select I_EMP_FIL from CADFILIAIS ');
  while not TabelasAImportarLocal.Eof do
  begin
    AtualizaNomeTabelaImportar('SEQUENCIAL COMISSÃO FILIAL "'+TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsString+'"');
    VpfQtdImportar := 100 - Sistema.RQtdSequenciaComissaoFilial(TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsInteger);
    PRegistros.Max := VpfQtdImportar;
    PRegistros.Position := 0;

    TabelaMatriz.PacketRecords := VpfQtdImportar;
    VprTransacao.IsolationLevel :=xilDIRTYREAD;
    FPrincipal.BaseDadosMatriz.StartTransaction(VprTransacao);

    AdicionaSQLAbreTabela(Cadastro,'Select * from SEQUENCIALCOMISSAO ' +
                                   ' WHERE CODFILIAL =0 AND SEQCOMISSAO = 0');
    for  VpfLaco := 1 to VpfQtdImportar  do
    begin
      AdicionaSQLAbreTabela(TabelaMatriz,'Select min(SEQCOMISSAO) SEQCOMISSAO from SEQUENCIALCOMISSAO '+
                                       ' Where CODFILIAL = '+TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsString);
      if TabelaMatriz.FieldByName('SEQCOMISSAO').AsInteger = 0 then
      begin
        aviso('FINAL DA FAIXA DOS SEQUENCIAIS DA COMISSAO!!!'#13'Não existem sequenciais de comissão disponivel na Fabrica. Solicita a fabrica para que eles gerem mais sequenciais de comissão, após isso faça uma nova importação.');
        break;
      end;
      VpfSequencial := TabelaMatriz.FieldByName('SEQCOMISSAO').AsInteger;
      ExecutaComandoSql(TabelaMatriz,'DELETE FROM SEQUENCIALCOMISSAO '+
                                     ' Where CODFILIAL = '+TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsString+
                                     ' AND SEQCOMISSAO = '+IntToStr(VpfSequencial));
      Cadastro.Insert;
      cadastro.FieldByName('CODFILIAL').AsInteger := TabelasAImportarLocal.FieldByName('I_EMP_FIL').AsInteger;
      cadastro.FieldByName('SEQCOMISSAO').AsInteger := VpfSequencial;
      Cadastro.Post;
      IncrementaRegistro;
    end;
    TabelasAImportarLocal.Next;
    FPrincipal.BaseDadosMatriz.Commit(VprTransacao);
  end;
  Cadastro.Close;
  TabelaMatriz.Close;
  TabelasAImportarLocal.Close;
  PTabelas.Progress := PTabelas.Progress +1;
end;

{ **************************************************************************** }
procedure TFImportacaoDados.IncrementaRegistro;
begin
  inc(VprRegistrosImportados);
  LQtd.Caption := IntToStr(VprRegistrosImportados);
  LQtd.Refresh;
  PRegistros.StepBy(1);
end;

{ **************************************************************************** }
function TFImportacaoDados.VendedorAtivo: Boolean;
begin
  AdicionaSQLAbreTabela(TabelaMatriz,'Select C_IND_ATI FROM CADVENDEDORES ' +
                                     ' Where I_COD_VEN = '+IntToStr(varia.CodVendedorSistemaPedidos));
  result := TabelaMatriz.FieldByName('C_IND_ATI').AsString = 'S';
  TabelaMatriz.Close;
end;

{ **************************************************************************** }
procedure TFImportacaoDados.BFecharClick(Sender: TObject);
begin
  close;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImportacaoDados.BImportacaoTotalClick(Sender: TObject);
begin
  ImportacaoTotal;
end;

{******************************************************************************}
procedure TFImportacaoDados.BMenuFiscalClick(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

{******************************************************************************}
procedure TFImportacaoDados.ConfiguraPermissaoUsuario;
begin
  BMenuFiscal.Visible := NomeModulo = 'PDV';
end;

{******************************************************************************}
procedure TFImportacaoDados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunImportacaoDados.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImportacaoDados]);
end.
