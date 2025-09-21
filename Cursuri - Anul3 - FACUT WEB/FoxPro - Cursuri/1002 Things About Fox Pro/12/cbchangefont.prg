****************************************************************************
*
*  PROGRAM NAME: CBChangeFont.prg
*
*  AUTHOR: Richard A. Schummer, January 2000
*
*  COPYRIGHT © 2000   All Rights Reserved.
*     Richard A. Schummer
*     42759 Flis Dr.  
*     Sterling Heights, MI  48314-2850
*     rick@rickschummer.com
*
*     Latest Updates Available: http://rickschummer.com
*
*     Released into public domain for the use by all FoxPro developers
*     around the world!
*
*  SYSTEM: Common Utilities
*
*  PROGRAM DESCRIPTION: 
*     This program changes the font used in the display of the VFP Class 
*     Browser.  This add-in automatically loads when the Class Browser
*     loads.
*
*  CALLED BY: 
*     DO CBChangeFont                   && Registers in Browser.dbf
*     DO CBChangeFont WITH <toBrowser>  && As called from Class Browser
*
*  SAMPLE CALL:
*     DO CBChangeDateFormat
*
*  INPUT PARAMETERS: 
*     toBrowser = Optional parameter, this is the reference to the existing
*                 Class Browser.  If this is not an object reference it
*                 is assumed that the Add-in needs to be registered.
*
*  OUTPUT PARAMETERS:
*     None
* 
*  DATABASES ACCESSED: 
*     None
* 
*  GLOBAL VARIABLES REQUIRED:
*     None
*
*  GLOBAL PROCEDURES REQUIRED:
*     None
* 
*  DEVELOPMENT STANDARDS:
*     Version 3.1 compliant
*  
*  TEST INFORMATION:
*     None
*   
*  SPECIAL REQUIREMENTS/DEVICES:
*     None
*
*  FUTURE ENHANCEMENTS:
*     None
*
*  LANGUAGE/VERSION:
*     Visual FoxPro 6.0 or higher
* 
****************************************************************************
*
*                           C H A N G E    L O G
*
*   Date           Developer          Version           Description
* ----------  ----------------------  -------  -----------------------------
* 01/16/2000  Richard A. Schummer     1.0      Created program 
* --------------------------------------------------------------------------
* 01/22/2000  Richard A. Schummer     1.0      Fixed Addin() method call to 
*                                              register the addin correctly 
* --------------------------------------------------------------------------
* 07/12/2001  Richard A. Schummer     1.0      Updated email and website
* --------------------------------------------------------------------------
*
****************************************************************************
LPARAMETERS toBrowser

LOCAL lcName                           && Name of the Add-in
LOCAL lcComment                        && Comment for the Add-in
LOCAL lnOldSelect                      && Save for reset later

* Self registration if not called form the Class Browser
IF TYPE("toBrowser")= "L"
   lcName    = "Rick Schummer's Font Changer"
   lcComment = "Developed by RAS for online forum discussion and example"
   
   IF TYPE("_oBrowser")= "O"
      * If Class Browser is running, use Addin() method
      _oBrowser.Addin(lcName, STRTRAN(SYS(16),".FXP",".PRG"), "ACTIVATE", , , lcComment)
   ELSE
      * Use the low level access of the Browser registration table
      IF FILE(HOME() + "BROWSER.DBF")
         lnOldSelect = SELECT()

         USE (HOME() + "BROWSER") IN 0 AGAIN SHARED ALIAS curRASDateChanger
         SELECT curRASDateChanger
         LOCATE FOR Type = "ADDIN" AND Name = lcName
          
         IF EOF()
           APPEND BLANK
         ENDIF
         
         * Always replace with the latest information
         REPLACE Platform WITH "WINDOWS", ;
                 Type     WITH "ADDIN", ;
                 Id       WITH "METHOD", ;
                 Name     WITH lcName, ;
                 Method   WITH "ACTIVATE", ;
                 Program  WITH LOWER( STRTRAN( SYS(16), ".FXP", ".PRG")), ;
                 Comment  WITH lcComment
         USE
         
         SELECT (lnOldSelect)
      ELSE
         MESSAGEBOX("Could not find the table " + HOME() + "BROWSER.DBF" + ", please make sure it exists.", ;
                    0 + 48, ;
                    _screen.Caption)
      ENDIF
   ENDIF
   
   RETURN
ELSE
   * Check to see if we really got called from the Class Browser
   IF !PEMSTATUS(toBrowser, "lFileMode", 5)
     RETURN .F.
   ENDIF
   
   * Now change the font
   toBrowser.SetFont("Tahoma", 8)
ENDIF

RETURN

*: EOF :*