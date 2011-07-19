unit AProspects;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, ComCtrls, Graficos,
  Localizacao, Mask, numericos, Menus, Constantes, DBClient;

type
  TFProspects = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    Prospect: TSQL;
    DataProspect: TDataSource;
    ProspectCODPROSPECT: TFMTBCDField;
    ProspectNOMPROSPECT: TWideStringField;
    ProspectNOMFANTASIA: TWideStringField;
    ProspectTIPPESSOA: TWideStringField;
    ProspectDESENDERECO: TWideStringField;
    ProspectDESCIDADE: TWideStringField;
    ProspectDESFONE1: TWideStringField;
    ProspectDATCADASTRO: TSQLTimeStampField;
    ProspectDESMEIODIVULGACAO: TWideStringField;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label2: TLabel;
    PGraficos: TCorPainelGra;
    BitBtn4: TBitBtn;
    PanelColor5: TPanelColor;
    Label17: TLabel;
    Label18: TLabel;
    BMeioDivulgacao: TBitBtn;
    BFechaGrafico: TBitBtn;
    BVendedor: TBitBtn;
    BProduto: TBitBtn;
    BData: TBitBtn;
    BFlag: TBitBtn;
    BCondicao: TBitBtn;
    BEstado: TBitBtn;
    GraficosTrio: TGraficosTrio;
    Label11: TLabel;
    EVendedor: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    LNomVendedor: TLabel;
    Localiza: TConsultaPadrao;
    ENome: TEditColor;
    Label1: TLabel;
    ENomeFantasia: TEditColor;
    Label3: TLabel;
    CContatovendedor: TCheckBox;
    PopupMenu1: TPopupMenu;
    BMes: TBitBtn;
    NovaAgenda1: TMenuItem;
    PanelColor4: TPanelColor;
    N2: TMenuItem;
    TelemarketingReceptivo1: TMenuItem;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    LMeioDivulgacao: TLabel;
    EMeioDivulgacao: TEditLocaliza;
    ECidade: TEditColor;
    Label7: TLabel;
    Label6: TLabel;
    ERamoAtividade: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label8: TLabel;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoConsultar1: TBotaoConsultar;
    BotaoExcluir1: TBotaoExcluir;
    BGraficos: TBitBtn;
    BProdutos: TBitBtn;
    BContatos: TBitBtn;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure CPeriodoClick(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure BGraficosClick(Sender: TObject);
    procedure BFechaGraficoClick(Sender: TObject);
    procedure BMeioDivulgacaoClick(Sender: TObject);
    procedure BVendedorClick(Sender: TObject);
    procedure BProdutoClick(Sender: TObject);
    procedure BDataClick(Sender: TObject);
    procedure BFlagClick(Sender: TObject);
    procedure BCondicaoClick(Sender: TObject);
    procedure BEstadoClick(Sender: TObject);
    procedure ENomeExit(Sender: TObject);
    procedure ENomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ENomeFantasiaExit(Sender: TObject);
    procedure ENomeFantasiaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BMesClick(Sender: TObject);
    procedure NovaAgenda1Click(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
    procedure BProdutosClick(Sender: TObject);
    procedure BContatosClick(Sender: TObject);
    procedure TelemarketingReceptivo1Click(Sender: TObject);
    procedure ECidadeExit(Sender: TObject);
    procedure ECidadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprOrdem,
    VprNome,
    VprNomFantasia,
    VprCidade : String;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    function RRodapeGrafico : String;
    procedure GraficoMeioDivulgacao;
    procedure GraficoVendedor;
    procedure GraficoCidade;
    procedure GraficoRamoAtividade;
    procedure GraficoProfissao;
    procedure GraficoData;
    procedure GraficoMes;
    procedure GraficoUF;
  public
    { Public declarations }
  end;

var
  FProspects: TFProspects;

implementation

uses APrincipal, ANovoProspect, Funsql,fundata, ANovaProposta,
  ANovaAgendaProspect, AProdutosProspect, AContatosProspect,
  ANovoTelemarketingProspect;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProspects.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.dateTime :=PrimeiroDiaMes(date) ;
  EDatFim.DateTime := UltimoDiaMes(date);
  VprOrdem := 'order by PRO.CODPROSPECT ';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProspects.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFProspects.AtualizaConsulta;
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := Prospect.GetBookmark;
  Prospect.close;
  Prospect.sql.clear;
  Prospect.sql.add('select CODPROSPECT, NOMPROSPECT, NOMFANTASIA, TIPPESSOA, DESENDERECO, DESCIDADE, DESFONE1, DATCADASTRO, MEI.DESMEIODIVULGACAO '+
                   ' from PROSPECT PRO, MEIODIVULGACAO MEI ' +
                   ' Where ' +SQLTextoRightJoin('PRO.CODMEIODIVULGACAO','MEI.CODMEIODIVULGACAO'));
  AdicionaFiltros(Prospect.sql);
  Prospect.SQL.add(VprOrdem);
  GridIndice1.ALinhaSQLOrderBy := Prospect.sql.count - 1;
  Prospect.open;
  try
    Prospect.GotoBookmark(VpfPosicao);
  except
  end;
  Prospect.FreeBookmark(VpfPosicao);
  VprNome := ENome.Text;
  VprNomFantasia := ENomeFantasia.text;
  VprCidade := ECidade.Text;
end;

{******************************************************************************}
procedure TFProspects.AdicionaFiltros(VpaSelect : TStrings);
begin
  if CPeriodo.Checked then
    VpaSelect.add('and ('+ SQLTextoDataEntreAAAAMMDD('PRO.DATCADASTRO',EDatInicio.DAtetime,incdia(EDatFim.datetime,1),false)+
                  ' OR EXISTS (SELECT CON.CODPROSPECT FROM CONTATOPROSPECT CON '+
                  ' Where CON.CODPROSPECT = PRO.CODPROSPECT '+
                  SQLTextoDataEntreAAAAMMDD('CON.DATCADASTRO',EDatInicio.DateTime,EDatFim.Datetime,true)+'))');
  if EVendedor.AInteiro <> 0 then
    VpaSelect.add('AND PRO.CODVENDEDOR = '+ EVendedor.Text);
  if ENome.Text <> '' then
    VpaSelect.Add('AND PRO.NOMPROSPECT LIKE '''+ENome.Text +'%''');
  if ENomeFantasia.Text <> '' then
    VpaSelect.Add('AND PRO.NOMFANTASIA LIKE '''+ENomeFantasia.Text+'%''');
  if CContatovendedor.Checked then
    VpaSelect.Add('AND PRO.INDCONTATOVENDEDOR = ''N''');
  if (puCRSomenteSuspectDoVendedor in varia.PermissoesUsuario) then
    VpaSelect.Add('and PRO.CODVENDEDOR in '+Varia.CodigosVendedores);
  if EMeioDivulgacao.AInteiro <> 0 then
    VpaSelect.add('and PRO.CODMEIODIVULGACAO = ' +EMeioDivulgacao.Text);
  if ECidade.Text <> '' then
    VpaSelect.add('and PRO.DESCIDADE LIKE '''+ECidade.Text+'%''');
  if ERamoAtividade.AInteiro <> 0 then
    VpaSelect.Add('AND PRO.CODRAMOATIVIDADE = '+ERamoAtividade.Text);
end;

{******************************************************************************}
procedure TFProspects.GraficoMeioDivulgacao;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, MEI.DESMEIODIVULGACAO '+
                    ' from PROSPECT PRO, MEIODIVULGACAO MEI '+
                    ' Where PRO.CODMEIODIVULGACAO = MEI.CODMEIODIVULGACAO');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY MEI.DESMEIODIVULGACAO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'DESMEIODIVULGACAO';
  graficostrio.info.TituloGrafico := 'Gráfico Suspect´s - Meio Divulgação';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Suspect´s';
  graficostrio.info.TituloX := 'Meio Divulgação';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFProspects.GraficoVendedor;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, VEN.C_NOM_VEN VENDEDOR '+
                    ' from PROSPECT PRO, CADVENDEDORES VEN '+
                    ' Where PRO.CODVENDEDOR = VEN.I_COD_VEN');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY VEN.C_NOM_VEN');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'VENDEDOR';
  graficostrio.info.TituloGrafico := 'Gráfico Suspect´s - Vendedores';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Suspect´s';
  graficostrio.info.TituloX := 'Vendedor';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFProspects.GraficoCidade;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, PRO.DESCIDADE CIDADE '+
                    ' from PROSPECT PRO '+
                    ' Where PRO.CODPROSPECT = PRO.CODPROSPECT ');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY PRO.DESCIDADE');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CIDADE';
  graficostrio.info.TituloGrafico := 'Gráfico Suspect´s - Cidades';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Suspect´s';
  graficostrio.info.TituloX := 'Cidade';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFProspects.GraficoRamoAtividade;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, RAM.NOM_RAMO_ATIVIDADE CAMPO '+
                    ' from PROSPECT PRO, RAMO_ATIVIDADE RAM '+
                    ' Where '+SQLTextoRightJoin('PRO.CODRAMOATIVIDADE','RAM.COD_RAMO_ATIVIDADE'));
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY RAM.NOM_RAMO_ATIVIDADE');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Suspect´s - Ramo Atividades';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Suspect´s';
  graficostrio.info.TituloX := 'Ramo Atividade';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFProspects.GraficoProfissao;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, PRF.C_NOM_PRF CAMPO '+
                    ' from PROSPECT PRO, CADPROFISSOES PRF '+
                    ' Where '+SQLTextoRightJoin('PRO.CODPROFISSAOCONTATO','PRF.I_COD_PRF '));
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY PRF.C_NOM_PRF');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Suspect´s - Profissão Contato';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Suspect´s';
  graficostrio.info.TituloX := 'Profissão Contato';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFProspects.GraficoData;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, PRO.DATCADASTRO CAMPO '+
                    ' from PROSPECT PRO '+
                    ' Where PRO.CODPROSPECT = PRO.CODPROSPECT ');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY PRO.DATCADASTRO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Suspect´s - Data';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Suspect´s';
  graficostrio.info.TituloX := 'Data';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFProspects.GraficoMes;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, (YEAR(PRO.DATCADASTRO) *100)+month(PRO.DATCADASTRO)  DATA1, month(PRO.DATCADASTRO)||''/''|| year(PRO.DATCADASTRO) DATA'+
                    ' from PROSPECT PRO '+
                    ' Where PRO.CODPROSPECT = PRO.CODPROSPECT ');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.Add(' group by DATA1, DATA '  +
                    ' order by 2');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'DATA';
  graficostrio.info.TituloGrafico := 'Gráfico Suspect´s - Mês';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Suspect´s';
  graficostrio.info.TituloX := 'Mes';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFProspects.GraficoUF;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, DESUF CAMPO '+
                    ' from PROSPECT PRO '+
                    ' Where PRO.CODPROSPECT = PRO.CODPROSPECT ');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY DESUF');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Suspect´s - UF';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Suspect´s';
  graficostrio.info.TituloX := 'UF';
  graficostrio.execute;
