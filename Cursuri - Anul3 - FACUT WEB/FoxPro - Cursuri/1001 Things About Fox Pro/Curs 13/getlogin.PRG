****************************************************
* Program....: GetLogIn.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Get Windows Log-In Name
****************************************************
LOCAL lcUserName, lcRetVal

*** Declare API Function
DECLARE GetUserName IN Win32Api ;
    STRING @cString, ;
    INTEGER @nBuffer

*** Initialise the buffers	
lcUserName = SPACE(50)

*** Get the Login Name
GetUserName( @lcUserName, LEN(lcUserName) )

*** String is Null-terminated in the result buffer so:
lcRetVal = LEFT(lcUserName, AT(CHR(0), lcUserName) - 1)

*** Return Login ID
RETURN lcRetVal
