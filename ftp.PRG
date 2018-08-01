*************************************************************************
*  FTP Services for Visual Foxpro 5.0+                                  *
*  Written by: Robert Abram                                             *
*  Date: Sept 1998                                                      *
*                                                                       *
*  Revision 2.0.10                                                      *
*  Martina Jindrová                                                     *
*  E-mail: jindra@egservis.cz                                           *
*  JID   : gorila@dione.zcu.cz                                          *
*  CP    : 1250                                                         *
*  Date  : 2011-02-12                                                   *
*  GetFTPDirectoryArray() - localtime                                   *
*                                                                       *
*  Revision 2.0.9                                                       *
*  Martina Jindrová                                                     *
*  E-mail: jindra@egservis.cz                                           *
*  JID   : gorila@dione.zcu.cz                                          *
*  CP    : 1250                                                         *
*  Date  : 2011-02-12                                                   *
*  m dot operator fix                                                   *
*                                                                       *
*  Revision 2.0.8                                                       *
*  Martina Jindrová                                                     *
*  E-mail: jindra@egservis.cz                                           *
*  JID   : gorila@dione.zcu.cz                                          *
*  CP    : 1250                                                         *
*  Date  : 2009-09-30                                                   *
*                                                                       *
*  Revision 2.0.7                                                       *
*  Martina Jindrová                                                     *
*  E-mail: jindra@egservis.cz                                           *
*  JID   : gorila@dione.zcu.cz                                          *
*  CP    : 1250                                                         *
*  Date  : 2009-04-18                                                   *
*                                                                       *
*  Revision 2.0.6                                                       *
*  Martina Jindrù                                                       *
*  Thx to  Honza Cernohlavek                                            *
*  E-mail: jindra@egservis.cz                                           *
*  JID   : gorila@dione.zcu.cz                                          *
*  CP    : 1250                                                         *
*  Date  : 2008-12-17                                                   *
*                                                                       *
*  Revision 2.0.5                                                       *
*  Adrian Troche                                                        *
*  Martina Jindrù                                                       *
*  E-mail: jindra@egservis.cz                                           *
*  JID   : gorila@dione.zcu.cz                                          *
*  CP    : 1250                                                         *
*  Date  : 2008-07-07                                                   *
*                                                                       *
*  New properties aIOptions,FTPOpen                                     *
*  New method WinInetSetOptions()                                       *
*                                                                       *
*  Revision 2.0.4                                                       *
*  Martina Jindrù                                                       *
*  E-mail: jindra@egservis.cz                                           *
*  JID   : gorila@dione.zcu.cz                                          *
*  CP    : 1250                                                         *
*                                                                       *
*  Updated 2006-06-05                                                   *
*   - BITOR support for VFP 5.0                                         *
*                                                                       *
*                                                                       *
*                                                                       *
*  Proxy Support                                                        *
*  Paul Culbertson                                                      *
*  http://www.foxite.com/archives/progress_bar_for_ftps_0000013728.htm  *
*                                                                       *
*                                                                       *
*  RESUME Support                                                       *
*  Zintis Petersons                                                     *
*  http://www.vbip.com/wininet/wininet-ftp-command-01.asp               *
*                                                                       *
*                                                                       *
*  Revision 1.1a                                                        *
*                                                                       *
*  wininet.dll needs to be in the windows/system                        *
*  directory.                                                           *
*                                                                       *
*  Updated 3/16/99 - Changed Date Usage to comply with                  *
*                    Strict Date handling.                              *
*														                *
*  Added 3/16/99 Functions - AutoDialInternet                           *
*                            AutoDialHangUp                             *
*                            DialInternet                               *
*                            DialHangUp                                 *
*                            GetConnectedState                          *
*                            GoOnline                                   *
*************************************************************************
*!*	<pdm_sc_yes/>
*!*	<pdm_dd_yes/>


#IFNDEF __FTP_INCLUDE
   #INCLUDE "FTP.h"
#ENDIF

EXTERNAL ARRAY lnFlag


* Declare a Kernel32 Functions
FUNCTION ftps_GetLastError()
 DECLARE Integer GetLastError IN Kernel32 AS ftps_GetLastError
 RETURN ftps_GetLastError()
ENDFUNC

FUNCTION ftps_FileTimeToSystemTime(m.lpcBuffer, m.lpcBuffer)
 DECLARE Integer FileTimeToSystemTime IN Kernel32 AS ftps_FileTimeToSystemTime String @lpcBuffer, String @lpcBuffer
 RETURN ftps_FileTimeToSystemTime(@m.lpcBuffer, @m.lpcBuffer)
ENDFUNC


FUNCTION ftps_SystemTimeToTzSpecificLocalTime(m.lpTimeZone, m.lpUniversalTime, m.lpLocalTime)
 DECLARE INTEGER SystemTimeToTzSpecificLocalTime IN KERNEL32.dll AS ftps_SystemTimeToTzSpecificLocalTime STRING @lpTimeZone, STRING @lpUniversalTime, STRING @lpLocalTime
 RETURN ftps_SystemTimeToTzSpecificLocalTime(@m.lpTimeZone, @m.lpUniversalTime, @m.lpLocalTime)
ENDFUNC

           
* Declare DLL functions used by Program
FUNCTION ftps_InternetAutodial(m.nAccessType, m.nHandle)
 DECLARE Integer InternetAutodial IN WinInet AS ftps_InternetAutodial Integer nAccessType, Integer nHandle
 RETURN ftps_InternetAutodial(m.nAccessType, m.nHandle)
ENDFUNC
                   
FUNCTION ftps_InternetAutodialHangup(m.nFlags)
 DECLARE Integer InternetAutodialHangup IN WinInet AS ftps_InternetAutodialHangup Integer nFlags
 RETURN ftps_InternetAutodialHangup(m.nFlags)
ENDFUNC
                       
FUNCTION ftps_InternetDial(m.nHandle, m.lpcDialUp, m.nAccessType, m.nConnect_Handle, m.nFlags)
 DECLARE Integer InternetDial IN WinInet AS ftps_InternetDial ;
              Integer nHandle, String @lpcDialUp, Integer nAccessType, Integer @nConnect_Handle, Integer nFlags
 RETURN ftps_InternetDial(m.nHandle, @m.lpcDialUp, m.nAccessType, @m.nConnect_Handle, m.nFlags)
ENDFUNC
               
FUNCTION ftps_InternetHangUp(m.nConnect_Handle, m.nFlags)
 DECLARE Integer InternetHangUp IN WinInet AS ftps_InternetHangUp Integer nConnect_Handle, Integer nFlags
 RETURN ftps_InternetHangUp(m.nConnect_Handle, m.nFlags)
ENDFUNC
                       
FUNCTION ftps_InternetGetConnectedState(m.nContext, m.nFlags)
 DECLARE Integer InternetGetConnectedState IN WinInet AS ftps_InternetGetConnectedState Integer @nContext, Integer nFlags
 RETURN ftps_InternetGetConnectedState(@m.nContext, m.nFlags)
ENDFUNC
                       
FUNCTION ftps_InternetGoOnline(m.lpcURL, m.nHandle, m.nFlags)
 DECLARE Integer InternetGoOnline IN WinInet AS ftps_InternetGoOnline  String @lpcURL, Integer nHandle, Integer nFlags
 RETURN ftps_InternetGoOnline(@m.lpcURL, m.nHandle, m.nFlags)
ENDFUNC
                       

FUNCTION ftps_InternetOpen(m.lpcAgent, m.nAccessType, m.lpcProxyName, m.lpcProxyBypass, m.nFlags)
 DECLARE Integer InternetOpen IN WinInet AS ftps_InternetOpen ;
              String @lpcAgent, Integer nAccessType, String @lpcProxyName, ;
              String @lpcProxyBypass, Integer nFlags
 RETURN ftps_InternetOpen(@m.lpcAgent, m.nAccessType, @m.lpcProxyName, @m.lpcProxyBypass, m.nFlags)
ENDFUNC

FUNCTION ftps_InternetQueryOption(m.hInternet, m.dwOption, m.lpBuffer, m.lpdwBufferLength)
 DECLARE InternetQueryOption  IN WinInet AS ftps_InternetQueryOption ;
              INTEGER hInternet, INTEGER dwOption, INTEGER @ lpBuffer, INTEGER @ lpdwBufferLength
 RETURN ftps_InternetQueryOption(m.hInternet, m.dwOption, @m.lpBuffer, @m.lpdwBufferLength)
ENDFUNC

FUNCTION ftps_InternetSetOption(m.hInternet, m.dwOption, m.lpBuffer, m.dwBufferLength)
 *** begin of olrrai fix
 DECLARE INTEGER InternetSetOption IN WININET.DLL AS ftps_InternetSetOption INTEGER, INTEGER, INTEGER @, INTEGER
 *********** end of olrrai fix
 RETURN ftps_InternetSetOption(m.hInternet, m.dwOption, @m.lpBuffer, m.dwBufferLength)
ENDFUNC
       
       
                       
FUNCTION ftps_InternetConnect(m.nInet_Handle, m.lpcServer, m.nPort, m.lpcUserName, m.lpcPassword, m.nService, m.nFlags, m.nContext)
 DECLARE Integer InternetConnect IN WinInet AS ftps_InternetConnect ;
              Integer nInet_Handle, String @lpcServer, Short nPort, String @lpcUserName, ;
              String @lpcPassword, Integer nService, Integer nFlags, Integer nContext
 RETURN ftps_InternetConnect(m.nInet_Handle, @m.lpcServer, m.nPort, @m.lpcUserName, @m.lpcPassword, m.nService, m.nFlags, m.nContext)
ENDFUNC

FUNCTION ftps_InternetCloseHandle(m.nConnect_Handle)
 DECLARE Integer InternetCloseHandle IN WinInet AS ftps_InternetCloseHandle Integer nConnect_Handle
 RETURN ftps_InternetCloseHandle(m.nConnect_Handle)
ENDFUNC
                       
* FTP Functions
FUNCTION ftps_FtpCreateDirectory(m.nConnect_Handle, m.lpcDirectory)
 DECLARE Integer FtpCreateDirectory IN WinInet AS ftps_FtpCreateDirectory Integer nConnect_Handle, String @lpcDirectory
 RETURN ftps_FtpCreateDirectory(m.nConnect_Handle, @m.lpcDirectory)
ENDFUNC
                       
FUNCTION ftps_FtpDeleteFile(m.nConnect_Handle, m.lpcFileName)
 DECLARE Integer FtpDeleteFile IN WinInet AS ftps_FtpDeleteFile Integer nConnect_Handle, String @lpcFileName
 RETURN ftps_FtpDeleteFile(m.nConnect_Handle, @m.lpcFileName)
ENDFUNC
               
FUNCTION ftps_FtpFindFirstFile(m.nConnect_Handle, m.lpcSearchStr, m.lpcWIN32_FIND_DATA, m.nFlags, m.nContext)
 DECLARE Integer FtpFindFirstFile IN WinInet AS ftps_FtpFindFirstFile ;
         Integer nConnect_Handle, String @lpcSearchStr, String @lpcWIN32_FIND_DATA, Integer nFlags, Integer nContext
 RETURN ftps_FtpFindFirstFile(m.nConnect_Handle, @m.lpcSearchStr, @m.lpcWIN32_FIND_DATA, m.nFlags, m.nContext)
ENDFUNC

FUNCTION ftps_InternetFindNextFile(m.nConnect_Handle, m.lpcWIN32_FIND_DATA)
 DECLARE Integer InternetFindNextFile IN WinInet AS ftps_InternetFindNextFile ;
         Integer nConnect_Handle, String @lpcWIN32_FIND_DATA
 RETURN ftps_InternetFindNextFile(m.nConnect_Handle, @m.lpcWIN32_FIND_DATA)
ENDFUNC
                       
FUNCTION ftps_FtpGetCurrentDirectory(m.nConnect_Handle, m.lpcDirectory, m.nMax_Path)
 DECLARE Integer FtpGetCurrentDirectory IN WinInet AS ftps_FtpGetCurrentDirectory ;
         Integer nConnect_Handle, String @lpcDirectory, Integer @nMax_Path
 RETURN ftps_FtpGetCurrentDirectory(m.nConnect_Handle, @m.lpcDirectory, @m.nMax_Path)
ENDFUNC
           
FUNCTION ftps_FtpGetFile(m.nConnect_Handle, m.lpcRemoteFile, m.lpcNewFile, m.nFailIfExists, m.nAttributes, m.nFlags, m.nContext)
 DECLARE Integer FtpGetFile IN WinInet AS ftps_FtpGetFile ;
         Integer nConnect_Handle, String @lpcRemoteFile, String @lpcNewFile, ;
         Integer nFailIfExists, Integer nAttributes, Integer nFlags, ;
         Integer nContext
 RETURN ftps_FtpGetFile(m.nConnect_Handle, @m.lpcRemoteFile, @m.lpcNewFile, m.nFailIfExists, m.nAttributes, m.nFlags, m.nContext)
ENDFUNC
                       
FUNCTION ftps_FtpOpenFile(m.nConnect_Handle, m.lpcRemoteFile, m.nAccessType, m.nFlags, m.nContext)
 DECLARE Integer FtpOpenFile IN WinInet AS ftps_FtpOpenFile ;
         Integer nConnect_Handle, String @lpcRemoteFile, Integer nAccessType, ;
         Integer nFlags, Integer nContext
 RETURN ftps_FtpOpenFile(m.nConnect_Handle, @m.lpcRemoteFile, m.nAccessType, m.nFlags, m.nContext)
ENDFUNC

                       
FUNCTION ftps_FtpPutFile(m.nConnect_Handle, m.lpcNewFile, m.lpcRemoteFile, m.nFlags, m.nContext)
 DECLARE Integer FtpPutFile IN WinInet AS ftps_FtpPutFile ;
         Integer nConnect_Handle, String @lpcNewFile, String @lpcRemoteFile, Integer nFlags, Integer nContext
 RETURN ftps_FtpPutFile(m.nConnect_Handle, @m.lpcNewFile, @m.lpcRemoteFile, m.nFlags, m.nContext)
ENDFUNC
                       
FUNCTION ftps_FtpRemoveDirectory(m.nConnect_Handle, m.lpcDirectory)
 DECLARE Integer FtpRemoveDirectory IN WinInet AS ftps_FtpRemoveDirectory Integer nConnect_Handle, String @lpcDirectory
 RETURN ftps_FtpRemoveDirectory(m.nConnect_Handle, @m.lpcDirectory)
ENDFUNC
                       
FUNCTION ftps_FtpRenameFile(m.nConnect_Handle, m.lpcRemoteFile, m.lpcNewFile)
 DECLARE Integer FtpRenameFile IN WinInet AS ftps_FtpRenameFile Integer nConnect_Handle, String @lpcRemoteFile, String @lpcNewFile
 RETURN ftps_FtpRenameFile(m.nConnect_Handle, @m.lpcRemoteFile, @m.lpcNewFile)
