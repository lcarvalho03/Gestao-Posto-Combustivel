unit UDM;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, Data.Win.ADODB;

type
  TDM = class(TDataModule)
    ADOConnection: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function ConectaDatabase(): Boolean;
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses
  System.IniFiles, System.SysUtils, Vcl.Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

function TDM.ConectaDatabase: Boolean;
var
  caminho : String;
  servidor, banco, usuario, senha, porta, driverServidor, nomeEstacao : string;
  arquivoIni : TIniFile;
begin
  ADOConnection.Connected := False;

  //verifica se o arq_conf existe
  //if not FileExists(ExtractFilePath(Application.ExeName) + 'arq_conf.ini') then // Testando se o arquivo arq_conf.INI existe.
  //begin
    //MessageDlg('O arquivo de configuração não foi localizado', mtError, mbOKCancel, 0);

    // Chamando form2 para a criação do arquivo.
    //F_CriarConexao.ShowModal;
  //end
  //else
  begin

    // Procura o arq_conf.ini
    arquivoIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'arquivo_configuracoes.ini');

    servidor := arquivoIni.ReadString('conexao_adoconnection', 'servidor', '');
    driverservidor := arquivoIni.ReadString('conexao_adoconnection', 'driver', '');
    porta := arquivoIni.ReadString('conexao_adoconnection', 'port', '');
    banco := arquivoIni.ReadString('conexao_adoconnection', 'database', '');
    usuario := arquivoIni.ReadString('conexao_adoconnection', 'user', '');
    senha := arquivoIni.ReadString('conexao_adoconnection', 'password', '');

    ADOConnection.ConnectionString := 'Provider=' + driverServidor + ';' +
                                      'Password=' + senha + ';' +
                                      'Persist Security Info=True;' +
                                      'User ID=' + usuario + ';' +
                                      'Initial Catalog=' + banco + ';' +
                                      'Data Source=' + servidor + ';' +
                                      'Initial File Name="";' +
                                      'Server SPN="";' +
                                      'Authentication="";' +
                                      'Access Token=""';
  end;

  try
    ADOConnection.Connected := true;
    Result := True;
  except
    Result := False;
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  if not ConectaDatabase then
  begin
    Application.MessageBox(PWideChar('Falha ao tentar conectar no Servidor de Banco de Dados SQL Server.'),
                           PWideChar('Conexão com o Servidor de Banco de Dados'));
  end;
end;

end.
