unit Comum.Model.Endereco;

interface

uses Comum.Model.Default;

type

  TEndereco = class(Comum.Model.Default.TDefault)
  private
    FIDEndereco: Integer;
    FDSCep     : String;
    FIDPessoa  : Integer;
  public
    property IDEndereco: Integer read FIDEndereco write FIDEndereco;
    property IDPessoa  : Integer read FIDPessoa   write FIDPessoa;
    property DSCep     : String  read FDSCep      write FDSCep;
  end;

implementation

end.
