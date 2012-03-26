//
//  AnalyseChart.m
//  diplom
//
//  Created by Mac on 18.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AnalyseChart.h"
#import "StochasticItem.h"

@implementation AnalyseChart
@synthesize black,white,red,green,blue,gray;
@synthesize mode;
@synthesize drawPoints;
@synthesize stochasticPoints;
@synthesize scaleX, horShift, PADDING;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(id) newAnalyseChart:(CGRect)frame
{     
    AnalyseChart *chart=[[AnalyseChart alloc] initWithFrame:frame];   
    chart.black=[UIColor blackColor].CGColor;
    chart.blue=[UIColor blueColor].CGColor;
    chart.white=[UIColor whiteColor].CGColor;
    chart.red=[UIColor redColor].CGColor;
    chart.gray=[UIColor grayColor].CGColor;
    chart.green=[UIColor greenColor].CGColor;
    chart.backgroundColor=[UIColor whiteColor];
    chart.PADDING=40;
    return chart;
}
- (void)drawRect:(CGRect)rect
{
    if(drawPoints.count==0)
        return;
    CGContextRef context=UIGraphicsGetCurrentContext();
    PADDING=(int)(0.1*self.bounds.size.width);
    int height=self.bounds.size.height;
    int width=self.bounds.size.width;
    double scaleFactor=height/100.0;            
    int y1, y2, y3, y4;
    int i=0;
    CGContextSetStrokeColorWithColor(context, gray);
    for(i=0;i<100;i++)
    {               
        if(i%6==0){
            CGContextMoveToPoint(context, 0, floor(i*scaleFactor));
            CGContextAddLineToPoint(context, width, floor(i*scaleFactor));
        }
    }
    for(i=0;i<drawPoints.count;i++)
    {
        CGContextMoveToPoint(context, horShift+i*scaleX, 0);
        CGContextAddLineToPoint(context, horShift+i*scaleX, height);
    }
    CGContextStrokePath(context);
    if(mode==RSI)
    {
        CGContextSetStrokeColorWithColor(context, blue);
        CGContextMoveToPoint(context, 0, height/2);
        CGContextAddLineToPoint(context, width, height/2);
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, red);
        [@"RSI" drawInRect:CGRectMake(10, 10, 50, 20) withFont:[UIFont systemFontOfSize:12]];   
        CGContextSetStrokeColorWithColor(context, green);
        for(i=0;i<drawPoints.count-1;i++){
            y1=abs([[drawPoints objectAtIndex:i] doubleValue]*scaleFactor-height);
            y2=abs([[drawPoints objectAtIndex:i+1] doubleValue]*scaleFactor-height);
            CGContextMoveToPoint(context, horShift+i*scaleX, y1);
            CGContextAddLineToPoint(context, horShift+(i+1)*scaleX, y2);
        }
        CGContextStrokePath(context);
        CGContextFillPath(context);
    }
    else
    {
        i=0;  
        CGContextSetFillColorWithColor(context, red);
        [@"Stochastic" drawInRect:CGRectMake(10, 20, 50, 20) withFont:[UIFont systemFontOfSize:12]];
        CGContextFillPath(context);
        CGContextSetStrokeColorWithColor(context, blue);
        CGContextMoveToPoint(context, 0, height/2+(int)(25*scaleFactor));
        CGContextAddLineToPoint(context, width, height/2+(int)(25*scaleFactor));
        CGContextMoveToPoint(context, 0, height/2-(int)(25*scaleFactor));
        CGContextAddLineToPoint(context, width, height/2-(int)(25*scaleFactor)); 
        CGContextStrokePath(context);
        for(int i=0;i<stochasticPoints.count-1;i++) {
            StochasticItem* item1=[stochasticPoints objectAtIndex:i];
            StochasticItem* item2=[stochasticPoints objectAtIndex:i+1];
            y1=abs([item1 slow]*scaleFactor-height);                
            y2=abs([item2 slow]*scaleFactor-height);
            y3=abs([item1 fast]*scaleFactor-height);
            y4=abs([item2 fast]*scaleFactor-height);  
            CGContextSetStrokeColorWithColor(context, red);
            CGContextMoveToPoint(context, horShift+i*scaleX, y1);
            CGContextAddLineToPoint(context, horShift+(i+1)*scaleX, y2);
            CGContextStrokePath(context);
            CGContextSetStrokeColorWithColor(context, blue); 
            CGContextMoveToPoint(context, horShift+i*scaleX, y3);
            CGContextAddLineToPoint(context, horShift+(i+1)*scaleX, y4);
            CGContextStrokePath(context);
        }        
    }
    CGContextSetFillColorWithColor(context, black);
    CGContextAddRect(context, CGRectMake(width-PADDING, 0, width, height));
    CGContextFillPath(context);
    CGContextSetFillColorWithColor(context, white);
    [@"90" drawInRect:CGRectMake(width-PADDING+3, (int)(height*0.1)-6, 50, 20) withFont:[UIFont systemFontOfSize:10]];
    [@"70" drawInRect:CGRectMake(width-PADDING+3, (int)(height*0.3)-6, 50, 20) withFont:[UIFont systemFontOfSize:10]];
    [@"50" drawInRect:CGRectMake(width-PADDING+3, height/2-6, 50, 20) withFont:[UIFont systemFontOfSize:10]];
    [@"30" drawInRect:CGRectMake(width-PADDING+3, (int)(height*0.7)-6, 50, 20) withFont:[UIFont systemFontOfSize:10]];
    [@"10" drawInRect:CGRectMake(width-PADDING+3, (int)(height*0.9)-6, 50, 20) withFont:[UIFont systemFontOfSize:10]];
    CGContextFillPath(context);
}
-(void)setParams:(int)hShift:(int)scX
{        
    self.horShift=hShift;
    self.scaleX=scX;
}    
-(void)setInputData:(NSMutableArray*)quotes
{        
    if(mode==RSI)
        drawPoints=[self RSI:quotes];
    else stochasticPoints=[self Stochastic:quotes];
    [self setNeedsDisplay];
}
-(NSMutableArray*)RSI:(NSMutableArray*)quotes
{
    NSMutableArray* result=[[NSMutableArray alloc] init];
    double closeValue1=0, closeValue2;
    double U, D, Up=1, Dp=1, RS, RSI;
    double Su, Sd, Sup=1, Sdp=1;
    double a=2.0/(quotes.count+1.0);
    for(int i=0;i<quotes.count-1;i++)
    {
        closeValue1=[[quotes objectAtIndex:i] closeValue];
        closeValue2=[[quotes objectAtIndex:i+1] closeValue];
        if(closeValue2>closeValue1)
        {
            U=closeValue2-closeValue1;
            D=0;
        }
        else
        {
            U=0;
            D=closeValue1-closeValue2;
        }
        Su=a*Up+(1.0-a)*Sup;
        Up=U;
        Sup=Su;
        Sd=a*Dp+(1.0-a)*Sdp;
        Dp=D;
        Sdp=Sd;
        if(Sd>0)
        {
            RS=Su/Sd;
            RSI=100.0-100.0/(1.0+RS);
        }
        else RSI=100.0;
        [result addObject:[NSNumber numberWithDouble:floor(RSI)]];
    }
    return result;
}    
-(NSMutableArray*) Stochastic:(NSMutableArray*)quotes
{
    NSMutableArray* result=[[NSMutableArray alloc] init];
    int periodsNum=4;
    double periodHigh, periodLow, closeValue;
    double a=2.0/(quotes.count+1.0);
    double fast, slow, slowPrev=1.0;
    for(int i=0;i<quotes.count-1;i++)
    {
        closeValue=[[quotes objectAtIndex:i] closeValue];
        NSArray* array;
        if(i<periodsNum)
            array=[quotes subarrayWithRange:NSMakeRange(0, periodsNum)];
        else array=[quotes subarrayWithRange:NSMakeRange(i-periodsNum, i)];            
        periodHigh=[self getMaxClose:array];
        periodLow=[self getMinClose:array];
        fast=(closeValue - periodLow) / (periodHigh - periodLow) * 100.0;
        slow=a*fast+(1.0-a)*slowPrev;
        slowPrev=slow;
        [result addObject:[StochasticItem newStochasticItem:floor(fast):floor(slow)]];        
    }
    return result;
}
-(double) getMinClose:(NSArray*)values
{
    double min=[[values objectAtIndex:0] closeValue], v;
    for(int i=1;i<values.count;i++)
    {
        v=[[values objectAtIndex:i] closeValue];
        if(v<min)
            min=v;
    }
    return min;
}
-(double) getMaxClose:(NSArray*)values
{
    double max=[[values objectAtIndex:0] closeValue], v;
    for(int i=1;i<values.count;i++)
    {
        v=[[values objectAtIndex:i] closeValue];
        if(v>max)
            max=v;
    }
    return max;
}
@end
