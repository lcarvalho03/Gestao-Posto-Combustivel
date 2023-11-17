unit UViewBombaCombustivel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, UModelBombaCombustivel;

type
  TFrmBombaCombustivel = class(TForm)
    pnlBotoes: TPanel;
    btnIncluir: TSpeedButton;
    btnGravar: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnFechar: TSpeedButton;
    DBGrid1: TDBGrid;
    pnlEdicao: TPanel;
    edtNome: TEdit;
    lblNome: TLabel;
    lblTanqueCombustivel: TLabel;
    cbbTanqueCombustivel: TComboBox;
    btnExcluir: TSpeedButton;
    DataSource: TDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    objBombaCombustivel: TBombaCombustivel;
  public
    { Public declarations }
  end;

var
  FrmBombaCombustivel: TFrmBombaCombustivel;

const TEXTO_NOME_OBJETO = 'Bomba de Combustível';

implementation

uses ULib, UControllerBombaCombustivel, UModelTanqueCombustivel, UDaoTanqueCombustivel;

{$R *.dfm}

procedure TFrmBombaCombustivel.btnAlterarClick(Sender: TObject);
begin
  objBombaCombustivel.id := DataSource.DataSet.FieldByName('id').Value;
  ControlarEdicaoComponentesForm(FrmBombaCombustivel, TSpeedButton(Sender).tag);
  edtNome.SetFocus;
end;

procedure TFrmBombaCombustivel.btnCancelarClick(Sender: TObject);
begin
  ControlarEdicaoComponentesForm(FrmBombaCombustivel, TSpeedButton(Sender).tag);
  DataSourceDataChange(Sender, DataSource.DataSet.FieldByName('id'));
end;

procedure TFrmBombaCombustivel.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmBombaCombustivel.btnGravarClick(Sender: TObject);
begin
  objBombaCombustivel.InputDados(edtNome.Text, TTanqueCombustivel(cbbTanqueCombustivel.Items.Objects[cbbTanqueCombustivel.ItemIndex]));

  if (objBombaCombustivel.id = 0) then
  begin
    if TControllerBombaCombustivel.Create(objBombaCombustivel) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' criado com sucesso', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerBombaCombustivel.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmBombaCombustivel, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar criar o ' + TEXTO_NOME_OBJETO+ '.', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end
  else
  begin
    if TControllerBombaCombustivel.Update(objBombaCombustivel) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' alterado com sucesso', 'Alteração de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerBombaCombustivel.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmBombaCombustivel, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar alterar o ' + TEXTO_NOME_OBJETO + '.', 'Alteração de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end;
end;

procedure TFrmBombaCombustivel.btnIncluirClick(Sender: TObject);
begin
  objBombaCombustivel.LimpaAtributos;
  edtNome.Clear;
  cbbTanqueCombustivel.ItemIndex := 0;
  ControlarEdicaoComponentesForm(FrmBombaCombustivel, TSpeedButton(Sender).tag);
  edtNome.SetFocus;
end;

procedure TFrmBombaCombustivel.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if (not DataSource.DataSet.IsEmpty) then
  begin
    edtNome.Text := DataSource.DataSet.FieldByName('nome').Value;
    cbbTanqueCombustivel.ItemIndex := cbbTanqueCombustivel.Items.IndexOf(DataSource.DataSet.FieldByName('nome_tanque_combustivel').Value);
  end
  else
  begin
    edtNome.Clear;
    cbbTanqueCombustivel.ItemIndex := 0;
  end;
end;

procedure TFrmBombaCombustivel.FormCreate(Sender: TObject);
begin
  objBombaCombustivel := TBombaCombustivel.Create;
  MontaComboboxTanqueCombustivel(cbbTanqueCombustivel, TDaoTanqueCombustivel.ObtemListaAllObjects)
end;

procedure TFrmBombaCombustivel.FormDestroy(Sender: TObject);
begin
  LimpaObjetosDoCombobox(cbbTanqueCombustivel);
  FreeAndNil(objBombaCombustivel);
end;

procedure TFrmBombaCombustivel.FormShow(Sender: TObject);
begin
  TControllerBombaCombustivel.Read(DataSource);
end;

procedure TFrmBombaCombustivel.btnExcluirClick(Sender: TObject);
begin
  if (Application.MessageBox('Confirma a exclusão do ' + TEXTO_NOME_OBJETO + ' selecionado?', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONQUESTION + MB_YESNO) = ID_YES) then
  begin
    objBombaCombustivel.id := DataSource.DataSet.FieldByName('id').Value;

    if TControllerBombaCombustivel.Delete(objBombaCombustivel) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' excluído com sucesso', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerBombaCombustivel.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmBombaCombustivel, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar excluir o ' + TEXTO_NOME_OBJETO + ' selecionado.', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end;
end;

end.
