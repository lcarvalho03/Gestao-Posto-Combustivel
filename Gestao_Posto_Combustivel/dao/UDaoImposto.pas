unit UDaoImposto;

interface

uses Data.Win.ADODB, UModelImposto;

type
  TDaoImposto = class
  private
    class function GetSqlInsert(): string;
    class function GetSqlUpdate(): string;
    class function GetSqlDelete(): string;
    class function GetSqlSelectAll(): string;
    class function GetSqlSelectOne(): string;
    class function GetSqlSelectAtivo(): string;
  public
    class function Insert(objImposto: TImposto): Boolean;
    class function Update(objImposto: TImposto): Boolean;
    class function Delete(objImposto: TImposto): Boolean;
    class function SelectAll(): TADOQuery;
    class function ObtemImpostoAtivo(): TImposto;
  end;

implementation

uses
  System.SysUtils, ULib;

{ TDaoImposto }

class function TDaoImposto.Delete(objImposto: TImposto): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlDelete);

    lQuery.Parameters.ParamByName('id').Value := objImposto.id;

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

class function TDaoImposto.GetSqlDelete: string;
begin
  Result := 'delete ' +
            'from [dao].[Imposto] ' +
            'where ([id] = :id)';
end;

class function TDaoImposto.GetSqlInsert: string;
begin
  Result := 'INSERT INTO [dbo].[Imposto] (' +
                 '[data_imposto] ' +
                ',[percentual] ' +
                ',[ativo]) ' +
            'VALUES (' +
                 ':data_imposto ' +
                ',:percentual ' +
                ',:ativo)';
end;

class function TDaoImposto.GetSqlSelectAll: string;
begin
  Result := 'SELECT ' +
                '[id], ' +
                '[data_imposto], ' +
                '[percentual], ' +
                '[ativo] ' +
            'FROM [dbo].[Imposto] ' +
            'ORDER BY [data_imposto]';
end;

class function TDaoImposto.GetSqlSelectAtivo: string;
begin
  Result := 'SELECT ' +
                 '[id] ' +
                ',[data_imposto] ' +
                ',[percentual] ' +
                ',[ativo] ' +
            'FROM [dbo].[Imposto] ' +
            'WHERE ([ativo] = 1)';
end;

class function TDaoImposto.GetSqlSelectOne: string;
begin
  Result := 'SELECT ' +
                 '[id] ' +
                ',[data_imposto] ' +
                ',[percentual] ' +
                ',[ativo] ' +
            'FROM [dbo].[Imposto] ' +
            'WHERE ([id] = :id)';
end;

class function TDaoImposto.GetSqlUpdate: string;
begin
  Result := 'UPDATE [dbo].[Imposto] ' +
            'SET  [data_imposto] = :data_imposto ' +
                ',[percentual] = :percentual ' +
                ',[ativo] = :ativo ' +
            'WHERE ([id] = :id)';
end;

class function TDaoImposto.Insert(objImposto: TImposto): Boolean;
var
  lQuery: TADOQuery;
  objImpostoAtivo: TImposto;
begin
  Result := True;
  objImposto := ObtemImpostoAtivo();
  objImposto.ativo := False;

  try
    lQuery := ObtemComponenteQuery(GetSqlInsert);

    lQuery.Parameters.ParamByName('percentual').Value := objImposto.percentual;
    lQuery.Parameters.ParamByName('ativo').Value := objImposto.ativo;
    lQuery.Parameters.ParamByName('data_imposto').Value := objImposto.data_imposto;

    try
      lQuery.Connection.BeginTrans;
      TDaoImposto.Update(objImposto);
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

class function TDaoImposto.ObtemImpostoAtivo: TImposto;
var
  lQuery: TADOQuery;
  lImposto: TImposto;
begin
  lQuery := obtemComponenteQuery(GetSqlSelectAtivo);
  lQuery.Open;

  if (not lQuery.IsEmpty) then
    Result := TImposto.Create(lQuery.FieldByName('id').Value,
                              lQuery.FieldByName('data_imposto').Value,
                              lQuery.FieldByName('percentual').Value,
                              lQuery.FieldByName('ativo').Value)
  else
    Result := TImposto.Create(0,
                              Date,
                              0.00,
                              True);
end;

class function TDaoImposto.SelectAll: TADOQuery;
var
  lQuery: TADOQuery;
begin
  lQuery := obtemComponenteQuery(GetSqlSelectAll);
  lQuery.Open;
  Result := lQuery;
end;

class function TDaoImposto.Update(objImposto: TImposto): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlUpdate);

    lQuery.Parameters.ParamByName('id').Value := objImposto.id;
    lQuery.Parameters.ParamByName('percentual').Value := objImposto.percentual;
    lQuery.Parameters.ParamByName('ativo').Value := objImposto.ativo;
    lQuery.Parameters.ParamByName('data_imposto').Value := objImposto.data_imposto;

    try
      lQuery.ExecSQL;
    except
      Result := False;
    end;
  finally
    FreeAndNil(lQuery);
  end;
end;

end.
