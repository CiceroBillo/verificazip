unit APerfilCliente;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, BotaoCadastro, StdCtrls, Buttons, Db,  DBTables,
  Tabela, Mask, DBCtrls, DBCidade, Componentes1, Grids, DBGrids,
  Localizacao, DBKeyViolation, LabelCorMove, PainelGradiente, constantes, constMsg,
  DBClient, Menus, IniFiles, CBancoDados;

type
  TFPerfilCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BFechar: TBitBtn;
    BotaoConsultar: TBotaoConsultar;
    DBGridColor1: TGridIndice;
    DataPerfilCliente: TDataSource;
    PerfilCliente: TSQL;
    PerfilClienteCODPERFIL: TFMTBCDField;
    PerfilClienteNOMPERFIL: TWideStringField;
    EConsulta: TLocalizaEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ENomeExit(Sender: TObject);
    procedure ENomeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridIndice1Ordem(Ordem: string);
    procedure DBGridColor1Ordem(Ordem: string);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoConsultarAntesAtividade(Sender: TObject);
    procedure BotaoConsultarDepoisAtividade(Sender: TObject);
  private
    VprOrdem : String;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);

  public
    { Public declarations }
  end;

var
  FPerfilCliente: TFPerfilCliente;

implementation

uses APrincipal, ANovoPerfilCliente, AMetasVendedor, funsql, FunString, FunValida;

{$R *.DFM}


{ **************************************************************************** }
procedure TFPerfilCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by CODPERFIL ';
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPerfilCliente.GridIndice1Ordem(Ordem: string);
begin
  VprOrdem:= Ordem;
end;

{ *************************************************************************** }
procedure TFPerfilCliente.AdicionaFiltros(VpaSelect: TStrings);
begin
  if EConsulta.Text <> '' then
    VpaSelect.add('and NOMPERFIL like  '''+EConsulta.Text +'%''');
end;

{******************************************************************************}
procedure TFPerfilCliente.AtualizaConsulta;
begin
  PerfilCliente.close;
  PerfilCliente.sql.clear;
  PerfilCliente.sql.add('Select CODPERFIL, NOMPERFIL'+
                        ' From PERFILCLIENTE PER '+
                        ' Where CODPERFIL = CODPERFIL');
  AdicionaFiltros(PerfilCliente.sql);
  PerfilCliente.sql.add(VprOrdem);
  DBGridColor1.ALinhaSQLOrderBy := PerfilCliente.SQL.Count-1;
  PerfilCliente.open;
end;

{******************************************************************************}
procedure TFPerfilCliente.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFPerfilCliente.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQlAbreTabela( FNovoPerfilCliente.PerfilCliente,'Select * from PERFILCLIENTE '+
                                                       ' Where CODPERFIL = '+ PerfilClienteCODPERFIL.AsString);
end;

{******************************************************************************}
procedure TFPerfilCliente.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
   FNovoPerfilCliente:= TFNovoPerfilCliente.CriarSDI(Application,'',true);
end;

{******************************************************************************}
procedure TFPerfilCliente.BotaoCadastrar1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFPerfilCliente.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovoPerfilCliente.ShowModal;
end;

{******************************************************************************}
procedure TFPerfilCliente.BotaoConsultarAntesAtividade(Sender: TObject);
begin
  FNovoPerfilCliente := TFNovoPerfilCliente.CriarSDI(Application,'',true);
end;

procedure TFPerfilCliente.BotaoConsultarDepoisAtividade(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFPerfilCliente.DBGridColor1Ordem(Ordem: string);
begin
    VprOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFPerfilCliente.ENomeExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPerfilCliente.ENomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPerfilCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  PerfilCliente.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPerfilCliente]);
end.
