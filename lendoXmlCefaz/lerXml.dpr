program lerXml;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form15};

{$R *.res}

begin
 Application.Initialize;
 Application.MainFormOnTaskbar := True;
 Application.CreateForm(TForm15, Form15);
  Application.Run;

end.
