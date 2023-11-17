unit UModelAbastecimento;

interface

uses UModelTanqueCombustivel, UModelBombaCombustivel, UModelTipoCombustivel;

type
  TAbastecimento = class
  private
    Fid: Integer;
    Fpercentual_imposto: double;
    Fdata_abastecimento: TDateTime;
    Fqtd_litro_combustivel: Double;
    Fvalor_litro: Double;
    Ftanque_combustivel: string;
    Fbomba_combustivel: string;
    Ftipo_combustivel: string;
    procedure Setdata_abastecimento(const Value: TDateTime);
    procedure Setid(const Value: Integer);
    procedure Setpercentual_imposto(const Value: double);
    procedure Setqtd_litro_combustivel(const Value: Double);
    procedure Setvalor_litro(const Value: Double);
    procedure Setbomba_combustivel(const Value: string);
    procedure Settanque_combustivel(const Value: string);
    procedure Settipo_combustivel(const Value: string);

  public
    property id: Integer read Fid write Setid;
    property data_abastecimento: TDateTime read Fdata_abastecimento write Setdata_abastecimento;
    property tanque_combustivel: string read Ftanque_combustivel write Settanque_combustivel;
    property bomba_combustivel: string read Fbomba_combustivel write Setbomba_combustivel;
    property tipo_combustivel: string read Ftipo_combustivel write Settipo_combustivel;
    property valor_litro: Double read Fvalor_litro write Setvalor_litro;
    property qtd_litro_combustivel: Double read Fqtd_litro_combustivel write Setqtd_litro_combustivel;
    property percentual_imposto: double read Fpercentual_imposto write Setpercentual_imposto;

    constructor Create; overload;
    destructor Destroy; override;

    constructor Create(id: Integer; nome: String; tanque_combustivel: TTanqueCombustivel); overload;
    procedure LimpaAtributos();
    procedure InputDados(data_abastecimento: TDateTime;
                         tanque_combustivel: string;
                         bomba_combustivel: string;
                         tipo_combustivel: string;
                         valor_litro: Double;
                         qtd_litro_combustivel: Double;
                         percentual_imposto: double);
  end;

implementation

uses
  System.SysUtils;

{ TAbastecimento }

constructor TAbastecimento.Create;
begin
end;

constructor TAbastecimento.Create(id: Integer; nome: String;
  tanque_combustivel: TTanqueCombustivel);
begin

end;

destructor TAbastecimento.Destroy;
begin
  inherited;
end;

procedure TAbastecimento.InputDados(data_abastecimento: TDateTime;
                         tanque_combustivel: string;
                         bomba_combustivel: string;
                         tipo_combustivel: string;
                         valor_litro: Double;
                         qtd_litro_combustivel: Double;
                         percentual_imposto: double);
begin
  self.data_abastecimento := data_abastecimento;
  self.tanque_combustivel := tanque_combustivel;
  self.bomba_combustivel := bomba_combustivel;
  self.tipo_combustivel := tipo_combustivel;
  self.valor_litro := valor_litro;
  self.qtd_litro_combustivel := qtd_litro_combustivel;
  self.percentual_imposto := percentual_imposto;
end;

procedure TAbastecimento.LimpaAtributos;
begin
  self.id := 0;
  self.data_abastecimento := Date;
  self.tanque_combustivel := '';
  self.bomba_combustivel := '';
  self.tipo_combustivel := '';
  self.valor_litro := 0.00;
  self.qtd_litro_combustivel := 0.00;
  self.percentual_imposto := 0.00;
end;

procedure TAbastecimento.Setbomba_combustivel(const Value: string);
begin
  Fbomba_combustivel := Value;
end;

procedure TAbastecimento.Setdata_abastecimento(const Value: TDateTime);
begin
  Fdata_abastecimento := Value;
end;

procedure TAbastecimento.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TAbastecimento.Setpercentual_imposto(const Value: double);
begin
  Fpercentual_imposto := Value;
end;

procedure TAbastecimento.Setqtd_litro_combustivel(const Value: Double);
begin
  Fqtd_litro_combustivel := Value;
end;

procedure TAbastecimento.Settanque_combustivel(const Value: string);
begin
  Ftanque_combustivel := Value;
end;

procedure TAbastecimento.Settipo_combustivel(const Value: string);
begin
  Ftipo_combustivel := Value;
end;

procedure TAbastecimento.Setvalor_litro(const Value: Double);
begin
  Fvalor_litro := Value;
end;

end.
