unit UDaoTanqueCombustivel;

interface

uses UModelTanqueCombustivel, Data.Win.ADODB, System.Generics.Collections;

type
  TDaoTanqueCombustivel = class
  private
    class function GetSqlInsert(): string;
    class function GetSqlUpdate(): string;
    class function GetSqlDelete(): string;
    class function GetSqlSelectAll(): string;
    class function GetSqlSelectOne(): string;
  public
    class function Insert(objTanqueCombustivel: TTanqueCombustivel): Boolean;
    class function Update(objTanqueCombustivel: TTanqueCombustivel): Boolean;
    class function Delete(objTanqueCombustivel: TTanqueCombustivel): Boolean;
    class function SelectAll(): TADOQuery;
    class function ObtemListaAllObjects(): TObjectList<TTanqueCombustivel>;
  end;

implementation

uses ULib, System.SysUtils, UModelTipoCombustivel;

{ TDaoTanqueCombustivel }

class function TDaoTanqueCombustivel.GetSqlDelete: string;
begin
  Result := 'DELETE FROM [dbo].[Tanque_Combustivel] ' +
            'WHERE ([id] = :id)';
end;

class function TDaoTanqueCombustivel.GetSqlInsert: string;
begin
  Result := 'INSERT INTO [dbo].[Tanque_Combustivel] (' +
                '[nome], ' +
                '[tipo_combustivel], ' +
                '[capacidade_em_litros]) ' +
            'VALUES (' +
                ':nome, ' +
                ':tipo_combustivel, ' +
                ':capacidade_em_litros)';
end;

class function TDaoTanqueCombustivel.GetSqlSelectAll: string;
begin
  Result := 'SELECT TC.[id], ' +
                   'TC.[nome], ' +
                   'TC.[tipo_combustivel], ' +
                   'U.[nome] AS nome_tipo_combustivel, ' +
                   'TC.[capacidade_em_litros] ' +
            'FROM [dbo].[Tanque_Combustivel] TC ' +
                 'INNER JOIN [dbo].[Tipo_Combustivel] U ON (TC.[tipo_combustivel] = U.[id]) ' +
            'ORDER BY U.[nome], TC.[nome]';
end;

class function TDaoTanqueCombustivel.GetSqlSelectOne: string;
begin
  Result := 'SELECT TC.[id], ' +
                   'TC.[nome], ' +
                   'TC.[tipo_combustivel], ' +
                   'U.[nome] AS nome_tipo_combustivel, ' +
                   'TC.[capacidade_em_litros] ' +
            'FROM [dbo].[Tanque_Combustivel] TC ' +
                 'INNER JOIN [dbo].[Tipo_Combustivel] U ON (TC.[tipo_combustivel] = U.[id]) ' +
            'WHERE (TC.[id] = :id)';
end;

class function TDaoTanqueCombustivel.GetSqlUpdate: string;
begin
  Result := 'UPDATE [dbo].[Tanque_Combustivel] ' +
            'SET [nome] = :nome, ' +
                '[tipo_combustivel] = :tipo_combustivel, ' +
                '[capacidade_em_litros] = :capacidade_em_litros ' +
            'WHERE ([id] = :id)';
end;

class function TDaoTanqueCombustivel.Insert(
  objTanqueCombustivel: TTanqueCombustivel): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlInsert);

    lQuery.Parameters.ParamByName('nome').Value := objTanqueCombustivel.nome;
    lQuery.Parameters.ParamByName('tipo_combustivel').Value := TTipoCombustivel(objTanqueCombustivel.tipo_combustivel).id;
    lQuery.Parameters.ParamByName('capacidade_em_litros').Value := objTanqueCombustivel.capacidade_em_litros;

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

class function TDaoTanqueCombustivel.ObtemListaAllObjects: TObjectList<TTanqueCombustivel>;
var
  lLista: TObjectList<TTanqueCombustivel>;
  lQuery: TADOQuery;
begin
  lLista := TObjectList<TTanqueCombustivel>.Create;
  lLista.Add(TTanqueCombustivel.Create(0,
                                     '',
                                     TTipoCombustivel.Create,
                                     0.00));
  lQuery := obtemComponenteQuery(GetSqlSelectAll);
  lQuery.Open;

  if (not lQuery.IsEmpty)  then
  begin
    lQuery.First;

    while (not lQuery.Eof) do
    begin
      lLista.Add(TTanqueCombustivel.Create(lQuery.FieldByName('id').Value,
                                           lQuery.FieldByName('nome').Value,
                                           TTipoCombustivel.Create(lQuery.FieldByName('tipo_combustivel').Value,
                                                                   '',
                                                                   0.00),
                                           lQuery.FieldByName('capacidade_em_litros').Value));

      lQuery.Next;
    end;
  end;

  Result := lLista;
end;

class function TDaoTanqueCombustivel.SelectAll: TADOQuery;
var
  lQuery: TADOQuery;
begin
  lQuery := obtemComponenteQuery(GetSqlSelectAll);
  lQuery.Open;
  Result := lQuery;
end;

class function TDaoTanqueCombustivel.Update(objTanqueCombustivel: TTanqueCombustivel): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlUpdate);

    lQuery.Parameters.ParamByName('id').Value := objTanqueCombustivel.id;
    lQuery.Parameters.ParamByName('nome').Value := objTanqueCombustivel.nome;
    lQuery.Parameters.ParamByName('tipo_combustivel').Value := objTanqueCombustivel.tipo_combustivel.id;
    lQuery.Parameters.ParamByName('capacidade_em_litros').Value := objTanqueCombustivel.capacidade_em_litros;

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

class function TDaoTanqueCombustivel.Delete(objTanqueCombustivel: TTanqueCombustivel): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlDelete);

    lQuery.Parameters.ParamByName('id').Value := objTanqueCombustivel.id;

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
