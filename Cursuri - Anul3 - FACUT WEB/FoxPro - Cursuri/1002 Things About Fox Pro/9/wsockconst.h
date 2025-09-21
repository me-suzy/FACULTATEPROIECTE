*** Constant Group: ProtocolConstants
#define sckTCPProtocol                                    0
#define sckUDPProtocol                                    1

*** Constant Group: StateConstants
#define sckClosed                                         0
#define sckOpen                                           1
#define sckListening                                      2
#define sckConnectionPending                              3
#define sckResolvingHost                                  4
#define sckHostResolved                                   5
#define sckConnecting                                     6
#define sckConnected                                      7
#define sckClosing                                        8
#define sckError                                          9

*** Constant Group: ErrorConstants
#define sckInvalidPropertyValue                           380
#define sckGetNotSupported                                394
#define sckSetNotSupported                                383
#define sckOutOfMemory                                    7
#define sckBadState                                       40006
#define sckInvalidArg                                     40014
#define sckSuccess                                        40017
#define sckUnsupported                                    40018
#define sckInvalidOp                                      40020
#define sckOutOfRange                                     40021
#define sckWrongProtocol                                  40026
#define sckOpCanceled                                     10004
#define sckInvalidArgument                                10014
#define sckWouldBlock                                     10035
#define sckInProgress                                     10036
#define sckAlreadyComplete                                10037
#define sckNotSocket                                      10038
#define sckMsgTooBig                                      10040
#define sckPortNotSupported                               10043
#define sckAddressInUse                                   10048
#define sckAddressNotAvailable                            10049
#define sckNetworkSubsystemFailed                         10050
#define sckNetworkUnreachable                             10051
#define sckNetReset                                       10052
#define sckConnectAborted                                 10053
#define sckConnectionReset                                10054
#define sckNoBufferSpace                                  10055
#define sckAlreadyConnected                               10056
#define sckNotConnected                                   10057
#define sckSocketShutdown                                 10058
#define sckTimedout                                       10060
#define sckConnectionRefused                              10061
#define sckNotInitialized                                 10093
#define sckHostNotFound                                   11001
#define sckHostNotFoundTryAgain                           11002
#define sckNonRecoverableError                            11003
#define sckNoData                                         11004
