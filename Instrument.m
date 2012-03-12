//
//  Instrument.m
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Instrument.h"

@implementation Instrument
@synthesize code, board, name;
@synthesize exchangeId;
@synthesize value;
+(id)newInstrument:(NSString*)code:(NSString*)board:(NSString*)name:(int)exchangeId:(double)value{
    Instrument *instr=[[Instrument alloc] init];
    [instr setCode:code];
    [instr setBoard:board];
    [instr setName:name];
    [instr setExchangeId:exchangeId];
    [instr setValue:value];
    return instr;
}
+(int)getRTS{
    return RTS;
}
+(int)getMICEX{
    return MICEX;
}
@end
