//
//  StochasticItem.h
//  diplom
//
//  Created by Mac on 19.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StochasticItem : NSObject
@property int fast, slow;
+(id)newStochasticItem:(int)fast:(int)slow;
@end
