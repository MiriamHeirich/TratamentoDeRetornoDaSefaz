unit uPrincipal;

interface

uses
   Winapi.Windows,
   Winapi.Messages,
   System.SysUtils,
   System.Variants,
   System.Classes,
   Vcl.Graphics,
   Vcl.Controls,
   Vcl.Forms,
   Vcl.Dialogs,
   Xml.xmldom,
   Xml.XMLIntf,
   Xml.XMLDoc,
   Vcl.StdCtrls,
   System.StrUtils,
   Data.DB,
   Datasnap.DBClient,
   Vcl.ExtCtrls,
   Vcl.ComCtrls;

type
   TForm15 = class(TForm)
   MemoErro: TMemo;
   btnTestar: TButton;
   XMLDocument1: TXMLDocument;
   btnLimpar: TButton;
   btnFechar: TButton;
   Label1: TLabel;
   memoTodosOsErros: TMemo;
   Label2: TLabel;
   procedure btnTestarClick(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure btnLimparClick(Sender: TObject);
   procedure btnFecharClick(Sender: TObject);
   procedure MemoTodosOsErrosChange(Sender: TObject);
   private
     function procurarTagXml(sDescricaoErro, sNomeTag: String): String;
    { Private declarations }
  public
    { Public declarations }
   end;

  var
   Form15: TForm15;

  implementation

{$R *.dfm}
{$region 'Procedures'}
procedure TForm15.btnFecharClick(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TForm15.btnTestarClick(Sender: TObject);
var
   sErroGerado : String;
begin
   sErroGerado := MemoErro.Lines.Text;
   MessageDlg( procurarTagXml(sErroGerado,'Erros')+#13
             + procurarTagXml(sErroGerado,'Campos')+#13
             + procurarTagXml(sErroGerado, 'Tags')+#13
             + 'Preencha o campo acima corretamente e tente novamente'
             , mtinformation
             , [mbOk]
             , 0
             );
end;

procedure TForm15.btnLimparClick(Sender: TObject);
begin
   MemoErro.Lines.Text:= '';
end;

procedure TForm15.FormCreate(Sender: TObject);
begin
   XMLDocument1.LoadFromFile('C:\Users\Bsoft\Desktop\ProjetoErrosDeXML\Erros.xml');
   XMLDocument1.Active := true;
end;

procedure TForm15.MemoTodosOsErrosChange(Sender: TObject);
begin

end;
{$endregion}

function TForm15.procurarTagXml(sDescricaoErro, sNomeTag: String): String;
var
   xmlNoErro  : IXMLNode;
   i          : integer;
   sTipoDeErro: String;

begin
   xmlNoErro := XMLDocument1.ChildNodes.FindNode('ErrosTratados').ChildNodes.FindNode(sNomeTag);

   for I := 0 to xmlNoErro.ChildNodes.Count -1 do
   begin
      if sDescricaoErro.Contains(xmlNoErro.Childnodes[i].ChildNodes[0].text) then
         sTipoDeErro := xmlNoErro.Childnodes[i].ChildNodes[1].text;
   end;

   Result:= sTipoDeErro;
end;

end.
