unit AAlteracao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, numericos, Db, DBTables, Registry;

type
  TFAtualizacao = class(TForm)
    BitBtn2: TBitBtn;
    BaseDados: TDatabase;
    aux: TQuery;
    GroupBox2: TGroupBox;
    BitBtn3: TBitBtn;
    Edit1: TEdit;
    Label2: TLabel;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  FAtualizacao: TFAtualizacao;

implementation

  uses constmsg, fundata, UnAtualizacao;

{$R *.DFM}

procedure TFAtualizacao.BitBtn3Click(Sender: TObject);
Var
  Atualizacao : TAtualiza;
begin
  if (Edit1.Text <> '' ) then
  begin
    BaseDados.AliasName :=  Edit1.Text;
    BaseDados.Connected := true;
    if BaseDados.Connected then
    begin
      Atualizacao := TAtualiza.Criar(self, self.BaseDados);
      Atualizacao.AtualizaBanco;
      Atualizacao.Free;
    end;
    BaseDados.Connected := false;
 end;
end;

procedure TFAtualizacao.BitBtn2Click(Sender: TObject);
begin
self.close;
end;

end.
