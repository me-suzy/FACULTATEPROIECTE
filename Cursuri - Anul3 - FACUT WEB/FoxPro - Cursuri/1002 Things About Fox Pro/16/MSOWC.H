
*** Constant Group: ChartChartLayoutEnum
#define chChartLayoutAutomatic                            0
#define chChartLayoutHorizontal                           1
#define chChartLayoutVertical                             2

*** Constant Group: LineStyleEnum
#define owcLineStyleNone                                  0
#define owcLineStyleAutomatic                             1
#define owcLineStyleSolid                                 2
#define owcLineStyleDash                                  3
#define owcLineStyleDot                                   4
#define owcLineStyleDashDot                               5
#define owcLineStyleDashDotDot                            6

*** Constant Group: LineWeightEnum
#define owcLineWeightHairline                             0
#define owcLineWeightThin                                 1
#define owcLineWeightMedium                               2
#define owcLineWeightThick                                3

*** Constant Group: ChartScaleOrientationEnum
#define chScaleOrientationMinMax                          0
#define chScaleOrientationMaxMin                          1

*** Constant Group: ChartScaleTypeEnum
#define chScaleTypeLinear                                 0
#define chScaleTypeLogarithmic                            1

*** Constant Group: ChartAxisPositionEnum
#define chAxisPositionTop                                 -1
#define chAxisPositionBottom                              -2
#define chAxisPositionLeft                                -3
#define chAxisPositionRight                               -4
#define chAxisPositionRadial                              -5
#define chAxisPositionCircular                            -6

*** Constant Group: ChartAxisTypeEnum
#define chCategoryAxis                                    0
#define chValueAxis                                       1

*** Constant Group: ChartAxisCrossesEnum
#define chAxisCrossesAutomatic                            0
#define chAxisCrossesCustom                               3

*** Constant Group: UnderlineStyleEnum
#define owcUnderlineStyleNone                             0
#define owcUnderlineStyleSingle                           1
#define owcUnderlineStyleDouble                           2
#define owcUnderlineStyleSingleAccounting                 3
#define owcUnderlineStyleDoubleAccounting                 4

*** Constant Group: ChartTickMarkEnum
#define chTickMarkAutomatic                               0
#define chTickMarkNone                                    1
#define chTickMarkInside                                  2
#define chTickMarkOutside                                 3
#define chTickMarkCross                                   4

*** Constant Group: ChartTitlePositionEnum
#define chTitlePositionAutomatic                          0
#define chTitlePositionTop                                1
#define chTitlePositionBottom                             2
#define chTitlePositionLeft                               3
#define chTitlePositionRight                              4

*** Constant Group: ChartLegendPositionEnum
#define chLegendPositionAutomatic                         0
#define chLegendPositionTop                               1
#define chLegendPositionBottom                            2
#define chLegendPositionLeft                              3
#define chLegendPositionRight                             4

*** Constant Group: ChartWizardTypeEnum
#define chWizardFull                                      0
#define chWizardChartType                                 1
#define chWizardSourceData                                2

*** Constant Group: ChartDataLabelPositionEnum
#define chLabelPositionAutomatic                          0
#define chLabelPositionCenter                             1
#define chLabelPositionInsideEnd                          2
#define chLabelPositionInsideBase                         3
#define chLabelPositionOutsideEnd                         4
#define chLabelPositionOutsideBase                        5
#define chLabelPositionLeft                               6
#define chLabelPositionRight                              7
#define chLabelPositionTop                                8
#define chLabelPositionBottom                             9

*** Constant Group: ChartDimensionsEnum
#define chDimSeriesNames                                  0
#define chDimCategories                                   1
#define chDimValues                                       2
#define chDimYValues                                      3
#define chDimXValues                                      4
#define chDimOpenValues                                   5
#define chDimCloseValues                                  6
#define chDimHighValues                                   7
#define chDimLowValues                                    8
#define chDimBubbleValues                                 9
#define chDimRValues                                      10
#define chDimThetaValues                                  11

*** Constant Group: ChartEndStyleEnum
#define chEndStyleNone                                    1
#define chEndStyleCap                                     2

*** Constant Group: ChartErrorBarDirectionEnum
#define chErrorBarDirectionY                              0
#define chErrorBarDirectionX                              1

