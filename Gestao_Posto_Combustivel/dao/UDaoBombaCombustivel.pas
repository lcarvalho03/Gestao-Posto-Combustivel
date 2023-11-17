unit UDaoBombaCombustivel;

interface

uses
  UModelBombaCombustivel, Data.Win.ADODB, System.Generics.Collections;

type
  TDaoBombaCombustivel = class
  private
    class function GetSqlInsert(): string;
    class function GetSqlUpdate(): string;
    class function GetSqlDelete(): string;
    class function GetSqlSelectAll(): string;
    class function GetSqlSelectOne(): string;
  public
    class function Insert(objBombaCombustivel: TBombaCombustivel): Boolean;
    class function Update(objBombaCombustivel: TBombaCombustivel): Boolean;
    class function Delete(objBombaCombustivel: TBombaCombustivel): Boolean;
    class function SelectAll(): TADOQuery;
    class function ObtemListaAllObjects(): TObjectList<TBombaCombustivel>;
  end;

implementation

uses ULib, UModelTanqueCombustivel, UModelTipoCombustivel, System.SysUtils;

{ TDaoBombaCombustivel }

class function TDaoBombaCombustivel.Delete(
  objBombaCombustivel: TBombaCombustivel): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlDelete);

    lQuery.Parameters.ParamByName('id').Value := objBombaCombustivel.id;

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

class function TDaoBombaCombustivel.GetSqlDelete: string;
begin
  Result := 'DELETE FROM [dbo].[Bomba_Combustivel] ' +
            'WHERE ([id] = :id)';
end;

class function TDaoBombaCombustivel.GetSqlInsert: string;
begin
  Result := 'INSERT INTO [dbo].[Bomba_Combustivel] (' +
                '[nome], ' +
                '[tanque_combustivel]) ' +
            'VALUES (' +
                ':nome, ' +
                ':tanque_combustivel)';
end;

class function TDaoBombaCombustivel.GetSqlSelectAll: string;
begin
  Result := 'SELECT B.[id] ' +
                  ',B.[nome] ' +
                  ',B.[tanque_combustivel] ' +
                  ',TC.[nome] AS nome_tanque_combustivel ' +
                  ',TC.[tipo_combustivel] ' +
                  ',U.[nome] AS nome_tipo_combustivel ' +
                  ',U.[valor_litro] ' +
            'FROM [dbo].[Bomba_Combustivel] B ' +
                 'INNER JOIN [dbo].[Tanque_Combustivel] TC ON (B.[tanque_combustivel] = TC.[id]) ' +
                 'INNER JOIN [dbo].[Tipo_Combustivel] U ON (TC.[tipo_combustivel] = U.[id]) ' +
            'ORDER BY TC.[nome], B.[nome]';
end;

class function TDaoBombaCombustivel.GetSqlSelectOne: string;
begin
  Result := 'SELECT B.[id] ' +
                  ',B.[nome] ' +
                  ',B.[tanque_combustivel] ' +
                  ',TC.[nome] AS nome_tanque_combustivel ' +
                  ',U.[nome] AS nome_tipo_combustivel ' +
            'FROM [dbo].[Bomba_Combustivel] B ' +
                 'INNER JOIN [dbo].[Tanque_Combustivel] TC ON (B.[tanque_combustivel] = TC.id) ' +
                 'INNER JOIN [dbo].[Tipo_Combustivel] U ON (B.[tanque_combustivel] = U.id) ' +
            'WHERE (TC.[id] = :id)';
end;

class function TDaoBombaCombustivel.GetSqlUpdate: string;
begin
  Result := 'UPDATE [dbo].[Bomba_Combustivel] ' +
            'SET [nome] = :nome, ' +
                '[tanque_combustivel] = :tanque_combustivel ' +
            'WHERE ([id] = :id)';
end;

class function TDaoBombaCombustivel.Insert(
  objBombaCombustivel: TBombaCombustivel): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlInsert);

    lQuery.Parameters.ParamByName('nome').Value := objBombaCombustivel.nome;
    lQuery.Parameters.ParamByName('tanque_combustivel').Value := TTanqueCombustivel(objBombaCombustivel.tanque_combustivel).id;

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

class function TDaoBombaCombustivel.ObtemListaAllObjects: TObjectList<TBombaCombustivel>;
var
  lLista: TObjectList<TBombaCombustivel>;
  lQuery: TADOQuery;
begin
  lLista := TObjectList<TBombaCombustivel>.Create;
  lLista.Add(TBombaCombustivel.Create(0,
                                     '',
                                     TTanqueCombustivel.Create));
  lQuery := obtemComponenteQuery(GetSqlSelectAll);
  lQuery.Open;

  if (not lQuery.IsEmpty)  then
  begin
    lQuery.First;

    while (not lQuery.Eof) do
    begin
      lLista.Add(TBombaCombustivel.Create(lQuery.FieldByName('id').Value,
                                          lQuery.FieldByName('nome').Value,
                                          TTanqueCombustivel.Create(lQuery.FieldByName('tanque_combustivel').Value,
                                                                    lQuery.FieldByName('nome_tanque_combustivel').Value,
                                                                    TTipoCombustivel.Create(lQuery.FieldByName('tipo_combustivel').Value,
                                                                                            lQuery.FieldByName('nome_tipo_combustivel').Value,
                                                                                            lQuery.FieldByName('valor_litro').Value),
                                                                     0.00)));

      lQuery.Next;
    end;
  end;

  Result := lLista;
end;

class function TDaoBombaCombustivel.SelectAll: TADOQuery;
var
  lQuery: TADOQuery;
begin
  lQuery := obtemComponenteQuery(GetSqlSelectAll);
  lQuery.Open;
  Result := lQuery;
end;

class function TDaoBombaCombustivel.Update(
  objBombaCombustivel: TBombaCombustivel): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlUpdate);

    lQuery.Parameters.ParamByName('id').Value := objBombaCombustivel.id;
    lQuery.Parameters.ParamByName('nome').Value := objBombaCombustivel.nome;
    lQuery.Parameters.ParamByName('tanque_combustivel').Value := objBombaCombustivel.tanque_combustivel.id;

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