end;

{******************************************************************************}
function TFProspects.RRodapeGrafico : String;
begin
  result := '';
  if CPeriodo.Checked then
    result := 'Período de :'+ FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+ ' até : '+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime);
  if EVendedor.AInteiro <> 0 then
    result := result + ' - Vendedor : '+ LNomVendedor.Caption;
  if EMeioDivulgacao.AInteiro <> 0 then
    result := result + ' - Meio Div. : '+LMeioDivulgacao.caption;
  if ECidade.text <> '' then
    Result := result + ' - Cidade : '+ECidade.Text;
end;

{******************************************************************************}
procedure TFProspects.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovoProspect := TFNovoProspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProspect'));
end;

procedure TFProspects.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovoProspect.ShowModal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFProspects.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFProspects.CPeriodoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFProspects.BotaoAlterar1Atividade(Sender: TObject);
begin
  FNovoProspect.LocalizaProspect(ProspectCODPROSPECT.AsInteger);
end;

{******************************************************************************}
procedure TFProspects.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovoProspect.Show;
end;

{******************************************************************************}
procedure TFProspects.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovoProspect.close;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFProspects.BGraficosClick(Sender: TObject);
begin
  PanelColor1.Enabled := false;
  GridIndice1 .Enabled := false;
  PGraficos.Top := 50;
  PGraficos.Visible := true;
