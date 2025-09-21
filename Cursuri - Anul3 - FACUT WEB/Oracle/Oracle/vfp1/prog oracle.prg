LOCAL nrConexiune, vSucces
nrConexiune=SQLCONNECT("conexiune_BDstud")
IF nrConexiune < 1 
MESSAGEBOX("Probleme la conectare!")
RETURN
ENDIF
v_sal=111111
vSucces=SQLEXEC(nrConexiune,;
"UPDATE Personal set salorar=?v_sal where marca=1001")
IF vSucces>0 
**SELECT cPersonal
**BROWSE
ELSE
MESSAGEBOX("N-am obtinut cursor...!");

endif