ENDFUNC
                       
FUNCTION ftps_FtpSetCurrentDirectory(m.nConnect_Handle, m.lpcDirectory)
 DECLARE Integer FtpSetCurrentDirectory IN WinInet AS ftps_FtpSetCurrentDirectory Integer nConnect_Handle, String @lpcDirectory
 RETURN ftps_FtpSetCurrentDirectory(m.nConnect_Handle, @m.lpcDirectory)
ENDFUNC


FUNCTION ftps_FtpCommand(m.hConnect, m.fExpectResponse, m.dwFlags, m.lpszCommand, m.dwContext, m.phFtpCommand)
 DECLARE Integer FtpCommand IN WinInet AS ftps_FtpCommand ;
         Integer hConnect, Integer fExpectResponse,;
         Integer dwFlags, STRING @ lpszCommand,;
         Integer dwContext, Integer @ phFtpCommand
 RETURN ftps_FtpCommand(m.hConnect, m.fExpectResponse, m.dwFlags, @m.lpszCommand, m.dwContext, @m.phFtpCommand)
ENDFUNC


FUNCTION ftps_InternetGetLastResponseInfo(m.nError, m.lpcBuffer, m.nMax_Path)
 DECLARE Integer InternetGetLastResponseInfo IN WinInet AS ftps_InternetGetLastResponseInfo Integer @nError, String @lpcBuffer, Integer @nMax_Path
 RETURN ftps_InternetGetLastResponseInfo(@m.nError, @m.lpcBuffer, @m.nMax_Path)
ENDFUNC


FUNCTION ftps_InternetWriteFile(m.hFile, m.lpBuffer, m.dwNumberOfBytesToWrite, m.lpdwNumberOfBytesWritten)
 DECLARE INTEGER InternetWriteFile IN WinInet AS ftps_InternetWriteFile ;
         INTEGER hFile, STRING @ lpBuffer, INTEGER dwNumberOfBytesToWrite, INTEGER @ lpdwNumberOfBytesWritten
 RETURN ftps_InternetWriteFile(m.hFile, @m.lpBuffer, m.dwNumberOfBytesToWrite, @m.lpdwNumberOfBytesWritten)
ENDFUNC

FUNCTION ftps_InternetReadFile(m.hFile, m.lpBuffer, m.dwNumberOfBytesToWrite, m.lpdwNumberOfBytesWritten)
 DECLARE INTEGER InternetReadFile IN WinInet AS ftps_InternetReadFile ;
         INTEGER hFile, STRING @ lpBuffer, INTEGER dwNumberOfBytesToWrite, INTEGER @ lpdwNumberOfBytesWritten
 RETURN ftps_InternetReadFile(m.hFile, @m.lpBuffer, m.dwNumberOfBytesToWrite, @m.lpdwNumberOfBytesWritten)
ENDFUNC






****************************************************
* Class Ftp_Service                                *
****************************************************
DEFINE CLASS FTP_SERVICE AS custom
   HIDDEN lDLL_Loaded,nResult_Code,nExtended_Result,cExtended_Message,;
          nInet_Handle,nConnect_Handle,lUseProxy,;
          cIPAddress,cUserName,cPassword,cPort,nCachingType,oListPE
             

   cIPAddress 	     = ""   && FTP server name  or IP address
   cUserName         = ""   && FTP User name
   cPassword         = ""   && FTP Password
   cPort			 = "21" && FTP Port (default value is 21)
		
   nInet_Handle 	 = 0   && Internal handle by connected to internet
   nConnect_Handle 	 = 0   && Internal handle by connected to FTP server
   lDLL_Loaded       = .F. && Internally flag of loaded API function
   nResult_Code	     = 0   && FTP API function's result code 
   nExtended_Result  = 0   && Extended error code
   cExtended_Message = ""  && Extended error message
   cCurrentDir		 = ""  && Current folder
		
   nCachingType      = INTERNET_FLAG_DONT_CACHE && Default caching flag

   cAgent 	         = "Visual FoxPro" + cNULL && Name of application

   nFlags            = INTERNET_FLAG_PASSIVE && The default flag for opening FTP session
   lMultiOperations  = .T. && Sign if all FTP operations use one FTP connection
   cStartupFolder    = "" && Startup folder

   cProxyProtocol=""  && Protocol for proxy
   cProxyHost=""      && Proxyhost
   cProxyport=""      && ProxyPort
   lUseProxy = .F.    && Flag of using proxy settings
 
   oListPE=.NULL.      && List parser engine

   * olrrai fix 
   DIMENSION aIOptions(INTERNET_OPTION_MAXFLAG)   && Internet options flag's array / defult settings for new connection
   * Init() pøidává výchozí nastavení pro timeouty
   * nová metoda pro Set a Query. Oboje se musí pøenastavovat dle typu (DWORD,LONG,STRINg,STRING/STRUC)
   * olrrai added

   FTPOpen = .F.       && result of method OpenInternet
   * end of olrrai
				
   ****************************************************
   PROTECTED PROCEDURE Init && Constructor of class
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      IF _DOS OR _UNIX OR _MAC
         RETURN .F.
      ENDIF
   ENDPROC	
	
   ****************************************************
   PROTECTED PROCEDURE LoadAPIFuncs && Load basic API functions
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

      * Check to see if We have already declared functions and loaded the DLL
      IF This.lDLL_Loaded  
         RETURN ERROR_SUCCESS
      ENDIF

      This.lDLL_Loaded = .T.

      This.aIOptions(INTERNET_OPTION_CONNECT_TIMEOUT)=3600*1000
      This.aIOptions(INTERNET_OPTION_DATA_RECEIVE_TIMEOUT)=3600*1000
      This.aIOptions(INTERNET_OPTION_DATA_SEND_TIMEOUT)=3600*1000
      This.aIOptions(INTERNET_OPTION_CONNECT_RETRIES)=5
      This.aIOptions(INTERNET_OPTION_RECEIVE_TIMEOUT)=3600*1000
      This.aIOptions(INTERNET_OPTION_SEND_TIMEOUT)=3600*1000

      RETURN ERROR_SUCCESS	
   ENDPROC


   PROCEDURE IsGlobalOffline() && Return if is internet offline
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL liState
      liState = 0
      lnSize = 4

      IF This.LoadAPIFuncs() != ERROR_SUCCESS
         RETURN -1
      ENDIF	

      IF ftps_InternetQueryOption(0, INTERNET_OPTION_CONNECTED_STATE, @m.liState, @m.lnSize)
         * disconnect status      
         * INTERNET_STATE_DISCONNECTED_BY_USER OR INTERNET_STATE_DISCONNECTED
         RETURN IIF(BITTEST(m.liState,4) OR BITTEST(m.liState,1),1,0)
      ENDIF
      RETURN  -1
   ENDPROC
		
   ****************************************************
   PROCEDURE AutoDialInternet(INP lnType) && Automatically dial the default Internet connection
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL lnHWNDHandle, fResult
      IF This.LoadAPIFuncs() != ERROR_SUCCESS
 	      RETURN .F.
      ENDIF	
		   	  
      IF TYPE(m.lnType) != "N" 
         RETURN .F.
      ENDIF
		   	  
      =This.BeforeAutoDialInternet(m.lnType)
      lnHWNDHandle = 0	  		
      fResult = ftps_InternetAutodial(m.lnType, m.lnHWNDHandle)
      =This.GetExtendedError()
      =This.AfterAutoDialInternet(m.lnType,m.fResult)
      RETURN m.fResult # 0 
   ENDPROC

   ****************************************************
   PROCEDURE BeforeAutoDialInternet(INP lnType) && Raised before calling  API function InternetAutoDial()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterAutoDialInternet(INP lnType,INP fResult) && Raised after calling  API function InternetAutoDial()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC


   ****************************************************
   PROCEDURE AutoDialHangUp && Closes a modem connection 
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult
      IF This.LoadAPIFuncs() != ERROR_SUCCESS
         RETURN .F.
      ENDIF	
	  		
      =This.BeforeAutoDialHangUp()
      fResult = ftps_InternetAutoDialHangUp(0)
      This.GetExtendedError()
      =This.AfterAutoDialHangUp(m.fResult)
	  		  
      RETURN m.fResult # 0 
   ENDPROC
	  		  
   ****************************************************
   PROCEDURE BeforeAutoDialHangUp() && Raised before calling  API function InternetAutoDialHangUp()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterAutoDialHangUp(INP fResult) && Raised after calling  API function InternetAutoDialHangUp()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC
	  
   ****************************************************	
   PROCEDURE DialInternet(INP lcDialUpName, INP lnFlag) && Attempts to use a preconfigured Dial Up account to connect to the internet
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult, lnConnectionID, lnHWNDHandle
      IF This.LoadAPIFuncs() != ERROR_SUCCESS
         RETURN -1
      ENDIF
  	  		
      STORE 0 TO lnConnectionID,lnHWNDHandle
  	  		    	  		    	  		  
      IF TYPE("m.lcDialUpName") != "C" OR ;
         TYPE("m.lnFlag") != "N"
         RETURN -1
      ENDIF
  	  		
      IF LEN(ALLTRIM(m.lcDialUpName)) = 0 
         RETURN -1
      ENDIF
  	  		  
      lcDialUpName = m.lcDialUpName + cNULL
      =This.BeforeDialInternet(m.lcDialUpName, m.lnFlag)
      fResult = ftps_InternetDial(m.lnHWNDHandle, @m.lcDialUpName, m.lnFlag, @m.lnConnectionID, 0)
      =This.GetExtendedError()
      =This.AfterDialInternet(@m.lcDialUpName, m.lnFlag, m.lnConnectionID, m.fResult)
      RETURN m.lnConnectionID
   ENDPROC  

   ****************************************************
   PROCEDURE BeforeDialInternet(INPREF lcDialUpName, INP lnFlag) && Raised before calling  API function InternetDial()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterDialInternet(INPREF lcDialUpName, INP lnFlag, INP lnConnectionID, INP fResult) && Raised after calling  API function InternetDial()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC


   ****************************************************
   PROCEDURE DialHangUp(INP lnConnectionID) && Closes a dialup connection
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult
      IF This.LoadAPIFuncs() != ERROR_SUCCESS
         RETURN .F.
      ENDIF
		   	  
      IF TYPE("m.lnConnectionID") != "N"
         RETURN .F.
      ENDIF
		   	  
      =This.BeforeDialHangUp(m.lnConnectionID)
      fResult = ftps_InternetHangUp(m.lnConnectionID, 0)
      This.GetExtendedError()
      =This.AfterDialHangUp(m.lnConnectionID,m.fResult)
      RETURN m.fResult # 0 
   ENDPROC

   ****************************************************
   PROCEDURE BeforeDialHangUp(INP lnConnectionID) && Raised before calling  API function InternetHangUp()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterDialHangUp(INP lnConnectionID,INP fResult) && Raised after calling  API function InternetHangUp()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

	    
	    
   ****************************************************
   PROCEDURE GetConnectedState && Returns the current type of internet connection
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult, lnConnectionState
			
      IF This.LoadAPIFuncs() != ERROR_SUCCESS
         RETURN -1
      ENDIF
			
      lnConnectionState = 0
		
      =This.BeforeGetConnectedState()
      fResult = ftps_InternetGetConnectedState(@m.lnConnectionState, 0)
      =This.GetExtendedError()
      =This.AfterGetConnectedState(m.fResult,m.lnConnectionState)
      RETURN IIF(m.fResult = 0,-1,m.lnConnectionState)
   ENDPROC


   ****************************************************
   PROCEDURE BeforeGetConnectedState() && Raised before calling  API function InternetGetConnectedState()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterGetConnectedState(INP fResult, INP lnConnectionState) && Raised after calling  API function InternetGetConnectedState()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC
		
			  
   ****************************************************	
   PROCEDURE GoOnline(INP lcURL) && Brings up a dialog to the user requesting permission to go the requested URL
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL lnHWNDHandle, fResult
      IF This.LoadAPIFuncs() != ERROR_SUCCESS
         RETURN .F.
      ENDIF

      IF TYPE("m.lcURL") != "C"
         RETURN .F.
      ENDIF
	  			
      lcURL = m.lcURL + cNULL
      lnHWNDHandle = 0
      =This.BeforeGoOnline(@m.lcURL)
      fResult = ftps_InternetGoOnline(@m.lcURL, m.lnHWNDHandle, 0)
      =This.GetExtendedError()
      =This.AfterGoOnline(@m.lcURL,m.fResult)
      RETURN m.fResult # 0 
   ENDPROC	


   ****************************************************
   PROCEDURE BeforeGoOnline(INPREF lcURL) && Raised before calling  API function InternetGoOnline()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterGoOnline(INPREF lcURL, INP fResult) && Raised after before calling  API function InternetGoOnline()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

		
   ****************************************************
   PROCEDURE OpenInternet(INP lcUserName, INP lcPassword,INP lcIPAddress, INP lcPort, OPT_INP  lnFlag) && Attempts to open a connection to the FTP server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL lnPCount, fResult,lnConnectHandle,liAccessType,lcProxyBypass,lcProxyName

      * olrrai added:
      This.FTPOpen = .F.
		   
      * Check Passed Parameters
      lnPCount = PCOUNT()
		   		   
      IF m.lnPCount < 4
         This.nResult_Code = ERROR_INTERNET_BAD_OPTION_LENGTH
         RETURN .F.
      ENDIF
      lnFlag=IIF(m.lnPCount<5,0,m.lnFlag)
		   	
      * Make sure parameters are of the correct type
      IF (TYPE("m.lcUserName") != "C") OR ;
         (TYPE("m.lcPassword") != "C") OR ;
         (TYPE("m.lcIPAddress") != "C") OR ;
         (TYPE("m.lcPort") != "C")
         This.nResult_Code = ERROR_INVALID_PARAMETER
         RETURN .F.
      ENDIF
		   	
      * Check Parameter Values
      IF EMPTY(m.lcUserName) OR EMPTY(m.lcPassword) OR EMPTY(m.lcIPAddress)
         This.nResult_Code = ERROR_INVALID_PARAMETER
         RETURN .F.
      ENDIF
		   	
      IF This.LoadAPIFuncs() != ERROR_SUCCESS
         RETURN .F.
      ENDIF
		   	
		   	
      * Open Handle to Internet
      * Set Parameters
      This.cUserName = m.lcUserName + cNULL           && Store FTP Connection information
      This.cPassword = m.lcPassword + cNULL
      This.cIPAddress = m.lcIPAddress + cNULL
      This.cPort = m.lcPort

