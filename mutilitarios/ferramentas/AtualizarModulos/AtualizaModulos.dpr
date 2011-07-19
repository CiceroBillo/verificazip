program AtualizaModulos;

uses
  Forms,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  AAtualiza in 'AAtualiza.pas' {FAtualiza};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'AtualizaModulos';
  Application.CreateForm(TFPrincipal, FPrincipal);
  if FPrincipal.AbreBaseDados(ParamStr(1)) then  // caso naum abra a base de dados
    Application.Run
  else
    FPrincipal.Close;
end.
