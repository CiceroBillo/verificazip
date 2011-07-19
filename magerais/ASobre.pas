unit ASobre;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, formularios, LabelCorMove, Componentes1,
  PainelGradiente, TextoMove, Db, DBTables;

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
    BitBtn1: TBitBtn;
    Bevel3: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    LVersaoBanco: TLabel;
    LVersaoSistema: TLabel;
    Label4: TLabel;
    Aux: TQuery;
    LBancoSistema: TLabel;
    LabelCorMove1: TLabelCorMove;
    Label5: TLabel;
    LNomComputador: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSobre : TFSobre;

implementation
Uses Constantes, APrincipal,FunSql;

{$R *.DFM}

{********************* quando o formulario é criado ***************************}
procedure TFSobre.FormCreate(Sender: TObject);
begin
  LVersaoBanco.Caption := IntToStr(Varia.VersaoBanco);
  LVersaoSistema.Caption := Varia.VersaoSistema;
  AdicionaSQLAbreTabela(Aux,'Select '+ CampoPermissaoModulo + ' from cfg_Geral');
  LBancoSistema.Caption :=  Aux.FieldByName(CampoPermissaoModulo).Asstring;
  LNomComputador.Caption := varia.NomeComputador;
end;

{******************** quando o formulario é fechado ***************************}
procedure TFSobre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************* fecha o formulario *************************************}
procedure TFSobre.BitBtn1Click(Sender: TObject);
begin
  Close;
end;


end.

