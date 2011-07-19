unit ALimpaBancoDados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Buttons, DB, DBClient, Tabela, CBancoDados, FMTBcd, SqlExpr,
  ComCtrls;

type
  TFLimpaBancoDados = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BLimpar: TBitBtn;
    BFechar: TBitBtn;
    CLog: TCheckBox;
    CMovEstoqueProdutos: TCheckBox;
    CLogReceber: TCheckBox;
    CRetornoItem: TCheckBox;
    Label1: TLabel;
    EPeriodo: TComboBoxColor;
    Aux: TSQL;
    CTarefaEmarketing: TCheckBox;
    Paginas: TPageControl;
    PanelColor3: TPanelColor;
    PGEral: TTabSheet;
    PLog: TTabSheet;
    ELog: TMemoColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BLimparClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    VprTotalRegistroApagados : Integer;
    function RDataLimpeza : TDateTime;
    procedure AtualizaLog(VpaTexto : String);
    procedure LimpaLog;
    procedure LimpaLogReceber;
    procedure limpamovestoqueprodutos;
    procedure LimpaRetornoItem;
    procedure LimpaTarefaEmarketing;

  public
    { Public declarations }
  end;

var
  FLimpaBancoDados: TFLimpaBancoDados;

implementation

uses APrincipal, FunData, funSQL, constmsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFLimpaBancoDados.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{******************************************************************************}
procedure TFLimpaBancoDados.LimpaLog;
Var
  VpfQtdRegistros : Integer;
begin
  AtualizaLog('Verificando a quantidade de registros da tabela LOG');
  AdicionaSQLAbreTabela(Aux,'Select COUNT(*) QTD FROM LOG '+
                        ' Where DAT_LOG <= ' +SQLTextoDataAAAAMMMDD(RDataLimpeza));
  VpfQtdRegistros := Aux.FieldByName('QTD').AsInteger;

  AtualizaLog('Apagando registros tabela LOG');
  ExecutaComandoSql(Aux,'Delete from LOG '+
                        ' Where DAT_LOG <= ' +SQLTextoDataAAAAMMMDD(RDataLimpeza));

  AtualizaLog(IntToStr(VpfQtdRegistros)+' registros apagandos da tabela LOG');
  VprTotalRegistroApagados := VprTotalRegistroApagados +VpfQtdRegistros;
  AtualizaLog('Total de registros apagados '+IntToStr(VprTotalRegistroApagados));
end;

{******************************************************************************}
procedure TFLimpaBancoDados.LimpaLogReceber;
Var
  VpfQtdRegistros : Integer;
begin
  AtualizaLog('Verificando a quantidade de registros da tabela LOGCONTASARECEBER');
  AdicionaSQLAbreTabela(Aux,'Select COUNT(*) QTD FROM LOGCONTASARECEBER '+
                        ' Where DATLOG <= ' +SQLTextoDataAAAAMMMDD(RDataLimpeza));
  VpfQtdRegistros := Aux.FieldByName('QTD').AsInteger;

  AtualizaLog('Apagando registros tabela LOGCONTASARECEBER');
  ExecutaComandoSql(Aux,'Delete from LOGCONTASARECEBER '+
                        ' Where DATLOG <= ' +SQLTextoDataAAAAMMMDD(RDataLimpeza));
  AtualizaLog(IntToStr(VpfQtdRegistros)+' registros apagandos da tabela LOGCONTASARECEBER');
  VprTotalRegistroApagados := VprTotalRegistroApagados +VpfQtdRegistros;
  AtualizaLog('Total de registros apagados '+IntToStr(VprTotalRegistroApagados));
end;

{******************************************************************************}
procedure TFLimpaBancoDados.limpamovestoqueprodutos;
Var
  VpfQtdRegistros : Integer;
begin
  AtualizaLog('Verificando a quantidade de registros da tabela MOVESTOQUEPRODUTOS');
  AdicionaSQLAbreTabela(Aux,'Select COUNT(*) QTD FROM MOVESTOQUEPRODUTOS '+
                        ' Where D_DAT_MOV <= ' +SQLTextoDataAAAAMMMDD(RDataLimpeza));
  VpfQtdRegistros := Aux.FieldByName('QTD').AsInteger;

  AtualizaLog('Apagando registros tabela MOVESTOQUEPRODUTOS');
  ExecutaComandoSql(Aux,'Delete from MOVESTOQUEPRODUTOS '+
                        ' Where D_DAT_MOV <= ' +SQLTextoDataAAAAMMMDD(RDataLimpeza));
  AtualizaLog(IntToStr(VpfQtdRegistros)+' registros apagandos da tabela MOVESTOQUEPRODUTOS');
  VprTotalRegistroApagados := VprTotalRegistroApagados +VpfQtdRegistros;
  AtualizaLog('Total de registros apagados '+IntToStr(VprTotalRegistroApagados));
end;

{******************************************************************************}
procedure TFLimpaBancoDados.LimpaRetornoItem;
Var
  VpfQtdRegistros : Integer;
