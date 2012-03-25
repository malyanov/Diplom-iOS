//
//  MICEX_Loader.h
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
@interface MICEX_Loader : NSObject
+(void)getDataForChart:(NSString*)instrumentCode:(NSDate*)start:(QuotationType)bidType:(void(^)(Quotation*))handler;
+(void)runDataForChart:(NSDictionary*)args;
+(void)getCurrentValueAsync:(NSString*)board:(NSString*)instrumentCode:(QuotationType)bidType:(void(^)(Quotation*))handler;
+(double)getCurrentValue:(NSString*)board:(NSString*)instrumentCode;
+(Instrument*)getInstrumentByCode:(NSString*)code;
+(int)getInstrumentId:(NSString*)instrumentCode;
+(void)runCurrentValue:(NSDictionary*)args;
+(NSMutableDictionary*)getAttributes:(id)row;
@end
