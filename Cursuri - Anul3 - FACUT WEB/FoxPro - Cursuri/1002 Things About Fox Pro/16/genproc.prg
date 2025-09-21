*** All purpose procedure file
*!***********************************************
*!
*!      Procedure: EvlTxt
*!
*!***********************************************
PROCEDURE EvlTxt
*  Author............: Ken Levy
*  Version...........: 1.1 Dec 27 1993
*} Project...........: GENSCRNX
*  Created...........: 09/23/93
*  Copyright.........: Public Domain
*) Description.......: PROCEDURE EvlTxt
*)                     Evaluated {{}} within strings

PARAMETERS m.old_text

PRIVATE ;
  m.eval_str1, ;
  m.eval_str2, ;
  m.eval_str, ;
  m.new_text, ;
  m.old_text, ;
  m.var_type
PRIVATE ;
  m.at_pos, ;
  m.at_pos2, ;
  m.at_pos3, ;
  m.at_pos4, ;
  m.at_pos5, ;
  m.new_str, ;
  m.old_Str
PRIVATE ;
  m.at_line, ;
  m.evlmode, ;
  m.I, ;
  m.j, ;
  m.mThd_Str, ;
  m.onError, ;
  m.sellast

IF TYPE( [m.old_text])#[C]
  RETURN m.old_text
ENDIF

m.onError = ON( [ERROR])
m.new_text= m.old_text
m.at_pos3 = 1
DO WHILE .T.
  m.at_pos= AT( [{{], SUBSTR( m.old_text, m.at_pos3))
  IF m.at_pos= 0
    EXIT
  ENDIF
  m.at_pos2= AT( [}}], SUBSTR( m.old_text, m.at_pos+ m.at_pos3-1))
  IF m.at_pos2= 0
    EXIT
  ENDIF
  m.at_pos4= AT( [{{], SUBSTR( m.old_text, m.at_pos+ m.at_pos3+ 1))
  IF m.at_pos4>0.and.m.at_pos4<m.at_pos2
    m.at_pos4= OCCURS( [{{], SUBSTR( m.old_text, m.at_pos+ m.at_pos3-1, ;
      m.at_pos2-m.at_pos4))
    m.at_pos4 = AT( [{{], SUBSTR( m.old_text, m.at_pos+ m.at_pos3-1), m.at_pos4)
    m.old_Str = SUBSTR( m.old_text, m.at_pos+ m.at_pos3-1, m.at_pos2+ 1)
    m.eval_str= SUBSTR( m.old_Str, 3, LEN( m.old_Str)-2)
    m.old_Str = EvlTxt( m.eval_str)
    m.old_text= STRTRAN( m.old_text, m.eval_str, m.old_Str)
    m.new_text= STRTRAN( m.new_text, m.eval_str, m.old_Str)
    LOOP
  ENDIF
  m.old_Str = SUBSTR( m.old_text, m.at_pos+ m.at_pos3-1, m.at_pos2+ 1)
  m.eval_str= ALLTRIM( SUBSTR( m.old_Str, 3, LEN( m.old_Str)-4))

  m.evlmode = .F.

  DO CASE
  CASE EMPTY( m.eval_str)
    m.eval_str= ''
  CASE LEFT( m.eval_str, 2)== [&.]
    m.eval_str= SUBSTR( m.eval_str, 3)
    &eval_str                                       &&;
      --------------------------------------------------------------;
      ERROR ocCured during MACRO substitution OF {{&. <expc> }}.
    m.eval_str= ''
  CASE LEFT( m.eval_str, 1)== [<]
    *[smb]  m.eval_str= INSERT( SUBSTR( m.eval_str, 2))     &&;
--------------------------------------------------------------;
ERROR ocCured during evaluation OF {{< <FILE> }}.
  OTHERWISE
    *** MGA changed on 02/08/2001 ADDED SUPPORT FOR NULLS
    m.eval_str= NVL( EVALUATE( m.eval_str), '' )               &&;
      --------------------------------------------------------------;
      ERROR occured during evaluation OF {{ <expc> }}.
  ENDCASE
  IF EMPTY( m.onError)
    ON ERROR
  ELSE
    ON ERROR &onError
  ENDIF
  m.var_type= TYPE( [m.eval_str])
  DO CASE
  CASE m.var_type== [C]
    m.new_str= m.eval_str
  CASE m.var_type== [N]
    m.new_str= ALLTRIM( STR( m.eval_str, 24, 12))
    DO WHILE RIGHT( m.new_str, 1)== [0]
      m.new_str= LEFT( m.new_str, LEN( m.new_str)-1)
      IF RIGHT( m.new_str, 1)== [.]
        m.new_str= LEFT( m.new_str, LEN( m.new_str)-1)
        EXIT
      ENDIF
    ENDDO
  CASE m.var_type== [D]
    m.new_str= DTOC( m.eval_str)
  CASE m.var_type== [T]
    m.new_str= TTOC( m.eval_str)
  CASE m.var_type== [D]
    m.new_str= TTOC( m.eval_str)
  CASE m.var_type== [L]
    m.new_str= IIF( m.eval_str, [.T.], [.F.])
  OTHERWISE
    m.new_str= m.old_Str
  ENDCASE
  m.new_text= STRTRAN( m.new_text, m.old_Str, m.new_str)
  m.at_pos2 = m.at_pos+ LEN( m.new_str)
  IF m.at_pos2<= 0
    EXIT
  ENDIF
  m.at_pos3= m.at_pos3+ m.at_pos2
ENDDO
m.j= 0
DO WHILE [{{]$m.new_text.and.[}}]$m.new_text
  m.I       = LEN( m.new_text)
  m.new_text= EvlTxt( m.new_text)
  IF m.I= LEN( m.new_text)
    IF m.j>= 2
      EXIT
    ENDIF
    m.j= m.j+ 1
  ENDIF
ENDDO
RETURN m.new_text

************************************************************************
FUNCTION GetProperty( tcProperty, tcPropertyText)
************************************************************************
* Returns a property form a properties memo
LOCAL lcRetVal, lnAtPos, lcLine
lcRetVal= ""
DO WHILE " ="$ tcPropertyText
  tcPropertyText= STRTRAN( tcPropertyText, " =", "=" )
ENDDO
DO CASE
CASE EMPTY( tcProperty ) OR EMPTY( tcPropertyText )
  *-- Do nothing

OTHERWISE
  lnAtPos= ATC( tcProperty + "=", tcPropertyText )
  IF lnAtPos> 0
    lcLine= MLINE( tcPropertyText, 1, lnAtPos )
    lcRetVal= ALLTRIM(SUBS( lcLine, AT( "=", lcLine ) + 1 ) )
  ENDIF
ENDCASE
RETURN lcRetVal
