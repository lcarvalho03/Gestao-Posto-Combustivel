unit UModelBombaCombustivel;

interface

uses UModelTanqueCombustivel;

type
  TBombaCombustivel = class
  private
    Ftanque_combustivel: TTanqueCombustivel;
    Fid: Integer;
    Fnome: string;
    procedure Setid(const Value: Integer);
    procedure Setnome(const Value: string);
    procedure Settanque_combustivel(const Value: TTanqueCombustivel);

  public
    property id: Integer read Fid write Setid;
    property nome: string read Fnome write Setnome;
    property tanque_combustivel: TTanqueCombustivel read Ftanque_combustivel write Settanque_combustivel;

    constructor Create; overload;
    destructor Destroy; override;

    constructor Create(id: Integer; nome: String; tanque_combustivel: TTanqueCombustivel); overload;
    procedure LimpaAtributos();
    procedure InputDados(nome: String; tanque_combustivel: TTanqueCombustivel);
  end;

implementation

uses
  System.SysUtils;

{ TBombaCombustivel }

constructor TBombaCombustivel.Create;
begin
  tanque_combustivel := TTanqueCombustivel.Create;
end;

constructor TBombaCombustivel.Create(id: Integer; nome: String; tanque_combustivel: TTanqueCombustivel);
begin
  self.id := id;
  self.nome := nome;
  self.tanque_combustivel := tanque_combustivel;
end;

destructor TBombaCombustivel.Destroy;
begin
  FreeAndNil(tanque_combustivel);
  inherited;
end;

procedure TBombaCombustivel.InputDados(nome: String;
  tanque_combustivel: TTanqueCombustivel);
begin
  self.nome := nome;
  self.tanque_combustivel := tanque_combustivel;
end;

procedure TBombaCombustivel.LimpaAtributos;
begin
  self.id := 0;
  self.nome := '';
  self.tanque_combustivel := nil;
end;

procedure TBombaCombustivel.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TBombaCombustivel.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TBombaCombustivel.Settanque_combustivel(
  const Value: TTanqueCombustivel);
begin
  Ftanque_combustivel := Value;
end;

end.
