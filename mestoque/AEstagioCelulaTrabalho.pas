unit AEstagioCelulaTrabalho;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, CGrades, Componentes1, ExtCtrls, UnDadosProduto, UnProdutos,
  PainelGradiente, Localizacao, UnOrdemProducao;

type
  TFEstagioCelulaTrabalho = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    EEstagio: TEditLocaliza;
    Localiza: TConsultaPadrao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EEstagioCadastrar(Sender: TObject);
    procedure EEstagioRetorno(Retorno1, Retorno2: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDCelula : TRBDCelulaTrabalho;
    VprDEstagio : TRBDEstagioCelula;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure CarTitulosGrade;
    procedure CarDEstagio;
    function ExisteEstagio : Boolean;
  public
    { Public declarations }
    function EstagiosCelula(VpaDCelula : TRBDCelulaTrabalho):Boolean;
  end;

var
  FEstagioCelulaTrabalho: TFEstagioCelulaTrabalho;

implementation

uses APrincipal,ConstMsg, AEstagioProducao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEstagioCelulaTrabalho.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.Cria(FPrincipal.BaseDados);
  CarTitulosGrade;
  VprAcao :=false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEstagioCelulaTrabalho.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Estágio';
  Grade.Cells[3,0] := 'Principal';
  Grade.Cells[4,0] := 'Capacidade Produtiva';
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.CarDEstagio;
begin
  VprDEstagio.CodEstagio := StrToInt(Grade.Cells[1,Grade.ALinha]);
  VprDEstagio.NomEstagio := Grade.Cells[2,Grade.ALinha];
  VprDEstagio.IndPrincipal := UpperCase(Grade.Cells[3,Grade.ALinha]) = 'S';
  VprDEstagio.ValCapacidadeProdutiva := StrToInt(Grade.Cells[4,Grade.ALinha]);
end;

{******************************************************************************}
function TFEstagioCelulaTrabalho.ExisteEstagio : Boolean;
begin
  result := false;
  if Grade.Cells[1,Grade.ALinha] <> '' then
  begin
    result := FunProdutos.ExisteEstagio(Grade.Cells[1,Grade.Alinha],VprDEstagio.NomEstagio);
    if result then
      Grade.Cells[2,Grade.ALinha] := VprDestagio.NomEstagio
    else
      Grade.cells[2,Grade.ALinha] := '';
  end;
end;

{******************************************************************************}
function TFEstagioCelulaTrabalho.EstagiosCelula(VpaDCelula : TRBDCelulaTrabalho):Boolean;
begin
  VprDCelula := VpaDCelula;
  Grade.ADados := VprDCelula.Estagios;
  Grade.CarregaGrade;
  Showmodal;
  result := vprAcao;
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.BGravarClick(Sender: TObject);
Var
  VpfResultado : String;
begin
  VpfResultado := FunOrdemProducao.GravaDEstagioCelulaTrabalho(VprDCelula);
  if VpfResultado = '' then
  begin
    VprAcao := true;
    close;
  end
  else
    Aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDEstagio := TRBDEstagioCelula(VprDCelula.Estagios.Items[Vpalinha-1]);
  if VprDEstagio.CodEstagio <> 0 then
    Grade.Cells[1,VpaLinha] := InttoStr(VprDEstagio.CodEstagio)
  else
    Grade.Cells[1,VpaLinha] := '';
  Grade.cells[2,VpaLinha] := VprDEstagio.NomEstagio;
  if VprDEstagio.IndPrincipal then
    Grade.Cells[3,VpaLinha] := 'S'
  else
    Grade.Cells[3,VpaLinha] := 'N';
  if VprDEstagio.ValCapacidadeProdutiva <> 0 then
    Grade.Cells[4,VpaLinha] := InttoStr(VprDEstagio.ValCapacidadeProdutiva)
  else
    Grade.Cells[4,VpaLinha] := '';
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := false;
  if (Grade.Cells[1,Grade.ALinha] = '') then
  begin
    aviso('ESTÁGIO NÃO PREENCHIDO!!!'#13'É necessário preencher o código do estagio.');
    Grade.Col := 1;
  end
  else
    if not ExisteEstagio then
    begin
      aviso('ESTÁGIO INVÁLIDO!!!'#13'O estágio preenchido não existe cadastrado.');
      Grade.Col := 1;
    end
    else
      if (Grade.Cells[3,Grade.ALinha] = '') then
      begin
        aviso('INDICADOR DE PRIORIDADE NÃO PREENCHIDO!!!'#13'É necessário preencher o indicador se a celula é principal.');
        Grade.Col := 3;
      end
      else
        if (Grade.Cells[4,Grade.ALinha] = '') then
        begin
          aviso('CAPACIDADE PRODUTIVA NÃO PREENCHIDO!!!'#13'É necessário preencher a capacidade produtiva da celula.');
          Grade.Col := 4;
        end
        else
          VpaValidos := true;
  if VpaValidos then
  begin
    CarDEstagio;
    if VprDEstagio.ValCapacidadeProdutiva <=0 then
    begin
      aviso('CAPACIDADE PRODUTIVA INVÁLIDA!!!'#13'Valor preenchido da capacidade produtiva inváido.');
      Grade.Col := 4;
      VpaValidos := false;
    end
    else
      if FunOrdemProducao.ExisteEstagioCelulaDuplicado(VprDCelula) then
      begin
        Aviso('ESTÁGIO DUPLICADO!!!'#13'O estágio digitado já foi cadastrado para essa celula de trabalho.');
        Grade.Col := 1;
        VpaValidos := false;
      end;
  end;
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1,4 :  Value := '0000;0; ';
  end;
end;

procedure TFEstagioCelulaTrabalho.GradeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Grade.Col = 2 then
    Key := #0;
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDCelula.Estagios.Count >0 then
    VprDEstagio := TRBDEstagioCelula(VprDCelula.Estagios.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.GradeNovaLinha(Sender: TObject);
begin
  VprDEstagio := VprDCelula.addEstagio;
  VprDEstagio.ValCapacidadeProdutiva := 100;
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1 : if Grade.Cells[1,Grade.Alinha] <> '' then
            begin
              if not existeEstagio then
              begin
                if not EEstagio.AAbreLocalizacao then
                begin
                  Aviso('ESTÁGIO INVÁLIDO!!!'#13'O estágio digitado não existe cadastrado.');
                  Grade.Col := 1;
                  abort;
                end;
              end;
            end
            else
              EEstagio.AAbreLocalizacao;
      end;
    end;
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.EEstagioCadastrar(Sender: TObject);
begin
  FEstagioProducao := TFEstagioProducao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FEstagioProducao'));
  FEstagioProducao.BotaoCadastrar1.Click;
  FEstagioProducao.Showmodal;
  FEstagioProducao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEstagioCelulaTrabalho.EEstagioRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[1,Grade.ALinha] := EEstagio.Text;
    Grade.Cells[2,Grade.ALinha] := retorno1;
  end;
end;

procedure TFEstagioCelulaTrabalho.GradeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case Grade.Col of
        1 :  EEstagio.AAbreLocalizacao;
      end;
    end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEstagioCelulaTrabalho]);
end.
