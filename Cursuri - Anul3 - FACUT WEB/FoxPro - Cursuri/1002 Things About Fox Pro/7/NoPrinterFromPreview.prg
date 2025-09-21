LOCAL lcOldResource, ;
      lcOriginalResourceFile, ;
      lcReportsResourceFile

lcReportsResourceFile  = "ReportsFoxUser.dbf"
lcOldResource          = SET("Resource")
lcOriginalResourceFile = SYS(2005)

SET RESOURCE ON
SET RESOURCE TO (lcReportsResourceFile)

* Make sure data is prepared
REPORT FORM WaterMarkDemo PREVIEW

SET RESOURCE TO (lcOriginalResourceFile)
SET RESOURCE &lcOldResource

RETURN

*: EOF :*