end;

{******************************************************************************}
procedure TFProspects.BFechaGraficoClick(Sender: TObject);
begin
  PanelColor1.Enabled := true;
  GridIndice1 .Enabled := true;
  PGraficos.Visible := false;
end;

{******************************************************************************}
procedure TFProspects.BMeioDivulgacaoClick(Sender: TObject);
begin
  GraficoMeioDivulgacao;
end;

{******************************************************************************}
procedure TFProspects.BVendedorClick(Sender: TObject);
begin
  GraficoVendedor;
end;

{******************************************************************************}
procedure TFProspects.BProdutoClick(Sender: TObject);
begin
  GraficoCidade;
end;

{******************************************************************************}
procedure TFProspects.BDataClick(Sender: TObject);
begin
  GraficoRamoAtividade;
end;

{******************************************************************************}
procedure TFProspects.BFlagClick(Sender: TObject);
begin
  GraficoProfissao;
end;

{******************************************************************************}
procedure TFProspects.BCondicaoClick(Sender: TObject);
begin
  GraficoData;
end;

{******************************************************************************}
procedure TFProspects.BEstadoClick(Sender: TObject);
begin
  GraficoUF;
end;

{******************************************************************************}
procedure TFProspects.ENomeExit(Sender: TObject);
begin
  if VprNome <> ENome.Text then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFProspects.ENomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    ENomeExit(ENome);
