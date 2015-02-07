{
Description
Project JEDI Windows Security Code Library (JWSCL)

Simulates security descriptors on a path.

Author
Christian Wimmer

License
The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License");
you may not use this file except in compliance with the License. You may obtain a copy of the
License at http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF
ANY KIND, either express or implied. See the License for the specific language governing rights
and limitations under the License.

Alternatively, the contents of this file may be used under the terms of the
GNU Lesser General Public License (the  "LGPL License"), in which case the
provisions of the LGPL License are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the LGPL License and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting  the provisions above and
replace  them with the notice and other provisions required by the LGPL
License.  If you do not delete the provisions above, a recipient may use
your version of this file under either the MPL or the LGPL License.

For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html

The Original Code is JwsclPathSimulation.pas.

The Initial Developer of the Original Code is Christian Wimmer.
Portions created by Christian Wimmer are Copyright (C) Christian Wimmer. All rights reserved.

Requirement: Delphi 2009 or newer

Version
The following values are automatically injected by Subversion on commit.
<table>
\Description                                                        Value
------------------------------------------------------------------  ------------
Last known date the file has changed in the repository              \$Date: 2010-10-15 16:12:04 -0400 (Fri, 15 Oct 2010) $
Last known revision number the file has changed in the repository   \$Revision: 1029 $
Last known author who changed the file in the repository.           \$Author: dezipaitor $
Full URL to the latest version of the file in the repository.       \$HeadURL: https://svn.code.sf.net/p/jedi-apilib/code/jwscl/trunk/source/JwsclPathSimulation.pas $
</table>
}
unit JwsclPathSimulation;
{$INCLUDE ..\includes\Jwscl.inc}


{$WARNINGS ON}

{$IFNDEF DELPHI2009_UP}
  {$MESSAGE WARN 'This file is only for Delphi 2009 and newer'}
{$ENDIF}



{$IFNDEF DEBUG}
  {$MESSAGE FAIL 'File JwsclPathSimulation.pas is not intended for production. It is intended for simulation security descriptor inheritance.'}
{$ELSE}
  {$MESSAGE WARN 'File JwsclPathSimulation.pas is not intended for production. It is intended for simulation security descriptor inheritance.'}
{$ENDIF}

interface
uses
  JwaWindows,
  JwsclSecureObjects,
  JwsclDescriptor,
  JwsclAcl,
  JwsclConstants,
  JwsclEnumerations,
  JwsclTypes,
  JwsclMapping,
  JwsclExceptions,
  JwsclStrings,
  Classes,
  SysUtils;

{$IFDEF DELPHI2009_UP}
type
  {TJwInheritancePath splits the entries of a path into
   the root drive and its folder.
   Each folder's security descriptor can be access through the
   SD property. At first these are all nil and must be initialized!}
  TJwInheritancePath = class
  private
    fPath : String;
    fSD : TStringList;

    function GetSD(Path : String) : TJwSecurityDescriptor;
    function GetSDIdx(Index : Integer) : TJwSecurityDescriptor;
  public
    constructor Create(const Path : string);

    property SD[Path : String] : TJwSecurityDescriptor read GetSD;
    property SDi[Index : Integer] : TJwSecurityDescriptor read GetSDIdx;
    property Path : String read fPath;
  end;

{$ENDIF DELPHI2009_UP}
implementation

{ TJwInheritancePath }

{$IFDEF DELPHI2009_UP}
constructor TJwInheritancePath.Create(const Path: string);
  function ReversStr(const S : string) : String;
  var i : Integer;
  begin
    result := '';
    for i := 1 to Length(S) do
      result := S[i] + result;
  end;

var p,i, j : Integer;
  SubStr, SubPath : String;
begin
  fPath := Path;
  fSD := TStringList.Create;
  fSD.OwnsObjects := true;
  fSD.CaseSensitive := false;

  SubPath := IncludeTrailingBackslash(Path);

  p := Length(SubPath) - pos('\', ReversStr(SubPath))-1 ;
  while p > 0 do
  begin
    SubPath := Copy(SubPath, 1, p+1);
    fSD.InsertObject(0, IncludeTrailingBackslash(SubPath), TJwSecurityDescriptor.Create);

    p := pos('\', ReversStr(SubPath));
    if p > 0 then
      p := Length(SubPath) - p -1 ;
  end;
end;

function TJwInheritancePath.GetSD(Path: String): TJwSecurityDescriptor;
var i : Integer;
begin
  i := 0;
  if fSD.Find(IncludeTrailingBackslash(Path), i) then
    result := TJwSecurityDescriptor(fSD.Objects[i])
  else
    result := nil;
end;

function TJwInheritancePath.GetSDIdx(Index: Integer): TJwSecurityDescriptor;
begin
  result :=  TJwSecurityDescriptor(fSD.Objects[Index])
end;

{$ENDIF DELPHI2009_UP}

end.
