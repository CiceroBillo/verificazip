unit AInstalar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, shellapi,
  StdCtrls, jpeg, ExtCtrls, LabelCorMove, ComCtrls, MPlayer, Componentes1,
  PainelGradiente, Registry;

const
ct_largura = 602;//433;
ct_altura = 346;//280;
ct_raio = 39;

type
  TFInicializa = class(TForm)
    sig: TImage;
    Bola3: TImage;
    Bola2: TImage;
    Bola1: TImage;
    Abaixo: TMediaPlayer;
    Acima: TMediaPlayer;
    Panel1: TPainelGradiente;
    Image4: TImage;
    LBola4: TLabel;
    Panel2: TPainelGradiente;
    Image10: TImage;
    LBola10: TLabel;
    Image7: TImage;
    Texto: TLabel;
    Image1: TImage;
    CorPainelGra1: TCorPainelGra;
    CorPainelGra2: TCorPainelGra;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    TConLogoListeners: TTimer;
    TListeners: TTimer;
    TControlaROI: TTimer;
    Roi: TTimer;
    TRoi: TTimer;
    Image2: TImage;
    LBola2: TLabel;
    Label3: TLabel;
    Image5: TImage;
    LBola5: TLabel;
    Image6: TImage;
    LBola6: TLabel;
    LBola6_1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LBola10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LBola10MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sigMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Lbola12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure TConLogoListenersTimer(Sender: TObject);
    procedure TListenersTimer(Sender: TObject);
    procedure TControlaROITimer(Sender: TObject);
    procedure RoiTimer(Sender: TObject);
    procedure TRoiTimer(Sender: TObject);
  private
     lista : TstringList;
     pontos : array[0..ct_largura,0..ct_altura] of integer;
     pontossig : array[0..ct_largura,0..ct_altura] of integer;
     ativosom : boolean;
     MudaDesenho, IgnoraMove : boolean;
     posicao : integer;
     Ini : TRegIniFile;
     VprLaco,
     VprAltura,
     VprLargura : Integer;
     VprDesenhando : Boolean;
     procedure CarregaPontos;
     procedure DesenhaROI;
     procedure ExecutaApresentacao;
     procedure CopiaSons;
  public
  end;

var
  FInicializa: TFInicializa;

implementation

{$R *.DFM}

 uses funhardware, constmsg, funstring, FunArquivos;

{******************************************************************************}
procedure TFInicializa.FormCreate(Sender: TObject);
begin
  Ini := TRegIniFile.Create('Software\Listeners\Sistema');
  lista := TStringList.create;
  CarregaPontos;
  VprDesenhando := false;
  VprLargura := 0;
  MudaDesenho := true;
  IgnoraMove := false;
  posicao := self.Width - ct_largura - 10;
  sig.left := 131;
  sig.top := 0;
  VprLaco := 0;
end;

{******************************************************************************}
procedure TFInicializa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  lista.free;
  Ini.Free;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Imagem
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFInicializa.CarregaPontos;
var
  alt, lar : integer;
begin
 for alt := 0 to ct_altura do
   for lar := 0 to ct_largura do
   begin
     pontos[lar,alt] := Image1.Canvas.Pixels[lar,alt];
     pontossig[lar,alt] := sig.Canvas.Pixels[lar,alt];
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           bolas
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFInicializa.Image2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if ct_raio > abs(sqrt( sqr(ct_raio - x) + sqr(ct_raio - y) )) then
  begin
    if (MudaDesenho) and ( not IgnoraMove )  then
    begin
      (sender as TImage).Picture := Bola2.Picture;
      (sender as TImage).tag := 1;
      texto.Caption := (sender as TImage).Hint;
      MudaDesenho := false;
      if (sender as TImage).Name = 'Image2' then
        lBola2.Font.Color := clBlack
       else
        if (sender as TImage).Name = 'Image5' then
          lBola5.Font.Color := clBlack
         else
          if (sender as TImage).Name = 'Image6' then
          begin
            lBola6.Font.Color := clBlack;
            LBola6_1.Font.Color := clBlack;
          end
           else
            if (sender as TImage).Name = 'Image4' then
              lBola4.Font.Color := clBlack
             else
               if (sender as TImage).Name = 'Image10' then
                 lBola10.Font.Color := clBlack;

    end;
  end
  else
    FormMouseMove(sender,Shift,x,y);
