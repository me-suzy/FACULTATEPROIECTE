***********************************************************************
* Program....: GenerateHTML
* Author.....: Marcia G. Akins
* Date.......: 13 February 2002
* Notice.....: Copyright (c) 2002 Tightline Computers Inc, All Rights Reserved.
* Compiler...: Visual FoxPro 07.00.0000.9400 for Windows 
* Purpose....: OLE Public class for generating web pages
***********************************************************************
DEFINE CLASS SesGenPage AS Session OLEPUBLIC
	oRender = .NULL.
	oGraph = .NULL.
	cDataDir = ""
	cPath = ""
FUNCTION INIT
	*** Set the default directory
	LOCAL lcProgram, lnStartPos, lnEndPos, lcDefault, lcPath
	*** Get the current path
	lcProgram = SYS( 16 )
	lnStartPos = AT( '\', lcProgram )
	lnEndPos = RAT( '\', lcProgram )

	*** Check to see if we have a drive mapped or if we have a UNC path
	IF SUBSTR( lcProgram, lnStartPos - 1, 1 ) = ":"
		lnStartPos = lnStartPos - 2
	ENDIF
	lnLen = lnEndPos - lnStartPos + 1
	lcDefault = SUBSTR( lcProgram, lnStartPos,lnLen )
  SET DEFAULT TO ( lcDefault )
  IF EMPTY( This.cDataDir )
  		This.cDataDir = lcDefault
  	ENDIF
	*** Create the renderer
	This.oRender = NEWOBJECT( 'Render', 'Render.vcx' )
	*** and the class to generate graphs using the owc
	This.oGraph = NEWOBJECT( 'owcGraph', 'Render.vcx' ) 
ENDFUNC
FUNCTION GenPage( tcAlias )
	LOCAL lcDBC
	*** Make sure the table is open
	IF NOT USED ( tcAlias )
		USE ( This.cDataDir + tcAlias ) AGAIN IN 0
	ENDIF
	*** Set the database if necessary
	lcDBC = CURSORGETPROP( "Database", tcAlias )
	IF NOT EMPTY( lcDBC )
		SET DATABASE TO ( lcDBC )
	ENDIF
	*** Select and position the cursor
	SELECT ( tcAlias )
	GO TOP
	WITH This.oRender
		*** Reset the render object 
		*** in case the cascading style sheet has been modified
		*** so he will re-read it and see the changes
		.Reset()
		*** And set up a pagetitle
		.cPageTitle = 'Fox Rocks!'
		.cPageSubTitle = 'Holy Toledo!'
		*** First set the lister up
		.oLister.cID = tcAlias
		.cBody = .oLister.Execute()
		*** This produces the html 
		lcHTML = .Render()
		RETURN lcHTML
	ENDWITH
ENDFUNC
FUNCTION GenGraph( tcQuery )
LOCAL lcScript, lcHTML
*** Set the required properties on the graph
WITH This.oGraph
	.cQueryName = tcQuery
	lcScript = .CreateGraph()
ENDWITH
*** Merge it with the render's cBody
WITH This.oRender
	*** Reset the render object 
	*** in case the cascading style sheet has been modified
	*** so he will re-read it and see the changes
	.Reset()
	*** And set up a pagetitle
	.cPageTitle = 'Fox Rocks!'
	.cPageSubTitle = 'Using Office Web Components to Display Graphs' 
	*** This produces the html 
	.cBody = lcScript
	lcHTML = .Render()
ENDWITH
RETURN lcHTML
ENDFUNC
FUNCTION Destroy
	This.oRender = .NULL.
	This.oGraph = .NULL.
	CLOSE DATABASES ALL
ENDFUNC
ENDDEFINE
 