unit UModelTipoCombustivel;

interface

type
  TTipoCombustivel = class
  private
    Fid: Integer;
    Fvalor_litro: double;
    Fnome: string;
    procedure Setid(const Value: Integer);
    procedure Setnome(const Value: string);
    procedure Setvalor_litro(const Value: double);

  public
    property id: Integer read Fid write Setid;
    property nome: string read Fnome write Setnome;
    property valor_litro: double read Fvalor_litro write Setvalor_litro;

    constructor Create(id: Integer; nome: String; valor_litro: Double); overload;
    procedure LimpaAtributos();
    procedure InputDados(nome: string; valor_litro: Double);
  end;

implementation

{ TTipoCombustivel }

constructor TTipoCombustivel.Create(id: Integer; nome: String;
  valor_litro: Double);
begin
  self.id := id;
  self.nome := nome;
  self.valor_litro := valor_litro;
end;

procedure TTipoCombustivel.InputDados(nome: string; valor_litro: Double);
begin
  self.nome := nome;
  self.valor_litro := valor_litro;
end;

procedure TTipoCombustivel.LimpaAtributos;
begin
  self.id := 0;
  self.nome := '';
  self.valor_litro := 0.00;
end;

procedure TTipoCombustivel.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TTipoCombustivel.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TTipoCombustivel.Setvalor_litro(const Value: double);
begin
  Fvalor_litro := Value;
end;

end.