*** Constant Group: ChartErrorBarIncludeEnum
#define chErrorBarIncludePlusValues                       0
#define chErrorBarIncludeMinusValues                      1
#define chErrorBarIncludeBoth                             2

*** Constant Group: ChartErrorBarTypeEnum
#define chErrorBarTypeFixedValue                          0
#define chErrorBarTypePercent                             1
#define chErrorBarTypeCustom                              2

*** Constant Group: ChartErrorBarCustomValuesEnum
#define chErrorBarPlusValues                              12
#define chErrorBarMinusValues                             13

*** Constant Group: ChartMarkerStyleEnum
#define chMarkerStyleNone                                 0
#define chMarkerStyleSquare                               1
#define chMarkerStyleDiamond                              2
#define chMarkerStyleTriangle                             3
#define chMarkerStyleX                                    4
#define chMarkerStyleStar                                 5
#define chMarkerStyleDot                                  6
#define chMarkerStyleDash                                 7
#define chMarkerStyleCircle                               8
#define chMarkerStylePlus                                 9

*** Constant Group: ChartTrendlineTypeEnum
#define chTrendlineTypeExponential                        0
#define chTrendlineTypeLinear                             1
#define chTrendlineTypeLogarithmic                        2
#define chTrendlineTypePolynomial                         3
#define chTrendlineTypePower                              4

*** Constant Group: ChartChartTypeEnum
#define chChartTypeCombo                                  -1
#define chChartTypeColumnClustered                        0
#define chChartTypeColumnStacked                          1
#define chChartTypeColumnStacked100                       2
#define chChartTypeBarClustered                           3
#define chChartTypeBarStacked                             4
#define chChartTypeBarStacked100                          5
#define chChartTypeLine                                   6
#define chChartTypeLineStacked                            8
#define chChartTypeLineStacked100                         10
#define chChartTypeLineMarkers                            7
#define chChartTypeLineStackedMarkers                     9
#define chChartTypeLineStacked100Markers                  11
#define chChartTypeSmoothLine                             12
#define chChartTypeSmoothLineStacked                      14
#define chChartTypeSmoothLineStacked100                   16
#define chChartTypeSmoothLineMarkers                      13
#define chChartTypeSmoothLineStackedMarkers               15
#define chChartTypeSmoothLineStacked100Markers            17
#define chChartTypePie                                    18
#define chChartTypePieExploded                            19
#define chChartTypePieStacked                             20
#define chChartTypeScatterMarkers                         21
#define chChartTypeScatterLine                            25
#define chChartTypeScatterLineMarkers                     24
#define chChartTypeScatterLineFilled                      26
#define chChartTypeScatterSmoothLine                      23
#define chChartTypeScatterSmoothLineMarkers               22
#define chChartTypeBubble                                 27
#define chChartTypeBubbleLine                             28
#define chChartTypeArea                                   29
#define chChartTypeAreaStacked                            30
#define chChartTypeAreaStacked100                         31
#define chChartTypeDoughnut                               32
#define chChartTypeDoughnutExploded                       33
#define chChartTypeRadarLine                              34
#define chChartTypeRadarLineMarkers                       35
#define chChartTypeRadarLineFilled                        36
#define chChartTypeRadarSmoothLine                        37
#define chChartTypeRadarSmoothLineMarkers                 38
#define chChartTypeStockHLC                               39
#define chChartTypeStockOHLC                              40
#define chChartTypePolarMarkers                           41
#define chChartTypePolarLine                              42
#define chChartTypePolarLineMarkers                       43
#define chChartTypePolarSmoothLine                        44
#define chChartTypePolarSmoothLineMarkers                 45

*** Constant Group: ChartSizeRepresentsEnum
#define chSizeIsWidth                                     0
#define chSizeIsArea                                      1

*** Constant Group: ChartDataSourceTypeEnum
#define chDataSourceTypeUnknown                           0
#define chDataSourceTypeSpreadsheet                       1
#define chDataSourceTypeRecordset                         2
#define chDataSourceTypePivotlist                         3

