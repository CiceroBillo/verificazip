unit UnCrystal;

interface

Uses Classes, Forms, SysUtils,Constantes;

Type
  TRBFuncoesCrystal = class
    private
      procedure ConfiguraAlias;
      procedure InicializaParametros;
    public
//d5      Crystal : tCrpe;
      constructor cria;
      destructor destroy;override;
      procedure ImprimeRelatorioDiretoImpressora(VpaNomImpressora,VpaNomRelatorio : String;VpaParametros : array of String;VpaOrientacaoFolha :TRBDOrientacaoPagina=opretrato);
      procedure ImprimeRelatorioDireto(VpaNomRelatorio : String;VpaParametros :array of string;VpaNomImpressora : String = '';VpaOrientacaoFolha :TRBDOrientacaoPagina=opRetrato);
      procedure ImprimeRelatorio(VpaNomRelatorio : String;VpaParametros : array of String);
      procedure EnviaEmail(VpaNomRelatorio,VpaEmailDestino, VpaAssuntoEmail : String;VpaParametros : array of String);
end;

var
  FunCrystal : TRBFuncoesCrystal;

implementation

Uses ConstMsg, FunString, APrincipal;

{******************************************************************************}
constructor TRBFuncoesCrystal.Cria;
begin
  inherited;
  InicializaParametros;
end;

{******************************************************************************}
destructor TRBFuncoesCrystal.destroy;
begin
//d5  Crystal.free;
  inherited;
end;

{******************************************************************************}
procedure TRBFuncoesCrystal.ConfiguraAlias;
Var
  VpfLaco : Integer;
begin
{d5  Crystal.Connect.Retrieve;
  Crystal.Connect.ServerName := FPrincipal.BaseDados.AliasName+'Rel';
  Crystal.Connect.DatabaseName := FPrincipal.BaseDados.AliasName;
  Crystal.Subreports.Retrieve;

  Crystal.Subreports.Connect.ServerName := FPrincipal.BaseDados.AliasName;
  for VpfLaco := 0 to Crystal.Subreports.Count - 1 do
  begin
    crystal.Subreports[VpfLaco].Connect.ServerName := FPrincipal.BaseDados.AliasName+'Rel';
    crystal.Subreports[VpfLaco].Connect.DatabaseName := FPrincipal.BaseDados.AliasName;
  end;}
end;

{******************************************************************************}
procedure TRBFuncoesCrystal.InicializaParametros;
begin
{d5  Crystal := TCrpe.Create(nil);
  Crystal.DiscardSavedData := true;
  Crystal.WindowState := wsmaximized;
  Crystal.WindowButtonBar.PrintSetupBtn := true;
  Crystal.WindowButtonBar.SearchBtn := true;
  Crystal.Export.FileType := WordForWindows;
  Crystal.Export.Destination := toEmailViaMapi;}
end;

{******************************************************************************}
procedure TRBFuncoesCrystal.ImprimeRelatorioDireto(VpaNomRelatorio : String;VpaParametros :array of string;VpaNomImpressora : String = '';VpaOrientacaoFolha :TRBDOrientacaoPagina=opRetrato);
var
  VpfLaco : Integer;
begin
{d5  Crystal.Clear;
  InicializaParametros;
  Crystal.ReportName := VpaNomRelatorio;
  Crystal.Printer.Retrieve;
  Crystal.Connect.UserID   := 'DBA';
  Crystal.Connect.Password := varia.SenhaBanco;
  ConfiguraAlias;
  Crystal.Subreports.ItemIndex := 0;
  Crystal.ParamFields.Retrieve;

  if (VpaNomImpressora <> '')and (VpaNomImpressora <> 'A') then
    Crystal.Printer.Name := VpaNomImpressora;
  for VpfLaco := 0 to high(VpaParametros) do
  begin
    if (ContaLetra(VpaParametros[VpfLaco],'/') = 2) and (length(VpaParametros[VpfLaco])= 10) then
      Crystal.ParamFields[VpfLaco].AsDate := StrToDate(VpaParametros[VpfLaco])
    else
      Crystal.ParamFields[VpfLaco].Value := VpaParametros[VpfLaco];
  end;
  for VpfLaco := Crystal.ParamFields.Count -1 downto high(VpaParametros) +1 do
    Crystal.ParamFields.Delete(VpfLaco);
  Crystal.Output := toPrinter;
  crystal.execute;}
