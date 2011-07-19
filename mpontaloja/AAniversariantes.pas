unit AAniversariantes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls,
  Grids, DBGrids, Tabela, DBKeyViolation, Db, DBTables, Menus, DBClient;

type
  TFAniversariantes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BEnviarEmail: TBitBtn;
    EDatInicio: TCalendario;
    Label2: TLabel;
    EDatFim: TCalendario;
    CPeriodo: TCheckBox;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    Splitter1: TSplitter;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    PanelColor8: TPanelColor;
    PanelColor9: TPanelColor;
    Label1: TLabel;
    Splitter2: TSplitter;
    PanelColor10: TPanelColor;
    Label3: TLabel;
    PanelColor11: TPanelColor;
    Label4: TLabel;
    PanelColor12: TPanelColor;
    Label5: TLabel;
    GClientesFornecedores: TGridIndice;
    GContatosCliente: TGridIndice;
    GProspects: TGridIndice;
    GContatosProspect: TGridIndice;
    CADCLIENTES: TSQL;
    CADCLIENTESD_DAT_NAS: TSQLTimeStampField;
    CADCLIENTESIDADE: TFMTBCDField;
    CADCLIENTESC_NOM_CLI: TWideStringField;
    CADCLIENTESC_FO1_CLI: TWideStringField;
    CADCLIENTESC_END_ELE: TWideStringField;
    CADCLIENTESC_CID_CLI: TWideStringField;
    DataCADCLIENTES: TDataSource;
    CONTATOCLIENTE: TSQL;
    DataCONTATOCLIENTE: TDataSource;
    CONTATOCLIENTEDATNASCIMENTO: TSQLTimeStampField;
    CONTATOCLIENTENOMCONTATO: TWideStringField;
    CONTATOCLIENTEC_NOM_CLI: TWideStringField;
    CONTATOCLIENTEC_NOM_FAN: TWideStringField;
    CONTATOCLIENTEC_FO1_CLI: TWideStringField;
    CONTATOCLIENTEC_END_ELE: TWideStringField;
    CONTATOCLIENTEC_CID_CLI: TWideStringField;
    CONTATOCLIENTEIDADE: TFMTBCDField;
    Splitter3: TSplitter;
    PROSPECT: TSQL;
    DataPROSPECT: TDataSource;
    PROSPECTDATNASCIMENTO: TSQLTimeStampField;
    PROSPECTIDADE: TFMTBCDField;
    PROSPECTNOMPROSPECT: TWideStringField;
    PROSPECTDESFONE1: TWideStringField;
    PROSPECTDESEMAILCONTATO: TWideStringField;
    PROSPECTDESCIDADE: TWideStringField;
    CONTATOPROSPECT: TSQL;
    DataCONTATOPROSPECT: TDataSource;
    CONTATOPROSPECTDATNASCIMENTO: TSQLTimeStampField;
    CONTATOPROSPECTIDADE: TFMTBCDField;
    CONTATOPROSPECTNOMCONTATO: TWideStringField;
    CONTATOPROSPECTNOMPROSPECT: TWideStringField;
    CONTATOPROSPECTNOMFANTASIA: TWideStringField;
    CONTATOPROSPECTDESFONE1: TWideStringField;
    CONTATOPROSPECTDESEMAILCONTATO: TWideStringField;
    CONTATOPROSPECTDESCIDADE: TWideStringField;
    PClientes: TPopupMenu;
    EnviarEMail1: TMenuItem;
    Telemarketing1: TMenuItem;
    CADCLIENTESI_COD_CLI: TFMTBCDField;
    PContatosCliente: TPopupMenu;
    EnviarEMail2: TMenuItem;
    Telemarketing2: TMenuItem;
    CONTATOCLIENTECODCLIENTE: TFMTBCDField;
    PROSPECTCODPROSPECT: TFMTBCDField;
    CONTATOPROSPECTCODPROSPECT: TFMTBCDField;
    PProspects: TPopupMenu;
    EMail1: TMenuItem;
    Telemarketing3: TMenuItem;
    PContatosProspect: TPopupMenu;
    EMail2: TMenuItem;
    Telemarketing4: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GClientesFornecedoresOrdem(Ordem: String);
    procedure CPeriodoClick(Sender: TObject);
    procedure GContatosClienteOrdem(Ordem: String);
    procedure GProspectsOrdem(Ordem: String);
    procedure GContatosProspectOrdem(Ordem: String);
    procedure EnviarEMail1Click(Sender: TObject);
    procedure Telemarketing1Click(Sender: TObject);
    procedure EnviarEMail2Click(Sender: TObject);
    procedure Telemarketing2Click(Sender: TObject);
    procedure EMail1Click(Sender: TObject);
    procedure Telemarketing3Click(Sender: TObject);
    procedure EMail2Click(Sender: TObject);
    procedure Telemarketing4Click(Sender: TObject);
  private
    VprOrdemCliente,
    VprOrdemContatoCliente,
    VprOrdemProspect,
    VprOrdemContatoProspect: String;
    procedure InicializaTela;
    procedure AtualizaConsultas;
    procedure AtualizaConsultaCliente;
    procedure AdicionaFiltrosCliente(VpaSelect: TStrings);
    procedure AtualizaConsultaContatoCliente;
    procedure AdicionaFiltrosContatoCliente(VpaSelect: TStrings);
    procedure AtualizaConsultaProspect;
    procedure AdicionaFiltrosProspect(VpaSelect: TStrings);
    procedure AtualizaConsultaContatoProspect;
    procedure AdicionaFiltrosContatoProspect(VpaSelect: TStrings);
    procedure EmailCliente; //rafael
    procedure TelemarketingCliente(VpaCodCliente: Integer);
    procedure EMailContatoCliente; //rafael
    procedure EMailProspect; //rafael
    procedure TelemarketingProspect(VpaCodProspect: Integer);
    procedure EmailContatoProspect; //rafael
  public
  end;

