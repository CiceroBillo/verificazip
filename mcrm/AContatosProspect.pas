unit AContatosProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, Componentes1, Localizacao,
  Grids, CGrades, UnDados, UnProspect;

type
  TFContatosProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor3: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    PanelColor1: TPanelColor;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    EProspect: TEditLocaliza;
    Localiza: TConsultaPadrao;
    Grade: TRBStringGridColor;
    EProfissao: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure EProfissaoCadastrar(Sender: TObject);
    procedure EProfissaoRetorno(Retorno1, Retorno2: String);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
  private
    VprCodProspect: Integer;
    VprAcao: Boolean;
    VprEmail : String;
    VprDContato: TRBDContatoProspect;
    VprContatos: TList;
    procedure CarTitulosGrade;
    function ExisteProfissao : boolean;
    procedure CarDContatoClasse;
  public
    function CadastraContatos(VpaCodProspect: Integer): Boolean;
  end;

var
  FContatosProspect: TFContatosProspect;

implementation
uses
  APrincipal, FunString, UnClientes, Constantes, FunData, FunObjeto, ConstMsg, AProfissoes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFContatosProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  VprContatos:= TList.Create;
  Grade.ADados:= VprContatos;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFContatosProspect.FormClose(Sender: TObject; var Action: TCloseAction);
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
procedure TFContatosProspect.CarTitulosGrade;
begin
  Grade.Cells[1,0]:= 'Nome Contato';
  Grade.Cells[2,0]:= 'Data Nascimento';
  Grade.Cells[3,0]:= 'Telefone';
  Grade.Cells[4,0]:= 'Celular';
  Grade.Cells[5,0]:= 'E-Mail';
  Grade.Cells[6,0]:= 'Código';
  Grade.Cells[7,0]:= 'Profissão';
  Grade.Cells[8,0]:= 'Observações';
  Grade.Cells[9,0]:= 'Marketing';  
end;

{******************************************************************************}
function TFContatosProspect.CadastraContatos(VpaCodProspect: Integer): Boolean;
begin
  VprCodProspect:= VpaCodProspect;
  EProspect.AInteiro:= VpaCodProspect;
  EProspect.Atualiza;
  FunProspect.CarDContatoProspect(VpaCodProspect,VprContatos);
  Grade.CarregaGrade;
  ActiveControl:= Grade;
  Showmodal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFContatosProspect.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFContatosProspect.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFContatosProspect.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= FunProspect.GravaDContatosProspect(VprCodProspect,VprContatos);
  if VpfResultado = '' then
  begin
    VprAcao:= True;
    Close;
  end
  else
    Aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFContatosProspect.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDContato:= TRBDContatoProspect(VprContatos.Items[VpaLinha-1]);

  Grade.Cells[1,VpaLinha]:= VprDContato.NomContato;
  if VprDContato.DatNascimento > MontaData(1,1,1900) then
    Grade.Cells[2,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDContato.DatNascimento)
  else
    Grade.Cells[2,VpaLinha]:= '';
  Grade.Cells[3,VpaLinha]:= VprDContato.FonContato;
  Grade.Cells[4,VpaLinha]:= VprDContato.CelContato;
  Grade.Cells[5,VpaLinha]:= VprDContato.EMailContato;
  if VprDContato.CodProfissao <> 0 then
    Grade.Cells[6,VpaLinha]:= IntToStr(VprDContato.CodProfissao)
  else
    Grade.Cells[6,VpaLinha]:= '';
  Grade.Cells[7,VpaLinha]:= VprDContato.NomProfissao;
  Grade.Cells[8,VpaLinha]:= VprDContato.DesObservacoes;
  Grade.Cells[9,VpaLinha]:= VprDContato.AceitaEMarketing;
end;

