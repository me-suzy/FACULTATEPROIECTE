**********************************************************************
* Program....: WinDir.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Windows API Directory Functions
* ...........: Calling Options
* ...........: 1  -> Return Windows System Directory
* ...........: 2  -> Return Windows Directory
* ...........: 3  -> Return Current Working Directory
* ...........: 4, <path> -> Set Working Directory (Accepts Relative Path)
* ...........: 5, <path> -> Create Named Directory (Accepts Relative Path)
* ...........: 6, <path> -> Remove Named Directory (Accepts Relative Path)
**********************************************************************
LPARAMETERS tnWhich, tcDirName
LOCAL lcSysDir, lnBuffer, lnDirLen, lcRetVal
*** Initialize the buffers
lcSysDir = REPLICATE(CHR(0),255)
lnBuffer = 255
*** Execute Appropriate call
Do CASE
    CASE tnWhich = 1
        *** Windows system directory
        DECLARE INTEGER GetSystemDirectory IN Win32API ;
            STRING @cBuffer, ;
            INTEGER nSize
        *** Call the function
        lnDirLen = GetSystemDirectory( @lcSysDir, lnBuffer )
        lcRetVal = LEFT( lcSysDir, lnDirLen )

    CASE tnWhich = 2
        *** Windows system directory
        DECLARE INTEGER GetWindowsDirectory IN Win32API ;
            STRING @cBuffer, ;
            INTEGER nSize
        *** Call the function
        lnDirLen = GetWindowsDirectory( @lcSysDir, lnBuffer )
        lcRetVal = LEFT( lcSysDir, lnDirLen )

    CASE tnWhich = 3
        *** Current working directory
        DECLARE INTEGER GetCurrentDirectory IN Win32API ;
            INTEGER nSize, ;
            STRING @cBuffer
        *** Call the function
        lnDirLen = GetCurrentDirectory( lnBuffer, @lcSysDir )
        lcRetVal = LEFT( lcSysDir, lnDirLen )

    CASE tnWhich = 4
        *** Set Default Directory
        DECLARE INTEGER SetCurrentDirectory IN WIN32API ;
            STRING cNewDir
        *** Call the function, return name if OK, empty string if not
        lcRetVal = IIF( SetCurrentDirectory( tcDirName) = 1, tcDirName, "Directory does not exist")

    CASE tnWhich = 5
        *** Create Directory
        DECLARE INTEGER CreateDirectory IN WIN32API ;
            STRING cNewDir, ;
            STRING cAttrib
        *** Call the function
        lnSuccess = CreateDirectory ( tcDirName, "")
        lcRetVal = IIF( lnSuccess = 1, "Created", "Failed" )

    CASE tnWhich = 6
        *** Remove Directory
        DECLARE INTEGER RemoveDirectory IN WIN32API ;
            STRING cKillDir
        *** Call the function
        lnSuccess = RemoveDirectory( tcDirName)
        lcRetVal = IIF( lnSuccess = 1, "Removed", "Failed" )

    OTHERWISE
        *** Unknown Parameter
        lcRetVal = ""
ENDCASE
*** Return the directory location
RETURN lcRetVal
