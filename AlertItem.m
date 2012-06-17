//
//  AlertItem.m
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlertItem.h"

@implementation AlertItem
@synthesize instrumentCode, value;
+(id)newAlertItem:(double)value :(NSString *)instrumentCode{
    AlertItem *item=[[AlertItem alloc] init];
    item.value=value;
    item.instrumentCode=instrumentCode;
    return item;
}
@end
