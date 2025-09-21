****************************************************************************
*  PROGRAM NAME: GenProjectFile.prg
*
*  AUTHOR: Richard A. Schummer
*
*  COPYRIGHT © 1999   All Rights Reserved.
*     Kirtland Associates, Inc.
*     1152 E. Big Beaver Rd.
*     Troy,  MI  48083
*
*  SYSTEM: Kirtland Associates Application Wizard
*
*  PROGRAM DESCRIPTION: 
*     This program builds a project file and adds all the generated
*     programs, menus, etc.
*
*  PARAMETERS:
*     CALLING SYNTAX: 
*        DO GenProjectFile.prg with <tcProjPrefix>, ; 
*                                   <tcProjectDir>, ;
*                                   <tcBusinessGroupDir>, ;
*                                   <tcSystem>, ;
*                                   <tcProjectHook>
*
*     INPUT PARAMETERS: (all optional)
*        tcProjPrefix       = Character, 2 character project prefix
*        tcProjectDir       = Character, project level directory
*        tcBusinessGroupDir = Character, business group directory
*        tcSystem           = Character, name of the application
*        tcProjectHook      = Character, name of the projecthook class
*
*     OUTPUT PARAMETERS:
*        None
* 
*     SAMPLE CALL:
*        DO GenProjClasses.prg with "CP", "N:\Cust1Proj1\", "K:\BGCust\, "New App", "phkCust"
*
*  DATABASE TABLES ACCESSED: 
*     None
*
*  FREE TABLES ACCESSED: 
*     None
* 
*  DEVELOPMENT STANDARDS:
*     Version 1.1 compliant
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
*   Date      Dev  System                      WO/Description
* ----------  ---  -------  ------------------------------------------------ 
* 03/19/1999  RAS  DevTool  Create program
* -------------------------------------------------------------------------- 
* 07/19/1999  RAS  DevTool  Added Stonefield Query files
* -------------------------------------------------------------------------- 
* 09/27/1999  RAS  DevTool  Added the Config.fpw & ReadMe.txt files
* -------------------------------------------------------------------------- 
* 09/27/1999  RAS  DevTool  Removed project's TestConvert, Conversion classes
* -------------------------------------------------------------------------- 
* 09/30/1999  RAS  DevTool  Added the new database directory capability
* ----------------------------------------------------------------------------
* 10/05/1999  RAS  DevTool  Added the projecthook addition
* ----------------------------------------------------------------------------
****************************************************************************
lparameters tcProjPrefix, tcProjectDir, tcBusinessGroupDir, tcSystem, tcProjectHook

#define ccPROJECTHOOKSLIB  "k:\vfpaddon\rasprojecthooks\cProjectHooks.vcx"
#define ccSYNTAX           "do GenProjectFile with tcProjPrefix, tcProjectDir, tcBusinessGroupDir, tcSystem, tcProjectHook"

local lcOldSafety                      && Save Safety setting
local lcOldAlternate                   && Save Alternate setting
local lcOldAlternateFile               && Save Alternate,1 setting
local lcProjectName                    && Actual project name generated
local lcDatabaseDir                    && Database directory

if vartype(tcProjPrefix) != "C" or empty(tcProjPrefix)
   messagebox(program() + " - project prefix parameter is not a character string or empty, please correct." + ;
              replicate(chr(10),2) + ;
              ccSYNTAX, ;
              0 + 16, ;
              _screen.Caption)
   return .F.
endif

if vartype(tcProjectDir) != "C" or empty(tcProjectDir)
   messagebox(program() + " - project directory parameter is not a character string or empty, please correct." + ;
              replicate(chr(10),2) + ;
              ccSYNTAX, ;
              0 + 16, ;
              _screen.Caption)
   return .F.
endif

if vartype(tcBusinessGroupDir) != "C" or empty(tcBusinessGroupDir)
   messagebox(program() + " - project business group parameter is not a character string or empty, please correct." + ;
              replicate(chr(10),2) + ;
              ccSYNTAX, ;
              0 + 16, ;
              _screen.Caption)
   return .F.
endif

if vartype(tcSystem) != "C" or empty(tcSystem)
   messagebox(program() + " - project system name parameter is not a character string or empty, please correct." + ;
              replicate(chr(10),2) + ;
              ccSYNTAX, ;
              0 + 16, ;
              _screen.Caption)
   return .F.
endif

