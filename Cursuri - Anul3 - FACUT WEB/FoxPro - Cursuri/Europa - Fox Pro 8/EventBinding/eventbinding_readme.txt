Visual FoxPro 8.0 extended the event handling support to also include native Visual FoxPro objects.  This project demonstrates how to use these new functions.

EventBinding.pjx is a project that contains 3 different examples on how to use event binding in your applications.

1_EventBinding_BindEvent : 
This program will show how you can keep the Class Browser positioned to the right side of the Visual FoxPro desktop, regardless of how the desktop is resized.  When the Class Browser is closed then the binding of the Resize event is removed.

2_EventBinding_UnBindEvent : 
This program will show how you can unbind an event using the UnBindEvent function.  When the Class Browser is closed then the binding of the Resize event is removed.

3_EventBinding_RaiseEvent : 
This program will show how you can raise an event from a custom method by using the RaiseEvent function.  The sample will show how to write an entry in a log file every time a report is printed.

4_EventBinding_Forms : 
This program will show how you can bind the AfterRowColChange event of a grid to another form to refresh the associated child data for the current record.