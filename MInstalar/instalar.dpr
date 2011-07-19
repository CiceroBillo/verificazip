program Instalar;

uses
  Forms,
  AInstalar in 'AInstalar.pas' {FInicializa};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFInicializa, FInicializa);
  FInicializa.Timer1.Interval := 100;
  Application.Run;
end.
