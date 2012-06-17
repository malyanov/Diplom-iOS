//
//  BollingerBands.m
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BollingerBands.h"

@implementation BollingerBands
@synthesize ml, tl, bl;
+(id)newBollingerBands:(double)ml :(double)tl :(double)bl{
    BollingerBands *bb=[[BollingerBands alloc] init];
    bb.ml=ml;
    bb.tl=tl;
    bb.bl=bl;
    return bb;
}
@end
