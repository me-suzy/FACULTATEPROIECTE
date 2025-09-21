
*** Constant Group: ErrorConstants
#define VtOk                                              0
#define VtFail                                            1000
#define VtErrorDeletingUsedObject                         1001
#define VtErrorDeletingDeletedObject                      1002
#define VtErrorCorruptData                                1003
#define VtErrorNotImplemented                             1004
#define VtErrorNoMemory                                   1100
#define VtErrorInvalidArgument                            1101
#define VtErrorNotFound                                   1102
#define VtErrorTooSmall                                   1103
#define VtErrorInvalidRequest                             1104
#define VtErrorStreamIo                                   1105
#define VtErrorUserIo                                     1106
#define VtErrorCorruptArchive                             1107
#define VtErrorArchiveVersion                             1108
#define VtErrorArchiveTypeMismatch                        1109
#define VtErrorArchivePointerMismatch                     1110
#define VtErrorCannotOpenFile                             1111
#define VtErrorUnableToLoadString                         1112
#define VtErrorBufferTooSmall                             1113
#define VtErrorCopyingObject                              1114
#define VtErrorDuplicateObject                            1115
#define VtErrorActionCanceled                             1116
#define VtErrorInvalidIndex                               1117
#define VtErrorInvalidTypeConversion                      1118
#define VtErrorInvalidObject                              1119
#define VtErrorCreateWindow                               1120
#define VtErrorOSVersion                                  1121
#define VtErrorLoadPicture                                1122
#define VtErrorInvalidSyntax                              1200
#define VtErrorIdentifierTooBig                           1201
#define VtErrorUnrecongizedFunction                       1202
#define VtErrorUnrecongizedSymbol                         1203
#define VtErrorUnexpectedEOS                              1204
#define VtErrorDuplicateSymbol                            1205
#define VtErrorDisplay                                    1500
#define VtErrorInvalidFontName                            1501
#define VtErrorInvalidFont                                1502
#define VtErrorNoDisplayResources                         1503
#define VtErrorDefaultFontSubstituted                     1504
#define VtChError                                         2000
#define VtChErrorInvalidHandle                            2001
#define VtChErrorNoData                                   2002
#define VtChErrorInvalidSeriesNumber                      2003
#define VtChErrorInvalidAxis                              2004
#define VtChErrorRestrictedVersion                        2005
#define InvalidPropertyValue                              380
#define GetNotSupported                                   394
#define SetNotSupported                                   383
#define InvalidProcedureCall                              5
#define InvalidObjectUse                                  425
#define WrongClipboardFormat                              461
#define DataObjectLocked                                  672
#define ExpectedAnArgument                                673
#define RecursiveOleDrag                                  674
#define FormatNotByteArray                                675
#define DataNotSetForFormat                               676

*** Constant Group: OLEDropConstants
#define chOLEDropNone                                     0
#define chOLEDropManual                                   1
#define chOLEDropAutomatic                                2

*** Constant Group: OLEDragConstants
#define chOLEDragManual                                   0
#define chOLEDragAutomatic                                1

*** Constant Group: VtHorizontalAlignment
#define VtHorizontalAlignmentLeft                         0
#define VtHorizontalAlignmentRight                        1
#define VtHorizontalAlignmentCenter                       2
#define VtHorizontalAlignmentFill                         3
#define VtHorizontalAlignmentFlush                        4

*** Constant Group: VtVerticalAlignment
#define VtVerticalAlignmentTop                            0
#define VtVerticalAlignmentBottom                         1
#define VtVerticalAlignmentCenter                         2

*** Constant Group: VtOrientation
#define VtOrientationHorizontal                           0
#define VtOrientationVertical                             1
#define VtOrientationUp                                   2
#define VtOrientationDown                                 3

*** Constant Group: VtSortType
#define VtSortTypeNone                                    0
#define VtSortTypeAscending                               1
#define VtSortTypeDescending                              2

*** Constant Group: VtAngleUnits
#define VtAngleUnitsDegrees                               0
#define VtAngleUnitsRadians                               1
#define VtAngleUnitsGrads                                 2

*** Constant Group: VtPrintScaleType
#define VtPrintScaleTypeActual                            0
#define VtPrintScaleTypeFitted                            1
#define VtPrintScaleTypeStretched                         2

