//
//  Settings.m
//  diplom
//
//  Created by Mac on 18.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import "Instrument.h"
#import "Quotation.h"

@implementation Settings
static Modes chartMode=CURVES;
static QuotationType bidType=Hour_Bid;
static int exchangeId=-1;
static Mode analyseMode=RSI;
static NSString *instrumentCode=@"GAZP", *boardCode=@"";
+(QuotationType) getBidType{
    return bidType;
}
+(Modes) getChartMode{
    return chartMode;
}
+(NSString*) getInstrumentCode{
    return instrumentCode;
}
+(NSString*) getBoardCode{
    return instrumentCode;
}
+(void)setInstrumentCode:(NSString*)value{
    instrumentCode=value;
}
+(void)setBoardCode:(NSString*)value{
    boardCode=value;
}
+(int)getExchangeId{
    return exchangeId;
}
+(Mode)getAnalyseMode{
    return analyseMode;
}
+(void)setAnalyseMode:(Mode)mode{
    analyseMode=mode;
}
+(void)clear{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"chart_mode"];
    [defaults removeObjectForKey:@"bid_type"];
    [defaults removeObjectForKey:@"exchange_id"];
    [defaults removeObjectForKey:@"analyse_mode"];
    [defaults removeObjectForKey:@"instrument_code"];
    [defaults removeObjectForKey:@"board_code"];
    [defaults synchronize];
}
+(BOOL)load{
    exchangeId=[Instrument getMICEX];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"instrument_code"]==nil)
        return NO;
    instrumentCode = [defaults objectForKey:@"instrument_code"];
    boardCode = [defaults objectForKey:@"board_code"];
    chartMode = [[defaults objectForKey:@"chart_mode"] intValue];
    bidType = [[defaults objectForKey:@"bid_type"] intValue];
    exchangeId = [[defaults objectForKey:@"exchange_id"] intValue];
    analyseMode = [[defaults objectForKey:@"analyse_mode"] intValue];
    return YES;
}
+(void)save{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:chartMode] forKey:@"chart_mode"];
    [defaults setObject:[NSNumber numberWithInt:bidType] forKey:@"bid_type"];
    [defaults setObject:[NSNumber numberWithInt:exchangeId] forKey:@"exchange_id"];
    [defaults setObject:[NSNumber numberWithInt:analyseMode] forKey:@"analyse_mode"];
    [defaults setObject:instrumentCode forKey:@"instrument_code"];
    [defaults setObject:boardCode forKey:@"board_code"];
    [defaults synchronize];
}
@end
