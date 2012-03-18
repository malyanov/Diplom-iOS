//
//  Chart.h
//  diplom
//
//  Created by Mac on 17.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quotation.h"
#import "AnalyseChart.h"
typedef enum {CURVES,CANDLES,BARS}Modes;
@interface Chart : UIView
@property int MAX_SCALE, MIN_SCALE, SCALE_DELTA, MOVE_DELTA, PADDING;
@property bool firstRun;
@property (strong) NSMutableArray  *qList;
@property int curScaleX, curScaleY, curPos;
@property double maxValue, minValue;
@property (strong) NSMutableArray *points;
@property (strong) NSString *info;    
@property Modes mode;
@property QuotationType bid;
@property CGColorRef white, gray, blue, black, red;  
//drag flags
@property bool isDragging;
@property CGPoint startPoint;
@property int moveUpCounter, moveDownCounter, moveLeftCounter, moveRightCounter;    
@property bool isFullscreen;    
@property (strong) AnalyseChart *analyseChart;
@property float mScaleFactor;
+newChart:(AnalyseChart*)analyseChart:(bool)isFullscreen;
-(void)updateLastValue:(double)value;
@end
