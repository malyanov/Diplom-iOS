//
//  Instrument.h
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
static int RTS=1, MICEX=2;
@interface Instrument : NSObject 
@property (strong) NSString *code, *board, *name;
@property int exchangeId;
@property double value;
+(int)getRTS;
+(int)getMICEX;
+(id)newInstrument:(NSString*)code:(NSString*)board:(NSString*)name:(int)exchangeId:(double)value;
@end