begin
  AtualizaLog('Verificando a quantidade de registros da tabela  RETORNOITEM');
  AdicionaSQLAbreTabela(Aux,'Select COUNT(*) QTD FROM RETORNOITEM '+
                        ' Where DATOCORRENCIA  <= ' +SQLTextoDataAAAAMMMDD(RDataLimpeza));
  VpfQtdRegistros := Aux.FieldByName('QTD').AsInteger;

  AtualizaLog('Apagando registros tabela  RETORNOITEM');
  ExecutaComandoSql(Aux,'Delete from RETORNOITEM '+
                        ' Where DATOCORRENCIA  <= ' +SQLTextoDataAAAAMMMDD(RDataLimpeza));
  AtualizaLog(IntToStr(VpfQtdRegistros)+' registros apagandos da tabela  RETORNOITEM');
  VprTotalRegistroApagados := VprTotalRegistroApagados +VpfQtdRegistros;
  AtualizaLog('Total de registros apagados '+IntToStr(VprTotalRegistroApagados));
end;

{******************************************************************************}
procedure TFLimpaBancoDados.LimpaTarefaEmarketing;
Var
  VpfQtdRegistros : Integer;
begin
  AtualizaLog('Verificando a quantidade de registros da tabela  TAREFAEMARKETINGITEM');
  AdicionaSQLAbreTabela(Aux,'SELECT COUNT(*) QTD FROM TAREFAEMARKETINGITEM ITE '+
                        ' WHERE SEQTAREFA IN ( SELECT SEQTAREFA FROM TAREFAEMARKETING TAR '+
                        ' WHERE DATTAREFA <=  ' +SQLTextoDataAAAAMMMDD(RDataLimpeza)+')');
  VpfQtdRegistros := Aux.FieldByName('QTD').AsInteger;

  AtualizaLog('Apagando registros tabela  TAREFAEMARKETINGITEM');
  ExecutaComandoSql(Aux,'DELETE FROM TAREFAEMARKETINGITEM ITE '+
                        ' WHERE SEQTAREFA IN ( SELECT SEQTAREFA FROM TAREFAEMARKETING TAR '+
                        ' WHERE DATTAREFA <=  ' +SQLTextoDataAAAAMMMDD(RDataLimpeza)+')');
  AtualizaLog(IntToStr(VpfQtdRegistros)+' registros apagandos da tabela  TAREFAEMARKETINGITEM');
  VprTotalRegistroApagados := VprTotalRegistroApagados +VpfQtdRegistros;
  AtualizaLog('Total de registros apagados '+IntToStr(VprTotalRegistroApagados));

  AtualizaLog('Verificando a quantidade de registros da tabela  TAREFAEMARKETINGPROSPECTITEM');
  AdicionaSQLAbreTabela(Aux,'SELECT COUNT(*) QTD FROM TAREFAEMARKETINGPROSPECTITEM ITE '+
                        ' WHERE SEQTAREFA IN ( SELECT SEQTAREFA FROM TAREFAEMARKETINGPROSPECT TAR '+
                        ' WHERE DATTAREFA <=  ' +SQLTextoDataAAAAMMMDD(RDataLimpeza)+')');
  VpfQtdRegistros := Aux.FieldByName('QTD').AsInteger;

  AtualizaLog('Apagando registros tabela  TAREFAEMARKETINGPROSPECTITEM');
  ExecutaComandoSql(Aux,'DELETE FROM TAREFAEMARKETINGPROSPECTITEM ITE '+
                        ' WHERE SEQTAREFA IN ( SELECT SEQTAREFA FROM TAREFAEMARKETINGPROSPECT TAR '+
                        ' WHERE DATTAREFA <=  ' +SQLTextoDataAAAAMMMDD(RDataLimpeza)+')');
  AtualizaLog(IntToStr(VpfQtdRegistros)+' registros apagandos da tabela  TAREFAEMARKETINGPROSPECTITEM');
  VprTotalRegistroApagados := VprTotalRegistroApagados +VpfQtdRegistros;
  AtualizaLog('Total de registros apagados '+IntToStr(VprTotalRegistroApagados));
end;

{******************************************************************************}
function TFLimpaBancoDados.RDataLimpeza: TDateTime;
begin
  case EPeriodo.ItemIndex of
    0 : Result := DecMes(PrimeiroDiaMes(date),3);
    1 : Result := DecMes(PrimeiroDiaMes(date),6);
    2 : Result := DecMes(PrimeiroDiaMes(date),12);
  end;
end;

{ *************************************************************************** }
procedure TFLimpaBancoDados.AtualizaLog(VpaTexto: String);
begin
  ELog.Lines.Add(VpaTexto);
  ELog.Refresh;
end;

{******************************************************************************}
procedure TFLimpaBancoDados.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFLimpaBancoDados.BLimparClick(Sender: TObject);
begin
  VprTotalRegistroApagados := 0;
  ELog.Clear;
  Paginas.ActivePage := PLog;
  if CLog.Checked then
    LimpaLog;
  if CLogReceber.Checked then
    LimpaLogReceber;
  if CMovEstoqueProdutos.Checked then
    limpamovestoqueprodutos;
  if CRetornoItem.Checked then
    LimpaRetornoItem;
  if CTarefaEmarketing.Checked then
    LimpaTarefaEmarketing;

  aviso('Banco de dados limpo com sucesso.');
end;

procedure TFLimpaBancoDados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFLimpaBancoDados]);
end.
