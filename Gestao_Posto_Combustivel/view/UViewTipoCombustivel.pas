unit UViewTipoCombustivel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, UModelTipoCombustivel;

type
  TFrmTipoCombustivel = class(TForm)
    pnlBotoes: TPanel;
    btnIncluir: TSpeedButton;
    btnGravar: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnFechar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnExcluir: TSpeedButton;
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    pnlEdicao: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtValorLitro: TEdit;
    edtNome: TEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorLitroKeyPress(Sender: TObject; var Key: Char);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    { Private declarations }
    objTipoCombustivel: TTipoCombustivel;
    procedure InicializarCamposParaEdicao;
  public
    { Public declarations }
  end;

var
  FrmTipoCombustivel: TFrmTipoCombustivel;

const TEXTO_NOME_OBJETO = 'Tipo de Combustível';

implementation

uses ULib, UControllerTipoCombustivel;

{$R *.dfm}

procedure TFrmTipoCombustivel.btnAlterarClick(Sender: TObject);
begin
  objTipoCombustivel.id := DataSource.DataSet.FieldByName('id').Value;
  ControlarEdicaoComponentesForm(FrmTipoCombustivel, TSpeedButton(Sender).tag);
  edtNome.SetFocus;
end;

procedure TFrmTipoCombustivel.btnCancelarClick(Sender: TObject);
begin
  ControlarEdicaoComponentesForm(FrmTipoCombustivel, TSpeedButton(Sender).tag);
  DataSourceDataChange(Sender, DataSource.DataSet.FieldByName('id'));
end;

procedure TFrmTipoCombustivel.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmTipoCombustivel.btnGravarClick(Sender: TObject);
begin
  objTipoCombustivel.InputDados(edtNome.Text, StrToFloat(edtValorLitro.Text));


  if (objTipoCombustivel.id = 0) then
  begin
    if TControllerTipoCombustivel.Create(objTipoCombustivel) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' criado com sucesso.', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerTipoCombustivel.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmTipoCombustivel, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar criar o ' + TEXTO_NOME_OBJETO + '.', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end
  else
  begin
    if TControllerTipoCombustivel.Update(objTipoCombustivel) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' alterado com sucesso.', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerTipoCombustivel.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmTipoCombustivel, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar alterar o ' + TEXTO_NOME_OBJETO + '.', 'Alteração de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end;
end;

procedure TFrmTipoCombustivel.btnIncluirClick(Sender: TObject);
begin
  objTipoCombustivel.LimpaAtributos;
  InicializarCamposParaEdicao;
  ControlarEdicaoComponentesForm(FrmTipoCombustivel, TSpeedButton(Sender).tag);
  edtNome.SetFocus;
end;

procedure TFrmTipoCombustivel.InicializarCamposParaEdicao;
begin
  edtNome.Clear;
  edtValorLitro.Text := '0,00';
end;

procedure TFrmTipoCombustivel.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if (not DataSource.DataSet.IsEmpty) then
  begin
    edtNome.Text := DataSource.DataSet.FieldByName('nome').Value;
    edtValorLitro.Text := FormatFloat('#,##0.00', DataSource.DataSet.FieldByName('valor_litro').Value);
  end
  else
  begin
    edtNome.Clear;
    edtValorLitro.Text := '0,00';
  end;
end;

procedure TFrmTipoCombustivel.edtValorLitroKeyPress(Sender: TObject;
  var Key: Char);
begin
  // Permitir somente números, ponto e vírgula.
  if not (key in ['0'..'9', ',', '.', #8]) then
    key :=#0;
end;

procedure TFrmTipoCombustivel.FormCreate(Sender: TObject);
begin
  objTipoCombustivel := TTipoCombustivel.Create;
end;

procedure TFrmTipoCombustivel.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objTipoCombustivel);
end;

procedure TFrmTipoCombustivel.FormShow(Sender: TObject);
begin
  TControllerTipoCombustivel.Read(DataSource);
end;

procedure TFrmTipoCombustivel.btnExcluirClick(Sender: TObject);
begin
  if (Application.MessageBox('Confirma a exclusão do ' + TEXTO_NOME_OBJETO + ' selecionado?', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONQUESTION + MB_YESNO) = ID_YES) then
  begin
    objTipoCombustivel.id := DataSource.DataSet.FieldByName('id').Value;

    if TControllerTipoCombustivel.Delete(objTipoCombustivel) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' excluído com sucesso', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerTipoCombustivel.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmTipoCombustivel, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar excluir o ' + TEXTO_NOME_OBJETO + ' selecionado.', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end;
end;

end.
