unit AAbertura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, StdCtrls, Componentes1, LabelCorMove;

type
  TFAbertura = class(TFormularioPermissao)
    Image1: TImage;
    Label3D1: TLabel3D;
    ESerie: TEditColor;
    Label3D2: TLabel3D;
    ESenha: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprTentativas : Integer;
    function RetornaSerie : String;
    function ValidaSenha : Boolean;
    function RetornaSenha(VpaSerie : String) :String;
  public
    { Public declarations }
    VplCancelado : Boolean;
  end;

var
  FAbertura: TFAbertura;

implementation
{$R *.DFM}

Uses FunValida, FunHardware, ConstMsg, FunString,FunData;


{ ****************** Na criação do Formulário ******************************** }
procedure TFAbertura.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Brush.Style:=bsClear;
  BorderStyle:=bsNone;

  VplCancelado := True;
  VprTentativas := 0;
  ESerie.Text := RetornaSerie;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAbertura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************* rentorna o numero de serie *******************************}
function TFAbertura.RetornaSerie : String;
var
  VprDataBios,
  VprData, VprHora : String;
begin
  VprData := FormatDateTime('DD/MM/YYYY',(Date));
  VprHora := FormatDateTime('hh:mm:ss',Time);

  VprDataBios  := DataBios;
  Result :=  Copy(VprData,1,1)+ Copy(VprDataBios,2,1)+ Copy(VprHora,7,1)+
                Copy(VprData,2,1)+ Copy(VprHora,8,1)+ Copy(VprHora,4,1)+Copy(VprHora,5,1);
end;

{************************ valida a senha **************************************}
function TFAbertura.ValidaSenha : Boolean;
var
  VpfStringAux : String;
begin
  VpfStringAux := RetornaSenha(ESerie.Text);
  if ESenha.Text = VpfStringAux Then
    result := true
  else
  begin
    Result := false;
    inc(VprTentativas);
    erro('Senha Inválida....');
  end;
  if Vprtentativas >= 3 Then
    Close;
end;

{************ retorna a senha da serie passada como parametro *****************}
function TFAbertura.RetornaSenha(VpaSerie : String) :String;
begin
  result := IntTostr(StrToInt(copy(VpaSerie,length(VpaSerie),1))+1)+ IntTostr(StrToInt(copy(VpaSerie,1,1))+1)+
            AdicionaCharE('0',IntToStr(Mes(Date)),2) +
            IntTostr(StrToInt(copy(VpaSerie,length(VpaSerie)-1,1))+2)+ IntTostr(StrToInt(copy(VpaSerie,2,1))+2) ;
end;


{******************** verifica as teclas pressionadas *************************}
procedure TFAbertura.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case key of
    27 : Close;
    13 : if ValidaSenha then
         begin
           VplCancelado := false;
           close;
         end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAbertura]);
end.
