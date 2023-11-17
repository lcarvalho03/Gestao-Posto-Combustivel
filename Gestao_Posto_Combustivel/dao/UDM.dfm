object DM: TDM
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=MSOLEDBSQL.1;Password=$$Teste123$$;Persist Security Inf' +
      'o=True;User ID=sa;Initial Catalog=db_gestao_posto_combustivel;Da' +
      'ta Source=DESKTOP-5GSVM0K;Initial File Name="";Server SPN="";Aut' +
      'hentication="";Access Token=""'
    LoginPrompt = False
    Provider = 'MSOLEDBSQL.1'
    Left = 166
    Top = 168
  end
end
