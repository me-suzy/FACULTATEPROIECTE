**********************************************************************
* Program....: SQLShow.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Illustrate the use of VFP ShowPlan reporting

*** Enable Showplan reporting
SYS(3054,1)		&& Actually returns "1" indicating Level 1 reporting is enabled

*** Disable screen and direct output to file
SET CONSOLE OFF
SET ALTERNATE TO showplan.txt
SET ALTERNATE ON
*** We need deleted ON to see the results
lcOldDel = SET( 'DELETED')
SET DELETED ON

*** Execute the query
SELECT CL.cliname, CO.consname ;
  FROM sqlcli CL ;
    JOIN sqlcon CO ON CO.clikey = CL.clisid ;
    ORDER BY cliname, consname ;
  INTO CURSOR ijoin

*** Restore settings
SET CONSOLE ON
SET ALTERNATE OFF
SET ALTERNATE TO
SET DELETED &lcOldDel

*** Turn off showplan reporting
SYS(3054,0)
