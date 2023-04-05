unit Client.View.Pessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Client.Controller.DModule,
  Comum.Model.Pessoa, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Client.Uteis.TiposEspeciais;

type
  TfrmPessoa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    edtCodigo: TLabeledEdit;
    edtNatureza: TLabeledEdit;
    edtDocumento: TLabeledEdit;
    edtPrimeiroNome: TLabeledEdit;
    edtSegundoNome: TLabeledEdit;
    edtCEP: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    Button3: TButton;
    Button4: TButton;
    dscEndereco: TDataSource;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FTipoCadastro: Client.Uteis.TiposEspeciais.TTipoCadastro;
    function DoSave: Boolean;
  public
    procedure LoadPessoa;
    property TipoCadastro: Client.Uteis.TiposEspeciais.TTipoCadastro read FTipoCadastro write FTipoCadastro;
  end;

var
  frmPessoa: TfrmPessoa;

implementation

uses
  System.Math;

{$R *.dfm}

{ TForm1 }

procedure TfrmPessoa.Button1Click(Sender: TObject);
begin
  Client.Controller.DModule.DataModule1.cdsEndereco.Insert;
  Client.Controller.DModule.DataModule1.cdsEndereco.FieldByName('idpessoa').AsInteger := Comum.Model.Pessoa.TPessoa.GetInstance.IDPessoa;
  Client.Controller.DModule.DataModule1.cdsEndereco.FieldByName('dscep').AsString     := edtCEP.Text;
  Client.Controller.DModule.DataModule1.cdsEndereco.Post;
end;

procedure TfrmPessoa.Button2Click(Sender: TObject);
begin
  if Client.Controller.DModule.DataModule1.cdsEndereco.RecNo > ZeroValue then
  begin
    try
      Client.Controller.DModule.DataModule1.cdsEndereco.Delete;
      ShowMessage('Registro deletado com sucesso!');
    except
      ShowMessage('Erro ao tentar deletar registro!');
    end;
  end
  else
    ShowMessage('Nenhum registro selecionado para ser deletado!');

end;

procedure TfrmPessoa.Button3Click(Sender: TObject);
begin
 if DoSave then
   Close;
end;

procedure TfrmPessoa.Button4Click(Sender: TObject);
begin
  Close;
end;

function TfrmPessoa.DoSave: Boolean;
  function GetPessoa: Boolean;
  begin
     // Faltou validação se os campos obrigatórios estão preenchidos.
     // Faltou validar se os valores correspondem aos tipos dos campos.
    Comum.Model.Pessoa.TPessoa.GetInstance.IDPessoa    := StrToInt(edtCodigo.Text);
    Comum.Model.Pessoa.TPessoa.GetInstance.FLNatureza  := ifThen(edtNatureza.Text <> '', StrToInt(edtNatureza.Text), 0);
    Comum.Model.Pessoa.TPessoa.GetInstance.DSDocumento := edtDocumento.Text;
    Comum.Model.Pessoa.TPessoa.GetInstance.NMPrimeiro  := edtPrimeiroNome.Text;
    Comum.Model.Pessoa.TPessoa.GetInstance.NMSegundo   := edtSegundoNome.Text;
    Result             := True;
  end;

begin
  try
    if GetPessoa then
    begin
      if TipoCadastro = tcInsert then
        Client.Controller.DModule.DataModule1.cdsPessoa.Insert
      else
        Client.Controller.DModule.DataModule1.cdsPessoa.Edit;

      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('idpessoa').AsInteger    := Comum.Model.Pessoa.TPessoa.GetInstance.IDPessoa;
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('flnatureza').AsInteger  := Comum.Model.Pessoa.TPessoa.GetInstance.FLNatureza;
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('dsdocumento').AsString  := Comum.Model.Pessoa.TPessoa.GetInstance.DSDocumento;
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('nmprimeiro').AsString   := Comum.Model.Pessoa.TPessoa.GetInstance.NMPrimeiro;
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('nmsegundo').AsString    := Comum.Model.Pessoa.TPessoa.GetInstance.NMSegundo;
      Client.Controller.DModule.DataModule1.cdsPessoa.FieldByName('dtregistro').AsDateTime := Now;
      Client.Controller.DModule.DataModule1.cdsPessoa.Post;

      Client.Controller.DModule.DataModule1.cdsPessoa.ApplyUpdates(0);
      Client.Controller.DModule.DataModule1.cdsEndereco.ApplyUpdates(0);

      Client.Controller.DModule.DataModule1.cdsPessoa.Active := False;
      Client.Controller.DModule.DataModule1.cdsPessoa.Active := True;
      Result := True;
    end;
  except
    ShowMessage('Erro ao tentar salvar registro!');
    Result := False;
  end;
end;

procedure TfrmPessoa.FormShow(Sender: TObject);
begin
  LoadPessoa;
end;

procedure TfrmPessoa.LoadPessoa;
begin
  edtCodigo.Text       := Comum.Model.Pessoa.TPessoa.GetInstance.IDPessoa.ToString;
  edtNatureza.Text     := Comum.Model.Pessoa.TPessoa.GetInstance.FLNatureza.ToString;
  edtDocumento.Text    := Comum.Model.Pessoa.TPessoa.GetInstance.DSDocumento;
  edtPrimeiroNome.Text := Comum.Model.Pessoa.TPessoa.GetInstance.NMPrimeiro;
  edtSegundoNome.Text  := Comum.Model.Pessoa.TPessoa.GetInstance.NMSegundo;

  Client.Controller.DModule.DataModule1.cdsEndereco.Active   := False;
  Client.Controller.DModule.DataModule1.cdsEndereco.Filtered := False;
  Client.Controller.DModule.DataModule1.cdsEndereco.Filter   := 'idpessoa = ' + Comum.Model.Pessoa.TPessoa.GetInstance.IDPessoa.ToString;
  Client.Controller.DModule.DataModule1.cdsEndereco.Filtered := True;
  Client.Controller.DModule.DataModule1.cdsEndereco.Active   := True;
end;

end.