var
  FAniversariantes: TFAniversariantes;

implementation
uses
  APrincipal, FunData, FunSQL, UnDados, ANovoTeleMarketing, ConstMsg,
  ANovoTelemarketingProspect;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAniversariantes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  InicializaTela;
  VprOrdemCliente:= '';
  VprOrdemContatoCliente:= '';
  VprOrdemProspect:= '';
  VprOrdemContatoProspect:= '';
  AtualizaConsultas;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAniversariantes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CADCLIENTES.Close;
  PROSPECT.Close;
  CONTATOCLIENTE.Close;
  CONTATOPROSPECT.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAniversariantes.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFAniversariantes.CPeriodoClick(Sender: TObject);
begin
  AtualizaConsultas;
end;

{******************************************************************************}
procedure TFAniversariantes.InicializaTela;
begin
  EDatInicio.DateTime:= PrimeiroDiaMes(Date);
  EDatFim.DateTime:= UltimoDiaMes(Date);
  ActiveControl:= EDatInicio;
end;

{******************************************************************************}
procedure TFAniversariantes.AtualizaConsultas;
begin
  AtualizaConsultaCliente;
  AtualizaConsultaContatoCliente;
  AtualizaConsultaProspect;
  AtualizaConsultaContatoProspect;
end;

{******************************************************************************}
procedure TFAniversariantes.AtualizaConsultaCliente;
begin
  CADCLIENTES.Close;
  CADCLIENTES.SQL.Clear;
  CADCLIENTES.SQL.Add('SELECT CLI.I_COD_CLI, CLI.D_DAT_NAS, ('+ FormatDateTime('YYYY',Now) +'- '+SqlTextoAno('CLI.D_DAT_NAS')+') IDADE,'+
                      ' CLI.C_NOM_CLI, CLI.C_FO1_CLI, CLI.C_END_ELE, CLI.C_CID_CLI'+
                      ' FROM CADCLIENTES CLI'+
                      ' WHERE CLI.I_COD_CLI = CLI.I_COD_CLI');
  AdicionaFiltrosCliente(CADCLIENTES.SQL);
  CADCLIENTES.SQL.Add(VprOrdemCliente);
  CADCLIENTES.Open;
  GClientesFornecedores.ALinhaSQLOrderBy:= CADCLIENTES.SQL.Count-1;
end;

{******************************************************************************}
procedure TFAniversariantes.AdicionaFiltrosCliente(VpaSelect: TStrings);
begin
//verificar - não encontrei outra forma mais fácil de fazer
  if CPeriodo.Checked then
  begin
    VpaSelect.Add(' AND '+SQLTextoDia('CLI.D_DAT_NAS')+' BETWEEN '+IntToStr(Dia(EDatInicio.Datetime))+' AND '+IntToStr(Dia(EDatFim.Datetime)));
    VpaSelect.Add(' AND '+SQLTextoMes('CLI.D_DAT_NAS')+' BETWEEN '+IntToStr(Mes(EDatInicio.Datetime))+' AND '+IntToStr(Mes(EDatFim.Datetime)));
//    VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('CLI.D_DAT_NAS',EDatInicio.Datetime,EDatFim.Datetime,True));
  end;
end;

{******************************************************************************}
procedure TFAniversariantes.GClientesFornecedoresOrdem(Ordem: String);
begin
  VprOrdemCliente:= Ordem;
end;

