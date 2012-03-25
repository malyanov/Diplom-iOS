//
//  InstrumentUpdateTask.h
//  diplom
//
//  Created by Mac on 24.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Instrument.h"
#import "Quotation.h"
#import "RTS_Loader.h"
#import "MICEX_Loader.h"
typedef void(^HandleBlock)(Instrument*);
@interface InstrumentUpdateTask : NSObject
@property (strong) Instrument* instrument;
@property (strong) HandleBlock handler;
+(id)newInstrumentUpdateTask:(Instrument*)instrument:(HandleBlock)handler;
-(void)run;
@end