*** Constant Group: VtPrintOrientation
#define VtPrintOrientationPortrait                        0
#define VtPrintOrientationLandscape                       1

*** Constant Group: VtFontStyle
#define VtFontStyleBold                                   1
#define VtFontStyleItalic                                 2
#define VtFontStyleOutline                                4

*** Constant Group: VtFontEffect
#define VtFontEffectStrikeThrough                         256
#define VtFontEffectUnderline                             512

*** Constant Group: VtBrushStyle
#define VtBrushStyleNull                                  0
#define VtBrushStyleSolid                                 1
#define VtBrushStylePattern                               2
#define VtBrushStyleHatched                               3

*** Constant Group: VtBrushPatterns
#define VtBrushPattern94Percent                           0
#define VtBrushPattern88Percent                           1
#define VtBrushPattern75Percent                           2
#define VtBrushPattern50Percent                           3
#define VtBrushPattern25Percent                           4
#define VtBrushPatternBoldHorizontal                      5
#define VtBrushPatternBoldVertical                        6
#define VtBrushPatternBoldDownDiagonal                    7
#define VtBrushPatternBoldUpDiagonal                      8
#define VtBrushPatternChecks                              9
#define VtBrushPatternWeave                               10
#define VtBrushPatternHorizontal                          11
#define VtBrushPatternVertical                            12
#define VtBrushPatternDownDiagonal                        13
#define VtBrushPatternUpDiagonal                          14
#define VtBrushPatternGrid                                15
#define VtBrushPatternTrellis                             16
#define VtBrushPatternInvertedTrellis                     17
#define VtBrushPatternCount                               18

*** Constant Group: VtBrushHatches
#define VtBrushHatchHorizontal                            0
#define VtBrushHatchVertical                              1
#define VtBrushHatchDownDiagonal                          2
#define VtBrushHatchUpDiagonal                            3
#define VtBrushHatchCross                                 4
#define VtBrushHatchDiagonalCross                         5
#define VtBrushHatchCount                                 6

*** Constant Group: VtShadowStyle
#define VtShadowStyleNull                                 0
#define VtShadowStyleDrop                                 1

*** Constant Group: VtPenStyle
#define VtPenStyleNull                                    0
#define VtPenStyleSolid                                   1
#define VtPenStyleDashed                                  2
#define VtPenStyleDotted                                  3
#define VtPenStyleDashDot                                 4
#define VtPenStyleDashDotDot                              5
#define VtPenStyleDitted                                  6
#define VtPenStyleDashDit                                 7
#define VtPenStyleDashDitDit                              8
#define VtPenStyleNative                                  9

*** Constant Group: VtPenJoin
#define VtPenJoinMiter                                    0
#define VtPenJoinRound                                    1
#define VtPenJoinBevel                                    2

*** Constant Group: VtPenCap
#define VtPenCapButt                                      0
#define VtPenCapRound                                     1
#define VtPenCapSquare                                    2

*** Constant Group: VtFrameStyle
#define VtFrameStyleNull                                  0
#define VtFrameStyleSingleLine                            1
#define VtFrameStyleDoubleLine                            2
#define VtFrameStyleThickInner                            3
#define VtFrameStyleThickOuter                            4

*** Constant Group: VtPictureType
#define VtPictureTypeNull                                 0
#define VtPictureTypeBitmap                               1
#define VtPictureTypeVector                               2
#define VtPictureTypeBMP                                  3
#define VtPictureTypeWMF                                  4

*** Constant Group: VtPictureOption
#define VtPictureOptionNoSizeHeader                       1
#define VtPictureOptionTextAsCurves                       2

*** Constant Group: VtPictureMapType
#define VtPictureMapTypeActual                            0
#define VtPictureMapTypeFitted                            1
#define VtPictureMapTypeStretched                         2
#define VtPictureMapTypeTiled                             3
#define VtPictureMapTypeCropFitted                        4
#define VtPictureMapTypeHorizontalTile                    5
#define VtPictureMapTypeVerticalTile                      6

*** Constant Group: VtGradientStyle
#define VtGradientStyleHorizontal                         0
#define VtGradientStyleVertical                           1
#define VtGradientStyleRectangle                          2
#define VtGradientStyleOval                               3

