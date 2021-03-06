//
//  Querer.m
//  diplom
//
//  Created by Mac on 24.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Querer.h"

@implementation Querer
@synthesize tasks, timer;
+(id)newQuerer{
    Querer *querer=[[Querer alloc] init];
    querer.tasks=[[NSMutableArray alloc] init];
    //bug selector problem
    querer.timer=[NSTimer scheduledTimerWithTimeInterval:10.0 target:querer selector:@selector(runTimerTask) userInfo:nil repeats:YES];
    return querer;
}
-(void)stopTimer{
    [timer invalidate];
    timer=nil;
}
-(void)addTask:(Instrument*)instrument:(HandleBlock)handler{
    InstrumentUpdateTask* task=[InstrumentUpdateTask newInstrumentUpdateTask:instrument:handler];
    [tasks addObject:task];
}
-(void)runTimerTask{
    for (int i = 0; i < tasks.count; i++) {
        InstrumentUpdateTask *task=[tasks objectAtIndex:i];
        [task run];
    }
}
-(void)removeTask:(Instrument*)instrument{
    for (int i = 0; i < tasks.count; i++) {
        Instrument *instr=[[tasks objectAtIndex:i] instrument];
        if([instrument code]==[instr code]&&[instrument exchangeId]==[instr exchangeId]){
            [tasks removeObjectAtIndex:i];            
            return;
        }
    }
}
@end
