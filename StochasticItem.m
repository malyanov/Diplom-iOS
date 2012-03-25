//
//  StochasticItem.m
//  diplom
//
//  Created by Mac on 19.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StochasticItem.h"

@implementation StochasticItem
@synthesize fast, slow;
+(id)newStochasticItem:(int)fast:(int)slow{
    StochasticItem *item=[StochasticItem alloc];
    [item setFast:fast];
    [item setSlow:slow];
    return item;
}
@end
