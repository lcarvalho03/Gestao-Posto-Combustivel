unit UControllerBombaCombustivel;

interface

uses UModelBombaCombustivel, Data.DB;

type
  TControllerBombaCombustivel = class
  private
  public
    class function Create(objBombaCombustivel: TBombaCombustivel): Boolean;
    class function Update(objBombaCombustivel: TBombaCombustivel): Boolean;
    class function Delete(objBombaCombustivel: TBombaCombustivel): Boolean;
    class function Read(objDataSource: TDataSource): Boolean;
  end;

implementation

uses UDaoBombaCombustivel;


{ TControllerTanqueCombustivel }

class function TControllerBombaCombustivel.Create(
  objBombaCombustivel: TBombaCombustivel): Boolean;
begin
  Result := TDaoBombaCombustivel.Insert(objBombaCombustivel);
end;

class function TControllerBombaCombustivel.Delete(
  objBombaCombustivel: TBombaCombustivel): Boolean;
begin
  Result := TDaoBombaCombustivel.Delete(objBombaCombustivel);
end;

class function TControllerBombaCombustivel.Read(
  objDataSource: TDataSource): Boolean;
begin
  objDataSource.DataSet := TDaoBombaCombustivel.SelectAll;
end;

class function TControllerBombaCombustivel.Update(
  objBombaCombustivel: TBombaCombustivel): Boolean;
begin
  Result := TDaoBombaCombustivel.Update(objBombaCombustivel);
end;

end.
