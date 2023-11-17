unit UControllerImposto;

interface

uses
  UModelImposto, Data.DB;

type
  TControllerImposto = class
  private
  public
    class function Create(objImposto: TImposto): Boolean;
    class function Update(objImposto: TImposto): Boolean;
    class function Delete(objImposto: TImposto): Boolean;
    class function Read(objDataSource: TDataSource): Boolean;
    class function ObtemImpostoAtivo(): TImposto;
  end;

implementation

uses
  UDaoImposto;

{ TControllerImposto }

class function TControllerImposto.Create(objImposto: TImposto): Boolean;
begin
  Result := TDaoImposto.Insert(objImposto);
end;

class function TControllerImposto.Delete(objImposto: TImposto): Boolean;
begin
  Result := TDaoImposto.Delete(objImposto);
end;

class function TControllerImposto.ObtemImpostoAtivo: TImposto;
begin
  Result := TDaoImposto.ObtemImpostoAtivo;
end;

class function TControllerImposto.Read(objDataSource: TDataSource): Boolean;
begin
  objDataSource.DataSet := TDaoImposto.SelectAll;
end;

class function TControllerImposto.Update(objImposto: TImposto): Boolean;
begin
  Result := TDaoImposto.Update(objImposto);
end;

end.
