goErrLog = NEWOBJECT( 'xErrLog', 'errorlog.prg', NULL)
ON ERROR GoErrLog.LogError( SET("DATASESSION"), PROGRAM(), LINENO() )
use sqlinv
APPEND BLANK
REPLACE invdate WITH date()
REPLACE fred with 'something'
ON ERROR
