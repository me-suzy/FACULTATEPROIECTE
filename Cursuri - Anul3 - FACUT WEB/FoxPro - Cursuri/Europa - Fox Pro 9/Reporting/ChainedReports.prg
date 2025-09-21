*This demonstrates how reports can be chained in the preview now.

#define ListenerPrint	0
#define ListenerPreview	1
#define ListenerXML		4
#define ListenerHTML	5

 
rep1 = GETFILE("FRX", "Pick the first report")
rep2 = GETFILE("FRX", "Pick the second report")

*See how the range is now respected by the preview: 
REPORT FORM (Rep1)  RANGE 1,4 	OBJECT TYPE ListenerPreview	NOPAGEEJECT 
REPORT FORM (Rep2)  RANGE 1,4 	OBJECT TYPE ListenerPreview	NORESET 

