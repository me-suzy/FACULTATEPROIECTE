**********************************************************************
* Program....: ChgArea.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Illustrate the use of the SELALIAS class for controlling
* ...........: and changing Work Areas. Output results to screen
**********************************************************************
*** Make sure we are all closed up
CLEAR
CLOSE TABLES ALL
*** Open Clients table
USE sqlcli ORDER 1 IN 0
? 'Using Selector with Just an Alias'
? '================================='
?
? "USE sqlcli ORDER 1 IN 0"
? "Area:" + PADL(SELECT(),2) + " Using Table " + JUSTSTEM(DBF()) + " as Alias " + ALIAS()
?
*** Create a Client Selection Object
loSelCli = NEWOBJECT( 'xSelAlias',  'SelAlias.prg', NULL, 'SqlCli' )
? "loSelCli = NEWOBJECT( 'xSelAlias',  'SelAlias.prg', NULL, 'SqlCli' )"
? "Area:" + PADL(SELECT(),2) + " Using Table " + JUSTSTEM(DBF()) + " as Alias " + ALIAS()
?
*** Open Invoices Table (temporarily)
loSelInv = NEWOBJECT( 'xSelAlias',  'SelAlias.prg', NULL, 'SqlInv' )
? "loSelInv = NEWOBJECT( 'xSelAlias',  'SelAlias.prg', NULL, 'SqlInv' )"
? "Area:" + PADL(SELECT(),2) + " Using Table " + JUSTSTEM(DBF()) + " as Alias " + ALIAS()
?
*** Now close the Invoices table by releasing the object
RELEASE loSelInv
? "RELEASE loSelInv"
? "USED( 'SqlInv' ) => " + IIF( USED( 'SqlInv' ), "Still In Use", "Not Open" )
?
*** Now releaswe the Client table object
RELEASE loSelCli
? "RELEASE loSelCli"
? "USED( 'SqlCli' ) => " + IIF( USED( 'SqlCli' ), "Still In Use", "Not Open" )
? 
? "Area:" + PADL(SELECT(),2) + " Using Table " + JUSTSTEM(DBF()) + " as Alias " + ALIAS()
?
? "Press a key to clear the screen and continue..."
INKEY(0, 'hm' )
CLEAR

? 'Using Selector to create an Alias'
? '================================='
?
? "Area:" + PADL(SELECT(),2) + " Using Table " + JUSTSTEM(DBF()) + " as Alias " + ALIAS()
?
*** Open Clients Again under new Alias
loSelCli = NEWOBJECT( 'xSelAlias',  'SelAlias.prg', NULL, 'Clients', 'SqlCli' )
? "loSelCli = NEWOBJECT( 'xSelAlias',  'SelAlias.prg', NULL, 'Clients', 'SqlCli' )"
? "Area:" + PADL(SELECT(),2) + " Using Table " + JUSTSTEM(DBF()) + " as Alias " + ALIAS()
?
*** Open Invoices Table (temporarily)
loSelInv = NEWOBJECT( 'xSelAlias',  'SelAlias.prg', NULL, 'Invoices', 'SqlInv' )
? "loSelInv = NEWOBJECT( 'xSelAlias',  'SelAlias.prg', NULL, 'Invoices', 'SqlInv' )"
? "Area:" + PADL(SELECT(),2) + " Using Table " + JUSTSTEM(DBF()) + " as Alias " + ALIAS()
?
*** Now close the Invoices table by releasing the object
RELEASE loSelInv
? "RELEASE loSelInv"
? "USED( 'Invoices' ) => " + IIF( USED( 'Invoices' ), "Still In Use", "Not Open" )
?
*** Now releaswe the Client table object
RELEASE loSelCli
? "RELEASE loSelCli"
? "USED( 'Clients' ) => " + IIF( USED( 'Clients' ), "Still In Use", "Not Open" )
? 
? "Area:" + PADL(SELECT(),2) + " Using Table " + JUSTSTEM(DBF()) + " as Alias " + ALIAS()
?
? "Press a key to clear the screen and finish..."
INKEY(0, 'hm' )
CLEAR 
