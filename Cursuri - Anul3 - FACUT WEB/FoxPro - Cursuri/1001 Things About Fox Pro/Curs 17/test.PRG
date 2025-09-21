LPARAMETER tnTimeStamp, tcStyle

LOCAL lcRetVal                   &&  Requested data returned from procedure

IF TYPE('tnTimeStamp') != "N"    &&  Timestamp must be numeric
   WAIT WINDOW "Time stamp passed is not numeric"
   RETURN ""
ENDIF 

IF tnTimeStamp = 0               &&  Timestamp is zero until built in project
   RETURN "Not built into App"
ENDIF

IF TYPE('tcStyle') != "C"        &&  Default return style to both date and time
   tcStyle = "DATETIME"
ENDIF

IF !INLIST(UPPER(tcStyle), "DATE", "TIME", "DATETIME")
   WAIT WINDOW "Style parameter must be DATE, TIME, or DATETIME"
   RETURN ""
ENDIF

lnYear   = ((tnTimeStamp/(2**25) + 1980))
lnMonth  = ((lnYear-INT(lnYear)    )*(2**25))/(2**21)
lnDay    = ((lnMonth-INT(lnMonth)  )*(2**21))/(2**16)

lnHour   = ((lnDay-INT(lnDay)      )*(2**16))/(2**11)
lnMinute = ((lnHour-INT(lnHour)    )*(2**11))/(2**05)

&&  Multiply by two to correct truncation problem built in
&& to the creation algorithm (Source: Microsoft Tech Support)
lnSecond = ((lnMinute-INT(lnMinute))*(2**05))*2

lcRetVal = ""
    
IF "DATE" $ UPPER(tcStyle) 
   lcRetVal = lcRetVal + RIGHT("0"+ALLTRIM(STR(INT(lnMonth))),2) + "/" + ;
                         RIGHT("0"+ALLTRIM(STR(INT(lnDay))),2)   + "/" + ;
                         RIGHT("0"+ALLTRIM(STR(INT(lnYear))),2)
ENDIF
   
IF "TIME" $ UPPER(tcStyle)
   lcRetVal = lcRetVal + IIF("DATE" $ UPPER(tcStyle), " ", "")
   lcRetVal = lcRetVal + RIGHT("0"+ALLTRIM(STR(INT(lnHour))),2)   + ":" + ;
                         RIGHT("0"+ALLTRIM(STR(INT(lnMinute))),2) + ":" + ;
                         RIGHT("0"+ALLTRIM(STR(INT(lnSecond))),2)
ENDIF

RETURN lcRetVal
