unit UViewAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, UModelAbastecimento,
  UModelImposto;

type
  TFrmAbastecimento = class(TForm)
    pnlBotoes: TPanel;
    btnIncluir: TSpeedButton;
    btnGravar: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnFechar: TSpeedButton;
    DBGrid1: TDBGrid;
    pnlEdicao: TPanel;
    edtValorLitro: TEdit;
    Label1: TLabel;
    cbbBombaCombustivel: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dtpAbastecimento: TDateTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    edtQtdLitros: TEdit;
    Label7: TLabel;
    edtPercentualImposto: TEdit;
    Label8: TLabel;
    edtValorImposto: TEdit;
    btnExcluir: TSpeedButton;
    DataSource: TDataSource;
    Label9: TLabel;
    edtValorTotal: TEdit;
    edtTipoCombustivel: TEdit;
    edtTanqueCombustivel: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cbbBombaCombustivelSelect(Sender: TObject);
    procedure edtQtdLitrosChange(Sender: TObject);
    procedure edtQtdLitrosKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objAbastecimento: TAbastecimento;
    objImposto: TImposto;
    procedure InicializarCamosParaEdicao;
    function CalculaValorImposto(valor_total, percentual_imposto: Double): Double;
  public
    { Public declarations }
    function CalculaValorTotal(valor_litro, qtd_litros: Double): Double;
  end;

var
  FrmAbastecimento: TFrmAbastecimento;

const TEXTO_NOME_OBJETO = 'Registro de Abastecimento';

implementation

uses ULib, UControllerAbastecimento, UDaoBombaCombustivel,
  UModelBombaCombustivel, UControllerImposto;

{$R *.dfm}

procedure TFrmAbastecimento.btnAlterarClick(Sender: TObject);
begin
  objAbastecimento.id := DataSource.DataSet.FieldByName('id').Value;
  ControlarEdicaoComponentesForm(FrmAbastecimento, TSpeedButton(Sender).tag);
  dtpAbastecimento.SetFocus;
end;

procedure TFrmAbastecimento.InicializarCamosParaEdicao;
begin
  dtpAbastecimento.Date := Date;
  cbbBombaCombustivel.ItemIndex := 0;
  edtQtdLitros.Text := '0,00';
  edtValorTotal.Text := '0,00';
end;

procedure TFrmAbastecimento.btnCancelarClick(Sender: TObject);
begin
  ControlarEdicaoComponentesForm(FrmAbastecimento, TSpeedButton(Sender).tag);
  DataSourceDataChange(Sender, DataSource.DataSet.FieldByName('id'));
end;

procedure TFrmAbastecimento.btnExcluirClick(Sender: TObject);
begin
  if (Application.MessageBox('Confirma a exclusão do ' + TEXTO_NOME_OBJETO + ' selecionado?', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONQUESTION + MB_YESNO) = ID_YES) then
  begin
    objAbastecimento.id := DataSource.DataSet.FieldByName('id').Value;

    if TControllerAbastecimento.Delete(objAbastecimento) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' excluído com sucesso', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerAbastecimento.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmAbastecimento, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar excluir o ' + TEXTO_NOME_OBJETO + ' selecionado.', 'Exclusão de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end;
end;

procedure TFrmAbastecimento.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmAbastecimento.btnGravarClick(Sender: TObject);
begin
  objAbastecimento.InputDados(dtpAbastecimento.DateTime,
                              edtTanqueCombustivel.Text,
                              TBombaCombustivel(cbbBombaCombustivel.Items.Objects[cbbBombaCombustivel.ItemIndex]).nome,
                              edtTipoCombustivel.Text,
                              ObtemDoubleFromString(edtValorLitro.Text),
                              ObtemDoubleFromString(edtQtdLitros.Text),
                              ObtemDoubleFromString(edtPercentualImposto.Text));

  if (objAbastecimento.id = 0) then
  begin
    if TControllerAbastecimento.Create(objAbastecimento) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' criado com sucesso', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerAbastecimento.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmAbastecimento, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar criar o ' + TEXTO_NOME_OBJETO+ '.', 'Criação de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end
  else
  begin
    if TControllerAbastecimento.Update(objAbastecimento) then
    begin
      Application.MessageBox(TEXTO_NOME_OBJETO + ' alterado com sucesso', 'Alteração de ' + TEXTO_NOME_OBJETO, MB_ICONEXCLAMATION);
      TControllerAbastecimento.Read(DataSource);
      ControlarEdicaoComponentesForm(FrmAbastecimento, TSpeedButton(Sender).tag);
    end
    else
      Application.MessageBox('Falha ao tentar alterar o ' + TEXTO_NOME_OBJETO + '.', 'Alteração de ' + TEXTO_NOME_OBJETO, MB_ICONERROR);
  end;
