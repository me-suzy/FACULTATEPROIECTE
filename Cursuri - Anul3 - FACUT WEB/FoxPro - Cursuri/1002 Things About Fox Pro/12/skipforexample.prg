LPARAMETERS txKey

IF VARTYPE(txKey) = "C"
   * Here is where you will lookup some table based
   * on user login id or user login value
   
   * IF FOUND()
   *    glSkipFor = .F.
   * ELSE
   *    glSkipFor = .T.
   * ENDIF
ELSE
   * Handle default setting (likely going to return .F.)
ENDIF

* This example displays the setting of the public variable setting
? "Skip For procedure called with PUBLIC glSkipFor = " + TRANSFORM(glSkipFor)
RETURN glSkipFor