*** Constant Group: ChartSelectionsEnum
#define chSelectionNone                                   -1
#define chSelectionAxis                                   0
#define chSelectionChart                                  1
#define chSelectionPlotArea                               2
#define chSelectionDataLabels                             3
#define chSelectionErrorbars                              4
#define chSelectionGridlines                              5
#define chSelectionLegend                                 6
#define chSelectionLegendEntry                            7
#define chSelectionPoint                                  8
#define chSelectionSeries                                 9
#define chSelectionTitle                                  10
#define chSelectionTrendline                              11
#define chSelectionWebChart                               12

*** Constant Group: SheetCommandEnum
#define ssCalculate                                       0
#define ssInsertRows                                      2
#define ssInsertColumns                                   3
#define ssDeleteRows                                      4
#define ssDeleteColumns                                   5
#define ssCut                                             6
#define ssCopy                                            7
#define ssPaste                                           8
#define ssExport                                          9
#define ssUndo                                            10
#define ssSortAscending                                   11
#define ssSortDescending                                  12
#define ssFind                                            13
#define ssClear                                           14
#define ssAutoFilter                                      15
#define ssProperties                                      16
#define ssHelp                                            17

*** Constant Group: SheetFindLookInEnum
#define ssFormulas                                        0
#define ssValues                                          1

*** Constant Group: SheetFindLookAtEnum
#define ssPart                                            0
#define ssWhole                                           1

*** Constant Group: SheetSearchOrderEnum
#define ssByColumns                                       0
#define ssByRows                                          1

*** Constant Group: SheetSearchDirectionEnum
#define ssNext                                            0
#define ssPrevious                                        1

*** Constant Group: SheetFreezePanesEnum
#define ssFreezeLeft                                      1
#define ssFreezeRight                                     2
#define ssFreezeTop                                       4
#define ssFreezeBottom                                    8
#define ssFreezeNone                                      16

*** Constant Group: SheetSortOrderEnum
#define ssAscending                                       0
#define ssDescending                                      1

*** Constant Group: SheetYesNoGuessEnum
#define ssGuess                                           0
#define ssYes                                             1
#define ssNo                                              2

*** Constant Group: SheetHAlignEnum
#define ssHAlignGeneral                                   0
#define ssHAlignLeft                                      1
#define ssHAlignCenter                                    2
#define ssHAlignRight                                     3

*** Constant Group: SheetExportActionEnum
#define ssExportActionNone                                0
#define ssExportActionOpenInExcel                         1

*** Constant Group: SheetFilterFunction
#define ssFilterFunctionInclude                           1
#define ssFilterFunctionExclude                           2

*** Constant Group: SheetVAlignEnum
#define ssVAlignBottom                                    0
#define ssVAlignCenter                                    1
#define ssVAlignTop                                       2

*** Constant Group: SheetDirectionEnum
#define ssDown                                            0
#define ssToLeft                                          1
#define ssToRight                                         2
#define ssUp                                              3

*** Constant Group: ChartSeriesScalingsEnum
#define chCategoryScaling                                 0
#define chValueScaling                                    1
#define chValueScaling1                                   2
#define chValueScaling2                                   3

*** Constant Group: ChartFillStyleEnum
#define chNone                                            -1
#define chSolid                                           0

*** Constant Group: ChartColorIndexEnum
#define chColorAutomatic                                  -1
#define chColorNone                                       -2

*** Constant Group: ChartDataGroupingFunctionEnum
#define chDataGroupingFunctionMinimum                     0
#define chDataGroupingFunctionMaximum                     1
#define chDataGroupingFunctionSum                         2
#define chDataGroupingFunctionAverage                     3

*** Constant Group: ChartSeriesByEnum
#define chSeriesByRows                                    0
#define chSeriesByColumns                                 1

*** Constant Group: ChartSpecialDataSourcesEnum
#define chDataLiteral                                     -1
#define chDataNone                                        -2

*** Constant Group: ChartPivotDataReferenceEnum
#define chPivotColumns                                    -1
#define chPivotRows                                       -2
#define chPivotColAggregates                              -3
#define chPivotRowAggregates                              -4

*** Constant Group: SheetBorderTypeEnum
#define ssEdgeAll                                         0
#define ssEdgeBottom                                      1
#define ssEdgeLeft                                        2
#define ssEdgeRight                                       3
#define ssEdgeTop                                         4
#define ssInsideHorizontal                                5
#define ssInsideVertical                                  6

