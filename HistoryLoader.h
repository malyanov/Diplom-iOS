//
//  HistoryLoader.h
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quotation.h"
#import "HttpClient.h"

@interface HistoryLoader : NSObject
+(id)newHistoryLoader;
-(NSString*)genQuery:(int)marketId:(int)emitentId:(NSString*)emitentCode:(NSDate*)startDate:(NSDate*)finishDate:(int)period;
-(NSString*)getFileName:(NSString*)emitentCode:(NSDate*)start:(NSDate*)finish;
-(void)load:(int)marketId:(int)emitentId:(NSString*)emitentCode:(NSDate*)start:(QuotationType)bidType;
@end
