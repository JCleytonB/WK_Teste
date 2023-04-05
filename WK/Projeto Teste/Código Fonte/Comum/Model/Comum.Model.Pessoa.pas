unit Comum.Model.Pessoa;

interface

uses Comum.Model.Default, System.Math;

type

  TPessoa = class(Comum.Model.Default.TDefault)
  private
    class var FNMPrimeiro : String;
    class var FDTRegistro : TDate;
    class var FNMSegundo  : String;
    class var FDSDocumento: String;
    class var FIDPessoa   : Integer;
    class var FFLNatureza : Integer;
    class var FInstance   : TPessoa;
  public
    class function GetInstance: TPessoa;
    class property IDPessoa   : Integer read FIDPessoa    write FIDPessoa default 0;
    class property FLNatureza : Integer read FFLNatureza  write FFLNatureza;
    class property DSDocumento: String  read FDSDocumento write FDSDocumento;
    class property NMPrimeiro : String  read FNMPrimeiro  write FNMPrimeiro;
    class property NMSegundo  : String  read FNMSegundo   write FNMSegundo;
    class property DTRegistro : TDate   read FDTRegistro  write FDTRegistro;
    constructor Create;
    constructor CreatePrivate;
  end;

implementation

uses
  Vcl.Dialogs, System.SysUtils;

{ TPessoa }

constructor TPessoa.Create;
begin
  raise Exception.Create('Para obter uma instância de TPessoa utilize TPessoa.GetInstance !');
end;

constructor TPessoa.CreatePrivate;
begin
  inherited Create;
end;

class function TPessoa.GetInstance: TPessoa;
begin
  if not Assigned(FInstance) then
    FInstance := TPessoa.CreatePrivate;
  Result := FInstance;
end;


end.
