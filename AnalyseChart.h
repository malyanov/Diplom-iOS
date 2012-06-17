//
//  AnalyseChart.h
//  diplom
//
//  Created by Mac on 18.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quotation.h"
#import "Analiser.h"
typedef enum{RSI=0, Stochastic, Momentum}Mode;
@interface AnalyseChart : UIView
@property (strong) NSMutableArray *drawPoints;
@property int scaleX, horShift;
@property Mode mode;
@property int PADDING;
@property CGColorRef white,gray,blue,black,red,green;
+(id) newAnalyseChart:(CGRect)frame;
-(void)setParams:(int)hShift:(int)scX;
-(void)setInputData:(NSMutableArray*)quotes;
-(void)drawRSI:(CGContextRef)context:(double)scaleFactor;
-(void)drawStochastic:(CGContextRef)context:(double)scaleFactor;
-(void)drawMomentum:(CGContextRef)context;
@end
