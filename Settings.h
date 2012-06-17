//
//  Settings.h
//  diplom
//
//  Created by Mac on 18.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chart.h"
#import "Quotation.h"
#import "Instrument.h"
#import "AnalyseChart.h"

@interface Settings : NSObject
+(QuotationType) getBidType;
+(void)setBidType:(QuotationType)type;
+(Modes) getChartMode;
+(void)setChartMode:(Modes)mode;
+(NSString*) getInstrumentCode;
+(void)setInstrumentCode:(NSString*)value;
+(NSString*) getBoardCode;
+(void)setBoardCode:(NSString*)value;
+(int)getExchangeId;
+(void)setExchangeId:(int)exchId;
+(Mode)getAnalyseMode;
+(void)setAnalyseMode:(Mode)mode;
+(void)saveSettings;
+(void)clearSettings;
+(BOOL)loadSettings;
+(void)setChanged:(bool)value;
+(bool)getChanged;
+(bool)getBollingerBands;
+(void)setBollingerBands:(bool)value;
+(bool)getEMA;
+(void)setEMA:(bool)value;
@end