*http://www.foxite.com/archives/can-someone-help-me-with-ftp-problem-0000158078.htm

      IF EMPTY(This.cProxyHost) OR ISNULL(This.cProxyHost)
         lcProxyName = .NULL.
         lcProxyBypass=.NULL.
         liAccessType=IIF(TYPE("m.lnFlag("+LTRIM(STR(_FTPS_FA_AccessType,11))+")")="N",m.lnFlag(_FTPS_FA_AccessType),INTERNET_OPEN_TYPE_DIRECT)
         This.lUseProxy = .F.
      ELSE
         *protocol=proxyhost:proxyport
         *ftp=ftp://ftp_proxy_name:21 
*         lcProxyName = This.cProxyProtocol+"="+ This.cProxyHost + ":" + ALLTRIM(This.cProxyport) + cNULL
         lcProxyName = This.cProxyProtocol+"://"+ This.cProxyHost + ":" + ALLTRIM(This.cProxyport) + cNULL
         lcProxyBypass=.NULL. && This.cIPAddress
         liAccessType=INTERNET_OPEN_TYPE_PROXY
         This.lUseProxy = .T.
      ENDIF
		    		    	   		    		   
      This.nInet_Handle = ftps_InternetOpen((This.cAgent), m.liAccessType, @m.lcProxyName, @m.lcProxyBypass,m.lnFlag)
      This.GetExtendedError()
		   	
		   	
      * Unable to Get a Connection into the Internet
      IF This.nInet_Handle = 0
         This.CloseFTPConnection()
         RETURN .F.
      ENDIF

      *- Set options
      This.WinInetSetOptions() && olrrai fix
		   
	
      * This Opens the FTP site and Gets the Current Directory.  The handle to the FTP site is opened
      * and closed for each call to any function.	
      * Open FTP Site 
      fResult=This.OpenFTPConnection(This.cStartupFolder)
      =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
      This.FTPOpen = m.fResult && olrrai added
      RETURN m.fResult
   ENDPROC


   ***** begin of olrrai fix
   PROCEDURE WinInetSetOptions(laFlags) && Set Timeout for connection
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      EXTERNAL ARRAY laFlags
      LOCAL llRetVal,lii,luVal
      LOCAL ARRAY m.laFlagsX(INTERNET_OPTION_MAXFLAG)
      IF TYPE("m.laFlags")="N"
         =ACOPY(m.laFlags,m.laFlagsX)
      ELSE
         =ACOPY(This.aIOptions,m.laFlagsX)
      ENDIF

      FOR lii= 1 TO ALEN(m.laFlagsX)
          luVal= m.laFlagsX(m.lii)
          IF TYPE("m.luVal")="N"
             llRetVal=ftps_InternetSetOption(This.nInet_Handle,m.lii,@m.luVal,4)
          ENDIF 
      NEXT
      RETURN .T.
   ENDPROC
   *********** end of olrrai fix

		
   ****************************************************
   PROCEDURE CloseInternet && Closes any open handles to the Internet
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
 
      * olrrai added:
      This.FTPOpen = .F.

      * Handles have a Hierarchy.  Closing the Top Handle will close all child handles also.
      * (really?)
      IF This.nInet_Handle != 0
         This.CloseFTPConnection()

         =ftps_InternetCloseHandle(This.nInet_Handle)
         This.nInet_Handle = 0
         This.cCurrentDir = ""
      ENDIF
   ENDPROC
      


		
   ****************************************************
   PROCEDURE OpenFTPConnection(OPT_INP lcCurrentFolder) && Connect to FTP server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL nHandle, lnConnect_Handle
      IF This.nConnect_Handle>0 
         RETURN .T.
      ENDIF
      * Open FTP Site 
      lnConnect_Handle = ftps_InternetConnect(This.nInet_Handle, (This.cIPAddress), VAL(This.cPort), ;
                        (This.cUserName), (This.cPassword), INTERNET_SERVICE_FTP, This.nFlags, 0)

      This.GetExtendedError()
      IF lnConnect_Handle = 0
         RETURN .F.
      ENDIF

      IF PCOUNT()=0 OR EMPTY(m.lcCurrentFolder)
         lcCurrentFolder = SPACE(MAX_PATH)      
         fResult = ftps_FtpGetCurrentDirectory(m.lnConnect_Handle, @m.lcCurrentFolder, MAX_PATH)
         This.GetExtendedError()
      ELSE
         fResult = ftps_FtpSetCurrentDirectory(m.lnConnect_Handle, @m.lcCurrentFolder)
      ENDIF

      IF m.fResult = 1
         This.cCurrentDir = LEFT(m.lcCurrentFolder,AT(CHR(0),m.lcCurrentFolder)-1)
         This.nConnect_Handle = m.lnConnect_Handle
         RETURN .T.
      ELSE
         This.GetExtendedError()     && Only Get extended Error information when there is an error
         RETURN .F.
      ENDIF
   ENDPROC
		
   ****************************************************
   PROCEDURE CloseFTPConnection && Disconnect from FTP server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      IF This.nConnect_Handle != 0
         =This._FTPCommand("QUIT",FTP_TRANSFER_TYPE_BINARY,0,.NULL.)
         =ftps_InternetCloseHandle(This.nConnect_Handle)
      ENDIF
	    	
      This.nConnect_Handle = 0
      RETURN
   ENDPROC
	    
		
   ****************************************************
   PROCEDURE SetCachingMethod(INP nCachingType) && Changes the current file caching method
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
	
      * only change caching type if we have a valid new cache type
      IF m.nCachingType = INTERNET_FLAG_DONT_CACHE OR ;
         m.nCachingType = INTERNET_FLAG_HYPERLINK OR ;
         m.nCachingType = INTERNET_FLAG_MUST_CACHE_REQUEST OR ;
         m.nCachingType = INTERNET_FLAG_NEED_FILE OR ;
         m.nCachingType = INTERNET_FLAG_NO_CACHE_WRITE OR ;
         m.nCachingType = INTERNET_FLAG_OFFLINE OR ;
         m.nCachingType = INTERNET_FLAG_RELOAD OR ;
         m.nCachingType = INTERNET_FLAG_RESYNCHRONIZE
              
         This.nCachingType = BITOR(This.nCachingType,m.nCachingType)
         RETURN .T.
      ENDIF

      RETURN .F.
   ENDPROC
		
   ****************************************************
   PROCEDURE GetCachingMethod && Returns the current caching method
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      RETURN This.nCachingType
   ENDPROC

   ****************************************************
   PROCEDURE ResetCachingMethod && Reset caching method
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      This.nCachingType=0
   ENDPROC

		 
   ****************************************************
   PROCEDURE GetFTPFile(INP lcRemoteFile, INP lcLocalFile, INP llFailIfExists, INP lnFlag) && Get file from the FTP Server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult, lnFail
      IF EMPTY(m.lcRemoteFile)
         This.SetExtendedError(_FTPS_UE_FNDEF,"lcRemoteFile")
         RETURN .F.
      ENDIF
      IF EMPTY(m.lcLocalFile)
         This.SetExtendedError(_FTPS_UE_FNDEF,"lcLocalFile")
         RETURN .F.
      ENDIF
      lnFlag=IIF(PCOUNT()<4,FTP_TRANSFER_TYPE_UNKNOWN,m.lnFlag)

      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle
         lnFail=IIF(m.llFailIfExists,1,0)
		  	  	
         lcLocalFile = m.lcLocalFile + cNULL
         lcRemoteFile = m.lcRemoteFile + cNULL
		  	  
         =This.BeforeGetFTPFile(@m.lcRemoteFile, @m.lcLocalFile, m.llFailIfExists,m.lnFlag)
         fResult = ftps_FtpGetFile(This.nConnect_Handle, @m.lcRemoteFile, @m.lcLocalFile, m.lnFail, ;
                              FILE_ATTRIBUTE_NORMAL, BITOR(This.nCachingType,m.lnFlag), 0)
         =This.GetExtendedError()
         =This.AfterGetFTPFile(@m.lcRemoteFile, @m.lcLocalFile, m.llFailIfExists,m.lnFlag,m.fResult)
		  	  	
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
		  	  	
         RETURN m.fResult = 1
      ENDIF
      RETURN .F.
   ENDPROC



   ****************************************************
   PROCEDURE BeforeGetFTPFile(INPREF lcRemoteFile, INPREF lcLocalFile, INP llFailIfExists, INP lnFlag) && Raised before calling  API function FtpGetFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterGetFTPFile(INPREF lcRemoteFile, INPREF lcLocalFile, INP llFailIfExists, INP lnFlag, INP fResult) && Raised after calling  API function FtpGetFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

	  	
   ****************************************************
   PROCEDURE PutFTPFile(INP lcRemoteFile, INP lcLocalFile, INP lnFlag) && Sends a file to the FTP server from some local area
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult
      IF EMPTY(m.lcRemoteFile)
         This.SetExtendedError(_FTPS_UE_FNDEF,"lcRemoteFile")
         RETURN .F.
      ENDIF
      IF EMPTY(m.lcLocalFile)
         This.SetExtendedError(_FTPS_UE_FNDEF,"lcLocalFile")
         RETURN .F.
      ENDIF
      lnFlag=IIF(PCOUNT()<3,FTP_TRANSFER_TYPE_UNKNOWN,m.lnFlag)
      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle
         lcRemoteFile = m.lcRemoteFile + cNULL
         lcLocalFile = m.lcLocalFile + cNULL
		  	  	  	  	
         =This.BeforePutFTPFile(@m.lcRemoteFile, @m.lclocalFile,m.lnFlag)
         fResult = ftps_FtpPutFile(This.nConnect_Handle, @m.lcLocalFile, @m.lcRemoteFile, ;
                              BITOR(This.nCachingType,m.lnFlag), 0)
         =This.GetExtendedError()
         =This.AfterPutFTPFile(@m.lcRemoteFile, @m.lclocalFile,m.lnFlag,m.fResult)

         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
	  	    	
         RETURN  m.fResult = 1
      ENDIF
      RETURN .F.
   ENDPROC


   ****************************************************
   PROCEDURE BeforePutFTPFile(INPREF lcRemoteFile, INPREF lclocalFile, INP lnFlag) && Raised before calling  API function FtpPutFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterPutFTPFile(INPREF lcRemoteFile, INPREF lclocalFile, INP lnFlag, INP fResult) && Raised after calling  API function FtpPutFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC


   ****************************************************
   PROCEDURE WriteFTPFile(INP lcRemoteFile, INP lcData,OPT_INP liData,OPT_INP liStart,OPT_INP liFlags,OPT_INP lnFlag) && Sends a file or string to the FTP server from some local area
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult,lihFTP,lcBuffer,liData,liWrite,lihFile,lcAll,lcAlias,liSele,llErr,lcError
      LOCAL ARRAY laFile(1)
      lihFile=0

      liData=IIF(PCOUNT()<3,512,m.liData)
      liData=IIF(liData<=0,512,m.liData)
      
      liStart=IIF(PCOUNT()<4,0,m.liStart)
      liFlags=IIF(PCOUNT()<5,_FTPS_RWF_File,m.liFlags)
      lnFlag=IIF(PCOUNT()<6,FTP_TRANSFER_TYPE_UNKNOWN,m.lnFlag)
      liSele=SELECT()
      lcAlias=SYS(2015)

      IF !BITTEST(m.liFlags,0) && File?
         IF ADIR(m.laFile,lcData,"RSHA")=0 && safety than FILE()
            This.SetExtendedError(_FTPS_UE_FNEXISTS,m.lcData)
            RETURN .F.
         ENDIF

         CREATE CURSOR (m.lcAlias) (XX000 M NOCPTRANS)
         APPEND BLANK
         #IF VAL(STRTRAN(SUBS(VERSION(),LEN("Visual FoxPro ")+1,2),"0",""))>=8
          TRY
           APPEND MEMO XX000 FROM (m.lcData)
          CATCH
           llErr=.T.
          FINALLY
          ENDTRY
         #ELSE
           lcError=ON("ERROR") 
           ON ERROR llErr=.T.
           APPEND MEMO XX000 FROM (m.lcData)
         #ENDIF
         IF llErr && bug at reading file from disk
            This.SetExtendedError(_FTPS_UE_CNF,lcData)
            RETURN .F.
         ENDIF
      ELSE
         IF TYPE("m.lcData")#"C"
            This.SetExtendedError(11,"Function argument value, type, or count is invalid.")
            RETURN .F.
         ENDIF
