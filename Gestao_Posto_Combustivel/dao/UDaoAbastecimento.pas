unit UDaoAbastecimento;

interface

uses UModelAbastecimento, Data.Win.ADODB;

type
  TDaoAbastecimento = class
  private
    class function GetSqlInsert(): string;
    class function GetSqlUpdate(): string;
    class function GetSqlDelete(): string;
    class function GetSqlSelectAll(): string;
    class function GetSqlSelectOne(): string;
  public
    class function Insert(objAbastecimento: TAbastecimento): Boolean;
    class function Update(objAbastecimento: TAbastecimento): Boolean;
    class function Delete(objAbastecimento: TAbastecimento): Boolean;
    class function SelectAll(): TADOQuery;
  end;

implementation

uses ULib, System.SysUtils;

{ TDaoImposto }

class function TDaoAbastecimento.Delete(
  objAbastecimento: TAbastecimento): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlDelete);

    lQuery.Parameters.ParamByName('id').Value := objAbastecimento.id;

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

class function TDaoAbastecimento.GetSqlDelete: string;
begin
  Result := 'DELETE FROM [dbo].[Abastecimento] ' +
            'WHERE ([id] = :id)';
end;

class function TDaoAbastecimento.GetSqlInsert: string;
begin
  Result := 'INSERT INTO [dbo].[Abastecimento] (' +
                '[data_abastecimento]' +
                ',[tanque_combustivel]' +
                ',[bomba_combustivel]' +
                ',[tipo_combustivel]' +
                ',[valor_litro]' +
                ',[qtd_litro_combustivel]' +
                ',[percentual_imposto])' +
            'VALUES (' +
                 ':data_abastecimento' +
                ',:tanque_combustivel' +
                ',:bomba_combustivel' +
                ',:tipo_combustivel' +
                ',:valor_litro' +
                ',:qtd_litro_combustivel' +
                ',:percentual_imposto)';
end;

class function TDaoAbastecimento.GetSqlSelectAll: string;
begin
  Result := 'SELECT ' +
                   'A.[id] ' +
                  ',A.[data_abastecimento] ' +
                  ',A.[bomba_combustivel] ' +
                  ',A.[tipo_combustivel] ' +
                  ',A.[valor_litro] ' +
                  ',A.[tanque_combustivel] ' +
                  ',A.[qtd_litro_combustivel] ' +
                  ',A.[percentual_imposto] ' +
            'FROM [dbo].[Abastecimento] A ' +
            'ORDER BY A.[id]';

{
  Result := 'SELECT ' +
                   'A.[id] ' +
                  ',A.[data_abastecimento] ' +
                  ',A.[tanque_combustivel] ' +
                  ',TC.[nome] AS nome_tanque_combustivel ' +
                  ',A.[bomba_combustivel] ' +
                  ',B.[nome] AS nome_boma_combustivel ' +
                  ',A.[tipo_combustivel] ' +
                  ',U.[nome] AS nome_tipo_combustivel ' +
                  ',A.[valor_litro] ' +
                  ',A.[qtd_litro_combustivel] ' +
                  ',A.[percentual_imposto] ' +
            'FROM [dbo].[Abastecimento] A ' +
                 'INNER JOIN [dbo].[Tanque_Combustivel] TC ON (A.tanque_combustivel = TC.id) ' +
                 'INNER JOIN [dbo].[Bomba_Combustivel] B ON (A.bomba_combustivel = B.id) ' +
                 'INNER JOIN [dbo].[Tipo_Combustivel] U ON (A.tipo_combustivel = U.id) ' +
            'ORDER BY A.[id]';
  }
end;

