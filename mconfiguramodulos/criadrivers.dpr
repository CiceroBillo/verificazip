program CriaDrivers;

uses
  Forms,
  ACriaDriversImpressora in 'ACriaDriversImpressora.pas' {FCriaDrivers};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFCriaDrivers, FCriaDrivers);
  Application.Run
end.
