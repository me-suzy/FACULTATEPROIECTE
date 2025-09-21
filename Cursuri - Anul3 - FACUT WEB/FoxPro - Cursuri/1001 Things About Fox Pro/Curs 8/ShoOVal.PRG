**********************************************************************
* Program....: ShoOVal.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Illustrates problem with using OldVal() to revert field
* ...........: which is used in a Candidate key
* ...........: Ref: MS Knowledgebase PSS ID Number: Q157405
**********************************************************************
*** Create and populate a sample table
CREATE TABLE sample ( Field1 C(5) UNIQUE, Field2 N(2) )
INSERT INTO sample ( Field1, Field2 ) VALUES ( "one  ", 1 )
INSERT INTO sample ( Field1, Field2 ) VALUES ( "two  ", 2 )
INSERT INTO sample ( Field1, Field2 ) VALUES ( "three", 3 )
*** Force into Table Buffered mode 
SET MULTILOCK ON
CURSORSETPROP( "Buffering", 5 )

*** FIRST THE PROBLEM
*** Change key field
GO TOP
REPLACE field1 WITH "four", field2 WITH 4
SKIP
SKIP -1
*** Revert value using OldVal()
REPLACE field1 WITH OLDVAL( "Field1" )
SKIP
SKIP -1
*** You now get a "Uniqueness of index FIELD1 is violated" error message
*** Click IGNORE and revert the table - loses changes in all fields!
TableRevert(.T.)

*** NOW THE SOLUTION
*** Repeat the Replace
GO TOP
REPLACE field1 WITH "four", field2 WITH 4
SKIP
SKIP -1
*** Scatter the fields to an Object
SCATTER NAME loReverter
*** Revert the Key Field value
loReverter.Field1 = OLDVAL( 'Field1' )
*** Revert the row in the table
TableRevert(.F.)
*** Gather values back
GATHER NAME loReverter
SKIP
SKIP-1
*** NOTE: No error, and the change in Field2 is retained
*** Confirm the reversion
TableUpdate(1)
BROW NOWAIT