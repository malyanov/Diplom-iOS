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
static bool changed=false, bollingerBands=false, ema=false;
+(void)setChanged:(bool)value{
    changed=true;
}
+(bool)getChanged{
    return changed;
}

+(QuotationType) getBidType{
    return bidType;
}
+(void)setBidType:(QuotationType)type{
    bidType=type;
}
+(Modes) getChartMode{
    return chartMode;
}
+(void)setChartMode:(Modes)mode{
    chartMode=mode;
}
+(NSString*) getInstrumentCode{
    return instrumentCode;
}
+(void)setInstrumentCode:(NSString*)value{
    instrumentCode=value;
}
+(NSString*) getBoardCode{
    return boardCode;
}
+(void)setBoardCode:(NSString*)value{
    boardCode=value;
}
+(int)getExchangeId{
    return exchangeId;
}
+(void)setExchangeId:(int)exchId{
    exchangeId=exchId;
}
+(Mode)getAnalyseMode{
    return analyseMode;
}
+(void)setAnalyseMode:(Mode)mode{
    analyseMode=mode;
}
+(bool)getBollingerBands{
    return bollingerBands;
}
+(void)setBollingerBands:(bool)value{
    bollingerBands=value;
}
+(bool)getEMA{
    return ema;
}
+(void)setEMA:(bool)value{
    ema=value;
}
+(void)clearSettings{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"chart_mode"];
    [defaults removeObjectForKey:@"bid_type"];
    [defaults removeObjectForKey:@"exchange_id"];
    [defaults removeObjectForKey:@"analyse_mode"];
    [defaults removeObjectForKey:@"instrument_code"];
    [defaults removeObjectForKey:@"board_code"];
    [defaults removeObjectForKey:@"bollinger_bands"];
    [defaults removeObjectForKey:@"ema"];
    [defaults synchronize];
}
+(BOOL)loadSettings{
    exchangeId=[Instrument getMICEX];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"instrument_code"]==nil){
        changed=true;
        return NO;
    }
    instrumentCode = [defaults objectForKey:@"instrument_code"];
    boardCode = [defaults objectForKey:@"board_code"];
    chartMode = [[defaults objectForKey:@"chart_mode"] intValue];
    bidType = [[defaults objectForKey:@"bid_type"] intValue];
    exchangeId = [[defaults objectForKey:@"exchange_id"] intValue];
    analyseMode = [[defaults objectForKey:@"analyse_mode"] intValue];
    bollingerBands = [[defaults objectForKey:@"bollinger_bands"] boolValue];
    ema = [[defaults objectForKey:@"ema"] boolValue];
    return YES;
}
+(void)saveSettings{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:chartMode] forKey:@"chart_mode"];
    [defaults setObject:[NSNumber numberWithInt:bidType] forKey:@"bid_type"];
    [defaults setObject:[NSNumber numberWithInt:exchangeId] forKey:@"exchange_id"];
    [defaults setObject:[NSNumber numberWithInt:analyseMode] forKey:@"analyse_mode"];
    [defaults setObject:instrumentCode forKey:@"instrument_code"];
    [defaults setObject:boardCode forKey:@"board_code"];
    [defaults setObject:[NSNumber numberWithBool:bollingerBands] forKey:@"bollinger_bands"];
    [defaults setObject:[NSNumber numberWithBool:ema] forKey:@"ema"];
    [defaults synchronize];
}
@end
