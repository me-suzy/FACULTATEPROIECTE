*************************************************************************
* Program....: DemoIsRunning.prg
* Compiler...: Visual FoxPro 06.00.8492.00 for Windows
* Abstract...: Demonstantion on how to use the IsRunning function to
*............: return an array of all running applications and convert the
*............: array to a cursor so you can browse the results
*************************************************************************
LOCAL loApps, laApps[ 1 ]

*** Get the parameters object containing all running apps

loApps = IsRunning()

IF ALEN( loApps.aParameters ) = 0
	*** Nothing running except for VFP
	*** Might as well demo MsgBeep her too <g>
	MsgBeep( 64 )
	MESSAGEBOX( 'VFP is the only application running', 64, 'Return from IsRunning' )
ELSE
	ACOPY( loApps.aParameters, laApps )
	ArToCurs( @laApps, 'RunningApps' )
	SELECT RunningApps
	BROW
ENDIF
USE IN RunningApps
	