end;

procedure TFrmAbastecimento.btnIncluirClick(Sender: TObject);
begin
  objAbastecimento.LimpaAtributos;
  InicializarCamosParaEdicao;
  ControlarEdicaoComponentesForm(FrmAbastecimento, TSpeedButton(Sender).tag);
  dtpAbastecimento.SetFocus;
end;

function TFrmAbastecimento.CalculaValorImposto(valor_total,
  percentual_imposto: Double): Double;
begin
  if (valor_total > 0.00) then
      Result := (valor_total * percentual_imposto / 100)
  else
    Result := 0.00;
end;

function TFrmAbastecimento.CalculaValorTotal(valor_litro,
  qtd_litros: Double): Double;
begin
  if (qtd_litros > 0.00) then
      Result := (valor_litro * qtd_litros)
  else
    Result := 0.00;
end;

procedure TFrmAbastecimento.cbbBombaCombustivelSelect(Sender: TObject);
begin
  edtTanqueCombustivel.Text := TBombaCombustivel(cbbBombaCombustivel.Items.Objects[cbbBombaCombustivel.ItemIndex]).tanque_combustivel.nome;
  edtTipoCombustivel.Text := TBombaCombustivel(cbbBombaCombustivel.Items.Objects[cbbBombaCombustivel.ItemIndex]).tanque_combustivel.tipo_combustivel.nome;
  edtValorLitro.Text := FormatFloat('#,##0.00', TBombaCombustivel(cbbBombaCombustivel.Items.Objects[cbbBombaCombustivel.ItemIndex]).tanque_combustivel.tipo_combustivel.valor_litro);
end;

procedure TFrmAbastecimento.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if (not DataSource.DataSet.IsEmpty) then
  begin
    dtpAbastecimento.Date := DataSource.DataSet.FieldByName('data_abastecimento').Value;
    cbbBombaCombustivel.ItemIndex := cbbBombaCombustivel.Items.IndexOf(DataSource.DataSet.FieldByName('bomba_combustivel').Value);
    cbbBombaCombustivelSelect(cbbBombaCombustivel);
    edtQtdLitros.Text := FormatFloat('#,##0.00', DataSource.DataSet.FieldByName('qtd_litro_combustivel').Value);
    edtQtdLitrosChange(edtQtdLitros);

    //edtValorTotal.Text := FormatFloat('#,##0.00', (DataSource.DataSet.FieldByName('qtd_litro_combustivel').Value *                                                   2));
  end
  else
  begin
    dtpAbastecimento.Date := Date;
    cbbBombaCombustivel.ItemIndex := 0;
    cbbBombaCombustivelSelect(cbbBombaCombustivel);
    edtQtdLitros.Text := '0,00';
    edtQtdLitrosChange(edtQtdLitros);
    //edtValorTotal.Text := '0,00';
  end;
end;

procedure TFrmAbastecimento.edtQtdLitrosChange(Sender: TObject);
var
  lValorTotal: Double;
  lValorImposto: Double;
begin
  lValorTotal := CalculaValorTotal(TBombaCombustivel(cbbBombaCombustivel.Items.Objects[cbbBombaCombustivel.ItemIndex]).tanque_combustivel.tipo_combustivel.valor_litro,
                                   ObtemDoubleFromString(edtQtdLitros.Text));

  lValorImposto := CalculaValorImposto(lValorTotal, objImposto.percentual);

  edtValorTotal.Text := FormatFloat('#,##0.00', lValorTotal);

  edtValorImposto.Text := FormatFloat('#,##0.00', lValorImposto);
end;

procedure TFrmAbastecimento.edtQtdLitrosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['0'..'9', ',', '.', #8]) then
    key :=#0;
end;

procedure TFrmAbastecimento.FormCreate(Sender: TObject);
begin
  objAbastecimento := TAbastecimento.Create;
  objImposto := TControllerImposto.ObtemImpostoAtivo();
  MontaComboboxBombaCombustivel(cbbBombaCombustivel, TDaoBombaCombustivel.ObtemListaAllObjects);
end;

procedure TFrmAbastecimento.FormDestroy(Sender: TObject);
begin
  LimpaObjetosDoCombobox(cbbBombaCombustivel);
  FreeAndNil(objImposto);
  FreeAndNil(objAbastecimento);
end;

procedure TFrmAbastecimento.FormShow(Sender: TObject);
begin
  edtPercentualImposto.Text := FormatFloat('#,##0.00', objImposto.percentual);
  TControllerAbastecimento.Read(DataSource);
end;

end.