*         lcData=SUBST(lcData,liStart+1)
      ENDIF

      IF This.OpenFTPConnection(This.cCurrentDir)    && Open an FTP Handle
         lcRemoteFile = m.lcRemoteFile + cNULL

         =This.BeforeWriteFTPFile(@m.lcRemoteFile, @m.lcData,m.liData,m.liStart,m.liFlags,m.lnFlag)

         IF m.liStart>0 && Part data
            * Append file
            =This._FTPCommand("REST "+LTRIM(STR(m.liStart,11)), m.lnFlag,0,.NULL.)
            fResult=IIF(This._FTPCommand("APPE "+m.lcRemoteFile, m.lnFlag,0,@m.lihFTP),1,0)
         ENDIF

         STORE ftps_FtpOpenFile(This.nConnect_Handle, @m.lcRemoteFile, GENERIC_WRITE, ;
                           BITOR(This.nCachingType,m.lnFlag), 0) TO fResult,lihFTP
         =This.GetExtendedError()

         IF m.fResult #0 && OK, FTP file is openned
            DO CASE
               CASE !BITTEST(m.liFlags,0) AND m.liStart>=LEN(XX000) OR;
                     BITTEST(m.liFlags,0) AND LEN(m.lcData)=0 && prázdný soubor nebo prázdná data
                    lcBuffer=""
                    liData=LEN(m.lcBuffer)

                    liWrite=0
                    fResult = ftps_InternetWriteFile(m.lihFTP, @m.lcBuffer, m.liData, @m.liWrite)
                    =This.GetExtendedError()
                    =This.AtWriteFTPFile(@m.lcRemoteFile, @m.lcData,m.liData,m.liStart,m.liFlags,m.lnFlag,0,m.liWrite,m.fResult)
         
               CASE !BITTEST(m.liFlags,0) && File from string
                    lii=m.liStart+1
               
                    DO WHILE m.lii<LEN(XX000)
                       lcBuffer=SUBST(XX000,m.lii,m.liData)
                       liData=LEN(m.lcBuffer)

                       liWrite=0
                       fResult = ftps_InternetWriteFile(m.lihFTP, @m.lcBuffer, m.liData, @m.liWrite)
                       =This.GetExtendedError()
                       =This.AtWriteFTPFile(@m.lcRemoteFile, @m.lcData,m.liData,m.liStart,m.liFlags,m.lnFlag,m.lii,m.liWrite,m.fResult)
                       IF m.fResult#1
                          EXIT
                       ENDIF
                       lii=m.lii+m.liData
                    ENDDO

               CASE BITTEST(m.liFlags,0) && String data
                    lii=m.liStart+1
               
                    DO WHILE m.lii<LEN(m.lcData)
                       lcBuffer=SUBST(m.lcData,m.lii,m.liData)
                       liData=LEN(m.lcBuffer)

                       liWrite=0
                       fResult = ftps_InternetWriteFile(m.lihFTP, @m.lcBuffer, m.liData, @m.liWrite)
                       =This.GetExtendedError()
                       =This.AtWriteFTPFile(@m.lcRemoteFile, @m.lcData,m.liData,m.liStart,m.liFlags,m.lnFlag,m.lii,m.liWrite,m.fResult)
                       IF m.fResult#1
                          EXIT
                       ENDIF
                       lii=m.lii+m.liData
                    ENDDO

            ENDCASE

            =IIF(m.liStart>0,This._FTPCommand("NOOP", FTP_TRANSFER_TYPE_BINARY,0,.NULL.),.T.)
            =ftps_InternetCloseHandle(m.lihFTP)
         ENDIF
         IF USED(m.lcAlias)
            USE IN (m.lcAlias)
         ENDIF
         SELECT (m.liSele)

         =This.AfterWriteFTPFile(@m.lcRemoteFile, @m.lcData,m.liData,m.liStart,m.liFlags,m.lnFlag,m.fResult)
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         
         RETURN m.fResult = 1
      ENDIF
      RETURN .F.
   ENDPROC



   ****************************************************
   PROCEDURE BeforeWriteFTPFile(INPREF lcRemoteFile, INPREF lcData, INP liData, INP liStart, INP liFlags, INP lnFlag) && Raised before calling  API function FtpOpenFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterWriteFTPFile(INPREF lcRemoteFile, INPREF lcData,INP liData,INP liStart,INP liFlags, INP lnFlag, INP fResult) && Raised after last calling API InternetWriteFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AtWriteFTPFile(INPREF lcRemoteFile, INPREF lcData,INP liData,INP liStart,INP liFlags,INP lnFlag,INP lii,INP liWrite,INP fResult) && Raised after each calling  API function InternetWriteFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC



   ****************************************************
   PROCEDURE ReadFTPFile(INP lcRemoteFile,INP lcData,OPT_INP liData,OPT_INP liRStart,OPT_INP liLStart,OPT_INP liFlags,OPT_INP lnFlag) && Get file from FTP do string or local file
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult,lihFTP,lcBuffer,liData,liRead,lihFile,llFast,lcAll,llAppend,liFSize,liModeFile,llErr
      lihFile=0
      liData=IIF(PCOUNT()<3,512,m.liData)
      liData=IIF(liData<=0,512,m.liData)
      
      liRStart=IIF(PCOUNT()<4,0,m.liRStart)
      liLStart=IIF(PCOUNT()<5,0,m.liLStart)
      liFlags=IIF(PCOUNT()<6,_FTPS_RWF_Resume+_FTPS_RWF_File,m.liFlags)
      lnFlag=IIF(PCOUNT()<7,FTP_TRANSFER_TYPE_UNKNOWN,m.lnFlag)

      liModeFile=IIF(TYPE("m.lnFlag("+LTRIM(STR(_FTPS_FA_ModeFile,11))+")")="N",m.lnFlag(_FTPS_FA_ModeFile),0)

      IF !BITTEST(m.liFlags,0) && File?
         llFast=VAL(STRTRAN(SUBS(VERSION(),LEN("Visual FoxPro ")+1,2),"0",""))>6
         IF !m.llFast
            lihFile=FOPEN(m.lcData,0)
            IF m.lihFile<=0
               IF m.liModeFile=_FTPS_FA_MF_Error
                  This.SetExtendedError(_FTPS_UE_FNEXISTS,m.lcData)
                  RETURN .F.
               ENDIF
               lihFile=FCREATE(m.lcData,0)

               DO CASE
                  CASE m.liModeFile=_FTPS_FA_MF_New OR IIF(BITTEST(m.liFlags,1),m.liLStart,m.liRStart)=0

                  CASE m.lihFile<=0
                       This.SetExtendedError(_FTPS_UE_CCF,m.lcData)
                       RETURN .F.

                  CASE m.liModeFile=_FTPS_FA_MF_Append
                       IF BITTEST(m.liFlags,1) && rewrite, skip to new position
                          =FCHSIZE(m.lihFile,m.liLStart+1)
                          =FSEEK(m.lihFile,m.liLStart,0)
                       ELSE
                          =FCHSIZE(m.lihFile,m.liRStart+1)
                          =FSEEK(m.lihFile,m.liRStart,0) && resume native mode
                       ENDIF

               ENDCASE
            ELSE
               IF m.lihFile<=0
                  This.SetExtendedError(_FTPS_UE_COF,m.lcData)
                  RETURN .F.
               ENDIF

               =IIF(BITTEST(m.liFlags,1),; && rewrite, skip to new position
                    FSEEK(m.lihFile,m.liLStart,0),;
                    FSEEK(m.lihFile,m.liRStart,0)) && resume native mode
            ENDIF
         ELSE
            IF LEN(SYS(2000,m.lcData))=0 && local file not exist
               DO CASE
                  CASE m.liModeFile=_FTPS_FA_MF_New OR IIF(BITTEST(m.liFlags,1),m.liLStart,m.liRStart)=0
                       lcAll=""

                  CASE m.liModeFile=_FTPS_FA_MF_Error
                       This.SetExtendedError(_FTPS_UE_FNEXISTS,m.lcData)
                       RETURN .F.

                  CASE m.liModeFile=_FTPS_FA_MF_Append
                       lcAll=IIF(BITTEST(m.liFlags,1),; && rewrite, skip to new position
                                 REPL(CHR(0),m.liLStart),REPL(CHR(0),m.liRStart))
                 
                  OTHERWISE

               ENDCASE
               
            ELSE
               lcAll=FILETOSTR(m.lcData)
               lcAll=IIF(BITTEST(m.liFlags,1),; && rewrite, skip to new position
                         LEFT(m.lcAll,m.liLStart),LEFT(m.lcAll,m.liRStart))
            ENDIF
 

         ENDIF
      ELSE
         IF TYPE("m.lcData")#"C"
            This.SetExtendedError(11,"Function argument value, type, or count is invalid.")
            RETURN .F.
         ENDIF
         lcData=IIF(BITTEST(m.liFlags,1),; && rewrite, skip to new position
                    LEFT(m.lcData,m.liLStart),LEFT(m.lcData,m.liRStart))
         llFast=.T.
      ENDIF

      IF This.OpenFTPConnection(This.cCurrentDir) && Open an FTP Handle
         lcRemoteFile = m.lcRemoteFile + cNULL

         =This.BeforeReadFTPFile(@m.lcRemoteFile, @m.lcData,m.liData,m.liRStart,m.liLStart,m.liFlags,m.lnFlag)
         IF m.liRStart>0 && Part data
            =This._FTPCommand("REST "+LTRIM(STR(m.liRStart,11)), FTP_TRANSFER_TYPE_BINARY,0,.NULL.)
         ENDIF

         STORE ftps_FtpOpenFile(This.nConnect_Handle, @m.lcRemoteFile, GENERIC_READ, ;
                           BITOR(This.nCachingType,m.lnFlag), 0) TO fResult,lihFTP
         =This.GetExtendedError()

         IF m.fResult #0 && OK, FTP file is openned
            lii=0
            STORE 1 TO fResult,liRead

            DO WHILE m.liRead>0
               liRead=0
               lcBuffer=SPACE(m.liData)
               fResult = ftps_InternetReadFile(m.lihFTP, @m.lcBuffer, m.liData, @m.liRead)
               =This.GetExtendedError()
               =This.AtReadFTPFile(@m.lcRemoteFile, @m.lcData,m.liData,m.liRStart,m.liLStart,m.liFlags,m.lnFlag,@m.lcBuffer,m.fResult)

               IF !BITTEST(m.liFlags,0) && File?
                  IF m.llFast AND m.liRead>0
                     IF LEN(m.lcAll)+m.liRead>_FTPS_MaxFileSize
                        IF STRTOFILE(m.lcAll,m.lcData,m.llAppend)=0
                           This.SetExtendedError(_FTPS_UE_CWF,"")
                           fResult=0
                           EXIT
                        ENDIF
                        llAppend=.T.
                        lcAll=""
                     ENDIF
                     lcAll=m.lcAll+LEFT(m.lcBuffer,m.liRead)
                  ELSE
                     IF m.liRead>0
                        IF FWRITE(m.lihFile,LEFT(m.lcBuffer,m.liRead),m.liRead)=0
                           This.SetExtendedError(_FTPS_UE_CWF,STR(FERROR()))
                           fResult=0
                           EXIT
                        ENDIF
                     ENDIF
                  ENDIF
               ELSE
                  lcData=m.lcData+LEFT(m.lcBuffer,m.liRead)
               ENDIF
               lii=m.lii+m.liRead
            ENDDO

            IF !BITTEST(m.liFlags,0)
                =IIF(m.llFast AND LEN(m.lcAll)>0,; && File?
                     STRTOFILE(m.lcAll,m.lcData,m.llAppend),.T.)
                =IIF(m.lihFile>0 AND !m.llFast,FCLOSE(m.lihFile),.T.)
            ENDIF
            =ftps_InternetCloseHandle(m.lihFTP)

            =IIF(m.liRStart>0,This._FTPCommand("NOOP", FTP_TRANSFER_TYPE_BINARY,0,.NULL.),.T.)
         ENDIF

         =This.AfterReadFTPFile(@m.lcRemoteFile, @m.lcData,m.liData,m.liRStart,m.liLStart,m.liFlags,m.lnFlag,m.fResult)
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN  m.fResult = 1
      ENDIF
      RETURN .F.
   ENDPROC



   ****************************************************
   PROCEDURE BeforeReadFTPFile(INPREF lcRemoteFile,INPREF lcData,INP liData,INP liRStart,INP liLStart,INP liFlags,INP lnFlag) && Raised before calling  API function FtpOpenFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterReadFTPFile(INPREF lcRemoteFile,INPREF lcData,INP liData,INP liRStart,INP liLStart,INP liFlags,INP lnFlag,INP fResult) && Raised after last calling API function InternetReadFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AtReadFTPFile(INPREF lcRemoteFile,INPREF lcData,INP liData,INP liRStart,INP liLStart,INP liFlags,INP lnFlag,INPREF lcBuffer,INP fResult) && Raised after calling API function InternetReadFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC


   ****************************************************
   PROTECTED PROCEDURE _FTPCommand(INP lcCommand,INP liFlags,OPT_INP liContext,OPT_CHNGREF lihFTP) && Send native FTP command to FTP server (iternal method)
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult

      liFlags=IIF(PCOUNT()<2,FTP_TRANSFER_TYPE_BINARY,m.liFlags)
      liContext=IIF(PCOUNT()<3,0,m.liContext)
      lihFTP=IIF(ISNULL(m.lihFTP),-1,0)

      lcCommand = m.lcCommand + cNULL
      fResult = ftps_FtpCommand(This.nConnect_Handle, IIF(m.lihFTP=-1,0,1), m.liFlags, @m.lcCommand,m.liContext,@m.lihFTP)
      =This.GetExtendedError()
      RETURN  m.fResult = 1
   ENDPROC


   ****************************************************
   PROCEDURE FTPCommand(INP lcCommand,INP liFlags,OPT_INP liContext,OPT_CHNGREF lihFTP) && Send native FTP command to FTP server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult
      liFlags=IIF(PCOUNT()<2,FTP_TRANSFER_TYPE_BINARY,m.liFlags)
      liContext=IIF(PCOUNT()<3,0,m.liContext)
      lihFTP=IIF(ISNULL(m.lihFTP),-1,0)

      lcCommand = m.lcCommand + cNULL
      =This.BeforeFTPCommand(@m.lcCommand, m.liFlags, m.liContext,m.lihFTP)
      fResult = ftps_FtpCommand(This.nConnect_Handle, IIF(m.lihFTP=-1,0,1), m.liFlags, @m.lcCommand,m.liContext,@m.lihFTP)

      =This.GetExtendedError()
      =This.AfterFTPCommand(@m.lcCommand, m.liFlags, m.liContext,m.lihFTP,m.fResult)

      =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
      RETURN  m.fResult = 1
   ENDPROC


   ****************************************************
   PROCEDURE BeforeFTPCommand(INPREF lcCommand,INP liFlags,INP liContext,INP lihFTP) && Raised before calling  API function FtpCommand()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterFTPCommand(INPREF lcCommand,INP liFlags,INP liContext,INP lihFTP,INP fResult) && Raised after calling  API function FtpCommand()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC




	  	
   ****************************************************
   PROCEDURE DeleteFTPFile(INP lcRemoteFile) && Delete file on the FTP Server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult
      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle
         lcRemoteFile = m.lcRemoteFile + cNULL
		  	  		  	  	  	  	
         =This.BeforeDeleteFTPFile(@m.lcRemoteFile)
         fResult = ftps_FtpDeleteFile(This.nConnect_Handle, @m.lcRemoteFile)
         This.GetExtendedError()
         =This.AfterDeleteFTPFile(@m.lcRemoteFile,m.fResult)
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN m.fResult = 1
      ENDIF
      RETURN .F.    	  	  	
   ENDPROC

   ****************************************************
   PROCEDURE BeforeDeleteFTPFile(INPREF lcRemoteFile) && Raised before calling  API function FtpDeleteFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterDeleteFTPFile(INPREF lcRemoteFile,INP fResult) && Raised after calling  API function FtpDeleteFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC
		
		
   ****************************************************
   PROCEDURE RenameFTPFile(INP lcOldFile,INP lcNewFile) && Renames a file
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult
      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle
         lcOldFile = m.lcOldFile + cNULL
         lcNewFile = m.lcNewFile + cNULL
		  	  	  	  	
         =This.BeforeRenameFTPFile(@m.lcOldFile, @m.lcNewFile)
         fResult = ftps_FtpRenameFile(This.nConnect_Handle, @m.lcOldFile, @m.lcNewFile)
         =This.GetExtendedError()
         =This.AfterRenameFTPFile(@m.lcOldFile, @m.lcNewFile,m.fResult)
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN m.fResult = 1
      ENDIF
      RETURN .F.    	  	  	
   ENDPROC

   ****************************************************
   PROCEDURE BeforeRenameFTPFile(INPREF lcOldFile,INPREF lcNewFile) && Raised before calling  API function FtpRenameFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterRenameFTPFile(INPREF lcOldFile,INPREF lcNewFile,INP fResult) && Raised after calling  API function FtpRenameFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE GetFileSize(INP lcFile, CHNGREF lnSize)  && Get File Size
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL lcPom,llRet
      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle
         lcFile = ALLTRIM(m.lcFile)+cNULL
		  	  	  	  	
         =This.BeforeGetFileSize(@m.lcFile, m.lnSize)
         *!* FtpGetFileSize does not work as expected for files greater then 4Gb (dwFileSizeHigh always NULL)
         *!* http://groups.google.com.ar/group/microsoft.public.windows.inetexplorer.ie5.programming.wininet/browse_thread/thread/3c118ed4c7c32269/791a868311e60a00?lnk=st&q=ftpfindfirstfile+and+large+files&rnum=2&hl=es#791a868311e60a00

         llRet=This._FTPCommand("SIZE "+m.lcFile,FTP_TRANSFER_TYPE_BINARY,0,.NULL.)
         IF llRet
            lcPom=This.GetExtendedErrorMsg()
            lnSize=VAL(SUBSTR(m.lcPom,AT(" ",m.lcPom)+1))
         ENDIF

         =This.AfterGetFileSize(@m.lcFile,m.lnSize,m.llRet)
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN m.llRet
      ENDIF
      RETURN .F.    	  	  	
   ENDPROC

   ****************************************************
   PROCEDURE BeforeGetFileSize(INPREF lcFile, CHNGREF lnSize) && Raised before calling  API function FTPGetFileSize()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterGetFileSize(INPREF lcFile, CHNGREF lnSize,INP llRet) && Raised after calling  API function FTPGetFileSize()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC
		
		
   ****************************************************
   PROCEDURE CreateFTPDirectory(INP lcNewDir) && Creates a directory on the FTP Server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult
      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle  	   		
         lcNewDir = m.lcNewDir + cNULL
		  	   	  	   		  	   	 
         =This.BeforeCreateFTPDirectory(@m.lcNewDir)
         fResult = ftps_FtpCreateDirectory(This.nConnect_Handle, @m.lcNewDir)
         =This.GetExtendedError()
         =This.AfterCreateFTPDirectory(@m.lcNewDir,m.fResult)
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
		  	 	
         RETURN m.fResult = 1
      ENDIF
      RETURN .F.
   ENDPROC


   ****************************************************
   PROCEDURE BeforeCreateFTPDirectory(INPREF lcNewDir) && Raised before calling  API function FtpCreateDirectory()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterCreateFTPDirectory(INPREF lcNewDir,INP fResult) && Raised after calling  API function FtpCreateDirectory()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>

   ENDPROC

	  	
   ****************************************************
   PROCEDURE RemoveFTPDirectory(INP lcDir) && Removes a directory on the FTP Server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult
      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle  	   		  
         lcDir = m.lcDir + cNULL
		  	   	  	   		  	   	 
         =This.BeforeRemoveFTPDirectory(@m.lcDir)
         fResult = ftps_FtpRemoveDirectory(This.nConnect_Handle, @m.lcDir)
         =This.GetExtendedError()
         =This.AfterRemoveFTPDirectory(@m.lcDir,m.fResult)
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
		  	 	
         RETURN m.fResult = 1
      ENDIF
      RETURN .F. 
   ENDPROC


   ****************************************************
   PROCEDURE BeforeRemoveFTPDirectory(INPREF lcDir) && Raised before calling  API function FtpRemoveDirectory()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterRemoveFTPDirectory(INPREF lcDir,INP fResult) && Raised after calling API function FtpRemoveDirectory()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC
			 
   ****************************************************
   PROCEDURE ChangeFTPDirectory(INP lcNewDir) && Change the current directory on the FTP Server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult, lcTempDir, llResult
	  	   	  	   		  
      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle 	   		  
         llResult = .F.	 
         lcTempDir = SPACE(MAX_PATH)	   		  	   	
		  	   	  	   		  	   	 
         =This.BeforeChangeFTPDirectory(@m.lcNewDir)
         fResult = ftps_FtpSetCurrentDirectory(This.nConnect_Handle, @m.lcNewDir)
         =This.GetExtendedError()
		  	 		  	 	
         IF m.fResult = 1
            fResult = ftps_FtpGetCurrentDirectory(This.nConnect_Handle, @m.lcTempDir, MAX_PATH)
            =This.GetExtendedError()
		  	 		  	 		
            IF m.fResult = 1
               This.cCurrentDir = LEFT(m.lcTempDir,AT(CHR(0),m.lcTempDir)-1)
               llResult = .T.
            ENDIF
         ENDIF
         =This.AfterChangeFTPDirectory(@m.lcNewDir,m.fResult)
		  	 	
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN m.llResult
      ENDIF	  	 
      RETURN .F. 		  	 
   ENDPROC

   ****************************************************
   PROCEDURE BeforeChangeFTPDirectory(INPREF lcNewDir) && Raised before calling  API function FtpSetCurrentDirectory()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterChangeFTPDirectory(INPREF lcNewDir,INP fResult) && Raised after calling API function FtpSetCurrentDirectory()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC
	  	
   ****************************************************
   PROCEDURE GetFTPDirectory(OUTREF lcDirectory) && Get current directory on the FTP Server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL fResult, lcTempDir
      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle
         lcTempDir = SPACE(MAX_PATH)
         =This.BeforeGetFTPDirectory(@m.lcDirectory)
         fResult = ftps_FtpGetCurrentDirectory(This.nConnect_Handle, @m.lcTempDir, MAX_PATH)
         =This.GetExtendedError()
         lcDirectory = LEFT(m.lcTempDir, AT(cNULL, m.lcTempDir) - 1)
         =This.AfterGetFTPDirectory(@m.lcDirectory,m.fResult)
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN m.fResult = 1
      ENDIF
      RETURN .F.
   ENDPROC

   ****************************************************
   PROCEDURE BeforeGetFTPDirectory(INPREF lcDirectory) && Raised before calling  API function FtpGetCurrentDirectory()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterGetFTPDirectory(INPREF lcDirectory,INP fResult) && Raised after calling API function FtpGetCurrentDirectory()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC
		
				
   ****************************************************
   PROCEDURE GetFTPDirectoryArray(OUTREF laDirectory, INP lcMask,OPT_INP lnFlag, OUTREF liCount) && Get a list of files from the current directory on the FTP Server
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL cStruct, liResult, fResult, lffHandle,lii,lnSize
      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle
         lcMask = m.lcMask + cNULL
		      
         * Dimension the array to store the directory
         * [x, 1] = FileName
         * [x, 2] = Alternate FileName
         * [x, 3] = File Size
         * [x, 4] = File Create Date
         * [x, 5] = File Last Access Time
         * [x, 6] = File Last Write Time
         * [x, 7] = File Attributes
         DIMENSION m.laDirectory [1, 7]
         laDirectory [1, 1] = .F.
         lnFlag=BITOR(INTERNET_FLAG_RELOAD,IIF(PCOUNT()<=3,0,m.lnFlag))
         liCount=0
          		    	      	
         * This is for a FoxPro Quirk.
         lcStruct = REPL(CHR(0),319)+CHR(0)   && Allocate space for the returned structure
		      	
         =This.BeforeGetFTPDirectoryArray(@m.laDirectory, @m.lcMask,m.lnFlag)
         * Get the first file or find out if 
         lffHandle = ftps_FtpFindFirstFile(This.nConnect_Handle, @m.lcMask, @m.lcStruct, m.lnFlag, 0)
         This.GetExtendedError()
		      	
         IF m.lffHandle = 0 AND This.nResult_Code <> ERROR_NO_MORE_FILES
            RETURN .F.
         ENDIF

         IF m.lffHandle = 0 AND This.nResult_Code = ERROR_NO_MORE_FILES
            RETURN .T.
         ENDIF

         * Parse out First File Information
         =This.CrackFile(m.lcStruct, @m.laDirectory)
         liCount=1	
         llResult = 1
         DO WHILE This.nResult_Code != ERROR_NO_MORE_FILES AND m.llResult != 0
            lcStruct = SPACE(319)
            * Get next files
            liResult = ftps_InternetFindNextFile(m.lffHandle, @m.lcStruct)
            =This.GetExtendedError()
			    		
            * If we got good information, go ahead and parse it
            IF This.nResult_Code != ERROR_NO_MORE_FILES AND m.llResult != 0
               liCount=m.liCount+1
               =This.CrackFile(m.lcStruct, @m.laDirectory)
            ENDIF
         ENDDO
         =This.AfterGetFTPDirectoryArray(@m.laDirectory, @m.lcMask, m.lnFlag,m.liResult)
         =ftps_InternetCloseHandle(m.lffHandle)

         FOR lii=1 TO ALEN(m.laDirectory,1)
             IF ATC(m.laDirectory(m.lii,7),"D")=0 AND This.GetFileSize(m.laDirectory(m.lii,1),@m.lnSize)
                laDirectory(m.lii,3)=m.lnSize
             ENDIF
         NEXT

         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN .T.
      ELSE
         RETURN .F.     && Unable to get FTP Connection	
      ENDIF
   ENDPROC

   ****************************************************
   PROCEDURE BeforeGetFTPDirectoryArray(CHNGREF laDirectory, INPREF lcMask, INP lnFlag) && Raised before calling API function FtpFindFirstFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterGetFTPDirectoryArray(CHNGREF laDirectory,INPREF lcMask, INP lnFlag,INP liResult) && Raised after last calling API function FtpFindNextFile()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE List(OUTREF luData, INP lcMask,OPT_INP liFlags,OPT_INP lnFlag) && Get a list of files and folders from the current directory on the FTP Server
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      EXTERNAL ARRAY luData
      LOCAL liResult, lihFTP,lii,lcBuffer,lcData,liData,liEnd,liCount,llRet

      liFlags=IIF(PCOUNT()<3,_FTPS_RWF_File,m.liFlags)
      lnFlag=IIF(PCOUNT()<4,FTP_TRANSFER_TYPE_ASCII,m.lnFlag)

      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle
         IF BITTEST(m.liFlags,2) && Array?
            DIMENSION m.luData [1, 1]
            luData [1, 1] = .NULL.
         ENDIF
         lihFTP=0

         This.BeforeList(@m.luData,@m.lcMask,m.liFlags,m.lnFlag)

         liResult=IIF(This._FTPCommand("LIST "+m.lcMask,FTP_TRANSFER_TYPE_ASCII,0,@m.lihFTP),1,0)
         IF m.liResult #0 && OK, FTP list is openned
            llRet=.T.         
            lii=0
            liData=500
            STORE 1 TO fResult,liRead
            lcData=""

            DO WHILE m.liRead>0
               liRead=0
               lcBuffer=SPACE(m.liData)
               liResult = ftps_InternetReadFile(m.lihFTP, @m.lcBuffer, m.liData, @m.liRead)
               =This.GetExtendedError()
               This.AtList(@m.luData,@m.lcMask,m.liFlags,m.lnFlag,@m.lcBuffer,m.liResult)

               lcData=m.lcData+LEFT(m.lcBuffer,m.liRead)
               lii=m.lii+m.liRead
            ENDDO
            =ftps_InternetCloseHandle(m.lihFTP)  

            =This.AfterList(m.luData,m.lcMask,m.liFlags,m.lnFlag,m.liResult)

            DO CASE
               CASE m.liResult=0

               CASE !BITTEST(m.liFlags,0) AND !BITTEST(m.liFlags,2) && File?
                    IF STRTOFILE(m.lcData,m.luData)=0
                       This.SetExtendedError(_FTPS_UE_CWF,"")
                       llRet=.F.
                    ENDIF

               CASE BITTEST(m.liFlags,0) && String?
                    luData=m.lcData

               CASE BITTEST(m.liFlags,2) && Array?
                    IF ISNULL(This.oLIstPE)
                       This.oLIstPE=CREATEOBJECT("_LIST_PARSER_ENGINE")
                    ENDIF
                    This.oLIstPE.oFTP=This
                    llRet=This.oLIstPE.Parse(@m.luData,@m.lcData)
                    This.oLIstPE.oFTP=.NULL.
            ENDCASE
         ENDIF
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN m.llRet
      ELSE
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN .F.     && Unable to get FTP Connection   
      ENDIF
   ENDPROC

   ****************************************************
   PROCEDURE BeforeList(CHNGREF luData, INPREF lcMask,OPT_INP liFlags,OPT_INP lnFlag) && Raised before calling API function FtpCommand
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterList(CHNGREF luData, INPREF lcMask,OPT_INP liFlags,OPT_INP lnFlag,OPT_INP liResult) && Raised after closing FTP connection
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AtList(CHNGREF luData, INPREF lcMask,OPT_INP liFlags,OPT_INP lnFlag,CHNGREF lcBuffer,OPT_INP liResult) && Raised after reading data from buffer
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE NLST(OUTREF luData, INP lcMask,OPT_INP liFlags,OPT_INP lnFlag) && Get a list of files and folders from the current directory on the FTP Server
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      EXTERNAL ARRAY luData
      LOCAL liResult, lihFTP,lii,lcBuffer,lcData,liData,liEnd,liCount,llRet

      liFlags=IIF(PCOUNT()<3,_FTPS_RWF_File,m.liFlags)
      lnFlag=IIF(PCOUNT()<4,FTP_TRANSFER_TYPE_ASCII,m.lnFlag)

      IF This.OpenFTPConnection(This.cCurrentDir)     && Open an FTP Handle
         IF BITTEST(m.liFlags,2) && Array?
            DIMENSION m.luData [1, 1]
            luData [1, 1] = .NULL.
         ENDIF
         lihFTP=0

         This.BeforeNLST(@m.luData,@m.lcMask,m.liFlags,m.lnFlag)

         liResult=IIF(This._FTPCommand("NLST "+m.lcMask,FTP_TRANSFER_TYPE_ASCII,0,@m.lihFTP),1,0)
         IF m.liResult #0 && OK, FTP list is openned
            llRet=.T.         
            lii=0
            liData=500
            STORE 1 TO fResult,liRead
            lcData=""

            DO WHILE m.liRead>0
               liRead=0
               lcBuffer=SPACE(m.liData)
               liResult = ftps_InternetReadFile(m.lihFTP, @m.lcBuffer, m.liData, @m.liRead)
               =This.GetExtendedError()
               This.AtNLST(@m.luData,@m.lcMask,m.liFlags,m.lnFlag,@m.lcBuffer,m.liResult)

               lcData=m.lcData+LEFT(m.lcBuffer,m.liRead)
               lii=m.lii+m.liRead
            ENDDO
            =ftps_InternetCloseHandle(m.lihFTP)  

            DO CASE
               CASE m.liResult=0

               CASE !BITTEST(m.liFlags,0) AND !BITTEST(m.liFlags,2) && File?
                    IF STRTOFILE(m.lcData,m.luData)=0
                       This.SetExtendedError(_FTPS_UE_CWF,"")
                       llRet=.F.
                    ENDIF

               CASE BITTEST(m.liFlags,0) && String?
                    luData=m.lcData

               CASE BITTEST(m.liFlags,2) && Array?
                    * parse data by CRLF
                    IF AT("\015\012",m.lcData)>0 && EPLF
                       lcData=STRTRAN(m.lcData,"\015\012",CRLF)
                    ENDIF
                    IF VAL(STRTRAN(SUBS(VERSION(),LEN("Visual FoxPro ")+1,2),"0",""))>=6
                       liCount=ALINES(m.luData,m.lcData)
                    ELSE
                       liCount=OCCURS(CRLF,m.lcData)
                       IF m.liCount>0 THEN
                          DIME luData[m.liCount, 1]
                          lii=1  
                          liEnd=AT(CRLF,m.lcData,1)
                          DO WHILE m.liEnd>0
                             luData[m.lii, 1]=LEFT(m.lcData,m.liEnd-1)
                             lcData=SUBSTR(m.lcData,m.liEnd+2)
                             liEnd=AT(CRLF,m.lcData,1)
                             lii=m.lii+1  
                          ENDDO
                       ENDIF
                    ENDIF
            ENDCASE
         ENDIF
         This.AfterNLST(m.luData,m.lcMask,m.liFlags,m.lnFlag,m.liResult)
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN m.llRet
      ELSE
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN .F.     && Unable to get FTP Connection   
      ENDIF
   ENDPROC

   ****************************************************
   PROCEDURE BeforeNLST(CHNGREF luData, INPREF lcMask,OPT_INP liFlags,OPT_INP lnFlag) && Raised before calling API function FtpCommand
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterNLST(CHNGREF luData, INPREF lcMask,OPT_INP liFlags,OPT_INP lnFlag,OPT_INP liResult) && Raised after closing FTP connection
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AtNLST(CHNGREF luData, INPREF lcMask,OPT_INP liFlags,OPT_INP lnFlag,CHNGREF lcBuffer,OPT_INP liResult) && Raised after reading data from buffer
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC



   ****************************************************
   PROCEDURE BeforeReadTree(INPREF lcFolder, INP llChild, INP lcAlias) && Raised before calling API function FtpSetCurrentDirectory()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC

   ****************************************************
   PROCEDURE AfterReadTree(INPREF lcFolder, INP llChild, INP lcAlias,INP llNext) && Raised after calling API function FtpSetCurrentDirectory()
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
   ENDPROC
	  	
   ****************************************************
   PROCEDURE ReadTree(INP lcFolder, INP llChild, INP lcAlias) && Read Tree (folders and files)
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL llNext,liRecno,lii,liCount,lcCurFolder
      LOCAL ARRAY laFiles(1)

      IF This.OpenFTPConnection()     && Open an FTP Handle
         =This.BeforeReadTree(m.lcFolder,m.llChild,m.lcAlias)
         IF USED(m.lcAlias)
            USE IN (m.lcAlias)
         ENDIF
         CREATE CURSOR (m.lcAlias)  (FOLDER M, NAME M, ALTERNAME M, SIZE I, CD T, LAT T, LWT T, ATTRIB M)
         lcCurFolder=This.cCurrentDir
         llNext=IIF(!EMPTY(m.lcFolder),This.ChangeFTPDirectory(m.lcFolder),.T.)
         liCount=0
         llNext=m.llNext AND This.GetFTPDirectoryArray(@m.laFiles,"*.*",0,@m.liCount) && read all files and folders
         IF m.liCount>0
            FOR lii=1 TO ALEN(m.laFiles,1)
                INSERT INTO (m.lcAlias) (FOLDER, NAME, ALTERNAME, SIZE, CD, LAT, LWT, ATTRIB);
                  VALUES;
                  (This.cCurrentDir,m.laFiles(m.lii,1),m.laFiles(m.lii,2),m.laFiles(m.lii,3),m.laFiles(m.lii,4),m.laFiles(m.lii,5),m.laFiles(m.lii,6),m.laFiles(m.lii,7))
            NEXT

            SELECT (m.lcAlias)
            GO TOP
            SCAN WHILE m.llNext AND m.llChild
                 IF NOT ATTRIB=="D" 
                    LOOP
                 ENDIF   

                 liRecno=RECNO()

                 llNext=This.ChangeFTPDirectory(FOLDER+"/"+NAME)
                 llNext=m.llNext AND This.GetFTPDirectoryArray(@m.laFiles,"*.*",0,@m.liCount) && read all files and folders
                 IF m.liCount>0 
                    FOR lii=1 TO ALEN(m.laFiles,1)
                        INSERT INTO (m.lcAlias) (FOLDER, NAME, ALTERNAME, SIZE, CD, LAT, LWT, ATTRIB);
                           VALUES;
                           (This.cCurrentDir,m.laFiles(m.lii,1),m.laFiles(m.lii,2),m.laFiles(m.lii,3),m.laFiles(m.lii,4),m.laFiles(m.lii,5),m.laFiles(m.lii,6),m.laFiles(m.lii,7))
                    NEXT
                 ENDIF   
                 
                 SELECT (m.lcAlias)
                 GO (m.liRecno)
            ENDSCAN 
         ENDIF
         =This.ChangeFTPDirectory(m.lcCurFolder)

         =This.AfterReadTree(m.lcFolder,m.llChild,m.lcAlias,m.llNext)
         =IIF(This.lMultiOperations,.T.,This.CloseFTPConnection())   && Close FTP Handle
         RETURN m.llNext
      ENDIF
      RETURN .F.
   ENDPROC

		
   ****************************************************
   PROTECTED PROCEDURE CrackFile(INP lcString, CHNGREF laDirectory) && Parsing file's attributes and storing to array
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL lcFileName, lcAlterName, lnSizeHigh, lnSizeLow, lnFileSize, ;
            lcAttributes, lnArrayLen, lcTimeBuff, ;
            ldCreateDate, ldAccessDate, ldWriteDate, laNewArray, lnResult,lcPom
	      	
      IF TYPE('m.laDirectory[1, 1]') = 'L'	&& Array Has Not Been Filed      
         * Force Record size of 1
         DIMENSION m.laDirectory [1, 7]
      ELSE	
         * Expand Array
         DIMENSION m.laDirectory [ALEN(m.laDirectory, 1) + 1, 7]
      ENDIF
	        
      * Get new Array Position
      lnArrayLen = ALEN(m.laDirectory, 1)


