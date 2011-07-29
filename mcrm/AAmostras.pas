unit AAmostras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Menus, UnAmostra,
  ComCtrls, Mask, numericos, Localizacao, UnDadosProduto, DBClient, SqlExpr;

type
  TFAmostras = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TGridIndice;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoConsultar1: TBotaoConsultar;
    BFechar: TBitBtn;
    Amostra: TSQL;
    DataAmostra: TDataSource;
    AmostraCODAMOSTRA: TFMTBCDField;
    AmostraNOMAMOSTRA: TWideStringField;
    AmostraDATAMOSTRA: TSQLTimeStampField;
    AmostraDATENTREGACLIENTE: TSQLTimeStampField;
    AmostraDATAPROVACAO: TSQLTimeStampField;
    AmostraC_NOM_VEN: TWideStringField;
    AmostraNOMCOLECAO: TWideStringField;
    AmostraNOMDESENVOLVEDOR: TWideStringField;
    BImprimir: TBitBtn;
    PopupMenu1: TPopupMenu;
    MConcluiAmostra: TMenuItem;
    Label3: TLabel;
    Label4: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ConsultaPadrao1: TConsultaPadrao;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    EAmostra: Tnumerico;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    LNomVendedor: TLabel;
    EVendedor: TEditLocaliza;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    EDesenvolvedor: TEditLocaliza;
    ETipoPeriodo: TComboBoxColor;
    Label8: TLabel;
    AprovarAmostra1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ConcluirFichaTcnica1: TMenuItem;
    Label9: TLabel;
    ESituacao: TComboBoxColor;
    Label10: TLabel;
    EAmostraIndefinida: Tnumerico;
    AmostraDATFICHA: TSQLTimeStampField;
    N3: TMenuItem;
    ExtornarAprovao1: TMenuItem;
    TransformaremProduto1: TMenuItem;
    AmostraC_NOM_CLI: TWideStringField;
    AmostraDATPRECO: TSQLTimeStampField;
    AmostraDATENTREGA: TSQLTimeStampField;
    MConcluiPreco: TMenuItem;
    N4: TMenuItem;
    MRequisicaoMaquina: TMenuItem;
    ECliente: TRBEditLocaliza;
    AmostraTIPAMOSTRA: TWideStringField;
    BExcluir: TBitBtn;
    Label12: TLabel;
    ETipo: TComboBoxColor;
    MConcluirFichaAmostra: TMenuItem;
    AmostraINDAMOSTRAREALIZADA: TWideStringField;
    N5: TMenuItem;
    Duplicarreferncia1: TMenuItem;
    Label13: TLabel;
    ESolVend: TEditColor;
    AmostraCODCOR: TFMTBCDField;
    AmostraNOM_COR: TWideStringField;
    AmostraDATFICHACOR: TSQLTimeStampField;
    AmostraVALPRECOESTIMADO: TFMTBCDField;
    N6: TMenuItem;
    MotivoAtraso1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure MConcluiAmostraClick(Sender: TObject);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure EAmostraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AprovarAmostra1Click(Sender: TObject);
    procedure ConcluirFichaTcnica1Click(Sender: TObject);
    procedure ExtornarAprovao1Click(Sender: TObject);
    procedure TransformaremProduto1Click(Sender: TObject);
    procedure MConcluiPrecoClick(Sender: TObject);
    procedure AmostraAfterScroll(DataSet: TDataSet);
    procedure MRequisicaoMaquinaClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure MConcluirFichaAmostraClick(Sender: TObject);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure BotaoAlterar1Click(Sender: TObject);
    procedure Duplicarreferncia1Click(Sender: TObject);
    procedure ESolVendedorExit(Sender: TObject);
    procedure ESolVendedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ESolVendExit(Sender: TObject);
    procedure ESolVendKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GradeEditButtonClick(Sender: TObject);
    procedure MotivoAtraso1Click(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    FunAmostra : TRBFuncoesAmostra;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    procedure Configurapermissaousuario;
    procedure VerificaDataFichaParaAmostraRealizada;
  public
    { Public declarations }
    procedure ConsultaAmostrasIndefinidas(VpaCodAmostrasIndefinida : Integer);
  end;

var
  FAmostras: TFAmostras;

implementation

uses APrincipal, ANovaAmostra, funSql, unCrystal, Constantes, Fundata, Constmsg,
  ARequisicaoMaquina, dmRave, FunObjeto, AMotivoAtrasoAmostra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAmostras.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  EDatInicio.DateTime := PrimeiroDiaMes(Date);
  EDatFim.DateTime := UltimoDiaMes(date);
  ETipoPeriodo.ItemIndex := 0;
  ESituacao.ItemIndex := 0;
  VprOrdem := 'Order by AMO.CODAMOSTRA, COR.NOM_COR ';
  AtualizaConsulta;
  Configurapermissaousuario;
end;

procedure TFAmostras.GradeDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (State = [gdSelected]) then
  begin
    Grade.Canvas.Font.Color:= clWhite;
    Grade.DefaultDrawDataCell(Rect, Grade.columns[datacol].field, State);
  end
  else
  begin
    if not (AmostraDATENTREGA.IsNull) then
    begin
      grade.Canvas.Font.Color:= clGreen;
      grade.DefaultDrawDataCell(Rect, grade.columns[datacol].field, State);
    end
    else
      if (AmostraDATENTREGACLIENTE.AsDateTime < date)then
      begin
          grade.Canvas.Font.Color:= clred;
          grade.DefaultDrawDataCell(Rect, Grade.columns[datacol].field, State);
      end;
    if (not (AmostraDATAPROVACAO.IsNull) and (AmostraDATENTREGA.IsNull)) then
    begin
      grade.Canvas.Font.Color:= clBlue;
      grade.DefaultDrawDataCell(Rect, Grade.columns[datacol].field, State);
    end;
  end;
end;


procedure TFAmostras.GradeEditButtonClick(Sender: TObject);
begin
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAmostras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAmostras.BExcluirClick(Sender: TObject);
begin
  if confirmacao(CT_DeletaRegistro) then
  begin
    FunAmostra.ExcluiAmostra(AmostraCODAMOSTRA.AsInteger);
    AtualizaConsulta;
  end;
end;


procedure TFAmostras.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAmostras.AtualizaConsulta;
Var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := Amostra.GetBookmark;
  Amostra.close;
  Amostra.Sql.clear;
  Amostra.sql.add('SELECT AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAMOSTRA, AMO.DATENTREGACLIENTE, AMO.DATAPROVACAO, ' +
                  ' AMO.DATFICHA, AMO.DATPRECO, AMO.TIPAMOSTRA, AMO.INDAMOSTRAREALIZADA, '+
                  ' AMO.DESSOLVENDEDOR, VEN.C_NOM_VEN,  COL.NOMCOLECAO, DES.NOMDESENVOLVEDOR, '+
                  ' AMC.CODCOR, AMC.DATFICHACOR, AMC.DATENTREGA, AMC.VALPRECOESTIMADO, ' +
                  ' COR.NOM_COR, '+
                  ' CLI.C_NOM_CLI '+
                  ' FROM AMOSTRA AMO, CADVENDEDORES VEN, COLECAO COL,  DESENVOLVEDOR DES, CADCLIENTES CLI, AMOSTRACOR AMC, COR '+
                  ' WHERE AMO.CODVENDEDOR = VEN.I_COD_VEN '+
                  ' AND AMO.CODCOLECAO = COL.CODCOLECAO '+
                  ' AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR'+
                  ' AND '+SQLTextoRightJoin('AMO.CODAMOSTRA','AMC.CODAMOSTRA')+
                  ' AND AMC.CODCOR = COR.COD_COR (+) '+
                  ' AND '+SQLTextoRightJoin('AMO.CODCLIENTE','CLI.I_COD_CLI'));
  AdicionaFiltros(Amostra.sql);
  Amostra.sql.add(VprOrdem);
  Grade.ALinhaSQLOrderBy := Amostra.sql.count - 1;
//  Amostra.SQL.SaveToFile('c:\consulta.sql');
  Amostra.open;
  try
    Amostra.GotoBookmark(VpfPosicao);
  except
    Amostra.Last;
    try
      Amostra.GotoBookmark(VpfPosicao);
    except
    end;
  end;
  Amostra.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFAmostras.AdicionaFiltros(VpaSelect : TStrings);
begin
  if EAmostra.AsInteger <> 0 then
    VpaSelect.Add('AND AMO.CODAMOSTRA = '+EAmostra.Text)
  else
    if EAmostraIndefinida.AsInteger <> 0 then
      VpaSelect.add('AND AMO.CODAMOSTRAINDEFINIDA = '+IntToStr(EAmostraIndefinida.AsInteger))
    else
      if ESolVend.Text <> '' then
        VpaSelect.add('AND AMO.DESSOLVENDEDOR = '''+ ESolVend.Text+ '''')
      else
      case ESituacao.ItemIndex of
        1 : VpaSelect.add('AND AMO.DATFICHA IS NULL AND DATAPROVACAO IS NOT NULL');
        2 : VpaSelect.add('AND AMO.DATFICHA IS NULL                             ') ;
      else
        case ETipoPeriodo.ItemIndex of
          0 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('AMO.DATAMOSTRA',EDatInicio.DateTime,incDia(EDatFim.DateTime,1),true));
          1 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('AMC.DATENTREGA',EDatInicio.DateTime,incDia(EDatFim.DateTime,1),true));
          2 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('AMO.DATAPROVACAO',EDatInicio.DateTime,incDia(EDatFim.DateTime,1),true));
          3 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('AMO.DATENTREGACLIENTE',EDatInicio.DateTime,incDia(EDatFim.DateTime,1),true));
        end;
        case ESituacao.ItemIndex of
          1 : VpaSelect.add('AND AMO.DATAPROVACAO IS NOT NULL AND DATFICHA IS NULL');
        end;
        case ETipo.ItemIndex of
          1 : VpaSelect.add('AND AMO.TIPAMOSTRA = ''I''');
          2 : VpaSelect.add('AND AMO.TIPAMOSTRA = ''D''');
        end;
        if ECliente.AInteiro <> 0 then
          VpaSelect.Add(' and AMO.CODCLIENTE = ' + ECliente.text);
        if EVendedor.AInteiro <> 0 then
          VpaSelect.add(' and AMO.CODVENDEDOR = '+EVendedor.Text);
        if EDesenvolvedor.AInteiro <> 0 then
          VpaSelect.add(' and AMO.CODDESENVOLVEDOR = '+EDesenvolvedor.Text);
        if EAmostraIndefinida.AsInteger <> 0 then
          VpaSelect.add(' and AMO.CODAMOSTRAINDEFINIDA = '+EAmostraIndefinida.Text);
      end;
end;

{******************************************************************************}
procedure TFAmostras.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  if TBitBtn(Sender).Tag = 12 then // botao excluir;
  begin
    if AmostraCODAMOSTRA.AsInteger <> 0 then
      if FunAmostra.ExisteAmostraDefinidaDesenvolvida(AmostraCODAMOSTRA.AsInteger) then
      begin
        aviso('NÃO É POSSÍVEL EXCLUIR A AMOSTRA!!!'#13'Existem amostras desenvolvidas para essa requisicao de amostra.');
        abort;
      end;
  end;
  FNovaAmostra := TFNovaAmostra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaAmostra'));
end;

procedure TFAmostras.BotaoCadastrar1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFAmostras.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovaAmostra.ShowModal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostras.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovaAmostra.Amostra,'Select * from AMOSTRA '+
                                             ' Where CODAMOSTRA = '+AmostraCODAMOSTRA.AsString);
end;

procedure TFAmostras.BotaoAlterar1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFAmostras.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FAmostras.show;
end;

{******************************************************************************}
procedure TFAmostras.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovaAmostra.Close;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostras.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  if AmostraTIPAMOSTRA.AsString = 'D' then
    dtRave.ImprimeFichaTecnicaAmostra(AmostraCodAmostra.AsInteger,true,'')
  else
    dtRave.ImprimeFichaDesenvolvimento(AmostraCodAmostra.AsInteger);
  dtRave.free;
end;

{******************************************************************************}
procedure TFAmostras.MConcluiAmostraClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    if Confirmacao('Tem certeza que deseja concluir a ficha técnica da amostra?') then
    begin
      VpfREsultado := FunAmostra.ConcluiAmostraCor(AmostraCODAMOSTRA.AsInteger,AmostraCODCOR.AsInteger,now);
      if VpfREsultado <> '' then
        aviso(VpfREsultado)
      else
        AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFAmostras.EDatInicioCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostras.ESolVendedorExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFAmostras.ESolVendedorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostras.ESolVendExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFAmostras.ESolVendKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostras.EAmostraKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFAmostras.AprovarAmostra1Click(Sender: TObject);
var
  VpfResultado : String;
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    if Confirmacao('Tem certeza que deseja aprovar a amostra?') then
    begin
      VpfREsultado := FunAmostra.AprovaAmostra(AmostraCODAMOSTRA.AsInteger);
      if VpfREsultado <> '' then
        aviso(VpfREsultado)
      else
        AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFAmostras.MConcluirFichaAmostraClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    if Confirmacao('Tem certeza que deseja concluir a ficha técnica da amostra?') then
    begin
      if AmostraCODCOR.AsInteger = 0 then
        VpfREsultado := FunAmostra.ConcluirFichaAmostra(AmostraCODAMOSTRA.AsInteger)
      else
        VpfREsultado := FunAmostra.ConcluirFichaCor(AmostraCODAMOSTRA.AsInteger,AmostraCODCOR.AsInteger);
      if VpfREsultado <> '' then
        aviso(VpfREsultado)
      else
      begin
        AtualizaConsulta;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFAmostras.MotivoAtraso1Click(Sender: TObject);
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    FMotivoAtrasoAmostra := TFMotivoAtrasoAmostra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaAmostra'));
    FMotivoAtrasoAmostra.AbreMotivoAmostra(AmostraCODAMOSTRA.AsInteger, AmostraCODCOR.AsInteger);
    FMotivoAtrasoAmostra.Free;
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFAmostras.ConcluirFichaTcnica1Click(Sender: TObject);
var
  VpfResultado : String;
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    if Confirmacao('Tem certeza que deseja concluir a ficha técnica da amostra?') then
    begin
      VpfREsultado := FunAmostra.ConcluirFichaTecnica(AmostraCODAMOSTRA.AsInteger);
      if VpfREsultado <> '' then
        aviso(VpfREsultado)
      else
        AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFAmostras.Configurapermissaousuario;
begin
  AlterarVisibleDet([MConcluiAmostra],(puCRConcluirAmostra in varia.PermissoesUsuario));
  if (puCRNaoExluiAmostra in varia.PermissoesUsuario) then
    AlterarVisibleDet([BExcluir],false);
end;

{******************************************************************************}
procedure TFAmostras.ExtornarAprovao1Click(Sender: TObject);
var
  VpfResultado : String;
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    if Confirmacao('Tem certeza que deseja estornar a aprovação da amostra?') then
    begin
      VpfREsultado := FunAmostra.EstornarAprovacao(AmostraCODAMOSTRA.AsInteger);
      if VpfREsultado <> '' then
        aviso(VpfREsultado)
      else
        AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFAmostras.TransformaremProduto1Click(Sender: TObject);
var
  VpfResultado: String;
  VpfDAmostra : TRBDAmostra;
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    if Confirmacao('Deseja transformar essa amostra em um produto ?') then
    begin
      VpfDAmostra := TRBDAmostra.cria;
      FunAmostra.CarDAmostra(VpfDAmostra,AmostraCODAMOSTRA.AsInteger);
      if VpfResultado <> '' then
        aviso(VpfResultado);
      VpfDAmostra.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFAmostras.VerificaDataFichaParaAmostraRealizada;
Var
  VpfResultado: String;
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    VpfResultado := FunAmostra.VerificaAmostraRealizada(EAmostraIndefinida.AsInteger);
    if VpfResultado <> '' then
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFAmostras.MConcluiPrecoClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    if Confirmacao('Tem certeza que deseja concluir o preço da amostra?') then
    begin
      VpfREsultado := FunAmostra.ConcluirPrecoAmostra(AmostraCODAMOSTRA.AsInteger,now);
      if VpfREsultado <> '' then
        aviso(VpfREsultado)
      else
        AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFAmostras.AmostraAfterScroll(DataSet: TDataSet);
begin
  MConcluiAmostra.Enabled := (AmostraDATENTREGA.IsNull) and (AmostraTIPAMOSTRA.AsString = 'D');
  MConcluiPreco.Enabled := AmostraDATPRECO.IsNull;
  MRequisicaoMaquina.Enabled := AmostraTIPAMOSTRA.AsString = 'I';
  MConcluirFichaAmostra.Enabled := AmostraDATFICHACOR.IsNull;
  AprovarAmostra1.Enabled:= AmostraDATAPROVACAO.IsNull;
end;

{******************************************************************************}
procedure TFAmostras.ConsultaAmostrasIndefinidas(VpaCodAmostrasIndefinida : Integer);
begin
  EAmostraIndefinida.AsInteger := VpaCodAmostrasIndefinida;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFAmostras.Duplicarreferncia1Click(Sender: TObject);
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    FNovaAmostra := TFNovaAmostra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaAmostra'));
    FNovaAmostra.DuplicaAmostra(AmostraCODAMOSTRA.AsInteger);
    FNovaAmostra.Free;
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFAmostras.MRequisicaoMaquinaClick(Sender: TObject);
begin
  if AmostraCODAMOSTRA.AsInteger <> 0 then
  begin
    FRequisicaoMaquina := TFRequisicaoMaquina.CriarSDI(self,'',FPrincipal.VerificaPermisao(''));
    FRequisicaoMaquina.NovaRequisicaoMaquina(AmostraCODAMOSTRA.AsInteger);
    FRequisicaoMaquina.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAmostras]);
end.
