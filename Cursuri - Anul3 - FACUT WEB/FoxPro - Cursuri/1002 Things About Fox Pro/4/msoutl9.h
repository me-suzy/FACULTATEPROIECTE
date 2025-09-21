
*** Constant Group: OlActionCopyLike
#define olReply                                           0
#define olReplyAll                                        1
#define olForward                                         2
#define olReplyFolder                                     3
#define olRespond                                         4

*** Constant Group: OlActionReplyStyle
#define olOmitOriginalText                                0
#define olEmbedOriginalItem                               1
#define olIncludeOriginalText                             2
#define olIndentOriginalText                              3
#define olLinkOriginalItem                                4
#define olUserPreference                                  5
#define olReplyTickOriginalText                           1000

*** Constant Group: OlActionResponseStyle
#define olOpen                                            0
#define olSend                                            1
#define olPrompt                                          2

*** Constant Group: OlActionShowOn
#define olDontShow                                        0
#define olMenu                                            1
#define olMenuAndToolbar                                  2

*** Constant Group: OlAttachmentType
#define olByValue                                         1
#define olByReference                                     4
#define olEmbeddeditem                                    5
#define olOLE                                             6

*** Constant Group: OlBusyStatus
#define olFree                                            0
#define olTentative                                       1
#define olBusy                                            2
#define olOutOfOffice                                     3

*** Constant Group: OlDaysOfWeek
#define olSunday                                          1
#define olMonday                                          2
#define olTuesday                                         4
#define olWednesday                                       8
#define olThursday                                        16
#define olFriday                                          32
#define olSaturday                                        64

*** Constant Group: OlDefaultFolders
#define olFolderDeletedItems                              3
#define olFolderOutbox                                    4
#define olFolderSentMail                                  5
#define olFolderInbox                                     6
#define olFolderCalendar                                  9
#define olFolderContacts                                  10
#define olFolderJournal                                   11
#define olFolderNotes                                     12
#define olFolderTasks                                     13
#define olFolderDrafts                                    16

*** Constant Group: OlDisplayType
#define olUser                                            0
#define olDistList                                        1
#define olForum                                           2
#define olAgent                                           3
#define olOrganization                                    4
#define olPrivateDistList                                 5
#define olRemoteUser                                      6

*** Constant Group: OlEditorType
#define olEditorText                                      1
#define olEditorHTML                                      2
#define olEditorRTF                                       3
#define olEditorWord                                      4

*** Constant Group: OlFlagStatus
#define olNoFlag                                          0
#define olFlagComplete                                    1
#define olFlagMarked                                      2

*** Constant Group: OlFolderDisplayMode
#define olFolderDisplayNormal                             0
#define olFolderDisplayFolderOnly                         1
#define olFolderDisplayNoNavigation                       2

*** Constant Group: OlFormRegistry
#define olDefaultRegistry                                 0
#define olPersonalRegistry                                2
#define olFolderRegistry                                  3
#define olOrganizationRegistry                            4

*** Constant Group: OlGender
#define olUnspecified                                     0
#define olFemale                                          1
#define olMale                                            2

*** Constant Group: OlImportance
#define olImportanceLow                                   0
#define olImportanceNormal                                1
#define olImportanceHigh                                  2

*** Constant Group: OlInspectorClose
#define olSave                                            0
#define olDiscard                                         1
#define olPromptForSave                                   2

*** Constant Group: OlItemType
#define olMailItem                                        0
#define olAppointmentItem                                 1
#define olContactItem                                     2
#define olTaskItem                                        3
#define olJournalItem                                     4
#define olNoteItem                                        5
#define olPostItem                                        6
#define olDistributionListItem                            7

*** Constant Group: OlJournalRecipientType
#define olAssociatedContact                               1

*** Constant Group: OlMailingAddress
#define olNone                                            0
#define olHome                                            1
#define olBusiness                                        2
#define olOther                                           3

*** Constant Group: OlMailRecipientType
#define olOriginator                                      0
#define olTo                                              1
#define olCC                                              2
#define olBCC                                             3

*** Constant Group: OlMeetingRecipientType
#define olOrganizer                                       0
#define olRequired                                        1
#define olOptional                                        2
#define olResource                                        3

*** Constant Group: OlMeetingResponse
#define olMeetingTentative                                2
#define olMeetingAccepted                                 3
#define olMeetingDeclined                                 4

*** Constant Group: OlMeetingStatus
#define olNonMeeting                                      0
#define olMeeting                                         1
#define olMeetingReceived                                 3
#define olMeetingCanceled                                 5

*** Constant Group: OlNetMeetingType
#define olNetMeeting                                      0
#define olNetShow                                         1
#define olChat                                            2

*** Constant Group: OlNoteColor
#define olBlue                                            0
#define olGreen                                           1
#define olPink                                            2
#define olYellow                                          3
#define olWhite                                           4

