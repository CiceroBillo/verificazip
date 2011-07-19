unit AGerarFracaoOPMaquinasCorte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, CGrades, StdCtrls, UnDadosProduto,
  Buttons, Localizacao;

type
  TFGerarFracaoOPMaquinasCorte = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    EBastidor: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EBastidorRetorno(Retorno1, Retorno2: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure EBastidorSelect(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDOrdemProducao : TRBDordemProducao;
    VprDOrdemCorteItem : TRBDOrdemCorteItem;
    function ExisteBastidor : Boolean;
    procedure CalculaConsumos;
    procedure CarTitulosGrade;
  public
    { Public declarations }
    function GeraOrdemCorte(VpaDOrdemProducao : TRBDordemProducao) : Boolean;
  end;

var
  FGerarFracaoOPMaquinasCorte: TFGerarFracaoOPMaquinasCorte;

implementation

uses APrincipal,Constantes, UnProdutos, ConstMsg, UnOrdemProducao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGerarFracaoOPMaquinasCorte.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGerarFracaoOPMaquinasCorte.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFGerarFracaoOPMaquinasCorte.ExisteBastidor: Boolean;
begin
  Result:= True;
  if Grade.Cells[1,Grade.ALinha] <> '' then
  begin
    Result:= FunOrdemProducao.ExisteBastidor(StrToInt(Grade.Cells[1,Grade.ALinha]),VprDOrdemCorteItem);
    if Result then
    begin
      Grade.Cells[2,Grade.ALinha]:= VprDOrdemCorteItem.NomBastidor;
    end;
    CalculaConsumos;
  end;
end;

{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.CalculaConsumos;
Var
  VpfQtdMedida1,VpfQtdMedida2, VpfQtdMedida3 : Integer;
  VpfIndice1,VpfIndice2, VpfIndice3 : Double;
  VpfDFaca : TRBDFaca;
begin
  VprDOrdemCorteItem.QtdPecasemMetro := 0;
  if VprDOrdemCorteItem.CodFaca <> 0 then
  begin
    VpfDFaca := TRBDFaca.cria;
    FunProdutos.ExisteFaca(VprDOrdemCorteItem.CodFaca,VpfDFaca);
    VprDOrdemCorteItem.QtdPecasemMetro := FunProdutos.RQtdPecaemMetro(VprDOrdemCorteItem.AltProduto,100,VpfDFaca.QtdProvas,VpfDFaca.AltFaca,VpfDFaca.LarFaca,false,VprDOrdemCorteItem.ValIndiceMetro);
    VprDOrdemCorteItem.Qtdproduto := 1 / VprDOrdemCorteItem.QtdPecasemMetro;
    VpfDFaca.free;
  end
  else
    if (VprDOrdemCorteItem.LarMolde <> 0 )and
       (VprDOrdemCorteItem.AltMolde <> 0) then
    begin
      VprDOrdemCorteItem.QtdPecasemMetro := FunProdutos.RQtdPecaemMetro(VprDOrdemCorteItem.AltProduto,100,1,VprDOrdemCorteItem.AltMolde,VprDOrdemCorteItem.LarMolde,false,VprDOrdemCorteItem.ValIndiceMetro);
    end;
  if (VprDOrdemCorteItem.LarMolde <> 0 )or(VprDOrdemCorteItem.AltMolde <> 0) or
     (VprDOrdemCorteItem.CodFaca <> 0) or (VprDOrdemCorteItem.CodMaquina <> 0) then
    if VprDOrdemCorteItem.AltProduto = 0 then
    begin
      aviso('ALTURA DO PRODUTO NÃO PREENCHIDA!!!'#13'É necessário informar a altura do produto');
      VprDOrdemCorteItem.QtdPecasemMetro := 0;
    end;
  if VprDOrdemCorteItem.QtdPecasemMetro <> 0 then
    Grade.Cells[12,Grade.ALinha]:= FormatFloat('###,###,##0.00',VprDOrdemCorteItem.QtdPecasemMetro)
  else
    Grade.Cells[12,Grade.ALinha]:= '';
  if VprDOrdemCorteItem.ValIndiceMetro <> 0 then
    Grade.Cells[13,Grade.ALinha]:= FormatFloat('###,###,##0.00',VprDOrdemCorteItem.ValIndiceMetro)
  else
    Grade.Cells[13,Grade.ALinha]:= '';

end;


{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Bastidor';
  Grade.Cells[3,0] := 'Código';
  Grade.Cells[4,0] := 'Máquina';
  Grade.Cells[5,0] := 'Qtd';
  Grade.Cells[6,0] := 'Código';
  Grade.Cells[7,0] := 'Faca';
  Grade.Cells[8,0] := 'Largura Molde';
  Grade.Cells[9,0] := 'Altura Molde';
  Grade.Cells[10,0] := 'Código';
  Grade.Cells[11,0] := 'Produto';
  Grade.Cells[12,0] := 'Código';
  Grade.Cells[13,0] := 'Cor';
  Grade.Cells[14,0] := 'Pc em Metro';
  Grade.Cells[15,0] := 'Indice MT';
  Grade.Cells[16,0] := 'Observações';
end;


{******************************************************************************}
function TFGerarFracaoOPMaquinasCorte.GeraOrdemCorte(VpaDOrdemProducao : TRBDordemProducao) : Boolean;
begin
  VprDOrdemProducao := VpaDOrdemProducao;
  Grade.ADados := VprDOrdemProducao.OrdemCorte.Itens;
  Grade.CarregaGrade;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.BCancelarClick(Sender: TObject);
begin
  Vpracao := false;
  close;
end;

{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.BOkClick(Sender: TObject);
begin
  VprAcao := true;
  close;
end;

{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.GradeCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDOrdemCorteItem := TRBDOrdemCorteItem(VprDOrdemProducao.OrdemCorte.Itens.Items[VpaLinha - 1]);
  if VprDOrdemCorteItem.CodBastidor <> 0 then
    Grade.Cells[1,VpaLinha] := IntToStr(VprDOrdemCorteItem.CodBastidor)
  else
    Grade.Cells[1,VpaLinha] := '';
  Grade.Cells[2,VpaLinha] := VprDOrdemCorteItem.NomBastidor;
  if VprDOrdemCorteItem.CodMaquina <> 0 then
    Grade.Cells[3,VpaLinha] := IntToStr(VprDOrdemCorteItem.CodMaquina)
  else
    Grade.Cells[3,VpaLinha] := '';
  Grade.Cells[4,VpaLinha] := VprDOrdemCorteItem.DMaquina.NomMaquina;
  Grade.Cells[5,VpaLinha] := FormatFloat(varia.MascaraQtd,VprDOrdemCorteItem.QtdProduto);
  if VprDOrdemCorteItem.CodFaca <> 0 then
    Grade.Cells[6,VpaLinha] := IntToStr(VprDOrdemCorteItem.CodFaca)
  else
    Grade.Cells[6,VpaLinha] := '';
  Grade.Cells[7,VpaLinha] := VprDOrdemCorteItem.NomFaca;
  if VprDOrdemCorteItem.LarMolde <> 0 then
    Grade.Cells[8,VpaLinha] := FormatFloat('0.00',VprDOrdemCorteItem.LarMolde)
  else
    Grade.Cells[8,VpaLinha] := '';
  if VprDOrdemCorteItem.AltMolde <> 0 then
    Grade.Cells[9,VpaLinha] := FormatFloat('0.00',VprDOrdemCorteItem.AltMolde)
  else
    Grade.Cells[9,VpaLinha] := '';
  Grade.Cells[10,VpaLinha] := VprDOrdemCorteItem.CodProduto;
  Grade.Cells[11,VpaLinha] := VprDOrdemCorteItem.NomProduto;
  if VprDOrdemCorteItem.CodCor <> 0 then
    Grade.Cells[12,VpaLinha] := IntToStr(VprDOrdemCorteItem.CodCor)
  else
    Grade.Cells[12,VpaLinha] := '';
  Grade.Cells[13,VpaLinha] := VprDOrdemCorteItem.NomCor;
  if VprDOrdemCorteItem.QtdPecasemMetro <> 0 then
    Grade.Cells[14,VpaLinha] := FormatFloat(varia.MascaraQtd,VprDOrdemCorteItem.QtdPecasemMetro)
  else
    Grade.Cells[14,VpaLinha] := '';
  if VprDOrdemCorteItem.ValIndiceMetro <> 0 then
    Grade.Cells[15,VpaLinha] := FormatFloat(varia.MascaraQtd,VprDOrdemCorteItem.ValIndiceMetro)
  else
    Grade.Cells[15,VpaLinha] := '';
  Grade.Cells[16,VpaLinha] := VprDOrdemCorteItem.DesObservacao;
end;

{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  if not ExisteBastidor then
  begin
    VpaValidos := false;
    Aviso('MAQUINA NÃO CADASTRADA!!!!'#13'A maquina digitada não existe cadastrada.');
    Grade.Col := 1;
  end;
end;

{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.GradeSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1: if not ExisteBastidor then
              if not EBastidor.AAbreLocalizacao then
              begin
                Grade.Cells[1,Grade.ALinha]:= '';
                Grade.Col:= 1;
                abort;
              end;
      end;
    end;
end;

{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.EBastidorRetorno(Retorno1,
  Retorno2: String);
begin
  Grade.Cells[1,Grade.ALinha]:= Retorno1;
  Grade.Cells[2,Grade.ALinha]:= Retorno2;
  if Retorno1 <> '' then
  begin
    ExisteBastidor;
  end;
end;

{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.GradeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case Grade.Col of
        1: EBastidor.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDOrdemProducao.OrdemCorte.Itens.Count >0 then
  begin
    VprDOrdemCorteItem := TRBDOrdemCorteItem(VprDOrdemProducao.OrdemCorte.Itens.Items[VpaLinhaAtual - 1]);
  end;
end;

{******************************************************************************}
procedure TFGerarFracaoOPMaquinasCorte.EBastidorSelect(Sender: TObject);
begin
  EBastidor.ASelectLocaliza.Text := 'Select BAS.CODBASTIDOR, BAS.NOMBASTIDOR, ' +
                                  ' MOB.QTDPECAS '+
                                  ' FROM BASTIDOR BAS, MOVKITBASTIDOR MOB '+
                                  ' Where BAS.CODBASTIDOR = MOB.CODBASTIDOR '+
                                  ' AND MOB.SEQPRODUTOKIT = '+IntToStr(VprDOrdemCorteItem.SeqProdutoKit)+
                                  ' AND MOB.SEQCORKIT = '+ IntToStr(VprDOrdemCorteItem.SeqCorKit)+
                                  ' AND MOB.SEQMOVIMENTO = '+IntToStr(VprDOrdemCorteItem.SeqMovimentoKit)+
                                  ' AND BAS.NOMBASTIDOR LIKE ''@%'''; 
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGerarFracaoOPMaquinasCorte]);
end.
