unit ACadastraEmailSuspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao, UnDadosLocaliza, UnDados,
  UnProspect, DBKeyViolation;

type
  TFCadastraEmailSuspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    ESuspect: TRBEditLocaliza;
    ENomSuspect: TEditColor;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    EEmailsCadatrados: TMemoColor;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label5: TLabel;
    LQtdCadastrados: TLabel;
    LQtdAutomaticos: TLabel;
    ESiteEmail: TMemoColor;
    ValidaGravacao1: TValidaGravacao;
    EDominios: TMemoColor;
    Label6: TLabel;
    OpenDialog: TOpenDialog;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ESuspectRetorno(VpaColunas: TRBColunasLocaliza);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure ESiteEmailKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure ESuspectChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprQtdEmailCadastrado,
    VprQtdEmailAutomatico : Integer;
    VprDProspect : TRBDProspect;
    procedure InicializaTela;
    function ImportaArquivoOutlook :string;
  public
    { Public declarations }
  end;

var
  FCadastraEmailSuspect: TFCadastraEmailSuspect;

implementation

uses APrincipal, ConstMsg, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCadastraEmailSuspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDProspect := TRBDProspect.cria;
  VprQtdEmailCadastrado := 0;
  VprQtdEmailAutomatico := 0;
  ValidaGravacao1.execute;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCadastraEmailSuspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDProspect.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFCadastraEmailSuspect.ImportaArquivoOutlook: string;
var
  VpfLaco,VpfPosMailto : Integer;
  VpfArquivo : TStringList;
  VpfEmail,VpfResultado : String;
  VpfCharDelimitador : char;
begin
  for VpfLaco := 0 to OpenDialog.Files.Count - 1 do
  begin
    VpfArquivo := TStringList.Create;
    VpfArquivo.LoadFromFile(OpenDialog.Files.Strings[VpfLaco]);
    VpfPosMailto := Pos('mailto',VpfArquivo.text);
    while VpfPosMailto > 0 do
    begin
      if VpfArquivo.Text[VpfPosMailto-1] = '['  then
        VpfCharDelimitador := ']'
      else
        if VpfArquivo.Text[VpfPosMailto-1] = '"'  then
          VpfCharDelimitador := '"'
        else
          aviso('CharDelimitador não definido '+VpfArquivo.Text[VpfPosMailto-1]);
      VpfArquivo.Text := copy(VpfArquivo.Text,VpfPosMailto,length(VpfArquivo.Text)-VpfPosMailto);
      VpfEmail := CopiaAteChar(VpfArquivo.Text,VpfCharDelimitador);
      VpfEmail := DeleteAteChar(VpfEmail,':');
      VpfArquivo.Text := DeleteAteChar(VpfArquivo.Text,VpfCharDelimitador);
      VprDProspect.CodProspect := ESuspect.AInteiro;
      VpfResultado := FunProspect.CadastraEmailEmailSuspect(VprDProspect,VpfEmail,EEmailsCadatrados,EDominios,VprQtdEmailCadastrado,VprQtdEmailAutomatico);
      if VpfResultado <> '' then
      begin
        aviso(VpfResultado);
        break;
      end;
      VpfPosMailto := Pos('mailto',VpfArquivo.text);
      LQtdCadastrados.Caption  := IntToStr(VprQtdEmailCadastrado);
      LQtdCadastrados.Refresh;
      LQtdAutomaticos.Caption := IntToStr(VprQtdEmailAutomatico);
      LQtdAutomaticos.Refresh;
    end;
    VpfArquivo.Free;
  end;
end;

{******************************************************************************}
procedure TFCadastraEmailSuspect.InicializaTela;
begin
  ESiteEmail.Clear;
  if ESuspect.AInteiro <> 0 then
    ESiteEmail.SetFocus;
end;

{******************************************************************************}
procedure TFCadastraEmailSuspect.ESuspectChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFCadastraEmailSuspect.ESuspectRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  ENomSuspect.Text := VpaColunas[1].AValorRetorno;
end;

{******************************************************************************}
procedure TFCadastraEmailSuspect.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFCadastraEmailSuspect.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VprDProspect.CodProspect := ESuspect.AInteiro;
  VpfResultado := FunProspect.CadastraEmailEmailSuspect(VprDProspect,ESiteEmail.Text,EEmailsCadatrados,EDominios,VprQtdEmailCadastrado,VprQtdEmailAutomatico);
  if VpfResultado = '' then
  begin
    InicializaTela;
    LQtdCadastrados.Caption  := IntToStr(VprQtdEmailCadastrado);
    LQtdAutomaticos.Caption := IntToStr(VprQtdEmailAutomatico);
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFCadastraEmailSuspect.BitBtn1Click(Sender: TObject);
begin
  if ESuspect.AInteiro <> 0 then
  begin
    if OpenDialog.Execute then
      ImportaArquivoOutlook;
  end
  else
    aviso('SUSPECT NÃO PREENCHIDO!!!'#13'É necessário preencher o codigo do suspect que sera guardados os e-mails');

end;

procedure TFCadastraEmailSuspect.BitBtn2Click(Sender: TObject);
var
  VpfArquivo : TStringList;
begin
  VpfArquivo := TStringList.Create;
  VpfArquivo.LoadFromFile(');
end;

{******************************************************************************}
procedure TFCadastraEmailSuspect.ESiteEmailKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    BGravar.Click;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCadastraEmailSuspect]);
end.
