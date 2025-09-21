********************************************************************************
* 2_EventBinding_UnBindEvent.prg
* Description:	This program will show how you can unbind an event using the 
*				UnBindEvent function.  When the Class Browser is closed then the
*				binding of the Resize event is removed.
* Tip:	When unbinding events, you can remove all events associated with a class
*		or specific events.
********************************************************************************
#DEFINE CRLF CHR(13)+CHR(10)

LOCAL lcStr as String
PUBLIC oHandler

* Create an instance of a class that will handle the repositioning of the Class
* Browser.
oHandler=NEWOBJECT("MyHandler")

* Run the Class Browser.
DO (_browser)

* Bind the VFP Desktop's Resize event to the oHandler object's MyResize method.
BINDEVENT(_SCREEN,"Resize",oHandler,"MyResize")

* Bind the Class Browser's UnLoad event to remove of all events handled by
* oHandler object.
BINDEVENT(_obrowser,"UnLoad",oHandler,"MyUnLoad")

lcStr = "The Class Browser is repositioned to the right side of the Visual" + ;
		" FoxPro desktop, regardless of how the desktop is resized. The" + ;
		" BindEvent method associates the Resize event of the _SCREEN system" + ;
		" variable, or Visual FoxPro desktop, with a class which has a method" + ;
		" used as its delegate. The code in the method runs when the Resize" + ;
		" event is triggered."
MESSAGEBOX(lcStr)

RETURN

* The class that will handle the repositioning of the Class Browser.
DEFINE CLASS MyHandler AS Session
   
   PROCEDURE MyResize
   		* Check to see if the Class Browser window has been closed.
   		IF ISNULL(_obrowser) THEN
        	* If the Class Browser has been closed then unbind the event.
        	UNBINDEVENT(_SCREEN,"Resize",oHandler,"MyResize")
      	ELSE
         	* Reposition the Class Browser to the right side of the VFP Desktop.
         	_obrowser.left = _SCREEN.Width - _obrowser.width
      	ENDIF
   		RETURN
   	ENDPROC
   	
   PROCEDURE MyUnLoad
   		* Class Browser window is being unloaded so the UnBindEvent is called to
   		* remove all events associated with this class.
       	UNBINDEVENT(THIS)
       	
		lcStr = "The event handler has been removed."
		MESSAGEBOX(lcStr)
		
   		RETURN
   	ENDPROC
ENDDEFINE