end;

{******************************************************************************}
procedure TRBFuncoesCrystal.ImprimeRelatorioDiretoImpressora(VpaNomImpressora,VpaNomRelatorio : String;VpaParametros : array of String;VpaOrientacaoFolha :TRBDOrientacaoPagina=opRetrato);
begin
{  if VpaNomImpressora <> 'A' then
  begin
    Crystal.Printer.Name := VpaNomImpressora;
    if VpaOrientacaoFolha = opRetrato then
      Crystal.Printer.Orientation := orPortrait
    else
      Crystal.Printer.Orientation := orLandscape;
//    Crystal.Printer.SetCurrent;
  end;}

  ImprimeRelatorioDireto(VpaNomRelatorio,VpaParametros,VpaNomImpressora);
end;

{******************************************************************************}
procedure TRBFuncoesCrystal.ImprimeRelatorio(VpaNomRelatorio : String;VpaParametros :array of string);
var
  VpfLaco : Integer;
begin
{d5  Crystal.Clear;
  InicializaParametros;
  Crystal.ReportName := VpaNomRelatorio;
  ConfiguraAlias;
  Crystal.Printer.Retrieve;
  Crystal.Connect.UserID   := 'DBA';
  Crystal.Connect.Password := varia.SenhaBanco;
  Crystal.Subreports.ItemIndex := 0;
  Crystal.ParamFields.Retrieve;

  for VpfLaco := 0 to high(VpaParametros) do
  begin
    if (ContaLetra(VpaParametros[VpfLaco],'/') = 2) and (length(VpaParametros[VpfLaco])= 10) then
      Crystal.ParamFields[VpfLaco].AsDate := StrToDate(VpaParametros[VpfLaco])
    else
      Crystal.ParamFields[VpfLaco].Value := VpaParametros[VpfLaco];
  end;
  for VpfLaco := Crystal.ParamFields.Count -1 downto high(VpaParametros) +1 do
  begin
    Crystal.ParamFields.Delete(VpfLaco);
  end;
//  Crystal.Output := toPrinter;
  Crystal.Output := toWindow;
  crystal.execute;}
end;

{******************************************************************************}
procedure TRBFuncoesCrystal.EnviaEmail(VpaNomRelatorio,VpaEmailDestino, VpaAssuntoEmail : String;VpaParametros : array of String);
var
  VpfLaco : Integer;
begin
{d5  if VpaEmailDestino <> '' then
  begin
    Crystal.ReportName := VpaNomRelatorio;
    Crystal.Connect.UserID   := 'DBA';
    Crystal.Connect.Password := varia.SenhaBanco;
    Crystal.ParamFields.Retrieve;
    for VpfLaco := 0 to high(VpaParametros) do
    begin
    if (ContaLetra(VpaParametros[VpfLaco],'/') = 2) and (length(VpaParametros[VpfLaco])= 10) then
      Crystal.ParamFields[VpfLaco].AsDate := StrToDate(VpaParametros[VpfLaco])
    else
      Crystal.ParamFields[VpfLaco].Value := VpaParametros[VpfLaco];
    end;
    for VpfLaco := Crystal.ParamFields.Count -1 downto high(VpaParametros) +1 do
      Crystal.ParamFields.Delete(VpfLaco);

    Crystal.Export.Email.Subject := VpaAssuntoEmail;
    Crystal.Export.Email.ToList := VpaEmailDestino;
    Crystal.Export.Email.BCCList := 'suporte@eficaciaconsultoria.com.br';

    Crystal.Export.FileName := varia.DiretorioTemporarioCrystal +'\'+FormatDateTime('AAAAMMDDHHMMSS',now)+'.html';
    Crystal.Output := toExport;
    crystal.execute;
  end
  else
    Aviso('EMAIL NÃO ENVIADO!!!'#13'Falta o e-mail do destinatario.');}
end;

{******************************************************************************}
initialization
  FunCrystal := TRBFuncoesCrystal.cria;
{******************************************************************************}
finalization
  FunCrystal.free;

end.
