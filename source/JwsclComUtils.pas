{
Description
Project JEDI Windows Security Code Library (JWSCL)

Contains structures to support auto free class instances.

Author
Robert Giesecke
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

Note

The Original Code is JwsclComUtils.pas.
The Initial Developer of the Original Code is Robert Giesecke.

Example
To use this code simply do the following:
<code lang="Delphi">
var myClass : TMyClass;
begin
  myClass := TMyClass.Create;
  TJwAutoPointer.Wrap(myClass);

  ... your code here ...
end; //autodestruction of myClass here.
</code>

Version
The following values are automatically injected by Subversion on commit.
<table>
\Description                                                        Value
------------------------------------------------------------------  ------------
Last known date the file has changed in the repository              \$Date: 2010-11-14 10:40:34 -0500 (Sun, 14 Nov 2010) $
Last known revision number the file has changed in the repository   \$Revision: 1059 $
Last known author who changed the file in the repository.           \$Author: dezipaitor $
Full URL to the latest version of the file in the repository.       \$HeadURL: https://svn.code.sf.net/p/jedi-apilib/code/jwscl/trunk/source/JwsclComUtils.pas $
</table>
}
{$IFNDEF SL_OMIT_SECTIONS}
unit JwsclComUtils;
{$INCLUDE ..\includes\Jwscl.inc}

interface

uses
  JwaWindows, ActiveX, Classes, JwsclTypes, JwsclResource ,Jwsclexceptions;
{$ENDIF SL_OMIT_SECTIONS}

{$IFNDEF SL_IMPLEMENTATION_SECTION}
const
  IIDIJwAutoPointer = '{08360FA5-F278-45EF-98FE-6C43DF9C778B}';
  IIDIJwAutoLock = '{555DB592-48B3-4E37-8853-E50A33E869A3}';

