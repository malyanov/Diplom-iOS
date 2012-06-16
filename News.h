//
//  News.h
//  diplom
//
//  Created by Mac on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (strong) NSDate *date;
@property (strong) NSString *title, *description, *link;
+(id)newNews:(NSDate*)date:(NSString*)title:(NSString*)description:(NSString*)link;
@end