class function TDaoAbastecimento.GetSqlSelectOne: string;
begin
  Result := 'SELECT ' +
                   'A.[id] ' +
                  ',A.[data_abastecimento] ' +
                  ',A.[tanque_combustivel] ' +
                  ',TC.[nome] AS nome_tanque_combustivel ' +
                  ',A.[bomba_combustivel] ' +
                  ',B.[nome] AS nome_boma_combustivel ' +
                  ',A.[tipo_combustivel] ' +
                  ',U.[nome] AS nome_tipo_combustivel ' +
                  ',A.[valor_litro] ' +
                  ',A.[qtd_litro_combustivel] ' +
                  ',A.[percentual_imposto] ' +
            'FROM [dbo].[Abastecimento] A ' +
                 'INNER JOIN [dbo].[Tanque_Combustivel] TC ON (A.tanque_combustivel = TC.id) ' +
                 'INNER JOIN [dbo].[Bomba_Combustivel] B ON (A.bomba_combustivel = B.id) ' +
                 'INNER JOIN [dbo].[Tipo_Combustivel] U ON (A.tipo_combustivel = U.id) ' +
            'WHERE (A.[id] = :id)';
end;

class function TDaoAbastecimento.GetSqlUpdate: string;
begin
  Result := 'UPDATE [dbo].[Abastecimento] ' +
            'SET [data_abastecimento] = :data_abastecimento ' +
               ',[tanque_combustivel] = :tanque_combustivel ' +
               ',[bomba_combustivel] = :bomba_combustivel ' +
               ',[tipo_combustivel] = :tipo_combustivel ' +
               ',[valor_litro] = :valor_litro ' +
               ',[qtd_litro_combustivel] = :qtd_litro_combustivel ' +
               ',[percentual_imposto] = :percentual_imposto ' +
            'WHERE ([id] = :id)';
end;

class function TDaoAbastecimento.Insert(
  objAbastecimento: TAbastecimento): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlInsert);

    lQuery.Parameters.ParamByName('data_abastecimento').Value := objAbastecimento.data_abastecimento;
    lQuery.Parameters.ParamByName('tanque_combustivel').Value := objAbastecimento.tanque_combustivel;
    lQuery.Parameters.ParamByName('bomba_combustivel').Value := objAbastecimento.bomba_combustivel;
    lQuery.Parameters.ParamByName('tipo_combustivel').Value := objAbastecimento.tipo_combustivel;
    lQuery.Parameters.ParamByName('valor_litro').Value := objAbastecimento.valor_litro;
    lQuery.Parameters.ParamByName('qtd_litro_combustivel').Value := objAbastecimento.qtd_litro_combustivel;
    lQuery.Parameters.ParamByName('percentual_imposto').Value := objAbastecimento.percentual_imposto;

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

class function TDaoAbastecimento.SelectAll: TADOQuery;
var
  lQuery: TADOQuery;
begin
  lQuery := obtemComponenteQuery(GetSqlSelectAll);
  lQuery.Open;
  Result := lQuery;
end;

class function TDaoAbastecimento.Update(objAbastecimento: TAbastecimento): Boolean;
var
  lQuery: TADOQuery;
begin
  Result := True;

  try
    lQuery := ObtemComponenteQuery(GetSqlUpdate);

    lQuery.Parameters.ParamByName('id').Value := objAbastecimento.id;
    lQuery.Parameters.ParamByName('data_abastecimento').Value := objAbastecimento.data_abastecimento;
    lQuery.Parameters.ParamByName('tanque_combustivel').Value := objAbastecimento.tanque_combustivel;
    lQuery.Parameters.ParamByName('bomba_combustivel').Value := objAbastecimento.bomba_combustivel;
    lQuery.Parameters.ParamByName('tipo_combustivel').Value := objAbastecimento.tipo_combustivel;
    lQuery.Parameters.ParamByName('valor_litro').Value := objAbastecimento.valor_litro;
    lQuery.Parameters.ParamByName('qtd_litro_combustivel').Value := objAbastecimento.qtd_litro_combustivel;
    lQuery.Parameters.ParamByName('percentual_imposto').Value := objAbastecimento.percentual_imposto;

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
