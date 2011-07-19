unit APermissaoRelatorio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Menus, StdCtrls, Buttons, ExtCtrls, Componentes1, DB, UnImpressaoRelatorio,
  DBClient, Tabela, CBancoDados;

type
  TFPermissaoRelatorio = class(TFormularioPermissao)
    Menu: TMainMenu;
    MRelatorios: TMenuItem;
    PanelColor1: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Cadastro: TRBSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprCodFilial,
    VprCodGrupo,
    VprSeqRelatorio : integer;
    FunImpressaoRel: TImpressaoRelatorio;
    procedure GravaPermissaoRelatorio;
    procedure GravaPermissaoMenu(VpaMenu : TMenuItem);
  public
    { Public declarations}
    function PermissaoRelatorio(VpaCodFilial, VpaCodGrupo : Integer):boolean;
  end;

var
  FPermissaoRelatorio: TFPermissaoRelatorio;

implementation

uses APrincipal, funsql, constantes;

{$R *.DFM}


{ **************************************************************************** }
procedure TFPermissaoRelatorio.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunImpressaoRel := TImpressaoRelatorio.Cria(FPrincipal.BaseDados);
  FunImpressaoRel.CarregarMenuRel(mrTodos,MRelatorios);
end;

{******************************************************************************}
procedure TFPermissaoRelatorio.GravaPermissaoMenu(VpaMenu: TMenuItem);
var
  Vpflaco : Integer;
  VpfMenu : TMenuItem;
begin
  for VpfLaco := 0 to VpaMenu.Count - 1 do
  begin
    VpfMenu := VpaMenu.Items[Vpflaco];
    if VpfMenu.Count > 0 then
      GravaPermissaoMenu(VpfMenu)
    else
    begin
      if VpfMenu.Checked then
      begin
        Cadastro.insert;
        Cadastro.FieldByName('CODFILIAL').AsInteger := VprCodFilial;
        Cadastro.FieldByName('CODGRUPO').AsInteger := VprCodGrupo;
        Cadastro.FieldByName('SEQRELATORIO').AsInteger := VprSeqRelatorio;
        Cadastro.FieldByName('NOMRELATORIO').AsString := copy(VpfMenu.Hint,length(varia.PathRelatorios)+1,length(VpfMenu.Hint));
        if copy(Cadastro.FieldByName('NOMRELATORIO').AsString,1,1) = '\' then
          Cadastro.FieldByName('NOMRELATORIO').AsString := copy(Cadastro.FieldByName('NOMRELATORIO').AsString,2,length(Cadastro.FieldByName('NOMRELATORIO').AsString));
        inc(VprSeqRelatorio);
        Cadastro.Post;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFPermissaoRelatorio.GravaPermissaoRelatorio;
var
  VpfLaco : Integer;
  VpfMenu : TMenuItem;
begin
  ExecutaComandoSql(Cadastro,'DELETE FROM GRUPOUSUARIORELATORIO ' +
                             ' Where CODFILIAL = ' +IntToStr(VprCodFilial)+
                             ' AND CODGRUPO = ' +IntToStr(VprCodGrupo));
  AdicionaSQLAbreTabela(Cadastro,'Select * from GRUPOUSUARIORELATORIO ' +
                                 ' WHERE CODFILIAL = 0 AND CODGRUPO = 0 AND SEQRELATORIO =0 ' );
  VprSeqRelatorio := 1;
  GravaPermissaoMenu(MRelatorios);
  Cadastro.Close;
end;

{******************************************************************************}
function TFPermissaoRelatorio.PermissaoRelatorio(VpaCodFilial,VpaCodGrupo: Integer): boolean;
begin
  VprCodFilial := VpaCodFilial;
  VprCodGrupo := VpaCodGrupo;
  ShowModal;
end;

{ *************************************************************************** }
procedure TFPermissaoRelatorio.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFPermissaoRelatorio.BGravarClick(Sender: TObject);
begin
  GravaPermissaoRelatorio;
  close;
end;

procedure TFPermissaoRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunImpressaoRel.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPermissaoRelatorio]);
end.
