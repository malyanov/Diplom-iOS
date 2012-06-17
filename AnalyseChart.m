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
    float components[4]={0.5,0.5,0.5,0.3};
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    chart.gray=CGColorCreate(space, components);
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
    switch (mode) {
        case Stochastic:
            [self drawStochastic:context:scaleFactor];
            break;
        case  RSI:
            [self drawRSI:context:scaleFactor];
            break;
        case Momentum:
            [self drawMomentum:context];
            break;
        default:
            break;
    }    
}
-(void)drawRSI:(CGContextRef)context:(double)scaleFactor{
    int height=self.bounds.size.height;
    int width=self.bounds.size.width;
    int y1, y2;
    CGContextSetStrokeColorWithColor(context, blue);
    CGContextMoveToPoint(context, 0, height/2);
    CGContextAddLineToPoint(context, width, height/2);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, red);
    [@"RSI" drawInRect:CGRectMake(10, 10, 50, 20) withFont:[UIFont systemFontOfSize:12]];   
    CGContextSetStrokeColorWithColor(context, green);
    for(int i=0;i<drawPoints.count-1;i++){
        y1=abs([[drawPoints objectAtIndex:i] doubleValue]*scaleFactor-height);
        y2=abs([[drawPoints objectAtIndex:i+1] doubleValue]*scaleFactor-height);
        CGContextMoveToPoint(context, horShift+i*scaleX, y1);
        CGContextAddLineToPoint(context, horShift+(i+1)*scaleX, y2);
    }
    CGContextStrokePath(context);
    CGContextFillPath(context);
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
-(void)drawStochastic:(CGContextRef)context :(double)scaleFactor{
    int height=self.bounds.size.height;
    int width=self.bounds.size.width;
    int y1, y2, y3, y4;
    CGContextSetStrokeColorWithColor(context, blue);
    CGContextMoveToPoint(context, 0, height/2+(int)(25*scaleFactor));
    CGContextAddLineToPoint(context, width, height/2+(int)(25*scaleFactor));
    CGContextMoveToPoint(context, 0, height/2-(int)(25*scaleFactor));
    CGContextAddLineToPoint(context, width, height/2-(int)(25*scaleFactor)); 
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, red);
    [@"Stochastic" drawInRect:CGRectMake(10, 5, 150, 20) withFont:[UIFont systemFontOfSize:12]];
    CGContextFillPath(context);
    for(int i=0;i<drawPoints.count-1;i++) {
        StochasticItem* item1=[drawPoints objectAtIndex:i];
        StochasticItem* item2=[drawPoints objectAtIndex:i+1];
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
-(void)drawMomentum:(CGContextRef)context{
       	int y1, y2, i;    	    	
        double max, min, curVal;    
        int height=self.bounds.size.height;
        int width=self.bounds.size.width;
        max=min=[[drawPoints objectAtIndex:0] doubleValue];
        CGContextSetStrokeColorWithColor(context, gray);
        for(i=0;i<drawPoints.count;i++){
            curVal=[[drawPoints objectAtIndex:i] doubleValue];
        	if(curVal>max)
        		max=curVal;
        	if(curVal<min)
        		min=curVal;            
            CGContextMoveToPoint(context, horShift+i*scaleX, 0);
            CGContextAddLineToPoint(context, horShift+i*scaleX, height);
        }
        CGContextStrokePath(context);
        double delta=max-min;
        double scaleFactor=height/delta;
        CGContextSetStrokeColorWithColor(context, green);
        for(i=0;i<drawPoints.count-1;i++){
            y1=(int)abs([[drawPoints objectAtIndex:i] doubleValue]*scaleFactor-height/2);
            y2=(int)abs([[drawPoints objectAtIndex:(i+1)] doubleValue]*scaleFactor-height/2);
            CGContextMoveToPoint(context, horShift+i*scaleX, y1);
            CGContextAddLineToPoint(context, horShift+(i+1)*scaleX, y2);
        }
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, black);
        CGContextAddRect(context, CGRectMake(width-PADDING, 0, width, height));
        CGContextFillPath(context);
        int x=width-PADDING+2, y;        
        for(i=0;i<10;i++){
        	y=(int)(height*0.1*i)+10;
            CGContextSetFillColorWithColor(context, white);
            [[NSString stringWithFormat:@"%.2f",(max-delta/10.0*i)] drawInRect:CGRectMake(x, y, 50, 20) withFont:[UIFont systemFontOfSize:10]];
        	//canvas.drawText(df.format(max-delta/10.0*i), x, y, white);
            CGContextSetFillColorWithColor(context, gray);
            CGContextMoveToPoint(context, 0, y);
            CGContextAddLineToPoint(context, width-PADDING, y);
        }  
        CGContextFillPath(context);
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, red);
        [@"Momentum" drawInRect:CGRectMake(10, 5, 150, 20) withFont:[UIFont systemFontOfSize:12]];
        CGContextFillPath(context);
}
-(void)setParams:(int)hShift:(int)scX
{        
    self.horShift=hShift;
    self.scaleX=scX;
}    
-(void)setInputData:(NSMutableArray*)quotes{  
    Analiser *analiser=[Analiser newAnaliser:quotes];
    switch (mode) {
        case RSI:
            drawPoints=[analiser RSI];
            break;
        case Stochastic:
            drawPoints=[analiser stochastic];
            break;
        case Momentum:
            drawPoints=[analiser momentum];
            break;
        default:
            break;
    }     
    [self setNeedsDisplay];
}    
@end