end;

{******************************************************************************}
procedure TFInicializa.Image2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  try   // caso nao encontre o arquivo de som ou naum possa abri-lo
    abaixo.play;
  except
  end;
  if not MudaDesenho then
  begin
    (sender as TImage).Picture := Bola3.Picture;
    MudaDesenho := true;
    IgnoraMove := true;
    if (sender as TImage).Name = 'Image2' then
      lBola2.Font.size := 8
    else
      if (sender as TImage).Name = 'Image5' then
        lBola5.Font.size := 8
      else
        if (sender as TImage).Name = 'Image6' then
        begin
          lBola6.Font.size := 8;
          lBola6_1.Font.size := 8;
        end
        else
          if (sender as TImage).Name = 'Image4' then
            lBola4.Font.size := 8
          else
            if (sender as TImage).Name = 'Image10' then
              lBola10.Font.size := 8;
  end;
end;

{******************************************************************************}
procedure TFInicializa.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  try   // caso nao encontre o arquivo de som ou naum possa abri-lo
    acima.play;
  except
  end;

  if  MudaDesenho then
  begin
    (sender as TImage).Picture := Bola2.Picture;
    MudaDesenho := false;
    IgnoraMove := false;
      if (sender as TImage).Name = 'Image4' then
      begin
        lBola4.Font.size := 10;
        ShellExecute( handle, nil, StrToPChar('SisCorp5.1.PPS'), nil,StrToPChar('SisCorp5.1.PPS'),SW_SHOWMAXIMIZED)
      end
      else
        if (sender as TImage).Name = 'Image5' then
        begin
          lBola5.Font.size := 10;
          ShellExecute( handle, nil, StrToPChar('ReferenciaCiente.WMV'), nil,StrToPChar('ReferenciaCiente.WMV'),SW_SHOWMAXIMIZED)
        end
        else
          if (sender as TImage).Name = 'Image6' then
          begin
            lBola6.Font.size := 10;
            lBola6_1.Font.size := 10;
            ShellExecute( handle, nil, StrToPChar('Haco.exe'), nil,StrToPChar('Haco.exe'),SW_SHOWMAXIMIZED)
          end
          else
             if (sender as TImage).Name = 'Image2' then
             begin
                lBola2.Font.size := 10;
                ShellExecute( handle, nil, StrToPChar('\ProgramasGratuitos\VendaBalcao\DISK1\instalar.exe'), nil,StrToPChar('\CDSisCorp\ProgramasGratuitos\VendaBalcao\DISK1\instalar.exe'),SW_SHOWMAXIMIZED)
             end
             else
                 if (sender as TImage).Name = 'Image10' then
                 begin
                   lBola10.Font.size := 10;
                   self.close;
                 end;
  end;
end;

{******************************************************************************}
procedure TFInicializa.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if (not MudaDesenho) and ( not IgnoraMove ) then
  begin
     if Image2.Tag = 1 then begin Image2.Picture := Bola1.Picture; Image2.tag := 0; lBola2.Font.Color := clYellow; end;
     if Image4.Tag = 1 then begin Image4.Picture := Bola1.Picture; Image4.tag := 0; lBola4.Font.Color := clyellow;end;
     if Image10.Tag = 1 then begin Image10.Picture := Bola1.Picture; Image10.tag := 0; lBola10.Font.Color := clyellow;end;
     if Image6.Tag = 1 then begin Image6.Picture := Bola1.Picture; Image6.tag := 0; lBola6.Font.Color := clyellow;lBola6_1.Font.Color := clyellow;end;
     if Image5.Tag = 1 then begin Image5.Picture := Bola1.Picture; Image5.tag := 0; lBola5.Font.Color := clyellow;end;
    MudaDesenho := true;
  end;
