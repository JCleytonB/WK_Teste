unit Server.View.Main;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    btnStart: TButton;
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Server.Controller.ServerContainerUnit;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  try
    Server.Controller.ServerContainerUnit.ServerContainer1.DSServer1.Start;
  except
    ShowMessage('Erro ao tentar conectar!');
  end;
end;

end.

