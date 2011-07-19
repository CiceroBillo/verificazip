program Basico;

uses
  Forms,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  AAlterarFilialUso in '..\..\MaGerais\AAlterarFilialUso.pas' {FAlterarFilialUso},
  Abertura in '..\..\MaGerais\Abertura.pas' {FAbertura},
  AAlterarSenha in '..\..\MaGerais\AAlterarSenha.pas' {FAlteraSenha},
  ASobre in '..\..\MaGerais\ASobre.pas' {FSobre},
  Constantes in '..\..\MConfiguracoesSistema\Constantes.pas',
  UnRegistro in '..\UnRegistro.pas';


{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'C:\x\Helphaco.hlp';
  Application.CreateForm(TFPrincipal, FPrincipal);
  FAbertura := TFAbertura.create(application);
  FAbertura.ShowModal;
  if Varia.StatusAbertura = 'CANCELADO' then
    FPrincipal.close
  else
    Application.Run;
end.
