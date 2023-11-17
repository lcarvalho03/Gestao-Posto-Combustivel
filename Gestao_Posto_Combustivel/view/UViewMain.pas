unit UViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  UViewAbastecimento, UViewBombaCombustivel, UViewImposto, UViewTanqueCombustivel,
  UFrameBaseCadastro, UViewTeste, UViewTipoCombustivel,
  UViewRptAbastecimentoDiaTanqueBomba;

type
  TFrmMain = class(TForm)
    MainMenu1: TMainMenu;
    Cadastr1: TMenuItem;
    Abastecimento2: TMenuItem;
    Sair1: TMenuItem;
    anquedeCombustvel1: TMenuItem;
    BombadeCombustvel1: TMenuItem;
    Abastecimento3: TMenuItem;
    Imposto1: TMenuItem;
    ipodeCombustvel1: TMenuItem;
    AbastecimentoporDiaTanqueBomba1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure anquedeCombustvel1Click(Sender: TObject);
    procedure Imposto1Click(Sender: TObject);
    procedure Abastecimento3Click(Sender: TObject);
    procedure BombadeCombustvel1Click(Sender: TObject);
    procedure ipodeCombustvel1Click(Sender: TObject);
    procedure AbastecimentoporDiaTanqueBomba1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.Abastecimento3Click(Sender: TObject);
var
  form: TFrmAbastecimento;
begin
  try
    Application.CreateForm(TFrmAbastecimento, form);
    FrmAbastecimento := form;
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;
end;

procedure TFrmMain.AbastecimentoporDiaTanqueBomba1Click(Sender: TObject);
var
  form: TFrmRptAbastecimentoDiaTanqueBomba;
begin
  try
    Application.CreateForm(TFrmRptAbastecimentoDiaTanqueBomba, form);
    FrmRptAbastecimentoDiaTanqueBomba := form;
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;
end;

procedure TFrmMain.anquedeCombustvel1Click(Sender: TObject);
var
  form: TFrmTanqueCombustivel;
begin
  try
    Application.CreateForm(TFrmTanqueCombustivel, form);
    FrmTanqueCombustivel := form;
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;
end;

procedure TFrmMain.BombadeCombustvel1Click(Sender: TObject);
var
  form: TFrmBombaCombustivel;
begin
  try
    Application.CreateForm(TFrmBombaCombustivel, form);
    FrmBombaCombustivel := form;
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;
end;

procedure TFrmMain.Imposto1Click(Sender: TObject);
var
  form: TFrmImposto;
begin
  try
    Application.CreateForm(TFrmImposto, form);
    FrmImposto := Form;
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;
end;

procedure TFrmMain.ipodeCombustvel1Click(Sender: TObject);
var
  form: TFrmTipoCombustivel;
begin
  try
    Application.CreateForm(TFrmTipoCombustivel, form);
    FrmTipoCombustivel := form;
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;

end;

procedure TFrmMain.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