*** Constant Group: SheetTriStateEnum
#define ssAuto                                            -1
#define ssOff                                             0
#define ssOn                                              1

*** Constant Group: ExpandBitmapTypeEnum
#define ecBitmapPlusMinus                                 0
#define ecBitmapUpDownArrow                               1
#define ecBitmapOpenCloseFolder                           2

*** Constant Group: DscRowsourceTypeEnum
#define dscTable                                          1
#define dscView                                           2
#define dscCommandText                                    3
#define dscProcedure                                      4
#define dscCommandFile                                    5

*** Constant Group: DscFieldTypeEnum
#define dscParameter                                      -1
#define dscOutput                                         1
#define dscCalculated                                     2
#define dscGrouping                                       3

*** Constant Group: DscTotalTypeEnum
#define dscNone                                           0
#define dscSum                                            1
#define dscAvg                                            2
#define dscMin                                            3
#define dscMax                                            4
#define dscCount                                          5
#define dscAny                                            6
#define dscStdev                                          7

*** Constant Group: DscGroupOnEnum
#define dscNoGrouping                                     -1
#define dscEachValue                                      0
#define dscPrefix                                         1
#define dscYear                                           2
#define dscQuarter                                        3
#define dscMonth                                          4
#define dscWeek                                           5
#define dscDay                                            6
#define dscHour                                           7
#define dscMinute                                         8
#define dscInterval                                       9

*** Constant Group: DscJoinTypeEnum
#define dscInnerJoin                                      1
#define dscLeftOuterJoin                                  2
#define dscRightOuterJoin                                 3

*** Constant Group: DscPageRelTypeEnum
#define dscSublist                                        1
#define dscLookup                                         2

*** Constant Group: DscObjectTypeEnum
#define dscobjUnknown                                     -1
#define dscobjSchemaRowsource                             1
#define dscobjSchemaField                                 2
#define dscobjSchemaRelationship                          4
#define dscobjRecordsetDef                                8
#define dscobjPageRowsource                               16
#define dscobjPageField                                   32
#define dscobjSublistRelationship                         64
#define dscobjLookupRelationship                          128
#define dscobjGroupingDef                                 256
#define dscobjDatamodel                                   512
#define dscobjPageRelatedField                            1024
#define dscobjParameterValue                              2048
#define dscobjSchemaRelatedField                          4096
#define dscobjSchemaParameter                             8192

*** Constant Group: NavButtonEnum
#define navbtnMoveFirst                                   0
#define navbtnMovePrev                                    1
#define navbtnMoveNext                                    2
#define navbtnMoveLast                                    3
#define navbtnNew                                         4
#define navbtnDelete                                      5
#define navbtnSave                                        6
#define navbtnUndo                                        7
#define navbtnSortAscending                               8
#define navbtnSortDescending                              9
#define navbtnApplyFilter                                 10
#define navbtnToggleFilter                                11
#define navbtnHelp                                        12

*** Constant Group: DscDropTypeEnum
#define dscDefault                                        0
#define dscGrid                                           1
#define dscFields                                         2

*** Constant Group: DscDropLocationEnum
#define dscAbove                                          1
#define dscWithin                                         2
#define dscBelow                                          3

*** Constant Group: DscHyperlinkPartEnum
#define dschlDisplayedValue                               0
#define dschlDisplayText                                  1
#define dschlAddress                                      2
#define dschlSubAddress                                   3
#define dschlScreenTip                                    4
#define dschlFullAddress                                  5

*** Constant Group: DscLocationEnum
#define dscSystem                                         -1
#define dscClient                                         0
#define dscServer                                         1

*** Constant Group: DscRecordsetTypeEnum
#define dscSnapshot                                       1
#define dscUpdatableSnapshot                              2

*** Constant Group: DscFetchTypeEnum
#define dscFull                                           1
#define dscParameterized                                  2

*** Constant Group: DscAdviseTypeEnum
#define dscAdd                                            1
#define dscDelete                                         2
#define dscMove                                           3
#define dscLoad                                           4
#define dscChange                                         5
#define dscDeleteComplete                                 6

*** Constant Group: FieldListConnectionTypeEnum
#define fltypeUnknown                                     0
#define fltypeMD                                          1
#define fltypePVT                                         2
#define fltypeRel                                         3

