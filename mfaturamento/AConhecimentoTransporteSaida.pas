unit AConhecimentoTransporteSaida;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, UnDados, Grids,
  CGrades, ConstMsg, Constantes, FunData, FunString, Localizacao, DBGrids, UnDadosProduto, UnNotasFiscaisFor,
  UnDadosLocaliza, FunObjeto;

type
  TRBDColunaGrade =(clNumNota,clNumSerieNota,clCodTransportadora,clNomTransportadora,clCodModelo,clNomModelo,clNumConhecimento,clDatConhecimento,clValConhecimento,clValBaseIcms,clValIcms,clValNaoTributado,clPesoFrete);

  TFConhecimentoTransporteSaida = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Panel1: TPanelColor;
    BFechar: TBitBtn;
    BGravar: TBitBtn;
    BCancela: TBitBtn;
    Grade: TRBStringGridColor;
    Lmodelo: TLabel;
    ETransportadora: TRBEditLocaliza;
    ETipoDocumentoFiscal: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelaClick(Sender: TObject);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GradeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BGravarClick(Sender: TObject);
    procedure ETransportadoraRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ETipoDocumentoFiscalRetorno(VpaColunas: TRBColunasLocaliza);
  private
    { Private declarations }
    VprDConhecimentoTransporte: TRBDConhecimentoTransporte;
    VprDNota: TRBDNotaFiscal;
    FunNotaFor : TFuncoesNFFor;
    VprConhecimento: TList;
    function RColunaGrade(VpaColuna : TRBDColunaGrade):Integer;
    function ExisteNota: Boolean;
    function ExisteSerieNota: Boolean;
    function ExisteTransportadora: Boolean;
    function ExisteModelo: Boolean;
    procedure CarTitulosGrade;
    procedure CarDClasse;
  public
    { Public declarations }
    procedure NovoConhecimento;
  end;

var
  FConhecimentoTransporteSaida: TFConhecimentoTransporteSaida;

implementation

uses APrincipal, UnNotaFiscal, UnClientes;

{$R *.DFM}


{ **************************************************************************** }
procedure TFConhecimentoTransporteSaida.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualiza��o de menus }
  CarTitulosGrade;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.GradeDadosValidos(Sender: TObject;
 var VpaValidos: Boolean);
