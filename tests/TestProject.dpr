program TestProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  DUnitXTestRunner,
  ArrayHelperTests in 'ArrayHelperTests.pas';

begin
  try
    TDUnitXTestRunner.Execute;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