if vartype(tcProjectHook) != "C" or empty(tcProjectHook)
   messagebox(program() + " - project projecthook parameter is not a character string or empty, please correct." + ;
              replicate(chr(10),2) + ;
              ccSYNTAX, ;
              0 + 16, ;
              _screen.Caption)
   return .F.
endif

lcOldSafety        = set("safety")
lcOldAlternate     = set("alternate")  
lcOldAlternateFile = set("alternate",1)
lcProjectName      = alltrim(tcProjectDir) + alltrim(tcProjPrefix) + ".pjx"
lcDatabaseDir      = "data\"

set safety off

set alternate to fullpath(curdir()) + "GenProjectFile.txt" additive
set alternate on

create project (lcProjectName) nowait save noshow noprojecthook


if type("_vfp.ActiveProject") = "O" and !isnull(_vfp.ActiveProject) and file(lcProjectName)
   ? "Project file created " + lcProjectName + " at " + ttoc(datetime())
   
   with _vfp.ActiveProject
      * Set some of the Build Version information
      .HomeDir            = tcProjectDir
      .AutoIncrement      = .T.
      .Debug              = .T.
      .VersionNumber      = "1.0.0"
      .VersionComments    = "Visual FoxPro Application"
      .VersionCompany     = "Kirtland Associates, Inc"
      .VersionDescription = ""
      .VersionCopyright   = alltrim(str(year(date())))
      .VersionTrademarks  = ""
      .VersionProduct     = alltrim(tcSystem)
      .VersionLanguage    = "English"
      
      * RAS 05-Oct-1999 Added the projecthook connection.
      * They must be in this order, library first, class second
      * otherwise a dialog is displayed and the wizard crashes
      .ProjectHookLibrary = ccPROJECTHOOKSLIB
      .ProjectHookClass   = alltrim(tcProjectHook)
      
      * The main program needs to be added first to become the SET MAIN for the project
      lcFile = tcProjectDir + "programs\" + tcProjPrefix + "Main.prg"
      do AddFileToProject with lcFile
      
      * Add one of the VMP Programs so that all the VMP files will come from VMP directory
      * and not one of the legacy directory on the local workstation
      lcFile = "K:\VMP4\Xlib\X3GenPk.prg"
      do AddFileToProject with lcFile
      
      * Add the third party spell checker to the list since it is a unique directory
      lcFile = "K:\VfpAddon\FoxSpell\FS_Spell.prg"
      do AddFileToProject with lcFile

      * Add all the class libraries
      lnProgCount   = adir(laPrgFiles, "K:\KALib\Programs\*.prg")

      for lnCount = 1 to lnProgCount
         lcFile = "K:\KALib\Programs\" + laPrgFiles[lnCount,1]
         do AddFileToProject with lcFile
      endfor
      
      * Add Menu
      lcFile = tcProjectDir + "menus\" + tcProjPrefix + "Main.mnx"
      do AddFileToProject with lcFile
      
      lcFile = "K:\KALib\Menus\SpellCheck.mnx"
      do AddFileToProject with lcFile

      * Add database container
      lcFile = tcProjectDir + lcDatabaseDir + tcProjPrefix + ".dbc"
      do AddFileToProject with lcFile

      * Add some free tables
      lcFile = tcProjectDir + "system\" + tcProjPrefix + "config.dbf"
      do AddFileToProject with lcFile
      
      lcFile = tcProjectDir + "system\" + tcProjPrefix + "usyssi.dbf"
      do AddFileToProject with lcFile
      
      lcFile = tcProjectDir + "msgsvc.dbf"
      do AddFileToProject with lcFile
      
      lcFile = tcProjectDir + "strings.dbf"
      do AddFileToProject with lcFile
      
      lcFile = tcProjectDir + "system\" + "words1.dbf"
      do AddFileToProject with lcFile
      
      lcFile = tcProjectDir + "system\" + "words2.dbf"
      do AddFileToProject with lcFile
      
      lcFile = tcProjectDir + "system\" + "words3.dbf"
      do AddFileToProject with lcFile
      
      * Add one MaxFrame level class library so the rest are found
      lcFile = "K:\VMP4\XLib\XXFw.vcx"
      do AddFileToProject with lcFile
      
      * Add one Kirtland level class library so the rest are found
      lcFile = "K:\KALib\Libs\KAFw.vcx"
      do AddFileToProject with lcFile
      
      * Add all the business group class libraries
      lnLibCount   = adir(laBGLibFiles, tcBusinessGroupDir + "libs\*.vcx")

      for lnCount = 1 to lnLibCount
         lcFile = tcBusinessGroupDir + "libs\" + laBGLibFiles[lnCount,1]
         do AddFileToProject with lcFile
      endfor
      
      * Add all the project specific class libraries
      lnLibCount   = adir(laPjLibFiles, tcProjectDir + "libs\*.vcx")

      for lnCount = 1 to lnLibCount
         lcFile = tcProjectDir + "libs\" + laPjLibFiles[lnCount,1]
         do AddFileToProject with lcFile
      endfor

      * Add the Stonefield Database Toolkit classes
      lcFile = "K:\VfpAddon\Stonefield\SDT\Source\DbcxMgr.vcx"
      do AddFileToProject with lcFile

      lcFile = "K:\VfpAddon\Stonefield\SDT\Source\SDT.vcx"
      do AddFileToProject with lcFile
      
      * RAS 19-Jul-1999 Added SFQ files
      * Add the Stonefield Query classes
      lcFile = "K:\VfpAddon\Stonefield\SfQuery\SFQuery.vcx"
      do AddFileToProject with lcFile

      lcFile = "K:\VfpAddon\Stonefield\SfQuery\Filter.ico"
      do AddFileToProject with lcFile

      lcFile = "K:\VfpAddon\Stonefield\SfQuery\SFQuery.mnx"
      do AddFileToProject with lcFile

      lcFile = "K:\VfpAddon\Stonefield\SfQuery\MakeObject.prg"
      do AddFileToProject with lcFile

      lcFile = "K:\VfpAddon\Stonefield\SfCommon\SFCtrls.vcx"
      do AddFileToProject with lcFile

      lcFile = "K:\VfpAddon\Stonefield\SfCommon\SFCollection.vcx"
      do AddFileToProject with lcFile
      
      * RAS 27-Sep-1999 Added the Config.fpw template
      lcFile = tcProjectDir + "text\" + "Config.fpw"
      do AddFileToProject with lcFile
      
      * Make sure the Config file is included
      _vfp.ActiveProject.Files("Config.fpw").Exclude = .F.
      
      * RAS 27-Sep-1999 Added the ReadMe.txt template
      lcFile = tcProjectDir + "text\" + "ReadMe.txt"
      do AddFileToProject with lcFile
      
      * Make sure the Config file is included
      _vfp.ActiveProject.Files("ReadMe.txt").Exclude = .T.
      
      * RAS 27-Sep-1999 Remove the TestConvert program which is not needed
      * by the application.  This remove 2 other classes which 
      * are not needed as well.
      _vfp.ActiveProject.Files("TestConvert.prg").Remove()     
      _vfp.ActiveProject.Files("BGConvrt.vcx").Remove()     
      _vfp.ActiveProject.Files(tcProjPrefix + "Convrt.vcx").Remove()     

      * Build the project using the Rebuild option to pull in the rest of the project files
      llBuildResult = .Build(1)
      ? "The result from the build was: " + transform(llBuildResult) + " at " + ttoc(datetime())

      * Done, output a completion message   
      ? replicate("*", 3) + space(1) + "Completed at " + ttoc(datetime())
      
      .Visible = .T.  
   endwith
else
   ? "Project file creation failed for " + lcProjectName + " at " + ttoc(datetime())  
endif

* Close the log
set alternate off
set alternate to

* Reset to the original settings
set alternate to &lcOldAlternateFile
set alternate &lcOldAlternate

set safety on

return .T.


****************************************************************************
*  PROCEDURE NAME: AddFileToProject
*
*  PROCEDURE DESCRIPTION:
*     This routine uses the Project Object to add the passed file to the
*     project.
*
*  PARAMETERS:
*     INPUT PARAMETERS:
*        tcFileName = Required, name of the file added to the project, needs
*                     the full path and the extension for the project object
*                     to add the file.
*
*     OUTPUT PARAMETERS:
*        None
****************************************************************************
procedure AddFileToProject (tcFileName)

if file(tcFileName)
   _vfp.ActiveProject.Files.Add(tcFileName)
   ? "Added file: " + tcFileName + " at " + ttoc(datetime())
else
   ? "  Problem adding file " + tcFileName
endif
      
return

*: EOF :*