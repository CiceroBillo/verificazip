unit APrecoLarguraTear;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Componentes1, ExtCtrls,
  PainelGradiente, DB, Grids, DBGrids, Tabela, DBKeyViolation, StdCtrls, Buttons, DBClient, CBancoDados;

type
  TFPrecoLarguraTear = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    PrecoLarguraTear: TRBSQL;
    BFechar: TBitBtn;
    DataPrecoLarguraTear: TDataSource;
    GridIndice1: TGridIndice;
    PrecoLarguraTearNUMLARGURA: TFMTBCDField;
    PrecoLarguraTearVALCONVENCIONAL: TFMTBCDField;
    PrecoLarguraTearVALCROCHE: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrecoLarguraTear: TFPrecoLarguraTear;

implementation

uses APrincipal, ConstMsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFPrecoLarguraTear.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  PrecoLarguraTear.Open;
end;

procedure TFPrecoLarguraTear.GridIndice1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_DELETE then
    if Confirmacao(CT_DeletaRegistro) then
      PrecoLarguraTear.Delete;
end;

{ *************************************************************************** }
procedure TFPrecoLarguraTear.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFPrecoLarguraTear.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  PrecoLarguraTear.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPrecoLarguraTear]);
end.
