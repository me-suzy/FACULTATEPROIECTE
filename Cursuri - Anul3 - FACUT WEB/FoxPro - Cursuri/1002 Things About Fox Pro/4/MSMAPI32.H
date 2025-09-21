
*** Constant Group: DeleteConstants
#define mapMessageDelete                                  0
#define mapRecipientDelete                                1
#define mapAttachmentDelete                               2

*** Constant Group: MessagesActionConstants
#define mapFetch                                          1
#define mapSendDialog                                     2
#define mapSend                                           3
#define mapSave                                           4
#define mapCopy                                           5
#define mapCompose                                        6
#define mapReply                                          7
#define mapReplyAll                                       8
#define mapForward                                        9
#define mapDelete                                         10
#define mapShowAddressBook                                11
#define mapShowRecipDetails                               12
#define mapResolveName                                    13
#define mapDeleteRecip                                    14
#define mapDeleteAttachment                               15

*** Constant Group: MAPIErrors
#define mapSuccessSuccess                                 32000
#define mapUserAbort                                      32001
#define mapFailure                                        32002
#define mapLoginFail                                      32003
#define mapDiskFull                                       32004
#define mapInsufficientMem                                32005
#define mapAccessDenied                                   32006
#define mapGeneralFailure                                 32007
#define mapTooManySessions                                32008
#define mapTooManyFiles                                   32009
#define mapTooManyRecipients                              32010
#define mapAttachmentNotFound                             32011
#define mapAttachmentOpenFailure                          32012
#define mapAttachmentWriteFailure                         32013
#define mapUnknownRecipient                               32014
#define mapBadRecipType                                   32015
#define mapNoMessages                                     32016
#define mapInvalidMessage                                 32017
#define mapTextTooLarge                                   32018
#define mapInvalidSession                                 32019
#define mapTypeNotSupported                               32020
#define mapAmbiguousRecipient                             32021
#define mapMessageInUse                                   32022
#define mapNetworkFailure                                 32023
#define mapInvalidEditFields                              32024
#define mapInvalidRecips                                  32025
#define mapNotSupported                                   32026
#define mapSessionExist                                   32050
#define mapInvalidBuffer                                  32051
#define mapInvalidReadBufferAction                        32052
#define mapNoSession                                      32053
#define mapInvalidRecipient                               32054
#define mapInvalidComposeBufferAction                     32055
#define mapControlFailure                                 32056
#define mapNoRecipients                                   32057
#define mapNoAttachment                                   32058

*** Constant Group: ErrorConstants
#define mpeOutOfMemory                                    7
#define mpeErrorLoadingMAPI                               48
#define mpeInvalidPropertyValue                           380
#define mpeInvalidPropertyArrayIndex                      381
#define mpeSetNotSupported                                383
#define mpeGetNotSupported                                394
#define mpeUserCancelled                                  32001
#define mpeUnspecifiedFailure                             32002
#define mpeLoginFailed                                    32003
#define mpeDiskFull                                       32004
#define mpeInsufficientMemory                             32005
#define mpeAccessDenied                                   32006
#define mpeMAPIFailure                                    32007
#define mpeTooManySessions                                32008
#define mpeTooManyFiles                                   32009
#define mpeTooManyRecipients                              32010
#define mpeAttachmentNotFound                             32011
#define mpeFailedOpeningAttachment                        32012
#define mpeFailedWritingAttachment                        32013
#define mpeUnknownRecipient                               32014
#define mpeInvalidRecipientType                           32015
#define mpeNoMessages                                     32016
#define mpeInvalidMessage                                 32017
#define mpeTextTooLarge                                   32018
#define mpeInvalidSession                                 32019
#define mpeTypeNotSupported                               32020
#define mpeAmbiguousRecipient                             32021
#define mpeMessageInUse                                   32022
#define mpeNetworkFailure                                 32023
#define mpeInvalidEditFields                              32024
#define mpeInvalidRecipients                              32025
#define mpeNotSupported                                   32026
#define mpeUserAbortedAction                              32027
#define mpeMAPIMissing                                    32048
#define mpeLogonFailure                                   32050
#define mpePropertyIsReadOnly                             32051
#define mpeInvalidAction                                  32052
#define mpeNoValidSessionID                               32053
#define mpeNoOriginator                                   32054
#define mpeActionNotValid                                 32055
#define mpeNoMessageList                                  32056
#define mpeNoRecipients                                   32057
#define mpeNoAttachments                                  32058

*** Constant Group: RecipTypeConstants
#define mapOrigList                                       0
#define mapToList                                         1
#define mapCcList                                         2
#define mapBccList                                        3

*** Constant Group: AttachTypeConstants
#define mapData                                           0
#define mapEOLE                                           1
#define mapSOLE                                           2

*** Constant Group: SessionActionConstants
#define mapSignOn                                         1
#define mapSignOff                                        2