{******************************************************************************}
procedure TFAniversariantes.AtualizaConsultaContatoCliente;
begin
  CONTATOCLIENTE.Close;
  CONTATOCLIENTE.SQL.Clear;
  CONTATOCLIENTE.SQL.Add('SELECT CCL.CODCLIENTE, CCL.DATNASCIMENTO, ('+ FormatDateTime('YYYY',Now) +'- '+SqlTExtoAno('CCL.DATNASCIMENTO')+') IDADE,'+
                         ' CCL.NOMCONTATO, CLI.C_NOM_CLI, CLI.C_NOM_FAN, CLI.C_FO1_CLI, CLI.C_END_ELE, CLI.C_CID_CLI'+
                         ' FROM CONTATOCLIENTE CCL, CADCLIENTES CLI'+
                         ' WHERE CLI.I_COD_CLI = CCL.CODCLIENTE');
  AdicionaFiltrosContatoCliente(CONTATOCLIENTE.SQL);
  CONTATOCLIENTE.SQL.Add(VprOrdemContatoCliente);
  CONTATOCLIENTE.Open;
  GContatosCliente.ALinhaSQLOrderBy:= CONTATOCLIENTE.SQL.Count-1;
end;

{******************************************************************************}
procedure TFAniversariantes.AdicionaFiltrosContatoCliente(VpaSelect: TStrings);
begin
//verificar - não encontrei outra forma mais fácil de fazer
  if CPeriodo.Checked then
  begin
    VpaSelect.Add(' AND '+SQLTextoDia('CCL.DATNASCIMENTO')+' BETWEEN '+IntToStr(Dia(EDatInicio.Datetime))+' AND '+IntToStr(Dia(EDatFim.Datetime)));
    VpaSelect.Add(' AND '+SQLTextoMes('CCL.DATNASCIMENTO')+' BETWEEN '+IntToStr(Mes(EDatInicio.Datetime))+' AND '+IntToStr(Mes(EDatFim.Datetime)));
//    VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('CCL.DATNASCIMENTO',EDatInicio.Datetime,Incdia(EDatFim.Datetime,1),True));
  end;
end;

{******************************************************************************}
procedure TFAniversariantes.GContatosClienteOrdem(Ordem: String);
begin
  VprOrdemContatoCliente:= Ordem;
end;

{******************************************************************************}
procedure TFAniversariantes.AtualizaConsultaProspect;
begin
  PROSPECT.Close;
  PROSPECT.SQL.Clear;
  PROSPECT.SQL.Add('SELECT PPT.CODPROSPECT, PPT.DATNASCIMENTO, ('+ FormatDateTime('YYYY',Now) +'- '+SqlTextoAno('PPT.DATNASCIMENTO')+') IDADE,'+
                   ' PPT.NOMPROSPECT, PPT.DESFONE1, PPT.DESEMAILCONTATO, PPT.DESCIDADE'+
                   ' FROM PROSPECT PPT'+
                   ' WHERE PPT.CODPROSPECT = PPT.CODPROSPECT');
  AdicionaFiltrosProspect(PROSPECT.SQL);
  PROSPECT.SQL.Add(VprOrdemProspect);
  PROSPECT.Open;
  GProspects.ALinhaSQLOrderBy:= PROSPECT.SQL.Count-1;
end;

{******************************************************************************}
procedure TFAniversariantes.AdicionaFiltrosProspect(VpaSelect: TStrings);
begin
//verificar - não encontrei outra forma mais fácil de fazer
  if CPeriodo.Checked then
  begin
    VpaSelect.Add(' AND '+SQLTextoDia('PPT.DATNASCIMENTO')+ ' BETWEEN '+IntToStr(Dia(EDatInicio.Datetime))+' AND '+IntToStr(Dia(EDatFim.Datetime)));
    VpaSelect.Add(' AND '+SQLTextoMes('PPT.DATNASCIMENTO')+ ' BETWEEN '+IntToStr(Mes(EDatInicio.Datetime))+' AND '+IntToStr(Mes(EDatFim.Datetime)));
  end;
end;

{******************************************************************************}
procedure TFAniversariantes.GProspectsOrdem(Ordem: String);
begin
  VprOrdemProspect:= Ordem;
end;

{******************************************************************************}
procedure TFAniversariantes.AtualizaConsultaContatoProspect;
begin
  CONTATOPROSPECT.Close;
  CONTATOPROSPECT.SQL.Clear;
  CONTATOPROSPECT.SQL.Add('SELECT CPP.CODPROSPECT, CPP.DATNASCIMENTO, ('+ FormatDateTime('YYYY',Now) +'- '+SqlTextoAno('CPP.DATNASCIMENTO')+') IDADE, CPP.NOMCONTATO,'+
                          ' PPT.NOMPROSPECT, PPT.NOMFANTASIA, PPT.DESFONE1, PPT.DESEMAILCONTATO, PPT.DESCIDADE'+
                          ' FROM CONTATOPROSPECT CPP, PROSPECT PPT'+
                          ' WHERE PPT.CODPROSPECT = CPP.CODPROSPECT');
  AdicionaFiltrosContatoProspect(CONTATOPROSPECT.SQL);
  CONTATOPROSPECT.SQL.Add(VprOrdemContatoProspect);
  CONTATOPROSPECT.Open;
  GContatosProspect.ALinhaSQLOrderBy:= CONTATOPROSPECT.SQL.Count-1;
