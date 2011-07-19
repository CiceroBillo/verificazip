program Modulos;

uses
  Forms,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  AconfiguraModulos in 'AconfiguraModulos.pas' {FConfiguracoesModulos},
  UnRegistro in 'UnRegistro.pas',
  Constantes in '..\MConfiguracoesSistema\Constantes.pas',
  AGeraNumero in 'AGeraNumero.pas' {FGeraNumero},
  AAbertura in 'AAbertura.pas' {FAbertura},
  AConfigRelatorios in 'AConfigRelatorios.pas' {FConfigRelatorios},
  UnSistema in '..\magerais\UnSistema.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFAbertura, FAbertura);
  FAbertura.ShowModal;
  if FAbertura.VplCancelado Then
    FPrincipal.close
  else
    Application.Run;
end.
