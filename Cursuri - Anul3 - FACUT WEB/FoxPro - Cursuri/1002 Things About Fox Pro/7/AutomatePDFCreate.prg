* Create the Crystal Report Object and open a report
loCrystalReports     = CREATEOBJECT("CrystalRuntime.Application")
loReport             = loCrystalReports.OpenReport("GraphExample2.rpt")

* Set the appropriate export options
loExportOptions                 = loReport.ExportOptions
loExportOptions.FormatType      = 31   && crEFTPortableDocFormat
loExportOptions.DestinationType = 1    && crEDTDiskFile
loExportOptions.DiskFileName    = "GraphExample2.pdf"

* Export the file without prompting the user
loReport.Export(.F.)

* Clean up object references
loExportOptions  = .NULL.
loReport         = .NULL.
loCrystalReports = .NULL.

RETURN

*: EOF :*