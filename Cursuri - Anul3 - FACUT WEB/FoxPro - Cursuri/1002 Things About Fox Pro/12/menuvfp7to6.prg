****************************************************************************
*
*  PROGRAM NAME: MenuVFP7to6.prg
*
*  AUTHOR: Richard A. Schummer, January 2002
*
*  COPYRIGHT © 2002   All Rights Reserved.
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
*     Originally written as a sample for MegaFox: 1002 Things You Wanted 
*                                                 To Know About Extending VFP
*
*  SYSTEM: Common Utilities
*
*  PROGRAM DESCRIPTION: 
*     This program strips the VFP 7 menu columns for icon information so the
*     menu can be opened and modified in prior versions of VFP. You can pass the
*     menu filename. If you do not, you will be prompted to pick a menu.
*
*  CALLED BY: 
*     DO MenuVFP7to6.prg with [<tcMenu>]
*
*  INPUT PARAMETERS: 
*     tcMenu = Character, not required, if passed should be a menu file (MNX)
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
* 01/15/2002  Richard A. Schummer     1.0      Created program 
* --------------------------------------------------------------------------
*
****************************************************************************
LPARAMETERS tcMenu

LOCAL llReturnVal

llReturnVal = .T.

DO CASE 
   CASE PCOUNT() < 1
      tcMenu = GETFILE("mnx")

      IF EMPTY(tcMenu)
         llReturnVal = .F.
      ENDIF
   CASE VARTYPE(tcMenu) # "C"
      MESSAGEBOX("Menu file name parameter is not a character, please try again.", ;
                 0 + 16, _screen.Caption)
      llReturnVal = .F.
ENDCASE

IF llReturnVal
   tcMenu  = FORCEEXT(tcMenu, "mnx")

   IF FILE(tcMenu)
      lcAlias = JUSTSTEM(tcMenu)

      * Handle possible spaces in file name
      lcAlias = STRTRAN(lcAlias, SPACE(1), "_")

      USE (tcMenu) EXCLUSIVE IN 0

      * Make sure the menu is opened (not in used by another)
      IF USED(lcAlias)
         * Make sure the menu is from VFP 7 or later
         IF FCOUNT(lcAlias) > 23
            ALTER TABLE (tcMenu) DROP COLUMN SysRes
            ALTER TABLE (tcMenu) DROP COLUMN ResName
         ENDIF 
      ELSE
         MESSAGEBOX("Could not open the menu, please try again.", ;
                    0 + 16, _screen.Caption)
         llReturnVal = .F.
      ENDIF

      USE IN (SELECT(lcAlias))
   ELSE
      MESSAGEBOX("Menu file provided does not exist, please try again.", ;
                 0 + 16, _screen.Caption)
      llReturnVal = .F.
   ENDIF
ENDIF

RETURN llReturnVal

*: EOF :*