//
//  Analiser.m
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Analiser.h"
@implementation Analiser
@synthesize quotes;
+(id)newAnaliser:(NSMutableArray *)quotes{
    Analiser *analiser=[[Analiser alloc] init];
    analiser.quotes=quotes;
    return analiser;
}
-(NSMutableArray*)RSI{
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
-(NSMutableArray*)stochastic{
    NSMutableArray* result=[[NSMutableArray alloc] init];
    int periodsNum=4;
    double periodHigh, periodLow, closeValue;
    double a=2.0/(quotes.count+1.0);
    double fast, slow, slowPrev=1.0;
    for(int i=0;i<quotes.count;i++)
    {
        closeValue=[[quotes objectAtIndex:i] closeValue];
        NSArray* array;
        if(i<periodsNum)
            array=[quotes subarrayWithRange:NSMakeRange(0, periodsNum)];
        else array=[quotes subarrayWithRange:NSMakeRange(i-periodsNum, periodsNum)];            
        periodHigh=[self getMaxClose:array];
        periodLow=[self getMinClose:array];
        fast=(double)abs(closeValue - periodLow)/ (periodHigh - periodLow) * 100.0;
        slow=a*fast+(1.0-a)*slowPrev;
        slowPrev=slow;
        [result addObject:[StochasticItem newStochasticItem:floor(fast):(int)floor(slow)%100]];        
    }
    
//    List<StochasticItem> result=new ArrayList<StochasticItem>();
//    int periodsNum=4;
//    double periodHigh, periodLow, closeValue;
//    double a=2.0/(quotes.size()+1.0);
//    double fast, slow, slowPrev=1.0;
//    for(int i=0;i<quotes.size()-1;i++){
//        closeValue=quotes.get(i).closeValue;
//        if(i<periodsNum){
//            periodHigh=getMaxClose(quotes.subList(0, periodsNum));
//            periodLow=getMinClose(quotes.subList(0, periodsNum));
//        }
//        else{
//            periodHigh=getMaxClose(quotes.subList(i-periodsNum, i));
//            periodLow=getMinClose(quotes.subList(i-periodsNum, i));
//        }
//        fast=Math.abs(closeValue - periodLow) / (periodHigh - periodLow) * 100.0;
//        if(fast<0)
//            Log.i("stochastic","fast="+fast);
//        slow=a*fast+(1.0-a)*slowPrev;
//        slowPrev=slow;
//        result.add(new StochasticItem((int)Math.floor(slow), (int)Math.floor(fast)%100));
//    }
//    return result;
    
    
    return result;
}
-(NSMutableArray*)momentum{
    NSMutableArray *result=[[NSMutableArray alloc] init];    
    int periodsNum=4;
    double nowPrice, prevPrice;
    for(int i=0;i<quotes.count;i++){
        nowPrice=[[quotes objectAtIndex:i] closeValue];
        if(i<periodsNum)
            prevPrice=[[quotes objectAtIndex:0] closeValue];
        else prevPrice=[[quotes objectAtIndex:(i-periodsNum)] closeValue];            
        [result addObject:[NSNumber numberWithDouble:((nowPrice-prevPrice)/prevPrice*100.0)]];
    }
    return result;
}
-(NSMutableArray*)MA{//exponetial moving average
    NSMutableArray *result=[[NSMutableArray alloc] init];
    int periodsNum=4;
    double a=2.0/(periodsNum+1.0);
    double ema, emaPrev=[self getAvgClose:[quotes subarrayWithRange:NSMakeRange(0, periodsNum)]], periodAvg;
    for(int i=0;i<quotes.count;i++){
        if(i<periodsNum)
            periodAvg=[self getAvgClose:[quotes subarrayWithRange:NSMakeRange(0, periodsNum)]];
        else periodAvg=[self getAvgClose:[quotes subarrayWithRange:NSMakeRange(i-periodsNum, periodsNum)]];
        ema=a*periodAvg+(1.0-a)*emaPrev;
        emaPrev=ema;
        [result addObject:[NSNumber numberWithDouble:ema]];
    }
    return result;
}
-(NSMutableArray*)BollingerBands:(int)D{
    NSMutableArray *result=[[NSMutableArray alloc] init];
    int periodsNum=4;
    double StdDev;        
    double ml, tl, bl;
    NSArray* values;
    for(int i=0;i<quotes.count;i++){
        if(i<periodsNum)
            values=[quotes subarrayWithRange:NSMakeRange(0, periodsNum)];
        else values=[quotes subarrayWithRange:NSMakeRange(i-periodsNum, periodsNum)];            
        ml=[self getAvgClose:values];
        StdDev=[self calcStdDev:ml:quotes];
        tl=D*StdDev;
        bl=-D*StdDev;
        [result addObject:[BollingerBands newBollingerBands:ml:tl:bl]];
    }
    return result;
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
//StdDev = SQRT (SUM ((CLOSE ñ SMA (CLOSE, N))^2, N)/N),
-(double)calcStdDev:(double)sma:(NSArray*)values{
    double sum=0;
    for(Quotation *q in values)
        sum+=pow(q.closeValue-sma,2.0);
    return sqrt(sum/values.count);
}
-(double)getAvgClose:(NSArray*)values{
    double sum=0;
    for(Quotation *q in values)
        sum+=q.closeValue;
    return sum/values.count;
}

@end
