program EditorTexto;

uses
  Forms,
  AEditor in 'AEditor.pas' {FEditor},
  APagina in 'APagina.pas' {FPagina};

{$R *.RES}
 var
   laco : integer;
   Texto : string;

begin
  Application.CreateForm(TFEditor, FEditor);
  if ParamCount >= 1 then
  begin
    texto := '';
    for laco := 1 to ParamCount do
      texto := texto + ParamStr(laco)+ ' ';

    FPagina := TFPagina.Create(FEditor);
    FPagina.AbrirArquivo(texto);
  end;
  Application.Run;
end.
