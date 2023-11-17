program PrjTestesGestaoPostoCombustivel;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  {$ENDIF }
  DUnitX.TestFramework,
  UTestesAbastecimento in 'UTestesAbastecimento.pas',
  UViewAbastecimento in '..\view\UViewAbastecimento.pas' {FrmAbastecimento},
  UModelAbastecimento in '..\model\UModelAbastecimento.pas',
  UModelImposto in '..\model\UModelImposto.pas',
  UModelBombaCombustivel in '..\model\UModelBombaCombustivel.pas',
  UModelTanqueCombustivel in '..\model\UModelTanqueCombustivel.pas',
  UModelTipoCombustivel in '..\model\UModelTipoCombustivel.pas',
  UControllerAbastecimento in '..\controller\UControllerAbastecimento.pas',
  UControllerImposto in '..\controller\UControllerImposto.pas',
  UDaoAbastecimento in '..\dao\UDaoAbastecimento.pas',
  UDaoBombaCombustivel in '..\dao\UDaoBombaCombustivel.pas',
  ULib in '..\units\ULib.pas',
  UDM in '..\dao\UDM.pas' {DM: TDataModule},
  UDaoImposto in '..\dao\UDaoImposto.pas';

{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
    end;
    System.Readln;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