*!* 4	  DWORD    dwFileAttributes; 
*!* 8	  FILETIME ftCreationTime; 
*!*	8	  FILETIME ftLastAccessTime; 
*!* 8	  FILETIME ftLastWriteTime; 
*!* 4	  DWORD    nFileSizeHigh; 
*!* 4	  DWORD    nFileSizeLow; 
*!* 4	  DWORD    dwReserved0; 
*!* 4	  DWORD    dwReserved1; 
*!* 4	  TCHAR    cFileName[ MAX_PATH ]; 
*!*	  TCHAR    cAlternateFileName[ 14 ]; 


*!*	typedef struct _FILETIME { 
*!*	    DWORD dwLowDateTime; 
*!*	    DWORD dwHighDateTime; 
*!*	} FILETIME, *PFILETIME; 



      lcFileName = SUBSTR(m.lcString, 45, MAX_PATH)
      lcAlterName = RIGHT(m.lcString, 14)
	      	
      lcFileName = LEFT(m.lcFileName, AT(cNull, m.lcFileName) - 1)  && Copy out just the File Name Text
      lcAlterName = LEFT(m.lcAlterName, AT(cNull, m.lcAlterName) - 1)
	      	
      * Convert File Size DWORDs
      lnSizeHigh = (ASC(SUBSTR(m.lcString, 29, 1)) * BYTE_1) + ;
                   (ASC(SUBSTR(m.lcString, 30, 1)) * BYTE_2) + ;
                   (ASC(SUBSTR(m.lcString, 31, 1)) * BYTE_3) + ;
                   (ASC(SUBSTR(m.lcString, 32, 1)) * BYTE_4) 
	      				 
      lnSizeLow =  (ASC(SUBSTR(m.lcString, 33, 1)) * BYTE_1) + ;
                   (ASC(SUBSTR(m.lcString, 34, 1)) * BYTE_2) + ;
                   (ASC(SUBSTR(m.lcString, 35, 1)) * BYTE_3) + ;
                   (ASC(SUBSTR(m.lcString, 36, 1)) * BYTE_4) 
	      				 
      * Build File Size
      lnFileSize = (m.lnSizeHigh * MAXDWORD) + m.lnSizeLow

      *!* FtpGetFileSize does not work as expected for files greater then 4Gb (dwFileSizeHigh always NULL)
      *!* http://groups.google.com.ar/group/microsoft.public.windows.inetexplorer.ie5.programming.wininet/browse_thread/thread/3c118ed4c7c32269/791a868311e60a00?lnk=st&q=ftpfindfirstfile+and+large+files&rnum=2&hl=es#791a868311e60a00

      * Convert File Date
	       
      * Get File Create DateTime
      lcTimeBuff = SUBSTR(m.lcString, 5, 8)
      ldCreateDate = This.CrackDate(m.lcTimeBuff)
	        
      * Get File Last Access DateTime
      lcTimeBuff = SUBSTR(m.lcString, 13, 8)
      ldAccessDate = This.CrackDate(m.lcTimeBuff)
	        
      * Get File Last Write DateTime
      lcTimeBuff = SUBSTR(m.lcString, 21, 8)
      ldWriteDate = This.CrackDate(m.lcTimeBuff)
	        
      * Get File Attributes
      lcAttributes = This.CrackAttributes(LEFT(m.lcString, 4))
	        
      laDirectory[m.lnArrayLen, 1] = ALLTRIM(m.lcFileName)
      laDirectory[m.lnArrayLen, 2] = ALLTRIM(m.lcAlterName)
      laDirectory[m.lnArrayLen, 3] = m.lnFileSize
      laDirectory[m.lnArrayLen, 4] = m.ldCreateDate
      laDirectory[m.lnArrayLen, 5] = m.ldAccessDate
      laDirectory[m.lnArrayLen, 6] = m.ldWriteDate
      laDirectory[m.lnArrayLen, 7] = m.lcAttributes
  	 
      RETURN 
   ENDPROC
	    
   ****************************************************
   PROTECTED PROCEDURE CrackDate(INP lcOutBuffer) && Converting file system structure to system date
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL lcInBuffer, fResult, lcBuild, ;
            lnDay, lnMonth, lnYear, lnHour, lnMinute, lnSecond, lcFile, m.lcLocalTime
		
      IF EMPTY(m.lcOutBuffer)  
         RETURN {^1901-01-01 00:00:01}
      ENDIF

      STORE SPACE(16) TO m.lcInBuffer, m.lcLocalTime

      fResult = ftps_FileTimeToSystemTime(@m.lcOutBuffer, @m.lcInBuffer)
      This.GetExtendedError()
      IF m.fResult = 0   && Failed
         RETURN {^1901-01-01 00:00:01}
      ENDIF

      fResult = ftps_SystemTimeToTzSpecificLocalTime(NULL, @m.lcInBuffer, @m.lcLocalTime)
      IF m.fResult = 0   && Failed
         m.lcLocalTime=m.lcInBuffer
      ENDIF

      lnYear = ASC(SUBSTR(m.lcLocalTime, 1, 1)) + (ASC(SUBSTR(m.lcLocalTime, 2, 1)) * BYTE_2)
      lnMonth = ASC(SUBSTR(m.lcLocalTime, 3, 1)) + (ASC(SUBSTR(m.lcLocalTime, 4, 1)) * BYTE_2)
      lnDay = ASC(SUBSTR(m.lcLocalTime, 7, 1)) + (ASC(SUBSTR(m.lcLocalTime, 8, 1)) * BYTE_2)
      lnHour = ASC(SUBSTR(m.lcLocalTime, 9, 1)) + (ASC(SUBSTR(m.lcLocalTime, 10, 1)) * BYTE_2)
      lnMinute = ASC(SUBSTR(m.lcLocalTime, 11, 1)) + (ASC(SUBSTR(m.lcLocalTime, 12, 1)) * BYTE_2)
      lnSecond = ASC(SUBSTR(m.lcLocalTime, 13, 1)) + (ASC(SUBSTR(m.lcLocalTime, 13, 1)) * BYTE_2)
			
      lcBuild = "^" + ALLTRIM(STR(m.lnYear)) + '-' + ALLTRIM(STR(m.lnMonth)) + '-' + ALLTRIM(STR(m.lnDay)) + ' ' + ;
                ALLTRIM(STR(m.lnHour)) + ':' + ALLTRIM(STR(m.lnMinute)) + ':' + ALLTRIM(STR(m.lnSecond))
				      
      RETURN CTOT(m.lcBuild)
   ENDPROC
		  
   ****************************************************
   PROTECTED PROCEDURE CrackAttributes(INP lcBuffer) && Converting file's attributes to human's format
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL lcAttributes, lnValue
      lcAttributes = ''
	 		 		
      lnValue = (ASC(SUBSTR(m.lcBuffer, 1, 1)) * BYTE_1) + ;
                (ASC(SUBSTR(m.lcBuffer, 2, 1)) * BYTE_2) + ;
                (ASC(SUBSTR(m.lcBuffer, 3, 1)) * BYTE_3) + ;
                (ASC(SUBSTR(m.lcBuffer, 4, 1)) * BYTE_4) 
					  
      DO CASE
         CASE BITTEST(m.lnValue, BIT_ATTRIBUTE_READONLY) 
              lcAttributes = m.lcAttributes + 'R'

         CASE BITTEST(m.lnValue, BIT_ATTRIBUTE_HIDDEN) 
              lcAttributes = m.lcAttributes + 'H'

         CASE BITTEST(m.lnValue, BIT_ATTRIBUTE_SYSTEM) 
              lcAttributes = m.lcAttributes + 'S'

         CASE BITTEST(m.lnValue, BIT_ATTRIBUTE_DIRECTORY) 
              lcAttributes = m.lcAttributes + 'D'

         CASE BITTEST(m.lnValue, BIT_ATTRIBUTE_ARCHIVE) 
              lcAttributes = m.lcAttributes + 'A'

         CASE BITTEST(m.lnValue, BIT_ATTRIBUTE_NORMAL) 
              lcAttributes = m.lcAttributes + 'N'

         CASE BITTEST(m.lnValue, BIT_ATTRIBUTE_TEMPORARY) 
              lcAttributes = m.lcAttributes + 'T'

         CASE BITTEST(m.lnValue, BIT_ATTRIBUTE_COMPRESSED) 
              lcAttributes = m.lcAttributes + 'C'
   
         CASE BITTEST(m.lnValue, BIT_ATTRIBUTE_OFFLINE) 
              lcAttributes = m.lcAttributes + 'O'
      ENDCASE

      RETURN m.lcAttributes
   ENDPROC
		



   ****************************************************
   PROCEDURE GetErrorCode(INP llShowMessage) && Watch dog of this FTP Service
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL lcMessage
      IF m.llShowMessage
         * Build Error Message Here
         lcMessage = "Error (" + ALLTRIM(STR(This.nResult_Code)) + ")  -  " + ;
                     This.GetErrorText(This.nResult_Code)
         IF !EMPTY(This.cExtended_Message)
            lcMessage = m.lcMessage + CHR(13) + CHR(13) + "Extended Error Info - (" + ;
                        ALLTRIM(STR(This.nExtended_Result)) + ;
                        ") - " + This.cExtended_Message
         ENDIF
         =MESSAGEBOX(m.lcMessage, 48, "FTP Error Message")
      ENDIF
      RETURN This.nResult_Code
   ENDPROC
	 	
   ****************************************************
   PROCEDURE GetExtendedErrorCode && Returns the extended error code that was generated during the last function call
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      RETURN This.nExtended_Result
   ENDPROC
	 	
	 	
   ****************************************************
   PROCEDURE GetExtendedErrorMsg && Returns the extended error message generated during a function call
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      RETURN This.cExtended_Message
   ENDPROC

   ****************************************************
   PROTECTED PROCEDURE GetExtendedError && Fill Extended error by WININET
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL lcMessage, lnError, lcBuffer
      This.nResult_Code = ftps_GetLastError()
	        
      lnError = 0
      lcBuffer = SPACE(MAX_PATH)
	        
      =ftps_InternetGetLastResponseInfo(m.lnError, @m.lcBuffer, MAX_PATH)
		    
      This.nExtended_Result = m.lnError
      This.cExtended_Message = LEFT(m.lcBuffer, AT(cNULL, m.lcBuffer) - 1)
      RETURN 
   ENDPROC

   ****************************************************
   PROTECTED PROCEDURE SetExtendedError(liError,lcError) && Set user extended error...
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      This.nResult_Code = 0
      This.nExtended_Result = m.liError
      This.cExtended_Message = m.lcError
      RETURN 
   ENDPROC
				
   ****************************************************
   PROCEDURE GetErrorText(INP lnError) && Get error text
      *!*	<pdm_sc_yes/>
      *!*	<pdm_dd_yes/>
      LOCAL lcMessage
      DO CASE
         CASE lnError =  ERROR_INTERNET_OUT_OF_HANDLES                
              lcMessage = "ERROR_INTERNET_OUT_OF_HANDLES"

         CASE lnError =  ERROR_INTERNET_TIMEOUT                       
              lcMessage = "ERROR_INTERNET_TIMEOUT"

         CASE lnError =  ERROR_INTERNET_EXTENDED_ERROR                
              lcMessage = "ERROR_INTERNET_EXTENDED_ERROR"

         CASE lnError =  ERROR_INTERNET_INTERNAL_ERROR                
              lcMessage = "ERROR_INTERNET_INTERNAL_ERROR"

         CASE lnError =  ERROR_INTERNET_INVALID_URL                   
              lcMessage = "ERROR_INTERNET_INVALID_URL"

         CASE lnError =  ERROR_INTERNET_UNRECOGNIZED_SCHEME           
              lcMessage = "ERROR_INTERNET_UNRECOGNIZED_SCHEME"

         CASE lnError =  ERROR_INTERNET_NAME_NOT_RESOLVED             
              lcMessage = "ERROR_INTERNET_NAME_NOT_RESOLVED"

         CASE lnError =  ERROR_INTERNET_PROTOCOL_NOT_FOUND            
              lcMessage = "ERROR_INTERNET_PROTOCOL_NOT_FOUND"

         CASE lnError =  ERROR_INTERNET_INVALID_OPTION                
              lcMessage = "ERROR_INTERNET_INVALID_OPTION"

         CASE lnError =  ERROR_INTERNET_BAD_OPTION_LENGTH             
              lcMessage = "ERROR_INTERNET_BAD_OPTION_LENGTH"

         CASE lnError =  ERROR_INTERNET_OPTION_NOT_SETTABLE           
              lcMessage = "ERROR_INTERNET_OPTION_NOT_SETTABLE"

         CASE lnError =  ERROR_INTERNET_SHUTDOWN                      
              lcMessage = "ERROR_INTERNET_SHUTDOWN"

         CASE lnError =  ERROR_INTERNET_INCORRECT_USER_NAME           
              lcMessage = "ERROR_INTERNET_INCORRECT_USER_NAME"

         CASE lnError =  ERROR_INTERNET_INCORRECT_PASSWORD            
              lcMessage = "ERROR_INTERNET_INCORRECT_PASSWORD"

         CASE lnError =  ERROR_INTERNET_LOGIN_FAILURE                 
              lcMessage = "ERROR_INTERNET_LOGIN_FAILURE"

         CASE lnError =  ERROR_INTERNET_INVALID_OPERATION             
              lcMessage = "ERROR_INTERNET_INVALID_OPERATION"

         CASE lnError =  ERROR_INTERNET_OPERATION_CANCELLED           
              lcMessage = "ERROR_INTERNET_OPERATION_CANCELLED"

         CASE lnError =  ERROR_INTERNET_INCORRECT_HANDLE_TYPE         
              lcMessage = "ERROR_INTERNET_INCORRECT_HANDLE_TYPE"

         CASE lnError =  ERROR_INTERNET_INCORRECT_HANDLE_STATE        
              lcMessage = "ERROR_INTERNET_INCORRECT_HANDLE_STATE"

         CASE lnError =  ERROR_INTERNET_NOT_PROXY_REQUEST             
              lcMessage = "ERROR_INTERNET_NOT_PROXY_REQUEST"

         CASE lnError =  ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND      
              lcMessage = "ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND"

         CASE lnError =  ERROR_INTERNET_BAD_REGISTRY_PARAMETER        
              lcMessage = "ERROR_INTERNET_BAD_REGISTRY_PARAMETER"

         CASE lnError =  ERROR_INTERNET_NO_DIRECT_ACCESS              
              lcMessage = "ERROR_INTERNET_NO_DIRECT_ACCESS"

         CASE lnError =  ERROR_INTERNET_NO_CONTEXT                    
              lcMessage = "ERROR_INTERNET_NO_CONTEXT"

         CASE lnError =  ERROR_INTERNET_NO_CALLBACK                   
              lcMessage = "ERROR_INTERNET_NO_CALLBACK"

         CASE lnError =  ERROR_INTERNET_REQUEST_PENDING               
              lcMessage = "ERROR_INTERNET_REQUEST_PENDING"

         CASE lnError =  ERROR_INTERNET_INCORRECT_FORMAT              
              lcMessage = "ERROR_INTERNET_INCORRECT_FORMAT"

         CASE lnError =  ERROR_INTERNET_ITEM_NOT_FOUND                
              lcMessage = "ERROR_INTERNET_ITEM_NOT_FOUND"

         CASE lnError =  ERROR_INTERNET_CANNOT_CONNECT                
              lcMessage = "ERROR_INTERNET_CANNOT_CONNECT"

         CASE lnError =  ERROR_INTERNET_CONNECTION_ABORTED            
              lcMessage = "ERROR_INTERNET_CONNECTION_ABORTED"

         CASE lnError =  ERROR_INTERNET_CONNECTION_RESET              
              lcMessage = "ERROR_INTERNET_CONNECTION_RESET"

         CASE lnError =  ERROR_INTERNET_FORCE_RETRY                   
              lcMessage = "ERROR_INTERNET_FORCE_RETRY"

         CASE lnError =  ERROR_INTERNET_INVALID_PROXY_REQUEST         
              lcMessage = "ERROR_INTERNET_INVALID_PROXY_REQUEST"

         CASE lnError =  ERROR_INTERNET_NEED_UI                       
              lcMessage = "ERROR_INTERNET_NEED_UI"

         CASE lnError =  ERROR_INTERNET_HANDLE_EXISTS                 
              lcMessage = "ERROR_INTERNET_HANDLE_EXISTS"

         CASE lnError =  ERROR_INTERNET_SEC_CERT_DATE_INVALID         
              lcMessage = "ERROR_INTERNET_SEC_CERT_DATE_INVALID"

         CASE lnError =  ERROR_INTERNET_SEC_CERT_CN_INVALID           
              lcMessage = "ERROR_INTERNET_SEC_CERT_CN_INVALID"

         CASE lnError =  ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR        
              lcMessage = "ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR"

         CASE lnError =  ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR        
              lcMessage = "ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR"

         CASE lnError =  ERROR_INTERNET_MIXED_SECURITY                
              lcMessage = "ERROR_INTERNET_MIXED_SECURITY"

         CASE lnError =  ERROR_INTERNET_CHG_POST_IS_NON_SECURE        
              lcMessage = "ERROR_INTERNET_CHG_POST_IS_NON_SECURE"

         CASE lnError =  ERROR_INTERNET_POST_IS_NON_SECURE            
              lcMessage = "ERROR_INTERNET_POST_IS_NON_SECURE"

         CASE lnError =  ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED       
              lcMessage = "ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED"

         CASE lnError =  ERROR_INTERNET_INVALID_CA                    
              lcMessage = "ERROR_INTERNET_INVALID_CA"

         CASE lnError =  ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP         
              lcMessage = "ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP"

         CASE lnError =  ERROR_INTERNET_ASYNC_THREAD_FAILED           
              lcMessage = "ERROR_INTERNET_ASYNC_THREAD_FAILED"

         CASE lnError =  ERROR_INTERNET_REDIRECT_SCHEME_CHANGE        
              lcMessage = "ERROR_INTERNET_REDIRECT_SCHEME_CHANGE"

         CASE lnError =  ERROR_INTERNET_DIALOG_PENDING                
              lcMessage = "ERROR_INTERNET_DIALOG_PENDING"

         CASE lnError =  ERROR_INTERNET_RETRY_DIALOG                  
              lcMessage = "ERROR_INTERNET_RETRY_DIALOG"

         CASE lnError =  ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR       
              lcMessage = "ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR"

         CASE lnError =  ERROR_INTERNET_INSERT_CDROM                  
              lcMessage = "ERROR_INTERNET_INSERT_CDROM"

         CASE lnError =  FTP_TRANSFER_IN_PROGRESS            	     
              lcMessage = "FTP_TRANSFER_IN_PROGRESS"

         CASE lnError =  FTP_DROPPED                         	     
              lcMessage = "FTP_DROPPED"

         CASE lnError =  FTP_NO_PASSIVE_MODE                          
              lcMessage = "FTP_NO_PASSIVE_MODE"

         CASE lnError =  ERROR_INTERNET_SECURITY_CHANNEL_ERROR        
              lcMessage = "ERROR_INTERNET_SECURITY_CHANNEL_ERROR"

         CASE lnError =  ERROR_INTERNET_UNABLE_TO_CACHE_FILE          
              lcMessage = "ERROR_INTERNET_UNABLE_TO_CACHE_FILE"

         CASE lnError =  ERROR_INTERNET_TCPIP_NOT_INSTALLED           
              lcMessage = "ERROR_INTERNET_TCPIP_NOT_INSTALLED"

         CASE lnError =  ERROR_INTERNET_DISCONNECTED                  
              lcMessage = "ERROR_INTERNET_DISCONNECTED"

         CASE lnError =  ERROR_INTERNET_SERVER_UNREACHABLE            
              lcMessage = "ERROR_INTERNET_SERVER_UNREACHABLE"

         CASE lnError =  ERROR_INTERNET_PROXY_SERVER_UNREACHABLE      
              lcMessage = "ERROR_INTERNET_PROXY_SERVER_UNREACHABLE"

         CASE lnError =  ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT         
              lcMessage = "ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT"

         CASE lnError =  ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT     
              lcMessage = "ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT"

         CASE lnError =  ERROR_INTERNET_SEC_INVALID_CERT    		     
              lcMessage = "ERROR_INTERNET_SEC_INVALID_CERT"

         CASE lnError =  ERROR_INTERNET_SEC_CERT_REVOKED    		     
              lcMessage = "ERROR_INTERNET_SEC_CERT_REVOKED"

         CASE lnError =  ERROR_NO_MORE_FILES
              lcMessage = "ERROR_NO_MORE_FILES"

         CASE lnError =  ERROR_INVALID_HANDLE
              lcMessage = "ERROR_INVALID_HANDLE"

         CASE lnError =  ERROR_FILE_NOT_FOUND
              lcMessage = "ERROR_FILE_NOT_FOUND"

         CASE lnError =  ERROR_PATH_NOT_FOUND
              lcMessage = "ERROR_PATH_NOT_FOUND"

         CASE lnError =  ERROR_ACCESS_DENIED
              lcMessage = "ERROR_ACCESS_DENIED"

         CASE lnError =  ERROR_FILE_EXISTS
              lcMessage = "ERROR_FILE_EXISTS"

         CASE lnError =  ERROR_INVALID_PARAMETER
              lcMessage = "ERROR_INVALID_PARAMETER"

         OTHERWISE	
              lcMessage = "Unknown Error Message"
      ENDCASE
      RETURN m.lcMessage
   ENDPROC


   ****************************************************
   PROTECTED PROCEDURE GetSystemOption(INP liOption) && Return any system option
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>

      DO CASE
         CASE m.liOption=_FTPS_Option_CurrentDir
              RETURN This.cCurrentDir

         CASE m.liOption=_FTPS_Option_DLL_Loaded
              RETURN This.lDLL_Loaded

         CASE m.liOption=_FTPS_Option_Inet_Handle
              RETURN This.nInet_Handle

         CASE m.liOption=_FTPS_Option_Connect_Handle
              RETURN This.nConnect_Handle

         CASE m.liOption=_FTPS_Option_IPAddress
              RETURN This.cIPAddress

         CASE m.liOption=_FTPS_Option_UserName
              RETURN This.cUserName

         CASE m.liOption=_FTPS_Option_Password
              RETURN This.cPassword

         CASE m.liOption=_FTPS_Option_Port
              RETURN This.cPort

         CASE m.liOption=_FTPS_Option_UseProxy
              RETURN This.lUseProxy

         OTHERWISE
              RETURN .NULL.
      ENDCASE
   ENDPROC



