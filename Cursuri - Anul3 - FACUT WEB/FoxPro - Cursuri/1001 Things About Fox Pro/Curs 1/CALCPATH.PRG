*** CALCPATH
*** Automatically sets the path to include VFP Home directory 
FUNCTION CalcPath()
LOCAL lcSys16, lcProgram, lcPath, lcOldDir
  *** Get the name of program that called this one.
  lcSys16 = SYS(16, 1)
  *** Save current working directory
  lcOldDir = (SYS(5)+CURDIR())
  *** Make the directory from which it was run current
  lcProgram = SUBSTR(lcSys16, AT(":", lcSys16) - 1)
  CD LEFT(lcProgram, RAT("\", lcProgram))
  IF INLIST( JUSTEXT( lcProgram ), "FXP", "SCX" )
    *** If we are running a PRG/Form directly, then find the parent directory
    CD ..
    *** Set up path to include VFP Home plus the standard DEV directory tree
    lcPath = (HOME()+';'+SYS(5)+CURDIR()+";DATA;FORMS;LIBS;PROGS;UTILS")
  ELSE
    *** We are using an EXE/APP! Adjust path for DISTRIBUTION directory tree
    lcPath = (HOME()+';'+SYS(5)+CURDIR()+";DATA")
  ENDIF
  *** Restore original directory
  CD (lcOldDir)
  *** Return the calculated path
  RETURN lcPath
ENDFUNC
