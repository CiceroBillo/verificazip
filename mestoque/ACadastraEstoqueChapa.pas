unit ACadastraEstoqueChapa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, PainelGradiente, ExtCtrls,
  Componentes1, StdCtrls, Buttons, Grids, CGrades, UnDadosProduto;

type
  TFCadastraEstoqueChapa = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    LProduto: TLabel;
    EProduto: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EProdutoExit(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeEnter(Sender: TObject);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprSeqProduto,
    VprUltimoSeqChapa : Integer;
    VprChapas : TList;
    VprDChapa : TRBDEstoqueChapa;
    function ExisteProduto : Boolean;
    function LocalizaProduto : Boolean;
    procedure CarTitulosGrade;
    procedure CarDChapaClasse;
  public
    { Public declarations }
    function CadastraEstoqueChapa : Boolean;
  end;

var
  FCadastraEstoqueChapa: TFCadastraEstoqueChapa;

implementation

uses APrincipal, UnProdutos, ALocalizaProdutos, funObjeto, Constmsg, Funstring, Constantes;

{$R *.DFM}


{ **************************************************************************** }
procedure TFCadastraEstoqueChapa.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTitulosGrade;
  VprChapas := TList.Create;
  Grade.ADados := VprChapas;
  Grade.CarregaGrade;
end;

procedure TFCadastraEstoqueChapa.GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDChapa := TRBDEStoqueChapa(VprChapas.Items[VpaLinha-1]);
  if VprDChapa.SeqChapa <> 0 then
    Grade.Cells[1,VpaLinha] := IntToStr(VprDChapa.SeqChapa)
  else
    Grade.Cells[1,VpaLinha] := '';
  if VprDChapa.LarChapa <> 0 then
    Grade.Cells[2,VpaLinha] := FormatFloat('#,###,##0.00',VprDChapa.LarChapa)
  else
    Grade.Cells[2,VpaLinha] := '';
  if VprDChapa.ComChapa <> 0 then
    Grade.Cells[3,VpaLinha] := FormatFloat('#,###,##0.00',VprDChapa.ComChapa)
  else
    Grade.Cells[3,VpaLinha] := '';
  if VprDChapa.PerChapa <> 0 then
    Grade.Cells[4,VpaLinha] := FormatFloat('##0.00',VprDChapa.PerChapa)
  else
    Grade.Cells[4,VpaLinha] := '';
  if VprDChapa.PesChapa <> 0 then
    Grade.Cells[5,VpaLinha] := FormatFloat('#,###,##0.000',VprDChapa.PesChapa)
  else
    Grade.Cells[5,VpaLinha] := '';
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
var
  VpfREsultado : string;
begin
  VpaValidos := true;
  if (Grade.Cells[1,Grade.ALinha] = '') then
  begin
    VpaValidos := false;
    aviso('ID CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher o ID da chapa.');
    Grade.Col := 1;
  end
  else
    if (Grade.Cells[2,Grade.ALinha] = '') then
    begin
      VpaValidos := false;
      aviso('LARGURA CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher a largura da chapa.');
      Grade.Col := 2;
    end
    else
      if (Grade.Cells[3,Grade.ALinha] = '') then
      begin
        VpaValidos := false;
        aviso('COMPRIMENTO CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher o comprimento da chapa.');
        Grade.Col := 3;
      end
      else
        if (Grade.Cells[4,Grade.ALinha] = '') then
        begin
          VpaValidos := false;
          aviso('PERCENTUAL CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher o percentual da chapa.');
          Grade.Col := 4;
        end
        else
          if (Grade.Cells[5,Grade.ALinha] = '') then
          begin
            VpaValidos := false;
            aviso('PESO CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher o peso da chapa.');
            Grade.Col := 5;
          end;
  if VpaValidos then
  begin
    CarDChapaClasse;
    if VprDChapa.SeqChapa = 0  then
    begin
      VpaValidos := false;
      aviso('ID CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher o ID da chapa.');
      Grade.Col := 1;
    end
    else
      if (VprDChapa.LarChapa = 0) then
      begin
        VpaValidos := false;
        aviso('LARGURA CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher a largura da chapa.');
        Grade.Col := 2;
      end
      else
        if (VprDChapa.ComChapa = 0) then
        begin
          VpaValidos := false;
          aviso('COMPRIMENTO CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher o comprimento da chapa.');
          Grade.Col := 3;
        end
        else
          if (VprDChapa.PerChapa = 0) then
          begin
            VpaValidos := false;
            aviso('PERCENTUAL CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher o percentual da chapa.');
            Grade.Col := 4;
          end
          else
            if (VprDChapa.PesChapa = 0) then
            begin
              VpaValidos := false;
              aviso('PESO CHAPA NÃO PREENCHIDO!!!'#13'É necessário preencher o peso da chapa.');
              Grade.Col := 5;
            end;
  end;
  if VpaValidos then
  begin
    if FunProdutos.ExisteSeqChapaDuplicadoClasse(VprChapas) then
    begin
      aviso('ID CHAPA DUPLICADO!!!'#13'Não é permitido digitar duas chapas com o mesmo ID');
      VpaValidos := false;
    end;
    if  VpaValidos then
    begin
      VpfREsultado := FunProdutos.ExisteSeqChapaDuplicado(VprSeqProduto,VprDChapa.SeqChapa);
      if VpfREsultado <> '' then
      begin
        aviso(VpfREsultado);
        VpaValidos := false;
      end;
    end;
  end;
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.GradeEnter(Sender: TObject);
begin
  if VprSeqProduto = 0 then
  begin
    aviso('PRODUTO NÃO PREENCHIDO!!!'#13'É necessário preencher o codigo do produto.');
    EProduto.SetFocus;
  end;
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.GradeGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
begin
  case ACol of
    1 :  Value := '0000000;0; ';
  end;
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = '.') and  not(Grade.col in [1]) then
    key := DecimalSeparator;
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.GradeMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprChapas.Count >0 then
  begin
    VprDChapa := TRBDEStoqueChapa(VprChapas.Items[VpaLinhaAtual-1]);
  end;
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.GradeNovaLinha(Sender: TObject);
begin
  VprDChapa := TRBDEStoqueChapa.cria;
  VprChapas.Add(VprDChapa);
  VprDChapa.PerChapa := 100;
  VprDChapa.SeqChapa := VprUltimoSeqChapa;
  inc(VprUltimoSeqChapa);
  VprDChapa.Codfilial := varia.CodigoEmpFil;
  VprDChapa.CodCor := 0;
  VprDChapa.CodTamanho := 0;
  VprDChapa.SeqNotafornecedor := 0;
end;

{ *************************************************************************** }
function TFCadastraEstoqueChapa.LocalizaProduto: Boolean;
var
  VpfCodProduto, VpfNomProduto, VpfUM, VpfClaFiscal : String;
begin
  FlocalizaProduto := TFlocalizaProduto.CriarSDI(self,'',true);
  result := FlocalizaProduto.LocalizaProduto(VprSeqProduto,VpfCodProduto,VpfNomProduto,VpfUM, VpfClaFiscal);
  FlocalizaProduto.Free;
  if result then
  begin
    EProduto.Text := VpfCodProduto;
    LProduto.Caption := VpfNomProduto;
    FunProdutos.CarDEstoqueChapa(VprSeqProduto,VprChapas);
    Grade.CarregaGrade;
    VprUltimoSeqChapa := FunProdutos.RSeqChapaDisponivel;
  end;
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.SpeedButton2Click(Sender: TObject);
begin
  LocalizaProduto;
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.BCancelarClick(Sender: TObject);
begin
  close;
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.BGravarClick(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfResultado := FunProdutos.GravaDEstoqueChapa(VprSeqProduto,VprChapas);
  if VpfResultado = '' then
  begin
    VprAcao := true;
    Close;
  end
  else
    aviso(VpfResultado);
end;

{ *************************************************************************** }
function TFCadastraEstoqueChapa.CadastraEstoqueChapa: Boolean;
begin
  Showmodal;
  Result := Vpracao;
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.CarDChapaClasse;
begin
  VprDChapa.SeqChapa := StrToInt(Grade.Cells[1,Grade.Alinha]);
  VprDChapa.LarChapa := StrToFloat(DeletaChars(Grade.Cells[2,Grade.ALinha],'.'));
  VprDChapa.ComChapa := StrToFloat(DeletaChars(Grade.Cells[3,Grade.ALinha],'.'));
  VprDChapa.PerChapa := StrToFloat(DeletaChars(Grade.Cells[4,Grade.ALinha],'.'));
  VprDChapa.PesChapa := StrToFloat(DeletaChars(Grade.Cells[5,Grade.ALinha],'.'));
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'ID Chapa';
  Grade.Cells[2,0] := 'Largura';
  Grade.Cells[3,0] := 'Comprimento';
  Grade.Cells[4,0] := 'Percentual';
  Grade.Cells[5,0] := 'Peso';
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.EProdutoExit(Sender: TObject);
begin
  ExisteProduto;
end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.EProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key  of
    VK_F3 : LocalizaProduto;
  end;
end;

{ *************************************************************************** }
function TFCadastraEstoqueChapa.ExisteProduto: Boolean;
var
  VpfNomProduto, VpfUM : string;
begin
  result := true;
  if EProduto.Text <> '' then
  begin
    result := FunProdutos.ExisteProduto(EProduto.Text,VprSeqProduto,VpfNomProduto,VpfUM);
    if result then
      LProduto.Caption := VpfNomProduto
    else
      result := LocalizaProduto;
  end;
  if not result  then
  begin
    EProduto.Clear;
    LProduto.Caption := '';
  end
  else
  begin
    FunProdutos.CarDEstoqueChapa(VprSeqProduto,VprChapas);
    Grade.CarregaGrade;
    VprUltimoSeqChapa := FunProdutos.RSeqChapaDisponivel;
  end;

end;

{ *************************************************************************** }
procedure TFCadastraEstoqueChapa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprChapas);
  VprChapas.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCadastraEstoqueChapa]);
end.
