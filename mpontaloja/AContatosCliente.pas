unit AContatosCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Localizacao, StdCtrls, Componentes1, Buttons,
  Grids, CGrades, UnDados, UnClientes, Mask;

type
  TFContatosCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    ECliente: TEditLocaliza;
    ConsultaPadrao1: TConsultaPadrao;
    PanelColor2: TPanelColor;
    Grade: TRBStringGridColor;
    PanelColor3: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    EProfissao: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EProfissaoRetorno(Retorno1, Retorno2: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EProfissaoCadastrar(Sender: TObject);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
  private
    VprAcao: Boolean;
    VprEmail : string;
    VprCodCliente: Integer;
    VprDContato: TRBDContatoCliente;
    VprContatos: TList;
    procedure CarTitulosGrade;
    procedure CarDContatoClasse;
    function ExisteProfissao : boolean;
  public
    { Public declarations }
    function CadastraContatos(VpaCodCliente: Integer): Boolean;
  end;

var
  FContatosCliente: TFContatosCliente;

implementation
uses
  APrincipal, FunObjeto, ConstMsg, Constantes, FunData, AProfissoes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFContatosCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  VprContatos:= TList.Create;
  Grade.ADados:= VprContatos;
  Grade.CarregaGrade;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFContatosCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprContatos);
  VprContatos.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFContatosCliente.CarTitulosGrade;
begin
  Grade.Cells[1,0]:= 'Nome Contato';
  Grade.Cells[2,0]:= 'Dt. Nascimento';
  Grade.Cells[3,0]:= 'Telefone';
  Grade.Cells[4,0]:= 'Celular';
  Grade.Cells[5,0]:= 'E-Mail';
  Grade.Cells[6,0]:= 'Código';
  Grade.Cells[7,0]:= 'Profissão';
  Grade.Cells[8,0]:= 'Observações';
  Grade.Cells[9,0]:= 'Marketing';  
end;



