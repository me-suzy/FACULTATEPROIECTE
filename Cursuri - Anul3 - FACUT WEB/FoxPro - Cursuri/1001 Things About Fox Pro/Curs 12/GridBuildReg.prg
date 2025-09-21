**********************************************************************
* Program....: GridBUildReg.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Registers GridBuild.app as the grid builder in VFP
**********************************************************************
CLOSE DATA ALL
CLEAR ALL
USE HOME() + 'wizards\builder' IN 0
LOCATE FOR NAME = 'Industrial Strength Grid Builder'
IF ! FOUND()
	LOCATE FOR NAME = 'Grid Builder'
	SCATTER MEMVAR MEMO
	REPLACE TYPE WITH 'XGRID'
	INSERT INTO BUILDER FROM MEMVAR
	REPLACE NAME WITH 'Industrial Strength Grid Builder', ;
			PROGRAM WITH 'wizards\gridbuild.app', ;
			CLASSLIB WITH 'gridbuild.vcx', ;
			CLASSNAME WITH 'gridbuild'
ENDIF 
WAIT WINDOW 'GridBuild now registered as the Grid Builder'
USE
