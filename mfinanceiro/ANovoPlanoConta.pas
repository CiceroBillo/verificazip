unit ANovoPlanoConta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, DBTables, Tabela, DBCtrls, ExtCtrls,
  Componentes1, BotaoCadastro, PainelGradiente, DBKeyViolation, formularios, constantes, constMsg,
  FMTBcd, SqlExpr, DBClient, UnContasAReceber;

Const
  CT_PLANOINVALIDO='PLANO DE CONTAS INVÁLIDO!!!'#13'Plano de contas preenchido inválido ou não preenchido...';
  CT_NOMEPLANOINVALIDO = 'DESCRIÇÃO DO PLANO DE CONTAS INVÁLIDO!!!'#13'Descrição do plano de contas preenchido inválido ou não preenchido...';
  CT_TIPOPLANOINVALIDO = 'TIPO DO PLANO DE CONTAS INVÁLIDO!!!'#13'Tipo do plano de contas preenchido inválido ou não preenchido...';

type
  TFNovoPlanoConta = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Empresa: TDBEditColor;
    Label4: TLabel;
    CadPlanoConta: TSQL;
    Desc: TDBEditColor;
    DataPlanoConta: TDataSource;
    PainelGradiente1: TPainelGradiente;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    VerificaPlanoConta: TSQLQuery;
    CodCla: TMaskEditColor;
    CadPlanoContaC_NOM_PLA: TWideStringField;
    CadPlanoContaI_COD_EMP: TFMTBCDField;
    CadPlanoContaC_TIP_PLA: TWideStringField;
    DBEditChar1: TDBEditChar;
    Label3: TLabel;
    ValidaGravacao1: TValidaGravacao;
    CadPlanoContaD_ULT_ALT: TSQLTimeStampField;
    CadPlanoContaC_CLA_PLA: TWideStringField;
    Label5: TLabel;
    DBEditColor1: TDBEditColor;
    CadPlanoContaN_VLR_PRE: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoGravar1DepoisAtividade(Sender: TObject);
    procedure BotaoCancelar1DepoisAtividade(Sender: TObject);
    procedure CodClaExit(Sender: TObject);
    procedure BotaoGravar1Atividade(Sender: TObject);
    procedure EmpresaChange(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure CadPlanoContaBeforePost(DataSet: TDataSet);
    procedure CadPlanoContaAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    acao:Boolean;
    codigo : string;
    function DadosValidos(VpaAvisar : Boolean):Boolean;
  public
    { Public declarations }
    modo:byte;

    function Inseri( var Descricao, codigo : string; TamanhoPicture : Integer;var TipoDebCre : String ) : Boolean;
    function Alterar(Codigo : string; var Descricao : string; TipoDebCre : String ) : Boolean;
  end;

var
  FNovoPlanoConta: TFNovoPlanoConta;

implementation

uses APrincipal, FunSql, FunString, UnSistema;

{$R *.DFM}

{******************************************************************************
                        Inseri novo plano de conta
****************************************************************************** }
function TFNovoPlanoConta.Inseri( var Descricao, codigo : string; TamanhoPicture : Integer;var TipoDebCre : String  ) : Boolean;
var
  laco : integer;
  VpfPlanoContas : String;
begin
  self.codigo := codigo;
  CodCla.EditMask  := '';
  for laco := 1 to length(codigo) do
    CodCla.EditMask  := CodCla.EditMask +  '\' + codigo[laco] ;

  for laco :=1 to TamanhoPicture  do
     CodCla.EditMask := CodCla.EditMask + '0';
 CodCla.EditMask := CodCla.EditMask + ';0;_';

 CadPlanoConta.Insert;
 Empresa.Field.AsInteger := varia.CodigoEmpresa;

 CodCla.ReadOnly := FALSE;
 VpfPlanoContas := FunContasAReceber.RPlanoContasDisponivel(codigo,TamanhoPicture+Length(codigo));
 if VpfPlanoContas <> '' then
   CodCla.EditText := VpfPlanoContas
 else
   CodCla.EditText := codigo+ AdicionaCharE('0','1',TamanhoPicture);
 if TipoDebCre <> '' then
 begin
   DBEditChar1.Field.AsString := TipoDebCre;
   DBEditChar1.Enabled := false;
 end;

 ShowModal;

 Descricao := Desc.Text;
 codigo := CadPlanoContaC_CLA_PLA.AsString; //codigo;
 TipoDebCre := CadPlanoContaC_TIP_PLA.AsString;
 result := Acao;
end;


{******************************************************************************
                        Alterar plano de conta
****************************************************************************** }
function TFNovoPlanoConta.Alterar(Codigo : string; var Descricao : string; TipoDebCre : String ) : Boolean;
begin
  AdicionaSQLAbreTabela(CadPlanoConta,'Select * from CAD_PLANO_CONTA '+
                                      ' Where C_CLA_PLA = '''+Codigo+'''');
  CadPlanoConta.edit;
  CodCla.Text := Codigo;
  CodCla.ReadOnly := true;
  if TipoDebCre <> '' then
    DBEditChar1.Enabled := false;

  ShowModal;

  Descricao := Desc.Text;
  result := Acao;
end;


{ *****************************************************************************
  FormShow :  serve para colocar o componente de edicao do
              código read only se for uma alteracao
****************************************************************************** }
procedure TFNovoPlanoConta.FormCreate(Sender: TObject);
begin
   CadPlanoConta.open;
end;

procedure TFNovoPlanoConta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := CaFree;
end;

{*****************************************************************************
                   serve para indicar que o usuario confirmou
****************************************************************************** }
procedure TFNovoPlanoConta.BotaoGravar1DepoisAtividade(Sender: TObject);
begin
  Acao:=TRUE;
  Close;
end;

{******************************************************************************
             serve para indicar que o usuario cancelou
****************************************************************************** }
procedure TFNovoPlanoConta.BotaoCancelar1DepoisAtividade(Sender: TObject);
begin
  acao:=FALSE;
  Close;
end;

function TFNovoPlanoConta.DadosValidos(VpaAvisar : Boolean):Boolean;
var
  VpfErro : String;
begin
  result := true;
  if CadPlanoContaC_CLA_PLA.IsNull then
  begin
    result := false;
    VpfErro := CT_PLANOINVALIDO;
  end;
  if result then
  begin
    if CadPlanoContaC_NOM_PLA.IsNull then
    begin
      result := false;
      VpfErro := CT_NOMEPLANOINVALIDO;
    end;

    if result then
    begin
      if CadPlanoContaC_TIP_PLA.IsNull then
      begin
        result := false;
        VpfErro := CT_TIPOPLANOINVALIDO
      end;
    end;
  end;
  if not result then
    if VpaAvisar then
      aviso(Vpferro);
end;

{******************************************************************************
   na saida da caixa de codigo, faz verificações de duplicação de código
****************************************************************************** }
procedure TFNovoPlanoConta.CodClaExit(Sender: TObject);
begin

if CadPlanoConta.state = dsinsert Then
    if CodCla.text <> '' then
    begin
        VerificaPlanoConta.close;
        VerificaPlanoConta.SQL.Clear;
        VerificaPlanoConta.sql.Add('select * from cad_Plano_Conta where i_cod_emp = ' +
                                      empresa.Text +
                                      ' and c_cla_pla = ''' + codigo +  CodCla.Text + '''');
        VerificaPlanoConta.open;

        if not VerificaPlanoConta.EOF then
        begin
        erro(CT_DuplicacaoPlanoConta);
        if not BotaoCancelar1.Focused then
          codcla.SetFocus;
        end;

        VerificaPlanoConta.Close;
    end;
end;


procedure TFNovoPlanoConta.BotaoGravar1Atividade(Sender: TObject);
begin
if CadPlanoConta.State = dsInsert then
   CadPlanoContaC_CLA_PLA.AsString := codigo + CodCla.Text;
end;



procedure TFNovoPlanoConta.EmpresaChange(Sender: TObject);
begin
if CadPlanoConta.State in [ dsEdit, dsInsert ] then
  ValidaGravacao1.execute;
if (BotaoGravar1.Enabled) and (CodCla.Text = '') then
  BotaoGravar1.Enabled := false;

end;

procedure TFNovoPlanoConta.BBAjudaClick(Sender: TObject);
begin
end;

{******************* antes de gravar o registro *******************************}
procedure TFNovoPlanoConta.CadPlanoContaAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CAD_PLANO_CONTA');
end;

procedure TFNovoPlanoConta.CadPlanoContaBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  if not DadosValidos(true) then
    abort;

  CadPlanoContaD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  Sistema.MarcaTabelaParaImportar('CAD_PLANO_CONTA');
end;

end.
