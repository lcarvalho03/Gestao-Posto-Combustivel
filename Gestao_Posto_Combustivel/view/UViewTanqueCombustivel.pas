unit UViewTanqueCombustivel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, UModelTanqueCombustivel;

type
  TFrmTanqueCombustivel = class(TForm)
    pnlEdicao: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCapacidadeEmLitros: TEdit;
    cbbTipoCombustivel: TComboBox;
    edtNome: TEdit;
    pnlBotoes: TPanel;
    btnIncluir: TSpeedButton;
    btnGravar: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnFechar: TSpeedButton;
    SpeedButton1: TSpeedButton;
    DBGrid1: TDBGrid;
    btnExcluir: TSpeedButton;
    DataSource: TDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edtCapacidadeEmLitrosKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objTanqueCombustivel: TTanqueCombustivel;
    procedure InicializarCamposParaEdicao;
  public
    { Public declarations }
  end;

var
  FrmTanqueCombustivel: TFrmTanqueCombustivel;

const TEXTO_NOME_OBJETO = 'Tanque de Combustível';

implementation

uses ULib, UControllerTanqueCombustivel, UModelTipoCombustivel, UDaoTipoCombustivel;

{$R *.dfm}

procedure TFrmTanqueCombustivel.btnIncluirClick(Sender: TObject);
begin
  objTanqueCombustivel.LimpaAtributos;
  InicializarCamposParaEdicao;
  ControlarEdicaoComponentesForm(FrmTanqueCombustivel, TSpeedButton(Sender).tag);
  edtNome.SetFocus;
end;

procedure TFrmTanqueCombustivel.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if (not DataSource.DataSet.IsEmpty) then
  begin
    edtNome.Text := DataSource.DataSet.FieldByName('nome').Value;
    cbbTipoCombustivel.ItemIndex := cbbTipoCombustivel.Items.IndexOf(DataSource.DataSet.FieldByName('nome_tipo_combustivel').Value);
    edtCapacidadeEmLitros.Text := FormatFloat('#,##0.00', DataSource.DataSet.FieldByName('capacidade_em_litros').Value);
  end
  else
  begin
    edtNome.Clear;
    cbbTipoCombustivel.ItemIndex := 0;
    edtCapacidadeEmLitros.Text := '0,00';
  end;
end;

procedure TFrmTanqueCombustivel.edtCapacidadeEmLitrosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['0'..'9', ',', '.', #8]) then
    key :=#0;
end;

procedure TFrmTanqueCombustivel.FormCreate(Sender: TObject);
begin
  objTanqueCombustivel := TTanqueCombustivel.Create;
  MontaComboboxTipoCombustivel(cbbTipoCombustivel, TDaoTipoCombustivel.ObtemListaAllObjects)
end;

procedure TFrmTanqueCombustivel.FormDestroy(Sender: TObject);
begin
  LimpaObjetosDoCombobox(cbbTipoCombustivel);
  FreeAndNil(objTanqueCombustivel);
end;

procedure TFrmTanqueCombustivel.FormShow(Sender: TObject);
begin
  TControllerTanqueCombustivel.Read(DataSource);
end;

procedure TFrmTanqueCombustivel.SpeedButton1Click(Sender: TObject);
begin
  ControlarEdicaoComponentesForm(FrmTanqueCombustivel, TSpeedButton(Sender).tag);
  DataSourceDataChange(Sender, DataSource.DataSet.FieldByName('id'));
end;

procedure TFrmTanqueCombustivel.InicializarCamposParaEdicao;
begin
  edtNome.Clear;
  edtCapacidadeEmLitros.Text := '0,00';
  cbbTipoCombustivel.ItemIndex := 0;
end;

procedure TFrmTanqueCombustivel.btnAlterarClick(Sender: TObject);
begin
  objTanqueCombustivel.id := DataSource.DataSet.FieldByName('id').Value;
  ControlarEdicaoComponentesForm(FrmTanqueCombustivel, TSpeedButton(Sender).tag);
  edtNome.SetFocus;
end;

procedure TFrmTanqueCombustivel.btnExcluirClick(Sender: TObject);
begin
  if (Application.MessageBox('Confirma a exclusão do ' + TEXTO_NOME_OBJETO + ' selecionado?', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONQUESTION + MB_YESNO) = ID_YES) then
  begin
    objTanqueCombustivel.id := DataSource.DataSet.FieldByName('id').Value;

    if TControllerTanqueCombustivel.Delete(objTanqueCombustivel) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' excluído com sucesso', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerTanqueCombustivel.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmTanqueCombustivel, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar excluir o ' + TEXTO_NOME_OBJETO + ' selecionado.', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end;
end;

procedure TFrmTanqueCombustivel.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmTanqueCombustivel.btnGravarClick(Sender: TObject);
begin
  objTanqueCombustivel.InputDados(edtNome.Text, TTipoCombustivel(cbbTipoCombustivel.Items.Objects[cbbTipoCombustivel.ItemIndex]), ObtemDoubleFromString(edtCapacidadeEmLitros.Text));

  if (objTanqueCombustivel.id = 0) then
  begin
    if TControllerTanqueCombustivel.Create(objTanqueCombustivel) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' criado com sucesso', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerTanqueCombustivel.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmTanqueCombustivel, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar criar o ' + TEXTO_NOME_OBJETO+ '.', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end
  else
  begin
    if TControllerTanqueCombustivel.Update(objTanqueCombustivel) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' alterado com sucesso', 'Alteração de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerTanqueCombustivel.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmTanqueCombustivel, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar alterar o ' + TEXTO_NOME_OBJETO + '.', 'Alteração de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end;
end;

end.
