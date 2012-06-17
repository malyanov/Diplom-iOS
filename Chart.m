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
@synthesize blue, black, gray, red, white, green;  
//drag flags
@synthesize isDragging;
@synthesize startPoint;
@synthesize moveUpCounter, moveDownCounter, moveLeftCounter, moveRightCounter;    
@synthesize isFullscreen;    
@synthesize analyseChart;
@synthesize mScaleFactor;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
    [self drawGrid:context];
}
+(id) newChart:(AnalyseChart*)analyseChart:(bool)isFullscreen:(CGRect)frame{     
    Chart *chart=[[Chart alloc] initWithFrame:frame]; 
    chart.black=[UIColor blackColor].CGColor;    
    chart.blue=[UIColor blueColor].CGColor;    
    chart.white=[UIColor whiteColor].CGColor;    
    chart.red=[UIColor redColor].CGColor; 
    float components[4]={0.5,0.5,0.5,0.3};
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    chart.gray=CGColorCreate(space, components);
    chart.green=[UIColor greenColor].CGColor;
    chart.isFullscreen=isFullscreen;
    chart.analyseChart=analyseChart;
    chart.MAX_SCALE=60;
    chart.MIN_SCALE=10;
    chart.SCALE_DELTA=5;
    chart.MOVE_DELTA=2;
    chart.curScaleX=chart.MIN_SCALE;
    chart.curScaleY=(int)(0.4*chart.MIN_SCALE);   
    chart.curScaleX=chart.curScaleY=10;
    chart.PADDING=40;
    chart.backgroundColor=[UIColor whiteColor];
    return chart;
}
-(void)updateLastValue:(double)value{
    [[qList objectAtIndex:[qList count]-1] setCloseValue:value];
    [self setNeedsDisplay];
}
-(void) init:(NSMutableArray*)list{
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
    //isFullscreen=true;        
    qList=list;
    [self setNeedsDisplay];
}    
-(void) increaseScale{
    if(curScaleX+SCALE_DELTA<MAX_SCALE)
    {
        curScaleX+=SCALE_DELTA;
        curScaleY=(int) (0.4 * curScaleX);
        [self setNeedsDisplay];
    }
}
-(void) moveLeft{
    if(curPos-MOVE_DELTA>=0)
    {
        curPos-=MOVE_DELTA;            
        [self setNeedsDisplay];
    }
}
-(void) moveRight{
    int vertTicks=(self.bounds.size.width-PADDING)/curScaleX;
    if(curPos+MOVE_DELTA+vertTicks<[qList count])
    {
        curPos+=MOVE_DELTA;            
        [self setNeedsDisplay];
    }
}
-(void) changeViewMode:(Modes)m{
    mode=m;
    [self setNeedsDisplay];
}
-(void) setBidType:(QuotationType)type{
    bid=type;
    [self setNeedsDisplay];
}
-(void) decreaseScale{
    if(curScaleX-SCALE_DELTA>MIN_SCALE)
    {
        curScaleX-=SCALE_DELTA; 
        curScaleY=(int) (0.4 * curScaleX);
        [self setNeedsDisplay];
    }
}  
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    isDragging=true;
    startPoint=[touch locationInView:self];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if(isDragging)
    {
        if(abs(startPoint.x-[touch locationInView:self].x)>abs(startPoint.y-[touch locationInView:self].y))
        {
            if(startPoint.x>[touch locationInView:self].x)
                [self moveRight];
            else [self moveLeft];
        }
        else
        {
            if(startPoint.y<[touch locationInView:self].y)
                decreaseScale:;
            else increaseScale:;
        }
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    isDragging=false;
}
+(NSString*) getDateString:(NSDate*)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return  dateString;
}
-(void) drawGrid:(CGContextRef)context{  
    if(qList==nil||qList.count==0)
        return;
    if(firstRun){
        firstRun=false;
        PADDING=(int)(0.10*self.bounds.size.width);          
    }
    int graphWidth=self.bounds.size.width-PADDING;
    int graphHeight=self.bounds.size.height-PADDING;
    int vertTicks=graphWidth/curScaleX,          
    horTicks=graphHeight/curScaleY;      
    
    [self prepare:vertTicks+3];
    double valuesHeight=maxValue-minValue;
    double scaleFactor=graphHeight/valuesHeight;
    double horTickValue=valuesHeight/horTicks;
    int horShift=vertTicks*curScaleX-graphWidth;
    int vertShift=graphHeight-horTicks*curScaleY;
    int x,y;      
    [analyseChart setParams:horShift:curScaleX];
    [analyseChart setInputData:points];        
    CGContextStrokePath(context);
    CGContextFillPath(context);    
    double openValue=0, closeValue=0, highValue=0, lowValue=0;
    if([Settings getBollingerBands])
        [self drawBollingerBands:context:horShift:vertShift:self.bounds.size.height:scaleFactor];
    if([Settings getEMA])
        [self drawMA:context:horShift:vertShift:self.bounds.size.height:scaleFactor];
    CGContextSetStrokeColorWithColor(context, black);
    switch(mode){
        case CURVES:              
            for(int i=0;i<points.count-1;i++){  
                CGContextMoveToPoint(context, horShift+i*curScaleX, fabsf(([[points objectAtIndex:i] closeValue]-minValue)*scaleFactor-graphHeight)+vertShift);
                CGContextAddLineToPoint(context, horShift+(i+1)*curScaleX, fabsf(([[points objectAtIndex:i+1] closeValue]-minValue)*scaleFactor-graphHeight)+vertShift);                 
            }
            break;
        case CANDLES:
            {
                int cX,cY, cWidth, cHeight;
                for(int i=0;i<points.count;i++)
                {
                    CGContextSetStrokeColorWithColor(context, black);
                    CGContextMoveToPoint(context, horShift+i*curScaleX, fabsf(([[points objectAtIndex:i] highValue]-minValue)*scaleFactor-graphHeight)+vertShift);
                    CGContextAddLineToPoint(context, horShift+i*curScaleX, fabsf(([[points objectAtIndex:i] lowValue]-minValue)*scaleFactor-graphHeight)+vertShift);
                    CGContextStrokePath(context);
                    openValue=[[points objectAtIndex:i] openValue];
                    closeValue=[[points objectAtIndex:i] closeValue];
                    cX=horShift+i*curScaleX-2;
                    CGColorRef candlePaint;
                    if(openValue>closeValue){           
                        candlePaint=black;
                        cY=ceil(fabsf((openValue-minValue)*scaleFactor-graphHeight))+vertShift;
                    }
                    else{
                        candlePaint=white;
                        cY=ceil(fabsf((closeValue-minValue)*scaleFactor-graphHeight))+vertShift;
                    }                  
                    cWidth=4;
                    cHeight=abs((openValue-closeValue)*scaleFactor);
                    CGContextSetFillColorWithColor(context, candlePaint);
                    CGContextAddRect(context, CGRectMake(cX, cY, cWidth, cHeight)); 
                    CGContextFillPath(context);
                    CGContextSetStrokeColorWithColor(context, black);
                    CGRect rect=CGRectMake(cX, cY, cWidth, cHeight);
                    CGContextAddRect(context, rect);
                    CGContextStrokePath(context);                    
                }
            }
            break;
        case BARS:
            {
                int vpos=0;
                int barLevelWidth=curScaleX/2-2;
                for(int i=0;i<points.count;i++){                  
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
                    CGContextStrokePath(context); 
                }
            }
            break;
    } 
    CGContextStrokePath(context);
    CGContextFillPath(context);
    //
    CGContextSetFillColorWithColor(context, black);
    CGContextAddRect(context, CGRectMake(0, graphHeight, self.bounds.size.width, self.bounds.size.height)); 
    CGContextAddRect(context, CGRectMake(graphWidth, 0, self.bounds.size.width, self.bounds.size.height));
    CGContextFillPath(context);
    //
    int tail=0;
    CGContextSetFillColorWithColor(context, white);
    CGContextSetStrokeColorWithColor(context, gray);
    int margiTop=graphHeight+PADDING/4;
    for(int i=0;i<points.count;i++){
        x=horShift+i*curScaleX;
        if(i%(int)(MAX_SCALE/curScaleX+2)==0){
            NSString* str=[Chart getDateString:[[points objectAtIndex:i] dateTime]];
            [str drawInRect:CGRectMake(x-3, margiTop, 50, 20) withFont:[UIFont systemFontOfSize:9]];             
            tail=5;
        }
        else tail=0;
        CGContextMoveToPoint(context, x, 0);
        CGContextAddLineToPoint(context, x, graphHeight+tail);                  
    }  
    tail=0;
    NSString* strValue;    
    for(int j=0;j<horTicks;j++){
        y=vertShift+j*curScaleY;
        if(j%5==0){            
            tail=5;
            strValue=[NSString stringWithFormat:@"%.2f", maxValue-j*horTickValue];
            [strValue drawInRect:CGRectMake(graphWidth+(int)(0.15*PADDING), y, 50, 20) withFont:[UIFont systemFontOfSize:9]];            
        }
        else tail=0;
        CGContextMoveToPoint(context, 0, y);
        CGContextAddLineToPoint(context, graphWidth+tail, y);        
    } 
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, red);
    CGContextSetStrokeColorWithColor(context, red);
    [[Settings getInstrumentCode] drawInRect:CGRectMake(8, 8, 50, 10) withFont:[UIFont systemFontOfSize:12]];
    CGContextFillPath(context);
    double close=[[qList objectAtIndex:qList.count-1] closeValue]; 
    int curValue=fabs((close-minValue)*scaleFactor-graphHeight)+vertShift;//change  ot curent  
    if(curValue>graphHeight)
        curValue=graphHeight-1;
    if(curValue<=0)
        curValue=1;
    CGContextMoveToPoint(context, 0, curValue);
    CGContextAddLineToPoint(context, self.bounds.size.width, curValue);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, white);
    CGContextAddRect(context, CGRectMake(graphWidth, curValue, self.bounds.size.width, 15));
    CGContextFillPath(context);
    CGContextSetFillColorWithColor(context, red);
    [[NSString stringWithFormat:@"%.2f",[[qList objectAtIndex:qList.count-1] closeValue]] drawInRect:CGRectMake(self.bounds.size.width-PADDING+1, curValue+1, 50, 15) withFont:[UIFont systemFontOfSize:9]];
    CGContextFillPath(context);
}
-(void)drawBollingerBands:(CGContextRef)context:(int)horShift:(int)vertShift:(int)chartHeight:(double)scaleFactor{
    NSMutableArray* list=[[Analiser newAnaliser:points] BollingerBands:15];
    int x1, x2, y1, y2;
    for(int i=0;i<list.count-1;i++){
        BollingerBands *p1=[list objectAtIndex:i], *p2=[list objectAtIndex:(i+1)];
        x1=horShift+i*curScaleX;
        x2=horShift+(i+1)*curScaleX;
        y1=abs((p1.ml-minValue)*scaleFactor-chartHeight)-25;
        y2=abs((p2.ml-minValue)*scaleFactor-chartHeight)-25;
        CGContextSetStrokeColorWithColor(context, green);
        CGContextMoveToPoint(context, x1, y1);
        CGContextAddLineToPoint(context, x2, y2);
        CGContextStrokePath(context);
        
        CGContextSetStrokeColorWithColor(context, blue);
        CGContextMoveToPoint(context, x1, (int)(y1+p1.bl));
        CGContextAddLineToPoint(context, x2, (int)(y2+p2.bl));
        CGContextMoveToPoint(context, x1, (int)(y1+p1.tl));
        CGContextAddLineToPoint(context, x2, (int)(y2+p2.tl));
        CGContextStrokePath(context);
    }    
}
-(void)drawMA:(CGContextRef)context:(int)horShift:(int)vertShift:(int)chartHeight:(double)scaleFactor{    	
    NSMutableArray* list=[[Analiser newAnaliser:points] MA];
    int y1,y2;
    CGContextSetStrokeColorWithColor(context, red);
    for(int i=0;i<list.count-1;i++){        	
        y1=abs(([[list objectAtIndex:i] doubleValue]-minValue)*scaleFactor-chartHeight)-25;
        y2=abs(([[list objectAtIndex:i+1] doubleValue]-minValue)*scaleFactor-chartHeight)-25;
        CGContextMoveToPoint(context,horShift+i*curScaleX, y1);
        CGContextAddLineToPoint(context, horShift+(i+1)*curScaleX, y2);      	
    }
    CGContextStrokePath(context);
}
-(void) prepare:(int)num{
    Quotation *q=[qList objectAtIndex:curPos];
    minValue=[q lowValue];
    maxValue=[q highValue];
    [points removeAllObjects];        
    if(curPos+num>qList.count)
        num=qList.count-curPos;
    for(int i=curPos;i<curPos+num;i++){
        q=[qList objectAtIndex:i];
        if([q highValue]>maxValue) maxValue=[q highValue];
        if([q lowValue]<minValue) minValue=[q lowValue];
        [points addObject:q];
    }       
}
@end
