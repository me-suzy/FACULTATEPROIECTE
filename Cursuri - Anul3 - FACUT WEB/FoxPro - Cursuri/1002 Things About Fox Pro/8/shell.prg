* WinApi :: ShellExecute
*  Function: Opens a file in the application 
*            that it's associated with.
*      Pass: lcFileName -  Name of the file to open
*   
*  Return:   2  - Bad Association (ie, invalid URL)
*            31 - No application association
*            29 - Failure to load application
*            30 - Application is busy 
*
*            Values over 32 indicate success
*            and return an instance handle for
*            the application started (the browser)
LPARAMETERS tcFileName, tcWorkDir, tcOperation

LOCAL lcFileName, ;
      lcWorkDir, ;
      lcOperation

IF EMPTY(tcFileName)
   RETURN -1
ENDIF

lcFileName  = ALLTRIM(tcFileName)
lcWorkDir   = IIF(TYPE("tcWorkDir") = "C", ;
                       ALLTRIM(tcWorkDir),"")
lcOperation = IIF(TYPE("tcOperation")="C" AND ;
                  NOT  EMPTY(tcOperation), ;
                  ALLTRIM(tcOperation),"Open")

* ShellExecute(hwnd, lpszOp, lpszFile, lpszParams,;
*              lpszDir, wShowCmd)
* 
* HWND hwnd - handle of parent window
* LPCTSTR lpszOp    - address of string for 
*                     operation to perform
* LPCTSTR lpszFile  - address of string for filename
* LPTSTR lpszParams - address of string for 
*                     executable-file parameters
* LPCTSTR lpszDir   - address of string for default
*                     directory
* INT wShowCmd      - whether file is shown when
*                     opened
DECLARE INTEGER ShellExecute ;
       IN SHELL32.DLL ;
       INTEGER nWinHandle,;
       STRING cOperation,;   
       STRING cFileName,;
       STRING cParameters,;
       STRING cDirectory,;
       INTEGER nShowWindow

RETURN ShellExecute(0,lcOperation,lcFilename,;
                    "",lcWorkDir,1)

*: EOF :* 