*** Constant Group: OlObjectClass
#define olApplication                                     0
#define olNamespace                                       1
#define olFolder                                          2
#define olRecipient                                       4
#define olAttachment                                      5
#define olAddressList                                     7
#define olAddressEntry                                    8
#define olFolders                                         15
#define olItems                                           16
#define olRecipients                                      17
#define olAttachments                                     18
#define olAddressLists                                    20
#define olAddressEntries                                  21
#define olAppointment                                     26
#define olMeetingRequest                                  53
#define olMeetingCancellation                             54
#define olMeetingResponseNegative                         55
#define olMeetingResponsePositive                         56
#define olMeetingResponseTentative                        57
#define olRecurrencePattern                               28
#define olExceptions                                      29
#define olException                                       30
#define olAction                                          32
#define olActions                                         33
#define olExplorer                                        34
#define olInspector                                       35
#define olPages                                           36
#define olFormDescription                                 37
#define olUserProperties                                  38
#define olUserProperty                                    39
#define olContact                                         40
#define olDocument                                        41
#define olJournal                                         42
#define olMail                                            43
#define olNote                                            44
#define olPost                                            45
#define olReport                                          46
#define olRemote                                          47
#define olTask                                            48
#define olTaskRequest                                     49
#define olTaskRequestUpdate                               50
#define olTaskRequestAccept                               51
#define olTaskRequestDecline                              52
#define olExplorers                                       60
#define olInspectors                                      61
#define olPanes                                           62
#define olOutlookBarPane                                  63
#define olOutlookBarStorage                               64
#define olOutlookBarGroups                                65
#define olOutlookBarGroup                                 66
#define olOutlookBarShortcuts                             67
#define olOutlookBarShortcut                              68
#define olDistributionList                                69
#define olPropertyPageSite                                70
#define olPropertyPages                                   71
#define olSyncObject                                      72
#define olSyncObjects                                     73
#define olSelection                                       74
#define olLink                                            75
#define olLinks                                           76

*** Constant Group: OlOutlookBarViewType
#define olLargeIcon                                       0
#define olSmallIcon                                       1

*** Constant Group: OlPane
#define olOutlookBar                                      1
#define olFolderList                                      2
#define olPreview                                         3

*** Constant Group: OlRecurrenceState
#define olApptNotRecurring                                0
#define olApptMaster                                      1
#define olApptOccurrence                                  2
#define olApptException                                   3

*** Constant Group: OlRecurrenceType
#define olRecursDaily                                     0
#define olRecursWeekly                                    1
#define olRecursMonthly                                   2
#define olRecursMonthNth                                  3
#define olRecursYearly                                    5
#define olRecursYearNth                                   6

*** Constant Group: OlRemoteStatus
#define olRemoteStatusNone                                0
#define olUnMarked                                        1
#define olMarkedForDownload                               2
#define olMarkedForCopy                                   3
#define olMarkedForDelete                                 4

*** Constant Group: OlResponseStatus
#define olResponseNone                                    0
#define olResponseOrganized                               1
#define olResponseTentative                               2
#define olResponseAccepted                                3
#define olResponseDeclined                                4
#define olResponseNotResponded                            5

*** Constant Group: OlSaveAsType
#define olTXT                                             0
#define olRTF                                             1
#define olTemplate                                        2
#define olMSG                                             3
#define olDoc                                             4
#define olHTML                                            5
#define olVCard                                           6
#define olVCal                                            7

*** Constant Group: OlSensitivity
#define olNormal                                          0
#define olPersonal                                        1
#define olPrivate                                         2
#define olConfidential                                    3

*** Constant Group: OlSortOrder
#define olSortNone                                        0
#define olAscending                                       1
#define olDescending                                      2

*** Constant Group: OlTaskDelegationState
#define olTaskNotDelegated                                0
#define olTaskDelegationUnknown                           1
#define olTaskDelegationAccepted                          2
#define olTaskDelegationDeclined                          3

*** Constant Group: OlTaskOwnership
#define olNewTask                                         0
#define olDelegatedTask                                   1
#define olOwnTask                                         2

*** Constant Group: OlTaskRecipientType
#define olUpdate                                          2
#define olFinalStatus                                     3

*** Constant Group: OlTaskResponse
#define olTaskSimple                                      0
#define olTaskAssign                                      1
#define olTaskAccept                                      2
#define olTaskDecline                                     3

*** Constant Group: OlTaskStatus
#define olTaskNotStarted                                  0
#define olTaskInProgress                                  1
#define olTaskComplete                                    2
#define olTaskWaiting                                     3
#define olTaskDeferred                                    4

*** Constant Group: OlTrackingStatus
#define olTrackingNone                                    0
#define olTrackingDelivered                               1
#define olTrackingNotDelivered                            2
#define olTrackingNotRead                                 3
#define olTrackingRecallFailure                           4
#define olTrackingRecallSuccess                           5
#define olTrackingRead                                    6
#define olTrackingReplied                                 7

*** Constant Group: OlUserPropertyType
#define olText                                            1
#define olNumber                                          3
#define olDateTime                                        5
#define olYesNo                                           6
#define olDuration                                        7
#define olKeywords                                        11
#define olPercent                                         12
#define olCurrency                                        14
#define olFormula                                         18
#define olCombination                                     19

*** Constant Group: OlWindowState
#define olMaximized                                       0
#define olMinimized                                       1
#define olNormalWindow                                    2

*** Constant Group: OlSyncState
#define olSyncStopped                                     0
#define olSyncStarted                                     1
