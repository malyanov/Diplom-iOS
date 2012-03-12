//
//  Quotation.m
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Quotation.h"

@implementation Quotation
@synthesize openValue,closeValue,highValue,lowValue,currentValue;
@synthesize dateTime;
@synthesize type;
@synthesize isCurrent;
+(id)newQuotation:(double)openValue :(double)closeValue :(double)highValue :(double)lowValue{
    Quotation *q=[[Quotation alloc] init];
    [q setOpenValue:openValue];
    [q setCloseValue:closeValue];
    [q setHighValue:highValue];
    [q setLowValue:lowValue];
    return q;
}
-(void)changeCurrentValue:(double)value{
    if(isCurrent)
    {
        currentValue=value;
        if(value>highValue)highValue=value;
        if(value<lowValue)lowValue=value;
    }
}
-(void)close{
    isCurrent=false;
}
@end
