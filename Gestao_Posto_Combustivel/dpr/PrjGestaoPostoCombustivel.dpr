program PrjGestaoPostoCombustivel;

uses
  Vcl.Forms,
  UViewMain in '..\view\UViewMain.pas' {FrmMain},
  UModelTanqueCombustivel in '..\model\UModelTanqueCombustivel.pas',
  UControllerTanqueCombustivel in '..\controller\UControllerTanqueCombustivel.pas',
  UDaoTanqueCombustivel in '..\dao\UDaoTanqueCombustivel.pas',
  UModelBombaCombustivel in '..\model\UModelBombaCombustivel.pas',
  UModelAbastecimento in '..\model\UModelAbastecimento.pas',
  UViewBombaCombustivel in '..\view\UViewBombaCombustivel.pas' {FrmBombaCombustivel},
  UViewAbastecimento in '..\view\UViewAbastecimento.pas' {FrmAbastecimento},
  UControllerAbastecimento in '..\controller\UControllerAbastecimento.pas',
  UControllerBombaCombustivel in '..\controller\UControllerBombaCombustivel.pas',
  UDaoBombaCombustivel in '..\dao\UDaoBombaCombustivel.pas',
  UDaoAbastecimento in '..\dao\UDaoAbastecimento.pas',
  UDM in '..\dao\UDM.pas' {DM: TDataModule},
  UModelImposto in '..\model\UModelImposto.pas',
  UDaoImposto in '..\dao\UDaoImposto.pas',
  UControllerImposto in '..\controller\UControllerImposto.pas',
  UViewTanqueCombustivel in '..\view\UViewTanqueCombustivel.pas' {FrmTanqueCombustivel},
  UViewImposto in '..\view\UViewImposto.pas' {FrmImposto},
  UFrameBaseCadastro in '..\view\UFrameBaseCadastro.pas' {FrameBaseCadastro: TFrame},
  UViewTeste in '..\view\UViewTeste.pas' {FrmTeste},
  UModelTipoCombustivel in '..\model\UModelTipoCombustivel.pas',
  UDaoTipoCombustivel in '..\dao\UDaoTipoCombustivel.pas',
  UControllerTipoCombustivel in '..\controller\UControllerTipoCombustivel.pas',
  UViewTipoCombustivel in '..\view\UViewTipoCombustivel.pas' {FrmTipoCombustivel},
  ULib in '..\units\ULib.pas',
  UViewRptAbastecimentoDiaTanqueBomba in '..\view\UViewRptAbastecimentoDiaTanqueBomba.pas' {FrmRptAbastecimentoDiaTanqueBomba};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
