#DEFINE NEWCODEBLOCK .T.

*** Stripped down version for wwPDF

**************************************************************
*** This program file consists of two classes:
***
***     wwEval        -  Single statement Evaluation routine
***     wwCodeBlock   -  Multiple command 'program' evaluation
***                      routine. This class is really 
***                      Randy Pearson's CodeBlock class
***                      renamed here for consistency with 
***                      Web Connection
*************************************************************
#INCLUDE WCONNECT.H

*************************************************************
DEFINE CLASS wwEval AS RELATION
*************************************************************
***    Author: Rick Strahl
***            (c) West Wind Technologies, 1996
***   Contact: (541) 386-2087  / rstrahl@west-wind.com
***  Modified: 05/01/96
***  Function: Evaluation Class used to safely execute
***            evaluation strings and test for error
*************************************************************

*** Custom Properties
lError=.F.
nError=0
cResultType="L"
vErrorResult=.F.
Result=""

*** These properties are specific to executing
*** Code Block 
oCodeBlock=.Null.
nErrorLine=0
cErrorCode=""
cErrorMessage=""

lCompileCodeBlock = .F.

*** Stock Properties

************************************************************************
* wwEval :: Evaluate
*********************************
***  Function: Actually evaluates expression.
***      Pass: lcExpression  -  Expression to evaluate
***    Return: Result
************************************************************************
FUNCTION Evaluate
LPARAMETERS lcEvalString

THIS.lError=.F.

THIS.Result=EVALUATE(lcEvalString)

IF THIS.lError  && OR TYPE("THIS.Result")#THIS.cResultType
   THIS.lError=.T.
   THIS.cErrorMessage=Message()
   THIS.cErrorCode = Message(1) 
   RETURN THIS.vErrorResult
ENDIF   
   
RETURN THIS.Result
* Evaluate

************************************************************************
* wwEval :: ExecuteCommand
*********************************
***  Function: Macro Expands the command passed.
***      Pass: lcCommand -  Command to run 
***    Return: nothing
************************************************************************
FUNCTION ExecuteCommand
LPARAMETERS lcEvalString

THIS.lError=.F.

&lcEvalString

IF THIS.lError  && OR TYPE("THIS.Result")#THIS.cResultType
   THIS.lError=.T.
   THIS.cErrorMessage = Message()
   THIS.cErrorCode = lcEvalString
   RETURN THIS.vErrorResult
ENDIF   
   
RETURN
* Evaluate


************************************************************************
* wwEval :: SetResultType
*********************************
***  Function: Set the Result Type for the Evaluated expression.
***      Pass: lcType -   Valid FoxPro Type
***    Return: nothing
************************************************************************
FUNCTION SetResultType
LPARAMETERS lcType
lcType=IIF(vartype(lcType)="C",UPPER(lcType),"C")
THIS.cResultType=lcType
ENDFUNC
* SetResultType

************************************************************************
* wwEval :: SetErrorResult
*********************************
***  Function: Set the Default value that is returned if the Eval
***            fails.
***      Pass: lvErrorResult   -   Result value to assign
***    Return: nothing
************************************************************************
FUNCTION SetErrorResult
LPARAMETERS lvErrorResult
THIS.vErrorResult=lvErrorResult
ENDFUNC
* SetErrorResult

************************************************************************
* wwEval :: IsError
*********************************
***  Function: Returns error status of previous eval operation
***    Return: .T. or .F.
************************************************************************
FUNCTION IsError
RETURN THIS.lError
* IsError

************************************************************************
* wwEval :: GetErrorNumber
*********************************
***  Function: Returns the error number of the previous eval operation
***            if an error occurred.
***    Return: Error number or 0
************************************************************************
FUNCTION GetErrorNumber
IF !THIS.lError
   RETURN 0
ENDIF
RETURN THIS.nError  
* GetErrorNumber


*#IF !DEBUGMODE

************************************************************************
* wwEval :: Error
*********************************
***  Function: Traps Evaluation error, sets error flag and error number
************************************************************************
FUNCTION ERROR
LPARAMETER nError, cMethod, nLine

THIS.lError=.T.
THIS.nError=nError
THIS.nErrorLine=nLine
THIS.cErrorMessage = MESSAGE()

ENDFUNC
* Error


ENDDEFINE
*EOC wwEval


****************************************************
FUNCTION GoUrl
******************
***    Author: Rick Strahl
***            (c) West Wind Technologies, 1996
***   Contact: rstrahl@west-wind.com
***  Modified: 03/14/96
***  Function: Starts associated Web Browser
***            and goes to the specified URL.
***            If Browser is already open it
***            reloads the page.
***    Assume: Works only on Win95 and NT 4.0
***      Pass: tcUrl  - The URL of the site or
***                     HTML page to bring up
***                     in the Browser
***    Return: 2  - Bad Association (invalid URL)
***            31 - No application association
***            29 - Failure to load application
***            30 - Application is busy 
***
***            Values over 32 indicate success
***            and return an instance handle for
***            the application started (the browser) 
****************************************************
LPARAMETERS tcUrl, tcAction, tcDirectory

tcUrl=IIF(type("tcUrl")="C",tcUrl,;
          "http://www.west-wind.com/")
          
tcAction=IIF(type("tcAction")="C",tcAction,"OPEN")

tcDirectory=IIF(EMPTY(tcDirectory),SYS(2023),tcDirectory)

DECLARE INTEGER ShellExecute ;
    IN SHELL32.dll ;
    INTEGER nWinHandle,;
    STRING cOperation,;
    STRING cFileName,;
    STRING cParameters,;
    STRING cDirectory,;
    INTEGER nShowWindow

DECLARE INTEGER FindWindow ;
   IN WIN32API ;
   STRING cNull,STRING cWinName

RETURN ShellExecute(FindWindow(0,_SCREEN.caption),;
                    tcAction,tcUrl,;
                    "",tcDirectory,1)
