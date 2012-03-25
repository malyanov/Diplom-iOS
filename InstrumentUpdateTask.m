//
//  InstrumentUpdateTask.m
//  diplom
//
//  Created by Mac on 24.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InstrumentUpdateTask.h"

@implementation InstrumentUpdateTask
@synthesize handler, instrument;
+(id)newInstrumentUpdateTask:(Instrument*)instrument:(HandleBlock)handler{
    InstrumentUpdateTask* task=[[InstrumentUpdateTask alloc] init];
    task.instrument=instrument;
    task.handler=handler;
    return task;
}
-(void)run{
    if([instrument exchangeId]==[Instrument getRTS])
    {			
        double value=[RTS_Loader getCurrentValue:[instrument code]];
        [instrument setValue:value];
        handler(instrument);
    }
    else if([instrument exchangeId]==[Instrument getMICEX])
    {
        double value=[MICEX_Loader getCurrentValue:[instrument board]:[instrument code]];
        [instrument setValue:value];        
        handler(instrument);
    }
}
@end
