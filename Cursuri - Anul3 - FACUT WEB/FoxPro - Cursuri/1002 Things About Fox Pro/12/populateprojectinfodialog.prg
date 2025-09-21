****************************************************************************
*
*  PROGRAM NAME: PopulateProjectInfoDialog.prg
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
*     This program changes the author information via the Project Info dialog
*
*  CALLED BY: 
*     DO PopulateProjectInfoDialog.prg
*
*  INPUT PARAMETERS: 
*     None
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
* 01/10/2002  Richard A. Schummer     1.0      Created program 
* --------------------------------------------------------------------------
*
****************************************************************************

IF TYPE("_vfp.ActiveProject") = "O"
   IF WONTOP(_vfp.ActiveProject.Name)
      * Everything is ready, project is most active window
   ELSE
      * ACTIVATE WINDOW (JUSTFNAME(_vfp.ActiveProject.Name))
      ACTIVATE WINDOW ("Project Manager")
   ENDIF
ELSE
   RETURN
ENDIF

* Cannot automate the project menu since it is not a system menu
* The shortcut to the Project Info dialog is Ctrl+J, plus since 
* the dialog opens on the page tab, you need to tab to the first
* textbox.
KEYBOARD '{CTRL + J}'
KEYBOARD '{TAB}'

* Author
KEYBOARD 'Richard A. Schummer'
KEYBOARD '{TAB}'

* Company
KEYBOARD 'Geeks and Gurus, Inc.'
KEYBOARD '{TAB}'

* Company
KEYBOARD '5296 Harvard'
KEYBOARD '{TAB}'

* City
KEYBOARD 'Detroit'
KEYBOARD '{TAB}'

* State
KEYBOARD 'MI'
KEYBOARD '{TAB}'

* Country
KEYBOARD 'USA'
KEYBOARD '{TAB}'

* Postal Code
KEYBOARD '48224'
KEYBOARD '{TAB}'

RETURN


