unit UControllerTanqueCombustivel;

interface

uses UModelTanqueCombustivel, Data.DB;

type
  TControllerTanqueCombustivel = class
  private
  public
    class function Create(objTanqueCombustivel: TTanqueCombustivel): Boolean;
    class function Update(objTanqueCombustivel: TTanqueCombustivel): Boolean;
    class function Delete(objTanqueCombustivel: TTanqueCombustivel): Boolean;
    class function Read(objDataSource: TDataSource): Boolean;
  end;

implementation

uses UDaoTanqueCombustivel;

{ TControllerTanqueCombustivel }

class function TControllerTanqueCombustivel.Create(
  objTanqueCombustivel: TTanqueCombustivel): Boolean;
begin
  Result := TDaoTanqueCombustivel.Insert(objTanqueCombustivel);
end;

class function TControllerTanqueCombustivel.Delete(
  objTanqueCombustivel: TTanqueCombustivel): Boolean;
begin
  Result := TDaoTanqueCombustivel.Delete(objTanqueCombustivel);
end;

class function TControllerTanqueCombustivel.Read(objDataSource: TDataSource): Boolean;
begin
  objDataSource.DataSet := TDaoTanqueCombustivel.SelectAll;
end;

class function TControllerTanqueCombustivel.Update(objTanqueCombustivel: TTanqueCombustivel): Boolean;
begin
  Result := TDaoTanqueCombustivel.Update(objTanqueCombustivel);
end;

end.
