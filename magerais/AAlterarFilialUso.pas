unit AAlterarFilialUso;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: Altera a filial em uso
  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 01/04/199 / rafael Budag
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, BotaoCadastro, DBCtrls, Tabela, ExtCtrls, DBTables,
  Componentes1, Db, Grids, DBGrids, constantes, LabelCorMove,
  PainelGradiente, DBClient;

type
  TFAlterarFilialUso = class(TFormularioPermissao)
    DataCadFiliais: TDataSource;
    CadEmpresas: TSQL;
    DataCadEmpresa: TDataSource;
    CadFiliais: TSQL;
    CadFiliaisI_COD_FIL: TFMTBCDField;
    CadFiliaisI_COD_EMP: TFMTBCDField;
    CadFiliaisC_NOM_FIL: TWideStringField;
    CadFiliaisC_NOM_FAN: TWideStringField;
    CadEmpresasI_COD_EMP: TFMTBCDField;
    CadEmpresasC_NOM_EMP: TWideStringField;
    PanelColor1: TPanelColor;
    Label3: TLabel;
    Label2: TLabel;
    PanelColor2: TPanelColor;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    DBGridColor1: TDBGridColor;
    DBGridColor2: TDBGridColor;
    PainelGradiente1: TPainelGradiente;
    CadFiliaisI_EMP_FIL: TFMTBCDField;
    CadFiliaisI_COD_TAB: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CadEmpresasAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAlterarFilialUso: TFAlterarFilialUso;

implementation

uses APrincipal,FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlterarFilialUso.FormCreate(Sender: TObject);
begin
 CadEmpresas.Open;
 CadFiliais.Open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlterarFilialUso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CadEmpresas.Close;
 CadFiliais.Close;
 Action := CaFree;
end;

{ ******************* Alterar a filial em uso ******************************* }
procedure TFAlterarFilialUso.BitBtn1Click(Sender: TObject);
begin
 CarregaEmpresaFilial(CadEmpresasI_COD_EMP.AsInteger,CadFiliaisI_EMP_FIL.AsInteger,
                      FPrincipal.BaseDados);
 FPrincipal.CorFoco.ACodigoFilial := varia.CodigoEmpFil;
 FPrincipal.AlteraNomeEmpresa;
 close;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFAlterarFilialUso.BitBtn2Click(Sender: TObject);
begin
   close;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFAlterarFilialUso.CadEmpresasAfterScroll(DataSet: TDataSet);
begin
  AdicionaSQLAbreTabela(CadFiliais,'Select * from CADFILIAIS '+
                                   ' WHERE I_COD_EMP = '+CadEmpresasI_COD_EMP.AsString +
                                   ' and i_emp_fil not in (select CODFILIAL FROM SEMPERMISSAOFILIAL '+
                                   ' WHERE CODUSUARIO = '+IntToStr(Varia.CodigoUsuario)+')');
end;

Initialization
 RegisterClasses([TFAlterarFilialUso]);
end.
