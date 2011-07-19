unit AGrupos;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: Cadastrar um novo
  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 01/04/199 / Rafael Budag
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela, StdCtrls, Mask,
  DBCtrls, Db, BotaoCadastro, Buttons, DBTables, Componentes1,
  DBKeyViolation, constantes, Localizacao, DBClient;

type
  TFGrupos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DatacadGrupos: TDataSource;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    EConsulta: TLocalizaEdit;
    Label4: TLabel;
    BBAjuda: TBitBtn;
    BFechar: TBitBtn;
    GridIndice1: TGridIndice;
    CadGrupos: TSQL;
    BotaoConsultar1: TBotaoConsultar;
    CadGruposI_EMP_FIL: TFMTBCDField;
    CadGruposI_COD_GRU: TFMTBCDField;
    CadGruposC_NOM_GRU: TWideStringField;
    CadGruposD_ULT_ALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridIndice1Ordem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure EConsultaSelect(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  FGrupos: TFGrupos;

implementation

uses APrincipal, ANovaFilial, ANovoGrupo, funSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGrupos.FormCreate(Sender: TObject);
begin
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGrupos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cadGrupos.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{ *************  Altera a order by da consulta ****************************** }
procedure TFGrupos.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFGrupos.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFGrupos.EConsultaSelect(Sender: TObject);
begin
  EConsulta.ASelect.Text := 'Select * from CADGRUPOS Where C_NOM_GRU like ''@%''';
end;

{******************************************************************************}
procedure TFGrupos.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovoGrupo := TFNovoGrupo.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovoGrupo'));
end;

{******************************************************************************}
procedure TFGrupos.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovoGrupo.ShowModal;
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFGrupos.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovoGrupo.CadGrupos,'Select * from CADGRUPOS '+
                                             ' Where I_COD_GRU = '+CadGruposI_COD_GRU.AsString);
end;


{******************************************************************************}
procedure TFGrupos.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovoGrupo.show;
end;

{******************************************************************************}
procedure TFGrupos.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovoGrupo.close;
  EConsulta.AtualizaConsulta;
end;

Initialization
 RegisterClasses([TFGrupos]);
end.