{******************************************************************************}
procedure TFContatosProspect.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
{  //permitir cadastrar os prospect sem nome para colocar os contatos da newsletter
  if Grade.Cells[1,Grade.ALinha] = '' then
  begin
    Aviso('NOME DO CONTATO NÃO PREENCHIDO!!!'#13'É necessário preencher o nome do contato.');
    VpaValidos:= False;
    Grade.Col:= 1;
  end
  else}
    if not ExisteProfissao then
    begin
      Aviso('PROFISSÃO INVÁLIDA!!!'#13'A profissão digitada não é válida.');
      VpaValidos:= False;
      Grade.Col:= 6;
    end
    else
      if Grade.Cells[9,Grade.ALinha] = '' then
      begin
        Aviso('EMARKETING NÃO PREENCHIDO!!!'#13'É necessário preencher se o prospect aceita telemarketing.');
        VpaValidos:= False;
        Grade.Col:= 1;
      end;    
  if VpaValidos then
    CarDContatoClasse;
end;

{******************************************************************************}
function TFContatosProspect.ExisteProfissao: boolean;
begin
  result:= true;
  if Grade.Cells[6,Grade.ALinha] <> '' then
  begin
    result:= FunClientes.ExisteProfissao(StrToInt(Grade.Cells[6,Grade.ALinha]));
    if result then
    begin
      EProfissao.Text := Grade.Cells[6,Grade.ALinha];
      EProfissao.Atualiza;
    end;
  end;
end;

{******************************************************************************}
procedure TFContatosProspect.CarDContatoClasse;
begin
  VprDContato.CodProspect:= VprCodProspect;
  VprDContato.CodUsuario:= Varia.CodigoUsuario;
  VprDContato.NomContato:= Grade.Cells[1,Grade.ALinha];
  try
    VprDContato.DatNascimento:= StrToDate(Grade.Cells[2,Grade.ALinha]);
  except
    VprDContato.DatNascimento:= MontaData(1,1,1900);
  end;
  if DeletaChars(DeletaChars(DeletaChars(DeletaEspaco(Grade.Cells[3,Grade.ALinha]),'('),')'),'-') <> '' then
    VprDContato.FonContato:= Grade.Cells[3,Grade.ALinha]
  else
    VprDContato.FonContato:= '';
  if DeletaChars(DeletaChars(DeletaChars(DeletaEspaco(Grade.Cells[4,Grade.ALinha]),'('),')'),'-') <> '' then
    VprDContato.CelContato:= Grade.Cells[4,Grade.ALinha]
  else
    VprDContato.CelContato:= '';
  VprDContato.EMailContato:= Grade.Cells[5,Grade.ALinha];
  if Grade.Cells[6,Grade.ALinha] <> '' then
    VprDContato.CodProfissao:= StrToInt(Grade.Cells[6,Grade.ALinha])
  else
    VprDContato.CodProfissao:= 0;
  VprDContato.NomProfissao:= Grade.Cells[7,Grade.ALinha];
  VprDContato.DesObservacoes:= Grade.Cells[8,Grade.ALinha];
  VprDContato.AceitaEMarketing:= Grade.Cells[9,Grade.ALinha];
  if Grade.AEstadoGrade in [egEdicao] then
  begin
    if (VprDContato.EmailContato <> VprEmail) then
      VprDContato.IndExportadoEficacia := false;
  end;
end;

{******************************************************************************}
procedure TFContatosProspect.EProfissaoCadastrar(Sender: TObject);
begin
  FProfissoes:= TFProfissoes.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProfissoes'));
  FProfissoes.BotaoCadastrar1.Click;
  FProfissoes.showmodal;
  FProfissoes.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFContatosProspect.EProfissaoRetorno(Retorno1, Retorno2: String);
begin
  Grade.Cells[6,Grade.ALinha]:= Retorno1;
  Grade.Cells[7,Grade.ALinha]:= Retorno2;
end;

{******************************************************************************}
procedure TFContatosProspect.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    2: Value:= '!99\/99\/0000;1;';
    3, 4: Value:= '!\(00\)>#000-0000;1; ';
    6: Value:= '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFContatosProspect.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114: case Grade.AColuna of
           6: EProfissao.AAbreLocalizacao;
         end;
  end;
end;

{******************************************************************************}
procedure TFContatosProspect.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprContatos.Count > 0 then
  begin
    VprDContato:= TRBDContatoProspect(VprContatos.Items[VpaLinhaAtual-1]);
    VprEmail := VprDContato.EmailContato;
  end;
end;

{******************************************************************************}
procedure TFContatosProspect.GradeNovaLinha(Sender: TObject);
begin
  VprDContato:= TRBDContatoProspect.Cria;
  VprContatos.Add(VprDContato);
  VprDContato.AceitaEMarketing:= 'S';
  Grade.Cells[9,Grade.ALinha]:= 'S';  
end;

{******************************************************************************}
procedure TFContatosProspect.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egEdicao, egInsercao] then
  begin
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        6: if not ExisteProfissao then
             EProfissao.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFContatosProspect.GradeKeyPress(Sender: TObject; var Key: Char);
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
  RegisterClasses([TFContatosProspect]);
end.