type
  IJwAutoPointer = interface;

  {The interface IJwAutoLock is returned by the Lock method of IJwAutoPointer.}
  IJwAutoLock = interface
  [IIDIJwAutoLock]
    function GetAutoPointer : IJwAutoPointer;
    {This method returns the data as Pointer type.

   Returns
    The function returns the value of the stored pointer.
    The property Pointertype must be ptNew, ptLocalAlloc,
    ptGetMem or ptCOMPointer; otherwise the return value is undefined.
  }
    function GetPointer   : Pointer;
    {This method returns the data as object type.

   Returns
    The property Pointertype must be ptClass;
    otherwise the return value is undefined.
  }
  function GetInstance  : TObject;
  {This method returns the pointer as Pointer type.

   Returns
     The method returns the type of stored pointer.
     Any value of TJwPointerType may be returned.
  }
    function GetPointerType : TJwPointerType;

  {This method returns the data as object type.

   Returns
    The property Pointertype must be ptCOMPointer;
    otherwise the return value is undefined.
  }
    function GetHandle : THandle;

    {The method UnLock removes the exclusive lock on the data;

     Remarks
     Do not use this method. Instead destroy the interface by setting
     all references to nil.
  }
    procedure UnLock;

  //See method GetPointer for more information
    property Pointer   : Pointer read GetPointer;
  //See method Instance for more information
    property Instance  : TObject read GetInstance;
  //See method PointerType for more information
    property PointerType  : TJwPointerType read GetPointerType;
  end;

  {The interface <b>IJwAutoPointer</b> is returned by any of
   the TJwAutoPointer wrap methods.

   The interface does not provide reference counting on the data.
  }
  IJwAutoPointer = interface
  [IIDIJwAutoPointer]
    {This method returns the data as Pointer type.

 Remarks
     Use the Get methods of the interface IJwAutoLock retunred by Lock
     in a multithread environment.

   Returns
    The function returns the value of the stored pointer.
    The property Pointertype must be ptNew, ptLocalAlloc,
    ptGetMem or ptCOMPointer; otherwise the return value is undefined.
  }
    function GetPointer   : Pointer;
    {This method returns the data as object type.

     Remarks
     Use the Get methods of the interface IJwAutoLock retunred by Lock
     in a multithread environment.

   Returns
    The property Pointertype must be ptClass;
    otherwise the return value is undefined.
  }
  function GetInstance  : TObject;
  {This method returns the pointer as Pointer type.

   Remarks
     Use the Get methods of the interface IJwAutoLock retunred by Lock
     in a multithread environment.

   Returns
     The method returns the type of stored pointer.
     Any value of TJwPointerType may be returned.
  }
    function GetPointerType : TJwPointerType;

  {This method returns the data as object type.

   Remarks
     Use the Get methods of the interface IJwAutoLock retunred by Lock
     in a multithread environment.

   Returns
    The property Pointertype must be ptCOMPointer;
    otherwise the return value is undefined.
  }
    function GetHandle : THandle;

  //See method GetPointer for more information
    property Pointer   : Pointer read GetPointer;
  //See method Instance for more information
    property Instance  : TObject read GetInstance;
  //See method PointerType for more information
    property PointerType  : TJwPointerType read GetPointerType;

  {The method Lock joins an exclusive lock and stops
   further access to the data using this function.

   Remarks
     Only this function makes sure that the pointer is accessed
     exclusively. Calling any Get method without Lock
     has unpredictable results.
  }
    function Lock : IJwAutoLock;
  end;


  {<B>TJwAutoPointer</B> implements tool functions for creating new and wrapping existing
   pointers and classes for auto destruction.
   The class does not provide reference counting on the data.
  }
  TJwAutoPointer = class
  public
    {<B>Wrap</B> wraps an existing class instance for auto pointer desctruction.
     When the returned auto pointer interface goes out of scope the
     given instance will be destroyed.
    @param Instance defines the class instance that will be automatically
     destroyed
    @return Returns an auto pointer interface that is resposible for
      auto destruction. }
    class function Wrap(const Instance  : TObject) : IJwAutoPointer; overload;

    {<B>Wrap</B> wraps an existing pointer for auto desctruction.
     When the returned auto pointer interface goes out of scope the
     given pointer will be destroyed.
     @param Ptr Defines a pointer that is automatically destroyed.
     @param Size Defines the size of the pointer data. If size is
        not zero, the memory will be overwritten with zeroes before
        it is freed.
     @param PointerType Defines the pointer type. It is used to call
      the appropriate free function.
     @return Returns an auto pointer interface that is resposible for
      auto destruction.
     }
    class function Wrap(const Ptr : Pointer;
        Size : Cardinal;
        PointerType : TJwPointerType) : IJwAutoPointer; overload;

    {Wrap wraps a windows handle and closes it using CloseHandle.

   Parameters
     ShowLastError Defines whether the exception EJwsclInvalidHandle will
       include the last error value (true) or not (false).

   Raises
     EJwsclInvalidHandle The handle was invalid (0 or INVALID_HANDLE_VALUE).
  }
    class function Wrap(const Handle : THandle; const
       ShowLastError : Boolean = false) : IJwAutoPointer; overload;

    {WrapCOM wraps a COM memory allocation with CoTaskMemAlloc.
   The pointer will be freed using CoTaskMemFree.
  }
    class function WrapCOM(const Ptr : Pointer) : IJwAutoPointer;

    {<B>CreateInstance</B> creates a new auto pointer class instance and also
     creates the given class with a default constructor (no parameters).
     Use instead Wrap if you cannot use standard constructor or
      your class does not support a standard constructor.
     @param ClassReference defines the class type which is to be created
     @return Returns an auto pointer interface that is resposible for
      auto destruction.
     }
    class function CreateInstance(
      const ClassReference : TClass) : IJwAutoPointer; overload;

    {<B>CreateInstance</B> creates a new auto pointer class instance and also
     creates the given component class.
     Use instead Wrap if you cannot use standard component constructor or
      your class does not support a standard component constructor.
     @param ClassReference defines the class type which is to be created
     @param Owner defines the component owner which is applied to the
      component constructor.
     @return Returns an auto pointer interface that is resposible for
      auto destruction.
     }
    class function CreateInstance(
      const ClassReference : TComponentClass;
      const Owner          : TComponent = nil) : IJwAutoPointer; overload;

    {<B>CreateNewPointer</B> creates a new pointer or wraps an existing one.
     The following pointer types are created automatically :

        # ptGetMem
        # ptLocalAlloc

     The following pointer types are tunneled through and must
     be created by the caller:

        # ptNew

     The following pointer types are not supported and raises EJwsclInvalidPointerType

        # ptUnknown
        # ptClass


     }
    class function CreateNewPointer(
      var Ptr : Pointer; Size : Cardinal; PointerType : TJwPointerType)  : IJwAutoPointer; overload;
  end;

