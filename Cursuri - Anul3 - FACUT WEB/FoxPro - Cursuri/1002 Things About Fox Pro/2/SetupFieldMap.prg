******************************************************************************************
*** Program: SetupFieldMap.prg
*** Written by Marcia G. Akins 
*** Abstract: Set up the field map table to migrate the customer table in the Tastrade database
*** Compiler: Visual FoxPro 07.00.0000.9262 for Windows
*****************************************************************************************
LOCAL lcDBC

*** Get the path to the tastrade data
*** and open the dbc as a table
lcDBC = ADDBS( _SAMPLES ) + "DATA\Testdata.dbc"
USE ( lcDBC ) 

USE FieldMap IN 0

*** Now fill all the source table and source field fields in the field map
*** with the field names in the customer table
LOCATE FOR ObjectName = 'customer' AND ObjectType = 'Table'
IF FOUND()
  lcParentID = ObjectID
  lcTableName = ObjectName
  SELECT ObjectName FROM ( lcDBC ) ;
    WHERE ParentID = lcParentID AND ObjectType = 'Field' ;
    INTO CURSOR Temp
  SCAN
    INSERT INTO FieldMap ( cSourceTbl, cSourceFld ) ;
      VALUES ( lcTableName, Temp.ObjectName )
   ENDSCAN
ENDIF
