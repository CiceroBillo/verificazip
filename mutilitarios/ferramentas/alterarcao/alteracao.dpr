program Alteracao;

uses
  Forms,
  AAlteracao in 'AAlteracao.pas' {FAtualizacao},
  UnAtualizacao in 'UnAtualizacao.pas',
  Constantes in '..\..\..\mconfiguracoessistema\Constantes.pas',
  UnSistema in '..\..\..\magerais\UnSistema.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFAtualizacao, FAtualizacao);
  Application.Run;
end.
