****************************************************************************
*
*  PROGRAM NAME: CpModulePerformanceReg.prg
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
*  SYSTEM: Coverage Profiler Add-in
*
*  PROGRAM DESCRIPTION: 
*     This program registers the CP Module Performance Analyzer and 
*     adds a button to the Coverage Profiler toolbar.
*
*  CALLED BY: 
*     Press the Add-in button on the Coverage Profiler and select this
*     program to be run.
*
*  INPUT PARAMETERS: 
*     toCoverage = Required parameter, this is the reference to the existing
*                  Coverage Profiler.  
*
*  OUTPUT PARAMETERS:
*     None
* 
*  DATABASES ACCESSED: 
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
* 01/19/2002  Richard A. Schummer     1.0      Created program 
* --------------------------------------------------------------------------
*
****************************************************************************

LPARAMETERS toCoverage

LOCAL llReturnVal, ;
      loControl

* Check to verify that we have a Coverage Profiler session 
* calling this form.
IF VARTYPE(toCoverage) # "O" OR TYPE("toCoverage.cAppName") # "C"
   MESSAGEBOX("You need to be running the VFP Coverage Profiler " + ;
              "for this program to be effective.", ;
              0 + 16, ;
              _screen.Caption)
   llReturnVal = .F.
ELSE
   llReturnVal = .T.

   * Loop through all Coverage profiler toolbar controls to see if the 
   * cmdModPerformanceButton is already instantiated. We do not want
   * more than once instance of this control registered.

   FOR EACH loControl IN toCoverage.frmMainDialog.cntTools.Controls
     IF LOWER(loControl.Class) == "cmdmodperformancebutton"
        WAIT WINDOW "Module Performance Button already loaded!" NOWAIT
        llReturnVal = .F.
        EXIT
     ENDIF
   ENDFOR

   IF llReturnVal
      * Button is not on Coverage Profiler, so we add it.
      toCoverage.frmMainDialog.AddTool("cmdModPerformanceButton")
   ENDIF
ENDIF

RETURN llReturnVal


DEFINE CLASS cmdModPerformanceButton AS cmdCoverageToolButton
*  This button subclass is of the CoverageToolButton Class
*  (see below)
   Caption     = "MP"
   ToolTipText = "Module Performance Analyzer Add-in"
   AutoSize    = .F.
   Width       = 22
   Height      = 23

   PROCEDURE Init
      IF VERSION(5) > 600
         this.SpecialEffect = 2
      ENDIF
   ENDPROC

   PROCEDURE Click
      thisformset.RunAddIn('CpModulePerformance.scx')
   ENDPROC

ENDDEFINE


DEFINE CLASS cmdCoverageToolButton AS CommandButton
* This base class is borrowed directly from Lisa Slater Nichols.
* It integrates the button into the toolbar in an appropriate fashion.
* This class also includes basic error handling as built into the 
* Cov_standard class.

   lError   = .F.
   AutoSize = .T.                      && Text will fit automatically

   PROCEDURE Init
   * Use some formset properties to make the new tool "fit in"

      WITH thisformset
         this.FontName   = .cBaseFontName
         this.FontItalic = .lBaseFontItalic
         this.FontBold   = .lBaseFontBold
         this.FontSize   = .nBaseFontSize
      ENDWITH

      * Now use the container's physical properties
      * to fit in there as well:
      THIS.Autosize = .F.

      WITH THISFORMSET.frmMainDialog.cntTools
         THIS.Top = .Controls(1).Top
         THIS.Height = .Controls(1).Height
      ENDWITH 

   RETURN (NOT THIS.lError)

   PROCEDURE Error(tnError, tcMethod, tnLine)
   * Designed to use the FormSet's error method which, in in this 
   * case does nothing more than put up an error MessageBox.  

      THIS.lError = .T.

      IF TYPE("thisformset.BaseClass") = "C"
         thisformset.Error(tnError, this.Name + ":" + tcMethod, tnLine)
      ELSE
         ERROR tnError
      ENDIF

   ENDPROC
ENDDEFINE

*: EOF :*