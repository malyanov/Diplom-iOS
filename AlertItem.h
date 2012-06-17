//
//  AlertItem.h
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertItem : NSObject
@property double value;
@property (strong) NSString* instrumentCode;
+(id)newAlertItem:(double)value:(NSString*)instrumentCode;
@end
