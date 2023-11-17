unit UModelImposto;

interface

type
  TImposto = class
  private
    Fpercentual: Double;
    Fdata_imposto: TDate;
    Fativo: boolean;
    Fid: Integer;
    procedure Setdata_imposto(const Value: TDate);
    procedure Setpercentual(const Value: Double);
    procedure Setativo(const Value: boolean);
    procedure Setid(const Value: Integer);

  public
    property id: Integer read Fid write Setid;
    property data_imposto: TDate read Fdata_imposto write Setdata_imposto;
    property percentual: Double read Fpercentual write Setpercentual;
    property ativo: boolean read Fativo write Setativo;

    constructor Create(id: Integer; data_imposto: TDate; percentual: Double; ativo: Boolean); overload;
    procedure LimpaAtributos();
    procedure InputDados(data_imposto: TDate; percentual: Double; ativo: Boolean);
  end;

implementation

uses
  System.SysUtils;

{ TImposto }

constructor TImposto.Create(id: Integer; data_imposto: TDate; percentual: Double;
  ativo: Boolean);
begin
  self.id := id;
  self.data_imposto := data_imposto;
  self.percentual := percentual;
  self.ativo := ativo;
end;

procedure TImposto.InputDados(data_imposto: TDate; percentual: Double;
  ativo: Boolean);
begin
  self.data_imposto := data_imposto;
  self.percentual := percentual;
  self.ativo := ativo;
end;

procedure TImposto.LimpaAtributos;
begin
  self.id := 0;
  self.data_imposto := Date;
  self.percentual := 0.00;
  self.ativo := True;
end;

procedure TImposto.Setativo(const Value: boolean);
begin
  Fativo := Value;
end;

procedure TImposto.Setdata_imposto(const Value: TDate);
begin
  Fdata_imposto := Value;
end;

procedure TImposto.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TImposto.Setpercentual(const Value: Double);
begin
  Fpercentual := Value;
end;

end.
