program Backup;

uses
  Forms,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  Constantes in '..\mconfiguracoessistema\Constantes.pas',
  UnImporta in 'UnImporta.pas',
  UnDados in 'UnDados.pas',
  UnAtualizacao in '..\magerais\UnAtualizacao.pas',
  UnSistema in '..\magerais\UnSistema.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
