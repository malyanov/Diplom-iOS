//
//  HistoryLoader.m
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryLoader.h"

@implementation HistoryLoader
static int HOUR_BID_ID=7, DAY_BID_ID=8;
static NSString* serverAddress=@"http://195.128.78.52/";
+(id)newHistoryLoader{
    HistoryLoader* loader=[[HistoryLoader alloc] init];
    return loader;
}
-(NSString*)genQuery:(int)marketId:(int)emitentId:(NSString*)emitentCode:(NSDate*)startDate:(NSDate*)finishDate:(int)period{
    NSString* filename=[self getFileName:emitentCode:startDate:finishDate];
    NSDateComponents *startDateComp = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:startDate];    
    NSDateComponents *finishDateComp = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:finishDate];
    NSString* result=[NSString stringWithFormat:@"%@%@.txt?d=d&market=%d&em=%d&df=%d&mf=%d&yf=%d&dt=%d&mt=%d&yt=%d&p=%d&f=%@&e=.txt&cn=%@&dtf=1&tmf=1&MSOR=0&sep=1&sep2=1&datf=2&at=1&fps=1", serverAddress, filename, marketId, emitentId, [startDateComp day], [startDateComp month]-1, [startDateComp year], [finishDateComp day], [finishDateComp month]-1, [finishDateComp year], period, filename, emitentCode];    
    return result;        
}
-(NSString*)getFileName:(NSString*)emitentCode:(NSDate*)start:(NSDate*)finish{    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"_yyMMdd"];    
    NSString* result=emitentCode;    
    result=[result stringByAppendingString:[dateFormat stringFromDate:start]];
    result=[result stringByAppendingString:[dateFormat stringFromDate:finish]];        
    return result;
}
-(void)load:(int)marketId:(int)emitentId:(NSString*)emitentCode:(NSDate*)start:(QuotationType)bidType{
    int period=HOUR_BID_ID;
    if(bidType==Day_Bid)
        period=DAY_BID_ID;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);    
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSString *fileName = [NSString stringWithFormat:@"%@/data.txt", documentsDirectory];
    //BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fileName];
    //debug
    if([Settings getChanged]){
        [HttpClient downloadFromURL:[self genQuery:marketId:emitentId:emitentCode:start:[NSDate date]:period]:@"data.txt"];
        [Settings setChanged:false];
    }
}        
@end
