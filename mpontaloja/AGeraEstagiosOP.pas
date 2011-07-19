unit AGeraEstagiosOP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Localizacao, UnDadosProduto,
  Grids, CGrades, Mask, numericos, UnOrdemProducao, UnProdutos,
  CheckLst;

type
  TFGeraEstagiosOP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    LNomProduto: TLabel;
    ECodProduto: TEditColor;
    EQtdProduto: Tnumerico;
    Label2: TLabel;
    Label3: TLabel;
    EUM: TEditColor;
    EQtdCelula: Tnumerico;
    Label4: TLabel;
    Grade: TRBStringGridColor;
    ETotalHoras: TEditColor;
    Label5: TLabel;
    EDesTecnica: TMemoColor;
    Label6: TLabel;
    ECor: TEditLocaliza;
    Label7: TLabel;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    BFechar: TBitBtn;
    SpeedButton3: TSpeedButton;
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
    procedure GradeGetCellAlignment(sender: TObject; ARow, ACol: Integer;
      var HorAlignment: TAlignment; var VerAlignment: TVerticalAlignment);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure GradeDepoisExclusao(Sender: TObject);
    procedure EQtdProdutoExit(Sender: TObject);
    procedure EQtdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EQtdCelulaExit(Sender: TObject);
    procedure EQtdCelulaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDOrdemProducao : TRBDOrdemProducao;
    VprDFracaoOP : TRBDFracaoOrdemProducao;
    VprDEstagio : TRBDordemProducaoEstagio;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure CarTitulosGrade;
    procedure CarDTela;
    procedure CarDClasse;
    procedure CarDEstagio;
    procedure HabilitaBotoes(VpaEstado : Boolean);
    procedure AtualizarHorasProducao;
    procedure AtualizaQtdCelulas;
  public
    { Public declarations }
    function GeraEstagioOP(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracaoOP : TRBDFracaoOrdemProducao):boolean;
  end;

var
  FGeraEstagiosOP: TFGeraEstagiosOP;

implementation

uses APrincipal, ConstMsg, Constantes, FunString, ANovoProdutoPro;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGeraEstagiosOP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGeraEstagiosOP.FormClose(Sender: TObject; var Action: TCloseAction);
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
procedure TFGeraEstagiosOP.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.BGravarClick(Sender: TObject);
begin
  CarDClasse;
  VprAcao := true;
  close;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.CarTitulosGrade;
begin
  Grade.Cells[0,0] := 'ID';
  Grade.Cells[1,0] := 'Celulas Trabalho';
  Grade.Cells[2,0] := 'Horas';
  Grade.Cells[3,0] := 'Código';
  Grade.Cells[4,0] := 'Estágio';
  Grade.Cells[5,0] := 'Descrição';
  Grade.Cells[6,0] := 'ID Anterior';
  Grade.Cells[7,0] := 'Ordem';
  Grade.Cells[8,0] := 'Interna/Externa';
  Grade.Cells[9,0] := 'Val Unitário Facção';
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.CarDTela;
begin
  ECodProduto.Text := VprDOrdemProducao.CodProduto;
  LNomProduto.Caption := VprDOrdemProducao.NomProduto;
  EQtdProduto.AValor := VprDFracaoOP.QtdProduto;
  EUM.Text := VprDOrdemProducao.UMPedido;
  EQtdCelula.AsInteger := VprDFracaoOP.QtdCelula;
  EDesTecnica.Lines.Text := VprDOrdemProducao.DesObservacoes;
  ECor.AInteiro := VprDOrdemProducao.CodCor;
  ECor.Atualiza;
  ETotalHoras.text :=  FunOrdemProducao.RTotalHorasOP(VprDFracaoOP);
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.CarDClasse;
begin
  VprDOrdemProducao.DesObservacoes := EDesTecnica.Lines.Text;
  VprDFracaoOP.QtdProduto := EQtdProduto.AValor;
  VprDFracaoOP.HorProducao := ETotalHoras.Text;
  VprDFracaoOP.QtdCelula := EQtdCelula.AsInteger;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.CarDEstagio;
