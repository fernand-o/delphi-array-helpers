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
  public
    [Setup]
    procedure SetUp;
  published
    procedure Count;
    procedure Add_DuplicatedValues;
    procedure Add_SkipDuplicates;
    procedure Join;
    procedure IsEmpty;
  end;

  [TTestFixture]
  TIntegerArrayTests = class
  private
    FSUT: TIntegerArray;
  public
    [Setup]
    procedure SetUp;
  published
    procedure Count;
    procedure Add_DuplicatedValues;
    procedure Add_SkipDuplicates;
    procedure ToStringArray_Join;
    procedure IsEmpty;
  end;

implementation

procedure TStringArrayTests.Add_DuplicatedValues;
begin
  FSUT.Add('a');
  FSUT.Add('b');
  FSUT.Add('c');
  FSUT.Add('c');
  FSUT.Add('c');

  Assert.AreEqual(5, FSUT.Count);
end;

procedure TStringArrayTests.Add_SkipDuplicates;
begin
  FSUT.Add('a');
  FSUT.Add('b');
  FSUT.Add('c');
  FSUT.AddIfNotExists('c');
  FSUT.AddIfNotExists('a');

  Assert.AreEqual(3, FSUT.Count);
end;

procedure TStringArrayTests.Count;
begin
  FSUT := ['1', '2'];
  Assert.AreEqual(2, FSUT.Count);
end;

procedure TStringArrayTests.IsEmpty;
begin
  FSUT.Add('foo');
  Assert.IsFalse(FSUT.IsEmpty);
  FSUT.Clear;
  Assert.IsTrue(FSUT.IsEmpty);
end;

procedure TStringArrayTests.SetUp;
begin
  FSUT.Clear;
end;

procedure TStringArrayTests.Join;
begin
  FSUT.Add('10');
  FSUT.Add('20');
  FSUT.Add('30');

  Assert.AreEqual('10->20->30', FSUT.Join('->'));
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
  FSUT.Add(1);
  FSUT.Add(20);
  FSUT.Add(20);
  FSUT.AddIfNotExists(1);
  FSUT.Add(100);
  FSUT.AddIfNotExists(100);

  Assert.AreEqual(4, FSUT.Count);
end;

procedure TIntegerArrayTests.Count;
begin
  FSUT := [1,2,3];
  Assert.AreEqual(3, FSUT.Count);
end;

procedure TIntegerArrayTests.IsEmpty;
begin
  FSUT.Add(1);
  Assert.IsFalse(FSUT.IsEmpty);
  FSUT.Clear;
  Assert.IsTrue(FSUT.IsEmpty);
end;

procedure TIntegerArrayTests.SetUp;
begin
  FSUT.Clear;
end;

procedure TIntegerArrayTests.ToStringArray_Join;
var
  SArray: TStringArray;
begin
  FSUT.Add(10);
  FSUT.Add(20);
  FSUT.Add(30);

  SArray := FSUT.ToStringArray;
  Assert.AreEqual(3, SArray.Count);
  Assert.AreEqual('30', SArray.Last);
end;

initialization
  TDUnitX.RegisterTestFixture(TStringArrayTests);
  TDUnitX.RegisterTestFixture(TIntegerArrayTests);

end.
