***********************************************************************
* Program....: TCPClient.prg
* Date.......: 11 January 2002
* Compiler...: Visual FoxPro 07.00.0000.9465 for Windows 
* Purpose....: TCP/IP Client Class
***********************************************************************
DEFINE CLASS xTCPClient AS CUSTOM
  cServer  = LOWER( LEFT( SYS(0), AT( "#", SYS(0)  ) - 1 ) ) && Local machine name
  nRemPort = 1001 && Default port to use
  oConnect = NULL
  
  ********************************************************************
  *** [E] INIT(): Initialize Connection properties when instantiated
  ********************************************************************
  FUNCTION Init( tcServer, tnRemPort )
  LOCAL lcServer, lnRemPort
    WITH This
      *** Default to local machine name if nothing specified
      .cServer = IIF( EMPTY( tcServer ), .cServer, tcServer )
      *** Remote Port ID defaults to 1001
      .nRemPort = IIF( EMPTY( tnRemPort ), .nRemPort, tnRemPort )
      *** Create the Connection object
      .oConnect = CREATEOBJECT( "MSWinsock.WinSock" )
    ENDWITH
  ENDFUNC

  ********************************************************************
  *** [E] POSTDATA(): Transmit data to Server
  ********************************************************************
  FUNCTION PostData( tcData )
    LOCAL lnCnt, lnState, llSend, llTxOK
    *** Must ensure that the connection is closed before setting host
    This.CloseConnection()
    WITH This.oConnect
      *** Set server parameters
      .RemoteHost = This.cServer
      .RemotePort = This.nRemport
      ***************************************************************
      *** TIMING BUG HERE!
      *** 
      *** When running both Client and Server on the same machine, you 
      *** will need a SET STOP ON before the call to Connect() otherwise
      *** the connection will fail. Uncomment the next line in this case
      *!*  SET STEP ON
      *** This is ONLY needed when both client and server are on the 
      *** same machine, and you only need to step over the actual method call
      *** Hit "resume" immediately after and all is well. 
      *** This is a truly WEIRD one!
      ***
      ***************************************************************
      *** And initiate the connection
      .Connect()
      *** Poll status for connection
      lnCnt = 1
      DO WHILE .T.
        lnState = .State
        *** Allow some time to connect before checking
        INKEY(0.3,'hm')
        *** If we are connected, get out now
        IF lnState = 7
          llSend = .T.
          EXIT
        ENDIF
        lnCnt = lnCnt + 1
        *** Break out if we get to 100, otherwise we're stuck forever
        IF lnCnt > 100
          EXIT
        ENDIF
        DOEVENTS()        
      ENDDO
      *** If we got a connection, send the data
      IF llSend
        .SendData( tcData )
        llTxOK = .T.
      ENDIF
    ENDWITH
    RETURN llTxOK
  ENDFUNC

  ********************************************************************
  *** [E] CLOSECONNECTION(): Close an open connection
  ********************************************************************
  FUNCTION CloseConnection()
    IF VARTYPE( This.oConnect ) = "O"
      WITH This.oConnect
        IF .State # 0
          *** Close the connection
          .Close()
        ENDIF
      ENDWITH
    ENDIF
  ENDFUNC

  ********************************************************************
  *** [E] DESTROY(): Ensure connection is closed before releasing
  ********************************************************************
  FUNCTION Destroy()
    This.CloseConnection()
    *** Release the object
    This.oConnect = NULL
  ENDFUNC

ENDDEFINE
