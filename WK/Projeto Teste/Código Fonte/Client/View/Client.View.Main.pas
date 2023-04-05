unit Client.View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids, System.Math,
  Vcl.DBGrids, Vcl.StdCtrls, Client.Controller.DModule, Datasnap.DBClient,
  Datasnap.DSConnect;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DBGridPessoa: TDBGrid;
    dscPessoa: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Client.View.Pessoa, Client.Controller.ServerMethodsClient,
  Comum.Model.Pessoa, Client.Uteis.TiposEspeciais;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  AProxy: Client.Controller.ServerMethodsClient.TServerMethods1Client;
  AIDPessoa: String;
begin
  try
    Client.View.Pessoa.frmPessoa := Client.View.Pessoa.TfrmPessoa.Create(nil);
    AProxy := Client.Controller.ServerMethodsClient.TServerMethods1Client.Create(Client.Controller.DModule.DataModule1.SQLConnection.DBXConnection);
    AIDPessoa                                       := AProxy.GetPessoaID;
    Comum.Model.Pessoa.TPessoa.GetInstance.IDPessoa := StrToInt(AIDPessoa);
    Client.View.Pessoa.frmPessoa.TipoCadastro := tcInsert;
    Client.View.Pessoa.frmPessoa.ShowModal;
  finally
    if Assigned(AProxy) then
      FreeAndNil(AProxy);
    if Assigned(Client.View.Pessoa.frmPessoa) then
      FreeAndNil(Client.View.Pessoa.frmPessoa);
  end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  Client.View.Pessoa.frmPessoa                       := Client.View.Pessoa.TfrmPessoa.Create(nil);
  Comum.Model.Pessoa.TPessoa.GetInstance.IDPessoa    := Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('idpessoa').AsInteger;
  Comum.Model.Pessoa.TPessoa.GetInstance.FLNatureza  := Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('flnatureza').AsInteger;
  Comum.Model.Pessoa.TPessoa.GetInstance.DSDocumento := Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('dsdocumento').AsString;
  Comum.Model.Pessoa.TPessoa.GetInstance.NMPrimeiro  := Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('nmprimeiro').AsString;
  Comum.Model.Pessoa.TPessoa.GetInstance.NMSegundo   := Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('nmsegundo').AsString;
  Client.View.Pessoa.frmPessoa.TipoCadastro          := tcUpdate;
  Client.View.Pessoa.frmPessoa.ShowModal;
  FreeAndNil(Client.View.Pessoa.frmPessoa);
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  if Client.Controller.DModule.DataModule1.cdsPessoa.RecNo > ZeroValue then
  begin
    try
      Client.Controller.DModule.DataModule1.cdsPessoa.Delete;
      Client.Controller.DModule.DataModule1.cdsPessoa.ApplyUpdates(0);
      ShowMessage('Registro deletado com sucesso!');
      Client.Controller.DModule.DataModule1.cdsPessoa.Active := False;
      Client.Controller.DModule.DataModule1.cdsPessoa.Active := True;
    except
      ShowMessage('Erro ao tentar deletar registro!');
    end;
  end
  else
    ShowMessage('Nenhum registro selecionado para ser deletado!');

end;

procedure TfrmMain.Button4Click(Sender: TObject);
var
  AArquivoCSV: TextFile;
  AContador  : Integer;
  i          : Integer;
  ALinha     : String;

  function MontaValor: String;
  var
    AValorMontado: String;
  begin
    AValorMontado := '';
    inc(i);
    while ALinha[i] >= ' ' do
    begin
      if ALinha[I] = ';' then
        break;
      AValorMontado := AValorMontado + ALinha[i];
      inc(i);
    end;
    result := AValorMontado;
  end;

begin
  // TO-DO Criar busca de arquivo
  AssignFile(AArquivoCSV, 'C:\Temp\Teste.csv');

  try
    Reset(AArquivoCSV);
    Readln(AArquivoCSV, ALinha);
    AContador := 1;

    // TO-DO Criar valida��o da estrutura do arquivo
    while not Eoln(AArquivoCSV) do
    begin
      Client.Controller.DModule.DataModule1.cdsPessoa.Insert;
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('idpessoa').AsInteger    := StrToInt(MontaValor);
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('flnatureza').AsInteger  := StrToInt(MontaValor);
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('dsdocumento').AsString  := MontaValor;
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('nmprimeiro').AsString   := MontaValor;
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('nmsegundo').AsString    := MontaValor;
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('dtregistro').AsDateTime := Now;
      Client.Controller.DModule.DataModule1.cdsPessoa.Post;
      Readln(AArquivoCSV, ALinha);

    end;
    Client.Controller.DModule.DataModule1.cdsPessoa.ApplyUpdates(0);
    ShowMessage('Importa��o efetuada com sucesso!');
    Client.Controller.DModule.DataModule1.cdsPessoa.Active := False;
    Client.Controller.DModule.DataModule1.cdsPessoa.Active := True;
  finally
    CloseFile(AArquivoCSV);
  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  try
    Client.Controller.DModule.DataModule1.cdsPessoa.Active := True;
  except
    ShowMessage('Erro ao tentar pesquisar Pessoas!');
  end;
end;

end.
