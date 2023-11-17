unit UControllerTipoCombustivel;

interface

uses
  UModelTipoCombustivel, Data.DB;

type
  TControllerTipoCombustivel = class
  private
  public
    class function Create(objTipoCombustivel: TTipoCombustivel): Boolean;
    class function Update(objTipoCombustivel: TTipoCombustivel): Boolean;
    class function Delete(objTipoCombustivel: TTipoCombustivel): Boolean;
    class function Read(objDataSource: TDataSource): Boolean;
  end;

implementation

uses UDaoTipoCombustivel;

{ TControllerTipoCombustivel }

class function TControllerTipoCombustivel.Create(
  objTipoCombustivel: TTipoCombustivel): Boolean;
begin
  Result := TDaoTipoCombustivel.Insert(objTipoCombustivel);
end;

class function TControllerTipoCombustivel.Delete(
  objTipoCombustivel: TTipoCombustivel): Boolean;
begin
   Result := TDaoTipoCombustivel.Delete(objTipoCombustivel);
end;

class function TControllerTipoCombustivel.Read(
  objDataSource: TDataSource): Boolean;
begin
  objDataSource.DataSet := TDaoTipoCombustivel.SelectAll;
end;

class function TControllerTipoCombustivel.Update(
  objTipoCombustivel: TTipoCombustivel): Boolean;
begin
  Result := TDaoTipoCombustivel.Update(objTipoCombustivel);
end;

end.
