program WKClient;

uses
  Vcl.Forms,
  Client.View.Main in 'View\Client.View.Main.pas' {frmMain},
  Client.Controller.DModule in 'Controller\Client.Controller.DModule.pas' {DataModule1: TDataModule},
  Client.View.Pessoa in 'View\Client.View.Pessoa.pas' {frmPessoa},
  Comum.Model.Pessoa in '..\Comum\Model\Comum.Model.Pessoa.pas',
  Comum.Model.Default in '..\Comum\Model\Comum.Model.Default.pas',
  Client.Uteis.TiposEspeciais in 'Uteis\Client.Uteis.TiposEspeciais.pas',
  Client.Controller.ServerMethodsClient in 'Controller\Client.Controller.ServerMethodsClient.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmPessoa, frmPessoa);
  Application.Run;
end.