*** Constant Group: FieldListObjectTypeEnum
#define flTables                                          1
#define flViews                                           2
#define flStoredProcedures                                4
#define flCmdText                                         8
#define flSchemaDiagrams                                  16
#define flOLAPCube                                        32
#define flAll                                             255

*** Constant Group: DaAttrEnum
#define daLength                                          1
#define daPrecision                                       2
#define daScale                                           3

*** Constant Group: DaPivotLocationEnum
#define dplRowArea                                        1
#define dplColumnArea                                     2
#define dplFilterArea                                     3
#define dplDataArea                                       4
#define dplDetails                                        5

*** Constant Group: FieldListRelationshipTypeEnum
#define flrelNoRel                                        0
#define flrelOneToMany                                    1
#define flrelManyToOne                                    2
#define flrelOneToOnePrimaryPrimary                       4
#define flrelOneToOnePrimaryForeign                       8
#define flrelUniqueConstraint                             16
#define flrelUniqueIndex                                  32

*** Constant Group: SectTypeEnum
#define sectTypeNone                                      0
#define sectTypeCaption                                   1
#define sectTypeHeader                                    2
#define sectTypeFooter                                    3
#define sectTypeRecNav                                    4

*** Constant Group: ProviderType
#define providerTypeUnknown                               1
#define providerTypeRelational                            2
#define providerTypeMultidimensional                      3

*** Constant Group: DefaultControlTypeEnum
#define ctlTypeTextBox                                    0
#define ctlTypeBoundHTML                                  1

*** Constant Group: DataPageDesignerFlags
#define designFlagDontDelete                              1
#define designFlagDontCleanup                             2

*** Constant Group: PivotHAlignmentEnum
#define plHAlignAutomatic                                 0
#define plHAlignLeft                                      1
#define plHAlignCenter                                    2
#define plHAlignRight                                     3

*** Constant Group: PivotFieldGroupOnEnum
#define plGroupOnEachValue                                0
#define plGroupOnPrefixChar                               1
#define plGroupOnYears                                    2
#define plGroupOnQtrs                                     3
#define plGroupOnMonths                                   4
#define plGroupOnWeeks                                    5
#define plGroupOnDays                                     6
#define plGroupOnHours                                    7
#define plGroupOnMinutes                                  8
#define plGroupOnSeconds                                  9
#define plGroupOnInterval                                 10

*** Constant Group: PivotFieldSortDirectionEnum
#define plSortDirectionDefault                            0
#define plSortDirectionAscending                          1
#define plSortDirectionDescending                         2

*** Constant Group: PivotFieldTypeEnum
#define plTypeRegular                                     1
#define plTypeCalculated                                  2
#define plTypeTime                                        3
#define plTypeTimeYears                                   4
#define plTypeTimeHalfYears                               5
#define plTypeTimeQuarters                                6
#define plTypeTimeMonths                                  7
#define plTypeTimeWeeks                                   8
#define plTypeTimeDays                                    9
#define plTypeTimeHours                                   10
#define plTypeTimeMinutes                                 11
#define plTypeTimeSeconds                                 12
#define plTypeTimeUndefined                               13
#define plTypeUnknown                                     14
#define plTypeUserDefined                                 15

*** Constant Group: PivotFieldFilterFunctionEnum
#define plFilterFunctionNone                              0
#define plFilterFunctionInclude                           1
#define plFilterFunctionExclude                           2

*** Constant Group: PivotTotalFunctionEnum
#define plFunctionSum                                     1
#define plFunctionCount                                   2
#define plFunctionMin                                     3
#define plFunctionMax                                     4

*** Constant Group: PivotTotalTypeEnum
#define plTotalTypeIntrinsic                              1
#define plTotalTypeUserDefined                            2

*** Constant Group: PivotFieldSetOrientationEnum
#define plOrientationNone                                 0
#define plOrientationColumnAxis                           1
#define plOrientationRowAxis                              2
#define plOrientationFilterAxis                           4
#define plOrientationDataAxis                             8

*** Constant Group: PivotFieldSetTypeEnum
#define plFieldSetTypeTime                                1
#define plFieldSetTypeOther                               2
#define plFieldSetTypeUnknown                             3
#define plFieldSetTypeUserDefined                         4

*** Constant Group: PivotViewTotalOrientationEnum
#define plTotalOrientationRow                             1
#define plTotalOrientationColumn                          2

