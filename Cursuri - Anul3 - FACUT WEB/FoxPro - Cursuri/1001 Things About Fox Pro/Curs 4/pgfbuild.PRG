LPARAMETERS tuParam1, tuParam2, tuParam3
LOCAL lnCnt, loPage

*** This defines the Location of the Class Library containing your Page Class 
*** Which will be auto-inserted into the PageFrame which contain an object of Class
*** Page, (i.e. a default VFP Page
#DEFINE	LOC_CLASSLIB	"Ch04.prg"

*** Did we have something selected?
IF ASELOBJ(aObj)=0
	MESSAGEBOX( 'Please Select A PageFrame & Re Run This Builder!' )
	RETURN
ENDIF

*** Create the cursor which will be used to populate the Pageframe
*** This cursor will have one row per page of the pageframe
*** You can (obviously) choose anything you like here, simply 
*** Change this definition and the following FOR...NEXT Loop
CREATE CURSOR curPages (;
	Name       C( 10), ;
	Caption    C( 40) )
														
*** Pick up the (relevant) existing properties for each page
FOR lnCnt = 1 TO aObj[1].PageCount
	INSERT INTO curPages VALUES ( ;
			ALLTRIM(aObj[1].Pages[lnCnt].Name), ;
			ALLTRIM(aObj[1].Pages[lnCnt].Caption) )
ENDFOR

*** Now Edit the cursor to set all the properties
GO TOP
BROWSE NORMAL

*** If Esc - confirm discard
IF LASTKEY()=27 AND MESSAGEBOX( 'Discard Changes ?', 4+32 ) = 6  && yes
	WAIT WINDOW NOWAIT "Discarded..."
	IF USED('curPages')
		USE IN curPages
	ENDIF
	RETURN
ENDIF

*** Remove base class pages and add our custom pages
aObj[1].PageCount = 0

*** Now use the Cursor to update the pages
lnCnt = 1
SCAN
	*** Find classlib
	SET PROC TO LOC_CLASSLIB ADDITIVE
	*** Add new one
	aObj[1].AddObject( 'PgBase'+ALLTRIM( STR( lnCnt ) ), 'PgBase' )
	aObj[1].PageCount = lnCnt
	IF aObj[1].Pages[lnCnt].Caption # ALLTRIM(Caption)
		aObj[1].Pages[lnCnt].Caption = ALLTRIM(Caption)
	ENDIF
	IF aObj[1].Pages[lnCnt].Name # Name
		aObj[1].Pages[lnCnt].Name = "Pg"+ALLTRIM(name)
	ENDIF
	lnCnt = lnCnt + 1
ENDSCAN

aObj[1].ActivePage = 1

IF USED('curPages')
	USE IN curPages
ENDIF