{$ENDIF SL_IMPLEMENTATION_SECTION}

{$IFNDEF SL_OMIT_SECTIONS}
implementation
uses SysUtils, SyncObjs;
{$ENDIF SL_OMIT_SECTIONS}


{$IFNDEF SL_INTERFACE_SECTION}
type
  { <b>TJwAutoPointerImpl</b> implements the auto pointer interface IJwAutoPointer. }
  TJwAutoPointerImpl = class(TInterfacedObject, IJwAutoPointer)
  protected
    fInstance : TObject;
    fPointer : Pointer;
    fPointerType : TJwPointerType;
    fSize : Cardinal;
    fSection : TCriticalSection;
    fHandle : THandle;

    function GetInstance: TObject;
    function GetPointer: Pointer;
    function GetPointerType : TJwPointerType;
    function GetHandle : THandle;
  public
    constructor Create(const Instance : TObject); overload;
    constructor Create(const Ptr : Pointer; Size : Cardinal; PointerType : TJwPointerType); overload;
    procedure BeforeDestruction; override;

    function Lock : IJwAutoLock;
  end;

  TJwAutoLock = class(TInterfacedObject, IJwAutoLock)
  protected
    fAutoPointer : TJwAutoPointerImpl;
    { The f<b>LeaveFlag</b> field defines whether the entered section is released when
      the instance is destroyed (false) or not (true).

      It is for future use only and thus has no public access.                         }
    fLeaveFlag : Boolean;
  public
    { <b>Create</b> creates a new TJwAutoLock instance and enters the a thread safe
      section defined by parameter AutoPointer. If this section was already entered by
      another thread, the constructor is blocked until released. There is no timeout!




      Parameters
      AutoPointer :  This parameter defines an auto pointer implementation that holds
                     the thread section for exclusive access to the resource.          }
    constructor Create(const AutoPointer : TJwAutoPointerImpl);

    function GetAutoPointer : IJwAutoPointer;
    function GetPointer   : Pointer;
    function GetInstance  : TObject;
    function GetPointerType : TJwPointerType;
    function GetHandle : THandle;

    procedure BeforeDestruction; override;

    { <b>UnLock</b> releases the section lock previously gained by creating the
      instance.


      See Also
        * Create                                                                }
    procedure UnLock;
  end;


{ AutoPointer }

class function TJwAutoPointer.Wrap(const Instance: TObject): IJwAutoPointer;
begin
  Result := TJwAutoPointerImpl.Create(instance);
end;

class function TJwAutoPointer.CreateInstance(
  const ClassReference : TClass): IJwAutoPointer;
begin
  Result := Wrap(classReference.Create());
end;



class function TJwAutoPointer.CreateInstance(
  const ClassReference : TComponentClass;
  const Owner : TComponent): IJwAutoPointer;
begin
  Result := Wrap(classReference.Create(Owner));
end;


class function TJwAutoPointer.CreateNewPointer(
  var Ptr : Pointer; Size : Cardinal; PointerType: TJwPointerType): IJwAutoPointer;
begin
  case PointerType of
    ptGetMem : GetMem(Ptr, Size);
    ptLocalAlloc : Ptr := Pointer(LocalAlloc(LPTR,Size));
    ptNew : Size := 0;
    ptUnknown,
    ptClass:
    raise EJwsclInvalidPointerType.CreateFmtEx(
      RsInvalidPointerType, 'CreateNewPointer', ClassName, RsUNComUtils,
      0, False, []);
  end;
  Result := Wrap(Ptr, Size, PointerType);
end;

class function TJwAutoPointer.Wrap(const Handle: THandle; const
       ShowLastError : Boolean = false): IJwAutoPointer;
begin
  if (Handle = 0) or (Handle = INVALID_HANDLE_VALUE) then
    raise EJwsclInvalidHandle.CreateFmtEx(
      RsInvalidWrapHandle, 'Wrap', ClassName, RsUNComUtils,
      0, ShowLastError, []);

  result := Wrap(Pointer(Handle), Cardinal(-1), ptHandle);