ENDDEFINE


DEFINE CLASS _LIST_PARSER AS CUSTOM
   oFTP=.NULL. && FTPClass instance
   cMonths=",jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec,"

   PROCEDURE FindDT(INPREF lcData)
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      LOCAL liAT,liy,liz,lcPom,liCnt,lcRow
      lcRow=LOWER(m.lcData)
      liCnt =OCCURS(",",This.cMonths)-1
      liAT=0
      FOR liy=1 TO m.liCnt
          liz=AT(",",This.cMonths,m.liy)
          lcMonth=SUBSTR(This.cMonths,m.liz+1,AT(",",This.cMonths,m.liy+1)-m.liz-1)

          FOR liz=1 TO OCCURS(m.lcMonth,m.lcRow)
              liAT=RAT(m.lcMonth,m.lcRow,m.liz)
              IF m.liAT=0
                 LOOP
              ENDIF
              lcPom=SUBSTR(m.lcData,m.liAT) && datetime info
              IF (SUBSTR(m.lcPom,4,1)=" " AND SUBSTR(m.lcPom,7,1)=" " AND VAL(SUBSTR(m.lcPom,5,2))>0 AND ;
                  VAL(SUBSTR(m.lcPom,8,2))>0 AND SUBSTR(m.lcPom,10,1)=":" AND VAL(SUBSTR(m.lcPom,11,2))>0) OR;
                 (SUBSTR(m.lcPom,4,1)=" " AND SUBSTR(m.lcPom,7,2)=" " AND VAL(SUBSTR(m.lcPom,5,2))>0 AND ;
                  VAL(SUBSTR(m.lcPom,9,4))>0)
                 EXIT
              ENDIF
              liAT=0
          NEXT
          IF m.liAT>0
             EXIT
          ENDIF
      NEXT
      RETURN m.liAT && Fail at parsing file
   ENDPROC

   PROCEDURE FormatDT(INPREF lcDT)
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      LOCAL liMonth,lcRet
      liMonth=ATC(","+LEFT(m.lcDT,3)+",",This.cMonths)
      liMonth=OCCURS(",",LEFT(This.cMonths,m.liMonth))

      IF AT(":",m.lcDT)>0 && Time 
         lcRet=EVALUATE("{^"+STR(YEAR(DATE()))+"-"+;
               LTRIM(STR(m.liMonth,2))+;
               "-"+LTRIM(SUBSTR(m.lcDT,5,2))+" "+SUBSTR(m.lcDT,8,5)+":00}")
      ELSE
         lcRet=EVALUATE("{^"+SUBSTR(m.lcDT,9,4)+"-"+;
               LTRIM(STR(m.liMonth,2))+;
               "-"+LTRIM(SUBSTR(m.lcDT,5,2))+" 00:00:00}")
      ENDIF
      RETURN m.lcRet
   ENDPROC

