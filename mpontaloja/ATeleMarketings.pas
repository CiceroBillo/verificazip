unit ATeleMarketings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Db, DBTables,
  Localizacao, Grids, DBGrids, Tabela, DBKeyViolation, ComCtrls, DBCtrls,
  Mask, numericos, Graficos, Menus, DBClient;

type
  TFTeleMarketings = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Label18: TLabel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label4: TLabel;
    BUsuario: TSpeedButton;
    LNomUsuario: TLabel;
    ECodCliente: TEditLocaliza;
    ECodUsuario: TEditLocaliza;
    ConsultaPadrao1: TConsultaPadrao;
    Ligacoes: TSQL;
    DataLigacoes: TDataSource;
    LigacoesSEQTELE: TFMTBCDField;
    LigacoesDATLIGACAO: TSQLTimeStampField;
    LigacoesLANORCAMENTO: TFMTBCDField;
    LigacoesDESFALADOCOM: TWideStringField;
    LigacoesDESOBSERVACAO: TWideStringField;
    LigacoesC_NOM_CLI: TWideStringField;
    LigacoesC_NOM_USU: TWideStringField;
    LigacoesDESHISTORICO: TWideStringField;
    PanelColor3: TPanelColor;
    Grade: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    LigacoesDATTEMPOLIGACAO: TSQLTimeStampField;
    PanelColor4: TPanelColor;
    CAtualizarTotais: TCheckBox;
    EQtdLigacoes: Tnumerico;
    Label2: TLabel;
    Aux: TSQL;
    BGraficoOperador: TBitBtn;
    GraficosTrio: TGraficosTrio;
    BGraficoTempo: TBitBtn;
    PopupMenu1: TPopupMenu;
    VerCotao1: TMenuItem;
    BGraficoHistorico: TBitBtn;
    ECodHistorico: TEditLocaliza;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    N1: TMenuItem;
    TeleMarketingReceptivo1: TMenuItem;
    LigacoesCODCLIENTE: TFMTBCDField;
    Label7: TLabel;
    ETempoTotal: TEditColor;
    ETempoMedio: TEditColor;
    Label8: TLabel;
    BLigacoesDia: TBitBtn;
    BPedidosPorTipo: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeOrdem(Ordem: String);
    procedure EDatInicioExit(Sender: TObject);
    procedure CAtualizarTotaisClick(Sender: TObject);
    procedure BGraficoOperadorClick(Sender: TObject);
    procedure BGraficoTempoClick(Sender: TObject);
    procedure VerCotao1Click(Sender: TObject);
    procedure BGraficoHistoricoClick(Sender: TObject);
    procedure TeleMarketingReceptivo1Click(Sender: TObject);
    procedure BLigacoesDiaClick(Sender: TObject);
    procedure BPedidosPorTipoClick(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    procedure AtualizaConsulta;
    procedure Adicionafiltros(VpaComandoSql : TStrings);
    function RQtdLigacoes(VAR VpaTempoTotal : INTEGER) : Integer;
    function RHoraFormatada(VpaQtdSegundos:Integer):string;
    procedure ConfiguraPermissaoUsuario;
  public
    { Public declarations }
    procedure ConsultaHistoricos;
    procedure HitoricoLigacoes(VpaCodCliente : Integer);
  end;

var
  FTeleMarketings: TFTeleMarketings;

implementation

uses APrincipal, FunSql, FunData, constantes, ANovaCotacao,
  ANovoTeleMarketing,funString, FunNumeros;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTeleMarketings.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ConfiguraPermissaoUsuario;
  EDatInicio.DateTime := date;
  EDatFim.Datetime := date;
  VprOrdem := 'order by TEL.DATLIGACAO'
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTeleMarketings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Ligacoes.close;
  Aux.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTeleMarketings.AtualizaConsulta;
begin
  Ligacoes.close;
  Ligacoes.Sql.clear;
  Ligacoes.sql.add('select TEL.SEQTELE, TEL.DATLIGACAO,TEL.LANORCAMENTO, TEL.DESFALADOCOM, TEL.DESOBSERVACAO, '+
                   ' TEL.DATTEMPOLIGACAO, CODCLIENTE, '+
                   ' CLI.C_NOM_CLI, '+
                   ' USU.C_NOM_USU, '+
                   ' HIS.DESHISTORICO '+
                   ' from TELEMARKETING TEL, CADCLIENTES CLI, CADUSUARIOS USU, HISTORICOLIGACAO HIS '+
                   ' Where TEL.CODCLIENTE = CLI.I_COD_CLI '+
                   ' and TEL.CODUSUARIO = USU.I_COD_USU '+
                   ' and TEL.CODHISTORICO = HIS.CODHISTORICO ');
  Adicionafiltros(Ligacoes.Sql);
  Ligacoes.sql.add(VprOrdem);
  Ligacoes.open;
  Grade.ALinhaSQLOrderBy := Ligacoes.sql.count - 1;
  CAtualizarTotaisClick(CAtualizarTotais);
end;

{******************************************************************************}
procedure TFTeleMarketings.Adicionafiltros(VpaComandoSql : TStrings);
begin
  if CPeriodo.Checked then
    VpaComandoSql.add(SQLTextoDataEntreAAAAMMDD('TEL.DATLIGACAO',EDatInicio.DateTime,incdia(EDatFim.Datetime,1),true));
  if ECodCliente.AInteiro <> 0 then
    VpaComandoSql.Add(' and TEL.CODCLIENTE = '+ECodCliente.Text);
  if ECodUsuario.Ainteiro <> 0 then
    VpaComandoSql.add(' and TEL.CODUSUARIO = '+ECodUsuario.Text);
  if ECodHistorico.AInteiro <> 0 then
    VpaComandoSql.add(' and TEL.CODHISTORICO = '+ECodHistorico.Text);
end;

{******************************************************************************}
function TFTeleMarketings.RQtdLigacoes(VAR VpaTempoTotal : INTEGER) : Integer;
begin
  Aux.sql.clear;
  Aux.sql.add('Select count(*) QTD, SUM(QTDSEGUNDOSLIGACAO) TEMPO  from TELEMARKETING TEL '+
              ' Where TEL.CODFILIAL = TEL.CODFILIAL');
  Adicionafiltros(Aux.SQL);
  Aux.open;
  result := Aux.FieldByName('QTD').AsInteger;
  VpaTempoTotal := Aux.FieldByName('TEMPO').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TFTeleMarketings.RHoraFormatada(VpaQtdSegundos:Integer):string;
var
  VpfQtdHoras : Integer;
begin
{  if VpaQtdSegundos div 60 > 60 then
    result := AdicionaCharE('0',IntToStr(VpaQtdSegundos div 60),2)+':' +AdicionaCharE('0',IntToStr(VpaQtdSegundos mod 60),2)
  else}
  begin
    VpfQtdHoras := ((VpaQtdSegundos div 60)div 60);
    VpaQtdSegundos := VpaQtdSegundos - (VpfQtdHoras *60 *60);
    result := AdicionaCharE('0',IntToStr(VpfQtdHoras),2)+':'+AdicionaCharE('0',IntToStr(VpaQtdSegundos div 60),2)+':' +AdicionaCharE('0',IntToStr(VpaQtdSegundos mod 60),2)
  end;
end;

{******************************************************************************}
procedure TFTeleMarketings.ConfiguraPermissaoUsuario;
begin
  if (puSomenteClientesdoVendedor in varia.PermissoesUsuario) then
  begin
    ECodUsuario.AInteiro := Varia.CodigoUsuario;
    ECodUsuario.Atualiza;
    ECodUsuario.Enabled := false;
    BUsuario.Enabled := false;
    LNomUsuario.Enabled := false;
  end;
end;

{******************************************************************************}
procedure TFTeleMarketings.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTeleMarketings.ConsultaHistoricos;
begin
  AtualizaConsulta;
  Showmodal;
end;

{******************************************************************************}
procedure TFTeleMarketings.HitoricoLigacoes(VpaCodCliente : Integer);
begin
  CPeriodo.Checked := false;
  ECodCliente.AInteiro := VpaCodCliente;
  ECodCliente.Atualiza;
  VprOrdem := 'order by TEL.DATLIGACAO DESC';
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFTeleMarketings.GradeOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFTeleMarketings.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTeleMarketings.CAtualizarTotaisClick(Sender: TObject);
var
  VpfTempoTotal : Integer;
begin
  if CAtualizarTotais.Checked then
  begin
    EQtdLigacoes.AValor := RQtdLigacoes(VpfTempototal);
    ETempoTotal.Text := RHoraFormatada(VpfTempoTotal);
    ETempoMedio.Text := RHoraFormatada(RetornaInteiro(VpfTempoTotal / EQtdLigacoes.AValor));

  end;

end;

{******************************************************************************}
procedure TFTeleMarketings.BGraficoOperadorClick(Sender: TObject);
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('select COUNT(*) QTD,  USU.C_NOM_USU '+
                    ' from TELEMARKETING TEL, CADUSUARIOS USU '+
                    ' Where  TEL.CODUSUARIO = USU.I_COD_USU ');
  Adicionafiltros(VpfComandoSql);
  VpfComandoSql.Add('GROUP BY USU.C_NOM_USU') ;
  graficostrio.info.CampoValor := 'QTD';
  graficostrio.info.TituloY := 'Quantidade';
  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;

  graficostrio.info.CampoRotulo := 'C_NOM_USU';
  graficostrio.info.TituloGrafico := 'Gráficos por Operador - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := 'Gráfico de ligações por Operador';
  graficostrio.info.TituloFormulario := 'Gráfico de ligações por Operador';
  graficostrio.info.TituloX := 'Operador';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFTeleMarketings.BGraficoTempoClick(Sender: TObject);
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('select QTDSEGUNDOSLIGACAO, DATLIGACAO '+
                    ' from TELEMARKETING TEL'+
                    ' Where  TEL.CODFILIAL = TEL.CODFILIAL ');
  Adicionafiltros(VpfComandoSql);
  VpfComandoSql.Add('order by DATLIGACAO') ;
  graficostrio.info.CampoValor := 'QTDSEGUNDOSLIGACAO';
  graficostrio.info.TituloY := 'Segundos';
  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;

  graficostrio.info.CampoRotulo := 'DATLIGACAO';
  graficostrio.info.TituloGrafico := 'Gráficos Tempo da Ligacação - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := 'Gráfico de Tempo da Ligacação';
  graficostrio.info.TituloFormulario := 'Gráfico de Tempo da Ligação.';
  graficostrio.info.TituloX := 'Data Ligação';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFTeleMarketings.VerCotao1Click(Sender: TObject);
begin
  if LigacoesLANORCAMENTO.AsInteger <> 0 then
  begin
    FNovaCotacao := TFNovaCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
    FNovaCotacao.ConsultaCotacao(inttostr(varia.Codigoempfil),LigacoesLANORCAMENTO.AsString);
    FNovaCotacao.free;
  end;
end;

{******************************************************************************}
procedure TFTeleMarketings.BGraficoHistoricoClick(Sender: TObject);
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('select COUNT(*) QTD,  HIS.DESHISTORICO '+
                    ' from TELEMARKETING TEL, HISTORICOLIGACAO HIS '+
                    ' Where  TEL.CODHISTORICO = HIS.CODHISTORICO ');
  Adicionafiltros(VpfComandoSql);
  VpfComandoSql.Add('GROUP BY HIS.DESHISTORICO') ;
  graficostrio.info.CampoValor := 'QTD';
  graficostrio.info.TituloY := 'Quantidade';
  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;

  graficostrio.info.CampoRotulo := 'DESHISTORICO';
  graficostrio.info.TituloGrafico := 'Gráficos por Histórico - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := 'Gráfico de ligações por Historico';
  graficostrio.info.TituloFormulario := 'Gráfico de ligações por Histórico';
  graficostrio.info.TituloX := 'Histórico';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFTeleMarketings.TeleMarketingReceptivo1Click(Sender: TObject);
begin
  if not Ligacoes.Eof then
  begin
    FNovoTeleMarketing := TFNovoTeleMarketing.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoTeleMarketing'));
    FNovoTeleMarketing.TeleMarketingCliente(LigacoesCODCLIENTE.AsInteger);
    FNovoTeleMarketing.free;
  end;
end;

{******************************************************************************}
procedure TFTeleMarketings.BLigacoesDiaClick(Sender: TObject);
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('select COUNT(*) QTD, DATE(DATLIGACAO) data '+
                    ' from TELEMARKETING TEL'+
                    ' Where  TEL.CODFILIAL = TEL.CODFILIAL ');
  Adicionafiltros(VpfComandoSql);
  VpfComandoSql.Add('GROUP BY data order by 2') ;
  graficostrio.info.CampoValor := 'QTD';
  graficostrio.info.TituloY := 'Ligações';
  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;

  graficostrio.info.CampoRotulo := 'data';
  if ECodUsuario.AInteiro <> 0 then
    graficostrio.info.TituloGrafico := 'Gráficos Quantidade de Ligacações - ' + LNomUsuario.Caption
  else
    graficostrio.info.TituloGrafico := 'Gráficos Quantidade de Ligacações - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := 'Gráfico de Quantidade de Ligacações';
  graficostrio.info.TituloFormulario := 'Gráfico de Quantidade de Ligações.';
  graficostrio.info.TituloX := 'Data Ligação';
  graficostrio.execute;

end;

{******************************************************************************}
procedure TFTeleMarketings.BPedidosPorTipoClick(Sender: TObject);
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('select SUM(ORC.N_VLR_LIQ)VALOR,  HIS.DESTIPOLIGACAO '+
                    ' from TELEMARKETING TEL, HISTORICOLIGACAO HIS, CADORCAMENTOS ORC'+
                    ' Where  TEL.CODHISTORICO = HIS.CODHISTORICO '+
                    ' and TEL.CODFILIAL = ORC.I_EMP_FIL '+
                    ' AND TEL.LANORCAMENTO = ORC.I_LAN_ORC' );
  Adicionafiltros(VpfComandoSql);
  VpfComandoSql.Add('GROUP BY HIS.DESTIPOLIGACAO') ;
  graficostrio.info.CampoValor := 'VALOR';
  graficostrio.info.TituloY := 'Valor';
  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;

  graficostrio.info.CampoRotulo := 'DESTIPOLIGACAO';
  graficostrio.info.TituloGrafico := 'Gráficos por Tipo de ligaçào - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := 'Gráfico de ligações por Tipo de Ligação';
  graficostrio.info.TituloFormulario := 'Gráfico de ligações por Tipo de Ligação';
  graficostrio.info.TituloX := 'Tipo Ligação';
  graficostrio.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTeleMarketings]);
end.