end;

{******************************************************************************}
procedure TFInicializa.LBola10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if (sender is TLabel) then
   begin
     case (sender as TLabel).Tag of
       2 : Image2MouseDown(image2,button,shift,x,y);
       3 : Image2MouseDown(image5,button,shift,x,y);
       4 : Image2MouseDown(image4,button,shift,x,y);
       6 : Image2MouseDown(image6,button,shift,x,y);
       10 : Image2MouseDown(image10,button,shift,x,y);
     end;
   end;
end;

{******************************************************************************}
procedure TFInicializa.LBola10MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if (sender is TLabel) then
   begin
     case (sender as TLabel).Tag of
       2 : Image2MouseUp(image2,button,shift,x,y);
       3 : Image2MouseUp(image5,button,shift,x,y);
       4 : Image2MouseUp(image4,button,shift,x,y);
       6 : Image2MouseUp(image6,button,shift,x,y);
       10 : Image2MouseUp(image10,button,shift,x,y);
     end;
   end;
end;

{******************************************************************************}
procedure TFInicializa.Lbola12MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   if (sender is TLabel) then
   begin
     case (sender as TLabel).Tag of
       2 : Image2MouseMove(image2,shift,x,y);
       3 : Image2MouseMove(image5,shift,x,y);
       4 : Image2MouseMove(image4,shift,x,y);
       6 : Image2MouseMove(image6,shift,x,y);
       10 : Image2MouseMove(image10,shift,x,y);
     end;
   end;
end;

{******************************************************************************}
procedure TFInicializa.sigMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Texto.Caption := sig.hint;
end;


{******************************************************************************}
procedure TFInicializa.DesenhaROI;
var
  VpfAlt, VpfLar : Integer;
begin
  VpfAlt := random(Ct_Altura);
  VpfLar := random(ct_Largura);
  if (pontosSig[VpfLar,VpfAlt] > 0) and(pontosSig[VpfLar,VpfAlt] <> 16777215) then
  begin
    FInicializa.Canvas.MoveTo(VpfLar + posicao+95,VpfAlt+90);
    FInicializa.Canvas.Pixels[VpfLar + posicao+95,VpfAlt+90] := pontosSig[VpfLar,VpfAlt];
  end;
end;

{******************************************************************************}
procedure TFInicializa.ExecutaApresentacao;
begin
    ShellExecute( handle, nil, StrToPChar('SisCorp5.1.PPS'), nil,StrToPChar('SisCorp5.1.PPS'),SW_SHOWMAXIMIZED)
end;

{******************************************************************************}
procedure TFInicializa.CopiaSons;
var
  VpfCopiarArquivos :Boolean;
  VpfArquivos : TStringList;
  VpfLaco : Integer;