ENDDEFINE

DEFINE CLASS _LIST_PARSER_1 AS _LIST_PARSER && UNIX list parser
*!*       /* "         10        20        30        40        50        60
*!*       /* "1234567890123456789012345678901234567890123456789012345678901234567890"
*!*       /* UNIX-style listing, without inum and without blocks */
*!*       /* "-rw-r--r--   1 root     other        531 Jan 29 03:26 README" */
*!*       /* "dr-xr-xr-x   2 root     other        512 Apr  8  1994 etc" */
*!*       /* "dr-xr-xr-x   2 root                  512 Apr  8  1994 etc" */
*!*       /* "lrwxrwxrwx   1 root     other          7 Jan 25 00:17 bin -> usr/bin" */

*!*       /* "-rwxrwx---   1 gorila   www-data       49 May 27  2006 dbc.css
*!*       /* "-rwxrwx---   1 gorila   www-data      620 May 27  2006 dbc.html
*!*       /* "-rwxrwx---   1 gorila   www-data       33 May 27  2006 devcon.css
*!*       /* "-rwxrwx---   1 gorila   www-data      806 May 27  2006 devcon.html
*!*       /* "-rwxrwx---   1 gorila   www-data       37 May 27  2006 dumpfll.css
*!*       /* "-rwxrwx---   1 gorila   www-data      853 May 27  2006 dumpfll.html
*!*       /* "drwxrwx---   2 gorila   www-data     4096 Jan 10  2007 bw
*!*       /* "drwxr-xr-x   2 gorila   www-data     4096 Aug 30 07:27 canal

*!*       /* Also NetPresenz for the Mac: */
*!*       /* "-------r--         326  1391972  1392298 Nov 22  1995 MegaPhone.sit" */
*!*       /* "drwxrwxr-x               folder        2 May 10  1996 network" */

