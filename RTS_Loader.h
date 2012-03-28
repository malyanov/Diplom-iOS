//
//  RTS_Loader.h
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quotation.h"
#import "HistoryLoader.h"
#import "Instrument.h"
#import "Settings.h"
#import "XPathQuery.h"
@interface RTS_Loader : NSObject
+(void)getDataForChart:(NSString*)instrumentCode:(NSDate*)start:(QuotationType)bidType:(void(^)(Quotation*))handler;
+(void)runDataForChart:(NSDictionary*)args;
+(void)getCurrentValueAsync:(NSString*)instrumentCode:(void(^)(Quotation*))handler;
+(void)runCurrentValue:(NSDictionary*)args;
+(double)getCurrentValue:(NSString*)instrumentCode;
+(int)getMarketId:(NSString*)instrumentCode;
+(int)getInstrumentId:(NSString*)instrumentCode;
+(NSMutableDictionary*)getAttributes:(id)row;
+(NSMutableArray*)getEmitentCodes;
@end
