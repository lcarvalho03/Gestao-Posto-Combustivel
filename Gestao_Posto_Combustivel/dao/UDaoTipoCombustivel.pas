unit UDaoTipoCombustivel;

interface

uses
  UModelTipoCombustivel, Data.Win.ADODB, System.Generics.Collections;

type
  TDaoTipoCombustivel = class
  private
    class function GetSqlInsert(): string;
    class function GetSqlUpdate(): string;
    class function GetSqlDelete(): string;
    class function GetSqlSelectAll(): string;
    class function GetSqlSelectOne(): string;
  public
    class function Insert(objTipoCombustivel: TTipoCombustivel): Boolean;
    class function Update(objTipoCombustivel: TTipoCombustivel): Boolean;
    class function Delete(objTipoCombustivel: TTipoCombustivel): Boolean;
    class function SelectAll(): TADOQuery;
    class function ObtemListaAllObjects(): TObjectList<TTipoCombustivel>;
  end;

implementation

uses ULib, System.SysUtils;

{ TDaoTipoCombustivel }

class function TDaoTipoCombustivel.Delete(
  objTipoCombustivel: TTipoCombustivel): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlDelete);

    lQuery.Parameters.ParamByName('id').Value := objTipoCombustivel.id;

    try
      lQuery.Connection.BeginTrans;
      lQuery.ExecSQL;
      lQuery.Connection.CommitTrans;
    except
      lQuery.Connection.RollbackTrans;
      Result := False;
    end;
  finally
    FreeAndNil(lQuery);
  end;
end;

class function TDaoTipoCombustivel.GetSqlDelete: string;
begin
  Result := 'DELETE FROM [dbo].[Tipo_Combustivel] ' +
            'WHERE ([id] = :id)';
end;

class function TDaoTipoCombustivel.GetSqlInsert: string;
begin
  Result := 'INSERT INTO [dbo].[Tipo_Combustivel] (' +
                '[nome], ' +
                '[valor_litro]) ' +
            'VALUES (' +
                ':nome, ' +
                ':valor_litro)';
end;

class function TDaoTipoCombustivel.GetSqlSelectAll: string;
begin
  Result := 'SELECT [id], ' +
                '[nome], ' +
                '[valor_litro] ' +
            'FROM [dbo].[Tipo_Combustivel] ' +
            'ORDER BY [nome]';
end;

class function TDaoTipoCombustivel.GetSqlSelectOne: string;
begin
  Result := 'SELECT [id], ' +
                '[nome], ' +
                '[valor_litro] ' +
            'FROM [dbo].[Tipo_Combustivel] ' +
            'WHERE ([id] = :id)';
end;

class function TDaoTipoCombustivel.GetSqlUpdate: string;
begin
  Result := 'UPDATE [dbo].[Tipo_Combustivel] ' +
            'SET [nome] = :nome, ' +
                '[valor_litro] = :valor_litro ' +
            'WHERE ([id] = :id)';
end;

class function TDaoTipoCombustivel.Insert(
  objTipoCombustivel: TTipoCombustivel): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlInsert);

    lQuery.Parameters.ParamByName('nome').Value := objTipoCombustivel.nome;
    lQuery.Parameters.ParamByName('valor_litro').Value := objTipoCombustivel.valor_litro;

    try
      lQuery.Connection.BeginTrans;
      lQuery.ExecSQL;
      lQuery.Connection.CommitTrans;
    except
      lQuery.Connection.RollbackTrans;
      Result := False;
    end;
  finally
    FreeAndNil(lQuery);
  end;
end;

class function TDaoTipoCombustivel.ObtemListaAllObjects: TObjectList<TTipoCombustivel>;
var
  lLista: TObjectList<TTipoCombustivel>;
  lQuery: TADOQuery;
begin
  lLista := TObjectList<TTipoCombustivel>.Create;
  lLista.Add(TTipoCombustivel.Create(0,
                                     '',
                                     0.00));
  lQuery := obtemComponenteQuery(GetSqlSelectAll);
  lQuery.Open;

  if (not lQuery.IsEmpty)  then
  begin
    lQuery.First;

    while (not lQuery.Eof) do
    begin
      lLista.Add(TTipoCombustivel.Create(lQuery.FieldByName('id').Value,
                                         lQuery.FieldByName('nome').Value,
                                         lQuery.FieldByName('valor_litro').Value));

      lQuery.Next;
    end;
  end;

  Result := lLista;
end;

class function TDaoTipoCombustivel.SelectAll: TADOQuery;
var
  lQuery: TADOQuery;
begin
  lQuery := obtemComponenteQuery(GetSqlSelectAll);
  lQuery.Open;
  Result := lQuery;
end;

class function TDaoTipoCombustivel.Update(
  objTipoCombustivel: TTipoCombustivel): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlUpdate);

    lQuery.Parameters.ParamByName('id').Value := objTipoCombustivel.id;
    lQuery.Parameters.ParamByName('nome').Value := objTipoCombustivel.nome;
    lQuery.Parameters.ParamByName('valor_litro').Value := objTipoCombustivel.valor_litro;

    try
      lQuery.Connection.BeginTrans;
      lQuery.ExecSQL;
      lQuery.Connection.CommitTrans;
    except
      lQuery.Connection.RollbackTrans;
      Result := False;
    end;
  finally
    FreeAndNil(lQuery);
  end;
end;

end.
