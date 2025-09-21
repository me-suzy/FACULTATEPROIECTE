*This is how you can easily go to HTML using the built in XBase HTML Listener.
*The HTML Listener is in the REPORTOUTPUT.APP which needs to be in _ReportOutput.

*The HTML Listener uses the XML Listener, then performs and XSLT transformation to
*get the result


#DEFINE DebugListener -2
#DEFINE PrintListener 0
#DEFINE PreviewListener 1
#DEFINE XMLListener 5
#DEFINE HTMLListener 5

REPORT FORM ? OBJECT TYPE HTMLListener
