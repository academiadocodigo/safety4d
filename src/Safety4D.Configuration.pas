unit Safety4D.Configuration;

interface

uses
    Safety4D.Interfaces;

type
  TSafety4DConfiguration = class(TInterfacedObject, iSafety4DConfiguration)
    private
      [weak]
      FParent : iSafety4D;
      FException : Boolean;
    public
      constructor Create(aParent : iSafety4D);
      destructor Destroy; override;
      class function New(aParent : iSafety4D) : iSafety4DConfiguration;
      function exceptions( aValue : Boolean ) : iSafety4DConfiguration; overload;
      function exceptions : boolean; overload;
      function &End : iSafety4D;
  end;

implementation

{ TSafety4DConfiguration }

function TSafety4DConfiguration.&end : iSafety4D;
begin
    Result := FParent;
end;

function TSafety4DConfiguration.exceptions: boolean;
begin
  Result := FException;
end;

function TSafety4DConfiguration.exceptions(
  aValue: Boolean): iSafety4DConfiguration;
begin
  Result := Self;
  FException := aValue;
end;

constructor TSafety4DConfiguration.Create(aParent : iSafety4D);
begin
  FParent := aParent;
  FException := False;
end;

destructor TSafety4DConfiguration.Destroy;
begin

  inherited;
end;

class function TSafety4DConfiguration.New(aParent : iSafety4D): iSafety4DConfiguration;
begin
  Result := Self.Create(aParent);
end;

end.
