unit ArrayHelperTests;

interface

uses
  DUnitX.TestFramework,
  ArrayHelpers;

type
  [TTestFixture]
  TStringArrayTests = class
  private
    FSUT: TStringArray;
  protected
    [Setup]
    procedure SetUp;
  published
    procedure Count;
    procedure Add_Count;
  end;

  [TTestFixture]
  TIntegerArrayTests = class
  private
    FSUT: TIntegerArray;
  public
    [Setup]
    procedure SetUp;
  published
    procedure Add_DuplicatedValues;
    procedure Add_SkipDuplicates;
    procedure ToStringArray_Join;
  end;

implementation

{ TStringArrayTests }

procedure TStringArrayTests.Add_Count;
begin
  FSUT.Add('1');
end;

procedure TStringArrayTests.Count;
begin
  FSUT := ['1', '2'];
  Assert.AreEqual(2, FSUT.Count);
end;

procedure TStringArrayTests.SetUp;
begin
  FSUT := [];
end;

procedure TIntegerArrayTests.Add_DuplicatedValues;
begin
  FSUT.Add(1);
  FSUT.Add(20);
  FSUT.Add(100);
  FSUT.Add(1);

  Assert.AreEqual(4, FSUT.Count);
end;

procedure TIntegerArrayTests.Add_SkipDuplicates;
begin
  FSUT.Add(20);
  FSUT.Add(100);
  FSUT.Add(1);
  FSUT.Add(1, ebSkipIfExists);

  Assert.AreEqual(3, FSUT.Count);
end;

procedure TIntegerArrayTests.SetUp;
begin
  FSUT := [];
end;

procedure TIntegerArrayTests.ToStringArray_Join;
begin
  FSUT.Add(10);
  FSUT.Add(20);
  FSUT.Add(30);

  Assert.AreEqual('10->20->30', FSUT.ToStringArray.Join('->'));
end;

initialization
  TDUnitX.RegisterTestFixture(TStringArrayTests);
  TDUnitX.RegisterTestFixture(TIntegerArrayTests);

end.