*** Constant Group: VtFillStyle
#define VtFillStyleNull                                   0
#define VtFillStyleBrush                                  1
#define VtFillStyleGradient                               2

*** Constant Group: VtMarkerStyle
#define VtMarkerStyleDash                                 0
#define VtMarkerStylePlus                                 1
#define VtMarkerStyleX                                    2
#define VtMarkerStyleStar                                 3
#define VtMarkerStyleCircle                               4
#define VtMarkerStyleSquare                               5
#define VtMarkerStyleDiamond                              6
#define VtMarkerStyleUpTriangle                           7
#define VtMarkerStyleDownTriangle                         8
#define VtMarkerStyleFilledCircle                         9
#define VtMarkerStyleFilledSquare                         10
#define VtMarkerStyleFilledDiamond                        11
#define VtMarkerStyleFilledUpTriangle                     12
#define VtMarkerStyleFilledDownTriangle                   13
#define VtMarkerStyle3dBall                               14
#define VtMarkerStyleNull                                 15
#define VtMarkerStyleCount                                16

*** Constant Group: VtProjectionType
#define VtProjectionTypePerspective                       0
#define VtProjectionTypeOblique                           1
#define VtProjectionTypeOrthogonal                        2
#define VtProjectionTypeFrontal                           3
#define VtProjectionTypeOverhead                          4

*** Constant Group: VtSmoothingType
#define VtSmoothingTypeNone                               0
#define VtSmoothingTypeQuadraticBSpline                   1
#define VtSmoothingTypeCubicBSpline                       2

*** Constant Group: VtDcType
#define VtDcTypeNull                                      0
#define VtDcTypeDisplay                                   1
#define VtDcTypePrinter                                   2
#define VtDcTypeMetafile                                  3

*** Constant Group: VtTextOutputType
#define VtTextOutputTypeHardware                          0
#define VtTextOutputTypePolygon                           1

*** Constant Group: VtTextLengthType
#define VtTextLengthTypeVirtual                           0
#define VtTextLengthTypeDevice                            1

*** Constant Group: VtChChartType
#define VtChChartType3dBar                                0
#define VtChChartType2dBar                                1
#define VtChChartType3dLine                               2
#define VtChChartType2dLine                               3
#define VtChChartType3dArea                               4
#define VtChChartType2dArea                               5
#define VtChChartType3dStep                               6
#define VtChChartType2dStep                               7
#define VtChChartType3dCombination                        8
#define VtChChartType2dCombination                        9
#define VtChChartType3dHorizontalBar                      10
#define VtChChartType2dHorizontalBar                      11
#define VtChChartType3dClusteredBar                       12
#define VtChChartType3dPie                                13
#define VtChChartType2dPie                                14
#define VtChChartType3dDoughnut                           15
#define VtChChartType2dXY                                 16
#define VtChChartType2dPolar                              17
#define VtChChartType2dRadar                              18
#define VtChChartType2dBubble                             19
#define VtChChartType2dHiLo                               20
#define VtChChartType2dGantt                              21
#define VtChChartType3dGantt                              22
#define VtChChartType3dSurface                            23
#define VtChChartType2dContour                            24
#define VtChChartType3dScatter                            25
#define VtChChartType3dXYZ                                26
#define VtChChartTypeCount                                27

*** Constant Group: VtChSeriesType
#define VtChSeriesTypeVaries                              -2
#define VtChSeriesTypeDefault                             -1
#define VtChSeriesType3dBar                               0
#define VtChSeriesType2dBar                               1
#define VtChSeriesType3dHorizontalBar                     2
#define VtChSeriesType2dHorizontalBar                     3
#define VtChSeriesType3dClusteredBar                      4
#define VtChSeriesType3dLine                              5
#define VtChSeriesType2dLine                              6
#define VtChSeriesType3dArea                              7
#define VtChSeriesType2dArea                              8
#define VtChSeriesType3dStep                              9
#define VtChSeriesType2dStep                              10
#define VtChSeriesType2dXY                                11
#define VtChSeriesType2dPolar                             12
#define VtChSeriesType2dRadarLine                         13
#define VtChSeriesType2dRadarArea                         14
#define VtChSeriesType2dBubble                            15
#define VtChSeriesType2dHiLo                              16
#define VtChSeriesType2dHLC                               17
#define VtChSeriesType2dHLCRight                          18
#define VtChSeriesType2dOHLC                              19
#define VtChSeriesType2dOHLCBar                           20
#define VtChSeriesType2dGantt                             21
#define VtChSeriesType3dGantt                             22
#define VtChSeriesType3dPie                               23
#define VtChSeriesType2dPie                               24
#define VtChSeriesType3dDoughnut                          25
#define VtChSeriesType2dDates                             26
#define VtChSeriesType3dBarHiLo                           27
#define VtChSeriesType2dBarHiLo                           28
#define VtChSeriesType3dHorizontalBarHiLo                 29
#define VtChSeriesType2dHorizontalBarHiLo                 30
#define VtChSeriesType3dClusteredBarHiLo                  31
#define VtChSeriesType3dSurface                           32
#define VtChSeriesType2dContour                           33
#define VtChSeriesType3dXYZ                               34
#define VtChSeriesTypeCount                               35

