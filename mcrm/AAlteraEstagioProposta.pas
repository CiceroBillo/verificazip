unit AAlteraEstagioProposta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, PainelGradiente, ExtCtrls, Componentes1,
  DBKeyViolation, Localizacao, UnProposta, UnDados, Mask, numericos;

type
  TFAlteraEstagioProposta = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    ConsultaPadrao1: TConsultaPadrao;
    EUsuario: TEditLocaliza;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label8: TLabel;
    ECodEstagio: TEditLocaliza;
    EEstagioAtual: TEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    EMotivo: TMemoColor;
    Label9: TLabel;
    EProposta: Tnumerico;
    Label1: TLabel;
    EDatEmissao: TEditColor;
    Label10: TLabel;
    SpeedButton3: TSpeedButton;
    ECliente: TRBEditLocaliza;
    Label11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EUsuarioChange(Sender: TObject);
    procedure EPropostaRetorno(Retorno1, Retorno2: String);
    procedure EChamadoChange(Sender: TObject);
    procedure ECodEstagioRetorno(Retorno1, Retorno2: String);
    procedure ECodEstagioSelect(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprPropostas : TList;
    FunProposta : TRBFuncoesProposta;
    function DadosValidos : String;
    procedure ConfiguraPermissaoUsuario;
  public
    { Public declarations }
    function AlteraEstagioPropostaCliente(VpaDProposta : TRBDPropostaCorpo): Boolean;
    function AlteraEstagioPropostas(VpaPropostas : TList):Boolean;
  end;

var
  FAlteraEstagioProposta: TFAlteraEstagioProposta;

implementation

uses APrincipal,Constantes, ConstMsg, FunObjeto, AEstagioProducao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraEstagioProposta.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  FunProposta := TRBFuncoesProposta.cria(fprincipal.BaseDados);
  VprPropostas := TList.Create;
  ConfiguraPermissaoUsuario;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraEstagioProposta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunProposta.free;
  VprPropostas.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAlteraEstagioProposta.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
  VpfLaco : Integer;
  VpfDProposta : TRBDPropostaCorpo;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = '' then
  begin
    for VpfLaco := 0 to VprPropostas.Count - 1 do
    begin
      VpfDProposta := TRBDPropostaCorpo(VprPropostas.Items[VpfLaco]);
      VpfResultado := FunProposta.AlteraEstagioProposta(VpfDProposta.CodFilial,VpfDProposta.SeqProposta,EUsuario.AInteiro,ECodEstagio.AInteiro,EMotivo.Lines.Text);
      if VpfResultado <> '' then
        break;
    end;
    if VpfResultado = '' then
    begin
      VprAcao := true;
      close;
    end
  end;
  if VpfResultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.ConfiguraPermissaoUsuario;
begin

end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.EUsuarioChange(Sender: TObject);
begin
  ValidaGravacao1.Execute;
end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.EPropostaRetorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
    EEstagioAtual.Text := Retorno1
  else
    EEstagioAtual.clear;
  EEstagioAtual.Atualiza;

end;

{******************************************************************************}
function TFAlteraEstagioProposta.AlteraEstagioPropostaCliente(VpaDProposta : TRBDPropostaCorpo): Boolean;
begin
  VprPropostas.Add(VpaDProposta);
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  EProposta.AsInteger := VpaDProposta.SeqProposta;
  EDatEmissao.Text := FormatDateTime('DD/MM/YYYY',VpaDProposta.DatProposta);
  ECliente.AInteiro := VpaDProposta.CodCliente;
  ECliente.Atualiza;
  EEstagioAtual.AInteiro := VpaDProposta.CodEstagio;
  EEstagioAtual.Atualiza;
  ActiveControl := ECodEstagio;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioProposta.AlteraEstagioPropostas(VpaPropostas : TList):Boolean;
begin
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  VprPropostas := VpaPropostas;
  AlterarEnabledDet([EProposta],false);
  EProposta.ACampoObrigatorio := false;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioProposta.DadosValidos : String;
begin
  result := '';
  if EMotivo.ACampoObrigatorio then
    if EMotivo.Lines.Text = '' then
      result := 'MOTIVO NÃO PREENCHIDO!!!'#13'É necessário preencher o motivo pelo qual se está mudando de estágio';
end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.EChamadoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.ECodEstagioRetorno(Retorno1,
  Retorno2: String);
begin
  EMotivo.ACampoObrigatorio := false;
  if retorno1 <> '' then
  begin
    if Retorno1 = 'S' then
      EMotivo.ACampoObrigatorio := true;
  end;
end;


procedure TFAlteraEstagioProposta.ECodEstagioSelect(Sender: TObject);
begin
  ECodEstagio.ASelectLocaliza.Text := ' Select * from ESTAGIOPRODUCAO ' +
                                      '  Where  TIPEST = ''C'' ';
  ECodEstagio.ASelectValida.Text   := ' Select * from ESTAGIOPRODUCAO  '+
                                      '  Where CODEST = @     ' +
                                      '    AND TIPEST = ''C'' ';
  if not (puAdministrador in varia.PermissoesUsuario)  then
    if (puCREstagiosAutorizados in varia.PermissoesUsuario) then
    begin
      // somente os estágios autorizados deste grupo de usuario
      ECodEstagio.ASelectLocaliza.Text := ECodEstagio.ASelectLocaliza.Text + ' AND CODEST IN ' + varia.CodigosEstagiosAutorizados;
      ECodEstagio.ASelectValida.Text := ECodEstagio.ASelectValida.Text + ' AND CODEST IN ' + varia.CodigosEstagiosAutorizados;
    end;
end;

initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraEstagioProposta]);
end.