*** Constant Group: PivotExportActionEnum
#define plExportActionNone                                0
#define plExportActionOpenInExcel                         1

*** Constant Group: PivotViewReasonEnum
#define plViewReasonSelectionChange                       0
#define plViewReasonSubtotalsChange                       1
#define plViewReasonSystemColorChange                     2
#define plViewReasonQuery                                 3
#define plViewReasonFontNameChange                        4
#define plViewReasonFontSizeChange                        5
#define plViewReasonFontBoldChange                        6
#define plViewReasonFontItalicChange                      7
#define plViewReasonFontUnderlineChange                   8
#define plViewReasonMemberExpandedChange                  9
#define plViewReasonCellExpandedChange                    10
#define plViewReasonDetailRowHeightChange                 11
#define plViewReasonFieldDetailWidthChange                12
#define plViewReasonFieldGroupedWidthChange               13
#define plViewReasonViewDetailWidthChange                 14
#define plViewReasonFieldSetWidthChange                   15
#define plViewReasonTotalWidthChange                      16
#define plViewReasonForeColorChange                       17
#define plViewReasonBackColorChange                       18
#define plViewReasonAlignmentChange                       19
#define plViewReasonNumberFormatChange                    20
#define plViewReasonDetailTopChange                       21
#define plViewReasonDetailLeftChange                      22
#define plViewReasonTopChange                             23
#define plViewReasonLeftChange                            24
#define plViewReasonRightToLeftChange                     25
#define plViewReasonTotalOrientationChange                26
#define plViewReasonDisplayOutlineChange                  27
#define plViewReasonFieldCaptionChange                    28
#define plViewReasonFieldSetCaptionChange                 29
#define plViewReasonLabelCaptionChange                    30
#define plViewReasonMemberCaptionChange                   31
#define plViewReasonTotalCaptionChange                    32
#define plViewReasonAllowFilteringChange                  33
#define plViewReasonAllowGroupingChange                   34
#define plViewReasonWidthChange                           35
#define plViewReasonHeightChange                          36
#define plViewReasonLabelVisibleChange                    37
#define plViewReasonDisplayToolbarChange                  38
#define plViewReasonMaxHeightChange                       39
#define plViewReasonMaxWidthChange                        40
#define plViewReasonAutoFitChange                         41
#define plViewReasonFieldExpandedChange                   42
#define plViewReasonCellsExpandedChange                   43
#define plViewReasonDetailMaxWidthChange                  44
#define plViewReasonDetailMaxHeightChange                 45

*** Constant Group: PivotQueryReasonEnum
#define plQueryReasonInsertFieldSet                       0
#define plQueryReasonRemoveFieldSet                       1
#define plQueryReasonInsertTotal                          2
#define plQueryReasonRemoveTotal                          3
#define plQueryReasonAllowDetailsChange                   4
#define plQueryReasonSortDirectionChange                  5
#define plQueryReasonSortOnChange                         6
#define plQueryReasonSortOnScopeChange                    7
#define plQueryReasonFilterFunctionChange                 8
#define plQueryReasonFilterMemberChange                   9
#define plQueryReasonIsIncludedChange                     10
#define plQueryReasonExpressionChange                     11
#define plQueryReasonDisplayEmptyMembersChange            12
#define plQueryReasonTotalFunctionChange                  13
#define plQueryReasonUser                                 14
#define plQueryReasonDataSourceChange                     15
#define plQueryReasonDataMemberChange                     16
#define plQueryReasonGroupOnChange                        17
#define plQueryReasonUnknown                              18
#define plQueryReasonGroupOffsetChange                    19
#define plQueryReasonGroupIntervalChange                  20
#define plQueryReasonIsFilteredChange                     21

*** Constant Group: PivotTableMemberExpandEnum
#define plMemberExpandAutomatic                           0
#define plMemberExpandAlways                              1
#define plMemberExpandNever                               2

*** Constant Group: PivotTableReasonEnum
#define plPivotTableReasonTotalAdded                      0
#define plPivotTableReasonTotalDeleted                    1
#define plPivotTableReasonFieldSetAdded                   2
#define plPivotTableReasonFieldSetDeleted                 3
#define plPivotTableReasonFieldAdded                      4
