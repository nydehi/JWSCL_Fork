{ Description
  Project JEDI Windows Security Code Library (JWSCL)

  Contains types that are used by the units of JWSCL
  Author
  Christian Wimmer
  License
  The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); you may not use
  this file except in compliance with the License. You may obtain a copy of the License at http://www.mozilla.org/MPL/

  Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either
  express or implied. See the License for the specific language governing rights and limitations under the License.

  Alternatively, the contents of this file may be used under the terms of the GNU Lesser General Public License (the
  "LGPL License"), in which case the provisions of the LGPL License are applicable instead of those above. If you wish
  to allow use of your version of this file only under the terms of the LGPL License and not to allow others to use
  your version of this file under the MPL, indicate your decision by deleting the provisions above and replace them
  with the notice and other provisions required by the LGPL License. If you do not delete the provisions above, a
  recipient may use your version of this file under either the MPL or the LGPL License.

  For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html
  Note
  The Original Code is JwsclVersion.pas.

  The Initial Developer of the Original Code is Christian Wimmer. Portions created by Christian Wimmer are Copyright
  (C) Christian Wimmer. All rights reserved.


  Version
  The following values are automatically injected by Subversion on commit.
  <table>
  \Description                                                        Value
  ------------------------------------------------------------------  ------------
  Last known date the file has changed in the repository              \$Date: 2010-11-14 10:40:34 -0500 (Sun, 14 Nov 2010) $
  Last known revision number the file has changed in the repository   \$Revision: 1059 $
  Last known author who changed the file in the repository.           \$Author: dezipaitor $
  Full URL to the latest version of the file in the repository.       \$HeadURL: https://svn.code.sf.net/p/jedi-apilib/code/jwscl/trunk/source/JwsclVersion.pas $
  </table>
 }
{$IFNDEF SL_OMIT_SECTIONS}
unit JwsclVersion;
{$INCLUDE ..\includes\Jwscl.inc}

interface

uses SysUtils,
  JwsclUtils, JwsclResource,
  jwaWindows, JwsclConstants, JwsclExceptions, JwsclTypes, JwsclToken,
  JwsclStrings;

{$ENDIF SL_OMIT_SECTIONS}

{$IFNDEF SL_IMPLEMENTATION_SECTION}
type


  TJwFileVersion = class(TObject)
  private
  protected
  public
    {<B>GetFileInfo</B> retrieves a TFileVersionInfo structure for a given Filename.
    }
    class function GetFileInfo(const Filename: TJwString;
      var FileVersionInfo: TJwFileVersionInfo): Boolean;
  end;


  { <b>TJwServerInfo</b> retrieves Windows Version information on a remote or local client. }
  TJwServerInfo = class(TObject)
  private
  protected
    {@exclude}
    FServer: TJwString;
    {@exclude}
    FMajorVersion: Integer;
    {@exclude}
    FMinorVersion: Integer;
    {@exclude}
    FIsServer: Boolean;
    {@exclude}
    FIsTerminalServer: Boolean;
    {@exclude}
    FWindowsType: Integer;
  public
    {The <B>Create</B> constructor creates the TJwServerInfo object and reserves memory
     for it.
     @param Server the servername for which you would like to retreive
     information. If Servername is empty string the local machine will be
     queried.

     Example:
     <code lang="Delphi">
     var
       ServerInfo: TJwServerInfo;

     begin
       // Create TJwServerInfo object and reserve memory for it
       ServerInfo := TJwServerInfo.Create('REMOTESERVER');

       // Are we running on a Server?
       if ServerInfo.IsServer then
       begin
         Memo1.Lines.Add(Format('Server %s runs a Server OS', [ServerInfo.Server]));
       end;

       // Vista or higher code
       if ServerInfo.IsWindowsVista(True) then
       begin
         // Do some Vista specific stuff
       end;

       // Free Memory!
       ServerInfo.Free;
     end;
     </code>
    }
    constructor Create(const Server: TJwString);

    {<B>GetWindowsType</B> returns a constant that defines the windows version the process is running.
     @return The return value can be one of these constants defined in JwsclConstants
     Currently these items are supported

       #  Spacing(Compact)
       #  cOsUnknown = The system is unknown
       #  cOsWinNT   = running on Windows NT
       #  cOsWin2000 = running on Windows 2000
       #  cOsXP      = running on Windows XP
       #  cOS2003    = running on Windows 2003 or Windows 2003 Release 2
       #  cOSXP64    = running on Windows XP 64 Edition (not supported at the moment)
       #  cOsVista   = running on Windows Vista
       #  cOsWin2008 = running on Windows 2008 (tested on rc)
     )
    }
    function GetWindowsType: Integer;

    {<B>IsServer</B> checks if the system is a server version.
     <B>IsServer</B> returns <B>true</B> if the system is a Server; otherwise <B>false</B> (Workstation).
    }

    property IsServer: Boolean read FIsServer;

    {<B>IsTerminalServer</B> checks if the system is a Terminal Server. A server is considered to
     be a Terminal Server if it meets one of the following conditions:

     # The Terminal Server is in application mode
     # The Terminal Server is advertising itsself on the network


     <B>IsTerminalServer</B> returns <B>true</B> if the system is a Terminal Server in application mode
     ; otherwise <B>false</B>.
     See Also
     * TJwTerminalServer.EnumerateServers
    }
    property IsTerminalServer: Boolean read FIsTerminalServer;

    {<B>IsWindows2000</B> checks if the system has the version given in the function name.
     @param bOrHigher defines if the return value should also be <B>true</B> if the system
     is better/higher than the requested system version.
     @returns <B>IsWindows2000</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
     otherwise <B>false</B>.
     If bOrHigher is <B>true</B> the return value is the result of
     <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
     <B>false</B> if GetWindowsType < (requested version)

    }
    function IsWindows2000(bOrHigher: boolean = False): boolean;

    {<B>IsWindows2003</B> checks if the system has the version given in the function name.
     @param bOrHigher defines if the return value should also be <B>true</B> if the system
     is better/higher than the requested system version.
     @return <B>IsWindows2003</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
     otherwise <B>false</B>.
     If bOrHigher is <B>true</B> the return value is the result of
     <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
     <B>false</B> if GetWindowsType < (requested version)

    }
    function IsWindows2003(bOrHigher: boolean = False): boolean;

    {<B>IsWindowsXP</B> checks if the system has the version given in the function name.
     @param bOrHigher defines if the return value should also be <B>true</B> if the system
     is better/higher than the requested system version.
     @return <B>IsWindowsXP</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
     otherwise <B>false</B>.
     If bOrHigher is <B>true</B> the return value is the result of
     <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
     <B>false</B> if GetWindowsType < (requested version)

    }
    function IsWindowsXP(bOrHigher: boolean = False): boolean;

    {<B>IsWindows2008</B> checks if the system has the version given in the function name.
     @param bOrHigher defines if the return value should also be <B>true</B> if the system
     is better/higher than the requested system version.
     @return <B>IsWindows2008</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
     otherwise <B>false</B>.
     If bOrHigher is <B>true</B> the return value is the result of
     <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
     <B>false</B> if GetWindowsType < (requested version)

    }
    function IsWindows2008(bOrHigher: boolean = False): boolean;


    {<B>IsWindowsVista</B> checks if the system has the version given in the function name.
     @param bOrHigher defines if the return value should also be <B>true</B> if the system
     is better/higher than the requested system version.
     @return <B>IsWindowsVista</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
     otherwise <B>false</B>.
     If bOrHigher is <B>true</B> the return value is the result of
     <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
     <B>false</B> if GetWindowsType < (requested version)

    }
    function IsWindowsVista(bOrHigher: boolean = False): boolean;

    {<B>IsWindowsBeta</B> checks if the system has the version given in the function name.
     @param bOrHigher defines if the return value should also be <B>true</B> if the system
     is better/higher than the requested system version.
     @return <B>IsWindowsVista</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
     otherwise <B>false</B>.
     If bOrHigher is <B>true</B> the return value is the result of
     <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
     <B>false</B> if GetWindowsType < (requested version)

    }
    function IsWindows7(bOrHigher: boolean = False): boolean;


    {<B>Server</B> is the servername as returned by Windows Api}
    property Server: TJwString read FServer;
  end;




  {<B>TJwSystemInformation</B> provides methods to retrieve information about
   Windows (UAC, TS, Session, Processes) and the system it is running on.
   To get the Windows Version (also 64/32bit, ServicePack, Edition) call a method from class TJwWindowsVersion.
   }
  TJwSystemInformation = class
  public
    {<B>IsTerminalServiceRunning</B> checks the status of the terminal service.

     Return
        Returns true if the terminal service is running; otherwise false.
     Remarks
        On Windows 7 (Workstation) the function returns in most cases false because
        of a changed Windows TS architecture.
        Even if TS is not running you can safely call any WTS function. So
        you just need to check for Windows 7 and ignore the result of IsTerminalServiceRunning.
    }
    class function IsTerminalServiceRunning : Boolean; virtual;

    // <B>GetNativeProcessorArchitecture</B> returns processor architecture of the system
    class function GetNativeProcessorArchitecture : TJwProcessorArchitecture; virtual;


    {IsRemoteSession returns true if the current session is a remote session (RDP); otherwise false.}
    class function IsRemoteSession : Boolean; virtual;

    {IsConsoleSession returns true if the current session is the console session; otherwise false.}
    class function IsConsoleSession : Boolean; virtual;

    {IsShadowedSession returns true if the current session is shadowed; otherwise false.}
    class function IsShadowedSession : Boolean; virtual;

    {GetConsoleSessionId returns the ID of the current console session.}
    class function GetConsoleSessionId: TJwSessionId; virtual;

    {GetSystemBootType returns the boot type of Windows. (normal, fail safe, fail safe with network)

    Exceptions
      EJwsclInvalidIndex The boot type could not be determined. Read property LastError of the exception
           to get the boot type value returned by GetSysteMetrics.
    }
    class function GetSystemBootType : TJwSystemBootType; virtual;

    {IsShuttingDown returns true if the system is shutting down.

    Exceptions
      EJwsclUnsupportedWindowsVersionException Only Windows XP and newer support this call.}
    class function IsShuttingDown : Boolean; virtual;

    {GetSystemDEPPolicy returns the SYSTEM DEP Policy Flag.

     Return value
      The function returns a value of TJwDEPSystemPolicy or
        spUnsupported if the system does not support DEP.
    }
    class function GetSystemDEPPolicy : TJwDEPSystemPolicy; virtual;

    { GetProcessDEPPolicy returns the Data Execution Prevention (DEP) flag of a process.


      Parameters
      ProcessHandle :  ProcessHandle defines a handle to a process which DEP is to be returned. Set to 0 or \-1 to retrieve
                       DEP status of the current process.
      Returns
      The return value can be depDisabled or a combination of depEnabled, depATLDisableThunkEmulation and depPermanent.
      Remarks
      On a Windows XP prior to SP3 or in a 64bit process the function returns [depUnsupported].                             }
    class function GetProcessDEPPolicy(ProcessHandle : DWORD = 0) : TJwDEPProcessPolicy; virtual;

    { SetProcessDEPPolicy sets the Data Execution Prevention (DEP) flag of the current process.


      Parameters
      NewPolicy :  NewPolicy defines the kind of DEP policy to be set.
      Remarks
      If Parameter NewPolicy contains depEnabled, it also must contain depPermanent.

      On a Windows XP prior to SP3 or in a 64bit process the function does nothing.             }
    class procedure SetProcessDEPPolicy(NewPolicy : TJwDEPProcessPolicy); virtual;

    {GetProcessorFeatures returns a set of available processor features.

    Remarks
      This function does not fail.
    }
    class function GetProcessorFeatures : TJwProcessorFeatures; virtual;

    { <b>IsProcess64</b> checks if a process is 64 bit. param ProcessHandle Defines the process to be checked for 64 bit.
      If this parameter is zero the current process is used instead. return Returns true if the given process is a 64bit
      process.
      Parameters
      ProcessHandle :  ProcessHandle defines a handle to a process. Set to 0 or \-1 to use the current process.
      Remarks
      The process must have the following access rights:
      <table>
      XP/2003           PROCESS_QUERY_INFORMATION
      Vista and newer   PROCESS_QUERY_INFORMATION and PROCESS_QUERY_LIMITED_INFORMATION
      </table>                                                                                                            }
    class function IsProcess64(ProcessHandle : DWORD = 0) : boolean; virtual;

    { IsWOWProcess64 checks whether the current or a given process is running under WOW64.


      Parameters
      ProcessHandle :  ProcessHandle defines a handle to a process. Set to 0 or \-1 to use the current process. }
    class function IsWOWProcess64(ProcessHandle : DWORD = 0) : boolean; virtual;

    { <b>GetNumberOfProcessors</b> returns the number of logical or physical available processors in the system.


      Parameters
      ProcessorType :  Defines the kind of processor which count is to be returned. See TJwProcessorCountType for more
                       information.
      Returns
      \Returns the number of available logical or physical processors.
      Remarks
      The numbers of available logical processors may depend on the Windows version and architecture type. On Windows
      prior to 7, the return value may be less than 32 for 32bit processes. On Windows 7 a 32bit process can retrieve more
      than 64 bit processors but may not be able to use them.

      The number of physical processors should not depend on Windows version and architecture but not all physical
      processors may be available to the system. Furthermore, on a system with hyper threading technology the returned
      number of physical processors may not be the correct number. Instead the number of logical processors is returned.

      On Windows 2000, XP with SP1 or SP2 HyperThreading is not recognized here.

      The function ignores the affinity mask set for the process.
                                                                                                                           }
    class function GetNumberOfProcessors(ProcessorType :  TJwProcessorCountType = pctLogicalProcessors) : Cardinal; virtual;

    { <b>GetProcessFileName</b> returns the absolute file path of a process.
      Parameters
      ProcessHandle :  ProcessHandle defines a handle to a process which filename is to be returned. Set to 0 or \-1 to
                       retrieve the name of the current process.
      Returns
      The function returns the process file path (e.g. C:\\Windows\\Process.exe)
      Remarks
      Currently, the function will fail with exception EJwsclProcNotFound if the implementation is not supported on
      Windows. Newer implementation may cure this.                                                                      }
    class function GetProcessFileName(ProcessHandle : THandle = INVALID_HANDLE_VALUE) : TJwString; virtual;

    //class function GetAvailableMemory : Int64;
  end;

  {This class provides methods about the Windows shell}
  TJwShellInformation = class(TJwSystemInformation)
  protected
    {Only for internal usage!

     This method returns a token handle (the internal from TJwSecurityToken) and may try to
     load the user profile.

     Parameters
       Token Defines a token that is used to retrieve the folder. May be nil.
        You can use the pseudo class instance <b>JwDefaultUserPseudoToken</b> here to
        retrieve the folders of the default user. Do not access any method or property
        of JwDefaultUserPseudoToken since it is not a valid instance.
       TokenHandle Returns the token handle. It will be INVALID_HANDLE_VALUE if Parameter Token
          is JwDefaultUserPseudoToken. This value will be 0 if Windows is not XP or newer.
       bProfilLoaded Returns true if a user profile for the token was loaded and must be
          unloaded afterwards. Use Parameter ProfileInfo to unload the profile.
       ProfileInfo Returns profile information on how to unload the profile. This information
          is undefined if bProfilLoaded is false.

     Remarks
       bProfilLoaded will be always false if Parameter Token is invalid (nil or JwDefaultUserPseudoToken).
    }
    class procedure GetTokenHandle(const Token: TJwSecurityToken;
                      out TokenHandle : TJwTokenHandle; out bProfilLoaded : boolean;
                      out ProfileInfo : TJwProfileInfo);
  public
    {<b>GetShellRestrictions</b> returns all restrictions an administrator placed in the system.

    }
    class function GetShellRestrictions : TJwShellRestrictions; virtual;

    { <b>GetFolderPath</b> retrieves a known folder path from the system.
      Parameters
      OwnerWindow :  Set to 0.
      Folder :       A CSIDL value of a folder to be retrieved. See CSIDL_xxxx values in MSDN (e.g. CSIDL_ADMINTOOLS).
      Token :        A token of a user which is used to retrieve the folder path. The returned path will point to the
                     user's folder. If this value is nil the current user is used.<p />The parameter can be the constant
                     JwDefaultUserPseudoToken to retrieve the folders of the "default user" profile.
      FolderType :   Type of folder\: Current (currently set) or default (preconfigured by Windows).
      Exceptions
      EJwsclWinCallFailedException :  A call to SHGetFolderPath failed. To get error information you can read LastError
                                      property of exception.<p />
      EJwsclAccessTypeException :     The supplied token has not enough access rights to be used here.
      Remarks
      This method calls SHGetFolderPath. For more information on its parameters refer to MSDN.



      The calling thread won't necessarily be impersonated after the call.
                                                                                                                         }
    class function GetFolderPath(const OwnerWindow : HWND; Folder : Integer;
        Token : TJwSecurityToken; const FolderType : TJwShellFolderType) : TJwString;

