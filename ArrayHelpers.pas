unit ArrayHelpers;

interface

type
  TExistsBehaviour = (ebAddAnyway, ebSkipIfExists);

  TArrayFunctions<T> = class
    class function Count(Arr: TArray<T>): Integer;
    class function Last(Arr: TArray<T>): T;
    class function IsEmpty(Arr: TArray<T>): Boolean;
    class function Add(Arr: TArray<T>; Value: T): TArray<T>;
    class procedure Remove(var Arr: TArray<T>; Index: Integer);
    class procedure Sort(var Arr: TArray<T>);
  end;

  // if you declare TArray<string>, delphi will apply the record helper to every TArray variable, such as TArray<Integer>
  TStringArray = array of string;
  TStringArrayHelper = record helper for TStringArray
  private
    function AsArray: TArray<string>;
  public
    function Count: Integer;
    function Last: string;
    function Join(Separator: string): string;
    function Exists(Value: string): Boolean;
    procedure Add(Value: string; ExistsBehaviour: TExistsBehaviour = ebAddAnyway);
  end;

  TIntegerArray = array of Integer;
  TIntegerArrayHelper = record helper for TIntegerArray
  private
    function AsArray: TArray<Integer>;
  public
    function Count: Integer;
    function Last: Integer;
    function Sort: TIntegerArray;
    function Exists(Value: Integer): Boolean;
    procedure Add(Value: Integer; ExistsBehaviour: TExistsBehaviour = ebAddAnyway);
    function ToStringArray: TStringArray;
  end;

implementation

uses
  System.Variants,
  System.SysUtils,
  System.Rtti,
  System.Generics.Collections;

{ TArrayFunctions }

class function TArrayFunctions<T>.Add(Arr: TArray<T>; Value: T): TArray<T>;
begin
  Result := Arr + [Value];
end;

class function TArrayFunctions<T>.Count(Arr: TArray<T>): Integer;
begin
  Result := Length(Arr);
end;

class procedure TArrayFunctions<T>.Remove(var Arr: TArray<T>; Index: Integer);
begin
  Delete(Arr, Index, 1);
end;

class procedure TArrayFunctions<T>.Sort(var Arr: TArray<T>);
begin
  TArray.Sort<T>(Arr);
end;

class function TArrayFunctions<T>.IsEmpty(Arr: TArray<T>): Boolean;
begin
  Result := Length(Arr) = 0;
end;

class function TArrayFunctions<T>.Last(Arr: TArray<T>): T;
begin
  Result := Arr[Pred(Length(Arr))];
end;

{ TStringArrayHelper }

procedure TStringArrayHelper.Add(Value: string; ExistsBehaviour: TExistsBehaviour = ebAddAnyway);
begin
  if (ExistsBehaviour = ebSkipIfExists) and Exists(Value) then
    Exit;

  Self := Self + [Value];
end;

function TStringArrayHelper.AsArray: TArray<string>;
begin
  Result := TArray<string>(Self);
end;

function TStringArrayHelper.Count: Integer;
begin
  Result := TArrayFunctions<string>.Count(Self.AsArray);
end;

function TStringArrayHelper.Exists(Value: string): Boolean;
var
  Index: Integer;
begin
  Result := TArray.BinarySearch<string>(Self.AsArray, Value, Index);
end;

function TStringArrayHelper.Join(Separator: string): string;
begin
  Result := ''.Join(Separator, Self.AsArray);
end;

function TStringArrayHelper.Last: string;
begin
  Result := TArrayFunctions<string>.Last(Self.AsArray);
end;

{ TIntegerArrayHelper }

procedure TIntegerArrayHelper.Add(Value: Integer; ExistsBehaviour: TExistsBehaviour = ebAddAnyway);
begin
  if (ExistsBehaviour = ebSkipIfExists) and Exists(Value) then
    Exit;

  Self := Self + [Value];
end;

function TIntegerArrayHelper.AsArray: TArray<Integer>;
begin
  Result := TArray<Integer>(Self);
end;

function TIntegerArrayHelper.Count: Integer;
begin
  Result := TArrayFunctions<Integer>.Count(Self.AsArray);
end;

function TIntegerArrayHelper.Exists(Value: Integer): Boolean;
var
  Index: Integer;
begin
  Result := TArray.BinarySearch<Integer>(Self.AsArray, Value, Index);
end;

function TIntegerArrayHelper.Last: Integer;
begin
  Result := TArrayFunctions<Integer>.Last(Self.AsArray);
end;

function TIntegerArrayHelper.Sort: TIntegerArray;
begin
  TArray.Sort<Integer>(Self);
end;

function TIntegerArrayHelper.ToStringArray: TStringArray;
var
  I: Integer;
begin
  for I in Self do
    Result := Result + [I.ToString];
end;

end.