begin
  VpfCopiarArquivos := false;
  if not ExisteDiretorio('c:\windows\lisSomTe') then
  begin
    CriaDiretorio('c:\windows\LisSomTe');
    VpfCopiarArquivos := true;
  end
  else
    if not(ExisteArquivo('c:\windows\LisSomte\Slide01.wav')) or
       not(ExisteArquivo('c:\windows\LisSomte\Slide22.wav')) then
      VpfCopiarArquivos := true;
  application.ProcessMessages;
  if VpfCopiarArquivos then
  begin
    VpfArquivos := RetornaArquivosMascara(RetornaDiretorioCorrente+'som\*.*');
    for vpflaco := 0 to VpfArquivos.Count - 1 do
    begin
      if DeletaChars(VpfArquivos.Strings[VpfLaco],'.') <> '' then
      begin
        CopiaArquivo(RetornaDiretorioCorrente+'Som\'+VpfArquivos.Strings[VpfLaco],'c:\windows\LisSomTe\'+VpfArquivos.Strings[VpfLaco]);
      end;
      if VpfLaco = 2 then
      begin
        ExecutaApresentacao;
        Application.ProcessMessages;
      end;
    end;
  end;

end;

{******************************************************************************}
procedure TFInicializa.FormShow(Sender: TObject);
begin
  try
    Abaixo.open;
    Acima.open;
  except
  end;
  TConLogoListeners.Enabled := true;
end;


procedure TFInicializa.Timer1Timer(Sender: TObject);
begin
{  Movimento;
  Timer1.Interval := 0;}
end;



{******************************************************************************}
procedure TFInicializa.TConLogoListenersTimer(Sender: TObject);
begin
  TConLogoListeners.Enabled := false;
  VprAltura := 0;
  TListeners.Enabled := true;
end;

{******************************************************************************}
procedure TFInicializa.TListenersTimer(Sender: TObject);
var
  VpfLar : Integer;
begin
  if not VprDesenhando then
  begin
    VprDesenhando := true;
    for VpfLar := 1 to 300 do
    begin
      if VpfLar = 30 then
        CopiaSons;
      if (pontos[VpfLar,VprAltura] > 0) and (pontos[VpfLar,VprAltura] <> 16777215) and
         (pontos[VpfLar,VprAltura] <> 12940090) then
      begin
        FInicializa.Canvas.MoveTo(VpfLar + posicao,VprAltura);
        FInicializa.Canvas.Pixels[VpfLar + posicao,VprAltura] := pontos[VpfLar,VprAltura];
      end;
    end;
    inc(VprAltura);


    if (VprAltura >= 208) then
    begin
      TListeners.Enabled := False;
      Roi.Enabled := true;
      TControlaROI.Enabled := true;
    end;

    VprDesenhando := false;
  end;
end;


{******************************************************************************}
procedure TFInicializa.TControlaROITimer(Sender: TObject);
begin
  Roi.Enabled := false;
  TControlaRoi.Enabled := false;
  TRoi.Enabled := True;
end;

{******************************************************************************}
procedure TFInicializa.RoiTimer(Sender: TObject);
var
  VpfLaco : Integer;
begin
  if not VprDesenhando then
  begin
    VprDesenhando := true;
    for VpfLaco := 0 to 300 do
      DesenhaROI;
    VprDesenhando := false;
  end;

end;

{******************************************************************************}
procedure TFInicializa.TRoiTimer(Sender: TObject);
Var
  VpfAlt : Integer;
begin
  for VpfAlt := 0 to ct_altura do
  begin
    if (pontossig[VprLargura,VpfAlt] <> 16777215) and (pontossig[VprLargura,VpfAlt] > 0) then
    begin
      FInicializa.Canvas.MoveTo(VprLargura + posicao+95,VpfAlt+90);
      FInicializa.Canvas.Pixels[VprLargura + posicao+95,VpfAlt+90] := pontossig[VprLargura,VpfAlt];
    end;
    if (pontossig[ct_largura - VprLargura,VpfAlt] <> 16777215)and (pontossig[ct_largura - VprLargura,VpfAlt] > 0) then
    begin
      FInicializa.Canvas.MoveTo(ct_largura - VprLargura + posicao+95,VpfAlt+90);
      FInicializa.Canvas.Pixels[ct_largura - VprLargura + posicao+95,VpfAlt+90] := pontossig[ct_largura - VprLargura,VpfAlt];
    end;
  end;

  inc(VprLargura);
  if (VprLargura > (ct_largura div 2)) then
  begin
    TRoi.Enabled := false;
    sig.Top := 90;
    sig.Left:= 226;
    Image3.Visible := true;
    sig.Visible := true;
 end;
end;

end.




