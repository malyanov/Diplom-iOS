//
//  Quotation.h
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {Hour_Bid,Day_Bid}QuotationType;
@interface Quotation : NSObject
@property double openValue,closeValue,highValue,lowValue,currentValue;
@property (strong) NSDate *dateTime;
@property QuotationType type;
@property bool isCurrent;
+(id)newQuotation:(double)openValue:(double)closeValue:(double)highValue:(double)lowValue;
+(id)newQuotation:(double)value:(NSDate*)qdate:(QuotationType)qtype;
-(void)changeCurrentValue:(double)value;
-(void)close;
@end
