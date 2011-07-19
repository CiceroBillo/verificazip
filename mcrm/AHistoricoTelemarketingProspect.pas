unit AHistoricoTelemarketingProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, StdCtrls, Buttons, Localizacao,
  ComCtrls, Db, DBTables, DBCtrls, Tabela, Grids, DBGrids, DBKeyViolation,
  Mask, numericos, Menus, DBClient;

type
  TFHistoricoTelemarketingProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BFechar: TBitBtn;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    Label5: TLabel;
    SpeedButton4: TSpeedButton;
    Label4: TLabel;
    BUsuario: TSpeedButton;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ECodProspect: TEditLocaliza;
    ECodUsuario: TEditLocaliza;
    ECodHistorico: TEditLocaliza;
    Localiza: TConsultaPadrao;
    Label2: TLabel;
    LNomUsuario: TLabel;
    Label7: TLabel;
    PanelColor3: TPanelColor;
    LIGACOES: TSQL;
    DataLIGACOES: TDataSource;
    Grade: TGridIndice;
    EObservacoes: TDBMemoColor;
    Splitter1: TSplitter;
    LIGACOESSEQTELE: TFMTBCDField;
    LIGACOESDATLIGACAO: TSQLTimeStampField;
    LIGACOESDESFALADOCOM: TWideStringField;
    LIGACOESDESOBSERVACAO: TWideStringField;
    LIGACOESDATTEMPOLIGACAO: TSQLTimeStampField;
    LIGACOESCODPROSPECT: TFMTBCDField;
    LIGACOESNOMPROSPECT: TWideStringField;
    LIGACOESC_NOM_USU: TWideStringField;
    LIGACOESDESHISTORICO: TWideStringField;
    PanelColor4: TPanelColor;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    CAtualizarTotais: TCheckBox;
    EQtdLigacoes: Tnumerico;
    ETempoTotal: TEditColor;
    ETempoMedio: TEditColor;
    Aux: TSQL;
    PopupMenu1: TPopupMenu;
    TelemarketingReceptivo1: TMenuItem;
    LIGACOESTIPO: TWideStringField;
    Label6: TLabel;
    BVendedor: TSpeedButton;
    LVendedor: TLabel;
    EVendedor: TRBEditLocaliza;
    LIGACOESVENDEDORCADASTRO: TWideStringField;
    LIGACOESVENDEDORHISTORICO: TWideStringField;
    N1: TMenuItem;
    Agendar1: TMenuItem;
    Label11: TLabel;
    SpeedButton1: TSpeedButton;
    LCidade: TLabel;
    ECidade: TEditLocaliza;
    LIGACOESCIDADE: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure CAtualizarTotaisClick(Sender: TObject);
    procedure TelemarketingReceptivo1Click(Sender: TObject);
    procedure GradeOrdem(Ordem: string);
    procedure Agendar1Click(Sender: TObject);
    procedure ECidadeFimConsulta(Sender: TObject);
    procedure ECidadeRetorno(Retorno1, Retorno2: string);
  private
    VprOrdem,
    VprEstadoFiltro: String;
    procedure InicializaTela;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
    procedure AdicionaFiltroCliente(VpaComandoSql : TStrings);
    function RQtdLigacoes(var VpaTempoTotal, VpaMedia: Integer): Integer;
    procedure ConfiguraPermissaoUsuario;
  public
  end;

var
  FHistoricoTelemarketingProspect: TFHistoricoTelemarketingProspect;

implementation
uses
  APrincipal, FunString, FunNumeros, FunSQL, FunData, Constantes,
  ANovoTelemarketingProspect, ANovoTeleMarketing, ANovoAgendamento;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFHistoricoTelemarketingProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ConfiguraPermissaoUsuario;
  VprOrdem:= ' ORDER BY 2';
  InicializaTela;
  AtualizaConsulta;
end;

procedure TFHistoricoTelemarketingProspect.GradeOrdem(Ordem: string);
begin
  VprOrdem := Ordem;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFHistoricoTelemarketingProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.InicializaTela;