*!*       /* Also produced by Microsoft's FTP servers for Windows: */
*!*       /* "----------   1 owner    group   .     1803128 Jul 10 10:18 ls-lR.Z" */
*!*       /* "d---------   1 owner    group               0 May  9 19:45 Softlib" */
*!*       /* Also WFTPD for MSDOS: */
*!*       /* "-rwxrwxrwx   1 noone    nogroup           322 Aug 19  1996 message.ftp" */

         * [x, 1] = File Attributes - 1
         * [x, 2] = Links count     - 2
         * [x, 3] = Owner           - 3
         * [x, 4] = Group           - 4
         * [x, 5] = File Size       - 5
         * [x, 6] = File Last Write Time () - 6+7+8
         * [x, 7] = File Name       - 9

   PROCEDURE Parse(CHNGREF laFiles,INP loEngine)
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      EXTERNAL ARRAY laFiles
      LOCAL liEnd,lcData,lii,liAT,liy,liz,lcPom,lnFileSize
      DIMENSION m.laFiles(100,7)
      liEnd=AT(CRLF,m.loEngine.cData,1)
      lii=0
      DO WHILE m.liEnd>0
         lcData=LEFT(m.loEngine.cData,m.liEnd-1)
         loEngine.cData=SUBSTR(m.loEngine.cData,m.liEnd+2)
         liEnd=AT(CRLF,m.loEngine.cData,1)
        
         lii=m.lii+1
         IF m.lii>ALEN(m.laFiles,1)
            DIMENSION m.laFiles(m.lii+100,7)
         ENDIF            
         * Row processing
         laFiles(m.lii,1)=SUBSTR(m.lcData,1,10)
         laFiles(m.lii,2)=VAL(SUBSTR(m.lcData,12,3))

         * Check where is: "Mon Da HH:MM" or "Mon Da  YYYY"
         liAT=This.FindDT(@m.lcData)
         IF m.liAT=0 && Fail at parsing file
            This.oFTP.SetExtendedError(_FTPS_UE_PLF,m.lcRow)
            RETURN .F.
         ENDIF

         * Date last modify
         laFiles(m.lii,6)=This.FormatDT(SUBSTR(m.lcData,m.liAT,12))

         * File name
         laFiles(m.lii,7)=SUBSTR(m.lcData,m.liAT+13)

         * from 16. char to liAT-2 are three columns
         lcPom=ALLTRIM(SUBSTR(m.lcData,16,m.liAT-16-1))
         liy=AT(" ",m.lcPom)
         liz=RAT(" ",m.lcPom)
         laFiles(m.lii,3)=ALLTRIM(LEFT(m.lcPom,m.liy-1))      && Owner
         laFiles(m.lii,4)=ALLTRIM(SUBSTR(m.lcPom,m.liy+1,m.liz-1-m.liy))      && Group
*         laFiles(m.lii,5)=VAL(SUBSTR(m.lcPom,m.liz+1)) && Size
         IF This.oFTP.GetFileSize(m.laFiles(m.lii,7),@m.lnFileSize)
            laFiles(m.lii,5)=m.lnFileSize
         ENDIF

      ENDDO
      IF m.lii>0 AND m.lii<>ALEN(m.laFiles,1)
         DIMENSION laFiles(m.lii,7)
      ENDIF
      RETURN .T.
   ENDPROC
ENDDEFINE

DEFINE CLASS _LIST_PARSER_2 AS _LIST_PARSER_1 && WIN List Parser
ENDDEFINE

DEFINE CLASS _LIST_PARSER_3 AS _LIST_PARSER_1 && DOS List Parser
ENDDEFINE


DEFINE CLASS _LIST_PARSER_5 AS _LIST_PARSER_1 && Mac List Parser
ENDDEFINE



DEFINE CLASS _LIST_PARSER_4 AS _LIST_PARSER && NOVELL list parser
*!*       /* "         10        20        30        40        50        60
*!*       /* "1234567890123456789012345678901234567890123456789012345678901234567890"
*!*       /* Also NetWare: */
*!*       /* "d [R----F--] supervisor            512       Jan 16 18:53    login" */
*!*       /* "- [R----F--] rhesus             214059       Oct 20 15:27    cx.exe" */

         * [x, 1] = File Attributes - 1
         * [x, 2] = Links count     - 2
         * [x, 3] = Owner           - 3
         * [x, 4] = Group           - 4
         * [x, 5] = File Size       - 5
         * [x, 6] = File Last Write Time () - 6+7+8
         * [x, 7] = File Name       - 9

   PROCEDURE Parse(CHNGREF laFiles,INP loEngine)
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      EXTERNAL ARRAY laFiles
      LOCAL liEnd,lcData,lii,liAT,liy,liz,lcPom,lnFileSize
      DIMENSION m.laFiles(100,7)
      liEnd=AT(CRLF,m.loEngine.cData,1)
      lii=0

      DO WHILE m.liEnd>0
         lcData=LEFT(m.loEngine.cData,m.liEnd-1)
         loEngine.cData=SUBSTR(m.loEngine.cData,m.liEnd+2)
         liEnd=AT(CRLF,m.loEngine.cData,1)
        
         lii=m.lii+1
         IF m.lii>ALEN(m.laFiles,1)
            DIMENSION m.laFiles(m.lii+100,7)
         ENDIF            
         * Row processing
         laFiles(m.lii,1)=LEFT(m.lcData,1)+SUBSTR(m.lcData,4,8)
         laFiles(m.lii,2)=0

         * Check where is: "Mon Da HH:MM" or "Mon Da  YYYY"
         liAT=This.FindDT(@m.lcData)
         IF m.liAT=0 && Fail at parsing file
            This.oFTP.SetExtendedError(_FTPS_UE_PLF,m.lcRow)
            RETURN .F.
         ENDIF

         * Date last modify
         laFiles(m.lii,6)=This.FormatDT(SUBSTR(m.lcData,m.liAT,12))

         * File name
         laFiles(m.lii,7)=RTRIM(SUBSTR(m.lcData,m.liAT+13))

         * from 16. char to liAT-2 are two columns
         lcPom=ALLTRIM(SUBSTR(m.lcData,14,m.liAT-14-1))
         liy=AT(" ",m.lcPom)
         laFiles(m.lii,3)=ALLTRIM(LEFT(m.lcPom,m.liy-1))      && Owner
         laFiles(m.lii,4)=""     && Group
*         laFiles(m.lii,5)=VAL(ALLT(SUBSTR(m.lcPom,m.liy+1))) && Size
         IF This.oFTP.GetFileSize(m.laFiles(m.lii,7),@m.lnFileSize)
            laFiles(m.lii,5)=m.lnFileSize
         ENDIF

      ENDDO
      IF m.lii>0 AND m.lii<>ALEN(m.laFiles,1)
         DIMENSION m.laFiles(m.lii,7)
      ENDIF
      RETURN .T.
   ENDPROC
ENDDEFINE


DEFINE CLASS _LIST_PARSER_0 AS _LIST_PARSER && EPFL list parser
*!*       /* "         10        20        30        40        50        60
*!*       /* "1234567890123456789012345678901234567890123456789012345678901234567890"
*!*       /* Also EPFL: */
*!*       /* "+i8388621.29609,m824255902,/,\tdev" */
*!*       /* "+i8388621.44468,m839956783,r,s10376,\tRFCEPLF" */

             * http://cr.yp.to/ftp/list/eplf.html

         * [x, 1] = File Attributes - 1
         * [x, 2] = Links count     - 2
         * [x, 3] = Owner           - 3
         * [x, 4] = Group           - 4
         * [x, 5] = File Size       - 5
         * [x, 6] = File Last Write Time () - 6+7+8
         * [x, 7] = File Name       - 9

   PROCEDURE Parse(CHNGREF laFiles,INP loEngine)
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      EXTERNAL ARRAY laFiles
      LOCAL liEnd,lcData,lii,liy,liz,lcPom,lnFileSize,liAT,liATE
      DIMENSION m.laFiles(100,7)
      liEnd=AT("\015\012",m.loEngine.cData,1)
      lii=0

      DO WHILE m.liEnd>0
         lcData=SUBSTR(m.loEngine.cData,2,m.liEnd-2)
         loEngine.cData=SUBSTR(m.loEngine.cData,m.liEnd+2)
         liEnd=AT("\015\012",m.loEngine.cData,1)
        
         lii=m.lii+1
         IF m.lii>ALEN(m.laFiles,1)
            DIMENSION m.laFiles(m.lii+100,7)
         ENDIF            

         liy=OCCURS(",",m.lcData)+1
         * Row processing

         FOR liz=1 TO m.liy
             liAT=IIF(m.liz=1,1,AT(",",m.lcData,m.liz-1)+1)
             liATE=IIF(m.liz<m.liy-1,AT(",",m.lcData,m.liz)-1,LEN(m.lcData))
             lcPom=SUBSTR(m.lcData,m.liAT,m.liATE-m.liAT)

             DO CASE
                CASE LEFT(m.lcPom,1)='i'

                CASE LEFT(m.lcPom,1)='m'
                    * Date last modify
                    laFiles(m.lii,6)={^1970-01-01 00:00:00}+VAL(SUBSTR(m.lcPom,2))

                CASE LEFT(m.lcPom,1)='r' OR LEFT(m.lcPom,1)='/'
                     laFiles(m.lii,1)=m.lcPom

                CASE LEFT(m.lcPom,1)='s'
                     laFiles(m.lii,5)=VAL(ALLT(SUBSTR(m.lcPom,2))) && Size
*!*	                     IF This.oFTP.GetFileSize(m.laFiles(m.lii,7),@m.lnFileSize)
*!*	                        laFiles(m.lii,5)=m.lnFileSize
*!*	                     ENDIF

                OTHERWISE
                    * Name of file
                    laFiles(m.lii,7)=STRTRAN(m.lcPom,"\t","")

             ENDCASE
         NEXT

         laFiles(m.lii,2)=0
      ENDDO
      IF m.lii>0 AND m.lii<>ALEN(m.laFiles,1)
         DIMENSION m.laFiles(m.lii,7)
      ENDIF
      RETURN .T.
   ENDPROC
ENDDEFINE

DEFINE CLASS _LIST_PARSER_ENGINE AS _LIST_PARSER

   cData="" && Data for parsing

   PROCEDURE Parse(CHNGREF laFiles,INPREF lcData)
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      LOCAL liFormat,loParser,llRet
      This.cData=m.lcData
      lcData="" && freeze
    
      liFormat=This.CheckFormat()
      
      IF !PEMSTATUS(This,"PL"+STR(m.liFormat,1),5)
         This.AddObject("PL"+STR(m.liFormat,1),"_LIST_PARSER_"+STR(m.liFormat,1))
      ENDIF
      loParser=EVALUATE("This.PL"+STR(m.liFormat,1))
      loParser.oFTP=This.oFTP
      llRet=loParser.Parse(@m.laFiles,This)
      loParser.oFTP=.NULL.
      RETURN m.llRet
   ENDPROC

   PROCEDURE CheckFormat
      *!*   <pdm_sc_yes/>
      *!*   <pdm_dd_yes/>
      IF AT("\015\012",This.cData)>0 OR LEFT(This.cData,1)="+"
         RETURN _FTPC_PL_EPLF
      ENDIF

      IF SUBST(This.cData,2,1)=" "
         RETURN _FTPC_PL_NWL
      ENDIF

      RETURN _FTPC_PL_UNIX && _FTPC_PL_MSWIN,_FTPC_PL_DOC, _FTPC_PL_MAC
      * fòuk, fnuk, I'm lazy : http://cr.yp.to/ftpparse/ftpparse.c
ENDDEFINE