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
+(Modes) getChartMode;
+(NSString*) getInstrumentCode;
+(NSString*) getBoardCode;
+(void)setInstrumentCode:(NSString*)value;
+(void)setBoardCode:(NSString*)value;
+(int)getExchangeId;
+(Mode)getAnalyseMode;
+(void)setAnalyseMode:(Mode)mode;
+(void)save;
+(void)clear;
+(BOOL)load;
@end
