//
//  Instrument.h
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instrument : NSObject 
@property (strong) NSString *code, *board, *name;
@property int exchangeId;
@property double value;
+(int)getRTS;
+(int)getMICEX;
+(id)newInstrument:(int)exchangeId:(NSString*)board:(NSString*)code:(NSString*)name:(double)value;
@end
