unit AManutencaoEmail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, StdCtrls, Buttons, Grids,
  DBGrids, Tabela, Db, DBTables, Menus, unEMarketing,
  ComCtrls, DBClient;

type
  TFManutencaoEmail = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BFechar: TBitBtn;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    Splitter1: TSplitter;
    PanelColor5: TPanelColor;
    Label1: TLabel;
    ENome: TEditColor;
    EEmail: TEditColor;
    Label2: TLabel;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    GClientes: TDBGridColor;
    PanelColor8: TPanelColor;
    GContatosCliente: TDBGridColor;
    PanelColor10: TPanelColor;
    GContatosProspect: TDBGridColor;
    GProspect: TDBGridColor;
    CADCLIENTES: TSQL;
    DataCADCLIENTES: TDataSource;
    PROSPECT: TSQL;
    DataPROSPECT: TDataSource;
    CONTATOSCLIENTE: TSQL;
    DataCONTATOSCLIENTE: TDataSource;
    CONTATOSPROSPECT: TSQL;
    DataCONTATOSPROSPECT: TDataSource;
    CADCLIENTESC_ACE_SPA: TWideStringField;
    CADCLIENTESC_END_ELE: TWideStringField;
    CADCLIENTESC_CON_CLI: TWideStringField;
    CADCLIENTESC_NOM_CLI: TWideStringField;
    CADCLIENTESI_COD_CLI: TFMTBCDField;
    CONTATOSCLIENTESEQCONTATO: TFMTBCDField;
    CONTATOSCLIENTENOMCONTATO: TWideStringField;
    CONTATOSCLIENTEDESTELEFONE: TWideStringField;
    CONTATOSCLIENTEDESEMAIL: TWideStringField;
    CONTATOSCLIENTEINDACEITAEMARKETING: TWideStringField;
    PROSPECTINDACEITASPAM: TWideStringField;
    PROSPECTDESEMAILCONTATO: TWideStringField;
    PROSPECTNOMCONTATO: TWideStringField;
    PROSPECTNOMPROSPECT: TWideStringField;
    PROSPECTCODPROSPECT: TFMTBCDField;
    CONTATOSPROSPECTSEQCONTATO: TFMTBCDField;
    CONTATOSPROSPECTINDACEITAEMARKETING: TWideStringField;
    CONTATOSPROSPECTNOMCONTATO: TWideStringField;
    CONTATOSPROSPECTDESTELEFONE: TWideStringField;
    CONTATOSPROSPECTDESEMAIL: TWideStringField;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    PClientes: TPopupMenu;
    BAtivaDesativaCliente: TMenuItem;
    N1: TMenuItem;
    AlterarEMail1: TMenuItem;
    PProspects: TPopupMenu;
    BAtivaDesativaProspect: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PContatosCliente: TPopupMenu;
    BAtivaDesativaContatoCliente: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    PContatoProspect: TPopupMenu;
    BAtivaDesativaContatoProspect: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    Label3: TLabel;
    CONTATOSCLIENTECODCLIENTE: TFMTBCDField;
    CONTATOSPROSPECTCODPROSPECT: TFMTBCDField;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    N2: TMenuItem;
    EfeturarTelemarketing1: TMenuItem;
    N3: TMenuItem;
    EfetuarTelemarketing1: TMenuItem;
    N4: TMenuItem;
    EfetuarTelemarketing2: TMenuItem;
    N5: TMenuItem;
    EfetuarTelemarketing3: TMenuItem;
    PEMailRetorno: TPanelColor;
    Progresso: TProgressBar;
    Animate1: TAnimate;
    LREtornoEmail: TLabel;
    BRetorno: TSpeedButton;
    Retorno: TTimer;
    EData: TEditColor;
    Label7: TLabel;
    LContaEmail: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ENomeExit(Sender: TObject);
    procedure ENomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PClientesPopup(Sender: TObject);
    procedure BAtivaDesativaClienteClick(Sender: TObject);
    procedure AlterarEMail1Click(Sender: TObject);
    procedure PProspectsPopup(Sender: TObject);
    procedure BAtivaDesativaProspectClick(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure PContatosClientePopup(Sender: TObject);
    procedure BAtivaDesativaContatoClienteClick(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure PContatoProspectPopup(Sender: TObject);
    procedure BAtivaDesativaContatoProspectClick(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure EfeturarTelemarketing1Click(Sender: TObject);
    procedure EfetuarTelemarketing1Click(Sender: TObject);
    procedure EfetuarTelemarketing2Click(Sender: TObject);
    procedure EfetuarTelemarketing3Click(Sender: TObject);
    procedure BRetornoClick(Sender: TObject);
    procedure RetornoTimer(Sender: TObject);
  private
    VprEnviando : Boolean;
    FunEmarketing : TRBFuncoesEMarketing;
    procedure AtualizaConsulta;
    procedure AtualizaConsultaCliente(VpaPosicionar: Boolean = False);
    procedure AtualizaConsultaProspect(VpaPosicionar: Boolean = False);
    procedure AtualizaConsultaContatosCliente(VpaPosicionar: Boolean = False);
    procedure AtualizaConsultaContatosProspect(VpaPosicionar: Boolean = False);

    procedure AdicionaFiltrosCliente(VpaSelect: TStrings);
    procedure AdicionaFiltrosProspect(VpaSelect: TStrings);
    procedure AdicionaFiltrosContatosCliente(VpaSelect: TStrings);
    procedure AdicionaFiltrosContatosProspect(VpaSelect: TStrings);

    procedure AtivarCliente;
    procedure DesativarCliente;
    procedure AlterarEmailCliente;

    procedure AtivarProspect;
    procedure DesativarProspect;
    procedure AlteraEmailProspect;

    procedure AtivarContatoCliente;
    procedure DesativarContatoCliente;
    procedure AlterarEmailContatoCliente;

    procedure AtivarContatoProspect;
    procedure DesativarContatoProspect;
    procedure AlterarEmailContatoProspect;
  public
  end;

var
  FManutencaoEmail: TFManutencaoEmail;

implementation
uses
  APrincipal, UnClientes, UnProspect, ConstMsg, ANovoTeleMarketing,
  ANovoTelemarketingProspect;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFManutencaoEmail.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunEmarketing := TRBFuncoesEMarketing.cria(FPrincipal.BaseDados);
  AtualizaConsulta;
  ActiveControl:= EEmail;
  VprEnviando := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFManutencaoEmail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CADCLIENTES.Close;
  PROSPECT.Close;
  CONTATOSCLIENTE.Close;
  CONTATOSPROSPECT.Close;
  FunEmarketing.free;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFManutencaoEmail.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AtualizaConsulta;
begin
  AtualizaConsultaCliente;
  AtualizaConsultaProspect;
  AtualizaConsultaContatosCliente;
  AtualizaConsultaContatosProspect;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AtualizaConsultaCliente(VpaPosicionar: Boolean);
var
  VpfPosicao: TBookmark;
begin
  if VpaPosicionar then
    VpfPosicao:= CADCLIENTES.GetBookmark;
  CADCLIENTES.Close;
  CADCLIENTES.SQL.Clear;
  CADCLIENTES.SQL.Add('SELECT CLI.I_COD_CLI, CLI.C_ACE_SPA, CLI.C_END_ELE,'+
                      ' CLI.C_CON_CLI, CLI.C_NOM_CLI'+
                      ' FROM CADCLIENTES CLI'+
                      ' WHERE'+
                      ' CLI.I_COD_CLI = CLI.I_COD_CLI');
  AdicionaFiltrosCliente(CADCLIENTES.SQL);
//  CADCLIENTES.SQL.Add(' ORDER BY CLI.C_NOM_CLI');
  CADCLIENTES.Open;
  if VpaPosicionar then
  begin
    try
      CADCLIENTES.GotoBookmark(VpfPosicao);
      CADCLIENTES.FreeBookmark(VpfPosicao);
    except
    end;
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AdicionaFiltrosCliente(VpaSelect: TStrings);
begin
  if ENome.Text <> '' then
    VpaSelect.Add(' AND C_NOM_CLI LIKE '''+ENome.Text+'%''');
  if EEmail.Text <> '' then
    VpaSelect.Add(' AND LOWER(C_END_ELE) LIKE '''+EEmail.Text+'%''');
end;

{******************************************************************************}
procedure TFManutencaoEmail.AtualizaConsultaContatosCliente(VpaPosicionar: Boolean);
var
  VpfPosicao: TBookmark;
begin
  if VpaPosicionar then
    VpfPosicao:= CONTATOSCLIENTE.GetBookmark;
  CONTATOSCLIENTE.close;
  CONTATOSCLIENTE.SQL.Clear;
  CONTATOSCLIENTE.SQL.Add('SELECT CCL.CODCLIENTE, CCL.SEQCONTATO, CCL.INDACEITAEMARKETING,'+
                          ' CCL.NOMCONTATO, CCL.DESTELEFONE, CCL.DESEMAIL'+
                          ' FROM CONTATOCLIENTE CCL'+
                          ' WHERE'+
                          ' CCL.CODCLIENTE = CCL.CODCLIENTE');
  AdicionaFiltrosContatosCliente(CONTATOSCLIENTE.SQL);
//  CONTATOSCLIENTE.SQL.Add(' ORDER BY CCL.NOMCONTATO');
  CONTATOSCLIENTE.Open;
  if VpaPosicionar then
  begin
    try
      CONTATOSCLIENTE.GotoBookmark(VpfPosicao);
      CONTATOSCLIENTE.FreeBookmark(VpfPosicao);
    except
    end;
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AdicionaFiltrosContatosCliente(VpaSelect: TStrings);
begin
  if ENome.Text <> '' then
    VpaSelect.Add(' AND NOMCONTATO LIKE '''+ENome.Text+'%''');
  if EEmail.Text <> '' then
    VpaSelect.Add(' AND LOWER(DESEMAIL) LIKE '''+EEmail.Text+'%''');
end;

{******************************************************************************}
procedure TFManutencaoEmail.AtualizaConsultaProspect(VpaPosicionar: Boolean);
var
  VpfPosicao: TBookmark;
begin
  if VpaPosicionar then
    VpfPosicao:= PROSPECT.GetBookmark;
  PROSPECT.Close;
  PROSPECT.SQL.Clear;
  PROSPECT.SQL.Add('SELECT PCT.CODPROSPECT, PCT.INDACEITASPAM, PCT.DESEMAILCONTATO,'+
                   ' PCT.NOMCONTATO, PCT.NOMPROSPECT'+
                   ' FROM PROSPECT PCT'+
                   ' WHERE'+
                   ' PCT.CODPROSPECT = PCT.CODPROSPECT');
  AdicionaFiltrosProspect(PROSPECT.SQL);
//  PROSPECT.SQL.Add(' ORDER BY PCT.NOMPROSPECT');
  PROSPECT.Open;
  if VpaPosicionar then
  begin
    try
      PROSPECT.GotoBookmark(VpfPosicao);
      PROSPECT.FreeBookmark(VpfPosicao);
    except
    end;
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AdicionaFiltrosProspect(VpaSelect: TStrings);
begin
  if ENome.Text <> '' then
    VpaSelect.Add(' AND NOMPROSPECT LIKE '''+ENome.Text+'%''');
  if EEmail.Text <> '' then
    VpaSelect.Add(' AND LOWER(DESEMAILCONTATO) LIKE '''+EEmail.Text+'%''');
end;

{******************************************************************************}
procedure TFManutencaoEmail.AtualizaConsultaContatosProspect(VpaPosicionar: Boolean);
var
  VpfPosicao: TBookmark;
begin
  if VpaPosicionar then
    VpfPosicao:= CONTATOSPROSPECT.GetBookmark;
  CONTATOSPROSPECT.close;
  CONTATOSPROSPECT.SQL.Clear;
  CONTATOSPROSPECT.SQL.Add('SELECT CPR.CODPROSPECT, CPR.SEQCONTATO, CPR.INDACEITAEMARKETING,'+
                           ' CPR.NOMCONTATO, CPR.DESTELEFONE, CPR.DESEMAIL'+
                           ' FROM CONTATOPROSPECT CPR'+
                           ' WHERE'+
                           ' CPR.CODPROSPECT = CPR.CODPROSPECT');
  AdicionaFiltrosContatosProspect(CONTATOSPROSPECT.SQL);
  CONTATOSPROSPECT.Open;
  if VpaPosicionar then
  begin
    try
      CONTATOSPROSPECT.GotoBookmark(VpfPosicao);
      CONTATOSPROSPECT.FreeBookmark(VpfPosicao);
    except
    end;
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AdicionaFiltrosContatosProspect(VpaSelect: TStrings);
begin
  if ENome.Text <> '' then
    VpaSelect.Add(' AND NOMCONTATO LIKE '''+ENome.Text+'%''');
  if EEmail.Text <> '' then
    VpaSelect.Add(' AND LOWER(DESEMAIL) LIKE '''+EEmail.Text+'%''');
end;

{******************************************************************************}
procedure TFManutencaoEmail.ENomeExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFManutencaoEmail.ENomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.PClientesPopup(Sender: TObject);
begin
  if CADCLIENTESC_ACE_SPA.AsString = 'S' then
    BAtivaDesativaCliente.Caption:= '&Desativar'
  else
    BAtivaDesativaCliente.Caption:= '&Ativar';
end;

{******************************************************************************}
procedure TFManutencaoEmail.BAtivaDesativaClienteClick(Sender: TObject);
begin
  if CADCLIENTESI_COD_CLI.AsInteger = 0 then
  begin
    aviso('SELECIONE UM REGISTRO!!!'#13'É necessário selecionar um cliente para poder seguir em frente.');
    Exit;
  end;
  if BAtivaDesativaCliente.Caption = '&Ativar' then
    AtivarCliente
  else
    DesativarCliente;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AtivarCliente;
var
  VpfResultado: String;
begin
  VpfResultado:= FunClientes.AtivarEmailCliente(CADCLIENTESI_COD_CLI.AsInteger, True);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsultaCliente(True);
end;

{******************************************************************************}
procedure TFManutencaoEmail.DesativarCliente;
var
  VpfResultado: String;
begin
  VpfResultado:= FunClientes.AtivarEMailCliente(CADCLIENTESI_COD_CLI.AsInteger, False);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsultaCliente(True);
end;

{******************************************************************************}
procedure TFManutencaoEmail.AlterarEMail1Click(Sender: TObject);
begin
  if CADCLIENTESI_COD_CLI.AsInteger = 0 then
  begin
    aviso('SELECIONE UM REGISTRO!!!'#13'É necessário selecionar um cliente para poder seguir em frente.');
    Exit;
  end;
  AlterarEmailCliente;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AlterarEmailCliente;
var
  VpfNovoEmail,
  VpfResultado: String;
begin
  VpfResultado:= '';
  VpfNovoEmail:= CADCLIENTESC_END_ELE.AsString;
  if Entrada('Alteração E-Mail','Informe o novo email:',VpfNovoEmail,False,
             FPrincipal.CorFoco.ACorFundoFoco,FPrincipal.CorForm.ACorPainel) then
  begin
    VpfResultado:= FunClientes.AlteraEmailCliente(CADCLIENTESI_COD_CLI.AsInteger,VpfNovoEmail);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsultaCliente(True);
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.PProspectsPopup(Sender: TObject);
begin
  if PROSPECTINDACEITASPAM.AsString = 'S' then
    BAtivaDesativaProspect.Caption:= '&Desativar'
  else
    BAtivaDesativaProspect.Caption:= '&Ativar';
end;

{******************************************************************************}
procedure TFManutencaoEmail.BAtivaDesativaProspectClick(Sender: TObject);
begin
  if PROSPECTCODPROSPECT.AsInteger = 0 then
  begin
    aviso('SELECIONE UM REGISTRO!!!'#13'É necessário selecionar um prospect para poder seguir em frente.');
    Exit;
  end;
  if BAtivaDesativaProspect.Caption = '&Ativar' then
    AtivarProspect
  else
    DesativarProspect;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AtivarProspect;
var
  VpfResultado: String;
begin
  VpfResultado:= FunProspect.AtivarEmailProspect(PROSPECTCODPROSPECT.AsInteger, True);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsultaProspect(True);
end;

{******************************************************************************}
procedure TFManutencaoEmail.DesativarProspect;
var
  VpfResultado: String;
begin
  VpfResultado:= FunProspect.AtivarEmailProspect(PROSPECTCODPROSPECT.AsInteger, False);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsultaProspect(True);
end;

{******************************************************************************}
procedure TFManutencaoEmail.MenuItem3Click(Sender: TObject);
begin
  if PROSPECTCODPROSPECT.AsInteger = 0 then
  begin
    aviso('SELECIONE UM REGISTRO!!!'#13'É necessário selecionar um prospect para poder seguir em frente.');
    Exit;
  end;
  AlteraEmailProspect;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AlteraEmailProspect;
var
  VpfNovoEmail,
  VpfResultado: String;
begin
  VpfNovoEmail:= PROSPECTDESEMAILCONTATO.AsString;
  if Entrada('Alteração E-Mail','Informe o novo email:',VpfNovoEmail,False,
             FPrincipal.CorFoco.ACorFundoFoco,FPrincipal.CorForm.ACorPainel) then
  begin
    VpfResultado:= FunProspect.AlteraEmailProspect(PROSPECTCODPROSPECT.AsInteger,VpfNovoEmail);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsultaProspect(True);
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.PContatosClientePopup(Sender: TObject);
begin
  if CONTATOSCLIENTEINDACEITAEMARKETING.AsString = 'S' then
    BAtivaDesativaContatoCliente.Caption:= '&Desativar'
  else
    BAtivaDesativaContatoCliente.Caption:= '&Ativar';
end;

{******************************************************************************}
procedure TFManutencaoEmail.BAtivaDesativaContatoClienteClick(Sender: TObject);
begin
  if CONTATOSCLIENTESEQCONTATO.AsInteger = 0 then
  begin
    aviso('SELECIONE UM REGISTRO!!!'#13'É necessário selecionar o contato de um cliente para poder seguir em frente.');
    Exit;
  end;
  if BAtivaDesativaContatoCliente.Caption = '&Ativar' then
    AtivarContatoCliente
  else
    DesativarContatoCliente;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AtivarContatoCliente;
var
  VpfResultado: String;
begin
  if Confirmacao('Deseja ativar este contato do cliente?') then
  begin
    VpfResultado:= FunClientes.AtivarEmailContatoCliente(CONTATOSCLIENTECODCLIENTE.AsInteger,CONTATOSCLIENTESEQCONTATO.AsInteger, True);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsultaContatosCliente(True);
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.DesativarContatoCliente;
var
  VpfResultado: String;
begin
  VpfResultado:= '';
  if Confirmacao('Deseja desativar este contato do cliente?') then
  begin
    VpfResultado:= FunClientes.AtivarEmailContatoCliente(CONTATOSCLIENTECODCLIENTE.AsInteger,CONTATOSCLIENTESEQCONTATO.AsInteger, False);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsultaContatosCliente(True);
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.MenuItem5Click(Sender: TObject);
begin
  if CONTATOSCLIENTESEQCONTATO.AsInteger = 0 then
  begin
    aviso('SELECIONE UM REGISTRO!!!'#13'É necessário selecionar o contato de um cliente para poder seguir em frente.');
    Exit;
  end;
  AlterarEmailContatoCliente;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AlterarEmailContatoCliente;
var
  VpfNovoEmail,
  VpfResultado: String;
begin
  VpfResultado:= '';
  if Confirmacao('Deseja alterar o e-Mail do contato deste cliente?') then
  begin
    VpfNovoEmail:= CONTATOSCLIENTEDESEMAIL.AsString;
    if Entrada('Alteração E-Mail','Informe o novo email:',VpfNovoEmail,False,
               FPrincipal.CorFoco.ACorFundoFoco,FPrincipal.CorForm.ACorPainel) then
    begin
      VpfResultado:= FunClientes.AlteraEmailContatoCliente(CONTATOSCLIENTECODCLIENTE.AsInteger,CONTATOSCLIENTESEQCONTATO.AsInteger,VpfNovoEmail);
      if VpfResultado <> '' then
        aviso(VpfResultado)
      else
        AtualizaConsultaContatosCliente(True);
    end;
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.PContatoProspectPopup(Sender: TObject);
begin
  if CONTATOSPROSPECTINDACEITAEMARKETING.AsString = 'S' then
    BAtivaDesativaContatoProspect.Caption:= '&Desativar'
  else
    BAtivaDesativaContatoProspect.Caption:= '&Ativar';
end;

{******************************************************************************}
procedure TFManutencaoEmail.BAtivaDesativaContatoProspectClick(
  Sender: TObject);
begin
  if CONTATOSPROSPECTSEQCONTATO.AsInteger = 0 then
  begin
    aviso('SELECIONE UM REGISTRO!!!'#13'É necessário selecionar o contato de um prospect para poder seguir em frente.');
    Exit;
  end;
  if BAtivaDesativaContatoProspect.Caption = '&Ativar' then
    AtivarContatoProspect
  else
    DesativarContatoProspect;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AtivarContatoProspect;
var
  VpfResultado: String;
begin
  VpfResultado:= FunProspect.AtivarEmailContatoProspect(CONTATOSPROSPECTCODPROSPECT.AsInteger,CONTATOSPROSPECTSEQCONTATO.AsInteger, True);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsultaContatosProspect(True);
end;

{******************************************************************************}
procedure TFManutencaoEmail.DesativarContatoProspect;
var
  VpfResultado: String;
begin
  VpfResultado:= FunProspect.AtivarEmailContatoProspect(CONTATOSPROSPECTCODPROSPECT.AsInteger,CONTATOSPROSPECTSEQCONTATO.AsInteger, False);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsultaContatosProspect(True);
end;

{******************************************************************************}
procedure TFManutencaoEmail.MenuItem7Click(Sender: TObject);
begin
  if CONTATOSPROSPECTSEQCONTATO.AsInteger = 0 then
  begin
    aviso('SELECIONE UM REGISTRO!!!'#13'É necessário selecionar o contato de um prospect para poder seguir em frente.');
    Exit;
  end;
  AlterarEmailContatoProspect;
end;

{******************************************************************************}
procedure TFManutencaoEmail.AlterarEmailContatoProspect;
var
  VpfNovoEmail,
  VpfResultado: String;
begin
  VpfResultado:= '';
  VpfNovoEmail:= CONTATOSPROSPECTDESEMAIL.AsString;
  if Entrada('Alteração E-Mail','Informe o novo email:',VpfNovoEmail,False,
             FPrincipal.CorFoco.ACorFundoFoco,FPrincipal.CorForm.ACorPainel) then
  begin
    VpfResultado:= FunProspect.AlteraEmailContatoProspect(CONTATOSPROSPECTCODPROSPECT.AsInteger,CONTATOSPROSPECTSEQCONTATO.AsInteger,VpfNovoEmail);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsultaContatosProspect(True);
  end;
end;

{******************************************************************************}
procedure TFManutencaoEmail.EfeturarTelemarketing1Click(Sender: TObject);
begin
  FNovoTeleMarketing := TFNovoTeleMarketing.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoTeleMarketing'));
  FNovoTeleMarketing.TeleMarketingCliente(CADCLIENTESI_COD_CLI.AsInteger);
  FNovoTeleMarketing.free;
end;

{******************************************************************************}
procedure TFManutencaoEmail.EfetuarTelemarketing1Click(Sender: TObject);
begin
  FNovoTeleMarketing := TFNovoTeleMarketing.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoTeleMarketing'));
  FNovoTeleMarketing.TeleMarketingCliente(CONTATOSCLIENTECODCLIENTE.AsInteger);
  FNovoTeleMarketing.free;
end;

{******************************************************************************}
procedure TFManutencaoEmail.EfetuarTelemarketing2Click(Sender: TObject);
begin
  FNovoTelemarketingProspect := TFNovoTelemarketingProspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoTelemarketingProspect'));
  FNovoTelemarketingProspect.TeleMarketingProspect(PROSPECTCODPROSPECT.AsInteger);
  FNovoTelemarketingProspect.free;
end;

{******************************************************************************}
procedure TFManutencaoEmail.EfetuarTelemarketing3Click(Sender: TObject);
begin
  FNovoTelemarketingProspect := TFNovoTelemarketingProspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoTelemarketingProspect'));
  FNovoTelemarketingProspect.TeleMarketingProspect(CONTATOSPROSPECTCODPROSPECT.AsInteger);
  FNovoTelemarketingProspect.free;
end;

{******************************************************************************}
procedure TFManutencaoEmail.BRetornoClick(Sender: TObject);
begin
  RetornoTimer(Retorno);
  Retorno.Enabled := BRetorno.Down;
end;

{******************************************************************************}
procedure TFManutencaoEmail.RetornoTimer(Sender: TObject);
var
  VpfResultado : String;
begin
  if not VprEnviando then
  begin
    PEMailRetorno.Visible := true;
    try
      VprEnviando := true;
      Animate1.Active := true;
      VpfResultado := FunEmarketing.VerificaEmailInvalido(Progresso,LREtornoEmail,LContaEmail);
      if VpfResultado <> '' then
        aviso(VpfResultado);
      Animate1.Active := false;
      PEMailRetorno.Visible := false;
      VprEnviando := false;
    except
      on e : exception do
      begin
        LREtornoEmail.Caption := e.message;
        VprEnviando := false;
      end;
    end;
    EData.Text := FormatDateTime('HH:MM:SS',now);
  end;
end;

initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFManutencaoEmail]);
end.