end;

{******************************************************************************}
procedure TFProspects.ENomeFantasiaExit(Sender: TObject);
begin
  if ENomeFantasia.Text <> VprNomFantasia then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFProspects.ENomeFantasiaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    ENomeFantasiaExit(ENomeFantasia);
end;

{******************************************************************************}
procedure TFProspects.BMesClick(Sender: TObject);
begin
  GraficoMes;
end;

{******************************************************************************}
procedure TFProspects.NovaAgenda1Click(Sender: TObject);

begin
  if ProspectCODPROSPECT.AsInteger <> 0 then
  begin
    FNovaAgendaProspect:= TFNovaAgendaProspect.CriarSDI(Self,'',True);
    FNovaAgendaProspect.NovaAgendaProspect(ProspectCODPROSPECT.AsInteger);
    FNovaAgendaProspect.Free;
  end;
end;

{******************************************************************************}
procedure TFProspects.GridIndice1Ordem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFProspects.BProdutosClick(Sender: TObject);
begin
  if ProspectCODPROSPECT.AsInteger <> 0 then
  begin
    FProdutosProspect:= TFProdutosProspect.CriarSDI(Self,'',True);
    FProdutosProspect.CadastraProdutos(ProspectCODPROSPECT.AsInteger);
    FProdutosProspect.Free;
  end;
end;

procedure TFProspects.BContatosClick(Sender: TObject);
begin
  if ProspectCODPROSPECT.AsInteger <> 0 then
  begin
    FContatosProspect:= TFContatosProspect.CriarSDI(Application,'',True);
    FContatosProspect.CadastraContatos(ProspectCODPROSPECT.AsInteger);
    FContatosProspect.Free;
  end;
end;

{******************************************************************************}
procedure TFProspects.TelemarketingReceptivo1Click(Sender: TObject);
begin
  if not Prospect.Eof then
  begin
    FNovoTeleMarketingProspect:= TFNovoTeleMarketingProspect.CriarSDI(Application,'',True);
    FNovoTeleMarketingProspect.TeleMarketingProspect(ProspectCODPROSPECT.AsInteger);
    FNovoTeleMarketingProspect.Free;
  end;
end;

procedure TFProspects.ECidadeExit(Sender: TObject);
begin
  if ECidade.Text <> VprCidade then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFProspects.ECidadeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    ECidadeExit(ECidade);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFProspects]);
end.