begin
  EDatInicio.DateTime:= PrimeiroDiaMes(Date);
  EDatFim.DateTime:= UltimoDiaMes(Date);
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.AdicionaFiltros(VpaSelect: TStrings);
begin
  if CPeriodo.Checked then
    VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('TRUNC(TEL.DATLIGACAO)',EDatInicio.DateTime,EDatFim.Datetime,True));
  if ECodProspect.AInteiro <> 0 then
    VpaSelect.Add(' AND TEL.CODPROSPECT = '+ECodProspect.Text);
  if ECodUsuario.Ainteiro <> 0 then
    VpaSelect.Add(' AND TEL.CODUSUARIO = '+ECodUsuario.Text);
  if EVendedor.Ainteiro <> 0 then
    VpaSelect.Add(' AND TEL.CODVENDEDOR = '+EVendedor.Text);
  if ECodHistorico.AInteiro <> 0 then
    VpaSelect.Add(' AND TEL.CODHISTORICO = '+ECodHistorico.Text);
  if ECidade.AInteiro <> 0 then
    VpaSelect.add(' and PRO.DESCIDADE = '''+LCidade.Caption+'''');
  if VprEstadoFiltro <> '' then
    VpaSelect.Add(' and PRO.DESUF = '''+ VprEstadoFiltro+ '''');
end;

procedure TFHistoricoTelemarketingProspect.Agendar1Click(Sender: TObject);
begin
  if LIGACOESTIPO.AsString = 'PROSPECT' then
  begin
    FNovoAgedamento := TFNovoAgedamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoAgedamento'));
    FNovoAgedamento.AgendaPeloTelemarketing(LIGACOESCODPROSPECT.AsInteger,varia.CodigoUsuario);
    FNovoAgedamento.free;
  end;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.AdicionaFiltroCliente(VpaComandoSql : TStrings);
begin
  if ECodProspect.AInteiro <> 0 then
    VpaComandoSql.Add(' AND TEL.CODCLIENTE = 0');
  if EVendedor.AInteiro <> 0 then
    VpaComandoSql.Add(' AND TEL.CODVENDEDOR = '+EVendedor.Text);
  if CPeriodo.Checked then
    VpaComandoSql.add(SQLTextoDataEntreAAAAMMDD('TRUNC(TEL.DATLIGACAO)',EDatInicio.DateTime,EDatFim.Datetime,true));
  if ECodUsuario.Ainteiro <> 0 then
    VpaComandoSql.add(' and TEL.CODUSUARIO = '+ECodUsuario.Text);
  if ECodHistorico.AInteiro <> 0 then
    VpaComandoSql.add(' and TEL.CODHISTORICO = '+ECodHistorico.Text);
  if ECidade.AInteiro <> 0 then
    VpaComandoSql.add(' and CLI.C_CID_CLI = '''+LCidade.Caption+'''');
  if VprEstadoFiltro <> '' then
    VpaComandoSql.Add(' and CLI.C_EST_CLI = '''+ VprEstadoFiltro+'''');
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.AtualizaConsulta;
begin
  LIGACOES.close;
  LIGACOES.SQL.Clear;
  LIGACOES.SQL.Add('SELECT'+
                   ' ''SUSPECT'' TIPO,TEL.SEQTELE, TEL.DATLIGACAO, TEL.DESFALADOCOM,'+
                   ' TEL.DESOBSERVACAO, TEL.DATTEMPOLIGACAO, TEL.CODPROSPECT,'+
                   ' PRO.NOMPROSPECT, PRO.DESCIDADE CIDADE,'+
                   ' USU.C_NOM_USU,'+
                   ' HIS.DESHISTORICO, '+
                   ' VEC.C_NOM_VEN VENDEDORCADASTRO, ' +
                   ' VEH.C_NOM_VEN VENDEDORHISTORICO ' +
                   ' FROM '+
                   ' TELEMARKETINGPROSPECT TEL, PROSPECT PRO, CADUSUARIOS USU, HISTORICOLIGACAO HIS, CADVENDEDORES VEC, CADVENDEDORES VEH '+
                   ' WHERE'+
                   ' TEL.CODPROSPECT = PRO.CODPROSPECT'+
                   ' AND TEL.CODUSUARIO = USU.I_COD_USU'+
                   ' AND ' +SQLTextoRightJoin('PRO.CODVENDEDOR','VEC.I_COD_VEN')+
                   ' AND ' +SQLTextoRightJoin('TEL.CODVENDEDOR','VEH.I_COD_VEN')+
                   ' AND TEL.CODHISTORICO = HIS.CODHISTORICO');
  AdicionaFiltros(LIGACOES.SQL);
  Ligacoes.SQL.ADD('union '+
                   ' select ''PROSPECT'' TIPO,TEL.SEQTELE, TEL.DATLIGACAO,TEL.DESFALADOCOM,  TEL.DESOBSERVACAO, TEL.DATTEMPOLIGACAO, TEL.CODCLIENTE, '+
                   ' CLI.C_NOM_CLI, CLI.C_CID_CLI CIDADE, '+
                   ' USU.C_NOM_USU, '+
                   ' HIS.DESHISTORICO, '+
                   ' VEC.C_NOM_VEN VENDEDORCADASTRO, ' +
                   ' VEH.C_NOM_VEN VENDEDORHISTORICO ' +
                   ' from TELEMARKETING TEL, CADCLIENTES CLI, CADUSUARIOS USU, HISTORICOLIGACAO HIS, CADVENDEDORES VEC, CADVENDEDORES VEH '+
                   ' Where TEL.CODCLIENTE = CLI.I_COD_CLI '+
                   ' and TEL.CODUSUARIO = USU.I_COD_USU '+
                   ' AND ' +SQLTextoRightJoin('CLI.I_COD_VEN','VEC.I_COD_VEN')+
                   ' AND ' +SQLTextoRightJoin('TEL.CODVENDEDOR','VEH.I_COD_VEN')+
                   ' and TEL.CODHISTORICO = HIS.CODHISTORICO ');
  AdicionaFiltroCliente(LIGACOES.sql);
  LIGACOES.SQL.Add(VprOrdem);
  LIGACOES.Open;
  Grade.ALinhaSQLOrderBy:= LIGACOES.SQL.Count-1;
  CAtualizarTotaisClick(CAtualizarTotais);
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.ECidadeFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.ECidadeRetorno(Retorno1,
  Retorno2: string);
begin
  VprEstadoFiltro:= Retorno1;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.EDatInicioCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.CAtualizarTotaisClick(Sender: TObject);
var
  VpfTempoTotal, VpfMedia: Integer;
begin
  if CAtualizarTotais.Checked then
  begin
    EQtdLigacoes.AValor:= RQtdLigacoes(VpfTempoTotal,VpfMedia);
    ETempoTotal.Text:= FormatDateTime('HH:MM:SS',VpfTempoTotal);
    ETempoMedio.Text:= FormatDateTime('HH:MM:SS',VpfMedia);
  end
  else
  begin
    EQtdLigacoes.AValor:= 0;
    ETempoTotal.Text:= FormatDateTime('HH:MM:SS',0);
    ETempoMedio.Text:= FormatDateTime('HH:MM:SS',0);
  end;
end;

{******************************************************************************}
function TFHistoricoTelemarketingProspect.RQtdLigacoes(var VpaTempoTotal, VpaMedia: Integer): Integer;
begin
  Aux.Close;
  Aux.SQL.Clear;
  Aux.SQL.Add('SELECT COUNT(*) QTD,'+
              '       SUM(QTDSEGUNDOSLIGACAO) TEMPO,'+
              '       AVG(QTDSEGUNDOSLIGACAO) MEDIA'+
              ' FROM TELEMARKETINGPROSPECT TEL, PROSPECT PRO'+
              ' WHERE TEL.SEQTELE = TEL.SEQTELE' +
              ' AND TEL.CODPROSPECT = PRO.CODPROSPECT');
  Adicionafiltros(Aux.SQL);
  Aux.Open;
  Result:= Aux.FieldByName('QTD').AsInteger;
  VpaTempoTotal:= Aux.FieldByName('TEMPO').AsInteger;
  VpaMedia:= Aux.FieldByName('MEDIA').AsInteger;

  Aux.Close;
  Aux.SQL.Clear;
  Aux.SQL.Add('SELECT COUNT(*) QTD,'+
              '       SUM(QTDSEGUNDOSLIGACAO) TEMPO,'+
              '       AVG(QTDSEGUNDOSLIGACAO) MEDIA'+
              ' FROM TELEMARKETING TEL, CADCLIENTES CLI'+
              ' WHERE TEL.SEQTELE = TEL.SEQTELE' +
              ' AND TEL.CODCLIENTE = CLI.I_COD_CLI ');
  AdicionaFiltroCliente(Aux.SQL);
  Aux.open;
  Result:=  result + Aux.FieldByName('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.ConfiguraPermissaoUsuario;
begin
  if (puSomenteClientesdoVendedor in varia.PermissoesUsuario) then
  begin
    EVendedor.AInteiro := Varia.CodVendedor;
    EVendedor.Atualiza;
    EVendedor.Enabled := false;
    BVendedor.Enabled := false;
    LVendedor.Enabled := false;
  end;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.TelemarketingReceptivo1Click(
  Sender: TObject);
begin
  if not LIGACOESCODPROSPECT.AsInteger <> 0 then
  begin
    if LIGACOESTIPO.AsString = 'SUSPECT' then
    BEGIN
      FNovoTeleMarketingProspect:= TFNovoTeleMarketingProspect.CriarSDI(Application,'',True);
      FNovoTeleMarketingProspect.TeleMarketingProspect(LIGACOESCODPROSPECT.AsInteger);
      FNovoTeleMarketingProspect.Free;
    END
    else
      if LIGACOESTIPO.AsString = 'PROSPECT' then
      begin
        FNovoTeleMarketing := TFNovoTeleMarketing.CriarSDI(self,'',true);
        FNovoTeleMarketing.TeleMarketingCliente(LIGACOESCODPROSPECT.AsInteger);
        FNovoTeleMarketing.Free;
      end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFHistoricoTelemarketingProspect]);
end.
