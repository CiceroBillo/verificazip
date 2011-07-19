unit AVerificaLeituraLembrete;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, UnLembrete, UnDados, StdCtrls,
  Buttons, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, DBClient;

type
  TFVerificaLeituraLembrete = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    ETitulo: TEditColor;
    Label5: TLabel;
    BFechar: TBitBtn;
    LEMBRETEITEMLIDOS: TSQL;
    DataLEMBRETEITEM: TDataSource;
    DataLEMBRETEITEMNAOLIDOS: TDataSource;
    LEMBRETEITEMNAOLIDOS: TSQL;
    USUARIOSNAOLIDOS: TGridIndice;
    USUARIOSLIDOS: TGridIndice;
    LEMBRETEITEMLIDOSC_NOM_USU: TWideStringField;
    LEMBRETEITEMNAOLIDOSC_NOM_USU: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
  private
    VprDLembreteCorpo: TRBDLembreteCorpo;
    FunLembrete: TRBFuncoesLembrete;
    procedure CarDTela;
    procedure AtualizaConsulta;
  public
    procedure VerificaLeitura(VpaSeqLembrete, VpaCodUsuario: Integer);
  end;

var
  FVerificaLeituraLembrete: TFVerificaLeituraLembrete;

implementation
uses
  APrincipal, ConstMsg, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFVerificaLeituraLembrete.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDLembreteCorpo:= TRBDLembreteCorpo.Cria;
  FunLembrete:= TRBFuncoesLembrete.Cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFVerificaLeituraLembrete.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDLembreteCorpo.Free;
  FunLembrete.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFVerificaLeituraLembrete.VerificaLeitura(VpaSeqLembrete, VpaCodUsuario: Integer);
begin
  FunLembrete.CarDLembrete(VpaSeqLembrete,VprDLembreteCorpo);
  CarDTela;
  AtualizaConsulta;
  if (VprDLembreteCorpo.CodUsuario = VpaCodUsuario) or
     (puAdministrador in Varia.PermissoesUsuario) then
    ShowModal
  else
    aviso('PERMISSÃO INVÁLIDA!!!'#13'Somente o dono deste lembrete ou administradores podem verificar suas leituras.');
end;

{******************************************************************************}
procedure TFVerificaLeituraLembrete.CarDTela;
begin
  ETitulo.Text:= VprDLembreteCorpo.DesTitulo;
end;

{******************************************************************************}
procedure TFVerificaLeituraLembrete.AtualizaConsulta;
begin
  LEMBRETEITEMLIDOS.Close;
  LEMBRETEITEMLIDOS.SQL.Clear;
  LEMBRETEITEMLIDOS.SQL.Add('SELECT USU.C_NOM_USU'+
                            ' FROM CADUSUARIOS USU, LEMBRETEITEM LBI'+
                            ' WHERE USU.I_COD_USU = LBI.CODUSUARIO'+
                            ' AND USU.I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil)+
                            ' AND LBI.SEQLEMBRETE = '+IntToStr(VprDLembreteCorpo.SeqLembrete)+
                            ' ORDER BY USU.C_NOM_USU');
  LEMBRETEITEMLIDOS.Open;

  LEMBRETEITEMNAOLIDOS.Close;
  LEMBRETEITEMNAOLIDOS.SQL.Clear;
  LEMBRETEITEMNAOLIDOS.SQL.Add('SELECT USU.C_NOM_USU'+
                               ' FROM CADUSUARIOS USU, LEMBRETECORPO LBC'+
                               ' WHERE'+
                               ' USU.I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil)+
                               ' AND USU.C_USU_ATI = ''S'''+
                               ' AND LBC.SEQLEMBRETE = '+IntToStr(VprDLembreteCorpo.SeqLembrete)+
                               // não estejam lidos
                               ' AND NOT EXISTS (SELECT *'+
                               '                 FROM LEMBRETEITEM LBI'+
                               '                 WHERE LBI.CODUSUARIO = USU.I_COD_USU'+
                               '                 AND LBI.SEQLEMBRETE = LBC.SEQLEMBRETE)'+
                               // pegar todos ou aqueles que estao gravados
                               ' AND (LBC.INDTODOS = ''S'''+
                               '      OR EXISTS (SELECT *'+
                               '                 FROM LEMBRETEUSUARIO LBU'+
                               '                 WHERE LBU.CODUSUARIO = USU.I_COD_USU'+
                               '                 AND LBU.SEQLEMBRETE = LBC.SEQLEMBRETE))'+
                               'ORDER BY USU.C_NOM_USU');
  LEMBRETEITEMNAOLIDOS.Open;
end;

{******************************************************************************}
procedure TFVerificaLeituraLembrete.BFecharClick(Sender: TObject);
begin
  Close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFVerificaLeituraLembrete]);
end.
