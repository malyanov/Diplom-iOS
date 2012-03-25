//
//  Chart.m
//  diplom
//
//  Created by Mac on 17.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Chart.h"
#import "Settings.h"

@implementation Chart
@synthesize MAX_SCALE, MIN_SCALE, MOVE_DELTA, SCALE_DELTA, PADDING;
@synthesize firstRun;
@synthesize qList;
@synthesize curScaleX, curScaleY, curPos;
@synthesize maxValue, minValue;
@synthesize points;
@synthesize info;    
@synthesize mode;
@synthesize bid;
@synthesize blue, black, gray, red, white;  
//drag flags
@synthesize isDragging;
@synthesize startPoint;
@synthesize moveUpCounter, moveDownCounter, moveLeftCounter, moveRightCounter;    
@synthesize isFullscreen;    
@synthesize analyseChart;
@synthesize mScaleFactor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    /*CGFloat rgba[]={1.0,0.0,0.0,1.0};
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextSetFillColorWithColor(context, CGColorCreate(space, rgba));
    CGContextFillRect(context, self.bounds);    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 50, 50);
    CGFloat lineColor[]={0.0,1.0,0.0,1.0};
    CGContextSetStrokeColorWithColor(context, CGColorCreate(space, lineColor));
    CGContextStrokePath(context);
    CGColorSpaceRelease(space);*/
    [self drawGrid:context];
}
+(id) newChart:(AnalyseChart*)analyseChart:(bool)isFullscreen:(CGRect)frame
{     
    Chart *chart=[[Chart alloc] initWithFrame:frame];
    [chart setAnalyseChart:analyseChart];
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGFloat blackRGBA[]={0.0,0.0,0.0,1.0};
    [chart setBlack:CGColorCreate(space, blackRGBA)];
    CGFloat blueRGBA[]={0.0,0.0,1.0,1.0};
    [chart setBlue:CGColorCreate(space, blueRGBA)];
    CGFloat whiteRGBA[]={1.0,1.0,1.0,1.0};
    [chart setWhite:CGColorCreate(space, whiteRGBA)];
    CGFloat redRGBA[]={0.0,0.0,0.0,1.0};
    [chart setRed:CGColorCreate(space, redRGBA)];
    CGFloat grayRGBA[]={0.7,0.7,0.7,1.0};
    [chart setGray:CGColorCreate(space, grayRGBA)];
    [chart setIsFullscreen:isFullscreen];
    [chart setAnalyseChart:analyseChart];
    CGColorSpaceRelease(space);
    chart.curScaleX=chart.curScaleY=1;
    return chart;
}
-(void)updateLastValue:(double)value
{
    [[qList objectAtIndex:[qList count]-1] setCurrentValue:value];
    [self setNeedsDisplay];
}
-(void) init:(NSMutableArray*)list
{
    firstRun=true;        
    curPos=0;
    maxValue=0;
    minValue=0;
    points=[[NSMutableArray alloc] init];
    info=@"";        
    mode=[Settings getChartMode];
    bid=[Settings getBidType];
    //drag flags
    isDragging=false;
    startPoint=CGPointMake(0, 0);
    moveUpCounter=0;
    moveDownCounter=0;
    moveLeftCounter=0;
    moveRightCounter=0;        
    isFullscreen=true;        
    qList=list;
    [self setNeedsDisplay];
}    
-(void) increaseScale
{
    if(curScaleX+SCALE_DELTA<MAX_SCALE)
    {
        curScaleX+=SCALE_DELTA;
        curScaleY=(int) (0.4 * curScaleX);
        [self setNeedsDisplay];
    }
}
-(void) moveLeft
{
    if(curPos-MOVE_DELTA>=0)
    {
        curPos-=MOVE_DELTA;            
        [self setNeedsDisplay];
    }
}
-(void) moveRight
{
    int vertTicks=(self.bounds.size.width-PADDING)/curScaleX;
    if(curPos+MOVE_DELTA+vertTicks<[qList count])
    {
        curPos+=MOVE_DELTA;            
        [self setNeedsDisplay];
    }
}
-(void) changeViewMode:(Modes)m
{
    mode=m;
    [self setNeedsDisplay];
}
-(void) setBidType:(QuotationType)type
{
    bid=type;
    [self setNeedsDisplay];
}
-(void) decreaseScale
{
    if(curScaleX-SCALE_DELTA>MIN_SCALE)
    {
        curScaleX-=SCALE_DELTA; 
        curScaleY=(int) (0.4 * curScaleX);
        [self setNeedsDisplay];
    }
}  
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    isDragging=true;
    startPoint=[touch locationInView:self];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(isDragging)
    {
        if(abs(startPoint.x-[touch locationInView:self].x)>abs(startPoint.y-[touch locationInView:self].y))
        {
            if(startPoint.x>[touch locationInView:self].x)
                moveRight:;
            else moveLeft:;
        }
        else
        {
            if(startPoint.y<[touch locationInView:self].y)
                decreaseScale:;
            else increaseScale:;
        }
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    isDragging=false;
}
+(NSString*) getDateString:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];    
    return  dateString;
}
-(void) drawGrid:(CGContextRef)context
{      
    if(firstRun)
    {
        firstRun=false;
        PADDING=(int)(0.08*self.bounds.size.width);          
    }
    int graphWidth=self.bounds.size.width-PADDING;
    int graphHeight=self.bounds.size.height-PADDING;
    int vertTicks=graphWidth/curScaleX,          
    horTicks=graphHeight/curScaleY;      
    //
    CGContextSetStrokeColorWithColor(context, black);
    CGContextAddRect(context, CGRectMake(0, graphHeight, self.bounds.size.width, self.bounds.size.height)); 
    CGContextAddRect(context, CGRectMake(graphWidth, 0, self.bounds.size.width, self.bounds.size.height));
    //
    if(qList==nil||qList.count==0)
        return;
    [self prepare:vertTicks+2];
    double valuesHeight=maxValue-minValue;
    double scaleFactor=graphHeight/valuesHeight;
    double horTickValue=valuesHeight/horTicks;
    int horShift=vertTicks*curScaleX-graphWidth;
    int vertShift=graphHeight-horTicks*curScaleY;
    int x,y;      
    //analyseChart.setParams(horShift, curScaleX);
    //analyseChart.setInputData(points);
    int tail=0;
    CGContextSetStrokeColorWithColor(context, gray);
    for(int i=0;i<points.count;i++)
    {
        x=horShift+i*curScaleX;
        if(i%(int)(MAX_SCALE/curScaleX+2)==0)
        {
            NSString* str=[Chart getDateString:[[points objectAtIndex:i] dateTime]];
            [str drawInRect:CGRectMake(x-50, graphHeight+PADDING/2+3, 50, 20) withFont:[UIFont systemFontOfSize:8]];             
            tail=5;
        }
        else tail=0;
        CGContextMoveToPoint(context, x, 0);
        CGContextAddLineToPoint(context, x, graphHeight+tail);                  
    }    
    tail=0;
    NSString* strValue;    
    for(int j=0;j<horTicks;j++)
    {
        y=vertShift+j*curScaleY;
        CGContextSetStrokeColorWithColor(context, white);
        if(j%10==0)
        {            
            tail=5;
            strValue=[NSString stringWithFormat:@"%d", maxValue-j*horTickValue];
            if(strValue.length>7)
                strValue=[strValue substringWithRange:NSRangeFromString(@"0,7")];
            [strValue drawInRect:CGRectMake(graphWidth+(int)(0.2*PADDING), y, 50, 20) withFont:[UIFont systemFontOfSize:8]];            
        }
        else tail=0;
        CGContextSetStrokeColorWithColor(context, gray);
        CGContextMoveToPoint(context, 0, y);
        CGContextAddLineToPoint(context, graphWidth+tail, y);        
    }
    CGContextSetStrokeColorWithColor(context, black);
    double openValue=0, closeValue=0, highValue=0, lowValue=0;      
    switch(mode)
    {
        case CURVES:              
            for(int i=0;i<points.count-1;i++)
            {  
                CGContextMoveToPoint(context, horShift+i*curScaleX, fabsf(([[points objectAtIndex:i] closeValue]-minValue)*scaleFactor-graphHeight)+vertShift);
                CGContextAddLineToPoint(context, horShift+(i+1)*curScaleX, fabsf(([[points objectAtIndex:i+1] closeValue]-minValue)*scaleFactor-graphHeight)+vertShift);                 
            }
            break;
        case CANDLES:
            {
                int cX,cY, cWidth, cHeight;
                for(int i=0;i<points.count;i++)
                {
                    CGContextMoveToPoint(context, horShift+i*curScaleX, fabsf(([[points objectAtIndex:i] highValue]-minValue)*scaleFactor-graphHeight)+vertShift);
                    CGContextAddLineToPoint(context, horShift+i*curScaleX, fabsf(([[points objectAtIndex:i] lowValue]-minValue)*scaleFactor-graphHeight)+vertShift);                   
                    openValue=[[points objectAtIndex:i] openValue];
                    closeValue=[[points objectAtIndex:i] closeValue];
                    cX=horShift+i*curScaleX-2;
                    CGColorRef candlePaint;
                    if(openValue>closeValue)
                    {           
                        candlePaint=black;
                        cY=ceil(fabsf(openValue-minValue)*scaleFactor-graphHeight)+vertShift;
                    }
                    else
                    {
                        candlePaint=white;
                        cY=ceil(fabsf(closeValue-minValue)*scaleFactor-graphHeight)+vertShift;
                    }                  
                    cWidth=4;
                    cHeight=abs((openValue-closeValue)*scaleFactor);
                    CGContextSetStrokeColorWithColor(context, candlePaint);
                    CGContextAddRect(context, CGRectMake(cX, cY, cX+cWidth, cY+cHeight)); 
                    CGContextSetStrokeColorWithColor(context, black);
                    CGRect rect=CGRectMake(cX, cY, cX+cWidth, cY+cHeight);
                    CGContextAddRect(context, rect);
                    CGContextFillRect(context, rect);                    
                }
            }
            break;
        case BARS:
            {
                int vpos=0;
                int barLevelWidth=curScaleX/2-2;
                for(int i=0;i<points.count;i++)
                {                  
                    openValue=[[points objectAtIndex:i] openValue];
                    closeValue=[[points objectAtIndex:i] closeValue];
                    lowValue=[[points objectAtIndex:i] lowValue];
                    highValue=[[points objectAtIndex:i] highValue];
                    CGColorRef barPaint;
                    if(openValue<closeValue)
                        barPaint=blue;
                    else barPaint=black;
                    CGContextSetStrokeColorWithColor(context, barPaint);
                    CGContextMoveToPoint(context, horShift+i*curScaleX, abs((highValue-minValue)*scaleFactor-graphHeight)+vertShift);
                    CGContextAddLineToPoint(context, horShift+i*curScaleX, abs((lowValue-minValue)*scaleFactor-graphHeight)+vertShift);
                    vpos=abs((openValue-minValue)*scaleFactor-graphHeight)+vertShift;
                    CGContextMoveToPoint(context, horShift+i*curScaleX-barLevelWidth,vpos);
                    CGContextAddLineToPoint(context, horShift+i*curScaleX, vpos);                    
                    vpos=abs((closeValue-minValue)*scaleFactor-graphHeight)+vertShift;
                    CGContextMoveToPoint(context, horShift+i*curScaleX,vpos);
                    CGContextAddLineToPoint(context, horShift+i*curScaleX+barLevelWidth, vpos);
                }
            }
            break;
    } 
    CGContextSetStrokeColorWithColor(context, red);
    [[Settings getInstrumentCode] drawInRect:CGRectMake(20, 20, 50, 20) withFont:[UIFont systemFontOfSize:8]];
    int curValue=abs(([[qList objectAtIndex:qList.count-1] closeValue]-minValue)*scaleFactor-graphHeight)+vertShift;//change  ot curent      
    CGContextMoveToPoint(context, 0, curValue);
    CGContextAddLineToPoint(context, self.bounds.size.width, curValue);
    CGContextSetStrokeColorWithColor(context, white);
    CGContextAddRect(context, CGRectMake(graphWidth, curValue, self.bounds.size.width, curValue+15));
    CGContextSetStrokeColorWithColor(context, red);
    [[NSString stringWithFormat:@"%d",[[qList objectAtIndex:qList.count-1] closeValue]] drawInRect:CGRectMake(self.bounds.size.width-PADDING+5, curValue+12, 50, 20) withFont:[UIFont systemFontOfSize:8]];
    
}
-(void) prepare:(int)num
{
    Quotation *q=[qList objectAtIndex:curPos];
    maxValue=minValue=[q lowValue];
    [points removeAllObjects];        
    if(curPos+num>qList.count)
        num=qList.count-curPos;
    for(int i=curPos;i<curPos+num;i++)
    {
        q=[qList objectAtIndex:i];
        if([q lowValue]>maxValue) maxValue=[q lowValue];
        if([q lowValue]<minValue) minValue=[q lowValue];
        [points addObject:q];
    }        
    //info="max="+maxValue+"; min="+minValue;        
}
@end
