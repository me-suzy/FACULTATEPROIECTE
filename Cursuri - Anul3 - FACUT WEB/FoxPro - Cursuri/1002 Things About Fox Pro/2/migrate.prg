******************************************************************************************
*** Program: Migrate.prg
*** Written by Marcia G. Akins 
*** Abstract: How to use a field mapping table to drive data migrations
*** Compiler: Visual FoxPro 07.00.0000.9262 for Windows
*****************************************************************************************
LOCAL lcSourceTable, lcTargetTbl, luValue, lcType, lcSource, lcProcName
PRIVATE poName

*** Create our name object so that it can hold the various components of the name
*** as we parse them out
poName = NEWOBJECT( 'Line' )
poName.AddProperty( 'cFirst', '' )
poName.AddProperty( 'cLast', '' )

*** Migrate the customer table in the Tastrade sample database into a more
*** normalized structure where contacts and phone numbers are moved to a 
*** separate table
CLOSE DATABASES ALL

*** Get the path to the tastrade data
lcSourceTable = ADDBS( _SAMPLES ) + "DATA\Customer.dbf"
USE ( lcSourceTable ) IN 0

*** Get the lookups for phone types and contact
*** types into separate cursors from the
*** lookup header and detail tables
SELECT ildPK iPhoneTypePK, cldDesc cPhoneType ;
	 FROM LookupDtl JOIN LookupHdr ON iLhFK = iLhPK ;
	 	WHERE UPPER( ALLTRIM( cLhDesc ) ) = 'PHONE TYPES' ;
			INTO CURSOR PhoneTypes
INDEX ON UPPER( cPhoneType ) TAG cPhoneType

SELECT ildPK iContactTypePK, cldDesc cContactType ;
	 FROM LookupDtl JOIN LookupHdr ON iLhFK = iLhPK ;
	 	WHERE UPPER( ALLTRIM( cLhDesc ) ) = 'CONTACT TYPES' ;
			INTO CURSOR ContactTypes
INDEX ON UPPER( cContactType ) TAG cConType

*** Open the field map table and ensure that it is in the correct order
USE FieldMap IN 0 ORDER TAG cProcName

*** Get the names of all the target tables from the field map
SELECT DISTINCT cTargetTbl FROM FieldMap INTO CURSOR Temp

*** And make sure they are all open
IF _TALLY > 0
	SCAN
		USE ( ALLTRIM( Temp.cTargetTbl ) ) IN 0
	ENDSCAN
ELSE
	*** Nothing to do. No Source data to migrate
	MESSAGEBOX( 'There is no target data in the field map table', 48, 'Nothing to do' )
	RETURN
ENDIF

*** Since this is a very simple migration, we do not need
*** to process the data in a specific order (i.e,; there is no process
*** that must be complete before we can start the next one).
*** We can let the field map do all the work
SELECT Customer
SCAN
	*** Re-initialize the parsed name object
	WITH poName
		.cFirst = ''
		.cLast = ''
	ENDWITH
	
	*** Apply the rules in the field map table to each record in the customer table
	*** to convert it
	SELECT FieldMap
	SCAN
		lcSource = ALLTRIM( FieldMap.cSourceTbl )	+ '.'+ALLTRIM( FieldMap.cSourceFld )
		*** First see if we need to insert a new record in the target table
		*** If we do, FieldMap.lCreateNew will be true
		IF FieldMap.lCreateNew
			*** This code is here because in this migration
			*** we do not want to create phone records if there
			*** is no telephone number present. So the fieldmap
			*** record that creats the new record in the table
			*** points to the required piece of info in the source data
			IF NOT EMPTY( EVALUATE( lcSource ) )
				APPEND BLANK IN ( ALLTRIM( FieldMap.cTargetTbl ) )
			ELSE
				*** Skip over the rest of the records for this migration process
				lcProcName = FieldMap.cProcName
				DO WHILE FieldMap.cProcName == lcProcName AND NOT EOF()
					SKIP 
				ENDDO
				*** We went 1 record too far: Jump back Jack!
				SKIP -1
				*** And perform the next migration process
				LOOP
			ENDIF
		ENDIF
		*** Find out if the current value is an expression, a constant, or a field in a table
		*** and process it appropriately
		DO CASE
			CASE NOT EMPTY( FieldMap.mRuleText )
				*** Evaluate the rule text field as the value into the target table
				luValue = EVAL( ALLTRIM( FieldMap.mRuleText ) )

			CASE NOT EMPTY( FieldMap.cConstant ) 
				*** Make certain that whatever we have to move to the target table is of the correct
				*** Data type so find out what it should be
				lcType = TYPE( ALLTRIM( FieldMap.cTargetTbl ) + '.' + ALLTRIM( FieldMap.cTargetFld ) )
				*** And Convert it
				luValue = Str2Exp( ALLTRIM( FieldMap.cConstant ), lcType )

			OTHERWISE
				*** It is a field from the specified source table
				luValue = EVAL( lcSource )
		ENDCASE
		
		*** And replace the specified field in the target table
		REPLACE ( ALLTRIM( FieldMap.cTargetFld ) ) WITH luValue IN ( ALLTRIM( FieldMap.cTargetTbl ) )
	ENDSCAN 	&& FieldMap (to process a single record in the source file)
ENDSCAN	&& Source table

*******************************************************************************************
FUNCTION Str2Exp( tcString, tcType )
*******************************************************************************************
LOCAL luExp
*** Convert from CHARACTER TO THE SPECIFIED DATA TYPE
DO CASE
	CASE tcType $ 'IN' 		&& integer, numeric
		luExp = VAL(tcString)
	CASE tcType = 'Y' 		&& currency
		luExp = NTOM(VAL(tcString))
	CASE tcType = 'D' 		&& date/datetime
		luExp = CTOD(tcString)
	CASE tcType = 'L'  		&& logical
		luExp = IIF(tcString = 'T',.T.,.F.)
	CASE tcType = 'T' 		&& date/datetime
		luExp = CTOT(tcString)
	CASE tcType $ 'CM'  	&& character, memo
		luExp = tcString
	CASE tcType = 'U'
		luExp = .NULL.	
	OTHERWISE
		*** There is NO otherwise!
ENDCASE
*** Return the character string as the designated expresssion
RETURN luExp

ENDFUNC

***************************************************************************
FUNCTION GetFirstName( tcName )
***************************************************************************
*** Before we can return the First Name
*** We have to call the name parser to parse the entire name
ParseName( tcName )

RETURN poName.cFirst

ENDFUNC

***************************************************************************
FUNCTION ParseName( tcName )
***************************************************************************
*** In the Tastrade sample data it is easy
*** because all of the contacts have only a first name and a last name
*** it is usually not so simple
poName.cFirst = GETWORDNUM( tcName, 1 )
poName.cLast = GETWORDNUM( tcName, 2 )

ENDFUNC
