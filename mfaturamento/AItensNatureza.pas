unit AItensNatureza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, BotaoCadastro, Componentes1, Grids, DBGrids, Tabela,
  Db, DBTables, ExtCtrls, PainelGradiente;

type
  TFItensNatureza = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    DataMovNatureza: TDataSource;
    DBGridColor1: TDBGridColor;
    PanelColor1: TPanelColor;
    BOk: TBitBtn;
    BBAjuda: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure PosicionaNatureza(Query : TDataSet);
  end;

var
  FItensNatureza: TFItensNatureza;

implementation

uses APrincipal, funsql, constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFItensNatureza.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFItensNatureza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := CaFree;
end;

{************Posiciona a tabela passada conforme o codigo passado**************}
procedure TFItensNatureza.PosicionaNatureza(Query : TDataSet);
begin
  DataMovNatureza.DataSet := Query;
  self.ShowModal;
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFItensNatureza.BOkClick(Sender: TObject);
begin
  self.close;
end;

Initialization
 RegisterClasses([TFItensNatureza]);
end.