{$IFDEF WINVISTA_UP}
    {
    <b>GetKnownFolderPath</b> retrieves a folder path from the system on Vista and newer.

    Parameters
      FolderID : Defines a GUID that identifies the folder. Use the FOLDERID_xxx constants from JEDI API.
      Token : Defines a token that is used to retrieve the folder. May be nil.
      You can use the pseudo class instance <b>JwDefaultUserPseudoToken</b> here to
      retrieve the folders of the default user. Do not access any method or property
      of JwDefaultUserPseudoToken since it is not a valid instance.


    Remarks
      This method calls SHGetKnownFolderPath. For more information on its parameters
      refer to MSDN
    }
    class procedure GetKnownFolderPath(const FolderId : KNOWNFOLDERID;
        out Path : TJwWideString;
        const KnownFolderFlags : DWORD = 0;
        const Token : TJwSecurityToken = nil);


    {
    <b>SetKnownFolderPath</b> sets a folder path of the system on Vista and newer.

    Parameters
      Token Defines a token that is used to retrieve the folder. May be nil.
      You can use the pseudo class instance <b>JwDefaultUserPseudoToken</b> here to
      retrieve the folders of the default user. Do not access any method or property
      of JwDefaultUserPseudoToken since it is not a valid instance.

    Remarks
      This method calls SHGetKnownFolderPath. For more information on its parameters
      refer to MSDN
    }
    class procedure SetKnownFolderPath(const FolderId : KNOWNFOLDERID;
            const Path : TJwWideString;
            const KnownFolderFlags : DWORD = 0;
            const Token : TJwSecurityToken = nil);
{$ENDIF WINVISTA_UP}


    {<B>IsUACEnabled</B> returns true if the Windows system has UAC enabled.

     Remarks
       This method calls the function JwsclToken.JwIsUACEnabled

    }
    class function IsUACEnabled : Boolean; virtual;

    { <b>IsUserAdmin</b> checks whether the current user has administrative rights.
      Remarks
      The method calls the function JwsclToken.JwIsMemberOfAdministratorsGroup

      If User Account Control (UAC) is activated the function returns FALSE if the process is not elevated; otherwise
      true.                                                                                                           }
    class function IsUserAdmin : Boolean; virtual;
  end;

  { This structure maps either to the Ansi- or Unicodeversion of the Winapi OS information structure.

    Source Description
    <c lang="Delphi">TOSVersionInfoEx = {$IFDEF UNICODE&#125;TOSVersionInfoExW{$ELSE&#125;TOSVersionInfoExA{$ENDIF&#125;;</c> }
  TOSVersionInfoEx =
    {$IFDEF UNICODE}TOSVersionInfoExW{$ELSE}TOSVersionInfoExA{$ENDIF};

  {<B>TJwSystemInformation</B> provides methods to detect the windows version and product type.
   All methods are class methods so there is no need for an instance of <B>TJwWindowsVersion</B>.
   }
  TJwWindowsVersion = class(TJwSystemInformation)
  protected
     {This method returns a constant cOsXXXX from JwsclTypes by
      iterating the constant array SupportedWindowVersions using the
      current Windows version.
     }
     class function GetCurrentWindowsTypeInternal(
        out osVerInfo: {$IFDEF UNICODE}TOSVersionInfoExW{$ELSE}TOSVersionInfoExA{$ENDIF};
        out IsServer : Boolean): integer; virtual;

  public
     {This method returns a constant cOsXXXX from JwsclTypes by
      iterating the constant array SupportedWindowVersions using the
      OS Version Info from OSVerInfo.

      Not all information may be gathered from OSVerInfo because SupportedWindowVersions
      may use callbacks that use other location.
     }
     class function GetCurrentSupportedWindowsVersionCOSIndex(const
        OSVerInfo: TOSVersionInfoEx) : Integer; overload;

     class function GetCurrentSupportedWindowsVersionCOSIndex(const HiVersion,
        LoVersion : DWORD; IsServer : Boolean) : Integer; overload;


     class function GetCurrentSupportedWindowsVersion(const
        OSVerInfo: TOSVersionInfoEx) : TJwWindowsVersionDefinition; overload;

     class function GetCurrentSupportedWindowsVersion(const HiVersion,
        LoVersion : DWORD; IsServer : Boolean) : TJwWindowsVersionDefinition; overload;

     {GetSupportedOSVersion returns a copy of a JWSCL Windows Version information by an Index.

      Parameters
        Index : Receives an index of a supported Windows Version. The bounds can be determined by GetSupportedOSVersionBoundary.
      }
     class function GetSupportedOSVersion(const Index : Integer) : TJwWindowsVersionDefinition;

     {GetSupportedOSVersionBoundary returns the high and low boundary used for GetSupportedOSVersion}
     class function GetSupportedOSVersionBoundary : TJwArrayBounds;

     class function GetSupportedOSByGuid(const IsAWinGUID : Boolean; ID : TGuid) : TJwWindowsVersionDefinition;
  protected
     //callback functions for array: SupportedWindowVersions
     class function _IsServer2003R2(osVerInfo: TOSVersionInfoEx;
         Definition : PJwWindowsVersionDefinition;
          var ResultValue : Boolean) : Boolean;
     class function _IsWin98SE(osVerInfo: TOSVersionInfoEx;
         Definition : PJwWindowsVersionDefinition;
          var ResultValue : Boolean) : Boolean;

     class function _IsNewUnknown(osVerInfo: TOSVersionInfoEx;
         Definition : PJwWindowsVersionDefinition;
          var ResultValue : Boolean) : Boolean;

  public
   {<B>GetWindowsType</B> returns a constant that defines the windows version the process is running.
       @return The return value can be one of these constants defined in JwsclConstants
        Currently these items are supported

         #  cOsUnknown = The system is unknown
         #  cOsWin95   = running on Windows 95
         #  cOsWin98   = running on Windows 98
         #  cOsWin98SE = running on Windows 98 Second Edition
         #  cOsWinME   = running on Windows ME
         #  cOsWinNT   = running on Windows NT
         #  cOsWin2000 = running on Windows 2000
         #  cOsXP      = running on Windows XP
         #  cOS2003    = running on Windows 2003
         #  cOS2003R2  = running on Windows 2003 Release 2
         #  cOsVista   = running on Windows Vista
         #  cOsWin2008 = running on Windows 2008 (tested on rc)
         #  cOsWin7    = running on Windows 7
         #  cOsWin2008R2 = running on Windows 2008R2

       }

    class function GetWindowsType(
          out osVerInfo: TOSVersionInfoEx): integer; virtual;

    class function GetCachedWindowsType: integer;
    class function SetCachedWindowsType(const WindowsType : Integer; Server : Boolean = False) : Integer; virtual;
    class procedure ResetCachedWindowsType; virtual;

      {<B>IsWindows95</B> checks if the system has the version given in the function name.
       @param bOrHigher defines if the return value should also be <B>true</B> if the system
              is better/higher than the requested system version.
       @return <B>IsWindows95</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
               otherwise <B>false</B>.
               If bOrHigher is <B>true</B> the return value is the result of
                <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
                <B>false</B> if GetWindowsType < (requested version)

       }
    class function IsWindows95(bOrHigher: boolean = False): boolean;
      virtual;
      {<B>IsWindows98</B> checks if the system has the version given in the function name.
       @param bOrHigher defines if the return value should also be <B>true</B> if the system
              is better/higher than the requested system version.
       @return <B>IsWindows98</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
               otherwise <B>false</B>.
               If bOrHigher is <B>true</B> the return value is the result of
                <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
                <B>false</B> if GetWindowsType < (requested version)

       }

    class function IsWindows98(bOrHigher: boolean = False): boolean;
      virtual;

      {<B>IsWindowsME</B> checks if the system has the version given in the function name.
       @param bOrHigher defines if the return value should also be <B>true</B> if the system
              is better/higher than the requested system version.
       @return <B>IsWindowsME</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
               otherwise <B>false</B>.
               If bOrHigher is <B>true</B> the return value is the result of
                <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
                <B>false</B> if GetWindowsType < (requested version)

       }

    class function IsWindowsME(bOrHigher: boolean = False): boolean;
      virtual;

            {<B>IsWindows2000</B> checks if the system has the version given in the function name.
       @param bOrHigher defines if the return value should also be <B>true</B> if the system
              is better/higher than the requested system version.
       @return <B>IsWindows2000</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
               otherwise <B>false</B>.
               If bOrHigher is <B>true</B> the return value is the result of
                <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
                <B>false</B> if GetWindowsType < (requested version)

       }
    class function IsWindows2000(bOrHigher: boolean = False): boolean;
      virtual;


      {<B>IsWindows2003</B> checks if the system has the version given in the function name.
       @param bOrHigher defines if the return value should also be <B>true</B> if the system
              is better/higher than the requested system version.
       @return <B>IsWindows2003</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
               otherwise <B>false</B>.
               If bOrHigher is <B>true</B> the return value is the result of
                <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
                <B>false</B> if GetWindowsType < (requested version)

       }
    class function IsWindows2003(bOrHigher: boolean = False): boolean;
      virtual;


      {<B>IsWindows2003R2</B> checks if the system has the version given in the function name.
       @param bOrHigher defines if the return value should also be <B>true</B> if the system
              is better/higher than the requested system version.
       @return <B>IsWindows2003R2</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
               otherwise <B>false</B>.
               If bOrHigher is <B>true</B> the return value is the result of
                <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
                <B>false</B> if GetWindowsType < (requested version)

       }
    class function IsWindows2003R2(bOrHigher: boolean = False): boolean;
      virtual;


      {<B>IsWindowsXP</B> checks if the system has the version given in the function name.
       @param bOrHigher defines if the return value should also be <B>true</B> if the system
              is better/higher than the requested system version.
       @return <B>IsWindowsXP</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
               otherwise <B>false</B>.
               If bOrHigher is <B>true</B> the return value is the result of
                <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
                <B>false</B> if GetWindowsType < (requested version)

       }
    class function IsWindowsXP(bOrHigher: boolean = False): boolean;
      virtual;


      {<B>IsWindowsVista</B> checks if the system has the version given in the function name.

       Currenty the parameter bOrHigher has no meaning in this function!

       @param bOrHigher defines if the return value should also be <B>true</B> if the system
              is better/higher than the requested system version.
       @return <B>IsWindowsVista</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
               otherwise <B>false</B>.
               If bOrHigher is <B>true</B> the return value is the result of
                <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
                <B>false</B> if GetWindowsType < (requested version)

       }
    class function IsWindowsVista(bOrHigher: boolean = False): boolean;
      virtual;

      {<B>IsWindows2008</B> checks if the system has the version given in the function name.

       Currently the parameter bOrHigher has no meaning in this function!

       @param bOrHigher defines if the return value should also be <B>true</B> if the system
              is better/higher than the requested system version.
       @return <B>IsWindows2008</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
               otherwise <B>false</B>.
               If bOrHigher is <B>true</B> the return value is the result of
                <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
                <B>false</B> if GetWindowsType < (requested version)

       }
    class function IsWindows2008(bOrHigher: boolean = False): boolean;
      virtual;

   { <b>IsWindows2008 R2</b> checks if the system has the version given in the function name.

     Currently the parameter bOrHigher has no meaning in this function!


     Parameters
     bOrHigher :  defines if the return value should also be <b>true</b> if the system is better/higher than the requested
                  system version.
     Returns
     <b>IsWindows2008 R2</b> returns <b>true</b> if the system is the requested version (or higher if bOrHigher is true);
     otherwise <b>false</b>. If bOrHigher is <b>true</b> the return value is the result of <b>true</b> if (bOrHigher and
     (GetWindowsType \> iVer)) is true; <b>false</b> if GetWindowsType \< (requested version)                              }
   class function IsWindows2008R2(bOrHigher: boolean = False): boolean;
      virtual;

      {<B>IsWindows7</B> checks if the system has the version given in the function name.

       Currently the parameter bOrHigher has no meaning in this function!

       @param bOrHigher defines if the return value should also be <B>true</B> if the system
              is better/higher than the requested system version.
       @return <B>IsWindows7</B> returns <B>true</B> if the system is the requested version (or higher if bOrHigher is true);
               otherwise <B>false</B>.
               If bOrHigher is <B>true</B> the return value is the result of
                <B>true</B> if (bOrHigher and (GetWindowsType > iVer)) is true;
                <B>false</B> if GetWindowsType < (requested version)

       }
    class function IsWindows7(bOrHigher: Boolean = False): Boolean; virtual;


      {<B>IsServer</B> checks if the system is a server version
       @return Returns true if the system is a server; otherwise false (Workstation). }
    class function IsServer: boolean; virtual;


      {<B>CheckWindowsVersion</B> raises an EJwsclUnsupportedWindowsVersionException exception if
       the current windows version does not correspond to the required one in the parameters.

       @param iWinVer contains a cOsXXXXX constant that is defined in JwsclConstants.
              If iWinVer is not between the bounds of sOSVerString the windows version will be checked though, but on
              exception the supplied cOsXXXX constant will be presented as "Unknown System".
       @param bOrHigher If true the exception will only be raised if the current system version
               is smaller than the given on in iWinVer; otherwise the system version must be exactly the given one in iWinVer
       @param SourceProc contains the caller method name to be displayed in the exception message
       @param SourceClass contains the caller class name to be displayed in the exception message
       @param SourceFile contains the caller file name to be displayed in the exception message
       @param SourcePos contains the caller source position to be displayed in the exception message

       raises
 EJwsclUnsupportedWindowsVersionException:  will be raised if the following expression is false :
                ((fWindowsType = iWinVer) or
                (bOrHigher and (fWindowsType > iWinVer)))
       }
    class procedure CheckWindowsVersion(const iWinVer: integer;
      bOrHigher: boolean; SourceProc, SourceClass, SourceFile: TJwString;
      SourcePos: Cardinal); virtual;

    {<B>IsWindowsX64</B> returns true if the process is running on a Windows (AMD) x64 version
      Remarks
      Call IsWindows64 to check for general 64bit Windows.
    }
    class function IsWindowsX64 : boolean; virtual;

    {<B>IsWindowsIA64</B> returns true if the process is running on a Windows IA64 version

    Remarks
      Call IsWindows64 to check for general 64bit Windows.
    }
    class function IsWindowsIA64 : boolean; virtual;

    // <B>IsWindows64</B> returns true if the process is running on any 64 bit Windows version
    class function IsWindows64 : boolean; virtual;

    //<b>GetServicePackVersion</b> returns the name and the version of the installed Windows Service Pack
    class function GetServicePackVersion : TJwServicePackVersion;

    {IsStarterEdition returns true if the current Windows is a Starter Edition.}
    class function IsStarterEdition : Boolean; virtual;

    {<b>GetProductType</b> returns the product type of the current OS and maps
     the type supported by the specified version.

     Return Value
       The supported product type.
       Currently, on XP or older the return value is ptUNDEFINED. }
    class function GetProductType(Version : TOSVersionInfoEx) : TJwProductType; overload; virtual;

    {<b>GetProductType</b> returns the current product type of Windows.
     Return Value
       The supported product type.
       Currently, on XP or older the return value is ptUNDEFINED. }
    class function GetProductType : TJwProductType; overload; virtual;
  end;

const
  {<b>JwDefaultUserPseudoToken</b> defines a pseudo user token object
   for use only with TJwShellInformation.GetFolderPath.
   Do not use it directly.
   }
  JwDefaultUserPseudoToken : TJwSecurityToken = TJwSecurityToken(-1);



{$ENDIF SL_IMPLEMENTATION_SECTION}

{$IFNDEF SL_OMIT_SECTIONS}
implementation

uses SysConst, Registry, JwsclEnumerations, ActiveX;


{$ENDIF SL_OMIT_SECTIONS}

{$IFNDEF SL_INTERFACE_SECTION}




//pseudo class variable
var
  fWindowsType: integer;
  fIsServer: boolean;
  fOSVerInfo: TOSVersionInfoEx;


const
  FlagMajorMinorServer = [wvdfMajorVersion, wvdfMinorVersion, wvdfIsServer, wvdfPlatform];
  FlagMajorMinor = [wvdfMajorVersion, wvdfMinorVersion, wvdfPlatform];
  FlagUseOnlyCallback = [];


  SupportedWindowVersionCount = 12 + 1;

  {By JWSCL supported (known) Windows versions.
   See also TJwWindowsVersionDefinitionCallback for information about callbacks.

   Real Windows definition entries start at 0 and end at high-1 .

   Be aware that the cOsXXX values are not compatible with the array index.
  }
  SupportedWindowVersions : array[-1..SupportedWindowVersionCount-1] of TJwWindowsVersionDefinition = (
    (WinConst     : cOsUnknown;
     MajorVersion : 0;
     MinorVersion : 0;
     PlatformID   : 0;
     Flags        : [wvdIgnore];
     WinGUID      : '{00000000-0000-0000-0000-000000000000}';
     ID           : '{415EAD5E-EBD6-4676-853C-C1A4F3458C4D}';
     ),
    (WinConst     : cOsWin95;
     MajorVersion : 4;
     MinorVersion : 0;
     PlatformID   : VER_PLATFORM_WIN32_WINDOWS;
     Flags        : FlagMajorMinor;
     WinGUID      : '{00000000-0000-0000-0000-000000000000}';
     ID           : '{274E9F7A-0E58-420A-8600-C2625BB68D9C}';
     ),
    (WinConst     : cOsWin98;
     MajorVersion : 4;
     MinorVersion : 10;
     PlatformID   : VER_PLATFORM_WIN32_WINDOWS;
     Flags        : FlagMajorMinorServer;
     WinGUID      : '{00000000-0000-0000-0000-000000000000}';
     ID           : '{B0E0D019-6298-465E-BD1E-92A5C2598E23}';
     Callback     : TJwWindowsVersion._IsWin98SE;
     ),
    (WinConst     : cOsWin98SE;
     MajorVersion : 4;
     MinorVersion : 10;
     PlatformID   : VER_PLATFORM_WIN32_WINDOWS;
     Flags        : FlagMajorMinor;
     WinGUID      : '{00000000-0000-0000-0000-000000000000}';
     ID           : '{6D372256-25C7-47CA-925A-0D5AF99B9FF1}';
     Callback     : TJwWindowsVersion._IsWin98SE
     ),
    (WinConst     : cOsWinME;
     MajorVersion : 4;
     MinorVersion : 90;
     PlatformID   : VER_PLATFORM_WIN32_WINDOWS;
     Flags        : FlagMajorMinor;
     WinGUID      : '{00000000-0000-0000-0000-000000000000}';
     ID           : '{5BEF1DD9-7ACB-47B5-9AC2-F6776B9F59A1}';
     ),


    (WinConst     : cOsWin2000;
     MajorVersion : 5;
     MinorVersion : 0;
     PlatformID   : VER_PLATFORM_WIN32_NT;
     IsServer     : False;
     Flags        : FlagMajorMinorServer;
     WinGUID      : '{00000000-0000-0000-0000-000000000000}';
     ID           : '{1303B749-E0D3-4A33-A655-7BF586B29E61}';
     ),
    (WinConst     : cOsXP;
     MajorVersion : 5;
     MinorVersion : 1;
     PlatformID   : VER_PLATFORM_WIN32_NT;
     IsServer     : False;
     Flags        : FlagMajorMinorServer;
     WinGUID      : '{00000000-0000-0000-0000-000000000000}';
     ID           : '{31E94B1E-2E66-4681-AA5C-98327A901869}';
     Callback     : TJwWindowsVersion._IsServer2003R2;
     ),
    (WinConst     : cOS2003;
     MajorVersion : 5;
     MinorVersion : 1;
     PlatformID   : VER_PLATFORM_WIN32_NT;
     IsServer     : True;
     Flags        : FlagMajorMinorServer;
     WinGUID      : '{00000000-0000-0000-0000-000000000000}';
     ID           : '{1BE531CD-FAB1-4B4A-8930-D0DBEB0D2330}';
     Callback     : TJwWindowsVersion._IsServer2003R2;
     ),
    (WinConst     : cOS2003R2;
     MajorVersion : 5;
     MinorVersion : 1;
     PlatformID   : VER_PLATFORM_WIN32_NT;
     IsServer     : True;
     Flags        : FlagMajorMinorServer;
     WinGUID      : '{00000000-0000-0000-0000-000000000000}';
     ID           : '{9C5B14E7-FE24-4FF6-932F-E3E3AAD7DC8F}';
     Callback     : TJwWindowsVersion._IsServer2003R2;
     ),
    (WinConst     : cOsVista;
     MajorVersion : 6;
     MinorVersion : 0;
     PlatformID   : VER_PLATFORM_WIN32_NT;
     IsServer     : False;
     Flags        : FlagMajorMinorServer;
     WinGUID      : '{e2011457-1546-43c5-a5fe-008deee3d3f0}';
     ID           : '{3144E57A-062B-439A-A17C-84A1126B586F}';
     ),
    (WinConst     : cOsWin2008;
     MajorVersion : 6;
     MinorVersion : 0;
     PlatformID   : VER_PLATFORM_WIN32_NT;
     IsServer     : True;
     Flags        : FlagMajorMinorServer;
     WinGUID      : '{e2011457-1546-43c5-a5fe-008deee3d3f0}';
     ID           : '{245E0BFD-DD36-4351-A1B0-47CB2CC16E0E}';
     ),
    (WinConst     : cOsWin7;
     MajorVersion : 6;
     MinorVersion : 1;
     PlatformID   : VER_PLATFORM_WIN32_NT;
     IsServer     : False;
     Flags        : FlagMajorMinorServer;
     WinGUID      : '{35138b9a-5d96-4fbd-8e2d-a2440225f93a}';
     ID           : '{3FD28992-6528-40DD-8602-976E67E502CE}';
     ),
    (WinConst     : cOsWin2008R2;
     MajorVersion : 6;
     MinorVersion : 1;
     IsServer     : True;
     Flags        : FlagMajorMinorServer;
     WinGUID      : '{35138b9a-5d96-4fbd-8e2d-a2440225f93a}';
     ID           : '{094D42E8-C979-4C24-9823-DA57CE71C318}';
     ),

    //always set LAST
    //The callback is called last and checks whether the Windows Version
    //is newer than JWSCL supports. If so, JWSCL returns cOsWinUnknownNew.
    (WinConst     : cOsWinUnknownNew;
     MajorVersion : 0;
     MinorVersion : 0;
     IsServer     : false;
     Flags        : []; //always execute Callback
     ID           : '{64CE430E-3919-4080-A4F2-476EB16BF73B}';
     Callback     : TJwWindowsVersion._IsNewUnknown;
     )
     //do not add new entries here.
    );


class function TJwWindowsVersion.GetCurrentSupportedWindowsVersion(const HiVersion,
  LoVersion : DWORD; IsServer : Boolean) : TJwWindowsVersionDefinition;
var OSInfo : TOSVersionInfoEx;
begin
  ZeroMemory(@OSInfo, sizeof(OSInfo));

  OSInfo.dwMajorVersion := HiVersion;
  OSInfo.dwMinorVersion := LoVersion;
  if IsServer then
    OSInfo.wProductType := VER_NT_SERVER
  else
    OSInfo.wProductType := VER_NT_WORKSTATION;

  result := GetCurrentSupportedWindowsVersion(OSInfo);
end;


class function TJwWindowsVersion.GetCurrentSupportedWindowsVersion(const
    OSVerInfo: TOSVersionInfoEx) : TJwWindowsVersionDefinition;

  function CompareVersion(
      const OSVerInfo: TOSVersionInfoEx;
      const Definition : TJwWindowsVersionDefinition) : boolean;
  var bRes : Boolean;
  begin
    if (Definition.Flags = []) and Assigned(Definition.Callback) then
    begin
      if not Definition.Callback(OSVerInfo, @Definition, result) then
        result := false;
    end
    else
    begin
      if wvdIgnore in Definition.Flags then
      begin
        Result := false;
        exit;
      end;

      result := true;
      if wvdfMajorVersion in Definition.Flags then
        result := result and (OSVerInfo.dwMajorVersion = Definition.MajorVersion);
      if wvdfMinorVersion in Definition.Flags then
        result := result and (OSVerInfo.dwMinorVersion = Definition.MinorVersion);
      if (wvdfIsServer in Definition.Flags) and Definition.IsServer then
        result := result and (OSVerInfo.wProductType <> VER_NT_WORKSTATION)
      else
        result := result and (OSVerInfo.wProductType = VER_NT_WORKSTATION);

      if result and Assigned(Definition.Callback) then
      begin
        bRes := false;

        if Definition.Callback(OSVerInfo, @Definition, bRes) then
          result := result and bRes;
      end;
    end;
  end;

var i : Integer;
begin
  result := SupportedWindowVersions[-1]; //cOsUnknown
  for I := low(SupportedWindowVersions) to high(SupportedWindowVersions) do
  begin
    if CompareVersion(OSVerInfo, SupportedWindowVersions[i]) then
    begin
      result := SupportedWindowVersions[i];
      exit;
    end;
  end;
end;


class function TJwWindowsVersion.GetCurrentSupportedWindowsVersionCOSIndex(const
    OSVerInfo: TOSVersionInfoEx) : Integer;
begin
  result := GetCurrentSupportedWindowsVersion(OSVerInfo).WinConst;
end;

class function TJwWindowsVersion.GetCurrentSupportedWindowsVersionCOSIndex(const HiVersion,
    LoVersion : DWORD; IsServer : Boolean) : Integer;
begin
  result := GetCurrentSupportedWindowsVersion(HiVersion, LoVersion, IsServer).WinConst;
end;


class function TJwFileVersion.GetFileInfo(const Filename: TJwString;
  var FileVersionInfo: TJwFileVersionInfo): Boolean;
var VerInfoSize: DWORD;
 DummyVar: DWORD;
 VersionInfo: Pointer;
 Translation: Pointer;
 VersionValue: TJwString;

function VerInfoQuery(VerInfo: Pointer; VerValue: TJwString): String;
var VerInfoSize: DWORD;
  VerInfoPtr: Pointer;
begin
  Result := '';

  VerInfoSize := 0;
{$IFDEF UNICODE}
  if VerQueryValueW(VerInfo, PWideChar(VerValue), VerInfoPtr, VerInfoSize) then
  begin
    Result := Trim(PWideChar(VerInfoPtr));
  end;
{$ELSE}
  if VerQueryValueA(VerInfo, PAnsiChar(VerValue), VerInfoPtr, VerInfoSize) then
  begin
    Result := Trim(PAnsiChar(VerInfoPtr));
  end;
{$ENDIF}

  VerInfoPtr := nil; // Memory is freed when freeing VersionInfo Pointer
end;
begin
  Result := False;
  ZeroMemory(@FileVersionInfo, SizeOf(FileVersionInfo));

  VerInfoSize :=
{$IFDEF UNICODE}
  GetFileVersionInfoSizeW(PWideChar(Filename), DummyVar);
{$ELSE}
  GetFileVersionInfoSizeA(PAnsiChar(Filename), DummyVar);
{$ENDIF}
  if VerInfoSize > 0 then begin

    // GetFileVersionInfoSize returns bytes and not char's so should be okay
    // for unicode and ansi
    GetMem(VersionInfo, VerInfoSize);

    try
      Result :=
{$IFDEF UNICODE}
      GetFileVersionInfoW(PWideChar(Filename), 0, VerInfoSize, VersionInfo);
{$ELSE}
      GetFileVersionInfoA(PAnsiChar(Filename), 0, VerInfoSize, VersionInfo);
{$ENDIF}

      // Exit on failure
      if not Result then Exit;

      Result :=
{$IFDEF UNICODE}
      VerQueryValueW(VersionInfo, '\VarFileInfo\Translation',
        Translation, VerInfoSize);
{$ELSE}
      VerQueryValueA(VersionInfo, '\VarFileInfo\Translation',
        Translation, VerInfoSize);
{$ENDIF}

      // Exit on failure
      if not Result then Exit;

      VersionValue := Format('\StringFileInfo\%.4x%.4x\',
        [LoWord(Integer(Translation^)), HiWord(Integer(Translation^))]);

      FileVersionInfo.CompanyName := VerInfoQuery(VersionInfo,
        VersionValue + 'CompanyName');
      FileVersionInfo.FileDescription := VerInfoQuery(VersionInfo,
        VersionValue + 'FileDescription');
      FileVersionInfo.FileVersion := VerInfoQuery(VersionInfo,
        VersionValue + 'FileVersion');
      FileVersionInfo.InternalName := VerInfoQuery(VersionInfo,
        VersionValue + 'InternalName');
      FileVersionInfo.LegalCopyright := VerInfoQuery(VersionInfo,
        VersionValue + 'LegalCopyright');
      FileVersionInfo.LegalTradeMarks := VerInfoQuery(VersionInfo,
        VersionValue + 'LegalTrademarks');
      FileVersionInfo.OriginalFilename := VerInfoQuery(VersionInfo,
        VersionValue + 'OriginalFilename');
      FileVersionInfo.ProductName := VerInfoQuery(VersionInfo,
        VersionValue + 'ProductName');
      FileVersionInfo.ProductVersion := VerInfoQuery(VersionInfo,
        VersionValue + 'ProductVersion');
      FileVersionInfo.Comments := VerInfoQuery(VersionInfo,
        VersionValue + 'Comments');

    finally
      FreeMem(VersionInfo);
    end;
  end;
end;


constructor TJwServerInfo.Create(const Server: TJwString);
var
  nStatus: NET_API_STATUS;
  pwServer: PWideChar;
  ServerInfoPtr: PServerInfo101;
begin
  pwServer := PWideChar(WideString(Server));

  nStatus := NetServerGetInfo(pwServer, 101, PByte(ServerInfoPtr));

  if nStatus = NERR_Success then
  begin
    FServer := ServerInfoPtr^.sv101_name;
//    Specifies, in the least significant 4 bits of the byte, the major release
//     version number of the operating system. The most significant 4 bits of the
//     byte specifies the server type. The mask MAJOR_VERSION_MASK should be used
//     to ensure correct results.
    FMajorVersion  := ServerInfoPtr^.sv101_version_major and MAJOR_VERSION_MASK;
    FMinorVersion  := ServerInfoPtr^.sv101_version_minor;
    FIsServer :=
      (JwCheckBitMask(ServerInfoPtr^.sv101_type, SV_TYPE_DOMAIN_CTRL)) or
      (JwCheckBitMask(ServerInfoPtr^.sv101_type, SV_TYPE_DOMAIN_BAKCTRL)) or
      (JwCheckBitMask(ServerInfoPtr^.sv101_type, SV_TYPE_SERVER_NT));
    FIsTerminalServer :=
      (JwCheckBitMask(ServerInfoPtr^.sv101_type, SV_TYPE_TERMINALSERVER));
    FWindowsType := GetWindowsType;

    // Free Memory
    NetApiBufferFree(ServerInfoPtr);
  end
  else begin
    raise EJwsclWinCallFailedException.CreateFmtEx(
//TODO: make ressource string
      RsWinCallFailedWithNTStatus+#13#10+'Server: %2:s', 'DisableAllPrivileges', ClassName,
      RsUNVersion, 0, True, ['NetServerGetInfo', nStatus,FServer]);
  end;
end;

function TJwServerInfo.GetWindowsType: Integer;
begin
  if FMajorVersion <= 4 then
  begin
    Result := cOsWinNT;
  end
  else if (FMajorVersion = 5) and (FMinorVersion = 0) then
  begin
    Result := cOsWin2000;
  end
  else if (FMajorVersion = 5) and (FMinorVersion = 1) then
  begin
    Result := cOsXP;
  end
  else if (FMajorVersion = 5) and (FMinorVersion = 2) then
  begin
    // Is there a way to determine 2003 R2 remotely?
    Result := cOS2003;
  end
  else if (FMajorVersion = 6) and (FMinorVersion = 0) and (not fIsServer) then
  begin
    Result := cOsVista;
  end
  else if (FMajorVersion = 6) and (FMinorVersion = 0) and (fIsServer) then
  begin
    Result := cOsWin2008;
  end
  else if (FMajorVersion = 6) and (FMinorVersion = 0) then
  begin
    Result := cOsVista;
  end
  else if (FMajorVersion = 6) and (FMinorVersion = 1) and (fIsServer) then
  begin
    Result := cOsWin2008R2;
  end
  else if (FMajorVersion = 6) and (FMinorVersion = 1) and (not fIsServer) then
  begin
    Result := cOsWin7;
  end
  else
  begin
    Result := cOsUnknown;
  end;
end;

function TJwServerInfo.IsWindows2000(bOrHigher: Boolean = False): Boolean;
const
  iVer = cOsWin2000;
begin
  Result := (FWindowsType = iVer) or (bOrHigher and (FWindowsType > iVer));
end;

function TJwServerInfo.IsWindows2003(bOrHigher: Boolean = False): Boolean;
const
  iVer = cOs2003;
begin
  Result := (FWindowsType = iVer) or (bOrHigher and (FWindowsType > iVer));
end;

function TJwServerInfo.IsWindowsXP(bOrHigher: Boolean = False): Boolean;
const
  iVer = cOsXP;
begin
  Result := (fWindowsType = iVer) or (bOrHigher and (fWindowsType > iVer));
end;

function TJwServerInfo.IsWindowsVista(bOrHigher: Boolean = False): Boolean;
const
  iVer = cOsVista;
begin
  Result := (FWindowsType = iVer) or (bOrHigher and (FWindowsType > iVer));
end;

function TJwServerInfo.IsWindows7(bOrHigher: Boolean = False): Boolean;
const
  iVer = cOsWin7;
begin
  Result := (FWindowsType = iVer) or (bOrHigher and (FWindowsType > iVer));
end;


function TJwServerInfo.IsWindows2008(bOrHigher: Boolean = False): Boolean;
const
  iVer = cOsWin2008;
begin
  Result := (FWindowsType = iVer) or (bOrHigher and (FWindowsType > iVer));
end;



class procedure TJwWindowsVersion.CheckWindowsVersion(const iWinVer: integer;
  bOrHigher: boolean; SourceProc, SourceClass, SourceFile: TJwString;
  SourcePos: Cardinal);
var
  sOrHigher, sActWinVer, sWinVer: TJwString;

begin
  if (iWinVer < low(sOSVerString)) or (iWinVer > high(sOSVerString)) then
    sWinVer := RsUnknownSuppliedOS
  else
    sWinVer := sOSVerString[iWinVer];

  try
    sActWinVer := sOSVerString[fWindowsType];
  except
    sActWinVer := sOSVerString[-1];
  end;

  sOrHigher := '';
  if bOrHigher then
    sOrHigher := RsVersionOrHigher;

  if not ((fWindowsType = iWinVer) or (bOrHigher and
    (fWindowsType > iWinVer))) then
    raise EJwsclUnsupportedWindowsVersionException.CreateFmtEx(
      RsVersionUnsupportedVersion, SourceProc, SourceClass,
      SourceFile, SourcePos, False,
      [sActWinVer,
      sWinVer, sOrHigher]);
end;


class function TJwWindowsVersion.IsWindows95(bOrHigher: boolean = False)
: boolean;
const
  iVer = cOsWin95;
begin
  Result := (fWindowsType = iVer) or (bOrHigher and
    (fWindowsType > iVer));
end;

class function TJwWindowsVersion.IsWindows98(bOrHigher: boolean = False)
: boolean;
const
  iVer = cOsWin95;
begin
  Result := (fWindowsType = iVer) or (bOrHigher and
    (fWindowsType > iVer));
end;

class function TJwWindowsVersion.IsWindowsME(bOrHigher: boolean = False)
: boolean;
const
  iVer = cOsWinME;
begin
  Result := (fWindowsType = iVer) or (bOrHigher and
    (fWindowsType > iVer));
end;

class function TJwWindowsVersion.IsWindows2000(bOrHigher: boolean = False)
: boolean;
const
  iVer = cOsWin2000;
begin
  Result := (fWindowsType = iVer) or (bOrHigher and
    (fWindowsType > iVer));
end;

class function TJwWindowsVersion.IsWindows2003(bOrHigher: boolean = False)
: boolean;
const
  iVer = cOs2003;
begin
  Result := (fWindowsType = iVer) or (bOrHigher and
    (fWindowsType > iVer));
end;

class function TJwWindowsVersion.IsWindows2003R2(bOrHigher: boolean = False)
: boolean;
const
  iVer = cOs2003R2;
begin
  Result := (fWindowsType = iVer) or (bOrHigher and
    (fWindowsType > iVer));
end;

class function TJwWindowsVersion.IsWindowsXP(bOrHigher: boolean = False)
: boolean;
const
  iVer = cOsXP;
begin
  Result := (fWindowsType = iVer) or (bOrHigher and
    (fWindowsType > iVer));
end;

class function TJwSystemInformation.IsWOWProcess64(ProcessHandle: DWORD): boolean;
var res : BOOL;
begin
  if ProcessHandle = 0 then
    ProcessHandle := GetCurrentProcess();
  if IsWow64Process(ProcessHandle, res) then
    result := res
  else
    result := false;
end;

class function TJwWindowsVersion.IsWindowsVista(bOrHigher: boolean = False)
: boolean;
const
  iVer = cOsVista;
begin
  Result := (fWindowsType = iVer) or (bOrHigher and
    (fWindowsType > iVer));
end;

class function TJwWindowsVersion.IsWindows2008(bOrHigher: boolean = False)
: boolean;
const
  iVer = cOsWin2008;
begin
  Result := (fWindowsType = iVer) or (bOrHigher and
    (fWindowsType > iVer));
end;

class function TJwWindowsVersion.IsWindows2008R2(bOrHigher: boolean): boolean;
const
  iVer = cOsWin2008R2;
begin
  Result := ((fWindowsType = iVer) or (bOrHigher and
    (fWindowsType > iVer)));
end;

class function TJwWindowsVersion.IsServer: boolean;
begin
  Result := fIsServer;
end;

class function TJwWindowsVersion._IsNewUnknown(osVerInfo: TOSVersionInfoEx;
  Definition: PJwWindowsVersionDefinition;
     var ResultValue : Boolean): Boolean;
var
  I : Integer;
  MajorVer, MinorVer : Integer;
begin
  result := false;

  if Definition.WinConst <> cOsWinUnknownNew then
    exit;

  MajorVer := 0;
  MinorVer := 0;

  //get highest known version
  for I := low(SupportedWindowVersions) to high(SupportedWindowVersions) do
  begin
    if (SupportedWindowVersions[I].PlatformID = osVerInfo.dwPlatformId) then
    begin
      if (SupportedWindowVersions[I].MajorVersion > MajorVer) or
         ((SupportedWindowVersions[I].MajorVersion = MajorVer) and
         (SupportedWindowVersions[I].MinorVersion > MinorVer)) then
      begin
        MajorVer := SupportedWindowVersions[I].MajorVersion;
        MinorVer := SupportedWindowVersions[I].MinorVersion;
      end;
    end;
  end;

  if I = -1 then
    exit;

  if (osVerInfo.dwMajorVersion > MajorVer) or
     ((osVerInfo.dwMajorVersion = MajorVer) and
      (osVerInfo.dwMinorVersion > MinorVer)) then
  begin
    result := true;
    ResultValue := True;
  end;
end;

class function TJwWindowsVersion._IsServer2003R2(osVerInfo: TOSVersionInfoEx;
  Definition: PJwWindowsVersionDefinition;
     var ResultValue : Boolean): Boolean;
begin
  ResultValue := Boolean(GetSystemMetrics(SM_SERVERR2));
  result := (Definition.WinConst = cOsWin2008R2);
end;

class function TJwWindowsVersion._IsWin98SE(osVerInfo: TOSVersionInfoEx;
  Definition: PJwWindowsVersionDefinition;
     var ResultValue : Boolean): Boolean;
begin
  ResultValue := (osVerInfo.szCSDVersion[1] = 'A');
  result := (Definition.WinConst = cOsWin98SE);
end;

class function TJwSystemInformation.IsShadowedSession: Boolean;
begin
  result := GetSystemMetrics(SM_REMOTECONTROL) <> 0;
end;

class function TJwSystemInformation.IsShuttingDown: Boolean;
var
  VerInfo : TJwWindowsVersionDefinition;
begin
  if TJwWindowsVersion.IsWindowsXP(true) then
    result := GetSystemMetrics(SM_SHUTTINGDOWN) <> 0
  else
  begin
    VerInfo := TJwWindowsVersion.GetCurrentSupportedWindowsVersion(5,1, False);

    raise EJwsclUnsupportedWindowsVersionException.CreateFmtEx(
        RsUnsupportedCallByWindowsVersionWithMinVersion,
        'IsShuttingDown',                                //sSourceProc
        ClassName,                                //sSourceClass
        RSUnVersion,                          //sSourceFile
        0,                                           //iSourceLine
        false,                                  //bShowLastError
        [VerInfo.MajorVersion, VerInfo.MinorVersion, JwGetOsVerString(VerInfo.WinConst)]);                                  //const Args: array of const
  end;
end;

class function TJwWindowsVersion.IsStarterEdition: Boolean;
begin
  result := GetSystemMetrics(SM_SERVERR2) <> 0;
end;


class function TJwWindowsVersion.GetWindowsType(
    out osVerInfo: TOSVersionInfoEx
  ): integer;
var dummy : Boolean;
begin
  result := GetCurrentWindowsTypeInternal(osVerInfo, dummy);
end;

class function TJwWindowsVersion.GetCurrentWindowsTypeInternal(
    out osVerInfo: TOSVersionInfoEx;
    out IsServer : Boolean): integer;
begin
  //  Result := cOsUnknown;

  osVerInfo.dwOSVersionInfoSize := SizeOf(osVerInfo);

  if
{$IFDEF UNICODE}GetVersionExW{$ELSE}
  GetVersionExA
{$ENDIF}
    (@osVerInfo) then
  begin
    result := GetCurrentSupportedWindowsVersionCOSIndex(osVerInfo);
  end
  else
    Result := cOsUnknown;
end;



class function TJwWindowsVersion.GetProductType(Version: TOSVersionInfoEx): TJwProductType;
type
  TGetProductInfo = function(
      {__in}   dwOSMajorVersion,
      {__in}   dwOSMinorVersion,
      {__in}   dwSpMajorVersion,
      {__in}   dwSpMinorVersion : DWORD;
      {__out}  pdwReturnedProductType : PDWORD) : BOOL; stdcall;

var
  GetProductInfo : TGetProductInfo;
  ProdType : DWORD;
begin
  if TJwWindowsVersion.IsWindowsVista(true) or TJwWindowsVersion.IsWindows2008(true) then
  begin
    GetProcedureAddress(@GetProductInfo, kernel32, 'GetProductInfo');

    if not GetProductInfo(Version.dwMajorVersion, Version.dwMinorVersion,
                   Version.wServicePackMajor, Version.wServicePackMinor,
                   @ProdType) then
    begin
      //TODO: also check for K SKUS
      //http://msdn.microsoft.com/en-us/library/aa965835%28VS.85%29.aspx
      //http://msdn.microsoft.com/en-us/library/ms724358%28VS.85%29.aspx
      raise EJwsclInvalidParameterException.Create(RsInvalidValueInVersionParameter);
    end;

    //$ABCDABCD has the highest bit set and thus is recognized as negative by Delphi
    //  which, in return, will produce an warning at TJwProductType
    //Using a value without this last bit as ptUnlicensed makes it necessary
    //  to distinguish it here.
    if ProdType = $ABCDABCD then
      result := ptUnlicensed
    else
      result := TJwProductType(ProdType);
  end
  else
  begin
    //TODO: use WIM ?
    result := ptUNDEFINED;
  end;
end;

class function TJwWindowsVersion.GetProductType: TJwProductType;
begin
  result := GetProductType(fOSVerInfo);
end;


class function TJwSystemInformation.IsTerminalServiceRunning: Boolean;
begin
  result := JwaWindows.IsTerminalServiceRunning;
end;





class function TJwSystemInformation.GetProcessFileName(
  ProcessHandle: THandle = INVALID_HANDLE_VALUE): TJwString;
var
  hProc : THandle;
  Len : Cardinal;
  S : WideString;
  US : PUnicodeString;
  Status : NTSTATUS;
begin
  if (ProcessHandle = 0) or (ProcessHandle = INVALID_HANDLE_VALUE) then
  begin
    hProc := OpenProcess(PROCESS_QUERY_INFORMATION, False, GetCurrentProcessId);
  end
  else
    hProc := ProcessHandle;
  try
    US := nil;

    try
      Status := NtQueryInformationProcess(
        hProc,//__in       HANDLE ProcessHandle,
        ProcessImageFileName,//__in       PROCESSINFOCLASS ProcessInformationClass,
        US,//__out      PVOID ProcessInformation,
        0,//__in       ULONG ProcessInformationLength,
        @Len//__out_opt  PULONG ReturnLength
      );
    except
      on E : EJwsclProcNotFound do
      begin
        raise;
      end;
    end;

    if (Status = STATUS_INFO_LENGTH_MISMATCH) then
    begin
      US := JwCreateUnicodeStringSelfRelative(Len);

      try
        Status := NtQueryInformationProcess(
          hProc,//__in       HANDLE ProcessHandle,
          ProcessImageFileName,//__in       PROCESSINFOCLASS ProcessInformationClass,
          US,//__out      PVOID ProcessInformation,
          Len,//__in       ULONG ProcessInformationLength,
          @Len//__out_opt  PULONG ReturnLength
        );

        if Status = STATUS_SUCCESS then
        begin
          S := JwUnicodeStringToJwString(US^);
          result := JwDeviceToDosDrive(S);
          exit;
        end
      finally
        FreeMem(US);
      end;
    end;

    if Status <> STATUS_SUCCESS then
    begin
      SetLastError(RtlNtStatusToDosError(Status));
      raise EJwsclWinCallFailedException.CreateFmtWinCall(
          RsWinCallFailed,
          'GetModuleFileName',                                //sSourceProc
          ClassName,                                //sSourceClass
          RSUnVersion,                          //sSourceFile
          0,                                           //iSourceLine
          true,                                  //bShowLastError
          'GetModuleFileName',                   //sWinCall
          ['GetModuleFileName']);                                  //const Args: array of const
    end;
  finally
    if hProc <> ProcessHandle then
      CloseHandle(hProc);
  end;

  JwUNIMPLEMENTED;
end;

class function TJwSystemInformation.GetNativeProcessorArchitecture : TJwProcessorArchitecture;
var
  SystemInfo : SYSTEM_INFO;
  // only available on Windows >= 5.1 so we have to link it dynamically
  GetNativeSystemInfo : procedure (lpSystemInfo: LPSYSTEM_INFO); stdcall;
begin
  GetNativeSystemInfo := GetProcAddress(GetModuleHandle(kernel32), 'GetNativeSystemInfo');
  if @GetNativeSystemInfo <> nil
    then
      begin
        GetNativeSystemInfo(@SystemInfo);
        result := TJwProcessorArchitecture(SystemInfo.wProcessorArchitecture);
      end
    else
      result := paINTEL;
end;




class function TJwSystemInformation.GetNumberOfProcessors(
  ProcessorType: TJwProcessorCountType): Cardinal;

  function GetActiveProcessors(Mask : DWORD) : DWORD;
  var I : Integer;
  begin
    result := 0;
    for I := 0 to (sizeof(Mask) * 8)-1 do
    begin
      if ((1 shl I) and Mask) = (1 shl I) then
        Inc(Result);
    end;
  end;


type
  TBufArray = array[0..0] of SYSTEM_LOGICAL_PROCESSOR_INFORMATION;
  //TODO: move to jwa
  TGetActiveProcessorCount = function ({__in} GroupNumber : Word) : DWORD; stdcall;

const
  ALL_PROCESSOR_GROUPS = $FFFF;


var
  SysInfo : TSystemInfo;
  Size, Len,
  LogicalCount, CoreCount, PhysicalCount : Cardinal;
  Buf : ^TBufArray;
  Res : Boolean;
  I : Integer;

  GetActiveProcessorCount : TGetActiveProcessorCount;
begin
  if ProcessorType = pctLogicalProcessors then
  begin
    if TJwWindowsVersion.IsWindows7(true) or
      TJwWindowsVersion.IsWindows2008R2(true) then
    begin
      //on newer windows version we can get the real active processor count (> 64)
      try
        GetActiveProcessorCount := nil;
        JwaWindows.GetProcedureAddress(@GetActiveProcessorCount, kernel32, 'GetActiveProcessorCount');
        result := GetActiveProcessorCount(ALL_PROCESSOR_GROUPS);
        exit;
      except
        on E : EJwsclProcNotFound do; //skip next
      end;
    end;
  end;

  try
//    GetLogicalProcessorInformation is present only on
//    Windows Vista, Windows XP Professional x64 Edition, Windows XP with SP3
//    This is a little bit complicated, so we just call it

    Len := 0;
    Res := GetLogicalProcessorInformation(nil, @Len);
  except
    on E : EJwsclProcNotFound do
    begin
      //function not implemented on this system... return to pyhsical cpu count
      Res := FALSE;
      SetLastError(0);
    end;
  end;

  if not Res and (GetLastError() = ERROR_INSUFFICIENT_BUFFER) then
  begin
    GetMem(Buf, Len);
    try
//
//        f�r win7
//        + GetActiveProcessorCount
//
//        http://msdn.microsoft.com/en-us/library/ms683194%28VS.85%29.aspx
//
//        1.
//        On systems with more than 64 logical processors, the GetLogicalProcessorInformation
//        function retrieves logical processor information about processors in the processor
//        group to which the calling thread is currently assigned. Use the GetLogicalProcessorInformationEx
//        function to retrieve information about processors in all processor groups on the system.
//
//        2.
//        Windows Server 2003, Windows XP Professional x64 Edition, and Windows XP with SP3:
//          This code reports the number of physical processors rather than the number of active processor cores.

      Res := GetLogicalProcessorInformation(@Buf[0], @Len);
      if not Res then
        raise EJwsclWinCallFailedException.CreateFmtWinCall(
          RsWinCallFailed,
          'GetNumberOfProcessors',                                //sSourceProc
          ClassName,                                //sSourceClass
          RSUnVersion,                          //sSourceFile
          0,                                           //iSourceLine
          True,                                  //bShowLastError
          'GetLogicalProcessorInformation #2',                   //sWinCall
          ['GetLogicalProcessorInformation']);                                  //const Args: array of const

      Size := Len div sizeof(SYSTEM_LOGICAL_PROCESSOR_INFORMATION);

      LogicalCount := 0;
      CoreCount := 0;
      PhysicalCount := 0;

      {$R-}
      for I := 0 to Size - 1 do
      begin
        case Buf[I].Relationship of
          RelationProcessorCore :
            begin
              Inc(CoreCount);

              Inc(LogicalCount, GetActiveProcessors(Buf[I].ProcessorMask));
            end;
          RelationProcessorPackage :
            begin
              Inc(PhysicalCount);
            end;
        end;
      end;
    finally
      FreeMem(Buf);
    end;

    case ProcessorType of
      pctCoreProcessors     : result := CoreCount;
      pctPhysicalProcessors : result := PhysicalCount;
      pctLogicalProcessors  : result := LogicalCount;
    end;
    exit;
  end
  else
  if (GetLastError() <> 0) then
    raise EJwsclWinCallFailedException.CreateFmtWinCall(
        RsWinCallFailed,
        'GetNumberOfProcessors',                                //sSourceProc
        ClassName,                                //sSourceClass
        RSUnVersion,                          //sSourceFile
        0,                                           //iSourceLine
        True,                                  //bShowLastError
        'GetLogicalProcessorInformation #1',                   //sWinCall
        ['GetLogicalProcessorInformation']);                                  //const Args: array of const

  //otherwise get physical number instead
  //this happens on Win 2000 and Windows XP SP1, SP2

  if IsWOWProcess64 then
    GetNativeSystemInfo(@SysInfo)
  else
    GetSystemInfo(SysInfo);
  result := SysInfo.dwNumberOfProcessors;
end;

class function TJwSystemInformation.GetProcessDEPPolicy(
  ProcessHandle: DWORD): TJwDEPProcessPolicy;
var
  _GetProcessDEPPolicy : function (hProcess : HANDLE; out lpFlags : DWORD; out lpPermanent : BOOL) : BOOL; stdcall;
  Flags : DWORD;
  Permanent : BOOL;
begin
  result := [depUnsupported];

  if TJwWindowsVersion.IsWindowsXP(true) and not TJwWindowsVersion.IsProcess64() then
  begin
    _GetProcessDEPPolicy := GetProcAddress(GetModuleHandle(kernel32), 'GetProcessDEPPolicy');
    if @_GetProcessDEPPolicy <> nil then
    begin
      if (ProcessHandle = 0) then
        ProcessHandle := GetCurrentProcess;

      if not _GetProcessDEPPolicy(ProcessHandle, Flags, Permanent) then
        raise EJwsclWinCallFailedException.CreateFmtWinCall(
          RsWinCallFailed,
          'GetProcessDEPPolicy',                                //sSourceProc
          ClassName,                                //sSourceClass
          RSUnVersion,                          //sSourceFile
          0,                                           //iSourceLine
          True,                                  //bShowLastError
          'GetProcessDEPPolicy',                   //sWinCall
          ['GetProcessDEPPolicy']);                                  //const Args: array of const

      result := [];

      if (Flags and PROCESS_DEP_ENABLE) = PROCESS_DEP_ENABLE then
        result := result + [depEnabled];
      if (Flags and PROCESS_DEP_DISABLE_ATL_THUNK_EMULATION) = PROCESS_DEP_DISABLE_ATL_THUNK_EMULATION then
        result := result + [depATLDisableThunkEmulation];

      if Flags = 0 then
        result := [depDisabled];

      if Permanent then
        result := result + [depPermanent];
    end;
  end;
end;

class function TJwSystemInformation.GetProcessorFeatures: TJwProcessorFeatures;
var
  I : TJwProcessorFeature;
begin
  result := [];
  for I := low(TJwProcessorFeature) to high(TJwProcessorFeature) do
  begin
    if IsProcessorFeaturePresent(DWORD(I)) then
      result := result + [I];
  end;
end;

class function TJwWindowsVersion.IsWindowsX64 : boolean;
begin
  result := TJwSystemInformation.GetNativeProcessorArchitecture = paAMD64;
end;


class function TJwWindowsVersion.IsWindowsIA64 : boolean;
begin
  result := TJwSystemInformation.GetNativeProcessorArchitecture = paIA64;
end;


class function TJwWindowsVersion.IsWindows64 : boolean;
begin
  result := IsWindowsX64 or IsWindowsIA64;
end;


class function TJwSystemInformation.IsConsoleSession: Boolean;
begin
  result := not IsRemoteSession;
end;

class function TJwSystemInformation.IsProcess64(ProcessHandle : DWORD = 0) : boolean;
var
  RunningInsideWOW64 : BOOL;
begin
  if ProcessHandle = 0 then
    ProcessHandle := GetCurrentProcess();

  // If we are on a 64 bit Windows but NOT inside WOW64 we are running natively
  if TJwWindowsVersion.IsWindows64 then
  begin
    if IsWow64Process(ProcessHandle, RunningInsideWOW64) then
      result := not RunningInsideWOW64
    else
      raise EJwsclWinCallFailedException.CreateFmtWinCall(
        RsWinCallFailed,
        'IsProcess64',                                //sSourceProc
        ClassName,                                //sSourceClass
        RSUnVersion,                          //sSourceFile
        0,                                           //iSourceLine
        True,                                  //bShowLastError
        'IsWow64Process',                   //sWinCall
        ['IsWow64Process']);                                  //const Args: array of const
  end
  else
  begin
    result := false;
  end;
end;





class function TJwSystemInformation.IsRemoteSession: Boolean;
begin
  result := GetSystemMetrics(SM_REMOTESESSION) <> 0;
end;

class function TJwSystemInformation.GetConsoleSessionId: TJwSessionId;
asm
  mov eax, [$7ffe02d8];
end;

class function TJwWindowsVersion.GetCachedWindowsType: integer;
begin
  result := fWindowsType;
end;

class procedure TJwWindowsVersion.ResetCachedWindowsType;
begin
  fWindowsType := GetCurrentWindowsTypeInternal(fOSVerInfo, fIsServer);
end;

class function TJwWindowsVersion.SetCachedWindowsType(
  const WindowsType: Integer; Server: Boolean): Integer;
begin
  result := fWindowsType; //returns previous value
  fWindowsType := WindowsType;
  fIsServer  := Server;
end;


class procedure TJwSystemInformation.SetProcessDEPPolicy(NewPolicy: TJwDEPProcessPolicy);
var
  _SetProcessDEPPolicy : function (Flags : DWORD) : BOOL; stdcall;
  Flags : DWORD;
begin
  if TJwWindowsVersion.IsWindowsXP(true) and not TJwWindowsVersion.IsProcess64() then
  begin
    _SetProcessDEPPolicy := GetProcAddress(GetModuleHandle(kernel32), 'SetProcessDEPPolicy');
    if @_SetProcessDEPPolicy <> nil then
    begin
      Flags := 0;

      if depDisabled in NewPolicy then
        Flags := 0;

      if depEnabled in NewPolicy then
      begin
        if not (depPermanent in NewPolicy) then
           raise EJwsclInvalidParameterException.CreateFmtEx(
              RsDepEnabledRequiresPermanent,
              'SetProcessDEPPolicy',
              ClassName,
              RsUNVersion,
              0,
              false,
              []);
        Flags := Flags or PROCESS_DEP_ENABLE;
      end;

      if depATLDisableThunkEmulation in NewPolicy then
        Flags := Flags or PROCESS_DEP_DISABLE_ATL_THUNK_EMULATION;

      if not _SetProcessDEPPolicy(Flags) then
        raise EJwsclWinCallFailedException.CreateFmtWinCall(
          RsWinCallFailed,
          'GetProcessDEPPolicy',                                //sSourceProc
          ClassName,                                //sSourceClass
          RSUnVersion,                          //sSourceFile
          0,                                           //iSourceLine
          True,                                  //bShowLastError
          'GetProcessDEPPolicy',                   //sWinCall
          ['GetProcessDEPPolicy']);                                 //const Args: array of const
    end;
  end;
end;

class function TJwWindowsVersion.GetServicePackVersion: TJwServicePackVersion;
begin
  result.Version.Major :=  fOSVerInfo.wServicePackMajor;
  result.Version.Minor :=  fOSVerInfo.wServicePackMinor;
  result.Name := TJwString(fOSVerInfo.szCSDVersion);
end;

class function TJwWindowsVersion.GetSupportedOSByGuid(const IsAWinGUID: Boolean; ID : TGuid): TJwWindowsVersionDefinition;
var
  I: Integer;
  B : TJwArrayBounds;
begin
  B := GetSupportedOSVersionBoundary;
  for I := B.Low to B.High do
  begin
    if  (IsAWinGUID and
        CompareMem(@SupportedWindowVersions[I].WinGUID, @ID, sizeof(TGUID))) or
        (not IsAWinGUID and
        CompareMem(@SupportedWindowVersions[I].ID, @ID, sizeof(TGUID))) then
    begin
      result := SupportedWindowVersions[I];
      exit;
    end;
  end;
  raise EJwsclInvalidIndex.CreateFmtEx(
            'The given Guid was not found',
            'GetSupportedOSByGuid',                                //sSourceProc
            ClassName,                                //sSourceClass
            RSUnVersion,                          //sSourceFile
            0,
            false,                                    //iSourceLine
            []);                                 //const Args: array of const
end;

class function TJwWindowsVersion.GetSupportedOSVersion(const Index: Integer): TJwWindowsVersionDefinition;
begin
  result := SupportedWindowVersions[Index];
end;

class function TJwWindowsVersion.GetSupportedOSVersionBoundary: TJwArrayBounds;
begin
  //only return bounds that deliver real windows version info
  result.High := High(SupportedWindowVersions)-1;
  result.Low := 0;
end;

//bProfilLoaded will be true only if Token is a valid instance
class procedure TJwShellInformation.GetTokenHandle(const Token: TJwSecurityToken;
    out TokenHandle : TJwTokenHandle; out bProfilLoaded : boolean;
    out ProfileInfo : TJwProfileInfo);
begin
  TokenHandle := 0;
  bProfilLoaded := false;

  if Assigned(Token) and TJwWindowsVersion.IsWindowsXP(true) then
  begin
    if Token = JwDefaultUserPseudoToken then
    begin
      TokenHandle := INVALID_HANDLE_VALUE;
    end
    else
    begin
      Token.CheckTokenAccessType(TOKEN_QUERY or TOKEN_IMPERSONATE, 'TOKEN_QUERY or TOKEN_IMPERSONATE', 'TJwShellInformation.GetFolderPath');

      //The function may need a loaded user profile
      if JwIsPrivilegeSet(SE_RESTORE_NAME) then
      begin
        ZeroMemory(@ProfileInfo, sizeof(ProfileInfo));
        try
          Token.LoadUserProfile(ProfileInfo, []);
          bProfilLoaded := true;
        except
          on E: EJwsclWinCallFailedException do ; //ignore and call the function do it anyway
        end;
      end;

      TokenHandle := Token.TokenHandle;
    end;
  end;
end;

{
Remarks
  The thread won't necessarily be impersonated after the call.

}
class function TJwShellInformation.GetFolderPath(const OwnerWindow: HWND;
  Folder: Integer; Token: TJwSecurityToken;
  const FolderType: TJwShellFolderType): TJwString;

  procedure RaiseError(ErrorMsg : TJwString; Error : HRESULT );
  begin
    SetLastError(HRESULT_CODE(Error));
    raise EJwsclWinCallFailedException.CreateFmtWinCall(
            RsWinCallFailedWithNTStatus + #13#10 + ErrorMsg,
            'GetFolderPath',                                //sSourceProc
            ClassName,                                //sSourceClass
            RSUnVersion,                          //sSourceFile
            0,                                           //iSourceLine
            true,                                  //bShowLastError
            'GetProcessDEPPolicy',                   //sWinCall
            ['SHGetFolderPath', Error]);                                 //const Args: array of const
  end;

var
  pPath : array[0..MAX_PATH] of TJwChar;
  hToken : TJwTokenHandle;
  bProfilLoaded, bImpersonated : Boolean;
  hr : HRESULT;
  ProfileInfo : TJwProfileInfo;
begin
  bProfilLoaded := false;
  bImpersonated := false;

  GetTokenHandle(Token, hToken, bProfilLoaded, ProfileInfo);

  hr := {$IFDEF UNICODE}SHGetFolderPathW{$ELSE}SHGetFolderPathA{$ENDIF}(OwnerWindow, Folder,
    hToken, Cardinal(FolderType), pPath) ;

  //this happens because the current process does not have the right to retrieve it
  //and because the token must have TOKEN_IMPERSONATE, we can impersonate it and get the path anyway
  if (HRESULT_CODE(hr) = ERROR_ACCESS_DENIED) and
     Assigned(Token) and (Token <> JwDefaultUserPseudoToken) and
     TJwWindowsVersion.IsWindowsXP(true) then
  begin
    Token.ImpersonateLoggedOnUser;
    bImpersonated := true;

    hr := {$IFDEF UNICODE}SHGetFolderPathW{$ELSE}SHGetFolderPathA{$ENDIF}(OwnerWindow, Folder,
    hToken, Cardinal(FolderType), pPath) ;
  end;

  try
    case hr of
      S_OK         : result := TJwString(pPath);
      S_FALSE,

      E_FAIL       : RaiseError(RsCsidlCorrectButFolderNotFound,hr);
      E_INVALIDARG : RaiseError(RsInvalidCSIDLPath,hr);
    else
      RaiseError('',hr);
    end;
  finally
    if bImpersonated then
    begin
      try
        TJwSecurityToken.RevertToSelf;
      except
        on E: EJwsclSecurityException do ; //ignore
      end;
    end;

    if bProfilLoaded then
      Token.UnLoadUserProfile(ProfileInfo);
  end;
end;

{$IFDEF WINVISTA_UP}

class procedure TJwShellInformation.GetKnownFolderPath(const FolderId : TGuid;
        out Path : TJwWideString;
        const KnownFolderFlags : DWORD = 0;
        const Token : TJwSecurityToken = nil);
var
  hToken : TJwTokenHandle;
  sPath : PWideChar;
  hr : HRESULT;
  bProfilLoaded : Boolean;
  ProfileInfo : TJwProfileInfo;
begin
  if not TJwWindowsVersion.IsWindowsVista(true) then
    raise EJwsclUnsupportedWindowsVersionException.CreateFmtWinCall(
//TODO: make ressource string
            'The Windows version is not supported',
            'GetKnownFolderPath',                                //sSourceProc
            ClassName,                                //sSourceClass
            RSUnVersion,                          //sSourceFile
            0,                                           //iSourceLine
            false,                                  //bShowLastError
            '',                   //sWinCall
            []);                                 //const Args: array of const

  GetTokenHandle(Token, hToken, bProfilLoaded, ProfileInfo);

  sPath := nil;
  try
    hr := SHGetKnownFolderPath(FolderId, KnownFolderFlags, hToken, sPath);
    if FAILED(hr) then
    begin
      SetLastError(HRESULT_CODE(hr));
      raise EJwsclWinCallFailedException.CreateFmtWinCall(
              RsWinCallFailed,
              'GetKnownFolderPath',                                //sSourceProc
              ClassName,                                //sSourceClass
              RSUnVersion,                          //sSourceFile
              0,                                           //iSourceLine
              true,                                  //bShowLastError
              'SHGetKnownFolderPath',                   //sWinCall
              ['SHGetKnownFolderPath']);                                 //const Args: array of const
    end;
  finally
    if bProfilLoaded then
      Token.UnLoadUserProfile(ProfileInfo);
  end;

  Path := TJwWideString(sPath);

  CoTaskMemFree(sPath);
end;

class procedure TJwShellInformation.SetKnownFolderPath(const FolderId : TGuid;
            const Path : TJwWideString;
            const KnownFolderFlags : DWORD = 0;
            const Token : TJwSecurityToken = nil);
var
  hToken : TJwTokenHandle;
  hr : HRESULT;
  bProfilLoaded : Boolean;
  ProfileInfo : TJwProfileInfo;
begin
  GetTokenHandle(Token, hToken, bProfilLoaded, ProfileInfo);

  try
    hr := SHSetKnownFolderPath(FolderId, KnownFolderFlags, hToken, PWideChar(Path));
    if FAILED(hr) then
    begin
      SetLastError(HRESULT_CODE(hr));
      raise EJwsclWinCallFailedException.CreateFmtWinCall(
              RsWinCallFailed,
              'SetKnownFolderPath',                                //sSourceProc
              ClassName,                                //sSourceClass
              RSUnVersion,                          //sSourceFile
              0,                                           //iSourceLine
              true,                                  //bShowLastError
              'SHSetKnownFolderPath',                   //sWinCall
              ['SHSetKnownFolderPath']);                                  //const Args: array of const
    end;
  finally
    if bProfilLoaded then
      Token.UnLoadUserProfile(ProfileInfo);
  end;
end;


{$ENDIF WINVISTA_UP}

class function TJwShellInformation.IsUACEnabled: Boolean;
begin
  result := JwsclToken.JwIsUACEnabled;
end;

class function TJwShellInformation.IsUserAdmin: Boolean;
begin
  result := JwsclToken.JwIsMemberOfAdministratorsGroup;
end;

class function TJwShellInformation.GetShellRestrictions: TJwShellRestrictions;
var
  i : TJwShellRestriction;
  Rest : Cardinal;
begin
  result := [];
  if (TJwWindowsVersion.IsWindowsXP(true) and (TJwWindowsVersion.GetServicePackVersion.Version.Major >= 2))
    or
    TJwWindowsVersion.IsWindows2003(true) then
  begin
    for  I := low(i) to high(i) do
    begin
      Rest := TJwEnumMap.ConvertShellRestrictions([i]);
      if SHRestricted(Rest) <> 0 then
        Include(result, i);
    end;
  end;
end;

class function TJwSystemInformation.GetSystemBootType: TJwSystemBootType;
var value : DWORD;
begin
  value := GetSystemMetrics(SM_CLEANBOOT);
  if value <= DWORD(high(TJwSystemBootType)) then
    result := TJwSystemBootType(value)
  else
    raise EJwsclInvalidIndex.CreateFmtEx(
        RsInvalidSystemMetric,
        'SystemBootType',                                //sSourceProc
        ClassName,                                //sSourceClass
        RSUnVersion,                          //sSourceFile
        0,                                           //iSourceLine
        value,                                  //bShowLastError
        [value]);                                  //const Args: array of const

end;

class function TJwSystemInformation.GetSystemDEPPolicy: TJwDEPSystemPolicy;
var
  _GetSystemDEPPolicy : function () : BOOL; stdcall;
begin
  result := spUnsupported;

  if TJwWindowsVersion.IsWindowsXP(true) and not TJwWindowsVersion.IsProcess64() then
  begin
    _GetSystemDEPPolicy := GetProcAddress(GetModuleHandle(kernel32), 'GetSystemDEPPolicy');
    if @_GetSystemDEPPolicy <> nil then
    begin
      result := TJwDEPSystemPolicy(_GetSystemDEPPolicy());
    end;
  end;
end;

class function TJwWindowsVersion.IsWindows7(bOrHigher: Boolean): Boolean;
const
  iVer = cOsWin7;
begin
  Result := (FWindowsType = iVer) or (bOrHigher and (FWindowsType > iVer));
end;

{$ENDIF SL_INTERFACE_SECTION}

{$IFNDEF SL_OMIT_SECTIONS}

initialization
{$ENDIF SL_OMIT_SECTIONS}

{$IFNDEF SL_INITIALIZATION_SECTION}
  TJwWindowsVersion.ResetCachedWindowsType;

{$ENDIF SL_INITIALIZATION_SECTION}


{$IFNDEF SL_OMIT_SECTIONS}
end.
{$ENDIF SL_OMIT_SECTIONS}