end;

{******************************************************************************}
procedure TFAniversariantes.AdicionaFiltrosContatoProspect(VpaSelect: TStrings);
begin
  if CPeriodo.Checked then
  begin
    VpaSelect.Add(' AND '+SQLTextoDia('CPP.DATNASCIMENTO')+' BETWEEN '+IntToStr(Dia(EDatInicio.Datetime))+' AND '+IntToStr(Dia(EDatFim.Datetime)));
    VpaSelect.Add(' AND '+SQLTextoMes('CPP.DATNASCIMENTO')+' BETWEEN '+IntToStr(Mes(EDatInicio.Datetime))+' AND '+IntToStr(Mes(EDatFim.Datetime)));
  end;
end;

{******************************************************************************}
procedure TFAniversariantes.GContatosProspectOrdem(Ordem: String);
begin
  VprOrdemContatoProspect:= Ordem;
end;

{******************************************************************************}
procedure TFAniversariantes.EnviarEMail1Click(Sender: TObject);
begin
  EmailCliente;
end;

{******************************************************************************}
procedure TFAniversariantes.EmailCliente;
begin

end;

{******************************************************************************}
procedure TFAniversariantes.Telemarketing1Click(Sender: TObject);
begin
  if CADCLIENTESI_COD_CLI.AsInteger <> 0 then
    TelemarketingCliente(CADCLIENTESI_COD_CLI.AsInteger)
  else
    aviso('CLIENTE INVÁLIDO!!!'#13'É necessário selecionar um cliente antes de fazer o telemarketing.');
end;

{******************************************************************************}
procedure TFAniversariantes.TelemarketingCliente(VpaCodCliente: Integer);
begin
  FNovoTeleMarketing:= TFNovoTeleMarketing.CriarSDI(Application,'',True);
  FNovoTeleMarketing.TeleMarketingCliente(VpaCodCliente);
  FNovoTeleMarketing.Free;
end;

{******************************************************************************}
procedure TFAniversariantes.EnviarEMail2Click(Sender: TObject);
begin
  EMailContatoCliente;
end;

{******************************************************************************}
procedure TFAniversariantes.EMailContatoCliente;
begin

end;

{******************************************************************************}
procedure TFAniversariantes.Telemarketing2Click(Sender: TObject);
begin
  if CONTATOCLIENTECODCLIENTE.AsInteger <> 0 then
    TelemarketingCliente(CONTATOCLIENTECODCLIENTE.AsInteger)
  else
    aviso('CONTATO DO CLIENTE INVÁLIDO!!!'#13'É necessário selecionar o contato de um cliente antes de fazer o telemarketing.');
end;

{******************************************************************************}
procedure TFAniversariantes.EMail1Click(Sender: TObject);
begin
  EMailProspect;
end;

{******************************************************************************}
procedure TFAniversariantes.EMailProspect;
begin

end;

{******************************************************************************}
procedure TFAniversariantes.Telemarketing3Click(Sender: TObject);
begin
  if PROSPECTCODPROSPECT.AsInteger <> 0 then
    TelemarketingProspect(PROSPECTCODPROSPECT.AsInteger)
  else
    aviso('PROSPECT INVÁLIDO!!!'#13'É necessário selecionar um prospect antes de fazer o telemarketing.');
end;

{******************************************************************************}
procedure TFAniversariantes.TelemarketingProspect(VpaCodProspect: Integer);
begin
  FNovoTeleMarketingProspect:= TFNovoTeleMarketingProspect.CriarSDI(Application,'',True);
  FNovoTeleMarketingProspect.TeleMarketingProspect(VpaCodProspect);
  FNovoTeleMarketingProspect.Free;
end;

{******************************************************************************}
procedure TFAniversariantes.EMail2Click(Sender: TObject);
begin
  EmailContatoProspect;
end;

{******************************************************************************}
procedure TFAniversariantes.EmailContatoProspect;
begin

end;

{******************************************************************************}
procedure TFAniversariantes.Telemarketing4Click(Sender: TObject);
begin
  if CONTATOPROSPECTCODPROSPECT.AsInteger <> 0 then
    TelemarketingProspect(CONTATOPROSPECTCODPROSPECT.AsInteger)
  else
    aviso('CONTATO DO PROSPECT INVÁLIDO!!!'#13'É necessário selecionar o contato de um prospect antes de fazer o telemarketing.');
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFAniversariantes]);
end.
