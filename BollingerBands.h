//
//  BollingerBands.h
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BollingerBands : NSObject
@property double ml, tl, bl;
+(id)newBollingerBands:(double)ml:(double)tl:(double)bl;
@end
