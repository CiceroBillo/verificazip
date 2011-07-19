unit ASobre;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, formularios, LabelCorMove, Componentes1,
  PainelGradiente, TextoMove;

type
  TFSobre = class(TFormularioPermissao)
    CorPainelGra1: TCorPainelGra;
    CorPainelGra2: TCorPainelGra;
    PainelGradiente1: TPainelGradiente;
    ProgramIcon: TImage;
    Label3D2: TLabel3D;
    Label3D1: TLabel3D;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label3D3: TLabel3D;
    PanelColor1: TPanelColor;
    BitBtn1: TBitBtn;
    TextoMove1: TTextoMove;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TextoMove1AOnFimMove(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSobre : TFSobre;

implementation

{$R *.DFM}

procedure TFSobre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action := cafree;
end;






procedure TFSobre.BitBtn1Click(Sender: TObject);
begin
Close;
end;



procedure TFSobre.FormShow(Sender: TObject);
begin
textoMove1.Ativa;
end;

procedure TFSobre.TextoMove1AOnFimMove(Sender: TObject);
begin
textoMove1.Ativa;
end;

end.
 
