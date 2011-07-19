unit CadFormularios;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: Cadastrar os formularios da aplicação
  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 01/04/199 / rafael Budag
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, Grids, DBGrids, Db, DBTables, PainelGradiente,
  StdCtrls, Buttons, Componentes1;

type
  TFCadFormularios = class(TForm)
    CadFormularios: TTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    CadFormulariosC_COD_FOM: TStringField;
    CadFormulariosC_NOM_FOM: TStringField;
    CadFormulariosC_NOM_MEN: TStringField;
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCadFormularios: TFCadFormularios;

implementation

uses APrincipal;

{$R *.DFM}

procedure TFCadFormularios.BitBtn1Click(Sender: TObject);
begin
if CadFormularios.State in [ dsInsert, dsEdit ] then
  cadFormularios.Post;
self.close;
end;

procedure TFCadFormularios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
CadFormularios.close;
action := cafree;
end;

procedure TFCadFormularios.FormCreate(Sender: TObject);
begin
//  Self.HelpFile := Varia.PathHelp + 'MaConfSistema.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  CadFormularios.open;
end;

end.
