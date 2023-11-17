unit UViewImposto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.ExtCtrls, UModelImposto;

type
  TFrmImposto = class(TForm)
    pnlBotoes: TPanel;
    btnIncluir: TSpeedButton;
    btnGravar: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnFechar: TSpeedButton;
    DBGrid: TDBGrid;
    pnlEdicao: TPanel;
    Label1: TLabel;
    dtpImposto: TDateTimePicker;
    Label2: TLabel;
    edtPercentual: TEdit;
    DataSource: TDataSource;
    ckbAtivo: TCheckBox;
    btnCancelar: TSpeedButton;
    btnExcluir: TSpeedButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtPercentualKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    objImposto: TImposto;
    procedure InicializarCamposParaEdicao;
  public
    { Public declarations }
  end;

var
  FrmImposto: TFrmImposto;

const TEXTO_NOME_OBJETO = 'Imposto';


implementation

uses ULib, UControllerImposto, System.SysUtils;

{$R *.dfm}

procedure TFrmImposto.btnAlterarClick(Sender: TObject);
begin
  objImposto.id := DataSource.DataSet.FieldByName('id').Value;
  ControlarEdicaoComponentesForm(FrmImposto, TSpeedButton(Sender).tag);
  ckbAtivo.Enabled := False;
  dtpImposto.SetFocus;
end;

procedure TFrmImposto.btnGravarClick(Sender: TObject);
begin
  objImposto.InputDados(dtpImposto.DateTime, StrToFloat(edtPercentual.Text), ckbAtivo.Checked);

  if (objImposto.id = 0) then
  begin
    if TControllerImposto.Create(objImposto) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' criado com sucesso', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerImposto.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmImposto, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar criar o ' + TEXTO_NOME_OBJETO+ '.', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end
  else
  begin
    if TControllerImposto.Update(objImposto) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' alterado com sucesso', 'Alteração de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerImposto.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmImposto, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar alterar o ' + TEXTO_NOME_OBJETO + '.', 'Alteração de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end;
end;

procedure TFrmImposto.btnIncluirClick(Sender: TObject);
begin
  objImposto.LimpaAtributos;
  InicializarCamposParaEdicao;
  ControlarEdicaoComponentesForm(FrmImposto, TSpeedButton(Sender).tag);
  dtpImposto.SetFocus;
end;

procedure TFrmImposto.btnCancelarClick(Sender: TObject);
begin
  ControlarEdicaoComponentesForm(FrmImposto, TSpeedButton(Sender).tag);
  DataSourceDataChange(Sender, DataSource.DataSet.FieldByName('id'));
end;

procedure TFrmImposto.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmImposto.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  if (not DataSource.DataSet.IsEmpty) then
  begin
    dtpImposto.Date := DataSource.DataSet.FieldByName('data_imposto').Value;
    edtPercentual.Text := FormatFloat('#,##0.00', DataSource.DataSet.FieldByName('percentual').Value);
    ckbAtivo.Checked := DataSource.DataSet.FieldByName('ativo').Value;
  end
  else
  begin
    dtpImposto.Date := Date;
    edtPercentual.Text := '0,00';
    ckbAtivo.Checked := True;
  end;
end;

procedure TFrmImposto.edtPercentualKeyPress(Sender: TObject; var Key: Char);
begin
  // Permitir somente números, ponto e vírgula.
  if not (key in ['0'..'9', ',', '.', #8]) then
    key :=#0;
end;

procedure TFrmImposto.FormCreate(Sender: TObject);
begin
  objImposto := TImposto.Create;
end;

procedure TFrmImposto.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objImposto);
end;

procedure TFrmImposto.FormShow(Sender: TObject);
begin
  dtpImposto.Date := Date;
  TControllerImposto.Read(DataSource);
end;

procedure TFrmImposto.btnExcluirClick(Sender: TObject);
begin
  if (Application.MessageBox('Confirma a exclusão do ' + TEXTO_NOME_OBJETO + ' selecionado?', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONQUESTION + MB_YESNO) = ID_YES) then
  begin
    objImposto.id := DataSource.DataSet.FieldByName('id').Value;

    if TControllerImposto.Delete(objImposto) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' excluído com sucesso', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerImposto.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmImposto, 2);
    end
    else
      Application.MessageBox('Falha ao tentar excluir o ' + TEXTO_NOME_OBJETO + ' selecionado.', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end;
end;

procedure TFrmImposto.InicializarCamposParaEdicao;
begin
  dtpImposto.Date := Date;
  edtPercentual.Text := '0,00';
  ckbAtivo.Checked := True;
end;

end.
