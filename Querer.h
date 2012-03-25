//
//  Querer.h
//  diplom
//
//  Created by Mac on 24.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstrumentUpdateTask.h"

@interface Querer : NSObject
@property (strong) NSMutableArray *tasks;
@property (strong) NSTimer* timer;
+(id)newQuerer;
-(void)stopTimer;
-(void)addTask:(Instrument*)instrument:(HandleBlock)handler;
-(void)timerTask;
-(void)removeTask:(Instrument*)instrument;
@end