{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                      Eventos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFContatosCliente.BFecharClick(Sender: TObject);
begin
  Self.Close;
end;

{******************************************************************************}
procedure TFContatosCliente.BCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

{******************************************************************************}
procedure TFContatosCliente.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:=  FunClientes.GravaDContatos(VprCodCliente,VprContatos);
  if VpfResultado = '' then
  begin
    VprAcao:= True;
    Self.Close;
  end
  else
    Aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFContatosCliente.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDContato:= TRBDContatoCliente(VprContatos.Items[VpaLinha-1]);
  Grade.Cells[1,VpaLinha]:= VprDContato.NomContato;
  if VprDContato.DatNascimento > MontaData(1,1,1900) then
    Grade.Cells[2,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDContato.DatNascimento)
  else
    Grade.Cells[2,VpaLinha]:= '';
  Grade.Cells[3,VpaLinha]:= VprDContato.DesTelefone;
  Grade.Cells[4,VpaLinha]:= VprDContato.DesCelular;
  Grade.Cells[5,VpaLinha]:= VprDContato.DesEMail;
  if VprDContato.CodProfissao <> 0 then
    Grade.Cells[6,VpaLinha]:= IntToStr(VprDContato.CodProfissao)
  else
    Grade.Cells[6,VpaLinha]:= '';
  Grade.Cells[7,VpaLinha]:= VprDContato.NomProfissao;
  Grade.Cells[8,VpaLinha]:= VprDContato.DesObservacao;
  Grade.Cells[9,VpaLinha]:= VprDContato.AceitaEMarketing;
end;

{******************************************************************************}
procedure TFContatosCliente.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if Grade.Cells[1,Grade.ALinha] = '' then
  begin
    Aviso('NOME DO CONTATO NÃO PREENCHIDO!!!'#13'É necessário preencher o nome do contato.');
    VpaValidos:= False;
    Grade.Col:= 1;
  end
  else
    if not ExisteProfissao then
    begin
      Aviso('PROFISSÃO INVÁLIDA!!!'#13'A profissão digitada não é válida.');
      VpaValidos:= False;
      Grade.Col:= 6;
    end
    else
      if Grade.Cells[9,Grade.ALinha] = '' then
      begin
        Aviso('EMARKETING NÃO PREENCHIDO!!!'#13'É necessário preencher se o cliente aceita telemarketing.');
        VpaValidos:= False;
        Grade.Col:= 1;
      end;
  if VpaValidos then
    CarDContatoClasse;
end;

{******************************************************************************}
procedure TFContatosCliente.CarDContatoClasse;
begin
  VprDContato.NomContato:= Grade.Cells[1,Grade.ALinha];
  try
    StrToDate(Grade.Cells[2,Grade.ALinha]);
    VprDContato.DatNascimento:= StrToDate(Grade.Cells[2,Grade.ALinha]);
  except
    VprDContato.DatNascimento:= MontaData(1,1,1900);
  end;
  VprDContato.DesTelefone:= Grade.Cells[3,Grade.ALinha];
  VprDContato.DesCelular:= Grade.Cells[4,Grade.ALinha];
  VprDContato.DesEMail:= LowerCase(Grade.Cells[5,Grade.ALinha]);
  if Grade.Cells[6,Grade.ALinha] <> '' then
    VprDContato.CodProfissao:= StrToInt(Grade.Cells[6,Grade.ALinha])
  else
    VprDContato.CodProfissao:= 0;
  VprDContato.NomProfissao:= Grade.Cells[7,Grade.ALinha];
  VprDContato.DesObservacao:= Grade.Cells[8,Grade.ALinha];
  VprDContato.AceitaEMarketing:= Grade.Cells[9,Grade.ALinha];
  if Grade.AEstadoGrade in [egEdicao] then
  begin
    if VprDContato.DesEMail <> VprEmail then
      VprDContato.IndExportadoEficacia := false;
  end;
  VprDContato.CodUsuario:= Varia.CodigoUsuario;
end;

{******************************************************************************}
function TFContatosCliente.ExisteProfissao : boolean;
begin
  result := true;
  if Grade.Cells[6,Grade.ALinha] <> '' then
  begin
    result := FunClientes.ExisteProfissao(StrToInt(Grade.Cells[6,Grade.ALinha]));
    if result then
    begin
      EProfissao.Text := Grade.Cells[6,Grade.ALinha];
      EProfissao.Atualiza;
    end;
  end;
end;

{******************************************************************************}
procedure TFContatosCliente.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    2: Value:= '!99\/99\/0000;1; ';
    3, 4: Value:= '!\(00\)>#000-0000;1; ';
    6: Value:= '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFContatosCliente.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprContatos.Count > 0 then
  begin
    VprDContato:= TRBDContatoCliente(VprContatos.Items[VpaLinhaAtual - 1]);
    VprEmail := VprDContato.DesEMail;
  end;
end;

{******************************************************************************}
procedure TFContatosCliente.GradeNovaLinha(Sender: TObject);
begin
  VprDContato:= TRBDContatoCliente.cria;
  VprContatos.Add(VprDContato);
  VprDContato.AceitaEMarketing:= 'S';  
  Grade.Cells[9,Grade.ALinha]:= 'S';
end;

{******************************************************************************}
procedure TFContatosCliente.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egEdicao, egInsercao] then
  begin
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        6: if not ExisteProfissao then
             EProfissao.AAbreLocalizacao
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFContatosCliente.EProfissaoRetorno(Retorno1, Retorno2: String);
begin
  Grade.Cells[6,Grade.ALinha]:= Retorno1;
  Grade.Cells[7,Grade.ALinha]:= Retorno2;
end;

{******************************************************************************}
procedure TFContatosCliente.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case Grade.AColuna of
        6: EProfissao.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFContatosCliente.CadastraContatos(
  VpaCodCliente: Integer): Boolean;
begin
  VprCodCliente := VpaCodCliente;
  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  FunClientes.CarDContatoCliente(VpaCodCliente,VprContatos);
  Grade.CarregaGrade;
  Showmodal;
  result := VprAcao;
end;

procedure TFContatosCliente.EProfissaoCadastrar(Sender: TObject);
begin
  FProfissoes :=TFProfissoes.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProfissoes'));
  FProfissoes.BotaoCadastrar1.Click;
  FProfissoes.showmodal;
  FProfissoes.free;
  ConsultaPadrao1.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFContatosCliente.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  case Grade.Col  of
    5 :
      begin
        if key in [' ',',','/',';','ç','\','ã',':'] then
          key := #0;
      end;
    9 :
      begin
        if not (Key in ['s','S','n','N',#8]) then
          Key:= #0
        else
          if Key = 's' Then
            Key:= 'S'
          else
            if key = 'n' Then
              Key:= 'N';
      end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFContatosCliente]);
end.
