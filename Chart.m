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
    CGFloat rgba[]={1.0,0.0,0.0,1.0};
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextSetFillColorWithColor(context, CGColorCreate(space, rgba));
    CGContextFillRect(context, self.bounds);    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 50, 50);
    CGFloat lineColor[]={0.0,1.0,0.0,1.0};
    CGContextSetStrokeColorWithColor(context, CGColorCreate(space, lineColor));
    CGContextStrokePath(context);
    CGColorSpaceRelease(space);
}
+(id) newChart:(AnalyseChart*)analyseChart:(bool)isFullscreen
{     
    Chart *chart=[[Chart alloc] init];
    [chart setAnalyseChart:analyseChart];
    //setOnTouchListener(onTouch);
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGFloat blackRGBA[]={0.0,0.0,0.0,1.0};
    [chart setBlack:CGColorCreate(space, blackRGBA)];
    CGFloat blueRGBA[]={0.0,0.0,1.0,1.0};
    [chart setBlue:CGColorCreate(space, blueRGBA)];
    CGFloat whiteRGBA[]={1.0,1.0,1.0,1.0};
    [chart setWhite:CGColorCreate(space, whiteRGBA)];
    CGFloat redRGBA[]={0.0,0.0,0.0,1.0};
    [chart setRed:CGColorCreate(space, redRGBA)];
    CGFloat grayRGBA[]={0.0,0.0,0.0,1.0};
    [chart setGray:CGColorCreate(space, grayRGBA)];
    [chart setIsFullscreen:isFullscreen];
    [chart setAnalyseChart:analyseChart];
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
/*private OnTouchListener onTouch=new OnTouchListener() {		
    @Override
    public boolean onTouch(View v, MotionEvent event) {
        mScaleDetector.onTouchEvent(event);
        if(event.getAction()==MotionEvent.ACTION_DOWN)
        {
            isDragging=true;
            startPoint.x=(int)event.getX();
            startPoint.y=(int)event.getY();
            Log.i("down", "action down");
        }
        else if(event.getAction()==MotionEvent.ACTION_MOVE)
        {
            if(isDragging)
            {
                if(Math.abs(startPoint.x-(int)event.getX())>Math.abs(startPoint.y-(int)event.getY()))
                {
                    if(startPoint.x>event.getX())
                        moveRight();
                    else moveLeft();
                }
                else
                {
                    if(startPoint.y<event.getY())
                        decreaseScale();
                    else increaseScale();
                }
                Log.i("move", "action move x="+event.getX()+"; y="+event.getY());
            }
        }
        else if(event.getAction()==MotionEvent.ACTION_UP)
        {
            isDragging=false;
            Log.i("up", "action up");
        }
        return isFullscreen;
    }
};*/
+(NSString*) getDateString:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];    
    return  dateString;
}
-(void) drawGrid:(CGContextRef)g
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
    CGContextSetStrokeColorWithColor(g, black);
    CGContextAddRect(g, CGRectMake(0, graphHeight, self.bounds.size.width, self.bounds.size.height)); 
    CGContextAddRect(g, CGRectMake(graphWidth, 0, self.bounds.size.width, self.bounds.size.height));
    //
    if(qList==nil||qList.count==0)
        return;
    prepare(vertTicks+2);
    double valuesHeight=maxValue-minValue;
    double scaleFactor=graphHeight/valuesHeight;
    double horTickValue=valuesHeight/horTicks;
    int horShift=vertTicks*curScaleX-graphWidth;
    int vertShift=graphHeight-horTicks*curScaleY;
    int x,y;      
    //analyseChart.setParams(horShift, curScaleX);
    //analyseChart.setInputData(points);
    int tail=0;
    CGContextSetStrokeColorWithColor(g, gray);
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
        CGContextMoveToPoint(g, x, 0);
        CGContextAddLineToPoint(g, x, graphHeight+tail);                  
    }    
    tail=0;
    NSString* strValue;    
    for(int j=0;j<horTicks;j++)
    {
        y=vertShift+j*curScaleY;
        CGContextSetStrokeColorWithColor(g, white);
        if(j%10==0)
        {            
            tail=5;
            strValue=[NSString stringWithFormat:@"%d", maxValue-j*horTickValue];
            if(strValue.length>7)
                strValue=[strValue substringWithRange:NSRangeFromString(@"0,7")];
            [strValue drawInRect:CGRectMake(graphWidth+(int)(0.2*PADDING), y, 50, 20) withFont:[UIFont systemFontOfSize:8]];            
        }
        else tail=0;
        CGContextSetStrokeColorWithColor(g, gray);
        CGContextMoveToPoint(g, 0, y);
        CGContextAddLineToPoint(g, graphWidth+tail, y);        
    }
    double openValue=0, closeValue=0, highValue=0, lowValue=0;      
    switch(mode)
    {
        case CURVES:              
            for(int i=0;i<points.count-1;i++)
            {                  
                g.drawLine(horShift+i*curScaleX, (int)Math.abs((points.get(i).closeValue-minValue)*scaleFactor-graphHeight)+vertShift, 
                           horShift+(i+1)*curScaleX, (int)Math.abs((points.get(i+1).closeValue-minValue)*scaleFactor-graphHeight)+vertShift, black);
            }
            break;
        case CANDLES:
            int cX,cY, cWidth, cHeight;
            for(int i=0;i<points.size();i++)
            {
                g.drawLine(horShift+i*curScaleX, (int)Math.abs((points.get(i).highValue-minValue)*scaleFactor-graphHeight)+vertShift, 
                           horShift+i*curScaleX, (int)Math.abs((points.get(i).lowValue-minValue)*scaleFactor-graphHeight)+vertShift, black);
                openValue=points.get(i).openValue;
                closeValue=points.get(i).closeValue;
                cX=horShift+i*curScaleX-2;
                Paint candlePaint;
                if(openValue>closeValue)
                {           
                    candlePaint=black;
                    cY=(int)Math.ceil(Math.abs((openValue-minValue)*scaleFactor-graphHeight))+vertShift;
                }
                else
                {
                    candlePaint=white;
                    cY=(int)Math.ceil(Math.abs((closeValue-minValue)*scaleFactor-graphHeight))+vertShift;
                }                  
                cWidth=4;
                cHeight=Math.abs((int)((openValue-closeValue)*scaleFactor));
                g.drawRect(cX, cY, cX+cWidth, cY+cHeight, candlePaint);
                black.setStyle(Style.STROKE);
                g.drawRect(cX, cY, cX+cWidth, cY+cHeight, black);
                black.setStyle(Style.FILL_AND_STROKE);
            }
            break;
        case BARS:
            int vpos=0;
            int barLevelWidth=curScaleX/2-2;
            for(int i=0;i<points.size();i++)
            {                  
                openValue=points.get(i).openValue;
                closeValue=points.get(i).closeValue;
                lowValue=points.get(i).lowValue;
                highValue=points.get(i).highValue;
                Paint barPaint;
                if(openValue<closeValue)
                    barPaint=blue;
                else barPaint=black;
                g.drawLine(horShift+i*curScaleX, (int)Math.abs((highValue-minValue)*scaleFactor-graphHeight)+vertShift, 
                           horShift+i*curScaleX, (int)Math.abs((lowValue-minValue)*scaleFactor-graphHeight)+vertShift, barPaint);
                vpos=(int)Math.abs((openValue-minValue)*scaleFactor-graphHeight)+vertShift;
                g.drawLine(horShift+i*curScaleX-barLevelWidth,vpos , horShift+i*curScaleX, vpos, barPaint);
                vpos=(int)Math.abs((closeValue-minValue)*scaleFactor-graphHeight)+vertShift;
                g.drawLine(horShift+i*curScaleX,vpos , horShift+i*curScaleX+barLevelWidth, vpos, barPaint);
            }
            break;
    }      
    g.drawText(Settings.instrumentCode, 20, 20, red);
    int curValue=(int)Math.abs((qList.get(qList.size()-1).closeValue-minValue)*scaleFactor-graphHeight)+vertShift;//change  ot curent      
    g.drawLine(0, curValue, this.getWidth(), curValue, red);      
    g.drawRect(graphWidth, curValue, this.getWidth(), curValue+15, white);      
    g.drawText(String.valueOf(qList.get(qList.size()-1).closeValue), this.getWidth()-PADDING+5, curValue+12, red);
    
}
private void prepare(int num){
    Quotation q=qList.get(curPos);
    maxValue=minValue=q.lowValue;
    points.clear();        
    if(curPos+num>qList.size())
        num=qList.size()-curPos;
    for(int i=curPos;i<curPos+num;i++)
    {
        q=qList.get(i);
        if(q.lowValue>maxValue) maxValue=q.lowValue;
        if(q.lowValue<minValue) minValue=q.lowValue;
        points.add(q);
    }        
    //info="max="+maxValue+"; min="+minValue;        
}        
public void setInfo(String info){
    this.info=info;
}
@Override
protected void onDraw(Canvas canvas) {    	
    super.onDraw(canvas);
    drawGrid(canvas);
} 
@end