begin
 VpaValidos:= True;
 if Grade.Cells[RColunaGrade(clNumNota),Grade.ALinha] = '' then
 begin
   VpaValidos:= False;
   Grade.Col:= RColunaGrade(clNumNota);
   aviso('NUMERO NOTA NAO PREENCHIDO!!!'#13'� necess�rio preencher um numero de nota fiscal.');
 end
 else
 if Grade.Cells[RColunaGrade(clNumSerieNota),Grade.ALinha] = '' then
 begin
   VpaValidos:= False;
   Grade.Col:= RColunaGrade(clNumSerieNota);
   aviso('NUMERO SERIE NAO PREENCHIDO!!!'#13'� necess�rio preencher um numero de serie.');
 end
 else
 if Grade.Cells[RColunaGrade(clCodTransportadora),Grade.ALinha] = '' then
 begin
   VpaValidos:= False;
   Grade.Col:= RColunaGrade(clCodTransportadora);
   aviso('TRANSPORTADORA NAO PREENCHIDA!!!'#13'� necess�rio preencher uma transportadora.');
 end;
 if VpaValidos then
   CarDClasse;
   if VprDConhecimentoTransporte.DatConhecimento <= MontaData(1,1,1900) then
   begin
     aviso('DATA CONHECIMENTO INV�LIDA!!!'#13'A data do conhecimento preenchida � inv�lida.');
     Vpavalidos := false;
     Grade.Col := RColunaGrade(clDatConhecimento);
   end
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  if RColunaGrade(clDatConhecimento) = ACol then
    Value := FPrincipal.CorFoco.AMascaraData;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.GradeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    114: if RColunaGrade(clCodTransportadora) = Grade.AColuna then
           ETransportadora.AAbreLocalizacao
         else
            if RColunaGrade(clCodModelo) = Grade.AColuna then
              ETipoDocumentoFiscal.AAbreLocalizacao;
         end;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.GradeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (RColunaGrade(clValConhecimento) = Grade.AColuna) or (RColunaGrade(clValBaseIcms) = Grade.AColuna) or
    (RColunaGrade(clValIcms) = Grade.AColuna)  or  (RColunaGrade(clValNaoTributado) = Grade.AColuna)  or
    (RColunaGrade(clPesoFrete) = Grade.AColuna) then
  begin
    if Key in [',','.'] then
      Key:= DecimalSeparator;
  end;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprConhecimento.Count > 0 then
    VprDConhecimentoTransporte := TRBDConhecimentoTransporte(VprConhecimento.Items[VpaLinhaAtual-1]);
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.GradeNovaLinha(Sender: TObject);
begin
  VprDConhecimentoTransporte := TRBDConhecimentoTransporte.cria;
  VprConhecimento.Add(VprDConhecimentoTransporte);
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao, egEdicao] then
  begin
    if Grade.AColuna <> ACol then
    begin
      if RColunaGrade(clNumNota) = Grade.AColuna then
      begin
         if not ExisteNota then
          begin
             Aviso('C�DIGO DA NOTA FISCAL INVALIDA !!!'#13'� necess�rio informar o numero da nota fiscal.');
             Grade.Col:= RColunaGrade(clNumNota);
          end;
      end
      else
        if RColunaGrade(clCodTransportadora) = Grade.AColuna then
          begin
            if not ExisteTransportadora then
            begin
               if not ETransportadora.AAbreLocalizacao then
               begin
                 Aviso('C�DIGO DA TRANSPORTADORA INVALIDO !!!'#13'� necess�rio informar o c�digo da transportadora.');
                 Grade.Col:= RColunaGrade(clCodTransportadora);
               end;
            end;
          end
          else
            if RColunaGrade(clCodModelo) = Grade.AColuna then
            begin
              if not ExisteModelo then
              begin
                if not ETipoDocumentoFiscal.AAbreLocalizacao then
                begin
                  Aviso('C�DIGO DO MODELO INVALIDO !!!'#13'� necess�rio informar o c�digo do modelo.');
                  Grade.Col:= RColunaGrade(clCodModelo);
               end;
              end;
            end
            else
              if RColunaGrade(clNumConhecimento) = Grade.AColuna then
              begin
                if Grade.Cells[RColunaGrade(clNumConhecimento), Grade.ALinha] = '' then
                begin
                  Aviso('N�MERO DO CONHECIMENTO N�O PREENCHIDO !!!'#13'� necess�rio informar o n�mero do conhecimento.');
                  Grade.Col:= RColunaGrade(clNumConhecimento);
                end;
              end
              else
                if RColunaGrade(clNumSerieNota) = Grade.AColuna then
                begin
                  if Grade.Cells[RColunaGrade(clNumSerieNota), Grade.ALinha] = '' then
                  begin
                    Aviso('N�MERO DE S�RIE N�O PREENCHIDO !!!'#13'� necess�rio informar o n�mero da s�rie.');
                    Grade.Col:= RColunaGrade(clNumSerieNota);
                  end
                  else
                  begin
                    if not ExisteSerieNota then
                    begin
                      Aviso('S�RIE DA NOTA FISCAL INVALIDA !!!'#13'� necess�rio informar o  n�mero da s�rie.');
                      Grade.Col:= RColunaGrade(clNumSerieNota);
                    end;
                  end;
                end;
          end;
  end;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.NovoConhecimento;
begin
  FunNotaFor := TFuncoesNFFor.criar(self,FPrincipal.BaseDados);
  VprDNota:= TRBDNotaFiscal.cria;
  VprConhecimento:= TList.Create;
  VprDConhecimentoTransporte:= TRBDConhecimentoTransporte.Cria;
  Grade.ADados:= VprConhecimento;
  Grade.CarregaGrade;
  ShowModal;
end;

{ *************************************************************************** }
function TFConhecimentoTransporteSaida.RColunaGrade(VpaColuna: TRBDColunaGrade): Integer;
begin
  case VpaColuna of
    clNumNota: result:= 1 ;
    clNumSerieNota: result:= 2;
    clCodTransportadora: result:= 3;
    clNomTransportadora: result:= 4;
    clCodModelo: result:= 5;
    clNomModelo: result:= 6;
    clNumConhecimento: result:= 7;
    clDatConhecimento: result:= 8;
    clValConhecimento: result:= 9;
    clValBaseIcms: result:= 10;
    clValIcms: result:= 11;
    clValNaoTributado: result:= 12;
    clPesoFrete: result:= 13;
  end;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.BCancelaClick(Sender: TObject);
begin
  close;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFConhecimentoTransporteSaida.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= FunNotaFor.GravaDConhecimentoTransporteNotaSaida(VprConhecimento);
  if VpfResultado <> '' then
    aviso(VpfResultado);
  Close;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.CarDClasse;
begin
  VprDConhecimentoTransporte.NumNota:= StrToInt(Grade.Cells[RColunaGrade(clNumNota),Grade.ALinha]);
  VprDConhecimentoTransporte.NumSerieNota:= Grade.Cells[RColunaGrade(clNumSerieNota),Grade.ALinha];
  VprDConhecimentoTransporte.CodTransportadora:= StrToInt(Grade.Cells[RColunaGrade(clCodTransportadora),Grade.ALinha]);
  VprDConhecimentoTransporte.CodFilial:= Varia.CodigoEmpFil;
  VprDConhecimentoTransporte.CodModeloDocumento:= Grade.Cells[RColunaGrade(clCodModelo),Grade.ALinha];
  try
    VprDConhecimentoTransporte.DatConhecimento := StrToDate(Grade.Cells[RColunaGrade(clDatConhecimento),Grade.ALinha])
  except
    VprDConhecimentoTransporte.DatConhecimento :=  MontaData(1,1,1900);
  end;

  VprDConhecimentoTransporte.NumTipoConhecimento:= 1;

  if Grade.Cells[RColunaGrade(clValConhecimento),Grade.ALinha] <> '' then
    VprDConhecimentoTransporte.ValConhecimento:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValConhecimento),Grade.ALinha],'.'))
  else
    VprDConhecimentoTransporte.ValConhecimento:= 0;

  if Grade.Cells[RColunaGrade(clValBaseIcms),Grade.ALinha] <> '' then
    VprDConhecimentoTransporte.ValorBaseIcms:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValBaseIcms),Grade.ALinha],'.'))
  else
    VprDConhecimentoTransporte.ValorBaseIcms:= 0;

  if Grade.Cells[RColunaGrade(clValIcms),Grade.ALinha] <> '' then
    VprDConhecimentoTransporte.ValorIcms:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValIcms),Grade.ALinha],'.'))
  else
    VprDConhecimentoTransporte.ValorIcms:= 0;

  if Grade.Cells[RColunaGrade(clValNaoTributado),Grade.ALinha] <> '' then
    VprDConhecimentoTransporte.ValorNaoTributado:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValNaoTributado),Grade.ALinha],'.'))
  else
    VprDConhecimentoTransporte.ValorNaoTributado:= 0;

   if Grade.Cells[RColunaGrade(clPesoFrete),Grade.ALinha] <> '' then
    VprDConhecimentoTransporte.PesoFrete:= StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clPesoFrete),Grade.ALinha],'.'))
  else
    VprDConhecimentoTransporte.PesoFrete:= 0;

  VprDConhecimentoTransporte.NumConhecimento:= StrToInt(Grade.Cells[RColunaGrade(clNumConhecimento),Grade.ALinha]);
  VprDConhecimentoTransporte.SeqNotaSaida:= FunNotaFiscal.RSeqNota(VprDConhecimentoTransporte.NumNota, VprDConhecimentoTransporte.CodFilial, VprDConhecimentoTransporte.NumSerieNota);
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.CarTitulosGrade;
begin
  grade.Cells[RColunaGrade(clNumNota),0] := 'Numero Nota';
  grade.Cells[RColunaGrade(clNumSerieNota),0] := 'Serie Nota';
  grade.Cells[RColunaGrade(clCodTransportadora),0] := 'Cod. Transportadora';
  grade.Cells[RColunaGrade(clNomTransportadora),0] := 'Transportadora';
  grade.Cells[RColunaGrade(clCodModelo),0] := 'Cod. Modelo';
  grade.Cells[RColunaGrade(clNomModelo),0] := 'Modelo';
  grade.Cells[RColunaGrade(clNumConhecimento),0] := 'Numero Conhecimento';
  grade.Cells[RColunaGrade(clDatConhecimento),0] := 'Data Conhecimento';
  grade.Cells[RColunaGrade(clValConhecimento),0] := 'Valor Conhecimento';
  grade.Cells[RColunaGrade(clValBaseIcms),0] := 'Valor Base ICMS';
  grade.Cells[RColunaGrade(clValIcms),0] := 'Valor ICMS';
  grade.Cells[RColunaGrade(clValNaoTributado),0] := 'Valor Nao Tributado';
  grade.Cells[RColunaGrade(clPesoFrete),0] := 'Peso Frete';
