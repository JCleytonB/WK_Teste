program WKServer;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Server.View.Main in 'View\Server.View.Main.pas' {frmMain},
  Server.Controller.ServerMethodsUnit in 'Controller\Server.Controller.ServerMethodsUnit.pas' {ServerMethods1: TDSServerModule},
  Server.Controller.ServerContainerUnit in 'Controller\Server.Controller.ServerContainerUnit.pas' {ServerContainer1: TDataModule},
  Comum.Model.Default in '..\Comum\Model\Comum.Model.Default.pas',
  Comum.Model.Pessoa in '..\Comum\Model\Comum.Model.Pessoa.pas',
  Comum.Model.Endereco in '..\Comum\Model\Comum.Model.Endereco.pas',
  Server.Controller.ControlePadrao in 'Controller\Server.Controller.ControlePadrao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.

