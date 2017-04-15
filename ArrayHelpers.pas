unit ArrayHelpers;

interface

type
  // if you declare TArray<string>, delphi will apply the record helper to every TArray variable, such as TArray<Integer>
  TStringArray = array of string;
  TStringArrayHelper = record helper for TStringArray
  public
    function AsArray: TArray<string>;
    procedure Add(Value: string);
    procedure AddIfNotExists(Value: string);
    procedure Clear;
    function Count: Integer;
    function Exists(Value: string): Boolean; overload;
    function Exists(Value: string; var Index: Integer): Boolean; overload;
    function First: string;
    function IsEmpty: Boolean;
    function Join(Separator: string = ','): string;
    function JoinQuoted(Separator: string = ','): string;
    function Last: string;
    function Sort: TStringArray;
    function PredCount: Integer;
    procedure From(Ar: TArray<string>);
    function Get(Index: Integer): string;
  end;

  TIntegerArray = array of Integer;
  TIntegerArrayHelper = record helper for TIntegerArray
  private
    function AsArray: TArray<Integer>;
  public
    procedure Add(Value: Integer);
    procedure AddIfNotExists(Value: Integer);
    procedure Clear;
    function Exists(Value: Integer): Boolean; overload;
    function Exists(Value: Integer; var Index: Integer): Boolean; overload;
    function First: Integer;
    function IsEmpty: Boolean;
    function Count: Integer;
    function Last: Integer;
    function Sort: TIntegerArray;
    function ToStringArray: TStringArray;
  end;

implementation

uses
  System.Variants,
  System.SysUtils,
  System.Rtti,
  System.Generics.Collections;

{ TStringArrayHelper }

procedure TStringArrayHelper.Add(Value: string);
begin
  Self := Self + [Value];
end;

procedure TStringArrayHelper.AddIfNotExists(Value: string);
begin
  if not Exists(Value) then
    Add(Value);
end;

function TStringArrayHelper.AsArray: TArray<string>;
begin
  Result := TArray<string>(Self);
end;

procedure TStringArrayHelper.Clear;
begin
  Self := [];
end;

function TStringArrayHelper.Count: Integer;
begin
  Result := Length(Self);
end;

function TStringArrayHelper.Exists(Value: string; var Index: Integer): Boolean;
begin
  Result := TArray.BinarySearch<string>(Self.AsArray, Value, Index);
end;

function TStringArrayHelper.Exists(Value: string): Boolean;
var
  Index: Integer;
begin
  Exists(Value, Index);

  Result := Index > 0;
end;

function TStringArrayHelper.First: string;
begin
  Result := '';

  if Count > 0 then
    Result := Self[0];
end;

procedure TStringArrayHelper.From(Ar: TArray<string>);
begin
  Self := TStringArray(Ar);
end;

function TStringArrayHelper.Get(Index: Integer): string;
begin
  Result := '';

  if (Index >= 0) and (Index < Count) then
    Result := Self[Index];
end;

function TStringArrayHelper.IsEmpty: Boolean;
begin
  Result := Count = 0;
end;

function TStringArrayHelper.Join(Separator: string = ','): string;
begin
  Result := ''.Join(Separator, Self.AsArray);
end;

function TStringArrayHelper.JoinQuoted(Separator: string = ','): string;
var
  StrArray: TStringArray;
  Value: string;
begin
  for Value in Self do
    StrArray.Add(QuotedStr(Value));

  Result := StrArray.Join(',');
end;

function TStringArrayHelper.Last: string;
begin
  Result := Self[Pred(Count)];
end;

function TStringArrayHelper.PredCount: Integer;
begin
  Result := Pred(Count);
end;

function TStringArrayHelper.Sort: TStringArray;
begin
  TArray.Sort<string>(Self);
  Result := Self;
end;

{ TIntegerArrayHelper }

procedure TIntegerArrayHelper.Add(Value: Integer);
begin
  Self := Self + [Value];
end;

procedure TIntegerArrayHelper.AddIfNotExists(Value: Integer);
begin
  if not Exists(Value) then
    Add(Value);
end;

function TIntegerArrayHelper.AsArray: TArray<Integer>;
begin
  Result := TArray<Integer>(Self);
end;

procedure TIntegerArrayHelper.Clear;
begin
  Self := [];
end;

function TIntegerArrayHelper.Count: Integer;
begin
  Result := Length(Self);
end;

function TIntegerArrayHelper.Exists(Value: Integer; var Index: Integer): Boolean;
begin
Result := TArray.BinarySearch<Integer>(Self.AsArray, Value, Index);
end;

function TIntegerArrayHelper.Exists(Value: Integer): Boolean;
var
  Index: Integer;
begin
  Result := Exists(Value, Index);
end;

function TIntegerArrayHelper.First: Integer;
begin
  Result := 0;

  if Count > 0 then
    Result := Self[0];
end;

function TIntegerArrayHelper.IsEmpty: Boolean;
begin
  Result := Count = 0;
end;

function TIntegerArrayHelper.Last: Integer;
begin
  Result := Self[Pred(Count)];
end;

function TIntegerArrayHelper.Sort: TIntegerArray;
begin
  TArray.Sort<Integer>(Self);
  Result := Self;
end;

function TIntegerArrayHelper.ToStringArray: TStringArray;
var
  I: Integer;
begin
  for I in Self do
    Result := Result + [I.ToString];
end;

end.