end;

class function TJwAutoPointer.WrapCOM(const Ptr: Pointer): IJwAutoPointer;
begin
  result := Wrap(Ptr, 0, ptCOMPointer);
end;

class function TJwAutoPointer.Wrap(const Ptr: Pointer;
  Size : Cardinal;
  PointerType: TJwPointerType): IJwAutoPointer;
begin
  Result := TJwAutoPointerImpl.Create(Ptr, Size, PointerType);
end;

{ TAutoPinterImpl }

function TJwAutoPointerImpl.GetHandle: THandle;
begin
  result := fHandle;
end;

function TJwAutoPointerImpl.GetInstance : TObject;
begin
  Result := fInstance;
end;

function TJwAutoPointerImpl.GetPointer : Pointer;
begin
  Result := fInstance;
end;

procedure TJwAutoPointerImpl.BeforeDestruction;
begin
  fSection.Enter;

  try
    case fPointerType of
      ptGetMem : if fSize <> 0 then ZeroMemory(fPointer, fSize);
      ptLocalAlloc : if fSize <> 0 then ZeroMemory(fPointer, fSize);
    end;

    case fPointerType of
      ptClass  : fInstance.Free();
      ptGetMem : FreeMem(fPointer);
      ptLocalAlloc : LocalFree(HLOCAL(fPointer));
      ptNew : Dispose(fPointer);
      ptHandle : CloseHandle(fHandle);
      ptCOMPointer : CoTaskMemFree(fPointer);
    end;

    fPointer := nil;
    fInstance := nil;
  finally
    fSection.Leave;
    FreeAndNil(fSection);
  end;

  inherited;
end;

constructor TJwAutoPointerImpl.Create(const Instance : TObject);
begin
  fInstance := Instance;
  fPointerType := ptClass;
  fSection := TCriticalSection.Create;
  fHandle := INVALID_HANDLE_VALUE;
end;

constructor TJwAutoPointerImpl.Create(const Ptr: Pointer;
  Size : Cardinal;
  PointerType: TJwPointerType);
begin
  fPointer := Ptr;
  fPointerType := PointerType;
  fSize := Size;
  fSection := TCriticalSection.Create;
  if Size = Cardinal(-1) then
  begin
    fHandle := DWORD(Ptr);
    fPointer := nil;
  end;

end;

function TJwAutoPointerImpl.GetPointerType: TJwPointerType;
begin
  result := fPointerType;
end;


function TJwAutoPointerImpl.Lock: IJwAutoLock;
begin
  result := TJwAutoLock.Create(Self);
end;


{ TJwAutoLock }

procedure TJwAutoLock.BeforeDestruction;
begin
  if Assigned(fAutoPointer.fSection) and not fLeaveFlag then
    fAutoPointer.fSection.Leave;

  inherited;
end;

constructor TJwAutoLock.Create(const AutoPointer: TJwAutoPointerImpl);
begin
  AutoPointer.fSection.Enter;

  fAutoPointer := AutoPointer;
  fLeaveFlag := false;

  inherited Create;
end;

function TJwAutoLock.GetAutoPointer: IJwAutoPointer;
begin
  result := fAutoPointer;
end;

function TJwAutoLock.GetHandle: THandle;
begin
  result := fAutoPointer.GetHandle;
end;

function TJwAutoLock.GetInstance: TObject;
begin
  result := fAutoPointer.GetInstance;
end;

function TJwAutoLock.GetPointer: Pointer;
begin
  result := fAutoPointer.GetPointer;
end;

function TJwAutoLock.GetPointerType: TJwPointerType;
begin
  result := fAutoPointer.GetPointerType;
end;

procedure TJwAutoLock.UnLock;
begin
  if Assigned(fAutoPointer.fSection) then
    fAutoPointer.fSection.Leave;
  fLeaveFlag := true;
end;

{$ENDIF SL_INTERFACE_SECTION}


{$IFNDEF SL_OMIT_SECTIONS}





initialization
{$ENDIF SL_OMIT_SECTIONS}

{$IFNDEF SL_INITIALIZATION_SECTION}
{$ENDIF SL_INITIALIZATION_SECTION}

{$IFNDEF SL_OMIT_SECTIONS}
end.
{$ENDIF SL_OMIT_SECTIONS}
