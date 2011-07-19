unit ACancelaExcluiCP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Grids, DBGrids,
  Tabela;

type
  TFCancelaExclui = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DBGridColor1: TDBGridColor;
    Query1: TQuery;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCancelaExclui: TFCancelaExclui;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCancelaExclui.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCancelaExclui.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;




{******************procura o registro que será excluído************************}
{procedure TFContasaPagar.BotaoExcluir1Atividade(Sender: TObject);
var
  Mb : TCalculosBancario;
begin
  CriaFormNovaConta;
  Mb := TCalculosBancario.criar(self,FPrincipal.BaseDados);

  if not FNovoContasaPagar.CadContasAPagarI_SEQ_NOT.IsNull then
  begin
    aviso(CT_ExclusaoNota);
    FNovoContasAPagar.close;
    abort;
  end;

  MovNotas.First;
  while not MovNotas.Eof do
  begin
    if not mb.VerificaExclusaoConta(MovNotasI_LAN_BAC.AsInteger) then
    begin
      FNovoContasAPagar.close;
      abort;
    end;
    MovNotas.Next;
  end;
end;



procedure TFNovoContasAPagar.CadContasAPagarBeforeDelete(
  DataSet: TDataSet);

begin
Aux.close;         // faz a exclusao dos movimentos bancarios...
Aux.SQL.clear;
Aux.sql.Add('Select * from MovContasAPagar where i_emp_fil = ' + IntToStr(varia.CodigoEmpFil) +
            ' and i_lan_apg = ' + CadContasAPagarI_LAN_APG.AsString );
Aux.open;
FNovoMovBancario := TFNovoMovBancario.CriarSDI(application, '', true);
while not aux.Eof do
begin
  if aux.FieldByName('I_LAN_BAC').AsInteger <> 0 then
//     FNovoMovBancario.Excluir(aux.FieldByName('I_LAN_BAC').AsInteger, aux.FieldByName('C_NRO_CON').AsString, false);  // estorna o movimento bancario
  aux.Next;
end;
FNovoMovBancario.Close;
end;
}




{ *************** Registra a classe para evitar duplicidade ****************** }
Initialization
 RegisterClasses([TFCancelaExclui]);
end.
