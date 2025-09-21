***********************************************************************
* Program....: WordForm.prg
* Date.......: 12 October 2001
* Compiler...: Visual FoxPro 07.00.0000.9147 for Windows 
***********************************************************************
DEFINE CLASS xChgCase AS session
  cAssertWas = ""
  cErrorWas = ""
  cInString = ""
  cOutString = ""
  cTableName = "WordForm"
  nWordCount = 0
  nFoxVersion = 700
  nDataSesWas = 0
  PROTECTED cAssertWas, cErrorWas, nFoxVersion

  ********************************************************************
  *** [E] FORMATTEXT(): Main Calling Method for formatting
  ********************************************************************
  FUNCTION FormatText( tcInString )
    LOCAL lcInString, lcOutString
    WITH This
      *** Set the environment we want
      IF ! .SetEnv()
        *** We failed for some reason, return the same string we were given
        .ResetEnv()
        RETURN tcInString
      ENDIF

      *** Check Parameters
      IF VARTYPE( tcInstring ) # "C" OR EMPTY( tcInstring )
        *** We didn't get a character string - return whatever it was we got unchanged
        ASSERT .F. MESSAGE 'Must pass a character string to FormatText()'
        .ResetEnv()
        RETURN tcInString
      ENDIF
      
      *** Initialize Variables. Do not change the case of the input string!
      .cInString = ALLTRIM( tcInstring )
      *** And clear the output string (in case it's not empty)
      .cOutString = ""

      *** Now replace all spaces with CHR(96) to preserve them and 
      *** add a space after any Character that is not alphnumeric
      .ForceSpacing()

      *** Next set the Word Count property
      IF This.nFoxVersion  < 700
        *** Not VFP 7.00 or later, so we need the FoxTools function
        This.nWordCount = WORDS( This.cOutString )
      ELSE
        *** We have VFP 7.00 or later, so we can just use GETWORDCOUNT()
        This.nWordCount = GETWORDCOUNT( This.cOutString )
      ENDIF

      *** Now format the string
      .ForceCase()
          
      *** Restore the original spacing here
      .RestoreSpacing()

      *** Finally check for words that end ['x] - can't do that in the main loop
      .CheckTerminalCaps()

      *** Tidy up and return the Result
      .ResetEnv()

      RETURN This.cOutString
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [P] FORCESPACING(): Takes the input string and replaces all spaces
  *** with CHR(96) to preserve the original spacing and then adds a space 
  *** immediately after any character that is not a letter or a number.
  *** Stores result to the cOutString property
  ********************************************************************
  PROTECTED FUNCTION ForceSpacing()
  LOCAL lnLen, lnCnt, lcSce, lcTgt, lcChar
    *** Firstly process all spaces to CHR(96) to preserve them
    lcSce = STRTRAN( This.cInstring, CHR(32), CHR(96))
    *** Get the overall length
    lnLen = LEN( This.cInstring )
    *** Process each character and write it out so that everything
    *** except letters and numbers is followed by a space
    STORE  "" TO lcChar, lcTgt
    FOR lnCnt = 1 TO lnlen
      *** Get a Character
      lcChar = SUBSTR( lcSce, lnCnt, 1 )
      *** Is it a letter
      IF ISALPHA( lcChar )
        lcTgt = lcTgt + lcChar
        LOOP
      ENDIF
      *** Not a letter, is it a number?
      IF ISDIGIT( lcChar )
        lcTgt = lcTgt + lcChar
        LOOP
      ENDIF
      *** Neither letter nor number so add a space
      lcTgt = lcTgt + lcChar + CHR(32)
    NEXT
    This.cOutString = lcTgt
    RETURN
  ENDFUNC

  ********************************************************************
  *** [P] FORCECASE(): Put text into proper case, properly
  ********************************************************************
  PROTECTED FUNCTION ForceCase()
  LOCAL lnWords, lcSce, lnCnt, llAddMarker, llAddLastChar, lcWord, lnLastChar
    lnWords = This.nWordCount
    *** Get the string to work with
    lcSce = This.cOutString
    *** Clear the output property
    This.cOutString = ""
    *** Then Process each word in turn
    FOR lnCnt = 1 TO lnWords
      *** Initialize flags
      STORE .F. TO llAddMarker, llAddLastChar
      *** Use correct function
      IF This.nFoxVersion = 700
        *** Use the VFP 7.00 function
        lcWord = GETWORDNUM( lcSce, lnCnt ) 
      ELSE
        *** Use the FoxTools function
        lcWord = WORDNUM( lcSce, lnCnt )
      ENDIF

      *** First, strip off the space marker if we have one
      IF RIGHT( lcWord, 1) = CHR(96)
        llAddMarker = .T.
        lcWord = LEFT( lcWord, LEN(lcWord) - 1)
      ENDIF
      *** And check for any terminating punctuation marks
      lcLastChar = RIGHT( lcWord, 1 )
      IF ISALPHA( lcLastChar ) OR ISDIGIT( lcLastChar )
        *** It's either a letter or number, so do nothing
      ELSE
        *** It's something we don't want here so lose it
        llAddLastChar = .T.
        lcWord = LEFT( lcWord, LEN(lcWord) - 1)
        *** Replace non-printable characters with spaces
        lcLastChar = IIF( ASC( lcLastChar ) < 32, " ", lcLastChar )
      ENDIF
      *** If all we have left is a space - ignore it
      IF ! EMPTY( lcWord )
        *** Is it a specially formatted word?
        IF SEEK( UPPER( lcWord ), 'wordform', 'cwdupper' )
          *** Yep, just use the specified format
          lcWord = ALLTRIM( wordform.cwdformat )
          *** Ensure the first word is capitalized Whatever it is
          IF lnCnt = 1 
            lcWord = UPPER( LEFT( lcWord, 1 )) ;
                   + IIF( LEN( lcWord ) > 1,  SUBSTR( lcWord, 2 ), "" )
          ENDIF         
        ELSE
          *** Just force to simple PROPER() case
          lcWord = PROPER( ALLTRIM( lcWord ))
        ENDIF
      ENDIF
      This.AddToOutPut( lcWord, llAddLastChar, lcLastChar, llAddMarker )
    NEXT
  ENDFUNC

  ********************************************************************
  *** [P] CHECKTERMINALCAPS(): Remove Xxx'S at END of word
  ********************************************************************
  PROTECTED FUNCTION CheckTerminalCaps()
  LOCAL lcSce, lnWordCnt, lnCnt, lcWord, lnAPos
    *** What are we dealing with
    lcSce = ALLTRIM( This.cOutstring )
    *** Get the real Word Count Value
    IF This.nFoxVersion  < 700
      *** Not VFP 7.00 or later, so we need the FoxTools function
      lnWordCnt = WORDS( This.cOutString )
    ELSE
      *** We have VFP 7.00 or later, so we can just use GETWORDCOUNT()
      lnWordCnt = GETWORDCOUNT( This.cOutString )
    ENDIF
    FOR lnCnt = 1 TO lnWordCnt
      *** Use correct function
      IF This.nFoxVersion = 700
        *** Use the VFP 7.00 function
        lcWord = GETWORDNUM( lcSce, lnCnt ) 
      ELSE
        *** Use the FoxTools function
        lcWord = WORDNUM( lcSce, lnCnt )
      ENDIF
      *** Do we have a terminal "'" in this word
      lnAPos = RAT( "'", lcWord )
      *** If so, is it further in than Position 2 
      *** (ie NOT O'xxx or d'xxx or l'xxx)
      IF lnAPos > 2
        LOCAL lnStPos, lcMakeLower, lnReplaceWith
        *** Force everything after the apostrophe to lower case
        lcMakeLower = LOWER( SUBSTR( lcWord, lnAPos + 1 ) )
        *** And re-build the word
        lcReplaceWith = LEFT( lcWord , lnAPos ) + lcMakeLower
        *** Now update the output string
        This.cOutString = STRTRAN( This.cOutString, lcWord, lcReplaceWith )
      ELSE
        IF lnAPos > 0
          *** Is the last letter capitalized?
          IF RIGHT( lcWord, 1 ) = UPPER( RIGHT( lcWord, 1 ))
            LOCAL lnStPos, lcChar, lnLetterPos
            lcChar = LOWER( RIGHT( lcWord, 1 ))
            *** Find out where in the string we are
            lnStPos = AT( lcWord, This.cOutString )
            *** And where the offending letter is
            lnLetterPos = lnStPos + LEN( lcWord ) - 1
            *** Now re-build the Output string
            This.cOutString = LEFT( This.cOutString, lnLetterPos - 1 ) ;
                  + lcChar ;
                  + SUBSTR( This.cOutString, lnLetterPos + 1 ) 
          ENDIF
        ENDIF
      ENDIF      
    NEXT
    RETURN
  ENDFUNC

  ********************************************************************
  *** [P] ADDTOOUTPUT(): Write out the formatted string to the property
  ********************************************************************
  PROTECTED FUNCTION AddToOutPut( tcWord, tlAddLast, tcLast, tlAddMark )
    LOCAL lcWord
    *** Restore the last character if we removed it for the checking
    lcWord = tcWord + IIF( tlAddLast, tcLast, "")
    *** Restore the space marker if we removed it for the checking
    lcWord = lcWord + IIF( tlAddMark, CHR( 96 ), "")
    *** Add the result to the output string property
    This.cOutString = This.cOutString + " " + lcWord
    RETURN
  ENDFUNC

  ********************************************************************
  *** [P] RESTORESPACING(): Restores original spacing of the string
  ********************************************************************
  PROTECTED FUNCTION RestoreSpacing()
  LOCAL lcSce
    *** Strip out all the spaces we inserted
    lcSce = STRTRAN( This.cOutString, " ", "" )
    *** And restore the original spaces
    This.cOutstring = STRTRAN( lcSce, CHR(96), CHR(32) )
    RETURN
  ENDFUNC

  *******************************************************************
  *** [E] DESTROY(): Augmented Destroy Method
  *******************************************************************
  FUNCTION Destroy
    *** Call Environment Reset
    This.ReSetEnv()
  ENDFUNC

  *******************************************************************
  *** [E] RELEASE(): Provide standard 'This.Release()' behavior
  *******************************************************************
  FUNCTION Release
    RELEASE This
  ENDFUNC

  *******************************************************************
  *** [P] SETENV(): Set Properties and Environment
  *******************************************************************
  PROTECTED FUNCTION SetEnv
    LOCAL llRetVal, lcAlias
    *** Check the Version of VFP 
    *** So that we can use VFP 7.0 (it's up to 50% faster than FoxTools)
    *** But not break in VFP 6.0 or earlier versions
    *** Save Error Handler Settings
    This.cErrorWas = ON( 'ERROR' )
    llRetVal = This.CheckFoxVersion()
    IF llRetVal
      *** Force Asserts on in Dev Modes
      IF VERSION(2) # 0
        This.cAssertWas = SET("Asserts")
        SET ASSERTS ON
      ELSE
        This.cAssertWas = ""
      ENDIF
      *** Need to save the current DS and change to our private datasession
      This.nDataSesWas = SET( "DataSession" )
      SET DATASESSION TO This.DataSession
      *** So far so good, try and open the formatting table
      lcAlias = JUSTSTEM( ALLTRIM( This.cTableName ))
      IF ! USED( lcAlias )
        USE (lcAlias) IN 0 AGAIN SHARED
      ENDIF        
      llRetVal = USED( lcAlias )
      IF ! llRetVal
        *** We needed, but couldn't find, the word formatting table 
        ASSERT .F. MESSAGE "Unable to locate Format Definition Table. Cannot proceed with this function"
      ELSE
        *** Set Exact ON for this class - we are in a Private Datasession
        SET EXACT ON
      ENDIF
    ELSE
      *** We needed, but couldn't find, FoxTools
      ASSERT .F. MESSAGE "Unable to locate FoxTools. Cannot proceed with this function"
    ENDIF
    RETURN llRetVal
  ENDFUNC

  *******************************************************************
  *** [P] RESETENV(): Restore Environment settings
  *******************************************************************
  PROTECTED FUNCTION ResetEnv
    LOCAL lcSetWas
    *** Restore Data Session
    IF ! EMPTY( This.nDataSesWas )
      SET DATASESSION TO ( This.nDataSesWas )
    ENDIF
    *** Restore Asserts in Dev Mode
    IF ! EMPTY( This.cAssertWas )
      lcSetWas = This.cAssertWas
      SET Asserts &lcSetWas
    ENDIF
    *** Restore Error Handling
    IF ! EMPTY( This.cErrorWas )
      lcSetWas = This.cErrorWas 
      ON ERROR &lcSetWas
    ENDIF
  ENDFUNC

  ********************************************************************
  *** [P] CHECKFOXVERSION(): Checks version of FoxPro and sets the
  ***            : nFoxVersion Property accordingly
  ********************************************************************
  PROTECTED FUNCTION CheckFoxVersion
    LOCAL llOk, lcErrWas, lnVer
    llOk = .T.
    *** Disable Error handling temporarily
    lcErrWas = ON( 'ERROR' )
    ON ERROR lnVer = 600
    *** Get the fox Version - default to 600 if not supported
    lnVer = VERSION(5)
    IF lnVer < 700
      *** We will FoxTools too, so open it up
      llOk = This.OpenFoxTools()
    ENDIF
    *** Restore Error Handler
    ON ERROR &lcErrWas
    *** Set the FoxPro Version as either 600 or 700
    This.nFoxVersion = IIF( lnVer >= 700, 700, 600 )
    RETURN llOk
  ENDFUNC

  ********************************************************************
  *** [P] OPENFOXTOOLS(): Checks to see if FoxTools is loaded and if
  ***           : not, and it is available, loads it
  ********************************************************************
  PROTECTED FUNCTION OpenFoxTools
  LOCAL llRetVal
    *** Is FoxTools loaded?
    IF "FOXTOOLS" $ UPPER(SET("LIBRARY"))
      llRetVal = .T.
    ELSE
      *** NOTE: Error handling is suppressed in calling method!
      *** Is it available
      IF FILE( 'FoxTools.FLL' )
        *** Try and load it
        SET LIBRARY TO foxtools ADDITIVE
        *** Check we got it now
        IF "FOXTOOLS" $ UPPER(SET("LIBRARY"))
          llRetVal = .T.
        ENDIF
      ENDIF
    ENDIF
    *** Return status of FoxTools
    RETURN llRetVal
  ENDFUNC

ENDDEFINE