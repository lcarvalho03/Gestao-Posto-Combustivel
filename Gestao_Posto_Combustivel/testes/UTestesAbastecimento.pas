unit UTestesAbastecimento;

interface

uses
  DUnitX.TestFramework, UViewAbastecimento;

type
  [TestFixture]
  TTestesAbastecimento = class
  strict private
    FViewAbastecimento: TFrmAbastecimento;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure TesteCalculoValorTotal;
  end;

implementation

procedure TTestesAbastecimento.Setup;
begin
  FViewAbastecimento := TFrmAbastecimento.Create(FViewAbastecimento);
end;

procedure TTestesAbastecimento.TearDown;
begin
  FViewAbastecimento.Free;
end;

procedure TTestesAbastecimento.TesteCalculoValorTotal;
begin
  var lValorLitro := 3.89;
  var lQtdLitros := 20;
  var lResultado := FViewAbastecimento.CalculaValorTotal(lValorLitro, lQtdLitros);
  Assert.AreEqual<Currency>(77.80, lResultado, 'Cálculo do Valor Total do Abastecimento.');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestesAbastecimento);

end.