end;

{ ***************************************************************************}
procedure TFConhecimentoTransporteSaida.ETipoDocumentoFiscalRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas[0].AValorRetorno <> '' then
  begin
    Grade.Cells[RColunaGrade(clNomModelo), Grade.ALinha]:= VpaColunas[1].AValorRetorno;
    Grade.Cells[RColunaGrade(clCodModelo), Grade.ALinha]:= ETipoDocumentoFiscal.Text;
  end
  else
    Grade.Cells[RColunaGrade(clNomModelo), Grade.ALinha]:= '';
end;

{ ***************************************************************************}
procedure TFConhecimentoTransporteSaida.ETransportadoraRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas[0].AValorRetorno <> '' then
  begin
    Grade.Cells[RColunaGrade(clNomTransportadora), Grade.ALinha]:= VpaColunas[1].AValorRetorno;
    Grade.Cells[RColunaGrade(clCodTransportadora), Grade.ALinha]:= ETransportadora.Text;
  end
  else
    Grade.Cells[RColunaGrade(clNomTransportadora), Grade.ALinha]:= '';
end;

{ ***************************************************************************
procedure TFConhecimentoTransporteSaida.ETransportadoraRetorno(Retorno1,
  Retorno2: string);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[RColunaGrade(clNomTransportadora), Grade.ALinha]:= Retorno1;
    Grade.Cells[RColunaGrade(clCodTransportadora), Grade.ALinha]:= ETransportadora.Text;
  end
  else
    Grade.Cells[RColunaGrade(clNomTransportadora), Grade.ALinha]:= '';
end;

{ *************************************************************************** }
function TFConhecimentoTransporteSaida.ExisteModelo: Boolean;
begin
  Result:= False;
  if Grade.Cells[RColunaGrade(clCodModelo),Grade.ALinha] <> '' then
  begin
    Result:= FunNotaFiscal.ExisteModelo(Grade.Cells[RColunaGrade(clCodModelo),Grade.ALinha]);
    if Result then
    begin
      ETipoDocumentoFiscal.Text:= Grade.Cells[RColunaGrade(clCodModelo),Grade.ALinha];
      ETipoDocumentoFiscal.Atualiza;
    end;
  end;
end;

{ *************************************************************************** }
function TFConhecimentoTransporteSaida.ExisteNota: Boolean;
begin
  Result:= False;
  if Grade.Cells[RColunaGrade(clNumNota),Grade.ALinha] <> '' then
  begin
    Result:= FunNotaFiscal.ExisteNota(StrToInt(Grade.Cells[RColunaGrade(clNumNota),Grade.ALinha]));
  end;
end;

{ *************************************************************************** }
function TFConhecimentoTransporteSaida.ExisteSerieNota: Boolean;
begin
  Result:= False;
  if Grade.Cells[RColunaGrade(clNumSerieNota),Grade.ALinha] <> '' then
  begin
    Result:= FunNotaFiscal.ExisteSerieNota(StrToInt(Grade.Cells[RColunaGrade(clNumNota),Grade.ALinha]), Grade.Cells[RColunaGrade(clNumSerieNota),Grade.ALinha]);
  end;
end;

{ *************************************************************************** }
function TFConhecimentoTransporteSaida.ExisteTransportadora: Boolean;
begin
  Result:= False;
  if Grade.Cells[RColunaGrade(clCodTransportadora),Grade.ALinha] <> '' then
  begin
    Result:= FunClientes.ExisteTransportadora(StrToInt(Grade.Cells[RColunaGrade(clCodTransportadora),Grade.ALinha]));
    if Result then
    begin
      ETransportadora.Text:= Grade.Cells[RColunaGrade(clCodTransportadora),Grade.ALinha];
      ETransportadora.Atualiza;
    end;
  end;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteSaida.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualiza��o de menus }
  FunNotaFor.Free;
  VprDNota.free;
  FreeTObjectsList(VprConhecimento);
  VprConhecimento.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            A��es Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConhecimentoTransporteSaida]);
end.
