unit UControllerAbastecimento;

interface

uses
  UModelAbastecimento, Data.DB;

type
  TControllerAbastecimento = class
  private
  public
    class function Create(objAbastecimento: TAbastecimento): Boolean;
    class function Update(objAbastecimento: TAbastecimento): Boolean;
    class function Delete(objAbastecimento: TAbastecimento): Boolean;
    class function Read(objDataSource: TDataSource): Boolean;
  end;

implementation

uses
  UDaoAbastecimento;

{ TControllerAbastecimento }


{ TControllerAbastecimento }

class function TControllerAbastecimento.Create(
  objAbastecimento: TAbastecimento): Boolean;
begin
  Result := TDaoAbastecimento.Insert(objAbastecimento);
end;

class function TControllerAbastecimento.Delete(
  objAbastecimento: TAbastecimento): Boolean;
begin
  Result := TDaoAbastecimento.Delete(objAbastecimento);
end;

class function TControllerAbastecimento.Read(
  objDataSource: TDataSource): Boolean;
begin
  objDataSource.DataSet := TDaoAbastecimento.SelectAll;
end;

class function TControllerAbastecimento.Update(
  objAbastecimento: TAbastecimento): Boolean;
begin
  Result := TDaoAbastecimento.Update(objAbastecimento);
end;

end.
