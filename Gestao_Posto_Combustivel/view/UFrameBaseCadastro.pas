unit UFrameBaseCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrameBaseCadastro = class(TFrame)
    pnlBotoes: TPanel;
    btnIncluir: TSpeedButton;
    btnGravar: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnSair: TSpeedButton;
    DBGrid: TDBGrid;
    pnlEdicao: TPanel;
    DataSource: TDataSource;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrameBaseCadastro.btnIncluirClick(Sender: TObject);
begin
  pnlEdicao.Enabled := not pnlEdicao.Enabled;
end;

procedure TFrameBaseCadastro.btnSairClick(Sender: TObject);
begin
  //TFrameBaseCadastro.Free;
end;

end.
