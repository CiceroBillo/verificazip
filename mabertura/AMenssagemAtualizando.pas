unit AMenssagemAtualizando;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, PainelGradiente, ExtCtrls, StdCtrls;

type
  TFMensagemAtualizando = class(TForm)
    Panel1: TPanel;
    Animate1: TAnimate;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMensagemAtualizando: TFMensagemAtualizando;

implementation

{$R *.DFM}

end.
