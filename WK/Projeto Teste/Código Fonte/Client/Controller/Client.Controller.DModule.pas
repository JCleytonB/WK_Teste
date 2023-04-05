unit Client.Controller.DModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Datasnap.DBClient, Datasnap.DSConnect;

type
  TDataModule1 = class(TDataModule)
    SQLConnection: TSQLConnection;
    DSPCPessoa: TDSProviderConnection;
    cdsPessoa: TClientDataSet;
    DSPCEndereco: TDSProviderConnection;
    cdsEndereco: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

uses
  Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  try
    SQLConnection.Close;
    SQLConnection.Connected := True;
  except
    ShowMessage('Erro ao tentar se conectar ao servidor!');
  end;
end;

end.
