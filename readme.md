# FTP Class
FTP Class is base on FTP Class 1.1a by Robert Abram. 

## Acknowledgments
 ...VFP comunnity on internet for many examples "How to use FTP class". 

## What is new...
 - Read&Write resume support
 - Native FTP Command
 - Multi operations
 - User's events
 - Native passive mode
 - Proxy support

## Files
- ftp.PRG - mail program
- ftp.h - header file
- core.h - header file 

## Question and answers

### How to change mode from passive to active
```foxpro
LOCAL loFTP,lii
LOCAL ARRAY laFolders(1)
#INCLUDE "x:\ftp\ftp.h"
SET PROCEDURE TO x:\ftp\ftp.prg ADDITIVE 
loFTP=CREATEOBJECT('ftp_service') 
loFTP.nFlags=BITXOR(loFTP.nFlags,INTERNET_FLAG_PASSIVE) && Reset passive mode

IF loFTP.OpenInternet("ABONNE", "PWD", "10.10.10.10", "21")

   =loFTP.ChangeFTPDirectory("download")
   IF !loFTP.GetFTPDirectoryArray(@laFolders,"*.zip")
      ?loFTP.GetExtendedErrorCode(),loFTP.GetExtendedErrorMsg()
   ELSE
      FOR lii=1 TO 1 && ALEN(laFolders,1)
          ?laFolders(lii, 1)         && File name
          ?CHR(9)+"Alternate File name: "+laFolders(lii, 2)
          ?CHR(9)+"File Size: "+STR(laFolders(lii, 3),11)
          ?CHR(9)+"File Create Date: "+TTOC(laFolders(lii, 4))
          ?CHR(9)+"File Last Access Time: "+TTOC(laFolders(lii, 5))
          ?CHR(9)+"File Last Write Time: "+TTOC(laFolders(lii, 6))
          ?CHR(9)+"File Attributes: "+laFolders(lii, 7)
          IF !loFTP.GetFTPFile(laFolders(lii, 1),"c:\temp\"+laFolders(lii, 1))
             ?loFTP.GetExtendedErrorCode(),loFTP.GetExtendedErrorMsg()
          ENDIF
      NEXT
   ENDIF
   =loFTP.CloseInternet() 
ELSE
   ?loFTP.GetExtendedErrorCode(),loFTP.GetExtendedErrorMsg()
ENDIF
RELEASE PROCEDURE x:\ftp\ftp.prg
```

### How to get informations about one file
 You can use method GetFTPDirectoryArray(). 

```foxpro
#INCLUDE "ftp.h"
CLEAR
lcPath=SYS(16)
lcPath=IIF(RAT("\",lcPath)>0,LEFT(lcPath,RAT("\",lcPath)),lcPath)

SET PROCEDURE TO (lcPath+"ftp.fxp")
DIMENSION laFiles(1)

loFTP = CREATEOBJECT('ftp_service')
IF loFTP.OpenInternet("ABONNE", "PWD", "10.10.10.10", "21")
    =loFTp.ChangeFTPDirectory("Kubuntu704")
    loFTP.GetFTPDirectoryArray(@laFile, "test.rar",0)
    ?
    ?laFile[1,1]
    ?laFile[1, 2]
    ?laFile[1, 3]
    ?laFile[1, 4]
    ?laFile[1, 5]
    ?laFile[1, 6]
    ?laFile[1, 7]
ENDIF
loFTP.CloseInternet()
```

### How to get file size
 You can use method GetFileSize(). 

```foxpro
#INCLUDE "ftp.h"
CLEAR
LOCAL lnFileSize,lcPath,loFTP
lcPath=SYS(16)
lcPath=IIF(RAT("\",lcPath)>0,LEFT(lcPath,RAT("\",lcPath)),lcPath)
SET PROCEDURE TO (lcPath+"ftp.fxp")

loFTP = CREATEOBJECT('ftp_service')
IF loFTP.OpenInternet("ABONNE", "PWD", "10.10.10.10", "21")
    =loFTp.ChangeFTPDirectory("Kubuntu704")
    IF loFTP.GetFileSize("test.rar",@lnFileSize)
       ?lnFileSize
    ENDIF
ENDIF
loFTP.CloseInternet()
```

### How to use method NLST()
 See to examples in methods [NLST()](doc/code/FTP.PRG/cls.ftp_service.nlst.htm) method. 

### How to use method List()
 See to examples in methods List() method. 

### Why result of List() method return incorrect values?
 The result of LIST command is depend on implementation of FTP server. FTP server can send bad file size or datetime. 

### Why if I call method List() with output to array the VFP cause error?
 The result of LIST command is very variable tha parsing can be failed. Please use output to file or string. 

### Time at time VFP hangup at using FTP Class. Why?
 I don't know why. I know the problem if I use Golden FTP Server on local machine. 

### Does FTP class support FTP over SSL?
 No. But you can use VFP libcurl (http://www.ctl32.com.ar/libcurl.asp) by Carlos Alloatti or any com object as Chilkat FTP object. 

### Calling method PutFTPFile caused error 2027 - Declare DLL call caused an exception.
 This error can cause method ChangeFTPDirectory() where folder separator is "\" and FTP server run on UNIX/Linux. Change folder separator from "\" to "/" (UNIX like) don't cause error.
