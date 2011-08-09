unit AAgendamentos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, StdCtrls, DBCtrls, Tabela, Grids, DBGrids, DBKeyViolation,
  Componentes1, PainelGradiente, ComCtrls, Buttons, Localizacao, Db,
  DBTables, Menus, UnClientes, UnDados, Funarquivos, DBClient, CAgenda,Geradores;

type
  TFAgendamentos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    Grade: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    Splitter1: TSplitter;
    EUsuario: TEditLocaliza;
    Label13: TLabel;
    SpeedButton3: TSpeedButton;
    Label14: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    CPeriodo: TCheckBox;
    ESituacao: TComboBoxColor;
    Label1: TLabel;
    Label2: TLabel;
    Agendamentos: TSQL;
    DataAgendamentos: TDataSource;
    AgendamentosCODUSUARIO: TFMTBCDField;
    AgendamentosSEQAGENDA: TFMTBCDField;
    AgendamentosCODCLIENTE: TFMTBCDField;
    AgendamentosDATCADASTRO: TSQLTimeStampField;
    AgendamentosDATINICIO: TSQLTimeStampField;
    AgendamentosDATFIM: TSQLTimeStampField;
    AgendamentosCODTIPOAGENDAMENTO: TFMTBCDField;
    AgendamentosINDREALIZADO: TWideStringField;
    AgendamentosDESOBSERVACAO: TWideStringField;
    AgendamentosCODUSUARIOAGENDOU: TFMTBCDField;
    AgendamentosC_NOM_USU: TWideStringField;
    AgendamentosC_NOM_CLI: TWideStringField;
    AgendamentosNOMTIPOAGENDAMENTO: TWideStringField;
    AgendamentosUSUAGENDOU: TWideStringField;
    AgendamentosHORAINI: TSQLTimeStampField;
    PopupMenu1: TPopupMenu;
    Concluir1: TMenuItem;
    Cancelar1: TMenuItem;
    Extornar1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    AgendamentosDATREALIZADO: TSQLTimeStampField;
    AgendamentosINDCANCELADO: TWideStringField;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    N3: TMenuItem;
    TelemarketingReceptivo1: TMenuItem;
    N4: TMenuItem;
    AlterarEstgio1: TMenuItem;
    EEstagio: TEditLocaliza;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Label11: TLabel;
    SpeedButton2: TSpeedButton;
    Label12: TLabel;
    ETipoAgendamento: TEditLocaliza;
    Label5: TLabel;
    SpeedButton4: TSpeedButton;
    Label6: TLabel;
    ECodCliente: TEditLocaliza;
    EVendedor: TRBEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    EFilial: TRBEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label9: TLabel;
    Label10: TLabel;
    EPedidoCompra: TRBEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    ECidade: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    LCidade: TLabel;
    AgendamentosC_CID_CLI: TWideStringField;
    RBAgenda: TRBAgenda;
    AgendamentosI_COR_AGE: TFMTBCDField;
    AgendamentosDESTITULO: TWideStringField;
    AgendamentosCODFILIALCOMPRA: TFMTBCDField;
    AgendamentosSEQPEDIDOCOMPRA: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EUsuarioFimConsulta(Sender: TObject);
    procedure Concluir1Click(Sender: TObject);
    procedure AgendamentosAfterScroll(DataSet: TDataSet);
    procedure Cancelar1Click(Sender: TObject);
    procedure Extornar1Click(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure TelemarketingReceptivo1Click(Sender: TObject);
    procedure GradeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure AlterarEstgio1Click(Sender: TObject);
    procedure EPedidoCompraSelect(Sender: TObject);
    procedure ECidadeFimConsulta(Sender: TObject);
    procedure RBAgendaFiltro;
    procedure CarTarefasNovaAgenda;
    procedure RBAgendaDuploCliquePainel(VpaPainel: TComponenteMove);
  private
    { Private declarations }
    VprOrdem : string;
    procedure AtualizaConsulta(VpaPosicionar : boolean;VpaAgendaUsuario : boolean);
    procedure AdicionaFiltros(VpaSelect : TStrings;VpaAgendaUsuario : boolean);
    procedure MontaHintGrade;
  public
    { Public declarations }
    procedure Agenda;
    procedure AgendaNova;
    procedure VerificaAgendamentoUsuario;
    procedure ConsultaPedidoCompra(VpaCodFilial,VpaSeqPedido : Integer);
  end;

var
  FAgendamentos: TFAgendamentos;

implementation

uses APrincipal, FunData, FunSql, constantes, ConstMSG, ANovoAgendamento,
  ANovoTeleMarketing, AAlteraEstagioAgendamento, funObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAgendamentos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ESituacao.ItemIndex := 0;
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
  EUsuario.AInteiro := varia.CodigoUsuario;
  VprOrdem := 'order by AGE.DATINICIO';
  EUsuario.Atualiza;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAgendamentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAgendamentos.AtualizaConsulta(VpaPosicionar : boolean;VpaAgendaUsuario : boolean);
var
  VpfPosicao : TBookmark;
begin
  if VpaPosicionar then
    VpfPosicao := Agendamentos.GetBookmark;
  Agendamentos.close;
  Agendamentos.sql.clear;
  Agendamentos.sql.add('select  AGE.CODUSUARIO, AGE.SEQAGENDA, AGE.CODCLIENTE, AGE.DATCADASTRO, '+
                       ' AGE.DATINICIO, AGE.DATINICIO HORAINI, AGE.DATFIM, AGE.CODTIPOAGENDAMENTO,'+
                       ' AGE.INDREALIZADO, AGE.DATREALIZADO, AGE.INDCANCELADO, '+
                       ' AGE.DESOBSERVACAO,AGE.CODUSUARIOAGENDOU, AGE.DESTITULO, '+
                       ' AGE.CODFILIALCOMPRA, AGE.SEQPEDIDOCOMPRA, '+
                       ' USU.C_NOM_USU, USU.I_COR_AGE, '+
                        ' TIP.NOMTIPOAGENDAMENTO, '+
                       ' CLI.C_NOM_CLI, CLI.C_CID_CLI, '+
                       ' USA.C_NOM_USU USUAGENDOU '+
                       ' from AGENDA AGE, CADUSUARIOS USU, CADCLIENTES CLI, TIPOAGENDAMENTO TIP, CADUSUARIOS USA '+
                       ' Where AGE.CODUSUARIO = USU.I_COD_USU '+
                       ' AND AGE.CODCLIENTE = CLI.I_COD_CLI '+
                       ' AND AGE.CODTIPOAGENDAMENTO = TIP.CODTIPOAGENDAMENTO '+
                       ' AND AGE.CODUSUARIOAGENDOU = USA.I_COD_USU ');
  AdicionaFiltros(Agendamentos.sql,VpaAgendaUsuario);
  Agendamentos.sql.add(VprOrdem);
  if FPrincipal.CorFoco.AGravarConsultaSQl then
     Agendamentos.Sql.Savetofile(RetornaDiretorioCorrente+'Consulta.sql');
  Agendamentos.open;
  Grade.ALinhaSQLOrderBy := Agendamentos.SQL.count -1;
  IF VpaPosicionar then
  begin
    try
      Agendamentos.GotoBookmark(VpfPosicao);
    except
    end;
    Agendamentos.FreeBookmark(VpfPosicao);
  end;
  Grade.Columns[0].visible := EUsuario.AInteiro =0;
end;

{******************************************************************************}
procedure TFAgendamentos.AdicionaFiltros(VpaSelect : TStrings;VpaAgendaUsuario :Boolean);
begin
  if CPeriodo.Checked then
    VpaSelect.add(SQLTextoDataEntreAAAAMMDD('AGE.DATINICIO',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),TRUE));

  case ESituacao.ItemIndex of
    0 : VpaSelect.Add(' and AGE.INDREALIZADO = ''N'' and AGE.INDCANCELADO = ''N''');
    1 : VpaSelect.Add(' and AGE.INDREALIZADO = ''S'' and AGE.INDCANCELADO = ''N''');
    2 : VpaSelect.Add(' and AGE.INDCANCELADO = ''S''');
  end;

  if EUsuario.AInteiro <> 0 then
    VpaSelect.add('and AGE.CODUSUARIO = '+EUsuario.Text);
  if VpaAgendaUsuario then
    VpaSelect.add('and AGE.DATINICIO <= dateformat('''+FormatDateTime('YYYY/MM/DD HH:MM',now)+''',''YYYY/MM/DD HH:MM'')');
  if EEstagio.AInteiro <> 0 THEN
    VpaSelect.add('and AGE.CODESTAGIO = '+EEstagio.Text);
  if ETipoAgendamento.AInteiro <> 0 then
    VpaSelect.add('and AGE.CODTIPOAGENDAMENTO = '+ETipoAgendamento.Text);
  if ECodCliente.AInteiro <> 0 then
    VpaSelect.add('and AGE.CODCLIENTE = '+ECodCliente.Text);
  if EVendedor.AInteiro <> 0 then
    VpaSelect.Add('and CLI.I_COD_VEN = '+EVendedor.Text);
  if ECidade.AInteiro <> 0 then
    VpaSelect.add(' and CLI.C_CID_CLI = '''+LCidade.Caption+'''');
  if (EFilial.AInteiro <> 0) and (EPedidoCompra.AInteiro <> 0) then
    VpaSelect.add(' and AGE.CODFILIALCOMPRA = '+EFilial.Text+
                  ' and AGE.SEQPEDIDOCOMPRA = '+EPedidoCompra.Text);
end;

{******************************************************************************}
procedure TFAgendamentos.Agenda;
begin
  AtualizaConsulta(false,false);
  showmodal;
end;

{******************************************************************************}
procedure TFAgendamentos.VerificaAgendamentoUsuario;
begin
  AtualizaConsulta(false,true);
  BringToFront;
  showmodal;
end;

{******************************************************************************}
procedure TFAgendamentos.ConsultaPedidoCompra(VpaCodFilial,VpaSeqPedido : Integer);
begin
  EFilial.AInteiro := VpaCodFilial;
  EFilial.Atualiza;
  EPedidoCompra.AInteiro := VpaSeqPedido;
  EPedidoCompra.Atualiza;
  EUsuario.Clear;
  EUsuario.Atualiza;
  ESituacao.ItemIndex := 3;
  AtualizaConsulta(false,false);
  showmodal;
end;

{******************************************************************************}
procedure TFAgendamentos.MontaHintGrade;
begin
  Grade.Hint := 'Cliente : '+AgendamentosCODCLIENTE.AsString + '-'+AgendamentosC_NOM_CLI.AsString;
  if AgendamentosDATREALIZADO.AsDateTime > montadata(1,1,1990) then
    Grade.Hint := Grade.Hint +#13+'Data Conclusão : '+FormatDateTime('DD/MM/YYYY HH:MM',AgendamentosDATREALIZADO.AsDateTime);
  Grade.Hint := Grade.Hint +#13+'Usuario Cadastrou : '+AgendamentosCODUSUARIOAGENDOU.AsString+'-'+AgendamentosUSUAGENDOU.AsString; 
end;

procedure TFAgendamentos.RBAgendaDuploCliquePainel(VpaPainel: TComponenteMove);
begin
    FNovoAgedamento := TFNovoAgedamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoAgedamento'));
    FNovoAgedamento.AlteraTarefa(TRBDTarefa(VpaPainel.ADado));
    FNovoAgedamento.free;
end;

procedure TFAgendamentos.RBAgendaFiltro;
begin
  EDatInicio.Date := PrimeiroDiaMes(RBAgenda.ADAgenda.DatAgenda);
  EDatFim.Date := UltimoDiaMes(RBAgenda.ADAgenda.DatAgenda);
  EUsuario.AInteiro := RBAgenda.ADAgenda.CodUsuario;
  AtualizaConsulta(false,false);
  CarTarefasNovaAgenda;
end;

{******************************************************************************}
procedure TFAgendamentos.EUsuarioFimConsulta(Sender: TObject);
begin
  AtualizaConsulta(false,false);
end;

{******************************************************************************}
procedure TFAgendamentos.Concluir1Click(Sender: TObject);
var
  VpfResultado : string;
begin
  if AgendamentosSEQAGENDA.AsInteger <> 0 then
    VpfResultado := FunClientes.SetaAgendaConcluida(AgendamentosCODUSUARIO.AsInteger,AgendamentosSEQAGENDA.AsInteger);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsulta(true,false);
end;

{******************************************************************************}
procedure TFAgendamentos.AgendamentosAfterScroll(DataSet: TDataSet);
begin
  Concluir1.Enabled := (AgendamentosINDREALIZADO.AsString = 'N') and(AgendamentosINDCANCELADO.AsString = 'N');
  Cancelar1.Enabled := (AgendamentosINDREALIZADO.AsString = 'N') and(AgendamentosINDCANCELADO.AsString = 'N');
  Extornar1.Enabled := (AgendamentosINDREALIZADO.AsString = 'S') OR (AgendamentosINDCANCELADO.AsString = 'S');
  MontaHintGrade;
end;

{******************************************************************************}
procedure TFAgendamentos.AgendaNova;
begin
  CPeriodo.Checked := false;
  RBAgenda.ADAgenda.ModeloAgenda := maMes;
  RBAgenda.ADAgenda.DatAgenda := date;
  RBAgenda.ADAgenda.CodUsuario := varia.CodigoUsuario;
  AtualizaConsulta(false,false);
  CarTarefasNovaAgenda;
  RBAgenda.Executa;
end;

{******************************************************************************}
procedure TFAgendamentos.Cancelar1Click(Sender: TObject);
var
  VpfResultado : string;
begin
  if AgendamentosSEQAGENDA.AsInteger <> 0 then
    VpfResultado := FunClientes.CancelaAgendamento(AgendamentosCODUSUARIO.AsInteger,AgendamentosSEQAGENDA.AsInteger);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsulta(true,false);
end;

{******************************************************************************}
procedure TFAgendamentos.CarTarefasNovaAgenda;
var
  VpfDTarefa : TRBDTarefa;
begin
  FreeTObjectsList(RBAgenda.ADAgenda.Dias);
  while not Agendamentos.Eof do
  begin
    VpfDTarefa := RBAgenda.ADAgenda.addTarefa(AgendamentosDATINICIO.AsDateTime);
    VpfDTarefa.SeqAgenda := AgendamentosSEQAGENDA.AsInteger;
    VpfDTarefa.DatCadastro := AgendamentosDATCADASTRO.AsDateTime;
    VpfDTarefa.CodUsuarioAgendou := AgendamentosCODUSUARIOAGENDOU.AsInteger;
    VpfDTarefa.CodCliente := AgendamentosCODCLIENTE.AsInteger;
    VpfDTarefa.CodUsuario := AgendamentosCODUSUARIO.AsInteger;
    VpfDTarefa.CodUsuarioAnterior := AgendamentosCODUSUARIO.AsInteger;
    VpfDTarefa.CodTipo := AgendamentosCODTIPOAGENDAMENTO.AsInteger;
    VpfDTarefa.DesTitulo := AgendamentosDESOBSERVACAO.AsString;
    VpfDTarefa.DatTarefa := AgendamentosDATINICIO.AsDateTime;
    VpfDTarefa.DatFim := AgendamentosDATFIM.AsDateTime;
    VpfDTarefa.DesTitulo := AgendamentosDESTITULO.AsString;
    VpfDTarefa.DesObservacoes := AgendamentosDESOBSERVACAO.AsString;
    VpfDTarefa.CorUsuario := AgendamentosI_COR_AGE.AsInteger;
    VpfDTarefa.CodFilialCompra := AgendamentosCODFILIALCOMPRA.AsInteger;
    VpfDTarefa.SeqPedidoCompra := AgendamentosSEQPEDIDOCOMPRA.AsInteger;
    VpfDTarefa.DatRealizado := AgendamentosDATREALIZADO.AsDateTime;
    VpfDTarefa.IndCancelada := AgendamentosINDCANCELADO.AsString ='S';
    VpfDTarefa.IndConcluida := AgendamentosINDREALIZADO.AsString ='S';
    Agendamentos.Next;
  end;
end;

{******************************************************************************}
procedure TFAgendamentos.Extornar1Click(Sender: TObject);
var
  VpfResultado : string;
begin
  if confirmacao('Tem certeza que deseja extornar o cancelamento ou a data de realização da agenda?') then
  begin
    if AgendamentosSEQAGENDA.AsInteger <> 0 then
      VpfResultado := FunClientes.ExtornaAgendamento(AgendamentosCODUSUARIO.AsInteger,AgendamentosSEQAGENDA.AsInteger);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsulta(true,false);
  end;
end;

{******************************************************************************}
procedure TFAgendamentos.BCadastrarClick(Sender: TObject);
begin
  FNovoAgedamento := TFNovoAgedamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoAgedamento'));
  if FNovoAgedamento.NovaAgenda(varia.CodigoUsuario) then
    AtualizaConsulta(true,false);
  FNovoAgedamento.free;

end;

{******************************************************************************}
procedure TFAgendamentos.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAgendamentos.BAlterarClick(Sender: TObject);
var
  VpfDAgenda : TRBDAgendaSisCorp;
begin
  if AgendamentosSEQAGENDA.AsInteger <> 0 then
  begin
    VpfDAgenda := TRBDAgendaSisCorp.cria;
    FunClientes.CarDAgenda(AgendamentosCODUSUARIO.AsInteger,AgendamentosSEQAGENDA.AsInteger,VpfDAgenda);
    FNovoAgedamento := TFNovoAgedamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoAgedamento'));
    if FNovoAgedamento.AlteraAgendamento(VpfDAgenda) then
      AtualizaConsulta(true,false);
    FNovoAgedamento.free;
  end;
end;

{******************************************************************************}
procedure TFAgendamentos.BConsultarClick(Sender: TObject);
var
  VpfDAgenda : TRBDAgendaSisCorp;
begin
  if AgendamentosSEQAGENDA.AsInteger <> 0 then
  begin
    VpfDAgenda := TRBDAgendaSisCorp.cria;
    FunClientes.CarDAgenda(AgendamentosCODUSUARIO.AsInteger,AgendamentosSEQAGENDA.AsInteger,VpfDAgenda);
    FNovoAgedamento := TFNovoAgedamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoAgedamento'));
    FNovoAgedamento.ConsultaAgenda(VpfDAgenda);
    FNovoAgedamento.free;
  end;
end;

{******************************************************************************}
procedure TFAgendamentos.TelemarketingReceptivo1Click(Sender: TObject);
begin
  if not AgendamentosSEQAGENDA.AsInteger <> 0 then
  begin
    FNovoTeleMarketing := TFNovoTeleMarketing.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoTeleMarketing'));
    FNovoTeleMarketing.TeleMarketingCliente(AgendamentosCODCLIENTE.AsInteger);
    FNovoTeleMarketing.free;
  end;
end;

procedure TFAgendamentos.GradeDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  VpfData : TDatetime;
begin
  VpfData := montadata(dia(AgendamentosDATINICIO.AsDatetime),mes(AgendamentosDATINICIO.AsDatetime),ano(AgendamentosDATINICIO.AsDatetime));
  if VpfData  = date then
  begin
    Grade.Canvas.brush.Color:= clYellow; // coloque aqui a cor desejada
    Grade.Canvas.Font.Color:= clBlack;
    Grade.DefaultDrawDataCell(Rect, Grade.columns[datacol].field, State);
  end
  else
    if VpfData < date then
    begin
      Grade.Canvas.brush.Color:= clred; // coloque aqui a cor desejada
      Grade.Canvas.Font.Color:= clwhite;
      Grade.DefaultDrawDataCell(Rect, Grade.columns[datacol].field, State);
    end;

end;

{******************************************************************************}
procedure TFAgendamentos.AlterarEstgio1Click(Sender: TObject);
var
  VpfDAgenda : TRBDAgendaSisCorp;
begin
  if AgendamentosSEQAGENDA.AsInteger <> 0 then
  begin
    VpfDAgenda := TRBDAgendaSisCorp.cria;
    FunClientes.CarDAgenda(AgendamentosCODUSUARIO.AsInteger,AgendamentosSEQAGENDA.AsInteger,VpfDAgenda);
    FAlteraEstagioAgendamento := TFAlteraEstagioAgendamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraEstagioAgendamento'));
    if FAlteraEstagioAgendamento.AlteraEstagioAgenda(VpfDAgenda) then
      AtualizaConsulta(true,false);
    FAlteraEstagioAgendamento.free;
    VpfDAgenda.free;
  end;
end;

{******************************************************************************}
procedure TFAgendamentos.ECidadeFimConsulta(Sender: TObject);
begin
  AtualizaConsulta(false, false);
end;

{******************************************************************************}
procedure TFAgendamentos.EPedidoCompraSelect(Sender: TObject);
begin
  EPedidoCompra.ASelectValida.Text := 'SELECT PED.CODFILIAL, PED.SEQPEDIDO, PED.DATPEDIDO,PED.DATENTREGA, '+
                                      ' CLI.C_NOM_CLI '+
                                      ' FROM PEDIDOCOMPRACORPO PED, CADCLIENTES CLI '+
                                      ' Where CLI.I_COD_CLI = PED.CODCLIENTE '+
                                      ' and PED.SEQPEDIDO = @'+
                                      ' AND PED.CODFILIAL = '+IntToStr(EFilial.AInteiro);
  EPedidoCompra.ASelectLocaliza.Text := 'SELECT PED.CODFILIAL, PED.SEQPEDIDO, PED.DATPEDIDO,PED.DATENTREGA, '+
                                      ' CLI.C_NOM_CLI '+
                                      ' FROM PEDIDOCOMPRACORPO PED, CADCLIENTES CLI '+
                                      ' Where CLI.I_COD_CLI = PED.CODCLIENTE '+
                                      ' and PED.CODFILIAL = '+IntToStr(EFilial.AInteiro);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAgendamentos]);
end.
