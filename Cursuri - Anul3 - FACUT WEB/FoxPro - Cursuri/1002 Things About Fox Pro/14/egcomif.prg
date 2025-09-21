***********************************************************************
* Program....: egcomif.prg
* Compiler...: Visual FoxPro 07.00.0000.9465
* Purpose....: Simple COM class Interface definition
***********************************************************************
DEFINE CLASS egComIF AS session OLEPUBLIC
  *** Add an exposed property [WILL appear in the Type Library]
  cExpProp = "" 
  *** And a protected rpoperty [Will NOT appear in Type Library] 
  PROTECTED nHidProp 
  nHidProp = 0
 
  ********************************************************************
  *** [E] EXACTSEEK(): Runs a SEEK inside an EXACT setting
  *** [This method WILL appear in the Type Library]
  ********************************************************************
  FUNCTION ExactSeek( tuValue AS Variant, ;
                      tcAlias AS String, ;
                      tcTag AS String ) AS Variant ;
                       HELPSTRING "Runs a SEEK inside an EXACT setting"
  ENDFUNC

  ********************************************************************
  *** [P] SETUP(): Set up working environment
  *** [This method will NOT appear in the Type Library]
  ********************************************************************
  PROTECTED FUNCTION SetUp()
    *** Need to set Multilocks if we want buffering!
    SET MULTILOCKS ON
  ENDFUNC

  ********************************************************************
  *** [P] INIT(): Standard Initialization method 
  *** [Native PEMs for Session Class do NOT appear in Type Library]
  ********************************************************************
  FUNCTION Init
    RETURN This.SetUp()
  ENDFUNC

ENDDEFINE
