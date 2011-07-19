unit AAlteraClienteVendedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Buttons, StdCtrls, Componentes1, Localizacao, SqlExpr, ConstMsg, FunSql, Tabela, Constantes;

type
  TFAlteraClienteVendedor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor10: TPanelColor;
    Label44: TLabel;
    Label54: TLabel;
    PanelColor3: TBevel;
    PanelColor4: TBevel;
    ECliente: TEditLocaliza;
    SpeedButton11: TSpeedButton;
    Label35: TLabel;
    Label34: TLabel;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    EVendedor: TEditLocaliza;
    Label10: TLabel;
    Label1: TLabel;
    ECidade: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    LCidade: TLabel;
    Label2: TLabel;
    EVendedorDestino: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    PanelColor2: TPanelColor;
    BAlterar: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    CCliente: TCheckBox;
    CProspect: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
  private
     VprQtdClientes, VprSeqAlteracao, VprSeqItemCorpo: Integer;
     AuxCli, Aux  : TSQLQuery;
     CliCadastro: TSQL;
     function RQtdTotalClientes: integer;
     function AlteraClienteVendedor: String;
     function GravaDAlteraClientesVendedor: String;
     function GravaDAlteraClientesVendedorItem(VpaCodCliente: Integer): String;
     procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FAlteraClienteVendedor: TFAlteraClienteVendedor;

implementation

uses APrincipal, UnClientes;

{$R *.DFM}


{ **************************************************************************** }
procedure TFAlteraClienteVendedor.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Aux := TSQLQUERY.Create(nil);
  Aux.SQLConnection := FPrincipal.BaseDados;
  AuxCli := TSQLQUERY.Create(nil);
  AuxCli.SQLConnection := FPrincipal.BaseDados;
  CliCadastro := TSQL.Create(nil);
  Clicadastro.ASQLConnection := FPrincipal.BaseDados;
end;

{******************************************************************************}
function TFAlteraClienteVendedor.GravaDAlteraClientesVendedor: String;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from ALTERACLIENTEVENDEDOR  '+
                                    ' Where SEQITEM = 0 ');
  CliCadastro.insert;
  CliCadastro.FieldByname('CODUSUARIO').AsInteger:= Varia.CodigoUsuario;
  CliCadastro.FieldByname('DATALTERACAO').AsDateTime:= now;
  CliCadastro.FieldByname('CODVENDEDORORIGEM').AsInteger:= EVendedor.AInteiro;
  CliCadastro.FieldByname('CODCLIENTEORIGEM').AsInteger:= ECliente.AInteiro;
  CliCadastro.FieldByname('CODCIDADEORIGEM').AsInteger:= ECidade.AInteiro;
  CliCadastro.FieldByname('CODVENDEDORDESTINO').AsInteger:= EVendedorDestino.AInteiro;
  CliCadastro.FieldByname('QTDREGISTROSALTERADOS').AsInteger:= VprQtdClientes;
  VprSeqAlteracao:= FunClientes.RSeqDisponivelAlteraClienteVendedor;
  CliCadastro.FieldByname('SEQITEM').AsInteger:= VprSeqAlteracao;
  CliCadastro.post;
  result := CliCadastro.AMensagemErroGravacao;
  CliCadastro.close;
end;

{******************************************************************************}
function TFAlteraClienteVendedor.GravaDAlteraClientesVendedorItem(VpaCodCliente: Integer): String;
begin
  result := '';
  AdicionaSQLAbreTabela(CliCadastro,'Select * from ALTERACLIENTEVENDEDORITEM  '+
                                    ' Where SEQITEMALTERACLIENTEVENDEDOR = 0 and SEQITEM = 0 ');
  CliCadastro.insert;
  CliCadastro.FieldByname('SEQITEMALTERACLIENTEVENDEDOR').AsInteger:= VprSeqAlteracao;
  CliCadastro.FieldByname('SEQITEM').AsInteger:= VprSeqItemCorpo;
  CliCadastro.FieldByname('CODCLIENTE').AsInteger:= VpaCodCliente;
  CliCadastro.post;
  result := CliCadastro.AMensagemErroGravacao;
  CliCadastro.close;
end;

{******************************************************************************}
function TFAlteraClienteVendedor.RQtdTotalClientes: integer;
begin
  aux.close;
  aux.sql.clear;
  aux.SQl.add('SELECT COUNT(I_COD_CLI) QTDCLIENTES FROM CADCLIENTES CLI' +
              ' WHERE CLI.I_COD_CLI = CLI.I_COD_CLI' );
  AdicionaFiltros(aux.Sql);
  aux.open;
  Result:= AUX.FieldByName('QTDCLIENTES').AsInteger;
end;

{ *************************************************************************** }
procedure TFAlteraClienteVendedor.AdicionaFiltros(VpaSelect: TStrings);
begin
  if EVendedor.AInteiro <> 0 then
    VpaSelect.Add(' and CLI.I_COD_VEN = '+ IntToStr(EVendedor.AInteiro));

  if ECliente.AInteiro <> 0 then
    VpaSelect.Add(' AND CLI.I_COD_CLI =' + IntToStr(ECliente.AInteiro));

  if ECidade.AInteiro <> 0 then
    VpaSelect.add(' and CLI.C_CID_CLI = '''+LCidade.Caption+'''');
  if CCliente.Checked then
    VpaSelect.add(' and CLI.C_IND_CLI = ''S''');
  if CProspect.Checked then
    VpaSelect.add(' and CLI.C_IND_PRC = ''S''');

end;

{******************************************************************************}
function TFAlteraClienteVendedor.AlteraClienteVendedor: String;
Var
  VpfResultado: String;
begin
  VprSeqItemCorpo:=1;
  aux.close;
  aux.sql.clear;
  aux.SQl.add('SELECT * FROM CADCLIENTES CLI' +
              ' WHERE CLI.I_COD_CLI = CLI.I_COD_CLI' );
  AdicionaFiltros(aux.Sql);
  aux.open;
  while not Aux.Eof do
  begin
    ExecutaComandoSql(AuxCli,' UPDATE CADCLIENTES SET I_COD_VEN = '+ IntToStr(EVendedorDestino.AInteiro) +
                             ' WHERE I_COD_CLI = ' + IntToStr(AUX.FieldByName('I_COD_CLI').AsInteger));
    VpfResultado:= GravaDAlteraClientesVendedorItem(AUX.FieldByName('I_COD_CLI').AsInteger);
    if VpfResultado <> '' then
      break
    else
    aux.Next;
    VprSeqItemCorpo:=VprSeqItemCorpo+1;
  end;
end;

{******************************************************************************}
procedure TFAlteraClienteVendedor.BAlterarClick(Sender: TObject);
Var
  VpfResultado: String;
begin
  VprQtdClientes:= RQtdTotalClientes;
  VpfResultado:= GravaDAlteraClientesVendedor;
  if VpfResultado = '' then
    VpfResultado:= AlteraClienteVendedor;
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    close;
end;

{******************************************************************************}
procedure TFAlteraClienteVendedor.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAlteraClienteVendedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  aux.Free;
  AuxCli.Free;
  CliCadastro.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraClienteVendedor]);
end.
