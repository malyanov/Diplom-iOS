//
//  Analiser.h
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quotation.h"
#import "StochasticItem.h"
#import "BollingerBands.h"

@interface Analiser : NSObject
@property (strong) NSMutableArray *quotes;
+(id)newAnaliser:(NSMutableArray*)quotes;
-(NSMutableArray*)RSI;
-(NSMutableArray*)stochastic;
-(NSMutableArray*)momentum;
-(NSMutableArray*)MA;
-(NSMutableArray*)BollingerBands:(int)D;
-(double) getMinClose:(NSArray*)values;
-(double) getMaxClose:(NSArray*)values;
-(double)calcStdDev:(double)sma:(NSArray*)values;
-(double)getAvgClose:(NSArray*)values;
@end
