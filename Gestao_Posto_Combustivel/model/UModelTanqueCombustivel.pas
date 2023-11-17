unit UModelTanqueCombustivel;

interface

uses UModelTipoCombustivel;

type
  TTanqueCombustivel = class
  private
    Fid: Integer;
    Fnome: string;
    Fcapacidade_em_litros: double;
    Ftipo_combustivel: TTipoCombustivel;
    Fvalor_litro: double;
    procedure Setid(const Value: Integer);
    procedure Setnome(const Value: string);
    procedure Settipo_combustivel(const Value: TTipoCombustivel);
    procedure Setcapacidade_em_litros(const Value: double);

  public
    property id: Integer read Fid write Setid;
    property nome: string read Fnome write Setnome;
    property tipo_combustivel: TTipoCombustivel read Ftipo_combustivel write Settipo_combustivel;
    property capacidade_em_litros: double read Fcapacidade_em_litros write Setcapacidade_em_litros;

    constructor Create; overload;
    destructor Destroy; override;

    constructor Create(id: Integer; nome: String; tipo_combustivel: TTipoCombustivel; capacidade_em_litros: Double); overload;
    procedure LimpaAtributos();
    procedure InputDados(nome: String; tipo_combustivel: TTipoCombustivel; capacidade_em_litros: Double);
  end;

implementation

uses
  System.SysUtils;

{ TTanqueCombustivel }

constructor TTanqueCombustivel.Create;
begin
  tipo_combustivel := TTipoCombustivel.Create;
end;

constructor TTanqueCombustivel.Create(id: Integer; nome: String;
  tipo_combustivel: TTipoCombustivel; capacidade_em_litros: Double);
begin
  self.id := id;
  self.nome := nome;
  self.tipo_combustivel := tipo_combustivel;
  self.capacidade_em_litros := capacidade_em_litros;
end;

destructor TTanqueCombustivel.Destroy;
begin
  FreeAndNil(tipo_combustivel);
  inherited;
end;

procedure TTanqueCombustivel.InputDados(nome: String;
  tipo_combustivel: TTipoCombustivel; capacidade_em_litros: Double);
begin
  self.nome := nome;
  self.tipo_combustivel := tipo_combustivel;
  self.capacidade_em_litros := capacidade_em_litros;
end;

procedure TTanqueCombustivel.LimpaAtributos;
begin
  self.id := 0;
  self.nome := '';
  self.tipo_combustivel := nil;
  self.capacidade_em_litros := 0.00;
end;

procedure TTanqueCombustivel.Setcapacidade_em_litros(const Value: double);
begin
  Fcapacidade_em_litros := Value;
end;

procedure TTanqueCombustivel.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TTanqueCombustivel.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TTanqueCombustivel.Settipo_combustivel(const Value: TTipoCombustivel);
begin
  Ftipo_combustivel := Value;
end;

end.