*** Constant Group: VtChPartType
#define VtChPartTypeChart                                 0
#define VtChPartTypeTitle                                 1
#define VtChPartTypeFootnote                              2
#define VtChPartTypeLegend                                3
#define VtChPartTypePlot                                  4
#define VtChPartTypeSeries                                5
#define VtChPartTypeSeriesLabel                           6
#define VtChPartTypePoint                                 7
#define VtChPartTypePointLabel                            8
#define VtChPartTypeAxis                                  9
#define VtChPartTypeAxisLabel                             10
#define VtChPartTypeAxisTitle                             11
#define VtChPartTypeSeriesName                            12
#define VtChPartTypePointName                             13
#define VtChPartTypeCount                                 14

*** Constant Group: VtChLocationType
#define VtChLocationTypeTopLeft                           0
#define VtChLocationTypeTop                               1
#define VtChLocationTypeTopRight                          2
#define VtChLocationTypeLeft                              3
#define VtChLocationTypeRight                             4
#define VtChLocationTypeBottomLeft                        5
#define VtChLocationTypeBottom                            6
#define VtChLocationTypeBottomRight                       7
#define VtChLocationTypeCustom                            8

*** Constant Group: VtChLabelComponent
#define VtChLabelComponentValue                           1
#define VtChLabelComponentPercent                         2
#define VtChLabelComponentSeriesName                      4
#define VtChLabelComponentPointName                       8

*** Constant Group: VtChLabelLineStyle
#define VtChLabelLineStyleNone                            0
#define VtChLabelLineStyleStraight                        1
#define VtChLabelLineStyleBent                            2

*** Constant Group: VtChLabelLocationType
#define VtChLabelLocationTypeNone                         0
#define VtChLabelLocationTypeAbovePoint                   1
#define VtChLabelLocationTypeBelowPoint                   2
#define VtChLabelLocationTypeCenter                       3
#define VtChLabelLocationTypeBase                         4
#define VtChLabelLocationTypeInside                       5
#define VtChLabelLocationTypeOutside                      6
#define VtChLabelLocationTypeLeft                         7
#define VtChLabelLocationTypeRight                        8

*** Constant Group: VtChSubPlotLabelLocationType
#define VtChSubPlotLabelLocationTypeNone                  0
#define VtChSubPlotLabelLocationTypeAbove                 1
#define VtChSubPlotLabelLocationTypeBelow                 2
#define VtChSubPlotLabelLocationTypeCenter                3

*** Constant Group: VtChPieWeightBasis
#define VtChPieWeightBasisNone                            0
#define VtChPieWeightBasisTotal                           1
#define VtChPieWeightBasisSeries                          2

*** Constant Group: VtChPieWeightStyle
#define VtChPieWeightStyleArea                            0
#define VtChPieWeightStyleDiameter                        1

*** Constant Group: VtChAxisId
#define VtChAxisIdX                                       0
#define VtChAxisIdY                                       1
#define VtChAxisIdY2                                      2
#define VtChAxisIdZ                                       3
#define VtChAxisIdNone                                    4

*** Constant Group: VtChDateIntervalType
#define VtChDateIntervalTypeNone                          0
#define VtChDateIntervalTypeDaily                         1
#define VtChDateIntervalTypeWeekly                        2
#define VtChDateIntervalTypeSemimonthly                   3
#define VtChDateIntervalTypeMonthly                       4
#define VtChDateIntervalTypeYearly                        5

