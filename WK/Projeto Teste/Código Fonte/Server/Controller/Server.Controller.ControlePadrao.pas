unit Server.Controller.ControlePadrao;

interface

uses Server.Controller.ServerMethodsUnit, FireDAC.Comp.Client,
  Comum.Model.Default;

type
  TControlePadrao = class
  private
    FDQuery: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
    function Insert(pObjeto: Comum.Model.Default.TDefault): Boolean; virtual; abstract;
    function Update(pObjeto: Comum.Model.Default.TDefault): Boolean; virtual; abstract;
    function Delete(pID: Integer): Boolean; virtual; abstract;
    function Pesquisa(pID: Integer; pComando: String = ''): Comum.Model.Default.TDefault; virtual; abstract;
    property SQLQuery: TFDQuery read FDQuery write FDQuery;
  end;

implementation


{ TControlePadrao }

constructor TControlePadrao.Create;
begin

end;

destructor TControlePadrao.Destroy;
begin

  inherited;
end;

end.
