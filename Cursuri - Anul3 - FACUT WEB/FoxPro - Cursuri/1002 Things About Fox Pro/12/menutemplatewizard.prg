LPARAMETERS tcProjectDir, tcProjectName

LOCAL lcProjectName, ;
      lcMainMenuName

#DEFINE ccMENUFOLDER   "d:\MyFrameWork\Common\Menus\"
#DEFINE ccMAINMENUNAME "MainMenu"
#DEFINE ccMENUTEMPLATE "MainTemplate"

tcProjectDir   = ADDBS(ALLTRIM(tcProjectDir))
tcProjectName  = ALLTRIM(tcProjectName)
lcProjectName  = tcProjectDir + FORCEEXT(tcProjectName, ".pjx")
lcMainMenuName = JUSTSTEM(ccMAINMENUNAME)

CREATE PROJECT (lcProjectName) NOWAIT SAVE NOSHOW NOPROJECTHOOK

IF TYPE("_vfp.ActiveProject") = "O" AND !ISNULL(_vfp.ActiveProject) AND FILE(lcProjectName)
   IF FILE(ccMENUFOLDER + ccMENUTEMPLATE + ".mnx")
      COPY FILE ccMENUFOLDER + ccMENUTEMPLATE + ".mnx" TO lcMainMenuName + ".mnx"
      COPY FILE ccMENUFOLDER + ccMENUTEMPLATE + ".mnt" TO lcMainMenuName + ".mnt"

      * Add Menu
      lcFile = tcProjectDir + "menus\" + lcMainMenuName + ".mnx"
      DO AddFileToProject WITH lcFile
   ELSE
      ? "  Menu Template Files not available for copying at " + TTOC(DATETIME())
   ENDIF
ENDIF

RETURN


PROCEDURE AddFileToProject(tcFileName)

IF FILE(tcFileName)
   _vfp.ActiveProject.Files.Add(tcFileName)
   ? "Added file: " + tcFileName + " at " + TTOC(DATETIME())
ELSE
   ? "  Problem adding file " + tcFileName
ENDIF

RETURN

*: EOF :*