*** Constant Group: VtChScaleType
#define VtChScaleTypeLinear                               0
#define VtChScaleTypeLogarithmic                          1
#define VtChScaleTypePercent                              2

*** Constant Group: VtChPercentAxisBasis
#define VtChPercentAxisBasisMaxChart                      0
#define VtChPercentAxisBasisMaxRow                        1
#define VtChPercentAxisBasisMaxColumn                     2
#define VtChPercentAxisBasisSumChart                      3
#define VtChPercentAxisBasisSumRow                        4
#define VtChPercentAxisBasisSumColumn                     5

*** Constant Group: VtChAxisTickStyle
#define VtChAxisTickStyleNone                             0
#define VtChAxisTickStyleCenter                           1
#define VtChAxisTickStyleInside                           2
#define VtChAxisTickStyleOutside                          3

*** Constant Group: VtChStats
#define VtChStatsMinimum                                  1
#define VtChStatsMaximum                                  2
#define VtChStatsMean                                     4
#define VtChStatsStddev                                   8
#define VtChStatsRegression                               16

*** Constant Group: VtChUpdateFlags
#define VtChNoDisplay                                     0
#define VtChDisplayPlot                                   1
#define VtChLayoutPlot                                    2
#define VtChDisplayLegend                                 4
#define VtChLayoutLegend                                  8
#define VtChLayoutSeries                                  16
#define VtChPositionSection                               32

*** Constant Group: VtChMouseFlag
#define VtChMouseFlagShiftKeyDown                         4
#define VtChMouseFlagControlKeyDown                       8

*** Constant Group: VtChSsLinkMode
#define VtChSsLinkModeOff                                 0
#define VtChSsLinkModeOn                                  1
#define VtChSsLinkModeAutoParse                           2

*** Constant Group: VtChDrawMode
#define VtChDrawModeDraw                                  0
#define VtChDrawModeBlit                                  1

*** Constant Group: VtChContourColorType
#define VtChContourColorTypeAutomatic                     0
#define VtChContourColorTypeGradient                      1
#define VtChContourColorTypeManual                        2

*** Constant Group: VtChContourDisplayType
#define VtChContourDisplayTypeCBands                      0
#define VtChContourDisplayTypeCLines                      1

*** Constant Group: VtChSurfaceBaseType
#define VtChSurfaceBaseTypePedestal                       0
#define VtChSurfaceBaseTypeStandard                       1
#define VtChSurfaceBaseTypeStandardWithCBands             2
#define VtChSurfaceBaseTypeStandardWithCLines             3

*** Constant Group: VtChSurfaceDisplayType
#define VtChSurfaceDisplayTypeNone                        0
#define VtChSurfaceDisplayTypeCBands                      1
#define VtChSurfaceDisplayTypeCLines                      2
#define VtChSurfaceDisplayTypeSolid                       3
#define VtChSurfaceDisplayTypeSolidWithCLines             4

*** Constant Group: VtChSurfaceProjectionType
#define VtChSurfaceProjectionTypeNone                     0
#define VtChSurfaceProjectionTypeCBands                   1
#define VtChSurfaceProjectionTypeCLines                   2

*** Constant Group: VtChSurfaceWireframeType
#define VtChSurfaceWireframeTypeNone                      0
#define VtChSurfaceWireframeTypeMajor                     1
#define VtChSurfaceWireframeTypeMajorAndMinor             2

*** Constant Group: VtBorderStyle
#define VtBorderStyleNone                                 0
#define VtBorderStyleFixedSingle                          1

*** Constant Group: VtMousePointer
#define VtMousePointerDefault                             0
#define VtMousePointerArrow                               1
#define VtMousePointerCross                               2
#define VtMousePointerIbeam                               3
#define VtMousePointerIcon                                4
#define VtMousePointerSize                                5
#define VtMousePointerSizeNESW                            6
#define VtMousePointerSizeNS                              7
#define VtMousePointerSizeNWSE                            8
#define VtMousePointerSizeWE                              9
#define VtMousePointerUpArrow                             10
#define VtMousePointerHourGlass                           11
#define VtMousePointerNoDrop                              12
#define VtMousePointerArrowHourGlass                      13
#define VtMousePointerArrowQuestion                       14
#define VtMousePointerSizeAll                             15