begin
  VprDEstagio.QtdCelula := StrToInt(Grade.Cells[1,Grade.ALinha]);
  Grade.Cells[2,Grade.ALinha] := FunOrdemProducao.RQtdHorasEstagio(VprDEstagio,FunProdutos.REstagioProduto(VprDOrdemProducao.DProduto,VprDEstagio.SeqEstagio),VprDFracaoOP.QtdProduto);
  VprDEstagio.QtdHoras := Grade.Cells[2,Grade.ALinha];
  VprdEstagio.NumOrdem := StrToInt(Grade.Cells[7,Grade.ALinha]);
  VprdEstagio.IndProducaoInterna := Grade.Cells[8,Grade.ALinha];
  if DeletaChars(DeletaChars(Grade.Cells[9,Grade.ALinha],'.'),'0') <> '' then
    VprDEstagio.ValUnitarioFaccao := StrToFloat(DeletaChars(Grade.Cells[9,Grade.ALinha],'.'));
  ETotalHoras.text :=  FunOrdemProducao.RTotalHorasOP(VprDFracaoOP);
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.HabilitaBotoes(VpaEstado : Boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

procedure TFGeraEstagiosOP.AtualizarHorasProducao;
begin
  VprDFracaoOP.QtdProduto := EQtdProduto.AValor;
  FunOrdemProducao.RecalculaHorasEstagio(VprDOrdemProducao,VprDFracaoOP);
  Grade.CarregaGrade;
  ETotalHoras.text :=  FunOrdemProducao.RTotalHorasOP(VprDFracaoOP);
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.AtualizaQtdCelulas;
var
  VpfLaco : Integer;
begin
  VprDFracaoOP.QtdCelula := EQtdCelula.AsInteger;
  for VpfLaco := 0 to VprDFracaoOP.Estagios.count -1 do
  begin
    TRBDordemProducaoEstagio(VprDFracaoOP.Estagios.Items[VpfLaco]).QtdCelula := VprDFracaoOP.QtdCelula;
  end;
  AtualizarHorasProducao;
end;

{******************************************************************************}
function TFGeraEstagiosOP.GeraEstagioOP(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracaoOP : TRBDFracaoOrdemProducao):boolean;
begin
  VprDOrdemProducao := VpaDOrdemProducao;
  VprDFracaoOP := VpaDFracaoOP;
  Grade.ADados := VprDFracaoOP.Estagios;
  Grade.CarregaGrade;
  CarDTela;
  HabilitaBotoes(true);
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDEstagio := TRBDordemProducaoEstagio(VprDFracaoOP.Estagios.Items[VpaLinha-1]);
  Grade.cells[0,VpaLinha] := InttoStr(VprDEstagio.SeqEstagio);
  Grade.Cells[1,VpaLinha] := Inttostr(VprDEstagio.QtdCelula);
  Grade.cells[2,VpaLinha] := VprDEstagio.QtdHoras;
  Grade.cells[3,VpaLinha] := InttoStr(VprDEstagio.CodEstagio);
  Grade.cells[4,VpaLinha] := VprDEstagio.NomEstagio;
  Grade.cells[5,VpaLinha] := VprDEstagio.DesEstagio;
  Grade.cells[6,VpaLinha] := InttoStr(VprDEstagio.SeqEstagioAnterior);
  Grade.Cells[7,VpaLinha] := IntTosTr(VprDEstagio.NumOrdem);
  Grade.Cells[8,VpaLinha] := VprDEstagio.IndProducaoInterna;
  if VprDEstagio.ValUnitarioFaccao <> 0 then
    Grade.Cells[9,VpaLinha] := FormatFloat(Varia.MascaraValorUnitario,VprDEstagio.ValUnitarioFaccao)
  else
    Grade.Cells[9,VpaLinha] := '';
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := false;
  if (Grade.Cells[1,Grade.ALinha] = '') then
  begin
    Aviso('QUANTIDADE DE CELULA DE TRABALHO NÃO PREENCHIDO!!!'#13'É necessário digitar a quantidade de células de trabalho.');
    Grade.Col := 1;
  end
  else
    if (Grade.Cells[2,Grade.ALinha] = '') then
    begin
      aviso('QUANTIDADE HORAS NÃO PREENCHIDO!!!'#13'É necessário digitar a quantidade de horas.');
      Grade.Col := 2;
    end
    else
      if (Grade.Cells[7,Grade.ALinha] = '') then
      begin
        aviso('ORDEM DO ESTÁGIO NÃO PREENCHIDO!!!'#13'É necessário digitar a ordem do estágio.');
        Grade.Col := 7;
      end
        else
        if (Grade.Cells[8,Grade.ALinha] <> 'I') and (Grade.Cells[8,Grade.ALinha] <> 'E') then
        begin
          aviso('INDICADOR DE PRODUÇÃO INTERNA INVÁLIDO!!!'#13'O indicardor de produção somente pode ser preenchido com "I"(Interna) ou "E"(Externa)...');
          Grade.Col := 8;
        end
        else
          VpaValidos := true;
  if VpaValidos then
  begin
    CarDEstagio;
    if VprDEstagio.QtdCelula = 0 then
    begin
      Aviso('QUANTIDADE DE CELULA DE TRABALHO NÃO PREENCHIDO!!!'#13'É necessário digitar a quantidade de células de trabalho.');
      VpaValidos := false;
      Grade.Col := 1;
    end;
  end;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    4,5 :  Value := '000;0; ';
    3 : value := '000:00;1;_';
  end;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  case Grade.Col of
    3,4 : key :=#0;
    8 :begin
         if key = 'i' then
           key := 'I'
         else
           if key = 'e' then
             key := 'E'
           else
             if not(key in ['I','E']) then
               key := #0;
       end;
  end;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDFracaoOP.Estagios.Count > 0 then
    VprDEstagio := TRBDordemProducaoEstagio(VprDFracaoOP.Estagios.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.GradeGetCellAlignment(sender: TObject; ARow,
  ACol: Integer; var HorAlignment: TAlignment;
  var VerAlignment: TVerticalAlignment);
begin
  if ARow > 0 then
  begin
    case ACol of
      1 : HorAlignment := taCenter;
      2 : HorAlignment := taRightJustify;
    end;
  end;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1 : if Grade.Cells[1,Grade.Alinha] <> '' then
            begin
              if StrToInt(Grade.Cells[1,Grade.Alinha])<> VprDEstagio.QtdCelula  then
              begin
                VprDEstagio.QtdCelula := StrToInt(Grade.Cells[1,Grade.Alinha]);
                Grade.Cells[2,Grade.ALinha] := FunOrdemProducao.RQtdHorasEstagio(VprDEstagio,FunProdutos.REstagioProduto(VprDOrdemProducao.DProduto,VprDEstagio.SeqEstagio),VprDFracaoOP.QtdProduto);
              end;
            end;
      end;
    end;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFGeraEstagiosOP.BImprimirClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.GradeDepoisExclusao(Sender: TObject);
begin
  ETotalHoras.text :=  FunOrdemProducao.RTotalHorasOP(VprDFracaoOP);
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.EQtdProdutoExit(Sender: TObject);
begin
  if EQtdProduto.AValor <> VprDFracaoOP.QtdProduto then
    AtualizarHorasProducao;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.EQtdProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    AtualizarHorasProducao;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.EQtdCelulaExit(Sender: TObject);
begin
  if EQtdCelula.AsInteger <> VprDFracaoOP.QtdCelula then
    AtualizaQtdCelulas;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.EQtdCelulaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
  begin
    AtualizaQtdCelulas;
    EQtdProduto.SelectAll;
  end;
end;

{******************************************************************************}
procedure TFGeraEstagiosOP.SpeedButton3Click(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  if FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,VprDOrdemProducao.SeqProduto) <> nil then
  begin
    FunProdutos.CarDProduto(VprDOrdemProducao.DProduto);
    FunOrdemProducao.AdicionaEstagiosOP(VprDOrdemProducao.DProduto,VprDFracaoOP,false);
    Grade.CarregaGrade;
  end;
  FNovoProdutoPro.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGeraEstagiosOP]);
end.
